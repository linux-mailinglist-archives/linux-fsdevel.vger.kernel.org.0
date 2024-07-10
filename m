Return-Path: <linux-fsdevel+bounces-23462-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1806D92C7EA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jul 2024 03:24:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AEA51F2399B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jul 2024 01:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EE235664;
	Wed, 10 Jul 2024 01:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nOC/WZjK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383E3B663
	for <linux-fsdevel@vger.kernel.org>; Wed, 10 Jul 2024 01:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720574617; cv=none; b=sgq1QzmUv8vpAEtnkkPArnk8zpe3ORv6UVwcE8bUgIaUskDCv8LKtJ4Jax8TisO7+UkakLZJdotafwjc8i+4T9eLPtYFNSgrn2/TC8f5nsk1bnROTXIX9I9jFR6AbYaJSms6DpqK95FannFMnFV8eVT3nLaUcyNP/J8ohCqwx/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720574617; c=relaxed/simple;
	bh=NivbZcmLgMpmzujOxK6y9Pe4yDRdjDLGJyA1fFQl4gg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y8QkRIEE2OhDYRwGvb/xFm2789zoIDJ/LY8yo1nge24QtI0fsqda7H6M2LqxXb9FJCRCwCu34xnPodBPj6VmJW0CcUO45S3F0twMFbquWch/w2oPr/kI/Ei41Qbvx6wc/QBAUbK3LrTWcj10WEzNSImhXqrBfF6xaP8SjjEgLOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=nOC/WZjK; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=VFllkMF1W9oko966gGZClOgAWQwliQxlwFZLV1nQGFw=; b=nOC/WZjKpNERhcqI8OgEZCK6Wj
	urEujYjSOYAuyVCRDSYiHJsJxsnxRC6cOLwUryMtxbhHcLaR8SJHpVJeNLHpIb/x40HYPxV0ZEXDX
	SDve/QLN6lS5Y7/ZwA/xJHQtjnnLaCZTMDBWm03eLQObmpkMzbc3PL2NME82M82xsLDCfqw44ZUEG
	IVTFzDePxqxM2+AyfRCHGIRmnXEfA5gvxJGZGBEWo8i07WY12DrBElP8ZescaTJcHIgKFjXI8kcxD
	RTaEDUfyB+Evem5/eFP6ugfpW/oYqjpLjSbwlqC50WFLAVbS38uw+R6e2+xmwX+OH2VW3wa8Eipm5
	V6mXk6cA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sRM3J-00000008YZy-1oIi;
	Wed, 10 Jul 2024 01:23:25 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH 1/7] minixfs: Convert dir_get_page() to dir_get_folio()
Date: Wed, 10 Jul 2024 02:23:15 +0100
Message-ID: <20240710012323.2039519-2-willy@infradead.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240710012323.2039519-1-willy@infradead.org>
References: <20240710012323.2039519-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove a few conversions between page and folio.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/minix/dir.c | 66 ++++++++++++++++++++++++++------------------------
 1 file changed, 35 insertions(+), 31 deletions(-)

diff --git a/fs/minix/dir.c b/fs/minix/dir.c
index a224cf222570..41e6c0c2e243 100644
--- a/fs/minix/dir.c
+++ b/fs/minix/dir.c
@@ -64,14 +64,15 @@ static int minix_handle_dirsync(struct inode *dir)
 	return err;
 }
 
-static void *dir_get_page(struct inode *dir, unsigned long n, struct page **p)
+static void *dir_get_folio(struct inode *dir, unsigned long n,
+		struct folio **foliop)
 {
-	struct address_space *mapping = dir->i_mapping;
-	struct page *page = read_mapping_page(mapping, n, NULL);
-	if (IS_ERR(page))
-		return ERR_CAST(page);
-	*p = page;
-	return kmap_local_page(page);
+	struct folio *folio = read_mapping_folio(dir->i_mapping, n, NULL);
+
+	if (IS_ERR(folio))
+		return ERR_CAST(folio);
+	*foliop = folio;
+	return kmap_local_folio(folio, 0);
 }
 
 static inline void *minix_next_entry(void *de, struct minix_sb_info *sbi)
@@ -99,9 +100,9 @@ static int minix_readdir(struct file *file, struct dir_context *ctx)
 
 	for ( ; n < npages; n++, offset = 0) {
 		char *p, *kaddr, *limit;
-		struct page *page;
+		struct folio *folio;
 
-		kaddr = dir_get_page(inode, n, &page);
+		kaddr = dir_get_folio(inode, n, &folio);
 		if (IS_ERR(kaddr))
 			continue;
 		p = kaddr+offset;
@@ -122,13 +123,13 @@ static int minix_readdir(struct file *file, struct dir_context *ctx)
 				unsigned l = strnlen(name, sbi->s_namelen);
 				if (!dir_emit(ctx, name, l,
 					      inumber, DT_UNKNOWN)) {
-					unmap_and_put_page(page, p);
+					folio_release_kmap(folio, p);
 					return 0;
 				}
 			}
 			ctx->pos += chunk_size;
 		}
-		unmap_and_put_page(page, kaddr);
+		folio_release_kmap(folio, kaddr);
 	}
 	return 0;
 }
@@ -158,7 +159,7 @@ minix_dirent *minix_find_entry(struct dentry *dentry, struct page **res_page)
 	struct minix_sb_info * sbi = minix_sb(sb);
 	unsigned long n;
 	unsigned long npages = dir_pages(dir);
-	struct page *page = NULL;
+	struct folio *folio = NULL;
 	char *p;
 
 	char *namx;
