Return-Path: <linux-fsdevel+bounces-18598-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEAF88BAA56
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 11:55:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A2C01F230CF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 09:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8287F152DF6;
	Fri,  3 May 2024 09:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TPBco6Nw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D511F14F9DC;
	Fri,  3 May 2024 09:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714730046; cv=none; b=Ghg2Ro9VjeBLv8M3XzhsBePSZhAIaqC2EFV5IhBGM5Y1mc2u3B75rW0ZZLSWM+96EFvnONLQ5y26HK5HDmaSduFNYHRBRMrqMoydaLLMplKP8RGD+GfaZyr3kNi4DEptkXhZsKtSxXAVwkAU6lzShKimgxidYB3Gf0U993WoOqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714730046; c=relaxed/simple;
	bh=pu9F0zR23Dd+IeBMpmXkhzvgqox3np2XcF6nNsTxb9w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PnI7nrZJT73Uwr1aNi+V1VbQxF2XMXd0zzJzVaX/EjOuMALmUjQx/V2F+0aBrc/hcJJFBjnlWZi58Db4B5Yx24YIcXzVmcCqDuRng8yAKVQjRX+P+vVNBz6FlnZGlAIbk0qBCVb7Wd2zAs3YrrMWbo5Ras6KL9tNiy9tR7DUI/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=TPBco6Nw; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=tXICgLDlPt9x6LyrrWFPrPPbantK/kpg/WVZcyA0J9Y=; b=TPBco6NwOG01vvbhxTM9YpTwNz
	Ts/4OKTR96oWhFG9iI0NxLctIXyBHrsBnvRF/O4c9zc7GZ5qVi5vEib/fh8BB9bzXn/JUqsvOs+5i
	nMmiVM6S9z+TeyoLQ9Zg86YuzfPWMu1V9U0aA8gYbXqhxWHGV88wo2EWXmp6wySW0XlmntDpxkoJi
	g61EgLRDXBIgbmJ+djGYd/zbulnGpNEFdQAvKZClOmoip3KNKbE2x8NUuZ375gi63lcuajfMN02Jx
	MpPQ3kTvz1Ck0Ti/pc0f5utZGO+H4/e/jXsPh1bxEDYiOOprrbFwhESBdscaR1bLP1pkC+huP1/xi
	v/kFNmMQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s2pc2-0000000Fw3K-3Q2M;
	Fri, 03 May 2024 09:53:54 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
To: akpm@linux-foundation.org,
	willy@infradead.org,
	djwong@kernel.org,
	brauner@kernel.org,
	david@fromorbit.com,
	chandan.babu@oracle.com
Cc: hare@suse.de,
	ritesh.list@gmail.com,
	john.g.garry@oracle.com,
	ziy@nvidia.com,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-mm@kvack.org,
	linux-block@vger.kernel.org,
	gost.dev@samsung.com,
	p.raghav@samsung.com,
	kernel@pankajraghav.com,
	mcgrof@kernel.org
Subject: [PATCH v5 00/11] enable bs > ps in XFS
Date: Fri,  3 May 2024 02:53:42 -0700
Message-ID: <20240503095353.3798063-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>

