Return-Path: <linux-fsdevel+bounces-18641-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A0F48BADD1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 15:37:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 913EA1C22D18
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 13:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDCD4153BDF;
	Fri,  3 May 2024 13:37:18 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C795B153BDD
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 May 2024 13:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714743438; cv=none; b=FxZZspwyQdgbUvk23ykLjQXZ1O/biwXdxEZP2PG5BQKLBaGqvha1wu6wKF8zhrJKPmQMK+VysKG8AbcVtGc2AIMYVRidM9vZ5sPlhVh+v9WiFU2RwDeNVRuaildWFAyQuSAmB25my3JkP/kyp6s5raZK0vUf8Og/F9V0qSJm75I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714743438; c=relaxed/simple;
	bh=Je3pzMJL55BlxyW4uaA0MWJcHQN4Jj+w4LboYM7cLnM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=IwKPTBS/K/w2Zg9YcsC5XcRklKQpA9WAyNhe/Yhp9P4OxIJX8avoIGJ55FDcfvNwvbOxE8NEDH9b4jFyK8GVMH1IXAT2rh8kbr9mQCslf3QkHdDe3by/b62hV6eyLTrAt2OXaCifkCMvsDrsVgtqwjHcqQgr+t4mRV9FCyfjP8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7d9d0936d6aso1024436839f.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 May 2024 06:37:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714743436; x=1715348236;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ghNzLmGNEbQ71sJISPN/dEMEfHG72quGfCnyvuFhPDY=;
        b=uEvLYQxbdRSPsrjxc+MpWpwEKMVfZ91r7RSBsVGmbS6oCbkoLcBRyvt2Z0uGNetsHx
         YLVB0+s81HafINjj0FeQ3QJJepNN80nN7Prray7KgGcHb8ZZl2YhDR8nxiRM+V4Ug1C+
         l1VQUE5qFDpGuGjOUT6uf8mkC3gjnbbvIavgWnOEdniNpRFvW2ziI2o5Br1MGfXW3vNU
         jZiylACUts+ieb9OiC9e78MN1IGPtngvN/UPGKUiLQM6JW9cAESftByc/2iiZ8VoI30E
         uXoBgGiYlvLSwtwb9P4xla8Oemu4hi1O2T7WnbNPJ5C1mHOtLjcPpnUSXj14qQkQNB1K
         wdew==
X-Forwarded-Encrypted: i=1; AJvYcCUNrVGJckyFTDkUyCsdvYKbf3dumepwOiyT3QqUjnuBZIsdDdCQVy57g+o99ia+Dn34KR4lrmr+1TVRj5505ggOd3bspN5VqAY2oV0JOA==
X-Gm-Message-State: AOJu0YzBSQLnGlzTkp2xW93H4KDa7IR81IonJbxNuGf5SHlno2JSEGOq
	jLwLXhdd1hePoabmRWDxRLzn+ItLmwc7ZjHmPvBEZeuIUOli5alSwm03H+l3LcXZm3Y80kYtTcP
	3kEmauCn5DZ91P12B9sCY2ADLuyDM3Uwl7sKiYrIBxZ6BICeRxy7Bd/U=
X-Google-Smtp-Source: AGHT+IE2Oq96MTqZrV/bkL7CLPyHrcGYAHhVH47+8zsQwpbgJvqLxTPNZVYCShWYfcg9lv0+6f4DUEKVUeWEJO2vfCTkG6BPosv2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:31c6:b0:487:3dc3:c47f with SMTP id
 n6-20020a05663831c600b004873dc3c47fmr90067jav.6.1714743436072; Fri, 03 May
 2024 06:37:16 -0700 (PDT)
Date: Fri, 03 May 2024 06:37:16 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000636fa106178cd1e4@google.com>
Subject: [syzbot] [bcachefs?] KASAN: slab-out-of-bounds Read in bch2_varint_decode_fast
From: syzbot <syzbot+66b9b74f6520068596a9@syzkaller.appspotmail.com>
To: bfoster@redhat.com, kent.overstreet@linux.dev, 
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    f03359bca01b Merge tag 'for-6.9-rc6-tag' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=177410a8980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3310e643b6ef5d69
dashboard link: https://syzkaller.appspot.com/bug?extid=66b9b74f6520068596a9
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/1b4deeb2639b/disk-f03359bc.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f3c3d98db8ef/vmlinux-f03359bc.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6f79ee1ae20f/bzImage-f03359bc.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+66b9b74f6520068596a9@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-out-of-bounds in get_unaligned_le64 include/asm-generic/unaligned.h:37 [inline]
BUG: KASAN: slab-out-of-bounds in bch2_varint_decode_fast+0x1b5/0x1e0 fs/bcachefs/varint.c:114
Read of size 8 at addr ffff888025fc6f7f by task syz-executor.3/19591

