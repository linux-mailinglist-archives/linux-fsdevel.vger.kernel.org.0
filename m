Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE22B7572A0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jul 2023 06:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbjGREAW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Jul 2023 00:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjGREAU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Jul 2023 00:00:20 -0400
Received: from mail-oo1-f77.google.com (mail-oo1-f77.google.com [209.85.161.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B893F10EB
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Jul 2023 21:00:14 -0700 (PDT)
Received: by mail-oo1-f77.google.com with SMTP id 006d021491bc7-563668b61e5so7549362eaf.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Jul 2023 21:00:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689652814; x=1692244814;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lP5+goy9pCxJ5sdWVBn6QMjehXDutBtDM461BKOsH4Q=;
        b=mDPhcbEyW2FevmpDKvZmRSlBCvFMq1IMDZXu+CLPZ5hrlQo3uRyYc9cCd7GGVexfMz
         8iC8ffwr/trLqRLDyYOc76KUSK8uOnlIitGNcYiHgspkvTwMRr7zPigxvvhwi1ZrVXIC
         /yDBONBz4/dz9sAFK1cowGTKuShWIa8GwQQGPf6XFGQdYvWUhw4sBKuOHlxmbaJs3EQb
         2+kLGxPyYMXjqhixlriqwzzYLTX6TQQIkXchUktfOXCVPVS2l6nOkMLJ6cVRLJ+EUYEx
         rfF++gfnj/RCfhY3XWB/h0mUCSS/bCmagiaOLqmcBmd3p2aPZdhFe4mrMbGIryzYju2S
         csXQ==
X-Gm-Message-State: ABy/qLbrz2uCYJ2DZfY8mjgUb2PBzcUF90rydF0tYrUzFcTd+txjGjuU
        FVGH1ExoxfhMCUzQ9UKaKsI9Ai82ZYNlCMRb3X/E/HgQ/0UY
X-Google-Smtp-Source: APBJJlEnh0acS0e8ryzsJVDfdowyHEZgH/0C91/Kn+GMDRUvXpzqdtBF9YNIHKw7d+TzrCaPotNeT29CdsgATj3gZlOvfPPHjgNR
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1529:b0:3a4:1265:312d with SMTP id
 u41-20020a056808152900b003a41265312dmr20705746oiw.5.1689652813980; Mon, 17
 Jul 2023 21:00:13 -0700 (PDT)
Date:   Mon, 17 Jul 2023 21:00:13 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c56a310600baf342@google.com>
Subject: [syzbot] [ext4?] INFO: task hung in sync_inodes_sb (5)
From:   syzbot <syzbot+30476ec1b6dc84471133@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    eb26cbb1a754 Merge tag 'platform-drivers-x86-v6.5-2' of gi..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=11ada364a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6d0f369ef5fb88c9
dashboard link: https://syzkaller.appspot.com/bug?extid=30476ec1b6dc84471133
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=132aa6daa80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10994a82a80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/047c8ae8d831/disk-eb26cbb1.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/94a0f439a3f2/vmlinux-eb26cbb1.xz
kernel image: https://storage.googleapis.com/syzbot-assets/57025348c668/bzImage-eb26cbb1.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/787828bdc769/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+30476ec1b6dc84471133@syzkaller.appspotmail.com

INFO: task syz-executor386:5013 blocked for more than 143 seconds.
      Not tainted 6.5.0-rc1-syzkaller-00033-geb26cbb1a754 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor386 state:D stack:24968 pid:5013  ppid:5010   flags:0x00004002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5381 [inline]
 __schedule+0x1873/0x48f0 kernel/sched/core.c:6710
 schedule+0xc3/0x180 kernel/sched/core.c:6786
 wb_wait_for_completion+0x166/0x290 fs/fs-writeback.c:192
 sync_inodes_sb+0x297/0xab0 fs/fs-writeback.c:2736
 sync_filesystem+0x16f/0x220 fs/sync.c:64
 generic_shutdown_super+0x6f/0x340 fs/super.c:472
 kill_block_super+0x68/0xa0 fs/super.c:1417
 deactivate_locked_super+0xa4/0x110 fs/super.c:330
 cleanup_mnt+0x426/0x4c0 fs/namespace.c:1254
 task_work_run+0x24a/0x300 kernel/task_work.c:179
 ptrace_notify+0x2cd/0x380 kernel/signal.c:2372
 ptrace_report_syscall include/linux/ptrace.h:411 [inline]
 ptrace_report_syscall_exit include/linux/ptrace.h:473 [inline]
 syscall_exit_work kernel/entry/common.c:252 [inline]
 syscall_exit_to_user_mode_prepare kernel/entry/common.c:279 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:284 [inline]
 syscall_exit_to_user_mode+0x157/0x280 kernel/entry/common.c:297
 do_syscall_64+0x4d/0xc0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fe49933f507
RSP: 002b:00007ffc0fbd7288 EFLAGS: 00000206 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007fe49933f507
RDX: 0000000000000000 RSI: 000000000000000a RDI: 00007ffc0fbd7340
RBP: 00007ffc0fbd7340 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000206 R12: 00007ffc0fbd83b0
R13: 0000555555f596c0 R14: 431bde82d7b634db R15: 00007ffc0fbd83d0
 </TASK>

Showing all locks held in the system:
1 lock held by rcu_tasks_kthre/13:
 #0: ffffffff8d328af0 (rcu_tasks.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x29/0xd20 kernel/rcu/tasks.h:522
1 lock held by rcu_tasks_trace/14:
 #0: ffffffff8d328eb0 (rcu_tasks_trace.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x29/0xd20 kernel/rcu/tasks.h:522
1 lock held by khungtaskd/28:
 #0: ffffffff8d328920 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire+0x0/0x30
4 locks held by kworker/u4:2/41:
 #0: ffff8880128ee938 ((wq_completion)writeback){+.+.}-{0:0}, at: process_one_work+0x7e3/0x12c0 kernel/workqueue.c:2569
 #1: ffffc90000b27d20 ((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0}, at: process_one_work+0x82b/0x12c0 kernel/workqueue.c:2571
 #2: ffff88807c094bd8 (&sbi->s_writepages_rwsem){.+.+}-{0:0}, at: ext4_writepages_down_read fs/ext4/ext4.h:1750 [inline]
 #2: ffff88807c094bd8 (&sbi->s_writepages_rwsem){.+.+}-{0:0}, at: ext4_writepages+0x1bd/0x3e0 fs/ext4/inode.c:2765
 #3: ffff888076550288 (&ei->i_data_sem){++++}-{3:3}, at: ext4_map_blocks+0x959/0x1cb0 fs/ext4/inode.c:614
2 locks held by getty/4765:
 #0: ffff8880298dc098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc900015902f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x6b1/0x1dc0 drivers/tty/n_tty.c:2187
2 locks held by syz-executor386/5013:
 #0: ffff88807c0960e0 (&type->s_umount_key#30){++++}-{3:3}, at: deactivate_super+0xad/0xf0 fs/super.c:360
 #1: ffff88801fed27d0 (&bdi->wb_switch_rwsem){+.+.}-{3:3}, at: bdi_down_write_wb_switch_rwsem fs/fs-writeback.c:364 [inline]
 #1: ffff88801fed27d0 (&bdi->wb_switch_rwsem){+.+.}-{3:3}, at: sync_inodes_sb+0x278/0xab0 fs/fs-writeback.c:2734

=============================================

NMI backtrace for cpu 1
CPU: 1 PID: 28 Comm: khungtaskd Not tainted 6.5.0-rc1-syzkaller-00033-geb26cbb1a754 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/03/2023
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
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 PID: 47 Comm: kworker/u4:3 Not tainted 6.5.0-rc1-syzkaller-00033-geb26cbb1a754 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/03/2023
Workqueue: events_unbound toggle_allocation_gate
RIP: 0010:update_sd_lb_stats kernel/sched/fair.c:10176 [inline]
RIP: 0010:find_busiest_group kernel/sched/fair.c:10428 [inline]
RIP: 0010:load_balance+0x1d30/0x8170 kernel/sched/fair.c:10838
Code: 00 00 44 89 3b 4c 8b bc 24 50 01 00 00 80 bc 24 a7 00 00 00 00 0f 84 59 01 00 00 48 8b 9c 24 c0 00 00 00 48 89 d8 48 c1 e8 03 <48> b9 00 00 00 00 00 fc ff df 80 3c 08 00 74 08 48 89 df e8 68 da
RSP: 0018:ffffc90000b87080 EFLAGS: 00000802
RAX: 1ffff92000170eb3 RBX: ffffc90000b87598 RCX: dffffc0000000000
RDX: dffffc0000000000 RSI: 1ffff92000170dfc RDI: ffff8880b983c9a0
RBP: ffffc90000b87730 R08: ffffc90000b875df R09: 0000000000000000
R10: ffffc90000b87590 R11: fffff52000170ebc R12: dffffc0000000000
R13: ffffc90000b87520 R14: 0000000000000001 R15: ffffc90000b87528
FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fbb9323ba08 CR3: 000000000d130000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 newidle_balance+0x660/0xff0 kernel/sched/fair.c:11891
 pick_next_task_fair+0x289/0xdc0 kernel/sched/fair.c:8182
 __pick_next_task kernel/sched/core.c:6013 [inline]
 pick_next_task kernel/sched/core.c:6088 [inline]
 __schedule+0x7c6/0x48f0 kernel/sched/core.c:6674
 schedule+0xc3/0x180 kernel/sched/core.c:6786
 toggle_allocation_gate+0x16a/0x250 mm/kfence/core.c:833
 process_one_work+0x92c/0x12c0 kernel/workqueue.c:2597
 worker_thread+0xa63/0x1210 kernel/workqueue.c:2748
 kthread+0x2b8/0x350 kernel/kthread.c:389
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>
INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 1.234 msecs


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to change bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
