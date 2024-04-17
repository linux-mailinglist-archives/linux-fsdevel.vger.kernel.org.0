Return-Path: <linux-fsdevel+bounces-17149-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B82E78A86EF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 17:04:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E964A1C2156D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 15:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1371146D51;
	Wed, 17 Apr 2024 15:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KtSc5Fy0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4596146A9A
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Apr 2024 15:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713366262; cv=none; b=jpXSXq8a1T8nz3xTTmQ8TyXnXSZJSX1HxiY01S3a7KyVN1HRytCjRhnjAk2oCOh9bYz8W0WkKka7qPq5mBLQZLq1wockAHivW59tUfrQeKYAVA6CZ83htlHnrPbfQh9zqHRHQ/5RJSgzHRyB6ODOw7R9i1/e+ldGtaldhjZxrm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713366262; c=relaxed/simple;
	bh=FsjzqX+a4HYeyiseOqrJ01AOLc8cwhapu1WucD6kSaE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q2kLbmveZ9DpH4v6aEateTh83TSERQoLf6gNcLqLLSQnVyW6ORy3gpcVicGfzyJHa+zkdeX4kbOV1TdmyD00WiDGT63HO9X21tdq/bxnDdZDGHLExkqH8i6dDb1PaLgK0/+moZbSPQQuxt+oJqRSiwsHrJBsM1CFlFB82G20Q/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=KtSc5Fy0; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=lQh5a+kJfL+KjL2wabh1P3qwQDd4h6SC46qZPxpB8P0=; b=KtSc5Fy0oawy5NvWFOyigC+sfN
	oynPjFUF+cLn/Qg8iQYVVX2Lcy1bgvUvQ/vUBi0lN6EcK8nnX/BXzF0iWRvQ8BIAAKdr9gzT873hB
	w8zZI+wLEM/IVtVq0TBDhuX04D3FZdR9bxEDPmL2YMMLZmsf8V2a+RPFuB13jEzo/QpACxwnm3xrE
	qRgSPA/MNbis7Ka70/mjmwU9o/T591wjuBxKxmol86YZo5CSAHpsyPwrfdF6iq6hRDX1YPTbt68IF
	L//Nua9J5zM26XwaybEAcrpYrMBmhnUpxp81sPMMmriEh88VdNOG8gjjWVMj45t1U/gMnErRx+Ekk
	h07bDkbQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rx6pe-000000039sj-17M5;
	Wed, 17 Apr 2024 15:04:18 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Jan Kara <jack@suse.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 3/7] udf: Convert udf_expand_file_adinicb() to use a folio
Date: Wed, 17 Apr 2024 16:04:09 +0100
Message-ID: <20240417150416.752929-4-willy@infradead.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240417150416.752929-1-willy@infradead.org>
References: <20240417150416.752929-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the folio APIs throughout this function.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/udf/inode.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/fs/udf/inode.c b/fs/udf/inode.c
index 5146b9d7aba3..59215494e6f6 100644
--- a/fs/udf/inode.c
+++ b/fs/udf/inode.c
@@ -342,7 +342,7 @@ const struct address_space_operations udf_aops = {
  */
 int udf_expand_file_adinicb(struct inode *inode)
 {
-	struct page *page;
+	struct folio *folio;
 	struct udf_inode_info *iinfo = UDF_I(inode);
 	int err;
 
@@ -358,12 +358,13 @@ int udf_expand_file_adinicb(struct inode *inode)
 		return 0;
 	}
 
-	page = find_or_create_page(inode->i_mapping, 0, GFP_KERNEL);
-	if (!page)
-		return -ENOMEM;
+	folio = __filemap_get_folio(inode->i_mapping, 0,
+			FGP_LOCK | FGP_ACCESSED | FGP_CREAT, GFP_KERNEL);
+	if (IS_ERR(folio))
+		return PTR_ERR(folio);
 
-	if (!PageUptodate(page))
-		udf_adinicb_readpage(page);
+	if (!folio_test_uptodate(folio))
+		udf_adinicb_readpage(&folio->page);
 	down_write(&iinfo->i_data_sem);
 	memset(iinfo->i_data + iinfo->i_lenEAttr, 0x00,
 	       iinfo->i_lenAlloc);
@@ -372,22 +373,22 @@ int udf_expand_file_adinicb(struct inode *inode)
 		iinfo->i_alloc_type = ICBTAG_FLAG_AD_SHORT;
 	else
 		iinfo->i_alloc_type = ICBTAG_FLAG_AD_LONG;
-	set_page_dirty(page);
-	unlock_page(page);
+	folio_mark_dirty(folio);
+	folio_unlock(folio);
 	up_write(&iinfo->i_data_sem);
 	err = filemap_fdatawrite(inode->i_mapping);
 	if (err) {
 		/* Restore everything back so that we don't lose data... */
-		lock_page(page);
+		folio_lock(folio);
 		down_write(&iinfo->i_data_sem);
-		memcpy_to_page(page, 0, iinfo->i_data + iinfo->i_lenEAttr,
-			       inode->i_size);
-		unlock_page(page);
+		memcpy_from_folio(iinfo->i_data + iinfo->i_lenEAttr,
+				folio, 0, inode->i_size);
+		folio_unlock(folio);
 		iinfo->i_alloc_type = ICBTAG_FLAG_AD_IN_ICB;
 		iinfo->i_lenAlloc = inode->i_size;
 		up_write(&iinfo->i_data_sem);
 	}
-	put_page(page);
+	folio_put(folio);
 	mark_inode_dirty(inode);
 
 	return err;
-- 
2.43.0


