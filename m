Return-Path: <linux-fsdevel+bounces-53142-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF36AAEAF89
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jun 2025 09:03:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C1CC566656
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jun 2025 07:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 409A421C182;
	Fri, 27 Jun 2025 07:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Hq/VRJxS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC75BBA27;
	Fri, 27 Jun 2025 07:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751007816; cv=none; b=eR136xn8xDb1+1ESlKGNr5wYZgHXd1ByiC42i/LAzm+IvM+8Rek6cXpxlB+muRW7AP/1IXsUxbGvUGtk9ncKP+y+PDPu/O1Ldk4Szo7sljnd53eGvFp/ql/EfyJSaoahSLA5+myvv7wA5V8Vwh84WCkobNbmRUoxHb5zNwlRTW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751007816; c=relaxed/simple;
	bh=FTmn98o/k79GVbaSmiisfTo//RqSx81gLtGMRxM9RX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JFV1oXVs+sqfCfEG5lgyNbLMG+YlRt/ME4gKuZxT9D0PUh9Qngf1FbKVhR82q1nmoWiBTAKh3e+6lDhf62c6K96HdgD/M9ARhN29NQbx373qRrhv8dlp06uJBTOzrXEGNVxmbTSCbWd7dWuYIdNc3dDWc7Er6r1UBPbp3DHsfeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Hq/VRJxS; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=PRJjqVsXo/lP3J/VxAVtJRauVKT4s1YI0u6oIfjDCyg=; b=Hq/VRJxSbD4u0wHdcAguET1icY
	D0WdzGolUd76+Au6CTd9+RrIBHy/bHoMsO1Zs4rWbp2o2q6asRI+vsWjrqPlnbvdAgVLgPZtONpyj
	QX9/OoW7IYdgg6k+3BiZeqCDrc/7orp/mMm4efqniVwU7FfOyQFEqWWKddJjLxWazHc0bVfJVkixX
	9jeJ1cN98I9rZRKqoxgWBREMwkRiiVCW3b08WVUkTAgUKDq0VVzZElE5Gng4AcZGHY9Ra+huWRVUf
	JobX0eMBIYBPpByDBqrhcEJF/HomMp8bflSLy3/qqYUwxfS8TybHho+bF3fYP0y+xuTxD/udwahtU
	fBYH+U0Q==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uV37W-0000000Dlsk-03kx;
	Fri, 27 Jun 2025 07:03:34 +0000
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Joanne Koong <joannelkoong@gmail.com>,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-block@vger.kernel.org,
	gfs2@lists.linux.dev,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 01/12] iomap: pass more arguments using the iomap writeback context
Date: Fri, 27 Jun 2025 09:02:34 +0200
Message-ID: <20250627070328.975394-2-hch@lst.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250627070328.975394-1-hch@lst.de>
References: <20250627070328.975394-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Add inode and wpc fields to pass the inode and writeback context that
are needed in the entire writeback call chain, and let the callers
initialize all fields in the writeback context before calling
iomap_writepages to simplify the argument passing.

Rename iomap_writepage_ctx to iomap_writeback_ctx given that the
writepage method has been removed we're touching most users of the
structure here.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 .../filesystems/iomap/operations.rst          |  4 +-
 block/fops.c                                  | 10 ++-
 fs/gfs2/aops.c                                |  8 ++-
 fs/gfs2/bmap.c                                |  2 +-
 fs/iomap/buffered-io.c                        | 64 +++++++++----------
 fs/xfs/xfs_aops.c                             | 42 +++++++-----
 fs/zonefs/file.c                              | 10 ++-
 include/linux/iomap.h                         | 14 ++--
 8 files changed, 85 insertions(+), 69 deletions(-)

