Return-Path: <linux-fsdevel+bounces-23846-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D5EB933FEF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2024 17:47:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5233B24293
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2024 15:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EEF01822E9;
	Wed, 17 Jul 2024 15:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CI8B/IWE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F7F1E536
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Jul 2024 15:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721231244; cv=none; b=iqaZiYaqcFFpk2puK068EAtYNGiuyjIYAUMroch3gieZVa4RoQJhOr7fwZE6um5RQsNvvaWx4X3VmsIp3tXFAX9Lk2bSd9gcad3QjZfyS88d7dFBiE/jxk02CE+fFimJaJzZK2TwpfTJca3WAJtZKjH0qa1I9X2mC90e3Sb99Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721231244; c=relaxed/simple;
	bh=Vpt6Z4oG2Abz4IICMVi86YbZTOkPJ++JGqR4ZnRoCA0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=At6+jdAW9jtkpJZ2ZkQLyUElN9MeTt9dOR3IFLws1szHV3J377wjtBbBn/KrmT6lU2+COqUalgHxekhyaVKOLzuu0KvS+WjcjTU58aT+Y4EeKqk296rawFkhwHBy6gM2/lVC+mKNT+h+pHH950Sq9ykegj1vI9JSy7UJ8qEldGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=CI8B/IWE; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=q6B77ZRLMKvnkwBauykffECVktknHyQSEextu/En5Lo=; b=CI8B/IWE2GN39o1C7OJCYkUB8K
	skEfGrix4y7B1NLFkU5gNI1oI12GVZj2iAc3xMM60ovKO6hIU0LiA/ZuVZ+Py2iiw8h2+cBXNutjh
	VDewIaxyLYU45Ok/XVjOSHF1jxrff0VfMryvhhwpVhxgZmhAQpGx+xyR7MNYByhQGTmVBS6NQ8bTN
	y3NMUD0v5svMGgIDIY41X/8LWm08PhnKve3IZo0z8OcwQE41MypQY93KRPYnQZdVLEXKvFBu2+CQU
	8fBQ2Tkr5LGuuJaNgj0yacyAds+Rbe8N8WQPUW1Fhi+G1xJkdAEvZc3kxYE3G+3C4CrYWbR9LJ9T3
	PuCiXadg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sU6sC-00000000zud-3tWd;
	Wed, 17 Jul 2024 15:47:20 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 09/23] ecryptfs: Use a folio in ecryptfs_write_begin()
Date: Wed, 17 Jul 2024 16:46:59 +0100
Message-ID: <20240717154716.237943-10-willy@infradead.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240717154716.237943-1-willy@infradead.org>
References: <20240717154716.237943-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use __filemap_get_folio() instead of grab_cache_page_write_begin()
and use the folio throughout.  No attempt is made here to support
large folios, simply converting this function to use folio APIs is
the goal.  Saves many hidden calls to compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ecryptfs/mmap.c | 53 +++++++++++++++++++++++-----------------------
 1 file changed, 27 insertions(+), 26 deletions(-)

