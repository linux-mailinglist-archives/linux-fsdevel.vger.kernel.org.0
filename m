Return-Path: <linux-fsdevel+bounces-38869-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93463A09309
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 15:10:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89DA316A2D9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 14:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A82A320FABB;
	Fri, 10 Jan 2025 14:10:30 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6471A20FAA4
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jan 2025 14:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736518230; cv=none; b=JI6UH9vKL3a1kDVS+YHYbkSPcVxVKS3kUYNTVf2aoBXf/fy8MbWS3VHOK3xpOIOgLcLpgyazLXGGbDBfO7G6LbMfnPgO7deS5wTBoCFMOdFidDTM+hr5A/h/tIfB0g3/qeLHYodNLj9l9N0TyKDyuxexTTR0nk+CUOUW6zNH5dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736518230; c=relaxed/simple;
	bh=ccph1KyUF7AFzcZbK6y/PvppLVGhIR7ClfctInf5V8E=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=DOuK2u0XR4EAymRZBhm2kajaJ5OVM/GyvvaT4woHrmGyaCGO2FMoOesYyv3ueRW5W0l7ZZkOuBEAxYOV+ZXd2ZpzfblnVIsYb1Rz/yhbCQB5Jf9tnDnOc8bcR5l7twuJ1zaA8li10nRT3Zn+Etk/xt+9wKKLh6BU7on6Ghr5r0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3a814bfb77bso30012525ab.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jan 2025 06:10:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736518227; x=1737123027;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SX/DqYHv8uT5dSMD2EBOOQW0t3JMgJmlHIdbzov7zHM=;
        b=o5YtcZxGj4MBvMei30KmL2hNieDfjwZWm1LmFJDTQyIQi+Ac0qEmxKCfT4skNpEWNW
         atsvH8h1mY877cNhggO0BHb0xjjXNwz/RBmAqxISRkRv5270zE8ndrISahaBG0NT3ApH
         9wLfPnb9eoq62lQ5E7XsZGUS4PBKy1HTll3nWqME9CD6NJ0IYoxZGDS27IvjuU7NynRl
         fg2cKc+9KoXVdqD4NBYH2FCv3218xsEqSYOGRE/XNW2eKAtGO6M0Y7x5ADCDUCS0xe4S
         DOohdrIqlSYElBiEpDQ8mNowEXrDoGTN9tW4myWP9t/hXSDFJCPDcL2DFbqx97QRpcy0
         +GNA==
X-Forwarded-Encrypted: i=1; AJvYcCURJFuAzuSsXY25Mo/1nOCP+Sxq+eHmX7AfhzaTkPj1aDlex60oS3izVO4y5LA6QnaKrEc+G42EmbQml5ss@vger.kernel.org
X-Gm-Message-State: AOJu0YwazMQItQw7vaS/Gthz5xS/4TKjZgnahS/Ihf7HgFOWY//+Vso0
	T/cwdlAPVPDSs/pLPasDnlg/30qfrtjuVRXlilkG2Sdil+o4bcxNKW6tiuuvqXW4gaRdgS2TB3u
	Z0+1v4CVAE/YsUWWM6IMXMnXrhCdH8/8vn+wP5V5D3Qaul/up9kEsjJ8=
X-Google-Smtp-Source: AGHT+IF87Q/AXRDKtZ0DulEuuX6Sh8NXi6QfkewKQr8WLQQMJJFAZLX5PCH3A/4a5sEIz6LpPzC8zuxVPkOSw7UvFk7DtGS4ZZ6w
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:17c6:b0:3ce:34fb:fdac with SMTP id
 e9e14a558f8ab-3ce47575fa7mr46033335ab.5.1736518227577; Fri, 10 Jan 2025
 06:10:27 -0800 (PST)
Date: Fri, 10 Jan 2025 06:10:27 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67812a53.050a0220.d0267.002c.GAE@google.com>
Subject: [syzbot] [exfat?] KASAN: slab-use-after-free Read in __find_get_block
From: syzbot <syzbot+1e866890c43f9d63c837@syzkaller.appspotmail.com>
To: linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sj1557.seo@samsung.com, 
	syzkaller-bugs@googlegroups.com, yuezhang.mo@sony.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    8379578b11d5 Merge tag 'for-v6.13-rc' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11c33018580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d269ef41b9262400
dashboard link: https://syzkaller.appspot.com/bug?extid=1e866890c43f9d63c837
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-8379578b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/46152cb37ce6/vmlinux-8379578b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b14facfd62b8/bzImage-8379578b.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1e866890c43f9d63c837@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 256
=======================================================
WARNING: The mand mount option has been deprecated and
         and is ignored by this kernel. Remove the mand
         option from the mount to silence this warning.
