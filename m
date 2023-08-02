Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7165976D625
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Aug 2023 19:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234043AbjHBRwk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Aug 2023 13:52:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234040AbjHBRw0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Aug 2023 13:52:26 -0400
Received: from mail-oi1-f206.google.com (mail-oi1-f206.google.com [209.85.167.206])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FA3D10D2
        for <linux-fsdevel@vger.kernel.org>; Wed,  2 Aug 2023 10:51:13 -0700 (PDT)
Received: by mail-oi1-f206.google.com with SMTP id 5614622812f47-3a483c86b74so50345b6e.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Aug 2023 10:51:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690998669; x=1691603469;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qUwpd3WVQCroggMQSHXSG0SQah6fpT1m9kYbHC10KHg=;
        b=YvQ+rZWbhV0Bki349dm1slt9qy4T6II4EmKq6F/pBUxAarnlfnaK4t31P39id0Wysr
         eVUaCdJyf9M4d1oAwIOvlk3DSqgC+aBRa/JNjinwCYlMnsaiLQglfVHQWRrhepJjpcVY
         QxN8R6PvysbwmN3cOSORbJb4NHq2Pjopj3blTM2PxxWYgdaaWz7eAfOrk+1Vbg8/T5Sn
         7glvQLKjpqIGaOxuiPrpH+wmVvX3751ALyQMJRXKGZdiEyRSaJ9a3VnabeLo66y9XpGy
         0EKBMyDLcqDGdwfBmTSMm+wSzfDXxkl7ONi2oBiwCpso+I3esePk76yPLNjlB9Auaosh
         5GkQ==
X-Gm-Message-State: ABy/qLaYJPEvexUqyBh7qi+UFNoXVDjouBhWoWkGd9ss9/1alcBF9D+5
        3ZZXxIHXv5oIHnLrSBuHf+HRjAnqLf9ew4mlDqGUP9/Ya0zH
X-Google-Smtp-Source: APBJJlGEX3bs9XGm6KFTkpNrAqT+U0B6KZAvqfiFN/V0FNPHRIWozmNyoyYqBsMcb7n3dnmRcJVQj3QLLIPD4iol+aje2CGi/Tg7
MIME-Version: 1.0
X-Received: by 2002:a05:6808:d47:b0:3a1:f295:3e with SMTP id
 w7-20020a0568080d4700b003a1f295003emr26280989oik.1.1690998669070; Wed, 02 Aug
 2023 10:51:09 -0700 (PDT)
Date:   Wed, 02 Aug 2023 10:51:09 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fc57030601f44e7a@google.com>
Subject: [syzbot] [btrfs?] INFO: task hung in extent_writepages
From:   syzbot <syzbot+d9d40a56a26bdd36922e@syzkaller.appspotmail.com>
To:     clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    ffabf7c73176 Merge tag 'ata-6.5-rc4' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1222dfcea80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5d10d93e1ae1f229
dashboard link: https://syzkaller.appspot.com/bug?extid=d9d40a56a26bdd36922e
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1209bae5a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=122ba496a80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/206c7acdd0bc/disk-ffabf7c7.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8fddac9d8e42/vmlinux-ffabf7c7.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0b13871eaad4/bzImage-ffabf7c7.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/8053495721fb/mount_0.gz

Bisection is inconclusive: the issue happens on the oldest tested release.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10353bf6a80000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=12353bf6a80000
console output: https://syzkaller.appspot.com/x/log.txt?x=14353bf6a80000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d9d40a56a26bdd36922e@syzkaller.appspotmail.com

INFO: task kworker/u4:2:30 blocked for more than 143 seconds.
      Not tainted 6.5.0-rc3-syzkaller-00275-gffabf7c73176 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/u4:2    state:D stack:20560 pid:30    ppid:2      flags:0x00004000
