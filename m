Return-Path: <linux-fsdevel+bounces-23853-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E0AF933FF6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2024 17:48:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02578B24752
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2024 15:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BE0218306A;
	Wed, 17 Jul 2024 15:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pE55La7c"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67DF181CFA
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Jul 2024 15:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721231245; cv=none; b=hfCWr7Aa5F68x8pxifGAYAN91EaOQZf6rH6QUgbo4fPQFFkcdemzbbSBukrLpLwLnomvhe2NpzCLnWSbEjz4i2vUQRS92NiYVXiP6Js0IewW+wnpyQWGjx2NIPky3LJKwPhT/olnHbXMWw93TIdvfMX7HxOX0BvTgRT3rjk2nU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721231245; c=relaxed/simple;
	bh=Dr/12UzOuYLgddk3DJFTOod860oOnFnfWu4dbzOAmdM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nuz+4wyvdlpA6TqmII/fPUL11g+Qj2PkyyKr+wB3OGDLVExHlT/97DzY1xcP6fiNp6nGfDFOeUxigYvt1gUE3lKH1ELN4CWu8Z8N6VNSWApTQ0fE1gmASuv9R3wJDr+byzratLiNx4CjzMEj9fhMKVFmRKx6gQJ0O3UB+zrA0Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=pE55La7c; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=j63RVuZ5nUMHrAOIWiZOQgWlSHw2lRG/hcJEaPqLSjA=; b=pE55La7c0FE31wYSdrh6+/9Zh5
	DeCdd0eDoD2zVjnYeg23OOgTkC7I8mrxcg5/q1FdCvdKM7aTxSDBE9jvcrzDBLsJ/wvR2elZl2OR9
	nwb3RoI2N385mjv9cc4oXjZYKrkNeL0FvtsV/b/tqe2UOdPSG3KBorw2M+2AgEeBblyITCUyKl1mx
	qPFXYSzbHgsorQS9RTGBv2G6gBhO6NgFE2aEJcejwwNu3wM9NPyZODVqnZ4KzO73XOWjeUSi+0DxX
	nXpV6Jant4vh7rPyWn2/VHPkTxrBvy5ta1KiIK/vQpY2W9PpNDpXV6qfvx80x83AVwC7YnzhmQzk2
	heta2idA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sU6sE-00000000zva-0c8z;
	Wed, 17 Jul 2024 15:47:22 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 17/23] orangefs: Convert orangefs_write_end() to use a folio
Date: Wed, 17 Jul 2024 16:47:07 +0100
Message-ID: <20240717154716.237943-18-willy@infradead.org>
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
Replaces five calls to compound_head() with one.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/orangefs/inode.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/fs/orangefs/inode.c b/fs/orangefs/inode.c
index fdb9b65db1de..6595417f62b1 100644
--- a/fs/orangefs/inode.c
+++ b/fs/orangefs/inode.c
@@ -367,7 +367,8 @@ static int orangefs_write_begin(struct file *file,
 static int orangefs_write_end(struct file *file, struct address_space *mapping,
     loff_t pos, unsigned len, unsigned copied, struct page *page, void *fsdata)
 {
-	struct inode *inode = page->mapping->host;
+	struct folio *folio = page_folio(page);
+	struct inode *inode = folio->mapping->host;
 	loff_t last_pos = pos + copied;
 
 	/*
@@ -377,23 +378,23 @@ static int orangefs_write_end(struct file *file, struct address_space *mapping,
 	if (last_pos > inode->i_size)
 		i_size_write(inode, last_pos);
 
-	/* zero the stale part of the page if we did a short copy */
-	if (!PageUptodate(page)) {
+	/* zero the stale part of the folio if we did a short copy */
+	if (!folio_test_uptodate(folio)) {
 		unsigned from = pos & (PAGE_SIZE - 1);
 		if (copied < len) {
-			zero_user(page, from + copied, len - copied);
+			folio_zero_range(folio, from + copied, len - copied);
 		}
 		/* Set fully written pages uptodate. */
-		if (pos == page_offset(page) &&
+		if (pos == folio_pos(folio) &&
 		    (len == PAGE_SIZE || pos + len == inode->i_size)) {
-			zero_user_segment(page, from + copied, PAGE_SIZE);
-			SetPageUptodate(page);
+			folio_zero_segment(folio, from + copied, PAGE_SIZE);
+			folio_mark_uptodate(folio);
 		}
 	}
 
-	set_page_dirty(page);
-	unlock_page(page);
-	put_page(page);
+	folio_mark_dirty(folio);
+	folio_unlock(folio);
+	folio_put(folio);
 
 	mark_inode_dirty_sync(file_inode(file));
 	return copied;
-- 
2.43.0


