Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91FBA125EA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2019 03:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbfECBGH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 May 2019 21:06:07 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:52614 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbfECBGH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 May 2019 21:06:07 -0400
Received: by mail-io1-f71.google.com with SMTP id t12so3315200ioc.19
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 May 2019 18:06:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=VzCj3Nnmvs7DMHUtzSYcHisPUznb7GXkmaagy/qmZY0=;
        b=Hlk1LFSwjAAe09nIBi931JymItoDzEu5h+rSAq/c671MBHkhnTM0sqVVGdcUkfk2BI
         +txTCKLvFhcGF3jf7LBQgL5NU0p1t1TRyWF6PKoIepP12msV4m5Z4P2Zf3b34lKf4rwm
         w4iVB2+l6Ndd0WA45eZNPt9PHhZH80snJ/o6uBmAage9XOc85ifeTeTzQ+dIR7TmL2zN
         18jHAxFrXB5cbLEMwraxjETig5XMq4Cgq8C4l/MO7+bf+UaY2HE47rQLxdCFnynMPBjr
         AtbNVTPipWgL7qf1yODAXbZ7Dvec3YamGfOurYzulCe48fUvBA1ujP2TEArDQne5Tcus
         yyMQ==
X-Gm-Message-State: APjAAAWy3PhfQYvdT73l6jo6k/m9Iwo6qtUdcjMZyxkeomcumAgaW8hu
        x6dmQ15M2Mka7FxLICaZfOkwvuxrillfLWT2v1K5rT0ctBLG
X-Google-Smtp-Source: APXvYqwszxiZU65FeCKJ2+aBskWIPIbsUDr5NoENAtRCJ7u6BPShgBMyZbu8a0Dzz1l5PqEPqty0g1MFxiDczwxihPQnAvPMvvFr
MIME-Version: 1.0
X-Received: by 2002:a24:d91:: with SMTP id 139mr5175945itx.152.1556845566181;
 Thu, 02 May 2019 18:06:06 -0700 (PDT)
Date:   Thu, 02 May 2019 18:06:06 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f14d5c0587f15a95@google.com>
Subject: INFO: task hung in mount_bdev (2)
From:   syzbot <syzbot+97889fb583ef1f3d42c6@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    9520b532 Merge tag 'for-linus' of git://git.armlinux.org.u..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1104bb90a00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a42d110b47dd6b36
dashboard link: https://syzkaller.appspot.com/bug?extid=97889fb583ef1f3d42c6
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10357834a00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10e1d160a00000

Bisection is inconclusive: the bug happens on the oldest tested release.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1478aa98a00000
console output: https://syzkaller.appspot.com/x/log.txt?x=1278aa98a00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+97889fb583ef1f3d42c6@syzkaller.appspotmail.com

INFO: task syz-executor013:7561 blocked for more than 143 seconds.
       Not tainted 5.1.0-rc6+ #90
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor013 D29336  7561   7543 0x00000004
Call Trace:
  context_switch kernel/sched/core.c:2877 [inline]
  __schedule+0x813/0x1cc0 kernel/sched/core.c:3518
  schedule+0x92/0x180 kernel/sched/core.c:3562
  schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:3620
  __mutex_lock_common kernel/locking/mutex.c:1002 [inline]
  __mutex_lock+0x726/0x1310 kernel/locking/mutex.c:1072
  mutex_lock_nested+0x16/0x20 kernel/locking/mutex.c:1087
  mount_bdev+0x93/0x3c0 fs/super.c:1313
  udf_mount+0x35/0x40 fs/udf/super.c:131
  legacy_get_tree+0xf2/0x200 fs/fs_context.c:584
  vfs_get_tree+0x123/0x450 fs/super.c:1481
  do_new_mount fs/namespace.c:2622 [inline]
  do_mount+0x1436/0x2c40 fs/namespace.c:2942
  ksys_mount+0xdb/0x150 fs/namespace.c:3151
  __do_sys_mount fs/namespace.c:3165 [inline]
  __se_sys_mount fs/namespace.c:3162 [inline]
  __x64_sys_mount+0xbe/0x150 fs/namespace.c:3162
  do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x44a739
