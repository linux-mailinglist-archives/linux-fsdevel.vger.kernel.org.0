Return-Path: <linux-fsdevel+bounces-54261-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1895AFCCB5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 15:54:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67AB74A6C5A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 13:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE9D12E0B57;
	Tue,  8 Jul 2025 13:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GRtk+hdd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B946A2E093F;
	Tue,  8 Jul 2025 13:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751982736; cv=none; b=XsYykRcH1+zKG57nJ5+bQfxgu++gZzRo6mE3t01gHgZrlLUOSdYv3T0oawhCARR6+dX70XHUJS5r4yCifJmP4hmy+hMYfyFaV5tl5hDEtvv6Sei5ONE1L7EWmGH9uMiaF86oJFHTvbKdxoSARoJsgagjNjqOm7Rn5MtBffjgH6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751982736; c=relaxed/simple;
	bh=AIfX18Dx2xQKZaDDPd7SXuaUFiZZkT/PkH0gi4IZmLY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BlWEqggHnSPFmESx1oLPm6gBmGVDkNfbIt6mY1Y9uO2UBeiyQHLHtkfcsBfzNHP3ACioL+aw2c4P8XR/3xa+D8X2Y/4DPLSGPO2ga+6hnSTPkhYLuagEMowotDP2+GcB/QIVcpKR3MC6mRVCm4CEPchpjzqflTyQBEUL5KmyQE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=GRtk+hdd; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=2wAcNCmeBGt9znAerI8klzBcbqxnK/gvfylMkpZBNtg=; b=GRtk+hddMR1cpbkFBWGFX88j4S
	TA4PaE5i7xHNE09RD35qOBpnbsbmBsGydVNXs542yno5jrKfazDMLqWLuV9eEJdw0bdqoEXCto8CA
	7L6TXgtwnM7FriM76eBYB7Q+k1JOBYo65ZtZD1AsYtjYL+F1di2Plo4QvURKzydlqm6Re6Dom9dqH
	M6e6/b3lfNStEZAS6kGXaiwgZ2svZ4BghmKAQSizEi75BTJrsqzHJW5gWwSAq/Jo8km0SaQJfPtnM
	3tS1AHNc2WAYHFga0ULVtBMTvKNqgh7D0urEwx1HxkEAhUikCxJnn9J3eYKPej7sKNQ2kJ98+q6Va
	LuI5oOJg==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZ8k1-00000005UZF-3rtx;
	Tue, 08 Jul 2025 13:52:14 +0000
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Joanne Koong <joannelkoong@gmail.com>,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-block@vger.kernel.org,
	gfs2@lists.linux.dev
Subject: [PATCH 14/14] iomap: build the writeback code without CONFIG_BLOCK
Date: Tue,  8 Jul 2025 15:51:20 +0200
Message-ID: <20250708135132.3347932-15-hch@lst.de>
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

Allow fuse to use the iomap writeback code even when CONFIG_BLOCK is
not enabled.  Do this with an ifdef instead of a separate file to keep
the iomap_folio_state local to buffered-io.c.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/iomap/Makefile      |   6 +--
 fs/iomap/buffered-io.c | 113 ++++++++++++++++++++++-------------------
 2 files changed, 64 insertions(+), 55 deletions(-)

diff --git a/fs/iomap/Makefile b/fs/iomap/Makefile
index 69e8ebb41302..f7e1c8534c46 100644
--- a/fs/iomap/Makefile
+++ b/fs/iomap/Makefile
@@ -9,9 +9,9 @@ ccflags-y += -I $(src)		# needed for trace events
 obj-$(CONFIG_FS_IOMAP)		+= iomap.o
 
 iomap-y				+= trace.o \
-				   iter.o
-iomap-$(CONFIG_BLOCK)		+= buffered-io.o \
-				   direct-io.o \
+				   iter.o \
+				   buffered-io.o
+iomap-$(CONFIG_BLOCK)		+= direct-io.o \
 				   ioend.o \
 				   fiemap.o \
 				   seek.o
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index b885267828d8..3a94a6b34aa9 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -274,6 +274,46 @@ static void iomap_adjust_read_range(struct inode *inode, struct folio *folio,
 	*lenp = plen;
 }
 
