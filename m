Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27B64E0E54
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2019 00:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389417AbfJVWoN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Oct 2019 18:44:13 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:35096 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730847AbfJVWoN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Oct 2019 18:44:13 -0400
Received: by mail-il1-f197.google.com with SMTP id o12so10864736ilf.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Oct 2019 15:44:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=YbuAwrztLhYSbCeKjV8xzP5SlzpBV1Lkrumio9M9Mdc=;
        b=uBQvmrU/rpRpyydoHH6XZ82JWrFzZiNVWgJ9odT8Fijquj/7QXqacXg+zC3hsdokcZ
         tvDy9alkLTpxAErE2VJJe6AYgHFUHUt46Inx1sdTeceni3yl9LX1I5ZaXwp6LnwFUSwf
         W1ifK9AZVJLP7TKsTYbUScwr4JDI43zj0AeCfuc1lL6yqWnpEiFRm7vjjxuMFeYJE5AN
         adAIO98dGMMY7AJokgiSMa7KWBdziSxYrjimPetQj5Sn8rCzZQ2Q5/IqVe5DGy62BeS2
         B8w9CaJ6NQ6tl2k29t/RJkI2r84TEGC4zhJ8biALCAv3cjmyIsIUjHYMF6At5nfQx0AN
         8G/w==
X-Gm-Message-State: APjAAAXMoBD+PxVm3IWYD64ikvHXCJTl+QoBwDpQ+zlwExZ1u5I1vqFr
        8hK98NvrtugRLpFHLXZh0gvxHw+sNPRiJAduPn5H0rIDfT5F
X-Google-Smtp-Source: APXvYqxT11LIh8xvooJbwTpLCUxuTOvrqrzUPK5L9Gw1QmPb9DndF0SUR/EFFEuIyZB66QXUQmIbaE2QdBz+2z32A7WJKg3qUtOU
MIME-Version: 1.0
X-Received: by 2002:a6b:7410:: with SMTP id s16mr151990iog.35.1571784251476;
 Tue, 22 Oct 2019 15:44:11 -0700 (PDT)
Date:   Tue, 22 Oct 2019 15:44:11 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f924d50595878964@google.com>
Subject: INFO: task hung in d_alloc_parallel (2)
From:   syzbot <syzbot+55f124a35eac76b52fb7@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    998d7551 Merge branch 'akpm' (patches from Andrew)
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=132747c8e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e0ac4d9b35046343
dashboard link: https://syzkaller.appspot.com/bug?extid=55f124a35eac76b52fb7
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14eafd5f600000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11c13108e00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+55f124a35eac76b52fb7@syzkaller.appspotmail.com

INFO: task init:1 blocked for more than 143 seconds.
       Not tainted 5.4.0-rc3+ #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
init            D22888     1      0 0x00000000
Call Trace:
  context_switch kernel/sched/core.c:3384 [inline]
  __schedule+0x94f/0x1e70 kernel/sched/core.c:4069
  schedule+0xd9/0x260 kernel/sched/core.c:4136
  d_wait_lookup fs/dcache.c:2506 [inline]
  d_alloc_parallel+0x12cd/0x1c30 fs/dcache.c:2588
  __lookup_slow+0x1ab/0x500 fs/namei.c:1646
  lookup_slow+0x58/0x80 fs/namei.c:1680
  walk_component+0x747/0x2000 fs/namei.c:1800
  link_path_walk.part.0+0x9a4/0x1340 fs/namei.c:2131
  link_path_walk fs/namei.c:2259 [inline]
  path_lookupat.isra.0+0xe3/0x8d0 fs/namei.c:2307
  filename_lookup+0x1b0/0x3f0 fs/namei.c:2338
  user_path_at_empty+0x43/0x50 fs/namei.c:2598
  user_path_at include/linux/namei.h:49 [inline]
  vfs_statx+0x129/0x200 fs/stat.c:187
  vfs_stat include/linux/fs.h:3242 [inline]
  __do_sys_newstat+0xa4/0x130 fs/stat.c:341
  __se_sys_newstat fs/stat.c:337 [inline]
  __x64_sys_newstat+0x54/0x80 fs/stat.c:337
  do_syscall_64+0xfa/0x760 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x7f5f11342c65
Code: Bad RIP value.
RSP: 002b:00007ffd17d8aeb8 EFLAGS: 00000246 ORIG_RAX: 0000000000000004
RAX: ffffffffffffffda RBX: 00007ffd17d8b0f0 RCX: 00007f5f11342c65
RDX: 00007ffd17d8b0f0 RSI: 00007ffd17d8b0f0 RDI: 0000000000407545
RBP: 0000000000000000 R08: 0000000000fe3b60 R09: 0000000000000001
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 00007ffd17d8b5f0 R14: 0000000000000000 R15: 0000000000000000
INFO: task syz-executor030:9494 blocked for more than 143 seconds.
       Not tainted 5.4.0-rc3+ #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor030 D27416  9494   9492 0x00000000
