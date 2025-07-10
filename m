Return-Path: <linux-fsdevel+bounces-54503-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B68B0038A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 15:36:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DF725A1CF6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 13:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DA0285C5E;
	Thu, 10 Jul 2025 13:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="4yZQkgN1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15041259C85;
	Thu, 10 Jul 2025 13:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752154446; cv=none; b=JFB85/fqhcUxXIfFFOuMF4HkWHpIexgumZkGL1c4+iPQ6zkVPn0iXyL1VcA5Nh9Gs8FcOcvPtz9cvtEOcbsk8js4OydX6dtqN+/tO2RJbgkxHvTtQmDmCK9Sqdu38sPvL6UHuonybKhN+/5hQxcgEowU4yTjYKammaUaAIf2KBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752154446; c=relaxed/simple;
	bh=x62pBhHDLOlwIFTTYRtSfYxko1AjbjbpB4rcHYi5ez0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BRlfTZPa64H+H+d2y9J3h/GByqDiDovMASFQL5Ai2eqxcgdBUud7SD/SOfYUhNBVMZDQ5PxrSp/wTJ3CXuq5mMvyg3Za83D3jV7tMZd4DalZS5UI8M1ZaWHHYsM8KWfRXXSS3xcbGGuxLvD0IiVgDjB5tFqXUJt3uBYl+gr/3NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=4yZQkgN1; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=fQOCuMxLIAgc0uKU/FtYljFXY0moXaqlSJl0eCHsfCo=; b=4yZQkgN14MOZeKD/TNSAlp8H1T
	yNsGFLVieimDB5TV07EjnWy5/sWJb3iyXOp2kBwWjhXfkVLhzwRcPmQFShO/n+R+snIes+0DkkH+E
	PXig6tWEJTXgZ0evXrmWyU2mGI4AQIrnZNTqu+vHLiIkyQ+Zd8MuzXw6vMKbC+d+uj1dKXjZeOTta
	gYhXZK7Qw5vdqxfVZ0LQtI+DrOfQsTq4nbhvt4YZhz1dQo7dAokh2AM9oecmWBpWN3A/n400wWC5y
	r7AnGvoWC7a6ZvqoGPXQlKtcffpliCFMQdFICMAlg2VFUS3ItQYA0jzLe3FlcdfaGzq35+autttA+
	GA0VkFqQ==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZrPX-0000000BwTE-0aqH;
	Thu, 10 Jul 2025 13:34:03 +0000
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Joanne Koong <joannelkoong@gmail.com>,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-block@vger.kernel.org,
	gfs2@lists.linux.dev,
	Brian Foster <bfoster@redhat.com>,
	Damien Le Moal <dlemoal@kernel.org>
Subject: [PATCH 05/14] iomap: hide ioends from the generic writeback code
Date: Thu, 10 Jul 2025 15:33:29 +0200
Message-ID: <20250710133343.399917-6-hch@lst.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250710133343.399917-1-hch@lst.de>
References: <20250710133343.399917-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Replace the ioend pointer in iomap_writeback_ctx with a void *wb_ctx
one to facilitate non-block, non-ioend writeback for use.  Rename
the submit_ioend method to writeback_submit and make it mandatory so
that the generic writeback code stops seeing ioends and bios.

Co-developed-by: Joanne Koong <joannelkoong@gmail.com>
Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Brian Foster <bfoster@redhat.com>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Acked-by: Damien Le Moal <dlemoal@kernel.org>
---
 .../filesystems/iomap/operations.rst          | 17 ++--
 block/fops.c                                  |  1 +
 fs/gfs2/bmap.c                                |  1 +
 fs/iomap/buffered-io.c                        | 91 ++++++++++---------
 fs/xfs/xfs_aops.c                             | 60 ++++++------
 fs/zonefs/file.c                              |  1 +
 include/linux/iomap.h                         | 19 ++--
 7 files changed, 100 insertions(+), 90 deletions(-)

diff --git a/Documentation/filesystems/iomap/operations.rst b/Documentation/filesystems/iomap/operations.rst
index f07c8fdb2046..4b93c5f7841a 100644
--- a/Documentation/filesystems/iomap/operations.rst
+++ b/Documentation/filesystems/iomap/operations.rst
@@ -284,8 +284,8 @@ The ``ops`` structure must be specified and is as follows:
 
  struct iomap_writeback_ops {
     int (*writeback_range)(struct iomap_writepage_ctx *wpc,
-         struct folio *folio, u64 pos, unsigned int len, u64 end_pos);
-    int (*submit_ioend)(struct iomap_writepage_ctx *wpc, int status);
+        struct folio *folio, u64 pos, unsigned int len, u64 end_pos);
+    int (*writeback_submit)(struct iomap_writepage_ctx *wpc, int error);
  };
 
 The fields are as follows:
