Return-Path: <linux-fsdevel+bounces-28990-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8D7197286D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2024 06:40:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43F721F24B91
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2024 04:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D61216F265;
	Tue, 10 Sep 2024 04:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vGPMft8F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1ECE14387B;
	Tue, 10 Sep 2024 04:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725943218; cv=none; b=IrP5codM+jyKhObh97vX5XVeydTxsJ669ud57KucSVOUOC5os6uLGb7aWaqCaN+vsSXV8vtDitmcl63Z6X0VEEnhDa4bcwfiKhElC3D8TlQP5Q6aWSya/qRu8KQ93wzIhpTXVHtPyVy2vD0cFIGfF5G58J9/P2/zsDcfQJ6a6Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725943218; c=relaxed/simple;
	bh=70+Wcka9+GBYoG8f/XigPLkasSkXav3gnsyLnSWOo/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YA9gQm8hoxdgfK8PKZA+mm8xQHmwHPKy2V0HhyzzMdFkWzobbMABAsLmWNE8MF4cp/wIoU4kZ+7m9Ell9BPu4Hfff4fmSIKExtE4cma/BfoMTHEfaKQSPgtoKkraVoUgG75kSF6HV8nFuHG/370TVgbw3iVNzocUQ3JlDqpDQFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=vGPMft8F; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=alHtqqHMYZYhp2fPP5QMgr7McVc5xeCT7aBN71/bjr4=; b=vGPMft8FGIwZo9ia+xLaV5DKQ4
	62UfcscSSalrDo8ihQU+7+gdn0U6aqbGbopRkMtCwqeFMC8LiDJpji3rF2ovIvAjuMNl9G0WaM1IL
	7oH9AhY379v6A/CxPuL57tIYzWH0iwfCHdO5xtU9b8cd8pV5OS3NLym6S/9i92YPQ38wC2Q4GvIzA
	JmoNTvRBLaT9LtDUeiQijZi4Q0DuJs6ZYK8cn0hSoxEdMRe0LKbSCjTGAR/1VZPCAdmetv0cmZr6h
	kDDHhnCVWh5iFehV3Vp0iuszXfH0My2N/on5lyE8YWHsg7P9lU4NmhU1rkp/mIpZiyscklLHh3ZVC
	HHmqs9GQ==;
Received: from ppp-2-84-49-240.home.otenet.gr ([2.84.49.240] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1snsfn-00000004ErO-2VcM;
	Tue, 10 Sep 2024 04:40:16 +0000
From: Christoph Hellwig <hch@lst.de>
To: Chandan Babu R <chandan.babu@oracle.com>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>
Cc: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 05/12] iomap: remove the iomap_file_buffered_write_punch_delalloc return value
Date: Tue, 10 Sep 2024 07:39:07 +0300
Message-ID: <20240910043949.3481298-6-hch@lst.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240910043949.3481298-1-hch@lst.de>
References: <20240910043949.3481298-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

iomap_file_buffered_write_punch_delalloc can only return errors if either
the ->punch callback returned an error, or if someone changed the API of
mapping_seek_hole_data to return a negative error code that is not
-ENXIO.

As the only instance of ->punch never returns an error, an such an error
would be fatal anyway remove the entire error propagation and don't
return an error code from iomap_file_buffered_write_punch_delalloc.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/iomap/buffered-io.c | 82 +++++++++++++++---------------------------
 fs/xfs/xfs_iomap.c     | 17 ++-------
 include/linux/iomap.h  |  4 +--
 3 files changed, 33 insertions(+), 70 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index a0bc7c3654cc36..52f285ae4bddcb 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1045,7 +1045,7 @@ iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter *i,
 }
 EXPORT_SYMBOL_GPL(iomap_file_buffered_write);
 
