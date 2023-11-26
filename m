Return-Path: <linux-fsdevel+bounces-3849-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D29F27F92B2
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Nov 2023 13:48:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64B94B20DFC
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Nov 2023 12:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16ABCD28B;
	Sun, 26 Nov 2023 12:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UJUh123I"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58428EA;
	Sun, 26 Nov 2023 04:47:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=mgwiYB1RJ50rR/80cBc8gN3EYZFZbbJbiDxoHLe+koE=; b=UJUh123I9sNmyUsObTf4+bI4B+
	DEwFWcojsYalH5KPzCpAlvV+oWsFqtg3fJKhhokTjBHpWoVAvgEjzh3omVZaqwCgO+BYA5lmdkzUN
	G9xKYdRK4JTOMXmRhZ8ZqC8qaNOAeaiozpoRtTR7MSyrlRnA1J4wwUvhM2po+4+iyL6DCErYLnRNQ
	GmSf5yJOj3dQ3ifPT3HJ7Kt0MYFCZGNI8lKoTgPazFcQCib+9O68cyDY2CeN/yIxrvDOLmhFoFuEW
	AHjgTaajReQaV8jjsITDYw30FCVpA9fKoejqDD8g4/B0VdbQoSfG6RRHgbeAurPF4yKoG0hXRMitN
	gnu+q7jA==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1r7EYB-00BCLo-0w;
	Sun, 26 Nov 2023 12:47:51 +0000
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Chandan Babu R <chandan.babu@oracle.com>,
	Zhang Yi <yi.zhang@huaweicloud.com>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 08/13] iomap: move the iomap_sector sector calculation out of iomap_add_to_ioend
Date: Sun, 26 Nov 2023 13:47:15 +0100
Message-Id: <20231126124720.1249310-9-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231126124720.1249310-1-hch@lst.de>
References: <20231126124720.1249310-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

The calculation in iomap_sector is pretty trivial and most of the time
iomap_add_to_ioend only callers either iomap_can_add_to_ioend or
iomap_alloc_ioend from a single invocation.

Calculate the sector in the two lower level functions and stop passing it
from iomap_add_to_ioend and update the iomap_alloc_ioend argument passing
order to match that of iomap_add_to_ioend.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/buffered-io.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 7f86d2f90e3863..329e2c342f1c64 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1666,9 +1666,8 @@ iomap_submit_ioend(struct iomap_writepage_ctx *wpc, struct iomap_ioend *ioend,
 	return 0;
 }
 
-static struct iomap_ioend *
-iomap_alloc_ioend(struct inode *inode, struct iomap_writepage_ctx *wpc,
-		loff_t offset, sector_t sector, struct writeback_control *wbc)
+static struct iomap_ioend *iomap_alloc_ioend(struct iomap_writepage_ctx *wpc,
+		struct writeback_control *wbc, struct inode *inode, loff_t pos)
 {
 	struct iomap_ioend *ioend;
 	struct bio *bio;
@@ -1676,7 +1675,7 @@ iomap_alloc_ioend(struct inode *inode, struct iomap_writepage_ctx *wpc,
 	bio = bio_alloc_bioset(wpc->iomap.bdev, BIO_MAX_VECS,
 			       REQ_OP_WRITE | wbc_to_write_flags(wbc),
 			       GFP_NOFS, &iomap_ioend_bioset);
-	bio->bi_iter.bi_sector = sector;
+	bio->bi_iter.bi_sector = iomap_sector(&wpc->iomap, pos);
 	wbc_init_bio(wbc, bio);
 
 	ioend = container_of(bio, struct iomap_ioend, io_inline_bio);
@@ -1685,9 +1684,9 @@ iomap_alloc_ioend(struct inode *inode, struct iomap_writepage_ctx *wpc,
 	ioend->io_flags = wpc->iomap.flags;
 	ioend->io_inode = inode;
 	ioend->io_size = 0;
-	ioend->io_offset = offset;
+	ioend->io_offset = pos;
 	ioend->io_bio = bio;
-	ioend->io_sector = sector;
+	ioend->io_sector = bio->bi_iter.bi_sector;
 
 	wpc->nr_folios = 0;
 	return ioend;
@@ -1716,8 +1715,7 @@ iomap_chain_bio(struct bio *prev)
 }
 
 static bool
-iomap_can_add_to_ioend(struct iomap_writepage_ctx *wpc, loff_t offset,
-		sector_t sector)
+iomap_can_add_to_ioend(struct iomap_writepage_ctx *wpc, loff_t offset)
 {
 	if ((wpc->iomap.flags & IOMAP_F_SHARED) !=
 	    (wpc->ioend->io_flags & IOMAP_F_SHARED))
@@ -1726,7 +1724,8 @@ iomap_can_add_to_ioend(struct iomap_writepage_ctx *wpc, loff_t offset,
 		return false;
 	if (offset != wpc->ioend->io_offset + wpc->ioend->io_size)
 		return false;
-	if (sector != bio_end_sector(wpc->ioend->io_bio))
+	if (iomap_sector(&wpc->iomap, offset) !=
+	    bio_end_sector(wpc->ioend->io_bio))
 		return false;
 	/*
 	 * Limit ioend bio chain lengths to minimise IO completion latency. This
@@ -1747,14 +1746,13 @@ static void iomap_add_to_ioend(struct iomap_writepage_ctx *wpc,
 		struct inode *inode, loff_t pos, struct list_head *iolist)
 {
 	struct iomap_folio_state *ifs = folio->private;
-	sector_t sector = iomap_sector(&wpc->iomap, pos);
 	unsigned len = i_blocksize(inode);
 	size_t poff = offset_in_folio(folio, pos);
 
-	if (!wpc->ioend || !iomap_can_add_to_ioend(wpc, pos, sector)) {
+	if (!wpc->ioend || !iomap_can_add_to_ioend(wpc, pos)) {
 		if (wpc->ioend)
 			list_add(&wpc->ioend->io_list, iolist);
-		wpc->ioend = iomap_alloc_ioend(inode, wpc, pos, sector, wbc);
+		wpc->ioend = iomap_alloc_ioend(wpc, wbc, inode, pos);
 	}
 
 	if (!bio_add_folio(wpc->ioend->io_bio, folio, len, poff)) {
-- 
2.39.2


