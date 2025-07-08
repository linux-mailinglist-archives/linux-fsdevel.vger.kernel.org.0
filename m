Return-Path: <linux-fsdevel+bounces-54258-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C53D1AFCCA2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 15:53:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30BE27ABF6C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 13:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B17A2E091C;
	Tue,  8 Jul 2025 13:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="y4Jq3Ee+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CCAE2E0904;
	Tue,  8 Jul 2025 13:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751982729; cv=none; b=EwheyWLCPFBvT34FLqgmZOrgPmCFSQZD0XRvr8vNTMp+IQsMVt3GGfgSzRC8z0bXefl3W8xC57RFfU1qGK/8XtNcw+JGLRsaNJ9gtnBW132QMALzqtrPaxOrAqxZLKoOSIxCGC7WrcB5/5uiDc3xfJuVabhL6V6qEyEBw824E5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751982729; c=relaxed/simple;
	bh=GIa+dzmeEYrJbJfIchnXb6+jRP8jyySWan2K6NBorVY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Df8a/BOGfky1ruHC5LDLGmh73SuDBOVv6rdjL4Fz3cc/z+KPp2bPq7atsqXQjPzbmeD8T84nyxPjRoHC+2Hne3mJZhiExEda0EQctj/WcW6vD/rbe7eAZo1L6pT6gthWuAuFhSPqdn7TRt6hJpdI0hwBV4T/z9b9y+gxgEDvaJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=y4Jq3Ee+; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=kAjSWTf6fjP2eoYC531I6kB9F3WlF22F9MRqoIMs7cQ=; b=y4Jq3Ee+JEAy9byz7Ita8gL2Gz
	ve/AMz1mIzcUcIu526QusG1NC2nGTllSy5+y5sExxiC1yocE9+845YOR4ybq/dGylI5EcjmpRF4i0
	WF6CHgiYPTDMUNqEszqGCY3lOoDdTvALzvpSYLw9dfPkGdAQ/oEtcCGe3qsJFGJAelmtFw+tOl3hb
	UiB0B1mABm3Poa5MpU++8TAz3UwsVVoq1TbvzfwHqIxPnx7Hexd5G9wQPh2g8sqZnyfVs95DshJdP
	xRE+v4FkM2uJ0aniIJSEOaKEvifDXPEdDwd3iE2X5IVaWySOGYN1hEq7afdmN4LSznNEl41rRtYOf
	Y/6GD7mA==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZ8ju-00000005UVT-2Zsn;
	Tue, 08 Jul 2025 13:52:07 +0000
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
Subject: [PATCH 11/14] iomap: replace iomap_folio_ops with iomap_write_ops
Date: Tue,  8 Jul 2025 15:51:17 +0200
Message-ID: <20250708135132.3347932-12-hch@lst.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250708135132.3347932-1-hch@lst.de>
References: <20250708135132.3347932-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

The iomap_folio_ops are only used for buffered writes, including the zero
and unshare variants.  Rename them to iomap_write_ops to better describe
the usage, and pass them through the call chain like the other operation
specific methods instead of through the iomap.

xfs_iomap_valid grows a IOMAP_HOLE check to keep the existing behavior
that never attached the folio_ops to a iomap representing a hole.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Brian Foster <bfoster@redhat.com>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Acked-by: Damien Le Moal <dlemoal@kernel.org>
---
 Documentation/filesystems/iomap/design.rst    |  3 -
 .../filesystems/iomap/operations.rst          |  8 +-
 block/fops.c                                  |  3 +-
 fs/gfs2/bmap.c                                | 21 ++---
 fs/gfs2/bmap.h                                |  1 +
 fs/gfs2/file.c                                |  3 +-
 fs/iomap/buffered-io.c                        | 79 +++++++++++--------
 fs/xfs/xfs_file.c                             |  6 +-
 fs/xfs/xfs_iomap.c                            | 12 ++-
 fs/xfs/xfs_iomap.h                            |  1 +
 fs/xfs/xfs_reflink.c                          |  3 +-
 fs/zonefs/file.c                              |  3 +-
 include/linux/iomap.h                         | 22 +++---
 13 files changed, 89 insertions(+), 76 deletions(-)

