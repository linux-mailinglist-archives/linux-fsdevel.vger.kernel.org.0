Return-Path: <linux-fsdevel+bounces-1975-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E617F7E10ED
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Nov 2023 21:44:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A84D7B20F94
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Nov 2023 20:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 622A5208A7;
	Sat,  4 Nov 2023 20:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DBD83C27
	for <linux-fsdevel@vger.kernel.org>; Sat,  4 Nov 2023 20:44:25 +0000 (UTC)
Received: from mail-oi1-f206.google.com (mail-oi1-f206.google.com [209.85.167.206])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2745E194
	for <linux-fsdevel@vger.kernel.org>; Sat,  4 Nov 2023 13:44:23 -0700 (PDT)
Received: by mail-oi1-f206.google.com with SMTP id 5614622812f47-3b56a1374afso4194186b6e.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 04 Nov 2023 13:44:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699130662; x=1699735462;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MZxWgtGIvHZlKV8iwRtqKbdNXmPRhZFV3dzHOIaGM+M=;
        b=IJ/vKaF2/EbU0Kaf2poqTaPnDFQ58ykTOGw7YrFNmtDaRYnygjY01VUR5nv6QcT4ws
         Ld8/QiAE5P+KZZGIvl8iucoR8K+0Nf5xnpx8qh8HUFT3oWo+xdKEUkNRIiZqr3y0B1GV
         lykXUnToh8nukFggWcI4gfpBX1+ux5FvBpBALU0ylBfmLjogxIr9yKir61wNCJcEFq0N
         DNdsBtGM1dnl56Gr1kVOtnrEMUim28zVVME7P6K5rYotgzdMcaLW36/MZlYqFxTa42R0
         hyv+7FouQ7NTxO6Rptaty5XB3cIMmO2Gx1fZBCIiyeAfO5kVlECy2wSzRzwhiK1SCUqe
         gLRA==
X-Gm-Message-State: AOJu0YznjalqRPWCCWfJLquC7N00RZLX/nM3EoOW3zbdjADy/eME6Q6+
	SVzjdPSzgB93H3igUAgkr15+1tZ1p/KtCtmPMH68AADk+3eT
X-Google-Smtp-Source: AGHT+IHAV7O5KVRPi70ba/7LCMVA4gIZWlPfFgdOuMPW7xe3zDBmZYmwMwtGNzUYeqjJFoULrXsKqb6D/elJ/DuHlDplOCR5vzaj
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:114c:b0:3b5:6462:3177 with SMTP id
 u12-20020a056808114c00b003b564623177mr5630322oiu.10.1699130662538; Sat, 04
 Nov 2023 13:44:22 -0700 (PDT)
Date: Sat, 04 Nov 2023 13:44:22 -0700
In-Reply-To: <000000000000a6429e0609331930@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000091528d060959afa6@google.com>
Subject: Re: [syzbot] [btrfs?] KASAN: slab-use-after-free Read in btrfs_qgroup_account_extent
From: syzbot <syzbot+e0b615318f8fcfc01ceb@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    90b0c2b2edd1 Merge tag 'pinctrl-v6.7-1' of git://git.kerne..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=108ff47b680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4cc8c922092464e7
dashboard link: https://syzkaller.appspot.com/bug?extid=e0b615318f8fcfc01ceb
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14cae708e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1354647b680000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/7221434504bc/disk-90b0c2b2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5688e9407000/vmlinux-90b0c2b2.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f733267e97b1/bzImage-90b0c2b2.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/92c0fab3d755/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e0b615318f8fcfc01ceb@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in __list_del_entry_valid_or_report+0x13e/0x1b0 lib/list_debug.c:49
Read of size 8 at addr ffff88802894b4b0 by task kworker/u4:3/48

CPU: 1 PID: 48 Comm: kworker/u4:3 Not tainted 6.6.0-syzkaller-14142-g90b0c2b2edd1 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/09/2023
Workqueue: btrfs-qgroup-rescan btrfs_work_helper
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:364 [inline]
 print_report+0xc4/0x620 mm/kasan/report.c:475
 kasan_report+0xda/0x110 mm/kasan/report.c:588
 __list_del_entry_valid_or_report+0x13e/0x1b0 lib/list_debug.c:49
 __list_del_entry_valid include/linux/list.h:124 [inline]
 __list_del_entry include/linux/list.h:215 [inline]
 list_del_init include/linux/list.h:287 [inline]
 qgroup_iterator_nested_clean fs/btrfs/qgroup.c:2623 [inline]
 btrfs_qgroup_account_extent+0x795/0x1020 fs/btrfs/qgroup.c:2883
 qgroup_rescan_leaf+0x6b4/0xc20 fs/btrfs/qgroup.c:3543
 btrfs_qgroup_rescan_worker+0x43a/0xa00 fs/btrfs/qgroup.c:3604
 btrfs_work_helper+0x210/0xbe0 fs/btrfs/async-thread.c:315
 process_one_work+0x884/0x15c0 kernel/workqueue.c:2630
 process_scheduled_works kernel/workqueue.c:2703 [inline]
 worker_thread+0x8b9/0x1290 kernel/workqueue.c:2784
 kthread+0x33c/0x440 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
 </TASK>

