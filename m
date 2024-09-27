Return-Path: <linux-fsdevel+bounces-30252-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA48B9886F8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2024 16:22:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 274221C211C4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2024 14:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42E3214F119;
	Fri, 27 Sep 2024 14:21:32 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36DC613635D
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Sep 2024 14:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727446891; cv=none; b=FbhmLviFMtcur9gbR+t1+rzhxbq9XcGAcTNhB0kZim94xVtEnMz5kVmd9o1n0WgA7LwcAWfD8wmtBd3WO7/67TMq56ONkHNGT5SnfF0qdeIRoK+zetMkjwLLnPRsMhRC5y7Yyy8V9SZ+cXMig1kHNZUVDX7EhW9MDsl1fwyOYPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727446891; c=relaxed/simple;
	bh=kBdGDmu4BrnzWVq7fO4/kVE9GaDCeLSyIG2tYuvtP9s=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Kl9VdDsN0FJOO6I7Q1wWVFOGwwpA7ENCNN5oP1uvBOK2aJ0kDkWi+8J6CXDk4ilB5ioa71/41B12R9Fg6rTVx6rpFV2bOQznIAghyELUoXalAjY12sC+IRY1yaL20BDQcCDsRJvaKIovV2oEhrE4r8b/vYhqGcXYQRLxp4E1hRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-82d0daa1b09so225275639f.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Sep 2024 07:21:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727446889; x=1728051689;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2yL/ISSFIb67LIpk12RYQN0TT8GPax7QbX5Qh6IEsAo=;
        b=T2huXGKtuZbL3J/RE84W3VnDtvy1lfHePDWK0yIoECAh+T/rCp5YTDdfVw4Zwy3HAi
         ncFQsPp1FHAlLLtkHy6AE1Aog9meYN9RR7KPGvLhoelF2yX+SXH0vWFGDWodgRIqaUtP
         l2S2QjeiZKVCpakskW0oKnNu2Pd7J/wREpo1PiwIBJ0Yz/yofT30MAx7WirpvT4HTV4c
         yRhf0baUB12E/73H5o9pislq0N+fL9pXOcaoI7bbEyiw1jjPvRaga46sC/S61rNiW2uv
         APSAGu5O6cgoMuSoQHJxi4oiYNgQYiVIlCpd9aUWrfh4ePo3/ynjKNUx18oLt5uUkbb1
         k+BA==
X-Forwarded-Encrypted: i=1; AJvYcCUx7Xf7jP8qZ8iHKJfOAmfcffwYq9X2TTDxSSoTFq2+rG4OnoyyK47wBG3laluIptGpv/+xxQlecEUgcIhw@vger.kernel.org
X-Gm-Message-State: AOJu0YzcXPoCovE0RkqVU3KVUfJeGfSWtZNkH+ptR/KicWLhuTm/1TRK
	4B5ZqxJqIQLKKKuV9/0xR9+T4lEy4vaOm2+QcchDhD2jQFCXs4cspeRYE2PMDZtP10ELAcAZGgl
	kYXzwqR97htv80WO7WkK7Yye6s6zmFAW8vDhshcQLc5gQmR6ddQRp9bk=
X-Google-Smtp-Source: AGHT+IG6K6x5dR8ZyF/HwB6FhpDJpgxI/diuue/G/t2xMxKOJLxKtpNCG2S3IwXSNZ9LtfRhMKDlhWoIoT/Ytu8topidhQHchBPu
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c24d:0:b0:3a0:b631:76d4 with SMTP id
 e9e14a558f8ab-3a34516037amr29740405ab.1.1727446889343; Fri, 27 Sep 2024
 07:21:29 -0700 (PDT)
Date: Fri, 27 Sep 2024 07:21:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f6bf69.050a0220.46d20.001a.GAE@google.com>
Subject: [syzbot] [iomap?] KASAN: use-after-free Read in iomap_read_inline_data
From: syzbot <syzbot+c297885a2650fbdcfdc1@syzkaller.appspotmail.com>
To: brauner@kernel.org, djwong@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    88264981f208 Merge tag 'sched_ext-for-6.12' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10b5dca9980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e851828834875d6f
dashboard link: https://syzkaller.appspot.com/bug?extid=c297885a2650fbdcfdc1
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-88264981.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/df2a0a047a7a/vmlinux-88264981.xz
kernel image: https://storage.googleapis.com/syzbot-assets/bbdb25081712/bzImage-88264981.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c297885a2650fbdcfdc1@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 32768
gfs2: fsid=syz:syz: Trying to join cluster "lock_nolock", "syz:syz"
gfs2: fsid=syz:syz: Now mounting FS (format 1801)...
gfs2: fsid=syz:syz.0: journal 0 mapped with 16 extents in 0ms
gfs2: fsid=syz:syz.0: first mount done, others may mount
==================================================================
BUG: KASAN: use-after-free in folio_fill_tail include/linux/highmem.h:577 [inline]
BUG: KASAN: use-after-free in iomap_read_inline_data+0x2bb/0x440 fs/iomap/buffered-io.c:354
Read of size 192 at addr ffff888000e800e8 by task syz.0.0/5123

