Return-Path: <linux-fsdevel+bounces-8618-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 101D7839905
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 20:04:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7ACEF1F2D496
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 19:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6559F1272BE;
	Tue, 23 Jan 2024 18:58:24 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B0E1272B5
	for <linux-fsdevel@vger.kernel.org>; Tue, 23 Jan 2024 18:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706036304; cv=none; b=o+O+mqpIAuQvEa5ppIPOzscZKjpqwCYKUba6HcIWWdMNpnJqjo8w8ihn+XMUcRotSymdD6Ivi257MAPM8SNeDk0UiUFV2cD4nL/QviNxMwV5zyLkEBBRMdymcxnXRHdgbqn8ni5zpaX9VT1y/GxAH8TKylhnhzIn/J6LQwxMHiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706036304; c=relaxed/simple;
	bh=T/UJzk/hCC5E5eruvRjSsJfp5VTM6UWNywnKs+gxuTg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=sMs1yCiYEi1xDRle7FdzRG3jLr5UxdL/LH6RzKnOFwbhllaGuCk0rAkRoBhe6Y1d+DtrxapyceorRqGnU3SvjKsrtzh0lAsl1EeRWvwNYM7qxftdGtuggXqs85ymfJ3zFAn90o6Ql3J5Ojd8vJlpJpzq0tVMmy0plMErDch+pw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-361a800f629so38436305ab.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Jan 2024 10:58:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706036301; x=1706641101;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dOSjUOeHl2QSll7gf92WgoHV5pOSKe9yCUVyi23pDk8=;
        b=bID9s+8RR7MA3FMPZ6QAI+zkbIpooUTbajiYUSVJtWAkH1DDAukeK76HYgl3AYTIKo
         WtvI0IFEu46OmuLEtNokg+7z2TRv7YR3AhyrLJEY/IkxyYjIXxFTpWXTf+jUuehN9MR1
         cqaBrAQXs9yXPml9K5eQ9xZH4jtworECUJ4kB2L7+xS9Y7X2y2nH/Xg3nKomBBw0tufX
         YFI/tGPjvAW2heJhMeJywKCTy+ZCZU2n6Og0hDqTF6P3LYg/NF0cdVrutBF5oPv/SdCa
         lEUqwTRD+EuE+1T5iod3MfBsYGDksKxJfJgvNY3sgvEV8v0SvL0q4OGjVNl4dLHDg7al
         iSog==
X-Gm-Message-State: AOJu0YyzhUg47ucxc0lX8TdsDZoML69jqQ6icRIoaj+sp5D0vYrJJagE
	5qiWrpTqM6i635ub+gPJ9SAMYI808vu5n1vpCVms0ncwfgx6t1z9tP0pmqN51mDbLhQ4/01d/OJ
	/OnjelLrMKR7rVXZg9RrTA6CRO3j+h+k1mMITEUA0mgQd57k5Y5fj8hNMhA==
X-Google-Smtp-Source: AGHT+IEip5o0ldc0hHCZFwlRTO7AiAdrLnd+i/LSjfd/yn4OpD76DBMw1vfJNt/JHUmQRP7Mj6Qo+5GLv0L35Ina112N3I1mKsxp
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:18c5:b0:361:8d02:f37d with SMTP id
 s5-20020a056e0218c500b003618d02f37dmr22475ilu.4.1706036301521; Tue, 23 Jan
 2024 10:58:21 -0800 (PST)
Date: Tue, 23 Jan 2024 10:58:21 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b9eb20060fa187db@google.com>
Subject: [syzbot] [hfs?] KASAN: invalid-free in hfsplus_release_folio (2)
From: syzbot <syzbot+4ab460b3092c782470be@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    9d1694dc91ce Merge tag 'for-6.8/block-2024-01-18' of git:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12217115e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=719e6acaf392d56b
dashboard link: https://syzkaller.appspot.com/bug?extid=4ab460b3092c782470be
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-9d1694dc.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/30a5315d82f7/vmlinux-9d1694dc.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c79cbc1c5e35/bzImage-9d1694dc.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4ab460b3092c782470be@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: double-free in hfsplus_release_folio+0x516/0x5f0 fs/hfsplus/inode.c:98
Free of addr ffff8880257f9100 by task kswapd0/109

