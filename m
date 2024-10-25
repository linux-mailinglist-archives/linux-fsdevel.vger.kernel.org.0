Return-Path: <linux-fsdevel+bounces-32934-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B2619B0DE6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 21:08:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8C51283370
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 19:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA14D20EA3F;
	Fri, 25 Oct 2024 19:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WIt7Qdkj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3229220D4F9;
	Fri, 25 Oct 2024 19:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729883307; cv=none; b=lGqFqbOWtxPYztUso1myBf4wswMyW9l3YTSf1g48367g+dQD7bS6A4TEtDXzHLRLN1Fp2IUlcWY4Ak4cMqUGapXFOEtUJjf4A5M+g0mJxV5pym4sYxLFs5JSwrxR4CAMq8S2sX8cQ5petkueMtjVBbyvZt17MlbdSXjdaqJrr44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729883307; c=relaxed/simple;
	bh=yMd3c8W3s/W+W73+PzOt8tHrfz0d7KV4KHFiXlvrZ1A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NckqEcT5OBQkipBfXQJs7QnqOC9oBCv0wVs/e0UU0t74KdlH1ZEAhXezh9Mv1PdAHg4ilm0icHkc6lDhLiGSQknMmuf0hXQP8x6GEuwKfPd+WDQX7CU+GRfwSkcLy7OgrJ71dt/F+QZx9s/VxHEb/X5xGgxqY/WFBre+Zk0kV8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WIt7Qdkj; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=ngUUNpMHchzF+LT0PYTuG94y5wEqsIYZzLCEqG1mipQ=; b=WIt7QdkjJnUJSbX1hGDNBGS7+n
	jqqR2SbscxqBe/Xx2kGqe5v2Z2PwYN38eD58GY6HQgjMrZoSUcrLakh3aTEPqSdLUfTkUYR/bzkOO
	GcUYUvHV2re9928zGWvqTYvSc6S4ruHjUWYLCHBp5sfZmu8tO7rwzD+7lG898o/4Z6vM6kyw7k6Y8
	rxMwQ7CFVL6GR8ssG48cqR8GZ9rc3lN2fo9LeODfXu52790pHFDkMcuMHSIMdLmCELRhCMkkJfzn4
	6PeqT5qjpVM9Pv/3wdZQHyaz4Lg3/EW013hAeHjwA+ohIPkmLRDUfz+vvHRyY0zWTMdRr7imjCNqb
	Pguun7BQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t4Pfb-00000005XB4-2lXI;
	Fri, 25 Oct 2024 19:08:23 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Tyler Hicks <code@tyhicks.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	ecryptfs@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 02/10] ecryptfs: Use a folio throughout ecryptfs_read_folio()
Date: Fri, 25 Oct 2024 20:08:12 +0100
Message-ID: <20241025190822.1319162-3-willy@infradead.org>
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

Remove the conversion to a struct page.  Removes a few hidden calls to
compound_head().  Use 'err' instead of 'rc' for clarity.

Also remove the unnecessary call to ClearPageUptodate(); the uptodate
flag is already clear if this function is being called.  That lets us
switch to folio_end_read() which does one atomic flag operation instead
of two.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ecryptfs/mmap.c | 50 +++++++++++++++++++++-------------------------
 1 file changed, 23 insertions(+), 27 deletions(-)

diff --git a/fs/ecryptfs/mmap.c b/fs/ecryptfs/mmap.c
index 92ea39d907de..25a756fec5c2 100644
--- a/fs/ecryptfs/mmap.c
+++ b/fs/ecryptfs/mmap.c
@@ -178,55 +178,51 @@ ecryptfs_copy_up_encrypted_with_header(struct page *page,
  */
 static int ecryptfs_read_folio(struct file *file, struct folio *folio)
 {
-	struct page *page = &folio->page;
+	struct inode *inode = folio->mapping->host;
 	struct ecryptfs_crypt_stat *crypt_stat =
-		&ecryptfs_inode_to_private(page->mapping->host)->crypt_stat;
-	int rc = 0;
+		&ecryptfs_inode_to_private(inode)->crypt_stat;
+	int err = 0;
 
 	if (!crypt_stat || !(crypt_stat->flags & ECRYPTFS_ENCRYPTED)) {
-		rc = ecryptfs_read_lower_page_segment(page, page->index, 0,
-						      PAGE_SIZE,
-						      page->mapping->host);
+		err = ecryptfs_read_lower_page_segment(&folio->page, folio->index, 0,
+						      folio_size(folio),
+						      inode);
 	} else if (crypt_stat->flags & ECRYPTFS_VIEW_AS_ENCRYPTED) {
 		if (crypt_stat->flags & ECRYPTFS_METADATA_IN_XATTR) {
-			rc = ecryptfs_copy_up_encrypted_with_header(page,
+			err = ecryptfs_copy_up_encrypted_with_header(&folio->page,
 								    crypt_stat);
-			if (rc) {
+			if (err) {
 				printk(KERN_ERR "%s: Error attempting to copy "
 				       "the encrypted content from the lower "
 				       "file whilst inserting the metadata "
-				       "from the xattr into the header; rc = "
-				       "[%d]\n", __func__, rc);
+				       "from the xattr into the header; err = "
+				       "[%d]\n", __func__, err);
 				goto out;
 			}
 
 		} else {
-			rc = ecryptfs_read_lower_page_segment(
-				page, page->index, 0, PAGE_SIZE,
-				page->mapping->host);
-			if (rc) {
-				printk(KERN_ERR "Error reading page; rc = "
-				       "[%d]\n", rc);
+			err = ecryptfs_read_lower_page_segment(&folio->page,
+					folio->index, 0, folio_size(folio),
+					inode);
+			if (err) {
+				printk(KERN_ERR "Error reading page; err = "
+				       "[%d]\n", err);
 				goto out;
 			}
 		}
 	} else {
-		rc = ecryptfs_decrypt_page(page);
-		if (rc) {
+		err = ecryptfs_decrypt_page(&folio->page);
+		if (err) {
 			ecryptfs_printk(KERN_ERR, "Error decrypting page; "
-					"rc = [%d]\n", rc);
+					"err = [%d]\n", err);
 			goto out;
 		}
 	}
 out:
-	if (rc)
-		ClearPageUptodate(page);
-	else
-		SetPageUptodate(page);
-	ecryptfs_printk(KERN_DEBUG, "Unlocking page with index = [0x%.16lx]\n",
-			page->index);
-	unlock_page(page);
-	return rc;
+	ecryptfs_printk(KERN_DEBUG, "Unlocking folio with index = [0x%.16lx]\n",
+			folio->index);
+	folio_end_read(folio, err == 0);
+	return err;
 }
 
 /*
-- 
2.43.0


