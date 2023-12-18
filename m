Return-Path: <linux-fsdevel+bounces-6364-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 301908173F5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Dec 2023 15:43:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46FDB1C249EF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Dec 2023 14:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B28FB1E52B;
	Mon, 18 Dec 2023 14:43:29 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4E53789B
	for <linux-fsdevel@vger.kernel.org>; Mon, 18 Dec 2023 14:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7b71da9f8b9so573828239f.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Dec 2023 06:43:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702910607; x=1703515407;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EM88xTFig+JbgiSlhAOOt+tZ4fN5H09dR4j9K9Kl5MY=;
        b=dEbFny6mudbLePFq+yoC+nT+U1C7ybdGKEjgQTJVIWXQzbWL3IGjdCOxUXLKAteYmm
         uyljCciGjW13tI4RH/vPP6JTOhKqdYc1sFOn3OUke7km5OGZNSR6j/JUkOcMPK2rq4BH
         8YR52fMPA0HNvcPEhdJHXNLF279a1Xdq3ak+v/3MnoRa78EG1X74UGffY9n+iwIXh+an
         G+xaZ5rlN9gOznUYp47XbzBPNVF4e/Rha+sO+XvN7kCQuyGC0hw8UYiveh1+F4lRizLP
         oSdU/BiPrk8WRW3k1+FVfSKekZmleafeND2IGbd/rqlZPhdDMltVYuV8bwh9j0e7xgDF
         wdwg==
X-Gm-Message-State: AOJu0Yx2YCY6BqLfT6Zr4K18v5YJAc/wRHym0H5Ls68UMkYMZBXFGj6y
	16GOoP3Vri0Gmke/pfu31rPwwJG1QPZqY7GPl9T6pGQQBBvF
X-Google-Smtp-Source: AGHT+IF3iS+Y8LvysDbPGm5d2MaCQR8Xx6BmUWHdvv/F8tE23+9O4yvUFYTzx8h0LC0fE2+bdukt3Twp6DbzlDhxggmupmnZqOle
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:62a1:b0:466:5e39:7098 with SMTP id
 fh33-20020a05663862a100b004665e397098mr1118350jab.5.1702910607070; Mon, 18
 Dec 2023 06:43:27 -0800 (PST)
Date: Mon, 18 Dec 2023 06:43:27 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d1a1d1060cc9c5e7@google.com>
Subject: [syzbot] [btrfs?] KASAN: slab-out-of-bounds Read in getname_kernel (2)
From: syzbot <syzbot+33f23b49ac24f986c9e8@syzkaller.appspotmail.com>
To: clm@fb.com, daniel@iogearbox.net, dsterba@suse.com, 
	john.fastabend@gmail.com, josef@toxicpanda.com, linux-btrfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	liujian56@huawei.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    3bd7d7488169 Merge tag 'io_uring-6.7-2023-12-15' of git://..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=13732cc6e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=53ec3da1d259132f
dashboard link: https://syzkaller.appspot.com/bug?extid=33f23b49ac24f986c9e8
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16d8ba06e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=136fd5b2e80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/99b3f103aa0b/disk-3bd7d748.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/32f8e3e696ce/vmlinux-3bd7d748.xz
kernel image: https://storage.googleapis.com/syzbot-assets/cb20a5445c11/bzImage-3bd7d748.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/4f5365674997/mount_0.gz

The issue was bisected to:

commit 9974d37ea75f01b47d16072b5dad305bd8d23fcc
Author: Liu Jian <liujian56@huawei.com>
Date:   Tue Jun 28 12:36:16 2022 +0000

    skmsg: Fix invalid last sg check in sk_msg_recvmsg()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=172b998ae80000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=14ab998ae80000
console output: https://syzkaller.appspot.com/x/log.txt?x=10ab998ae80000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+33f23b49ac24f986c9e8@syzkaller.appspotmail.com
Fixes: 9974d37ea75f ("skmsg: Fix invalid last sg check in sk_msg_recvmsg()")

BTRFS info (device loop0): clearing compat-ro feature flag for FREE_SPACE_TREE_VALID (0x2)
==================================================================
BUG: KASAN: slab-out-of-bounds in strlen+0x58/0x70 lib/string.c:418
Read of size 1 at addr ffff88801d7f2a28 by task syz-executor424/5057

CPU: 1 PID: 5057 Comm: syz-executor424 Not tainted 6.7.0-rc5-syzkaller-00200-g3bd7d7488169 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:364 [inline]
 print_report+0x163/0x540 mm/kasan/report.c:475
 kasan_report+0x142/0x170 mm/kasan/report.c:588
 strlen+0x58/0x70 lib/string.c:418
 getname_kernel+0x1d/0x2e0 fs/namei.c:226
 kern_path+0x1d/0x50 fs/namei.c:2609
 lookup_bdev block/bdev.c:979 [inline]
 bdev_open_by_path+0xd1/0x540 block/bdev.c:901
 btrfs_init_dev_replace_tgtdev fs/btrfs/dev-replace.c:260 [inline]
 btrfs_dev_replace_start fs/btrfs/dev-replace.c:638 [inline]
 btrfs_dev_replace_by_ioctl+0x41b/0x2010 fs/btrfs/dev-replace.c:747
 btrfs_ioctl_dev_replace+0x2c9/0x390 fs/btrfs/ioctl.c:3299
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:871 [inline]
 __se_sys_ioctl+0xf8/0x170 fs/ioctl.c:857
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x45/0x110 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7f8e8ffdc079
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 61 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe15cbe138 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007ffe15cbe308 RCX: 00007f8e8ffdc079
RDX: 0000000020000540 RSI: 00000000ca289435 RDI: 0000000000000005
RBP: 00007f8e90054610 R08: 00007ffe15cbe308 R09: 00007ffe15cbe308
R10: 00007ffe15cbe308 R11: 0000000000000246 R12: 0000000000000001
R13: 00007ffe15cbe2f8 R14: 0000000000000001 R15: 0000000000000001
 </TASK>

