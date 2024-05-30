Return-Path: <linux-fsdevel+bounces-20574-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37EA28D53B7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2024 22:23:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD7F21F25117
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2024 20:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8205A15B561;
	Thu, 30 May 2024 20:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Xf8YmQWq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54936158DD1
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 May 2024 20:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717100480; cv=none; b=SoKFqJJAmOLcqySf4Va7uYfjbkDnynBv1JMtQkLN++3pQq5y0ayoQzCTCYYnzknXGkJhqZoKVAaxBgXOxxPmvr+NRAEECf9ODHDqtyCRu037K1BsWVi4F9vLYAG8gK2Qp7siqLUYUfOpf4Gb05g+fdSJaiQ7eu74fD+l502jcTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717100480; c=relaxed/simple;
	bh=UuzRZvckg8fKW4nE8aYj0OSSgwOofSnrBXzIRmA5N5c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pdaXetGfVRYGpEO4ZIW2UT3s1aBMfXBud4jes56t1lWrR8asNP47nJ3J6JyJ3GtlWVvEPzasoFZn+Gj419YkXBeWfmJuv1xBpMmEG524F37sAIb5bgV87Wgudife5r9AhCSIgkMI6tmgENszU6N8Lsq+OUnQCksj/ZUhKnaqTfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Xf8YmQWq; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=/YAyokozXBr3aRWhechl8r4QZQyL+SgETq3seuBRhZI=; b=Xf8YmQWq2b4v3uxcDxQ9ClWKC/
	MEa2WXLTOQk7qG/f+F/UpRwRMeRedwrp6cDE6rykwETL1bD+a7BxhYx0R5wsIrR3bYO1eY7kzbxbi
	mBSHyEqWv12gZyrZVazXhqxEYRUESPi7DiKpJ4M/XyeyTJOMdLWzvgqhuaNaiE+GIhxtLWGlUdLmT
	3u/1M08/XMBsEh7EMyYFTV2FWJycu4wZGktYs5Tu3YQs1+0PObHvPcN6/zosdVMlLKFIxc8Y1RqsX
	lDTJA6MXsPYhADXUBU6yzKldAr/dA1lwOuXVqi8/xYv/9rG216TP62ARRWHci863g8NDCdjC/jIdS
	qNqw+yVg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCmGz-0000000B8LC-2jaw;
	Thu, 30 May 2024 20:21:17 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Christian Brauner <brauner@kernel.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 06/16] isofs: Convert rock_ridge_symlink_read_folio to use a folio
Date: Thu, 30 May 2024 21:20:58 +0100
Message-ID: <20240530202110.2653630-7-willy@infradead.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240530202110.2653630-1-willy@infradead.org>
References: <20240530202110.2653630-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the conversion back into a page and use the folio APIs throughout.
Remove the setting of PG_error instead of converting it; it is unused
by core code or by the rest of isofs, so it serves no purpose here.
Use folio_end_read() to save an atomic operation and unify the two
exit paths.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/isofs/rock.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/fs/isofs/rock.c b/fs/isofs/rock.c
index d6c17ad69dee..dbf911126e61 100644
--- a/fs/isofs/rock.c
+++ b/fs/isofs/rock.c
@@ -688,11 +688,10 @@ int parse_rock_ridge_inode(struct iso_directory_record *de, struct inode *inode,
  */
 static int rock_ridge_symlink_read_folio(struct file *file, struct folio *folio)
 {
-	struct page *page = &folio->page;
-	struct inode *inode = page->mapping->host;
+	struct inode *inode = folio->mapping->host;
 	struct iso_inode_info *ei = ISOFS_I(inode);
 	struct isofs_sb_info *sbi = ISOFS_SB(inode->i_sb);
-	char *link = page_address(page);
+	char *link = folio_address(folio);
 	unsigned long bufsize = ISOFS_BUFFER_SIZE(inode);
 	struct buffer_head *bh;
 	char *rpnt = link;
@@ -779,9 +778,10 @@ static int rock_ridge_symlink_read_folio(struct file *file, struct folio *folio)
 		goto fail;
 	brelse(bh);
 	*rpnt = '\0';
-	SetPageUptodate(page);
-	unlock_page(page);
-	return 0;
+	ret = 0;
+end:
+	folio_end_read(folio, ret == 0);
+	return ret;
 
 	/* error exit from macro */
 out:
@@ -795,9 +795,8 @@ static int rock_ridge_symlink_read_folio(struct file *file, struct folio *folio)
 fail:
 	brelse(bh);
 error:
-	SetPageError(page);
-	unlock_page(page);
-	return -EIO;
+	ret = -EIO;
+	goto end;
 }
 
 const struct address_space_operations isofs_symlink_aops = {
-- 
2.43.0


