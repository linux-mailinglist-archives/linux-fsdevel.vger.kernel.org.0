Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D04EA309B3E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 31 Jan 2021 10:45:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbhAaJmC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 31 Jan 2021 04:42:02 -0500
Received: from mail-il1-f197.google.com ([209.85.166.197]:50006 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230165AbhAaJkB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 31 Jan 2021 04:40:01 -0500
Received: by mail-il1-f197.google.com with SMTP id q3so11308226ilv.16
        for <linux-fsdevel@vger.kernel.org>; Sun, 31 Jan 2021 01:39:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=CfQ+twVIg4wde5CKyqRsNFlxl1xHEaSejYFflkTsyHc=;
        b=GVgvo0iPui2P733rbLxGS4FYC0uRyONQE49sSE5psg4Zc/7yz1XEHq9vZpdfoNaVin
         ffVZhgqft8+DCsui+eUDpSkLIyU9zNpkymSUinoJ+lMUr7vMF7yXCbE6Cw+E0+Iki8Ir
         jv8Pe4ZS6HcDZvwWMVtRPb5LJ6GJQwold+QGdRraYr+bXM/1+Z3UdOKTRmtK5gpALgzM
         +XFQRc5p2j10TS3JAkhqk8vMBB35g4aoktmb6MS8TDHjGz2+x/y7PbHskefxTrHsb/q4
         D0Nc0yZZFqCwolaO3TuEYRGHCt2GpbDyi0zm3idCC5EZ7KMUJBWtnTqQD/so31UUrmVW
         QLzg==
X-Gm-Message-State: AOAM532+1jMJNuuBDjtRO3Phi/qiyUK+hUO8sh2p8LHfQGqhHehrLB5s
        ftBOGAVgaeIAi6VpQU8nlh0npNThEVDXtrEnBX3cqZa711sK
X-Google-Smtp-Source: ABdhPJzN+LllYbuS2zrf0Lm9mGJniVzpX1wGdUT1BtOlKOxOwrZ7w9msljDf6yKXZvIQ0lsFHYbO68Yqpr2zDW6J9XoOX1grYNuh
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a6d:: with SMTP id w13mr9857659ilv.181.1612085957377;
 Sun, 31 Jan 2021 01:39:17 -0800 (PST)
Date:   Sun, 31 Jan 2021 01:39:17 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d6445b05ba2f02de@google.com>
Subject: INFO: task can't die in iget5_locked
From:   syzbot <syzbot+1732f7c4545ff63c9119@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    b01f250d Add linux-next specific files for 20210129
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1340da08d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=725bc96dc234fda7
dashboard link: https://syzkaller.appspot.com/bug?extid=1732f7c4545ff63c9119
compiler:       gcc (GCC) 10.1.0-syz 20200507

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1732f7c4545ff63c9119@syzkaller.appspotmail.com

INFO: task syz-executor.4:15223 can't die for more than 143 seconds.
task:syz-executor.4  state:R  running task     stack:25736 pid:15223 ppid:  8430 flags:0x00004006
Call Trace:
 context_switch kernel/sched/core.c:4326 [inline]
 __schedule+0x90c/0x21a0 kernel/sched/core.c:5077
 preempt_schedule_common+0x45/0xc0 kernel/sched/core.c:5237
 preempt_schedule_thunk+0x16/0x18 arch/x86/entry/thunk_64.S:35
 __raw_spin_unlock include/linux/spinlock_api_smp.h:152 [inline]
 _raw_spin_unlock+0x36/0x40 kernel/locking/spinlock.c:183
 spin_unlock include/linux/spinlock.h:394 [inline]
 ilookup5_nowait fs/inode.c:1336 [inline]
 ilookup5 fs/inode.c:1364 [inline]
 iget5_locked+0xcc/0x2d0 fs/inode.c:1145
 fuse_iget+0x271/0x610 fs/fuse/inode.c:342
 fuse_lookup_name+0x447/0x630 fs/fuse/dir.c:439
 fuse_lookup.part.0+0xdf/0x390 fs/fuse/dir.c:469
 fuse_lookup+0x70/0x90 fs/fuse/dir.c:465
 __lookup_slow+0x24c/0x480 fs/namei.c:1625
 lookup_slow fs/namei.c:1642 [inline]
 walk_component+0x418/0x6a0 fs/namei.c:1939
 lookup_last fs/namei.c:2396 [inline]
 path_lookupat+0x1ba/0x830 fs/namei.c:2420
 filename_lookup+0x19f/0x560 fs/namei.c:2453
 unix_find_other+0xd1/0x720 net/unix/af_unix.c:935
 unix_dgram_sendmsg+0xc73/0x1a80 net/unix/af_unix.c:1696
 sock_sendmsg_nosec net/socket.c:654 [inline]
 sock_sendmsg+0xcf/0x120 net/socket.c:674
 ____sys_sendmsg+0x331/0x810 net/socket.c:2350
 ___sys_sendmsg+0xf3/0x170 net/socket.c:2404
 __sys_sendmmsg+0x195/0x470 net/socket.c:2494
 __do_sys_sendmmsg net/socket.c:2523 [inline]
 __se_sys_sendmmsg net/socket.c:2520 [inline]
 __x64_sys_sendmmsg+0x99/0x100 net/socket.c:2520
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x45e219
RSP: 002b:00007f20a7119c68 EFLAGS: 00000246 ORIG_RAX: 0000000000000133
RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 000000000045e219
RDX: 0000000000000002 RSI: 0000000020008600 RDI: 0000000000000006
RBP: 000000000119bfc8 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000119bf8c
R13: 00007ffcb7b513ef R14: 00007f20a711a9c0 R15: 000000000119bf8c
INFO: task syz-executor.4:15230 can't die for more than 144 seconds.
task:syz-executor.4  state:D stack:27056 pid:15230 ppid:  8430 flags:0x00000004
Call Trace:
 context_switch kernel/sched/core.c:4326 [inline]
 __schedule+0x90c/0x21a0 kernel/sched/core.c:5077
 schedule+0xcf/0x270 kernel/sched/core.c:5156
 rwsem_down_write_slowpath+0x7e5/0x1200 kernel/locking/rwsem.c:1106
 __down_write_common kernel/locking/rwsem.c:1261 [inline]
 __down_write_common kernel/locking/rwsem.c:1258 [inline]
 __down_write kernel/locking/rwsem.c:1270 [inline]
 down_write+0x132/0x150 kernel/locking/rwsem.c:1407
 inode_lock include/linux/fs.h:775 [inline]
 lock_mount+0x8a/0x2e0 fs/namespace.c:2216
 do_new_mount_fc fs/namespace.c:2846 [inline]
 do_new_mount fs/namespace.c:2905 [inline]
 path_mount+0x14d6/0x1f90 fs/namespace.c:3233
 do_mount fs/namespace.c:3246 [inline]
 __do_sys_mount fs/namespace.c:3454 [inline]
 __se_sys_mount fs/namespace.c:3431 [inline]
 __x64_sys_mount+0x27f/0x300 fs/namespace.c:3431
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x45e219
RSP: 002b:00007f20a70f8c68 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000000000005 RCX: 000000000045e219
RDX: 0000000020002100 RSI: 00000000200020c0 RDI: 0000000000000000
RBP: 000000000119c078 R08: 0000000020002140 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000119c034
R13: 00007ffcb7b513ef R14: 00007f20a70f99c0 R15: 000000000119c034
INFO: task syz-executor.4:15230 blocked for more than 144 seconds.
      Not tainted 5.11.0-rc5-next-20210129-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.4  state:D stack:27056 pid:15230 ppid:  8430 flags:0x00000004
Call Trace:
 context_switch kernel/sched/core.c:4326 [inline]
 __schedule+0x90c/0x21a0 kernel/sched/core.c:5077
 schedule+0xcf/0x270 kernel/sched/core.c:5156
 rwsem_down_write_slowpath+0x7e5/0x1200 kernel/locking/rwsem.c:1106
 __down_write_common kernel/locking/rwsem.c:1261 [inline]
 __down_write_common kernel/locking/rwsem.c:1258 [inline]
 __down_write kernel/locking/rwsem.c:1270 [inline]
 down_write+0x132/0x150 kernel/locking/rwsem.c:1407
 inode_lock include/linux/fs.h:775 [inline]
 lock_mount+0x8a/0x2e0 fs/namespace.c:2216
 do_new_mount_fc fs/namespace.c:2846 [inline]
 do_new_mount fs/namespace.c:2905 [inline]
 path_mount+0x14d6/0x1f90 fs/namespace.c:3233
 do_mount fs/namespace.c:3246 [inline]
 __do_sys_mount fs/namespace.c:3454 [inline]
 __se_sys_mount fs/namespace.c:3431 [inline]
 __x64_sys_mount+0x27f/0x300 fs/namespace.c:3431
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x45e219
RSP: 002b:00007f20a70f8c68 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000000000005 RCX: 000000000045e219
RDX: 0000000020002100 RSI: 00000000200020c0 RDI: 0000000000000000
RBP: 000000000119c078 R08: 0000000020002140 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000119c034
R13: 00007ffcb7b513ef R14: 00007f20a70f99c0 R15: 000000000119c034

Showing all locks held in the system:
1 lock held by khungtaskd/1666:
 #0: ffffffff8b571460 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x53/0x260 kernel/locking/lockdep.c:6326
1 lock held by in:imklog/8110:
 #0: ffff88801a784d70 (&f->f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0xe9/0x100 fs/file.c:961
2 locks held by syz-executor.4/15223:
1 lock held by syz-executor.4/15230:
 #0: ffff8880325a8150 (&type->i_mutex_dir_key#9){++++}-{3:3}, at: inode_lock include/linux/fs.h:775 [inline]
 #0: ffff8880325a8150 (&type->i_mutex_dir_key#9){++++}-{3:3}, at: lock_mount+0x8a/0x2e0 fs/namespace.c:2216

=============================================

NMI backtrace for cpu 1
CPU: 1 PID: 1666 Comm: khungtaskd Not tainted 5.11.0-rc5-next-20210129-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x107/0x163 lib/dump_stack.c:120
 nmi_cpu_backtrace.cold+0x44/0xd7 lib/nmi_backtrace.c:105
 nmi_trigger_cpumask_backtrace+0x1b3/0x230 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:147 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:253 [inline]
 watchdog+0xd89/0xf30 kernel/hung_task.c:338
 kthread+0x3b1/0x4a0 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 PID: 15223 Comm: syz-executor.4 Not tainted 5.11.0-rc5-next-20210129-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:match_held_lock+0xa/0x150 kernel/locking/lockdep.c:4961
Code: 0f 1f 44 00 00 48 8b 34 24 48 c7 c7 20 14 6a 89 e8 6f b5 be ff cc cc cc cc cc cc cc cc cc cc cc 48 39 77 10 0f 84 97 00 00 00 <66> f7 47 22 f0 ff 74 4b 48 83 ec 08 48 8b 46 08 48 85 c0 0f 84 84
RSP: 0018:ffffc90016c7ef08 EFLAGS: 00000087
RAX: 0000000000000005 RBX: 0000000000000001 RCX: 0000000000000001
RDX: 0000000000000000 RSI: ffffffff8b571400 RDI: ffff88807666a5b8
RBP: ffffffff8b571400 R08: fffffffffffff000 R09: ffffffff8b2146c3
R10: ffffffff81c937db R11: 0000000000000000 R12: ffff888076669c00
R13: ffff88807666a590 R14: 00000000ffffffff R15: ffff88807666a5b8
FS:  00007f20a711a700(0000) GS:ffff8880b9e00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f9a30068000 CR3: 000000002f153000 CR4: 00000000001506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 __lock_is_held kernel/locking/lockdep.c:5252 [inline]
 lock_is_held_type+0xa4/0x120 kernel/locking/lockdep.c:5548
 lock_is_held include/linux/lockdep.h:278 [inline]
 ___might_sleep+0x202/0x2c0 kernel/sched/core.c:8050
 wait_on_inode include/linux/writeback.h:205 [inline]
 ilookup5 fs/inode.c:1366 [inline]
 iget5_locked+0x10e/0x2d0 fs/inode.c:1145
 fuse_iget+0x271/0x610 fs/fuse/inode.c:342
 fuse_lookup_name+0x447/0x630 fs/fuse/dir.c:439
 fuse_lookup.part.0+0xdf/0x390 fs/fuse/dir.c:469
 fuse_lookup+0x70/0x90 fs/fuse/dir.c:465
 __lookup_slow+0x24c/0x480 fs/namei.c:1625
 lookup_slow fs/namei.c:1642 [inline]
 walk_component+0x418/0x6a0 fs/namei.c:1939
 lookup_last fs/namei.c:2396 [inline]
 path_lookupat+0x1ba/0x830 fs/namei.c:2420
 filename_lookup+0x19f/0x560 fs/namei.c:2453
 unix_find_other+0xd1/0x720 net/unix/af_unix.c:935
 unix_dgram_sendmsg+0xc73/0x1a80 net/unix/af_unix.c:1696
 sock_sendmsg_nosec net/socket.c:654 [inline]
 sock_sendmsg+0xcf/0x120 net/socket.c:674
 ____sys_sendmsg+0x331/0x810 net/socket.c:2350
 ___sys_sendmsg+0xf3/0x170 net/socket.c:2404
 __sys_sendmmsg+0x195/0x470 net/socket.c:2494
 __do_sys_sendmmsg net/socket.c:2523 [inline]
 __se_sys_sendmmsg net/socket.c:2520 [inline]
 __x64_sys_sendmmsg+0x99/0x100 net/socket.c:2520
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x45e219
Code: 0d b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 db b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f20a7119c68 EFLAGS: 00000246 ORIG_RAX: 0000000000000133
RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 000000000045e219
RDX: 0000000000000002 RSI: 0000000020008600 RDI: 0000000000000006
RBP: 000000000119bfc8 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000119bf8c
R13: 00007ffcb7b513ef R14: 00007f20a711a9c0 R15: 000000000119bf8c


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
