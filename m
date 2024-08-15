Return-Path: <linux-fsdevel+bounces-26030-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8228A952BD1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2024 12:20:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5CAA1C21727
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2024 10:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 928ED17A5BE;
	Thu, 15 Aug 2024 09:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="mPuTEpVE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BAE51BDA9B;
	Thu, 15 Aug 2024 09:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723712952; cv=none; b=eWnSCOc8WObjO5/vpGD/hsVChoqBvhSvTD+jFEfRCR3kaOpyHVBudsIq9rbHg+4kQ0BFQ+/juztAtmmjxLUG7wM801btyJffr3s5zmLv9SHt19Z9MedkFQcvpn5tZOGbHTt2fbjW+3NDcxiYJ8UeuJ6aFv7hs6nvrAVBIEgjSRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723712952; c=relaxed/simple;
	bh=Mul9z/t+NyoNQ3hyA3e/slqUNLppNdHFTAPCHrnHaJk=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=U7ZVisms2FJW2h71OhCYNIx7a8LqUPPqpwDRJWNdDzS58R89r4No8ANnOFay3vVV05NzGsUMvExpHH9Ss8J7naMQFC46yIoXq39S0AJmeaNudHYK55/KqI5LefXbGquP1Sx90sz9+Mw4hYzx/sPZl6je8Z2euttw5JwZGoBS+oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=mPuTEpVE; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4Wkznm5LLSz9sJ5;
	Thu, 15 Aug 2024 11:09:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1723712940;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+pM9gcDQmpAu1KxMlZEMUf7H6tquKP9eEhjTE70iaUU=;
	b=mPuTEpVEiW9viw+9S7YRAuaTuZi81Ek1hDkFclq8xZ8Vnc2faQ0T2S599plk5MbXOg+cCP
	rRVuMgWfSf4Dyn1Phho2qeCuFYrUFULTo8Bf1weXLzO9UPUNCbLAqnHmI0KjhRikP6DLBC
	28HlqkQa+YhNTCh0f1H/pbNWBuyGA0+43bT6ETGSialO+qxEFM0R0Tmxtp8yzO1vGLGgnO
	iK1nY7CT7HW1TueKrpU2n0P+ghvd6oKLpAiPZC4k5Kk26QJar94FyekIQFlHMKmKHQLI6y
	Dr0bhrwgcPTjnqros6n6iPmI3JR3U8Az1t2WU4tx6daOQe2BdOuRolZR7ei10w==
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
Subject: [PATCH v12 00/10] enable bs > ps in XFS
Date: Thu, 15 Aug 2024 11:08:39 +0200
Message-ID: <20240815090849.972355-1-kernel@pankajraghav.com>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4Wkznm5LLSz9sJ5

From: Pankaj Raghav <p.raghav@samsung.com>

This is the 12th version of the series that enables block size > page size
(Large Block Size) experimental support in XFS. Please consider this for
the inclusion in 6.12.
The series is based on fs-next as I was not able to run tests on
the latest linux-next.

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

No new failures were found with the LBS support.

We've done some preliminary performance tests with fio on XFS on 4k block size
against pmem and NVMe with buffered IO and Direct IO on vanilla Vs + these
patches applied, and detected no regressions.

We ran sysbench on postgres and mysql for several hours on LBS XFS
without any issues.

We also wrote an eBPF tool called blkalgn [5] to see if IO sent to the device
is aligned and at least filesystem block size in length.

For those who want this in a git tree we have this up on a kdevops
large-block-minorder-for-next-v12 tag [6].

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

Changes since v11:
- Minor string alignment fixup.
- Collected RVB from Dave.

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
 include/linux/pagemap.h       | 122 ++++++++++++++++++++++++++++++----
 mm/filemap.c                  |  36 ++++++----
 mm/huge_memory.c              |  59 ++++++++++++++--
 mm/readahead.c                |  83 +++++++++++++++++------
 14 files changed, 345 insertions(+), 85 deletions(-)


base-commit: bb62fbd2b0e31b2ed5dccf1dc4489460137fdf5c
-- 
2.44.1


