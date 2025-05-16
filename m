Return-Path: <linux-fsdevel+bounces-49228-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34A67AB99CB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 12:11:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2B914E75F5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 10:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51F00235075;
	Fri, 16 May 2025 10:11:24 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112FA233159;
	Fri, 16 May 2025 10:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747390284; cv=none; b=ip7F9i0heTFwra0JzzbbkpXEHupPid/4CRJPIjdQMaqtjJokn/BxjWwOgbtWPZv0DdqADt2kDk6Jo+45R4xkGJ/GhZkhIhhyExHkp5XcC5NE0wK91bBMapSB3AbcbFinET2TTLpRsm+svi5stsGNyNXYunm+HI7Hw8UJF2sjILs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747390284; c=relaxed/simple;
	bh=aaTOj7kfhFSOVIoJP8tXQ3B2wT5QtcvJnD+E2EI11lw=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=JAlY2PYXcKMEuTGJibYlbyCZVDmUVMO5oy8/kuv+TcmI8aF1xlXuPXsA3tvSTE3And4i9rz/I+812AUA1birqwO8b9r+lLkqnnDP62m6H9e5OVt83Vp9TaaJJ4ITHRUfaQMr9RXro758U8b761wXU8b6Zzpm7zw7Zus6xOiCaeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=pankajraghav.com; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4ZzNC35VRsz9stK;
	Fri, 16 May 2025 12:11:11 +0200 (CEST)
From: Pankaj Raghav <p.raghav@samsung.com>
To: "Darrick J . Wong" <djwong@kernel.org>,
	hch@lst.de,
	willy@infradead.org
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	David Hildenbrand <david@redhat.com>,
	linux-fsdevel@vger.kernel.org,
	mcgrof@kernel.org,
	gost.dev@samsung.com,
	Andrew Morton <akpm@linux-foundation.org>,
	kernel@pankajraghav.com,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: [RFC 0/3] add large zero page for zeroing out larger segments
Date: Fri, 16 May 2025 12:10:51 +0200
Message-ID: <20250516101054.676046-1-p.raghav@samsung.com>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4ZzNC35VRsz9stK

Introduce LARGE_ZERO_PAGE of size 2M as an alternative to ZERO_PAGE.
Similar to ZERO_PAGE, LARGE_ZERO_PAGE is also a global shared page.
2M seems to be a decent compromise between memory usage and performance.

This idea (but not the implementation) was suggested during the review of
adding LBS support to XFS[1][2].

NOTE:
===
This implementation probably has a lot of holes, and it is not complete.
For example, this implementation only works on x86.

The intent of the RFC is:
- To understand if this is something we still need in the kernel.
- If this is the approach we want to take to implement a feature like
  this or should we explore other alternatives.

I have excluded a lot of Maintainers/mailing list and only included relevant
folks in this RFC to understand the direction we want to take if this
feature is needed.
===

There are many places in the kernel where we need to zeroout larger
chunks but the maximum segment we can zeroout at a time is limited by
PAGE_SIZE.

This is especially annoying in block devices and filesystems where we
attach multiple ZERO_PAGEs to the bio in different bvecs. With multipage
bvec support in block layer, it is much more efficient to send out
larger zero pages as a part of a single bvec.

Some examples of places in the kernel where this could be useful:
- blkdev_issue_zero_pages()
- iomap_dio_zero()
- vmalloc.c:zero_iter()
- rxperf_process_call()
- fscrypt_zeroout_range_inline_crypt()
- bch2_checksum_update()
...

I have converted blkdev_issue_zero_pages() and iomap_dio_zero() as an
example as a part of this series.

While there are other options such as huge_zero_page, they can fail
based on the system conditions requiring a fallback to ZERO_PAGE[3].

LARGE_ZERO_PAGE is added behind a config option so that systems that are
constrained by memory are not forced to use it.

Looking forward to some feedback.

[1] https://lore.kernel.org/linux-xfs/20231027051847.GA7885@lst.de/
[2] https://lore.kernel.org/linux-xfs/ZitIK5OnR7ZNY0IG@infradead.org/

Pankaj Raghav (3):
  mm: add large zero page for efficient zeroing of larger segments
  block: use LARGE_ZERO_PAGE in __blkdev_issue_zero_pages()
  iomap: use LARGE_ZERO_PAGE in iomap_dio_zero()

 arch/Kconfig                   |  8 ++++++++
 arch/x86/include/asm/pgtable.h | 20 +++++++++++++++++++-
 arch/x86/kernel/head_64.S      |  9 ++++++++-
 block/blk-lib.c                |  4 ++--
 fs/iomap/direct-io.c           | 31 +++++++++----------------------
 5 files changed, 46 insertions(+), 26 deletions(-)


base-commit: 9e619cd4fefd19cdce16e169d5827bc64ae01aa1
-- 
2.47.2