diff --git a/Documentation/filesystems/iomap/design.rst b/Documentation/filesystems/iomap/design.rst
index f2df9b6df988..0f7672676c0b 100644
--- a/Documentation/filesystems/iomap/design.rst
+++ b/Documentation/filesystems/iomap/design.rst
@@ -167,7 +167,6 @@ structure below:
      struct dax_device   *dax_dev;
      void                *inline_data;
      void                *private;
-     const struct iomap_folio_ops *folio_ops;
      u64                 validity_cookie;
  };
 
@@ -292,8 +291,6 @@ The fields are as follows:
    <https://lore.kernel.org/all/20180619164137.13720-7-hch@lst.de/>`_.
    This value will be passed unchanged to ``->iomap_end``.
 
- * ``folio_ops`` will be covered in the section on pagecache operations.
-
  * ``validity_cookie`` is a magic freshness value set by the filesystem
    that should be used to detect stale mappings.
    For pagecache operations this is critical for correct operation
diff --git a/Documentation/filesystems/iomap/operations.rst b/Documentation/filesystems/iomap/operations.rst
index 4b93c5f7841a..a9b48ce4af92 100644
--- a/Documentation/filesystems/iomap/operations.rst
+++ b/Documentation/filesystems/iomap/operations.rst
@@ -57,16 +57,12 @@ The following address space operations can be wrapped easily:
  * ``bmap``
  * ``swap_activate``
 
-``struct iomap_folio_ops``
+``struct iomap_write_ops``
 --------------------------
 
-The ``->iomap_begin`` function for pagecache operations may set the
-``struct iomap::folio_ops`` field to an ops structure to override
-default behaviors of iomap:
-
 .. code-block:: c
 
