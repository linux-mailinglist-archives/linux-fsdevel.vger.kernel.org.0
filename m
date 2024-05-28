Return-Path: <linux-fsdevel+bounces-20363-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 739238D21F1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2024 18:49:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F6C6287541
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2024 16:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B9B9175552;
	Tue, 28 May 2024 16:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="edCpatfO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5550617332A;
	Tue, 28 May 2024 16:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716914914; cv=none; b=aaj5wgbroJrReAiibYqElaHSeTRBNe5mFYBlZFKRlm17YazNSjjWZ9I4KYARULPoZllw2lxlXmBUFuEFBfOq/cB+tVYuLn0V4hEg4fdV2vAcBCod8tuidvmpMtnDSyXh3nFQbF5EEavQojLCg8t8xkMbsuZnMAEHBt4I/1AGhlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716914914; c=relaxed/simple;
	bh=3Pjpp2P09PE5rEltCX5jMmUoMU02SiNpRbHgjiGkpzY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IwlnrN2ONMg5TipCuw4SOR2CFRf8z8ns5gzbS7182XXOyiEpdxR4nVfOUzKgMFTRLPKo6Oo5/5sGKhgjsCuhDVtr8RsXi6HhVBMmkSqiLW7qTq5e4ym3npL+ja5QM3HJX9nJ0q0M9aXUnLhubl2GPG8od/KSz6O/TqcqDKGrfRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=edCpatfO; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=OM8uDx7VjJ0gwoeodjHhQfGhwJlDV1N5xXOB75yQ0vQ=; b=edCpatfOyuveWnzurf/9dQewBY
	tSk1iTDUilIJESZsVhA7kPWjsblYQ/UTaoTKfK7aOdA8mhQ4wFFWfOV8/Dq8uRw5KHuoFm4IbWTvN
	hI/VvO72W6Mm0T4gjRpoTyill8Ho3cmxZ7IKpwwE/VE0SKR0SYHiejj7CCy61yw6so+5bOb0wKomc
	GKWkOOf1N5lp7n3m+F0EVordxNybfp2LRTg4jKhTn3sY932jXt7pwahZqI4e2FUMZPh1O4s+Nxz4z
	7y6tbLL13ELfus/7ymp02uIC8zSnBrJyLIRIH9YamtZfyvKH6h+PSNYnOMSlu8s2bADdwYw2/ofLr
	qMGQgJRA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sBzzz-00000008pjR-2rSv;
	Tue, 28 May 2024 16:48:31 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Christoph Hellwig <hch@lst.de>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org
Subject: [PATCH 5/7] ext2: Convert to buffered_write_operations
Date: Tue, 28 May 2024 17:48:26 +0100
Message-ID: <20240528164829.2105447-6-willy@infradead.org>
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

Move write_begin and write_end from the address_space_operations to
the new buffered_write_operations.  Removes a number of hidden calls
to compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ext2/ext2.h  |  1 +
 fs/ext2/file.c  |  4 ++--
 fs/ext2/inode.c | 55 ++++++++++++++++++++++++++-----------------------
 fs/ext2/namei.c |  2 +-
 4 files changed, 33 insertions(+), 29 deletions(-)

diff --git a/fs/ext2/ext2.h b/fs/ext2/ext2.h
index f38bdd46e4f7..89b498c81f18 100644
--- a/fs/ext2/ext2.h
+++ b/fs/ext2/ext2.h
@@ -784,6 +784,7 @@ extern const struct file_operations ext2_file_operations;
 extern void ext2_set_file_ops(struct inode *inode);
 extern const struct address_space_operations ext2_aops;
 extern const struct iomap_ops ext2_iomap_ops;
+extern const struct buffered_write_operations ext2_bw_ops;
 
 /* namei.c */
 extern const struct inode_operations ext2_dir_inode_operations;
diff --git a/fs/ext2/file.c b/fs/ext2/file.c
index 10b061ac5bc0..108e8d2e9654 100644
--- a/fs/ext2/file.c
+++ b/fs/ext2/file.c
@@ -252,7 +252,7 @@ static ssize_t ext2_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
 
 		iocb->ki_flags &= ~IOCB_DIRECT;
 		pos = iocb->ki_pos;
