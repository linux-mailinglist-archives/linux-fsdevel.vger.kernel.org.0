Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8D5E77EDD2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Aug 2023 01:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347178AbjHPX1y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Aug 2023 19:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347177AbjHPX1u (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Aug 2023 19:27:50 -0400
Received: from mail-pl1-f208.google.com (mail-pl1-f208.google.com [209.85.214.208])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE70B271F
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Aug 2023 16:27:47 -0700 (PDT)
Received: by mail-pl1-f208.google.com with SMTP id d9443c01a7336-1bbb97d27d6so84698785ad.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Aug 2023 16:27:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692228467; x=1692833267;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PAODHEKlkohyVW4SPU/mzzjLtNTRD9df5tm0JKFVRoM=;
        b=X2dCb0FF4bHDMLjn7ETiw5GC67crQ7T73jjx29StIf2tNJu2WRQA6vxxppbasZkFJh
         alOTFbu95WxnwtQtRMFWCeoaiR1kEWFFqWn3ECceRSXgORA0mmwylm1MRmfdp5mAITOs
         Tz9AF3UT/kxQ/zu6Plg77Ay+YrC/3Tyde7izq7xkL5K09cdHfM/xpoIObn4oWj6PiPhJ
         ciM2tsrseek+rU3/Lwc+duAexhirdee8p9jk/leAJeC8gwdG5uhl95fAGKkvvBbBH6AQ
         aFfZghfglI+Nr644Prnvp/bUHvZgk7SK+ewjAeFfvMuCLmhKB3HQl1wqW/A+nYKCt35Y
         s65Q==
X-Gm-Message-State: AOJu0Yxo1UL7EFgFiW+UmT8WLdCh8pNNqDSsvDMAMIwAZOTNr4WnjbPi
        LAPHfXBhv+GSVcDRWnhtW/C6AqhRR7xU3qGIWH5jEdjpWA9S
X-Google-Smtp-Source: AGHT+IEVKJaNYWhsLc8jTBq2cwXfDEnAiIer4Ho7bobQt0yn5iTbUe7aSmJ6XKe0ibJTzIG5RgoIruxRyMGV2FDmDHgDfLBB37dR
MIME-Version: 1.0
X-Received: by 2002:a17:903:2302:b0:1bf:794:9e8f with SMTP id
 d2-20020a170903230200b001bf07949e8fmr564090plh.7.1692228467435; Wed, 16 Aug
 2023 16:27:47 -0700 (PDT)
Date:   Wed, 16 Aug 2023 16:27:47 -0700
In-Reply-To: <000000000000f59fa505fe48748f@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ae2d46060312a494@google.com>
Subject: Re: [syzbot] [ext4?] INFO: task hung in __writeback_inodes_sb_nr (6)
From:   syzbot <syzbot+38d04642cea49f3a3d2e@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, linkinjeon@kernel.org,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, sj1557.seo@samsung.com,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    4853c74bd7ab Merge tag 'parisc-for-6.5-rc7' of git://git.k..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=178eb2efa80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=aa796b6080b04102
dashboard link: https://syzkaller.appspot.com/bug?extid=38d04642cea49f3a3d2e
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=171242cfa80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17934703a80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/fef982ba26aa/disk-4853c74b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/633875549882/vmlinux-4853c74b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a1d2d81c82f6/bzImage-4853c74b.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/45ecbb86ca49/mount_4.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+38d04642cea49f3a3d2e@syzkaller.appspotmail.com

INFO: task syz-executor359:5018 blocked for more than 143 seconds.
      Not tainted 6.5.0-rc6-syzkaller-00036-g4853c74bd7ab #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor359 state:D stack:27216 pid:5018  ppid:5015   flags:0x00004002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5381 [inline]
 __schedule+0xee1/0x59f0 kernel/sched/core.c:6710
 schedule+0xe7/0x1b0 kernel/sched/core.c:6786
 wb_wait_for_completion+0x1ae/0x270 fs/fs-writeback.c:192
 __writeback_inodes_sb_nr+0x1d8/0x270 fs/fs-writeback.c:2650
 sync_filesystem fs/sync.c:54 [inline]
 sync_filesystem+0xb6/0x280 fs/sync.c:30
 generic_shutdown_super+0x74/0x480 fs/super.c:472
 kill_block_super+0x64/0xb0 fs/super.c:1417
 deactivate_locked_super+0x9a/0x170 fs/super.c:330
 deactivate_super+0xde/0x100 fs/super.c:361
 cleanup_mnt+0x222/0x3d0 fs/namespace.c:1254
 task_work_run+0x14d/0x240 kernel/task_work.c:179
 ptrace_notify+0x10c/0x130 kernel/signal.c:2376
 ptrace_report_syscall include/linux/ptrace.h:411 [inline]
 ptrace_report_syscall_exit include/linux/ptrace.h:473 [inline]
 syscall_exit_work kernel/entry/common.c:252 [inline]
 syscall_exit_to_user_mode_prepare+0x120/0x220 kernel/entry/common.c:279
 __syscall_exit_to_user_mode_work kernel/entry/common.c:284 [inline]
 syscall_exit_to_user_mode+0xd/0x50 kernel/entry/common.c:297
 do_syscall_64+0x44/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f497ef65487
RSP: 002b:00007ffdd57d4148 EFLAGS: 00000206 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f497ef65487
RDX: 0000000000000000 RSI: 000000000000000a RDI: 00007ffdd57d4200
RBP: 00007ffdd57d4200 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000206 R12: 00007ffdd57d5270
R13: 00005555566da6c0 R14: 431bde82d7b634db R15: 00007ffdd57d5290
 </TASK>

Showing all locks held in the system:
1 lock held by rcu_tasks_kthre/13:
 #0: ffffffff8c9a67f0 (rcu_tasks.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x2c/0xe20 kernel/rcu/tasks.h:522
1 lock held by rcu_tasks_trace/14:
 #0: ffffffff8c9a64f0 (rcu_tasks_trace.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x2c/0xe20 kernel/rcu/tasks.h:522
1 lock held by khungtaskd/27:
 #0: ffffffff8c9a7400 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x55/0x340 kernel/locking/lockdep.c:6615
3 locks held by kworker/u4:2/34:
2 locks held by getty/4774:
 #0: ffff88802cdfa098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x24/0x80 drivers/tty/tty_ldisc.c:243
 #1: ffffc900015c02f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0xfcb/0x1480 drivers/tty/n_tty.c:2187
1 lock held by syz-executor359/5018:
 #0: ffff88807b0e80e0 (&type->s_umount_key#42){+.+.}-{3:3}, at: deactivate_super+0xd6/0x100 fs/super.c:360

=============================================

NMI backtrace for cpu 1
CPU: 1 PID: 27 Comm: khungtaskd Not tainted 6.5.0-rc6-syzkaller-00036-g4853c74bd7ab #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 nmi_cpu_backtrace+0x277/0x380 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x2ac/0x310 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:160 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:222 [inline]
 watchdog+0xf29/0x11b0 kernel/hung_task.c:379
 kthread+0x33a/0x430 kernel/kthread.c:389
 ret_from_fork+0x2c/0x70 arch/x86/kernel/process.c:145
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
 </TASK>
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 PID: 34 Comm: kworker/u4:2 Not tainted 6.5.0-rc6-syzkaller-00036-g4853c74bd7ab #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
Workqueue: writeback wb_workfn (flush-7:0)
RIP: 0010:__sanitizer_cov_trace_pc+0x0/0x70 kernel/kcov.c:200
Code: a6 27 99 02 66 0f 1f 44 00 00 f3 0f 1e fa 48 8b be b0 01 00 00 e8 b0 ff ff ff 31 c0 c3 66 66 2e 0f 1f 84 00 00 00 00 00 66 90 <f3> 0f 1e fa 65 8b 05 dd b0 7d 7e 89 c1 48 8b 34 24 81 e1 00 01 00
RSP: 0018:ffffc90000ab74e8 EFLAGS: 00000206
RAX: 0000000000000000 RBX: ffffea0001c90174 RCX: ffffffff81fa92f9
RDX: ffff8880136fbb80 RSI: 0000000000000000 RDI: 0000000000000005
RBP: 0000000000000001 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000003 R11: 1ffffffff1936441 R12: 0000000000000003
R13: 0000000000000200 R14: 0000000000000003 R15: ffffea0001c90140
FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055fded888928 CR3: 0000000028191000 CR4: 0000000000350ef0
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 instrument_atomic_read_write include/linux/instrumented.h:96 [inline]
 atomic_dec_and_test include/linux/atomic/atomic-instrumented.h:1375 [inline]
 page_ref_dec_and_test include/linux/page_ref.h:210 [inline]
 put_page_testzero include/linux/mm.h:1028 [inline]
 folio_put_testzero include/linux/mm.h:1033 [inline]
 folio_put include/linux/mm.h:1439 [inline]
 grow_dev_page fs/buffer.c:1093 [inline]
 grow_buffers fs/buffer.c:1123 [inline]
 __getblk_slow+0x4b7/0x720 fs/buffer.c:1150
 __getblk_gfp fs/buffer.c:1445 [inline]
 __bread_gfp+0x215/0x310 fs/buffer.c:1479
 sb_bread include/linux/buffer_head.h:351 [inline]
 exfat_get_dentry_set+0x283/0xc10 fs/exfat/dir.c:878
 __exfat_write_inode+0x2c0/0x9e0 fs/exfat/inode.c:45
 exfat_write_inode+0xad/0x130 fs/exfat/inode.c:94
 write_inode fs/fs-writeback.c:1456 [inline]
 __writeback_single_inode+0xa81/0xe70 fs/fs-writeback.c:1668
 writeback_sb_inodes+0x599/0x1010 fs/fs-writeback.c:1894
 wb_writeback+0x2a5/0xa90 fs/fs-writeback.c:2070
 wb_do_writeback fs/fs-writeback.c:2217 [inline]
 wb_workfn+0x29c/0xfd0 fs/fs-writeback.c:2257
 process_one_work+0xaa2/0x16f0 kernel/workqueue.c:2600
 worker_thread+0x687/0x1110 kernel/workqueue.c:2751
 kthread+0x33a/0x430 kernel/kthread.c:389
 ret_from_fork+0x2c/0x70 arch/x86/kernel/process.c:145
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
 </TASK>
INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 1.463 msecs


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
