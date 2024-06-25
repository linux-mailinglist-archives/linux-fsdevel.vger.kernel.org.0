Return-Path: <linux-fsdevel+bounces-22324-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D300591666B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 13:44:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CD68288032
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 11:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE64B14C58A;
	Tue, 25 Jun 2024 11:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="kySvDD/n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4931494A0;
	Tue, 25 Jun 2024 11:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719315877; cv=none; b=a5fcAc1nwlLUqnDZUohZ8AMC7v/8wqEMDnH29uOHkHZK+dIBK4Bwzni2pqwP06crRnutLo9nLAUW5Ko8VLzpuHP0QOd4BuINHaMYKG/7Qn/QBGH8cju0MVLwR7Osm4YfGgMgE2MqX3sfHR3V6PfArASjx/i0ck+lbs8nPi/JsWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719315877; c=relaxed/simple;
	bh=eeVUGRc/d2AhjYvp2iaZcYGrK1l23XGEMp6ntMJF5uQ=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Djm7tVed9faKIuXL83PRLCglU4sV/Q98yQgs4TEtCaJOmwFqLEv4HFCBJZjCYG/h6XuI5zJrc3Styq5gK5K6uXFK7FTOEZK3WdkcGDK2re1Q4nYWY/ndVLD34exzgPXXziBTYDr+wpJLfZ1FqRF3Orc1sWh+Y99nPuaa3wSorck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=kySvDD/n; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4W7jfd2YL4z9sWC;
	Tue, 25 Jun 2024 13:44:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1719315865;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=MKFoJ3j4KB+I/qDQQrYOSbOqrOpG0UvaNnSzD6LfMBw=;
	b=kySvDD/nXc/Hs9+I7BRh+UVlcdHThmgtpTwEvLXk5xkZmwR4voWwC7i/AoHPW7N8Qyz76C
	w/GloDHjcxSc80CoscheghvDuGACxOpuxG/giKR9ACXpRnHGkylrWsiVSCwDZsSCRpdvmI
	+HdzdxyF7SQ/6egiwEy9WGIinvnY9yQKWDNZgBZHRNaVOBXZIC5ysurjSeD//gFYn1/HUR
	WL+KpqBXAPZZ341CRvrnc3LAanWaineXW4jOE2aSDS9lCg1X9zVJtGSx5gS3Kf7WLqxwp/
	Ey7ZR4VtDu61rjCQoGAUvMA+FYVWvc+bIE33AhIc9nd4QbLaSUBGRzzvYCOBIQ==
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: david@fromorbit.com,
	willy@infradead.org,
	chandan.babu@oracle.com,
	djwong@kernel.org,
	brauner@kernel.org,
	akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	yang@os.amperecomputing.com,
	linux-mm@kvack.org,
	john.g.garry@oracle.com,
	linux-fsdevel@vger.kernel.org,
	hare@suse.de,
	p.raghav@samsung.com,
	mcgrof@kernel.org,
	gost.dev@samsung.com,
	cl@os.amperecomputing.com,
	linux-xfs@vger.kernel.org,
	kernel@pankajraghav.com,
	hch@lst.de,
	Zi Yan <zi.yan@sent.com>
Subject: [PATCH v8 00/10] enable bs > ps in XFS
Date: Tue, 25 Jun 2024 11:44:10 +0000
Message-ID: <20240625114420.719014-1-kernel@pankajraghav.com>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pankaj Raghav <p.raghav@samsung.com>

This is the eight version of the series that enables block size > page size
(Large Block Size) in XFS.
The context and motivation can be seen in cover letter of the RFC v1 [0].
We also recorded a talk about this effort at LPC [1], if someone would
like more context on this effort.

A lot of emphasis has been put on testing using kdevops, starting with an XFS
baseline [3]. The testing has been split into regression and progression.

Regression testing:
In regression testing, we ran the whole test suite to check for regressions on
existing profiles due to the page cache changes.

I also ran split_huge_page_test selftest on XFS filesystem to check for
huge page splits in min order chunks is done correctly.

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
large-block-minorder-for-next-v8 tag [6].

[0] https://lore.kernel.org/lkml/20230915183848.1018717-1-kernel@pankajraghav.com/
[1] https://www.youtube.com/watch?v=ar72r5Xf7x4
[2] https://lkml.kernel.org/r/20240501153120.4094530-1-willy@infradead.org
[3] https://github.com/linux-kdevops/kdevops/blob/master/docs/xfs-bugs.md
489 non-critical issues and 55 critical issues. We've determined and reported
that the 55 critical issues have all fall into 5 common  XFS asserts or hung
tasks  and 2 memory management asserts.
[4] https://github.com/linux-kdevops/fstests/tree/lbs-fixes
[5] https://github.com/iovisor/bcc/pull/4813
[6] https://github.com/linux-kdevops/linux/
[7] https://lore.kernel.org/linux-kernel/Zl20pc-YlIWCSy6Z@casper.infradead.org/#t

Changes since v7:
- Move by min_nrpages in page_cache_ra_unbounded if we found a folio as
  we don't have a stable reference.
- Rename iomap_init to iomap_pagecache_init and add a new iomap_dio_init
  and mark the zero_fs_64k memory as RO.
- Simplified calculation in xfs_sb_validate_fsb_count().
- Collected RVB from willy, Darrick and Hannes.

Dave Chinner (1):
  xfs: use kvmalloc for xattr buffers

Luis Chamberlain (1):
  mm: split a folio in minimum folio order chunks

Matthew Wilcox (Oracle) (1):
  fs: Allow fine-grained control of folio sizes

Pankaj Raghav (7):
  filemap: allocate mapping_min_order folios in the page cache
  readahead: allocate folios with mapping_min_order in readahead
  filemap: cap PTE range to be created to allowed zero fill in
    folio_map_range()
  iomap: fix iomap_dio_zero() for fs bs > system page size
  xfs: expose block size in stat
  xfs: make the calculation generic in xfs_sb_validate_fsb_count()
  xfs: enable block size larger than page size support

 fs/iomap/buffered-io.c        |   4 +-
 fs/iomap/direct-io.c          |  30 +++++++++-
 fs/xfs/libxfs/xfs_attr_leaf.c |  15 ++---
 fs/xfs/libxfs/xfs_ialloc.c    |   5 ++
 fs/xfs/libxfs/xfs_shared.h    |   3 +
 fs/xfs/xfs_icache.c           |   6 +-
 fs/xfs/xfs_iops.c             |   2 +-
 fs/xfs/xfs_mount.c            |   8 ++-
 fs/xfs/xfs_super.c            |  18 +++---
 include/linux/huge_mm.h       |  14 +++--
 include/linux/pagemap.h       | 109 +++++++++++++++++++++++++++++-----
 mm/filemap.c                  |  36 +++++++----
 mm/huge_memory.c              |  55 +++++++++++++++--
 mm/readahead.c                |  85 +++++++++++++++++++-------
 14 files changed, 309 insertions(+), 81 deletions(-)


base-commit: b992b79ca8bc336fa8e2c80990b5af80ed8f36fd
-- 
2.44.1


