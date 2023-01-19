Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F35CC67474E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jan 2023 00:39:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbjASXjB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Jan 2023 18:39:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbjASXiz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Jan 2023 18:38:55 -0500
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67CC09EE0D
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Jan 2023 15:38:48 -0800 (PST)
Received: by mail-il1-f199.google.com with SMTP id q12-20020a056e0220ec00b0030f12525001so2702725ilv.10
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Jan 2023 15:38:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6ta3GJSvQKluL8qy5dUpvow33Jupa3fP0N6LAoWSxlk=;
        b=vfBEnL9/X/6JQq+Ji01MkNiFDqTZn25s/0gVrM8a26xzcJIxA8cC0XgXKj1l4rSvKq
         qwkv84EPi0MsgGoCqzxAzPjUUSiy6QvDFrZ2lb/v+MF+qe4tdLcEii3SULLYaJ5UKCWQ
         TN2bpc2z6FMLCxe63iYbnip6D4XKNId0UxhLPFITXe8dQqHuLMkfxMsk7SD+et1RqpSp
         M7EeBH1b1qZHjgvIZtnTUnOjoqq3PzeGHHdsjcpDvYYXmIxzSm8JNQyMDsAdHINikZdh
         OLqSafq3jzBl7PccgkomNkeHT3ep9RWiTw75i9Ht4ioReLE2Ze3JrMr2uIR4sZ4znndq
         tecA==
X-Gm-Message-State: AFqh2kroI02ZqlVYa/Qy07WRxx65mn/m8gBS7JPcggJ5/JgibJ0BhlvW
        tO2ehKJNMSe74EfjBwa0fWsynWvbozh2g+pe1lgmVNqJcqjz
X-Google-Smtp-Source: AMrXdXudJBi1dmW2gIaaJUd10BG5Ialm56pTGl4AWN7FzvGQLyNb3TOk4uN4ymKWFqb/9FaKOYPMpQ9sF3PUY9GEZCxBnugFUkFX
MIME-Version: 1.0
X-Received: by 2002:a02:ac96:0:b0:3a4:ab74:6924 with SMTP id
 x22-20020a02ac96000000b003a4ab746924mr1294316jan.303.1674171527647; Thu, 19
 Jan 2023 15:38:47 -0800 (PST)
Date:   Thu, 19 Jan 2023 15:38:47 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000032dc7305f2a66f46@google.com>
Subject: [syzbot] [btrfs?] INFO: task hung in extent_write_cache_pages
From:   syzbot <syzbot+cc35f55c41e34c30dcb5@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, clm@fb.com, dsterba@suse.com,
        josef@toxicpanda.com, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com,
        willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    7c6984405241 Merge tag 'iommu-fixes-v6.2-rc3' of git://git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1785447e480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ebc110f9741920ed
dashboard link: https://syzkaller.appspot.com/bug?extid=cc35f55c41e34c30dcb5
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=105b4136480000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12d4ba0e480000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b8f356c8d898/disk-7c698440.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6c7adfab3239/vmlinux-7c698440.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a5638e170c40/bzImage-7c698440.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/09ab9b4cd0af/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+cc35f55c41e34c30dcb5@syzkaller.appspotmail.com

INFO: task kworker/u4:5:1106 blocked for more than 143 seconds.
      Not tainted 6.2.0-rc3-syzkaller-00376-g7c6984405241 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/u4:5    state:D stack:17088 pid:1106  ppid:2      flags:0x00004000
