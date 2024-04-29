Return-Path: <linux-fsdevel+bounces-18034-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C653D8B4EFB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 02:37:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40FCE1F212E1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 00:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F742624;
	Mon, 29 Apr 2024 00:37:23 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C003385
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Apr 2024 00:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714351043; cv=none; b=r99Ee+qYas1GewqKY8Aemd4qwJaow1WLGET5rf4Sgd9Fi8MpNKnahpiaGpmxJieWpNfOjOm7xrqm0P3DkNdy74Iq3fPsa5UzQAH/phCjphowlvEfdJEHBJYDhYAdVXReeYulP5nHBByqCQ/7QyviUtFENDe9h7sOJIDrT/hOHYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714351043; c=relaxed/simple;
	bh=7ESwKgKfWHLoUD1b3Oaf+4nfPcXJo3zWieZr3tgides=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=BjjqJn6fb4HZlsEvRBfNnLTUOLe0ThJaxZbm+Y+sdtKLiXrMJL7FreV/b+VME2R+y5aKNUPDjvveXkhnG2PIGgEAaZhCwAwSrhoqa7hJ+Ls+X+2rBX1sxGPZdMBGf4E394g6WSyzH84GamZ3P5U7nL4OADx/rNkrng3yUg7pCyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-36c4ff49136so4955405ab.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 28 Apr 2024 17:37:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714351040; x=1714955840;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g6G48/biMy9lu9kuSBLQ0SeD+p96HimcuQQuEdtDohk=;
        b=Gb7AhvmVX8NhTaldcWmdaPcl1TlZH73jGXbdlURPb3aH6+1xphpugYjMVWp+nt0az4
         Q9jJHwWvDWODTOcC2YRh4w8j9M5p+BO24lnco6ITW2wmYXmpg2i+FwO557lxY2NYgIQ8
         QxfLepqsk0jcgT1F8DuvFqh6pPVVD7zJ5dhKXnP9XTgurK9w0wPT3dHPnUzHE4T2OOX0
         xXSA7F9xRvgMM3M+qnd4lHnprw/B7Ldtgw3BoLubTwhomwFQMu8/JtvUNR3DEWXxfHTC
         /ZhLJSMyG2YtwOzliaW02IXZvyCO32ApK/Fa4jPbEBGsDSC4U+I23uiua9q7287m3J/n
         Poeg==
X-Forwarded-Encrypted: i=1; AJvYcCV6LIBUyfb5yJ8nwpLsXxG9QeMMxIShrtvE200u8+L9rXsxmc2LT2Jtgdu3u4rt29b08pzyEzVxMWfy+zCcmgE5BPebcrKYQeHrlTLYeQ==
X-Gm-Message-State: AOJu0YzkEgUKrfdYCp01/pPCQmaT8tQQ4J7xrYC5UkkrPV0FQ8ixYjfM
	/FBbRRgHG3QL2rEnRl//ydbFPbBfmTPECv4k42vwS17A7Y/ZYsVyvyI9iIwZZXvz2O2ILL4f8cZ
	M+xdL4gR37rGWXIrO5a05QpV22hGMTOf1ZaeH0wYrXoUOLgI4CUhpw7U=
X-Google-Smtp-Source: AGHT+IHLHjsjjdJW/9XTAw4K0m55hB+icnXY8+dbh9C9PFf2SwcHVU1PykfHFYxbdBvOifGtPU24qCd1ll2OOuvT3qyAL71CUFef
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c28:b0:368:efa4:be00 with SMTP id
 m8-20020a056e021c2800b00368efa4be00mr345432ilh.3.1714351040801; Sun, 28 Apr
 2024 17:37:20 -0700 (PDT)
Date: Sun, 28 Apr 2024 17:37:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cebc5e06173174e2@google.com>
Subject: [syzbot] [jfs?] KASAN: slab-use-after-free Read in dtSearch
From: syzbot <syzbot+bd3506d55fa4e2fd9030@syzkaller.appspotmail.com>
To: jfs-discussion@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, shaggy@kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    e88c4cfcb7b8 Merge tag 'for-6.9-rc5-tag' of git://git.kern..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1223c980980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5a05c230e142f2bc
dashboard link: https://syzkaller.appspot.com/bug?extid=bd3506d55fa4e2fd9030
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11d1256b180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17d3b7bb180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/124765f3f2cd/disk-e88c4cfc.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0e2773bfa348/vmlinux-e88c4cfc.xz
kernel image: https://storage.googleapis.com/syzbot-assets/66c56fe803c8/bzImage-e88c4cfc.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/3ac261abbe6e/mount_0.gz

Bisection is inconclusive: the issue happens on the oldest tested release.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16722217180000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=15722217180000
console output: https://syzkaller.appspot.com/x/log.txt?x=11722217180000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+bd3506d55fa4e2fd9030@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 32768
==================================================================
BUG: KASAN: slab-out-of-bounds in dtCompare fs/jfs/jfs_dtree.c:3315 [inline]
BUG: KASAN: slab-out-of-bounds in dtSearch+0x1664/0x2520 fs/jfs/jfs_dtree.c:649
Read of size 1 at addr ffff888077222498 by task syz-executor129/5079

