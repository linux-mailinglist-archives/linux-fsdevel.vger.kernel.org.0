Return-Path: <linux-fsdevel+bounces-1890-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ED717DFC85
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Nov 2023 23:42:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69D5DB2139A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Nov 2023 22:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A64C2231D;
	Thu,  2 Nov 2023 22:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57BAF1DFD9
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Nov 2023 22:42:25 +0000 (UTC)
Received: from mail-oo1-f79.google.com (mail-oo1-f79.google.com [209.85.161.79])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34434138
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Nov 2023 15:42:19 -0700 (PDT)
Received: by mail-oo1-f79.google.com with SMTP id 006d021491bc7-581da38ec51so1787524eaf.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Nov 2023 15:42:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698964938; x=1699569738;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aUE0m0u3bkGN6Ok4lWPaHRKmZgqc8pe3r019AW+ZRzY=;
        b=AE0PBwIOQw4ehOVDyEoz+tQQpFIl8TzPZN159Iqcb7QEjDEV5a/fqIhlDgicUScBDT
         dQOuEwQUFQa2/o3bWaod9Eif22oVoQsgMU3T7Hlxc4kxLou8VO9HSmmyDwHA6gH5gPYp
         bQv6g7XwrjPIP5XACDo6k/xAID3z5XQiVUuzaznAj4vx9S6pZ2kcBeKLLq011JzgcTSX
         0h2V1fswuZ99T6FsVWoU7TYh5JB9U51xXYw53IJi/FlGKk7BK0xsZSlxsoyVFrS+kMhP
         6bYR8HEr+/fPQBmnJdU/iozWg9v343uZABEgS3qZ0Eh74DqpAK7bioRJWBYbMt9lcIRT
         YiBA==
X-Gm-Message-State: AOJu0Yxj6uJyZvyEwHIVtMTTWJ9Fj0wFyd7XF/A7Klfk8cvUYrH8Bmpb
	OwFQSiMo2IAy13bVlAsCAmNA4wxBJJWN1oGi4cZjfBYUyWCE
X-Google-Smtp-Source: AGHT+IGzT5zON+jrJVcbnN9E1PNHAPOemJPbLxQPnBf31p6Z2lUsOELno+kcBu7qRmjZPlgaHjl1FoegxKdPfXdMCaOacmGNDLhr
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6870:c796:b0:1f0:36b6:ef37 with SMTP id
 dy22-20020a056870c79600b001f036b6ef37mr1940783oab.4.1698964938570; Thu, 02
 Nov 2023 15:42:18 -0700 (PDT)
Date: Thu, 02 Nov 2023 15:42:18 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a6429e0609331930@google.com>
Subject: [syzbot] [btrfs?] KASAN: slab-use-after-free Read in btrfs_qgroup_account_extent
From: syzbot <syzbot+e0b615318f8fcfc01ceb@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    4652b8e4f3ff Merge tag '6.7-rc-ksmbd-server-fixes' of git:..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=148ee8cf680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d855e3560c4c99c4
dashboard link: https://syzkaller.appspot.com/bug?extid=e0b615318f8fcfc01ceb
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/162622d42235/disk-4652b8e4.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/62d46f58ffc9/vmlinux-4652b8e4.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d1062e5866ab/bzImage-4652b8e4.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e0b615318f8fcfc01ceb@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in __list_del_entry_valid_or_report+0x2f/0x130 lib/list_debug.c:49
Read of size 8 at addr ffff888028fe7cb0 by task kworker/u4:5/741

CPU: 0 PID: 741 Comm: kworker/u4:5 Not tainted 6.6.0-syzkaller-10396-g4652b8e4f3ff #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/09/2023
Workqueue: btrfs-qgroup-rescan btrfs_work_helper
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:364 [inline]
 print_report+0x163/0x540 mm/kasan/report.c:475
 kasan_report+0x175/0x1b0 mm/kasan/report.c:588
 __list_del_entry_valid_or_report+0x2f/0x130 lib/list_debug.c:49
 __list_del_entry_valid include/linux/list.h:124 [inline]
 __list_del_entry include/linux/list.h:215 [inline]
 list_del_init include/linux/list.h:287 [inline]
 qgroup_iterator_nested_clean fs/btrfs/qgroup.c:2623 [inline]
 btrfs_qgroup_account_extent+0x18b/0x1150 fs/btrfs/qgroup.c:2883
 qgroup_rescan_leaf fs/btrfs/qgroup.c:3543 [inline]
 btrfs_qgroup_rescan_worker+0x1078/0x1c60 fs/btrfs/qgroup.c:3604
 btrfs_work_helper+0x37c/0xbd0 fs/btrfs/async-thread.c:315
 process_one_work kernel/workqueue.c:2630 [inline]
 process_scheduled_works+0x90f/0x1400 kernel/workqueue.c:2703
 worker_thread+0xa5f/0xff0 kernel/workqueue.c:2784
 kthread+0x2d3/0x370 kernel/kthread.c:388
 ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
 </TASK>