Workqueue: writeback wb_workfn
 (flush-btrfs-21)
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5293 [inline]
 __schedule+0x995/0xe20 kernel/sched/core.c:6606
 schedule+0xcb/0x190 kernel/sched/core.c:6682
 io_schedule+0x83/0x100 kernel/sched/core.c:8862
 folio_wait_bit_common+0x83a/0x12a0 mm/filemap.c:1297
 extent_write_cache_pages+0x6c8/0x1220 fs/btrfs/extent_io.c:3071
 extent_writepages+0x219/0x540 fs/btrfs/extent_io.c:3211
 do_writepages+0x3c3/0x680 mm/page-writeback.c:2581
 __writeback_single_inode+0xd1/0x670 fs/fs-writeback.c:1598
 writeback_sb_inodes+0x812/0x1050 fs/fs-writeback.c:1889
 __writeback_inodes_wb+0x11d/0x260 fs/fs-writeback.c:1960
 wb_writeback+0x440/0x7b0 fs/fs-writeback.c:2065
 wb_check_background_flush fs/fs-writeback.c:2131 [inline]
 wb_do_writeback fs/fs-writeback.c:2219 [inline]
 wb_workfn+0xb3f/0xef0 fs/fs-writeback.c:2246
 process_one_work+0x877/0xdb0 kernel/workqueue.c:2289
 worker_thread+0xb14/0x1330 kernel/workqueue.c:2436
 kthread+0x266/0x300 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>
INFO: task syz-executor361:5668 blocked for more than 144 seconds.
      Not tainted 6.2.0-rc3-syzkaller-00376-g7c6984405241 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor361 state:D stack:20264 pid:5668  ppid:5119   flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5293 [inline]
 __schedule+0x995/0xe20 kernel/sched/core.c:6606
 schedule+0xcb/0x190 kernel/sched/core.c:6682
 wait_on_state fs/btrfs/extent-io-tree.c:707 [inline]
 wait_extent_bit+0x577/0x6f0 fs/btrfs/extent-io-tree.c:751
 lock_extent+0x1c2/0x280 fs/btrfs/extent-io-tree.c:1742
 find_lock_delalloc_range+0x4e6/0x9c0 fs/btrfs/extent_io.c:488
 writepage_delalloc+0x1ef/0x540 fs/btrfs/extent_io.c:1863
 __extent_writepage+0x736/0x14e0 fs/btrfs/extent_io.c:2174
 extent_write_cache_pages+0x983/0x1220 fs/btrfs/extent_io.c:3091
 extent_writepages+0x219/0x540 fs/btrfs/extent_io.c:3211
 do_writepages+0x3c3/0x680 mm/page-writeback.c:2581
 filemap_fdatawrite_wbc+0x11e/0x170 mm/filemap.c:388
 __filemap_fdatawrite_range mm/filemap.c:421 [inline]
 filemap_fdatawrite_range+0x175/0x200 mm/filemap.c:439
 btrfs_fdatawrite_range fs/btrfs/file.c:3850 [inline]
 start_ordered_ops fs/btrfs/file.c:1737 [inline]
 btrfs_sync_file+0x4ff/0x1190 fs/btrfs/file.c:1839
 generic_write_sync include/linux/fs.h:2885 [inline]
 btrfs_do_write_iter+0xcd3/0x1280 fs/btrfs/file.c:1684
 call_write_iter include/linux/fs.h:2189 [inline]
 new_sync_write fs/read_write.c:491 [inline]
 vfs_write+0x7dc/0xc50 fs/read_write.c:584
 ksys_write+0x177/0x2a0 fs/read_write.c:637
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f7d4054e9b9
RSP: 002b:00007f7d404fa2f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f7d405d87a0 RCX: 00007f7d4054e9b9
RDX: 0000000000000090 RSI: 0000000020000000 RDI: 0000000000000006
RBP: 00007f7d405a51d0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 61635f65646f6e69
R13: 65646f7475616f6e R14: 7261637369646f6e R15: 00007f7d405d87a8
 </TASK>
