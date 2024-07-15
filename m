Return-Path: <linux-fsdevel+bounces-23668-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60C98931183
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jul 2024 11:45:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13908281078
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jul 2024 09:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A96518732F;
	Mon, 15 Jul 2024 09:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="dLRvtHhe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946A7335C0;
	Mon, 15 Jul 2024 09:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721036719; cv=none; b=NYIppNkBc3M319agk2/jxlwHwyiyNV1AMkVQBiSFIKlqnVJpgMPOMwkxVugpdJ6JP5FdmdUUl/qvqlz++HOu5z+wnGpSRtuWdVvAymZL0uT2a0brZa9jsGGMrvTiGpfNDqFDpJbS/5wNuxly4W8w706awjoYAfXfYVjstDZdyb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721036719; c=relaxed/simple;
	bh=aZjdIQKwdp5H79qgehJQbRr3CRk8J+dnXqZ9303YyRo=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=qKlTa4iXcpe3jhQZc/uH6EsuDILMsN0tda/+/BM2a6e1mqBcXh+baGifsmsoVJ7+rNEgmAhqIXNF5S2osBgF9PjWG8egjcoBt5T6LDFP93gMozEUGOrftVoKHu5DOnaVLog7pbf6vHfoyytDiaN0Ym3l9QQRp4b8mWXN0SHQYSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=dLRvtHhe; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4WMy3m2r4qz9sZh;
	Mon, 15 Jul 2024 11:45:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1721036708;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=pnDOdJKQ2qCiJS1B5N8ch6auI8mL5/MTLJL29eG+61g=;
	b=dLRvtHhePFRpWc7HgyCwU2mg39Q97xo2kIH6p36nZCuSFTKc7ere3aFnjxxddOHtgXUOm8
	rD/UjzIT2KDk5lDaIqpdhuLkJshHpFWC3yXKsWE3L8Uq/ta0AnVNNCo3Srp2qCKGp7SaJR
	35Uz/JDwE8fEeD2Bv+H+omttN3Hsz7vBsQSvtUOHtfCbXX2L0Kwq6SemZiVX5m122Rg3Mb
	1sZWryKUj1GlLgeW6JL9YQbZ8f9uzSUNrw9SUPuXuwDNCkyD+6t9+Skp5gsgToUUnWH6u1
	gTEluWFSBo6cP9pUm3e+/BfQPdfgcSl7t6CAHbhkIHqcTEr8+N2W/YhW/K7Jgw==
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
	ryan.roberts@arm.com,
	hch@lst.de,
	Zi Yan <ziy@nvidia.com>
Subject: [PATCH v10 00/10] enable bs > ps in XFS
Date: Mon, 15 Jul 2024 11:44:47 +0200
Message-ID: <20240715094457.452836-1-kernel@pankajraghav.com>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pankaj Raghav <p.raghav@samsung.com>

This is the tenth version of the series that enables block size > page size
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
large-block-minorder-for-next-v10 tag [6].

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

Changes since v9:
- Added a mapping_max_folio_size_supported() that filesystems can call
  at mount time to check for mapping folio requirement.
- Changed split_folio_to_list() to call THP_SPLIT_PAGE_FAILED for
  pmd folios.
- Formatting changes in the first patch
- Collected RVB from Hannes, Zi yan, Darrick and Dave.

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
 fs/iomap/direct-io.c          |  45 ++++++++++--
 fs/xfs/libxfs/xfs_attr_leaf.c |  15 ++--
 fs/xfs/libxfs/xfs_ialloc.c    |   5 ++
 fs/xfs/libxfs/xfs_shared.h    |   3 +
 fs/xfs/xfs_icache.c           |   6 +-
 fs/xfs/xfs_iops.c             |   2 +-
 fs/xfs/xfs_mount.c            |   8 ++-
 fs/xfs/xfs_super.c            |  30 +++++---
 include/linux/huge_mm.h       |  14 ++--
 include/linux/pagemap.h       | 127 ++++++++++++++++++++++++++++++----
 mm/filemap.c                  |  36 ++++++----
 mm/huge_memory.c              |  59 ++++++++++++++--
 mm/readahead.c                |  83 ++++++++++++++++------
 14 files changed, 353 insertions(+), 84 deletions(-)


base-commit: 0b58e108042b0ed28a71cd7edf5175999955b233
-- 
2.44.1