Allocated by task 16724:
 kasan_save_stack+0x33/0x50 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 ____kasan_kmalloc mm/kasan/common.c:374 [inline]
 __kasan_kmalloc+0xa2/0xb0 mm/kasan/common.c:383
 kmalloc include/linux/slab.h:600 [inline]
 kzalloc include/linux/slab.h:721 [inline]
 btrfs_quota_enable+0xb0b/0x1eb0 fs/btrfs/qgroup.c:1209
 btrfs_ioctl_quota_ctl fs/btrfs/ioctl.c:3705 [inline]
 btrfs_ioctl+0x4caf/0x5d90 fs/btrfs/ioctl.c:4668
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:871 [inline]
 __se_sys_ioctl fs/ioctl.c:857 [inline]
 __x64_sys_ioctl+0x18f/0x210 fs/ioctl.c:857
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x3f/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

Freed by task 16724:
 kasan_save_stack+0x33/0x50 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 kasan_save_free_info+0x2b/0x40 mm/kasan/generic.c:522
 ____kasan_slab_free mm/kasan/common.c:236 [inline]
 ____kasan_slab_free+0x15b/0x1b0 mm/kasan/common.c:200
 kasan_slab_free include/linux/kasan.h:164 [inline]
 slab_free_hook mm/slub.c:1800 [inline]
 slab_free_freelist_hook+0x114/0x1e0 mm/slub.c:1826
 slab_free mm/slub.c:3809 [inline]
 __kmem_cache_free+0xc0/0x180 mm/slub.c:3822
 btrfs_remove_qgroup+0x541/0x7c0 fs/btrfs/qgroup.c:1787
 btrfs_ioctl_qgroup_create fs/btrfs/ioctl.c:3811 [inline]
 btrfs_ioctl+0x5042/0x5d90 fs/btrfs/ioctl.c:4672
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:871 [inline]
 __se_sys_ioctl fs/ioctl.c:857 [inline]
 __x64_sys_ioctl+0x18f/0x210 fs/ioctl.c:857
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x3f/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

Last potentially related work creation:
 kasan_save_stack+0x33/0x50 mm/kasan/common.c:45
 __kasan_record_aux_stack+0xbc/0xd0 mm/kasan/generic.c:492
 __call_rcu_common.constprop.0+0x9a/0x790 kernel/rcu/tree.c:2667
 pwq_release_workfn+0x244/0x380 kernel/workqueue.c:4138
 kthread_worker_fn+0x2ff/0xac0 kernel/kthread.c:841
 kthread+0x33c/0x440 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242

Second to last potentially related work creation:
 kasan_save_stack+0x33/0x50 mm/kasan/common.c:45
 __kasan_record_aux_stack+0xbc/0xd0 mm/kasan/generic.c:492
 __call_rcu_common.constprop.0+0x9a/0x790 kernel/rcu/tree.c:2667
 pwq_release_workfn+0x244/0x380 kernel/workqueue.c:4138
 kthread_worker_fn+0x2ff/0xac0 kernel/kthread.c:841
 kthread+0x33c/0x440 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242

The buggy address belongs to the object at ffff88802894b400
 which belongs to the cache kmalloc-512 of size 512
The buggy address is located 176 bytes inside of
 freed 512-byte region [ffff88802894b400, ffff88802894b600)

The buggy address belongs to the physical page:
page:ffffea0000a25200 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x28948
head:ffffea0000a25200 order:2 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000840(slab|head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000000840 ffff888013041c80 ffffea000072a700 dead000000000002
raw: 0000000000000000 0000000000100010 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 2, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 1, tgid 1 (swapper/0), ts 10886426299, free_ts 0
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x2cf/0x340 mm/page_alloc.c:1537
 prep_new_page mm/page_alloc.c:1544 [inline]
 get_page_from_freelist+0xa25/0x36c0 mm/page_alloc.c:3312
 __alloc_pages+0x1d0/0x4a0 mm/page_alloc.c:4568
 alloc_pages_mpol+0x258/0x5f0 mm/mempolicy.c:2133
 alloc_slab_page mm/slub.c:1870 [inline]
 allocate_slab+0x251/0x380 mm/slub.c:2017
 new_slab mm/slub.c:2070 [inline]
 ___slab_alloc+0x8c7/0x1580 mm/slub.c:3223
 __slab_alloc.constprop.0+0x56/0xa0 mm/slub.c:3322
 __slab_alloc_node mm/slub.c:3375 [inline]
 slab_alloc_node mm/slub.c:3468 [inline]
 __kmem_cache_alloc_node+0x131/0x310 mm/slub.c:3517
 __do_kmalloc_node mm/slab_common.c:1006 [inline]
 __kmalloc_node_track_caller+0x50/0x100 mm/slab_common.c:1027
 __do_krealloc mm/slab_common.c:1395 [inline]
 krealloc+0x5d/0x100 mm/slab_common.c:1428
 add_sysfs_param+0xca/0x960 kernel/params.c:652
 kernel_add_sysfs_param kernel/params.c:813 [inline]
 param_sysfs_builtin kernel/params.c:852 [inline]
 param_sysfs_builtin_init+0x2ca/0x450 kernel/params.c:986
 do_one_initcall+0x11c/0x640 init/main.c:1236
 do_initcall_level init/main.c:1298 [inline]
 do_initcalls init/main.c:1314 [inline]
 do_basic_setup init/main.c:1333 [inline]
 kernel_init_freeable+0x5c2/0x900 init/main.c:1551
 kernel_init+0x1c/0x2a0 init/main.c:1441
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
page_owner free stack trace missing

Memory state around the buggy address:
 ffff88802894b380: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88802894b400: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88802894b480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                     ^
 ffff88802894b500: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88802894b580: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

