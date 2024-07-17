Return-Path: <linux-fsdevel+bounces-23858-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A1CF933FFB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2024 17:48:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BA561C20D10
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2024 15:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B82DF18308C;
	Wed, 17 Jul 2024 15:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CdvX8X7t"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950D2181CF8
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Jul 2024 15:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721231246; cv=none; b=k1s7MlvECy0Phm32Tbpv5MHUUgi9zLJvqxaRZTb8OGrzK1bTdJOaNOnSLyIpn6SKvlwHs9whwztjksLCtFGgCcE7QMzv+ZXuZ9ZhS26eAONyr2WRyaQiGJVrw4y1JumaERq+TUp0Us3FhkHP+lBbkdR9S2mZcKigx6m0x3mgkuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721231246; c=relaxed/simple;
	bh=R8ls6OZ5levxjicM7oVcvmw68w0O5svODgTsE2GZ2RI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W6hvozn/OkBSeXrGWuGtFvaXYtXrcPeNl/nhL/UX3kShKPU9Yo7gpPRJACjk5mM+8WuZSQYqEZ5oe2bCyh3e0wPx5AuFNKEArBWvnQq/Crx/l7tTzeU/VgAmz+tpjrnbr1nvXlPVAiFFHxCD6ESZy45svr5a7vmw+HcNeRGGu6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=CdvX8X7t; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=WsD27dW/1HZa3BMn1gVyNGG6TywUhwL8B9XBIcUwVaY=; b=CdvX8X7tZ1Hu6DaMWNZv+8q+WN
	qgXAfXKf7JPT9n9oF0joMEW+AvojBsn4LQw30hQhrzTS+eM+ZybyqZVmLsZgMjFk9tX5JuAmZP4in
	R9Qn1WFkpQ5htLJgsa5rtAKx+pj2AA1i9dR0Q5npGhySwyAnsrhHgvOj1TyAxMFIpfeUSmi1y3Qmm
	1yxwQHq8+EQtkww5/vY1aUvaOI1lT5F7H5TU9hh49QHuIHzDEcjiCw2B5Ya43N8z6IVOmgTQyMs/M
	CroD1wWuekEdYI7uxBlxkooO/sruvz8u6ml3WVqh/Ck7r+8MvqdyJisxoIAlhZfqGvmgLTfz/ISpG
	DB4DREeA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sU6sE-00000000zvC-05DZ;
	Wed, 17 Jul 2024 15:47:22 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 16/23] jffs2: Convert jffs2_write_begin() to use a folio
Date: Wed, 17 Jul 2024 16:47:06 +0100
Message-ID: <20240717154716.237943-17-willy@infradead.org>
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

Fetch a folio from the page cache instead of a page and use it throughout
removing several calls to compound_head().  We still have to convert
back to a page for calling internal jffs2 functions, but hopefully they
will be converted soon.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/jffs2/file.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/fs/jffs2/file.c b/fs/jffs2/file.c
index 1a7dbf846c7c..ee8f7f029b45 100644
--- a/fs/jffs2/file.c
+++ b/fs/jffs2/file.c
@@ -127,7 +127,7 @@ static int jffs2_write_begin(struct file *filp, struct address_space *mapping,
 			loff_t pos, unsigned len,
 			struct page **pagep, void **fsdata)
 {
-	struct page *pg;
+	struct folio *folio;
 	struct inode *inode = mapping->host;
 	struct jffs2_inode_info *f = JFFS2_INODE_INFO(inode);
 	struct jffs2_sb_info *c = JFFS2_SB_INFO(inode->i_sb);
@@ -206,29 +206,30 @@ static int jffs2_write_begin(struct file *filp, struct address_space *mapping,
 	 * page in read_cache_page(), which causes a deadlock.
 	 */
 	mutex_lock(&c->alloc_sem);
-	pg = grab_cache_page_write_begin(mapping, index);
-	if (!pg) {
-		ret = -ENOMEM;
+	folio = __filemap_get_folio(mapping, index, FGP_WRITEBEGIN,
+			mapping_gfp_mask(mapping));
+	if (IS_ERR(folio)) {
+		ret = PTR_ERR(folio);
 		goto release_sem;
 	}
-	*pagep = pg;
+	*pagep = &folio->page;
 
 	/*
-	 * Read in the page if it wasn't already present. Cannot optimize away
-	 * the whole page write case until jffs2_write_end can handle the
+	 * Read in the folio if it wasn't already present. Cannot optimize away
+	 * the whole folio write case until jffs2_write_end can handle the
 	 * case of a short-copy.
 	 */
-	if (!PageUptodate(pg)) {
+	if (!folio_test_uptodate(folio)) {
 		mutex_lock(&f->sem);
-		ret = jffs2_do_readpage_nolock(inode, pg);
+		ret = jffs2_do_readpage_nolock(inode, &folio->page);
 		mutex_unlock(&f->sem);
 		if (ret) {
-			unlock_page(pg);
-			put_page(pg);
+			folio_unlock(folio);
+			folio_put(folio);
 			goto release_sem;
 		}
 	}
-	jffs2_dbg(1, "end write_begin(). pg->flags %lx\n", pg->flags);
+	jffs2_dbg(1, "end write_begin(). folio->flags %lx\n", folio->flags);
 
 release_sem:
 	mutex_unlock(&c->alloc_sem);
-- 
2.43.0


