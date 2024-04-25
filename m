Return-Path: <linux-fsdevel+bounces-17737-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6A948B2068
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 13:38:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 300D11F2574B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 11:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80DAD12B153;
	Thu, 25 Apr 2024 11:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="uwRh5GQN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA29886249;
	Thu, 25 Apr 2024 11:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714045078; cv=none; b=CZRwLifnIMP1QEXE9eboAbyXg3YSh5W3YiQUOTRE3P/2JsnjJPSzwmjX5BwvgoJoLz+P4q5vIBdmPgpB+b/PP2SiwPok0kA3XGqi6W7CMVwqDbD1iRQrQRDS1jU9WueXSt4PRSU9wWyItuje+zWXy+Xz0hK4F4OnIPc1Qo/5agQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714045078; c=relaxed/simple;
	bh=vNDx9fwLspXZs/OoV2AUZFh7B5mfBLYw1atOY+hPFBg=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=sPY/nI7AFjwIAV5UqfNJgFscmpE7wwZN8zSfVQG0WpOz1p1bviMlljl1Lh+Qmu5Zkcfx4BlxEMC9XZytCeWuyaWvNATNIfE+7/1p1ghoYzBiGEUXWEi7MhiBy0QzYejJuO2dsJWc8u6K5QUqO1NolqE9G7A3H46EDHGx8VlbKF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=uwRh5GQN; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4VQDPC594lz9sSp;
	Thu, 25 Apr 2024 13:37:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1714045071;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=U8xxTfMBMOv/DYScjU0FP2xsJBK+AQKv6ki1ccbkX/A=;
	b=uwRh5GQN2HBZrj6jGskurZbmTw7TtTazgVlZGxkbKiGdTfjn+DI5opyY916bNllTr/EvFF
	fHdWqMhE3ooOY4Pmb72Jo8X4Bigl8JFEiby5+/RpyGjz8QCjPATGVOtvJ/h4T8hfxbay8k
	dAoD2NMEJ77/rQwH/Bt/kzjiX8awcb/16yhhDGlCpjUPtjdQ8hcskT/NKQN8cFjqghPN96
	9AY3IzVZc7EGrVIX5o6pP01gMP9c6fB4Q47yqNM12Foryn8SrynTSM7gH3RLnYHECPBIfu
	AwaDhjBlONBMbg1Ot7k3nLoYvkfIMlM0ZtB/HX4TQdPZypxaIFuSb+4tGNN4yg==
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: willy@infradead.org,
	djwong@kernel.org,
	brauner@kernel.org,
	david@fromorbit.com,
	chandan.babu@oracle.com,
	akpm@linux-foundation.org
Cc: linux-fsdevel@vger.kernel.org,
	hare@suse.de,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-xfs@vger.kernel.org,
	mcgrof@kernel.org,
	gost.dev@samsung.com,
	p.raghav@samsung.com
Subject: [PATCH v4 00/11] enable bs > ps in XFS
Date: Thu, 25 Apr 2024 13:37:35 +0200
Message-Id: <20240425113746.335530-1-kernel@pankajraghav.com>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pankaj Raghav <p.raghav@samsung.com>

This is the fourth version of the series that enables block size > page size
(Large Block Size) in XFS. The context and motivation can be seen in cover
letter of the RFC v1[1]. We also recorded a talk about this effort at LPC [3],
if someone would like more context on this effort.

This series does not split a folio during truncation even though we have
an API to do so due to some issues with writeback. While it is not a
blocker, this feature can be added as a future improvement once we
get the base patches upstream (See patch 7).

A lot of emphasis has been put on testing using kdevops. The testing has
been split into regression and progression.

Regression testing:
In regression testing, we ran the whole test suite to check for
*regression on existing profiles due to the page cache changes.

No regression was found with the patches added on top.

Progression testing:
For progression testing, we tested for 8k, 16k, 32k and 64k block sizes.
To compare it with existing support, an ARM VM with 64k base page system
(without our patches) was used as a reference to check for actual failures
due to LBS support in a 4k base page size system.