CPU: 0 UID: 0 PID: 5123 Comm: syz.0.0 Not tainted 6.11.0-syzkaller-08481-g88264981f208 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 kasan_check_range+0x282/0x290 mm/kasan/generic.c:189
 __asan_memcpy+0x29/0x70 mm/kasan/shadow.c:105
 folio_fill_tail include/linux/highmem.h:577 [inline]
 iomap_read_inline_data+0x2bb/0x440 fs/iomap/buffered-io.c:354
 iomap_readpage_iter+0x2d6/0xba0 fs/iomap/buffered-io.c:382
 iomap_read_folio_iter fs/iomap/buffered-io.c:454 [inline]
 iomap_read_folio+0x532/0x8d0 fs/iomap/buffered-io.c:477
 gfs2_read_folio+0x12c/0x540 fs/gfs2/aops.c:454
 filemap_read_folio+0x14b/0x630 mm/filemap.c:2363
 do_read_cache_folio+0x3f5/0x850 mm/filemap.c:3821
 gfs2_internal_read+0x9d/0x4c0 fs/gfs2/aops.c:487
 read_rindex_entry fs/gfs2/rgrp.c:906 [inline]
 gfs2_ri_update+0x24a/0x1830 fs/gfs2/rgrp.c:1001
 gfs2_rindex_update+0x304/0x3d0 fs/gfs2/rgrp.c:1051
 init_inodes+0x24d/0x320 fs/gfs2/ops_fstype.c:892
 gfs2_fill_super+0x1c18/0x2500 fs/gfs2/ops_fstype.c:1249
 get_tree_bdev+0x3f7/0x570 fs/super.c:1635
 gfs2_get_tree+0x54/0x220 fs/gfs2/ops_fstype.c:1329
 vfs_get_tree+0x90/0x2b0 fs/super.c:1800
 do_new_mount+0x2be/0xb40 fs/namespace.c:3507
 do_mount fs/namespace.c:3847 [inline]
 __do_sys_mount fs/namespace.c:4055 [inline]
 __se_sys_mount+0x2d6/0x3c0 fs/namespace.c:4032
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f2c5a77f69a
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 de 1a 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f2c5b61ce68 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f2c5b61cef0 RCX: 00007f2c5a77f69a
RDX: 00000000200002c0 RSI: 0000000020000100 RDI: 00007f2c5b61ceb0
RBP: 00000000200002c0 R08: 00007f2c5b61cef0 R09: 0000000000008c9b
R10: 0000000000008c9b R11: 0000000000000246 R12: 0000000020000100
R13: 00007f2c5b61ceb0 R14: 0000000000012760 R15: 0000000020000400
 </TASK>

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x923 pfn:0xe80
flags: 0x7ff00000000000(node=0|zone=0|lastcpupid=0x7ff)
page_type: f0(buddy)
raw: 007ff00000000000 ffffea000000e808 ffffea0000004288 0000000000000000
raw: 0000000000000923 0000000000000000 00000000f0000000 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as freed
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x48c40(GFP_NOFS|__GFP_NOFAIL|__GFP_COMP), pid 5123, tgid 5121 (syz.0.0), ts 142142458203, free_ts 142143773467
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1537
 prep_new_page mm/page_alloc.c:1545 [inline]
 get_page_from_freelist+0x3045/0x3190 mm/page_alloc.c:3457
 __alloc_pages_noprof+0x256/0x6c0 mm/page_alloc.c:4733
 alloc_pages_mpol_noprof+0x3e8/0x680 mm/mempolicy.c:2265
 alloc_pages_noprof mm/mempolicy.c:2345 [inline]
 folio_alloc_noprof+0x128/0x180 mm/mempolicy.c:2352
 filemap_alloc_folio_noprof+0xdf/0x500 mm/filemap.c:1010
 __filemap_get_folio+0x446/0xbd0 mm/filemap.c:1952
 gfs2_getbuf+0x150/0x6a0 fs/gfs2/meta_io.c:132
 gfs2_meta_read+0x1e5/0x9b0 fs/gfs2/meta_io.c:261
 gfs2_meta_buffer+0x19a/0x410 fs/gfs2/meta_io.c:489
 gfs2_meta_inode_buffer fs/gfs2/meta_io.h:72 [inline]
 gfs2_inode_refresh+0xec/0x10b0 fs/gfs2/glops.c:478
 gfs2_instantiate+0x190/0x260 fs/gfs2/glock.c:468
 gfs2_glock_holder_ready fs/gfs2/glock.c:1345 [inline]
 gfs2_glock_wait+0x1df/0x2b0 fs/gfs2/glock.c:1365
 gfs2_glock_nq_init fs/gfs2/glock.h:238 [inline]
 gfs2_rindex_update+0x274/0x3d0 fs/gfs2/rgrp.c:1045
 init_inodes+0x24d/0x320 fs/gfs2/ops_fstype.c:892
 gfs2_fill_super+0x1c18/0x2500 fs/gfs2/ops_fstype.c:1249
page last free pid 80 tgid 80 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1108 [inline]
 free_unref_folios+0xf12/0x18d0 mm/page_alloc.c:2686
 shrink_folio_list+0x81fd/0x8cc0 mm/vmscan.c:1550
 evict_folios+0x549b/0x7b50 mm/vmscan.c:4583
 try_to_shrink_lruvec+0x9ab/0xbb0 mm/vmscan.c:4778
 shrink_one+0x3b9/0x850 mm/vmscan.c:4816
 shrink_many mm/vmscan.c:4879 [inline]
 lru_gen_shrink_node mm/vmscan.c:4957 [inline]
 shrink_node+0x3799/0x3de0 mm/vmscan.c:5937
 kswapd_shrink_node mm/vmscan.c:6765 [inline]
 balance_pgdat mm/vmscan.c:6957 [inline]
 kswapd+0x1ca3/0x3700 mm/vmscan.c:7226
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Memory state around the buggy address:
 ffff888000e7ff80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff888000e80000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>ffff888000e80080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                                                          ^
 ffff888000e80100: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff888000e80180: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
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