Call Trace:
  context_switch kernel/sched/core.c:3384 [inline]
  __schedule+0x94f/0x1e70 kernel/sched/core.c:4069
  schedule+0xd9/0x260 kernel/sched/core.c:4136
  schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:4195
  __mutex_lock_common kernel/locking/mutex.c:1033 [inline]
  __mutex_lock+0x7b0/0x13c0 kernel/locking/mutex.c:1103
  mutex_lock_nested+0x16/0x20 kernel/locking/mutex.c:1118
  fuse_lock_inode+0xba/0xf0 fs/fuse/inode.c:352
  fuse_lookup+0x8e/0x310 fs/fuse/dir.c:382
  __lookup_slow+0x279/0x500 fs/namei.c:1663
  lookup_slow+0x58/0x80 fs/namei.c:1680
  walk_component+0x747/0x2000 fs/namei.c:1800
  link_path_walk.part.0+0x9a4/0x1340 fs/namei.c:2131
  link_path_walk fs/namei.c:2062 [inline]
  path_openat+0x202/0x46d0 fs/namei.c:3524
  do_filp_open+0x1a1/0x280 fs/namei.c:3555
  do_sys_open+0x3fe/0x5d0 fs/open.c:1097
  __do_sys_open fs/open.c:1115 [inline]
  __se_sys_open fs/open.c:1110 [inline]
  __x64_sys_open+0x7e/0xc0 fs/open.c:1110
  do_syscall_64+0xfa/0x760 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x444c90
Code: Bad RIP value.
RSP: 002b:00007fffe5690030 EFLAGS: 00000206 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000444c90
RDX: 0000000000000000 RSI: 0000000000090800 RDI: 00000000004ae8f6
RBP: 000000000000251a R08: 0000000000002516 R09: 00000000026a8880
R10: 0000000000000000 R11: 0000000000000206 R12: 00007fffe5690260
R13: 00000000004075c0 R14: 0000000000000000 R15: 0000000000000000
INFO: task syz-executor030:9498 blocked for more than 144 seconds.
       Not tainted 5.4.0-rc3+ #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor030 D28160  9498   9494 0x00000004
Call Trace:
  context_switch kernel/sched/core.c:3384 [inline]
  __schedule+0x94f/0x1e70 kernel/sched/core.c:4069
  schedule+0xd9/0x260 kernel/sched/core.c:4136
  schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:4195
  __mutex_lock_common kernel/locking/mutex.c:1033 [inline]
  __mutex_lock+0x7b0/0x13c0 kernel/locking/mutex.c:1103
  mutex_lock_nested+0x16/0x20 kernel/locking/mutex.c:1118
  fuse_lock_inode+0xba/0xf0 fs/fuse/inode.c:352
  fuse_lookup+0x8e/0x310 fs/fuse/dir.c:382
  __lookup_slow+0x279/0x500 fs/namei.c:1663
  lookup_slow+0x58/0x80 fs/namei.c:1680
  walk_component+0x747/0x2000 fs/namei.c:1800
  link_path_walk.part.0+0x9a4/0x1340 fs/namei.c:2131
  link_path_walk fs/namei.c:2062 [inline]
  path_openat+0x202/0x46d0 fs/namei.c:3524
  do_filp_open+0x1a1/0x280 fs/namei.c:3555
  do_sys_open+0x3fe/0x5d0 fs/open.c:1097
  __do_sys_open fs/open.c:1115 [inline]
  __se_sys_open fs/open.c:1110 [inline]
  __x64_sys_open+0x7e/0xc0 fs/open.c:1110
  do_syscall_64+0xfa/0x760 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x405800
Code: 4c 89 e0 eb 0d 0f 1f 44 00 00 48 8b 00 48 85 c0 74 18 48 39 58 08 75  
f2 48 39 68 10 75 ec 5b 5d 41 5c c3 0f 1f 80 00 00 00 00 <bf> 18 00 00 00  
e8 76 d3 ff ff 48 85 c0 74 e5 4d 85 e4 48 c7 00 00
RSP: 002b:00007fffe568fd38 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 00007fffe568fd64 RCX: 0000000000405800
RDX: 00007fffe568fd6a RSI: 0000000000080001 RDI: 00000000004ae914
RBP: 00007fffe568fd60 R08: 0000000000000000 R09: 0000000000000004
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000407530
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000

Showing all locks held in the system:
1 lock held by init/1:
  #0: ffff888092111740 (&type->i_mutex_dir_key#6){++++}, at:  
inode_lock_shared include/linux/fs.h:801 [inline]
  #0: ffff888092111740 (&type->i_mutex_dir_key#6){++++}, at:  