There are some tests that assumes block size < page size that needs to
be fixed. I have a tree with fixes for xfstests here [6], which I will be
sending soon to the list. Already a part of this has been upstreamed to
fstest.

No new failures were found with the LBS support.

We've done some preliminary performance tests with fio on XFS on 4k block
size against pmem and NVMe with buffered IO and Direct IO on vanilla
Vs + these patches applied, and detected no regressions.

We also wrote an eBPF tool called blkalgn [7] to see if IO sent to the device
is aligned and at least filesystem block size in length.

Git tree:
https://github.com/linux-kdevops/linux/tree/large-block-minorder-6.9-rc4

[1] https://lore.kernel.org/lkml/20230915183848.1018717-1-kernel@pankajraghav.com/
[2] https://lore.kernel.org/linux-xfs/20240213093713.1753368-1-kernel@pankajraghav.com/
[3] https://www.youtube.com/watch?v=ar72r5Xf7x4
[4] https://github.com/linux-kdevops/kdevops/blob/master/docs/xfs-bugs.md
489 non-critical issues and 55 critical issues. We've determined and reported
that the 55 critical issues have all fall into 5 common  XFS asserts or hung
tasks  and 2 memory management asserts.
[5] https://lore.kernel.org/linux-xfs/fe7fec1c-3b08-430f-9c95-ea76b237acf4@samsung.com/
[6] https://github.com/linux-kdevops/fstests/tree/lbs-fixes
[7] https://github.com/iovisor/bcc/pull/4813

Changes since v3:
- Cap the PTE range to i_size for LBS configuration in folio_map_range()
- Added Chinners kvmalloc xattr patches
- Moved Hannes patches before adding the minorder patches to avoid
  confusion.
- Added mapping_set_folio_order_range().
- Return EINVAL instead EAGAIN in split_huge_page_to_list_to_order()

Changes since v2:
- Simplified the filemap and readahead changes. (Thanks willy)
- Removed DEFINE_READAHEAD_ALIGN.
- Added minorder support to readahead_expand().

Changes since v1:
- Round up to nearest min nr pages in ra_init
- Calculate index in filemap_create instead of doing in
  filemap_get_pages
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
- Added a new helper min_nrpages and added CONFIG_THP for enabling mapping_large_folio_support
- Don't split a folio if it has minorder set. Remove the old code where we set extra pins if it has that requirement.
- Split the code in XFS between the validation of mapping count. Put the icache code changes with enabling bs > ps.
- Added CONFIG_XFS_LBS option
- align the index in do_read_cache_folio()
- Removed truncate changes
- Fixed generic/091 with iomap changes to iomap_dio_zero function.
- Took care of folio truncation scenario in page_cache_ra_unbounded() that happens after read_pages if a folio was found.
- Sqaushed and moved commits around
- Rebased on top of v6.8-rc4

Dave Chinner (1):
  xfs: use kvmalloc for xattr buffers

Hannes Reinecke (1):
  readahead: rework loop in page_cache_ra_unbounded()

Luis Chamberlain (1):
  filemap: allocate mapping_min_order folios in the page cache

Matthew Wilcox (Oracle) (1):
  fs: Allow fine-grained control of folio sizes

Pankaj Raghav (7):
  readahead: allocate folios with mapping_min_order in readahead
  mm: do not split a folio if it has minimum folio order requirement
  filemap: cap PTE range to be created to i_size in folio_map_range()
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
 include/linux/pagemap.h       | 116 ++++++++++++++++++++++++++++------
 mm/filemap.c                  |  29 ++++++---
 mm/huge_memory.c              |   9 +++
 mm/readahead.c                |  94 +++++++++++++++++++++------
 12 files changed, 242 insertions(+), 70 deletions(-)


base-commit: 0bbac3facb5d6cc0171c45c9873a2dc96bea9680
-- 
2.34.1