@@ -168,7 +169,7 @@ minix_dirent *minix_find_entry(struct dentry *dentry, struct page **res_page)
 	for (n = 0; n < npages; n++) {
 		char *kaddr, *limit;
 
-		kaddr = dir_get_page(dir, n, &page);
+		kaddr = dir_get_folio(dir, n, &folio);
 		if (IS_ERR(kaddr))
 			continue;
 
@@ -188,12 +189,12 @@ minix_dirent *minix_find_entry(struct dentry *dentry, struct page **res_page)
 			if (namecompare(namelen, sbi->s_namelen, name, namx))
 				goto found;
 		}
-		unmap_and_put_page(page, kaddr);
+		folio_release_kmap(folio, kaddr);
 	}
 	return NULL;
 
 found:
-	*res_page = page;
+	*res_page = &folio->page;
 	return (minix_dirent *)p;
 }
 
@@ -204,7 +205,7 @@ int minix_add_link(struct dentry *dentry, struct inode *inode)
 	int namelen = dentry->d_name.len;
 	struct super_block * sb = dir->i_sb;
 	struct minix_sb_info * sbi = minix_sb(sb);
-	struct page *page = NULL;
+	struct folio *folio = NULL;
 	unsigned long npages = dir_pages(dir);
 	unsigned long n;
 	char *kaddr, *p;
@@ -223,10 +224,10 @@ int minix_add_link(struct dentry *dentry, struct inode *inode)
 	for (n = 0; n <= npages; n++) {
 		char *limit, *dir_end;
 
-		kaddr = dir_get_page(dir, n, &page);
+		kaddr = dir_get_folio(dir, n, &folio);
 		if (IS_ERR(kaddr))
 			return PTR_ERR(kaddr);
-		lock_page(page);
+		folio_lock(folio);
 		dir_end = kaddr + minix_last_byte(dir, n);
 		limit = kaddr + PAGE_SIZE - sbi->s_dirsize;
 		for (p = kaddr; p <= limit; p = minix_next_entry(p, sbi)) {
@@ -253,15 +254,15 @@ int minix_add_link(struct dentry *dentry, struct inode *inode)
 			if (namecompare(namelen, sbi->s_namelen, name, namx))
 				goto out_unlock;
 		}
-		unlock_page(page);
-		unmap_and_put_page(page, kaddr);
+		folio_unlock(folio);
+		folio_release_kmap(folio, kaddr);
 	}
 	BUG();
 	return -EINVAL;
 
 got_it:
-	pos = page_offset(page) + offset_in_page(p);
-	err = minix_prepare_chunk(page, pos, sbi->s_dirsize);
+	pos = folio_pos(folio) + offset_in_folio(folio, p);
+	err = minix_prepare_chunk(&folio->page, pos, sbi->s_dirsize);
 	if (err)
 		goto out_unlock;
 	memcpy (namx, name, namelen);
@@ -272,15 +273,15 @@ int minix_add_link(struct dentry *dentry, struct inode *inode)
 		memset (namx + namelen, 0, sbi->s_dirsize - namelen - 2);
 		de->inode = inode->i_ino;
 	}
-	dir_commit_chunk(page, pos, sbi->s_dirsize);
+	dir_commit_chunk(&folio->page, pos, sbi->s_dirsize);
 	inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
 	mark_inode_dirty(dir);
 	err = minix_handle_dirsync(dir);
 out_put:
-	unmap_and_put_page(page, kaddr);
+	folio_release_kmap(folio, kaddr);
 	return err;
 out_unlock:
-	unlock_page(page);
+	folio_unlock(folio);
 	goto out_put;
 }
 
@@ -357,7 +358,7 @@ int minix_make_empty(struct inode *inode, struct inode *dir)
  */
 int minix_empty_dir(struct inode * inode)
 {
-	struct page *page = NULL;
+	struct folio *folio = NULL;
 	unsigned long i, npages = dir_pages(inode);
 	struct minix_sb_info *sbi = minix_sb(inode->i_sb);
 	char *name, *kaddr;
@@ -366,7 +367,7 @@ int minix_empty_dir(struct inode * inode)
 	for (i = 0; i < npages; i++) {
 		char *p, *limit;
 
-		kaddr = dir_get_page(inode, i, &page);
+		kaddr = dir_get_folio(inode, i, &folio);
 		if (IS_ERR(kaddr))
 			continue;
 
@@ -395,12 +396,12 @@ int minix_empty_dir(struct inode * inode)
 					goto not_empty;
 			}
 		}
-		unmap_and_put_page(page, kaddr);
+		folio_release_kmap(folio, kaddr);
 	}
 	return 1;
 
 not_empty:
-	unmap_and_put_page(page, kaddr);
+	folio_release_kmap(folio, kaddr);
 	return 0;
 }
 
@@ -431,11 +432,14 @@ int minix_set_link(struct minix_dir_entry *de, struct page *page,
 
 struct minix_dir_entry * minix_dotdot (struct inode *dir, struct page **p)
 {
+	struct folio *folio;
 	struct minix_sb_info *sbi = minix_sb(dir->i_sb);
-	struct minix_dir_entry *de = dir_get_page(dir, 0, p);
+	struct minix_dir_entry *de = dir_get_folio(dir, 0, &folio);
 
-	if (!IS_ERR(de))
+	if (!IS_ERR(de)) {
+		*p = &folio->page;
 		return minix_next_entry(de, sbi);
+	}
 	return NULL;
 }
 
-- 
2.43.0


