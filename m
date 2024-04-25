Return-Path: <linux-fsdevel+bounces-17722-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B84BC8B1C56
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 09:59:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAAD21C21C9A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 07:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B04836EB51;
	Thu, 25 Apr 2024 07:59:30 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04456DCE8
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Apr 2024 07:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714031970; cv=none; b=byPBZCtIwl3cS3FaIFKW2Dw5U/ZzlY9W3sr/hZErvdOnX8kCyiWXrSYj0idILhT5XL6Luq3/oEW/M2FIiEUw38FTXY9xK0wNR/sbpRkI6iMx9oX+K/SsQFcb6P6d1LpADksfiuumifbgRh+cvCYBRnOfJFAiiMy5HKVWnsBcrTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714031970; c=relaxed/simple;
	bh=4E2jjArPD80nZDvKsau4iFP2yOxkv1kQVMOziuyPbNw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=pqZbfAMY8I7rRQKBt6MMjpGrFyMtBFYre/fov/Mx4U6XxQ/fKt3vCgh5+qF6TAKp1OP1vkkHdouA3DfPaZDSVmYPPlj7yabzcTQFfwfL1U975vBAeFM8KaSqC8X6/2KsuYRfjvz0dq54sNavyFX+IneB+RQgtMgRP0GJ024OfVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7dad65e5613so75122339f.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Apr 2024 00:59:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714031968; x=1714636768;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JI+ig1oD7MIpva3UZKvQJUrH9KBuWaizU7Bv3AWmx54=;
        b=J2W20ZrRXaF/Y6PulK+sEOxBC87xqd1T79qGTmszSKv1SxfZ5eGes48lepyFiuaSWI
         6n9Mq0K5SljmrxlJ1qlD/o1gVofmUh/OrBosx3L07vZIGrVfCFzW6QgZlj/m7YwFjhm5
         4ILHjWrmgZ7PmU1UwJacMfrTjCsMTOkqUMMVFsyVXOpYFMkezPc05uBglCedVkQVvm02
         bYgBj/+NQZPwUeyPMAfS5k4P3BFwF3nt8kqy6vWt20kTOc0VSDv2kA7Tai4oZqUxyT3W
         tqROBN5Bdjjr3isov9wEymNskBSR5vIDcdnA5uinjeqVOWk7dJv5eMTadMa1xnwzXKwt
         ynJA==
X-Forwarded-Encrypted: i=1; AJvYcCXSP6hptfh9vRW7PRhUGp1anAyIOnL0Xx2KyPuo+nYU1Gqu9oLN/z6jGoS37ynt25T+6kBzcI5QOKYbO5m+D5c5H3+H3W2aeBJdgA9woA==
X-Gm-Message-State: AOJu0Ywb1WsejwRzMeQmfeppCRnqSVGEcK41yljGf7skADP/E3/fp3tK
	EII5Uj3+sBfOCy5uPuO70B02bnjKRfdCvgeM4dOfhyy7N85n4AMtZkrHcfBU/U7DBfzairwh9nP
	PSb9pPpDXmcLWieJ0zihNBOP2q8L5r+hcSW1oG6WrvYZBeTVOlqDfGxQ=
X-Google-Smtp-Source: AGHT+IGv97Rgi1WZRIcMix4Ifbuj6lYQ7t4S8OvA23TOmAF6oP/ZkCcorNQ53P8MUtzSLUyEWvkcBhuWlqaTXCnga6qRKS/dJbuv
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:60cc:b0:7da:eb31:7c9d with SMTP id
 ft12-20020a05660260cc00b007daeb317c9dmr66653iob.2.1714031967858; Thu, 25 Apr
 2024 00:59:27 -0700 (PDT)