Workqueue: writeback wb_workfn (flush-btrfs-47)
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5381 [inline]
 __schedule+0x1873/0x48f0 kernel/sched/core.c:6710
 schedule+0xc3/0x180 kernel/sched/core.c:6786
 io_schedule+0x8c/0x100 kernel/sched/core.c:9028
 folio_wait_bit_common+0x86c/0x12b0 mm/filemap.c:1304
 folio_lock include/linux/pagemap.h:959 [inline]
 extent_write_cache_pages fs/btrfs/extent_io.c:2140 [inline]
 extent_writepages+0xcea/0x2d00 fs/btrfs/extent_io.c:2286
 do_writepages+0x3a6/0x670 mm/page-writeback.c:2553
 __writeback_single_inode+0x155/0xfa0 fs/fs-writeback.c:1603
 writeback_sb_inodes+0x8e3/0x11d0 fs/fs-writeback.c:1894
 __writeback_inodes_wb+0x11b/0x260 fs/fs-writeback.c:1965
 wb_writeback+0x461/0xc60 fs/fs-writeback.c:2072
 wb_check_background_flush fs/fs-writeback.c:2142 [inline]
 wb_do_writeback fs/fs-writeback.c:2230 [inline]
 wb_workfn+0xc6f/0xff0 fs/fs-writeback.c:2257
 process_one_work+0x92c/0x12c0 kernel/workqueue.c:2597
 worker_thread+0xa63/0x1210 kernel/workqueue.c:2748
 kthread+0x2b8/0x350 kernel/kthread.c:389
 ret_from_fork+0x2e/0x60 arch/x86/kernel/process.c:145
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:296
RIP: 0000:0x0
Code: Unable to access opcode bytes at 0xffffffffffffffd6.
RSP: 0000:0000000000000000 EFLAGS: 00000000 ORIG_RAX: 0000000000000000
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
INFO: task kworker/u4:5:1145 blocked for more than 144 seconds.
      Not tainted 6.5.0-rc3-syzkaller-00275-gffabf7c73176 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/u4:5    state:D stack:21608 pid:1145  ppid:2      flags:0x00004000
Workqueue: btrfs-endio-write btrfs_work_helper
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5381 [inline]
 __schedule+0x1873/0x48f0 kernel/sched/core.c:6710
 schedule+0xc3/0x180 kernel/sched/core.c:6786
 wait_on_state fs/btrfs/extent-io-tree.c:719 [inline]
 wait_extent_bit+0x50c/0x670 fs/btrfs/extent-io-tree.c:763
 lock_extent+0x1c0/0x270 fs/btrfs/extent-io-tree.c:1755
 btrfs_finish_one_ordered+0x5bf/0x1c80 fs/btrfs/inode.c:3242
 btrfs_work_helper+0x380/0xbe0 fs/btrfs/async-thread.c:314
 process_one_work+0x92c/0x12c0 kernel/workqueue.c:2597
 worker_thread+0xa63/0x1210 kernel/workqueue.c:2748
 kthread+0x2b8/0x350 kernel/kthread.c:389
 ret_from_fork+0x2e/0x60 arch/x86/kernel/process.c:145
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:296
RIP: 0000:0x0
Code: Unable to access opcode bytes at 0xffffffffffffffd6.
RSP: 0000:0000000000000000 EFLAGS: 00000000 ORIG_RAX: 0000000000000000
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
INFO: task syz-executor376:6242 blocked for more than 144 seconds.
      Not tainted 6.5.0-rc3-syzkaller-00275-gffabf7c73176 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor376 state:D stack:23592 pid:6242  ppid:5052   flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5381 [inline]
 __schedule+0x1873/0x48f0 kernel/sched/core.c:6710
 schedule+0xc3/0x180 kernel/sched/core.c:6786
 wait_on_state fs/btrfs/extent-io-tree.c:719 [inline]
 wait_extent_bit+0x50c/0x670 fs/btrfs/extent-io-tree.c:763
 lock_extent+0x1c0/0x270 fs/btrfs/extent-io-tree.c:1755
 find_lock_delalloc_range+0x4b5/0x980 fs/btrfs/extent_io.c:443
 writepage_delalloc+0x1bd/0x490 fs/btrfs/extent_io.c:1235
 __extent_writepage fs/btrfs/extent_io.c:1492 [inline]
 extent_write_cache_pages fs/btrfs/extent_io.c:2160 [inline]
 extent_writepages+0x14bd/0x2d00 fs/btrfs/extent_io.c:2286
 do_writepages+0x3a6/0x670 mm/page-writeback.c:2553
 filemap_fdatawrite_wbc+0x125/0x180 mm/filemap.c:393
 __filemap_fdatawrite_range mm/filemap.c:426 [inline]
 filemap_fdatawrite_range+0x16e/0x1e0 mm/filemap.c:444
 btrfs_fdatawrite_range fs/btrfs/file.c:3850 [inline]
 start_ordered_ops fs/btrfs/file.c:1725 [inline]
 btrfs_sync_file+0x424/0x1330 fs/btrfs/file.c:1800
 generic_write_sync include/linux/fs.h:2493 [inline]
 btrfs_do_write_iter+0xb45/0x1020 fs/btrfs/file.c:1677
 call_write_iter include/linux/fs.h:1871 [inline]
 new_sync_write fs/read_write.c:491 [inline]
 vfs_write+0x782/0xaf0 fs/read_write.c:584
 ksys_write+0x1a0/0x2c0 fs/read_write.c:637
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f0fa348afc9
RSP: 002b:00007f0fa3447218 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f0fa35176c8 RCX: 00007f0fa348afc9
RDX: 0000000000000128 RSI: 0000000020004400 RDI: 0000000000000006
RBP: 00007f0fa35176c0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f0fa34e41b0
R13: 61635f65646f6e69 R14: 65646f7475616f6e R15: 7261637369646f6e
 </TASK>
