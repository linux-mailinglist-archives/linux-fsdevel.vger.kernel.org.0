Return-Path: <linux-fsdevel+bounces-15807-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0E328931FB
	for <lists+linux-fsdevel@lfdr.de>; Sun, 31 Mar 2024 16:35:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 549391F214D1
	for <lists+linux-fsdevel@lfdr.de>; Sun, 31 Mar 2024 14:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F3816A03F;
	Sun, 31 Mar 2024 14:35:36 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0691F5F5
	for <linux-fsdevel@vger.kernel.org>; Sun, 31 Mar 2024 14:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711895735; cv=none; b=EI6DjE7QMugP1a2ns7GuBoIiyp3Fx3j7R6JvEPLiWFC1JolbmZFoZZsjeTuGh5MgQdTjSPBk5jJhPklPEnrMLRK6LPQwjCG1WxNAnsoYR9JkCYX6CpAa7kVgYripSi0VliUsoHj5roxIppeKJrOxEArWjdAxSTAgfOM3WXR6rSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711895735; c=relaxed/simple;
	bh=97Qu2IlIhpj5VYcHMQgH/kB4Td3Du7O1quw0M+8FhYs=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=q0tUds05+imjJbH2y0Rwfc4FcW61f1nex+nug8qI6skuQWhr70uVI4swWR4FlNDTvGGKsp7nwFX3zDiikGUqUzzSgZRc34hSkQ0lWmT5uPGaPJ/PEi++8rF1tViJDUVx7G0Xys+rCDV+vUlfzhSxDUSu63hANPoMwS0p85XlPeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7cbfd4781fcso368528339f.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 31 Mar 2024 07:35:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711895733; x=1712500533;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DN4PD01yYckogBGSZ8OktciIrgnu+3oaAUEVt9TkKts=;
        b=YKldDbLSoVuwotdCCZ6uNZsVan+0+LYrXUFZTUbpx0AEIBeJrhPuIUOWfoHcJ1qnKQ
         +0S3Y9EZfIdXJGy0OVsWnvclWDSGc9Xe0klhivbwW3JEcUjwRZHjSCTtK4o0GRAJ4zuo
         RZBPkZJSemMhovmg0Dz/HpsvmlrbvnsEEPqtwGbA3eYTZb9zzEXGuabg9eu8lOyhRCkz
         5Xm/oF23zY49mIItsklwXHJzP0flQDwhWcC41gOXk0Mp38IF7dE+MTYC68XbWQKWBL4x
         xDB2HwC67M8GSnpieYrjUQg74cvee+QHT43MuzIHbqwz7yA0uatmVD9BZdTBej5usbYi
         4ymw==
X-Gm-Message-State: AOJu0YzZxSOawzga4Zfq/V5S+fR35nbdJfCfgBmRqgr6T7kncyffexf/
	N5+aOJAHvdRi3NFCQ8BebiNQdw0aKa+fvMqRIebjBCC1tYen+DOHXQQx7AYV9FQv2I8kJ7GAkJH
	HFXQ5loN0N4oF7LpLyO5A8kyVBlGX7hNvJfS0i/vQCEko2BSeSt1i6nXVbA==
X-Google-Smtp-Source: AGHT+IFhrgj6qDiIEBSHyJnCL0CG3j5VaKi4ijebRU46m6Xs3XQBg5NHm2n38wY/DkZx52uhiGcq+xodHHOik4Ee5exCT6MYEJcG
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d1c:b0:368:9634:797c with SMTP id
 i28-20020a056e021d1c00b003689634797cmr504362ila.6.1711895733137; Sun, 31 Mar
 2024 07:35:33 -0700 (PDT)
Date: Sun, 31 Mar 2024 07:35:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001126200614f5c9c4@google.com>
Subject: [syzbot] [hfs?] KASAN: slab-use-after-free Read in
 hfsplus_read_wrapper (2)
From: syzbot <syzbot+fa7b3ab32bcb56c10961@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    fe46a7dd189e Merge tag 'sound-6.9-rc1' of git://git.kernel..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=165f4ad9180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1a07d5da4eb21586
dashboard link: https://syzkaller.appspot.com/bug?extid=fa7b3ab32bcb56c10961
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12d96e76180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13b52579180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b42ab0fd4947/disk-fe46a7dd.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b8a6e7231930/vmlinux-fe46a7dd.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4fbf3e4ce6f8/bzImage-fe46a7dd.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/d71f61687d0b/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+fa7b3ab32bcb56c10961@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in hfsplus_read_wrapper+0xf86/0x1070 fs/hfsplus/wrapper.c:226
Read of size 2 at addr ffff888024fba400 by task syz-executor204/5218

