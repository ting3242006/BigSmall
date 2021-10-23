//
//  ViewController.swift
//  BigSmall
//
//  Created by Ting on 2021/10/19.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var computerCardLabel: UILabel!
    @IBOutlet weak var playerCardLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBOutlet weak var moneyStepper: UIStepper!
    
    @IBOutlet weak var playerMoneyLabel: UILabel!

    @IBOutlet weak var moneyLabel: UILabel!
    var cards = [Card]()
    var playerMoney = 10000
    var bet = 1000
    
    //寫一個撲克牌的Array，裡面沒有裝東西，52張牌的兩層Loop寫法
    func creatCards(){
        for suit in suits {
            for rank in ranks {
                let card = Card(suit: suit, rank: rank)
                cards.append(card)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        creatCards()
    }
    //增加賭金的按鈕
    @IBAction func increaseBet(_ sender: Any) {
        bet = Int(1000 * (moneyStepper.value))
        moneyLabel.text = "\(bet)"
    }

    @IBAction func play(_ sender: Any) {
        
        //自動洗牌，電腦發一張 玩家發一張
        cards.shuffle()
        let computerCard = cards[0]
        computerCardLabel.text = "\(computerCard.suit) \(computerCard.rank)"
        let playerCard = cards[1]
        playerCardLabel.text = "\(playerCard.suit) \(playerCard.rank)"
        
        //幫撲克牌打分數來比大小
        var compuerCardNumber = 0
        if computerCard.rank == "A"{
            compuerCardNumber = 1
        }else if computerCard.rank == "J"{
            compuerCardNumber = 11
        }else if computerCard.rank == "Q"{
            compuerCardNumber = 12
        }else if computerCard.rank == "K"{
            compuerCardNumber = 13
        }else{
            compuerCardNumber = Int(computerCard.rank)!
        }
        
        var playerCardNumber = 0
        if playerCard.rank == "A"{
            playerCardNumber = 1
        }else if playerCard.rank == "J"{
            playerCardNumber = 11
        }else if playerCard.rank == "Q"{
            playerCardNumber = 12
        }else if playerCard.rank == "K"{
            playerCardNumber = 13
        }else{
            playerCardNumber = Int(playerCard.rank)!
        }
        
        //先比數字，數字一樣再比花色
        if compuerCardNumber < playerCardNumber{
            resultLabel.text = "You Win"
            playerMoneyLabel.text = "\(playerMoney + bet)"
        }else if compuerCardNumber > playerCardNumber{
            resultLabel.text = "You Lose"
            playerMoneyLabel.text = "\(playerMoney - bet)"
        }else {
            
            //幫花色打分數來比大小
            var playerSuitNumber = 0
            if playerCard.suit == "♣️" {
                playerSuitNumber = 1
            } else if playerCard.suit == "♦️" {
                playerSuitNumber = 2
            } else if playerCard.suit == "♥️" {
                playerSuitNumber = 3
            } else {
                playerSuitNumber = 4
            }
            
            var computerSuitNumber = 0
            if computerCard.suit == "♣️" {
                computerSuitNumber = 1
            } else if computerCard.suit == "♦️" {
                computerSuitNumber = 2
            } else if computerCard.suit == "♥️" {
                computerSuitNumber = 3
            } else {
                computerSuitNumber = 4
            }
            
            //贏了在結果的Label顯示，在本金中增加下注的賭金
            if computerSuitNumber < playerSuitNumber {
                resultLabel.text = "You Win!"
                playerMoneyLabel.text = "\(playerMoney + bet)"

            } else {
                //輸了在結果的Label顯示，在本金中減少下注的賭金
                resultLabel.text = "You Lose"
                playerMoneyLabel.text = "\(playerMoney - bet)"
            }
           
            
        }
       //本金少於等於0，遊戲結束
        playerMoney = Int(playerMoneyLabel.text!)!
        if playerMoney <= 0{
            resultLabel.text = "Game Over!"
        }
}
    //按reset之後的顯示結果
    @IBAction func reset(_ sender: Any) {
        playerMoney = 10000
                playerMoneyLabel.text = "\(playerMoney)"
                bet = 1000
                moneyLabel.text = "\(bet)"
        computerCardLabel.text = ""
        playerCardLabel.text = ""
        resultLabel.text = ""
        moneyStepper.value = 1
    }
}