CPU: 1 PID: 19591 Comm: syz-executor.3 Not tainted 6.9.0-rc6-syzkaller-00131-gf03359bca01b #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:114
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0xc3/0x620 mm/kasan/report.c:488
 kasan_report+0xd9/0x110 mm/kasan/report.c:601
 get_unaligned_le64 include/asm-generic/unaligned.h:37 [inline]
 bch2_varint_decode_fast+0x1b5/0x1e0 fs/bcachefs/varint.c:114
 bch2_inode_unpack_v3+0xf3d/0x2060 fs/bcachefs/inode.c:270
 bch2_inode_unpack fs/bcachefs/inode.c:323 [inline]
 __bch2_inode_invalid+0x1a2/0x4d0 fs/bcachefs/inode.c:449
 bch2_inode_v3_invalid+0x1f1/0x2e0 fs/bcachefs/inode.c:529
 bch2_bkey_val_invalid+0x1cb/0x290 fs/bcachefs/bkey_methods.c:140
 bch2_bkey_invalid+0x86/0x90 fs/bcachefs/bkey_methods.c:231
 __bch2_trans_commit+0x7ea/0x7880 fs/bcachefs/btree_trans_commit.c:1008
 bch2_trans_commit fs/bcachefs/btree_update.h:168 [inline]
 bch2_extent_update+0x494/0xa40 fs/bcachefs/io_write.c:318
 bch2_write_index_default+0x8d7/0xb70 fs/bcachefs/io_write.c:366
 __bch2_write_index+0x5ee/0xa60 fs/bcachefs/io_write.c:520
 bch2_write_data_inline fs/bcachefs/io_write.c:1538 [inline]
 bch2_write+0x1113/0x1400 fs/bcachefs/io_write.c:1606
 bch2_writepages+0x136/0x200 fs/bcachefs/fs-io-buffered.c:660
 do_writepages+0x1a3/0x7f0 mm/page-writeback.c:2612
 filemap_fdatawrite_wbc mm/filemap.c:397 [inline]
 filemap_fdatawrite_wbc+0x148/0x1c0 mm/filemap.c:387
 __filemap_fdatawrite_range+0xba/0x100 mm/filemap.c:430
 filemap_write_and_wait_range mm/filemap.c:685 [inline]
 filemap_write_and_wait_range+0xa3/0x130 mm/filemap.c:676
 bch2_symlink+0x13a/0x200 fs/bcachefs/fs.c:587
 vfs_symlink fs/namei.c:4481 [inline]
 vfs_symlink+0x3e8/0x630 fs/namei.c:4465
 do_symlinkat+0x263/0x310 fs/namei.c:4507
 __do_sys_symlinkat fs/namei.c:4523 [inline]
 __se_sys_symlinkat fs/namei.c:4520 [inline]
 __x64_sys_symlinkat+0x97/0xc0 fs/namei.c:4520
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x260 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f8907c7dd29
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f8908a970c8 EFLAGS: 00000246 ORIG_RAX: 000000000000010a
RAX: ffffffffffffffda RBX: 00007f8907dabf80 RCX: 00007f8907c7dd29
RDX: 0000000020000340 RSI: 0000000000000005 RDI: 0000000020000440
RBP: 00007f8907cca47e R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f8907dabf80 R15: 00007ffd176e7b48
 </TASK>

Allocated by task 19591:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:387
 kasan_kmalloc include/linux/kasan.h:211 [inline]
 __do_kmalloc_node mm/slub.c:3966 [inline]
 __kmalloc_node_track_caller+0x220/0x470 mm/slub.c:3986
 __do_krealloc mm/slab_common.c:1192 [inline]
 krealloc+0x5d/0x100 mm/slab_common.c:1225
 __bch2_trans_kmalloc+0x392/0xbf0 fs/bcachefs/btree_iter.c:2831
 bch2_trans_kmalloc_nomemzero fs/bcachefs/btree_iter.h:537 [inline]
 __bch2_bkey_make_mut_noupdate.constprop.0+0x3c9/0x4e0 fs/bcachefs/btree_update.h:223
 __bch2_bkey_get_mut_noupdate fs/bcachefs/btree_update.h:282 [inline]
 bch2_bkey_get_mut_noupdate fs/bcachefs/btree_update.h:293 [inline]
 bch2_extent_update_i_size_sectors+0x33d/0x760 fs/bcachefs/io_write.c:219
 bch2_extent_update+0x3db/0xa40 fs/bcachefs/io_write.c:314
 bch2_write_index_default+0x8d7/0xb70 fs/bcachefs/io_write.c:366
 __bch2_write_index+0x5ee/0xa60 fs/bcachefs/io_write.c:520
 bch2_write_data_inline fs/bcachefs/io_write.c:1538 [inline]
 bch2_write+0x1113/0x1400 fs/bcachefs/io_write.c:1606
 bch2_writepages+0x136/0x200 fs/bcachefs/fs-io-buffered.c:660
 do_writepages+0x1a3/0x7f0 mm/page-writeback.c:2612
 filemap_fdatawrite_wbc mm/filemap.c:397 [inline]
 filemap_fdatawrite_wbc+0x148/0x1c0 mm/filemap.c:387
 __filemap_fdatawrite_range+0xba/0x100 mm/filemap.c:430
 filemap_write_and_wait_range mm/filemap.c:685 [inline]
 filemap_write_and_wait_range+0xa3/0x130 mm/filemap.c:676
 bch2_symlink+0x13a/0x200 fs/bcachefs/fs.c:587
 vfs_symlink fs/namei.c:4481 [inline]
 vfs_symlink+0x3e8/0x630 fs/namei.c:4465
 do_symlinkat+0x263/0x310 fs/namei.c:4507
 __do_sys_symlinkat fs/namei.c:4523 [inline]
 __se_sys_symlinkat fs/namei.c:4520 [inline]
 __x64_sys_symlinkat+0x97/0xc0 fs/namei.c:4520
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x260 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff888025fc6f00
 which belongs to the cache kmalloc-128 of size 128
