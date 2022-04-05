Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 112D24F24BE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Apr 2022 09:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231678AbiDEHkG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Apr 2022 03:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231206AbiDEHkF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Apr 2022 03:40:05 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ED8B4AE16
        for <linux-fsdevel@vger.kernel.org>; Tue,  5 Apr 2022 00:38:07 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id f11-20020a056602070b00b00645d08010fcso7857683iox.15
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 Apr 2022 00:38:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=wcyi7XrZQP853dByi9+1YxDyQa3+xhgfC53tgafqARg=;
        b=ufa52Mi6h37r2ZdsnOGb40rWxowFQfKilDCyc4rllBwpqHfrlcz69IVImcxTJWWuea
         f1uaBGc01UAa6UqawSFgWv/JVkCTYyIRNS131ycWUfDeupcPiIV6BupCEmzzw8zEWSHe
         1JT++12qHctMcjgAyLTp5GIV9pZ1YUD+YZpi9oR8O2n6g6Tr/kMimDfpETp3uvdYKL17
         TVBagPvbmuFkcsi8uMgp6NFiaN9f2PRE2PujMqg4ATNYS9EY2iOUxGx8aXOTraKSJEhk
         MUXh/LoHUjh9sMouJ+02565wn767kj3iw73q3Om7kXowXbYXoHdbzUAjjdqsVHsVBNpX
         D1YA==
X-Gm-Message-State: AOAM532xrN6AtFipddrgY3TgoIJ9MmPvAIigeCfn7cuVujTNXHPZQWWA
        wDKM1ePxlseHc4VQ8QBpJdg/5A3G3RVuna4IhLTyK1jlMae7
X-Google-Smtp-Source: ABdhPJylwAgh1hTPED7kBLSTNMTi5KhXxeEahh2ttq/LYtuLKAfNNHO6HKO8c5krILmrEuJME3L2D43vjv+w9+R5yfXJVTS9+bYv
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d8e:b0:2ca:41bf:554a with SMTP id
 h14-20020a056e021d8e00b002ca41bf554amr1051738ila.128.1649144286768; Tue, 05
 Apr 2022 00:38:06 -0700 (PDT)
Date:   Tue, 05 Apr 2022 00:38:06 -0700
In-Reply-To: <0000000000001779fd05a46b001f@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006574b705dbe3533f@google.com>
Subject: Re: [syzbot] INFO: task hung in linkwatch_event (2)
From:   syzbot <syzbot+96ff6cfc4551fcc29342@syzkaller.appspotmail.com>
To:     allison@lohutok.net, andrew@lunn.ch, aviad.krawczyk@huawei.com,
        axboe@kernel.dk, davem@davemloft.net, gregkh@linuxfoundation.org,
        hdanton@sina.com, io-uring@vger.kernel.org,
        johannes.berg@intel.com, johannes@sipsolutions.net,
        kuba@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        linyunsheng@huawei.com, luobin9@huawei.com, netdev@vger.kernel.org,
        pabeni@redhat.com, phind.uet@gmail.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        viro@zeniv.linux.org.uk, xiaoguang.wang@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit 563fbefed46ae4c1f70cffb8eb54c02df480b2c2
Author: Nguyen Dinh Phi <phind.uet@gmail.com>
Date:   Wed Oct 27 17:37:22 2021 +0000

    cfg80211: call cfg80211_stop_ap when switch from P2P_GO type

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1048725f700000
start commit:   dd86e7fa07a3 Merge tag 'pci-v5.11-fixes-2' of git://git.ke..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=e83e68d0a6aba5f6
dashboard link: https://syzkaller.appspot.com/bug?extid=96ff6cfc4551fcc29342
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11847bc4d00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1267e5a0d00000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: cfg80211: call cfg80211_stop_ap when switch from P2P_GO type

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