diff --git a/Documentation/filesystems/iomap/operations.rst b/Documentation/filesystems/iomap/operations.rst
index 3b628e370d88..52c2e23e0e76 100644
--- a/Documentation/filesystems/iomap/operations.rst
+++ b/Documentation/filesystems/iomap/operations.rst
@@ -283,9 +283,9 @@ The ``ops`` structure must be specified and is as follows:
 .. code-block:: c
 
  struct iomap_writeback_ops {
-     int (*map_blocks)(struct iomap_writepage_ctx *wpc, struct inode *inode,
+     int (*map_blocks)(struct iomap_writeback_ctx *wpc, struct inode *inode,
                        loff_t offset, unsigned len);
-     int (*submit_ioend)(struct iomap_writepage_ctx *wpc, int status);
+     int (*submit_ioend)(struct iomap_writeback_ctx *wpc, int status);
      void (*discard_folio)(struct folio *folio, loff_t pos);
  };
 
diff --git a/block/fops.c b/block/fops.c
index 1309861d4c2c..00af678aaa3a 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -537,7 +537,7 @@ static void blkdev_readahead(struct readahead_control *rac)
 	iomap_readahead(rac, &blkdev_iomap_ops);
 }
 
-static int blkdev_map_blocks(struct iomap_writepage_ctx *wpc,
+static int blkdev_map_blocks(struct iomap_writeback_ctx *wpc,
 		struct inode *inode, loff_t offset, unsigned int len)
 {
 	loff_t isize = i_size_read(inode);
@@ -558,9 +558,13 @@ static const struct iomap_writeback_ops blkdev_writeback_ops = {
 static int blkdev_writepages(struct address_space *mapping,
 		struct writeback_control *wbc)
 {
-	struct iomap_writepage_ctx wpc = { };
+	struct iomap_writeback_ctx wpc = {
+		.inode		= mapping->host,
+		.wbc		= wbc,
+		.ops		= &blkdev_writeback_ops
+	};
 
-	return iomap_writepages(mapping, wbc, &wpc, &blkdev_writeback_ops);
+	return iomap_writepages(&wpc);
 }
 
 const struct address_space_operations def_blk_aops = {
diff --git a/fs/gfs2/aops.c b/fs/gfs2/aops.c
index 14f204cd5a82..9340418a2be4 100644
--- a/fs/gfs2/aops.c
+++ b/fs/gfs2/aops.c
@@ -159,7 +159,11 @@ static int gfs2_writepages(struct address_space *mapping,
 			   struct writeback_control *wbc)
 {
 	struct gfs2_sbd *sdp = gfs2_mapping2sbd(mapping);
-	struct iomap_writepage_ctx wpc = { };
+	struct iomap_writeback_ctx wpc = {
+		.inode		= mapping->host,
+		.wbc		= wbc,
+		.ops		= &gfs2_writeback_ops,
+	};
 	int ret;
 
 	/*
@@ -168,7 +172,7 @@ static int gfs2_writepages(struct address_space *mapping,
 	 * want balance_dirty_pages() to loop indefinitely trying to write out
 	 * pages held in the ail that it can't find.
 	 */
-	ret = iomap_writepages(mapping, wbc, &wpc, &gfs2_writeback_ops);
+	ret = iomap_writepages(&wpc);
 	if (ret == 0 && wbc->nr_to_write > 0)
 		set_bit(SDF_FORCE_AIL_FLUSH, &sdp->sd_flags);
 	return ret;
diff --git a/fs/gfs2/bmap.c b/fs/gfs2/bmap.c
index 7703d0471139..77a505e7a017 100644
--- a/fs/gfs2/bmap.c
+++ b/fs/gfs2/bmap.c
@@ -2469,7 +2469,7 @@ int __gfs2_punch_hole(struct file *file, loff_t offset, loff_t length)
 	return error;
 }
 
-static int gfs2_map_blocks(struct iomap_writepage_ctx *wpc, struct inode *inode,
+static int gfs2_map_blocks(struct iomap_writeback_ctx *wpc, struct inode *inode,
 		loff_t offset, unsigned int len)
 {
 	int ret;
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 3729391a18f3..b5162e0323d0 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1596,7 +1596,7 @@ static void iomap_writepage_end_bio(struct bio *bio)
  * with the error status here to run the normal I/O completion handler to clear
  * the writeback bit and let the file system proess the errors.
  */
-static int iomap_submit_ioend(struct iomap_writepage_ctx *wpc, int error)
+static int iomap_submit_ioend(struct iomap_writeback_ctx *wpc, int error)
 {
 	if (!wpc->ioend)
 		return error;
@@ -1625,24 +1625,23 @@ static int iomap_submit_ioend(struct iomap_writepage_ctx *wpc, int error)
 	return error;
 }
 
-static struct iomap_ioend *iomap_alloc_ioend(struct iomap_writepage_ctx *wpc,
-		struct writeback_control *wbc, struct inode *inode, loff_t pos,
-		u16 ioend_flags)
+static struct iomap_ioend *iomap_alloc_ioend(struct iomap_writeback_ctx *wpc,
+		loff_t pos, u16 ioend_flags)
 {
 	struct bio *bio;
 
 	bio = bio_alloc_bioset(wpc->iomap.bdev, BIO_MAX_VECS,
-			       REQ_OP_WRITE | wbc_to_write_flags(wbc),
+			       REQ_OP_WRITE | wbc_to_write_flags(wpc->wbc),
 			       GFP_NOFS, &iomap_ioend_bioset);
 	bio->bi_iter.bi_sector = iomap_sector(&wpc->iomap, pos);
 	bio->bi_end_io = iomap_writepage_end_bio;
-	bio->bi_write_hint = inode->i_write_hint;
-	wbc_init_bio(wbc, bio);
+	bio->bi_write_hint = wpc->inode->i_write_hint;
+	wbc_init_bio(wpc->wbc, bio);
 	wpc->nr_folios = 0;
-	return iomap_init_ioend(inode, bio, pos, ioend_flags);
+	return iomap_init_ioend(wpc->inode, bio, pos, ioend_flags);
 }
 
-static bool iomap_can_add_to_ioend(struct iomap_writepage_ctx *wpc, loff_t pos,
+static bool iomap_can_add_to_ioend(struct iomap_writeback_ctx *wpc, loff_t pos,
 		u16 ioend_flags)
 {
 	if (ioend_flags & IOMAP_IOEND_BOUNDARY)
@@ -1677,10 +1676,8 @@ static bool iomap_can_add_to_ioend(struct iomap_writepage_ctx *wpc, loff_t pos,
  * At the end of a writeback pass, there will be a cached ioend remaining on the
  * writepage context that the caller will need to submit.
  */
-static int iomap_add_to_ioend(struct iomap_writepage_ctx *wpc,
-		struct writeback_control *wbc, struct folio *folio,
-		struct inode *inode, loff_t pos, loff_t end_pos,
-		unsigned len)
+static int iomap_add_to_ioend(struct iomap_writeback_ctx *wpc,
+		struct folio *folio, loff_t pos, loff_t end_pos, unsigned len)
 {
 	struct iomap_folio_state *ifs = folio->private;
 	size_t poff = offset_in_folio(folio, pos);
@@ -1701,8 +1698,7 @@ static int iomap_add_to_ioend(struct iomap_writepage_ctx *wpc,
 		error = iomap_submit_ioend(wpc, 0);
 		if (error)
 			return error;
-		wpc->ioend = iomap_alloc_ioend(wpc, wbc, inode, pos,
-				ioend_flags);
+		wpc->ioend = iomap_alloc_ioend(wpc, pos, ioend_flags);
 	}
 
 	if (!bio_add_folio(&wpc->ioend->io_bio, folio, len, poff))
@@ -1756,24 +1752,24 @@ static int iomap_add_to_ioend(struct iomap_writepage_ctx *wpc,
 	if (wpc->ioend->io_offset + wpc->ioend->io_size > end_pos)
 		wpc->ioend->io_size = end_pos - wpc->ioend->io_offset;
 
-	wbc_account_cgroup_owner(wbc, folio, len);
+	wbc_account_cgroup_owner(wpc->wbc, folio, len);
 	return 0;
 }
 
-static int iomap_writepage_map_blocks(struct iomap_writepage_ctx *wpc,
-		struct writeback_control *wbc, struct folio *folio,
-		struct inode *inode, u64 pos, u64 end_pos,
-		unsigned dirty_len, unsigned *count)
+static int iomap_writepage_map_blocks(struct iomap_writeback_ctx *wpc,
+		struct folio *folio, u64 pos, u64 end_pos, unsigned dirty_len,
+		unsigned *count)
 {
 	int error;
 
 	do {
 		unsigned map_len;
 
-		error = wpc->ops->map_blocks(wpc, inode, pos, dirty_len);
+		error = wpc->ops->map_blocks(wpc, wpc->inode, pos, dirty_len);
 		if (error)
 			break;
-		trace_iomap_writepage_map(inode, pos, dirty_len, &wpc->iomap);
+		trace_iomap_writepage_map(wpc->inode, pos, dirty_len,
+				&wpc->iomap);
 
 		map_len = min_t(u64, dirty_len,
 			wpc->iomap.offset + wpc->iomap.length - pos);
@@ -1787,8 +1783,8 @@ static int iomap_writepage_map_blocks(struct iomap_writepage_ctx *wpc,
 		case IOMAP_HOLE:
 			break;
 		default:
-			error = iomap_add_to_ioend(wpc, wbc, folio, inode, pos,
-					end_pos, map_len);
+			error = iomap_add_to_ioend(wpc, folio, pos, end_pos,
+					map_len);
 			if (!error)
 				(*count)++;
 			break;
@@ -1869,11 +1865,11 @@ static bool iomap_writepage_handle_eof(struct folio *folio, struct inode *inode,
 	return true;
 }
 
-static int iomap_writepage_map(struct iomap_writepage_ctx *wpc,
-		struct writeback_control *wbc, struct folio *folio)
+static int iomap_writepage_map(struct iomap_writeback_ctx *wpc,
+		struct folio *folio)
 {
 	struct iomap_folio_state *ifs = folio->private;
-	struct inode *inode = folio->mapping->host;
+	struct inode *inode = wpc->inode;
 	u64 pos = folio_pos(folio);
 	u64 end_pos = pos + folio_size(folio);
 	u64 end_aligned = 0;
@@ -1920,8 +1916,8 @@ static int iomap_writepage_map(struct iomap_writepage_ctx *wpc,
 	 */
 	end_aligned = round_up(end_pos, i_blocksize(inode));
 	while ((rlen = iomap_find_dirty_range(folio, &pos, end_aligned))) {
-		error = iomap_writepage_map_blocks(wpc, wbc, folio, inode,
-				pos, end_pos, rlen, &count);
+		error = iomap_writepage_map_blocks(wpc, folio, pos, end_pos,
+				rlen, &count);
 		if (error)
 			break;
 		pos += rlen;
@@ -1957,10 +1953,9 @@ static int iomap_writepage_map(struct iomap_writepage_ctx *wpc,
 }
 
 int
-iomap_writepages(struct address_space *mapping, struct writeback_control *wbc,
-		struct iomap_writepage_ctx *wpc,
-		const struct iomap_writeback_ops *ops)
+iomap_writepages(struct iomap_writeback_ctx *wpc)
 {
+	struct address_space *mapping = wpc->inode->i_mapping;
 	struct folio *folio = NULL;
 	int error;
 
@@ -1972,9 +1967,8 @@ iomap_writepages(struct address_space *mapping, struct writeback_control *wbc,
 			PF_MEMALLOC))
 		return -EIO;
 
-	wpc->ops = ops;
-	while ((folio = writeback_iter(mapping, wbc, folio, &error)))
-		error = iomap_writepage_map(wpc, wbc, folio);
+	while ((folio = writeback_iter(mapping, wpc->wbc, folio, &error)))
+		error = iomap_writepage_map(wpc, folio);
 	return iomap_submit_ioend(wpc, error);
 }
 EXPORT_SYMBOL_GPL(iomap_writepages);
diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index 63151feb9c3f..81040b57a844 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -24,13 +24,13 @@
 #include "xfs_rtgroup.h"
 
 struct xfs_writepage_ctx {
-	struct iomap_writepage_ctx ctx;
+	struct iomap_writeback_ctx ctx;
 	unsigned int		data_seq;
 	unsigned int		cow_seq;
 };
 
 static inline struct xfs_writepage_ctx *
-XFS_WPC(struct iomap_writepage_ctx *ctx)
+XFS_WPC(struct iomap_writeback_ctx *ctx)
 {
 	return container_of(ctx, struct xfs_writepage_ctx, ctx);
 }
@@ -239,7 +239,7 @@ xfs_end_bio(
  */
 static bool
 xfs_imap_valid(
-	struct iomap_writepage_ctx	*wpc,
+	struct iomap_writeback_ctx	*wpc,
 	struct xfs_inode		*ip,
 	loff_t				offset)
 {
@@ -277,7 +277,7 @@ xfs_imap_valid(
 
 static int
 xfs_map_blocks(
-	struct iomap_writepage_ctx *wpc,
+	struct iomap_writeback_ctx *wpc,
 	struct inode		*inode,
 	loff_t			offset,
 	unsigned int		len)
@@ -457,7 +457,7 @@ xfs_ioend_needs_wq_completion(
 
 static int
 xfs_submit_ioend(
-	struct iomap_writepage_ctx *wpc,
+	struct iomap_writeback_ctx *wpc,
 	int			status)
 {
 	struct iomap_ioend	*ioend = wpc->ioend;
@@ -532,19 +532,19 @@ static const struct iomap_writeback_ops xfs_writeback_ops = {
 };
 
 struct xfs_zoned_writepage_ctx {
-	struct iomap_writepage_ctx	ctx;
+	struct iomap_writeback_ctx	ctx;
 	struct xfs_open_zone		*open_zone;
 };
 
 static inline struct xfs_zoned_writepage_ctx *
-XFS_ZWPC(struct iomap_writepage_ctx *ctx)
+XFS_ZWPC(struct iomap_writeback_ctx *ctx)
 {
 	return container_of(ctx, struct xfs_zoned_writepage_ctx, ctx);
 }
 
 static int
 xfs_zoned_map_blocks(
-	struct iomap_writepage_ctx *wpc,
+	struct iomap_writeback_ctx *wpc,
 	struct inode		*inode,
 	loff_t			offset,
 	unsigned int		len)
@@ -610,7 +610,7 @@ xfs_zoned_map_blocks(
 
 static int
 xfs_zoned_submit_ioend(
-	struct iomap_writepage_ctx *wpc,
+	struct iomap_writeback_ctx *wpc,
 	int			status)
 {
 	wpc->ioend->io_bio.bi_end_io = xfs_end_bio;
@@ -636,19 +636,29 @@ xfs_vm_writepages(
 	xfs_iflags_clear(ip, XFS_ITRUNCATED);
 
 	if (xfs_is_zoned_inode(ip)) {
-		struct xfs_zoned_writepage_ctx	xc = { };
+		struct xfs_zoned_writepage_ctx	xc = {
+			.ctx = {
+				.inode	= mapping->host,
+				.wbc	= wbc,
+				.ops	= &xfs_zoned_writeback_ops
+			},
+		};
 		int				error;
 
-		error = iomap_writepages(mapping, wbc, &xc.ctx,
-					 &xfs_zoned_writeback_ops);
+		error = iomap_writepages(&xc.ctx);
 		if (xc.open_zone)
 			xfs_open_zone_put(xc.open_zone);
 		return error;
 	} else {
-		struct xfs_writepage_ctx	wpc = { };
-
-		return iomap_writepages(mapping, wbc, &wpc.ctx,
-				&xfs_writeback_ops);
+		struct xfs_writepage_ctx	wpc = {
+			.ctx = {
+				.inode	= mapping->host,
+				.wbc	= wbc,
+				.ops	= &xfs_writeback_ops
+			},
+		};
+
+		return iomap_writepages(&wpc.ctx);
 	}
 }
 
diff --git a/fs/zonefs/file.c b/fs/zonefs/file.c
index 42e2c0065bb3..5a4b9f2711a9 100644
--- a/fs/zonefs/file.c
+++ b/fs/zonefs/file.c
@@ -124,7 +124,7 @@ static void zonefs_readahead(struct readahead_control *rac)
  * Map blocks for page writeback. This is used only on conventional zone files,
  * which implies that the page range can only be within the fixed inode size.
  */
-static int zonefs_write_map_blocks(struct iomap_writepage_ctx *wpc,
+static int zonefs_write_map_blocks(struct iomap_writeback_ctx *wpc,
 				   struct inode *inode, loff_t offset,
 				   unsigned int len)
 {
@@ -152,9 +152,13 @@ static const struct iomap_writeback_ops zonefs_writeback_ops = {
 static int zonefs_writepages(struct address_space *mapping,
 			     struct writeback_control *wbc)
 {
-	struct iomap_writepage_ctx wpc = { };
+	struct iomap_writeback_ctx wpc = {
+		.inode		= mapping->host,
+		.wbc		= wbc,
+		.ops		= &zonefs_writeback_ops,
+	};
 
-	return iomap_writepages(mapping, wbc, &wpc, &zonefs_writeback_ops);
+	return iomap_writepages(&wpc);
 }
 
 static int zonefs_swap_activate(struct swap_info_struct *sis,
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 522644d62f30..778d99f45ef1 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -15,7 +15,7 @@ struct fiemap_extent_info;
 struct inode;
 struct iomap_iter;
 struct iomap_dio;
-struct iomap_writepage_ctx;
+struct iomap_writeback_ctx;
 struct iov_iter;
 struct kiocb;
 struct page;
@@ -426,7 +426,7 @@ struct iomap_writeback_ops {
 	 * An existing mapping from a previous call to this method can be reused
 	 * by the file system if it is still valid.
 	 */
-	int (*map_blocks)(struct iomap_writepage_ctx *wpc, struct inode *inode,
+	int (*map_blocks)(struct iomap_writeback_ctx *wpc, struct inode *inode,
 			  loff_t offset, unsigned len);
 
 	/*
@@ -437,7 +437,7 @@ struct iomap_writeback_ops {
 	 * error code if status was non-zero or another error happened and
 	 * the bio could not be submitted.
 	 */
-	int (*submit_ioend)(struct iomap_writepage_ctx *wpc, int status);
+	int (*submit_ioend)(struct iomap_writeback_ctx *wpc, int status);
 
 	/*
 	 * Optional, allows the file system to discard state on a page where
@@ -446,8 +446,10 @@ struct iomap_writeback_ops {
 	void (*discard_folio)(struct folio *folio, loff_t pos);
 };
 
-struct iomap_writepage_ctx {
+struct iomap_writeback_ctx {
 	struct iomap		iomap;
+	struct inode		*inode;
+	struct writeback_control *wbc;
 	struct iomap_ioend	*ioend;
 	const struct iomap_writeback_ops *ops;
 	u32			nr_folios;	/* folios added to the ioend */
@@ -461,9 +463,7 @@ void iomap_finish_ioends(struct iomap_ioend *ioend, int error);
 void iomap_ioend_try_merge(struct iomap_ioend *ioend,
 		struct list_head *more_ioends);
 void iomap_sort_ioends(struct list_head *ioend_list);
-int iomap_writepages(struct address_space *mapping,
-		struct writeback_control *wbc, struct iomap_writepage_ctx *wpc,
-		const struct iomap_writeback_ops *ops);
+int iomap_writepages(struct iomap_writeback_ctx *wpc);
 
 /*
  * Flags for direct I/O ->end_io:
-- 
2.47.2


