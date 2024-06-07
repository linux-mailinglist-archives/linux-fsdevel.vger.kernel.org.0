Return-Path: <linux-fsdevel+bounces-21238-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FD489007F9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 17:01:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC50C28C348
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 15:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 421C619A2AC;
	Fri,  7 Jun 2024 14:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="NLH1n10p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28F5197521;
	Fri,  7 Jun 2024 14:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717772365; cv=none; b=SrrBPjlb58xQVYTc2j7yR2RND9FiRMFsYm+hSdP2JeP+MjUHPukTKLozrO2bdrS/fjRb1ocIoM835caATUbxHd0RHuE45nyqZOYiKK9C9wm0xhMBDZq5YvAfV/OkAvwxFUzi/43j7eq38R3Ib0X0xwHoNmXWx6DjXNvT2HRAdFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717772365; c=relaxed/simple;
	bh=h4gCbxxv+R5hXT1j0c37Tu4VJUNZwt5f6bSw3O+p4TA=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=jzt761r400J3Wh0rcB7BcZY03oWix38QM5Sd18dbAM3pXaj+r2QuxyhuEq4vApIlVXL7wb/huRV14kjFC4moSbFAEIhM3BZbJDOivxjwZ3BxHA49bIX94s/ESuzaoLC7Xba2q0EAwYXMg2W/qNzje8YFBhLd+bIlCdVTSOSGjs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=NLH1n10p; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4Vwkqh4dS1z9sSR;
	Fri,  7 Jun 2024 16:59:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1717772352;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=L5/K/voROGxiCi8/nrKyR1+yqBSs4rSx+7KJpqqgfCw=;
	b=NLH1n10pMvMbTG2IkpAspVJoe3J9POQgeAzS4s4nfxIUCuyJ5o4BEwTlLep/h/I3ARa2ox
	GMbzxhV684OGNRSRTG6Hb4G7lZ7IUZIzmRlQToB/BVeTHqjQwX3sKFDBhqBvAY0NffdnWH
	ejgS8ytScZGwMMyj3KmaK36P77dlBj3LzkrOeX1cvH1rKOE45q+VBSCl3blefjcXO2P3aw
	iVvoWJ7LhfqQ3PsLSN9nGbUYmb0kgGCv3QAWCgV0SlmH2WqKi3tRxxDJfGr9O5ivJ4zN4+
	snrxILtMTSaqo8h2XwLhr8yX9SJ/K5i28W2B+TVuBffuO9IcurgEUCXNhmkqmQ==
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: david@fromorbit.com,
	djwong@kernel.org,
	chandan.babu@oracle.com,
	brauner@kernel.org,
	akpm@linux-foundation.org,
	willy@infradead.org
Cc: mcgrof@kernel.org,
	linux-mm@kvack.org,
	hare@suse.de,
	linux-kernel@vger.kernel.org,
	yang@os.amperecomputing.com,
	Zi Yan <zi.yan@sent.com>,
	linux-xfs@vger.kernel.org,
	p.raghav@samsung.com,
	linux-fsdevel@vger.kernel.org,
	kernel@pankajraghav.com,
	hch@lst.de,
	gost.dev@samsung.com,
	cl@os.amperecomputing.com,
	john.g.garry@oracle.com
Subject: [PATCH v7 00/11] enable bs > ps in XFS
Date: Fri,  7 Jun 2024 14:58:51 +0000
Message-ID: <20240607145902.1137853-1-kernel@pankajraghav.com>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pankaj Raghav <p.raghav@samsung.com>

This is the seventh version of the series that enables block size > page size
(Large Block Size) in XFS targetted for inclusion in 6.11.
The context and motivation can be seen in cover letter of the RFC v1 [0].
We also recorded a talk about this effort at LPC [1], if someone would
like more context on this effort.

The major change on this v6 we retry getting a folio and we enable
warning if we failed to get a folio in __filemap_get_folio if the
order <= min_order (Patch 3)[7].

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
large-block-minorder-for-next-v7 tag [6].

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

Changes since v6:
- Warn users if we can't get a min order folio in __filemap_get_folio().
- Added iomap_dio_init() function and moved zero buffer init into that.
- Modified split_huge_pages_pid() to also consider non-anonymous memory
  and removed condition for anonymous memory in split_huge_pages_file().
- Collected RVB from Hannes.

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

 fs/internal.h                 |   5 ++
 fs/iomap/buffered-io.c        |   6 ++
 fs/iomap/direct-io.c          |  26 ++++++++-
 fs/xfs/libxfs/xfs_attr_leaf.c |  15 ++---
 fs/xfs/libxfs/xfs_ialloc.c    |   5 ++
 fs/xfs/libxfs/xfs_shared.h    |   3 +
 fs/xfs/xfs_icache.c           |   6 +-
 fs/xfs/xfs_iops.c             |   2 +-
 fs/xfs/xfs_mount.c            |  11 +++-
 fs/xfs/xfs_super.c            |  18 +++---
 include/linux/huge_mm.h       |  14 +++--
 include/linux/pagemap.h       | 106 +++++++++++++++++++++++++++++-----
 mm/filemap.c                  |  38 +++++++-----
 mm/huge_memory.c              |  55 ++++++++++++++++--
 mm/readahead.c                |  98 ++++++++++++++++++++++++-------
 15 files changed, 330 insertions(+), 78 deletions(-)


base-commit: d97496ca23a2d4ee80b7302849404859d9058bcd
-- 
2.44.1


