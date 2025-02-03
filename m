Return-Path: <linux-fsdevel+bounces-40580-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04838A25618
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 10:44:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F5193A8E78
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 09:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96FCC200127;
	Mon,  3 Feb 2025 09:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="zSaQmeB5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405D51FFC67;
	Mon,  3 Feb 2025 09:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738575813; cv=none; b=evrJD/VE35rOzF3FDwJB0C8iGCkf0tmcIXCxFKlQyoR5/7G+ZD85IPLF1HFMkmklu5BsMC/4DPhKX3FVAk081hC642klzTSYrC6y/n4LgTusVp+yMqoq1mfk8Y4V1jvP0tKo5jjQqw28pHtExNNrF/plUfEsubNLAJiNyvhmC/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738575813; c=relaxed/simple;
	bh=v2FHne68+jEpTvz5Rqg+6S/DvY9pyEXy6/nHNsd2irE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WizIJJg03xAD/Jq1d90nGWnk0KzRKVhULpLAJcBLjWVkTWJ1N1glo/Ny0AT/ifCN8FKAsIWliVBEFbFOlL2v1USWVgvwp9Ch9S2vTUsPKemKAkS+PBcKLK5jCOD4qG0oSNOzjEFlzkrBTE5WWVHr7VGU8n3sT0TOT9sLIXDiYQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=zSaQmeB5; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=VmoVu1qBS/xDcNr5Y2OBKuc12ztCJfDEnl6CgejjiPQ=; b=zSaQmeB5IDRvQFUdClCaEr/+90
	J7RakJyZU2ewghkPhz8mpCcZ7jgFQv8DFm40fVgl7QBm6vzoLct+bp12TKAgV/xU94fb0vJqAhNu0
	O7NON7HRrvhCe/Q9LvWaAxWTlzIqyQ3XwPS1ttgf26eUmdMJmHOWNd4blPuGpDJ3GRpK2flUPss1O
	2Gd2lPN7+4caWI+SJrmJRkYAMOVhTStVW7Zhh10Olgxc8c2p7zKM8WUwXMIMgEkBvz4l2be7AA5GF
	/Uc3/SJL+awnkYZSxt8jXGKkn71WyRjIQVKw/Rrjg2B6RuPGtRsMOAh/FH+ckA8CQpc/qT2n8yTNP
	o405fgSQ==;
Received: from 2a02-8389-2341-5b80-b79f-eb9e-0b40-3aae.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:b79f:eb9e:b40:3aae] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1teszK-0000000F1hF-0hMi;
	Mon, 03 Feb 2025 09:43:30 +0000
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>
Cc: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
	Qu Wenruo <wqu@suse.com>,
	Goldwyn Rodrigues <rgoldwyn@suse.com>,
	linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: [PATCH 2/7] iomap: introduce iomap_read_folio_ops
Date: Mon,  3 Feb 2025 10:43:06 +0100
Message-ID: <20250203094322.1809766-3-hch@lst.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250203094322.1809766-1-hch@lst.de>
References: <20250203094322.1809766-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

iomap_read_folio_ops provide additional functions to allocate or submit
the bio. Filesystems such as btrfs have additional operations with bios
such as verifying data checksums. Creating a bio submission hook allows
the filesystem to process and verify the bio.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
[hch: add a helper, pass file offset to ->submit_io]
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/fops.c           |  4 ++--
 fs/erofs/data.c        |  4 ++--
 fs/gfs2/aops.c         |  4 ++--
 fs/iomap/buffered-io.c | 27 ++++++++++++++++++++++-----
 fs/xfs/xfs_aops.c      |  4 ++--
 fs/zonefs/file.c       |  4 ++--
 include/linux/iomap.h  | 16 ++++++++++++++--
 7 files changed, 46 insertions(+), 17 deletions(-)