Date: Thu, 25 Apr 2024 00:59:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000094036c0616e72a1d@google.com>
Subject: [syzbot] [f2fs?] KASAN: slab-out-of-bounds Read in f2fs_get_node_info
From: syzbot <syzbot+3694e283cf5c40df6d14@syzkaller.appspotmail.com>
To: chao@kernel.org, jaegeuk@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    ed30a4a51bb1 Linux 6.9-rc5
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1116bc30980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5a05c230e142f2bc
dashboard link: https://syzkaller.appspot.com/bug?extid=3694e283cf5c40df6d14
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1128486b180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1516bc30980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/7a2e1a02882c/disk-ed30a4a5.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/329966999344/vmlinux-ed30a4a5.xz
kernel image: https://storage.googleapis.com/syzbot-assets/1befbdf4dcac/bzImage-ed30a4a5.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/42ddf2738cf7/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3694e283cf5c40df6d14@syzkaller.appspotmail.com

F2FS-fs (loop0): Mounted with checkpoint version = 48b305e4
==================================================================
BUG: KASAN: slab-out-of-bounds in f2fs_test_bit fs/f2fs/f2fs.h:2933 [inline]
BUG: KASAN: slab-out-of-bounds in current_nat_addr fs/f2fs/node.h:213 [inline]
BUG: KASAN: slab-out-of-bounds in f2fs_get_node_info+0xece/0x1200 fs/f2fs/node.c:600
Read of size 1 at addr ffff88807a58c76c by task syz-executor280/5076

CPU: 1 PID: 5076 Comm: syz-executor280 Not tainted 6.9.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 f2fs_test_bit fs/f2fs/f2fs.h:2933 [inline]
 current_nat_addr fs/f2fs/node.h:213 [inline]
 f2fs_get_node_info+0xece/0x1200 fs/f2fs/node.c:600
 f2fs_xattr_fiemap fs/f2fs/data.c:1848 [inline]
 f2fs_fiemap+0x55d/0x1ee0 fs/f2fs/data.c:1925
 ioctl_fiemap fs/ioctl.c:220 [inline]
 do_vfs_ioctl+0x1c07/0x2e50 fs/ioctl.c:838
 __do_sys_ioctl fs/ioctl.c:902 [inline]
 __se_sys_ioctl+0x81/0x170 fs/ioctl.c:890
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f60d34ae739
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 61 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc9f2f1148 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007ffc9f2f1318 RCX: 00007f60d34ae739
RDX: 0000000020000040 RSI: 00000000c020660b RDI: 0000000000000004
RBP: 00007f60d3527610 R08: 0000000000000000 R09: 00007ffc9f2f1318
R10: 000000000000551a R11: 0000000000000246 R12: 0000000000000001
R13: 00007ffc9f2f1308 R14: 0000000000000001 R15: 0000000000000001
 </TASK>

Allocated by task 5076:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:387
 kasan_kmalloc include/linux/kasan.h:211 [inline]
 __do_kmalloc_node mm/slub.c:3966 [inline]
 __kmalloc_node_track_caller+0x24e/0x4e0 mm/slub.c:3986
 kmemdup+0x2a/0x60 mm/util.c:131
 init_node_manager fs/f2fs/node.c:3268 [inline]
 f2fs_build_node_manager+0x8cc/0x2870 fs/f2fs/node.c:3329
 f2fs_fill_super+0x583c/0x8120 fs/f2fs/super.c:4540
 mount_bdev+0x20a/0x2d0 fs/super.c:1658
 legacy_get_tree+0xee/0x190 fs/fs_context.c:662
 vfs_get_tree+0x90/0x2a0 fs/super.c:1779
 do_new_mount+0x2be/0xb40 fs/namespace.c:3352
 do_mount fs/namespace.c:3692 [inline]
 __do_sys_mount fs/namespace.c:3898 [inline]
 __se_sys_mount+0x2d9/0x3c0 fs/namespace.c:3875
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff88807a58c700
 which belongs to the cache kmalloc-64 of size 64
The buggy address is located 44 bytes to the right of
 allocated 64-byte region [ffff88807a58c700, ffff88807a58c740)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x7a58c
