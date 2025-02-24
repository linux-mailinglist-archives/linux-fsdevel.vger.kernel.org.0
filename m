Return-Path: <linux-fsdevel+bounces-42478-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29FFDA42A9E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 19:06:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12F631753BA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 18:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A25D626656A;
	Mon, 24 Feb 2025 18:04:25 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB9026562D
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Feb 2025 18:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740420265; cv=none; b=YVlEJA1xypOD9/CLbz4lUa94ilkO5adljRcRKMsxiLB5cZOzjhOE4vuIJc5cNOi6multbBb8X9j23JKQk8FQfoMnjWyfyPnlMzRD2/M9+MteW6laYyftoSQZJmAWo2p87kOz4TO81iMMiA9G9ArrcIjDPJ2aSj/UZVsVDi15tYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740420265; c=relaxed/simple;
	bh=3qlV/GBWgy0F94uIR8IkmJNk0SAH8BsNtxYolYquZeg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=lJ+DRylkM6YYLaSf9jWU/yg4E3zuITtr3IVR3lySNmhfKPAIOQMVBPqF0M2oaDySima/xghcjXY+xdcmbfjKtl0V4sjY2M332QSIScfA/ae9nSpgNeCguiuHzuD+3/hBk2kZogMOJGqVRZO5lRV5MmYElQyPm55oHEXYeV2R19c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3d2b6d933acso42270275ab.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Feb 2025 10:04:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740420262; x=1741025062;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=26BoXc3uxySEZk4t96qqAMNaefnIOVDrN9EFPeud7NU=;
        b=fMoixyf87xRGUFH2vO+K5zSjS+nleKvdSZYu3GbaEoWLCOerXkHFk4ayGWxf2D6CyP
         FSwdsLcJX6ovbtZMyYDW8NyrQ6DhBuhaU5GYIqcGAE14f7RWGnLT6NqihMW+UIj/CUHi
         EAKhHqNxreqMh2P+LWUp6I3XhpEdRGMQD4vSC0XziyfdsccU+e2J8RSBOA8nlp7NhLky
         JYG5wNoyBnFKvpeERbP1VVjn48bayhDh1ZvMqx8sECDkJFZtPmra66tXBoCXOqb8q4i3
         cAGcSoN7e8klSOWwsxJ83SsiwQ2ucxfgPhqb/hDIyisz94qd1J3fts96I6xTZoCiwkDk
         DV1w==
X-Gm-Message-State: AOJu0Yx5y89be0LOaWGBQskZD0Sd519XOwrligS5BkavIfXxZSTDTKIt
	05WhNn15teYu87klseVPrvqTlnmomWTR14v3EfBJy608bRieQ/zOTPlrWPANaQjReMw2hZDq1tg
	O9x1qq8TOHZxdVT9n9QarbWA6SlhMqCyVkaYbdu+Cc7E66X6XtHZE9beW+Q==
X-Google-Smtp-Source: AGHT+IHZ6rzshGWczOtvBO8U27mzVKxlIwHp3Z7MyNbqJEIeAFCnFiV06cFnYmHMF8WADh6bP0VNT8e0pgX8Q+KYDPQSXnND+y+v
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1565:b0:3d1:946c:e69b with SMTP id
 e9e14a558f8ab-3d2cb4527abmr115705135ab.8.1740420262350; Mon, 24 Feb 2025
 10:04:22 -0800 (PST)
Date: Mon, 24 Feb 2025 10:04:22 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67bcb4a6.050a0220.bbfd1.008f.GAE@google.com>
Subject: [syzbot] [hfs?] KASAN: slab-out-of-bounds Read in hfsplus_bmap_alloc
From: syzbot <syzbot+356aed408415a56543cd@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    a1c24ab82279 Merge branch 'for-next/el2-enable-feat-pmuv3p..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=177737f8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f6b108de97771157
dashboard link: https://syzkaller.appspot.com/bug?extid=356aed408415a56543cd
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=106757a4580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10b646e4580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/9581dbc26f55/disk-a1c24ab8.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/50aec9ab8b8b/vmlinux-a1c24ab8.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3a018984f8f5/Image-a1c24ab8.gz.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/af05206b0a6c/mount_1.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+356aed408415a56543cd@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 1024
==================================================================
BUG: KASAN: slab-out-of-bounds in hfsplus_bmap_alloc+0x150/0x538
Read of size 8 at addr ffff0000c1d289c0 by task syz-executor168/6441

