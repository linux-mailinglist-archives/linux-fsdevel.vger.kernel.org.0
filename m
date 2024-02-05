Return-Path: <linux-fsdevel+bounces-10248-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A09A08495CB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 10:02:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15F881F239E2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 09:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E93FF125B6;
	Mon,  5 Feb 2024 09:01:46 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A1912E41
	for <linux-fsdevel@vger.kernel.org>; Mon,  5 Feb 2024 09:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707123706; cv=none; b=PdHPTPZBi4WWhMOf/jHS6WHbsk57/unfMeHoMdnQahnF2xR2IamlZxDB4NOLSwZqliv6Avqk/B3dvfZMZMSVdAJaboPf2mQSZeFfgk6NcijxCixreqdOJkXlC18ooq9NnsyyKji+71T2Yxk2zE0N1VL5CyVzpmblmZqJxKlDWKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707123706; c=relaxed/simple;
	bh=Z0Pj8klAftS8G3W/GFV0wmiGxNYk8xreD9LKvhOhD4I=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Pq8QzRBKFqeMeDsGkIcf1Y7ToG65kIS6L12a4uB1+MCz2O7Jn1W6vJjzoU8eEmmpPpSjw8UYTwL1N0zXqD++5x1u4sd659+jCHlKXBTWlonAwsahXmcoYgQH4zDrqIP4JjeCGvMVVai7Z5uX5ua/AUdZ6lMw2yGRnvOgHcENe8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-363c51d0b44so8090825ab.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 05 Feb 2024 01:01:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707123704; x=1707728504;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tOu83LdVS7vkg0FGTsfFSKxR4O77t46AZNefVR76Dis=;
        b=Xk1syKJhcOFNEvjWxBpSjcpOpd74TeGcXHuyfIkxSvw75TgZ4BcY0p2HG1N49NII6B
         hNwtaSq/n2XcfkMWwBTcIRUoRpUlmlFtYNEAS0JoZcV7dcQtimZPhibPNt/ztZYvQZ8d
         MJtvimXnlFa2OkIhfuiybHtvHsi7I0+rXqb2R/gwFRrTYXSP13/3qp3lwZ/gQMTeG0cX
         Y1eBT7gUE5CNSkoJv0Sku4GnS7388Zje6MP7uIj/9jOo8yXSE3H8MSKk0LBO2X6iI1ij
         6fcjkiWvcyo/oy7vcDw9clI3KWEehryza3a/nKgEytbJkAmo400oFZ+DJ99O/AIBIp7j
         Tnxw==
X-Gm-Message-State: AOJu0Yw03LE5l8Eq4vxy0RBQmiKMXHBOA/3sxi5Ja1ilZltQEQIGgT1l
	TiLFyDyEuE7GyCNKGeCvF6D7J+eF/TjTzmKUJwyXmqneDuZqgJN6cdPcslJPoHm0IXPyygFC29K
	LltdptW9wzprEsbMMqcL9V1uC4qJeRx/nDvJ6yJT4FnAUcWkWNrlRjYol/w==
X-Google-Smtp-Source: AGHT+IHi7kyf6J6Le1UctT8g6Jzr2P2WlvmBqbzm6pnkcFn9SOep5z04DdTiuUrVFbzy4VwPbNCJrSZG2ogiOdRqsYvaAOpOVM6z
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2165:b0:363:8f06:80b7 with SMTP id
 s5-20020a056e02216500b003638f0680b7mr1033038ilv.2.1707123703979; Mon, 05 Feb
 2024 01:01:43 -0800 (PST)
Date: Mon, 05 Feb 2024 01:01:43 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f6a86906109eb5b8@google.com>
Subject: [syzbot] [hfs?] KASAN: invalid-free in hfs_release_folio (2)
From: syzbot <syzbot+be88fd56f9769df61aee@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    54be6c6c5ae8 Linux 6.8-rc3
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1621a560180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=887796c7e5ffc20a
dashboard link: https://syzkaller.appspot.com/bug?extid=be88fd56f9769df61aee
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-54be6c6c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a27c83e3f15d/vmlinux-54be6c6c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0a4029d29e62/bzImage-54be6c6c.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+be88fd56f9769df61aee@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: double-free in hfs_release_folio+0x435/0x570 fs/hfs/inode.c:118
Free of addr ffff88804e23b760 by task kswapd0/109