=======================================================
exfat: Deprecated parameter 'namecase'
exFAT-fs (loop0): failed to load upcase table (idx : 0x00010000, chksum : 0x1cbb3694, utbl_chksum : 0xe619d30d)
exFAT-fs (loop0): error, in sector 160, dentry 5 should be unused, but 0xc1
==================================================================
BUG: KASAN: slab-use-after-free in lookup_bh_lru fs/buffer.c:1367 [inline]
BUG: KASAN: slab-use-after-free in __find_get_block+0x4af/0x1150 fs/buffer.c:1394
Read of size 8 at addr ffff888012c451e8 by task syz.0.0/5316

CPU: 0 UID: 0 PID: 5316 Comm: syz.0.0 Not tainted 6.13.0-rc4-syzkaller-00069-g8379578b11d5 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:489
 kasan_report+0x143/0x180 mm/kasan/report.c:602
 lookup_bh_lru fs/buffer.c:1367 [inline]
 __find_get_block+0x4af/0x1150 fs/buffer.c:1394
 sb_find_get_block include/linux/buffer_head.h:398 [inline]
 exfat_dir_readahead fs/exfat/dir.c:642 [inline]
 exfat_get_dentry+0x369/0x730 fs/exfat/dir.c:670
 exfat_find_dir_entry+0x56a/0x29c0 fs/exfat/dir.c:1028
 exfat_find fs/exfat/namei.c:629 [inline]
 exfat_lookup+0x810/0x1e70 fs/exfat/namei.c:727
 lookup_open fs/namei.c:3627 [inline]
 open_last_lookups fs/namei.c:3748 [inline]
 path_openat+0x11a7/0x3590 fs/namei.c:3984
 do_filp_open+0x27f/0x4e0 fs/namei.c:4014
 do_sys_openat2+0x13e/0x1d0 fs/open.c:1402
 do_sys_open fs/open.c:1417 [inline]
 __do_sys_openat fs/open.c:1433 [inline]
 __se_sys_openat fs/open.c:1428 [inline]
 __x64_sys_openat+0x247/0x2a0 fs/open.c:1428
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f2064f85d29
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f20649fe038 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00007f2065175fa0 RCX: 00007f2064f85d29
RDX: 0000000000105042 RSI: 0000000020000080 RDI: ffffffffffffff9c
RBP: 00007f2065001b08 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000000001db R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f2065175fa0 R15: 00007fff73a00208
 </TASK>

Allocated by task 5316:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 unpoison_slab_object mm/kasan/common.c:319 [inline]
 __kasan_slab_alloc+0x66/0x80 mm/kasan/common.c:345
 kasan_slab_alloc include/linux/kasan.h:250 [inline]
 slab_post_alloc_hook mm/slub.c:4119 [inline]
 slab_alloc_node mm/slub.c:4168 [inline]
 kmem_cache_alloc_noprof+0x1d9/0x380 mm/slub.c:4175
 alloc_buffer_head+0x2a/0x290 fs/buffer.c:3015
 folio_alloc_buffers+0x31f/0x640 fs/buffer.c:924
 grow_dev_folio fs/buffer.c:1064 [inline]
 grow_buffers fs/buffer.c:1105 [inline]
 __getblk_slow fs/buffer.c:1131 [inline]
 bdev_getblk+0x2af/0x670 fs/buffer.c:1431
 __breadahead+0x2b/0x240 fs/buffer.c:1440
 sb_breadahead include/linux/buffer_head.h:358 [inline]
 exfat_dir_readahead fs/exfat/dir.c:647 [inline]
 exfat_get_dentry+0x464/0x730 fs/exfat/dir.c:670
 exfat_create_upcase_table+0x242/0xf60 fs/exfat/nls.c:758
 __exfat_fill_super fs/exfat/super.c:628 [inline]
 exfat_fill_super+0x1196/0x2920 fs/exfat/super.c:678
 get_tree_bdev_flags+0x48c/0x5c0 fs/super.c:1636
 vfs_get_tree+0x90/0x2b0 fs/super.c:1814
 do_new_mount+0x2be/0xb40 fs/namespace.c:3507
 do_mount fs/namespace.c:3847 [inline]
 __do_sys_mount fs/namespace.c:4057 [inline]
 __se_sys_mount+0x2d6/0x3c0 fs/namespace.c:4034
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 5316:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:582
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x59/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2353 [inline]
 slab_free mm/slub.c:4613 [inline]
 kmem_cache_free+0x195/0x410 mm/slub.c:4715
 free_buffer_head+0x54/0x240 fs/buffer.c:3031
 try_to_free_buffers+0x2fa/0x3b0 fs/buffer.c:2972
 shrink_folio_list+0x241e/0x5ca0 mm/vmscan.c:1433
 evict_folios+0x3c86/0x5800 mm/vmscan.c:4593
 try_to_shrink_lruvec+0x9a6/0xc70 mm/vmscan.c:4789
 shrink_one+0x3b9/0x850 mm/vmscan.c:4834
 shrink_many mm/vmscan.c:4897 [inline]
 lru_gen_shrink_node mm/vmscan.c:4975 [inline]
 shrink_node+0x37c5/0x3e50 mm/vmscan.c:5956
 shrink_zones mm/vmscan.c:6215 [inline]
 do_try_to_free_pages+0x78c/0x1cf0 mm/vmscan.c:6277
 try_to_free_pages+0x47c/0x1050 mm/vmscan.c:6527
 __perform_reclaim mm/page_alloc.c:3929 [inline]
 __alloc_pages_direct_reclaim+0x178/0x3c0 mm/page_alloc.c:3951
 __alloc_pages_slowpath+0x764/0x1020 mm/page_alloc.c:4382
 __alloc_pages_noprof+0x49b/0x710 mm/page_alloc.c:4766
 alloc_pages_mpol_noprof+0x3e8/0x680 mm/mempolicy.c:2269
 folio_alloc_mpol_noprof+0x36/0x50 mm/mempolicy.c:2287
 shmem_alloc_folio mm/shmem.c:1798 [inline]
 shmem_alloc_and_add_folio+0x4a0/0x1080 mm/shmem.c:1837
 shmem_get_folio_gfp+0x621/0x1840 mm/shmem.c:2357
 shmem_get_folio mm/shmem.c:2463 [inline]
 shmem_write_begin+0x165/0x350 mm/shmem.c:3119
 generic_perform_write+0x346/0x990 mm/filemap.c:4055
 shmem_file_write_iter+0xf9/0x120 mm/shmem.c:3295
 new_sync_write fs/read_write.c:586 [inline]
 vfs_write+0xaeb/0xd30 fs/read_write.c:679
 ksys_write+0x18f/0x2b0 fs/read_write.c:731
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff888012c451d0
 which belongs to the cache buffer_head of size 168
