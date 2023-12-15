Return-Path: <linux-fsdevel+bounces-6211-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 619788150AF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Dec 2023 21:04:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 934C51C24203
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Dec 2023 20:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6F955F85F;
	Fri, 15 Dec 2023 20:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LmH9PtVl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24189563AD;
	Fri, 15 Dec 2023 20:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=fdiMOBZgvd1GbkJ8y1Kh/20f5RjjhoyfjJXzJkLF3z0=; b=LmH9PtVld+Jyw8zf/OkZOwV20R
	Krs0C2KZ64p7dlfZXWTA5P47NTFZTPuk4yjXczjRSkJUsplZo2jWReAeL5kKUpSBm/82CVq7hJXW4
	XDNtLl40ZFN8Yw4LLUkFI05XkFbT1TsMMS22iQ2nqb/JQW+k5LfSomw2d7AvtvSKTSxL7uSjWEspX
	J17a2T/FZ3bQH016FEPcByuSOzt97iTvr1Du8AOQZ96Lrb0Ym2bCW+ty2IIDJuoKRguXd9qTK9FeP
	mIfzsr999v4Zef4Aow1QSERqvgquTKna63QD0pcjPZIijjbkFdkws4ZGJeLZI8+QqcgdkwVIZET+n
	nFs1wwog==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rEEOV-0038j4-Mu; Fri, 15 Dec 2023 20:02:47 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Christoph Hellwig <hch@lst.de>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: [PATCH 08/14] hfsplus: Really remove hfsplus_writepage
Date: Fri, 15 Dec 2023 20:02:39 +0000
Message-Id: <20231215200245.748418-9-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231215200245.748418-1-willy@infradead.org>
References: <20231215200245.748418-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The earlier commit to remove hfsplus_writepage only removed it from
one of the aops.  Remove it from the btree_aops as well.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/hfsplus/inode.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/fs/hfsplus/inode.c b/fs/hfsplus/inode.c
index 702a0663b1d8..3d326926c195 100644
--- a/fs/hfsplus/inode.c
+++ b/fs/hfsplus/inode.c
@@ -28,11 +28,6 @@ static int hfsplus_read_folio(struct file *file, struct folio *folio)
 	return block_read_full_folio(folio, hfsplus_get_block);
 }
 
-static int hfsplus_writepage(struct page *page, struct writeback_control *wbc)
-{
-	return block_write_full_page(page, hfsplus_get_block, wbc);
-}
-
 static void hfsplus_write_failed(struct address_space *mapping, loff_t to)
 {
 	struct inode *inode = mapping->host;
@@ -159,9 +154,10 @@ const struct address_space_operations hfsplus_btree_aops = {
 	.dirty_folio	= block_dirty_folio,
 	.invalidate_folio = block_invalidate_folio,
 	.read_folio	= hfsplus_read_folio,
-	.writepage	= hfsplus_writepage,
+	.writepages	= hfsplus_writepages,
 	.write_begin	= hfsplus_write_begin,
 	.write_end	= generic_write_end,
+	.migrate_folio	= buffer_migrate_folio,
 	.bmap		= hfsplus_bmap,
 	.release_folio	= hfsplus_release_folio,
 };
-- 
2.42.0


