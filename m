Return-Path: <linux-fsdevel+bounces-23499-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5DF692D59D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jul 2024 18:00:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B7F5289F83
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jul 2024 16:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0D5F194C88;
	Wed, 10 Jul 2024 15:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qqZayFtK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48B7194A75
	for <linux-fsdevel@vger.kernel.org>; Wed, 10 Jul 2024 15:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720627195; cv=none; b=cGEWjoOqLd87kUSn5n3wG/gaeeXIs0yh1NHya3MRuCzvjSq6+eb4gKInhu6B2rn+wnaeQufLjZgji8ZWo0eWL2ngC07R9A0nwoctZOrjDY7hyW0ulTApLItTB2/31AVrqOGnyGe0ZTH1mirqwMhrhPStNEXuhI9DbpXuekkqKkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720627195; c=relaxed/simple;
	bh=NwSQICa1R9gQErI5BlhFLBPL74tfPi3q2ENWUkW+DfU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=irR4hI5n5IQssk1VfDWrncDYvH1SNYUsQkLyU5L9GSWmNEwMlbjFFnI5hliVslmJqoLp5gDb4lz8pYdg6fhv8uqwccfoq6IYtZ2pKKRGS6vPOU0tgpeY6++p7qexIxAbyYLZGpUDuUVTK0GkMFpNunzHfXVmiSAX9a69+jYsarY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qqZayFtK; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=XPQxuGOLvFCS3aW88WOTa6/iWEt7uMVm/luhDslViZs=; b=qqZayFtKbVYeq+MJ0pZNs2FVin
	MaioPvrPIkORP0KZCNdVzfj6rg+8o4psS8LxA/95rxeniA+NZqc8vrLkYB2C4DvmL6ylNe+sdTQpJ
	sTSTJLJrKVYUsmQsqHrfCwY6c5KwDIFShfM4AnpQh4SGgrlC0VJfsrvC+bPbKvRIN2LsuZrCUAIZg
	Ye0SGQ/JJO5tA1v0y3gb6HouOAUo4qpbVPBkEJZdV4XqsMBy69e05ps200348s8eLr2R9OA+JxyWu
	FUTqu3mNYEs0JPDiJMFFA0/w09GL6HOLUTXmRs13pbf9RgQaEfoH4fvl3PRjHBXkTBJcD0XB2JLc4
	SkGAFumA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sRZjQ-00000009TEG-3wke;
	Wed, 10 Jul 2024 15:59:48 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 1/6] qnx6: Convert qnx6_get_page() to qnx6_get_folio()
Date: Wed, 10 Jul 2024 16:59:39 +0100
Message-ID: <20240710155946.2257293-2-willy@infradead.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240710155946.2257293-1-willy@infradead.org>
References: <20240710155946.2257293-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Match the ext2 calling convention by returning the address and
setting the folio return pointer.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/qnx6/dir.c | 46 ++++++++++++++++++++++++----------------------
 1 file changed, 24 insertions(+), 22 deletions(-)

diff --git a/fs/qnx6/dir.c b/fs/qnx6/dir.c
index c1cfb8a19e9d..bc7f20dda579 100644
--- a/fs/qnx6/dir.c
+++ b/fs/qnx6/dir.c
@@ -24,13 +24,15 @@ static unsigned qnx6_lfile_checksum(char *name, unsigned size)
 	return crc;
 }
 
-static struct page *qnx6_get_page(struct inode *dir, unsigned long n)
+static void *qnx6_get_folio(struct inode *dir, unsigned long n,
+		struct folio **foliop)
 {
-	struct address_space *mapping = dir->i_mapping;
-	struct page *page = read_mapping_page(mapping, n, NULL);
-	if (!IS_ERR(page))
-		kmap(page);
-	return page;
+	struct folio *folio = read_mapping_folio(dir->i_mapping, n, NULL);
+
+	if (IS_ERR(folio))
+		return folio;
+	*foliop = folio;
+	return kmap(&folio->page);
 }
 
 static unsigned last_entry(struct inode *inode, unsigned long page_nr)
