Return-Path: <linux-fsdevel+bounces-35842-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B6159D8BE4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 19:04:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8E70B3256A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 18:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 675C01B4146;
	Mon, 25 Nov 2024 18:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GvlBVmMX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D7641C92
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Nov 2024 18:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732557688; cv=none; b=s1bkfgXf5yPbT8CRuUohnLwwEOtTNsfPHSKrxv0dK/7G5A/pX8BmIEU7+JLZOJS1NkRy5Pqw3a509Mr6lAw4j/a84zX4y/T5X0EwIN6xJyNaiVAGhDNbpPQ4fAWqxLe9FzxYFnwUAJ9nf1Gf3MHzZVc7FCMHjZw7vrv/wBUtEoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732557688; c=relaxed/simple;
	bh=VeKPBxAvy1/uP3gnnzQAKTiQmE4feskf0JlwXI3vqeM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ngSB/ypY5nmw4rkYYg9zNOmoyO8qw6b417zEFwZ4AM2Qiy2qJRiSHtJHnluj/mAc3y6Ts39Z1cIuCKSaizIvEQAyvmmNFJOB84ItLphw6pN1OSjgAqGTk4lUm/JjhtKvkE2JA9oOEeCCuSZBZxbaqP6ZWHYLLPBihLVfz+8pIUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=GvlBVmMX; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=KOS9XrHD8aqr14yYM3nE7i/E3miZ31k/vy11KgYcV7g=; b=GvlBVmMX094uu3vZkohS6bMgnB
	PCJJns7HXTkvcbEp4SOm5CWu5eATpVxfI85dBGnu6Bj2Z9wZAoIB8K5LLilayAFo5737COh4BNl3r
	4bdGyVp4SA8WJYcEeh6OMh9imHORLl90TJiwbOO4Rq0DeGVdiR6Rtro+DSzGO6Qx3Hb4BumoKuEFZ
	OQbrhJZFmYUyLVRywca37gxpkVCy5QYzK2zX6MC1ovNrSc5CFlxDEH93BZXEW8PZ6KG91EHeHwp/f
	lhI4/K4Wbg2V0HBRyY3bvC0tMM0aAyURS+cBtYfjIJo6PGu6XMfLL/zWlM0QQ5cOaxpDSNAnpixNj
	BC+j3vnA==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tFdOl-0000000CEAE-16ud;
	Mon, 25 Nov 2024 18:01:23 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Jan Kara <jack@suse.cz>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH] isofs: Partially convert zisofs_read_folio to use a folio
Date: Mon, 25 Nov 2024 18:01:14 +0000
Message-ID: <20241125180117.2914311-1-willy@infradead.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove several hidden calls to compound_head() and references
to page->index.  More needs to be done to use folios throughout
the zisofs code.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/isofs/compress.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/fs/isofs/compress.c b/fs/isofs/compress.c
index 34d5baa5d88a..5f3b6da0e022 100644
--- a/fs/isofs/compress.c
+++ b/fs/isofs/compress.c
@@ -301,7 +301,6 @@ static int zisofs_fill_pages(struct inode *inode, int full_page, int pcount,
  */
 static int zisofs_read_folio(struct file *file, struct folio *folio)
 {
-	struct page *page = &folio->page;
 	struct inode *inode = file_inode(file);
 	struct address_space *mapping = inode->i_mapping;
 	int err;
@@ -311,16 +310,15 @@ static int zisofs_read_folio(struct file *file, struct folio *folio)
 		PAGE_SHIFT <= zisofs_block_shift ?
 		(1 << (zisofs_block_shift - PAGE_SHIFT)) : 0;
 	struct page **pages;
-	pgoff_t index = page->index, end_index;
+	pgoff_t index = folio->index, end_index;
 
 	end_index = (inode->i_size + PAGE_SIZE - 1) >> PAGE_SHIFT;
 	/*
-	 * If this page is wholly outside i_size we just return zero;
+	 * If this folio is wholly outside i_size we just return zero;
 	 * do_generic_file_read() will handle this for us
 	 */
 	if (index >= end_index) {
-		SetPageUptodate(page);
-		unlock_page(page);
+		folio_end_read(folio, true);
 		return 0;
 	}
 
@@ -338,10 +336,10 @@ static int zisofs_read_folio(struct file *file, struct folio *folio)
 	pages = kcalloc(max_t(unsigned int, zisofs_pages_per_cblock, 1),
 					sizeof(*pages), GFP_KERNEL);
 	if (!pages) {
-		unlock_page(page);
+		folio_unlock(folio);
 		return -ENOMEM;
 	}
-	pages[full_page] = page;
+	pages[full_page] = &folio->page;
 
 	for (i = 0; i < pcount; i++, index++) {
 		if (i != full_page)
-- 
2.45.2


