Return-Path: <linux-fsdevel+bounces-61888-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0013B7CA16
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 14:06:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47AB3462645
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 08:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AA15279327;
	Wed, 17 Sep 2025 08:30:57 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB43270EBC
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Sep 2025 08:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758097857; cv=none; b=cVKi72B0hcqAJhho8rAFLw4qDbjbME0WcJncqHy6pfx3gaDj5nKiSnE6mr38AXwO7DHnLd4M+A8USQ7HMv1I2azJBydorGQIhi+YgPOQyzulFvFd6JnQxuFGJtBYMfOCKVRVjSKaI7gdiuRgL1unC1T3iRdPXfl4qYuN+2BYiTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758097857; c=relaxed/simple;
	bh=6AjWjKDKHP31jvovChTUYAq3p5SXpFp3nW3W4CkOup8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=REC+1Hgvg44W/lajdulU0oPpvzsuCmRjOaIc1WelwyrS+rYL6comkelDoPy0E3lZvMHWEOIpK80T3SZFqxtK4rOzAijnIhLFC51JrbdGTWffCd7n+IdwLrXbz/shp7fLmxzLswEEd83T5tiBI6dEqb7UTIv+YoWlRMe6Fhf1KWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-42407a5686fso40217415ab.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Sep 2025 01:30:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758097854; x=1758702654;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zdmiy5gkEAe6ErqXFJJ6VLMJb+lc1vqF7uUO5qKC344=;
        b=b+pDAcZmiWp23g6tTGkkDGMeViVQj7O0qtdBJ9SAcWE/YjJNPLBVEh+9vY58NDBJkd
         EjAn+ZMI70sSNmu79D+Ym0oB3ilY9hrD87g7rQaT7DzpxknZm70cVUfwTd2TSlmTJsm6
         G1GexP/CATjZbYnE3BlHS5Hef7+Op7rSHygRj1xpCe+24THikZ19oLIpzvmxgvV6uOLT
         VUVLBNwoTANq6w6NG1I4s45KuJRcw0R7WVCdLwYvT4+41SNAahJWcCRCLSnm6TutJmxR
         FLNWzZH8B6U0FvLMtts9FboTFIDwlxiA3rLI2W/IH3d9wrK0FXNVSQDl++mFTeyO8wUS
         ItjQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+PAw3iEZ4rApFokJTB8PCemT4ti9p+8j3ltzt+lt9eIWuN97E943amLoHE6I+ZkRf7iDgSMUXkrvmytbj@vger.kernel.org
X-Gm-Message-State: AOJu0YzDbl+S1r0fu5eCYIPBu9CXEVRAFN+TZ7xe+1GqxgyOSNVY7PBz
	181lToIHXo8sDTd0GB39KBPDxBCGxk9iFH8ORa0sCD/d4BMeoDmnMR/VyFs+2NdtbCjW471+VFw
	B88nz0c2jX2fAz3rQjqP87bBHBUjoud7I/LxSgWmY8UFzK4NEwVuRTKCnLs4=
X-Google-Smtp-Source: AGHT+IFPgxPgZg/2M8goxra8gmfI00vPQ86tMj20E/Zx9GXmsDyzLmakEjM0VQS323BU1Psx1AGfoPjVzvIVpMU5TceFqkAYG/P8
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1feb:b0:423:fea3:51e2 with SMTP id
 e9e14a558f8ab-4241a52885fmr11714555ab.21.1758097853913; Wed, 17 Sep 2025
 01:30:53 -0700 (PDT)
Date: Wed, 17 Sep 2025 01:30:53 -0700
In-Reply-To: <20250916234425.1274735-1-joannelkoong@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ca71bd.050a0220.2ff435.04fc.GAE@google.com>
Subject: [syzbot ci] Re: fuse: use iomap for buffered reads + readahead
From: syzbot ci <syzbot+ci9b5a486340e6bcdf@syzkaller.appspotmail.com>
To: brauner@kernel.org, djwong@kernel.org, gfs2@lists.linux.dev, 
	hch@infradead.org, hch@lst.de, hsiangkao@linux.alibaba.com, 
	joannelkoong@gmail.com, kernel-team@meta.com, linux-block@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-xfs@vger.kernel.org, miklos@szeredi.hu
