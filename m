Return-Path: <linux-fsdevel+bounces-20362-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0372A8D21F0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2024 18:49:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C17FB241C6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2024 16:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B505174EFE;
	Tue, 28 May 2024 16:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="m5RVL4WV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192D4172BD8;
	Tue, 28 May 2024 16:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716914914; cv=none; b=PudnwJ2wHQZRsHA2gfYswBeCsZhbrk3S34Crlujzzlw3hDkr2bcxS7brKbyVPCf1hwnxbYRJ2RdT0KXGPyDhYDpITvwuH8jUc1NheXpRD9by4MSsvZyaMpX7f2IvzECKLGxNep5pD/1xFax9N3ZmWB0fhsziBBI6X0WX7Bg3LEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716914914; c=relaxed/simple;
	bh=D2tTlrFnEeMjZECR3JcvOVGURlnNgkYSaHwAoMwrgN8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NadMvNtbiv70tSzgRQl4sTWbTlU6gFBWhid2I532tV2IZYxh9IgQd2c4yvAsMdQsv5gGAnxKmSUgbOVMjtZEC0PhYXXPueoQEP3ARNP0IeC9Qivzyvgfl37ZBSs2qspOHeU8lIDSJbBFfBe+fdl5MiPpUnCt23hikho5uOnNfgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=m5RVL4WV; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=5bqYlK1AE1ExlN3FvyGoPAxrjC2iLLgkrqD73YGe+nc=; b=m5RVL4WVT6K1NZAqVAVTje5J39
	EqybgNCMsCrX93CZyUyqx5Uo07q3pOiFhUDFk+vu1HvWa62cdV0iO4PUcxZJntOD7D3T3Q6nZlQ9/
	YEB2Z3NZ7KAE1N1AJHaZHYOmrI4yrb3lsdkDbqyVsfTXYzYu0wh2CLHV0MZm3lSENFMcx/Aa5YxcQ
	dSXODNXgfF/HVv8deaJJJujYc5hTsOsggiJkmXz4t2yfKs+gsa7NxSqYSAAbtlO2i6I7z/TPZ26Y2
	Dx0WoS4RBogN3vmZizBjISR8DyITwLEPvlhxE3JcbEmXi6NARoO6fvTOnWRod42hVbP/mU8KHErKP
	bkDEcuQw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sBzzz-00000008pjF-1pxS;
	Tue, 28 May 2024 16:48:31 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Christoph Hellwig <hch@lst.de>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org
Subject: [PATCH 3/7] buffer: Add buffer_write_begin, buffer_write_end and __buffer_write_end
Date: Tue, 28 May 2024 17:48:24 +0100
Message-ID: <20240528164829.2105447-4-willy@infradead.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240528164829.2105447-1-willy@infradead.org>
References: <20240528164829.2105447-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These functions are to be called from filesystem implementations of
write_begin and write_end.  They correspond to block_write_begin,
generic_write_end and block_write_end.  The old functions need to
be kept around as they're used as function pointers.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/buffer.c                 | 80 ++++++++++++++++++++++++++-----------
 include/linux/buffer_head.h |  6 +++
 2 files changed, 63 insertions(+), 23 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 58ac52f20bf6..4064b21fe499 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -2217,39 +2217,55 @@ static void __block_commit_write(struct folio *folio, size_t from, size_t to)
 }
 
 /*
- * block_write_begin takes care of the basic task of block allocation and
+ * buffer_write_begin - Helper for filesystem write_begin implementations
+ * @mapping: Address space being written to.
+ * @pos: Position in bytes within the file.
+ * @len: Number of bytes being written.
+ * @get_block: How to get buffer_heads for this filesystem.
+ *
+ * Take care of the basic task of block allocation and
  * bringing partial write blocks uptodate first.
  *
  * The filesystem needs to handle block truncation upon failure.
+ *
+ * Return: The folio to write to, or an ERR_PTR on failure.
  */
