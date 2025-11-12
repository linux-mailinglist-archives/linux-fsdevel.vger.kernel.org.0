Return-Path: <linux-fsdevel+bounces-68076-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CBB31C53852
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Nov 2025 17:54:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 49B8A50136E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Nov 2025 15:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB30A33F8CF;
	Wed, 12 Nov 2025 15:50:11 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2315D33BBB5
	for <linux-fsdevel@vger.kernel.org>; Wed, 12 Nov 2025 15:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762962611; cv=none; b=WGE49JodgI38qCc6zqT7EGes+Aze/2me3NLa7qhmluJe+pFS+sT/gXl4mS/m5S+f1TCZvmtRYi3E05EF0W/HkX0Pl/UaCm1+IlK1ulAVeVjCwe4+uhRCfLuQqIvvgXm2c/B4/DwneAWs86PcJx+xDi3QAwqEREukyp3vGmbcZ48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762962611; c=relaxed/simple;
	bh=06stUVdVrCwvUplAh76gT2K++oQBpkVUJo5TM4Bsguw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=PZRTwNkviiMzQCqkFuWyNDOl62jDCij4HLsWkWaUexQlLVOU5JriEKScm+bJEapGDKgFUwxUJowD/YYwvBxybK6PGXUGZuISfQgPZOzgChum5tr25KdGoWbebebIL71dDbm7A79xm+ujLhnNn9egsEGlotu18xQYB5VSmKUl1Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-433199c7fb4so8927125ab.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Nov 2025 07:50:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762962608; x=1763567408;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3zTsXzAL2O8FBHRHQuZTZdGfLgKf82AqMuTf8WBrX6k=;
        b=okWIYcHZj4DYYapl1+e2J3cf6VgGKWwwqsbXvTUGp1+yPd86u1ctKNyrzPewtiq3Ne
         L21kPVPbW0/wJW2Pr6PKvrzgaYrkd8F6RlHODI9S1aKCis6WfWDgPY1XmbI+bftmBEmH
         65aZ76BqceNHpE8jkijBrJjgXlTMtZmxOB/t6O7wCFUtltaPM+pQpvFQfA39ehMNBIFD
         pTMwMEY2KtG/gbDzyz8X5yAGs/3VM3Ypp9kBEBjCP5PJnpxz0tNFnIpjV/dHlIEfw8Mk
         tnGxCXXc+ritJjhLGt2VG5UauxPVI33J+EtrXwlzURm/FgRXhx0MqZS+EshCz0BXelcO
         +akQ==
X-Forwarded-Encrypted: i=1; AJvYcCXE8KRxGv2b9Ok855nloeJa1FcCy3jb6C96SuNfnnyp88S5PKT3vSdRS0rlquzjhLUUhoAdL18/1I3ryA/j@vger.kernel.org
X-Gm-Message-State: AOJu0YwSVXlTnf0YAZJI+m28AbI0erOzXI/ftjTqNQCCMKuZY2MkX8S8
	4ulQIICxQv6+TaA7YXa64IJ/aA996dmQ1FvkC4il7ZNHos8lpZ4GELK4YOY4DdjYDQAfg675+Lk
	idDk4ChSCt6lpDHS9ScuCyVDV4zhqrJZHU1Et2qkyddVEqyd1hjif+Mc4plw=
X-Google-Smtp-Source: AGHT+IHmXHfyTAC7o3gX451a5IIahr28v38z8/NoQnIggiwkPwHCChNJsSaHf6XMCJZzy1ZplwASB2f9wVZN0PHDzjagie+boMEe
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3521:b0:433:481d:fd61 with SMTP id
 e9e14a558f8ab-43473d92995mr43099555ab.18.1762962608328; Wed, 12 Nov 2025
 07:50:08 -0800 (PST)
Date: Wed, 12 Nov 2025 07:50:08 -0800
In-Reply-To: <cover.1762945505.git.ojaswin@linux.ibm.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6914acb0.050a0220.3565dc.0004.GAE@google.com>
Subject: [syzbot ci] Re: xfs: single block atomic writes for buffered IO
From: syzbot ci <syzbot+cie14707853a77f22b@syzkaller.appspotmail.com>
To: axboe@kernel.dk, brauner@kernel.org, dchinner@redhat.com, 
	djwong@kernel.org, hch@lst.de, jack@suse.cz, john.g.garry@oracle.com, 
	linux-block@vger.kernel.org, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org, 
	linux-xfs@vger.kernel.org, martin.petersen@oracle.com, nilay@linux.ibm.com, 
	ojaswin@linux.ibm.com, ritesh.list@gmail.com, rostedt@goodmis.org, 
	tytso@mit.edu, willy@infradead.org
