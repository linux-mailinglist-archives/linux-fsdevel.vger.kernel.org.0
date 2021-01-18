Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E0752F9B1B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Jan 2021 09:19:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387666AbhARITA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Jan 2021 03:19:00 -0500
Received: from mail-io1-f72.google.com ([209.85.166.72]:42797 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387644AbhARIS4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Jan 2021 03:18:56 -0500
Received: by mail-io1-f72.google.com with SMTP id k26so20358613ios.9
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Jan 2021 00:18:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=3fjTnf94TVTIh1qTX42tt6bh2yiBBEm3URzXzjU9F0I=;
        b=l3Hdg0f6/DYFrVJ/wwe0BarOj7oorQk5aENupyfHFOgmJTEKten+3KCZR6At7hmtqy
         EwUYMpCKuI7CN2V+yHB1uJDzIE6ZvHhFuDDDPtWLq3mfHBjjMci1lQTMRXOAaZQpV6NE
         qfMLMq5+uZYungxzPZdolwc/A2FiLgNYvoah+L0UFrrs8MZLaHsYtioQpYjS1MjudIsw
         lwRq0Oootu1tAO7y5V1vWNOhFOOL48lWlydF4XD95lCobo+iddzM/cgII6eb+nviyhXZ
         IbG9dq/8XCMgjcvL0na/XwrtgbHUU1N4Wy7Tsc0IYJFqvRV4r2SY2LmvQtvY2efB9X3j
         FyRw==
X-Gm-Message-State: AOAM531bAF7xZqetyvURN3zArFLryL7aN7XhDZVgkEg6Su+pfRTK8iyv
        soIjZzIt77poaBRFmrQG6XqRPMTnTYUVmbUgSj59sUvkZJzy
X-Google-Smtp-Source: ABdhPJz04KkF4BBpC/qfd3bH7vxgE5cJtlVDZ1xOiLVJM66tL/NUw+nue76GztvR3na3zJUFL93aRROhN8cmmTNyozinyWB6RkcH
MIME-Version: 1.0
X-Received: by 2002:a02:3843:: with SMTP id v3mr6046154jae.70.1610957894879;
 Mon, 18 Jan 2021 00:18:14 -0800 (PST)
Date:   Mon, 18 Jan 2021 00:18:14 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000128d3805b9285d54@google.com>
Subject: INFO: task hung in freeze_super
From:   syzbot <syzbot+e45cf80926482af211a0@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    b3a3cbde Add linux-next specific files for 20210115
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1290cb3f500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6ea08dae6aab586f
dashboard link: https://syzkaller.appspot.com/bug?extid=e45cf80926482af211a0
compiler:       gcc (GCC) 10.1.0-syz 20200507

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e45cf80926482af211a0@syzkaller.appspotmail.com

INFO: task kworker/0:1H:3061 blocked for more than 143 seconds.
      Not tainted 5.11.0-rc3-next-20210115-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/0:1H    state:D stack:27904 pid: 3061 ppid:     2 flags:0x00004000
Workqueue: glock_workqueue glock_work_func
Call Trace:
 context_switch kernel/sched/core.c:4373 [inline]
 __schedule+0x90c/0x21a0 kernel/sched/core.c:5124
 schedule+0xcf/0x270 kernel/sched/core.c:5203
 rwsem_down_write_slowpath+0x7e5/0x1200 kernel/locking/rwsem.c:1106
 __down_write_common kernel/locking/rwsem.c:1261 [inline]
 __down_write_common kernel/locking/rwsem.c:1258 [inline]
 __down_write kernel/locking/rwsem.c:1270 [inline]
 down_write+0x132/0x150 kernel/locking/rwsem.c:1407
 freeze_super+0x41/0x330 fs/super.c:1663
 freeze_go_sync+0x1e2/0x330 fs/gfs2/glops.c:588
 do_xmote+0x2ff/0xbc0 fs/gfs2/glock.c:616
 run_queue+0x323/0x680 fs/gfs2/glock.c:753
 glock_work_func+0xff/0x3f0 fs/gfs2/glock.c:920
 process_one_work+0x98d/0x15f0 kernel/workqueue.c:2275
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2421
 kthread+0x3b1/0x4a0 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296
INFO: task syz-executor.1:24203 can't die for more than 143 seconds.
task:syz-executor.1  state:D stack:25656 pid:24203 ppid: 23040 flags:0x00004004
Call Trace:
 context_switch kernel/sched/core.c:4373 [inline]
 __schedule+0x90c/0x21a0 kernel/sched/core.c:5124
 schedule+0xcf/0x270 kernel/sched/core.c:5203
 schedule_timeout+0x1d8/0x250 kernel/time/timer.c:1868
 do_wait_for_common kernel/sched/completion.c:85 [inline]
 __wait_for_common kernel/sched/completion.c:106 [inline]
 wait_for_common kernel/sched/completion.c:117 [inline]
 wait_for_completion+0x163/0x260 kernel/sched/completion.c:138
 flush_workqueue+0x3ff/0x13e0 kernel/workqueue.c:2838
 gfs2_gl_hash_clear+0xc8/0x270 fs/gfs2/glock.c:1984
 gfs2_fill_super+0x2073/0x2720 fs/gfs2/ops_fstype.c:1231
 get_tree_bdev+0x440/0x760 fs/super.c:1291
 gfs2_get_tree+0x4a/0x270 fs/gfs2/ops_fstype.c:1254
 vfs_get_tree+0x89/0x2f0 fs/super.c:1496
 do_new_mount fs/namespace.c:2889 [inline]
 path_mount+0x12ae/0x1e70 fs/namespace.c:3220
 do_mount fs/namespace.c:3233 [inline]
 __do_sys_mount fs/namespace.c:3441 [inline]
 __se_sys_mount fs/namespace.c:3418 [inline]
 __x64_sys_mount+0x27f/0x300 fs/namespace.c:3418
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x460c6a
RSP: 002b:00007f8f38606a78 EFLAGS: 00000202 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f8f38606b10 RCX: 0000000000460c6a
RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007f8f38606ad0
RBP: 00007f8f38606ad0 R08: 00007f8f38606b10 R09: 0000000020000000
R10: 0000000000000000 R11: 0000000000000202 R12: 0000000020000000
R13: 0000000020000100 R14: 0000000020000200 R15: 0000000020047a20
INFO: task syz-executor.1:24203 blocked for more than 143 seconds.
      Not tainted 5.11.0-rc3-next-20210115-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.1  state:D stack:25656 pid:24203 ppid: 23040 flags:0x00004004
Call Trace:
 context_switch kernel/sched/core.c:4373 [inline]
 __schedule+0x90c/0x21a0 kernel/sched/core.c:5124
 schedule+0xcf/0x270 kernel/sched/core.c:5203
 schedule_timeout+0x1d8/0x250 kernel/time/timer.c:1868
 do_wait_for_common kernel/sched/completion.c:85 [inline]
 __wait_for_common kernel/sched/completion.c:106 [inline]
 wait_for_common kernel/sched/completion.c:117 [inline]
 wait_for_completion+0x163/0x260 kernel/sched/completion.c:138
 flush_workqueue+0x3ff/0x13e0 kernel/workqueue.c:2838
 gfs2_gl_hash_clear+0xc8/0x270 fs/gfs2/glock.c:1984
 gfs2_fill_super+0x2073/0x2720 fs/gfs2/ops_fstype.c:1231
 get_tree_bdev+0x440/0x760 fs/super.c:1291
 gfs2_get_tree+0x4a/0x270 fs/gfs2/ops_fstype.c:1254
 vfs_get_tree+0x89/0x2f0 fs/super.c:1496
 do_new_mount fs/namespace.c:2889 [inline]
 path_mount+0x12ae/0x1e70 fs/namespace.c:3220
 do_mount fs/namespace.c:3233 [inline]
 __do_sys_mount fs/namespace.c:3441 [inline]
 __se_sys_mount fs/namespace.c:3418 [inline]
 __x64_sys_mount+0x27f/0x300 fs/namespace.c:3418
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x460c6a
RSP: 002b:00007f8f38606a78 EFLAGS: 00000202 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f8f38606b10 RCX: 0000000000460c6a
RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007f8f38606ad0
RBP: 00007f8f38606ad0 R08: 00007f8f38606b10 R09: 0000000020000000
R10: 0000000000000000 R11: 0000000000000202 R12: 0000000020000000
R13: 0000000020000100 R14: 0000000020000200 R15: 0000000020047a20

Showing all locks held in the system:
1 lock held by khungtaskd/1662:
 #0: ffffffff8b370ee0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x53/0x260 kernel/locking/lockdep.c:6259
3 locks held by kworker/0:1H/3061:
 #0: ffff888142ecf538 ((wq_completion)glock_workqueue){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff888142ecf538 ((wq_completion)glock_workqueue){+.+.}-{0:0}, at: atomic64_set include/asm-generic/atomic-instrumented.h:856 [inline]
 #0: ffff888142ecf538 ((wq_completion)glock_workqueue){+.+.}-{0:0}, at: atomic_long_set include/asm-generic/atomic-long.h:41 [inline]
 #0: ffff888142ecf538 ((wq_completion)glock_workqueue){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:616 [inline]
 #0: ffff888142ecf538 ((wq_completion)glock_workqueue){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:643 [inline]
 #0: ffff888142ecf538 ((wq_completion)glock_workqueue){+.+.}-{0:0}, at: process_one_work+0x871/0x15f0 kernel/workqueue.c:2246
 #1: ffffc90001edfda8 ((work_completion)(&(&gl->gl_work)->work)){+.+.}-{0:0}, at: process_one_work+0x8a5/0x15f0 kernel/workqueue.c:2250
 #2: ffff8880718c60e0 (&type->s_umount_key#82){+.+.}-{3:3}, at: freeze_super+0x41/0x330 fs/super.c:1663
1 lock held by in:imklog/8137:
 #0: ffff88801813d270 (&f->f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0xe9/0x100 fs/file.c:947
2 locks held by agetty/8141:
 #0: ffff888019119098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:266
 #1: ffffc90000f292e8 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x21d/0x1aa0 drivers/tty/n_tty.c:2160
2 locks held by syz-executor.5/11026:
 #0: ffff88806d6b6098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:266
 #1: ffffc900092fb2e8 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x21d/0x1aa0 drivers/tty/n_tty.c:2160
2 locks held by syz-executor.5/11065:
 #0: ffff88806bc46098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:266
 #1: ffffc90009b352e8 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x21d/0x1aa0 drivers/tty/n_tty.c:2160
2 locks held by syz-executor.5/11122:
 #0: ffff88806f7e7098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:266
 #1: ffffc90009d232e8 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x21d/0x1aa0 drivers/tty/n_tty.c:2160
2 locks held by syz-executor.5/11177:
 #0: ffff88806fc18098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:266
 #1: ffffc900010ca2e8 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x21d/0x1aa0 drivers/tty/n_tty.c:2160
1 lock held by syz-executor.1/24203:
 #0: ffff8880718c60e0 (&type->s_umount_key#81/1){+.+.}-{3:3}, at: alloc_super+0x201/0xaf0 fs/super.c:229

=============================================

NMI backtrace for cpu 0
CPU: 0 PID: 1662 Comm: khungtaskd Not tainted 5.11.0-rc3-next-20210115-syzkaller #0
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
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 PID: 4866 Comm: systemd-journal Not tainted 5.11.0-rc3-next-20210115-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:native_restore_fl arch/x86/include/asm/irqflags.h:41 [inline]
RIP: 0010:arch_local_irq_restore arch/x86/include/asm/irqflags.h:84 [inline]
RIP: 0010:lock_is_held_type+0xe7/0x120 kernel/locking/lockdep.c:5483
Code: e0 03 44 39 f0 41 0f 94 c5 48 c7 c7 a0 96 4b 89 e8 ce 0c 00 00 b8 ff ff ff ff 65 0f c1 05 e1 bc 06 77 83 f8 01 75 1b ff 34 24 <9d> 48 83 c4 08 44 89 e8 5b 5d 41 5c 41 5d 41 5e 41 5f c3 45 31 ed
RSP: 0018:ffffc9000160fec0 EFLAGS: 00000046
RAX: 0000000000000001 RBX: 0000000000000000 RCX: 0000000000000001
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffffffff8b370e20 R08: 0000000000000000 R09: 0000000000000000
R10: ffffffff8178e0b5 R11: 0000000000000000 R12: ffff88801170b800
R13: 0000000000000000 R14: 00000000ffffffff R15: 0000000000000000
FS:  00007fdfb845b8c0(0000) GS:ffff8880b9f00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fdfb5904000 CR3: 0000000026029000 CR4: 00000000001526e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 lock_is_held include/linux/lockdep.h:271 [inline]
 rcu_read_lock_sched_held+0x3a/0x70 kernel/rcu/update.c:125
 trace_irq_disable include/trace/events/preemptirq.h:36 [inline]
 trace_hardirqs_off_finish kernel/trace/trace_preemptirq.c:67 [inline]
 trace_hardirqs_off_finish+0x224/0x270 kernel/trace/trace_preemptirq.c:61
 __enter_from_user_mode kernel/entry/common.c:25 [inline]
 syscall_enter_from_user_mode+0x18/0x50 kernel/entry/common.c:106
 do_syscall_64+0xf/0x70 arch/x86/entry/common.c:41
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x7fdfb77179c7
Code: 83 c4 08 48 3d 01 f0 ff ff 73 01 c3 48 8b 0d c8 d4 2b 00 f7 d8 64 89 01 48 83 c8 ff c3 66 0f 1f 44 00 00 b8 15 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d a1 d4 2b 00 f7 d8 64 89 01 48
RSP: 002b:00007fffdb006028 EFLAGS: 00000246 ORIG_RAX: 0000000000000015
RAX: ffffffffffffffda RBX: 00007fffdb008f40 RCX: 00007fdfb77179c7
RDX: 00007fdfb8188a00 RSI: 0000000000000000 RDI: 000055ae1d4fc9a3
RBP: 00007fffdb006060 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000069 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fffdb008f40 R15: 00007fffdb006550


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
