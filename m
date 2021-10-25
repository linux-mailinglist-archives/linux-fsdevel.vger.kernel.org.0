Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B011B4393B4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Oct 2021 12:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232079AbhJYKbu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Oct 2021 06:31:50 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:48939 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231745AbhJYKbt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Oct 2021 06:31:49 -0400
Received: by mail-io1-f69.google.com with SMTP id c10-20020a5e8f0a000000b005ddce46973cso8561575iok.15
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Oct 2021 03:29:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=JAbTUB7wd0n4ed22nk2D+7uZypebDRexq0Nqq9dO8zk=;
        b=K/aRhIT2YF/f0sBxnSA6tTJVo55N+GkgDQbqJZ9VxVbC4SHqvPKOMe4vfyJM9ajF/8
         xS0Anw66zqSBId7LrIBJI5sTkevdjZhJk7jdzsrFGW/y7vWk5Mkhf7U53ON61IX7NpeT
         JaRjtKosiEgDzgJnJXuHZdac27DnlRdbqS80Luvg6ukfhyUT9WG1nfdOp8mxyAxB+AgQ
         r9RliaEkMvObJWl8NKWb4Jj61vWtMqPlLAHqrdVbljTIFlClPxz6zrZR6cXrqq9xcqCB
         ivsbG5a8J7poF1nKcYHPq9Iwxpw8qS7wbTf1O/F478Bsvs9X7rzkMk9eBabaTHupqHSG
         RmrA==
X-Gm-Message-State: AOAM532x06R37WE4z/8TiK/42wSQTzu6lAmJlLISVCzbEkFz0Upqm28j
        G9RIZqhbDGiLYcdizfTCWpocwFA74HXD//9C46fpvE1gk2g/
X-Google-Smtp-Source: ABdhPJwWCF6T9C/GTEoj1lxOQ5h/45kApoO8I+lcqj3iHmbzRdLdaidvzMK9GaMnT76mxQgLjvSuTnTNmL5Fugt0JGWgm8welM4u
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20e7:: with SMTP id q7mr9941507ilv.254.1635157767204;
 Mon, 25 Oct 2021 03:29:27 -0700 (PDT)
Date:   Mon, 25 Oct 2021 03:29:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ddb95c05cf2ad54a@google.com>
Subject: [syzbot] KCSAN: data-race in call_rcu / rcu_gp_fqs_loop
From:   syzbot <syzbot+4dfb96a94317a78f44d9@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    9c0c4d24ac00 Merge tag 'block-5.15-2021-10-22' of git://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=159c4954b00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6339b6ea86d89fd7
dashboard link: https://syzkaller.appspot.com/bug?extid=4dfb96a94317a78f44d9
compiler:       Debian clang version 11.0.1-2, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4dfb96a94317a78f44d9@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in call_rcu / rcu_gp_fqs_loop

write to 0xffffffff837342e0 of 8 bytes by task 11 on cpu 1:
 rcu_gp_fqs kernel/rcu/tree.c:1910 [inline]
 rcu_gp_fqs_loop+0x348/0x470 kernel/rcu/tree.c:1971
 rcu_gp_kthread+0x25/0x1a0 kernel/rcu/tree.c:2130
 kthread+0x262/0x280 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30

read to 0xffffffff837342e0 of 8 bytes by task 379 on cpu 0:
 __call_rcu_core kernel/rcu/tree.c:2904 [inline]
 __call_rcu kernel/rcu/tree.c:3020 [inline]
 call_rcu+0x4c0/0x6d0 kernel/rcu/tree.c:3067
 __dentry_kill+0x3ec/0x4e0 fs/dcache.c:596
 dput+0xc6/0x360 fs/dcache.c:888
 do_unlinkat+0x2a8/0x540 fs/namei.c:4172
 __do_sys_unlink fs/namei.c:4217 [inline]
 __se_sys_unlink fs/namei.c:4215 [inline]
 __x64_sys_unlink+0x2c/0x30 fs/namei.c:4215
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x44/0xa0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae

value changed: 0x0000000000005c0d -> 0x0000000000005c0e

Reported by Kernel Concurrency Sanitizer on:
CPU: 0 PID: 379 Comm: udevd Tainted: G        W         5.15.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