Cc: syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot ci has tested the following series

[v1] xfs: single block atomic writes for buffered IO
https://lore.kernel.org/all/cover.1762945505.git.ojaswin@linux.ibm.com
* [RFC PATCH 1/8] fs: Rename STATX{_ATTR}_WRITE_ATOMIC -> STATX{_ATTR}_WRITE_ATOMIC_DIO
* [RFC PATCH 2/8] mm: Add PG_atomic
* [RFC PATCH 3/8] fs: Add initial buffered atomic write support info to statx
* [RFC PATCH 4/8] iomap: buffered atomic write support
* [RFC PATCH 5/8] iomap: pin pages for RWF_ATOMIC buffered write
* [RFC PATCH 6/8] xfs: Report atomic write min and max for buf io as well
* [RFC PATCH 7/8] iomap: Add bs<ps buffered atomic writes support
* [RFC PATCH 8/8] xfs: Lift the bs == ps restriction for HW buffered atomic writes

and found the following issue:
KASAN: slab-out-of-bounds Read in __bitmap_clear

Full report is available here:
https://ci.syzbot.org/series/430a088a-50e2-46d3-87ff-a1f0fa67b66c

***

KASAN: slab-out-of-bounds Read in __bitmap_clear

tree:      linux-next
URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next
base:      ab40c92c74c6b0c611c89516794502b3a3173966
arch:      amd64
compiler:  Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
config:    https://ci.syzbot.org/builds/02d3e137-5d7e-4c95-8f32-43b8663d95df/config
C repro:   https://ci.syzbot.org/findings/92a3582f-40a6-4936-8fcd-dc55c447a432/c_repro
syz repro: https://ci.syzbot.org/findings/92a3582f-40a6-4936-8fcd-dc55c447a432/syz_repro

==================================================================
BUG: KASAN: slab-out-of-bounds in __bitmap_clear+0x155/0x180 lib/bitmap.c:395
Read of size 8 at addr ffff88816ced7cd0 by task kworker/0:1/10

CPU: 0 UID: 0 PID: 10 Comm: kworker/0:1 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Workqueue: xfs-conv/loop0 xfs_end_io
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xca/0x240 mm/kasan/report.c:482
 kasan_report+0x118/0x150 mm/kasan/report.c:595
 __bitmap_clear+0x155/0x180 lib/bitmap.c:395
 bitmap_clear include/linux/bitmap.h:496 [inline]
 ifs_clear_range_atomic fs/iomap/buffered-io.c:241 [inline]
 iomap_clear_range_atomic+0x25c/0x630 fs/iomap/buffered-io.c:268
 iomap_finish_folio_write+0x2f0/0x410 fs/iomap/buffered-io.c:1971
 iomap_finish_ioend_buffered+0x223/0x5e0 fs/iomap/ioend.c:58
 iomap_finish_ioends+0x116/0x2b0 fs/iomap/ioend.c:295
 xfs_end_ioend+0x50b/0x690 fs/xfs/xfs_aops.c:168
 xfs_end_io+0x253/0x2d0 fs/xfs/xfs_aops.c:205
 process_one_work+0x94a/0x15d0 kernel/workqueue.c:3267
 process_scheduled_works kernel/workqueue.c:3350 [inline]
 worker_thread+0x9b0/0xee0 kernel/workqueue.c:3431
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x599/0xb30 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

