Return-Path: <linux-fsdevel+bounces-29862-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E26D997EE23
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2024 17:29:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4DA0280FBE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2024 15:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D56519E969;
	Mon, 23 Sep 2024 15:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SxhfjviS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1B9199FC6;
	Mon, 23 Sep 2024 15:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727105358; cv=none; b=RKdj/GE5/A6vjHCs97r7a10j+kvSBFVC2tawW0Xwvqdf37oRsY/nK74omm4uHotD6cAwVYI9B2/b17+YQ7BAxpM9bl2cgpXyOgRPp1T74qz2wz410UlMkUoqMWyB3KURLTfYssOKRHm/uQsGJs2rYiR4uildBVaOHeOcsgBG3k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727105358; c=relaxed/simple;
	bh=5Nyid8LeJ2PQ0uM4Mq/jcHgW8bdyiGBNg9FuLtWB80Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V7VeA41fPzfZ5Ye9tnKl61/GwqbKMHHaxhp3oJgPIuZNzYd0g9NPsWh4RvTIvTLaSx5edzILHUivHUZn9p+GbhZnCfX/wEl+3Lfe0Xrg0Mbc1Oqwn5Wv07Rtr8Weoa43vqAgWAgBCfUxdZdp0+wJrtXuzwCt0fCBX7mYCYV8Lyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=SxhfjviS; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=vsBkE7Z+aYwkRCwrXgDrnOyF63ZJTLz2d9kHm5MNezA=; b=SxhfjviSSiUxuVLDfKScL/nH/2
	6fgIEe763bv8Eqmb25s7V+FVI08H24CYc84OtN9XwlCxxONSO6vvwT4UZc/+G1BsoOI8otB+TCtG2
	YaErEBL3w27h7gDxf2xUOXEQSJlWO5o9uE/ykM0eBv0Qc/OLvgyy/+SVEWgKw6p9qmMjPDsFdwlFD
	WtQCG5X9eXU/Wi3jF4kPkiUF9BpBkt5jRdGBJQVxGRcY9FKYyqvXJHm9jxo1iiW24kaaQTchN14TL
	+UZZRkOYeLBw0k8y1GDlmpLLnK5bOrbqXg0PJYHykOYKe9AdtbNzlPHCLVZKxIBRR8lN7zwG8FzaV
	o1UFwLiQ==;
Received: from 2a02-8389-2341-5b80-4c13-f559-77bd-3c36.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:4c13:f559:77bd:3c36] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1ssl00-0000000HV7d-1SkL;
	Mon, 23 Sep 2024 15:29:16 +0000
From: Christoph Hellwig <hch@lst.de>
To: Chandan Babu R <chandan.babu@oracle.com>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>
Cc: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 02/10] iomap: remove iomap_file_buffered_write_punch_delalloc
Date: Mon, 23 Sep 2024 17:28:16 +0200
Message-ID: <20240923152904.1747117-3-hch@lst.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240923152904.1747117-1-hch@lst.de>
References: <20240923152904.1747117-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Currently iomap_file_buffered_write_punch_delalloc can be called from
XFS either with the invalidate lock held or not.  To fix this while
keeping the locking in the file system and not the iomap library
code we'll need to life the locking up into the file system.

To prepare for that, open code iomap_file_buffered_write_punch_delalloc
in the only caller, and instead export iomap_write_delalloc_release.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 .../filesystems/iomap/operations.rst          |  2 +-
 fs/iomap/buffered-io.c                        | 85 ++++++-------------
 fs/xfs/xfs_iomap.c                            | 16 +++-
 include/linux/iomap.h                         |  6 +-
 4 files changed, 46 insertions(+), 63 deletions(-)

diff --git a/Documentation/filesystems/iomap/operations.rst b/Documentation/filesystems/iomap/operations.rst
index 8e6c721d233010..b93115ab8748ae 100644
--- a/Documentation/filesystems/iomap/operations.rst
+++ b/Documentation/filesystems/iomap/operations.rst
@@ -208,7 +208,7 @@ The filesystem must arrange to `cancel
 such `reservations
 <https://lore.kernel.org/linux-xfs/20220817093627.GZ3600936@dread.disaster.area/>`_
 because writeback will not consume the reservation.