-		status = generic_perform_write(iocb, from);
+		status = filemap_perform_write(iocb, from, &ext2_bw_ops, NULL);
 		if (unlikely(status < 0)) {
 			ret = status;
 			goto out_unlock;
@@ -299,7 +299,7 @@ static ssize_t ext2_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	if (iocb->ki_flags & IOCB_DIRECT)
 		return ext2_dio_write_iter(iocb, from);
 
-	return generic_file_write_iter(iocb, from);
+	return filemap_write_iter(iocb, from, &ext2_bw_ops, NULL);
 }
 
 static int ext2_file_open(struct inode *inode, struct file *filp)
diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
index 0caa1650cee8..a89525d08aa3 100644
--- a/fs/ext2/inode.c
+++ b/fs/ext2/inode.c
@@ -914,30 +914,6 @@ static void ext2_readahead(struct readahead_control *rac)
 	mpage_readahead(rac, ext2_get_block);
 }
 
-static int
-ext2_write_begin(struct file *file, struct address_space *mapping,
-		loff_t pos, unsigned len, struct page **pagep, void **fsdata)
-{
-	int ret;
-
-	ret = block_write_begin(mapping, pos, len, pagep, ext2_get_block);
-	if (ret < 0)
-		ext2_write_failed(mapping, pos + len);
-	return ret;
-}
-
-static int ext2_write_end(struct file *file, struct address_space *mapping,
-			loff_t pos, unsigned len, unsigned copied,
-			struct page *page, void *fsdata)
-{
-	int ret;
-
-	ret = generic_write_end(file, mapping, pos, len, copied, page, fsdata);
-	if (ret < len)
-		ext2_write_failed(mapping, pos + len);
-	return ret;
-}
-
 static sector_t ext2_bmap(struct address_space *mapping, sector_t block)
 {
 	return generic_block_bmap(mapping,block,ext2_get_block);
@@ -962,8 +938,6 @@ const struct address_space_operations ext2_aops = {
 	.invalidate_folio	= block_invalidate_folio,
 	.read_folio		= ext2_read_folio,
 	.readahead		= ext2_readahead,
-	.write_begin		= ext2_write_begin,
-	.write_end		= ext2_write_end,
 	.bmap			= ext2_bmap,
 	.writepages		= ext2_writepages,
 	.migrate_folio		= buffer_migrate_folio,
@@ -976,6 +950,35 @@ static const struct address_space_operations ext2_dax_aops = {
 	.dirty_folio		= noop_dirty_folio,
 };
 
+static struct folio *ext2_write_begin(struct file *file,
+		struct address_space *mapping, loff_t pos, size_t len,
+		void **fsdata)
+{
+	struct folio *folio;
+
+	folio = buffer_write_begin(mapping, pos, len, ext2_get_block);
+
+	if (IS_ERR(folio))
+		ext2_write_failed(mapping, pos + len);
+	return folio;
+}
+
+static size_t ext2_write_end(struct file *file, struct address_space *mapping,
+		loff_t pos, size_t len, size_t copied, struct folio *folio,
+		void **fsdata)
+{
+	size_t ret = buffer_write_end(file, mapping, pos, len, copied, folio);
+
+	if (ret < len)
+		ext2_write_failed(mapping, pos + len);
+	return ret;
+}
+
+const struct buffered_write_operations ext2_bw_ops = {
+	.write_begin		= ext2_write_begin,
+	.write_end		= ext2_write_end,
+};
+
 /*
  * Probably it should be a library function... search for first non-zero word
  * or memcmp with zero_page, whatever is better for particular architecture.
diff --git a/fs/ext2/namei.c b/fs/ext2/namei.c
index 8346ab9534c1..a0edb11be826 100644
--- a/fs/ext2/namei.c
+++ b/fs/ext2/namei.c
@@ -179,7 +179,7 @@ static int ext2_symlink (struct mnt_idmap * idmap, struct inode * dir,
 		inode->i_op = &ext2_symlink_inode_operations;
 		inode_nohighmem(inode);
 		inode->i_mapping->a_ops = &ext2_aops;
-		err = page_symlink(inode, symname, l);
+		err = filemap_symlink(inode, symname, l, &ext2_bw_ops, NULL);
 		if (err)
 			goto out_fail;
 	} else {
-- 
2.43.0