diff --git a/block/fops.c b/block/fops.c
index be9f1dbea9ce..f4c971311c6c 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -505,12 +505,12 @@ const struct address_space_operations def_blk_aops = {
 #else /* CONFIG_BUFFER_HEAD */
 static int blkdev_read_folio(struct file *file, struct folio *folio)
 {
-	return iomap_read_folio(folio, &blkdev_iomap_ops);
+	return iomap_read_folio(folio, &blkdev_iomap_ops, NULL);
 }
 
 static void blkdev_readahead(struct readahead_control *rac)
 {
-	iomap_readahead(rac, &blkdev_iomap_ops);
+	iomap_readahead(rac, &blkdev_iomap_ops, NULL);
 }
 
 static int blkdev_map_blocks(struct iomap_writepage_ctx *wpc,
diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index 0cd6b5c4df98..b0f0db855971 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -370,12 +370,12 @@ int erofs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
  */
 static int erofs_read_folio(struct file *file, struct folio *folio)
 {
-	return iomap_read_folio(folio, &erofs_iomap_ops);
+	return iomap_read_folio(folio, &erofs_iomap_ops, NULL);
 }
 
 static void erofs_readahead(struct readahead_control *rac)
 {
-	return iomap_readahead(rac, &erofs_iomap_ops);
+	return iomap_readahead(rac, &erofs_iomap_ops, NULL);
 }
 
 static sector_t erofs_bmap(struct address_space *mapping, sector_t block)
diff --git a/fs/gfs2/aops.c b/fs/gfs2/aops.c
index 68fc8af14700..f0debbe048a6 100644
--- a/fs/gfs2/aops.c
+++ b/fs/gfs2/aops.c
@@ -422,7 +422,7 @@ static int gfs2_read_folio(struct file *file, struct folio *folio)
 
 	if (!gfs2_is_jdata(ip) ||
 	    (i_blocksize(inode) == PAGE_SIZE && !folio_buffers(folio))) {
-		error = iomap_read_folio(folio, &gfs2_iomap_ops);
+		error = iomap_read_folio(folio, &gfs2_iomap_ops, NULL);
 	} else if (gfs2_is_stuffed(ip)) {
 		error = stuffed_read_folio(ip, folio);
 	} else {
@@ -497,7 +497,7 @@ static void gfs2_readahead(struct readahead_control *rac)
 	else if (gfs2_is_jdata(ip))
 		mpage_readahead(rac, gfs2_block_map);
 	else
-		iomap_readahead(rac, &gfs2_iomap_ops);
+		iomap_readahead(rac, &gfs2_iomap_ops, NULL);
 }
 
 /**
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 4abff64998fe..804527dcc9ba 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -320,7 +320,9 @@ struct iomap_readpage_ctx {
 	struct folio		*cur_folio;
 	bool			cur_folio_in_bio;
 	struct bio		*bio;
+	loff_t			bio_start_pos;
 	struct readahead_control *rac;
+	const struct iomap_read_folio_ops *ops;
 };
 
 /**
@@ -362,6 +364,15 @@ static inline bool iomap_block_needs_zeroing(const struct iomap_iter *iter,
 		pos >= i_size_read(iter->inode);
 }
 
+static void iomap_read_submit_bio(const struct iomap_iter *iter,
+		struct iomap_readpage_ctx *ctx)
+{
+	if (ctx->ops && ctx->ops->submit_io)
+		ctx->ops->submit_io(iter->inode, ctx->bio, ctx->bio_start_pos);
+	else
+		submit_bio(ctx->bio);
+}
+
 static loff_t iomap_readpage_iter(const struct iomap_iter *iter,
 		struct iomap_readpage_ctx *ctx, loff_t offset)
 {
@@ -405,8 +416,9 @@ static loff_t iomap_readpage_iter(const struct iomap_iter *iter,
 		unsigned int nr_vecs = DIV_ROUND_UP(length, PAGE_SIZE);
 
 		if (ctx->bio)
-			submit_bio(ctx->bio);
+			iomap_read_submit_bio(iter, ctx);
 
+		ctx->bio_start_pos = offset;
 		if (ctx->rac) /* same as readahead_gfp_mask */
 			gfp |= __GFP_NORETRY | __GFP_NOWARN;
 		ctx->bio = bio_alloc(iomap->bdev, bio_max_segs(nr_vecs),
@@ -455,7 +467,8 @@ static loff_t iomap_read_folio_iter(const struct iomap_iter *iter,
 	return done;
 }
 
-int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops)
+int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops,
+		const struct iomap_read_folio_ops *read_folio_ops)
 {
 	struct iomap_iter iter = {
 		.inode		= folio->mapping->host,
@@ -464,6 +477,7 @@ int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops)
 	};
 	struct iomap_readpage_ctx ctx = {
 		.cur_folio	= folio,
+		.ops		= read_folio_ops,
 	};
 	int ret;
 
@@ -473,7 +487,7 @@ int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops)
 		iter.processed = iomap_read_folio_iter(&iter, &ctx);
 
 	if (ctx.bio) {
-		submit_bio(ctx.bio);
+		iomap_read_submit_bio(&iter, &ctx);
 		WARN_ON_ONCE(!ctx.cur_folio_in_bio);
 	} else {
 		WARN_ON_ONCE(ctx.cur_folio_in_bio);
@@ -518,6 +532,7 @@ static loff_t iomap_readahead_iter(const struct iomap_iter *iter,
  * iomap_readahead - Attempt to read pages from a file.
  * @rac: Describes the pages to be read.
  * @ops: The operations vector for the filesystem.
+ * @read_folio_ops: Function hooks for filesystems for special bio submissions
  *
  * This function is for filesystems to call to implement their readahead
  * address_space operation.
@@ -529,7 +544,8 @@ static loff_t iomap_readahead_iter(const struct iomap_iter *iter,
  * function is called with memalloc_nofs set, so allocations will not cause
  * the filesystem to be reentered.
  */
-void iomap_readahead(struct readahead_control *rac, const struct iomap_ops *ops)
+void iomap_readahead(struct readahead_control *rac, const struct iomap_ops *ops,
+		const struct iomap_read_folio_ops *read_folio_ops)
 {
 	struct iomap_iter iter = {
 		.inode	= rac->mapping->host,
@@ -538,6 +554,7 @@ void iomap_readahead(struct readahead_control *rac, const struct iomap_ops *ops)
 	};
 	struct iomap_readpage_ctx ctx = {
 		.rac	= rac,
+		.ops	= read_folio_ops,
 	};
 
 	trace_iomap_readahead(rac->mapping->host, readahead_count(rac));
@@ -546,7 +563,7 @@ void iomap_readahead(struct readahead_control *rac, const struct iomap_ops *ops)
 		iter.processed = iomap_readahead_iter(&iter, &ctx);
 
 	if (ctx.bio)
-		submit_bio(ctx.bio);
+		iomap_read_submit_bio(&iter, &ctx);
 	if (ctx.cur_folio) {
 		if (!ctx.cur_folio_in_bio)
 			folio_unlock(ctx.cur_folio);
diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index 8e60ceeb1520..3e42a684cce1 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -522,14 +522,14 @@ xfs_vm_read_folio(
 	struct file		*unused,
 	struct folio		*folio)
 {
-	return iomap_read_folio(folio, &xfs_read_iomap_ops);
+	return iomap_read_folio(folio, &xfs_read_iomap_ops, NULL);
 }
 
 STATIC void
 xfs_vm_readahead(
 	struct readahead_control	*rac)
 {
-	iomap_readahead(rac, &xfs_read_iomap_ops);
+	iomap_readahead(rac, &xfs_read_iomap_ops, NULL);
 }
 
 static int
diff --git a/fs/zonefs/file.c b/fs/zonefs/file.c
index 35166c92420c..a70fa1cecef8 100644
--- a/fs/zonefs/file.c
+++ b/fs/zonefs/file.c
@@ -112,12 +112,12 @@ static const struct iomap_ops zonefs_write_iomap_ops = {
 
 static int zonefs_read_folio(struct file *unused, struct folio *folio)
 {
-	return iomap_read_folio(folio, &zonefs_read_iomap_ops);
+	return iomap_read_folio(folio, &zonefs_read_iomap_ops, NULL);
 }
 
 static void zonefs_readahead(struct readahead_control *rac)
 {
-	iomap_readahead(rac, &zonefs_read_iomap_ops);
+	iomap_readahead(rac, &zonefs_read_iomap_ops, NULL);
 }
 
 /*
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index b4be07e8ec94..2930861d1ef1 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -303,8 +303,20 @@ static inline bool iomap_want_unshare_iter(const struct iomap_iter *iter)
 
 ssize_t iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter *from,
 		const struct iomap_ops *ops, void *private);
-int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops);
-void iomap_readahead(struct readahead_control *, const struct iomap_ops *ops);
+
+struct iomap_read_folio_ops {
+	/*
+	 * Optional, allows the filesystem to perform a custom submission of
+	 * bio, such as csum calculations or multi-device bio split
+	 */
+	void (*submit_io)(struct inode *inode, struct bio *bio,
+			  loff_t file_offset);
+};
+
+int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops,
+		const struct iomap_read_folio_ops *);
+void iomap_readahead(struct readahead_control *, const struct iomap_ops *ops,
+		const struct iomap_read_folio_ops *);
 bool iomap_is_partially_uptodate(struct folio *, size_t from, size_t count);
 struct folio *iomap_get_folio(struct iomap_iter *iter, loff_t pos, size_t len);
 bool iomap_release_folio(struct folio *folio, gfp_t gfp_flags);
-- 
2.45.2


