Return-Path: <linux-fsdevel+bounces-20579-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A59F8D53BD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2024 22:24:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D962B24B59
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2024 20:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8392416E89C;
	Thu, 30 May 2024 20:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HBqdrquj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B3B158DD0
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 May 2024 20:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717100481; cv=none; b=YPV0l/dwSRUTuLZV8GbzX2YoSr6PKlDoO8q/KM8Fa12IndaKYP/9opf38w2J2ltc0vP/6RZ0jXVHIoUeB3oDviSyYF1EuMxAhvD3P1uECE+DwtOhayfs+t2TDqAj4dWTpVRxayQ6hoZFDO9yLRmeN3/xDMCGEXCMkzHgyQVH7z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717100481; c=relaxed/simple;
	bh=fdhuwyaoJ75kTK1+bY6IR85Uyujo7j76p0HlophZceU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RJCX5a6cTA3sO/8WuUWTcCbfxW3whXJN9lGjeuM6sVOxH832wZccgsEVqfVhsKqDnkc582ubwclOqPf5fLIcFO+BMdzP27YqWPn/+/s3OFWi8K9YdCa/X/A6/i9/zXDiJNTqZZu5O4lJQqZdrBcKDnxlYbb8H6XWUQKpJ/4Mu/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=HBqdrquj; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=Buzi7Zpoc/Gce0oEezUri/+iIc5iKy1SsFmuJMOCVRk=; b=HBqdrqujd5+jZGNgL/Psf2q7RI
	ghSBY9HxyPfwEuxTop7yk3mrjnrGD1UVCMk4QiLEWGGkuBLe8M1qMfiH24y2h4kZhM6FO/LBmAoBQ
	5pGXPTxRVr7kEK7STEzMAZAafgHBRsD9PpQ2tW40kKvAt1y115mAm2dAXPk6eyghm86DutTGodNQC
	E78IeBI0HKuAhJZg3bKFtOOrRcUg9jM5LfgXsnno7/YSVTygE7nXYnMNRLRyAbQOxn0Hf+gdnnpxj
	Uosp7dTw0ZIRXgCBWncTwC3yf1CUx6dpYymb/g8umG6odBvgf43CrtQkaC/XSmz/6nqGk5tdpYOVO
	+Q+Eh6jw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCmGz-0000000B8Kz-1X5z;
	Thu, 30 May 2024 20:21:17 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Christian Brauner <brauner@kernel.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 04/16] efs: Convert efs_symlink_read_folio to use a folio
Date: Thu, 30 May 2024 21:20:56 +0100
Message-ID: <20240530202110.2653630-5-willy@infradead.org>
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
by core code or by the rest of EFS, so it serves no purpose here.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/efs/symlink.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/fs/efs/symlink.c b/fs/efs/symlink.c
index 3b03a573cb1a..7749feded722 100644
--- a/fs/efs/symlink.c
+++ b/fs/efs/symlink.c
@@ -14,10 +14,9 @@
 
 static int efs_symlink_read_folio(struct file *file, struct folio *folio)
 {
-	struct page *page = &folio->page;
-	char *link = page_address(page);
-	struct buffer_head * bh;
-	struct inode * inode = page->mapping->host;
+	char *link = folio_address(folio);
+	struct buffer_head *bh;
+	struct inode *inode = folio->mapping->host;
 	efs_block_t size = inode->i_size;
 	int err;
   
@@ -40,12 +39,9 @@ static int efs_symlink_read_folio(struct file *file, struct folio *folio)
 		brelse(bh);
 	}
 	link[size] = '\0';
-	SetPageUptodate(page);
-	unlock_page(page);
-	return 0;
+	err = 0;
 fail:
-	SetPageError(page);
-	unlock_page(page);
+	folio_end_read(folio, err == 0);
 	return err;
 }
 
-- 
2.43.0


