Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0294878CD31
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Aug 2023 21:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238699AbjH2T4Z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Aug 2023 15:56:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239167AbjH2Tz6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Aug 2023 15:55:58 -0400
Received: from mail-pj1-f80.google.com (mail-pj1-f80.google.com [209.85.216.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45B4DCC0
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Aug 2023 12:55:55 -0700 (PDT)
Received: by mail-pj1-f80.google.com with SMTP id 98e67ed59e1d1-26f49ad3b86so4694725a91.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Aug 2023 12:55:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693338955; x=1693943755;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HC84qNqQEMgT1ZfsoGAGwcyJ1K/TCL9FUPOwtG8+cAA=;
        b=Ruckp0+v5g49/gbM9blOQwAMhMDJfaB7ZzLhipsE37eVC9pO0C+v3dlkTdW712Ttpg
         8ZW2YmQD0eYFTmJSwHUM+LAz3GfXHB5caNuThBt1j/4EjGyTu7gwYEkgeBGpHks9PPYV
         YbaTUaawzNiPY+X8Ptc1NTozFUgGs3YKRBDCtv5bP13F1Dn8KNqKZ1xwKBoZDONPdsdM
         uOcBL2zjo+1ud34sh/JCLmmVEIDtryI/fNctDc7bGS6bWRl7HCUlN06DJKAGPX1pzDmz
         9KGM4NTMPBCkRqq2Zy6T5nQ3nk/nvDXv4Gq2SIxtxgWClb75socMmilC1gWIwZxZ9Jy0
         q3jA==
X-Gm-Message-State: AOJu0YwyJOGVhoIqWTx5GbHmzi7hiwNyEOwAnq0ezpYsouikrUAtUnOV
        vWPLufvWGshWwYU6FW9S9Ijgi9KUPnUCAPoHWT/DDj1eTYp8
X-Google-Smtp-Source: AGHT+IGARoy1wpkyocTBY4c8QJ5HKan+fm1Nl0+ArCAHt2Iqaxha8PdNQmIMx/K20FTd+cE++VXw2O+uTGX1M3Hn00DJOWCdU45E
MIME-Version: 1.0
X-Received: by 2002:a17:90b:1047:b0:26d:14f2:b4e1 with SMTP id
 gq7-20020a17090b104700b0026d14f2b4e1mr50210pjb.8.1693338954764; Tue, 29 Aug
 2023 12:55:54 -0700 (PDT)
Date:   Tue, 29 Aug 2023 12:55:54 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e21aa80604153281@google.com>
Subject: [syzbot] [jfs?] INFO: task hung in jfs_commit_inode (2)
From:   syzbot <syzbot+9157524e62303fd7b21c@syzkaller.appspotmail.com>
To:     jfs-discussion@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        shaggy@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    4f9e7fabf864 Merge tag 'trace-v6.5-rc6' of git://git.kerne..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=14bfc5eba80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1b32f62c755c3a9c
dashboard link: https://syzkaller.appspot.com/bug?extid=9157524e62303fd7b21c
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=101aff5ba80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14d78db0680000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/acffca8b8b8e/disk-4f9e7fab.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/456bbc08eede/vmlinux-4f9e7fab.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c6ea47aa41f8/bzImage-4f9e7fab.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/08b2c3496eff/mount_0.gz

Bisection is inconclusive: the issue happens on the oldest tested release.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17d2b870680000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1432b870680000
console output: https://syzkaller.appspot.com/x/log.txt?x=1032b870680000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9157524e62303fd7b21c@syzkaller.appspotmail.com

INFO: task kworker/u4:3:42 blocked for more than 143 seconds.
      Not tainted 6.5.0-rc7-syzkaller-00104-g4f9e7fabf864 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/u4:3    state:D stack:22416 pid:42    ppid:2      flags:0x00004000
Workqueue: writeback wb_workfn (flush-7:0)
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5381 [inline]
 __schedule+0x1873/0x48f0 kernel/sched/core.c:6710
 schedule+0xc3/0x180 kernel/sched/core.c:6786
 schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:6845
 __mutex_lock_common+0xe33/0x2530 kernel/locking/mutex.c:679
 __mutex_lock kernel/locking/mutex.c:747 [inline]
 mutex_lock_nested+0x1b/0x20 kernel/locking/mutex.c:799
 jfs_commit_inode+0x246/0x580 fs/jfs/inode.c:102
 jfs_write_inode+0x143/0x210 fs/jfs/inode.c:132
 write_inode fs/fs-writeback.c:1456 [inline]
 __writeback_single_inode+0x69b/0xfa0 fs/fs-writeback.c:1668
 writeback_sb_inodes+0x8e3/0x11d0 fs/fs-writeback.c:1894
 __writeback_inodes_wb+0x11b/0x260 fs/fs-writeback.c:1965
 wb_writeback+0x461/0xc60 fs/fs-writeback.c:2072
 wb_check_background_flush fs/fs-writeback.c:2142 [inline]
 wb_do_writeback fs/fs-writeback.c:2230 [inline]
 wb_workfn+0xc6f/0xff0 fs/fs-writeback.c:2257
 process_one_work+0x92c/0x12c0 kernel/workqueue.c:2600
 worker_thread+0xa63/0x1210 kernel/workqueue.c:2751
 kthread+0x2b8/0x350 kernel/kthread.c:389
 ret_from_fork+0x2e/0x60 arch/x86/kernel/process.c:145
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
 </TASK>

Showing all locks held in the system:
1 lock held by rcu_tasks_kthre/13:
 #0: ffffffff8d3295f0 (rcu_tasks.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x29/0xd20 kernel/rcu/tasks.h:522
1 lock held by rcu_tasks_trace/14:
 #0: ffffffff8d3299b0 (rcu_tasks_trace.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x29/0xd20 kernel/rcu/tasks.h:522
1 lock held by khungtaskd/28:
 #0: ffffffff8d329420 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire+0x0/0x30
4 locks held by kworker/u4:3/42:
 #0: ffff888019676938 ((wq_completion)writeback){+.+.}-{0:0}, at: process_one_work+0x7e3/0x12c0 kernel/workqueue.c:2572
 #1: ffffc90000b37d00 ((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0}, at: process_one_work+0x82b/0x12c0 kernel/workqueue.c:2574
 #2: ffff8880796080e0 (&type->s_umount_key#43){.+.+}-{3:3}, at: trylock_super+0x1f/0xf0 fs/super.c:413
 #3: ffff88807866b008 (&jfs_ip->commit_mutex){+.+.}-{3:3}, at: jfs_commit_inode+0x246/0x580 fs/jfs/inode.c:102
2 locks held by getty/4764:
 #0: ffff888029ad2098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc900015c02f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x6b1/0x1dc0 drivers/tty/n_tty.c:2187
4 locks held by syz-executor320/5013:

=============================================

NMI backtrace for cpu 1
CPU: 1 PID: 28 Comm: khungtaskd Not tainted 6.5.0-rc7-syzkaller-00104-g4f9e7fabf864 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 nmi_cpu_backtrace+0x498/0x4d0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x187/0x300 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:160 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:222 [inline]
 watchdog+0xec2/0xf00 kernel/hung_task.c:379
 kthread+0x2b8/0x350 kernel/kthread.c:389
 ret_from_fork+0x2e/0x60 arch/x86/kernel/process.c:145
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
 </TASK>
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 PID: 4457 Comm: klogd Not tainted 6.5.0-rc7-syzkaller-00104-g4f9e7fabf864 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
RIP: 0010:lockdep_hardirqs_on_prepare+0x1a5/0x7a0 kernel/locking/lockdep.c:4363
Code: b1 97 7e 85 c0 0f 85 f4 03 00 00 65 48 8b 05 52 e1 98 7e 48 89 44 24 10 48 8d b8 b8 0a 00 00 48 89 f8 48 c1 e8 03 80 3c 10 00 <74> 0f e8 94 ba 79 00 48 ba 00 00 00 00 00 fc ff df 4c 89 7c 24 18
RSP: 0018:ffffc9000310f720 EFLAGS: 00000046
RAX: 1ffff1100fc4b8c7 RBX: 1ffff92000621eec RCX: ffffffff91fac203
RDX: dffffc0000000000 RSI: ffffffff8b58adc0 RDI: ffff88807e25c638
RBP: ffffc9000310f7d8 R08: ffffffff8e9878ef R09: 1ffffffff1d30f1d
R10: dffffc0000000000 R11: fffffbfff1d30f1e R12: dffffc0000000000
R13: 1ffff1101730799b R14: ffffc9000310f760 R15: 1ffff92000621ee8
FS:  00007f4bdb63b380(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055b621ad0780 CR3: 000000002c5b3000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 trace_hardirqs_on+0x28/0x40 kernel/trace/trace_preemptirq.c:61
 raw_spin_rq_unlock_irq kernel/sched/sched.h:1378 [inline]
 finish_lock_switch+0x93/0x110 kernel/sched/core.c:5133
 finish_task_switch+0x134/0x650 kernel/sched/core.c:5251
 context_switch kernel/sched/core.c:5384 [inline]
 __schedule+0x187b/0x48f0 kernel/sched/core.c:6710
 schedule+0xc3/0x180 kernel/sched/core.c:6786
 syslog_print+0x2a3/0x9b0 kernel/printk/printk.c:1579
 do_syslog+0x505/0x890 kernel/printk/printk.c:1732
 __do_sys_syslog kernel/printk/printk.c:1824 [inline]
 __se_sys_syslog kernel/printk/printk.c:1822 [inline]
 __x64_sys_syslog+0x7c/0x90 kernel/printk/printk.c:1822
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f4bdb79cfa7
Code: 73 01 c3 48 8b 0d 81 ce 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 67 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 51 ce 0c 00 f7 d8 64 89 01 48
RSP: 002b:00007ffe34adaec8 EFLAGS: 00000206 ORIG_RAX: 0000000000000067
RAX: ffffffffffffffda RBX: 00007f4bdb93b4a0 RCX: 00007f4bdb79cfa7
RDX: 00000000000003ff RSI: 00007f4bdb93b4a0 RDI: 0000000000000002
RBP: 0000000000000000 R08: 0000000000000002 R09: 27b8e563ad625ccb
R10: 0000000000004000 R11: 0000000000000206 R12: 00007f4bdb93b4a0
R13: 00007f4bdb92b212 R14: 00007f4bdb93b503 R15: 00007f4bdb93b503
 </TASK>
INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 1.366 msecs


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
