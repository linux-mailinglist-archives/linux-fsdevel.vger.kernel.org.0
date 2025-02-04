Return-Path: <linux-fsdevel+bounces-40856-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29874A27F62
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 00:13:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB6C91887DAD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 23:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0046321C9EC;
	Tue,  4 Feb 2025 23:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rijrXj+y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B646F21C19F;
	Tue,  4 Feb 2025 23:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738710737; cv=none; b=bjjGUSnJJz0IO7Zt38iPCAviG4ifKhGFHL3N9W6rlg8MyX2rW/WaK7gjmugRsyyFpz16DsSDd5TWvGvhCktHvr8noHxdDoNOtrfueK9C4E9fVxTJMaKgtoIAR+EtTXRarPYV1Z83qi8zF5kYT1fsIqHnVRGaRp3E5HjVQKzLa10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738710737; c=relaxed/simple;
	bh=fhhKGl6JPTwaTU9BuRnwZE+PIEHWTvw++wt/aZK++ik=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QJwMz2pDopHonXgF2uvdWuI8SG2aI1M6Zrk+Mp/Z3dg1aIQCObxiS8Ya6P+4c0ud3fy5wifiiRRQOtzS33l/SSlY71+tD8zk5b36oO3keQ6WMPIrLkeOAoLU1WcEfJotET5CDBkxFW4kcKvptuH0bORwXJN8w0jo50C3dyP2lLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rijrXj+y; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=kWF3U2LkOxTN8T3vmFQjS9eJjcQiGfH8Tr90xVOXrSQ=; b=rijrXj+yJ+nz0RrF14z8QejonG
	FcZPUXqnRhOO/8Yc+wXkDRt55ZCULLTT96RwOVqheHS2h40N0Me6/L5+Ca0MGifYuCdUWcCAtb52K
	IF+jWLscCxlkNQV6+0N8I4Gwdpsu+uQFcIFwsdHP1uwf1oTLoSy0bPXqGmcmxLp3kwsIWDfNySFlu
	suQWP4HgutVMmg4anHWTlM8HblHs+CogEX50QOsPXnoVO777kbKZ4MmMap2lLqSuSv8dBEby5kzeN
	/qrcA5FFtDeAz+vJoI8bkA/EUtVABdcNHRWMShHSwmBPEcWIuqR2nQLpBZ8exqNvol9iv7magNTwu
	Clebuseg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tfS5T-00000001nhK-0tRb;
	Tue, 04 Feb 2025 23:12:11 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
To: hare@suse.de,
	willy@infradead.org,
	dave@stgolabs.net,
	david@fromorbit.com,
	djwong@kernel.org,
	kbusch@kernel.org
Cc: john.g.garry@oracle.com,
	hch@lst.de,
	ritesh.list@gmail.com,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-mm@kvack.org,
	linux-block@vger.kernel.org,
	gost.dev@samsung.com,
	p.raghav@samsung.com,
	da.gomez@samsung.com,
	kernel@pankajraghav.com,
	mcgrof@kernel.org
Subject: [PATCH v2 0/8] enable bs > ps for block devices
Date: Tue,  4 Feb 2025 15:12:01 -0800
Message-ID: <20250204231209.429356-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>

This v2 addresses feedback from the first RFC on enabling bs > ps for
block devices [0] after which I split the async read buffer-head work
into its own series [1]. This unifies the series now that this the
buffer-head work is greatly simplified, and generalizing a block size
check is now merged upstream on v6.14-rc1.

Changes in this series:

 - Simplify block_read_full_folio() with bh_offset() and moves this
   as a first patch
 - Re-orders the negative shift patch to go first as otherwise
   the blocks_per_folio changes don't make any sense
 - Simplifies the amount of changes in the patch
   "enable large folio support for large logical block sizes" as most
   of the required changes are now upstream
 - Drops the NVMe patch as its no longer needed
 - Keeps the nrpages to 1 for readahead for folio for buffer-heads
   as suggested by Matthew
 - Takes the suggested approach by Matthew Wilcox on async read by
   replacing the batched read with a straight forward iteration
 - Tons of cosmetic updates as requested by folks
 - Rebases on top of v6.14-rc1
 - Tested with both fstests on ext4 and blktests using the latest
   changes posted to support bs > ps for block devices just now [2]
 - Updates the rationale for why we use 64k as the current limit:
   test and validation

If you want this on a tree, this is available on the kdevops linux
large-block-buffer-heads-for-next branch [3].

[0] https://lkml.kernel.org/r/20241113094727.1497722-1-mcgrof@kernel.org
[1] https://lkml.kernel.org/r/20241218022626.3668119-1-mcgrof@kernel.org
[2] https://lkml.kernel.org/r/20250204225729.422949-1-mcgrof@kernel.org
[3] https://github.com/linux-kdevops/linux/tree/large-block-buffer-heads-for-next

Hannes Reinecke (3):
  fs/mpage: avoid negative shift for large blocksize
  fs/mpage: use blocks_per_folio instead of blocks_per_page
  block/bdev: enable large folio support for large logical block sizes

Luis Chamberlain (4):
  fs/buffer: simplify block_read_full_folio() with bh_offset()
  fs/buffer fs/mpage: remove large folio restriction
  block/bdev: lift block size restrictions to 64k
  bdev: use bdev_io_min() for statx block size

Matthew Wilcox (1):
  fs/buffer: remove batching from async read

 block/bdev.c           | 11 ++++----
 fs/buffer.c            | 58 +++++++++++++++++-------------------------
 fs/mpage.c             | 45 +++++++++++++++-----------------
 include/linux/blkdev.h |  9 ++++++-
 4 files changed, 58 insertions(+), 65 deletions(-)

-- 
2.45.2