CPU: 1 PID: 5218 Comm: syz-executor204 Not tainted 6.8.0-syzkaller-08951-gfe46a7dd189e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/29/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:114
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0xc3/0x620 mm/kasan/report.c:488
 kasan_report+0xd9/0x110 mm/kasan/report.c:601
 hfsplus_read_wrapper+0xf86/0x1070 fs/hfsplus/wrapper.c:226
 hfsplus_fill_super+0x352/0x1bc0 fs/hfsplus/super.c:419
 mount_bdev+0x1e6/0x2d0 fs/super.c:1658
 legacy_get_tree+0x10c/0x220 fs/fs_context.c:662
 vfs_get_tree+0x92/0x380 fs/super.c:1779
 do_new_mount fs/namespace.c:3352 [inline]
 path_mount+0x14e6/0x1f20 fs/namespace.c:3679
 do_mount fs/namespace.c:3692 [inline]
 __do_sys_mount fs/namespace.c:3898 [inline]
 __se_sys_mount fs/namespace.c:3875 [inline]
 __x64_sys_mount+0x297/0x320 fs/namespace.c:3875
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xd5/0x260 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
RIP: 0033:0x7f706ca0c69a
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 5e 04 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffcd3a1c1c8 EFLAGS: 00000286 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f706ca0c69a
RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007ffcd3a1c210
RBP: 0000000000000004 R08: 00007ffcd3a1c250 R09: 0000000000000632
R10: 0000000000000050 R11: 0000000000000286 R12: 00007ffcd3a1c210
R13: 00007ffcd3a1c250 R14: 0000000000080000 R15: 0000000000000003
 </TASK>

The buggy address belongs to the object at ffff888024fba400
 which belongs to the cache kmalloc-512 of size 512
The buggy address is located 0 bytes inside of
 freed 512-byte region [ffff888024fba400, ffff888024fba600)

The buggy address belongs to the physical page:
page:ffffea000093ee00 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x24fb8
head:ffffea000093ee00 order:2 entire_mapcount:0 nr_pages_mapped:0 pincount:0
anon flags: 0xfff00000000840(slab|head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000000840 ffff888015041c80 0000000000000000 dead000000000001
raw: 0000000000000000 0000000080100010 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 2, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 4522, tgid 4522 (udevd), ts 49858478025, free_ts 49837791007
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x2d4/0x350 mm/page_alloc.c:1533
 prep_new_page mm/page_alloc.c:1540 [inline]
 get_page_from_freelist+0xa28/0x3780 mm/page_alloc.c:3311
 __alloc_pages+0x22b/0x2410 mm/page_alloc.c:4569
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
 kzalloc include/linux/slab.h:749 [inline]
 kernfs_fop_open+0x28b/0xd40 fs/kernfs/file.c:621
 do_dentry_open+0x8dd/0x18c0 fs/open.c:955
 do_open fs/namei.c:3642 [inline]
 path_openat+0x1dfb/0x2990 fs/namei.c:3799
 do_filp_open+0x1dc/0x430 fs/namei.c:3826
 do_sys_openat2+0x17a/0x1e0 fs/open.c:1406
 do_sys_open fs/open.c:1421 [inline]
 __do_sys_openat fs/open.c:1437 [inline]
 __se_sys_openat fs/open.c:1432 [inline]
 __x64_sys_openat+0x175/0x210 fs/open.c:1432
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xd5/0x260 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
page last free pid 4529 tgid 4529 stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1140 [inline]
 free_unref_page_prepare+0x527/0xb10 mm/page_alloc.c:2346
 free_unref_page+0x33/0x3c0 mm/page_alloc.c:2486
 __put_partials+0x14c/0x170 mm/slub.c:2906
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x4e/0x140 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x192/0x1e0 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x69/0x90 mm/kasan/common.c:322
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slub.c:3798 [inline]
 slab_alloc_node mm/slub.c:3845 [inline]
 kmem_cache_alloc_node+0x177/0x340 mm/slub.c:3888
 __alloc_skb+0x2b1/0x380 net/core/skbuff.c:658
 alloc_skb include/linux/skbuff.h:1318 [inline]
 netlink_alloc_large_skb+0x69/0x130 net/netlink/af_netlink.c:1210
 netlink_sendmsg+0x689/0xd70 net/netlink/af_netlink.c:1880
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg net/socket.c:745 [inline]
 ____sys_sendmsg+0xab8/0xc90 net/socket.c:2584
 ___sys_sendmsg+0x135/0x1e0 net/socket.c:2638
 __sys_sendmsg+0x117/0x1f0 net/socket.c:2667
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xd5/0x260 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x6d/0x75

Memory state around the buggy address:
 ffff888024fba300: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888024fba380: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff888024fba400: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                   ^
 ffff888024fba480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888024fba500: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================
hfsplus: unable to set blocksize to 1024!
hfsplus: unable to find HFS+ superblock


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

