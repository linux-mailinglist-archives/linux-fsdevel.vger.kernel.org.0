Return-Path: <linux-fsdevel+bounces-29329-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89B989781F0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 15:59:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AC3C1F2104E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 13:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33C141DC07F;
	Fri, 13 Sep 2024 13:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="swOMMPxy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2491DC05C;
	Fri, 13 Sep 2024 13:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726235727; cv=none; b=k5RvvB3WZvb5fhrCX+lWpf2OEhQX9HeA7KmbCRk9H3R7veLxW7VLduRNQ/+O4Y3fdWoOl2oQe5m4XH7Ei5EMF++uzLfRtIyLmfDEWSqOIhpRFVXVwcy1Iwbrg5XlLuUCYXjg2MZ5fhghVarSSdC/pSs5cvYBnSWcaQzyIMawHYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726235727; c=relaxed/simple;
	bh=oXazqEKDh0tAXw5ldH6EeU5zLIRYchYyy7PuXPu4XyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f24prMrNSFFqd7xCH0IDmAjsvHu6Ykw0Cp1qUSz1brcFBAPBchQeq1VE0ddATvOJjF95YkhOg8I18/f3ZhMZ8sS5bFFXG/9+y82GjtApjQmgcIvo5SQjuhklcWBbcgE5e+4BlD2JOvrz8yy6fMxTpy6gY4WcrFTk+QxgQLUGfA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=swOMMPxy; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ukaDfgZI5gyswKyGd9RyUNeHhjbD+lqgoaj3eehBdls=; b=swOMMPxyEy7Ioqk+jDcYTNAHYf
	6/8YGbokqCJKbUOOClv9kvgCSx6wVMAjbOnNVDDi4fmecmsxBHPmyZtSlL2AUHtd3vh+u8V1tXeZS
	ZWpQGh/iKnq3/SN1OSxNS9WIrCabvdldVKZ9CSsre6f7vmNqXdZc5cg+U0iWwWH2GN+cdl67pTwyp
	L16rS/V4sPvG/6z+8vCR3N3wv8fSYphs4VSWUmSQrVR1KLuR5aqD6IQX0+bjqBZ+ZDk2muycn9L6M
	wf51zhWEr6+5LlBDURQ4ieI5WlFZSP/bcodJXbPDiUdWRAXGYBCjsd6QBqxdhWrZruaKoJOiSA0Zl
	NXoyNyKw==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sp6lb-0000000GdYm-00Qk;
	Fri, 13 Sep 2024 13:55:19 +0000
Date: Fri, 13 Sep 2024 14:55:18 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Hillf Danton <hdanton@sina.com>
Cc: syzbot <syzbot+0930d8a3c3c55e931634@syzkaller.appspotmail.com>,
	Jan Kara <jack@suse.cz>,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [fs?] KASAN: slab-use-after-free Read in
 invalidate_bh_lru
Message-ID: <ZuRERj-RNkBHlqIx@casper.infradead.org>
References: <0000000000005c2d960621e89afe@google.com>
 <20240913123104.367-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240913123104.367-1-hdanton@sina.com>

On Fri, Sep 13, 2024 at 08:31:04PM +0800, Hillf Danton wrote:
> On Thu, 12 Sep 2024 02:19:26 -0700
> > ==================================================================
> > BUG: KASAN: slab-use-after-free in instrument_atomic_read include/linux/instrumented.h:68 [inline]
> > BUG: KASAN: slab-use-after-free in atomic_read include/linux/atomic/atomic-instrumented.h:32 [inline]
> > BUG: KASAN: slab-use-after-free in __brelse fs/buffer.c:1235 [inline]
> > BUG: KASAN: slab-use-after-free in brelse include/linux/buffer_head.h:325 [inline]
> > BUG: KASAN: slab-use-after-free in __invalidate_bh_lrus fs/buffer.c:1508 [inline]
> > BUG: KASAN: slab-use-after-free in invalidate_bh_lru+0xa8/0x1b0 fs/buffer.c:1521
> > Read of size 4 at addr ffff88801c989a58 by task udevd/5114
> > 
> A worse case than the report looks like
> 
> 	buff head is freed and reused with bh lru left intact

How is that supposed to happen?  We take a reference to the BH when
it goes on the LRU list, so it shouldn't be freed.

We free BHs in free_buffer_head().  That's called from two places; the
failure path of folio_alloc_buffers() and try_to_free_buffers().
try_to_free_buffers() calls drop_buffers() first, which checks
buffer_busy(), which will fail if bh->b_count is non-zero.

You can't even get to the BHs in folio_alloc_buffers() because they're
not attached to anything until the function returns.

So I have no idea what the problem is here.  And also I don't think it's
my responsibility to track it down.  I'm not the buffer_head maintainer.

