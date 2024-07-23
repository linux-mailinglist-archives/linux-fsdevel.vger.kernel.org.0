Return-Path: <linux-fsdevel+bounces-24108-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E38D8939894
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jul 2024 05:12:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CC261C2196B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jul 2024 03:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 398B313BC2F;
	Tue, 23 Jul 2024 03:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="M70k9AFd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E516C42AB3;
	Tue, 23 Jul 2024 03:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721704334; cv=none; b=f6F5vyhKFTyMsz6lrjViqSLoWsvwWClc0M4olQ6BiO8ZcT3dVoWkn4P6tpRlxZ4bFZblmhWrcTliYNiRwZ6rl7JeI9zf+u0td4QZ98kfBjfV/9RCxjR88KUCFGRegeq/pnzwrZbXTRBQmf6JPrcXsRepmiP9LNxjfp6R2BJbyv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721704334; c=relaxed/simple;
	bh=BVFBNVJEopweMgkwS0yCRpITnW9Vb72UW6UVguAMnCo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=cgeLYRpFay1ejmbLPwYOvhCp8aVKQIQ9uct6kpnmH4ovBOf0g6v9Bl3gm7/93SpbLQ0t2JCWRRMD99NjqfDY5esvmA3iviRt5e6+30l530DC4MI+67IowaNboeZViNnk61ATM37iz8Raw3M07Oy5y01svkx8m1xlpHa4VR6n8tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=M70k9AFd; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=9+ZzNfLKx1x+E/jrJLAE81V36izhpkebUp8gJEUE2eA=; b=M70k9AFdXAIjqyFoFZ8dKa4CER
	0Tu4Fjf82g0j6gzR6KhFTK3dLjXvbth5y6OGCMjndHbd+3iNTqX+CNw3v8PINiYX6FZs7lsQB9zH6
	mgwatODQFBAB7glBxd6Ytj1MtieNXCYECGFn3L1peItYuDxEwS64zXr8D/Gv6qhWuJmijuoTSs3uf
	UdvBkB2gsFxenVGZNUq+fSSmiU7CpzYiKEnhJznCtegk4Ps+TqwlvpsVX2/Wrw9a97O+g5rfpbiGB
	3iqDGx6gdJnah8LqEn6yi+K3RUu0ZJrC+eCZNPSdQESSYqGcU4nhATCei0Q/XA7BP5Vc/iolfFjEg
	JPfey3Ow==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sW5wX-00000006Sue-3Xpv;
	Tue, 23 Jul 2024 03:12:01 +0000
Date: Tue, 23 Jul 2024 04:12:01 +0100
From: Matthew Wilcox <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc: linux-btrfs@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Subject: State of removing page->index
Message-ID: <Zp8fgUSIBGQ1TN0D@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

My project for the next few weeks is removing page->index.

The last patch in the series is mostly:

