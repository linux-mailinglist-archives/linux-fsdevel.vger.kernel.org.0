Return-Path: <linux-fsdevel+bounces-32214-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A49749A2657
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 17:17:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D699B1C21A62
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 15:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4517B1DEFDA;
	Thu, 17 Oct 2024 15:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="O2DswwE2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48111DE8B4;
	Thu, 17 Oct 2024 15:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729178237; cv=none; b=lJiihAof8cLcjQj+K4+6MvTmhmg+BFXjgjMe55+R0Op6yrbjACfxAglareV/cQ0Mo2w2RL2GyPVDF6lfDRX93l5vOkPylkEIXnRma+HqQrQltN3EBrLuevnJnXtYZRBH+quZ6y+0RXTsdChOidNHQIN6F8dNqcWdD5eyS5i5WLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729178237; c=relaxed/simple;
	bh=eP9Pd8WPiP0C2LM+4D3U5ZJRKmug9Sv8RNRm4SF9Tnw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LRi/QReiduNf7W1GxBjFJu908AhgQE3b21JXS3IwAnvw75H/ejK52PNUkg+pVBKTwMbHd/wU1WlULlAi4fyWD/kFoj3KXYbuK7gncx1zR86jHabsTxu75SJ6hBkzR2eybb4XuFQuz7b/TgmahBd/3bvQikTQHftIvyxdyj9G58k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=O2DswwE2; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=QUSeCVFD42RiBhC+sU6UxLp8wUh9+38xI1tcqMh2AaA=; b=O2DswwE2mtCUOm9kO/oJqmNm8s
	o7ll7XI9n2pRKk9ZCqvnAT2os37QlrZ/8F6yYk2zHMlbJw2zL1zOTBAEzNpUkm3wAr++Z6Q9hc9ga
	/PyiH+jG91x6iGrQIsWWbEan6Avs7m6LmzvUGfp17uZkHsYH31kr2b/84xLoLXOF/l7z64AcfDA7p
	ZVc0X/77wYUUfpabeM+OKtxuQoJ4w9pIVS0vIGQEhIGiAeGJqhjqjQPmpZnpOPaXmHmJj4Ira4e4t
	x1qntSY9Qdixr35Xth2+5Vy+T7uUV5ssuqejHqBSE3nIqFfBQOEDDM/TWRFOcV5XFK0EErYeDVQ+U
	rEpxeL5w==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t1SFU-0000000BNoD-17Q1;
	Thu, 17 Oct 2024 15:17:12 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Tyler Hicks <code@tyhicks.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	ecryptfs@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 09/10] ecryptfs: Convert lower_offset_for_page() to take a folio
Date: Thu, 17 Oct 2024 16:17:04 +0100
Message-ID: <20241017151709.2713048-10-willy@infradead.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241017151709.2713048-1-willy@infradead.org>
References: <20241017151709.2713048-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both callers have a folio, so pass it in and use folio->index instead of
page->index.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ecryptfs/crypto.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/ecryptfs/crypto.c b/fs/ecryptfs/crypto.c
index 02bccaa7c666..3db50a779dc7 100644
--- a/fs/ecryptfs/crypto.c
+++ b/fs/ecryptfs/crypto.c
@@ -328,10 +328,10 @@ static int crypt_scatterlist(struct ecryptfs_crypt_stat *crypt_stat,
  * Convert an eCryptfs page index into a lower byte offset
  */
 static loff_t lower_offset_for_page(struct ecryptfs_crypt_stat *crypt_stat,
-				    struct page *page)
+				    struct folio *folio)
 {
 	return ecryptfs_lower_header_size(crypt_stat) +
-	       ((loff_t)page->index << PAGE_SHIFT);
+	       (loff_t)folio->index * PAGE_SIZE;
 }
 
 /**
@@ -440,7 +440,7 @@ int ecryptfs_encrypt_page(struct folio *folio)
 		}
 	}
 
-	lower_offset = lower_offset_for_page(crypt_stat, &folio->page);
+	lower_offset = lower_offset_for_page(crypt_stat, folio);
 	enc_extent_virt = kmap_local_page(enc_extent_page);
 	rc = ecryptfs_write_lower(ecryptfs_inode, enc_extent_virt, lower_offset,
 				  PAGE_SIZE);
@@ -489,7 +489,7 @@ int ecryptfs_decrypt_page(struct folio *folio)
 		&(ecryptfs_inode_to_private(ecryptfs_inode)->crypt_stat);
 	BUG_ON(!(crypt_stat->flags & ECRYPTFS_ENCRYPTED));
 
-	lower_offset = lower_offset_for_page(crypt_stat, &folio->page);
+	lower_offset = lower_offset_for_page(crypt_stat, folio);
 	page_virt = kmap_local_folio(folio, 0);
 	rc = ecryptfs_read_lower(page_virt, lower_offset, PAGE_SIZE,
 				 ecryptfs_inode);
-- 
2.43.0


