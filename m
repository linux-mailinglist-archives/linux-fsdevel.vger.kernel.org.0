Return-Path: <linux-fsdevel+bounces-34610-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8CE89C6BDC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 10:49:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F2301F2345C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 09:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAED21F9414;
	Wed, 13 Nov 2024 09:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="snFQ0Z5P"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4467118A951;
	Wed, 13 Nov 2024 09:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731491256; cv=none; b=L7w8tPRe81sJ1knP2PHMvGvKd8W7Obw5Qk60TumPMb92wMvzWTmqP08I57rrRhWDfgVVAVWUvcUQIzjkJZsMEV6ObA+223kNvZxZ13ybhRFpIFSMCYVjysXfpR15lAoGeCrGT3Rn+EfRDczhsXNS/H9OUH2QWVGXwsVMf+mPLg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731491256; c=relaxed/simple;
	bh=UzCj71djHnVlmhrgagbZpakgyKKeaOyqPK2azzUEczc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pp4NvZVyM+Ji/6dInbV3V4nRef2teni6oA1uw5RMOll8Uc2oig8N98Oe3LY1j4AJHyTOXNi/8ghuGJGd8dNxHi6bj2+W6nyieltpAvQnwovZLoLTK3xkcnRsq2C2PRXPjjBs5Oi7c/yKlGSV7YWlCG6ukH+LMf6z3Vh3/De68GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=snFQ0Z5P; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=NogMAPzoSN85DvPt0N/0Cgk6QQiG18HIcIcgH/liG3k=; b=snFQ0Z5PJlY9VkqMDtEFeSYgtD
	yMAPbpE4RgPcakyuL+8kKQyVKgjQ4rrp1V3uqsOWk6Nl53SQ3BZMdGLPQwiYA3iPjoR6fCmd7DaMb
	vamzErL4wJKX3d3LT5lvxfltNLq1g3j8gqFKiMbGhqsZV1s/RpohfYHIxH+luNGY7yMz0c1bs6kRe
	cpNKeilWuyF4a2Q8OQEy+FsWwCnS6M4Ld4IzUL7OEpDir3YxTWYoqW4nXJYfFTC/kwanqtuOiPgNJ
	zXhY/HPqdplSCnzxWhplwraESdUvvGzBj62+DaxWaV60NodWOsXDi7/YCaZ0XAkj1UoAlh/v+xh5N
	KLakTrOw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tB9yC-00000006Hcw-32MC;
	Wed, 13 Nov 2024 09:47:28 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
To: willy@infradead.org,
	hch@lst.de,
	hare@suse.de,
	david@fromorbit.com,
	djwong@kernel.org
Cc: john.g.garry@oracle.com,
	ritesh.list@gmail.com,
	kbusch@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-mm@kvack.org,
	linux-block@vger.kernel.org,
	gost.dev@samsung.com,
	p.raghav@samsung.com,
	da.gomez@samsung.com,
	kernel@pankajraghav.com,
	mcgrof@kernel.org
Subject: [RFC 0/8] enable bs > ps for block devices
Date: Wed, 13 Nov 2024 01:47:19 -0800
Message-ID: <20241113094727.1497722-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>

The last time this was addressed was at LFSMM this year in May [0] and
before LBS was on its way upstream. LBS is now on v6.12 and so the delta
required is much smaller now.

Before the turkey massacre slows part of the world down, here's a refresh.

Although Hannes' patches were in PATCH form, testing showed quickly that
it wasn't quite ready yet. I've only done cursory testing so far but have
also incorporated all of the fixes and feedback we could accumulate over
time. And so I'm sticking to RFC to reflect that this still needs thorough
testing. It at least does not crash for me yet and its a major rebase
onto v6.12-rc7.

The biggest changes now are these last patches:

  - block/bdev: lift block size restrictions and use common definition
  - nvme: remove superfluous block size check
  - bdev: use bdev_io_min() for statx block size

The buffer-head pathces I think should be ready.

If the consolidation of the max block size is good, perhaps we just also use it
for the iomap max zero page too. Note that in theory we should be able to get
up to a block size of 1 << (PAGE_SHIFT + MAX_PAGECACHE_ORDER), in practice
testing that shows we need much more love [1] although prospects indeed show
we should be able to get up to 2 MiB on x86_64. And so I think we should first
reduce scope up to 64k for now, test all this, and then embark on the next
64k --> 2 MiB journey next.

Thoughts?

If you want this in a tree you can get this from the kdevops branch
large-block-buffer-heads-for-next [2]

[0] https://lore.kernel.org/all/20240514173900.62207-1-hare@kernel.org/
[1] https://github.com/linux-kdevops/linux/commit/266f2c700be55bdb5626d521230597673c83c91d#diff-79b436371fdb3ddf0e7ad9bd4c9afe05160f7953438e650a77519b882904c56bL272
[2] https://github.com/linux-kdevops/linux/tree/large-block-buffer-heads-for-next

Hannes Reinecke (4):
  fs/mpage: use blocks_per_folio instead of blocks_per_page
  fs/mpage: avoid negative shift for large blocksize
  fs/buffer: restart block_read_full_folio() to avoid array overflow
  block/bdev: enable large folio support for large logical block sizes

Luis Chamberlain (4):
  fs/buffer fs/mpage: remove large folio restriction
  block/bdev: lift block size restrictions and use common definition
  nvme: remove superfluous block size check
  bdev: use bdev_io_min() for statx block size

 block/bdev.c             |  9 +++++---
 drivers/nvme/host/core.c | 10 ---------
 fs/buffer.c              | 21 ++++++++++++++----
 fs/mpage.c               | 47 +++++++++++++++++++---------------------
 fs/stat.c                |  2 +-
 include/linux/blkdev.h   |  6 ++++-
 6 files changed, 51 insertions(+), 44 deletions(-)

-- 
2.43.0