CPU: 0 PID: 109 Comm: kswapd0 Not tainted 6.7.0-syzkaller-12377-g9d1694dc91ce #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0xc4/0x620 mm/kasan/report.c:488
 kasan_report_invalid_free+0xab/0xd0 mm/kasan/report.c:563
 poison_slab_object mm/kasan/common.c:233 [inline]
 __kasan_slab_free+0x18f/0x1b0 mm/kasan/common.c:257
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2121 [inline]
 slab_free mm/slub.c:4299 [inline]
 kfree+0x124/0x360 mm/slub.c:4409
 hfsplus_release_folio+0x516/0x5f0 fs/hfsplus/inode.c:98
 filemap_release_folio+0x1f1/0x270 mm/filemap.c:4086
 shrink_folio_list+0x292c/0x3ea0 mm/vmscan.c:1369
 evict_folios+0x6e7/0x1b90 mm/vmscan.c:4521
 try_to_shrink_lruvec+0x638/0xa10 mm/vmscan.c:4726
 shrink_one+0x3f4/0x7b0 mm/vmscan.c:4765
 shrink_many mm/vmscan.c:4828 [inline]
 lru_gen_shrink_node mm/vmscan.c:4929 [inline]
 shrink_node+0x2149/0x3740 mm/vmscan.c:5888
 kswapd_shrink_node mm/vmscan.c:6693 [inline]
 balance_pgdat+0x9d2/0x1a90 mm/vmscan.c:6883
 kswapd+0x5be/0xbf0 mm/vmscan.c:7143
 kthread+0x2c6/0x3a0 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
 </TASK>

Allocated by task 8553:
 kasan_save_stack+0x33/0x50 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:372 [inline]
 __kasan_kmalloc+0xa2/0xb0 mm/kasan/common.c:389
 kasan_kmalloc include/linux/kasan.h:211 [inline]
 __do_kmalloc_node mm/slub.c:3981 [inline]
 __kmalloc+0x1f9/0x440 mm/slub.c:3994
 kmalloc include/linux/slab.h:594 [inline]
 kzalloc include/linux/slab.h:711 [inline]
 __hfs_bnode_create+0x108/0x860 fs/hfsplus/bnode.c:409
 hfsplus_bnode_find+0x2c4/0xcb0 fs/hfsplus/bnode.c:486
 hfsplus_brec_find+0x2b9/0x520 fs/hfsplus/bfind.c:183
 hfsplus_brec_read+0x2d/0x120 fs/hfsplus/bfind.c:222
 hfsplus_find_cat+0x1e6/0x4c0 fs/hfsplus/catalog.c:202
 hfsplus_iget+0x3b9/0x7a0 fs/hfsplus/super.c:82
 hfsplus_fill_super+0xca8/0x1bc0 fs/hfsplus/super.c:503
 mount_bdev+0x1df/0x2d0 fs/super.c:1663
 legacy_get_tree+0x109/0x220 fs/fs_context.c:662
 vfs_get_tree+0x8c/0x370 fs/super.c:1784
 do_new_mount fs/namespace.c:3352 [inline]
 path_mount+0x14e6/0x1f20 fs/namespace.c:3679
 do_mount fs/namespace.c:3692 [inline]
 __do_sys_mount fs/namespace.c:3898 [inline]
 __se_sys_mount fs/namespace.c:3875 [inline]
 __ia32_sys_mount+0x291/0x310 fs/namespace.c:3875
 do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
 __do_fast_syscall_32+0x79/0x110 arch/x86/entry/common.c:321
 do_fast_syscall_32+0x33/0x70 arch/x86/entry/common.c:346
 entry_SYSENTER_compat_after_hwframe+0x70/0x7a

Freed by task 5223:
 kasan_save_stack+0x33/0x50 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 kasan_save_free_info+0x3f/0x60 mm/kasan/generic.c:640
 poison_slab_object mm/kasan/common.c:241 [inline]
 __kasan_slab_free+0x121/0x1b0 mm/kasan/common.c:257
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2121 [inline]
 slab_free mm/slub.c:4299 [inline]
 kfree+0x124/0x360 mm/slub.c:4409
 hfsplus_btree_close+0xac/0x390 fs/hfsplus/btree.c:275
 hfsplus_put_super+0x24c/0x3f0 fs/hfsplus/super.c:301
 generic_shutdown_super+0x159/0x3d0 fs/super.c:646
 kill_block_super+0x3b/0x90 fs/super.c:1680
 deactivate_locked_super+0xbc/0x1a0 fs/super.c:477
 deactivate_super+0xde/0x100 fs/super.c:510
 cleanup_mnt+0x222/0x450 fs/namespace.c:1267
 task_work_run+0x14d/0x240 kernel/task_work.c:180
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:108 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:201 [inline]
 syscall_exit_to_user_mode+0x281/0x2b0 kernel/entry/common.c:212
 __do_fast_syscall_32+0x86/0x110 arch/x86/entry/common.c:324
 do_fast_syscall_32+0x33/0x70 arch/x86/entry/common.c:346
 entry_SYSENTER_compat_after_hwframe+0x70/0x7a