CPU: 1 UID: 0 PID: 6441 Comm: syz-executor168 Not tainted 6.14.0-rc3-syzkaller-ga1c24ab82279 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 12/27/2024
Call trace:
 show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:466 (C)
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0xe4/0x150 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0x198/0x538 mm/kasan/report.c:489
 kasan_report+0xd8/0x138 mm/kasan/report.c:602
 __asan_report_load8_noabort+0x20/0x2c mm/kasan/report_generic.c:381
 hfsplus_bmap_alloc+0x150/0x538
 hfs_btree_inc_height+0xf8/0xa60 fs/hfsplus/brec.c:475
 hfsplus_brec_insert+0x11c/0xaa0 fs/hfsplus/brec.c:75
 __hfsplus_ext_write_extent+0x288/0x4ac fs/hfsplus/extents.c:107
 __hfsplus_ext_cache_extent+0x84/0xa84 fs/hfsplus/extents.c:186
 hfsplus_ext_read_extent fs/hfsplus/extents.c:218 [inline]
 hfsplus_file_extend+0x39c/0x1544 fs/hfsplus/extents.c:462
 hfsplus_get_block+0x398/0x1168 fs/hfsplus/extents.c:245
 __block_write_begin_int+0x4c4/0x1610 fs/buffer.c:2116
 block_write_begin fs/buffer.c:2226 [inline]
 cont_write_begin+0x634/0x984 fs/buffer.c:2577
 hfsplus_write_begin+0x7c/0xc4 fs/hfsplus/inode.c:46
 cont_expand_zero fs/buffer.c:2504 [inline]
 cont_write_begin+0x2b0/0x984 fs/buffer.c:2567
 hfsplus_write_begin+0x7c/0xc4 fs/hfsplus/inode.c:46
 generic_perform_write+0x29c/0x868 mm/filemap.c:4189
 __generic_file_write_iter+0xfc/0x204 mm/filemap.c:4290
 generic_file_write_iter+0x108/0x4b0 mm/filemap.c:4316
 __kernel_write_iter+0x340/0x7a0 fs/read_write.c:612
 dump_emit_page fs/coredump.c:884 [inline]
 dump_user_range+0x378/0x6c8 fs/coredump.c:945
 elf_core_dump+0x336c/0x3c38 fs/binfmt_elf.c:2129
 do_coredump+0x1d28/0x29a0 fs/coredump.c:758
 get_signal+0xf6c/0x1500 kernel/signal.c:3021
 do_signal+0x1a4/0x3a04 arch/arm64/kernel/signal.c:1658
 do_notify_resume+0x74/0x1f4 arch/arm64/kernel/entry-common.c:148
 exit_to_user_mode_prepare arch/arm64/kernel/entry-common.c:169 [inline]
 exit_to_user_mode arch/arm64/kernel/entry-common.c:178 [inline]
 el0_da+0xbc/0x178 arch/arm64/kernel/entry-common.c:605
 el0t_64_sync_handler+0xcc/0x108 arch/arm64/kernel/entry-common.c:765
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600