INFO: task syz-executor376:6283 blocked for more than 145 seconds.
      Not tainted 6.5.0-rc3-syzkaller-00275-gffabf7c73176 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor376 state:D stack:21704 pid:6283  ppid:5052   flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5381 [inline]
 __schedule+0x1873/0x48f0 kernel/sched/core.c:6710
 schedule+0xc3/0x180 kernel/sched/core.c:6786
 wait_on_state fs/btrfs/extent-io-tree.c:719 [inline]
 wait_extent_bit+0x50c/0x670 fs/btrfs/extent-io-tree.c:763
 lock_extent+0x1c0/0x270 fs/btrfs/extent-io-tree.c:1755
 btrfs_page_mkwrite+0x5bd/0xd10 fs/btrfs/inode.c:8271
 do_page_mkwrite+0x1a4/0x600 mm/memory.c:2942
 wp_page_shared mm/memory.c:3294 [inline]
 do_wp_page+0x559/0x3a70 mm/memory.c:3376
 handle_pte_fault mm/memory.c:4955 [inline]
 __handle_mm_fault mm/memory.c:5079 [inline]
 handle_mm_fault+0x1c58/0x5410 mm/memory.c:5233
 do_user_addr_fault arch/x86/mm/fault.c:1392 [inline]
 handle_page_fault arch/x86/mm/fault.c:1486 [inline]
 exc_page_fault+0x266/0x7c0 arch/x86/mm/fault.c:1542
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:570
RIP: 0010:rep_movs_alternative+0x33/0xb0 arch/x86/lib/copy_user_64.S:58
Code: 40 83 f9 08 73 21 85 c9 74 0f 8a 06 88 07 48 ff c7 48 ff c6 48 ff c9 75 f1 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 8b 06 <48> 89 07 48 83 c6 08 48 83 c7 08 83 e9 08 74 df 83 f9 08 73 e8 eb
RSP: 0000:ffffc9000b76f330 EFLAGS: 00050206
RAX: 0000000000000000 RBX: 0000000020000158 RCX: 0000000000000038
RDX: 0000000000000000 RSI: ffffc9000b76f3e0 RDI: 0000000020000120
RBP: ffffc9000b76f498 R08: ffffc9000b76f417 R09: 1ffff920016ede82
R10: dffffc0000000000 R11: fffff520016ede83 R12: 0000000000000038
R13: ffffc9000b76f3e0 R14: 0000000020000120 R15: ffffc9000b76f3e0
 copy_user_generic arch/x86/include/asm/uaccess_64.h:112 [inline]
 raw_copy_to_user arch/x86/include/asm/uaccess_64.h:133 [inline]
 _copy_to_user+0x86/0xa0 lib/usercopy.c:41
 copy_to_user include/linux/uaccess.h:191 [inline]
 fiemap_fill_next_extent+0x235/0x410 fs/ioctl.c:144
 emit_fiemap_extent+0x256/0x410 fs/btrfs/extent_io.c:2532
 fiemap_process_hole+0x374/0xaf0 fs/btrfs/extent_io.c:2743
 extent_fiemap+0xeae/0x1fe0
 btrfs_fiemap+0x178/0x1e0 fs/btrfs/inode.c:7943
 ioctl_fiemap fs/ioctl.c:219 [inline]
 do_vfs_ioctl+0x19db/0x2b30 fs/ioctl.c:810
 __do_sys_ioctl fs/ioctl.c:868 [inline]
 __se_sys_ioctl+0x81/0x170 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f0fa348afc9
