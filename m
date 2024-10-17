Return-Path: <linux-fsdevel+bounces-32212-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 380A49A2655
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 17:17:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0B671F2286E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 15:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 122F81DEFCB;
	Thu, 17 Oct 2024 15:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fVUvKPiZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9414D1DE4EB;
	Thu, 17 Oct 2024 15:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729178237; cv=none; b=F6tx5tlZi8NQFfJcn6zXq6tN5OYmo0wkBRvJBP94w+EinCbZ9epdS9x61MlF2R1Kh6MAVNDsco1AL3Fain8kzdyPGo1MNL2GlsZ7wQ8TI7YsgnnrcxykWyrMURnj9Eh1jrCSucMM23r06v0CJn6KFJknFaNCBBcmIqP8/t/+yAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729178237; c=relaxed/simple;
	bh=2P/Q+WTVtaXSZxbAymCvV9JDU1wdXYHtetE2/H2WYyI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=phxAtQB7V+kZAsjh6AYDowIqAG3Lsm8gBDWx2bNx+UHC8+R06guy+KBptZ8x5vXnnEgJF5b0u9xf/F+OQqVA30iTigE6XKk2dg93fh0zgAU4iK6xlxJo0+5AuTQUiTRJzTy88FNBsKinELSo3xWajH2ecDO9y2tHjSZ97VT+BvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=fVUvKPiZ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=yXLPyePunnFCiAm+ZZYOcAd5KjXkJ4YfWrDc5djqjl0=; b=fVUvKPiZsabViaCoAX68Sn6kR1
	dKDwM296DSvJHXpe0wm0ST0Z9VZN21Qal/Uev6qPJ5a468w+OJJJXYhcN5Z54ysqsGXZ09z/HtzsY
	yBSQjYb1fVnUr/de/7ePlsH7fdtU7ymn51EDW7Eadxd54z801yBvAqkBxbiXbbvwNqxcTzco9L7aB
	EZXtJXofc2FUP8+JSqZfey2eDOCW1RYtOxkpwAsa5frFwURCfimWkpZFuvmxU4ctCp8/YOMz3rHDg
	URcf+fTkH4vurAtNgjAXm5a2MIzTuFc8/c2/XvTZOyZ2w4zHh391VBADFxSeNpOMVomhd5dEbx2uq
	hhOOolRQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t1SFU-0000000BNo6-0Xr9;
	Thu, 17 Oct 2024 15:17:12 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Tyler Hicks <code@tyhicks.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	ecryptfs@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 08/10] ecryptfs: Convert ecryptfs_decrypt_page() to take a folio
Date: Thu, 17 Oct 2024 16:17:03 +0100
Message-ID: <20241017151709.2713048-9-willy@infradead.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241017151709.2713048-1-willy@infradead.org>
References: <20241017151709.2713048-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both callers have a folio, so pass it in and use it throughout.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ecryptfs/crypto.c          | 9 +++++----
 fs/ecryptfs/ecryptfs_kernel.h | 2 +-
 fs/ecryptfs/mmap.c            | 4 ++--
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/fs/ecryptfs/crypto.c b/fs/ecryptfs/crypto.c
index 424233177b43..02bccaa7c666 100644
--- a/fs/ecryptfs/crypto.c
+++ b/fs/ecryptfs/crypto.c
@@ -475,7 +475,7 @@ int ecryptfs_encrypt_page(struct folio *folio)
  *
  * Returns zero on success; negative on error
  */
-int ecryptfs_decrypt_page(struct page *page)
+int ecryptfs_decrypt_page(struct folio *folio)
 {
 	struct inode *ecryptfs_inode;
 	struct ecryptfs_crypt_stat *crypt_stat;
@@ -484,13 +484,13 @@ int ecryptfs_decrypt_page(struct page *page)
 	loff_t lower_offset;
 	int rc = 0;
 
-	ecryptfs_inode = page->mapping->host;
+	ecryptfs_inode = folio->mapping->host;
 	crypt_stat =
 		&(ecryptfs_inode_to_private(ecryptfs_inode)->crypt_stat);
 	BUG_ON(!(crypt_stat->flags & ECRYPTFS_ENCRYPTED));
 
-	lower_offset = lower_offset_for_page(crypt_stat, page);
-	page_virt = kmap_local_page(page);
+	lower_offset = lower_offset_for_page(crypt_stat, &folio->page);
+	page_virt = kmap_local_folio(folio, 0);
 	rc = ecryptfs_read_lower(page_virt, lower_offset, PAGE_SIZE,
 				 ecryptfs_inode);
 	kunmap_local(page_virt);
@@ -504,6 +504,7 @@ int ecryptfs_decrypt_page(struct page *page)
 	for (extent_offset = 0;
 	     extent_offset < (PAGE_SIZE / crypt_stat->extent_size);
 	     extent_offset++) {
+		struct page *page = folio_page(folio, 0);
 		rc = crypt_extent(crypt_stat, page, page,
 				  extent_offset, DECRYPT);
 		if (rc) {
diff --git a/fs/ecryptfs/ecryptfs_kernel.h b/fs/ecryptfs/ecryptfs_kernel.h
index bffced0c1d8f..1f562e75d0e4 100644
--- a/fs/ecryptfs/ecryptfs_kernel.h
+++ b/fs/ecryptfs/ecryptfs_kernel.h
@@ -570,7 +570,7 @@ void ecryptfs_destroy_mount_crypt_stat(
 int ecryptfs_init_crypt_ctx(struct ecryptfs_crypt_stat *crypt_stat);
 int ecryptfs_write_inode_size_to_metadata(struct inode *ecryptfs_inode);
 int ecryptfs_encrypt_page(struct folio *folio);
-int ecryptfs_decrypt_page(struct page *page);
+int ecryptfs_decrypt_page(struct folio *folio);
 int ecryptfs_write_metadata(struct dentry *ecryptfs_dentry,
 			    struct inode *ecryptfs_inode);
 int ecryptfs_read_metadata(struct dentry *ecryptfs_dentry);
diff --git a/fs/ecryptfs/mmap.c b/fs/ecryptfs/mmap.c
index 1bf46d2c6a82..6ec4a60c1f3a 100644
--- a/fs/ecryptfs/mmap.c
+++ b/fs/ecryptfs/mmap.c
@@ -195,7 +195,7 @@ static int ecryptfs_read_folio(struct file *file, struct folio *folio)
 			}
 		}
 	} else {
-		rc = ecryptfs_decrypt_page(&folio->page);
+		rc = ecryptfs_decrypt_page(folio);
 		if (rc) {
 			ecryptfs_printk(KERN_ERR, "Error decrypting page; "
 					"rc = [%d]\n", rc);
@@ -308,7 +308,7 @@ static int ecryptfs_write_begin(struct file *file,
 				folio_zero_range(folio, 0, PAGE_SIZE);
 				folio_mark_uptodate(folio);
 			} else if (len < PAGE_SIZE) {
-				rc = ecryptfs_decrypt_page(&folio->page);
+				rc = ecryptfs_decrypt_page(folio);
 				if (rc) {
 					printk(KERN_ERR "%s: Error decrypting "
 					       "page at index [%ld]; "
-- 
2.43.0


