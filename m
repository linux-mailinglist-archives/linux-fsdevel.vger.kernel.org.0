Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E7E1155CD6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2020 18:28:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727468AbgBGR2Q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Feb 2020 12:28:16 -0500
Received: from mail-io1-f70.google.com ([209.85.166.70]:53669 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726901AbgBGR2P (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Feb 2020 12:28:15 -0500
Received: by mail-io1-f70.google.com with SMTP id q24so91994iot.20
        for <linux-fsdevel@vger.kernel.org>; Fri, 07 Feb 2020 09:28:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=W63ahMeKAoR2+ngyjzVUzuW+ArlTdmK9l5iWyjmZIq4=;
        b=oUCELQb9zcmWIAGNr0uXjPE2EHovOAdUkd4FFbzGhiTgbuKGdoc5iT6cMYQaO2fh1n
         w+7IK9ZPasffRlrSY+EgtMha5bidA95M63HJdc5OQnHaGUJw21cnSEW0eEn9zJCPWt6L
         ausNNt/jroucBQyKnN+U8WYv8KYDKYlAiBCDkDnSu03Qq40jBqAHYKvSvMj4+DJAGTor
         dsfM0cZS8zAH1i5/W88fq0yke9b9+VQrlRLykUrplWzO1w0XYMiRru30FuHjgm0kbB5n
         GDZ1AKqCOMCE8bhwAfxt9Bq88ep/kluB2Pc2cTe9ijedew4srLZrYmxlsKSzxRnrxoik
         E1nQ==
X-Gm-Message-State: APjAAAX49dq/R+dXquFEOxrU4x7/zHlHdJApOT0pcY/zf12BfO7J6UgE
        fiXmQuPBATQpSJq3R9v2BN68lu2NJvJM1HaF+zQn1btLLuf2
X-Google-Smtp-Source: APXvYqwEh9lgosP+ZBBHmuXoEJ8mg3fo/tiMaBTWqs2Fddp9hM/GpnUDHlrR9f+tNwP4WEpc/KQZNAmVVXrqXSKGL1pvEcf7kp6m
MIME-Version: 1.0
X-Received: by 2002:a92:79c4:: with SMTP id u187mr454535ilc.92.1581096493420;
 Fri, 07 Feb 2020 09:28:13 -0800 (PST)
Date:   Fri, 07 Feb 2020 09:28:13 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d895bd059dffb65c@google.com>
Subject: BUG: sleeping function called from invalid context in __kmalloc
From:   syzbot <syzbot+98704a51af8e3d9425a9@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    90568ecf Merge tag 'kvm-5.6-2' of git://git.kernel.org/pub..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=107413bee00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=69fa012479f9a62
dashboard link: https://syzkaller.appspot.com/bug?extid=98704a51af8e3d9425a9
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+98704a51af8e3d9425a9@syzkaller.appspotmail.com

BUG: sleeping function called from invalid context at mm/slab.h:565
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 12445, name: syz-executor.1
1 lock held by syz-executor.1/12445:
 #0: ffffffff89310218 (sb_lock){+.+.}, at: spin_lock include/linux/spinlock.h:338 [inline]
 #0: ffffffff89310218 (sb_lock){+.+.}, at: sget_fc+0xdc/0x640 fs/super.c:521
Preemption disabled at:
[<ffffffff81be818c>] spin_lock include/linux/spinlock.h:338 [inline]
[<ffffffff81be818c>] sget_fc+0xdc/0x640 fs/super.c:521
CPU: 0 PID: 12445 Comm: syz-executor.1 Not tainted 5.5.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x1fb/0x318 lib/dump_stack.c:118
 ___might_sleep+0x449/0x5e0 kernel/sched/core.c:6800
 __might_sleep+0x8f/0x100 kernel/sched/core.c:6753
 slab_pre_alloc_hook mm/slab.h:565 [inline]
 slab_alloc mm/slab.c:3306 [inline]
 __do_kmalloc mm/slab.c:3654 [inline]
 __kmalloc+0x6f/0x340 mm/slab.c:3665
 kmalloc include/linux/slab.h:560 [inline]
 path_remove_extra_slash+0xae/0x2a0 fs/ceph/super.c:495
 compare_mount_options fs/ceph/super.c:553 [inline]
 ceph_compare_super+0x1d4/0x560 fs/ceph/super.c:1052
 sget_fc+0x139/0x640 fs/super.c:524
 ceph_get_tree+0x467/0x1540 fs/ceph/super.c:1127
 vfs_get_tree+0x8b/0x2a0 fs/super.c:1547
 do_new_mount fs/namespace.c:2822 [inline]
 do_mount+0x18ee/0x25a0 fs/namespace.c:3142
 __do_sys_mount fs/namespace.c:3351 [inline]
 __se_sys_mount+0xdd/0x110 fs/namespace.c:3328
 __x64_sys_mount+0xbf/0xd0 fs/namespace.c:3328
 do_syscall_64+0xf7/0x1c0 arch/x86/entry/common.c:294
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x45b399
Code: ad b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 7b b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f77dba0ec78 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f77dba0f6d4 RCX: 000000000045b399
RDX: 0000000020000140 RSI: 00000000200000c0 RDI: 0000000020000040
RBP: 000000000075c070 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 0000000000000745 R14: 00000000004c8c38 R15: 000000000075c07c
ceph: No mds server is up or the cluster is laggy


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