RSP: 002b:00007f0f9c026218 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f0fa35176d8 RCX: 00007f0fa348afc9
RDX: 0000000020000100 RSI: 00000000c020660b RDI: 0000000000000005
RBP: 00007f0fa35176d0 R08: 00007ffc74220257 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f0fa34e41b0
R13: 61635f65646f6e69 R14: 65646f7475616f6e R15: 7261637369646f6e
 </TASK>

Showing all locks held in the system:
1 lock held by rcu_tasks_kthre/13:
 #0: ffffffff8d328db0 (rcu_tasks.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x29/0xd20 kernel/rcu/tasks.h:522
1 lock held by rcu_tasks_trace/14:
 #0: ffffffff8d329170 (rcu_tasks_trace.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x29/0xd20 kernel/rcu/tasks.h:522
1 lock held by khungtaskd/28:
 #0: ffffffff8d328be0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire+0x0/0x30
3 locks held by kworker/u4:2/30:
 #0: ffff88814267e938 ((wq_completion)writeback){+.+.}-{0:0}, at: process_one_work+0x7e3/0x12c0 kernel/workqueue.c:2569
 #1: ffffc90000a6fd00 ((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0}, at: process_one_work+0x82b/0x12c0 kernel/workqueue.c:2571
 #2: ffff88807a5d00e0 (&type->s_umount_key#43){++++}-{3:3}, at: trylock_super+0x1f/0xf0 fs/super.c:413
3 locks held by kworker/u4:5/1145:
 #0: ffff8880285ae138 ((wq_completion)btrfs-endio-write){+.+.}-{0:0}, at: process_one_work+0x7e3/0x12c0 kernel/workqueue.c:2569
 #1: ffffc9000514fd00 ((work_completion)(&work->normal_work)){+.+.}-{0:0}, at: process_one_work+0x82b/0x12c0 kernel/workqueue.c:2571
 #2: ffff888023a0a488 (btrfs_ordered_extent){++++}-{0:0}, at: btrfs_finish_one_ordered+0x343/0x1c80 fs/btrfs/inode.c:3201
2 locks held by getty/4768:
 #0: ffff88802df81098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc900015b02f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x6b1/0x1dc0 drivers/tty/n_tty.c:2187
2 locks held by syz-executor376/6242:
 #0: ffff8880201da0c8 (&f->f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0x20f/0x2a0 fs/file.c:1046
 #1: ffff88807a5d0410 (sb_writers#9){.+.+}-{0:0}, at: vfs_write+0x216/0xaf0 fs/read_write.c:580
4 locks held by syz-executor376/6283:
 #0: ffff8880753d62b0 (&sb->s_type->i_mutex_key#14){++++}-{3:3}, at: inode_lock_shared include/linux/fs.h:781 [inline]
 #0: ffff8880753d62b0 (&sb->s_type->i_mutex_key#14){++++}-{3:3}, at: btrfs_inode_lock+0x60/0xd0 fs/btrfs/inode.c:369
 #1: ffff88807d6027a0 (&mm->mmap_lock){++++}-{3:3}, at: mmap_read_trylock include/linux/mmap_lock.h:167 [inline]
 #1: ffff88807d6027a0 (&mm->mmap_lock){++++}-{3:3}, at: get_mmap_lock_carefully mm/memory.c:5261 [inline]
 #1: ffff88807d6027a0 (&mm->mmap_lock){++++}-{3:3}, at: lock_mm_and_find_vma+0x32/0x2f0 mm/memory.c:5323
 #2: ffff88807a5d0508 (sb_pagefaults){.+.+}-{0:0}, at: do_page_mkwrite+0x1a4/0x600 mm/memory.c:2942
 #3: ffff8880753d6138 (&ei->i_mmap_lock){++++}-{3:3}, at: btrfs_page_mkwrite+0x49c/0xd10 fs/btrfs/inode.c:8260

