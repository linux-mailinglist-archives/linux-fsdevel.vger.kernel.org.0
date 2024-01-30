Return-Path: <linux-fsdevel+bounces-9493-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3F69841B9A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 06:54:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 052B91C25118
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 05:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80FF5383A8;
	Tue, 30 Jan 2024 05:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lvX7yeCB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D27C381B9;
	Tue, 30 Jan 2024 05:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706594065; cv=none; b=IKqwN7FwNfPIjQWCVkMQzW2EBm07vXv5zapeSZT4D0o3TK5giW8enS5NjWK2ftT+yyzX8RuqSfYv2gj09pwecTQ48bzJERt/wBwTBzSU8XUBrrxyUx0mW/MbWN4ih5gWab8KlPJQLSnvIs+Ah6zojF+wasaolofuVJZtR9cMv7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706594065; c=relaxed/simple;
	bh=JMGNgA5p77L4yCmgHLC5rGqvzm4lD2Au+5vm0jaJPkg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KjPqbnrvNbBGiiuTjlYfpnsvt1smYSlHlnRRCjlJh8baAhfO7f4PO3cfXIkr4+m6boRw+2rTf3ZClgwMZ6nObOL0KraA1hAd/3Ox3TWWXK9iimv+QWVVtv1j4woj0e7Hi8WO9pUFB4DLwgdfX1m5zfYzA7TpD4UcOJe6D1LPQO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=lvX7yeCB; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=1Ef/D0lEas0yp4KPjSxjRO+7105j66U6WTJQm7R4Kn8=; b=lvX7yeCBJlayQsdK8PUlA0HuhG
	G5nIQwPrqg5Nr5CgLaofgotf/cYjScz6efp7vuNSpVwXzJ4/3hXRiAslNsbl6O663ILOPkgQyD3cK
	kDxlr4g2EJlVKFMxf18altMxeF9hMpWcHRfQsG604zLXLaEPcaivh9oyUGZ0rus5JLybfhkfpPFLN
	Se0FsSeLZE5LcUqhaIKBeIFXdpgew7sUGNLd2DLykvyhzSAdigLBFqQUqNLSvzRpiTpFnFzZSXvg8
	ipXacqLFu6Wxjo5LdlHkgqvAC5oqMjRxfeiY3/CiZwn49t0rYk1l5r9uDWrAPKH6o9STDPoDfCNKv
	ASYOi/nQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUh4a-00000008zkj-0zzP;
	Tue, 30 Jan 2024 05:54:16 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Christoph Hellwig <hch@lst.de>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org
Subject: [PATCH 2/3] fs: Supply optional buffered_write_operations in buffer.c
Date: Tue, 30 Jan 2024 05:54:12 +0000
Message-ID: <20240130055414.2143959-3-willy@infradead.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240130055414.2143959-1-willy@infradead.org>
References: <20240130055414.2143959-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

generic_cont_expand_simple() and cont_expand_zero() currently call
->write_begin and ->write_end, so will also need to be converted to use
buffered_write_operations.  Use macro magic again to pass in optional
buffered_write_operations.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/buffer.c                 | 62 +++++++++++++++++++++++++++----------
 include/linux/buffer_head.h | 22 ++++++++++---
 2 files changed, 64 insertions(+), 20 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index d3bcf601d3e5..8ed76fc6cff0 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -2441,11 +2441,13 @@ EXPORT_SYMBOL(block_read_full_folio);
  * truncates.  Uses filesystem pagecache writes to allow the filesystem to
  * deal with the hole.  
  */
