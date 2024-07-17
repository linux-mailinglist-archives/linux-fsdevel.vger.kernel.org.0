Return-Path: <linux-fsdevel+bounces-23848-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55B1E933FF1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2024 17:48:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 706BE1C21B11
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2024 15:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDA19182A69;
	Wed, 17 Jul 2024 15:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lMnKj4Al"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05D51E87C
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Jul 2024 15:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721231244; cv=none; b=SGQBupFV7rz7NQ+oIlIHE4mSQn6EejpZg/bPlyEYngZa/vtlpU5SFxZwCc5LSLDSVZELUHYknCzi7UzYiJZYcw1OWPM2d/KgNwzLbqcgclGeIHJWr4v0Zhaj8SPA5MvM1W7s9P8YSA6aSeZk/jSWkLG3HG9Rf9lfdQg75NEaQUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721231244; c=relaxed/simple;
	bh=1nLDbyJa2xSNvMv00iWeBd3toq1fo1Laq98DGkr00yw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fiKU+jlu+4yFfzpt/6TNSS59PF2t+tib9ocjgP5JTNqxM9WAAsCdyOzjRq3Otz+dWhyWDUX5f+IUvBs343DCeOV+Wy3yH1fiXchDN/VOVQjjaWj2qWAJiGuAoPAfQ6ANxQd/GKHva0Lnn6YMfz9dWOkLB9B7EbE5YVOJwQz3UI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=lMnKj4Al; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=7E/su4TkuxdA19Ni650nFfB1m6o+CfYVVG4HehrQ1X4=; b=lMnKj4AltOQVfI1TU3PbXtHiAB
	v/YfNf2mqyLuquw18N4rfo2Aejaib7tRVPX9R36VfSmAeoYSgNw7tyordX/Ntw0V1QXeQufxXZ5ta
	CNa9EiNMnibA+ml3ARUOv9i1HGL8vVFWpk7BMg/cyS9G/exndXDyrm6sV0A9X/+2Z6Fd8bWcEs8Pr
	Q9lowaXEpwCpXz0FZFXqwGJknWUGDNmcSRJUAOc/cEo9VgrOpijgW2b4tKUxlzbZecXHggJ4O1apA
	Opmr1i0tGhrBaKS9XyQQ01qIEYtZe+BLr/BVLHInoQRxehqx+2IQBGWytQMFFi+euBJDeJrWrVGCI
	KeKPBcbg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sU6sC-00000000zu4-09Gj;
	Wed, 17 Jul 2024 15:47:20 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 02/23] reiserfs: Convert reiserfs_write_begin() to use a folio
Date: Wed, 17 Jul 2024 16:46:52 +0100
Message-ID: <20240717154716.237943-3-willy@infradead.org>
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

Remove a few calls to compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/reiserfs/inode.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/fs/reiserfs/inode.c b/fs/reiserfs/inode.c
index 2d558b2012ea..33da519c9767 100644
--- a/fs/reiserfs/inode.c
+++ b/fs/reiserfs/inode.c
@@ -2738,20 +2738,21 @@ static int reiserfs_write_begin(struct file *file,
 				struct page **pagep, void **fsdata)
 {
 	struct inode *inode;
-	struct page *page;
+	struct folio *folio;
 	pgoff_t index;
 	int ret;
 	int old_ref = 0;
 
  	inode = mapping->host;
 	index = pos >> PAGE_SHIFT;
-	page = grab_cache_page_write_begin(mapping, index);
-	if (!page)
-		return -ENOMEM;
-	*pagep = page;
+	folio = __filemap_get_folio(mapping, index, FGP_WRITEBEGIN,
+			mapping_gfp_mask(mapping));
+	if (IS_ERR(folio))
+		return PTR_ERR(folio);
+	*pagep = &folio->page;
 
 	reiserfs_wait_on_write_block(inode->i_sb);
-	fix_tail_page_for_writing(page);
+	fix_tail_page_for_writing(&folio->page);
 	if (reiserfs_transaction_running(inode->i_sb)) {
 		struct reiserfs_transaction_handle *th;
 		th = (struct reiserfs_transaction_handle *)current->
@@ -2761,7 +2762,7 @@ static int reiserfs_write_begin(struct file *file,
 		old_ref = th->t_refcount;
 		th->t_refcount++;
 	}
-	ret = __block_write_begin(page, pos, len, reiserfs_get_block);
+	ret = __block_write_begin(&folio->page, pos, len, reiserfs_get_block);
 	if (ret && reiserfs_transaction_running(inode->i_sb)) {
 		struct reiserfs_transaction_handle *th = current->journal_info;
 		/*
@@ -2791,8 +2792,8 @@ static int reiserfs_write_begin(struct file *file,
 		}
 	}
 	if (ret) {
-		unlock_page(page);
-		put_page(page);
+		folio_unlock(folio);
+		folio_put(folio);
 		/* Truncate allocated blocks */
 		reiserfs_truncate_failed_write(inode);
 	}
-- 
2.43.0


