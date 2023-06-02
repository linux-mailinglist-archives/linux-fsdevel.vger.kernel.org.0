Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9BD571F792
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Jun 2023 03:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233244AbjFBBPL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Jun 2023 21:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233204AbjFBBPJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Jun 2023 21:15:09 -0400
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE878132
        for <linux-fsdevel@vger.kernel.org>; Thu,  1 Jun 2023 18:15:06 -0700 (PDT)
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-7776dd75224so47819139f.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 01 Jun 2023 18:15:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685668506; x=1688260506;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zwqVxLVfUOfca210sGbGwwIcFH4O+k5yY2hZxt0AgFM=;
        b=FYjrfw2NsKXx+gzz0EH8f8BZqALo+to0Vdd+ciqtt5/N9FS6Vz4HaZag8msmpG/Fiy
         tFygbZNjF0ZqRySFDhA043GyU1N8uj+krec4KxsYzUNgs48aWDQh5Q+/5URWxBzjooPZ
         GUJJ2IMaU1nD8ubdadiWuph6MGX0kmWCsfr3eXaCLK7FLsux5lPEyr/ZpOK2IdtHX8ZS
         PVCD9yIPc1Nr2yyayw/0guDquBEXXRhW2CW8IU7nquZjBMt7V+d3OabbGrVYWw8t8cF4
         NJWkIy0NLpsav09CYTsiT08mpzO4ptCkuFguJFxOjk6KtUasjcFNbQ22uyzM8amRqY2/
         dsqg==
X-Gm-Message-State: AC+VfDxKNkZynnb+C8UlqxRY4Dbj50CffTZ3YNMLtQUcHL2I+3besRr/
        gYyT9cU5TVSWOPGvsTqY9MncgMcBKTq1e9AdvzPBlFmmQIYq
X-Google-Smtp-Source: ACHHUZ5oA4SZucy9gwJ7nARDGb1MbUu6GZGcC1zHQAngoXC2aYSbdGu8pXH58wFYsjJdXt9ZofnYOe8fnU0IkKkVXpEd6cYDU371
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:4d2:b0:33a:4f71:b9c5 with SMTP id
 f18-20020a056e0204d200b0033a4f71b9c5mr3649194ils.1.1685668506237; Thu, 01 Jun
 2023 18:15:06 -0700 (PDT)
Date:   Thu, 01 Jun 2023 18:15:06 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000086021605fd1b484c@google.com>
Subject: [syzbot] [btrfs?] INFO: task hung in btrfs_sync_file (2)
From:   syzbot <syzbot+a694851c6ab28cbcfb9c@syzkaller.appspotmail.com>
To:     clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    715abedee4cd Add linux-next specific files for 20230515
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=16cc8ced280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6a2745d066dda0ec
dashboard link: https://syzkaller.appspot.com/bug?extid=a694851c6ab28cbcfb9c
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=146e7c35280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12ea7ffe280000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d4d1d06b34b8/disk-715abede.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3ef33a86fdc8/vmlinux-715abede.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e0006b413ed1/bzImage-715abede.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/8a4c583d7fb5/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a694851c6ab28cbcfb9c@syzkaller.appspotmail.com

INFO: task syz-executor274:6164 blocked for more than 143 seconds.
      Not tainted 6.4.0-rc2-next-20230515-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor274 state:D stack:24920 pid:6164  ppid:5041   flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5343 [inline]
 __schedule+0x1d15/0x5790 kernel/sched/core.c:6669
 schedule+0xde/0x1a0 kernel/sched/core.c:6745
 schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:6804
 rwsem_down_write_slowpath+0x3e2/0x1220 kernel/locking/rwsem.c:1178
 __down_write_common kernel/locking/rwsem.c:1306 [inline]
 __down_write kernel/locking/rwsem.c:1315 [inline]
 down_write+0x1d2/0x200 kernel/locking/rwsem.c:1574
 inode_lock include/linux/fs.h:775 [inline]
 btrfs_inode_lock+0x7e/0xf0 fs/btrfs/inode.c:377
 btrfs_sync_file+0x455/0x12d0 fs/btrfs/file.c:1808
 vfs_fsync_range+0x13e/0x230 fs/sync.c:188
 generic_write_sync include/linux/fs.h:2469 [inline]
 btrfs_do_write_iter+0x520/0x1210 fs/btrfs/file.c:1680
 call_write_iter include/linux/fs.h:1868 [inline]
 new_sync_write fs/read_write.c:491 [inline]
 vfs_write+0x945/0xd50 fs/read_write.c:584
 ksys_write+0x12b/0x250 fs/read_write.c:637
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f0de39026c9
RSP: 002b:00007f0de38a5208 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f0de3984788 RCX: 00007f0de39026c9
RDX: 0000000000000128 RSI: 0000000020004400 RDI: 0000000000000006
RBP: 00007f0de3984780 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f0de398478c
R13: 00007fffb0c5635f R14: 00007f0de38a5300 R15: 0000000000022000
 </TASK>
