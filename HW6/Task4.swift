

import UIKit

// 4.Напишите как можно больше примеров (с кодом), в которых по-разному создаются утечки памяти.

class ViewController2: UIViewController, Example1Delegate {
    private var Name = "ViewController"
    private var example1 = Example1()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(">> \(Name) добавлен в память")
        
// Пример 1
        let A = ARC_A()
        let B = ARC_B()
        A.b = B // при nil - удалит из памяти
        B.a = A
        
// Пример 2
        example1.delegate = self

    }
    deinit { print("<<< \(Name) удален из памяти!")}
}
class ARC_A {
    var b: ARC_B!
    init() { print(">> ARC_A добавлен в память"); refCount0 += 1}
    deinit { print("<<< ARC_A удален из памяти!"); refCount0 -= 1}
}
class ARC_B {
    var a: ARC_A!
    init() { print(">> ARC_B добавлен в память"); refCount0 += 1 }
    deinit { print("<<< ARC_B удален из памяти!"); refCount0 -= 1}
}

public var refCount0 = 0 {
    didSet {
        if refCount0 > 1 {
            print("*** ARC УТЕЧЕК: \(refCount0 - 1) ***")
        }
    }
}
// Пример 3

public var refCount1 = 0 {
    didSet {
        if refCount1 > 1 {
            print("*** Example_1 УТЕЧЕК: \(refCount1 - 1) ***")
        }
    }
}

protocol Example1Delegate { }

class Example1 {
    var delegate: Example1Delegate?
}

class ViewController: UIViewController, Example1Delegate {
    
    private let ref = Example1()
    
    override func viewDidLoad() {
        print(">> Example1 добавлен в память")
        refCount1 += 1
        ref.delegate = self
        if refCount1 > 1 {
            self.view.backgroundColor = .systemRed
        }
    }
    deinit {
        print("<<< Example1 удален из памяти!"); refCount1 -= 1
    }
}
