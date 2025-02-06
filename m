Return-Path: <linux-fsdevel+bounces-41029-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55DC2A2A114
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 07:41:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 377B916778D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 06:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 543F0224B0A;
	Thu,  6 Feb 2025 06:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WuNt0RWM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26FA2224B07;
	Thu,  6 Feb 2025 06:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738824048; cv=none; b=RT3LYmMh/tU/EDW/ONxTo5DS7/2jO/03WnuGKR3cMFJT+dgtqe/GRK6MvIEUeY5kq5HRvBW3mCyZRaDzy6CFclJmIe8yanYHI3zsH9whijTawYrrkiWcvQhhCUdXbQFeR4/qz0ubfoHnSMWHHZW+Is5gIsVnX/Mu2V9dmoCkdyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738824048; c=relaxed/simple;
	bh=XqdsnDK7yzicLCTHItwy4KKM0d1Rg/FKXmsX2gcjumk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=grkyCjq72t9QGD5h2CHyp3uDD4TTG3lwkeA33TUFOmZw6QHUdJcHu0iDhQVMdGvxfk5DXxyHXEtjX9C6fMmlZakJeEIuBqFyoVAYoQbUZ5g49vDCEPg6Hz4o0DI+M0y6Bz2YaTnzrlwLkNDsVYYakaQOATKZXTTN8aTz1fhSkks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WuNt0RWM; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=l33Bta1u4MSMt9bbV+R9GgQdjJA51THj9SlwTj9aS+0=; b=WuNt0RWMXQPzYZTgZHMdWiuu2y
	DHerASiGZA7RZQwBCUlwsBsoxtD6JnuhKg8hfc5Cwlpc4w/p8QQ9ykonq7vKZLNYjIyfnTdgq6Tf8
	C3rN/xoYXQQGNB7Gn3PT7z5mCiKfpDaN8KRm2PE7horHbD43gvSjfT76o7d/puoix0K0hpOfGOcmH
	mai7NupGf5P1zHIEWd+FtwytrGvqQGhixLJqSzJeZ97q50J+1HlPJqp4ntAHt+pmL5X8VcwGbay4b
	a0TXL5lPK+yLfxjK/iDbvfoh+x5/93hr3fC2PKXzPOTb6/j6QhaQSDjC2AZuuFEtmf8bifhEdk1xx
	knqsFxvA==;
Received: from 2a02-8389-2341-5b80-9d5d-e9d2-4927-2bd6.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:9d5d:e9d2:4927:2bd6] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tfvZ8-00000005PST-1pRS;
	Thu, 06 Feb 2025 06:40:46 +0000
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 04/11] iomap: split bios to zone append limits in the submission handlers
Date: Thu,  6 Feb 2025 07:40:02 +0100
Message-ID: <20250206064035.2323428-5-hch@lst.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250206064035.2323428-1-hch@lst.de>
References: <20250206064035.2323428-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Provide helpers for file systems to split bios in the direct I/O and
writeback I/O submission handlers.  The split ioends are chained to
the parent ioend so that only the parent ioend originally generated
by the iomap layer will be processed after all the chained off children
have completed.  This is based on the block layer bio chaining that has
supported a similar mechanism for a long time.

This Follows btrfs' lead and don't try to build bios to hardware limits
for zone append commands, but instead build them as normal unconstrained
bios and split them to the hardware limits in the I/O submission handler.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/iomap/Makefile      |  1 +
 fs/iomap/buffered-io.c | 49 ++++++++++++++----------
 fs/iomap/ioend.c       | 86 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/iomap.h  | 15 +++++++-
 4 files changed, 130 insertions(+), 21 deletions(-)
 create mode 100644 fs/iomap/ioend.c

diff --git a/fs/iomap/Makefile b/fs/iomap/Makefile
index 381d76c5c232..69e8ebb41302 100644
--- a/fs/iomap/Makefile
+++ b/fs/iomap/Makefile
@@ -12,6 +12,7 @@ iomap-y				+= trace.o \
 				   iter.o
 iomap-$(CONFIG_BLOCK)		+= buffered-io.o \
 				   direct-io.o \
+				   ioend.o \
 				   fiemap.o \
 				   seek.o
 iomap-$(CONFIG_SWAP)		+= swapfile.o
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index ba795d72e546..f67e13a9807a 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -40,7 +40,8 @@ struct iomap_folio_state {
 	unsigned long		state[];
 };
 
-static struct bio_set iomap_ioend_bioset;
+struct bio_set iomap_ioend_bioset;
+EXPORT_SYMBOL_GPL(iomap_ioend_bioset);
 
 static inline bool ifs_is_fully_uptodate(struct folio *folio,
 		struct iomap_folio_state *ifs)