INFO: task syz-executor274:6181 blocked for more than 143 seconds.
      Not tainted 6.4.0-rc2-next-20230515-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor274 state:D stack:26416 pid:6181  ppid:5041   flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5343 [inline]
 __schedule+0x1d15/0x5790 kernel/sched/core.c:6669
 schedule+0xde/0x1a0 kernel/sched/core.c:6745
 wait_on_state fs/btrfs/extent-io-tree.c:707 [inline]
 wait_extent_bit+0x56e/0x670 fs/btrfs/extent-io-tree.c:751
 lock_extent+0x120/0x1c0 fs/btrfs/extent-io-tree.c:1742
 btrfs_page_mkwrite+0x652/0x11a0 fs/btrfs/inode.c:8336
 do_page_mkwrite+0x1a1/0x690 mm/memory.c:2934
 wp_page_shared mm/memory.c:3283 [inline]
 do_wp_page+0x356/0x34e0 mm/memory.c:3365
 handle_pte_fault mm/memory.c:4967 [inline]
 __handle_mm_fault+0x1635/0x4170 mm/memory.c:5092
 handle_mm_fault+0x2af/0x9f0 mm/memory.c:5246
 do_user_addr_fault+0x51a/0x1210 arch/x86/mm/fault.c:1440
 handle_page_fault arch/x86/mm/fault.c:1534 [inline]
 exc_page_fault+0x98/0x170 arch/x86/mm/fault.c:1590
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:570
RIP: 0010:rep_movs_alternative+0x33/0xb0 arch/x86/lib/copy_user_64.S:56
Code: 46 83 f9 08 73 21 85 c9 74 0f 8a 06 88 07 48 ff c7 48 ff c6 48 ff c9 75 f1 c3 66 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 8b 06 <48> 89 07 48 83 c6 08 48 83 c7 08 83 e9 08 74 df 83 f9 08 73 e8 eb
RSP: 0018:ffffc9000becf728 EFLAGS: 00050206
RAX: 0000000000000000 RBX: 0000000000000038 RCX: 0000000000000038
RDX: fffff520017d9efb RSI: ffffc9000becf7a0 RDI: 0000000020000120
RBP: 0000000020000120 R08: 0000000000000000 R09: fffff520017d9efa
R10: ffffc9000becf7d7 R11: 0000000000000001 R12: ffffc9000becf7a0
R13: 0000000020000158 R14: 0000000000000000 R15: ffffc9000becf7a0
 copy_user_generic arch/x86/include/asm/uaccess_64.h:112 [inline]
 raw_copy_to_user arch/x86/include/asm/uaccess_64.h:133 [inline]
 _copy_to_user lib/usercopy.c:41 [inline]
 _copy_to_user+0xab/0xc0 lib/usercopy.c:34
 copy_to_user include/linux/uaccess.h:191 [inline]
 fiemap_fill_next_extent+0x217/0x370 fs/ioctl.c:144
 emit_fiemap_extent+0x18e/0x380 fs/btrfs/extent_io.c:2616
 fiemap_process_hole+0x516/0x610 fs/btrfs/extent_io.c:2874
 extent_fiemap+0x123b/0x1950 fs/btrfs/extent_io.c:3089
 btrfs_fiemap+0xe9/0x170 fs/btrfs/inode.c:8008
 ioctl_fiemap fs/ioctl.c:219 [inline]
 do_vfs_ioctl+0x466/0x1670 fs/ioctl.c:810
 __do_sys_ioctl fs/ioctl.c:868 [inline]
 __se_sys_ioctl fs/ioctl.c:856 [inline]
 __x64_sys_ioctl+0x10c/0x210 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f0de39026c9