-The ``iomap_file_buffered_write_punch_delalloc`` can be called from a
+The ``iomap_write_delalloc_release`` can be called from a
 ``->iomap_end`` function to find all the clean areas of the folios
 caching a fresh (``IOMAP_F_NEW``) delalloc mapping.
 It takes the ``invalidate_lock``.
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 884891ac7a226c..237aeb883166df 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1149,6 +1149,32 @@ static void iomap_write_delalloc_scan(struct inode *inode,
  * have dirty data still pending in the page cache - those are going to be
  * written and so must still retain the delalloc backing for writeback.
  *
+ * When a short write occurs, the filesystem may need to remove reserved space
+ * that was allocated in ->iomap_begin from it's ->iomap_end method. For
+ * filesystems that use delayed allocation, we need to punch out delalloc
+ * extents from the range that are not dirty in the page cache. As the write can
+ * race with page faults, there can be dirty pages over the delalloc extent
+ * outside the range of a short write but still within the delalloc extent
+ * allocated for this iomap.
+ *
+ * The punch() callback *must* only punch delalloc extents in the range passed
+ * to it. It must skip over all other types of extents in the range and leave
+ * them completely unchanged. It must do this punch atomically with respect to
+ * other extent modifications.
+ *
+ * The punch() callback may be called with a folio locked to prevent writeback
+ * extent allocation racing at the edge of the range we are currently punching.
+ * The locked folio may or may not cover the range being punched, so it is not
+ * safe for the punch() callback to lock folios itself.
+ *
+ * Lock order is:
+ *
+ * inode->i_rwsem (shared or exclusive)
+ *   inode->i_mapping->invalidate_lock (exclusive)
+ *     folio_lock()
+ *       ->punch
+ *         internal filesystem allocation lock
+ *
  * As we are scanning the page cache for data, we don't need to reimplement the
  * wheel - mapping_seek_hole_data() does exactly what we need to identify the
  * start and end of data ranges correctly even for sub-folio block sizes. This
@@ -1177,7 +1203,7 @@ static void iomap_write_delalloc_scan(struct inode *inode,
  * require sprinkling this code with magic "+ 1" and "- 1" arithmetic and expose
  * the code to subtle off-by-one bugs....
  */
-static void iomap_write_delalloc_release(struct inode *inode, loff_t start_byte,
+void iomap_write_delalloc_release(struct inode *inode, loff_t start_byte,
 		loff_t end_byte, unsigned flags, struct iomap *iomap,
 		iomap_punch_t punch)
 {
@@ -1243,62 +1269,7 @@ static void iomap_write_delalloc_release(struct inode *inode, loff_t start_byte,
 out_unlock:
 	filemap_invalidate_unlock(inode->i_mapping);
 }
-
-/*
- * When a short write occurs, the filesystem may need to remove reserved space
- * that was allocated in ->iomap_begin from it's ->iomap_end method. For
- * filesystems that use delayed allocation, we need to punch out delalloc
- * extents from the range that are not dirty in the page cache. As the write can
- * race with page faults, there can be dirty pages over the delalloc extent
- * outside the range of a short write but still within the delalloc extent
- * allocated for this iomap.
- *
- * This function uses [start_byte, end_byte) intervals (i.e. open ended) to
- * simplify range iterations.
- *
- * The punch() callback *must* only punch delalloc extents in the range passed
- * to it. It must skip over all other types of extents in the range and leave
- * them completely unchanged. It must do this punch atomically with respect to
- * other extent modifications.
- *
- * The punch() callback may be called with a folio locked to prevent writeback
- * extent allocation racing at the edge of the range we are currently punching.
- * The locked folio may or may not cover the range being punched, so it is not
- * safe for the punch() callback to lock folios itself.
- *
- * Lock order is:
- *
- * inode->i_rwsem (shared or exclusive)
- *   inode->i_mapping->invalidate_lock (exclusive)
- *     folio_lock()
- *       ->punch
- *         internal filesystem allocation lock
- */
-void iomap_file_buffered_write_punch_delalloc(struct inode *inode,
-		loff_t pos, loff_t length, ssize_t written, unsigned flags,
-		struct iomap *iomap, iomap_punch_t punch)
-{
-	loff_t			start_byte;
-	loff_t			end_byte;
-
-	if (iomap->type != IOMAP_DELALLOC)
-		return;
-
-	/* If we didn't reserve the blocks, we're not allowed to punch them. */
-	if (!(iomap->flags & IOMAP_F_NEW))
-		return;
-
-	start_byte = iomap_last_written_block(inode, pos, written);
-	end_byte = round_up(pos + length, i_blocksize(inode));
-
-	/* Nothing to do if we've written the entire delalloc extent */
-	if (start_byte >= end_byte)
-		return;
-
-	iomap_write_delalloc_release(inode, start_byte, end_byte, flags, iomap,
-			punch);
-}
-EXPORT_SYMBOL_GPL(iomap_file_buffered_write_punch_delalloc);
+EXPORT_SYMBOL_GPL(iomap_write_delalloc_release);
 
 static loff_t iomap_unshare_iter(struct iomap_iter *iter)
 {
diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index 1e11f48814c0d0..30f2530b6d5461 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -1227,8 +1227,20 @@ xfs_buffered_write_iomap_end(
 	unsigned		flags,
 	struct iomap		*iomap)
 {
-	iomap_file_buffered_write_punch_delalloc(inode, offset, length, written,
-			flags, iomap, &xfs_buffered_write_delalloc_punch);
+	loff_t			start_byte, end_byte;
+
+	/* If we didn't reserve the blocks, we're not allowed to punch them. */
+	if (iomap->type != IOMAP_DELALLOC || !(iomap->flags & IOMAP_F_NEW))
+		return 0;
+
+	/* Nothing to do if we've written the entire delalloc extent */
+	start_byte = iomap_last_written_block(inode, offset, written);
+	end_byte = round_up(offset + length, i_blocksize(inode));
+	if (start_byte >= end_byte)
+		return 0;
+
+	iomap_write_delalloc_release(inode, start_byte, end_byte, flags, iomap,
+			xfs_buffered_write_delalloc_punch);
 	return 0;
 }
 
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index e62df5d93f04de..137e0783faa224 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -290,9 +290,9 @@ vm_fault_t iomap_page_mkwrite(struct vm_fault *vmf,
 
 typedef void (*iomap_punch_t)(struct inode *inode, loff_t offset, loff_t length,
 		struct iomap *iomap);
-void iomap_file_buffered_write_punch_delalloc(struct inode *inode, loff_t pos,
-		loff_t length, ssize_t written, unsigned flag,
-		struct iomap *iomap, iomap_punch_t punch);
+void iomap_write_delalloc_release(struct inode *inode, loff_t start_byte,
+		loff_t end_byte, unsigned flags, struct iomap *iomap,
+		iomap_punch_t punch);
 
 int iomap_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 		u64 start, u64 len, const struct iomap_ops *ops);
-- 
2.45.2