Allocated by task 15683:
 kasan_save_stack mm/kasan/common.c:45 [inline]
 kasan_set_track+0x4f/0x70 mm/kasan/common.c:52
 ____kasan_kmalloc mm/kasan/common.c:374 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:383
 kmalloc include/linux/slab.h:600 [inline]
 kzalloc include/linux/slab.h:721 [inline]
 btrfs_quota_enable+0xee9/0x2060 fs/btrfs/qgroup.c:1209
 btrfs_ioctl_quota_ctl+0x143/0x190 fs/btrfs/ioctl.c:3705
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:871 [inline]
 __se_sys_ioctl+0xf8/0x170 fs/ioctl.c:857
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x44/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

Freed by task 15683:
 kasan_save_stack mm/kasan/common.c:45 [inline]
 kasan_set_track+0x4f/0x70 mm/kasan/common.c:52
 kasan_save_free_info+0x28/0x40 mm/kasan/generic.c:522
 ____kasan_slab_free+0xd6/0x120 mm/kasan/common.c:236
 kasan_slab_free include/linux/kasan.h:164 [inline]
 slab_free_hook mm/slub.c:1800 [inline]
 slab_free_freelist_hook mm/slub.c:1826 [inline]
 slab_free mm/slub.c:3809 [inline]
 __kmem_cache_free+0x263/0x3a0 mm/slub.c:3822
 btrfs_remove_qgroup+0x764/0x8c0 fs/btrfs/qgroup.c:1787
 btrfs_ioctl_qgroup_create+0x185/0x1e0 fs/btrfs/ioctl.c:3811
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:871 [inline]
 __se_sys_ioctl+0xf8/0x170 fs/ioctl.c:857
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x44/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

Last potentially related work creation:
 kasan_save_stack+0x3f/0x60 mm/kasan/common.c:45
 __kasan_record_aux_stack+0xad/0xc0 mm/kasan/generic.c:492
 __call_rcu_common kernel/rcu/tree.c:2667 [inline]
 call_rcu+0x167/0xa70 kernel/rcu/tree.c:2781
 kthread_worker_fn+0x4ba/0xa90 kernel/kthread.c:823
 kthread+0x2d3/0x370 kernel/kthread.c:388
 ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242

Second to last potentially related work creation:
 kasan_save_stack+0x3f/0x60 mm/kasan/common.c:45
 __kasan_record_aux_stack+0xad/0xc0 mm/kasan/generic.c:492
 insert_work+0x3e/0x320 kernel/workqueue.c:1647
 __queue_work+0xd00/0x1010 kernel/workqueue.c:1803
 call_timer_fn+0x17a/0x5e0 kernel/time/timer.c:1700
 expire_timers kernel/time/timer.c:1746 [inline]
 __run_timers+0x67a/0x860 kernel/time/timer.c:2022
 run_timer_softirq+0x67/0xf0 kernel/time/timer.c:2035
 __do_softirq+0x2bf/0x93a kernel/softirq.c:553

The buggy address belongs to the object at ffff888028fe7c00
 which belongs to the cache kmalloc-512 of size 512
The buggy address is located 176 bytes inside of
 freed 512-byte region [ffff888028fe7c00, ffff888028fe7e00)

The buggy address belongs to the physical page:
page:ffffea0000a3f900 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x28fe4
head:ffffea0000a3f900 order:2 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000840(slab|head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000000840 ffff888012c41c80 dead000000000100 dead000000000122
raw: 0000000000000000 0000000000100010 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 2, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 3643, tgid 3643 (kworker/u4:10), ts 20275525292, free_ts 0
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x1e6/0x210 mm/page_alloc.c:1536
 prep_new_page mm/page_alloc.c:1543 [inline]
 get_page_from_freelist+0x31db/0x3360 mm/page_alloc.c:3170
 __alloc_pages+0x255/0x670 mm/page_alloc.c:4426
 alloc_slab_page+0x6a/0x160 mm/slub.c:1870
 allocate_slab mm/slub.c:2017 [inline]
 new_slab+0x84/0x2f0 mm/slub.c:2070
 ___slab_alloc+0xc85/0x1310 mm/slub.c:3223
 __slab_alloc mm/slub.c:3322 [inline]
 __slab_alloc_node mm/slub.c:3375 [inline]
 slab_alloc_node mm/slub.c:3468 [inline]
 __kmem_cache_alloc_node+0x19d/0x270 mm/slub.c:3517
 kmalloc_trace+0x2a/0xe0 mm/slab_common.c:1098
 kmalloc include/linux/slab.h:600 [inline]
 kzalloc include/linux/slab.h:721 [inline]
 alloc_bprm+0x56/0x900 fs/exec.c:1514
 kernel_execve+0x96/0xa10 fs/exec.c:1989
 call_usermodehelper_exec_async+0x233/0x370 kernel/umh.c:110
 ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
page_owner free stack trace missing

Memory state around the buggy address:
 ffff888028fe7b80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888028fe7c00: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888028fe7c80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                     ^
 ffff888028fe7d00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888028fe7d80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

