Return-Path: <linux-fsdevel+bounces-42318-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D04CDA402DA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 23:39:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3EC63B68C3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 22:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CE0B2566C7;
	Fri, 21 Feb 2025 22:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="I+efmKN9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03C0205510;
	Fri, 21 Feb 2025 22:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740177512; cv=none; b=aas2LEGcSZg70lY8QMWmr0ofKukUvw+HOeAiLU5nHYupj4KJRWARL/Yhe7wLldxbMw+ISQrQVC0ldzUWBMSuf620KNi2e345R4B2DjrGSp+RMjJmrug+i/db+iRJdbZovVefaN0Y+oPrXVmGWB1uOnkjdpc0B/WZsg7j/QwhBkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740177512; c=relaxed/simple;
	bh=SzJwHUlL6vPv0BoUlO8UoQfRW+eugmww/taSYEPPiTw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XSIJjiejCin1UwZnRhm/mmpyevV6QceIcCXATntxgLiOk6bg9gzHgsJbSR0tw58FChJ0oR+i4Jn79X2JOrIxs5dCmnSXkKeDcqQQBQ2a9vvHFSys0H2flmmhQNN4YHzKr2sTzNfuslA5rQ57gyzPnpK2VysIHZ3K9JHuXMMRYHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=I+efmKN9; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=4Yzv/nSyDkCuldaOJn0MRJPjn/HMn3cvqTHPYuyv38A=; b=I+efmKN9OQCcGMEyHthsbQDodd
	lZLSZKT0tO4FzvqHV1I37zMGOjMWCHzKDjPZKtDkbfMvFiEQ5BXu26z5VPoAbZ3f0O9uA8BgPmRiN
	8pAEucPSBRrj/WzfrQ91Fj029tRUwPtVDPLNrw3DSKQHp5JF1VJ+Hgk5BaXy/38+dd+NFW9U8NZ74
	BucdYgHzeJUhzBg2bgFskls3/ch0wtkGZBnTcLr3Ry065+jZE2GGN5gvu8dBoZkw/gzsFLt1C5zQS
	fQz7vo0RMWl6FtbOQHWJsM/XnJr/bDiSbdqNnzpqXZUo2wYddolsnJHwJ35eB2zRbo7objkbYCgKk
	PYJ9v0pQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tlbf7-000000073Cy-2vQ2;
	Fri, 21 Feb 2025 22:38:25 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
To: brauner@kernel.org,
	akpm@linux-foundation.org,
	hare@suse.de,
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
Subject: [PATCH v3 0/8] enable bs > ps for block devices
Date: Fri, 21 Feb 2025 14:38:15 -0800
Message-ID: <20250221223823.1680616-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>

Christian, Andrew,

This v3 series addresses the feedback from the v2 series [0]. The only
patch which was mofified was the patch titled "fs/mpage: use blocks_per_folio
instead of blocks_per_page". The motivation for this series is to mainly
start supporting block devices with logical block sizes larger than 4k,
we do this by addressing buffer-head support required for the block
device cache.

In the future these changes can be leveraged to also start experimenting
with LBS support for filesystems which support only buffer-heads. This
paves the way for that work.

Its perhaps is surprising to some but since this also lifts the block
device cache sector size support to 64k, devices which support up to
64k sector sizes can also leverage this to enable filesystems created with
larger sector sizes up to 64k sector sizes. The filesystem sector size
is used or documented in a bit of obscurity except for few filesystems,
but in short it ensures that the filesystem itself will not generate
writes iteslef smaller than the specified sector size. In practice this
means you can constrain metadata writes as well to a minimum size, and
so be completely deterministic with regards to the specified sector size
for min IO writes. For example since XFS can supports up to 32k sector size,
it means with these changes enable filesystems to also be created on x86_64
with both the filesystem block size and sector size to 32k, now that the block
device cache limitation is lifted.

Since this touches buffer-heads I've ran this through fstests on ext4
and found no new regressions. I've also used blktests against a kernel
built with these changes to test block devices with different larger logical
block sizes than 4k on x86_64. All changes to be able to test block
devices with a logical block size support > 4k are now merged on
upstream blktests.  I've tested the block layer with blktests with block
devices with logical block sizes up to 64k which is the max we are
currently supporting and found no new regressions.

Detailed changes in this series:

  - Modifies the commit log for "fs/buffer: remove batching from async
    read" as per Willy's request and collects his SOB.
  - Collects Reviewed-by tags
  - The patch titled "fs/mpage: use blocks_per_folio instead of blocks_per_page"
    received more love to account for Willy's point
    that we should keep accounting in order for nr_pages on mpage. This
    does this by using folio_nr_pages() on the args passed and adjusts
    the last_block accounting accordingly.
  - Through code inspection fixed folio_zero_segment() use to use
    folio_size() as we move to suppor large folios for unmapped
    folio segments on do_mpage_readpage(), this is dealt with on the
    patch titled "fs/mpage: use blocks_per_folio instead of blocks_per_page"
    as that's when we start accounting large folios into the picture.

[0] https://lkml.kernel.org/r/20250204231209.429356-1-mcgrof@kernel.org

Hannes Reinecke (2):
  fs/mpage: avoid negative shift for large blocksize
  block/bdev: enable large folio support for large logical block sizes

Luis Chamberlain (5):
  fs/buffer: simplify block_read_full_folio() with bh_offset()
  fs/mpage: use blocks_per_folio instead of blocks_per_page
  fs/buffer fs/mpage: remove large folio restriction
  block/bdev: lift block size restrictions to 64k
  bdev: use bdev_io_min() for statx block size

Matthew Wilcox (1):
  fs/buffer: remove batching from async read

 block/bdev.c           | 11 ++++----
 fs/buffer.c            | 58 +++++++++++++++++-------------------------
 fs/mpage.c             | 49 +++++++++++++++++------------------
 include/linux/blkdev.h |  8 +++++-
 4 files changed, 59 insertions(+), 67 deletions(-)

-- 
2.47.2


