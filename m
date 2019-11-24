Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C1AF10848F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Nov 2019 20:07:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbfKXTHD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 24 Nov 2019 14:07:03 -0500
Received: from mail-il1-f198.google.com ([209.85.166.198]:36280 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726926AbfKXTHD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 24 Nov 2019 14:07:03 -0500
Received: by mail-il1-f198.google.com with SMTP id m16so11857973ilh.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 24 Nov 2019 11:07:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=0iPpdRzq0L7+RSFavqTsQfmCi/uTeccXAim0E/TGr2Q=;
        b=ppL+R/7jLRpMd7wYdqF10H8yNg8LfDdZlfyyeKosyBlwUKYhBONMSaesnN7U5uFkre
         odJ9Jo1wGwBD8Mk1xvNyfA+N5frcRm1GG+TVOUS+/PfeMcgbLY8hZxZHWU+m2ZalPa45
         IMQDJj+vmdp3SnVnMTx5/h0Hm4SvRRctlQ0zUHoNY7+NxiwM2eqQ3OgIRHb6Ehw8WGSh
         qKPaBR9mNQmCiUsoTm96ujWyEtS8ufMxr4sKObwjpOYqM3nNfZ0dHO5UUjAT//gadzfA
         akdc3kqBlEpBw7JdVZSIeKFkxSnot1Jiej5BodfwBbnaFRMHA/WHPRUkXOxa9Zlb/M/F
         cLxA==
X-Gm-Message-State: APjAAAVLHZ72dbw/p6YSR3bP/w3ay+meluYeYt8xxZ1CLVZhGOY+oLtf
        Paj8bfXrnovBQcr/sbbznXheEex+dwemSy+ylu1Qd2+nmMN3
X-Google-Smtp-Source: APXvYqxzdQLTUAzZHkNrn+IW7dBHAAZnrSGKEzdtkJeRCBqjt/+dvnBg9GSfzUg/aUk4k+sN4UpRfbhAt4p8PcJXTniYzbgEeEFN
MIME-Version: 1.0
X-Received: by 2002:a5d:9153:: with SMTP id y19mr23281646ioq.26.1574622420789;
 Sun, 24 Nov 2019 11:07:00 -0800 (PST)
Date:   Sun, 24 Nov 2019 11:07:00 -0800
In-Reply-To: <000000000000e59aab056e8873ae@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000beff305981c5ac6@google.com>
Subject: Re: KASAN: use-after-free Read in blkdev_get
From:   syzbot <syzbot+eaeb616d85c9a0afec7d@syzkaller.appspotmail.com>
To:     cmetcalf@ezchip.com, coreteam@netfilter.org, davem@davemloft.net,
        dvyukov@google.com, gang.chen.5i5j@gmail.com, kaber@trash.net,
        kadlec@blackhole.kfki.hu, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        netfilter-devel@vger.kernel.org, pablo@netfilter.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has bisected this bug to:

commit 77ef8f5177599efd0cedeb52c1950c1bd73fa5e3
Author: Chris Metcalf <cmetcalf@ezchip.com>
Date:   Mon Jan 25 20:05:34 2016 +0000

     tile kgdb: fix bug in copy to gdb regs, and optimize memset

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1131bc0ee00000
start commit:   f5b7769e Revert "debugfs: inode: debugfs_create_dir uses m..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=1331bc0ee00000
console output: https://syzkaller.appspot.com/x/log.txt?x=1531bc0ee00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=709f8187af941e84
dashboard link: https://syzkaller.appspot.com/bug?extid=eaeb616d85c9a0afec7d
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=177f898f800000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=147eb85f800000

Reported-by: syzbot+eaeb616d85c9a0afec7d@syzkaller.appspotmail.com
Fixes: 77ef8f517759 ("tile kgdb: fix bug in copy to gdb regs, and optimize  
memset")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
