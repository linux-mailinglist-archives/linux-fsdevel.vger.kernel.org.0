Return-Path: <linux-fsdevel+bounces-17793-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CE7528B23A7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 16:13:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61E9CB243B9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 14:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0837C149E14;
	Thu, 25 Apr 2024 14:13:34 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C84149E07
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Apr 2024 14:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714054413; cv=none; b=XliZeep2PjpTnLbL327VnSWb4XRv1GpSY+Sy+s4aF4b1d20Cu7uzs3Kffv/2bpvoCi0nm2xjMTPFNBRYHCRJA6SvKwPUknDJ1uh0iqvp+MxtXnDn6HBk6Ck8P4AV7qeTEPM/JwDDuXHHGAAaEXG7ojfnWSMs7ZvXxdtg5tDnBxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714054413; c=relaxed/simple;
	bh=4Pp/R16B0hhv6jPvjxj7zKcAs1uGAmjDt8rBaIovcXs=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=VQFANypMCevs6wU3Jjnhp9C2imuIMPxMNEc9LGaadldl7/SpAi4OE88Ajwb73Z/JpvAAyw5BrKS9ZSPniCXUmqjLBg3VHIydv1mdgnva5QfLfdlkKFiSsemJDGUYDJR5nYNzkiX4UEn4uBk/jELBKOYCkE759lZlpoBjipBk6DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7dd8cd201aaso112944439f.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Apr 2024 07:13:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714054411; x=1714659211;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qApprIgtf1alYZr45QCirqwx+Cv0ZvRNG+Ka09GgaVw=;
        b=jU/Az0qQZhdrPYN+AW4OoB8Z46BbujMpkFMe49aRyyR3fpQEeHj/s/Cbvry3gUzD3W
         0AjQnDiuxLYUhbPHZYHsc2sz4jbdLp6SRR5nauIZShaKmDvgXunZHxorZ5N54Qg45Pfh
         LR18VLSVLmiPf45McTIXG4F9jxy40n/k8q08aEFnUFRLVvnF9EXPwrLhAZpA8CE0qBXv
         bfhifjAnFd1K1drYvIY//8xcWNgs8C9pvJ1Xj9d1vF6Z/KsKtnULtz8+5c0glPof5OBA
         oS05ZWhOUrfXbX3bUafAZG6WQPH3bLG2TLoyS0B8FT5BbiwKtM9CUisvrYqYseMyJhKB
         r1vQ==
X-Forwarded-Encrypted: i=1; AJvYcCXwS1e91K+pQJgaIOzbYtEPNYuYgxStm6BkGOENcYs6WZ1OwxsMxYK5SXtRaxhtEH5JSJ4zxp4czR/5oN61OIX3D14q96ZSpx6mYXBROw==
X-Gm-Message-State: AOJu0YwG8VaJfS14Yp7qeGd5y3Fp0rOkdpzGuYfEh3p630ZmxeNy/RJc
	KWkq2FmpvIJWLWnmxIsm7nmOA0j7YSwBGc1UQb0Wc+RvtWg/C8Y5BbZnSZEtaQLh8u5uTGz1lBu
	dvpPPg4Y3gqTXhB0An3htCfDpHg2oKdZTlSWGshJAj0G3v8WCuauG5r8=
X-Google-Smtp-Source: AGHT+IHgrGr0WNeFrQD1ALpJ5LgSlgsC++wevaIxIXV0EAhz8t5pHZgAaAvvifwMBzxuaAwl2ZAVYPKrPL0yymmvXMmbWHwz26pU
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6d0d:b0:7d6:1df1:bf08 with SMTP id
 im13-20020a0566026d0d00b007d61df1bf08mr204565iob.3.1714054411294; Thu, 25 Apr
 2024 07:13:31 -0700 (PDT)
Date: Thu, 25 Apr 2024 07:13:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004fb3bb0616ec64d9@google.com>
Subject: [syzbot] [ntfs3?] KASAN: slab-out-of-bounds Read in ntfs_check_attr_def
From: syzbot <syzbot+977fab364b7723c33cc3@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ntfs3@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    7b4f2bc91c15 Add linux-next specific files for 20240418
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=12d0cbab180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ae644165a243bf62
dashboard link: https://syzkaller.appspot.com/bug?extid=977fab364b7723c33cc3
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13098e73180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13c667cb180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/524a18e6c5be/disk-7b4f2bc9.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/029f1b84d653/vmlinux-7b4f2bc9.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c02d1542e886/bzImage-7b4f2bc9.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/99fbe84e14e4/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+977fab364b7723c33cc3@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 4096
ntfs3: loop0: Different NTFS sector size (4096) and media sector size (512).
==================================================================
BUG: KASAN: slab-out-of-bounds in ntfs_check_attr_def+0x2e4/0x690 fs/ntfs3/fsntfs.c:2712
Read of size 4 at addr ffff88802e910b20 by task syz-executor175/5088