INFO: task syz-executor361:5697 blocked for more than 145 seconds.
      Not tainted 6.2.0-rc3-syzkaller-00376-g7c6984405241 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor361 state:D stack:21216 pid:5697  ppid:5119   flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5293 [inline]
 __schedule+0x995/0xe20 kernel/sched/core.c:6606
 schedule+0xcb/0x190 kernel/sched/core.c:6682
 rwsem_down_read_slowpath+0x5f9/0x930 kernel/locking/rwsem.c:1095
 __down_read_common+0x54/0x2a0 kernel/locking/rwsem.c:1260
 btrfs_page_mkwrite+0x417/0xc80 fs/btrfs/inode.c:8526
 do_page_mkwrite+0x19e/0x5e0 mm/memory.c:2947
 wp_page_shared+0x15e/0x380 mm/memory.c:3295
 handle_pte_fault mm/memory.c:4949 [inline]
 __handle_mm_fault mm/memory.c:5073 [inline]
 handle_mm_fault+0x1b79/0x26b0 mm/memory.c:5219
 do_user_addr_fault+0x69b/0xcb0 arch/x86/mm/fault.c:1428
 handle_page_fault arch/x86/mm/fault.c:1519 [inline]
 exc_page_fault+0x7a/0x110 arch/x86/mm/fault.c:1575
 asm_exc_page_fault+0x22/0x30 arch/x86/include/asm/idtentry.h:570
RIP: 0010:copy_user_short_string+0xd/0x40 arch/x86/lib/copy_user_64.S:233
Code: 74 0a 89 d1 f3 a4 89 c8 0f 01 ca c3 89 d0 0f 01 ca c3 01 ca eb e7 0f 1f 80 00 00 00 00 89 d1 83 e2 07 c1 e9 03 74 12 4c 8b 06 <4c> 89 07 48 8d 76 08 48 8d 7f 08 ff c9 75 ee 21 d2 74 10 89 d1 8a
RSP: 0018:ffffc9000570f330 EFLAGS: 00050202
RAX: ffffffff843e6601 RBX: 00007fffffffefc8 RCX: 0000000000000007
RDX: 0000000000000000 RSI: ffffc9000570f3e0 RDI: 0000000020000120
RBP: ffffc9000570f490 R08: 0000000000000000 R09: fffff52000ae1e83
R10: fffff52000ae1e83 R11: 1ffff92000ae1e7c R12: 0000000000000038
R13: ffffc9000570f3e0 R14: 0000000020000120 R15: ffffc9000570f3e0
 copy_user_generic arch/x86/include/asm/uaccess_64.h:37 [inline]
 raw_copy_to_user arch/x86/include/asm/uaccess_64.h:58 [inline]
 _copy_to_user+0xe9/0x130 lib/usercopy.c:34
 copy_to_user include/linux/uaccess.h:169 [inline]
 fiemap_fill_next_extent+0x22e/0x410 fs/ioctl.c:144
 emit_fiemap_extent+0x22d/0x3c0 fs/btrfs/extent_io.c:3458
 fiemap_process_hole+0xa00/0xad0 fs/btrfs/extent_io.c:3716
 extent_fiemap+0xe27/0x2100 fs/btrfs/extent_io.c:3922
 btrfs_fiemap+0x172/0x1e0 fs/btrfs/inode.c:8209
 ioctl_fiemap fs/ioctl.c:219 [inline]
 do_vfs_ioctl+0x185b/0x2980 fs/ioctl.c:810
 __do_sys_ioctl fs/ioctl.c:868 [inline]
 __se_sys_ioctl+0x83/0x170 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f7d4054e9b9
RSP: 002b:00007f7d390d92f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f7d405d87b0 RCX: 00007f7d4054e9b9
RDX: 0000000020000100 RSI: 00000000c020660b RDI: 0000000000000005
RBP: 00007f7d405a51d0 R08: 00007f7d390d9700 R09: 0000000000000000
R10: 00007f7d390d9700 R11: 0000000000000246 R12: 61635f65646f6e69
R13: 65646f7475616f6e R14: 7261637369646f6e R15: 00007f7d405d87b8
 </TASK>

Showing all locks held in the system:
1 lock held by rcu_tasks_kthre/12:
 #0: ffffffff8d326fd0 (rcu_tasks.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x30/0xd00 kernel/rcu/tasks.h:507
1 lock held by rcu_tasks_trace/13:
 #0: ffffffff8d3277d0 (rcu_tasks_trace.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x30/0xd00 kernel/rcu/tasks.h:507
1 lock held by khungtaskd/28:
 #0: ffffffff8d326e00 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire+0x0/0x30