+++ b/include/linux/mm_types.h
@@ -103,7 +103,7 @@ struct page {
                        /* See page-flags.h for PAGE_MAPPING_FLAGS */
                        struct address_space *mapping;
                        union {
-                               pgoff_t index;          /* Our offset within map
ping. */
+                               pgoff_t __folio_index;          /* Our offset wi
thin mapping. */
                                unsigned long share;    /* share count for fsdax */
                        };
                        /**

This is a stepping stone to shrinking struct page by half (64 bytes down
to 32 bytes) [1] and allocating struct folio separately from struct page.
It's currently 15 patches:

      bootmem: Stop using page->index
      mm: Constify page_address_in_vma()
      mm: Convert page_to_pgoff() to page_pgoff()
      mm: Mass constification of folio/page pointers
      fs: Turn page_offset() into a wrapper around folio_pos()
      fs: Remove page_mkwrite_check_truncate()
      mm: Remove references to page->index in huge_memory.c
      mm: Use page->private instead of page->index in percpu
      perf: Remove setting of page->index and ->mapping
      dax: Remove access to page->index
      null_blk: Remove accesses to page->index
      watch_queue: Use page->private instead of page->index
      isofs: Partially convert zisofs_read_folio to use a folio
      dax: Use folios more widely within DAX
      mm: Rename page->index to page->__folio_index

I haven't pushed the git tree because the build bots will choke on
the following files which still use page->index:

drivers/hwtracing/intel_th/msu.c
drivers/net/ethernet/sun/niu.c
drivers/staging/fbtft/fbtft-core.c
drivers/video/fbdev/core/fb_defio.c
fs/btrfs/compression.c
fs/btrfs/extent_io.c
fs/btrfs/file.c
fs/btrfs/super.c
fs/ceph/addr.c
fs/ceph/dir.c
fs/ceph/inode.c
fs/crypto/crypto.c
fs/ecryptfs/crypto.c
fs/ecryptfs/mmap.c
fs/ecryptfs/read_write.c
fs/erofs/data.c
fs/f2fs/checkpoint.c
fs/f2fs/compress.c
fs/f2fs/data.c
fs/f2fs/dir.c
fs/f2fs/file.c
fs/f2fs/inline.c
fs/f2fs/inode.c
fs/f2fs/node.c
fs/f2fs/segment.c
fs/f2fs/super.c
fs/fuse/file.c
fs/jffs2/file.c
fs/jfs/jfs_metapage.c
fs/ntfs3/frecord.c
fs/ocfs2/alloc.c
fs/ocfs2/aops.c
fs/ocfs2/mmap.c
fs/reiserfs/file.c
fs/reiserfs/inode.c
fs/smb/client/smb2ops.c
fs/squashfs/file.c
fs/squashfs/page_actor.c
fs/ufs/dir.c
mm/zsmalloc.c

Some of these will be fixed with scheduled pull requests (jfs), or are
improved (and maybe solved) by other pending series (ufs, ecryptfs,
jffs2, zsmalloc).

Expect to see a few patches from me over the next few weeks that seem
random; there is a destination in mind, and if everything lines up,
we might be able to get to it by the next merge window.  Probably
something will miss landing in v6.12 and it'll be the v6.13 release
before page->index goes away entirely.

I believe I have someone lined up to help with ocfs2.  If anyone wants to
help with the remaining filesystems (btrfs & f2fs in particular!), let
me know.  I'm honestly tempted to mark reiserfs BROKEN at this point.

The diffstat of what I currently have looks like this:

 arch/x86/mm/init_64.c         |  9 +++----
 drivers/block/null_blk/main.c |  8 +++---
 drivers/dax/device.c          |  9 +++----
 fs/ceph/addr.c                | 11 ++++----
 fs/dax.c                      | 53 ++++++++++++++++++++-------------------
 fs/isofs/compress.c           | 13 +++++-----
 include/linux/bootmem_info.h  | 25 +++++++++++++------
 include/linux/ksm.h           |  7 +++---
 include/linux/mm_types.h      |  6 ++---
 include/linux/pagemap.h       | 58 ++++++-------------------------------------
 include/linux/rmap.h          | 12 ++++-----
 kernel/events/core.c          |  2 --
 kernel/watch_queue.c          |  4 +--
 mm/bootmem_info.c             | 11 ++++----
 mm/huge_memory.c              | 18 +++++++-------
 mm/internal.h                 | 13 +++++++---
 mm/ksm.c                      |  5 ++--
 mm/memory-failure.c           | 28 +++++++++++----------
 mm/page_vma_mapped.c          |  5 ++--
 mm/percpu.c                   |  4 +--
 mm/rmap.c                     | 18 ++++++++------
 mm/sparse.c                   |  8 +++---
 mm/util.c                     |  2 +-
 23 files changed, 153 insertions(+), 176 deletions(-)

... mostly it's a 1:1 replacement of page with folio, or ->index with
->private, but we get to delete some stuff along the way.

[1] https://kernelnewbies.org/MatthewWilcox/Memdescs/Path
Yes, page->mapping is next on the list in case you're touching
a page->index and notice a page->mapping next door to it.