CPU: 1 PID: 109 Comm: kswapd0 Not tainted 6.8.0-rc3-syzkaller #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0xc4/0x620 mm/kasan/report.c:488
 kasan_report_invalid_free+0xab/0xd0 mm/kasan/report.c:563
 poison_slab_object mm/kasan/common.c:233 [inline]
 __kasan_slab_free+0x197/0x1c0 mm/kasan/common.c:257
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2121 [inline]
 slab_free mm/slub.c:4299 [inline]
 kfree+0x124/0x370 mm/slub.c:4409
 hfs_release_folio+0x435/0x570 fs/hfs/inode.c:118
 filemap_release_folio+0x1f1/0x280 mm/filemap.c:4088
 shrink_folio_list+0x2933/0x3ea0 mm/vmscan.c:1369
 evict_folios+0x6e7/0x1b90 mm/vmscan.c:4521
 try_to_shrink_lruvec+0x638/0xa10 mm/vmscan.c:4726
 shrink_one+0x3f8/0x7b0 mm/vmscan.c:4765
 shrink_many mm/vmscan.c:4828 [inline]
 lru_gen_shrink_node mm/vmscan.c:4929 [inline]
 shrink_node+0x21d0/0x3790 mm/vmscan.c:5888
 kswapd_shrink_node mm/vmscan.c:6693 [inline]
 balance_pgdat+0x9d2/0x1a90 mm/vmscan.c:6883
 kswapd+0x5be/0xc00 mm/vmscan.c:7143
 kthread+0x2c6/0x3b0 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1b/0x30 arch/x86/entry/entry_64.S:242
 </TASK>

Allocated by task 15903:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:372 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:389
 kasan_kmalloc include/linux/kasan.h:211 [inline]
 __do_kmalloc_node mm/slub.c:3981 [inline]
 __kmalloc+0x1f9/0x440 mm/slub.c:3994
 kmalloc include/linux/slab.h:594 [inline]
 kzalloc include/linux/slab.h:711 [inline]
 __hfs_bnode_create+0x108/0x860 fs/hfs/bnode.c:259
 hfs_bnode_find+0x2d1/0xc50 fs/hfs/bnode.c:335
 hfs_brec_find+0x2af/0x510 fs/hfs/bfind.c:126
 hfs_brec_read+0x26/0x120 fs/hfs/bfind.c:165
 hfs_cat_find_brec+0x18c/0x3a0 fs/hfs/catalog.c:194
 hfs_fill_super+0x11e0/0x1870 fs/hfs/super.c:419
 mount_bdev+0x1e3/0x2d0 fs/super.c:1663
 legacy_get_tree+0x109/0x220 fs/fs_context.c:662
 vfs_get_tree+0x8f/0x380 fs/super.c:1784
 do_new_mount fs/namespace.c:3352 [inline]
 path_mount+0x6e2/0x1f10 fs/namespace.c:3679
 do_mount fs/namespace.c:3692 [inline]
 __do_sys_mount fs/namespace.c:3898 [inline]
 __se_sys_mount fs/namespace.c:3875 [inline]
 __ia32_sys_mount+0x295/0x320 fs/namespace.c:3875
 do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
 __do_fast_syscall_32+0x7c/0x120 arch/x86/entry/common.c:321
 do_fast_syscall_32+0x33/0x80 arch/x86/entry/common.c:346
 entry_SYSENTER_compat_after_hwframe+0x7c/0x86

Freed by task 5220:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 kasan_save_free_info+0x3f/0x60 mm/kasan/generic.c:640
 poison_slab_object mm/kasan/common.c:241 [inline]
 __kasan_slab_free+0x121/0x1c0 mm/kasan/common.c:257
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2121 [inline]
 slab_free mm/slub.c:4299 [inline]
 kfree+0x124/0x370 mm/slub.c:4409
 hfs_btree_close+0xac/0x390 fs/hfs/btree.c:154
 hfs_mdb_put+0xbf/0x380 fs/hfs/mdb.c:360
 generic_shutdown_super+0x159/0x3d0 fs/super.c:646
 kill_block_super+0x3b/0x90 fs/super.c:1680
 deactivate_locked_super+0xbe/0x1a0 fs/super.c:477
 deactivate_super+0xde/0x100 fs/super.c:510
 cleanup_mnt+0x222/0x450 fs/namespace.c:1267
 task_work_run+0x14f/0x250 kernel/task_work.c:180
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:108 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:201 [inline]
 syscall_exit_to_user_mode+0x281/0x2b0 kernel/entry/common.c:212
 __do_fast_syscall_32+0x8c/0x120 arch/x86/entry/common.c:324
 do_fast_syscall_32+0x33/0x80 arch/x86/entry/common.c:346
 entry_SYSENTER_compat_after_hwframe+0x7c/0x86

The buggy address belongs to the object at ffff88804e23b760
 which belongs to the cache kmalloc-192 of size 192
The buggy address is located 0 bytes inside of
 192-byte region [ffff88804e23b760, ffff88804e23b820)