Cc: syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot ci has tested the following series

[v3] fuse: use iomap for buffered reads + readahead
https://lore.kernel.org/all/20250916234425.1274735-1-joannelkoong@gmail.com
* [PATCH v3 01/15] iomap: move bio read logic into helper function
* [PATCH v3 02/15] iomap: move read/readahead bio submission logic into helper function
* [PATCH v3 03/15] iomap: store read/readahead bio generically
* [PATCH v3 04/15] iomap: iterate over entire folio in iomap_readpage_iter()
* [PATCH v3 05/15] iomap: rename iomap_readpage_iter() to iomap_read_folio_iter()
* [PATCH v3 06/15] iomap: rename iomap_readpage_ctx struct to iomap_read_folio_ctx
* [PATCH v3 07/15] iomap: track read/readahead folio ownership internally
* [PATCH v3 08/15] iomap: add public start/finish folio read helpers
* [PATCH v3 09/15] iomap: add caller-provided callbacks for read and readahead
* [PATCH v3 10/15] iomap: add bias for async read requests
* [PATCH v3 11/15] iomap: move buffered io bio logic into new file
* [PATCH v3 12/15] iomap: make iomap_read_folio() a void return
* [PATCH v3 13/15] fuse: use iomap for read_folio
* [PATCH v3 14/15] fuse: use iomap for readahead
* [PATCH v3 15/15] fuse: remove fc->blkbits workaround for partial writes

and found the following issues:
* WARNING in iomap_iter_advance
* WARNING in iomap_readahead
* kernel BUG in folio_end_read

Full report is available here:
https://ci.syzbot.org/series/6845596a-1ec9-4396-b9c4-48bddc606bef

***

WARNING in iomap_iter_advance

tree:      torvalds
URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux
base:      f83ec76bf285bea5727f478a68b894f5543ca76e
arch:      amd64
compiler:  Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
config:    https://ci.syzbot.org/builds/4ec82322-3509-4b63-9881-f639f1b61f20/config
C repro:   https://ci.syzbot.org/findings/73807f10-d659-4291-84af-f982be7cabad/c_repro
syz repro: https://ci.syzbot.org/findings/73807f10-d659-4291-84af-f982be7cabad/syz_repro

