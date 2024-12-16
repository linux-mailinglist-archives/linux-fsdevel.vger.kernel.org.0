Return-Path: <linux-fsdevel+bounces-37510-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CCBB39F35FA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2024 17:28:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A6F57A2D5F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2024 16:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FD892063CC;
	Mon, 16 Dec 2024 16:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Iae0Cxoi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A60E20627E;
	Mon, 16 Dec 2024 16:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734366433; cv=none; b=gUT7+pMXCzFn41FQsRScYYdkCQSVSjgrxMkKf5wR/9Imry1fmgwEMKvkHd5ijKtIGHFtMN/u72bMZJR4c/JsmRKziT5AQhNqJPIIRgsA/P4Ur/BaT96xMSIeMpv+Ww0GEkhESSPA3uTS6RGfIm00sxeRut3tDd9G36o4/ILxQ0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734366433; c=relaxed/simple;
	bh=k6ffb1+fE+n5pupONOPXt73A+k8fe584gQa9Ik/Xpjs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bUk4WamdPur/nhJA9ndJEKerPBdGUd0udUZ9L8qspT3Z3NSjtw0t+Cq5w8ULV/4DEanNMPxl4bksf+mVrVdjc7xsl4qAzPiTvhNpu8ipEZr76szVjLydjU8YZszbvuA5qw2njPuGxkmg0TkTxBOWYVLee1vYP4da4t8sKcz8/z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Iae0Cxoi; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=bu2kx5ccarvn3y99Em/U+b3Zlo5ch2td1EQGdKbcf9U=; b=Iae0CxoiKWel5R+U7fAaIhy4Ax
	klvtGI5sKG/JH98UBdUH5ppXkVkaN7qU1fh1aTHFHnnv6pBSjGEL5MhpQdZiCIOlWZAPDOl1eQ+zo
	JVIYUbMNPox2hAORb2ZhVp+BwJcrVi8g0MD6w0jC/XoEBFo+lgZ90xVg2EItjjEYFm/3iObigGlPF
	5DjLiAp+DL8VQd1kzIpAGVAHgJizLjkOYhaj3y0PBxclJpS8zGZKcEW/K1NjGOzV1uFjT/QlDe7Vb
	rH6+v5OCv73CBJ8VFVsUmvSN5yTx6lwpyrfjabFajsqhqQVNBjrQEJ+eoaBYrFQCYVfu42RJjEoPs
	MgxiYB3g==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tNDw0-00000000Eyx-0jWG;
	Mon, 16 Dec 2024 16:27:04 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Phillip Lougher <phillip@squashfs.org.uk>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 1/5] squashfs: Use a folio throughout squashfs_read_folio()
Date: Mon, 16 Dec 2024 16:26:55 +0000
Message-ID: <20241216162701.57549-1-willy@infradead.org>
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