@@ -1539,15 +1540,15 @@ static void iomap_finish_folio_write(struct inode *inode, struct folio *folio,
  * ioend after this.
  */
 static u32
-iomap_finish_ioend(struct iomap_ioend *ioend, int error)
+iomap_finish_ioend_buffered(struct iomap_ioend *ioend)
 {
 	struct inode *inode = ioend->io_inode;
 	struct bio *bio = &ioend->io_bio;
 	struct folio_iter fi;
 	u32 folio_count = 0;
 
-	if (error) {
-		mapping_set_error(inode->i_mapping, error);
+	if (ioend->io_error) {
+		mapping_set_error(inode->i_mapping, ioend->io_error);
 		if (!bio_flagged(bio, BIO_QUIET)) {
 			pr_err_ratelimited(
 "%s: writeback error on inode %lu, offset %lld, sector %llu",
@@ -1566,6 +1567,24 @@ iomap_finish_ioend(struct iomap_ioend *ioend, int error)
 	return folio_count;
 }
 
+static u32
+iomap_finish_ioend(struct iomap_ioend *ioend, int error)
+{
+	if (ioend->io_parent) {
+		struct bio *bio = &ioend->io_bio;
+
+		ioend = ioend->io_parent;
+		bio_put(bio);
+	}
+
+	if (error)
+		cmpxchg(&ioend->io_error, 0, error);
+
+	if (!atomic_dec_and_test(&ioend->io_remaining))
+		return 0;
+	return iomap_finish_ioend_buffered(ioend);
+}
+
 /*
  * Ioend completion routine for merged bios. This can only be called from task
  * contexts as merged ioends can be of unbound length. Hence we have to break up
@@ -1667,8 +1686,10 @@ EXPORT_SYMBOL_GPL(iomap_sort_ioends);
 
 static void iomap_writepage_end_bio(struct bio *bio)
 {
-	iomap_finish_ioend(iomap_ioend_from_bio(bio),
-			blk_status_to_errno(bio->bi_status));
+	struct iomap_ioend *ioend = iomap_ioend_from_bio(bio);
+
+	ioend->io_error = blk_status_to_errno(bio->bi_status);
+	iomap_finish_ioend_buffered(ioend);
 }
 
 /*
@@ -1713,7 +1734,6 @@ static struct iomap_ioend *iomap_alloc_ioend(struct iomap_writepage_ctx *wpc,
 		struct writeback_control *wbc, struct inode *inode, loff_t pos,
 		u16 ioend_flags)
 {
-	struct iomap_ioend *ioend;
 	struct bio *bio;
 
 	bio = bio_alloc_bioset(wpc->iomap.bdev, BIO_MAX_VECS,
@@ -1721,21 +1741,10 @@ static struct iomap_ioend *iomap_alloc_ioend(struct iomap_writepage_ctx *wpc,
 			       GFP_NOFS, &iomap_ioend_bioset);
 	bio->bi_iter.bi_sector = iomap_sector(&wpc->iomap, pos);
 	bio->bi_end_io = iomap_writepage_end_bio;
-	wbc_init_bio(wbc, bio);
 	bio->bi_write_hint = inode->i_write_hint;
-
-	ioend = iomap_ioend_from_bio(bio);
-	INIT_LIST_HEAD(&ioend->io_list);
-	ioend->io_flags = ioend_flags;
-	if (pos > wpc->iomap.offset)
-		wpc->iomap.flags &= ~IOMAP_F_BOUNDARY;
-	ioend->io_inode = inode;
-	ioend->io_size = 0;
-	ioend->io_offset = pos;
-	ioend->io_sector = bio->bi_iter.bi_sector;
-
+	wbc_init_bio(wbc, bio);
 	wpc->nr_folios = 0;
-	return ioend;
+	return iomap_init_ioend(inode, bio, pos, ioend_flags);
 }
 
 static bool iomap_can_add_to_ioend(struct iomap_writepage_ctx *wpc, loff_t pos,
diff --git a/fs/iomap/ioend.c b/fs/iomap/ioend.c
new file mode 100644
index 000000000000..3ff38c665c31
--- /dev/null
+++ b/fs/iomap/ioend.c
@@ -0,0 +1,86 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2024-2025 Christoph Hellwig.
+ */
+#include <linux/iomap.h>
+
+struct iomap_ioend *iomap_init_ioend(struct inode *inode,
+		struct bio *bio, loff_t file_offset, u16 ioend_flags)
+{
+	struct iomap_ioend *ioend = iomap_ioend_from_bio(bio);
+
+	atomic_set(&ioend->io_remaining, 1);
+	ioend->io_error = 0;
+	ioend->io_parent = NULL;
+	INIT_LIST_HEAD(&ioend->io_list);
+	ioend->io_flags = ioend_flags;
+	ioend->io_inode = inode;
+	ioend->io_offset = file_offset;
+	ioend->io_size = bio->bi_iter.bi_size;
+	ioend->io_sector = bio->bi_iter.bi_sector;
+	return ioend;
+}
+EXPORT_SYMBOL_GPL(iomap_init_ioend);
+
+/*
+ * Split up to the first @max_len bytes from @ioend if the ioend covers more
+ * than @max_len bytes.
+ *
+ * If @is_append is set, the split will be based on the hardware limits for
+ * REQ_OP_ZONE_APPEND commands and can be less than @max_len if the hardware
+ * limits don't allow the entire @max_len length.
+ *
+ * The bio embedded into @ioend must be a REQ_OP_WRITE because the block layer
+ * does not allow splitting REQ_OP_ZONE_APPEND bios.  The file systems has to
+ * switch the operation after this call, but before submitting the bio.
+ */
+struct iomap_ioend *iomap_split_ioend(struct iomap_ioend *ioend,
+		unsigned int max_len, bool is_append)
+{
+	struct bio *bio = &ioend->io_bio;
+	struct iomap_ioend *split_ioend;
+	unsigned int nr_segs;
+	int sector_offset;
+	struct bio *split;
+
+	if (is_append) {
+		struct queue_limits *lim = bdev_limits(bio->bi_bdev);
+
+		max_len = min(max_len,
+			      lim->max_zone_append_sectors << SECTOR_SHIFT);
+
+		sector_offset = bio_split_rw_at(bio, lim, &nr_segs, max_len);
+		if (unlikely(sector_offset < 0))
+			return ERR_PTR(sector_offset);
+		if (!sector_offset)
+			return NULL;
+	} else {
+		if (bio->bi_iter.bi_size <= max_len)
+			return NULL;
+		sector_offset = max_len >> SECTOR_SHIFT;
+	}
+
+	/* ensure the split ioend is still block size aligned */
+	sector_offset = ALIGN_DOWN(sector_offset << SECTOR_SHIFT,
+			i_blocksize(ioend->io_inode)) >> SECTOR_SHIFT;
+
+	split = bio_split(bio, sector_offset, GFP_NOFS, &iomap_ioend_bioset);
+	if (IS_ERR(split))
+		return ERR_CAST(split);
+	split->bi_private = bio->bi_private;
+	split->bi_end_io = bio->bi_end_io;
+
+	split_ioend = iomap_init_ioend(ioend->io_inode, split, ioend->io_offset,
+			ioend->io_flags);
+	split_ioend->io_parent = ioend;
+
+	atomic_inc(&ioend->io_remaining);
+	ioend->io_offset += split_ioend->io_size;
+	ioend->io_size -= split_ioend->io_size;
+
+	split_ioend->io_sector = ioend->io_sector;
+	if (!is_append)
+		ioend->io_sector += (split_ioend->io_size >> SECTOR_SHIFT);
+	return split_ioend;
+}
+EXPORT_SYMBOL_GPL(iomap_split_ioend);
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index eb0764945b42..90c27875e39d 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -353,12 +353,19 @@ sector_t iomap_bmap(struct address_space *mapping, sector_t bno,
 
 /*
  * Structure for writeback I/O completions.
+ *
+ * File systems implementing ->submit_ioend can split a bio generated
+ * by iomap.  In that case the parent ioend it was split from is recorded
+ * in ioend->io_parent.
  */
 struct iomap_ioend {
 	struct list_head	io_list;	/* next ioend in chain */
 	u16			io_flags;	/* IOMAP_IOEND_* */
 	struct inode		*io_inode;	/* file being written to */
-	size_t			io_size;	/* size of data within eof */
+	size_t			io_size;	/* size of the extent */
+	atomic_t		io_remaining;	/* completetion defer count */
+	int			io_error;	/* stashed away status */
+	struct iomap_ioend	*io_parent;	/* parent for completions */
 	loff_t			io_offset;	/* offset in the file */
 	sector_t		io_sector;	/* start sector of ioend */
 	struct bio		io_bio;		/* MUST BE LAST! */
@@ -408,6 +415,10 @@ struct iomap_writepage_ctx {
 	u32			nr_folios;	/* folios added to the ioend */
 };
 
+struct iomap_ioend *iomap_init_ioend(struct inode *inode, struct bio *bio,
+		loff_t file_offset, u16 ioend_flags);
+struct iomap_ioend *iomap_split_ioend(struct iomap_ioend *ioend,
+		unsigned int max_len, bool is_append);
 void iomap_finish_ioends(struct iomap_ioend *ioend, int error);
 void iomap_ioend_try_merge(struct iomap_ioend *ioend,
 		struct list_head *more_ioends);
@@ -479,4 +490,6 @@ int iomap_swapfile_activate(struct swap_info_struct *sis,
 # define iomap_swapfile_activate(sis, swapfile, pagespan, ops)	(-EIO)
 #endif /* CONFIG_SWAP */
 
+extern struct bio_set iomap_ioend_bioset;
+
 #endif /* LINUX_IOMAP_H */
-- 
2.45.2


