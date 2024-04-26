Return-Path: <linux-fsdevel+bounces-17890-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B588B36CF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 14:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64B3FB21C14
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 12:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6B33145358;
	Fri, 26 Apr 2024 12:00:24 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E78144D3F
	for <linux-fsdevel@vger.kernel.org>; Fri, 26 Apr 2024 12:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714132824; cv=none; b=Nlro+zNYi02aOXTTDRx3OwtShiXAx++z7YfOWGjlHvngQZXB3FlyEOn8LWWVaQGpPDj28IUsNLv4JfGIyX9Aad+WDdms3uZTE7weeduk2gpCJSUreawMX1LfwZ6jpijx/6cGCJU79ztPXvv1xR/IOkWOi5ls0x9unJOD9fbQ9bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714132824; c=relaxed/simple;
	bh=8BO/ZBGEFoIIJdHqnHTSXHBZFlt4YEId1ib9PEjaKkM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=aFCKtZfiBPmppFwQVz4ftANl39FWe9lCNYsURg2UoIZUbT2zSn+yeC23Ikf7iyTKMPin7igS5TyGnC/znJngzYYY1IglrCHllibcraqMtXus8oViIHsjGSrW9Sr3zsyrtoBCLY/zFAs2b0sfu15Cmeyknn6eDTaGqFfLNOMxHiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7d667dd202cso207346339f.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Apr 2024 05:00:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714132822; x=1714737622;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GlBVU8NhQFDaSrNRdYhDZE6HqqUIChpmecrMdvytvYc=;
        b=YPCBJgl3c8LB+hAMq59z+3EuCBcSHv18G4Smu8aVe0t+iPZkI/T5AyBeDN6HUo9ajY
         4DvabTjvjtAwfjdwg+sAlZAbn6WWPSgxR2KCI04Q5Ak+QYW1R00iAsHMEmg734sl8gD9
         BWdaULaCHTbAli9FJ36RtKqakHP1SUgGcvPRuohLrHpSVsqHFEddgomavr6vINxBitMO
         xkgu9HcjmedKxq/4giQqXqNxKZkWm2Gj8ANJPfn7bVHuA2rrm3mytUShTjPpIW6rk+N0
         FWbNWnsW3M+wWwUV5++vR6w1bNdCenhNHrk2a7l3+V3AMXyDgohhaP5VUiFf96EUOs+w
         7Auw==
X-Forwarded-Encrypted: i=1; AJvYcCWhu3/jSLPceSefIHOpxBqIBrYrMfahKQPWxvnOo486Qc/3Y0TXU2rzlt3HYT0fGaA/3Qo7M0ZgeXlLiT1pAhWkO6s9grQMyL6DohGRSg==
X-Gm-Message-State: AOJu0Yz2D3PfxKetgdYwcJxtCxCHtJ3qlPVm+QYLYL8mleX0w3+EcgNy
	r80V0gba7/KoIVEsRfE4NXzC+md5XeWkDVDhRovYCoK+JL9sHy3TmRhSrdAOdPi+4je5qkvkMP4
	d53ilxLIH0b+9NijKabOMCcabGdnHFYojAgaQDgbO5IPPkHYqWutdF6A=
X-Google-Smtp-Source: AGHT+IHWi0X168bsy5DPhMJvl+U8bFNRuUZP409vo+4tPjUlYCKmirvKZzCGUUZhbDGpeLOObUNu2Gy3jedtb7whueE0kGDs0S10
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2dc2:b0:7d9:b860:3e54 with SMTP id
 l2-20020a0566022dc200b007d9b8603e54mr39486iow.2.1714132821958; Fri, 26 Apr
 2024 05:00:21 -0700 (PDT)
