Return-Path: <linux-fsdevel+bounces-23410-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8C4992BDBD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 17:04:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38D791F266C1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 15:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 418E719D893;
	Tue,  9 Jul 2024 15:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GHvPjwFH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243F419D09E
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Jul 2024 15:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720537401; cv=none; b=eZPGqW8rW50N3e0+HYKoIqcASfyx866+T4jjCffubUsInqz2feB2NiyAwlhpSnRnaHi5fTpTR4yQk94Cj138XNxCJfHPrtqtsciwNxxViBEdFEXDe9DKOZ1q39Jm6bYKG+xR1BUpzrTBWB+QG9AuKOYBIqUks5nIgBmPe+OWU+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720537401; c=relaxed/simple;
	bh=hqIGeaGEyzuGpKBLu6VwBTRqREi9APVz9HnlUlzCW20=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mh0GiRYES+bV0QDdvXHHUBP9BqzNOR6AKUUA//1XlgnP15QqWndB6Uor/g5bnuN4pgmcaYiS4Ma7VLJzoEGs3wyyij7ZQOVmHVXuwS106dMfcECH4EhjRVLKvw1rp9zS4gYR3rQAB2bSjzvFYfasYI23iwXyiI/NzgqWvf02a3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=GHvPjwFH; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=feDi5aSsC+9xS4VEriWMgV/zl7jn3RYQP9Y+adzQmFc=; b=GHvPjwFHF+8v8UH2/fR/qc4u/V
	qfkzXK06JORQeErcL+yQBeLxDcV631DZTPHMSgwamSWI4qtLyt1vyB8SInguah+td1QiAdoJzuKXr
	BNaUh7GgGsBXgIlAbFeNiNDHuM+MQv6mKsMZItmaLffyKYUK4OCXIQxkWst2QZFDCsoxCimfoLHv4
	mw0CQD5nbFb5mj+dcVdr89HSSX5gm+DQ0SRLoRthgC2S30DXYrC2//8K1PNl89O+sM5SO28OuP5ON
	7IaLugwRfHsEztmQRWxJzWo27W9cmHPyHVhUg5LKXaNPYtCBvqBA6/HVxjUlqsBI58EdzXVQkxhDj
	YCJ/uLig==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sRCN9-00000007zrs-2N06;
	Tue, 09 Jul 2024 15:03:15 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH 1/7] sysv: Convert dir_get_page() to dir_get_folio()
Date: Tue,  9 Jul 2024 16:03:06 +0100
Message-ID: <20240709150314.1906109-2-willy@infradead.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240709150314.1906109-1-willy@infradead.org>
References: <20240709150314.1906109-1-willy@infradead.org>
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
 fs/sysv/dir.c | 80 +++++++++++++++++++++++++++------------------------
 1 file changed, 42 insertions(+), 38 deletions(-)

diff --git a/fs/sysv/dir.c b/fs/sysv/dir.c
index 2e126d72d619..1f95f82f8941 100644
--- a/fs/sysv/dir.c
+++ b/fs/sysv/dir.c
@@ -52,20 +52,21 @@ static int sysv_handle_dirsync(struct inode *dir)
 }
 
 /*
- * Calls to dir_get_page()/unmap_and_put_page() must be nested according to the
+ * Calls to dir_get_folio()/folio_release_kmap() must be nested according to the
  * rules documented in mm/highmem.rst.
  *
- * NOTE: sysv_find_entry() and sysv_dotdot() act as calls to dir_get_page()
+ * NOTE: sysv_find_entry() and sysv_dotdot() act as calls to dir_get_folio()
  * and must be treated accordingly for nesting purposes.
  */
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
 
 static int sysv_readdir(struct file *file, struct dir_context *ctx)
