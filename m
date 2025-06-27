Return-Path: <linux-fsdevel+bounces-53153-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F8DDAEAFBC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jun 2025 09:06:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 207B11889FDD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jun 2025 07:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60E7722759D;
	Fri, 27 Jun 2025 07:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PUIdvxai"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518E9218589;
	Fri, 27 Jun 2025 07:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751007849; cv=none; b=Q9XvCFcqA4m/M70hmhTOVh0oQ4RvXv5exL3IA+g08spdBjz+nKC1RHM4EtWBG8JbBkjDP68dtYrcp+IFnaaOmwtdrKXomI0V48TcNVtRqVVvjjbaKtwuFZAnVo6iB7Fbz/N84Hs87P2rx39Ppck82ay+xu3B3KZQcm38QTiWJ+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751007849; c=relaxed/simple;
	bh=98s2bo9d4mxifI3N8Nz1oL0jdryCLR+8yMY0o/4z+6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uORctraU3iRq17xCanyjHpqVC5i2/tI63zGrdqi/EXcby63rho4nIkEB/nxApMQSgPSMGkEjd9HSFhPIw7ReZ8X+dGcGvrmugfPiiZWJmAXjqTS1LL+LCBF59zagmEY+HieM0MsyxhrnywzGuAU5i1smcJyOaQRBk/fb8WKCZtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=PUIdvxai; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=vODCfsYmJIjTxX9KxBg6yzhdDJTc+YeXtNFQoQoPSSI=; b=PUIdvxai/2AFJ4R0RH8HXntW0/
	MgdX9CWNZGmP4zzV+4zUPMGH6B5hCW8z6ViOvy9hcWJynndlusStrc48BzXDB4kNAs4HDJHAjDKk8
	xll0Qlwrmfb24eI+0zaF2fUZ3IK52Ht7zCb9WMXn/1v7qWLqXN/9vLMuq3zJ+jPEt35S/kxZOaUvb
	nlIC841xTwaocDpV3Kn25dJMTUnp7Tr74iEo4MY9y30/JQGBv6sQYGB5wbPQgzPBjWLliA5Ex+bxR
	3ytGEjo4cRsRuXxi81I8Ox3TcbqZ2CdPhrbESqIlBcj9jwXjJd57WO/HjiO1iojrYftHFoqNnB6q1
	TDZvomVw==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uV383-0000000Dm4E-1rpt;
	Fri, 27 Jun 2025 07:04:08 +0000
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Joanne Koong <joannelkoong@gmail.com>,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-block@vger.kernel.org,
	gfs2@lists.linux.dev
Subject: [PATCH 12/12] iomap: build the writeback code without CONFIG_BLOCK
Date: Fri, 27 Jun 2025 09:02:45 +0200
Message-ID: <20250627070328.975394-13-hch@lst.de>
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

Allow fuse to use the iomap writeback code even when CONFIG_BLOCK is
not enabled.  Do this with an ifdef instead of a separate file to keep
the iomap_folio_state local to buffered-io.c.

Signed-off-by: Christoph Hellwig <hch@lst.de>
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
index 1a9ade77aeeb..6ceeb0e2fc13 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -284,6 +284,46 @@ static void iomap_adjust_read_range(struct inode *inode, struct folio *folio,
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
@@ -323,45 +363,6 @@ struct iomap_readpage_ctx {
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
@@ -554,6 +555,27 @@ void iomap_readahead(struct readahead_control *rac, const struct iomap_ops *ops)
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
@@ -667,19 +689,6 @@ iomap_write_failed(struct inode *inode, loff_t pos, unsigned len)
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