-static int iomap_write_delalloc_ifs_punch(struct inode *inode,
+static void iomap_write_delalloc_ifs_punch(struct inode *inode,
 		struct folio *folio, loff_t start_byte, loff_t end_byte,
 		struct iomap *iomap, iomap_punch_t punch)
 {
@@ -1053,7 +1053,6 @@ static int iomap_write_delalloc_ifs_punch(struct inode *inode,
 	loff_t last_byte;
 	u8 blkbits = inode->i_blkbits;
 	struct iomap_folio_state *ifs;
-	int ret = 0;
 
 	/*
 	 * When we have per-block dirty tracking, there can be
@@ -1063,47 +1062,35 @@ static int iomap_write_delalloc_ifs_punch(struct inode *inode,
 	 */
 	ifs = folio->private;
 	if (!ifs)
-		return ret;
+		return;
 
 	last_byte = min_t(loff_t, end_byte - 1,
 			folio_pos(folio) + folio_size(folio) - 1);
 	first_blk = offset_in_folio(folio, start_byte) >> blkbits;
 	last_blk = offset_in_folio(folio, last_byte) >> blkbits;
 	for (i = first_blk; i <= last_blk; i++) {
-		if (!ifs_block_is_dirty(folio, ifs, i)) {
-			ret = punch(inode, folio_pos(folio) + (i << blkbits),
+		if (!ifs_block_is_dirty(folio, ifs, i))
+			punch(inode, folio_pos(folio) + (i << blkbits),
 				    1 << blkbits, iomap);
-			if (ret)
-				return ret;
-		}
 	}
-
-	return ret;
 }
 
-
-static int iomap_write_delalloc_punch(struct inode *inode, struct folio *folio,
+static void iomap_write_delalloc_punch(struct inode *inode, struct folio *folio,
 		loff_t *punch_start_byte, loff_t start_byte, loff_t end_byte,
 		struct iomap *iomap, iomap_punch_t punch)
 {
-	int ret = 0;
-
 	if (!folio_test_dirty(folio))
-		return ret;
+		return;
 
 	/* if dirty, punch up to offset */
 	if (start_byte > *punch_start_byte) {
-		ret = punch(inode, *punch_start_byte,
-				start_byte - *punch_start_byte, iomap);
-		if (ret)
-			return ret;
+		punch(inode, *punch_start_byte, start_byte - *punch_start_byte,
+				iomap);
 	}
 
 	/* Punch non-dirty blocks within folio */
-	ret = iomap_write_delalloc_ifs_punch(inode, folio, start_byte, end_byte,
+	iomap_write_delalloc_ifs_punch(inode, folio, start_byte, end_byte,
 			iomap, punch);
-	if (ret)
-		return ret;
 
 	/*
 	 * Make sure the next punch start is correctly bound to
@@ -1111,8 +1098,6 @@ static int iomap_write_delalloc_punch(struct inode *inode, struct folio *folio,
 	 */
 	*punch_start_byte = min_t(loff_t, end_byte,
 				folio_pos(folio) + folio_size(folio));
-
-	return ret;
 }
 
 /*
@@ -1132,13 +1117,12 @@ static int iomap_write_delalloc_punch(struct inode *inode, struct folio *folio,
  * This function uses [start_byte, end_byte) intervals (i.e. open ended) to
  * simplify range iterations.
  */
-static int iomap_write_delalloc_scan(struct inode *inode,
+static void iomap_write_delalloc_scan(struct inode *inode,
 		loff_t *punch_start_byte, loff_t start_byte, loff_t end_byte,
 		struct iomap *iomap, iomap_punch_t punch)
 {
 	while (start_byte < end_byte) {
 		struct folio	*folio;
-		int ret;
 
 		/* grab locked page */
 		folio = filemap_lock_folio(inode->i_mapping,
@@ -1149,20 +1133,14 @@ static int iomap_write_delalloc_scan(struct inode *inode,
 			continue;
 		}
 
-		ret = iomap_write_delalloc_punch(inode, folio, punch_start_byte,
+		iomap_write_delalloc_punch(inode, folio, punch_start_byte,
 				start_byte, end_byte, iomap, punch);
-		if (ret) {
-			folio_unlock(folio);
-			folio_put(folio);
-			return ret;
-		}
 
 		/* move offset to start of next folio in range */
 		start_byte = folio_next_index(folio) << PAGE_SHIFT;
 		folio_unlock(folio);
 		folio_put(folio);
 	}
-	return 0;
 }
 
 /*
@@ -1198,13 +1176,12 @@ static int iomap_write_delalloc_scan(struct inode *inode,
  * require sprinkling this code with magic "+ 1" and "- 1" arithmetic and expose
  * the code to subtle off-by-one bugs....
  */
-static int iomap_write_delalloc_release(struct inode *inode, loff_t start_byte,
+static void iomap_write_delalloc_release(struct inode *inode, loff_t start_byte,
 		loff_t end_byte, unsigned flags, struct iomap *iomap,
 		iomap_punch_t punch)
 {
 	loff_t punch_start_byte = start_byte;
 	loff_t scan_end_byte = min(i_size_read(inode), end_byte);
-	int error = 0;
 
 	/*
 	 * Lock the mapping to avoid races with page faults re-instantiating
@@ -1221,13 +1198,15 @@ static int iomap_write_delalloc_release(struct inode *inode, loff_t start_byte,
 		/*
 		 * If there is no more data to scan, all that is left is to
 		 * punch out the remaining range.
+		 *
+		 * Note that mapping_seek_hole_data is only supposed to return
+		 * either an offset or -ENXIO, so WARN on any other error as
+		 * that would be an API change without updating the callers.
 		 */
 		if (start_byte == -ENXIO || start_byte == scan_end_byte)
 			break;
-		if (start_byte < 0) {
-			error = start_byte;
+		if (WARN_ON_ONCE(start_byte < 0))
 			goto out_unlock;
-		}
 		WARN_ON_ONCE(start_byte < punch_start_byte);
 		WARN_ON_ONCE(start_byte > scan_end_byte);
 
@@ -1237,10 +1216,8 @@ static int iomap_write_delalloc_release(struct inode *inode, loff_t start_byte,
 		 */
 		data_end = mapping_seek_hole_data(inode->i_mapping, start_byte,
 				scan_end_byte, SEEK_HOLE);
-		if (data_end < 0) {
-			error = data_end;
+		if (WARN_ON_ONCE(data_end < 0))
 			goto out_unlock;
-		}
 
 		/*
 		 * If we race with post-direct I/O invalidation of the page cache,
@@ -1252,21 +1229,18 @@ static int iomap_write_delalloc_release(struct inode *inode, loff_t start_byte,
 		WARN_ON_ONCE(data_end < start_byte);
 		WARN_ON_ONCE(data_end > scan_end_byte);
 
-		error = iomap_write_delalloc_scan(inode, &punch_start_byte,
-				start_byte, data_end, iomap, punch);
-		if (error)
-			goto out_unlock;
+		iomap_write_delalloc_scan(inode, &punch_start_byte, start_byte,
+				data_end, iomap, punch);
 
 		/* The next data search starts at the end of this one. */
 		start_byte = data_end;
 	}
 
 	if (punch_start_byte < end_byte)
-		error = punch(inode, punch_start_byte,
-				end_byte - punch_start_byte, iomap);
+		punch(inode, punch_start_byte, end_byte - punch_start_byte,
+				iomap);
 out_unlock:
 	filemap_invalidate_unlock(inode->i_mapping);
-	return error;
 }
 
 /*
@@ -1299,7 +1273,7 @@ static int iomap_write_delalloc_release(struct inode *inode, loff_t start_byte,
  *       ->punch
  *         internal filesystem allocation lock
  */
-int iomap_file_buffered_write_punch_delalloc(struct inode *inode,
+void iomap_file_buffered_write_punch_delalloc(struct inode *inode,
 		loff_t pos, loff_t length, ssize_t written, unsigned flags,
 		struct iomap *iomap, iomap_punch_t punch)
 {
@@ -1308,11 +1282,11 @@ int iomap_file_buffered_write_punch_delalloc(struct inode *inode,
 	unsigned int		blocksize = i_blocksize(inode);
 
 	if (iomap->type != IOMAP_DELALLOC)
-		return 0;
+		return;
 
 	/* If we didn't reserve the blocks, we're not allowed to punch them. */
 	if (!(iomap->flags & IOMAP_F_NEW))
-		return 0;
+		return;
 
 	/*
 	 * start_byte refers to the first unused block after a short write. If
@@ -1327,10 +1301,10 @@ int iomap_file_buffered_write_punch_delalloc(struct inode *inode,
 
 	/* Nothing to do if we've written the entire delalloc extent */
 	if (start_byte >= end_byte)
-		return 0;
+		return;
 
-	return iomap_write_delalloc_release(inode, start_byte, end_byte, flags,
-					iomap, punch);
+	iomap_write_delalloc_release(inode, start_byte, end_byte, flags, iomap,
+			punch);
 }
 EXPORT_SYMBOL_GPL(iomap_file_buffered_write_punch_delalloc);
 
diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index 695e5bee776f94..1e11f48814c0d0 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -1208,7 +1208,7 @@ xfs_buffered_write_iomap_begin(
 	return error;
 }
 
-static int
+static void
 xfs_buffered_write_delalloc_punch(
 	struct inode		*inode,
 	loff_t			offset,
@@ -1216,7 +1216,6 @@ xfs_buffered_write_delalloc_punch(
 	struct iomap		*iomap)
 {
 	xfs_bmap_punch_delalloc_range(XFS_I(inode), offset, offset + length);
-	return 0;
 }
 
 static int
@@ -1228,18 +1227,8 @@ xfs_buffered_write_iomap_end(
 	unsigned		flags,
 	struct iomap		*iomap)
 {
-
-	struct xfs_mount	*mp = XFS_M(inode->i_sb);
-	int			error;
-
-	error = iomap_file_buffered_write_punch_delalloc(inode, offset, length,
-			written, flags, iomap,
-			&xfs_buffered_write_delalloc_punch);
-	if (error && !xfs_is_shutdown(mp)) {
-		xfs_alert(mp, "%s: unable to clean up ino 0x%llx",
-			__func__, XFS_I(inode)->i_ino);
-		return error;
-	}
+	iomap_file_buffered_write_punch_delalloc(inode, offset, length, written,
+			flags, iomap, &xfs_buffered_write_delalloc_punch);
 	return 0;
 }
 
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index a931190f6d858b..78a48af4d2c0a1 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -274,9 +274,9 @@ int iomap_truncate_page(struct inode *inode, loff_t pos, bool *did_zero,
 vm_fault_t iomap_page_mkwrite(struct vm_fault *vmf,
 			const struct iomap_ops *ops);
 
-typedef int (*iomap_punch_t)(struct inode *inode, loff_t offset, loff_t length,
+typedef void (*iomap_punch_t)(struct inode *inode, loff_t offset, loff_t length,
 		struct iomap *iomap);
-int iomap_file_buffered_write_punch_delalloc(struct inode *inode, loff_t pos,
+void iomap_file_buffered_write_punch_delalloc(struct inode *inode, loff_t pos,
 		loff_t length, ssize_t written, unsigned flag,
 		struct iomap *iomap, iomap_punch_t punch);
 
-- 
2.45.2


