Return-Path: <linux-fsdevel+bounces-51598-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E2AEAD931E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 18:47:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2153F7B1604
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 16:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B271221F34;
	Fri, 13 Jun 2025 16:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vfGr0IXP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC4E20127A
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Jun 2025 16:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749833220; cv=none; b=u4BamWpE7gnhvFRHeYZhxzNgLuD3+I8RtqenWIIGhCV/AGMmKaNPOiG+7UtZDFBQxcDhqWbd8IsjxgrfYFhERZevwgK6pISvITuCfKAAu1NVCsR6n6SpqLYJATYMXsFyMFcOd4onlrexHFG38J3f3C+RsllKIcKmlhmIwKZ9dM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749833220; c=relaxed/simple;
	bh=6+oSbzi0uMNPUfIVIC5k1U5v1ypu53uJFMENjgV0E/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F155mxGVZKMcyb/KkhhtCutcwBdWGfvIXLODlv4Cr02Bs3i69SI3JZ5iH6SQHZLTNCNHnZQISZj5TXgQBmOcmLOuTUlzQ0Y/R5KCJ+RVAzZ5Yx0nKus6bq+6mlhtzir1o/2hiNYbeJ95sYDnjto+yM+AiL+Hx4Oums1nq4vbOB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=vfGr0IXP; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=dA4+qTSWH59XT+woL8agYLzJMJDou5vYjzqDarSSlWI=; b=vfGr0IXPfBlnQtdlgltxOCTxSq
	MW6HyaMVTMGm3OOWeftpYUpTn9Dsu3spmnOR1OHMDAWC22txQ1Xb0p/+az81EKulTU+VR5xa3SUwb
	yKHAxKUagGtpaGbBfvY24iPunhiaUsJ6qlGrsstJabEBQMOwAwAuIOrXTb8yRHswU6WMe831dOQYq
	KUjCi7kEKsOOTxT2S+wGMXhmfpHM4GDgDPCixpVOzFdRXDFuXhN3QtbKFmbzZnIOS+SlIUCVR400g
	BU00kTdvtxX0N1+8ii/Zr1UEy+FP0itpiOsrv5pHLDyedAnkZnixCX5v3gOJo+hQlzqWsGExlXvPP
	d1kMrdYw==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uQ7YF-0000000DAjv-3LQK;
	Fri, 13 Jun 2025 16:46:47 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org,
	Joanne Koong <joannelkoong@gmail.com>
Subject: [PATCH 1/2] fuse: Use a folio in fuse_add_dirent_to_cache()
Date: Fri, 13 Jun 2025 17:46:43 +0100
Message-ID: <20250613164646.3139481-2-willy@infradead.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250613164646.3139481-1-willy@infradead.org>
References: <20250613164646.3139481-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Retrieve a folio from the page cache and use it throughout.
Removes three hidden calls to compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/fuse/readdir.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/fs/fuse/readdir.c b/fs/fuse/readdir.c
index c2aae2eef086..09bed488ee35 100644
--- a/fs/fuse/readdir.c
+++ b/fs/fuse/readdir.c
@@ -35,7 +35,7 @@ static void fuse_add_dirent_to_cache(struct file *file,
 	struct fuse_inode *fi = get_fuse_inode(file_inode(file));
 	size_t reclen = FUSE_DIRENT_SIZE(dirent);
 	pgoff_t index;
-	struct page *page;
+	struct folio *folio;
 	loff_t size;
 	u64 version;
 	unsigned int offset;
@@ -62,12 +62,13 @@ static void fuse_add_dirent_to_cache(struct file *file,
 	spin_unlock(&fi->rdc.lock);
 
 	if (offset) {
-		page = find_lock_page(file->f_mapping, index);
+		folio = filemap_lock_folio(file->f_mapping, index);
 	} else {
-		page = find_or_create_page(file->f_mapping, index,
-					   mapping_gfp_mask(file->f_mapping));
+		folio = __filemap_get_folio(file->f_mapping, index,
+				FGP_LOCK | FGP_ACCESSED | FGP_CREAT,
+				mapping_gfp_mask(file->f_mapping));
 	}
-	if (!page)
+	if (!folio)
 		return;
 
 	spin_lock(&fi->rdc.lock);
@@ -76,19 +77,19 @@ static void fuse_add_dirent_to_cache(struct file *file,
 	    WARN_ON(fi->rdc.pos != pos))
 		goto unlock;
 
-	addr = kmap_local_page(page);
+	addr = kmap_local_folio(folio, offset);
+	memcpy(addr, dirent, reclen);
 	if (!offset) {
-		clear_page(addr);
-		SetPageUptodate(page);
+		memset(addr + reclen, 0, PAGE_SIZE - reclen);
+		folio_mark_uptodate(folio);
 	}
-	memcpy(addr + offset, dirent, reclen);
 	kunmap_local(addr);
 	fi->rdc.size = (index << PAGE_SHIFT) + offset + reclen;
 	fi->rdc.pos = dirent->off;
 unlock:
 	spin_unlock(&fi->rdc.lock);
-	unlock_page(page);
-	put_page(page);
+	folio_unlock(folio);
+	folio_put(folio);
 }
 
 static void fuse_readdir_cache_end(struct file *file, loff_t pos)
-- 
2.47.2