Allocated by task 6441:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x40/0x78 mm/kasan/common.c:68
 kasan_save_alloc_info+0x40/0x50 mm/kasan/generic.c:562
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0xac/0xc4 mm/kasan/common.c:394
 kasan_kmalloc include/linux/kasan.h:260 [inline]
 __do_kmalloc_node mm/slub.c:4294 [inline]
 __kmalloc_noprof+0x32c/0x54c mm/slub.c:4306
 kmalloc_noprof include/linux/slab.h:905 [inline]
 kzalloc_noprof include/linux/slab.h:1037 [inline]
 __hfs_bnode_create+0xe4/0x6d4 fs/hfsplus/bnode.c:409
 hfsplus_bnode_find+0x1f8/0xc04 fs/hfsplus/bnode.c:486
 hfsplus_bmap_alloc+0xc8/0x538 fs/hfsplus/btree.c:390
 hfs_btree_inc_height+0xf8/0xa60 fs/hfsplus/brec.c:475
 hfsplus_brec_insert+0x11c/0xaa0 fs/hfsplus/brec.c:75
 __hfsplus_ext_write_extent+0x288/0x4ac fs/hfsplus/extents.c:107
 __hfsplus_ext_cache_extent+0x84/0xa84 fs/hfsplus/extents.c:186
 hfsplus_ext_read_extent fs/hfsplus/extents.c:218 [inline]
 hfsplus_file_extend+0x39c/0x1544 fs/hfsplus/extents.c:462
 hfsplus_get_block+0x398/0x1168 fs/hfsplus/extents.c:245
 __block_write_begin_int+0x4c4/0x1610 fs/buffer.c:2116
 block_write_begin fs/buffer.c:2226 [inline]
 cont_write_begin+0x634/0x984 fs/buffer.c:2577
 hfsplus_write_begin+0x7c/0xc4 fs/hfsplus/inode.c:46
 cont_expand_zero fs/buffer.c:2504 [inline]
 cont_write_begin+0x2b0/0x984 fs/buffer.c:2567
 hfsplus_write_begin+0x7c/0xc4 fs/hfsplus/inode.c:46
 generic_perform_write+0x29c/0x868 mm/filemap.c:4189
 __generic_file_write_iter+0xfc/0x204 mm/filemap.c:4290
 generic_file_write_iter+0x108/0x4b0 mm/filemap.c:4316
 __kernel_write_iter+0x340/0x7a0 fs/read_write.c:612
 dump_emit_page fs/coredump.c:884 [inline]
 dump_user_range+0x378/0x6c8 fs/coredump.c:945
 elf_core_dump+0x336c/0x3c38 fs/binfmt_elf.c:2129
 do_coredump+0x1d28/0x29a0 fs/coredump.c:758
 get_signal+0xf6c/0x1500 kernel/signal.c:3021
 do_signal+0x1a4/0x3a04 arch/arm64/kernel/signal.c:1658
 do_notify_resume+0x74/0x1f4 arch/arm64/kernel/entry-common.c:148
 exit_to_user_mode_prepare arch/arm64/kernel/entry-common.c:169 [inline]
 exit_to_user_mode arch/arm64/kernel/entry-common.c:178 [inline]
 el0_da+0xbc/0x178 arch/arm64/kernel/entry-common.c:605
 el0t_64_sync_handler+0xcc/0x108 arch/arm64/kernel/entry-common.c:765
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600

The buggy address belongs to the object at ffff0000c1d28900
 which belongs to the cache kmalloc-192 of size 192
The buggy address is located 48 bytes to the right of
 allocated 144-byte region [ffff0000c1d28900, ffff0000c1d28990)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x101d28