RSP: 002b:00007f0ddc484208 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f0de3984798 RCX: 00007f0de39026c9
RDX: 0000000020000100 RSI: 00000000c020660b RDI: 0000000000000005
RBP: 00007f0de3984790 R08: 00007f0ddc484700 R09: 0000000000000000
R10: 00007f0ddc484700 R11: 0000000000000246 R12: 00007f0de398479c
R13: 00007fffb0c5635f R14: 00007f0ddc484300 R15: 0000000000022000
 </TASK>

Showing all locks held in the system:
1 lock held by rcu_tasks_kthre/13:
 #0: ffffffff8c798530 (rcu_tasks.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x31/0xd80 kernel/rcu/tasks.h:522
1 lock held by rcu_tasks_trace/14:
 #0: ffffffff8c798230 (rcu_tasks_trace.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x31/0xd80 kernel/rcu/tasks.h:522
1 lock held by khungtaskd/28:
 #0: ffffffff8c799140 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x51/0x390 kernel/locking/lockdep.c:6559
2 locks held by getty/4759:
 #0: ffff888028dba098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x26/0x80 drivers/tty/tty_ldisc.c:243
 #1: ffffc900015902f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0xef4/0x13e0 drivers/tty/n_tty.c:2176
3 locks held by syz-executor274/6164:
 #0: ffff888027b554e8 (&f->f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0xe7/0x100 fs/file.c:1047
 #1: ffff88807cee8460 (sb_writers#10){.+.+}-{0:0}, at: ksys_write+0x12b/0x250 fs/read_write.c:637
 #2: ffff888075278590 (&sb->s_type->i_mutex_key#15){++++}-{3:3}, at: inode_lock include/linux/fs.h:775 [inline]
 #2: ffff888075278590 (&sb->s_type->i_mutex_key#15){++++}-{3:3}, at: btrfs_inode_lock+0x7e/0xf0 fs/btrfs/inode.c:377
4 locks held by syz-executor274/6181:
 #0: ffff888075278590 (&sb->s_type->i_mutex_key#15){++++}-{3:3}, at: inode_lock_shared include/linux/fs.h:785 [inline]
 #0: ffff888075278590 (&sb->s_type->i_mutex_key#15){++++}-{3:3}, at: btrfs_inode_lock+0xd8/0xf0 fs/btrfs/inode.c:369
 #1: ffff88807f081368 (&mm->mmap_lock){++++}-{3:3}, at: mmap_read_trylock include/linux/mmap_lock.h:161 [inline]
 #1: ffff88807f081368 (&mm->mmap_lock){++++}-{3:3}, at: do_user_addr_fault+0x448/0x1210 arch/x86/mm/fault.c:1381
 #2: ffff88807cee8558 (sb_pagefaults){.+.+}-{0:0}, at: do_page_mkwrite+0x1a1/0x690 mm/memory.c:2934
 #3: ffff888075278418 (&ei->i_mmap_lock){++++}-{3:3}, at: btrfs_page_mkwrite+0x6eb/0x11a0 fs/btrfs/inode.c:8325

=============================================

NMI backtrace for cpu 1
CPU: 1 PID: 28 Comm: khungtaskd Not tainted 6.4.0-rc2-next-20230515-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/25/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x150 lib/dump_stack.c:106
 nmi_cpu_backtrace+0x29c/0x350 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x2a4/0x300 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:148 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:222 [inline]
 watchdog+0xe16/0x1090 kernel/hung_task.c:379
 kthread+0x344/0x440 kernel/kthread.c:379
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0 skipped: idling at native_safe_halt arch/x86/include/asm/irqflags.h:48 [inline]
NMI backtrace for cpu 0 skipped: idling at arch_safe_halt arch/x86/include/asm/irqflags.h:86 [inline]
NMI backtrace for cpu 0 skipped: idling at acpi_safe_halt+0x40/0x50 drivers/acpi/processor_idle.c:112


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