+static inline bool iomap_block_needs_zeroing(const struct iomap_iter *iter,
+		loff_t pos)
+{
+	const struct iomap *srcmap = iomap_iter_srcmap(iter);
+
+	return srcmap->type != IOMAP_MAPPED ||
+		(srcmap->flags & IOMAP_F_NEW) ||
+		pos >= i_size_read(iter->inode);
+}
+
+/**
+ * iomap_read_inline_data - copy inline data into the page cache
+ * @iter: iteration structure
+ * @folio: folio to copy to
+ *
+ * Copy the inline data in @iter into @folio and zero out the rest of the folio.
+ * Only a single IOMAP_INLINE extent is allowed at the end of each file.
+ * Returns zero for success to complete the read, or the usual negative errno.
+ */
+static int iomap_read_inline_data(const struct iomap_iter *iter,
+		struct folio *folio)
+{
+	const struct iomap *iomap = iomap_iter_srcmap(iter);
+	size_t size = i_size_read(iter->inode) - iomap->offset;
+	size_t offset = offset_in_folio(folio, iomap->offset);
+
+	if (folio_test_uptodate(folio))
+		return 0;
+
+	if (WARN_ON_ONCE(size > iomap->length))
+		return -EIO;
+	if (offset > 0)
+		ifs_alloc(iter->inode, folio, iter->flags);
+
+	folio_fill_tail(folio, offset, iomap->inline_data, size);
+	iomap_set_range_uptodate(folio, offset, folio_size(folio) - offset);
+	return 0;
+}
+
+#ifdef CONFIG_BLOCK
 static void iomap_finish_folio_read(struct folio *folio, size_t off,
 		size_t len, int error)
 {
@@ -313,45 +353,6 @@ struct iomap_readpage_ctx {
 	struct readahead_control *rac;
 };
 
-/**
- * iomap_read_inline_data - copy inline data into the page cache
- * @iter: iteration structure
- * @folio: folio to copy to
- *
- * Copy the inline data in @iter into @folio and zero out the rest of the folio.
- * Only a single IOMAP_INLINE extent is allowed at the end of each file.
- * Returns zero for success to complete the read, or the usual negative errno.
- */
-static int iomap_read_inline_data(const struct iomap_iter *iter,
-		struct folio *folio)
-{
-	const struct iomap *iomap = iomap_iter_srcmap(iter);
-	size_t size = i_size_read(iter->inode) - iomap->offset;
-	size_t offset = offset_in_folio(folio, iomap->offset);
-
-	if (folio_test_uptodate(folio))
-		return 0;
-
-	if (WARN_ON_ONCE(size > iomap->length))
-		return -EIO;
-	if (offset > 0)
-		ifs_alloc(iter->inode, folio, iter->flags);
-
-	folio_fill_tail(folio, offset, iomap->inline_data, size);
-	iomap_set_range_uptodate(folio, offset, folio_size(folio) - offset);
-	return 0;
-}
-
-static inline bool iomap_block_needs_zeroing(const struct iomap_iter *iter,
-		loff_t pos)
-{
-	const struct iomap *srcmap = iomap_iter_srcmap(iter);
-
-	return srcmap->type != IOMAP_MAPPED ||
-		(srcmap->flags & IOMAP_F_NEW) ||
-		pos >= i_size_read(iter->inode);
-}
-
 static int iomap_readpage_iter(struct iomap_iter *iter,
 		struct iomap_readpage_ctx *ctx)
 {
@@ -544,6 +545,27 @@ void iomap_readahead(struct readahead_control *rac, const struct iomap_ops *ops)
 }
 EXPORT_SYMBOL_GPL(iomap_readahead);
 
+static int iomap_read_folio_range(const struct iomap_iter *iter,
+		struct folio *folio, loff_t pos, size_t len)
+{
+	const struct iomap *srcmap = iomap_iter_srcmap(iter);
+	struct bio_vec bvec;
+	struct bio bio;
+
+	bio_init(&bio, srcmap->bdev, &bvec, 1, REQ_OP_READ);
+	bio.bi_iter.bi_sector = iomap_sector(srcmap, pos);
+	bio_add_folio_nofail(&bio, folio, len, offset_in_folio(folio, pos));
+	return submit_bio_wait(&bio);
+}
+#else
+static int iomap_read_folio_range(const struct iomap_iter *iter,
+		struct folio *folio, loff_t pos, size_t len)
+{
+	WARN_ON_ONCE(1);
+	return -EIO;
+}
+#endif /* CONFIG_BLOCK */
+
 /*
  * iomap_is_partially_uptodate checks whether blocks within a folio are
  * uptodate or not.
@@ -657,19 +679,6 @@ iomap_write_failed(struct inode *inode, loff_t pos, unsigned len)
 					 pos + len - 1);
 }
 
-static int iomap_read_folio_range(const struct iomap_iter *iter,
-		struct folio *folio, loff_t pos, size_t len)
-{
-	const struct iomap *srcmap = iomap_iter_srcmap(iter);
-	struct bio_vec bvec;
-	struct bio bio;
-
-	bio_init(&bio, srcmap->bdev, &bvec, 1, REQ_OP_READ);
-	bio.bi_iter.bi_sector = iomap_sector(srcmap, pos);
-	bio_add_folio_nofail(&bio, folio, len, offset_in_folio(folio, pos));
-	return submit_bio_wait(&bio);
-}
-
 static int __iomap_write_begin(const struct iomap_iter *iter,
 		const struct iomap_write_ops *write_ops, size_t len,
 		struct folio *folio)
-- 
2.47.2