[ I was asked by Pankaj to post this v5 as he's out right now. ]

This is the fifth version of the series that enables block size > page size
(Large Block Size) in XFS. The context and motivation can be seen in cover
letter of the RFC v1 [0]. We also recorded a talk about this effort at LPC [1],
if someone would like more context on this effort.

The major change on this v5 is truncation to min order now included and has been
tested. The main issue which was observed was root cuased, and Matthew was able
to identify a fix for it in xarray, that fix is now queued up on
mm-hotfixes-unstable [2].

A lot of emphasis has been put on testing using kdevops, starting with an XFS
baseline [3]. The testing has been split into regression and progression.

Regression testing:
In regression testing, we ran the whole test suite to check for regressions on
existing profiles due to the page cache changes.

No regressions were found with these patches added on top.

Progression testing:
For progression testing, we tested for 8k, 16k, 32k and 64k block sizes.  To
compare it with existing support, an ARM VM with 64k base page system (without
our patches) was used as a reference to check for actual failures due to LBS
support in a 4k base page size system.

There are some tests that assumes block size < page size that needs to be fixed.
We have a tree with fixes for xfstests [4], most of the changes have been posted
already, and only a few minor changes need to be posted. Already part of these
changes has been upstreamed to fstests, and new tests have also been written and
are out for review, namely for mmap zeroing-around corner cases, compaction
and fsstress races on mm, and stress testing folio truncation on file mapped
folios.

No new failures were found with the LBS support.

We've done some preliminary performance tests with fio on XFS on 4k block size
against pmem and NVMe with buffered IO and Direct IO on vanilla Vs + these
patches applied, and detected no regressions.

We also wrote an eBPF tool called blkalgn [5] to see if IO sent to the device
is aligned and at least filesystem block size in length.

For those who want this in a git tree we have this up on a kdevops
20240503-large-block-minorder branch [6].

[0] https://lore.kernel.org/lkml/20230915183848.1018717-1-kernel@pankajraghav.com/
[1] https://www.youtube.com/watch?v=ar72r5Xf7x4
[2] https://lkml.kernel.org/r/20240501153120.4094530-1-willy@infradead.org
[3] https://github.com/linux-kdevops/kdevops/blob/master/docs/xfs-bugs.md
489 non-critical issues and 55 critical issues. We've determined and reported
that the 55 critical issues have all fall into 5 common  XFS asserts or hung
tasks  and 2 memory management asserts.
[4] https://github.com/linux-kdevops/fstests/tree/lbs-fixes
[5] https://github.com/iovisor/bcc/pull/4813
[7] https://github.com/linux-kdevops/linux/tree/20240503-large-block-minorder

Changes since v4:
- Added new Reviewed-by tags
- Truncation is now enabled, this depends on Matthew Wilcox xarray fix
  being merged and its already on its way
- filemap_map_pages() simplification as suggested by Matthew Wilcox
- minor variable forward declration ordering as suggested by Matthew Wilcox

Changes since v3:
- Cap the PTE range to i_size for LBS configuration in folio_map_range()
- Added Chinners kvmalloc xattr patches
- Moved Hannes patches before adding the minorder patches to avoid confusion.
- Added mapping_set_folio_order_range().
- Return EINVAL instead EAGAIN in split_huge_page_to_list_to_order()

Changes since v2:
- Simplified the filemap and readahead changes. (Thanks willy)
- Removed DEFINE_READAHEAD_ALIGN.
- Added minorder support to readahead_expand().

Changes since v1:
- Round up to nearest min nr pages in ra_init
- Calculate index in filemap_create instead of doing in filemap_get_pages
- Remove unnecessary BUG_ONs in the delete path
- Use check_shl_overflow instead of check_mul_overflow
- Cast to uint32_t instead of unsigned long in xfs_stat_blksize

Changes since RFC v2:
- Move order 1 patch above the 1st patch
- Remove order == 1 conditional in `fs: Allow fine-grained control of
folio sizes`. This fixed generic/630 that was reported in the previous version.
- Hide the max order and expose `mapping_set_folio_min_order` instead.
- Add new helper mapping_start_index_align and DEFINE_READAHEAD_ALIGN
- don't call `page_cache_ra_order` with min order in do_mmap_sync_readahead
- simplify ondemand readahead with only aligning the start index at the end
- Don't cap ra_pages based on bdi->io_pages
- use `checked_mul_overflow` while calculating bytes in validate_fsb
- Remove config lbs option
- Add a warning while mounting a LBS kernel
- Add Acked-by and Reviewed-by from Hannes and Darrick.

Changes since RFC v1:
- Added willy's patch to enable order-1 folios.
- Unified common page cache effort from Hannes LBS work.
- Added a new helper min_nrpages and added CONFIG_THP for enabling
  mapping_large_folio_support
- Don't split a folio if it has minorder set. Remove the old code where we
  set extra pins if it has that requirement.
- Split the code in XFS between the validation of mapping count. Put the
  icache code changes with enabling bs > ps.
- Added CONFIG_XFS_LBS option
- align the index in do_read_cache_folio()
- Removed truncate changes
- Fixed generic/091 with iomap changes to iomap_dio_zero function.
- Took care of folio truncation scenario in page_cache_ra_unbounded()
  that happens after read_pages if a folio was found.
- Sqaushed and moved commits around
- Rebased on top of v6.8-rc4

Dave Chinner (1):
  xfs: use kvmalloc for xattr buffers

Hannes Reinecke (1):
  readahead: rework loop in page_cache_ra_unbounded()

Luis Chamberlain (2):
  filemap: allocate mapping_min_order folios in the page cache
  mm: split a folio in minimum folio order chunks

Matthew Wilcox (Oracle) (1):
  fs: Allow fine-grained control of folio sizes

Pankaj Raghav (6):
  readahead: allocate folios with mapping_min_order in readahead
  filemap: cap PTE range to be created to allowed zero fill in
    folio_map_range()
  iomap: fix iomap_dio_zero() for fs bs > system page size
  xfs: expose block size in stat
  xfs: make the calculation generic in xfs_sb_validate_fsb_count()
  xfs: enable block size larger than page size support

 fs/iomap/direct-io.c          |  13 +++-
 fs/xfs/libxfs/xfs_attr_leaf.c |  15 ++---
 fs/xfs/libxfs/xfs_ialloc.c    |   5 ++
 fs/xfs/libxfs/xfs_shared.h    |   3 +
 fs/xfs/xfs_icache.c           |   6 +-
 fs/xfs/xfs_iops.c             |   2 +-
 fs/xfs/xfs_mount.c            |  10 ++-
 fs/xfs/xfs_super.c            |  10 +--
 include/linux/huge_mm.h       |  12 ++--
 include/linux/pagemap.h       | 116 ++++++++++++++++++++++++++++------
 mm/filemap.c                  |  31 ++++++---
 mm/huge_memory.c              |  50 ++++++++++++++-
 mm/readahead.c                |  94 +++++++++++++++++++++------
 13 files changed, 290 insertions(+), 77 deletions(-)

-- 
2.43.0