The buggy address is located 127 bytes inside of
 allocated 128-byte region [ffff888025fc6f00, ffff888025fc6f80)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x25fc6
flags: 0xfff00000000800(slab|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000000800 ffff8880150418c0 dead000000000100 dead000000000122
raw: 0000000000000000 0000000080100010 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x12820(GFP_ATOMIC|__GFP_NOWARN|__GFP_NORETRY), pid 5098, tgid -1144530164 (syz-executor.3), ts 5098, free_ts 114727813224
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x2d4/0x350 mm/page_alloc.c:1534
 prep_new_page mm/page_alloc.c:1541 [inline]
 get_page_from_freelist+0xa28/0x3780 mm/page_alloc.c:3317
 __alloc_pages+0x22b/0x2460 mm/page_alloc.c:4575
 __alloc_pages_node include/linux/gfp.h:238 [inline]
 alloc_pages_node include/linux/gfp.h:261 [inline]
 alloc_slab_page mm/slub.c:2175 [inline]
 allocate_slab mm/slub.c:2338 [inline]
 new_slab+0xcc/0x3a0 mm/slub.c:2391
 ___slab_alloc+0x66d/0x1790 mm/slub.c:3525
 __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3610
 __slab_alloc_node mm/slub.c:3663 [inline]
 slab_alloc_node mm/slub.c:3835 [inline]
 kmalloc_trace+0x2fb/0x330 mm/slub.c:3992
 kmalloc include/linux/slab.h:628 [inline]
 __hw_addr_create net/core/dev_addr_lists.c:60 [inline]
 __hw_addr_add_ex+0x3c8/0x7c0 net/core/dev_addr_lists.c:118
 __hw_addr_add net/core/dev_addr_lists.c:135 [inline]
 dev_uc_add+0xb6/0x110 net/core/dev_addr_lists.c:689
 vlan_dev_set_mac_address+0x2d4/0x440 net/8021q/vlan_dev.c:344
 dev_set_mac_address+0x301/0x4a0 net/core/dev.c:8950
 dev_set_mac_address_user+0x30/0x50 net/core/dev.c:8969
 do_setlink+0x901/0x3ff0 net/core/rtnetlink.c:2839
 __rtnl_newlink+0xc35/0x1960 net/core/rtnetlink.c:3680
 rtnl_newlink+0x67/0xa0 net/core/rtnetlink.c:3727
 rtnetlink_rcv_msg+0x3c7/0xe60 net/core/rtnetlink.c:6595
page last free pid 5164 tgid 5164 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1141 [inline]
 free_unref_page_prepare+0x527/0xb10 mm/page_alloc.c:2347
 free_unref_folios+0x256/0xad0 mm/page_alloc.c:2536
 folios_put_refs+0x487/0x6d0 mm/swap.c:1034
 free_pages_and_swap_cache+0x262/0x4b0 mm/swap_state.c:329
 __tlb_batch_free_encoded_pages+0xf9/0x290 mm/mmu_gather.c:136
 tlb_batch_pages_flush mm/mmu_gather.c:149 [inline]
 tlb_flush_mmu_free mm/mmu_gather.c:366 [inline]
 tlb_flush_mmu mm/mmu_gather.c:373 [inline]
 tlb_finish_mmu+0x168/0x7b0 mm/mmu_gather.c:465
 exit_mmap+0x3da/0xb90 mm/mmap.c:3280
 __mmput+0x12a/0x4d0 kernel/fork.c:1346
 mmput+0x62/0x70 kernel/fork.c:1368
 exit_mm kernel/exit.c:569 [inline]
 do_exit+0x999/0x2c10 kernel/exit.c:865
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1027
 __do_sys_exit_group kernel/exit.c:1038 [inline]
 __se_sys_exit_group kernel/exit.c:1036 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1036
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x260 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff888025fc6e80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888025fc6f00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff888025fc6f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
                   ^
 ffff888025fc7000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff888025fc7080: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
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