loop0: detected capacity change from 0 to 16
erofs (device loop0): mounted with root inode @ nid 36.
------------[ cut here ]------------
WARNING: CPU: 1 PID: 5996 at fs/iomap/iter.c:22 iomap_iter_advance+0x2c1/0x2f0 fs/iomap/iter.c:22
Modules linked in:
CPU: 1 UID: 0 PID: 5996 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:iomap_iter_advance+0x2c1/0x2f0 fs/iomap/iter.c:22
Code: 74 08 4c 89 ef e8 2f f1 ce ff 49 89 5d 00 31 c0 48 83 c4 50 5b 41 5c 41 5d 41 5e 41 5f 5d e9 46 0c 29 09 cc e8 80 7d 6b ff 90 <0f> 0b 90 b8 fb ff ff ff eb dc 44 89 f9 80 e1 07 fe c1 38 c1 0f 8c
RSP: 0018:ffffc90002a6f118 EFLAGS: 00010293
RAX: ffffffff82543fe0 RBX: 0000000000001000 RCX: ffff88801ec80000
RDX: 0000000000000000 RSI: 0000000000000f8c RDI: 0000000000001000
RBP: 0000000000000074 R08: ffffea00043daf87 R09: 1ffffd400087b5f0
R10: dffffc0000000000 R11: fffff9400087b5f1 R12: 0000000000001000
R13: 0000000000000f8c R14: ffffc90002a6f340 R15: 0000000000000f8c
FS:  000055556dfe9500(0000) GS:ffff8881a3c15000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b31563fff CR3: 00000000262da000 CR4: 00000000000006f0
Call Trace:
 <TASK>
 iomap_read_folio_iter+0x614/0xb70 fs/iomap/buffered-io.c:424
 iomap_read_folio+0x2e7/0x570 fs/iomap/buffered-io.c:472
 iomap_bio_read_folio include/linux/iomap.h:589 [inline]
 erofs_read_folio+0x13c/0x2e0 fs/erofs/data.c:374
 filemap_read_folio+0x117/0x380 mm/filemap.c:2413
 do_read_cache_folio+0x350/0x590 mm/filemap.c:3957
 read_mapping_folio include/linux/pagemap.h:991 [inline]
 erofs_bread+0x46f/0x7f0 fs/erofs/data.c:40
 erofs_find_target_block fs/erofs/namei.c:103 [inline]
 erofs_namei+0x36b/0x1030 fs/erofs/namei.c:177
 erofs_lookup+0x148/0x340 fs/erofs/namei.c:206
 lookup_open fs/namei.c:3686 [inline]
 open_last_lookups fs/namei.c:3807 [inline]
 path_openat+0x1101/0x3830 fs/namei.c:4043
 do_filp_open+0x1fa/0x410 fs/namei.c:4073
 do_sys_openat2+0x121/0x1c0 fs/open.c:1435
 do_sys_open fs/open.c:1450 [inline]
 __do_sys_openat fs/open.c:1466 [inline]
 __se_sys_openat fs/open.c:1461 [inline]
 __x64_sys_openat+0x138/0x170 fs/open.c:1461
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f86ddb8eba9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff12610128 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00007f86dddd5fa0 RCX: 00007f86ddb8eba9
RDX: 0000000000043142 RSI: 0000200000000040 RDI: ffffffffffffff9c
RBP: 00007f86ddc11e19 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f86dddd5fa0 R14: 00007f86dddd5fa0 R15: 0000000000000004
 </TASK>


***

WARNING in iomap_readahead

tree:      torvalds
URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux
base:      f83ec76bf285bea5727f478a68b894f5543ca76e
arch:      amd64
compiler:  Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
config:    https://ci.syzbot.org/builds/4ec82322-3509-4b63-9881-f639f1b61f20/config
C repro:   https://ci.syzbot.org/findings/6ee3f719-e6ab-468c-92dc-e197c12d8171/c_repro
syz repro: https://ci.syzbot.org/findings/6ee3f719-e6ab-468c-92dc-e197c12d8171/syz_repro