Date: Fri, 26 Apr 2024 05:00:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f386f90616fea5ef@google.com>
Subject: [syzbot] [ntfs3?] KASAN: slab-use-after-free Read in chrdev_open
From: syzbot <syzbot+5d34cc6474499a5ff516@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ntfs3@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    e33c4963bf53 Merge tag 'nfsd-6.9-5' of git://git.kernel.or..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=16f9787b180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5a05c230e142f2bc
dashboard link: https://syzkaller.appspot.com/bug?extid=5d34cc6474499a5ff516
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11655ed8980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12499380980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e06aabc50597/disk-e33c4963.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ac50f00a131e/vmlinux-e33c4963.xz
kernel image: https://storage.googleapis.com/syzbot-assets/21fd2a443e16/bzImage-e33c4963.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/9a3efbc77ff7/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5d34cc6474499a5ff516@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in __list_add_valid_or_report+0x4c/0xf0 lib/list_debug.c:29
Read of size 8 at addr ffff888076eed7c8 by task syz-executor427/5079

CPU: 0 PID: 5079 Comm: syz-executor427 Not tainted 6.9.0-rc5-syzkaller-00053-ge33c4963bf53 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 __list_add_valid_or_report+0x4c/0xf0 lib/list_debug.c:29
 __list_add_valid include/linux/list.h:88 [inline]
 __list_add include/linux/list.h:150 [inline]
 list_add include/linux/list.h:169 [inline]
 chrdev_open+0x2a9/0x630 fs/char_dev.c:396
 do_dentry_open+0x907/0x15a0 fs/open.c:955
 do_open fs/namei.c:3642 [inline]
 path_openat+0x2860/0x3240 fs/namei.c:3799
 do_filp_open+0x235/0x490 fs/namei.c:3826
 do_sys_openat2+0x13e/0x1d0 fs/open.c:1406
 do_sys_open fs/open.c:1421 [inline]
 __do_sys_openat fs/open.c:1437 [inline]
 __se_sys_openat fs/open.c:1432 [inline]
 __x64_sys_openat+0x247/0x2a0 fs/open.c:1432
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f722cb71329
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 21 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff23332778 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0030656c69662f2e RCX: 00007f722cb71329
RDX: 0000000000000000 RSI: 0000000020002140 RDI: ffffffffffffff9c
RBP: 0000000000000000 R08: 00007fff233327b0 R09: 00007fff233327b0
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fff2333279c
R13: 0000000000000001 R14: 431bde82d7b634db R15: 00007fff233327d0
 </TASK>

Allocated by task 5077:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 unpoison_slab_object mm/kasan/common.c:312 [inline]
 __kasan_slab_alloc+0x66/0x80 mm/kasan/common.c:338
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slub.c:3798 [inline]
 slab_alloc_node mm/slub.c:3845 [inline]
 kmem_cache_alloc_lru+0x178/0x350 mm/slub.c:3864
 alloc_inode_sb include/linux/fs.h:3091 [inline]
 ntfs_alloc_inode+0x28/0x80 fs/ntfs3/super.c:557
 alloc_inode fs/inode.c:261 [inline]
 new_inode_pseudo+0x69/0x1e0 fs/inode.c:1007
 new_inode+0x22/0x1d0 fs/inode.c:1033
 ntfs_new_inode+0x45/0x100 fs/ntfs3/fsntfs.c:1688
 ntfs_create_inode+0x687/0x3c30 fs/ntfs3/inode.c:1333
 ntfs_mknod+0x41/0x60 fs/ntfs3/namei.c:128
 vfs_mknod+0x36d/0x3b0 fs/namei.c:4001
 do_mknodat+0x3ec/0x5b0
 __do_sys_mknodat fs/namei.c:4079 [inline]
 __se_sys_mknodat fs/namei.c:4076 [inline]
 __x64_sys_mknodat+0xa9/0xc0 fs/namei.c:4076
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 0:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:579
 poison_slab_object+0xa6/0xe0 mm/kasan/common.c:240
 __kasan_slab_free+0x37/0x60 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2106 [inline]
 slab_free mm/slub.c:4280 [inline]
 kmem_cache_free+0x10b/0x2c0 mm/slub.c:4344
 rcu_do_batch kernel/rcu/tree.c:2196 [inline]
 rcu_core+0xafd/0x1830 kernel/rcu/tree.c:2471
 __do_softirq+0x2c6/0x980 kernel/softirq.c:554