flags: 0xfff80000000800(slab|node=0|zone=1|lastcpupid=0xfff)
page_type: 0xffffffff()
raw: 00fff80000000800 ffff888015041640 ffffea0000aa6400 dead000000000004
raw: 0000000000000000 0000000000200020 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x12c40(GFP_NOFS|__GFP_NOWARN|__GFP_NORETRY), pid 4536, tgid 106643948 (udevd), ts 4536, free_ts 43042041281
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
 __do_kmalloc_node mm/slub.c:3965 [inline]
 __kmalloc+0x2e5/0x4a0 mm/slub.c:3979
 kmalloc include/linux/slab.h:632 [inline]
 kzalloc include/linux/slab.h:749 [inline]
 tomoyo_encode2 security/tomoyo/realpath.c:45 [inline]
 tomoyo_encode+0x26f/0x540 security/tomoyo/realpath.c:80
 tomoyo_realpath_from_path+0x59e/0x5e0 security/tomoyo/realpath.c:283
 tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
 tomoyo_path_number_perm+0x23a/0x880 security/tomoyo/file.c:723
 tomoyo_path_mknod+0x176/0x1b0 security/tomoyo/tomoyo.c:252
 security_path_mknod+0xf8/0x150 security/security.c:1791
 may_o_create fs/namei.c:3319 [inline]
 lookup_open fs/namei.c:3460 [inline]
 open_last_lookups fs/namei.c:3566 [inline]
 path_openat+0xc7c/0x3240 fs/namei.c:3796
 do_filp_open+0x235/0x490 fs/namei.c:3826
 do_sys_openat2+0x13e/0x1d0 fs/open.c:1406
 do_sys_open fs/open.c:1421 [inline]
 __do_sys_openat fs/open.c:1437 [inline]
 __se_sys_openat fs/open.c:1432 [inline]
 __x64_sys_openat+0x247/0x2a0 fs/open.c:1432
page last free pid 4528 tgid 4528 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1141 [inline]
 free_unref_page_prepare+0x97b/0xaa0 mm/page_alloc.c:2347
 free_unref_page+0x37/0x3f0 mm/page_alloc.c:2487
 __slab_free+0x31b/0x3d0 mm/slub.c:4192
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x5e/0xc0 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x14f/0x170 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x23/0x80 mm/kasan/common.c:322
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slub.c:3798 [inline]
 slab_alloc_node mm/slub.c:3845 [inline]
 __do_kmalloc_node mm/slub.c:3965 [inline]
 __kmalloc+0x1e2/0x4a0 mm/slub.c:3979
 kmalloc include/linux/slab.h:632 [inline]
 kzalloc include/linux/slab.h:749 [inline]
 tomoyo_encode2 security/tomoyo/realpath.c:45 [inline]
 tomoyo_encode+0x26f/0x540 security/tomoyo/realpath.c:80
 tomoyo_realpath_from_path+0x59e/0x5e0 security/tomoyo/realpath.c:283
 tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
 tomoyo_path_number_perm+0x23a/0x880 security/tomoyo/file.c:723
 tomoyo_path_mknod+0x176/0x1b0 security/tomoyo/tomoyo.c:252
 security_path_mknod+0xf8/0x150 security/security.c:1791
 may_o_create fs/namei.c:3319 [inline]
 lookup_open fs/namei.c:3460 [inline]
 open_last_lookups fs/namei.c:3566 [inline]
 path_openat+0xc7c/0x3240 fs/namei.c:3796
 do_filp_open+0x235/0x490 fs/namei.c:3826
 do_sys_openat2+0x13e/0x1d0 fs/open.c:1406
 do_sys_open fs/open.c:1421 [inline]
 __do_sys_openat fs/open.c:1437 [inline]
 __se_sys_openat fs/open.c:1432 [inline]
 __x64_sys_openat+0x247/0x2a0 fs/open.c:1432

Memory state around the buggy address:
 ffff88807a58c600: 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc
 ffff88807a58c680: 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc
>ffff88807a58c700: 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc
                                                          ^
 ffff88807a58c780: 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc
 ffff88807a58c800: 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc
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

