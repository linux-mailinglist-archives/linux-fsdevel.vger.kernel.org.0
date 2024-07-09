Return-Path: <linux-fsdevel+bounces-23352-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F48892AEC6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 05:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 296AA28229A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 03:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2F0B12DD88;
	Tue,  9 Jul 2024 03:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XwhtkTwl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7FE12C46F
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Jul 2024 03:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720495840; cv=none; b=c0TMDXZHPQt7RTD75tJySo3DtlVQtUW3HdQzADc8zRfWnYd2X7WKfZ6rKW68VoWNuSAqevH8uL7mrPOMw2vS1CKEQ9yKbf6pzxg9sLpUF/B89V2P5Qu4EJi0d/wezqmHbAUVNt4hiXTZUKXHd3T/Tla5pFscmYN95lWTcFN6400=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720495840; c=relaxed/simple;
	bh=DBgN0O7JoPZ1T1KEU2CIXrUGaO+kp1X/FljQucYhgI4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=prq2+fMI7HxgE1BAdNN2iaXEmEOsAwmSKkfYaxWBPryINlODCJTypJ0Fh9PZI630IYzlfOC8WNDJscZoYRKdkAMsL7IJpjRSN+tzw8PCLCtB5s74aOx1TqJ9A6ulSck7B2WDMHqeoI+/NPjIe1yzuDbKVEB4TwB3Ii1y/ZUZDQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XwhtkTwl; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=doaouVmAEXZyjb88/tH6NQPtu9oK2glAhgUxzv971OU=; b=XwhtkTwlTL/Roqf9ocXeaQ3/KY
	r00iaDp0s9+jA7apnm/boh7C8WN9D075KvUt1y6YahfC+XqHbGsHiwk7WawGnEPESmJccaH68+cYv
	4nsjpKHW085TKnFwBCzsuoRsC4JcL0nL4VTrdHbCqQwydsf+PCrve01WgUXgHo/wgeLh48XfcqN32
	RIbOpFgQKKjrQK8Jl6lxgydgjVECmpafcfm3WADOjH9unMey82i8YMt2BhJT8VlP+JQ1G1d75/lFE
	sKpsBUSzGW04C4B3QpwnmTQ50Eya02naAj8yCKiybiZr8NCqzgo2ksgUecDsFKkHO9zXjASdLY7aC
	968X7FVA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sR1Yl-00000007QSZ-1PeS;
	Tue, 09 Jul 2024 03:30:31 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH 02/10] ufs: Convert ufs_get_page() to ufs_get_folio()
Date: Tue,  9 Jul 2024 04:30:19 +0100
Message-ID: <20240709033029.1769992-3-willy@infradead.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240709033029.1769992-1-willy@infradead.org>
References: <20240709033029.1769992-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the same calling convention as ext2 (see commit 46022375abe8)
so that we can transition to kmap_local in a future patch.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ufs/dir.c | 101 ++++++++++++++++++++++++---------------------------
 1 file changed, 48 insertions(+), 53 deletions(-)

diff --git a/fs/ufs/dir.c b/fs/ufs/dir.c
index 0705848899c1..6c3235f426ed 100644
--- a/fs/ufs/dir.c
+++ b/fs/ufs/dir.c
@@ -191,19 +191,22 @@ static bool ufs_check_page(struct page *page)
 	return false;
 }
 
