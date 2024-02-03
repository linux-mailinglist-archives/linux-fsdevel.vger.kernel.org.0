Return-Path: <linux-fsdevel+bounces-10140-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0928384848D
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Feb 2024 09:40:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB570B244CA
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Feb 2024 08:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA45D5C911;
	Sat,  3 Feb 2024 08:40:39 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26C558ACA
	for <linux-fsdevel@vger.kernel.org>; Sat,  3 Feb 2024 08:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706949639; cv=none; b=bZjfsML3AZa9UIR0etHTrs5rMn0L7B23v8L5ohjxYfZuDewRwRXLhjlqds70MOmRaLTFNowfoRNmrpPChsWOoRlcPFV6EVv/gWD1Muuh2Q60kafanhlLJ7lWlmABzqzMu3STR4f6R7lM/f0Mc1HUuu3Dj3a+ENhbk6GMpAbq29c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706949639; c=relaxed/simple;
	bh=xXdbn6Th8/yeDhRqmzj0sSt8ciexr4KqOD/UcR5HxtY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=rSYVzwJ2MxZZtd9IJg4dOPDY9zLHAL6U+52SBPzNlOa8l17fzVXw0pF7yGYU2iDOvvcKCJDBeeSKyRASaqbexnRcmUSEHxECw8LSUkn1ieBRay5mNZK+vLvdaMQkPKuai36M9ZHEe2/6KyJdDEho0AU1Ep/1jotb/fM5xlLgHMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3610073a306so25627675ab.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 03 Feb 2024 00:40:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706949637; x=1707554437;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JH0UWT1VuRwhxv8uLMOG4NLnKvFJPMKiFk/HBOsm7hQ=;
        b=SsGq2fUtthdX+RjlovizH+berO9vPjBYlItDCF6N46tzdNHJM6KSGzACmBOQtQ3m2C
         f5ZYqZLp4EfUmlcDjOMeW+1lvPoJxP1rjcPTOfG6l23lsT6bBGTTTA0InCXd0HUw/klx
         hMV1ZCYWUaqRHhYPJ+3mlXz+qC2J/we01zazz0yr+H93w5VrULDNGG8ww5ZzsUMjv+Fb
         p87B5jJ0qd58+8m0Dqig76yuE1WlUVNYkqe0oZQ5bDVO262eW/EG6zrnRhIpasmP5KVm
         76+wz0RgHAnSHg56hMRYDZtvYUgn7buq3jCJYfCvovdN/00qxpYZ/WualCh8N3hpxUTx
         XBvg==
X-Gm-Message-State: AOJu0YxSyY60HHkpPoNkSFKPmKyKtBptoZRJf3huZNjsv5c4zhXK40+q
	z5d5ZAcZpgBBQBK0uZfZfdhfTzid9pdvJsP9vCotW/pDSx+JNpv3+O2qnbYIpoQ8HhLSRI+L9S8
	tJOn4QAoqGQVblaxrqo2XLyr7znCko+AtJrGMEug3XzMC4vohbVdAkcQX2Q==
X-Google-Smtp-Source: AGHT+IEVD9aSEI5bN0h/gXEQTfUm8DdstSspgqVswzFZrvfGdC5J5hma4eh89yuk6yKhlgifRWapWI/0S/ntBHlEFGUO2Vh0CqTZ
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:388a:b0:363:b877:a4c7 with SMTP id
 cn10-20020a056e02388a00b00363b877a4c7mr213432ilb.1.1706949637010; Sat, 03 Feb
 2024 00:40:37 -0800 (PST)
Date: Sat, 03 Feb 2024 00:40:36 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c37a740610762e55@google.com>
Subject: [syzbot] [hfs?] KASAN: slab-out-of-bounds Write in hfsplus_bnode_read_key
From: syzbot <syzbot+57028366b9825d8e8ad0@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    076d56d74f17 Add linux-next specific files for 20240202
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1773d5d3e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=428086ff1c010d9f
dashboard link: https://syzkaller.appspot.com/bug?extid=57028366b9825d8e8ad0
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1692c160180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13bab004180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/dece45d1a4b5/disk-076d56d7.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4921e269b178/vmlinux-076d56d7.xz
kernel image: https://storage.googleapis.com/syzbot-assets/2a9156da9091/bzImage-076d56d7.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/a4851316d70a/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+57028366b9825d8e8ad0@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 1024
==================================================================
BUG: KASAN: slab-out-of-bounds in memcpy_from_page include/linux/highmem.h:417 [inline]
BUG: KASAN: slab-out-of-bounds in hfsplus_bnode_read fs/hfsplus/bnode.c:32 [inline]
BUG: KASAN: slab-out-of-bounds in hfsplus_bnode_read_key+0x394/0x610 fs/hfsplus/bnode.c:70
Write of size 3970 at addr ffff88802a197800 by task syz-executor339/5066

