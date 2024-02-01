Return-Path: <linux-fsdevel+bounces-9885-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74EEC845B1B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 16:17:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B6C7288676
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 15:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9AAB62168;
	Thu,  1 Feb 2024 15:17:26 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7726215A
	for <linux-fsdevel@vger.kernel.org>; Thu,  1 Feb 2024 15:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706800646; cv=none; b=EQK6ZVbGRNfV13aUd9quZg/E6XymmRTa2MooWryGyubXscJ+Nea1lwD5TX0mcWN8olgvVQshWUtmiKU6wGZOJdxpbX5JAfKdpNbQE3/h574gjAVZ+om8a0a5xVqxbED9yrNo9BjIMWIpDvdPdI/0wkwg321Cv2S+SHAzW65mKZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706800646; c=relaxed/simple;
	bh=HPxCSUB5zEx98b6o6g9W3iSdTbRcBAtJx2EqLbpkmnQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Kf4L8KfxF+wwT7xHnFmEDD5LGsO293145Y3ycdnJCtOPzspf0QrUm/v8J47fu+VvS3srr7zzljlDHgJB+jAHYGQ1qz5Par+6wLYef1XTTGG++FFtnRx+1YpvELy/fvo2QDMeJ5wP6WiFdekSFSFpq6fHt1IBZJQRuDASVf8PWVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-363abe44869so752065ab.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 01 Feb 2024 07:17:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706800643; x=1707405443;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U2PR9jxlA2KYl4LaDdZfOkauFUflX5kg7bFxv7gTX2o=;
        b=XKwD2ZMi6t7QDF6DPkRsKrPC0w3fkzGjNxnlaTP3GRWkV0whhJNePdJoaimYbt5q5S
         btYp9ks/U1tgbRPXhKKM1pons7tQ1m5YYnSkeHeFRe0D6rv/oU4mdARitz7SVKfhm8hg
         dD6UWBaPMR+d+KJ00MGDyliA+cWWD+nMzITaLbnzOVDoLkcz13btMkhOyxcXAYu3eRr4
         d4+hAFNpWKPTdpZtzr9cxEXmreS6dKsSvmfcYAwoMAySgeUR2Nr1MG2r21Pm1BOEAImA
         NIhKGIJ2vMnjlJBoO9D4JDhLtFa57SKEfbdguhcAQur2j0xPdcRHmxX1zw/6l3gmDAzs
         WrCA==
X-Gm-Message-State: AOJu0Yxq8xrR/Fduwid7Uj/09NMnVMiweHukSkvISVvUQsC8t9e4kRLG
	ldii9FyxZCm++0q06ccLBBWeCAfr+OB2oG/MncixQ3iAj4nJG6r0D+NBLJfusqWOKFz1YI+qSc3
	Dz0HXcEO06tlvcTMZBtDNxWb/zXDzIBtVrlEfHUCLjjVBt8L/ebaqy+o=
X-Google-Smtp-Source: AGHT+IE1g+zmbl+ljmYjmt69qpUnFFP8vaxrDFurP/9mozniNZo5RdC2v8pKoETfgZB5hw6pebQDXeDsGm7QXHA8VJFnxegwjBhD
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12ee:b0:363:8b04:6e01 with SMTP id
 l14-20020a056e0212ee00b003638b046e01mr470670iln.3.1706800643754; Thu, 01 Feb
 2024 07:17:23 -0800 (PST)
Date: Thu, 01 Feb 2024 07:17:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000012d4ed0610537e34@google.com>
Subject: [syzbot] [ntfs3?] KASAN: slab-out-of-bounds Read in mi_enum_attr
From: syzbot <syzbot+a426cde6dee8c2884b0b@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ntfs3@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    8a696a29c690 Merge tag 'platform-drivers-x86-v6.8-2' of gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16753f17e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9247001bfee478be
dashboard link: https://syzkaller.appspot.com/bug?extid=a426cde6dee8c2884b0b
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12c4efc3e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16a562f3e80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e52b675ecac5/disk-8a696a29.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4fc98d5eb84b/vmlinux-8a696a29.xz
kernel image: https://storage.googleapis.com/syzbot-assets/5d4769a0b908/bzImage-8a696a29.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/d57d4609374b/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a426cde6dee8c2884b0b@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-out-of-bounds in mi_enum_attr+0x850/0x9e0 fs/ntfs3/record.c:246
Read of size 4 at addr ffff88807483335d by task syz-executor171/9769