-int block_write_begin(struct address_space *mapping, loff_t pos, unsigned len,
-		struct page **pagep, get_block_t *get_block)
+struct folio *buffer_write_begin(struct address_space *mapping, loff_t pos,
+		size_t len, get_block_t *get_block)
 {
-	pgoff_t index = pos >> PAGE_SHIFT;
-	struct page *page;
+	struct folio *folio = __filemap_get_folio(mapping, pos / PAGE_SIZE,
+			FGP_WRITEBEGIN, mapping_gfp_mask(mapping));
 	int status;
 
-	page = grab_cache_page_write_begin(mapping, index);
-	if (!page)
-		return -ENOMEM;
+	if (IS_ERR(folio))
+		return folio;
 
-	status = __block_write_begin(page, pos, len, get_block);
+	status = __block_write_begin_int(folio, pos, len, get_block, NULL);
 	if (unlikely(status)) {
-		unlock_page(page);
-		put_page(page);
-		page = NULL;
+		folio_unlock(folio);
+		folio_put(folio);
+		folio = ERR_PTR(status);
 	}
 
-	*pagep = page;
-	return status;
+	return folio;
+}
+EXPORT_SYMBOL(buffer_write_begin);
+
+int block_write_begin(struct address_space *mapping, loff_t pos, unsigned len,
+		struct page **pagep, get_block_t *get_block)
+{
+	struct folio *folio = buffer_write_begin(mapping, pos, len, get_block);
+
+	if (IS_ERR(folio))
+		return PTR_ERR(folio);
+	*pagep = &folio->page;
+	return 0;
 }
 EXPORT_SYMBOL(block_write_begin);
 
-int block_write_end(struct file *file, struct address_space *mapping,
-			loff_t pos, unsigned len, unsigned copied,
-			struct page *page, void *fsdata)
+size_t __buffer_write_end(struct file *file, struct address_space *mapping,
+		loff_t pos, size_t len, size_t copied, struct folio *folio)
 {
-	struct folio *folio = page_folio(page);
 	size_t start = pos - folio_pos(folio);
 
 	if (unlikely(copied < len)) {
@@ -2277,17 +2293,26 @@ int block_write_end(struct file *file, struct address_space *mapping,
 
 	return copied;
 }
-EXPORT_SYMBOL(block_write_end);
+EXPORT_SYMBOL(__buffer_write_end);
 
-int generic_write_end(struct file *file, struct address_space *mapping,
+int block_write_end(struct file *file, struct address_space *mapping,
 			loff_t pos, unsigned len, unsigned copied,
 			struct page *page, void *fsdata)
+{
+	return buffer_write_end(file, mapping, pos, len, copied,
+			page_folio(page));
+}
+EXPORT_SYMBOL(block_write_end);
+
+size_t buffer_write_end(struct file *file, struct address_space *mapping,
+			loff_t pos, size_t len, size_t copied,
+			struct folio *folio)
 {
 	struct inode *inode = mapping->host;
 	loff_t old_size = inode->i_size;
 	bool i_size_changed = false;
 
-	copied = block_write_end(file, mapping, pos, len, copied, page, fsdata);
+	copied = __buffer_write_end(file, mapping, pos, len, copied, folio);
 
 	/*
 	 * No need to use i_size_read() here, the i_size cannot change under us
@@ -2301,8 +2326,8 @@ int generic_write_end(struct file *file, struct address_space *mapping,
 		i_size_changed = true;
 	}
 
-	unlock_page(page);
-	put_page(page);
+	folio_unlock(folio);
+	folio_put(folio);
 
 	if (old_size < pos)
 		pagecache_isize_extended(inode, old_size, pos);
@@ -2316,6 +2341,15 @@ int generic_write_end(struct file *file, struct address_space *mapping,
 		mark_inode_dirty(inode);
 	return copied;
 }
+EXPORT_SYMBOL(buffer_write_end);
+
+int generic_write_end(struct file *file, struct address_space *mapping,
+			loff_t pos, unsigned len, unsigned copied,
+			struct page *page, void *fsdata)
+{
+	return buffer_write_end(file, mapping, pos, len, copied,
+			page_folio(page));
+}
 EXPORT_SYMBOL(generic_write_end);
 
 /*
diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
index 1b7f14e39ab8..44e4b2b18cc0 100644
--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -267,6 +267,12 @@ int block_write_end(struct file *, struct address_space *,
 int generic_write_end(struct file *, struct address_space *,
 				loff_t, unsigned, unsigned,
 				struct page *, void *);
+struct folio *buffer_write_begin(struct address_space *mapping, loff_t pos,
+		size_t len, get_block_t *get_block);
+size_t buffer_write_end(struct file *, struct address_space *, loff_t pos,
+		size_t len, size_t copied, struct folio *);
+size_t __buffer_write_end(struct file *, struct address_space *, loff_t pos,
+		size_t len, size_t copied, struct folio *);
 void folio_zero_new_buffers(struct folio *folio, size_t from, size_t to);
 int cont_write_begin(struct file *, struct address_space *, loff_t pos,
 		unsigned len, struct page **, void **fsdata, get_block_t *,
-- 
2.43.0