Allocated by task 5952:
 kasan_save_stack mm/kasan/common.c:56 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:77
 poison_kmalloc_redzone mm/kasan/common.c:397 [inline]
 __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:414
 kasan_kmalloc include/linux/kasan.h:262 [inline]
 __do_kmalloc_node mm/slub.c:5672 [inline]
 __kmalloc_noprof+0x41d/0x800 mm/slub.c:5684
 kmalloc_noprof include/linux/slab.h:961 [inline]
 kzalloc_noprof include/linux/slab.h:1094 [inline]
 ifs_alloc+0x1e4/0x530 fs/iomap/buffered-io.c:356
 iomap_writeback_folio+0x81c/0x26a0 fs/iomap/buffered-io.c:2084
 iomap_writepages+0x162/0x2d0 fs/iomap/buffered-io.c:2168
 xfs_vm_writepages+0x28a/0x300 fs/xfs/xfs_aops.c:701
 do_writepages+0x32e/0x550 mm/page-writeback.c:2598
 filemap_writeback mm/filemap.c:387 [inline]
 filemap_fdatawrite_range mm/filemap.c:412 [inline]
 file_write_and_wait_range+0x23e/0x340 mm/filemap.c:786
 xfs_file_fsync+0x195/0x800 fs/xfs/xfs_file.c:137
 generic_write_sync include/linux/fs.h:2639 [inline]
 xfs_file_buffered_write+0x723/0x8a0 fs/xfs/xfs_file.c:1015
 do_iter_readv_writev+0x623/0x8c0 fs/read_write.c:-1
 vfs_writev+0x31a/0x960 fs/read_write.c:1057
 do_pwritev fs/read_write.c:1153 [inline]
 __do_sys_pwritev2 fs/read_write.c:1211 [inline]
 __se_sys_pwritev2+0x179/0x290 fs/read_write.c:1202
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff88816ced7c80
 which belongs to the cache kmalloc-96 of size 96
The buggy address is located 0 bytes to the right of
 allocated 80-byte region [ffff88816ced7c80, ffff88816ced7cd0)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x16ced7
flags: 0x57ff00000000000(node=1|zone=2|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 057ff00000000000 ffff888100041280 dead000000000100 dead000000000122
raw: 0000000000000000 0000000080200020 00000000f5000000 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x252800(GFP_NOWAIT|__GFP_NORETRY|__GFP_COMP|__GFP_THISNODE), pid 1, tgid 1 (swapper/0), ts 12041529441, free_ts 0
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x240/0x2a0 mm/page_alloc.c:1851
 prep_new_page mm/page_alloc.c:1859 [inline]
 get_page_from_freelist+0x2365/0x2440 mm/page_alloc.c:3920
 __alloc_frozen_pages_noprof+0x181/0x370 mm/page_alloc.c:5209
 alloc_slab_page mm/slub.c:3086 [inline]
 allocate_slab+0x71/0x350 mm/slub.c:3257
 new_slab mm/slub.c:3311 [inline]
 ___slab_alloc+0xf56/0x1990 mm/slub.c:4671
 __slab_alloc+0x65/0x100 mm/slub.c:4794
 __slab_alloc_node mm/slub.c:4870 [inline]
 slab_alloc_node mm/slub.c:5266 [inline]
 __kmalloc_cache_node_noprof+0x4b7/0x6f0 mm/slub.c:5799
 kmalloc_node_noprof include/linux/slab.h:983 [inline]
 alloc_node_nr_active kernel/workqueue.c:4908 [inline]
 __alloc_workqueue+0x6a9/0x1b80 kernel/workqueue.c:5762
 alloc_workqueue_noprof+0xd4/0x210 kernel/workqueue.c:5822
 nbd_dev_add+0x4f1/0xae0 drivers/block/nbd.c:1961
 nbd_init+0x168/0x1f0 drivers/block/nbd.c:2691
 do_one_initcall+0x25a/0x860 init/main.c:1378
 do_initcall_level+0x104/0x190 init/main.c:1440
 do_initcalls+0x59/0xa0 init/main.c:1456
 kernel_init_freeable+0x334/0x4b0 init/main.c:1688
 kernel_init+0x1d/0x1d0 init/main.c:1578
page_owner free stack trace missing

Memory state around the buggy address:
 ffff88816ced7b80: 00 00 00 00 00 00 00 00 00 00 fc fc fc fc fc fc
 ffff88816ced7c00: 00 00 00 00 00 00 00 00 00 00 fc fc fc fc fc fc
>ffff88816ced7c80: 00 00 00 00 00 00 00 00 00 00 fc fc fc fc fc fc
                                                 ^
 ffff88816ced7d00: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
 ffff88816ced7d80: 00 00 00 00 00 00 00 00 00 00 fc fc fc fc fc fc
==================================================================


***

If these findings have caused you to resend the series or submit a
separate fix, please add the following tag to your commit message:
  Tested-by: syzbot@syzkaller.appspotmail.com

---
This report is generated by a bot. It may contain errors.
syzbot ci engineers can be reached at syzkaller@googlegroups.com.

