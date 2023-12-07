Return-Path: <linux-fsdevel+bounces-5118-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4EF0808317
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 09:35:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE67A1C216D4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 08:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A4EA33CCD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 08:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fNbbzkIJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AF4F1AD;
	Wed,  6 Dec 2023 23:27:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=6w3rL/XbGr2VGomxDtHrk4OnPxYYtC/IRjrvVtWWkoI=; b=fNbbzkIJFR0OSjeyiWQ33ZtydJ
	kJFIH39tDS64REVitiAhGuko3wbdiptHHVuuc5CDFKlkWF2WSihFFa4VBwKV5Y9W9vQtrsHt1Sh42
	HmaKXt5q0pZWFgenQh1CoFr4kQ5n2jvL2P6NlROUuda+Sg4o3EB6rvFZzVeH8JZsOETSMTYHx/wKS
	Ru+gd0fkvzggIUiV5RxmC27V04tRu5Tllh7fOlBhWyEdx0mnjPS4ZUuvy9tvb0zmuo35phXkFXFx0
	cDORwkyGqFI9zsvIbkxMXZ9Cct7Veb7HuxPkz7XzSDt0MRHNhMQdYYdvbNOQEXrjpcubyfgGgQj91
	lyuTSEmA==;
Received: from [2001:4bb8:191:e7ca:4bf6:cea4:9bbf:8b02] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rB8nK-00C51I-36;
	Thu, 07 Dec 2023 07:27:39 +0000
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Chandan Babu R <chandan.babu@oracle.com>,
	Zhang Yi <yi.zhang@huaweicloud.com>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Jens Axboe <axboe@kernel.dk>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Johannes Thumshirn <jth@kernel.org>,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org,
	gfs2@lists.linux.dev
Subject: [PATCH 08/14] iomap: move the iomap_sector sector calculation out of iomap_add_to_ioend
Date: Thu,  7 Dec 2023 08:27:04 +0100
Message-Id: <20231207072710.176093-9-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231207072710.176093-1-hch@lst.de>
References: <20231207072710.176093-1-hch@lst.de>
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
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 fs/iomap/buffered-io.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index dc409ec85c3c0b..78cd5c06ea9b77 100644
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
@@ -1715,18 +1714,17 @@ iomap_chain_bio(struct bio *prev)
 	return new;
 }
 
-static bool
-iomap_can_add_to_ioend(struct iomap_writepage_ctx *wpc, loff_t offset,
-		sector_t sector)
+static bool iomap_can_add_to_ioend(struct iomap_writepage_ctx *wpc, loff_t pos)
 {
 	if ((wpc->iomap.flags & IOMAP_F_SHARED) !=
 	    (wpc->ioend->io_flags & IOMAP_F_SHARED))
 		return false;
 	if (wpc->iomap.type != wpc->ioend->io_type)
 		return false;
-	if (offset != wpc->ioend->io_offset + wpc->ioend->io_size)
+	if (pos != wpc->ioend->io_offset + wpc->ioend->io_size)
 		return false;
-	if (sector != bio_end_sector(wpc->ioend->io_bio))
+	if (iomap_sector(&wpc->iomap, pos) !=
+	    bio_end_sector(wpc->ioend->io_bio))
 		return false;
 	/*
 	 * Limit ioend bio chain lengths to minimise IO completion latency. This
@@ -1747,14 +1745,13 @@ static void iomap_add_to_ioend(struct iomap_writepage_ctx *wpc,
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


