Return-Path: <linux-fsdevel+bounces-32938-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DABE9B0DEF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 21:09:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 373E22863A0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 19:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A284820D507;
	Fri, 25 Oct 2024 19:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="R4DN4upI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA3E20D50B;
	Fri, 25 Oct 2024 19:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729883308; cv=none; b=JgEja+ewMZhX+SxVKkHlU/Q4aIinX2C53O2aV/n8GBtaXTsGH9vA1pxk+oGAFaD5lxSCCuDIIWlSYizb50Dh/erxE4l1UJ3klK3e3rbdTkfbYR3TwRINBVGrf11s5n9wkrJnfRdipTqCSHJ+m8PiMGn7M8AObdHXG1ssXHIoVZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729883308; c=relaxed/simple;
	bh=ojjdtH8wwN2gx0LLWaCdJn90MbZLfqJQ8xCLGuKjS/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OhL6ilDFoP6HWk2TLDIpodma6RXIBvs5NNiivAvMmzsszBKvxE8oh4KvbAzP8nud3GGlovaSQrWDrpiOEjyz+ihaYAWcH7rC2Xxm8CiKdDlbjiBcJTnr8Hv0AJ5zDYde/OtsdYTjJ4Ik7izIoEnY/rVFdRO3c7nlFR3OBm9Qjvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=R4DN4upI; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=jc8caRVXBO4jUHzGBRatQ/0YKXkRahvWyjp4uv+Vz74=; b=R4DN4upI76RrzQHgB37eAlJV/h
	RTQBax3RXioqCsOS+cjO9C0aN7GMB4xkEOeau0P8fb9lY1IGiaEoFGc3Qcs5GTGK8lGNRvRW5v6Bf
	xzHXmwUyvRho59qy7W53lNnrHVeIK8OH6OeTgU5/NmI1sdAHm8Qza81QLz/Txj22Fnl6aZG8zLqjj
	/zhpS8v5zhrPkjtkykMbdQhqLgtqMVeUvARWq5VvyOLXadsYgDLzFVEY4N+WY4fiSFC31o+5SYSmI
	TDGhvtlL4ZB2Cb0X5UGsNxp9H1Y5T23WCczvGqWs87+UoQUVvZm4pLJeKJK4jCbU5949XDey6dLQm
	q84Z5edA==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t4Pfb-00000005XB8-3H5g;
	Fri, 25 Oct 2024 19:08:23 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Tyler Hicks <code@tyhicks.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	ecryptfs@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH v2 03/10] ecryptfs: Convert ecryptfs_copy_up_encrypted_with_header() to take a folio
Date: Fri, 25 Oct 2024 20:08:13 +0100
Message-ID: <20241025190822.1319162-4-willy@infradead.org>
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

Both callers have a folio, so pass it in and use it throughout.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Pankaj Raghav <p.raghav@samsung.com>
---
 fs/ecryptfs/mmap.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/fs/ecryptfs/mmap.c b/fs/ecryptfs/mmap.c
index 25a756fec5c2..bd78a36ed479 100644
--- a/fs/ecryptfs/mmap.c
+++ b/fs/ecryptfs/mmap.c
@@ -95,7 +95,7 @@ static void strip_xattr_flag(char *page_virt,
 
 /**
  * ecryptfs_copy_up_encrypted_with_header
- * @page: Sort of a ``virtual'' representation of the encrypted lower
+ * @folio: Sort of a ``virtual'' representation of the encrypted lower
  *        file. The actual lower file does not have the metadata in
  *        the header. This is locked.
  * @crypt_stat: The eCryptfs inode's cryptographic context
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
@@ -189,8 +189,8 @@ static int ecryptfs_read_folio(struct file *file, struct folio *folio)
 						      inode);
 	} else if (crypt_stat->flags & ECRYPTFS_VIEW_AS_ENCRYPTED) {
 		if (crypt_stat->flags & ECRYPTFS_METADATA_IN_XATTR) {
-			err = ecryptfs_copy_up_encrypted_with_header(&folio->page,
-								    crypt_stat);
+			err = ecryptfs_copy_up_encrypted_with_header(folio,
+					crypt_stat);
 			if (err) {
 				printk(KERN_ERR "%s: Error attempting to copy "
 				       "the encrypted content from the lower "
@@ -291,7 +291,7 @@ static int ecryptfs_write_begin(struct file *file,
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