Last potentially related work creation:
 kasan_save_stack+0x3f/0x60 mm/kasan/common.c:47
 __kasan_record_aux_stack+0xac/0xc0 mm/kasan/generic.c:541
 __call_rcu_common kernel/rcu/tree.c:2734 [inline]
 call_rcu+0x167/0xa70 kernel/rcu/tree.c:2838
 __dentry_kill+0x20d/0x630 fs/dcache.c:603
 shrink_kill+0xa9/0x2c0 fs/dcache.c:1048
 shrink_dentry_list+0x2c0/0x5b0 fs/dcache.c:1075
 shrink_dcache_parent+0xcb/0x3b0
 do_one_tree+0x23/0xe0 fs/dcache.c:1538
 shrink_dcache_for_umount+0x7d/0x130 fs/dcache.c:1555
 generic_shutdown_super+0x6a/0x2d0 fs/super.c:619
 kill_block_super+0x44/0x90 fs/super.c:1675
 ntfs3_kill_sb+0x44/0x1b0 fs/ntfs3/super.c:1785
 deactivate_locked_super+0xc4/0x130 fs/super.c:472
 cleanup_mnt+0x426/0x4c0 fs/namespace.c:1267
 task_work_run+0x24f/0x310 kernel/task_work.c:180
 ptrace_notify+0x2d2/0x380 kernel/signal.c:2404
 ptrace_report_syscall include/linux/ptrace.h:415 [inline]
 ptrace_report_syscall_exit include/linux/ptrace.h:477 [inline]
 syscall_exit_work+0xc6/0x190 kernel/entry/common.c:173
 syscall_exit_to_user_mode_prepare kernel/entry/common.c:200 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:205 [inline]
 syscall_exit_to_user_mode+0x273/0x370 kernel/entry/common.c:218
 do_syscall_64+0x102/0x240 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff888076eed120
 which belongs to the cache ntfs_inode_cache of size 1760
The buggy address is located 1704 bytes inside of
 freed 1760-byte region [ffff888076eed120, ffff888076eed800)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x76ee8
head: order:3 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff80000000840(slab|head|node=0|zone=1|lastcpupid=0xfff)
page_type: 0xffffffff()
raw: 00fff80000000840 ffff888019777dc0 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000110011 00000001ffffffff 0000000000000000
head: 00fff80000000840 ffff888019777dc0 dead000000000122 0000000000000000
head: 0000000000000000 0000000000110011 00000001ffffffff 0000000000000000
head: 00fff80000000003 ffffea0001dbba01 dead000000000122 00000000ffffffff
head: 0000000800000000 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Reclaimable, gfp_mask 0xd2050(__GFP_IO|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_RECLAIMABLE), pid 5077, tgid 1360935967 (syz-executor427), ts 5077, free_ts 25749663853
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
 ntfs_alloc_inode+0x28/0x80 fs/ntfs3/super.c:557
 alloc_inode fs/inode.c:261 [inline]
 iget5_locked+0xa4/0x280 fs/inode.c:1235
 ntfs_iget5+0xc7/0x3b70 fs/ntfs3/inode.c:525
 ntfs_fill_super+0x2f01/0x49c0 fs/ntfs3/super.c:1300
 get_tree_bdev+0x3f7/0x570 fs/super.c:1614
 vfs_get_tree+0x90/0x2a0 fs/super.c:1779
 do_new_mount+0x2be/0xb40 fs/namespace.c:3352
 do_mount fs/namespace.c:3692 [inline]
 __do_sys_mount fs/namespace.c:3898 [inline]
 __se_sys_mount+0x2d9/0x3c0 fs/namespace.c:3875
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
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
 ffff888076eed680: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888076eed700: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888076eed780: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                              ^
 ffff888076eed800: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888076eed880: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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