@@ -87,9 +88,9 @@ static int sysv_readdir(struct file *file, struct dir_context *ctx)
 	for ( ; n < npages; n++, offset = 0) {
 		char *kaddr, *limit;
 		struct sysv_dir_entry *de;
-		struct page *page;
+		struct folio *folio;
 
-		kaddr = dir_get_page(inode, n, &page);
+		kaddr = dir_get_folio(inode, n, &folio);
 		if (IS_ERR(kaddr))
 			continue;
 		de = (struct sysv_dir_entry *)(kaddr+offset);
@@ -103,11 +104,11 @@ static int sysv_readdir(struct file *file, struct dir_context *ctx)
 			if (!dir_emit(ctx, name, strnlen(name,SYSV_NAMELEN),
 					fs16_to_cpu(SYSV_SB(sb), de->inode),
 					DT_UNKNOWN)) {
-				unmap_and_put_page(page, kaddr);
+				folio_release_kmap(folio, kaddr);
 				return 0;
 			}
 		}
-		unmap_and_put_page(page, kaddr);
+		folio_release_kmap(folio, kaddr);
 	}
 	return 0;
 }
@@ -133,7 +134,7 @@ static inline int namecompare(int len, int maxlen,
  *
  * On Success unmap_and_put_page() should be called on *res_page.
  *
- * sysv_find_entry() acts as a call to dir_get_page() and must be treated
+ * sysv_find_entry() acts as a call to dir_get_folio() and must be treated
  * accordingly for nesting purposes.
  */
 struct sysv_dir_entry *sysv_find_entry(struct dentry *dentry, struct page **res_page)
@@ -143,7 +144,7 @@ struct sysv_dir_entry *sysv_find_entry(struct dentry *dentry, struct page **res_
 	struct inode * dir = d_inode(dentry->d_parent);
 	unsigned long start, n;
 	unsigned long npages = dir_pages(dir);
-	struct page *page = NULL;
+	struct folio *folio = NULL;
 	struct sysv_dir_entry *de;
 
 	*res_page = NULL;
@@ -154,7 +155,7 @@ struct sysv_dir_entry *sysv_find_entry(struct dentry *dentry, struct page **res_
 	n = start;
 
 	do {
-		char *kaddr = dir_get_page(dir, n, &page);
+		char *kaddr = dir_get_folio(dir, n, &folio);
 
 		if (!IS_ERR(kaddr)) {
 			de = (struct sysv_dir_entry *)kaddr;
@@ -166,7 +167,7 @@ struct sysv_dir_entry *sysv_find_entry(struct dentry *dentry, struct page **res_
 							name, de->name))
 					goto found;
 			}
-			unmap_and_put_page(page, kaddr);
+			folio_release_kmap(folio, kaddr);
 		}
 
 		if (++n >= npages)
@@ -177,7 +178,7 @@ struct sysv_dir_entry *sysv_find_entry(struct dentry *dentry, struct page **res_
 
 found:
 	SYSV_I(dir)->i_dir_start_lookup = n;
-	*res_page = page;
+	*res_page = &folio->page;
 	return de;
 }
 
@@ -186,7 +187,7 @@ int sysv_add_link(struct dentry *dentry, struct inode *inode)
 	struct inode *dir = d_inode(dentry->d_parent);
 	const char * name = dentry->d_name.name;
 	int namelen = dentry->d_name.len;
-	struct page *page = NULL;
+	struct folio *folio = NULL;
 	struct sysv_dir_entry * de;
 	unsigned long npages = dir_pages(dir);
 	unsigned long n;
@@ -196,7 +197,7 @@ int sysv_add_link(struct dentry *dentry, struct inode *inode)
 
 	/* We take care of directory expansion in the same loop */
 	for (n = 0; n <= npages; n++) {
-		kaddr = dir_get_page(dir, n, &page);
+		kaddr = dir_get_folio(dir, n, &folio);
 		if (IS_ERR(kaddr))
 			return PTR_ERR(kaddr);
 		de = (struct sysv_dir_entry *)kaddr;
@@ -206,33 +207,33 @@ int sysv_add_link(struct dentry *dentry, struct inode *inode)
 				goto got_it;
 			err = -EEXIST;
 			if (namecompare(namelen, SYSV_NAMELEN, name, de->name)) 
-				goto out_page;
+				goto out_folio;
 			de++;
 		}
-		unmap_and_put_page(page, kaddr);
+		folio_release_kmap(folio, kaddr);
 	}
 	BUG();
 	return -EINVAL;
 
 got_it:
-	pos = page_offset(page) + offset_in_page(de);
-	lock_page(page);
-	err = sysv_prepare_chunk(page, pos, SYSV_DIRSIZE);
+	pos = folio_pos(folio) + offset_in_folio(folio, de);
+	folio_lock(folio);
+	err = sysv_prepare_chunk(&folio->page, pos, SYSV_DIRSIZE);
 	if (err)
 		goto out_unlock;
 	memcpy (de->name, name, namelen);
 	memset (de->name + namelen, 0, SYSV_DIRSIZE - namelen - 2);
 	de->inode = cpu_to_fs16(SYSV_SB(inode->i_sb), inode->i_ino);
-	dir_commit_chunk(page, pos, SYSV_DIRSIZE);
+	dir_commit_chunk(&folio->page, pos, SYSV_DIRSIZE);
 	inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
 	mark_inode_dirty(dir);
 	err = sysv_handle_dirsync(dir);
-out_page:
-	unmap_and_put_page(page, kaddr);
+out_folio:
+	folio_release_kmap(folio, kaddr);
 	return err;
 out_unlock:
-	unlock_page(page);
-	goto out_page;
+	folio_unlock(folio);
+	goto out_folio;
 }
 
 int sysv_delete_entry(struct sysv_dir_entry *de, struct page *page)