5 locks held by kworker/u4:4/56:
3 locks held by kworker/u4:5/1106:
 #0: ffff888144e2b138 ((wq_completion)writeback){+.+.}-{0:0}, at: process_one_work+0x7f2/0xdb0
 #1: ffffc9000592fd00 ((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0}, at: process_one_work+0x831/0xdb0 kernel/workqueue.c:2264
 #2: ffff88807847c0e0 (&type->s_umount_key#42){++++}-{3:3}, at: trylock_super+0x1b/0xf0 fs/super.c:415
2 locks held by getty/4745:
 #0: ffff88802c0b3098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x21/0x70 drivers/tty/tty_ldisc.c:244
 #1: ffffc900015902f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x53b/0x1650 drivers/tty/n_tty.c:2177
4 locks held by syz-executor361/5668:
 #0: ffff88807a09f9e8 (&f->f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0x242/0x2e0 fs/file.c:1046
 #1: ffff88807847c460 (sb_writers#9){.+.+}-{0:0}, at: vfs_write+0x287/0xc50 fs/read_write.c:580
 #2: ffff888075485c80 (&sb->s_type->i_mutex_key#15){++++}-{3:3}, at: inode_lock include/linux/fs.h:756 [inline]
 #2: ffff888075485c80 (&sb->s_type->i_mutex_key#15){++++}-{3:3}, at: btrfs_inode_lock+0x49/0xd0 fs/btrfs/inode.c:192
 #3: ffff888075485b08 (&ei->i_mmap_lock){++++}-{3:3}, at: btrfs_inode_lock+0xc1/0xd0 fs/btrfs/inode.c:195
3 locks held by syz-executor361/5697:
 #0: ffff8880280b0a18 (&mm->mmap_lock){++++}-{3:3}, at: mmap_read_trylock include/linux/mmap_lock.h:136 [inline]
 #0: ffff8880280b0a18 (&mm->mmap_lock){++++}-{3:3}, at: do_user_addr_fault+0x2e2/0xcb0 arch/x86/mm/fault.c:1369
 #1: ffff88807847c558 (sb_pagefaults){.+.+}-{0:0}, at: do_page_mkwrite+0x19e/0x5e0 mm/memory.c:2947
 #2: ffff888075485b08 (&ei->i_mmap_lock){++++}-{3:3}, at: btrfs_page_mkwrite+0x417/0xc80 fs/btrfs/inode.c:8526
2 locks held by syz-executor361/7986:

=============================================

NMI backtrace for cpu 0
CPU: 0 PID: 28 Comm: khungtaskd Not tainted 6.2.0-rc3-syzkaller-00376-g7c6984405241 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1b1/0x290 lib/dump_stack.c:106
 nmi_cpu_backtrace+0x46f/0x4f0 lib/nmi_backtrace.c:111
 nmi_trigger_cpumask_backtrace+0x1ba/0x420 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:148 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:220 [inline]
 watchdog+0xcd5/0xd20 kernel/hung_task.c:377
 kthread+0x266/0x300 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 PID: 7984 Comm: syz-executor361 Not tainted 6.2.0-rc3-syzkaller-00376-g7c6984405241 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
RIP: 0033:0x7f7d4050527c
Code: 01 c2 49 3b 55 08 77 56 8d 55 ff 85 ed 74 35 0f 1f 80 00 00 00 00 48 39 c1 77 1c 49 8b 75 00 49 89 c1 49 29 c9 46 0f b6 0c 0e <45> 84 c9 74 08 44 88 0c 06 49 8b 45 10 48 83 c0 01 49 89 45 10 83
RSP: 002b:00007f7d404f9830 EFLAGS: 00000206
RAX: 0000000000da5bbf RBX: 00007f7d404f9890 RCX: 0000000000000001
RDX: 0000000000000016 RSI: 00007f7d380da000 RDI: 00007f7d404f9930
RBP: 0000000000000102 R08: 0000000000000015 R09: 0000000000000000
R10: 0000000000000000 R11: 00007f7d404f98a0 R12: 00007f7d404f98a0
R13: 00007f7d404f9930 R14: 0000000000000001 R15: 0000000000000000
FS:  00007f7d404fa700 GS:  0000000000000000


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