CPU: 0 PID: 9769 Comm: syz-executor171 Not tainted 6.8.0-rc1-syzkaller-00356-g8a696a29c690 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x163/0x540 mm/kasan/report.c:488
 kasan_report+0x142/0x170 mm/kasan/report.c:601
 mi_enum_attr+0x850/0x9e0 fs/ntfs3/record.c:246
 mi_find_attr+0x1c5/0x2b0 fs/ntfs3/record.c:353
 ni_find_attr+0x609/0x8d0 fs/ntfs3/frecord.c:218
 ntfs_readlink_hlp+0xa6/0xcb0 fs/ntfs3/inode.c:1922
 ntfs_get_link+0x79/0x110 fs/ntfs3/inode.c:2068
 pick_link+0x638/0xd70
 step_into+0xc9f/0x1080 fs/namei.c:1871
 open_last_lookups fs/namei.c:3588 [inline]
 path_openat+0x187c/0x31e0 fs/namei.c:3795
 do_filp_open+0x234/0x490 fs/namei.c:3825
 do_sys_openat2+0x13e/0x1d0 fs/open.c:1404
 do_sys_open fs/open.c:1419 [inline]
 __do_sys_open fs/open.c:1427 [inline]
 __se_sys_open fs/open.c:1423 [inline]
 __x64_sys_open+0x225/0x270 fs/open.c:1423
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7f1b33964c19
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 81 1d 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f1b338d3218 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 00007f1b33a06708 RCX: 00007f1b33964c19
RDX: 0000000000000065 RSI: 0000000000000080 RDI: 0000000020000440
RBP: 0000000000000020 R08: 0000000000000000 R09: 0000000000000000
R10: 00007ffcb7e5f0f7 R11: 0000000000000246 R12: 00007f1b33a06700
R13: 00007f1b339d2024 R14: 0030656c69662f2e R15: 0031656c69662f2e
 </TASK>

Allocated by task 5096:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x70 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:372 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:389
 kasan_kmalloc include/linux/kasan.h:211 [inline]
 __do_kmalloc_node mm/slub.c:3981 [inline]
 __kmalloc+0x22e/0x490 mm/slub.c:3994
 kmalloc include/linux/slab.h:594 [inline]
 tomoyo_realpath_from_path+0xcf/0x5e0 security/tomoyo/realpath.c:251
 tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
 tomoyo_path_perm+0x2b7/0x730 security/tomoyo/file.c:822
 security_inode_getattr+0xd3/0x120 security/security.c:2237
 vfs_getattr+0x46/0x430 fs/stat.c:173
 vfs_statx+0x1a5/0x4e0 fs/stat.c:248
 vfs_fstatat+0x135/0x190 fs/stat.c:304
 __do_sys_newfstatat fs/stat.c:468 [inline]
 __se_sys_newfstatat fs/stat.c:462 [inline]
 __x64_sys_newfstatat+0x117/0x190 fs/stat.c:462
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

Freed by task 5096:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x70 mm/kasan/common.c:68
 kasan_save_free_info+0x4e/0x60 mm/kasan/generic.c:640
 poison_slab_object+0xa6/0xe0 mm/kasan/common.c:241
 __kasan_slab_free+0x34/0x60 mm/kasan/common.c:257
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2121 [inline]
 slab_free mm/slub.c:4299 [inline]
 kfree+0x14a/0x380 mm/slub.c:4409
 tomoyo_realpath_from_path+0x5a3/0x5e0 security/tomoyo/realpath.c:286
 tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
 tomoyo_path_perm+0x2b7/0x730 security/tomoyo/file.c:822
 security_inode_getattr+0xd3/0x120 security/security.c:2237
 vfs_getattr+0x46/0x430 fs/stat.c:173
 vfs_statx+0x1a5/0x4e0 fs/stat.c:248
 vfs_fstatat+0x135/0x190 fs/stat.c:304
 __do_sys_newfstatat fs/stat.c:468 [inline]
 __se_sys_newfstatat fs/stat.c:462 [inline]
 __x64_sys_newfstatat+0x117/0x190 fs/stat.c:462
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