Code: 00 49 6e 76 61 6c 69 64 20 22 24 41 63 74 69 6f 6e 51 75 65 75 65 43  
68 65 63 6b 70 6f 69 6e 74 49 6e 74 65 72 76 61 6c 22 2c <20> 65 72 72 6f  
72 20 25 64 2e 20 49 67 6e 6f 72 65 64 2c 20 72 75
RSP: 002b:00007f9541ef0db8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00000000006dbc28 RCX: 000000000044a739
RDX: 0000000020000240 RSI: 0000000020000200 RDI: 0000000020000080
RBP: 00000000006dbc20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006dbc2c
R13: 00007ffc6cf3cddf R14: 00007f9541ef19c0 R15: 0000000000000000
INFO: task syz-executor013:7563 blocked for more than 143 seconds.
       Not tainted 5.1.0-rc6+ #90
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor013 D29720  7563   7541 0x00000004
Call Trace:
  context_switch kernel/sched/core.c:2877 [inline]
  __schedule+0x813/0x1cc0 kernel/sched/core.c:3518
  schedule+0x92/0x180 kernel/sched/core.c:3562
  schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:3620
  __mutex_lock_common kernel/locking/mutex.c:1002 [inline]
  __mutex_lock+0x726/0x1310 kernel/locking/mutex.c:1072
  mutex_lock_nested+0x16/0x20 kernel/locking/mutex.c:1087
  mount_bdev+0x93/0x3c0 fs/super.c:1313
  udf_mount+0x35/0x40 fs/udf/super.c:131
  legacy_get_tree+0xf2/0x200 fs/fs_context.c:584
  vfs_get_tree+0x123/0x450 fs/super.c:1481
  do_new_mount fs/namespace.c:2622 [inline]
  do_mount+0x1436/0x2c40 fs/namespace.c:2942
  ksys_mount+0xdb/0x150 fs/namespace.c:3151
  __do_sys_mount fs/namespace.c:3165 [inline]
  __se_sys_mount fs/namespace.c:3162 [inline]
  __x64_sys_mount+0xbe/0x150 fs/namespace.c:3162
  do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x44a739
Code: 00 49 6e 76 61 6c 69 64 20 22 24 41 63 74 69 6f 6e 51 75 65 75 65 43  
68 65 63 6b 70 6f 69 6e 74 49 6e 74 65 72 76 61 6c 22 2c <20> 65 72 72 6f  
72 20 25 64 2e 20 49 67 6e 6f 72 65 64 2c 20 72 75
RSP: 002b:00007f9541ef0db8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00000000006dbc28 RCX: 000000000044a739
RDX: 0000000020000240 RSI: 0000000020000200 RDI: 0000000020000080
RBP: 00000000006dbc20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006dbc2c
R13: 00007ffc6cf3cddf R14: 00007f9541ef19c0 R15: 0000000000000000
INFO: task syz-executor013:7559 blocked for more than 143 seconds.
       Not tainted 5.1.0-rc6+ #90
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor013 D29096  7559   7544 0x00000004
Call Trace:
  context_switch kernel/sched/core.c:2877 [inline]
  __schedule+0x813/0x1cc0 kernel/sched/core.c:3518
  schedule+0x92/0x180 kernel/sched/core.c:3562
  __rwsem_down_write_failed_common kernel/locking/rwsem-xadd.c:582 [inline]
  rwsem_down_write_failed+0x774/0xc30 kernel/locking/rwsem-xadd.c:611
  call_rwsem_down_write_failed+0x17/0x30 arch/x86/lib/rwsem.S:117
  __down_write arch/x86/include/asm/rwsem.h:142 [inline]
  down_write+0x53/0x90 kernel/locking/rwsem.c:72
  grab_super+0xb4/0x290 fs/super.c:385
  sget_userns+0x1ab/0x560 fs/super.c:601
  sget+0x10c/0x150 fs/super.c:660
  mount_bdev+0xff/0x3c0 fs/super.c:1319
  udf_mount+0x35/0x40 fs/udf/super.c:131
  legacy_get_tree+0xf2/0x200 fs/fs_context.c:584
  vfs_get_tree+0x123/0x450 fs/super.c:1481
  do_new_mount fs/namespace.c:2622 [inline]
  do_mount+0x1436/0x2c40 fs/namespace.c:2942
  ksys_mount+0xdb/0x150 fs/namespace.c:3151
  __do_sys_mount fs/namespace.c:3165 [inline]
  __se_sys_mount fs/namespace.c:3162 [inline]
  __x64_sys_mount+0xbe/0x150 fs/namespace.c:3162
  do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x44a739
