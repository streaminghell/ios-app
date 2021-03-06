//
//  Alerts.swift
//  Share Extension
//
//  Created by donbot on 10.04.2020.
//  Copyright © 2020 robotmafia. All rights reserved.
//

import UIKit
import RxSwift

enum ACTIONS {
    case OPEN
    case COPY
    case SHARE
    case BACK
}

struct ActionSheetResult {
    let action: ACTIONS
    let provider: Provider
}

func showServicesSheet(root: UIViewController, services: [Provider]) -> Observable<Provider> {
    return Observable.create { observer in
        let actionSheet = UIAlertController(title: NSLocalizedString("Select target music service", comment: ""), message: nil, preferredStyle: .actionSheet)
        
        for provider in services {
            let serviceAction = UIAlertAction(title: provider.label, style: .default) { action in
                observer.onNext(provider)
                observer.onCompleted()
            }
            
            actionSheet.addAction(serviceAction)
        }
        
        let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .cancel) { action in
            observer.onCompleted()
        }
        
        actionSheet.addAction(cancelAction)
        
        root.present(actionSheet, animated: true, completion: nil)
        
        return Disposables.create()
    }
}

func showActionSheet(root: UIViewController, provider: Provider) -> Observable<ActionSheetResult> {
    return Observable.create { observer in
        let actionSheet = UIAlertController(title: provider.label, message: nil, preferredStyle: .actionSheet)
        
        let openAction = UIAlertAction(title: NSLocalizedString("Open", comment: ""), style: .default) { action in
            observer.onNext(ActionSheetResult(action: .OPEN, provider: provider))
        }
        
        let copyAction = UIAlertAction(title: NSLocalizedString("Copy", comment: ""), style: .default) { action in
            observer.onNext(ActionSheetResult(action: .COPY, provider: provider))
        }
        
        let shareAction = UIAlertAction(title: NSLocalizedString("Share", comment: ""), style: .default) { action in
            observer.onNext(ActionSheetResult(action: .SHARE, provider: provider))
        }
        
        let backAction = UIAlertAction(title: NSLocalizedString("Back", comment: ""), style: .default) { action in
            observer.onNext(ActionSheetResult(action: .BACK, provider: provider))
        }
        
        let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .cancel) { action in
            observer.onCompleted()
        }
        
        actionSheet.addAction(openAction)
        actionSheet.addAction(copyAction)
        actionSheet.addAction(shareAction)
        actionSheet.addAction(backAction)
        actionSheet.addAction(cancelAction)
        
        root.present(actionSheet, animated: true, completion: nil)
        
        return Disposables.create()
    }
}