=============================================

NMI backtrace for cpu 0
CPU: 0 PID: 28 Comm: khungtaskd Not tainted 6.5.0-rc3-syzkaller-00275-gffabf7c73176 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2023
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
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:296
RIP: 0000:0x0
Code: Unable to access opcode bytes at 0xffffffffffffffd6.
RSP: 0000:0000000000000000 EFLAGS: 00000000 ORIG_RAX: 0000000000000000
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 PID: 5903 Comm: kworker/u4:0 Not tainted 6.5.0-rc3-syzkaller-00275-gffabf7c73176 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2023
Workqueue: events_unbound toggle_allocation_gate
RIP: 0010:native_save_fl arch/x86/include/asm/irqflags.h:19 [inline]
RIP: 0010:arch_local_save_flags arch/x86/include/asm/irqflags.h:67 [inline]
RIP: 0010:arch_irqs_disabled arch/x86/include/asm/irqflags.h:127 [inline]
RIP: 0010:smp_call_function_many_cond+0x1660/0x27d0 kernel/smp.c:827
Code: 85 f6 75 07 e8 31 16 0b 00 eb 0a e8 2a 16 0b 00 e8 75 d5 11 00 4c 89 fb 48 c1 eb 03 48 b8 00 00 00 00 00 fc ff df 80 3c 03 00 <74> 08 4c 89 ff e8 36 df 63 00 48 c7 84 24 60 01 00 00 00 00 00 00
RSP: 0018:ffffc9000ad9f780 EFLAGS: 00000046
RAX: dffffc0000000000 RBX: 1ffff920015b3f1c RCX: ffffffff816c3cea
RDX: dffffc0000000000 RSI: ffffffff8b0a90c0 RDI: ffffffff8b58a600
RBP: ffffc9000ad9f980 R08: ffffffff907b1307 R09: 1ffffffff20f6260
R10: dffffc0000000000 R11: fffffbfff20f6261 R12: ffff8880b993d0c0
R13: 0000000000000000 R14: 0000000000000200 R15: ffffc9000ad9f8e0
FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f0f9bf29000 CR3: 000000000d130000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 on_each_cpu_cond_mask+0x3f/0x80 kernel/smp.c:1003
 on_each_cpu include/linux/smp.h:71 [inline]
 text_poke_sync arch/x86/kernel/alternative.c:2001 [inline]
 text_poke_bp_batch+0x615/0x960 arch/x86/kernel/alternative.c:2273
 text_poke_flush arch/x86/kernel/alternative.c:2402 [inline]
 text_poke_finish+0x1a/0x30 arch/x86/kernel/alternative.c:2409
 arch_jump_label_transform_apply+0x17/0x30 arch/x86/kernel/jump_label.c:146
 static_key_enable_cpuslocked+0x132/0x250 kernel/jump_label.c:205
 static_key_enable+0x1a/0x20 kernel/jump_label.c:218
 toggle_allocation_gate+0xb5/0x250 mm/kfence/core.c:831
 process_one_work+0x92c/0x12c0 kernel/workqueue.c:2597
 worker_thread+0xa63/0x1210 kernel/workqueue.c:2748
 kthread+0x2b8/0x350 kernel/kthread.c:389
 ret_from_fork+0x2e/0x60 arch/x86/kernel/process.c:145
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:296
RIP: 0000:0x0
Code: Unable to access opcode bytes at 0xffffffffffffffd6.
RSP: 0000:0000000000000000 EFLAGS: 00000000 ORIG_RAX: 0000000000000000
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 1.240 msecs


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

If you want to change bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