CPU: 0 PID: 5066 Comm: syz-executor339 Not tainted 6.8.0-rc2-next-20240202-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2e0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 kasan_check_range+0x282/0x290 mm/kasan/generic.c:189
 __asan_memcpy+0x40/0x70 mm/kasan/shadow.c:106
 memcpy_from_page include/linux/highmem.h:417 [inline]
 hfsplus_bnode_read fs/hfsplus/bnode.c:32 [inline]
 hfsplus_bnode_read_key+0x394/0x610 fs/hfsplus/bnode.c:70
 hfsplus_brec_insert+0x6ea/0xde0 fs/hfsplus/brec.c:141
 hfsplus_create_attr+0x4a2/0x640 fs/hfsplus/attributes.c:252
 __hfsplus_setxattr+0x6fe/0x22d0 fs/hfsplus/xattr.c:354
 hfsplus_setxattr+0xb0/0xe0 fs/hfsplus/xattr.c:434
 hfsplus_security_setxattr+0x40/0x60 fs/hfsplus/xattr_security.c:31
 __vfs_setxattr+0x468/0x4a0 fs/xattr.c:201
 __vfs_setxattr_noperm+0x12e/0x5e0 fs/xattr.c:235
 vfs_setxattr+0x221/0x430 fs/xattr.c:322
 do_setxattr fs/xattr.c:630 [inline]
 setxattr+0x25d/0x2f0 fs/xattr.c:653
 path_setxattr+0x1c0/0x2a0 fs/xattr.c:672
 __do_sys_setxattr fs/xattr.c:688 [inline]
 __se_sys_setxattr fs/xattr.c:684 [inline]
 __x64_sys_setxattr+0xbb/0xd0 fs/xattr.c:684
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
RIP: 0033:0x7fc180ad2639
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 61 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc6080f8c8 EFLAGS: 00000246 ORIG_RAX: 00000000000000bc
RAX: ffffffffffffffda RBX: 0031656c69662f2e RCX: 00007fc180ad2639
RDX: 0000000000000000 RSI: 0000000020000140 RDI: 0000000020000240
RBP: 00007fc180b45610 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00007ffc6080fa98 R14: 0000000000000001 R15: 0000000000000001
 </TASK>

Allocated by task 5066:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:387
 kasan_kmalloc include/linux/kasan.h:211 [inline]
 __do_kmalloc_node mm/slub.c:3982 [inline]
 __kmalloc+0x231/0x4a0 mm/slub.c:3995
 kmalloc include/linux/slab.h:594 [inline]
 hfsplus_find_init+0x85/0x1c0 fs/hfsplus/bfind.c:21
 hfsplus_create_attr+0x161/0x640 fs/hfsplus/attributes.c:216
 __hfsplus_setxattr+0x6fe/0x22d0 fs/hfsplus/xattr.c:354
 hfsplus_setxattr+0xb0/0xe0 fs/hfsplus/xattr.c:434
 hfsplus_security_setxattr+0x40/0x60 fs/hfsplus/xattr_security.c:31
 __vfs_setxattr+0x468/0x4a0 fs/xattr.c:201
 __vfs_setxattr_noperm+0x12e/0x5e0 fs/xattr.c:235
 vfs_setxattr+0x221/0x430 fs/xattr.c:322
 do_setxattr fs/xattr.c:630 [inline]
 setxattr+0x25d/0x2f0 fs/xattr.c:653
 path_setxattr+0x1c0/0x2a0 fs/xattr.c:672
 __do_sys_setxattr fs/xattr.c:688 [inline]
 __se_sys_setxattr fs/xattr.c:684 [inline]
 __x64_sys_setxattr+0xbb/0xd0 fs/xattr.c:684
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x6d/0x75

The buggy address belongs to the object at ffff88802a197800
 which belongs to the cache kmalloc-1k of size 1024
The buggy address is located 0 bytes inside of
 allocated 536-byte region [ffff88802a197800, ffff88802a197a18)

The buggy address belongs to the physical page:
page:ffffea0000a86400 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x2a190
head:ffffea0000a86400 order:3 entire_mapcount:0 nr_pages_mapped:0 pincount:0
anon flags: 0xfff80000000840(slab|head|node=0|zone=1|lastcpupid=0xfff)
page_type: 0xffffffff()
raw: 00fff80000000840 ffff888014c41dc0 0000000000000000 dead000000000001
raw: 0000000000000000 0000000080100010 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 1, tgid 1 (swapper/0), ts 10670801188, free_ts 0
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x1ea/0x210 mm/page_alloc.c:1539
 prep_new_page mm/page_alloc.c:1546 [inline]
 get_page_from_freelist+0x34eb/0x3680 mm/page_alloc.c:3353
 __alloc_pages+0x256/0x680 mm/page_alloc.c:4609
 __alloc_pages_node include/linux/gfp.h:238 [inline]
 alloc_pages_node include/linux/gfp.h:261 [inline]
 alloc_slab_page+0x5f/0x160 mm/slub.c:2191
 allocate_slab mm/slub.c:2354 [inline]
 new_slab+0x84/0x2f0 mm/slub.c:2407
 ___slab_alloc+0xc73/0x1260 mm/slub.c:3541
 __slab_alloc mm/slub.c:3626 [inline]
 __slab_alloc_node mm/slub.c:3679 [inline]
 slab_alloc_node mm/slub.c:3851 [inline]
 __do_kmalloc_node mm/slub.c:3981 [inline]
 __kmalloc+0x2e3/0x4a0 mm/slub.c:3995
 kmalloc include/linux/slab.h:594 [inline]
 kzalloc include/linux/slab.h:711 [inline]
 alloc_workqueue+0x19b/0x1f40 kernel/workqueue.c:5196
 nf_flow_table_offload_init+0x3c/0xb0 net/netfilter/nf_flow_table_offload.c:1217
 nf_flow_table_module_init+0x2b/0x70 net/netfilter/nf_flow_table_core.c:662
 do_one_initcall+0x238/0x830 init/main.c:1233
 do_initcall_level+0x157/0x210 init/main.c:1295
 do_initcalls+0x3f/0x80 init/main.c:1311
 kernel_init_freeable+0x430/0x5d0 init/main.c:1542
 kernel_init+0x1d/0x2b0 init/main.c:1432
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
page_owner free stack trace missing

Memory state around the buggy address:
 ffff88802a197900: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff88802a197980: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff88802a197a00: 00 00 00 fc fc fc fc fc fc fc fc fc fc fc fc fc
                            ^
 ffff88802a197a80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88802a197b00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
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