CPU: 1 PID: 5079 Comm: syz-executor129 Not tainted 6.9.0-rc5-syzkaller-00042-ge88c4cfcb7b8 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 dtCompare fs/jfs/jfs_dtree.c:3315 [inline]
 dtSearch+0x1664/0x2520 fs/jfs/jfs_dtree.c:649
 jfs_lookup+0x17f/0x410 fs/jfs/namei.c:1461
 lookup_open fs/namei.c:3475 [inline]
 open_last_lookups fs/namei.c:3566 [inline]
 path_openat+0x1033/0x3240 fs/namei.c:3796
 do_filp_open+0x235/0x490 fs/namei.c:3826
 do_sys_openat2+0x13e/0x1d0 fs/open.c:1406
 do_sys_open fs/open.c:1421 [inline]
 __do_sys_creat fs/open.c:1497 [inline]
 __se_sys_creat fs/open.c:1491 [inline]
 __x64_sys_creat+0x123/0x170 fs/open.c:1491
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f5f2a737639
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 61 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff3ca43838 EFLAGS: 00000246 ORIG_RAX: 0000000000000055
RAX: ffffffffffffffda RBX: 00007fff3ca43a18 RCX: 00007f5f2a737639
RDX: 00007f5f2a737639 RSI: 0000000000000000 RDI: 0000000020000000
RBP: 00007f5f2a7b0610 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000006152 R11: 0000000000000246 R12: 0000000000000001
R13: 00007fff3ca43a08 R14: 0000000000000001 R15: 0000000000000001
 </TASK>

The buggy address belongs to the object at ffff888077221bc0
 which belongs to the cache jfs_ip of size 2240
The buggy address is located 24 bytes to the right of
 allocated 2240-byte region [ffff888077221bc0, ffff888077222480)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x77220
head: order:3 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff80000000840(slab|head|node=0|zone=1|lastcpupid=0xfff)
page_type: 0xffffffff()
raw: 00fff80000000840 ffff88801a7f1140 dead000000000122 0000000000000000
raw: 0000000000000000 00000000800d000d 00000001ffffffff 0000000000000000
head: 00fff80000000840 ffff88801a7f1140 dead000000000122 0000000000000000
head: 0000000000000000 00000000800d000d 00000001ffffffff 0000000000000000
head: 00fff80000000003 ffffea0001dc8801 dead000000000122 00000000ffffffff
head: 0000000800000000 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Reclaimable, gfp_mask 0xd2050(__GFP_IO|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_RECLAIMABLE), pid 5079, tgid 1143321743 (syz-executor129), ts 5079, free_ts 26577297598
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1ea/0x210 mm/page_alloc.c:1534
 prep_new_page mm/page_alloc.c:1541 [inline]
 get_page_from_freelist+0x3410/0x35b0 mm/page_alloc.c:3317
 __alloc_pages+0x256/0x6c0 mm/page_alloc.c:4575
 __alloc_pages_node include/linux/gfp.h:238 [inline]
 alloc_pages_node include/linux/gfp.h:261 [inline]
 alloc_slab_page+0x5f/0x160 mm/slub.c:2175
 allocate_slab mm/slub.c:2338 [inline]
 new_slab+0x84/0x2f0 mm/slub.c:2391
 ___slab_alloc+0xc73/0x1260 mm/slub.c:3525
 __slab_alloc mm/slub.c:3610 [inline]
 __slab_alloc_node mm/slub.c:3663 [inline]
 slab_alloc_node mm/slub.c:3835 [inline]
 kmem_cache_alloc_lru+0x253/0x350 mm/slub.c:3864
 alloc_inode_sb include/linux/fs.h:3091 [inline]
 jfs_alloc_inode+0x28/0x70 fs/jfs/super.c:105
 alloc_inode fs/inode.c:261 [inline]
 new_inode_pseudo+0x69/0x1e0 fs/inode.c:1007
 new_inode+0x22/0x1d0 fs/inode.c:1033
 diReadSpecial+0x52/0x680 fs/jfs/jfs_imap.c:423
 jfs_mount+0x28b/0x830 fs/jfs/jfs_mount.c:138
 jfs_fill_super+0x59c/0xc50 fs/jfs/super.c:556
 mount_bdev+0x20a/0x2d0 fs/super.c:1658
 legacy_get_tree+0xee/0x190 fs/fs_context.c:662
 vfs_get_tree+0x90/0x2a0 fs/super.c:1779
page last free pid 1 tgid 1 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1141 [inline]
 free_unref_page_prepare+0x97b/0xaa0 mm/page_alloc.c:2347
 free_unref_page+0x37/0x3f0 mm/page_alloc.c:2487
 free_contig_range+0x9e/0x160 mm/page_alloc.c:6572
 destroy_args+0x8a/0x890 mm/debug_vm_pgtable.c:1036
 debug_vm_pgtable+0x4be/0x550 mm/debug_vm_pgtable.c:1416
 do_one_initcall+0x248/0x880 init/main.c:1245
 do_initcall_level+0x157/0x210 init/main.c:1307
 do_initcalls+0x3f/0x80 init/main.c:1323
 kernel_init_freeable+0x435/0x5d0 init/main.c:1555
 kernel_init+0x1d/0x2b0 init/main.c:1444
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Memory state around the buggy address:
 ffff888077222380: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888077222400: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff888077222480: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
                            ^
 ffff888077222500: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888077222580: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

