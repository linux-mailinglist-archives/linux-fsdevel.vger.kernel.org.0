Return-Path: <linux-fsdevel+bounces-18477-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21E2D8B9698
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2024 10:39:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45BB01C21B2E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2024 08:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FCF146544;
	Thu,  2 May 2024 08:39:30 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F46821A0B
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 May 2024 08:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714639169; cv=none; b=tTsQzOu1uIj2GgLf/7Wge45PC8xocRUv9gKA/Pu1692HZaQSmVzuaAVGeRR0NM0sOjx1/c9uynq9r4sflHASnn516WsDUttlgnvJu9LVHttp3kzwlN1kzpo6cUc+58+qCZRZOEeoUeMjwJldKP2rRQsQd4vd5qFF7kQDsDavL0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714639169; c=relaxed/simple;
	bh=rSpnHOYtnkUEP73ms6hF6CuYO3AJmWnwYNZ3WErQnRg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=D018pJaY0wd7dbegYbAF1NDZrQ4Wv9lDQh3aBfyp/eOyFg76kchbuUifItmYM95Q4t7nMmDo/ngz30gTYxRY+4XVQ50C2fIEZ8k4tYni+WFZdM+8pT1XlWmkmmAbWUS0gD5dlezv6WfjtxKh3C1Y1qYY/qxWkzIIzb4Pa1V8O4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7dda529a35cso865957839f.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 May 2024 01:39:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714639167; x=1715243967;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hh6J8jT52AtDRD1PAOaybgMxVZrYszBBBUsdf7Azj1g=;
        b=alQfUmd2g1sk3HtryAEqlnoFTUjvJaAf719Y2Kq2M5Jrn3SGMZWuIdMJ59JTvcxDN7
         D4eQdcFyk0AJ3+7oJi3qG+V5j2WmQfd7jAinSolezkq5r5dVh3fAYHB0ZsCwc2lmZxz1
         FfGp+SLqJbmwyug4grOhYx3kGf+0QZmeAm67wlPfqPs0GujTwqQavAHYI90blz/znMu0
         45VCiLEgb2dbqAo5MyEke4JtQfTp9tlV2+ChfrVADS+3PzImduhZ9+iaKN47PaCgVy2f
         OZWO2ITl4ZElr7bMbrGWjZ+5UOWidDjGjLaK0jvipZUTrUHyR+ttF1Od9kB19WVlf7b5
         qosg==
X-Forwarded-Encrypted: i=1; AJvYcCUH+uvhkw878SAq5mL77GUZuN5vW2zsJqNrvRCzN7j47Hi0nCqcaehtkiApOzjUdxa2dY3cXyhgt2lmfTb9VmUE2DgNA6GGyokM8w2Mvw==
X-Gm-Message-State: AOJu0YyP1YiPoPfpsKvE1ZosX/uDOLoF4Yo0e9VgT+VIZmZPLw8Bdbu5
	iMYaRyv1SZOFsT3pMxfKLHydJo5u06DxQ5SczXndd8oAev6EKoGsuOLuWC/7snApoecxJsXXlTQ
	yB+XYEpAZlWU6gBVTbsPnLD+BUCvQYVhnH51Y0IzqvGlaz+DLtV+AbDA=
X-Google-Smtp-Source: AGHT+IGqobK3lOmwFSPbUQOu5U7pbAXN68QvY6iIv5vwkJRNNRtcsxnKMbLRWJ4jujbNTYaa0tZ/54uUTEvwQ9gldmbhypfNcGOD
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d9d:b0:36c:11a2:725f with SMTP id
 h29-20020a056e021d9d00b0036c11a2725fmr275664ila.3.1714639167424; Thu, 02 May
 2024 01:39:27 -0700 (PDT)