Code: 00 49 6e 76 61 6c 69 64 20 22 24 41 63 74 69 6f 6e 51 75 65 75 65 43  
68 65 63 6b 70 6f 69 6e 74 49 6e 74 65 72 76 61 6c 22 2c <20> 65 72 72 6f  
72 20 25 64 2e 20 49 67 6e 6f 72 65 64 2c 20 72 75
RSP: 002b:00007f9541ef0db8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00000000006dbc28 RCX: 000000000044a739
RDX: 0000000020000240 RSI: 0000000020000200 RDI: 0000000020000080
RBP: 00000000006dbc20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006dbc2c
R13: 00007ffc6cf3cddf R14: 00007f9541ef19c0 R15: 0000000000000000
INFO: task syz-executor013:7565 blocked for more than 144 seconds.
       Not tainted 5.1.0-rc6+ #90
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor013 D29720  7565   7542 0x00000004
Call Trace:
  context_switch kernel/sched/core.c:2877 [inline]
  __schedule+0x813/0x1cc0 kernel/sched/core.c:3518
  schedule+0x92/0x180 kernel/sched/core.c:3562
  schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:3620
  __mutex_lock_common kernel/locking/mutex.c:1002 [inline]
  __mutex_lock+0x726/0x1310 kernel/locking/mutex.c:1072
  mutex_lock_nested+0x16/0x20 kernel/locking/mutex.c:1087
  mount_bdev+0x93/0x3c0 fs/super.c:1313
  udf_mount+0x35/0x40 fs/udf/super.c:131
  legacy_get_tree+0xf2/0x200 fs/fs_context.c:584
  vfs_get_tree+0x123/0x450 fs/super.c:1481
  do_new_mount fs/namespace.c:2622 [inline]
  do_mount+0x1436/0x2c40 fs/namespace.c:2942
  ksys_mount+0xdb/0x150 fs/namespace.c:3151
  __do_sys_mount fs/namespace.c:3165 [inline]
  __se_sys_mount fs/namespace.c:3162 [inline]
  __x64_sys_mount+0xbe/0x150 fs/namespace.c:3162
  do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x44a739
Code: 00 49 6e 76 61 6c 69 64 20 22 24 41 63 74 69 6f 6e 51 75 65 75 65 43  
68 65 63 6b 70 6f 69 6e 74 49 6e 74 65 72 76 61 6c 22 2c <20> 65 72 72 6f  
72 20 25 64 2e 20 49 67 6e 6f 72 65 64 2c 20 72 75
RSP: 002b:00007f9541ef0db8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00000000006dbc28 RCX: 000000000044a739
RDX: 0000000020000240 RSI: 0000000020000200 RDI: 0000000020000080
RBP: 00000000006dbc20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006dbc2c
R13: 00007ffc6cf3cddf R14: 00007f9541ef19c0 R15: 0000000000000000
INFO: task syz-executor013:7562 blocked for more than 144 seconds.
       Not tainted 5.1.0-rc6+ #90
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor013 D29720  7562   7546 0x00000004
Call Trace:
  context_switch kernel/sched/core.c:2877 [inline]
  __schedule+0x813/0x1cc0 kernel/sched/core.c:3518
  schedule+0x92/0x180 kernel/sched/core.c:3562
  schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:3620
  __mutex_lock_common kernel/locking/mutex.c:1002 [inline]
  __mutex_lock+0x726/0x1310 kernel/locking/mutex.c:1072
  mutex_lock_nested+0x16/0x20 kernel/locking/mutex.c:1087
  mount_bdev+0x93/0x3c0 fs/super.c:1313
  udf_mount+0x35/0x40 fs/udf/super.c:131
  legacy_get_tree+0xf2/0x200 fs/fs_context.c:584
  vfs_get_tree+0x123/0x450 fs/super.c:1481
  do_new_mount fs/namespace.c:2622 [inline]
  do_mount+0x1436/0x2c40 fs/namespace.c:2942
  ksys_mount+0xdb/0x150 fs/namespace.c:3151
  __do_sys_mount fs/namespace.c:3165 [inline]
  __se_sys_mount fs/namespace.c:3162 [inline]
  __x64_sys_mount+0xbe/0x150 fs/namespace.c:3162
  do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x44a739