-int generic_cont_expand_simple(struct inode *inode, loff_t size)
+int generic_cont_expand_simple(struct inode *inode, loff_t size,
+		const struct buffered_write_operations *ops)
 {
 	struct address_space *mapping = inode->i_mapping;
 	const struct address_space_operations *aops = mapping->a_ops;
 	struct page *page;
+	struct folio *folio;
 	void *fsdata = NULL;
 	int err;
 
@@ -2453,11 +2455,17 @@ int generic_cont_expand_simple(struct inode *inode, loff_t size)
 	if (err)
 		goto out;
 
-	err = aops->write_begin(NULL, mapping, size, 0, &page, &fsdata);
+	if (ops)
+		err = ops->write_begin(NULL, mapping, size, 0, &folio, &fsdata);
+	else
+		err = aops->write_begin(NULL, mapping, size, 0, &page, &fsdata);
 	if (err)
 		goto out;
 
-	err = aops->write_end(NULL, mapping, size, 0, 0, page, fsdata);
+	if (ops)
+		err = ops->write_end(NULL, mapping, size, 0, 0, folio, &fsdata);
+	else
+		err = aops->write_end(NULL, mapping, size, 0, 0, page, fsdata);
 	BUG_ON(err > 0);
 
 out:
@@ -2466,12 +2474,14 @@ int generic_cont_expand_simple(struct inode *inode, loff_t size)
 EXPORT_SYMBOL(generic_cont_expand_simple);
 
 static int cont_expand_zero(struct file *file, struct address_space *mapping,
-			    loff_t pos, loff_t *bytes)
+		loff_t pos, loff_t *bytes,
+		const struct buffered_write_operations *ops)
 {
 	struct inode *inode = mapping->host;
 	const struct address_space_operations *aops = mapping->a_ops;
 	unsigned int blocksize = i_blocksize(inode);
 	struct page *page;
+	struct folio *folio;
 	void *fsdata = NULL;
 	pgoff_t index, curidx;
 	loff_t curpos;
@@ -2489,13 +2499,23 @@ static int cont_expand_zero(struct file *file, struct address_space *mapping,
 		}
 		len = PAGE_SIZE - zerofrom;
 
-		err = aops->write_begin(file, mapping, curpos, len,
-					    &page, &fsdata);
+		if (ops) {
+			err = ops->write_begin(file, mapping, curpos, len,
+					&folio, &fsdata);
+			page = &folio->page;
+		} else {
+			err = aops->write_begin(file, mapping, curpos, len,
+					&page, &fsdata);
+		}
 		if (err)
 			goto out;
 		zero_user(page, zerofrom, len);
-		err = aops->write_end(file, mapping, curpos, len, len,
-						page, fsdata);
+		if (ops)
+			err = ops->write_end(file, mapping, curpos, len, len,
+					folio, &fsdata);
+		else
+			err = aops->write_end(file, mapping, curpos, len, len,
+					page, fsdata);
 		if (err < 0)
 			goto out;
 		BUG_ON(err != len);
@@ -2522,13 +2542,23 @@ static int cont_expand_zero(struct file *file, struct address_space *mapping,
 		}
 		len = offset - zerofrom;
 
-		err = aops->write_begin(file, mapping, curpos, len,
-					    &page, &fsdata);
+		if (ops) {
+			err = ops->write_begin(file, mapping, curpos, len,
+					&folio, &fsdata);
+			page = &folio->page;
+		} else {
+			err = aops->write_begin(file, mapping, curpos, len,
+					&page, &fsdata);
+		}
 		if (err)
 			goto out;
 		zero_user(page, zerofrom, len);
-		err = aops->write_end(file, mapping, curpos, len, len,
-						page, fsdata);
+		if (ops)
+			err = ops->write_end(file, mapping, curpos, len, len,
+					folio, &fsdata);
+		else
+			err = aops->write_end(file, mapping, curpos, len, len,
+					page, fsdata);
 		if (err < 0)
 			goto out;
 		BUG_ON(err != len);
@@ -2543,16 +2573,16 @@ static int cont_expand_zero(struct file *file, struct address_space *mapping,
  * We may have to extend the file.
  */
 int cont_write_begin(struct file *file, struct address_space *mapping,
-			loff_t pos, unsigned len,
-			struct page **pagep, void **fsdata,
-			get_block_t *get_block, loff_t *bytes)
+		loff_t pos, unsigned len, struct page **pagep, void **fsdata,
+		get_block_t *get_block, loff_t *bytes,
+		const struct buffered_write_operations *ops)
 {
 	struct inode *inode = mapping->host;
 	unsigned int blocksize = i_blocksize(inode);
 	unsigned int zerofrom;
 	int err;
 
-	err = cont_expand_zero(file, mapping, pos, bytes);
+	err = cont_expand_zero(file, mapping, pos, bytes, ops);
 	if (err)
 		return err;
 
diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
index d78454a4dd1f..80de88c12d23 100644
--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -268,16 +268,30 @@ int generic_write_end(struct file *, struct address_space *,
 				loff_t, unsigned, unsigned,
 				struct page *, void *);
 void folio_zero_new_buffers(struct folio *folio, size_t from, size_t to);
-int cont_write_begin(struct file *, struct address_space *, loff_t,
-			unsigned, struct page **, void **,
-			get_block_t *, loff_t *);
-int generic_cont_expand_simple(struct inode *inode, loff_t size);
+int cont_write_begin(struct file *, struct address_space *, loff_t pos,
+		unsigned len, struct page **, void **fsdata, get_block_t *,
+		loff_t *bytes, const struct buffered_write_operations *);
+int generic_cont_expand_simple(struct inode *inode, loff_t size,
+		const struct buffered_write_operations *ops);
 void block_commit_write(struct page *page, unsigned int from, unsigned int to);
 int block_page_mkwrite(struct vm_area_struct *vma, struct vm_fault *vmf,
 				get_block_t get_block);
 sector_t generic_block_bmap(struct address_space *, sector_t, get_block_t *);
 int block_truncate_page(struct address_space *, loff_t, get_block_t *);
 
+#define _cont_write_begin(file, mapping, pos, len, pagep, fsdata,	\
+		getblk, bytes, ops, extra...)				\
+	cont_write_begin(file, mapping, pos, len, pagep, fsdata,	\
+		getblk,bytes, ops)
+#define cont_write_begin(file, mapping, pos, len, pagep, fsdata,	\
+		getblk, bytes, ops...)					\
+	_cont_write_begin(file, mapping, pos, len, pagep, fsdata,	\
+		getblk, bytes, ## ops, NULL)
+#define _generic_cont_expand_simple(inode, size, ops, extra...)		\
+	generic_cont_expand_simple(inode, size, ops)
+#define generic_cont_expand_simple(inode, size, ops...)			\
+	_generic_cont_expand_simple(inode, size, ## ops, NULL)
+
 #ifdef CONFIG_MIGRATION
 extern int buffer_migrate_folio(struct address_space *,
 		struct folio *dst, struct folio *src, enum migrate_mode);
-- 
2.43.0


