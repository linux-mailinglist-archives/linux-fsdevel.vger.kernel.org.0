Return-Path: <linux-fsdevel+bounces-20365-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A662A8D21F4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2024 18:49:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BA5BB22A74
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2024 16:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD68F17557B;
	Tue, 28 May 2024 16:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FGRrsv3y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED588172BD5;
	Tue, 28 May 2024 16:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716914915; cv=none; b=Ycp5VSVJjBEMrWcVXT4aKAwQl50y9LRJSQ+6Ct1ALIAM9FnYHd2ESMY4I7iXDSDCSr4LIAYGvlltu8xdM8vsiNWTdCoGhLC8tDtgQgY6wG7ZJRDUWbWXrOMID7fB723IUxP6wwl+bMESELFKdwgWKGQajHeQU5WLKI4QfSX0RzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716914915; c=relaxed/simple;
	bh=UumrTljUiV9/fFu9UljiSySKbgCeWWnkBNY7Ez7gFM8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YzR1f7NO6BLhRpj0jMtkLe6qz0wxXF2Z9YDf1UChJTegWIu2jjtZJMYdb2i/0J3CWr9Fr81Y0hQJSBKlx3+CPPL1wWZZ0qrxCU6jHL2RE6lVlDIF3XdoXjqNIRJBG/JoQ4gP+CuZIIrDoI+rhfisfe/6GGY2iAEzrEbvC+rLl1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=FGRrsv3y; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=eOxBR5VEbisG9xilapnBHP0KrNMLEjBVgRMaOXofMC0=; b=FGRrsv3yu9nhx2UDc930DU6Q9H
	IglvDotpBNRV2jnKEcE1hwwpOVMs1czSJI3zBRWrmkdwvI852egvneMzy6Q7NkIwADGMOQkGRpcNy
	O6ahJ9qGUs8Atp3hJt7J3PnJ1pBK1isTVGHipHnlOBeD1Dw/OW88CUeEkySuFo5P6NIRPMZOBDS7D
	mKfRtDPfrU4i9To4fOA6S+W/OuA5xI6Hul3AMUj1T/4pxynwOnNo9fK4wT6uoWozZKUwLC38/jZcX
	s+OklUSMEJn0WS4UvEQ8z+0Muso8dXwwmC9fV+LcRMT3Edvg9J0RC+DppzJl8QUJHKTfzJkbVM3oQ
	EOPP4m0A==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sBzzz-00000008pj6-1JcW;
	Tue, 28 May 2024 16:48:31 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Christoph Hellwig <hch@lst.de>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org
Subject: [PATCH 2/7] fs: Supply optional buffered_write_operations in buffer.c
Date: Tue, 28 May 2024 17:48:23 +0100
Message-ID: <20240528164829.2105447-3-willy@infradead.org>
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

generic_cont_expand_simple() and cont_expand_zero() currently call
->write_begin and ->write_end, so will also need to be converted to
use buffered_write_operations.  Use macro magic to pass NULL if no
buffered_write_operations is supplied.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/buffer.c                 | 78 ++++++++++++++++++++++++++-----------
 include/linux/buffer_head.h | 22 +++++++++--
 2 files changed, 74 insertions(+), 26 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 8c19e705b9c3..58ac52f20bf6 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -2466,23 +2466,32 @@ EXPORT_SYMBOL(block_read_full_folio);
  * truncates.  Uses filesystem pagecache writes to allow the filesystem to
  * deal with the hole.  
  */