flags: 0x5ffc00000000000(node=0|zone=2|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 05ffc00000000000 ffff0000c00013c0 dead000000000100 dead000000000122
raw: 0000000000000000 0000000080100010 00000000f5000000 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff0000c1d28880: 00 00 00 fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff0000c1d28900: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff0000c1d28980: 00 00 fc fc fc fc fc fc fc fc fc fc fc fc fc fc
                                           ^
 ffff0000c1d28a00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff0000c1d28a80: 00 00 00 fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================
------------[ cut here ]------------
WARNING: CPU: 1 PID: 6441 at ./include/linux/mm.h:2250 rcu_read_unlock_sched include/linux/rcupdate.h:964 [inline]
WARNING: CPU: 1 PID: 6441 at ./include/linux/mm.h:2250 pfn_valid include/linux/mmzone.h:2069 [inline]
WARNING: CPU: 1 PID: 6441 at ./include/linux/mm.h:2250 lowmem_page_address include/linux/mm.h:2250 [inline]
WARNING: CPU: 1 PID: 6441 at ./include/linux/mm.h:2250 kmap_local_page+0x388/0x500 include/linux/highmem-internal.h:180
Modules linked in:
CPU: 1 UID: 0 PID: 6441 Comm: syz-executor168 Tainted: G    B              6.14.0-rc3-syzkaller-ga1c24ab82279 #0
Tainted: [B]=BAD_PAGE
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 12/27/2024
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : lowmem_page_address include/linux/rcupdate.h:964 [inline]
pc : kmap_local_page+0x388/0x500 include/linux/highmem-internal.h:180
lr : pfn_valid include/linux/mmzone.h:2061 [inline]
lr : lowmem_page_address include/linux/mm.h:2250 [inline]
lr : kmap_local_page+0x148/0x500 include/linux/highmem-internal.h:180
sp : ffff8000a4a15bf0
x29: ffff8000a4a15bf0 x28: ffff0000dc472000 x27: 1ffff00014942b8c
x26: 1fffe0001b88e403 x25: 1fffe0001b88f5fb x24: ffff80008f4d4000
x23: 1ffff00011e9a8a9 x22: ffff8000a4a15c80 x21: dfff800000000000
x20: ffff0000c1d28900 x19: 049004df41001929 x18: 0000000000000008
x17: 0000000000000000 x16: ffff80008b7275dc x15: 0000000000000001
x14: 1ffff0001262e6f8 x13: 0000000000000000 x12: 0000000000000000
x11: ffff70001262e6f9 x10: 0000000000ff0100 x9 : 0000000000000000
x8 : ffff0000c5fa0000 x7 : 0000000000000001 x6 : 0000000000000001
x5 : ffff8000a4a152f8 x4 : ffff80008fcaf720 x3 : ffff8000802f88ec
x2 : 0000000000000001 x1 : 049004df41001929 x0 : 0400000000000000
Call trace:
 rcu_read_unlock_sched include/linux/rcupdate.h:964 [inline] (P)
 pfn_valid include/linux/mmzone.h:2069 [inline] (P)
 lowmem_page_address include/linux/mm.h:2250 [inline] (P)
 kmap_local_page+0x388/0x500 include/linux/highmem-internal.h:180 (P)
 hfsplus_bmap_alloc+0x158/0x538
 hfs_btree_inc_height+0xf8/0xa60 fs/hfsplus/brec.c:475
 hfsplus_brec_insert+0x11c/0xaa0 fs/hfsplus/brec.c:75
 __hfsplus_ext_write_extent+0x288/0x4ac fs/hfsplus/extents.c:107
 __hfsplus_ext_cache_extent+0x84/0xa84 fs/hfsplus/extents.c:186
 hfsplus_ext_read_extent fs/hfsplus/extents.c:218 [inline]
 hfsplus_file_extend+0x39c/0x1544 fs/hfsplus/extents.c:462
 hfsplus_get_block+0x398/0x1168 fs/hfsplus/extents.c:245
 __block_write_begin_int+0x4c4/0x1610 fs/buffer.c:2116
 block_write_begin fs/buffer.c:2226 [inline]
 cont_write_begin+0x634/0x984 fs/buffer.c:2577
 hfsplus_write_begin+0x7c/0xc4 fs/hfsplus/inode.c:46
 cont_expand_zero fs/buffer.c:2504 [inline]
 cont_write_begin+0x2b0/0x984 fs/buffer.c:2567
 hfsplus_write_begin+0x7c/0xc4 fs/hfsplus/inode.c:46
 generic_perform_write+0x29c/0x868 mm/filemap.c:4189
 __generic_file_write_iter+0xfc/0x204 mm/filemap.c:4290
 generic_file_write_iter+0x108/0x4b0 mm/filemap.c:4316
 __kernel_write_iter+0x340/0x7a0 fs/read_write.c:612
 dump_emit_page fs/coredump.c:884 [inline]
 dump_user_range+0x378/0x6c8 fs/coredump.c:945
 elf_core_dump+0x336c/0x3c38 fs/binfmt_elf.c:2129
 do_coredump+0x1d28/0x29a0 fs/coredump.c:758
 get_signal+0xf6c/0x1500 kernel/signal.c:3021
 do_signal+0x1a4/0x3a04 arch/arm64/kernel/signal.c:1658
 do_notify_resume+0x74/0x1f4 arch/arm64/kernel/entry-common.c:148
 exit_to_user_mode_prepare arch/arm64/kernel/entry-common.c:169 [inline]
 exit_to_user_mode arch/arm64/kernel/entry-common.c:178 [inline]
 el0_da+0xbc/0x178 arch/arm64/kernel/entry-common.c:605
 el0t_64_sync_handler+0xcc/0x108 arch/arm64/kernel/entry-common.c:765
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600
irq event stamp: 9593
hardirqs last  enabled at (9593): [<ffff8000803d4db4>] raw_spin_rq_unlock_irq+0x14/0x24 kernel/sched/sched.h:1533
hardirqs last disabled at (9592): [<ffff80008b7d0e04>] __schedule+0x2bc/0x257c kernel/sched/core.c:6668
softirqs last  enabled at (7186): [<ffff800080311b48>] softirq_handle_end kernel/softirq.c:407 [inline]
softirqs last  enabled at (7186): [<ffff800080311b48>] handle_softirqs+0xb44/0xd34 kernel/softirq.c:589
softirqs last disabled at (7173): [<ffff800080020dbc>] __do_softirq+0x14/0x20 kernel/softirq.c:595
---[ end trace 0000000000000000 ]---
Unable to handle kernel paging request at virtual address fffd86fa0000cb28
KASAN: maybe wild-memory-access in range [0xfff037d000065940-0xfff037d000065947]
Mem abort info:
  ESR = 0x0000000096000004
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x04: level 0 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
  CM = 0, WnR = 0, TnD = 0, TagAccess = 0
  GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
swapper pgtable: 4k pages, 48-bit VAs, pgdp=00000001a50a6000
[fffd86fa0000cb28] pgd=0000000000000000, p4d=0000000000000000
Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
Modules linked in:
CPU: 1 UID: 0 PID: 6441 Comm: syz-executor168 Tainted: G    B   W          6.14.0-rc3-syzkaller-ga1c24ab82279 #0
Tainted: [B]=BAD_PAGE, [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 12/27/2024
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : hfsplus_bmap_alloc+0x180/0x538 fs/hfsplus/btree.c:404
lr : hfsplus_bmap_alloc+0x16c/0x538 fs/hfsplus/btree.c:403
sp : ffff8000a4a15c40
x29: ffff8000a4a15cc0 x28: 0000000000000f00 x27: 1ffff00014942b8c
x26: fff037d000064a40 x25: fff037d000065940 x24: 00000000ffff90f8
x23: ffff0000c1d289c0 x22: ffff8000a4a15c80 x21: dfff800000000000
x20: ffff0000c1d28900 x19: 1ffe06fa0000cb28 x18: 0000000000000008
x17: 0000000000000000 x16: ffff80008b7275dc x15: 0000000000000001
x14: 1ffff0001262e6f8 x13: 0000000000000000 x12: 0000000000000000
x11: ffff70001262e6f9 x10: 0000000000ff0100 x9 : 0000000000000000
x8 : ffff0000c5fa0000 x7 : 0000000000000001 x6 : 0000000000000001
x5 : ffff8000a4a152f8 x4 : ffff80008fcaf720 x3 : ffff8000802f88ec
x2 : 0000000000000001 x1 : 00000000000090f8 x0 : 0000000000000000
Call trace:
 hfsplus_bmap_alloc+0x180/0x538 fs/hfsplus/btree.c:404 (P)
 hfs_btree_inc_height+0xf8/0xa60 fs/hfsplus/brec.c:475
 hfsplus_brec_insert+0x11c/0xaa0 fs/hfsplus/brec.c:75
 __hfsplus_ext_write_extent+0x288/0x4ac fs/hfsplus/extents.c:107
 __hfsplus_ext_cache_extent+0x84/0xa84 fs/hfsplus/extents.c:186
 hfsplus_ext_read_extent fs/hfsplus/extents.c:218 [inline]
 hfsplus_file_extend+0x39c/0x1544 fs/hfsplus/extents.c:462
 hfsplus_get_block+0x398/0x1168 fs/hfsplus/extents.c:245
 __block_write_begin_int+0x4c4/0x1610 fs/buffer.c:2116
 block_write_begin fs/buffer.c:2226 [inline]
 cont_write_begin+0x634/0x984 fs/buffer.c:2577
 hfsplus_write_begin+0x7c/0xc4 fs/hfsplus/inode.c:46
 cont_expand_zero fs/buffer.c:2504 [inline]
 cont_write_begin+0x2b0/0x984 fs/buffer.c:2567
 hfsplus_write_begin+0x7c/0xc4 fs/hfsplus/inode.c:46
 generic_perform_write+0x29c/0x868 mm/filemap.c:4189
 __generic_file_write_iter+0xfc/0x204 mm/filemap.c:4290
 generic_file_write_iter+0x108/0x4b0 mm/filemap.c:4316
 __kernel_write_iter+0x340/0x7a0 fs/read_write.c:612
 dump_emit_page fs/coredump.c:884 [inline]
 dump_user_range+0x378/0x6c8 fs/coredump.c:945
 elf_core_dump+0x336c/0x3c38 fs/binfmt_elf.c:2129
 do_coredump+0x1d28/0x29a0 fs/coredump.c:758
 get_signal+0xf6c/0x1500 kernel/signal.c:3021
 do_signal+0x1a4/0x3a04 arch/arm64/kernel/signal.c:1658
 do_notify_resume+0x74/0x1f4 arch/arm64/kernel/entry-common.c:148
 exit_to_user_mode_prepare arch/arm64/kernel/entry-common.c:169 [inline]
 exit_to_user_mode arch/arm64/kernel/entry-common.c:178 [inline]
 el0_da+0xbc/0x178 arch/arm64/kernel/entry-common.c:605
 el0t_64_sync_handler+0xcc/0x108 arch/arm64/kernel/entry-common.c:765
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600
Code: 12002e7c 8b3c4359 d343ff33 12000b29 (38f56a68) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	12002e7c 	and	w28, w19, #0xfff
   4:	8b3c4359 	add	x25, x26, w28, uxtw
   8:	d343ff33 	lsr	x19, x25, #3
   c:	12000b29 	and	w9, w25, #0x7
* 10:	38f56a68 	ldrsb	w8, [x19, x21] <-- trapping instruction


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