@@ -316,13 +316,15 @@ The fields are as follows:
     clean pagecache.
     This function must be supplied by the filesystem.
 
-  - ``submit_ioend``: Allows the file systems to hook into writeback bio
-    submission.
+  - ``writeback_submit``: Submit the previous built writeback context.
+    Block based file systems should use the iomap_ioend_writeback_submit
+    helper, other file system can implement their own.
+    File systems can optionall to hook into writeback bio submission.
     This might include pre-write space accounting updates, or installing
     a custom ``->bi_end_io`` function for internal purposes, such as
     deferring the ioend completion to a workqueue to run metadata update
     transactions from process context before submitting the bio.
-    This function is optional.
+    This function must be supplied by the filesystem.
 
 Pagecache Writeback Completion
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@@ -336,10 +338,9 @@ If the write failed, it will also set the error bits on the folios and
 the address space.
 This can happen in interrupt or process context, depending on the
 storage device.
-
 Filesystems that need to update internal bookkeeping (e.g. unwritten
-extent conversions) should provide a ``->submit_ioend`` function to
-set ``struct iomap_end::bio::bi_end_io`` to its own function.
+extent conversions) should set their own bi_end_io on the bios
+submitted by ``->submit_writeback``
 This function should call ``iomap_finish_ioends`` after finishing its
 own work (e.g. unwritten extent conversion).
 
