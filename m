Return-Path: <linux-fsdevel+bounces-37989-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A19C49F9CCE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 23:46:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC6501898588
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 22:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 287EE221DB7;
	Fri, 20 Dec 2024 22:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="K7ZpjUGk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 565C31C07F7
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Dec 2024 22:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734734800; cv=none; b=M21VWmDa3sLIcxDiElyEr0tNBgbMA4MQcw7hU7JjY3BKyfC0l6k7oOST9VXRtfeROs7XZD9zLVU2TF0Yy8KJPeYPt0E+pYHtEd6YkiWmuWclH3teYJGehedaNhxdH3g+0+Df2AuUKKPE7G9kVG64xAL8W+JYuovxmjBhGKsptN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734734800; c=relaxed/simple;
	bh=k6ffb1+fE+n5pupONOPXt73A+k8fe584gQa9Ik/Xpjs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mFvvcnKm9HzFPgoIUoTOYlLaEalumtp11IYxgkwXHmqPC7X9tQXztkWN72PJKYZOSRgvh9u8jR8YHSLQKBIZfrQelW6WNjaHr4r1ZzdwEexT6U15f/p+y59eaI+TaVpig5ai3owS+aZ4SnBF3bKDYB4qckeDDz6kG5Gc0WqH3fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=K7ZpjUGk; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=bu2kx5ccarvn3y99Em/U+b3Zlo5ch2td1EQGdKbcf9U=; b=K7ZpjUGkd0mZNlnWY7zuhVdg9C
	ZnFJZwAcRLLI+W2ForNePteSz5hJxnEkHgLLoOKf4GfaguxYtyjFrT7Ar6YQRPrdn67+ZPztx3dYT
	vy6+MN3dJKWls98+N8ycDbV8nXbvhlXvE4svlwMyIJWIUqqX09dtuF7UmTqj0I6ZlpQ77rjIlITDU
	QCJHq931rr/DzrPMcqjcyfX8OrS3yYC7OHmrMe9A8db7M74y+O6xLO4bgs2V2J6W8wbtV2E4zz+Jp
	m2GanoeykzPqm5eREE6SVCz+yevOu8xshP5eqFpIzE8PUYlOfd6DJx0+JICVp9XS3xV8Yxy7wiS+m
	J0uIecDw==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tOllS-000000032NA-3x5Q;
	Fri, 20 Dec 2024 22:46:35 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Phillip Lougher <phillip@squashfs.org.uk>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 1/5] squashfs: Use a folio throughout squashfs_read_folio()
Date: Fri, 20 Dec 2024 22:46:24 +0000
Message-ID: <20241220224634.723899-1-willy@infradead.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use modern folio APIs where they exist and convert back to struct
page for the internal functions.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/squashfs/file.c | 25 +++++++++----------------
 1 file changed, 9 insertions(+), 16 deletions(-)

diff --git a/fs/squashfs/file.c b/fs/squashfs/file.c
index 21aaa96856c1..bc6598c3a48f 100644
--- a/fs/squashfs/file.c
+++ b/fs/squashfs/file.c
@@ -445,21 +445,19 @@ static int squashfs_readpage_sparse(struct page *page, int expected)
 
 static int squashfs_read_folio(struct file *file, struct folio *folio)
 {
-	struct page *page = &folio->page;
-	struct inode *inode = page->mapping->host;
+	struct inode *inode = folio->mapping->host;
 	struct squashfs_sb_info *msblk = inode->i_sb->s_fs_info;
-	int index = page->index >> (msblk->block_log - PAGE_SHIFT);
+	int index = folio->index >> (msblk->block_log - PAGE_SHIFT);
 	int file_end = i_size_read(inode) >> msblk->block_log;
 	int expected = index == file_end ?
 			(i_size_read(inode) & (msblk->block_size - 1)) :
 			 msblk->block_size;
 	int res = 0;
-	void *pageaddr;
 
 	TRACE("Entered squashfs_readpage, page index %lx, start block %llx\n",
-				page->index, squashfs_i(inode)->start);
+				folio->index, squashfs_i(inode)->start);
 
-	if (page->index >= ((i_size_read(inode) + PAGE_SIZE - 1) >>
+	if (folio->index >= ((i_size_read(inode) + PAGE_SIZE - 1) >>
 					PAGE_SHIFT))
 		goto out;
 
@@ -472,23 +470,18 @@ static int squashfs_read_folio(struct file *file, struct folio *folio)
 			goto out;
 
 		if (res == 0)
-			res = squashfs_readpage_sparse(page, expected);
+			res = squashfs_readpage_sparse(&folio->page, expected);
 		else
-			res = squashfs_readpage_block(page, block, res, expected);
+			res = squashfs_readpage_block(&folio->page, block, res, expected);
 	} else
-		res = squashfs_readpage_fragment(page, expected);
+		res = squashfs_readpage_fragment(&folio->page, expected);
 
 	if (!res)
 		return 0;
 
 out:
-	pageaddr = kmap_atomic(page);
-	memset(pageaddr, 0, PAGE_SIZE);
-	kunmap_atomic(pageaddr);
-	flush_dcache_page(page);
-	if (res == 0)
-		SetPageUptodate(page);
-	unlock_page(page);
+	folio_zero_segment(folio, 0, folio_size(folio));
+	folio_end_read(folio, res == 0);
 
 	return res;
 }
-- 
2.45.2


