Return-Path: <linux-fsdevel+bounces-32935-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93AC19B0DE9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 21:08:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7FC71C2226C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 19:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DF7F20EA4F;
	Fri, 25 Oct 2024 19:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Z9CKdDsE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760CC20D507;
	Fri, 25 Oct 2024 19:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729883307; cv=none; b=nXlytjDVEksCbVijbK3oS++m2s097GinEkBFihMSQRtOfeUC4gX4OcIeLXeLSJAFQLVm2WTXz2UfMHfL4Hj2HE+rwL1FMxBHzRqoGwBbwr2IUQf6KT7kAt1BdsbfY1H2kvD6pO+IK77oyZnkzUTJtneybe5/RAW+wjjt0ZRCf90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729883307; c=relaxed/simple;
	bh=9enTVMVHs12oKfVFpWnjhqvGuFpEAoOlLxy3Fzi7IXA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Iga8YxF+5Sdxx0S8LW1izZjKLkob7JE1bonBU8yMPXYcaZM7OcdmNc818I7YDHCa2uzGklrCKzEtluyRLHJVoGsZX3OQZzRWORIQ315To5eTkFy5Ce9uO76UWr/tP6XCqc2Cy0W7/Txr/qqdkbGEY27MkIMba+MK1O8tB4LdQVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Z9CKdDsE; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=bYLtvapkR7mcubzCOgvmer10s+f1RTTVikU9TF3hbBA=; b=Z9CKdDsEz4JMlRlPWuCVGKZt01
	GtO1EvbE+LYe8HAn77ofsWAET1MG3O3GQMZbNWTuDMfKPVvVdhWFJnmiDgpAl5TgzgsNxC+ZzPaSl
	+uqkEUmK7QRPrSYwSLThXHi9fL3pdtBUNUmaGRrug3aZo+9xK7mwcO3aU+WxqwlgOH5kG7zar1YBo
	g4Xky4/PKYi6Xr6f3vqfY7KMXGwnpOMiqM6da0zh8jgoet0KZMLiY0tYLIKwZ8dgtY+dzwrHeFxZm
	qWvnICkolymZVqN4+sd8CzMkQtOzmG3GjE8p27c9kS0Xys7w/1EY2mBAnLPrLUvnTdW+zbbGkRi28
	DcyiMMUg==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t4Pfb-00000005XBJ-3sKj;
	Fri, 25 Oct 2024 19:08:23 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Tyler Hicks <code@tyhicks.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	ecryptfs@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 04/10] ecryptfs: Convert ecryptfs_read_lower_page_segment() to take a folio
Date: Fri, 25 Oct 2024 20:08:14 +0100
Message-ID: <20241025190822.1319162-5-willy@infradead.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241025190822.1319162-1-willy@infradead.org>
References: <20241025190822.1319162-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All callers have a folio, so pass it in and use it directly.  This will
not work for large folios, but I doubt anybody wants to use large folios
with ecryptfs.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ecryptfs/ecryptfs_kernel.h |  2 +-
 fs/ecryptfs/mmap.c            | 13 ++++++-------
 fs/ecryptfs/read_write.c      | 10 +++++-----
 3 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/fs/ecryptfs/ecryptfs_kernel.h b/fs/ecryptfs/ecryptfs_kernel.h