@@ -117,26 +119,27 @@ static int qnx6_readdir(struct file *file, struct dir_context *ctx)
 	loff_t pos = ctx->pos & ~(QNX6_DIR_ENTRY_SIZE - 1);
 	unsigned long npages = dir_pages(inode);
 	unsigned long n = pos >> PAGE_SHIFT;
-	unsigned start = (pos & ~PAGE_MASK) / QNX6_DIR_ENTRY_SIZE;
+	unsigned offset = (pos & ~PAGE_MASK) / QNX6_DIR_ENTRY_SIZE;
 	bool done = false;
 
 	ctx->pos = pos;
 	if (ctx->pos >= inode->i_size)
 		return 0;
 
-	for ( ; !done && n < npages; n++, start = 0) {
-		struct page *page = qnx6_get_page(inode, n);
-		int limit = last_entry(inode, n);
+	for ( ; !done && n < npages; n++, offset = 0) {
 		struct qnx6_dir_entry *de;
-		int i = start;
+		struct folio *folio;
+		char *kaddr = qnx6_get_folio(inode, n, &folio);
+		char *limit;
 
-		if (IS_ERR(page)) {
+		if (IS_ERR(kaddr)) {
 			pr_err("%s(): read failed\n", __func__);
 			ctx->pos = (n + 1) << PAGE_SHIFT;
-			return PTR_ERR(page);
+			return PTR_ERR(kaddr);
 		}
-		de = ((struct qnx6_dir_entry *)page_address(page)) + start;
-		for (; i < limit; i++, de++, ctx->pos += QNX6_DIR_ENTRY_SIZE) {
+		de = (struct qnx6_dir_entry *)(kaddr + offset);
+		limit = kaddr + last_entry(inode, n);
+		for (; (char *)de < limit; de++, ctx->pos += QNX6_DIR_ENTRY_SIZE) {
 			int size = de->de_size;
 			u32 no_inode = fs32_to_cpu(sbi, de->de_inode);
 
@@ -164,7 +167,7 @@ static int qnx6_readdir(struct file *file, struct dir_context *ctx)
 				}
 			}
 		}
-		qnx6_put_page(page);
+		qnx6_put_page(&folio->page);
 	}
 	return 0;
 }
@@ -215,7 +218,7 @@ unsigned qnx6_find_entry(int len, struct inode *dir, const char *name,
 {
 	struct super_block *s = dir->i_sb;
 	struct qnx6_inode_info *ei = QNX6_I(dir);
-	struct page *page = NULL;
+	struct folio *folio;
 	unsigned long start, n;
 	unsigned long npages = dir_pages(dir);
 	unsigned ino;
@@ -232,12 +235,11 @@ unsigned qnx6_find_entry(int len, struct inode *dir, const char *name,
 	n = start;
 
 	do {
-		page = qnx6_get_page(dir, n);
-		if (!IS_ERR(page)) {
+		de = qnx6_get_folio(dir, n, &folio);
+		if (!IS_ERR(de)) {
 			int limit = last_entry(dir, n);
 			int i;
 
-			de = (struct qnx6_dir_entry *)page_address(page);
 			for (i = 0; i < limit; i++, de++) {
 				if (len <= QNX6_SHORT_NAME_MAX) {
 					/* short filename */
@@ -256,7 +258,7 @@ unsigned qnx6_find_entry(int len, struct inode *dir, const char *name,
 				} else
 					pr_err("undefined filename size in inode.\n");
 			}
-			qnx6_put_page(page);
+			qnx6_put_page(&folio->page);
 		}
 
 		if (++n >= npages)
@@ -265,7 +267,7 @@ unsigned qnx6_find_entry(int len, struct inode *dir, const char *name,
 	return 0;
 
 found:
-	*res_page = page;
+	*res_page = &folio->page;
 	ei->i_dir_start_lookup = n;
 	return ino;
 }
-- 
2.43.0