-static struct page *ufs_get_page(struct inode *dir, unsigned long n)
+static void *ufs_get_folio(struct inode *dir, unsigned long n,
+		struct folio **foliop)
 {
 	struct address_space *mapping = dir->i_mapping;
 	struct folio *folio = read_mapping_folio(mapping, n, NULL);
+	void *kaddr;
 
 	if (IS_ERR(folio))
-		return &folio->page;
-	kmap(&folio->page);
+		return ERR_CAST(folio);
+	kaddr = kmap(&folio->page);
 	if (unlikely(!folio_test_checked(folio))) {
 		if (!ufs_check_page(&folio->page))
 			goto fail;
 	}
-	return &folio->page;
+	*foliop = folio;
+	return kaddr;
 
 fail:
 	ufs_put_page(&folio->page);
@@ -234,14 +237,14 @@ ufs_next_entry(struct super_block *sb, struct ufs_dir_entry *p)
 
 struct ufs_dir_entry *ufs_dotdot(struct inode *dir, struct page **p)
 {
-	struct page *page = ufs_get_page(dir, 0);
-	struct ufs_dir_entry *de = NULL;
+	struct folio *folio;
+	struct ufs_dir_entry *de = ufs_get_folio(dir, 0, &folio);
+
+	if (IS_ERR(de))
+		return NULL;
+	de = ufs_next_entry(dir->i_sb, de);
+	*p = &folio->page;
 
-	if (!IS_ERR(page)) {
-		de = ufs_next_entry(dir->i_sb,
-				    (struct ufs_dir_entry *)page_address(page));
-		*p = page;
-	}
 	return de;
 }
 
@@ -262,7 +265,7 @@ struct ufs_dir_entry *ufs_find_entry(struct inode *dir, const struct qstr *qstr,
 	unsigned reclen = UFS_DIR_REC_LEN(namelen);
 	unsigned long start, n;
 	unsigned long npages = dir_pages(dir);
-	struct page *page = NULL;
+	struct folio *folio;
 	struct ufs_inode_info *ui = UFS_I(dir);
 	struct ufs_dir_entry *de;
 
@@ -280,18 +283,17 @@ struct ufs_dir_entry *ufs_find_entry(struct inode *dir, const struct qstr *qstr,
 		start = 0;
 	n = start;
 	do {
-		char *kaddr;
-		page = ufs_get_page(dir, n);
-		if (!IS_ERR(page)) {
-			kaddr = page_address(page);
-			de = (struct ufs_dir_entry *) kaddr;
+		char *kaddr = ufs_get_folio(dir, n, &folio);
+
+		if (!IS_ERR(kaddr)) {
+			de = (struct ufs_dir_entry *)kaddr;
 			kaddr += ufs_last_byte(dir, n) - reclen;
 			while ((char *) de <= kaddr) {
 				if (ufs_match(sb, namelen, name, de))
 					goto found;
 				de = ufs_next_entry(sb, de);
 			}
-			ufs_put_page(page);
+			ufs_put_page(&folio->page);
 		}
 		if (++n >= npages)
 			n = 0;
@@ -300,7 +302,7 @@ struct ufs_dir_entry *ufs_find_entry(struct inode *dir, const struct qstr *qstr,
 	return NULL;
 
 found:
-	*res_page = page;
+	*res_page = &folio->page;
 	ui->i_dir_start_lookup = n;
 	return de;
 }
@@ -317,11 +319,10 @@ int ufs_add_link(struct dentry *dentry, struct inode *inode)
 	unsigned reclen = UFS_DIR_REC_LEN(namelen);
 	const unsigned int chunk_size = UFS_SB(sb)->s_uspi->s_dirblksize;
 	unsigned short rec_len, name_len;
-	struct page *page = NULL;
+	struct folio *folio = NULL;
 	struct ufs_dir_entry *de;
 	unsigned long npages = dir_pages(dir);
 	unsigned long n;
-	char *kaddr;
 	loff_t pos;
 	int err;
 
@@ -329,21 +330,19 @@ int ufs_add_link(struct dentry *dentry, struct inode *inode)
 
 	/*
 	 * We take care of directory expansion in the same loop.
-	 * This code plays outside i_size, so it locks the page
+	 * This code plays outside i_size, so it locks the folio
 	 * to protect that region.
 	 */
 	for (n = 0; n <= npages; n++) {
+		char *kaddr = ufs_get_folio(dir, n, &folio);
 		char *dir_end;
 
-		page = ufs_get_page(dir, n);
-		err = PTR_ERR(page);
-		if (IS_ERR(page))
-			goto out;
-		lock_page(page);
-		kaddr = page_address(page);
+		if (IS_ERR(kaddr))
+			return PTR_ERR(kaddr);
+		folio_lock(folio);
 		dir_end = kaddr + ufs_last_byte(dir, n);
 		de = (struct ufs_dir_entry *)kaddr;
-		kaddr += PAGE_SIZE - reclen;
+		kaddr += folio_size(folio) - reclen;
 		while ((char *)de <= kaddr) {
 			if ((char *)de == dir_end) {
 				/* We hit i_size */
@@ -370,16 +369,15 @@ int ufs_add_link(struct dentry *dentry, struct inode *inode)
 				goto got_it;
 			de = (struct ufs_dir_entry *) ((char *) de + rec_len);
 		}
-		unlock_page(page);
-		ufs_put_page(page);
+		folio_unlock(folio);
+		ufs_put_page(&folio->page);
 	}
 	BUG();
 	return -EINVAL;
 
 got_it:
-	pos = page_offset(page) +
-			(char*)de - (char*)page_address(page);
-	err = ufs_prepare_chunk(page, pos, rec_len);
+	pos = folio_pos(folio) + offset_in_folio(folio, de);
+	err = ufs_prepare_chunk(&folio->page, pos, rec_len);
 	if (err)
 		goto out_unlock;
 	if (de->d_ino) {
@@ -396,18 +394,17 @@ int ufs_add_link(struct dentry *dentry, struct inode *inode)
 	de->d_ino = cpu_to_fs32(sb, inode->i_ino);
 	ufs_set_de_type(sb, de, inode->i_mode);
 
-	ufs_commit_chunk(page, pos, rec_len);
+	ufs_commit_chunk(&folio->page, pos, rec_len);
 	inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
 
 	mark_inode_dirty(dir);
 	err = ufs_handle_dirsync(dir);
 	/* OFFSET_CACHE */
 out_put:
-	ufs_put_page(page);
-out:
+	ufs_put_page(&folio->page);
 	return err;
 out_unlock:
-	unlock_page(page);
+	folio_unlock(folio);
 	goto out_put;
 }
 
@@ -445,19 +442,18 @@ ufs_readdir(struct file *file, struct dir_context *ctx)
 		return 0;
 
 	for ( ; n < npages; n++, offset = 0) {
-		char *kaddr, *limit;
 		struct ufs_dir_entry *de;
+		struct folio *folio;
+		char *kaddr = ufs_get_folio(inode, n, &folio);
+		char *limit;
 
-		struct page *page = ufs_get_page(inode, n);
-
-		if (IS_ERR(page)) {
+		if (IS_ERR(kaddr)) {
 			ufs_error(sb, __func__,
 				  "bad page in #%lu",
 				  inode->i_ino);
 			ctx->pos += PAGE_SIZE - offset;
-			return -EIO;
+			return PTR_ERR(kaddr);
 		}
-		kaddr = page_address(page);
 		if (unlikely(need_revalidate)) {
 			if (offset) {
 				offset = ufs_validate_entry(sb, kaddr, offset, chunk_mask);
@@ -483,13 +479,13 @@ ufs_readdir(struct file *file, struct dir_context *ctx)
 					       ufs_get_de_namlen(sb, de),
 					       fs32_to_cpu(sb, de->d_ino),
 					       d_type)) {
-					ufs_put_page(page);
+					ufs_put_page(&folio->page);
 					return 0;
 				}
 			}
 			ctx->pos += fs16_to_cpu(sb, de->d_reclen);
 		}
-		ufs_put_page(page);
+		ufs_put_page(&folio->page);
 	}
 	return 0;
 }
@@ -600,18 +596,17 @@ int ufs_make_empty(struct inode * inode, struct inode *dir)
 int ufs_empty_dir(struct inode * inode)
 {
 	struct super_block *sb = inode->i_sb;
-	struct page *page = NULL;
+	struct folio *folio;
+	char *kaddr;
 	unsigned long i, npages = dir_pages(inode);
 
 	for (i = 0; i < npages; i++) {
-		char *kaddr;
 		struct ufs_dir_entry *de;
-		page = ufs_get_page(inode, i);
 
-		if (IS_ERR(page))
+		kaddr = ufs_get_folio(inode, i, &folio);
+		if (IS_ERR(kaddr))
 			continue;
 
-		kaddr = page_address(page);
 		de = (struct ufs_dir_entry *)kaddr;
 		kaddr += ufs_last_byte(inode, i) - UFS_DIR_REC_LEN(1);
 
@@ -638,12 +633,12 @@ int ufs_empty_dir(struct inode * inode)
 			}
 			de = ufs_next_entry(sb, de);
 		}
-		ufs_put_page(page);
+		ufs_put_page(&folio->page);
 	}
 	return 1;
 
 not_empty:
-	ufs_put_page(page);
+	ufs_put_page(&folio->page);
 	return 0;
 }
 
-- 
2.43.0