XFS: noikeep mount option is deprecated.
XFS (loop0): Mounting V5 Filesystem bfdc47fc-10d8-4eed-a562-11a831b3f791
XFS (loop0): Ending clean mount
------------[ cut here ]------------
WARNING: CPU: 1 PID: 5993 at fs/iomap/buffered-io.c:497 iomap_readahead_iter fs/iomap/buffered-io.c:497 [inline]
WARNING: CPU: 1 PID: 5993 at fs/iomap/buffered-io.c:497 iomap_readahead+0x5ed/0xa40 fs/iomap/buffered-io.c:541
Modules linked in:
CPU: 1 UID: 0 PID: 5993 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:iomap_readahead_iter fs/iomap/buffered-io.c:497 [inline]
RIP: 0010:iomap_readahead+0x5ed/0xa40 fs/iomap/buffered-io.c:541
Code: a5 ff eb 35 e8 14 55 6b ff 48 8b 5c 24 20 48 8b 44 24 28 42 80 3c 28 00 74 08 48 89 df e8 8b c8 ce ff 48 c7 03 00 00 00 00 90 <0f> 0b 90 bb ea ff ff ff eb 53 e8 e4 54 6b ff 48 8b 44 24 28 42 80
RSP: 0018:ffffc90003096260 EFLAGS: 00010246
RAX: 1ffff92000612c8d RBX: ffffc90003096468 RCX: ffff888024038000
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000001
RBP: ffffc90003096430 R08: ffffffff8fa3a637 R09: 1ffffffff1f474c6
R10: dffffc0000000000 R11: fffffbfff1f474c7 R12: 0000000000000001
R13: dffffc0000000000 R14: 0000000000000001 R15: 0000000000000001
FS:  00005555761de500(0000) GS:ffff8881a3c15000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b30f63fff CR3: 000000010defc000 CR4: 00000000000006f0
Call Trace:
 <TASK>
 iomap_bio_readahead include/linux/iomap.h:600 [inline]
 xfs_vm_readahead+0x9f/0xe0 fs/xfs/xfs_aops.c:753
 read_pages+0x17a/0x580 mm/readahead.c:160
 page_cache_ra_order+0x8ca/0xd40 mm/readahead.c:512
 filemap_get_pages+0x43c/0x1ea0 mm/filemap.c:2603
 filemap_read+0x3f6/0x11a0 mm/filemap.c:2712
 xfs_file_buffered_read+0x1a2/0x350 fs/xfs/xfs_file.c:292
 xfs_file_read_iter+0x280/0x510 fs/xfs/xfs_file.c:317
 __kernel_read+0x4cf/0x960 fs/read_write.c:530
 integrity_kernel_read+0x89/0xd0 security/integrity/iint.c:28
 ima_calc_file_hash_tfm security/integrity/ima/ima_crypto.c:480 [inline]
 ima_calc_file_shash security/integrity/ima/ima_crypto.c:511 [inline]
 ima_calc_file_hash+0x85e/0x16f0 security/integrity/ima/ima_crypto.c:568
 ima_collect_measurement+0x428/0x8e0 security/integrity/ima/ima_api.c:293
 process_measurement+0x1121/0x1a40 security/integrity/ima/ima_main.c:405
 ima_file_check+0xd7/0x120 security/integrity/ima/ima_main.c:633
 security_file_post_open+0xbb/0x290 security/security.c:3160
 do_open fs/namei.c:3889 [inline]
 path_openat+0x2f26/0x3830 fs/namei.c:4046
 do_filp_open+0x1fa/0x410 fs/namei.c:4073
 do_sys_openat2+0x121/0x1c0 fs/open.c:1435
 do_sys_open fs/open.c:1450 [inline]
 __do_sys_openat fs/open.c:1466 [inline]
 __se_sys_openat fs/open.c:1461 [inline]
 __x64_sys_openat+0x138/0x170 fs/open.c:1461
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fe33b38eba9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff93f3bee8 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00007fe33b5d5fa0 RCX: 00007fe33b38eba9
RDX: 0000000000183042 RSI: 0000200000000740 RDI: ffffffffffffff9c
RBP: 00007fe33b411e19 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000015 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fe33b5d5fa0 R14: 00007fe33b5d5fa0 R15: 0000000000000004
 </TASK>


***

kernel BUG in folio_end_read