The buggy address belongs to the physical page:
page:ffffea0001388e80 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x4e23a
head:ffffea0001388e80 order:1 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0x4fff00000000840(slab|head|node=1|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 04fff00000000840 ffff888014c42a00 ffffea0001499000 dead000000000002
raw: 0000000000000000 00000000001e001e 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 1, migratetype Unmovable, gfp_mask 0x1d20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_HARDWALL), pid 5220, tgid 5220 (syz-executor.2), ts 205141987347, free_ts 204536887129
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x2d4/0x350 mm/page_alloc.c:1533
 prep_new_page mm/page_alloc.c:1540 [inline]
 get_page_from_freelist+0xa28/0x3780 mm/page_alloc.c:3311
 __alloc_pages+0x22f/0x2440 mm/page_alloc.c:4567
 __alloc_pages_node include/linux/gfp.h:238 [inline]
 alloc_pages_node include/linux/gfp.h:261 [inline]
 alloc_slab_page mm/slub.c:2190 [inline]
 allocate_slab mm/slub.c:2354 [inline]
 new_slab+0xcc/0x3a0 mm/slub.c:2407
 ___slab_alloc+0x4b0/0x1780 mm/slub.c:3540
 __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3625
 __slab_alloc_node mm/slub.c:3678 [inline]
 slab_alloc_node mm/slub.c:3850 [inline]
 __do_kmalloc_node mm/slub.c:3980 [inline]
 __kmalloc_node+0x361/0x470 mm/slub.c:3988
 kmalloc_array_node include/linux/slab.h:688 [inline]
 kcalloc_node include/linux/slab.h:693 [inline]
 memcg_alloc_slab_cgroups+0xa9/0x180 mm/memcontrol.c:3009
 __memcg_slab_post_alloc_hook+0xa3/0x370 mm/slub.c:1970
 memcg_slab_post_alloc_hook mm/slub.c:1993 [inline]
 slab_post_alloc_hook mm/slub.c:3822 [inline]
 slab_alloc_node mm/slub.c:3860 [inline]
 kmem_cache_alloc+0x314/0x320 mm/slub.c:3867
 kmem_cache_zalloc include/linux/slab.h:701 [inline]
 copy_signal kernel/fork.c:1855 [inline]
 copy_process+0x395d/0x6e30 kernel/fork.c:2494
 kernel_clone+0xfd/0x930 kernel/fork.c:2902
 __do_compat_sys_ia32_clone+0xb7/0x100 arch/x86/kernel/sys_ia32.c:254
 do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
 __do_fast_syscall_32+0x7c/0x120 arch/x86/entry/common.c:321
 do_fast_syscall_32+0x33/0x80 arch/x86/entry/common.c:346
 entry_SYSENTER_compat_after_hwframe+0x7c/0x86
page last free pid 6083 tgid 6083 stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1140 [inline]
 free_unref_page_prepare+0x527/0xb10 mm/page_alloc.c:2346
 free_unref_page+0x33/0x3c0 mm/page_alloc.c:2486
 __put_partials+0x14c/0x170 mm/slub.c:2922
 qlink_free mm/kasan/quarantine.c:160 [inline]
 qlist_free_all+0x58/0x150 mm/kasan/quarantine.c:176
 kasan_quarantine_reduce+0x192/0x1e0 mm/kasan/quarantine.c:283
 __kasan_slab_alloc+0x69/0x90 mm/kasan/common.c:324
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slub.c:3813 [inline]
 slab_alloc_node mm/slub.c:3860 [inline]
 kmem_cache_alloc+0x136/0x320 mm/slub.c:3867
 vm_area_dup+0x21/0x300 kernel/fork.c:480
 dup_mmap kernel/fork.c:695 [inline]
 dup_mm kernel/fork.c:1685 [inline]
 copy_mm+0xf93/0x2860 kernel/fork.c:1734
 copy_process+0x4031/0x6e30 kernel/fork.c:2497
 kernel_clone+0xfd/0x930 kernel/fork.c:2902
 __do_sys_clone+0xba/0x100 kernel/fork.c:3045
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xd5/0x270 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x6f/0x77

Memory state around the buggy address:
 ffff88804e23b600: fc fc fc fc fc fc fc fc fc fc 00 00 00 00 00 00
 ffff88804e23b680: 00 00 00 00 00 00 00 00 00 00 04 fc fc fc fc fc
>ffff88804e23b700: fc fc fc fc fc fc fc fc fc fc fc fc fa fb fb fb
                                                       ^
 ffff88804e23b780: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88804e23b800: fb fb fb fb fc fc fc fc fc fc fc fc fc fc 00 00
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