Code: 00 49 6e 76 61 6c 69 64 20 22 24 41 63 74 69 6f 6e 51 75 65 75 65 43  
68 65 63 6b 70 6f 69 6e 74 49 6e 74 65 72 76 61 6c 22 2c <20> 65 72 72 6f  
72 20 25 64 2e 20 49 67 6e 6f 72 65 64 2c 20 72 75
RSP: 002b:00007f9541ef0db8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00000000006dbc28 RCX: 000000000044a739
RDX: 0000000020000240 RSI: 0000000020000200 RDI: 0000000020000080
RBP: 00000000006dbc20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006dbc2c
R13: 00007ffc6cf3cddf R14: 00007f9541ef19c0 R15: 0000000000000000

Showing all locks held in the system:
1 lock held by khungtaskd/1042:
  #0: 000000006329251d (rcu_read_lock){....}, at:  
debug_show_all_locks+0x5f/0x27e kernel/locking/lockdep.c:5057
1 lock held by rsyslogd/7425:
  #0: 00000000d77ddd95 (&f->f_pos_lock){+.+.}, at: __fdget_pos+0xee/0x110  
fs/file.c:801
2 locks held by getty/7515:
  #0: 000000004c45b4e6 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:341
  #1: 00000000cb1f5c30 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x232/0x1b70 drivers/tty/n_tty.c:2156
2 locks held by getty/7516:
  #0: 0000000061e5eac7 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:341
  #1: 00000000aab03c35 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x232/0x1b70 drivers/tty/n_tty.c:2156
2 locks held by getty/7517:
  #0: 00000000205ee5b4 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:341
  #1: 0000000002712bdb (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x232/0x1b70 drivers/tty/n_tty.c:2156
2 locks held by getty/7518:
  #0: 000000000cc046b2 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:341
  #1: 00000000d5140a4a (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x232/0x1b70 drivers/tty/n_tty.c:2156
2 locks held by getty/7519:
  #0: 000000003624da6d (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:341
  #1: 00000000f5b16893 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x232/0x1b70 drivers/tty/n_tty.c:2156
2 locks held by getty/7520:
  #0: 0000000082294f91 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:341
  #1: 00000000870dfcb5 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x232/0x1b70 drivers/tty/n_tty.c:2156
2 locks held by getty/7521:
  #0: 000000000f72fa86 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:341
  #1: 00000000a044b2e0 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x232/0x1b70 drivers/tty/n_tty.c:2156
2 locks held by syz-executor013/7547:
1 lock held by syz-executor013/7561:
  #0: 00000000d97cb347 (&bdev->bd_fsfreeze_mutex){+.+.}, at:  
mount_bdev+0x93/0x3c0 fs/super.c:1313
1 lock held by syz-executor013/7563:
  #0: 00000000d97cb347 (&bdev->bd_fsfreeze_mutex){+.+.}, at:  
mount_bdev+0x93/0x3c0 fs/super.c:1313
2 locks held by syz-executor013/7559:
  #0: 00000000d97cb347 (&bdev->bd_fsfreeze_mutex){+.+.}, at:  
mount_bdev+0x93/0x3c0 fs/super.c:1313
  #1: 000000001ecfe564 (&type->s_umount_key#39){+.+.}, at:  
grab_super+0xb4/0x290 fs/super.c:385
1 lock held by syz-executor013/7565:
  #0: 00000000d97cb347 (&bdev->bd_fsfreeze_mutex){+.+.}, at:  
mount_bdev+0x93/0x3c0 fs/super.c:1313
1 lock held by syz-executor013/7562:
  #0: 00000000d97cb347 (&bdev->bd_fsfreeze_mutex){+.+.}, at:  
mount_bdev+0x93/0x3c0 fs/super.c:1313

=============================================

NMI backtrace for cpu 1
CPU: 1 PID: 1042 Comm: khungtaskd Not tainted 5.1.0-rc6+ #90
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  nmi_cpu_backtrace.cold+0x63/0xa4 lib/nmi_backtrace.c:101
  nmi_trigger_cpumask_backtrace+0x1be/0x236 lib/nmi_backtrace.c:62
  arch_trigger_cpumask_backtrace+0x14/0x20 arch/x86/kernel/apic/hw_nmi.c:38
  trigger_all_cpu_backtrace include/linux/nmi.h:146 [inline]
  check_hung_uninterruptible_tasks kernel/hung_task.c:204 [inline]
  watchdog+0x9b7/0xec0 kernel/hung_task.c:288
  kthread+0x357/0x430 kernel/kthread.c:253
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352
Sending NMI from CPU 1 to CPUs 0:


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
