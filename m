Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A3547BF8C4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Oct 2023 12:37:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbjJJKhD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Oct 2023 06:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbjJJKhC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Oct 2023 06:37:02 -0400
Received: from mail-ot1-f80.google.com (mail-ot1-f80.google.com [209.85.210.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B9E0AF
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Oct 2023 03:37:00 -0700 (PDT)
Received: by mail-ot1-f80.google.com with SMTP id 46e09a7af769-6c4ecdd6dc9so6370170a34.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Oct 2023 03:37:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696934219; x=1697539019;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0F1Pv6GO/TmZHvoMO6mcODtZLDhuap16XylfHcDc8yo=;
        b=J7jxbg13c/W9dZDLJ9IDCrr8tm3/cfdKm+y1qpbqp1DVRwT21SiAyhcf6mDpi7DMJK
         XEuW7HrCsFjgpM6Lo0VDp0nglPiD3z9Vaj3KjkDcJTpkiBDHQHQ6ziGSvGgtvz2hcir/
         bbAVlMoIcjh5Pb4gzW4Q94OVzZkzsvqzbq0Tnlyg24r++yh2h5JV3yQjK/Kr7DHoy/Q6
         /BDL4WJkVhI/Al9oiyt4mUVirHwMb4Xs6HXWGRDKHarWBi7N156OaloikMW4rTGWh1Ay
         oAUn8s1tGN5zHqsjSohGkHg3kOD0mWFXhvdVCHYnycddfK43LkM5kT92cDEFY59uf0Rf
         mYjA==
X-Gm-Message-State: AOJu0Yz6eTAybqj5A1GMvYRzzmQxQLF9oDff/PIb6w6Ynec8G5DZAYqK
        qz/ECi/I25bperiGY4vP+ctHJjb3Znr75AiOfeAvFL48c5r8
X-Google-Smtp-Source: AGHT+IHBmFer2u0U5ow4Jd4jLlzxKe+ZWG8A0KqXZhR6hCMg8HiS087qInDNSpPRkm+kqaOSYVnPSFlwamNms0GyY4ZrPAjzRLRh
MIME-Version: 1.0
X-Received: by 2002:a9d:69ca:0:b0:6bd:909:eb1a with SMTP id
 v10-20020a9d69ca000000b006bd0909eb1amr5842671oto.3.1696934219710; Tue, 10 Oct
 2023 03:36:59 -0700 (PDT)
Date:   Tue, 10 Oct 2023 03:36:59 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005f876b06075a4936@google.com>
Subject: [syzbot] [jfs?] INFO: task hung in lmLogClose (2)
From:   syzbot <syzbot+cf96fe0f87933d5cd68a@syzkaller.appspotmail.com>
To:     jfs-discussion@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        shaggy@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    b78b18fb8ee1 Merge tag 'erofs-for-6.6-rc5-fixes' of git://..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=122fb2c9680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7a5682d32a74b423
dashboard link: https://syzkaller.appspot.com/bug?extid=cf96fe0f87933d5cd68a
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=120a1c45680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1230440e680000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f88dc91eda37/disk-b78b18fb.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/44466bc55ac9/vmlinux-b78b18fb.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3dbfc0fc8b16/bzImage-b78b18fb.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/18dd05ef2068/mount_0.gz

Bisection is inconclusive: the issue happens on the oldest tested release.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14a27dc9680000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=16a27dc9680000
console output: https://syzkaller.appspot.com/x/log.txt?x=12a27dc9680000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+cf96fe0f87933d5cd68a@syzkaller.appspotmail.com

INFO: task syz-executor137:5040 blocked for more than 143 seconds.
      Not tainted 6.6.0-rc4-syzkaller-00176-gb78b18fb8ee1 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor137 state:D stack:25704 pid:5040  ppid:5037   flags:0x00004002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5382 [inline]
 __schedule+0x196c/0x4af0 kernel/sched/core.c:6695
 schedule+0xc3/0x180 kernel/sched/core.c:6771
 schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:6830
 __mutex_lock_common kernel/locking/mutex.c:679 [inline]
 __mutex_lock+0x6a3/0xd60 kernel/locking/mutex.c:747
 lmLogClose+0xb2/0x530 fs/jfs/jfs_logmgr.c:1444
 jfs_umount+0x2ce/0x3a0 fs/jfs/jfs_umount.c:114
 jfs_put_super+0x8a/0x190 fs/jfs/super.c:194
 generic_shutdown_super+0x13a/0x2c0 fs/super.c:693
 kill_block_super+0x41/0x70 fs/super.c:1646
 deactivate_locked_super+0xa4/0x110 fs/super.c:481
 cleanup_mnt+0x426/0x4c0 fs/namespace.c:1254
 task_work_run+0x24a/0x300 kernel/task_work.c:180
 ptrace_notify+0x2cd/0x380 kernel/signal.c:2387
 ptrace_report_syscall include/linux/ptrace.h:411 [inline]
 ptrace_report_syscall_exit include/linux/ptrace.h:473 [inline]
 syscall_exit_work kernel/entry/common.c:251 [inline]
 syscall_exit_to_user_mode_prepare kernel/entry/common.c:278 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:283 [inline]
 syscall_exit_to_user_mode+0x15c/0x280 kernel/entry/common.c:296
 do_syscall_64+0x4d/0xc0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f51106f42e7
RSP: 002b:00007ffe52a783c8 EFLAGS: 00000202 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f51106f42e7
RDX: 0000000000000000 RSI: 000000000000000a RDI: 00007ffe52a78480
RBP: 00007ffe52a78480 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000202 R12: 00007ffe52a794f0
R13: 0000555555b7b6c0 R14: 431bde82d7b634db R15: 00007ffe52a79510
 </TASK>
INFO: task syz-executor137:5041 blocked for more than 143 seconds.
      Not tainted 6.6.0-rc4-syzkaller-00176-gb78b18fb8ee1 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor137 state:D stack:26024 pid:5041  ppid:5037   flags:0x00004002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5382 [inline]
 __schedule+0x196c/0x4af0 kernel/sched/core.c:6695
 schedule+0xc3/0x180 kernel/sched/core.c:6771
 schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:6830
 __mutex_lock_common kernel/locking/mutex.c:679 [inline]
 __mutex_lock+0x6a3/0xd60 kernel/locking/mutex.c:747
 lmLogClose+0xb2/0x530 fs/jfs/jfs_logmgr.c:1444
 jfs_umount+0x2ce/0x3a0 fs/jfs/jfs_umount.c:114
 jfs_put_super+0x8a/0x190 fs/jfs/super.c:194
 generic_shutdown_super+0x13a/0x2c0 fs/super.c:693
 kill_block_super+0x41/0x70 fs/super.c:1646
 deactivate_locked_super+0xa4/0x110 fs/super.c:481
 cleanup_mnt+0x426/0x4c0 fs/namespace.c:1254
 task_work_run+0x24a/0x300 kernel/task_work.c:180
 ptrace_notify+0x2cd/0x380 kernel/signal.c:2387
 ptrace_report_syscall include/linux/ptrace.h:411 [inline]
 ptrace_report_syscall_exit include/linux/ptrace.h:473 [inline]
 syscall_exit_work kernel/entry/common.c:251 [inline]
 syscall_exit_to_user_mode_prepare kernel/entry/common.c:278 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:283 [inline]
 syscall_exit_to_user_mode+0x15c/0x280 kernel/entry/common.c:296
 do_syscall_64+0x4d/0xc0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f51106f42e7
RSP: 002b:00007ffe52a783c8 EFLAGS: 00000202 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f51106f42e7
RDX: 0000000000000000 RSI: 000000000000000a RDI: 00007ffe52a78480
RBP: 00007ffe52a78480 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000202 R12: 00007ffe52a794f0
R13: 0000555555b7b6c0 R14: 431bde82d7b634db R15: 00007ffe52a79510
 </TASK>
INFO: task syz-executor137:5042 blocked for more than 143 seconds.
      Not tainted 6.6.0-rc4-syzkaller-00176-gb78b18fb8ee1 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor137 state:D stack:25840 pid:5042  ppid:5037   flags:0x00004002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5382 [inline]
 __schedule+0x196c/0x4af0 kernel/sched/core.c:6695
 schedule+0xc3/0x180 kernel/sched/core.c:6771
 schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:6830
 __mutex_lock_common kernel/locking/mutex.c:679 [inline]
 __mutex_lock+0x6a3/0xd60 kernel/locking/mutex.c:747
 lmLogClose+0xb2/0x530 fs/jfs/jfs_logmgr.c:1444
 jfs_umount+0x2ce/0x3a0 fs/jfs/jfs_umount.c:114
 jfs_put_super+0x8a/0x190 fs/jfs/super.c:194
 generic_shutdown_super+0x13a/0x2c0 fs/super.c:693
 kill_block_super+0x41/0x70 fs/super.c:1646
 deactivate_locked_super+0xa4/0x110 fs/super.c:481
 cleanup_mnt+0x426/0x4c0 fs/namespace.c:1254
 task_work_run+0x24a/0x300 kernel/task_work.c:180
 ptrace_notify+0x2cd/0x380 kernel/signal.c:2387
 ptrace_report_syscall include/linux/ptrace.h:411 [inline]
 ptrace_report_syscall_exit include/linux/ptrace.h:473 [inline]
 syscall_exit_work kernel/entry/common.c:251 [inline]
 syscall_exit_to_user_mode_prepare kernel/entry/common.c:278 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:283 [inline]
 syscall_exit_to_user_mode+0x15c/0x280 kernel/entry/common.c:296
 do_syscall_64+0x4d/0xc0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f51106f42e7
RSP: 002b:00007ffe52a783c8 EFLAGS: 00000202 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f51106f42e7
RDX: 0000000000000000 RSI: 000000000000000a RDI: 00007ffe52a78480
RBP: 00007ffe52a78480 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000202 R12: 00007ffe52a794f0
R13: 0000555555b7b6c0 R14: 431bde82d7b634db R15: 00007ffe52a79510
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/29:
 #0: ffffffff8d32c420 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:303 [inline]
 #0: ffffffff8d32c420 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:749 [inline]
 #0: ffffffff8d32c420 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x55/0x2a0 kernel/locking/lockdep.c:6613
2 locks held by getty/4789:
 #0: ffff88802ad5a0a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc90002f062f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x6b1/0x1dc0 drivers/tty/n_tty.c:2206
2 locks held by syz-executor137/5038:
 #0: ffff8880218260e0 (&type->s_umount_key#46){+.+.}-{3:3}, at: __super_lock fs/super.c:56 [inline]
 #0: ffff8880218260e0 (&type->s_umount_key#46){+.+.}-{3:3}, at: __super_lock_excl fs/super.c:71 [inline]
 #0: ffff8880218260e0 (&type->s_umount_key#46){+.+.}-{3:3}, at: deactivate_super+0xad/0xf0 fs/super.c:513
 #1: ffffffff8d71f3e8 (jfs_log_mutex){+.+.}-{3:3}, at: lmLogClose+0xb2/0x530 fs/jfs/jfs_logmgr.c:1444
2 locks held by syz-executor137/5039:
 #0: ffff8880251140e0 (&type->s_umount_key#46){+.+.}-{3:3}, at: __super_lock fs/super.c:56 [inline]
 #0: ffff8880251140e0 (&type->s_umount_key#46){+.+.}-{3:3}, at: __super_lock_excl fs/super.c:71 [inline]
 #0: ffff8880251140e0 (&type->s_umount_key#46){+.+.}-{3:3}, at: deactivate_super+0xad/0xf0 fs/super.c:513
 #1: ffffffff8d71f3e8 (jfs_log_mutex){+.+.}-{3:3}, at: lmLogClose+0xb2/0x530 fs/jfs/jfs_logmgr.c:1444
2 locks held by syz-executor137/5040:
 #0: ffff88807eaa80e0 (&type->s_umount_key#46){+.+.}-{3:3}, at: __super_lock fs/super.c:56 [inline]
 #0: ffff88807eaa80e0 (&type->s_umount_key#46){+.+.}-{3:3}, at: __super_lock_excl fs/super.c:71 [inline]
 #0: ffff88807eaa80e0 (&type->s_umount_key#46){+.+.}-{3:3}, at: deactivate_super+0xad/0xf0 fs/super.c:513
 #1: ffffffff8d71f3e8 (jfs_log_mutex){+.+.}-{3:3}, at: lmLogClose+0xb2/0x530 fs/jfs/jfs_logmgr.c:1444
2 locks held by syz-executor137/5041:
 #0: ffff88807ae940e0 (&type->s_umount_key#46){+.+.}-{3:3}, at: __super_lock fs/super.c:56 [inline]
 #0: ffff88807ae940e0 (&type->s_umount_key#46){+.+.}-{3:3}, at: __super_lock_excl fs/super.c:71 [inline]
 #0: ffff88807ae940e0 (&type->s_umount_key#46){+.+.}-{3:3}, at: deactivate_super+0xad/0xf0 fs/super.c:513
 #1: ffffffff8d71f3e8 (jfs_log_mutex){+.+.}-{3:3}, at: lmLogClose+0xb2/0x530 fs/jfs/jfs_logmgr.c:1444
2 locks held by syz-executor137/5042:
 #0: ffff88802164a0e0 (&type->s_umount_key#46){+.+.}-{3:3}, at: __super_lock fs/super.c:56 [inline]
 #0: ffff88802164a0e0 (&type->s_umount_key#46){+.+.}-{3:3}, at: __super_lock_excl fs/super.c:71 [inline]
 #0: ffff88802164a0e0 (&type->s_umount_key#46){+.+.}-{3:3}, at: deactivate_super+0xad/0xf0 fs/super.c:513
 #1: ffffffff8d71f3e8 (jfs_log_mutex){+.+.}-{3:3}, at: lmLogClose+0xb2/0x530 fs/jfs/jfs_logmgr.c:1444
1 lock held by syz-executor137/5043:
 #0: ffff88807a8be0e0 (&type->s_umount_key#46){+.+.}-{3:3}, at: __super_lock fs/super.c:56 [inline]
 #0: ffff88807a8be0e0 (&type->s_umount_key#46){+.+.}-{3:3}, at: __super_lock_excl fs/super.c:71 [inline]
 #0: ffff88807a8be0e0 (&type->s_umount_key#46){+.+.}-{3:3}, at: deactivate_super+0xad/0xf0 fs/super.c:513

=============================================

NMI backtrace for cpu 0
CPU: 0 PID: 29 Comm: khungtaskd Not tainted 6.6.0-rc4-syzkaller-00176-gb78b18fb8ee1 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/06/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 nmi_cpu_backtrace+0x498/0x4d0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x198/0x310 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:160 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:222 [inline]
 watchdog+0xfa9/0xff0 kernel/hung_task.c:379
 kthread+0x2d3/0x370 kernel/kthread.c:388
 ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 PID: 2850 Comm: kworker/u4:12 Not tainted 6.6.0-rc4-syzkaller-00176-gb78b18fb8ee1 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/06/2023
Workqueue: events_unbound toggle_allocation_gate
RIP: 0010:update_min_vruntime kernel/sched/fair.c:782 [inline]
RIP: 0010:dequeue_entity+0xbaf/0x16d0 kernel/sched/fair.c:5157
Code: 00 48 29 5d 00 4d 89 ef 48 8b 6c 24 28 48 b8 00 00 00 00 00 fc ff df 48 8b 4c 24 50 80 3c 01 00 74 08 48 89 ef e8 c1 b2 82 00 <4c> 89 7d 00 48 8b 6c 24 30 48 b8 00 00 00 00 00 fc ff df 48 8b 4c
RSP: 0018:ffffc9000b58f698 EFLAGS: 00000046
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 1ffff1101732787f
RDX: ffff88802795bc38 RSI: 0000000000000001 RDI: ffff88802795bc40
RBP: ffff8880b993c3f8 R08: ffffffff814047f3 R09: 1ffffffff1d34ff5
R10: dffffc0000000000 R11: fffffbfff1d34ff6 R12: 0000000000000000
R13: 00000006a746e4b9 R14: ffff8880b993c3c0 R15: 00000006a746e4b9
FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000056329bdad600 CR3: 000000000d130000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 dequeue_task_fair+0x27a/0x1400 kernel/sched/fair.c:6559
 deactivate_task kernel/sched/core.c:2141 [inline]
 __schedule+0x614/0x4af0 kernel/sched/core.c:6649
 schedule+0xc3/0x180 kernel/sched/core.c:6771
 toggle_allocation_gate+0x16a/0x250 mm/kfence/core.c:832
 process_one_work kernel/workqueue.c:2630 [inline]
 process_scheduled_works+0x90f/0x1400 kernel/workqueue.c:2703
 worker_thread+0xa5f/0xff0 kernel/workqueue.c:2784
 kthread+0x2d3/0x370 kernel/kthread.c:388
 ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