- struct iomap_folio_ops {
+ struct iomap_write_ops {
      struct folio *(*get_folio)(struct iomap_iter *iter, loff_t pos,
                                 unsigned len);
      void (*put_folio)(struct inode *inode, loff_t pos, unsigned copied,
diff --git a/block/fops.c b/block/fops.c
index 0845737c0320..0c2c010ff303 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -723,7 +723,8 @@ blkdev_direct_write(struct kiocb *iocb, struct iov_iter *from)
 
 static ssize_t blkdev_buffered_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	return iomap_file_buffered_write(iocb, from, &blkdev_iomap_ops, NULL);
+	return iomap_file_buffered_write(iocb, from, &blkdev_iomap_ops, NULL,
+			NULL);
 }
 
 /*
diff --git a/fs/gfs2/bmap.c b/fs/gfs2/bmap.c
index 86045d3577b7..131091520de6 100644
--- a/fs/gfs2/bmap.c
+++ b/fs/gfs2/bmap.c
@@ -963,12 +963,16 @@ static struct folio *
 gfs2_iomap_get_folio(struct iomap_iter *iter, loff_t pos, unsigned len)
 {
 	struct inode *inode = iter->inode;
+	struct gfs2_inode *ip = GFS2_I(inode);
 	unsigned int blockmask = i_blocksize(inode) - 1;
 	struct gfs2_sbd *sdp = GFS2_SB(inode);
 	unsigned int blocks;
 	struct folio *folio;
 	int status;
 
+	if (!gfs2_is_jdata(ip) && !gfs2_is_stuffed(ip))
+		return iomap_get_folio(iter, pos, len);
+
 	blocks = ((pos & blockmask) + len + blockmask) >> inode->i_blkbits;
 	status = gfs2_trans_begin(sdp, RES_DINODE + blocks, 0);
 	if (status)
@@ -987,7 +991,7 @@ static void gfs2_iomap_put_folio(struct inode *inode, loff_t pos,
 	struct gfs2_inode *ip = GFS2_I(inode);
 	struct gfs2_sbd *sdp = GFS2_SB(inode);
 
-	if (!gfs2_is_stuffed(ip))
+	if (gfs2_is_jdata(ip) && !gfs2_is_stuffed(ip))
 		gfs2_trans_add_databufs(ip->i_gl, folio,
 					offset_in_folio(folio, pos),
 					copied);
@@ -995,13 +999,14 @@ static void gfs2_iomap_put_folio(struct inode *inode, loff_t pos,
 	folio_unlock(folio);
 	folio_put(folio);
 
-	if (tr->tr_num_buf_new)
-		__mark_inode_dirty(inode, I_DIRTY_DATASYNC);
-
-	gfs2_trans_end(sdp);
+	if (gfs2_is_jdata(ip) || gfs2_is_stuffed(ip)) {
+		if (tr->tr_num_buf_new)
+			__mark_inode_dirty(inode, I_DIRTY_DATASYNC);
+		gfs2_trans_end(sdp);
+	}
 }
 
-static const struct iomap_folio_ops gfs2_iomap_folio_ops = {
+const struct iomap_write_ops gfs2_iomap_write_ops = {
 	.get_folio = gfs2_iomap_get_folio,
 	.put_folio = gfs2_iomap_put_folio,
 };
@@ -1078,8 +1083,6 @@ static int gfs2_iomap_begin_write(struct inode *inode, loff_t pos,
 		gfs2_trans_end(sdp);
 	}
 
-	if (gfs2_is_stuffed(ip) || gfs2_is_jdata(ip))
-		iomap->folio_ops = &gfs2_iomap_folio_ops;
 	return 0;
 
 out_trans_end:
@@ -1304,7 +1307,7 @@ static int gfs2_block_zero_range(struct inode *inode, loff_t from, loff_t length
 		return 0;
 	length = min(length, inode->i_size - from);
 	return iomap_zero_range(inode, from, length, NULL, &gfs2_iomap_ops,
-			NULL);
+			&gfs2_iomap_write_ops, NULL);
 }
 
 #define GFS2_JTRUNC_REVOKES 8192
diff --git a/fs/gfs2/bmap.h b/fs/gfs2/bmap.h
index 4e8b1e8ebdf3..6cdc72dd55a3 100644
--- a/fs/gfs2/bmap.h
+++ b/fs/gfs2/bmap.h
@@ -44,6 +44,7 @@ static inline void gfs2_write_calc_reserv(const struct gfs2_inode *ip,
 }
 
 extern const struct iomap_ops gfs2_iomap_ops;
+extern const struct iomap_write_ops gfs2_iomap_write_ops;
 extern const struct iomap_writeback_ops gfs2_writeback_ops;
 
 int gfs2_unstuff_dinode(struct gfs2_inode *ip);
diff --git a/fs/gfs2/file.c b/fs/gfs2/file.c
index fd1147aa3891..2908f5bee21d 100644
--- a/fs/gfs2/file.c
+++ b/fs/gfs2/file.c
@@ -1058,7 +1058,8 @@ static ssize_t gfs2_file_buffered_write(struct kiocb *iocb,
 	}
 
 	pagefault_disable();
-	ret = iomap_file_buffered_write(iocb, from, &gfs2_iomap_ops, NULL);
+	ret = iomap_file_buffered_write(iocb, from, &gfs2_iomap_ops,
+			&gfs2_iomap_write_ops, NULL);
 	pagefault_enable();
 	if (ret > 0)
 		written += ret;
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index ddb4363359e2..b04c00dd6768 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -732,28 +732,27 @@ static int __iomap_write_begin(const struct iomap_iter *iter, size_t len,
 	return 0;
 }
 
-static struct folio *__iomap_get_folio(struct iomap_iter *iter, size_t len)
+static struct folio *__iomap_get_folio(struct iomap_iter *iter,
+		const struct iomap_write_ops *write_ops, size_t len)
 {
-	const struct iomap_folio_ops *folio_ops = iter->iomap.folio_ops;
 	loff_t pos = iter->pos;
 
 	if (!mapping_large_folio_support(iter->inode->i_mapping))
 		len = min_t(size_t, len, PAGE_SIZE - offset_in_page(pos));
 
-	if (folio_ops && folio_ops->get_folio)
-		return folio_ops->get_folio(iter, pos, len);
-	else
-		return iomap_get_folio(iter, pos, len);
+	if (write_ops && write_ops->get_folio)
+		return write_ops->get_folio(iter, pos, len);
+	return iomap_get_folio(iter, pos, len);
 }
 
-static void __iomap_put_folio(struct iomap_iter *iter, size_t ret,
+static void __iomap_put_folio(struct iomap_iter *iter,
+		const struct iomap_write_ops *write_ops, size_t ret,
 		struct folio *folio)
 {
-	const struct iomap_folio_ops *folio_ops = iter->iomap.folio_ops;
 	loff_t pos = iter->pos;
 
-	if (folio_ops && folio_ops->put_folio) {
-		folio_ops->put_folio(iter->inode, pos, ret, folio);
+	if (write_ops && write_ops->put_folio) {
+		write_ops->put_folio(iter->inode, pos, ret, folio);
 	} else {
 		folio_unlock(folio);
 		folio_put(folio);
@@ -790,10 +789,10 @@ static int iomap_write_begin_inline(const struct iomap_iter *iter,
  * offset, and length. Callers can optionally pass a max length *plen,
  * otherwise init to zero.
  */
-static int iomap_write_begin(struct iomap_iter *iter, struct folio **foliop,
+static int iomap_write_begin(struct iomap_iter *iter,
+		const struct iomap_write_ops *write_ops, struct folio **foliop,
 		size_t *poffset, u64 *plen)
 {
-	const struct iomap_folio_ops *folio_ops = iter->iomap.folio_ops;
 	const struct iomap *srcmap = iomap_iter_srcmap(iter);
 	loff_t pos = iter->pos;
 	u64 len = min_t(u64, SIZE_MAX, iomap_length(iter));
@@ -808,7 +807,7 @@ static int iomap_write_begin(struct iomap_iter *iter, struct folio **foliop,
 	if (fatal_signal_pending(current))
 		return -EINTR;
 
-	folio = __iomap_get_folio(iter, len);
+	folio = __iomap_get_folio(iter, write_ops, len);
 	if (IS_ERR(folio))
 		return PTR_ERR(folio);
 
@@ -822,8 +821,8 @@ static int iomap_write_begin(struct iomap_iter *iter, struct folio **foliop,
 	 * could do the wrong thing here (zero a page range incorrectly or fail
 	 * to zero) and corrupt data.
 	 */
-	if (folio_ops && folio_ops->iomap_valid) {
-		bool iomap_valid = folio_ops->iomap_valid(iter->inode,
+	if (write_ops && write_ops->iomap_valid) {
+		bool iomap_valid = write_ops->iomap_valid(iter->inode,
 							 &iter->iomap);
 		if (!iomap_valid) {
 			iter->iomap.flags |= IOMAP_F_STALE;
@@ -849,8 +848,7 @@ static int iomap_write_begin(struct iomap_iter *iter, struct folio **foliop,
 	return 0;
 
 out_unlock:
-	__iomap_put_folio(iter, 0, folio);
-
+	__iomap_put_folio(iter, write_ops, 0, folio);
 	return status;
 }
 
@@ -922,7 +920,8 @@ static bool iomap_write_end(struct iomap_iter *iter, size_t len, size_t copied,
 	return __iomap_write_end(iter->inode, pos, len, copied, folio);
 }
 
-static int iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
+static int iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i,
+		const struct iomap_write_ops *write_ops)
 {
 	ssize_t total_written = 0;
 	int status = 0;
@@ -966,7 +965,8 @@ static int iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
 			break;
 		}
 
-		status = iomap_write_begin(iter, &folio, &offset, &bytes);
+		status = iomap_write_begin(iter, write_ops, &folio, &offset,
+				&bytes);
 		if (unlikely(status)) {
 			iomap_write_failed(iter->inode, iter->pos, bytes);
 			break;
@@ -995,7 +995,7 @@ static int iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
 			i_size_write(iter->inode, pos + written);
 			iter->iomap.flags |= IOMAP_F_SIZE_CHANGED;
 		}
-		__iomap_put_folio(iter, written, folio);
+		__iomap_put_folio(iter, write_ops, written, folio);
 
 		if (old_size < pos)
 			pagecache_isize_extended(iter->inode, old_size, pos);
@@ -1028,7 +1028,8 @@ static int iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
 
 ssize_t
 iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter *i,
-		const struct iomap_ops *ops, void *private)
+		const struct iomap_ops *ops,
+		const struct iomap_write_ops *write_ops, void *private)
 {
 	struct iomap_iter iter = {
 		.inode		= iocb->ki_filp->f_mapping->host,
@@ -1045,7 +1046,7 @@ iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter *i,
 		iter.flags |= IOMAP_DONTCACHE;
 
 	while ((ret = iomap_iter(&iter, ops)) > 0)
-		iter.status = iomap_write_iter(&iter, i);
+		iter.status = iomap_write_iter(&iter, i, write_ops);
 
 	if (unlikely(iter.pos == iocb->ki_pos))
 		return ret;
@@ -1279,7 +1280,8 @@ void iomap_write_delalloc_release(struct inode *inode, loff_t start_byte,
 }
 EXPORT_SYMBOL_GPL(iomap_write_delalloc_release);
 
-static int iomap_unshare_iter(struct iomap_iter *iter)
+static int iomap_unshare_iter(struct iomap_iter *iter,
+		const struct iomap_write_ops *write_ops)
 {
 	struct iomap *iomap = &iter->iomap;
 	u64 bytes = iomap_length(iter);
@@ -1294,14 +1296,15 @@ static int iomap_unshare_iter(struct iomap_iter *iter)
 		bool ret;
 
 		bytes = min_t(u64, SIZE_MAX, bytes);
-		status = iomap_write_begin(iter, &folio, &offset, &bytes);
+		status = iomap_write_begin(iter, write_ops, &folio, &offset,
+				&bytes);
 		if (unlikely(status))
 			return status;
 		if (iomap->flags & IOMAP_F_STALE)
 			break;
 
 		ret = iomap_write_end(iter, bytes, bytes, folio);
-		__iomap_put_folio(iter, bytes, folio);
+		__iomap_put_folio(iter, write_ops, bytes, folio);
 		if (WARN_ON_ONCE(!ret))
 			return -EIO;
 
@@ -1319,7 +1322,8 @@ static int iomap_unshare_iter(struct iomap_iter *iter)
 
 int
 iomap_file_unshare(struct inode *inode, loff_t pos, loff_t len,
-		const struct iomap_ops *ops)
+		const struct iomap_ops *ops,
+		const struct iomap_write_ops *write_ops)
 {
 	struct iomap_iter iter = {
 		.inode		= inode,
@@ -1334,7 +1338,7 @@ iomap_file_unshare(struct inode *inode, loff_t pos, loff_t len,
 
 	iter.len = min(len, size - pos);
 	while ((ret = iomap_iter(&iter, ops)) > 0)
-		iter.status = iomap_unshare_iter(&iter);
+		iter.status = iomap_unshare_iter(&iter, write_ops);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(iomap_file_unshare);
@@ -1353,7 +1357,8 @@ static inline int iomap_zero_iter_flush_and_stale(struct iomap_iter *i)
 	return filemap_write_and_wait_range(mapping, i->pos, end);
 }
 
-static int iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)
+static int iomap_zero_iter(struct iomap_iter *iter, bool *did_zero,
+		const struct iomap_write_ops *write_ops)
 {
 	u64 bytes = iomap_length(iter);
 	int status;
@@ -1364,7 +1369,8 @@ static int iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)
 		bool ret;
 
 		bytes = min_t(u64, SIZE_MAX, bytes);
-		status = iomap_write_begin(iter, &folio, &offset, &bytes);
+		status = iomap_write_begin(iter, write_ops, &folio, &offset,
+				&bytes);
 		if (status)
 			return status;
 		if (iter->iomap.flags & IOMAP_F_STALE)
@@ -1377,7 +1383,7 @@ static int iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)
 		folio_mark_accessed(folio);
 
 		ret = iomap_write_end(iter, bytes, bytes, folio);
-		__iomap_put_folio(iter, bytes, folio);
+		__iomap_put_folio(iter, write_ops, bytes, folio);
 		if (WARN_ON_ONCE(!ret))
 			return -EIO;
 
@@ -1393,7 +1399,8 @@ static int iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)
 
 int
 iomap_zero_range(struct inode *inode, loff_t pos, loff_t len, bool *did_zero,
-		const struct iomap_ops *ops, void *private)
+		const struct iomap_ops *ops,
+		const struct iomap_write_ops *write_ops, void *private)
 {
 	struct iomap_iter iter = {
 		.inode		= inode,
@@ -1423,7 +1430,8 @@ iomap_zero_range(struct inode *inode, loff_t pos, loff_t len, bool *did_zero,
 	    filemap_range_needs_writeback(mapping, pos, pos + plen - 1)) {
 		iter.len = plen;
 		while ((ret = iomap_iter(&iter, ops)) > 0)
-			iter.status = iomap_zero_iter(&iter, did_zero);
+			iter.status = iomap_zero_iter(&iter, did_zero,
+					write_ops);
 
 		iter.len = len - (iter.pos - pos);
 		if (ret || !iter.len)
@@ -1454,7 +1462,7 @@ iomap_zero_range(struct inode *inode, loff_t pos, loff_t len, bool *did_zero,
 			continue;
 		}
 
-		iter.status = iomap_zero_iter(&iter, did_zero);
+		iter.status = iomap_zero_iter(&iter, did_zero, write_ops);
 	}
 	return ret;
 }
@@ -1462,7 +1470,8 @@ EXPORT_SYMBOL_GPL(iomap_zero_range);
 
 int
 iomap_truncate_page(struct inode *inode, loff_t pos, bool *did_zero,
-		const struct iomap_ops *ops, void *private)
+		const struct iomap_ops *ops,
+		const struct iomap_write_ops *write_ops, void *private)
 {
 	unsigned int blocksize = i_blocksize(inode);
 	unsigned int off = pos & (blocksize - 1);
@@ -1471,7 +1480,7 @@ iomap_truncate_page(struct inode *inode, loff_t pos, bool *did_zero,
 	if (!off)
 		return 0;
 	return iomap_zero_range(inode, pos, blocksize - off, did_zero, ops,
-			private);
+			write_ops, private);
 }
 EXPORT_SYMBOL_GPL(iomap_truncate_page);
 
diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 0b41b18debf3..0cbeae61f3a4 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -979,7 +979,8 @@ xfs_file_buffered_write(
 
 	trace_xfs_file_buffered_write(iocb, from);
 	ret = iomap_file_buffered_write(iocb, from,
-			&xfs_buffered_write_iomap_ops, NULL);
+			&xfs_buffered_write_iomap_ops, &xfs_iomap_write_ops,
+			NULL);
 
 	/*
 	 * If we hit a space limit, try to free up some lingering preallocated
@@ -1059,7 +1060,8 @@ xfs_file_buffered_write_zoned(
 retry:
 	trace_xfs_file_buffered_write(iocb, from);
 	ret = iomap_file_buffered_write(iocb, from,
-			&xfs_buffered_write_iomap_ops, &ac);
+			&xfs_buffered_write_iomap_ops, &xfs_iomap_write_ops,
+			&ac);
 	if (ret == -ENOSPC && !cleared_space) {
 		/*
 		 * Kick off writeback to convert delalloc space and release the
diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index ff05e6b1b0bb..2e94a9435002 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -79,6 +79,9 @@ xfs_iomap_valid(
 {
 	struct xfs_inode	*ip = XFS_I(inode);
 
+	if (iomap->type == IOMAP_HOLE)
+		return true;
+
 	if (iomap->validity_cookie !=
 			xfs_iomap_inode_sequence(ip, iomap->flags)) {
 		trace_xfs_iomap_invalid(ip, iomap);
@@ -89,7 +92,7 @@ xfs_iomap_valid(
 	return true;
 }
 
-static const struct iomap_folio_ops xfs_iomap_folio_ops = {
+const struct iomap_write_ops xfs_iomap_write_ops = {
 	.iomap_valid		= xfs_iomap_valid,
 };
 
@@ -151,7 +154,6 @@ xfs_bmbt_to_iomap(
 		iomap->flags |= IOMAP_F_DIRTY;
 
 	iomap->validity_cookie = sequence_cookie;
-	iomap->folio_ops = &xfs_iomap_folio_ops;
 	return 0;
 }
 
@@ -2198,7 +2200,8 @@ xfs_zero_range(
 		return dax_zero_range(inode, pos, len, did_zero,
 				      &xfs_dax_write_iomap_ops);
 	return iomap_zero_range(inode, pos, len, did_zero,
-				&xfs_buffered_write_iomap_ops, ac);
+			&xfs_buffered_write_iomap_ops, &xfs_iomap_write_ops,
+			ac);
 }
 
 int
@@ -2214,5 +2217,6 @@ xfs_truncate_page(
 		return dax_truncate_page(inode, pos, did_zero,
 					&xfs_dax_write_iomap_ops);
 	return iomap_truncate_page(inode, pos, did_zero,
-				   &xfs_buffered_write_iomap_ops, ac);
+			&xfs_buffered_write_iomap_ops, &xfs_iomap_write_ops,
+			ac);
 }
diff --git a/fs/xfs/xfs_iomap.h b/fs/xfs/xfs_iomap.h
index 674f8ac1b9bd..ebcce7d49446 100644
--- a/fs/xfs/xfs_iomap.h
+++ b/fs/xfs/xfs_iomap.h
@@ -57,5 +57,6 @@ extern const struct iomap_ops xfs_seek_iomap_ops;
 extern const struct iomap_ops xfs_xattr_iomap_ops;
 extern const struct iomap_ops xfs_dax_write_iomap_ops;
 extern const struct iomap_ops xfs_atomic_write_cow_iomap_ops;
+extern const struct iomap_write_ops xfs_iomap_write_ops;
 
 #endif /* __XFS_IOMAP_H__*/
diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
index ad3bcb76d805..3f177b4ec131 100644
--- a/fs/xfs/xfs_reflink.c
+++ b/fs/xfs/xfs_reflink.c
@@ -1881,7 +1881,8 @@ xfs_reflink_unshare(
 				&xfs_dax_write_iomap_ops);
 	else
 		error = iomap_file_unshare(inode, offset, len,
-				&xfs_buffered_write_iomap_ops);
+				&xfs_buffered_write_iomap_ops,
+				&xfs_iomap_write_ops);
 	if (error)
 		goto out;
 
diff --git a/fs/zonefs/file.c b/fs/zonefs/file.c
index fee9403ad49b..24c29c10e27f 100644
--- a/fs/zonefs/file.c
+++ b/fs/zonefs/file.c
@@ -572,7 +572,8 @@ static ssize_t zonefs_file_buffered_write(struct kiocb *iocb,
 	if (ret <= 0)
 		goto inode_unlock;
 
-	ret = iomap_file_buffered_write(iocb, from, &zonefs_write_iomap_ops, NULL);
+	ret = iomap_file_buffered_write(iocb, from, &zonefs_write_iomap_ops,
+			NULL, NULL);
 	if (ret == -EIO)
 		zonefs_io_error(inode, true);
 
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index b65d3f063bb0..80f543cc4fe8 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -101,8 +101,6 @@ struct vm_fault;
  */
 #define IOMAP_NULL_ADDR -1ULL	/* addr is not valid */
 
-struct iomap_folio_ops;
-
 struct iomap {
 	u64			addr; /* disk offset of mapping, bytes */
 	loff_t			offset;	/* file offset of mapping, bytes */
@@ -113,7 +111,6 @@ struct iomap {
 	struct dax_device	*dax_dev; /* dax_dev for dax operations */
 	void			*inline_data;
 	void			*private; /* filesystem private */
-	const struct iomap_folio_ops *folio_ops;
 	u64			validity_cookie; /* used with .iomap_valid() */
 };
 
@@ -143,16 +140,11 @@ static inline bool iomap_inline_data_valid(const struct iomap *iomap)
 }
 
 /*
- * When a filesystem sets folio_ops in an iomap mapping it returns, get_folio
- * and put_folio will be called for each folio written to.  This only applies
- * to buffered writes as unbuffered writes will not typically have folios
- * associated with them.
- *
  * When get_folio succeeds, put_folio will always be called to do any
  * cleanup work necessary.  put_folio is responsible for unlocking and putting
  * @folio.
  */
-struct iomap_folio_ops {
+struct iomap_write_ops {
 	struct folio *(*get_folio)(struct iomap_iter *iter, loff_t pos,
 			unsigned len);
 	void (*put_folio)(struct inode *inode, loff_t pos, unsigned copied,
@@ -335,7 +327,8 @@ static inline bool iomap_want_unshare_iter(const struct iomap_iter *iter)
 }
 
 ssize_t iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter *from,
-		const struct iomap_ops *ops, void *private);
+		const struct iomap_ops *ops,
+		const struct iomap_write_ops *write_ops, void *private);
 int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops);
 void iomap_readahead(struct readahead_control *, const struct iomap_ops *ops);
 bool iomap_is_partially_uptodate(struct folio *, size_t from, size_t count);
@@ -344,11 +337,14 @@ bool iomap_release_folio(struct folio *folio, gfp_t gfp_flags);
 void iomap_invalidate_folio(struct folio *folio, size_t offset, size_t len);
 bool iomap_dirty_folio(struct address_space *mapping, struct folio *folio);
 int iomap_file_unshare(struct inode *inode, loff_t pos, loff_t len,
-		const struct iomap_ops *ops);
+		const struct iomap_ops *ops,
+		const struct iomap_write_ops *write_ops);
 int iomap_zero_range(struct inode *inode, loff_t pos, loff_t len,
-		bool *did_zero, const struct iomap_ops *ops, void *private);
+		bool *did_zero, const struct iomap_ops *ops,
+		const struct iomap_write_ops *write_ops, void *private);
 int iomap_truncate_page(struct inode *inode, loff_t pos, bool *did_zero,
-		const struct iomap_ops *ops, void *private);
+		const struct iomap_ops *ops,
+		const struct iomap_write_ops *write_ops, void *private);
 vm_fault_t iomap_page_mkwrite(struct vm_fault *vmf, const struct iomap_ops *ops,
 		void *private);
 typedef void (*iomap_punch_t)(struct inode *inode, loff_t offset, loff_t length,
-- 
2.47.2