-int generic_cont_expand_simple(struct inode *inode, loff_t size)
+int generic_cont_expand_simple(struct inode *inode, loff_t size,
+		const struct buffered_write_operations *ops, void *fsdata)
 {
 	struct address_space *mapping = inode->i_mapping;
 	const struct address_space_operations *aops = mapping->a_ops;
 	struct page *page;
-	void *fsdata = NULL;
+	struct folio *folio;
 	int err;
 
 	err = inode_newsize_ok(inode, size);
 	if (err)
 		goto out;
 
-	err = aops->write_begin(NULL, mapping, size, 0, &page, &fsdata);
+	if (ops) {
+		folio = ops->write_begin(NULL, mapping, size, 0, &fsdata);
+		if (IS_ERR(folio))
+			err = PTR_ERR(folio);
+	} else
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
@@ -2491,13 +2500,14 @@ int generic_cont_expand_simple(struct inode *inode, loff_t size)
 EXPORT_SYMBOL(generic_cont_expand_simple);
 
 static int cont_expand_zero(struct file *file, struct address_space *mapping,
-			    loff_t pos, loff_t *bytes)
+		loff_t pos, loff_t *bytes,
+		const struct buffered_write_operations *ops, void **fsdata)
 {
 	struct inode *inode = mapping->host;
 	const struct address_space_operations *aops = mapping->a_ops;
 	unsigned int blocksize = i_blocksize(inode);
 	struct page *page;
-	void *fsdata = NULL;
+	struct folio *folio;
 	pgoff_t index, curidx;
 	loff_t curpos;
 	unsigned zerofrom, offset, len;
@@ -2514,13 +2524,25 @@ static int cont_expand_zero(struct file *file, struct address_space *mapping,
 		}
 		len = PAGE_SIZE - zerofrom;
 
-		err = aops->write_begin(file, mapping, curpos, len,
-					    &page, &fsdata);
-		if (err)
-			goto out;
+		if (ops) {
+			folio = ops->write_begin(file, mapping, curpos, len,
+					fsdata);
+			if (IS_ERR(folio))
+				return PTR_ERR(folio);
+			page = &folio->page;
+		} else {
+			err = aops->write_begin(file, mapping, curpos, len,
+					&page, fsdata);
+			if (err)
+				goto out;
+		}
 		zero_user(page, zerofrom, len);
-		err = aops->write_end(file, mapping, curpos, len, len,
-						page, fsdata);
+		if (ops)
+			err = ops->write_end(file, mapping, curpos, len, len,
+					folio, fsdata);
+		else
+			err = aops->write_end(file, mapping, curpos, len, len,
+					page, *fsdata);
 		if (err < 0)
 			goto out;
 		BUG_ON(err != len);
@@ -2547,13 +2569,25 @@ static int cont_expand_zero(struct file *file, struct address_space *mapping,
 		}
 		len = offset - zerofrom;
 
-		err = aops->write_begin(file, mapping, curpos, len,
-					    &page, &fsdata);
-		if (err)
-			goto out;
+		if (ops) {
+			folio = ops->write_begin(file, mapping, curpos, len,
+					fsdata);
+			if (IS_ERR(folio))
+				return PTR_ERR(folio);
+			page = &folio->page;
+		} else {
+			err = aops->write_begin(file, mapping, curpos, len,
+					&page, fsdata);
+			if (err)
+				goto out;
+		}
 		zero_user(page, zerofrom, len);
-		err = aops->write_end(file, mapping, curpos, len, len,
-						page, fsdata);
+		if (ops)
+			err = ops->write_end(file, mapping, curpos, len, len,
+					folio, fsdata);
+		else
+			err = aops->write_end(file, mapping, curpos, len, len,
+					page, *fsdata);
 		if (err < 0)
 			goto out;
 		BUG_ON(err != len);
@@ -2568,16 +2602,16 @@ static int cont_expand_zero(struct file *file, struct address_space *mapping,
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
+	err = cont_expand_zero(file, mapping, pos, bytes, ops, fsdata);
 	if (err)
 		return err;
 
diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
index e022e40b099e..1b7f14e39ab8 100644
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
+		const struct buffered_write_operations *ops, void *fsdata);
 void block_commit_write(struct page *page, unsigned int from, unsigned int to);
 int block_page_mkwrite(struct vm_area_struct *vma, struct vm_fault *vmf,
 				get_block_t get_block);
 sector_t generic_block_bmap(struct address_space *, sector_t, get_block_t *);
 int block_truncate_page(struct address_space *, loff_t, get_block_t *);
 
+#define _cont_write_begin(file, mapping, pos, len, pagep, fsdata,	\
+		getblk, bytes, ops, extra...)				\
+	cont_write_begin(file, mapping, pos, len, pagep, fsdata,	\
+		getblk, bytes, ops)
+#define cont_write_begin(file, mapping, pos, len, pagep, fsdata,	\
+		getblk, bytes, ops...)					\
+	_cont_write_begin(file, mapping, pos, len, pagep, fsdata,	\
+		getblk, bytes, ## ops, NULL)
+#define _generic_cont_expand_simple(inode, size, ops, fsdata, extra...)	\
+	generic_cont_expand_simple(inode, size, ops, fsdata)
+#define generic_cont_expand_simple(inode, size, ops_data...)		\
+	_generic_cont_expand_simple(inode, size, ## ops_data, NULL, NULL)
+
 #ifdef CONFIG_MIGRATION
 extern int buffer_migrate_folio(struct address_space *,
 		struct folio *dst, struct folio *src, enum migrate_mode);
-- 
2.43.0


