Return-Path: <linux-fsdevel+bounces-26738-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4805995B7CB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 15:59:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62CEE1C23E15
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 13:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4EE11CC89C;
	Thu, 22 Aug 2024 13:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="Csyw9loc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325DC1CC892;
	Thu, 22 Aug 2024 13:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724334982; cv=none; b=CLwWIy6PWA2TuhgFgOaEVZsov0FBthQBeUB7FURjpLKj3OJP64rIBYPSIvCLV8ZlVu2OtwPcBlEMHFh7WVlrkACsPLn6nx8Mir6u57FV502apixQps3hTs/pOmfAl+8UnvffCJbcKq4qAgq9olVLy/kqqR2Bz8cyzFHaL+myBV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724334982; c=relaxed/simple;
	bh=eiTLr+kGOaPfZuXR78HsGTHQ0hqu8uBD3fLLCW65UBA=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=KaPPXvSjqFWzP2uvcVnasB5OFQ3bMa7jrhepi5i7sLqbK0DysjQuQplb92SV8tv74eLUxAD6iiTzTBu4bGEBDuaeRKR95lgRe8vG+YNIhoiQpkHwctgxYoz9+tl1ZNWppoYZoRKZjE/C/yqjdywGUh+HSaS/s57/hAaFrXehcsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=Csyw9loc; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4WqPjM3plkz9sZS;
	Thu, 22 Aug 2024 15:50:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1724334631;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7pRMKX2rOPE9Dpzaf39cm+nvGAfhyyeS/+UDEWMvToI=;
	b=Csyw9locQT7xz4yaIBnXECXhUPSNMWknIij06oRMHOESEGG5Dh5nFug0EI3DHMUcij2SWK
	pmM91iH0Z38wJR/gYdmTPX6KC8FxHPNmh4AkzwRbe9jqCtzygsaA0iFOKoeueQ1r1hxt/2
	TTBLM6d0NjSjAyRyynp1xniDeVMMrLgz/k5SCFqsocaEBIcfkD7iqVA7v6j2bljwF0TWNf
	BfTaxBZEQo0k76TJAv8qJ4oyYCqBMt6jfzabcSOOKl1Al5h5LSDAMPjHBLUliRiKcU04TM
	ZQLRTaNl0ryfhhVZprYrfmZS3Hsxd1MLBuWEWhTsgBxwmlGrwqEdtWfSXGpdag==
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: brauner@kernel.org,
	akpm@linux-foundation.org
Cc: chandan.babu@oracle.com,
	linux-fsdevel@vger.kernel.org,
	djwong@kernel.org,
	hare@suse.de,
	gost.dev@samsung.com,
	linux-xfs@vger.kernel.org,
	kernel@pankajraghav.com,
	hch@lst.de,
	david@fromorbit.com,
	Zi Yan <ziy@nvidia.com>,
	yang@os.amperecomputing.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	willy@infradead.org,
	john.g.garry@oracle.com,
	cl@os.amperecomputing.com,
	p.raghav@samsung.com,
	mcgrof@kernel.org,
	ryan.roberts@arm.com
Subject: [PATCH v13 00/10] enable bs > ps in XFS
Date: Thu, 22 Aug 2024 15:50:08 +0200
Message-ID: <20240822135018.1931258-1-kernel@pankajraghav.com>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4WqPjM3plkz9sZS

From: Pankaj Raghav <p.raghav@samsung.com>

This is the 13th version of the series that enables block size > page size
(Large Block Size) experimental support in XFS. Please consider this for
the inclusion in 6.12.

The context and motivation can be seen in cover letter of the RFC v1 [0].
We also recorded a talk about this effort at LPC [1], if someone would
like more context on this effort.

Thanks to David Howells, the page cache changes have also been tested on
top of AFS[2] with mapping_min_order set.

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

No new failures were found with the LBS support.

We've done some preliminary performance tests with fio on XFS on 4k block size
against pmem and NVMe with buffered IO and Direct IO on vanilla Vs + these
patches applied, and detected no regressions.

We ran sysbench on postgres and mysql for several hours on LBS XFS
without any issues.

We also wrote an eBPF tool called blkalgn [5] to see if IO sent to the device
is aligned and at least filesystem block size in length.

For those who want this in a git tree we have this up on a kdevops
large-block-minorder-for-next-v13 tag [6].

[0] https://lore.kernel.org/lkml/20230915183848.1018717-1-kernel@pankajraghav.com/
[1] https://www.youtube.com/watch?v=ar72r5Xf7x4
[2] https://lore.kernel.org/linux-mm/3792765.1724196264@warthog.procyon.org.uk/
[3] https://github.com/linux-kdevops/kdevops/blob/master/docs/xfs-bugs.md
489 non-critical issues and 55 critical issues. We've determined and reported
that the 55 critical issues have all fall into 5 common  XFS asserts or hung
tasks  and 2 memory management asserts.
[4] https://github.com/linux-kdevops/fstests/tree/lbs-fixes
[5] https://github.com/iovisor/bcc/pull/4813
[6] https://github.com/linux-kdevops/linux/
[7] https://lore.kernel.org/linux-kernel/Zl20pc-YlIWCSy6Z@casper.infradead.org/#t

Changes since v12:
- Fixed the issue of masking the wrong bits in PATCH 1.
- Collected Tested-by from David Howells.

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
 fs/iomap/direct-io.c          |  45 +++++++++++--
 fs/xfs/libxfs/xfs_attr_leaf.c |  15 ++---
 fs/xfs/libxfs/xfs_ialloc.c    |   5 ++
 fs/xfs/libxfs/xfs_shared.h    |   3 +
 fs/xfs/xfs_icache.c           |   6 +-
 fs/xfs/xfs_iops.c             |   2 +-
 fs/xfs/xfs_mount.c            |   8 ++-
 fs/xfs/xfs_super.c            |  28 +++++---
 include/linux/huge_mm.h       |  14 ++--
 include/linux/pagemap.h       | 123 ++++++++++++++++++++++++++++++----
 mm/filemap.c                  |  36 ++++++----
 mm/huge_memory.c              |  60 +++++++++++++++--
 mm/readahead.c                |  83 +++++++++++++++++------
 14 files changed, 347 insertions(+), 85 deletions(-)


base-commit: eb8c5ca373cbb018a84eb4db25c863302c9b6314
-- 
2.44.1