The buggy address is located 24 bytes inside of
 freed 168-byte region [ffff888012c451d0, ffff888012c45278)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x12c45
memcg:ffff888000223a01
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000000 ffff88801c2eadc0 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000110011 00000001f5000000 ffff888000223a01
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Reclaimable, gfp_mask 0x52810(GFP_NOWAIT|__GFP_NORETRY|__GFP_COMP|__GFP_RECLAIMABLE), pid 5316, tgid 5315 (syz.0.0), ts 69189616209, free_ts 41366811191
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1558
 prep_new_page mm/page_alloc.c:1566 [inline]
 get_page_from_freelist+0x365c/0x37a0 mm/page_alloc.c:3476
 __alloc_pages_slowpath+0x414/0x1020 mm/page_alloc.c:4288
 __alloc_pages_noprof+0x49b/0x710 mm/page_alloc.c:4766
 alloc_pages_mpol_noprof+0x3e8/0x680 mm/mempolicy.c:2269
 alloc_slab_page+0x6a/0x110 mm/slub.c:2423
 allocate_slab+0x5a/0x2b0 mm/slub.c:2589
 new_slab mm/slub.c:2642 [inline]
 ___slab_alloc+0xc27/0x14a0 mm/slub.c:3830
 __slab_alloc+0x58/0xa0 mm/slub.c:3920
 __slab_alloc_node mm/slub.c:3995 [inline]
 slab_alloc_node mm/slub.c:4156 [inline]
 kmem_cache_alloc_noprof+0x268/0x380 mm/slub.c:4175
 alloc_buffer_head+0x2a/0x290 fs/buffer.c:3015
 folio_alloc_buffers+0x31f/0x640 fs/buffer.c:924
 grow_dev_folio fs/buffer.c:1064 [inline]
 grow_buffers fs/buffer.c:1105 [inline]
 __getblk_slow fs/buffer.c:1131 [inline]
 bdev_getblk+0x2af/0x670 fs/buffer.c:1431
 __breadahead+0x2b/0x240 fs/buffer.c:1440
 sb_breadahead include/linux/buffer_head.h:358 [inline]
 exfat_dir_readahead fs/exfat/dir.c:647 [inline]
 exfat_get_dentry+0x464/0x730 fs/exfat/dir.c:670
 exfat_create_upcase_table+0x242/0xf60 fs/exfat/nls.c:758
page last free pid 8 tgid 8 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1127 [inline]
 free_unref_page+0xd3f/0x1010 mm/page_alloc.c:2659
 vfree+0x1c3/0x360 mm/vmalloc.c:3383
 delayed_vfree_work+0x56/0x80 mm/vmalloc.c:3303
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa66/0x1840 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Memory state around the buggy address:
 ffff888012c45080: fb fb fb fb fb fc fc fc fc fc fc fc fc fa fb fb
 ffff888012c45100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888012c45180: fb fb fc fc fc fc fc fc fc fc fa fb fb fb fb fb
                                                          ^
 ffff888012c45200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fc
 ffff888012c45280: fc fc fc fc fc fc fc fa fb fb fb fb fb fb fb fb
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

