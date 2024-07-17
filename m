Return-Path: <linux-fsdevel+bounces-23843-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79C45933FEA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2024 17:47:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB2AB1C2152D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2024 15:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE0071822CD;
	Wed, 17 Jul 2024 15:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sjfmet6+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713621802A5
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Jul 2024 15:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721231244; cv=none; b=utX5PBbhb/0OlUPbqfeTOhXBcmduAyGovOOF36FmHRsG32mqX/iNXNCvDJm073ettSBoCetGBMDcq3BPb3dZvnzu/8q1bdngxqBhSP/FV/pOOdFU0QY41M+bGC69afOaOSIZyndE8bGUbn0UJA++ubpT/Civ819ldsYpfGJVNVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721231244; c=relaxed/simple;
	bh=j1b520dmMsgNz5hcysIYQaJJpapCAurli98cc9dm0xE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n3y6APhK7rnIuRo48CjPp/lDN946FAfK1AuIMuk6Hr6ELkmO2CTU480SWwOrlvQiBkAba1XnkguoNaKhmAIbVWp3gB6K0wchllAwnjiMyyRZbKGdHZjd6NwJPQRVlKnrI/5j0p9I8w82NippvAdi0Q436LF3O10PUfuVikQua8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=sjfmet6+; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=udJ4DmeQbt/C3gqDy9NEYBbYFMRAS7/Q0zPk9HF4q8k=; b=sjfmet6+2cxCsOwpsd0HkRlXJu
	lQPyT9l3kNE1HuFDiVnjmixrYjwCLD+7n7ssvGlZ5DZ+C7ibC9XVrwUyiM7nMsxRg+otmER507jxF
	+f1XsOwh2NZQKH7GyJM8j489U5lpvWr1h0drgmiZPKuv7Nnr3ZEDNztijv3KdhmlNQRweB3rcq1TW
	BI2q4/vDAZjg9OWD5EsYzjQmQH+MQGBAag/11P/8L5BhqF+bf8KCJGstDEarEMiugC5/ICK6wI4p6
	KLRzT+wxNY6Kep2ecIqKHAbYC1qjXvNkbBE6yed7N0AhIuUan6c5fbPk3zWwKJE2QE2zZBjE3lJdt
	UBHVo1cw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sU6sC-00000000zuY-3Kps;
	Wed, 17 Jul 2024 15:47:20 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 08/23] ecryptfs: Convert ecryptfs_write_end() to use a folio
Date: Wed, 17 Jul 2024 16:46:58 +0100
Message-ID: <20240717154716.237943-9-willy@infradead.org>
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

Convert the passed page to a folio and operate on that.
Replaces four calls to compound_head() with one.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ecryptfs/mmap.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/fs/ecryptfs/mmap.c b/fs/ecryptfs/mmap.c
index e2483acc4366..9b86fad2b9d1 100644
--- a/fs/ecryptfs/mmap.c
+++ b/fs/ecryptfs/mmap.c
@@ -234,17 +234,17 @@ static int ecryptfs_read_folio(struct file *file, struct folio *folio)
 /*
  * Called with lower inode mutex held.
  */
-static int fill_zeros_to_end_of_page(struct page *page, unsigned int to)
+static int fill_zeros_to_end_of_page(struct folio *folio, unsigned int to)
 {
-	struct inode *inode = page->mapping->host;
+	struct inode *inode = folio->mapping->host;
 	int end_byte_in_page;
 
-	if ((i_size_read(inode) / PAGE_SIZE) != page->index)
+	if ((i_size_read(inode) / PAGE_SIZE) != folio->index)
 		goto out;
 	end_byte_in_page = i_size_read(inode) % PAGE_SIZE;
 	if (to > end_byte_in_page)
 		end_byte_in_page = to;
-	zero_user_segment(page, end_byte_in_page, PAGE_SIZE);
+	folio_zero_segment(folio, end_byte_in_page, PAGE_SIZE);
 out:
 	return 0;
 }
@@ -465,6 +465,7 @@ static int ecryptfs_write_end(struct file *file,
 			loff_t pos, unsigned len, unsigned copied,
 			struct page *page, void *fsdata)
 {
+	struct folio *folio = page_folio(page);
 	pgoff_t index = pos >> PAGE_SHIFT;
 	unsigned from = pos & (PAGE_SIZE - 1);
 	unsigned to = from + copied;
@@ -476,8 +477,8 @@ static int ecryptfs_write_end(struct file *file,
 	ecryptfs_printk(KERN_DEBUG, "Calling fill_zeros_to_end_of_page"
 			"(page w/ index = [0x%.16lx], to = [%d])\n", index, to);
 	if (!(crypt_stat->flags & ECRYPTFS_ENCRYPTED)) {
-		rc = ecryptfs_write_lower_page_segment(ecryptfs_inode, page, 0,
-						       to);
+		rc = ecryptfs_write_lower_page_segment(ecryptfs_inode,
+				&folio->page, 0, to);
 		if (!rc) {
 			rc = copied;
 			fsstack_copy_inode_size(ecryptfs_inode,
@@ -485,21 +486,21 @@ static int ecryptfs_write_end(struct file *file,
 		}
 		goto out;
 	}
-	if (!PageUptodate(page)) {
+	if (!folio_test_uptodate(folio)) {
 		if (copied < PAGE_SIZE) {
 			rc = 0;
 			goto out;
 		}
-		SetPageUptodate(page);
+		folio_mark_uptodate(folio);
 	}
 	/* Fills in zeros if 'to' goes beyond inode size */
-	rc = fill_zeros_to_end_of_page(page, to);
+	rc = fill_zeros_to_end_of_page(folio, to);
 	if (rc) {
 		ecryptfs_printk(KERN_WARNING, "Error attempting to fill "
 			"zeros in page with index = [0x%.16lx]\n", index);
 		goto out;
 	}
-	rc = ecryptfs_encrypt_page(page);
+	rc = ecryptfs_encrypt_page(&folio->page);
 	if (rc) {
 		ecryptfs_printk(KERN_WARNING, "Error encrypting page (upper "
 				"index [0x%.16lx])\n", index);
@@ -518,8 +519,8 @@ static int ecryptfs_write_end(struct file *file,
 	else
 		rc = copied;
 out:
-	unlock_page(page);
-	put_page(page);
+	folio_unlock(folio);
+	folio_put(folio);
 	return rc;
 }
 
-- 
2.43.0


