Return-Path: <linux-fsdevel+bounces-32213-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE51D9A2656
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 17:17:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A3611F218D6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 15:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 255A31DEFD0;
	Thu, 17 Oct 2024 15:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ro0YL+FT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87EB81DE4D8;
	Thu, 17 Oct 2024 15:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729178237; cv=none; b=SH7tOehEyQ6bSOkyGL089hyRnGPUK8MEhsE5r1TdhXosbnv5rR/7vmgU20B3nHdblWoOrKK/d7oq+xyvaSDEg78yz/Dj+sjLBD/vk1t7CeyowSktjtm+qmtvSATZyASQ9in+yGSBjyyJryhtju6QJTsvqgQ5Z/cJoyZhiFfx1CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729178237; c=relaxed/simple;
	bh=zL4bAyjZ05KtEFhcr7cpGZOvmTcjnNvx+pBCNxyZq7o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gyPlR3+3TcM8hFhSO7N2BFditYLExjDeCDrDp3VKmE6QccR2xH9LmkCOAaXrEzeTkWBgY2KcDD+fVQ/TPCH2H1qUwE+7dxm2YAZMvJjZphhH8CHn04J20G+YQ4M9sRFwwb/xPBLcn/+1i805ytrTyz0jsDDmsZsFX0CfvsKzAXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Ro0YL+FT; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=38rLqhcMsy0L5Ad3kKQDodstFFHRENi1Ve1Bu3tuyy4=; b=Ro0YL+FTZUIdT5Y+iwBs2cmtcE
	/gVhklnlZ5a2+hO+dSe1SHv7SmmeUgx2mWD0c6gygsiN4stoL/iMRB+b7HIGVF5nIMaZMyiAlALOX
	3iKlP5neDDHJvmX1eafkVHzkgIT+WKzdEoMl+B8O59gXJlhrrdZRea8r+rYul4VGwJBC0TZP8bG8+
	e1Y8RsxuqoyYCQuwOm2T5069vRtIeAGVm0XDbskq3QtyvrJ496kj+rELJf7pvk+RWmHmqORvS2HPd
	xQdUoJil1XHPznEO5ENVBFKsWJPUlX8RuR6tApb92CTKODzDW1dazIA4Mq7ki/dve24TuuXNhCuI0
	Q3UX41CQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t1SFT-0000000BNna-11kJ;
	Thu, 17 Oct 2024 15:17:11 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Tyler Hicks <code@tyhicks.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	ecryptfs@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 04/10] ecryptfs: Convert ecryptfs_read_lower_page_segment() to take a folio
Date: Thu, 17 Oct 2024 16:16:59 +0100
Message-ID: <20241017151709.2713048-5-willy@infradead.org>
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

All callers have a folio, so pass it in and use it directly.  This will
not work for large folios, but I doubt anybody wants to use large folios
with ecryptfs.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ecryptfs/ecryptfs_kernel.h |  2 +-
 fs/ecryptfs/mmap.c            | 10 +++++-----
 fs/ecryptfs/read_write.c      | 10 +++++-----
 3 files changed, 11 insertions(+), 11 deletions(-)

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
index f7525a906ef7..b7ef0bf563bd 100644
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
@@ -184,7 +184,7 @@ static int ecryptfs_read_folio(struct file *file, struct folio *folio)
 	int rc = 0;
 
 	if (!crypt_stat || !(crypt_stat->flags & ECRYPTFS_ENCRYPTED)) {
-		rc = ecryptfs_read_lower_page_segment(&folio->page, folio->index, 0,
+		rc = ecryptfs_read_lower_page_segment(folio, folio->index, 0,
 						      folio_size(folio),
 						      inode);
 	} else if (crypt_stat->flags & ECRYPTFS_VIEW_AS_ENCRYPTED) {
@@ -201,7 +201,7 @@ static int ecryptfs_read_folio(struct file *file, struct folio *folio)
 			}
 
 		} else {
-			rc = ecryptfs_read_lower_page_segment(&folio->page,
+			rc = ecryptfs_read_lower_page_segment(folio,
 					folio->index, 0, folio_size(folio),
 					inode);
 			if (rc) {
@@ -281,7 +281,7 @@ static int ecryptfs_write_begin(struct file *file,
 
 		if (!(crypt_stat->flags & ECRYPTFS_ENCRYPTED)) {
 			rc = ecryptfs_read_lower_page_segment(
-				&folio->page, index, 0, PAGE_SIZE, mapping->host);
+				folio, index, 0, PAGE_SIZE, mapping->host);
 			if (rc) {
 				printk(KERN_ERR "%s: Error attempting to read "
 				       "lower page segment; rc = [%d]\n",
@@ -307,7 +307,7 @@ static int ecryptfs_write_begin(struct file *file,
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