diff --git a/fs/ecryptfs/mmap.c b/fs/ecryptfs/mmap.c
index 9b86fad2b9d1..75ce28d757b7 100644
--- a/fs/ecryptfs/mmap.c
+++ b/fs/ecryptfs/mmap.c
@@ -268,35 +268,36 @@ static int ecryptfs_write_begin(struct file *file,
 			struct page **pagep, void **fsdata)
 {
 	pgoff_t index = pos >> PAGE_SHIFT;
-	struct page *page;
+	struct folio *folio;
 	loff_t prev_page_end_size;
 	int rc = 0;
 
-	page = grab_cache_page_write_begin(mapping, index);
-	if (!page)
-		return -ENOMEM;
-	*pagep = page;
+	folio = __filemap_get_folio(mapping, index, FGP_WRITEBEGIN,
+			mapping_gfp_mask(mapping));
+	if (IS_ERR(folio))
+		return PTR_ERR(folio);
+	*pagep = &folio->page;
 
 	prev_page_end_size = ((loff_t)index << PAGE_SHIFT);
-	if (!PageUptodate(page)) {
+	if (!folio_test_uptodate(folio)) {
 		struct ecryptfs_crypt_stat *crypt_stat =
 			&ecryptfs_inode_to_private(mapping->host)->crypt_stat;
 
 		if (!(crypt_stat->flags & ECRYPTFS_ENCRYPTED)) {
 			rc = ecryptfs_read_lower_page_segment(
-				page, index, 0, PAGE_SIZE, mapping->host);
+				&folio->page, index, 0, PAGE_SIZE, mapping->host);
 			if (rc) {
 				printk(KERN_ERR "%s: Error attempting to read "
 				       "lower page segment; rc = [%d]\n",
 				       __func__, rc);
-				ClearPageUptodate(page);
+				folio_clear_uptodate(folio);
 				goto out;
 			} else
-				SetPageUptodate(page);
+				folio_mark_uptodate(folio);
 		} else if (crypt_stat->flags & ECRYPTFS_VIEW_AS_ENCRYPTED) {
 			if (crypt_stat->flags & ECRYPTFS_METADATA_IN_XATTR) {
 				rc = ecryptfs_copy_up_encrypted_with_header(
-					page, crypt_stat);
+					&folio->page, crypt_stat);
 				if (rc) {
 					printk(KERN_ERR "%s: Error attempting "
 					       "to copy the encrypted content "
@@ -304,46 +305,46 @@ static int ecryptfs_write_begin(struct file *file,
 					       "inserting the metadata from "
 					       "the xattr into the header; rc "
 					       "= [%d]\n", __func__, rc);
-					ClearPageUptodate(page);
+					folio_clear_uptodate(folio);
 					goto out;
 				}
-				SetPageUptodate(page);
+				folio_mark_uptodate(folio);
 			} else {
 				rc = ecryptfs_read_lower_page_segment(
-					page, index, 0, PAGE_SIZE,
+					&folio->page, index, 0, PAGE_SIZE,
 					mapping->host);
 				if (rc) {
 					printk(KERN_ERR "%s: Error reading "
 					       "page; rc = [%d]\n",
 					       __func__, rc);
-					ClearPageUptodate(page);
+					folio_clear_uptodate(folio);
 					goto out;
 				}
-				SetPageUptodate(page);
+				folio_mark_uptodate(folio);
 			}
 		} else {
 			if (prev_page_end_size
-			    >= i_size_read(page->mapping->host)) {
-				zero_user(page, 0, PAGE_SIZE);
-				SetPageUptodate(page);
+			    >= i_size_read(mapping->host)) {
+				folio_zero_range(folio, 0, PAGE_SIZE);
+				folio_mark_uptodate(folio);
 			} else if (len < PAGE_SIZE) {
-				rc = ecryptfs_decrypt_page(page);
+				rc = ecryptfs_decrypt_page(&folio->page);
 				if (rc) {
 					printk(KERN_ERR "%s: Error decrypting "
 					       "page at index [%ld]; "
 					       "rc = [%d]\n",
-					       __func__, page->index, rc);
-					ClearPageUptodate(page);
+					       __func__, folio->index, rc);
+					folio_clear_uptodate(folio);
 					goto out;
 				}
-				SetPageUptodate(page);
+				folio_mark_uptodate(folio);
 			}
 		}
 	}
 	/* If creating a page or more of holes, zero them out via truncate.
 	 * Note, this will increase i_size. */
 	if (index != 0) {
-		if (prev_page_end_size > i_size_read(page->mapping->host)) {
+		if (prev_page_end_size > i_size_read(mapping->host)) {
 			rc = ecryptfs_truncate(file->f_path.dentry,
 					       prev_page_end_size);
 			if (rc) {
@@ -359,11 +360,11 @@ static int ecryptfs_write_begin(struct file *file,
 	 * of page?  Zero it out. */
 	if ((i_size_read(mapping->host) == prev_page_end_size)
 	    && (pos != 0))
-		zero_user(page, 0, PAGE_SIZE);
+		folio_zero_range(folio, 0, PAGE_SIZE);
 out:
 	if (unlikely(rc)) {
-		unlock_page(page);
-		put_page(page);
+		folio_unlock(folio);
+		folio_put(folio);
 		*pagep = NULL;
 	}
 	return rc;
-- 
2.43.0