diff --git a/block/fops.c b/block/fops.c
index b500ff8f55dd..0845737c0320 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -560,6 +560,7 @@ static ssize_t blkdev_writeback_range(struct iomap_writepage_ctx *wpc,
 
 static const struct iomap_writeback_ops blkdev_writeback_ops = {
 	.writeback_range	= blkdev_writeback_range,
+	.writeback_submit	= iomap_ioend_writeback_submit,
 };
 
 static int blkdev_writepages(struct address_space *mapping,
diff --git a/fs/gfs2/bmap.c b/fs/gfs2/bmap.c
index 0cc41de54aba..86045d3577b7 100644
--- a/fs/gfs2/bmap.c
+++ b/fs/gfs2/bmap.c
@@ -2490,4 +2490,5 @@ static ssize_t gfs2_writeback_range(struct iomap_writepage_ctx *wpc,
 
 const struct iomap_writeback_ops gfs2_writeback_ops = {
 	.writeback_range	= gfs2_writeback_range,
+	.writeback_submit	= iomap_ioend_writeback_submit,
 };
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index c558ac15bc87..650a67b7d223 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1571,7 +1571,7 @@ u32 iomap_finish_ioend_buffered(struct iomap_ioend *ioend)
 	return folio_count;
 }
 
-static void iomap_writepage_end_bio(struct bio *bio)
+static void ioend_writeback_end_bio(struct bio *bio)
 {
 	struct iomap_ioend *ioend = iomap_ioend_from_bio(bio);
 
@@ -1580,42 +1580,30 @@ static void iomap_writepage_end_bio(struct bio *bio)
 }
 
 /*
- * Submit an ioend.
- *
- * If @error is non-zero, it means that we have a situation where some part of
- * the submission process has failed after we've marked pages for writeback.
- * We cannot cancel ioend directly in that case, so call the bio end I/O handler
- * with the error status here to run the normal I/O completion handler to clear
- * the writeback bit and let the file system proess the errors.
+ * We cannot cancel the ioend directly in case of an error, so call the bio end
+ * I/O handler with the error status here to run the normal I/O completion
+ * handler.
  */
-static int iomap_submit_ioend(struct iomap_writepage_ctx *wpc, int error)
+int iomap_ioend_writeback_submit(struct iomap_writepage_ctx *wpc, int error)
 {
-	if (!wpc->ioend)
-		return error;
+	struct iomap_ioend *ioend = wpc->wb_ctx;
 
-	/*
-	 * Let the file systems prepare the I/O submission and hook in an I/O
-	 * comletion handler.  This also needs to happen in case after a
-	 * failure happened so that the file system end I/O handler gets called
-	 * to clean up.
-	 */
-	if (wpc->ops->submit_ioend) {
-		error = wpc->ops->submit_ioend(wpc, error);
-	} else {
-		if (WARN_ON_ONCE(wpc->iomap.flags & IOMAP_F_ANON_WRITE))
-			error = -EIO;
-		if (!error)
-			submit_bio(&wpc->ioend->io_bio);
-	}
+	if (!ioend->io_bio.bi_end_io)
+		ioend->io_bio.bi_end_io = ioend_writeback_end_bio;
+
+	if (WARN_ON_ONCE(wpc->iomap.flags & IOMAP_F_ANON_WRITE))
+		error = -EIO;
 
 	if (error) {
-		wpc->ioend->io_bio.bi_status = errno_to_blk_status(error);
-		bio_endio(&wpc->ioend->io_bio);
+		ioend->io_bio.bi_status = errno_to_blk_status(error);
+		bio_endio(&ioend->io_bio);
+		return error;
 	}
 
-	wpc->ioend = NULL;
-	return error;
+	submit_bio(&ioend->io_bio);
+	return 0;
 }
+EXPORT_SYMBOL_GPL(iomap_ioend_writeback_submit);
 
 static struct iomap_ioend *iomap_alloc_ioend(struct iomap_writepage_ctx *wpc,
 		loff_t pos, u16 ioend_flags)
@@ -1626,7 +1614,6 @@ static struct iomap_ioend *iomap_alloc_ioend(struct iomap_writepage_ctx *wpc,
 			       REQ_OP_WRITE | wbc_to_write_flags(wpc->wbc),
 			       GFP_NOFS, &iomap_ioend_bioset);
 	bio->bi_iter.bi_sector = iomap_sector(&wpc->iomap, pos);
-	bio->bi_end_io = iomap_writepage_end_bio;
 	bio->bi_write_hint = wpc->inode->i_write_hint;
 	wbc_init_bio(wpc->wbc, bio);
 	wpc->nr_folios = 0;
@@ -1636,16 +1623,17 @@ static struct iomap_ioend *iomap_alloc_ioend(struct iomap_writepage_ctx *wpc,
 static bool iomap_can_add_to_ioend(struct iomap_writepage_ctx *wpc, loff_t pos,
 		u16 ioend_flags)
 {
+	struct iomap_ioend *ioend = wpc->wb_ctx;
+
 	if (ioend_flags & IOMAP_IOEND_BOUNDARY)
 		return false;
 	if ((ioend_flags & IOMAP_IOEND_NOMERGE_FLAGS) !=
-	    (wpc->ioend->io_flags & IOMAP_IOEND_NOMERGE_FLAGS))
+	    (ioend->io_flags & IOMAP_IOEND_NOMERGE_FLAGS))
 		return false;
-	if (pos != wpc->ioend->io_offset + wpc->ioend->io_size)
+	if (pos != ioend->io_offset + ioend->io_size)
 		return false;
 	if (!(wpc->iomap.flags & IOMAP_F_ANON_WRITE) &&
-	    iomap_sector(&wpc->iomap, pos) !=
-	    bio_end_sector(&wpc->ioend->io_bio))
+	    iomap_sector(&wpc->iomap, pos) != bio_end_sector(&ioend->io_bio))
 		return false;
 	/*
 	 * Limit ioend bio chain lengths to minimise IO completion latency. This
@@ -1671,6 +1659,7 @@ static bool iomap_can_add_to_ioend(struct iomap_writepage_ctx *wpc, loff_t pos,
 ssize_t iomap_add_to_ioend(struct iomap_writepage_ctx *wpc, struct folio *folio,
 		loff_t pos, loff_t end_pos, unsigned int dirty_len)
 {
+	struct iomap_ioend *ioend = wpc->wb_ctx;
 	struct iomap_folio_state *ifs = folio->private;
 	size_t poff = offset_in_folio(folio, pos);
 	unsigned int ioend_flags = 0;
@@ -1701,15 +1690,17 @@ ssize_t iomap_add_to_ioend(struct iomap_writepage_ctx *wpc, struct folio *folio,
 	if (pos == wpc->iomap.offset && (wpc->iomap.flags & IOMAP_F_BOUNDARY))
 		ioend_flags |= IOMAP_IOEND_BOUNDARY;
 
-	if (!wpc->ioend || !iomap_can_add_to_ioend(wpc, pos, ioend_flags)) {
+	if (!ioend || !iomap_can_add_to_ioend(wpc, pos, ioend_flags)) {
 new_ioend:
-		error = iomap_submit_ioend(wpc, 0);
-		if (error)
-			return error;
-		wpc->ioend = iomap_alloc_ioend(wpc, pos, ioend_flags);
+		if (ioend) {
+			error = wpc->ops->writeback_submit(wpc, 0);
+			if (error)
+				return error;
+		}
+		wpc->wb_ctx = ioend = iomap_alloc_ioend(wpc, pos, ioend_flags);
 	}
 
-	if (!bio_add_folio(&wpc->ioend->io_bio, folio, map_len, poff))
+	if (!bio_add_folio(&ioend->io_bio, folio, map_len, poff))
 		goto new_ioend;
 
 	if (ifs)
@@ -1756,9 +1747,9 @@ ssize_t iomap_add_to_ioend(struct iomap_writepage_ctx *wpc, struct folio *folio,
 	 * Note that this defeats the ability to chain the ioends of
 	 * appending writes.
 	 */
-	wpc->ioend->io_size += map_len;
-	if (wpc->ioend->io_offset + wpc->ioend->io_size > end_pos)
-		wpc->ioend->io_size = end_pos - wpc->ioend->io_offset;
+	ioend->io_size += map_len;
+	if (ioend->io_offset + ioend->io_size > end_pos)
+		ioend->io_size = end_pos - ioend->io_offset;
 
 	wbc_account_cgroup_owner(wpc->wbc, folio, map_len);
 	return map_len;
@@ -1953,6 +1944,18 @@ iomap_writepages(struct iomap_writepage_ctx *wpc)
 
 	while ((folio = writeback_iter(mapping, wpc->wbc, folio, &error)))
 		error = iomap_writepage_map(wpc, folio);
-	return iomap_submit_ioend(wpc, error);
+
+	/*
+	 * If @error is non-zero, it means that we have a situation where some
+	 * part of the submission process has failed after we've marked pages
+	 * for writeback.
+	 *
+	 * We cannot cancel the writeback directly in that case, so always call
+	 * ->writeback_submit to run the I/O completion handler to clear the
+	 * writeback bit and let the file system proess the errors.
+	 */
+	if (wpc->wb_ctx)
+		return wpc->ops->writeback_submit(wpc, error);
+	return error;
 }
 EXPORT_SYMBOL_GPL(iomap_writepages);
diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index f6d44ab78442..1ee4f835ac3c 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -514,41 +514,40 @@ xfs_ioend_needs_wq_completion(
 }
 
 static int
-xfs_submit_ioend(
-	struct iomap_writepage_ctx *wpc,
-	int			status)
+xfs_writeback_submit(
+	struct iomap_writepage_ctx	*wpc,
+	int				error)
 {
-	struct iomap_ioend	*ioend = wpc->ioend;
-	unsigned int		nofs_flag;
+	struct iomap_ioend		*ioend = wpc->wb_ctx;
 
 	/*
-	 * We can allocate memory here while doing writeback on behalf of
-	 * memory reclaim.  To avoid memory allocation deadlocks set the
-	 * task-wide nofs context for the following operations.
+	 * Convert CoW extents to regular.
+	 *
+	 * We can allocate memory here while doing writeback on behalf of memory
+	 * reclaim.  To avoid memory allocation deadlocks, set the task-wide
+	 * nofs context.
 	 */
-	nofs_flag = memalloc_nofs_save();
+	if (!error && (ioend->io_flags & IOMAP_IOEND_SHARED)) {
+		unsigned int		nofs_flag;
 
-	/* Convert CoW extents to regular */
-	if (!status && (ioend->io_flags & IOMAP_IOEND_SHARED)) {
-		status = xfs_reflink_convert_cow(XFS_I(ioend->io_inode),
+		nofs_flag = memalloc_nofs_save();
+		error = xfs_reflink_convert_cow(XFS_I(ioend->io_inode),
 				ioend->io_offset, ioend->io_size);
+		memalloc_nofs_restore(nofs_flag);
 	}
 
-	memalloc_nofs_restore(nofs_flag);
-
-	/* send ioends that might require a transaction to the completion wq */
+	/*
+	 * Send ioends that might require a transaction to the completion wq.
+	 */
 	if (xfs_ioend_needs_wq_completion(ioend))
 		ioend->io_bio.bi_end_io = xfs_end_bio;
 
-	if (status)
-		return status;
-	submit_bio(&ioend->io_bio);
-	return 0;
+	return iomap_ioend_writeback_submit(wpc, error);
 }
 
 static const struct iomap_writeback_ops xfs_writeback_ops = {
 	.writeback_range	= xfs_writeback_range,
-	.submit_ioend		= xfs_submit_ioend,
+	.writeback_submit	= xfs_writeback_submit,
 };
 
 struct xfs_zoned_writepage_ctx {
@@ -646,20 +645,25 @@ xfs_zoned_writeback_range(
 }
 
 static int
-xfs_zoned_submit_ioend(
-	struct iomap_writepage_ctx *wpc,
-	int			status)
+xfs_zoned_writeback_submit(
+	struct iomap_writepage_ctx	*wpc,
+	int				error)
 {
-	wpc->ioend->io_bio.bi_end_io = xfs_end_bio;
-	if (status)
-		return status;
-	xfs_zone_alloc_and_submit(wpc->ioend, &XFS_ZWPC(wpc)->open_zone);
+	struct iomap_ioend		*ioend = wpc->wb_ctx;
+
+	ioend->io_bio.bi_end_io = xfs_end_bio;
+	if (error) {
+		ioend->io_bio.bi_status = errno_to_blk_status(error);
+		bio_endio(&ioend->io_bio);
+		return error;
+	}
+	xfs_zone_alloc_and_submit(ioend, &XFS_ZWPC(wpc)->open_zone);
 	return 0;
 }
 
 static const struct iomap_writeback_ops xfs_zoned_writeback_ops = {
 	.writeback_range	= xfs_zoned_writeback_range,
-	.submit_ioend		= xfs_zoned_submit_ioend,
+	.writeback_submit	= xfs_zoned_writeback_submit,
 };
 
 STATIC int
diff --git a/fs/zonefs/file.c b/fs/zonefs/file.c
index c88e2c851753..fee9403ad49b 100644
--- a/fs/zonefs/file.c
+++ b/fs/zonefs/file.c
@@ -151,6 +151,7 @@ static ssize_t zonefs_writeback_range(struct iomap_writepage_ctx *wpc,
 
 static const struct iomap_writeback_ops zonefs_writeback_ops = {
 	.writeback_range	= zonefs_writeback_range,
+	.writeback_submit	= iomap_ioend_writeback_submit,
 };
 
 static int zonefs_writepages(struct address_space *mapping,
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 625d7911a2b5..9f32dd8dc075 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -391,8 +391,7 @@ sector_t iomap_bmap(struct address_space *mapping, sector_t bno,
 /*
  * Structure for writeback I/O completions.
  *
- * File systems implementing ->submit_ioend (for buffered I/O) or ->submit_io
- * for direct I/O) can split a bio generated by iomap.  In that case the parent
+ * File systems can split a bio generated by iomap.  In that case the parent
  * ioend it was split from is recorded in ioend->io_parent.
  */
 struct iomap_ioend {
@@ -416,7 +415,7 @@ static inline struct iomap_ioend *iomap_ioend_from_bio(struct bio *bio)
 
 struct iomap_writeback_ops {
 	/*
-	 * Required, performs writeback on the passed in range
+	 * Performs writeback on the passed in range
 	 *
 	 * Can map arbitrarily large regions, but we need to call into it at
 	 * least once per folio to allow the file systems to synchronize with
@@ -432,23 +431,22 @@ struct iomap_writeback_ops {
 			u64 end_pos);
 
 	/*
-	 * Optional, allows the file systems to hook into bio submission,
-	 * including overriding the bi_end_io handler.
+	 * Submit a writeback context previously build up by ->writeback_range.
 	 *
-	 * Returns 0 if the bio was successfully submitted, or a negative
-	 * error code if status was non-zero or another error happened and
-	 * the bio could not be submitted.
+	 * Returns 0 if the context was successfully submitted, or a negative
+	 * error code if not.  If @error is non-zero a failure occurred, and
+	 * the writeback context should be completed with an error.
 	 */
-	int (*submit_ioend)(struct iomap_writepage_ctx *wpc, int status);
+	int (*writeback_submit)(struct iomap_writepage_ctx *wpc, int error);
 };
 
 struct iomap_writepage_ctx {
 	struct iomap		iomap;
 	struct inode		*inode;
 	struct writeback_control *wbc;
-	struct iomap_ioend	*ioend;
 	const struct iomap_writeback_ops *ops;
 	u32			nr_folios;	/* folios added to the ioend */
+	void			*wb_ctx;	/* pending writeback context */
 };
 
 struct iomap_ioend *iomap_init_ioend(struct inode *inode, struct bio *bio,
@@ -461,6 +459,7 @@ void iomap_ioend_try_merge(struct iomap_ioend *ioend,
 void iomap_sort_ioends(struct list_head *ioend_list);
 ssize_t iomap_add_to_ioend(struct iomap_writepage_ctx *wpc, struct folio *folio,
 		loff_t pos, loff_t end_pos, unsigned int dirty_len);
+int iomap_ioend_writeback_submit(struct iomap_writepage_ctx *wpc, int error);
 
 int iomap_writepages(struct iomap_writepage_ctx *wpc);
 
-- 
2.47.2


