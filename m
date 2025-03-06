Return-Path: <linux-fsdevel+bounces-43314-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C3B8A541F0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Mar 2025 06:11:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E6E0169D79
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Mar 2025 05:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2A9719D891;
	Thu,  6 Mar 2025 05:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="i88gzM5F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080C37E9;
	Thu,  6 Mar 2025 05:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741237858; cv=none; b=iVpJoiOgnjG4NLVZTo14ylNTDguCxn2Esjx4PRR0PLpzzBq4aOHAeQkuFXdU3ZdjWtMTi4hr10IIki66SZsfzdoW8WKKG0f6j/B7X7jS77Zxe6tiJVbmPcGmXF2GJ4q8dJguM3FZrp+9V9ZXpTXdrlhJWj6id9QWrZHcslQwz0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741237858; c=relaxed/simple;
	bh=4DbueHlttFV8uEm6cha8MpMRQjUVM93gk8BRNUSWEk4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zit/9ZMNVgrhT4LuFeJsY/ShgvmtRlorT0AUzBlom/ts9YrgZnsT6xZmMgxsJexWL4aM9P5vrrzRCtqFlDW2XEZyYCKl6Do7aj7Ai2oCxiBL8BAk5iEcd84V3HbU1Z9dDu+tQP2ySdH6SBzTWZmxEWuCkCvXEQZl0Q4+mbpqB6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=i88gzM5F; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=XST+jheb705ZIJsJQQajySkT5tEWK7OqP/Yr2rYjQZc=; b=i88gzM5F9CHlNSXhYSF3Tg+OBk
	gP3SH4qseRy7Hnw+Uoix0oDZSbCOeYKzIuADYKD/p+muY6mZaDl+0V8DTj8TepAyIryfbzMj/VkQD
	+myqIK1SG80bEr6iQmWG01YFOR1U0nbvT+80auQANjWrt9uz1+9Ni0OCe6aCLxqRAu8faM7hGyLu2
	Om2zOqTPVCleHOs8qoVcvXBfH0D5J/NZmagFYMLMo9v9ht5Y+d+hJ4uOVpCrwYZ8qV837G/TQo07b
	LOmps4qOHTvGwKi1cmzyjr8V8FLLm1U0WEe1vrq3vkcHi7bK+KHjAPd0gApTGslYGkf9kGwBu8Bv5
	eiE5X8fw==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tq3VT-00000006qKX-1UEm;
	Thu, 06 Mar 2025 05:10:51 +0000
Date: Thu, 6 Mar 2025 05:10:51 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Luka <luka.2016.cs@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
	linux-fsdevel@vger.kernel.org
Subject: Potential Linux Crash: WARNING in __getblk_slow in Linux kernel
 v6.13-rc5
Message-ID: <Z8kuWyqj8cS-stKA@casper.infradead.org>
References: <CALm_T+3j+dyK02UgPiv9z0f1oj-HM63oxhsB0JF9gVAjeVfm1Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALm_T+3j+dyK02UgPiv9z0f1oj-HM63oxhsB0JF9gVAjeVfm1Q@mail.gmail.com>

On Thu, Mar 06, 2025 at 10:54:13AM +0800, Luka wrote:
> Dear Linux Kernel Experts,
> 
> Hello!
> 
> I am a security researcher focused on testing Linux kernel
> vulnerabilities. Recently, while testing the v6.13-rc5 Linux kernel,
> we encountered a crash related to the mm kernel module. We have
> successfully captured the call trace information for this crash.
> 
> Unfortunately, we have not been able to reproduce the issue in our
> local environment, so we are unable to provide a PoC (Proof of
> Concept) at this time.
> 
> We fully understand the complexity and importance of Linux kernel
> maintenance, and we would like to share this finding with you for
> further analysis and confirmation of the root cause. Below is a
> summary of the relevant information:

You're a "security researcher" ... but you're not even going to do a
cursory look at the code to figure out what's going on?

        if (unlikely(nofail)) {
...
                WARN_ON_ONCE(current->flags & PF_MEMALLOC);
^^^ that's the line which triggered the warning.  So it's not a
problem in the memory allocator at all, it's the memory allocator
reporting that someone's asked it to satisfy some impossible
constraints.

>  alloc_pages_mpol_noprof+0xda/0x300 mm/mempolicy.c:2269
>  folio_alloc_noprof+0x1e/0x70 mm/mempolicy.c:2355
>  filemap_alloc_folio_noprof+0x2b2/0x2f0 mm/filemap.c:1009
>  __filemap_get_folio+0x16d/0x3d0 mm/filemap.c:1951
>  grow_dev_folio fs/buffer.c:1039 [inline]
>  grow_buffers fs/buffer.c:1105 [inline]
>  __getblk_slow+0x138/0x430 fs/buffer.c:1131
>  bdev_getblk fs/buffer.c:1431 [inline]
>  __bread_gfp+0xea/0x2c0 fs/buffer.c:1485

__bread_gfp is who sets GFP_NOFAIL.

>  sb_bread include/linux/buffer_head.h:346 [inline]
>  fat12_ent_bread+0x231/0x3f0 fs/fat/fatent.c:86
>  fat_ent_read+0x624/0xaa0 fs/fat/fatent.c:368
>  fat_free_clusters+0x19c/0x860 fs/fat/fatent.c:568
>  fat_free.isra.0+0x377/0x850 fs/fat/file.c:376
>  fat_truncate_blocks+0x10d/0x190 fs/fat/file.c:394
>  fat_free_eofblocks fs/fat/inode.c:633 [inline]
>  fat_evict_inode+0x1b1/0x260 fs/fat/inode.c:658
>  evict+0x337/0x7c0 fs/inode.c:796
>  dispose_list fs/inode.c:845 [inline]
>  prune_icache_sb+0x189/0x290 fs/inode.c:1033
>  super_cache_scan+0x33d/0x510 fs/super.c:223
>  do_shrink_slab mm/shrinker.c:437 [inline]
>  shrink_slab+0x43e/0x930 mm/shrinker.c:664
>  shrink_node_memcgs mm/vmscan.c:5931 [inline]
>  shrink_node+0x4dd/0x15c0 mm/vmscan.c:5970
>  shrink_zones mm/vmscan.c:6215 [inline]
>  do_try_to_free_pages+0x284/0x1160 mm/vmscan.c:6277
>  try_to_free_pages+0x1ee/0x3e0 mm/vmscan.c:6527
>  __perform_reclaim mm/page_alloc.c:3929 [inline]

And __perform_reclaim() is where PF_MEMALLOC gets set.

>  __alloc_pages_direct_reclaim mm/page_alloc.c:3951 [inline]
>  __alloc_pages_slowpath mm/page_alloc.c:4382 [inline]
>  __alloc_pages_noprof+0xa48/0x2040 mm/page_alloc.c:4766
>  alloc_pages_mpol_noprof+0xda/0x300 mm/mempolicy.c:2269
>  pagetable_alloc_noprof include/linux/mm.h:2899 [inline]
>  __pte_alloc_one_noprof include/asm-generic/pgalloc.h:70 [inline]
>  pte_alloc_one+0x20/0x1b0 arch/x86/mm/pgtable.c:33
>  do_fault_around mm/memory.c:5274 [inline]
>  do_read_fault mm/memory.c:5313 [inline]
>  do_fault mm/memory.c:5456 [inline]
>  do_pte_missing mm/memory.c:3979 [inline]
>  handle_pte_fault mm/memory.c:5801 [inline]
>  __handle_mm_fault+0x15b9/0x2380 mm/memory.c:5944
>  handle_mm_fault+0x1c6/0x4c0 mm/memory.c:6112
>  faultin_page mm/gup.c:1196 [inline]
>  __get_user_pages+0x421/0x2550 mm/gup.c:1494
>  populate_vma_page_range+0x16b/0x200 mm/gup.c:1932
>  __mm_populate+0x1c2/0x360 mm/gup.c:2035
>  mm_populate include/linux/mm.h:3396 [inline]
>  vm_mmap_pgoff+0x25d/0x2f0 mm/util.c:585
>  ksys_mmap_pgoff+0x5a/0x480 mm/mmap.c:542

Now, I'm not sure how best to solve this.  Should FAT decline to read
entries if it's called from reclaim?  I know XFS goes to some trouble to
not do that kind of thing.  Or should buffer head allocation do
something to access the emergency reserves?

