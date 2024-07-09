Return-Path: <linux-fsdevel+bounces-23343-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 67EC492AEBD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 05:30:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CA60B21969
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 03:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE540811F7;
	Tue,  9 Jul 2024 03:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bmpwWXi/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2AC3D967
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Jul 2024 03:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720495835; cv=none; b=L9EBFFnmCHirK98rfx7Iz7tz47wS+/T7dLOBZ4UgLuQWXsdp+6eRL5oCnaiGLECxT73l8bH18FbLUx/FohJcRUPe6eTzpV/2XLQcU0Udd5TVJriV0i9hwN926vWVJP5RdQLzX4nDy8lpIrf5eFoOrDoVIC9BMFYhnCeebmfl2dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720495835; c=relaxed/simple;
	bh=CsIqmpYepm4UiYPMuZGOjq57L4rqPZCj517FGlQvLtg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BcBfkdMRMLQ/SRz9wIr2NSZFy8ehYUURTZaANBtQKQRPbCOCcMhJJ9Em0aRWWZtMGKlMEX/EKrRbqTG9QaFRPJ8SHW3GTJGiwxal6sJIZsu7rcbUGTujZb49NQXOcAusQp7MXSht9e5IvBkm+GWWTxglgTVRV+vkKCmYwBLCX3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=bmpwWXi/; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=qa8AdhGyPjH1Ox5kVghfn0l/IChUPGHUxpys1+/5xT8=; b=bmpwWXi/oCvw6dUU6tDdlFnPPm
	FxPyNVFuLrg8AyuvB1U6hLgmADtsH/0PPPG00wDR5NHouOnhLec7/o2zequA2y+VQK6KFNkCZutpq
	QCNgNkLpYVvygNtTlBLzjYxxnps8aIXhspXu9s5fj+QWWnrvqbjPp9Bp8CfkCsgvoXGBo8lCEjQRY
	xFWeVZsydQ665d7PikNkN5GIjOMtaH2JALUom2daYpdfbeJ6uGMxf7ePxyJ3Fx6zg+XgeU3QsJ6KW
	dp8FhVv0mcBUZyo6ft+EUG1US0iEdIDrTByYIAJDtUq+Cns43T+7ZruMM+HD/XCsyV5GkteYPL/tL
	5kQdgA5Q==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sR1Yl-00000007QT5-3xUN;
	Tue, 09 Jul 2024 03:30:32 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH 07/10] ufs: Convert ufs_make_empty() to use a folio
Date: Tue,  9 Jul 2024 04:30:24 +0100
Message-ID: <20240709033029.1769992-8-willy@infradead.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240709033029.1769992-1-willy@infradead.org>
References: <20240709033029.1769992-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Removes a few hidden calls to compound_head() and uses kmap_local
instead of kmap.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ufs/dir.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/fs/ufs/dir.c b/fs/ufs/dir.c
index 945fff87b385..6a2a6af38097 100644
--- a/fs/ufs/dir.c
+++ b/fs/ufs/dir.c
@@ -540,26 +540,25 @@ int ufs_make_empty(struct inode * inode, struct inode *dir)
 {
 	struct super_block * sb = dir->i_sb;
 	struct address_space *mapping = inode->i_mapping;
-	struct page *page = grab_cache_page(mapping, 0);
+	struct folio *folio = filemap_grab_folio(mapping, 0);
 	const unsigned int chunk_size = UFS_SB(sb)->s_uspi->s_dirblksize;
 	struct ufs_dir_entry * de;
-	char *base;
 	int err;
+	char *kaddr;
 
-	if (!page)
-		return -ENOMEM;
+	if (IS_ERR(folio))
+		return PTR_ERR(folio);
 
-	err = ufs_prepare_chunk(page, 0, chunk_size);
+	err = ufs_prepare_chunk(&folio->page, 0, chunk_size);
 	if (err) {
-		unlock_page(page);
+		folio_unlock(folio);
 		goto fail;
 	}
 
-	kmap(page);
-	base = (char*)page_address(page);
-	memset(base, 0, PAGE_SIZE);
+	kaddr = kmap_local_folio(folio, 0);
+	memset(kaddr, 0, folio_size(folio));
 
-	de = (struct ufs_dir_entry *) base;
+	de = (struct ufs_dir_entry *)kaddr;
 
 	de->d_ino = cpu_to_fs32(sb, inode->i_ino);
 	ufs_set_de_type(sb, de, inode->i_mode);
@@ -573,12 +572,12 @@ int ufs_make_empty(struct inode * inode, struct inode *dir)
 	de->d_reclen = cpu_to_fs16(sb, chunk_size - UFS_DIR_REC_LEN(1));
 	ufs_set_de_namlen(sb, de, 2);
 	strcpy (de->d_name, "..");
-	kunmap(page);
+	kunmap_local(kaddr);
 
-	ufs_commit_chunk(page, 0, chunk_size);
+	ufs_commit_chunk(&folio->page, 0, chunk_size);
 	err = ufs_handle_dirsync(inode);
 fail:
-	put_page(page);
+	folio_put(folio);
 	return err;
 }
 
-- 
2.43.0


