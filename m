Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96D07260C08
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Sep 2020 09:32:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729359AbgIHHca (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Sep 2020 03:32:30 -0400
Received: from mail-io1-f80.google.com ([209.85.166.80]:44083 "EHLO
        mail-io1-f80.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729252AbgIHHcX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Sep 2020 03:32:23 -0400
Received: by mail-io1-f80.google.com with SMTP id l8so9186399ioa.11
        for <linux-fsdevel@vger.kernel.org>; Tue, 08 Sep 2020 00:32:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=AC6BgcroEDp548ZIhS1TATAuRZtuMVj32nIWDlxaHZ8=;
        b=CqAbkVJsrEFZRHp/ix41AxdSjZMOmpBq7wzC4dG1GnNa8Ur8AasRBj+RI2vqW9q23l
         joMk8YN4XegS0iKotAHQIGcjeb4vdl9go8XMZUOwNkSQi9FZ1nBbFPoarkeUNfW/1pyx
         knumztLbe1t8CgWOWxTe4ocFovMCxdBlNON8sdFiAq9wFFRu5xMXSc/1oktyDht43EFj
         PjjgzwqFHEjNb5I/Wxssar0GkLa6499ZvkvRr6mtA5bayqfO3YegR079dCxpD6AAEcap
         q4IIGfV/FxKR5MOlSgalj8HnxXWN9efKgKsGtuLmP9CxlhVGdIM8IBylHxLGxgFYox9h
         zIpA==
X-Gm-Message-State: AOAM532eHS0gRqAHi3XSZmcTQkfZJ4JuoutKZm+N3MyKTiaVBpq8VJOX
        cmr2YJowv8gLHredaVnfBwXkCaRsY94lyTGzG9CMaUUQNEUn
X-Google-Smtp-Source: ABdhPJwrK+MvNyMKFdr3Ad+r7ZbCdqmn2+JSuXk34GuP1IPGf2/SSjWtf2ip02QSKxIWJuXUc3QRF5dcLJKpcbsbBRXv6M0iorxt
MIME-Version: 1.0
X-Received: by 2002:a92:4b0f:: with SMTP id m15mr10598300ilg.140.1599550342469;
 Tue, 08 Sep 2020 00:32:22 -0700 (PDT)
Date:   Tue, 08 Sep 2020 00:32:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f69d8405aec8552b@google.com>
Subject: BUG: spinlock bad magic in try_to_wake_up
From:   syzbot <syzbot+1b5d053eb77554ea5d77@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    b765a32a Merge tag 'scsi-fixes' of git://git.kernel.org/pu..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13188279900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e1c560d0f4e121c9
dashboard link: https://syzkaller.appspot.com/bug?extid=1b5d053eb77554ea5d77
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1b5d053eb77554ea5d77@syzkaller.appspotmail.com

BUG: spinlock bad magic on CPU#0, systemd-udevd/3905
 lock: 0xffff888000146cc8, .magic: 000f0f00, .owner: <none>/-1, .owner_cpu: -1
CPU: 0 PID: 3905 Comm: systemd-udevd Not tainted 5.9.0-rc3-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x1d6/0x29e lib/dump_stack.c:118
 spin_dump kernel/locking/spinlock_debug.c:67 [inline]
 spin_bug kernel/locking/spinlock_debug.c:75 [inline]
 debug_spin_lock_before kernel/locking/spinlock_debug.c:83 [inline]
 do_raw_spin_lock+0x2cc/0x800 kernel/locking/spinlock_debug.c:112
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:117 [inline]
 _raw_spin_lock_irqsave+0xb6/0xd0 kernel/locking/spinlock.c:159
 try_to_wake_up+0x5f/0xbb0 kernel/sched/core.c:2859
 autoremove_wake_function+0x12/0x110 kernel/sched/wait.c:389
 __wake_up_common+0x30a/0x4e0 kernel/sched/wait.c:93
 __wake_up_common_lock kernel/sched/wait.c:123 [inline]
 __wake_up+0xd4/0x150 kernel/sched/wait.c:142
 ep_poll_callback+0x50e/0x910 fs/eventpoll.c:1273
 __wake_up_common+0x30a/0x4e0 kernel/sched/wait.c:93
 __wake_up_common_lock kernel/sched/wait.c:123 [inline]
 __wake_up_sync_key+0xd3/0x150 kernel/sched/wait.c:190
 sock_def_readable+0x10f/0x210 net/core/sock.c:2908
 __netlink_sendskb net/netlink/af_netlink.c:1251 [inline]
 netlink_sendskb+0x8d/0x130 net/netlink/af_netlink.c:1257
 netlink_unicast+0x5b2/0x940 net/netlink/af_netlink.c:1345
 netlink_sendmsg+0xa57/0xd70 net/netlink/af_netlink.c:1919
 sock_sendmsg_nosec net/socket.c:651 [inline]
 sock_sendmsg net/socket.c:671 [inline]
 ____sys_sendmsg+0x519/0x800 net/socket.c:2353
 ___sys_sendmsg net/socket.c:2407 [inline]
 __sys_sendmsg+0x2b1/0x360 net/socket.c:2440
 do_syscall_64+0x31/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x7fb6a57a8e67
Code: 89 02 48 c7 c0 ff ff ff ff eb d0 0f 1f 84 00 00 00 00 00 8b 05 6a b5 20 00 85 c0 75 2e 48 63 ff 48 63 d2 b8 2e 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 8b 15 11 71 20 00 f7 d8 64 89 02 48
RSP: 002b:00007ffcc6917278 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 000056206161bcb0 RCX: 00007fb6a57a8e67
RDX: 0000000000000000 RSI: 00007ffcc6917290 RDI: 0000000000000004
RBP: 00007ffcc6917290 R08: 000056206161bdf4 R09: 0000000000000000
R10: 0000000000000018 R11: 0000000000000246 R12: 000056206162d8c0
R13: 000000000000009b R14: 0000562061620970 R15: 0000000000000000


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
