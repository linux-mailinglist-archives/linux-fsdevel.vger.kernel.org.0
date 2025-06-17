Return-Path: <linux-fsdevel+bounces-51881-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3355BADC8C8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 12:55:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07C4F7A7326
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 10:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48E582DBF47;
	Tue, 17 Jun 2025 10:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Y2OM91LS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180452D9EFC;
	Tue, 17 Jun 2025 10:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750157722; cv=none; b=LzQdrxLlqEjL3Vnvs9kVGqjX2KESifQabf0Egc9v58B6bNhxqpIQKeemX/H5G3q+4nwZqFDUewNoGfChjiZqLnhIfApk5PSBdE2qk020lKcXwTMTzMXKYsKRxP7iJgSlCBiF6HcMeYeOnH24DzPy6Hr9agsug6kDVaYDTr07l0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750157722; c=relaxed/simple;
	bh=5yo+r1GFOK9j2U8TpSFRv4vbaf4nN5GzoH3ZtBOF/dY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HREw0MxCh0s0yIVTQBybk0pYopXokM1FXu0HQPeZdvDpHYnCGmuXHsBzq6/JwIz7p6txvnU6e1kQ7WmthrY34wZpV+MUjvo9vj3F/eo6P6kUT33irIezO9GpOxPXNDGONpj84otbQ17yXKeNoj7TRXBBoFN9umoTcEa9xbne+dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Y2OM91LS; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=TvWDYhKZRdbtiUux4MvRvLKS8mIVuEqks/wO+dn0A5U=; b=Y2OM91LSeY6SQzZ5fK6UqlZwEK
	O6wSynfg1WTDkNtJc7cKLIyWKpahLS77ZhNRvFWfcFRibi0xejuULIMxEbxbmCaVon/LChFqTlJgd
	dXGNjBVuOv07KwhQzKeE/ixZecneTnzAAB4P/xhAZtEAYga6VwxzqNbPHOP359G9ygPeuLp+ymrM9
	77UD9MXUWQFl78phr7+sopOIwlbV9Tl0YYqf0IughMXoZPlWCG9XnDE/wlW7Hyf/3Eeh8W/aPHcwA
	5EbpPCrHvWDeH4JOEuXl+a15CnZ8VOnQdC6lChkfB0ugidnA9r7mq3JFS3VWsQ0OhrO/hdOkLDsxb
	7F/TeBCw==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uRTyK-00000006ylK-0xn4;
	Tue, 17 Jun 2025 10:55:20 +0000
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Joanne Koong <joannelkoong@gmail.com>,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-block@vger.kernel.org,
	gfs2@lists.linux.dev
Subject: [PATCH 01/11] iomap: pass more arguments using struct iomap_writepage_ctx
Date: Tue, 17 Jun 2025 12:55:00 +0200
Message-ID: <20250617105514.3393938-2-hch@lst.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250617105514.3393938-1-hch@lst.de>
References: <20250617105514.3393938-1-hch@lst.de>
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

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/fops.c           |  8 +++++--
 fs/gfs2/aops.c         |  8 +++++--
 fs/iomap/buffered-io.c | 52 +++++++++++++++++++-----------------------
 fs/xfs/xfs_aops.c      | 24 +++++++++++++------
 fs/zonefs/file.c       |  8 +++++--
 include/linux/iomap.h  |  6 ++---
 6 files changed, 61 insertions(+), 45 deletions(-)

diff --git a/block/fops.c b/block/fops.c
index 1309861d4c2c..3394263d942b 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -558,9 +558,13 @@ static const struct iomap_writeback_ops blkdev_writeback_ops = {
 static int blkdev_writepages(struct address_space *mapping,
 		struct writeback_control *wbc)
 {
-	struct iomap_writepage_ctx wpc = { };
+	struct iomap_writepage_ctx wpc = {
+		.inode		= mapping->host,
+		.wbc		= wbc,
+		.ops		= &blkdev_writeback_ops
+	};
 
-	return iomap_writepages(mapping, wbc, &wpc, &blkdev_writeback_ops);
+	return iomap_writepages(&wpc);
 }
 
 const struct address_space_operations def_blk_aops = {
diff --git a/fs/gfs2/aops.c b/fs/gfs2/aops.c
index 14f204cd5a82..47d74afd63ac 100644
--- a/fs/gfs2/aops.c
+++ b/fs/gfs2/aops.c
@@ -159,7 +159,11 @@ static int gfs2_writepages(struct address_space *mapping,
 			   struct writeback_control *wbc)
 {
 	struct gfs2_sbd *sdp = gfs2_mapping2sbd(mapping);
-	struct iomap_writepage_ctx wpc = { };
+	struct iomap_writepage_ctx wpc = {
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
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 3729391a18f3..71ad17bf827f 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1626,20 +1626,19 @@ static int iomap_submit_ioend(struct iomap_writepage_ctx *wpc, int error)
 }
 
 static struct iomap_ioend *iomap_alloc_ioend(struct iomap_writepage_ctx *wpc,
-		struct writeback_control *wbc, struct inode *inode, loff_t pos,
-		u16 ioend_flags)
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
 
 static bool iomap_can_add_to_ioend(struct iomap_writepage_ctx *wpc, loff_t pos,
@@ -1678,9 +1677,7 @@ static bool iomap_can_add_to_ioend(struct iomap_writepage_ctx *wpc, loff_t pos,
  * writepage context that the caller will need to submit.
  */
 static int iomap_add_to_ioend(struct iomap_writepage_ctx *wpc,
-		struct writeback_control *wbc, struct folio *folio,
-		struct inode *inode, loff_t pos, loff_t end_pos,
-		unsigned len)
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
 
 static int iomap_writepage_map_blocks(struct iomap_writepage_ctx *wpc,
-		struct writeback_control *wbc, struct folio *folio,
-		struct inode *inode, u64 pos, u64 end_pos,
-		unsigned dirty_len, unsigned *count)
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
@@ -1870,10 +1866,10 @@ static bool iomap_writepage_handle_eof(struct folio *folio, struct inode *inode,
 }
 
 static int iomap_writepage_map(struct iomap_writepage_ctx *wpc,
-		struct writeback_control *wbc, struct folio *folio)
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
+iomap_writepages(struct iomap_writepage_ctx *wpc)
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
index 63151feb9c3f..65485a52df3b 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
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
index 42e2c0065bb3..edca4bbe4b72 100644
--- a/fs/zonefs/file.c
+++ b/fs/zonefs/file.c
@@ -152,9 +152,13 @@ static const struct iomap_writeback_ops zonefs_writeback_ops = {
 static int zonefs_writepages(struct address_space *mapping,
 			     struct writeback_control *wbc)
 {
-	struct iomap_writepage_ctx wpc = { };
+	struct iomap_writepage_ctx wpc = {
+		.inode		= mapping->host,
+		.wbc		= wbc,
+		.ops		= &zonefs_writeback_ops,
+	};
 
-	return iomap_writepages(mapping, wbc, &wpc, &zonefs_writeback_ops);
+	return iomap_writepages(&wpc);
 }
 
 static int zonefs_swap_activate(struct swap_info_struct *sis,
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 522644d62f30..00179c9387c5 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -448,6 +448,8 @@ struct iomap_writeback_ops {
 
 struct iomap_writepage_ctx {
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
+int iomap_writepages(struct iomap_writepage_ctx *wpc);
 
 /*
  * Flags for direct I/O ->end_io:
-- 
2.47.2