CPU: 1 PID: 5088 Comm: syz-executor175 Not tainted 6.9.0-rc4-next-20240418-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 ntfs_check_attr_def+0x2e4/0x690 fs/ntfs3/fsntfs.c:2712
 ntfs_fill_super+0x38ff/0x42e0 fs/ntfs3/super.c:1452
 get_tree_bdev+0x3f7/0x570 fs/super.c:1615
 vfs_get_tree+0x90/0x2a0 fs/super.c:1780
 do_new_mount+0x2be/0xb40 fs/namespace.c:3352
 do_mount fs/namespace.c:3692 [inline]
 __do_sys_mount fs/namespace.c:3898 [inline]
 __se_sys_mount+0x2d9/0x3c0 fs/namespace.c:3875
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ff236c2b8ba
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 5e 04 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc7927a838 EFLAGS: 00000286 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007ffc7927a840 RCX: 00007ff236c2b8ba
RDX: 000000002001f180 RSI: 000000002001f1c0 RDI: 00007ffc7927a840
RBP: 0000000000000004 R08: 00007ffc7927a880 R09: 000000000001f1ed
R10: 0000000000000005 R11: 0000000000000286 R12: 00007ffc7927a880
R13: 0000000000000003 R14: 0000000000200000 R15: 0000000000000001
 </TASK>

Allocated by task 5088:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:387
 kasan_kmalloc include/linux/kasan.h:211 [inline]
 __do_kmalloc_node mm/slub.c:4078 [inline]
 __kmalloc_noprof+0x200/0x400 mm/slub.c:4091
 kmalloc_noprof include/linux/slab.h:664 [inline]
 ntfs_fill_super+0x3898/0x42e0 fs/ntfs3/super.c:1440
 get_tree_bdev+0x3f7/0x570 fs/super.c:1615
 vfs_get_tree+0x90/0x2a0 fs/super.c:1780
 do_new_mount+0x2be/0xb40 fs/namespace.c:3352
 do_mount fs/namespace.c:3692 [inline]
 __do_sys_mount fs/namespace.c:3898 [inline]
 __se_sys_mount+0x2d9/0x3c0 fs/namespace.c:3875
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff88802e910a00
 which belongs to the cache kmalloc-256 of size 256
The buggy address is located 76 bytes to the right of
 allocated 212-byte region [ffff88802e910a00, ffff88802e910ad4)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x2e910
head: order:1 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff80000000040(head|node=0|zone=1|lastcpupid=0xfff)
page_type: 0xffffefff(slab)
raw: 00fff80000000040 ffff888015041b40 ffffea0000b48380 0000000000000002
raw: 0000000000000000 0000000080100010 00000001ffffefff 0000000000000000
head: 00fff80000000040 ffff888015041b40 ffffea0000b48380 0000000000000002
head: 0000000000000000 0000000080100010 00000001ffffefff 0000000000000000
head: 00fff80000000001 ffffea0000ba4401 ffffffffffffffff 0000000000000000
head: 0000000000000002 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 1, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 1, tgid 133977591 (swapper/0), ts 1, free_ts 0
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1476
 prep_new_page mm/page_alloc.c:1484 [inline]
 get_page_from_freelist+0x2ce2/0x2d90 mm/page_alloc.c:3446
 __alloc_pages_noprof+0x256/0x6c0 mm/page_alloc.c:4704
 __alloc_pages_node_noprof include/linux/gfp.h:244 [inline]
 alloc_pages_node_noprof include/linux/gfp.h:271 [inline]
 alloc_slab_page+0x5f/0x120 mm/slub.c:2259
 allocate_slab+0x5a/0x2e0 mm/slub.c:2422
 new_slab mm/slub.c:2475 [inline]
 ___slab_alloc+0xcd1/0x14b0 mm/slub.c:3624
 __slab_alloc+0x58/0xa0 mm/slub.c:3714
 __slab_alloc_node mm/slub.c:3767 [inline]
 slab_alloc_node mm/slub.c:3945 [inline]
 __do_kmalloc_node mm/slub.c:4077 [inline]
 kmalloc_node_track_caller_noprof+0x286/0x440 mm/slub.c:4098
 __do_krealloc mm/slab_common.c:1190 [inline]
 krealloc_noprof+0x7d/0x120 mm/slab_common.c:1223
 add_sysfs_param+0xca/0x7f0 kernel/params.c:654
 kernel_add_sysfs_param+0xb4/0x130 kernel/params.c:817
 param_sysfs_builtin+0x16e/0x1f0 kernel/params.c:856
 param_sysfs_builtin_init+0x31/0x40 kernel/params.c:990
 do_one_initcall+0x248/0x880 init/main.c:1263
 do_initcall_level+0x157/0x210 init/main.c:1325
 do_initcalls+0x3f/0x80 init/main.c:1341
page_owner free stack trace missing

Memory state around the buggy address:
 ffff88802e910a00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff88802e910a80: 00 00 00 00 00 00 00 00 00 00 04 fc fc fc fc fc
>ffff88802e910b00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
                               ^
 ffff88802e910b80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88802e910c00: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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