@@ -292,19 +293,19 @@ int sysv_make_empty(struct inode *inode, struct inode *dir)
 int sysv_empty_dir(struct inode * inode)
 {
 	struct super_block *sb = inode->i_sb;
-	struct page *page = NULL;
+	struct folio *folio = NULL;
 	unsigned long i, npages = dir_pages(inode);
 	char *kaddr;
 
 	for (i = 0; i < npages; i++) {
 		struct sysv_dir_entry *de;
 
-		kaddr = dir_get_page(inode, i, &page);
+		kaddr = dir_get_folio(inode, i, &folio);
 		if (IS_ERR(kaddr))
 			continue;
 
 		de = (struct sysv_dir_entry *)kaddr;
-		kaddr += PAGE_SIZE-SYSV_DIRSIZE;
+		kaddr += folio_size(folio) - SYSV_DIRSIZE;
 
 		for ( ;(char *)de <= kaddr; de++) {
 			if (!de->inode)
@@ -321,12 +322,12 @@ int sysv_empty_dir(struct inode * inode)
 			if (de->name[1] != '.' || de->name[2])
 				goto not_empty;
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
 
@@ -352,18 +353,21 @@ int sysv_set_link(struct sysv_dir_entry *de, struct page *page,
 }
 
 /*
- * Calls to dir_get_page()/unmap_and_put_page() must be nested according to the
+ * Calls to dir_get_folio()/folio_release_kmap() must be nested according to the
  * rules documented in mm/highmem.rst.
  *
- * sysv_dotdot() acts as a call to dir_get_page() and must be treated
+ * sysv_dotdot() acts as a call to dir_get_folio() and must be treated
  * accordingly for nesting purposes.
  */
 struct sysv_dir_entry *sysv_dotdot(struct inode *dir, struct page **p)
 {
-	struct sysv_dir_entry *de = dir_get_page(dir, 0, p);
+	struct folio *folio;
+
+	struct sysv_dir_entry *de = dir_get_folio(dir, 0, &folio);
 
 	if (IS_ERR(de))
 		return NULL;
+	*p = &folio->page;
 	/* ".." is the second directory entry */
 	return de + 1;
 }
-- 
2.43.0


