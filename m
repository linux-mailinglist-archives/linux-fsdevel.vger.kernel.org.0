Return-Path: <linux-fsdevel+bounces-20572-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2842D8D53B3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2024 22:23:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B24551F25A46
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2024 20:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A24A15B0EB;
	Thu, 30 May 2024 20:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="d0Ybv+bJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A48158DCA
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 May 2024 20:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717100480; cv=none; b=IEltYGjv3Ik6mWYYz03lhTfmHK9yMtHHpcuAzAshHf4T4A2TQoo6e8N0QUsa6Exbgl6Xqg3W1pPzv1zdhGlTPzrsJujqpSaT1AFegOY3aPhUagAJ5wb2+givylk+GaFPX0mRvCiz/kCtK+4+atCvN0kHFt92c/fpYVcLbIXfgII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717100480; c=relaxed/simple;
	bh=5AZF/XdUh2ZSz4kF7jlJ0I1X1m0SeQT5vRBzGbeBJfs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=minkr3s61X8buNJyf4PubaPxPbbHUpbMpTAsbZKNkesCv4UKq9FY576ozrFvPXqFsOWfjJxN3mPHl8YrkzBqlH89W+nConKbb730tL1mgLuThgBYFmADOQ7q/weJ0fuSZomLehGq9g4Ie1iiGt6xcFogOyGC1aw4qC+QJvz3re8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=d0Ybv+bJ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=hqgerw82zFjkqDdW7SOrIPD4tAnKJQwyU8dSTQUOaHg=; b=d0Ybv+bJJyyk7ppiF2hz8aTDbZ
	u9vosBgsnG3z8UshQeB9mrmb3sz9Ipwk/WK0es+VqgZ9MEyoo5NAd1bGL5geMEuXsw6nXLdrb3Ov4
	wao2xDDXOrw3lczqR96AGwiUYr0638+HVwRPBd++KxBlz/uDUxcLKA5y3/wV3OPfg9pwdZmsLDIFe
	xbX2ClFnn2x5GGDEAy7ajBYPhl+r7gWHjaMT803HvBKimJTII1y7hWDK3cjupmxnkEEOG/in6BV+3
	y4/VBYzGputgj7z3Wy2vfmGC7a4DzQ3Copx2ti9EJMZutUyo1c6DsqJPyPNxiFh5W9Tz1ZbRJ02L0
	zpvUYPsQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCmGz-0000000B8L6-2746;
	Thu, 30 May 2024 20:21:17 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Christian Brauner <brauner@kernel.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 05/16] hpfs: Convert hpfs_symlink_read_folio to use a folio
Date: Thu, 30 May 2024 21:20:57 +0100
Message-ID: <20240530202110.2653630-6-willy@infradead.org>
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
by core code or by the rest of HPFS, so it serves no purpose here.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/hpfs/namei.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/fs/hpfs/namei.c b/fs/hpfs/namei.c
index 9184b4584b01..d0edf9ed33b6 100644
--- a/fs/hpfs/namei.c
+++ b/fs/hpfs/namei.c
@@ -472,9 +472,8 @@ static int hpfs_rmdir(struct inode *dir, struct dentry *dentry)
 
 static int hpfs_symlink_read_folio(struct file *file, struct folio *folio)
 {
-	struct page *page = &folio->page;
-	char *link = page_address(page);
-	struct inode *i = page->mapping->host;
+	char *link = folio_address(folio);
+	struct inode *i = folio->mapping->host;
 	struct fnode *fnode;
 	struct buffer_head *bh;
 	int err;
@@ -485,17 +484,9 @@ static int hpfs_symlink_read_folio(struct file *file, struct folio *folio)
 		goto fail;
 	err = hpfs_read_ea(i->i_sb, fnode, "SYMLINK", link, PAGE_SIZE);
 	brelse(bh);
-	if (err)
-		goto fail;
-	hpfs_unlock(i->i_sb);
-	SetPageUptodate(page);
-	unlock_page(page);
-	return 0;
-
 fail:
 	hpfs_unlock(i->i_sb);
-	SetPageError(page);
-	unlock_page(page);
+	folio_end_read(folio, err == 0);
 	return err;
 }
 
-- 
2.43.0