lookup_slow+0x4a/0x80 fs/namei.c:1679
1 lock held by khungtaskd/1070:
  #0: ffffffff88fab000 (rcu_read_lock){....}, at:  
debug_show_all_locks+0x5f/0x27e kernel/locking/lockdep.c:5337
1 lock held by rsyslogd/9340:
  #0: ffff88809d13e420 (&f->f_pos_lock){+.+.}, at: __fdget_pos+0xee/0x110  
fs/file.c:801
2 locks held by cron/9387:
  #0: ffff888092111740 (&type->i_mutex_dir_key#6){++++}, at:  
inode_lock_shared include/linux/fs.h:801 [inline]
  #0: ffff888092111740 (&type->i_mutex_dir_key#6){++++}, at:  
lookup_slow+0x4a/0x80 fs/namei.c:1679
  #1: ffff888092111ae0 (&fi->mutex){+.+.}, at: fuse_lock_inode+0xba/0xf0  
fs/fuse/inode.c:352
2 locks held by getty/9462:
  #0: ffff8880a7204090 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:340
  #1: ffffc90005f852e0 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x232/0x1c10 drivers/tty/n_tty.c:2156
2 locks held by getty/9463:
  #0: ffff8880a3e30090 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:340
  #1: ffffc90005f812e0 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x232/0x1c10 drivers/tty/n_tty.c:2156
2 locks held by getty/9464:
  #0: ffff8880a3fad090 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:340
  #1: ffffc90005f892e0 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x232/0x1c10 drivers/tty/n_tty.c:2156
2 locks held by getty/9465:
  #0: ffff88809df54090 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:340
  #1: ffffc90005f912e0 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x232/0x1c10 drivers/tty/n_tty.c:2156
2 locks held by getty/9466:
  #0: ffff888098a67090 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:340
  #1: ffffc90005f8d2e0 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x232/0x1c10 drivers/tty/n_tty.c:2156
2 locks held by getty/9467:
  #0: ffff8880972d4090 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:340
  #1: ffffc90005f952e0 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x232/0x1c10 drivers/tty/n_tty.c:2156
2 locks held by getty/9468:
  #0: ffff888099a67090 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:340
  #1: ffffc90005f5d2e0 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x232/0x1c10 drivers/tty/n_tty.c:2156
2 locks held by udevd/9478:
  #0: ffff888092111740 (&type->i_mutex_dir_key#6){++++}, at:  
inode_lock_shared include/linux/fs.h:801 [inline]
  #0: ffff888092111740 (&type->i_mutex_dir_key#6){++++}, at:  
lookup_slow+0x4a/0x80 fs/namei.c:1679
  #1: ffff888092111ae0 (&fi->mutex){+.+.}, at: fuse_lock_inode+0xba/0xf0  
fs/fuse/inode.c:352
2 locks held by syz-executor030/9494:
  #0: ffff888092111740 (&type->i_mutex_dir_key#6){++++}, at:  
inode_lock_shared include/linux/fs.h:801 [inline]
  #0: ffff888092111740 (&type->i_mutex_dir_key#6){++++}, at:  
lookup_slow+0x4a/0x80 fs/namei.c:1679
  #1: ffff888092111ae0 (&fi->mutex){+.+.}, at: fuse_lock_inode+0xba/0xf0  
fs/fuse/inode.c:352
2 locks held by syz-executor030/9498:
  #0: ffff888092111740 (&type->i_mutex_dir_key#6){++++}, at:  
inode_lock_shared include/linux/fs.h:801 [inline]
  #0: ffff888092111740 (&type->i_mutex_dir_key#6){++++}, at:  
lookup_slow+0x4a/0x80 fs/namei.c:1679
  #1: ffff888092111ae0 (&fi->mutex){+.+.}, at: fuse_lock_inode+0xba/0xf0  
fs/fuse/inode.c:352

=============================================

NMI backtrace for cpu 1
CPU: 1 PID: 1070 Comm: khungtaskd Not tainted 5.4.0-rc3+ #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  nmi_cpu_backtrace.cold+0x70/0xb2 lib/nmi_backtrace.c:101
  nmi_trigger_cpumask_backtrace+0x23b/0x28b lib/nmi_backtrace.c:62
  arch_trigger_cpumask_backtrace+0x14/0x20 arch/x86/kernel/apic/hw_nmi.c:38
  trigger_all_cpu_backtrace include/linux/nmi.h:146 [inline]
  check_hung_uninterruptible_tasks kernel/hung_task.c:205 [inline]
  watchdog+0x9d0/0xef0 kernel/hung_task.c:289
  kthread+0x361/0x430 kernel/kthread.c:255
  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0 skipped: idling at native_safe_halt+0xe/0x10  
arch/x86/include/asm/irqflags.h:60


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
