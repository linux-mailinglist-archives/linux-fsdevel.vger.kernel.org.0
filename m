Return-Path: <linux-fsdevel+bounces-32217-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53B339A265C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 17:18:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A2C01F21238
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 15:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D60821DEFCD;
	Thu, 17 Oct 2024 15:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JS3Va2Rw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47761DE880;
	Thu, 17 Oct 2024 15:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729178238; cv=none; b=ImGJAPtlO1MnEuEA9NbIiAIzyWe5jUXAkXqYQF6iS/r5ukDQSNcdOZYNJ6alfG4cttgO4t+gwLZKs1Rdk94ml8OP0IiQzpJwT8e2vIBXXzDH58IwtpoLkMRvY4BcoyKBj3DyorFIYXDGxVYPqNPqZ1Gu/owuOrCdyQldNY6+rDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729178238; c=relaxed/simple;
	bh=j1w3D0/GYQm8w5sx0WH65fsXPT8LlvpjQRplmRHK0/g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UZbGeROVMf8qzH2ih7OQCbEg1wtnryJ49QgYyUkzWq/GdtSx+jtnI3rZcug+U2lT8+wXdJq/ypMgc5Ril30EM5IwYa2NOffdLzvbSBgDg9GecR+I1UUMOUMdrNbXXIOWOMzbYeCTrYaZf7uCQA5FixmlR060S9ySbKY71H87kwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=JS3Va2Rw; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=yMR4u+v8EKlznoGnXM+GjQA9dD0RqUEprsHyhwzZiEg=; b=JS3Va2RwXHTHGrysz6953yuyoA
	NzbSHxEBLf377zKb5TMltoOZfRnXsg6T4cyb51wOAwZkmI+2NoMuFm7oY861XFXRbVfduBkHhTFEq
	l0ic4A6KSLy/rzbZOu+Uc2uAp0s+Dw/+Qq8WrzigdDJOonEY4LJTYy1JbN824s4WuGImXZMbhXO6s
	nGRcklZEZtpcGvrIn85AJ1UWV0Od9Iemz90rIRzhVh+e0yX55Ccwlpxf1X1+BVPDUPs+FR1ul20ru
	Zn+Ylpl07W23WMDB4ocfNIE/8q83jfpoFvmZxF94F6jVdLJXJO3VWqJjlCxzXZnCarVxBYzh5UvYZ
	qtOsVJNA==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t1SFU-0000000BNoL-1if6;
	Thu, 17 Oct 2024 15:17:12 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Tyler Hicks <code@tyhicks.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	ecryptfs@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 10/10] ecryptfs: Pass the folio index to crypt_extent()
Date: Thu, 17 Oct 2024 16:17:05 +0100
Message-ID: <20241017151709.2713048-11-willy@infradead.org>
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

We need to pass pages, not folios, to crypt_extent() as we may be
working with a plain page rather than a folio.  But we need to know the
index in the file, so pass it in from the caller.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ecryptfs/crypto.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/ecryptfs/crypto.c b/fs/ecryptfs/crypto.c
index 3db50a779dc7..c708b9012e21 100644
--- a/fs/ecryptfs/crypto.c
+++ b/fs/ecryptfs/crypto.c
@@ -350,9 +350,9 @@ static loff_t lower_offset_for_page(struct ecryptfs_crypt_stat *crypt_stat,
 static int crypt_extent(struct ecryptfs_crypt_stat *crypt_stat,
 			struct page *dst_page,
 			struct page *src_page,
+			pgoff_t page_index,
 			unsigned long extent_offset, int op)
 {
-	pgoff_t page_index = op == ENCRYPT ? src_page->index : dst_page->index;
 	loff_t extent_base;
 	char extent_iv[ECRYPTFS_MAX_IV_BYTES];
 	struct scatterlist src_sg, dst_sg;
@@ -432,7 +432,8 @@ int ecryptfs_encrypt_page(struct folio *folio)
 	     extent_offset < (PAGE_SIZE / crypt_stat->extent_size);
 	     extent_offset++) {
 		rc = crypt_extent(crypt_stat, enc_extent_page,
-				folio_page(folio, 0), extent_offset, ENCRYPT);
+				folio_page(folio, 0), folio->index,
+				extent_offset, ENCRYPT);
 		if (rc) {
 			printk(KERN_ERR "%s: Error encrypting extent; "
 			       "rc = [%d]\n", __func__, rc);
@@ -505,8 +506,8 @@ int ecryptfs_decrypt_page(struct folio *folio)
 	     extent_offset < (PAGE_SIZE / crypt_stat->extent_size);
 	     extent_offset++) {
 		struct page *page = folio_page(folio, 0);
-		rc = crypt_extent(crypt_stat, page, page,
-				  extent_offset, DECRYPT);
+		rc = crypt_extent(crypt_stat, page, page, folio->index,
+				extent_offset, DECRYPT);
 		if (rc) {
 			printk(KERN_ERR "%s: Error decrypting extent; "
 			       "rc = [%d]\n", __func__, rc);
-- 
2.43.0