The buggy address belongs to the object at ffff888074832000
 which belongs to the cache kmalloc-4k of size 4096
The buggy address is located 861 bytes to the right of
 allocated 4096-byte region [ffff888074832000, ffff888074833000)

The buggy address belongs to the physical page:
page:ffffea0001d20c00 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x74830
head:ffffea0001d20c00 order:3 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000840(slab|head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000000840 ffff888013042140 dead000000000100 dead000000000122
raw: 0000000000000000 0000000000040004 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0x1d2040(__GFP_IO|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_HARDWALL), pid 4500, tgid 4500 (udevd), ts 828902194240, free_ts 828781426813
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x1e6/0x210 mm/page_alloc.c:1533
 prep_new_page mm/page_alloc.c:1540 [inline]
 get_page_from_freelist+0x33ea/0x3570 mm/page_alloc.c:3311
 __alloc_pages+0x255/0x680 mm/page_alloc.c:4567
 __alloc_pages_node include/linux/gfp.h:238 [inline]
 alloc_pages_node include/linux/gfp.h:261 [inline]
 alloc_slab_page+0x5f/0x160 mm/slub.c:2190
 allocate_slab mm/slub.c:2354 [inline]
 new_slab+0x84/0x2f0 mm/slub.c:2407
 ___slab_alloc+0xd17/0x13d0 mm/slub.c:3540
 __slab_alloc mm/slub.c:3625 [inline]
 __slab_alloc_node mm/slub.c:3678 [inline]
 slab_alloc_node mm/slub.c:3850 [inline]
 __do_kmalloc_node mm/slub.c:3980 [inline]
 __kmalloc+0x2dc/0x490 mm/slub.c:3994
 kmalloc include/linux/slab.h:594 [inline]
 tomoyo_realpath_from_path+0xcf/0x5e0 security/tomoyo/realpath.c:251
 tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
 tomoyo_check_open_permission+0x255/0x500 security/tomoyo/file.c:771
 security_file_open+0x66/0x560 security/security.c:2932
 do_dentry_open+0x327/0x1590 fs/open.c:940
 do_open fs/namei.c:3641 [inline]
 path_openat+0x2823/0x31e0 fs/namei.c:3798
 do_filp_open+0x234/0x490 fs/namei.c:3825
 do_sys_openat2+0x13e/0x1d0 fs/open.c:1404
 do_sys_open fs/open.c:1419 [inline]
 __do_sys_openat fs/open.c:1435 [inline]
 __se_sys_openat fs/open.c:1430 [inline]
 __x64_sys_openat+0x247/0x290 fs/open.c:1430
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x230 arch/x86/entry/common.c:83
page last free pid 4500 tgid 4500 stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1140 [inline]
 free_unref_page_prepare+0x959/0xa80 mm/page_alloc.c:2346
 free_unref_page+0x37/0x3f0 mm/page_alloc.c:2486
 discard_slab mm/slub.c:2453 [inline]
 __put_partials+0xeb/0x130 mm/slub.c:2922
 put_cpu_partial+0x17b/0x250 mm/slub.c:2997
 __slab_free+0x2fe/0x410 mm/slub.c:4166
 qlink_free mm/kasan/quarantine.c:160 [inline]
 qlist_free_all+0x6d/0xd0 mm/kasan/quarantine.c:176
 kasan_quarantine_reduce+0x14b/0x160 mm/kasan/quarantine.c:283
 __kasan_slab_alloc+0x23/0x70 mm/kasan/common.c:324
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slub.c:3813 [inline]
 slab_alloc_node mm/slub.c:3860 [inline]
 kmem_cache_alloc_lru+0x172/0x340 mm/slub.c:3879
 __d_alloc+0x31/0x750 fs/dcache.c:1624
 d_alloc+0x4b/0x190 fs/dcache.c:1704
 lookup_one_qstr_excl+0xce/0x250 fs/namei.c:1604
 do_unlinkat+0x297/0x830 fs/namei.c:4386
 __do_sys_unlink fs/namei.c:4446 [inline]
 __se_sys_unlink fs/namei.c:4444 [inline]
 __x64_sys_unlink+0x49/0x50 fs/namei.c:4444
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

Memory state around the buggy address:
 ffff888074833200: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888074833280: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff888074833300: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
                                                    ^
 ffff888074833380: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888074833400: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

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

