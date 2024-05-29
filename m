Return-Path: <linux-fsdevel+bounces-20436-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58C668D3830
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 15:45:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1370628A43A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 13:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B3BF1C696;
	Wed, 29 May 2024 13:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="URxxrAHb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA63118E28;
	Wed, 29 May 2024 13:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716990328; cv=none; b=Cm5sOzgH8V/cSEBOIuoEI0Fq6YlWADbMFhtdSfajo82UgH+iXeGItj8WO9qZIYYVeIVAhhz6y5S0to99FoDSWCvJjMeRYm7+it3Ht/CS8EH9BIl9yzRacwKhRfjllHX8WUco9WIBXOATJpr7r/0GP8toc8OWPuVexFeW/Y8iqRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716990328; c=relaxed/simple;
	bh=qDPA76C94+7SAXO5Z0jQtl12RhGURITQlHH65KdkrEM=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=S3ePmQi4THLxOiN+FO9bdxnxeno/66YM/gXh8hK7Z9nLLfZ3hlKtPPmyORAz392QX5CfpMS/nHV8DwnyheZWGtzoiblUJbxVOvBhGXeUTlsCsNUulI9hWO3PYRGBSv36vWRW9EIUWsE4ymyzlwuY6oUBJWdnrXZklqzayRP3cnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=URxxrAHb; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4Vq9cX0plSz9spB;
	Wed, 29 May 2024 15:45:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1716990316;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+CJoGU0OwssHcj7466vH7ZJISfAqim3uobE0dzZLFqI=;
	b=URxxrAHbK+/p2h+K4uaSAa1Uel9A1y92pLPI4nZESePEzLjRneSW01JkMsg7N09YwyD/Di
	2msruoE9ebJwN8KYpbII89pkMljKDk2gUB0r4QYST4dqJce1pXZdg0Lfk1krFHIiQygjPn
	KY8qJ3hpw8hAEZuC7VV7wq6va5Gc2tAuuyAY5gZJAn367RnR3Y/pbUOCnHwNPOiLRW+4jh
	cN5orbhS/cs5s/4Tansf+E2M51/fz7CvAvVgV7IwHdhfLj1MR4CzK6ReJ+2rFY7PDkTj56
	zaPeHS/lKryvSjppaogY6pEIVPt2iJJPtoIl+eNhNKAHzHLLgqYb3qG2ip0e+A==
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: david@fromorbit.com,
	chandan.babu@oracle.com,
	akpm@linux-foundation.org,
	brauner@kernel.org,
	willy@infradead.org,
	djwong@kernel.org
Cc: linux-kernel@vger.kernel.org,
	hare@suse.de,
	john.g.garry@oracle.com,
	gost.dev@samsung.com,
	yang@os.amperecomputing.com,
	p.raghav@samsung.com,
	cl@os.amperecomputing.com,
	linux-xfs@vger.kernel.org,
	hch@lst.de,
	mcgrof@kernel.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v6 00/11] enable bs > ps in XFS
Date: Wed, 29 May 2024 15:44:58 +0200
Message-Id: <20240529134509.120826-1-kernel@pankajraghav.com>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pankaj Raghav <p.raghav@samsung.com>

This is the sixth version of the series that enables block size > page size
(Large Block Size) in XFS targetted for inclusion in 6.11. 
The context and motivation can be seen in cover letter of the RFC v1 [0].
We also recorded a talk about this effort at LPC [1], if someone would 
like more context on this effort.

The major change on this v6 is max order is respected by the page cache
and iomap direct IO zeroing will be using 64k buffer instead of looping
through ZERO_PAGE.

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
[6] https://github.com/linux-kdevops/linux/tree/large-block-minorder-next-20240528

Changes since v6:
- Max order is resptected by the page cache
- No LBS support for V4 format in XFS
- Use a 64k zeroed buffer for iomap direct io zeroing

Dave Chinner (1):
  xfs: use kvmalloc for xattr buffers

Hannes Reinecke (1):
  readahead: rework loop in page_cache_ra_unbounded()

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

 fs/internal.h                 |   8 +++
 fs/iomap/buffered-io.c        |   5 ++
 fs/iomap/direct-io.c          |   9 ++-
 fs/xfs/libxfs/xfs_attr_leaf.c |  15 ++---
 fs/xfs/libxfs/xfs_ialloc.c    |   5 ++
 fs/xfs/libxfs/xfs_shared.h    |   3 +
 fs/xfs/xfs_icache.c           |   6 +-
 fs/xfs/xfs_iops.c             |   2 +-
 fs/xfs/xfs_mount.c            |  11 +++-
 fs/xfs/xfs_super.c            |  18 +++---
 include/linux/huge_mm.h       |  14 +++--
 include/linux/pagemap.h       | 106 +++++++++++++++++++++++++++++-----
 mm/filemap.c                  |  36 ++++++++----
 mm/huge_memory.c              |  50 +++++++++++++++-
 mm/readahead.c                |  98 ++++++++++++++++++++++++-------
 15 files changed, 310 insertions(+), 76 deletions(-)


base-commit: 6dc544b66971c7f9909ff038b62149105272d26a
-- 
2.34.1