Date: Thu, 02 May 2024 01:39:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007e1e3a0617748a94@google.com>
Subject: [syzbot] [jfs?] KASAN: slab-use-after-free Read in jfs_strfromUCS_le
From: syzbot <syzbot+c7019fac44a50a2ab16f@syzkaller.appspotmail.com>
To: jfs-discussion@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, shaggy@kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    c942a0cd3603 Merge tag 'for_linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11d85a9b180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5a05c230e142f2bc
dashboard link: https://syzkaller.appspot.com/bug?extid=c7019fac44a50a2ab16f
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/9eed57ad49bb/disk-c942a0cd.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/00b3750541fe/vmlinux-c942a0cd.xz
kernel image: https://storage.googleapis.com/syzbot-assets/384cbdc161a0/bzImage-c942a0cd.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c7019fac44a50a2ab16f@syzkaller.appspotmail.com

ERROR: (device loop3): remounting filesystem as read-only
non-latin1 character 0x706d found in JFS file name
mount with iocharset=utf8 to access
==================================================================
BUG: KASAN: slab-use-after-free in jfs_strfromUCS_le+0x28d/0x3b0 fs/jfs/jfs_unicode.c:40
Read of size 2 at addr ffff8880641f2d32 by task syz-executor.3/6266

CPU: 1 PID: 6266 Comm: syz-executor.3 Not tainted 6.9.0-rc5-syzkaller-00159-gc942a0cd3603 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 jfs_strfromUCS_le+0x28d/0x3b0 fs/jfs/jfs_unicode.c:40
 jfs_readdir+0x19b6/0x4660 fs/jfs/jfs_dtree.c:2965
 wrap_directory_iterator+0x94/0xe0 fs/readdir.c:67
 iterate_dir+0x539/0x6f0 fs/readdir.c:110
 __do_sys_getdents64 fs/readdir.c:409 [inline]
 __se_sys_getdents64+0x20d/0x4f0 fs/readdir.c:394
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f35f267dea9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f35f33a90c8 EFLAGS: 00000246 ORIG_RAX: 00000000000000d9
RAX: ffffffffffffffda RBX: 00007f35f27abf80 RCX: 00007f35f267dea9
RDX: 0000000000001000 RSI: 0000000020000f80 RDI: 0000000000000009
RBP: 00007f35f26ca4a4 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f35f27abf80 R15: 00007fff3bf15438
 </TASK>

Allocated by task 6266:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 unpoison_slab_object mm/kasan/common.c:312 [inline]
 __kasan_slab_alloc+0x66/0x80 mm/kasan/common.c:338
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slub.c:3798 [inline]
 slab_alloc_node mm/slub.c:3845 [inline]
 kmem_cache_alloc_lru+0x178/0x350 mm/slub.c:3864
 alloc_inode_sb include/linux/fs.h:3091 [inline]
 jfs_alloc_inode+0x28/0x70 fs/jfs/super.c:105
 alloc_inode fs/inode.c:261 [inline]
 iget_locked+0x1ad/0x850 fs/inode.c:1280
 jfs_iget+0x22/0x3b0 fs/jfs/inode.c:29
 jfs_lookup+0x226/0x410 fs/jfs/namei.c:1469
 __lookup_slow+0x28c/0x3f0 fs/namei.c:1692
 lookup_slow+0x53/0x70 fs/namei.c:1709
 walk_component+0x2e1/0x410 fs/namei.c:2004
 lookup_last fs/namei.c:2461 [inline]
 path_lookupat+0x16f/0x450 fs/namei.c:2485
 filename_lookup+0x256/0x610 fs/namei.c:2514
 user_path_at_empty+0x42/0x60 fs/namei.c:2921
 user_path_at include/linux/namei.h:57 [inline]
 do_mount fs/namespace.c:3689 [inline]
 __do_sys_mount fs/namespace.c:3898 [inline]
 __se_sys_mount+0x29a/0x3c0 fs/namespace.c:3875
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 1563:
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
 jfs_iget+0x18d/0x3b0 fs/jfs/inode.c:37
 jfs_lookup+0x226/0x410 fs/jfs/namei.c:1469
 __lookup_slow+0x28c/0x3f0 fs/namei.c:1692
 lookup_slow+0x53/0x70 fs/namei.c:1709
 walk_component+0x2e1/0x410 fs/namei.c:2004
 lookup_last fs/namei.c:2461 [inline]
 path_lookupat+0x16f/0x450 fs/namei.c:2485
 filename_lookup+0x256/0x610 fs/namei.c:2514
 user_path_at_empty+0x42/0x60 fs/namei.c:2921
 user_path_at include/linux/namei.h:57 [inline]
 do_mount fs/namespace.c:3689 [inline]
 __do_sys_mount fs/namespace.c:3898 [inline]
 __se_sys_mount+0x29a/0x3c0 fs/namespace.c:3875
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff8880641f2500
 which belongs to the cache jfs_ip of size 2240