Allocated by task 5057:
 kasan_save_stack mm/kasan/common.c:45 [inline]
 kasan_set_track+0x4f/0x70 mm/kasan/common.c:52
 ____kasan_kmalloc mm/kasan/common.c:374 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:383
 kasan_kmalloc include/linux/kasan.h:198 [inline]
 __do_kmalloc_node mm/slab_common.c:1007 [inline]
 __kmalloc_node_track_caller+0xb1/0x190 mm/slab_common.c:1027
 memdup_user+0x2b/0xc0 mm/util.c:197
 btrfs_ioctl_dev_replace+0xb8/0x390 fs/btrfs/ioctl.c:3286
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:871 [inline]
 __se_sys_ioctl+0xf8/0x170 fs/ioctl.c:857
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x45/0x110 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

The buggy address belongs to the object at ffff88801d7f2000
 which belongs to the cache kmalloc-4k of size 4096
The buggy address is located 0 bytes to the right of
 allocated 2600-byte region [ffff88801d7f2000, ffff88801d7f2a28)

The buggy address belongs to the physical page:
page:ffffea000075fc00 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1d7f0
head:ffffea000075fc00 order:3 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000840(slab|head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000000840 ffff888012c42140 ffffea00007b5600 0000000000000002
raw: 0000000000000000 0000000080040004 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd2040(__GFP_IO|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 4716, tgid 4716 (ifup), ts 29920494589, free_ts 29905444571
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x1e6/0x210 mm/page_alloc.c:1537
 prep_new_page mm/page_alloc.c:1544 [inline]
 get_page_from_freelist+0x33ea/0x3570 mm/page_alloc.c:3312
 __alloc_pages+0x255/0x680 mm/page_alloc.c:4568
 alloc_pages_mpol+0x3de/0x640 mm/mempolicy.c:2133
 alloc_slab_page+0x6a/0x170 mm/slub.c:1870
 allocate_slab mm/slub.c:2017 [inline]
 new_slab+0x84/0x2f0 mm/slub.c:2070
 ___slab_alloc+0xc8a/0x1330 mm/slub.c:3223
 __slab_alloc mm/slub.c:3322 [inline]
 __slab_alloc_node mm/slub.c:3375 [inline]
 slab_alloc_node mm/slub.c:3468 [inline]
 __kmem_cache_alloc_node+0x21d/0x300 mm/slub.c:3517
 __do_kmalloc_node mm/slab_common.c:1006 [inline]
 __kmalloc+0xa2/0x1a0 mm/slab_common.c:1020
 kmalloc include/linux/slab.h:604 [inline]
 tomoyo_realpath_from_path+0xcf/0x5e0 security/tomoyo/realpath.c:251
 tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
 tomoyo_check_open_permission+0x255/0x500 security/tomoyo/file.c:771
 security_file_open+0x63/0xa0 security/security.c:2836
 do_dentry_open+0x327/0x1590 fs/open.c:935
 do_open fs/namei.c:3622 [inline]
 path_openat+0x2849/0x3290 fs/namei.c:3779
 do_filp_open+0x234/0x490 fs/namei.c:3809
 do_sys_openat2+0x13e/0x1d0 fs/open.c:1440
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1137 [inline]
 free_unref_page_prepare+0x931/0xa60 mm/page_alloc.c:2347
 free_unref_page+0x37/0x3f0 mm/page_alloc.c:2487
 discard_slab mm/slub.c:2116 [inline]
 __unfreeze_partials+0x1e0/0x220 mm/slub.c:2655
 put_cpu_partial+0x17b/0x250 mm/slub.c:2731
 __slab_free+0x2b6/0x390 mm/slub.c:3679
 qlink_free mm/kasan/quarantine.c:168 [inline]
 qlist_free_all+0x75/0xe0 mm/kasan/quarantine.c:187
 kasan_quarantine_reduce+0x14b/0x160 mm/kasan/quarantine.c:294
 __kasan_slab_alloc+0x23/0x70 mm/kasan/common.c:305
 kasan_slab_alloc include/linux/kasan.h:188 [inline]
 slab_post_alloc_hook+0x6c/0x3c0 mm/slab.h:763
 slab_alloc_node mm/slub.c:3478 [inline]
 __kmem_cache_alloc_node+0x1d0/0x300 mm/slub.c:3517
 __do_kmalloc_node mm/slab_common.c:1006 [inline]
 __kmalloc+0xa2/0x1a0 mm/slab_common.c:1020
 kmalloc include/linux/slab.h:604 [inline]
 tomoyo_realpath_from_path+0xcf/0x5e0 security/tomoyo/realpath.c:251
 tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
 tomoyo_path_perm+0x2b7/0x730 security/tomoyo/file.c:822
 security_inode_getattr+0xd3/0x120 security/security.c:2153
 vfs_getattr+0x46/0x430 fs/stat.c:173
 vfs_fstat fs/stat.c:198 [inline]
 vfs_fstatat+0xd6/0x190 fs/stat.c:295

Memory state around the buggy address:
 ffff88801d7f2900: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff88801d7f2980: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff88801d7f2a00: 00 00 00 00 00 fc fc fc fc fc fc fc fc fc fc fc
                                  ^
 ffff88801d7f2a80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88801d7f2b00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
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