index c586c5db18b5..43f1b5ff987d 100644
--- a/fs/ecryptfs/ecryptfs_kernel.h
+++ b/fs/ecryptfs/ecryptfs_kernel.h
@@ -658,7 +658,7 @@ int ecryptfs_write_lower_page_segment(struct inode *ecryptfs_inode,
 int ecryptfs_write(struct inode *inode, char *data, loff_t offset, size_t size);
 int ecryptfs_read_lower(char *data, loff_t offset, size_t size,
 			struct inode *ecryptfs_inode);
-int ecryptfs_read_lower_page_segment(struct page *page_for_ecryptfs,
+int ecryptfs_read_lower_page_segment(struct folio *folio_for_ecryptfs,
 				     pgoff_t page_index,
 				     size_t offset_in_page, size_t size,
 				     struct inode *ecryptfs_inode);
diff --git a/fs/ecryptfs/mmap.c b/fs/ecryptfs/mmap.c
index bd78a36ed479..1fc87c83e43c 100644
--- a/fs/ecryptfs/mmap.c
+++ b/fs/ecryptfs/mmap.c
@@ -150,7 +150,7 @@ ecryptfs_copy_up_encrypted_with_header(struct folio *folio,
 				 - crypt_stat->metadata_size);
 
 			rc = ecryptfs_read_lower_page_segment(
-				&folio->page, (lower_offset >> PAGE_SHIFT),
+				folio, (lower_offset >> PAGE_SHIFT),
 				(lower_offset & ~PAGE_MASK),
 				crypt_stat->extent_size, folio->mapping->host);
 			if (rc) {
@@ -184,9 +184,8 @@ static int ecryptfs_read_folio(struct file *file, struct folio *folio)
 	int err = 0;
 
 	if (!crypt_stat || !(crypt_stat->flags & ECRYPTFS_ENCRYPTED)) {
-		err = ecryptfs_read_lower_page_segment(&folio->page, folio->index, 0,
-						      folio_size(folio),
-						      inode);
+		err = ecryptfs_read_lower_page_segment(folio, folio->index, 0,
+				folio_size(folio), inode);
 	} else if (crypt_stat->flags & ECRYPTFS_VIEW_AS_ENCRYPTED) {
 		if (crypt_stat->flags & ECRYPTFS_METADATA_IN_XATTR) {
 			err = ecryptfs_copy_up_encrypted_with_header(folio,
@@ -201,7 +200,7 @@ static int ecryptfs_read_folio(struct file *file, struct folio *folio)
 			}
 
 		} else {
-			err = ecryptfs_read_lower_page_segment(&folio->page,
+			err = ecryptfs_read_lower_page_segment(folio,
 					folio->index, 0, folio_size(folio),
 					inode);
 			if (err) {
@@ -279,7 +278,7 @@ static int ecryptfs_write_begin(struct file *file,
 
 		if (!(crypt_stat->flags & ECRYPTFS_ENCRYPTED)) {
 			rc = ecryptfs_read_lower_page_segment(
-				&folio->page, index, 0, PAGE_SIZE, mapping->host);
+				folio, index, 0, PAGE_SIZE, mapping->host);
 			if (rc) {
 				printk(KERN_ERR "%s: Error attempting to read "
 				       "lower page segment; rc = [%d]\n",
@@ -305,7 +304,7 @@ static int ecryptfs_write_begin(struct file *file,
 				folio_mark_uptodate(folio);
 			} else {
 				rc = ecryptfs_read_lower_page_segment(
-					&folio->page, index, 0, PAGE_SIZE,
+					folio, index, 0, PAGE_SIZE,
 					mapping->host);
 				if (rc) {
 					printk(KERN_ERR "%s: Error reading "
diff --git a/fs/ecryptfs/read_write.c b/fs/ecryptfs/read_write.c
index 3458f153a588..251e9f6c6972 100644
--- a/fs/ecryptfs/read_write.c
+++ b/fs/ecryptfs/read_write.c
@@ -228,7 +228,7 @@ int ecryptfs_read_lower(char *data, loff_t offset, size_t size,
 
 /**
  * ecryptfs_read_lower_page_segment
- * @page_for_ecryptfs: The page into which data for eCryptfs will be
+ * @folio_for_ecryptfs: The folio into which data for eCryptfs will be
  *                     written
  * @page_index: Page index in @page_for_ecryptfs from which to start
  *		writing
@@ -243,7 +243,7 @@ int ecryptfs_read_lower(char *data, loff_t offset, size_t size,
  *
  * Returns zero on success; non-zero otherwise
  */
-int ecryptfs_read_lower_page_segment(struct page *page_for_ecryptfs,
+int ecryptfs_read_lower_page_segment(struct folio *folio_for_ecryptfs,
 				     pgoff_t page_index,
 				     size_t offset_in_page, size_t size,
 				     struct inode *ecryptfs_inode)
@@ -252,12 +252,12 @@ int ecryptfs_read_lower_page_segment(struct page *page_for_ecryptfs,
 	loff_t offset;
 	int rc;
 
-	offset = ((((loff_t)page_index) << PAGE_SHIFT) + offset_in_page);
-	virt = kmap_local_page(page_for_ecryptfs);
+	offset = (loff_t)page_index * PAGE_SIZE + offset_in_page;
+	virt = kmap_local_folio(folio_for_ecryptfs, 0);
 	rc = ecryptfs_read_lower(virt, offset, size, ecryptfs_inode);
 	if (rc > 0)
 		rc = 0;
 	kunmap_local(virt);
-	flush_dcache_page(page_for_ecryptfs);
+	flush_dcache_folio(folio_for_ecryptfs);
 	return rc;
 }
-- 
2.43.0