> 	flush bh lru
> 	__brelse()
> 	if (atomic_read(&bh->b_count)) {
> 		put_bh(bh);
> 		return;
> 	}
> 
> and bh->b_count gets corrupted by put_bh().
> 
> > CPU: 0 UID: 0 PID: 5114 Comm: udevd Not tainted 6.11.0-rc6-syzkaller-00308-gb31c44928842 #0
> > Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
> > Call Trace:
> >  <TASK>
> >  __dump_stack lib/dump_stack.c:93 [inline]
> >  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:119
> >  print_address_description mm/kasan/report.c:377 [inline]
> >  print_report+0x169/0x550 mm/kasan/report.c:488
> >  kasan_report+0x143/0x180 mm/kasan/report.c:601
> >  kasan_check_range+0x282/0x290 mm/kasan/generic.c:189
> >  instrument_atomic_read include/linux/instrumented.h:68 [inline]
> >  atomic_read include/linux/atomic/atomic-instrumented.h:32 [inline]
> >  __brelse fs/buffer.c:1235 [inline]
> >  brelse include/linux/buffer_head.h:325 [inline]
> >  __invalidate_bh_lrus fs/buffer.c:1508 [inline]
> >  invalidate_bh_lru+0xa8/0x1b0 fs/buffer.c:1521
> >  csd_do_func kernel/smp.c:134 [inline]
> >  smp_call_function_many_cond+0x15d7/0x29d0 kernel/smp.c:847
> >  on_each_cpu_cond_mask+0x3f/0x80 kernel/smp.c:1023
> >  kill_bdev block/bdev.c:89 [inline]
> >  blkdev_flush_mapping+0xfe/0x250 block/bdev.c:664
> >  blkdev_put_whole block/bdev.c:671 [inline]
> >  bdev_release+0x466/0x700 block/bdev.c:1096
> >  blkdev_release+0x15/0x20 block/fops.c:638
> >  __fput+0x24a/0x8a0 fs/file_table.c:422
> >  __do_sys_close fs/open.c:1566 [inline]
> >  __se_sys_close fs/open.c:1551 [inline]
> >  __x64_sys_close+0x7f/0x110 fs/open.c:1551
> >  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> >  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > RIP: 0033:0x7f8226f170a8
> > Code: 48 8b 05 83 9d 0d 00 64 c7 00 16 00 00 00 83 c8 ff 48 83 c4 20 5b c3 64 8b 04 25 18 00 00 00 85 c0 75 20 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 76 5b 48 8b 15 51 9d 0d 00 f7 d8 64 89 02 48 83
> > RSP: 002b:00007ffe0319be58 EFLAGS: 00000246 ORIG_RAX: 0000000000000003
> > RAX: ffffffffffffffda RBX: 00007f8226dee0e0 RCX: 00007f8226f170a8
> > RDX: 000056579a6766d5 RSI: 00007ffe0319b658 RDI: 0000000000000008
> > RBP: 00005652ff487f60 R08: 0000000000000006 R09: b595b5b875e4bbae
> > R10: 000000000000010f R11: 0000000000000246 R12: 0000000000000002
> > R13: 00005652ff478840 R14: 0000000000000008 R15: 00005652ff466910
> >  </TASK>
> > 
> > Allocated by task 5112:
> >  kasan_save_stack mm/kasan/common.c:47 [inline]
> >  kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
> >  unpoison_slab_object mm/kasan/common.c:312 [inline]
> >  __kasan_slab_alloc+0x66/0x80 mm/kasan/common.c:338
> >  kasan_slab_alloc include/linux/kasan.h:201 [inline]
> >  slab_post_alloc_hook mm/slub.c:3992 [inline]
> >  slab_alloc_node mm/slub.c:4041 [inline]
> >  kmem_cache_alloc_noprof+0x135/0x2a0 mm/slub.c:4048
> >  alloc_buffer_head+0x2a/0x290 fs/buffer.c:3025
> >  folio_alloc_buffers+0x241/0x5b0 fs/buffer.c:929
> >  grow_dev_folio fs/buffer.c:1072 [inline]
> >  grow_buffers fs/buffer.c:1113 [inline]
> >  __getblk_slow fs/buffer.c:1139 [inline]
> >  bdev_getblk+0x2a6/0x550 fs/buffer.c:1441
> >  __bread_gfp+0x86/0x400 fs/buffer.c:1495
> >  sb_bread include/linux/buffer_head.h:347 [inline]
> >  sysv_fill_super+0x231/0x710 fs/sysv/super.c:379
> >  mount_bdev+0x20a/0x2d0 fs/super.c:1679
> >  legacy_get_tree+0xee/0x190 fs/fs_context.c:662
> >  vfs_get_tree+0x90/0x2b0 fs/super.c:1800
> >  do_new_mount+0x2be/0xb40 fs/namespace.c:3472
> >  do_mount fs/namespace.c:3812 [inline]
> >  __do_sys_mount fs/namespace.c:4020 [inline]
> >  __se_sys_mount+0x2d6/0x3c0 fs/namespace.c:3997
> >  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> >  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > 
> > Freed by task 79:
> >  kasan_save_stack mm/kasan/common.c:47 [inline]
> >  kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
> >  kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:579
> >  poison_slab_object+0xe0/0x150 mm/kasan/common.c:240
> >  __kasan_slab_free+0x37/0x60 mm/kasan/common.c:256
> >  kasan_slab_free include/linux/kasan.h:184 [inline]
> >  slab_free_hook mm/slub.c:2256 [inline]
> >  slab_free mm/slub.c:4477 [inline]
> >  kmem_cache_free+0x145/0x350 mm/slub.c:4552
> >  free_buffer_head+0x54/0x240 fs/buffer.c:3041
> >  try_to_free_buffers+0x311/0x5f0 fs/buffer.c:2982
> >  shrink_folio_list+0x26c2/0x8c90 mm/vmscan.c:1413
> >  evict_folios+0x50f7/0x7780 mm/vmscan.c:4560
> >  try_to_shrink_lruvec+0x9ab/0xbb0 mm/vmscan.c:4755
> >  shrink_one+0x3b9/0x850 mm/vmscan.c:4793
> >  shrink_many mm/vmscan.c:4856 [inline]
> >  lru_gen_shrink_node mm/vmscan.c:4934 [inline]
> >  shrink_node+0x3799/0x3de0 mm/vmscan.c:5914
> >  kswapd_shrink_node mm/vmscan.c:6742 [inline]
> >  balance_pgdat mm/vmscan.c:6934 [inline]
> >  kswapd+0x1cbc/0x3720 mm/vmscan.c:7203
> >  kthread+0x2f0/0x390 kernel/kthread.c:389
> >  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
> >  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
> > 
> > The buggy address belongs to the object at ffff88801c9899f8
> >  which belongs to the cache buffer_head of size 168
> > The buggy address is located 96 bytes inside of
> >  freed 168-byte region [ffff88801c9899f8, ffff88801c989aa0)
> > 
> > The buggy address belongs to the physical page:
> > page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1c989
> > flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
> > page_type: 0xfdffffff(slab)
> > raw: 00fff00000000000 ffff88801b763c80 ffffea0000725d40 0000000000000006
> > raw: 0000000000000000 0000000080110011 00000001fdffffff 0000000000000000
> > page dumped because: kasan: bad access detected
> > page_owner tracks the page as allocated
> > page last allocated via order 0, migratetype Reclaimable, gfp_mask 0x152c50(GFP_NOFS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_HARDWALL|__GFP_RECLAIMABLE), pid 1, tgid 1 (init), ts 28576033639, free_ts 0
> >  set_page_owner include/linux/page_owner.h:32 [inline]
> >  post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1500
> >  prep_new_page mm/page_alloc.c:1508 [inline]
> >  get_page_from_freelist+0x2e4c/0x2f10 mm/page_alloc.c:3446
> >  __alloc_pages_noprof+0x256/0x6c0 mm/page_alloc.c:4702
> >  __alloc_pages_node_noprof include/linux/gfp.h:269 [inline]
> >  alloc_pages_node_noprof include/linux/gfp.h:296 [inline]
> >  alloc_slab_page+0x5f/0x120 mm/slub.c:2325
> >  allocate_slab+0x5a/0x2f0 mm/slub.c:2488
> >  new_slab mm/slub.c:2541 [inline]
> >  ___slab_alloc+0xcd1/0x14b0 mm/slub.c:3727
> >  __slab_alloc+0x58/0xa0 mm/slub.c:3817
> >  __slab_alloc_node mm/slub.c:3870 [inline]
> >  slab_alloc_node mm/slub.c:4029 [inline]
> >  kmem_cache_alloc_noprof+0x1c1/0x2a0 mm/slub.c:4048
> >  alloc_buffer_head+0x2a/0x290 fs/buffer.c:3025
> >  folio_alloc_buffers+0x241/0x5b0 fs/buffer.c:929
> >  grow_dev_folio fs/buffer.c:1072 [inline]
> >  grow_buffers fs/buffer.c:1113 [inline]
> >  __getblk_slow fs/buffer.c:1139 [inline]
> >  bdev_getblk+0x2a6/0x550 fs/buffer.c:1441
> >  __getblk include/linux/buffer_head.h:381 [inline]
> >  sb_getblk include/linux/buffer_head.h:387 [inline]
> >  ext4_read_inode_bitmap+0x24c/0x12f0 fs/ext4/ialloc.c:145
> >  __ext4_new_inode+0x106f/0x4260 fs/ext4/ialloc.c:1054
> >  ext4_create+0x279/0x550 fs/ext4/namei.c:2832
> >  lookup_open fs/namei.c:3578 [inline]
> >  open_last_lookups fs/namei.c:3647 [inline]
> >  path_openat+0x1a9a/0x3470 fs/namei.c:3883
> >  do_filp_open+0x235/0x490 fs/namei.c:3913
> > page_owner free stack trace missing
> > 
> > Memory state around the buggy address:
> >  ffff88801c989900: fc fc fa fb fb fb fb fb fb fb fb fb fb fb fb fb
> >  ffff88801c989980: fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc fa
> > >ffff88801c989a00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> >                                                     ^
> >  ffff88801c989a80: fb fb fb fb fc fc fc fc fc fc fc fc 00 00 00 00
> >  ffff88801c989b00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > ==================================================================