The buggy address belongs to the object at ffff8880257f9100
 which belongs to the cache kmalloc-192 of size 192
The buggy address is located 0 bytes inside of
 192-byte region [ffff8880257f9100, ffff8880257f91c0)

The buggy address belongs to the physical page:
page:ffffea000095fe00 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x257f8
head:ffffea000095fe00 order:1 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000840(slab|head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000000840 ffff888013042a00 dead000000000100 dead000000000122
raw: 0000000000000000 00000000801e001e 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 1, migratetype Unmovable, gfp_mask 0x1d20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_HARDWALL), pid 6909, tgid 6908 (syz-executor.0), ts 238947408079, free_ts 228594389767
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x2d0/0x350 mm/page_alloc.c:1533
 prep_new_page mm/page_alloc.c:1540 [inline]
 get_page_from_freelist+0xa28/0x3780 mm/page_alloc.c:3311
 __alloc_pages+0x22f/0x2440 mm/page_alloc.c:4567
 __alloc_pages_node include/linux/gfp.h:238 [inline]
 alloc_pages_node include/linux/gfp.h:261 [inline]
 alloc_slab_page mm/slub.c:2190 [inline]
 allocate_slab mm/slub.c:2354 [inline]
 new_slab+0xcc/0x3a0 mm/slub.c:2407
 ___slab_alloc+0x4af/0x19a0 mm/slub.c:3540
 __slab_alloc.constprop.0+0x56/0xa0 mm/slub.c:3625
 __slab_alloc_node mm/slub.c:3678 [inline]
 slab_alloc_node mm/slub.c:3850 [inline]
 __do_kmalloc_node mm/slub.c:3980 [inline]
 __kmalloc_node+0x35d/0x460 mm/slub.c:3988
 kmalloc_array_node include/linux/slab.h:688 [inline]
 kcalloc_node include/linux/slab.h:693 [inline]
 memcg_alloc_slab_cgroups+0xa9/0x180 mm/memcontrol.c:2988
 __memcg_slab_post_alloc_hook+0xa3/0x370 mm/slub.c:1970
 memcg_slab_post_alloc_hook mm/slub.c:1993 [inline]
 slab_post_alloc_hook mm/slub.c:3822 [inline]
 slab_alloc_node mm/slub.c:3860 [inline]
 kmem_cache_alloc_lru+0x399/0x6f0 mm/slub.c:3879
 __d_alloc+0x32/0xaa0 fs/dcache.c:1624
 d_alloc+0x4a/0x1e0 fs/dcache.c:1704
 lookup_one_qstr_excl+0xc7/0x180 fs/namei.c:1604
 filename_create+0x1ed/0x530 fs/namei.c:3892
 do_mkdirat+0xab/0x3a0 fs/namei.c:4137
 __do_sys_mkdirat fs/namei.c:4160 [inline]
 __se_sys_mkdirat fs/namei.c:4158 [inline]
 __ia32_sys_mkdirat+0x84/0xa0 fs/namei.c:4158
page last free pid 37 tgid 37 stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1140 [inline]
 free_unref_page_prepare+0x51f/0xb10 mm/page_alloc.c:2346
 free_unref_page+0x33/0x3c0 mm/page_alloc.c:2486
 kasan_depopulate_vmalloc_pte+0x63/0x80 mm/kasan/shadow.c:415
 apply_to_pte_range mm/memory.c:2619 [inline]
 apply_to_pmd_range mm/memory.c:2663 [inline]
 apply_to_pud_range mm/memory.c:2699 [inline]
 apply_to_p4d_range mm/memory.c:2735 [inline]
 __apply_to_page_range+0x57e/0xdb0 mm/memory.c:2769
 kasan_release_vmalloc+0xa8/0xc0 mm/kasan/shadow.c:532
 __purge_vmap_area_lazy+0x8b9/0x2170 mm/vmalloc.c:1770
 drain_vmap_area_work+0x54/0xd0 mm/vmalloc.c:1804
 process_one_work+0x886/0x15d0 kernel/workqueue.c:2633
 process_scheduled_works kernel/workqueue.c:2706 [inline]
 worker_thread+0x8b9/0x1290 kernel/workqueue.c:2787
 kthread+0x2c6/0x3a0 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242

Memory state around the buggy address:
 ffff8880257f9000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 04 fc
 ffff8880257f9080: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff8880257f9100: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                   ^
 ffff8880257f9180: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
 ffff8880257f9200: fc fc fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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

