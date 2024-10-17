Return-Path: <linux-fsdevel+bounces-32211-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B3569A2652
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 17:17:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 734621C21A26
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 15:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA7F11DEFC4;
	Thu, 17 Oct 2024 15:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YAPcy7cM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB7D1DE3DA;
	Thu, 17 Oct 2024 15:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729178237; cv=none; b=ewjt7m91yIUFFA0jDxHg8VTRb/qADQfMvdR4DPPnEdAgbG8Iy9+6lgET52+PxE0qwrLqe+NhSxSeIeDOD3NChlCeiLR/jBU8qjArt+3Xt/o1FVH9Xa+rxAp9wMGEKm/O4ijvPzZ+GqrbrQQivY/wLnV3+EAAVcg/M9W6LaWrW/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729178237; c=relaxed/simple;
	bh=8pAWhcWtuSzL12yIxfUX052bkioSKjfVIoE1A9I3nhw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SE/gxrQram9hImFpqeDejXYg43cUP+beKgLS6xd1+iopF8vL8ur8t9w8Ss95Jo75x7WbhQ3ZXMhQhw4VrqlZuHMnG3k/i3Y9U2su8L5qSQOqjnfAnxar68CthW8mAX2SQAFMWusrp+fb6wfnmS84z3KA6EWJQcV7E3+tuCZx4Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=YAPcy7cM; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=QmpeqJjAnL48nebWrTmTIYxty79g5twXYGWmGvJfuYM=; b=YAPcy7cMy/erGe8B9qAuYsbmEv
	XuacXjb2ESdtQXcyxuxI39Ekn9OHhj89TLG8tKw9ZfLK436bi2XOXXQ6uKU0Il8TudLaIVydpT2sI
	k493YW4C0GoIgmEUxw6wfAgYOlRf8SQS6DBJ2+ZY3LXQk3PeV5WrtmdYHFjJL9B4gV7qQMnq0IZNl
	I3g14JGPGs5ka3kSgM6+ZLon4Md9ftX0C22MTmiDyQWIFfRnwTSrj7p4CgydwE1yZ5730yiZ6QtnP
	Q7ca29e0H1XwAO7TBo51iibB17cGrl1XZmvZi8QvF+xT4O9R/Uy2xsRfVbua90Rpstdq6LxBJ90x2
	xhhC/wYw==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t1SFT-0000000BNnS-0GIR;
	Thu, 17 Oct 2024 15:17:11 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Tyler Hicks <code@tyhicks.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	ecryptfs@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 03/10] ecryptfs: Convert ecryptfs_copy_up_encrypted_with_header() to take a folio
Date: Thu, 17 Oct 2024 16:16:58 +0100
Message-ID: <20241017151709.2713048-4-willy@infradead.org>
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
 fs/ecryptfs/mmap.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/fs/ecryptfs/mmap.c b/fs/ecryptfs/mmap.c
index 346ed5f7ff8d..f7525a906ef7 100644
--- a/fs/ecryptfs/mmap.c
+++ b/fs/ecryptfs/mmap.c
@@ -104,7 +104,7 @@ static void strip_xattr_flag(char *page_virt,
  * seeing, with the header information inserted.
  */
 static int
-ecryptfs_copy_up_encrypted_with_header(struct page *page,
+ecryptfs_copy_up_encrypted_with_header(struct folio *folio,
 				       struct ecryptfs_crypt_stat *crypt_stat)
 {
 	loff_t extent_num_in_page = 0;
@@ -113,9 +113,9 @@ ecryptfs_copy_up_encrypted_with_header(struct page *page,
 	int rc = 0;
 
 	while (extent_num_in_page < num_extents_per_page) {
-		loff_t view_extent_num = ((((loff_t)page->index)
+		loff_t view_extent_num = ((loff_t)folio->index
 					   * num_extents_per_page)
-					  + extent_num_in_page);
+					  + extent_num_in_page;
 		size_t num_header_extents_at_front =
 			(crypt_stat->metadata_size / crypt_stat->extent_size);
 
@@ -123,21 +123,21 @@ ecryptfs_copy_up_encrypted_with_header(struct page *page,
 			/* This is a header extent */
 			char *page_virt;
 
-			page_virt = kmap_local_page(page);
+			page_virt = kmap_local_folio(folio, 0);
 			memset(page_virt, 0, PAGE_SIZE);
 			/* TODO: Support more than one header extent */
 			if (view_extent_num == 0) {
 				size_t written;
 
 				rc = ecryptfs_read_xattr_region(
-					page_virt, page->mapping->host);
+					page_virt, folio->mapping->host);
 				strip_xattr_flag(page_virt + 16, crypt_stat);
 				ecryptfs_write_header_metadata(page_virt + 20,
 							       crypt_stat,
 							       &written);
 			}
 			kunmap_local(page_virt);
-			flush_dcache_page(page);
+			flush_dcache_folio(folio);
 			if (rc) {
 				printk(KERN_ERR "%s: Error reading xattr "
 				       "region; rc = [%d]\n", __func__, rc);
@@ -150,9 +150,9 @@ ecryptfs_copy_up_encrypted_with_header(struct page *page,
 				 - crypt_stat->metadata_size);
 
 			rc = ecryptfs_read_lower_page_segment(
-				page, (lower_offset >> PAGE_SHIFT),
+				&folio->page, (lower_offset >> PAGE_SHIFT),
 				(lower_offset & ~PAGE_MASK),
-				crypt_stat->extent_size, page->mapping->host);
+				crypt_stat->extent_size, folio->mapping->host);
 			if (rc) {
 				printk(KERN_ERR "%s: Error attempting to read "
 				       "extent at offset [%lld] in the lower "
@@ -189,7 +189,7 @@ static int ecryptfs_read_folio(struct file *file, struct folio *folio)
 						      inode);
 	} else if (crypt_stat->flags & ECRYPTFS_VIEW_AS_ENCRYPTED) {
 		if (crypt_stat->flags & ECRYPTFS_METADATA_IN_XATTR) {
-			rc = ecryptfs_copy_up_encrypted_with_header(&folio->page,
+			rc = ecryptfs_copy_up_encrypted_with_header(folio,
 								    crypt_stat);
 			if (rc) {
 				printk(KERN_ERR "%s: Error attempting to copy "
@@ -293,7 +293,7 @@ static int ecryptfs_write_begin(struct file *file,
 		} else if (crypt_stat->flags & ECRYPTFS_VIEW_AS_ENCRYPTED) {
 			if (crypt_stat->flags & ECRYPTFS_METADATA_IN_XATTR) {
 				rc = ecryptfs_copy_up_encrypted_with_header(
-					&folio->page, crypt_stat);
+					folio, crypt_stat);
 				if (rc) {
 					printk(KERN_ERR "%s: Error attempting "
 					       "to copy the encrypted content "
-- 
2.43.0