The buggy address is located 2098 bytes inside of
 freed 2240-byte region [ffff8880641f2500, ffff8880641f2dc0)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff8880641f0940 pfn:0x641f0
head: order:3 entire_mapcount:0 nr_pages_mapped:0 pincount:0
memcg:ffff888028d26e01
flags: 0xfff80000000840(slab|head|node=0|zone=1|lastcpupid=0xfff)
page_type: 0xffffffff()
raw: 00fff80000000840 ffff8880197d13c0 dead000000000122 0000000000000000
raw: ffff8880641f0940 00000000800d000b 00000001ffffffff ffff888028d26e01
head: 00fff80000000840 ffff8880197d13c0 dead000000000122 0000000000000000
head: ffff8880641f0940 00000000800d000b 00000001ffffffff ffff888028d26e01
head: 00fff80000000003 ffffea0001907c01 dead000000000122 00000000ffffffff
head: 0000000800000000 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Reclaimable, gfp_mask 0x1d2050(__GFP_IO|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_HARDWALL|__GFP_RECLAIMABLE), pid 5433, tgid -1337237977 (syz-executor.3), ts 5435, free_ts 62450070106
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
 iget_locked+0x1ad/0x850 fs/inode.c:1280
 jfs_iget+0x22/0x3b0 fs/jfs/inode.c:29
 jfs_lookup+0x226/0x410 fs/jfs/namei.c:1469
 lookup_one_qstr_excl+0x11f/0x260 fs/namei.c:1607
 do_unlinkat+0x297/0x830 fs/namei.c:4387
 __do_sys_unlink fs/namei.c:4447 [inline]
 __se_sys_unlink fs/namei.c:4445 [inline]
 __x64_sys_unlink+0x49/0x60 fs/namei.c:4445
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page last free pid 50 tgid 50 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1141 [inline]
 free_unref_page_prepare+0x97b/0xaa0 mm/page_alloc.c:2347
 free_unref_page+0x37/0x3f0 mm/page_alloc.c:2487
 __folio_put_large+0x13f/0x190 mm/swap.c:132
 __folio_put+0x299/0x390 mm/swap.c:140
 io_rings_free+0x76/0x370 io_uring/io_uring.c:2801
 io_ring_ctx_free+0x798/0x9a0 io_uring/io_uring.c:2923
 io_ring_exit_work+0x7c7/0x850 io_uring/io_uring.c:3136
 process_one_work kernel/workqueue.c:3254 [inline]
 process_scheduled_works+0xa10/0x17c0 kernel/workqueue.c:3335
 worker_thread+0x86d/0xd70 kernel/workqueue.c:3416
 kthread+0x2f0/0x390 kernel/kthread.c:388
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Memory state around the buggy address:
 ffff8880641f2c00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8880641f2c80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff8880641f2d00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                     ^
 ffff8880641f2d80: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
 ffff8880641f2e00: fc fc fc fc fc fc fc fc fa fb fb fb fb fb fb fb
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