tree:      torvalds
URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux
base:      f83ec76bf285bea5727f478a68b894f5543ca76e
arch:      amd64
compiler:  Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
config:    https://ci.syzbot.org/builds/4ec82322-3509-4b63-9881-f639f1b61f20/config
C repro:   https://ci.syzbot.org/findings/caca928c-4ba3-49fe-b564-cbb9aeab1706/c_repro
syz repro: https://ci.syzbot.org/findings/caca928c-4ba3-49fe-b564-cbb9aeab1706/syz_repro

 handle_mm_fault+0x40a/0x8e0 mm/memory.c:6364
 do_user_addr_fault+0x764/0x1390 arch/x86/mm/fault.c:1387
 handle_page_fault arch/x86/mm/fault.c:1476 [inline]
 exc_page_fault+0x76/0xf0 arch/x86/mm/fault.c:1532
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
------------[ cut here ]------------
kernel BUG at mm/filemap.c:1525!
Oops: invalid opcode: 0000 [#1] SMP KASAN PTI
CPU: 0 UID: 0 PID: 5995 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:folio_end_read+0x22e/0x230 mm/filemap.c:1525
Code: 24 c9 ff 48 89 df 48 c7 c6 20 3e 94 8b e8 5a 63 31 ff 90 0f 0b e8 62 24 c9 ff 48 89 df 48 c7 c6 80 36 94 8b e8 43 63 31 ff 90 <0f> 0b 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa
RSP: 0018:ffffc9000336eec8 EFLAGS: 00010246
RAX: 3b63e53e8591b500 RBX: ffffea0000c47280 RCX: 0000000000000000
RDX: 0000000000000007 RSI: ffffffff8d9ba482 RDI: 00000000ffffffff
RBP: 0000000000000001 R08: ffffffff8fa3a637 R09: 1ffffffff1f474c6
R10: dffffc0000000000 R11: fffffbfff1f474c7 R12: 1ffffd4000188e51
R13: 1ffffd4000188e50 R14: ffffea0000c47288 R15: 0000000000000008
FS:  00005555827bc500(0000) GS:ffff8880b8615000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b30d63fff CR3: 0000000027336000 CR4: 00000000000006f0
Call Trace:
 <TASK>
 iomap_read_remove_bias fs/iomap/buffered-io.c:383 [inline]
 iomap_read_folio_iter+0x9af/0xb70 fs/iomap/buffered-io.c:448
 iomap_readahead_iter fs/iomap/buffered-io.c:500 [inline]
 iomap_readahead+0x632/0xa40 fs/iomap/buffered-io.c:541
 iomap_bio_readahead include/linux/iomap.h:600 [inline]
 xfs_vm_readahead+0x9f/0xe0 fs/xfs/xfs_aops.c:753
 read_pages+0x17a/0x580 mm/readahead.c:160
 page_cache_ra_order+0x8ca/0xd40 mm/readahead.c:512
 filemap_readahead mm/filemap.c:2572 [inline]
 filemap_get_pages+0xb22/0x1ea0 mm/filemap.c:2617
 filemap_splice_read+0x581/0xc60 mm/filemap.c:2991
 xfs_file_splice_read+0x2c4/0x600 fs/xfs/xfs_file.c:345
 do_splice_read fs/splice.c:982 [inline]
 splice_direct_to_actor+0x4a9/0xcc0 fs/splice.c:1086
 do_splice_direct_actor fs/splice.c:1204 [inline]
 do_splice_direct+0x181/0x270 fs/splice.c:1230
 do_sendfile+0x4da/0x7e0 fs/read_write.c:1370
 __do_sys_sendfile64 fs/read_write.c:1431 [inline]
 __se_sys_sendfile64+0x13e/0x190 fs/read_write.c:1417
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f897438eba9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffec28881f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 00007f89745d5fa0 RCX: 00007f897438eba9
RDX: 0000000000000000 RSI: 0000000000000005 RDI: 0000000000000005
RBP: 00007f8974411e19 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000e0000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f89745d5fa0 R14: 00007f89745d5fa0 R15: 0000000000000004
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:folio_end_read+0x22e/0x230 mm/filemap.c:1525
Code: 24 c9 ff 48 89 df 48 c7 c6 20 3e 94 8b e8 5a 63 31 ff 90 0f 0b e8 62 24 c9 ff 48 89 df 48 c7 c6 80 36 94 8b e8 43 63 31 ff 90 <0f> 0b 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa
RSP: 0018:ffffc9000336eec8 EFLAGS: 00010246
RAX: 3b63e53e8591b500 RBX: ffffea0000c47280 RCX: 0000000000000000
RDX: 0000000000000007 RSI: ffffffff8d9ba482 RDI: 00000000ffffffff
RBP: 0000000000000001 R08: ffffffff8fa3a637 R09: 1ffffffff1f474c6
R10: dffffc0000000000 R11: fffffbfff1f474c7 R12: 1ffffd4000188e51
R13: 1ffffd4000188e50 R14: ffffea0000c47288 R15: 0000000000000008
FS:  00005555827bc500(0000) GS:ffff8880b8615000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b30d63fff CR3: 0000000027336000 CR4: 00000000000006f0


***

If these findings have caused you to resend the series or submit a
separate fix, please add the following tag to your commit message:
  Tested-by: syzbot@syzkaller.appspotmail.com

---
This report is generated by a bot. It may contain errors.
syzbot ci engineers can be reached at syzkaller@googlegroups.com.

