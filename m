Return-Path: <linux-fsdevel+bounces-9935-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B19008463BB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 23:47:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E79728EBA5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 22:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5761747A7B;
	Thu,  1 Feb 2024 22:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GzlACinS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B21445C06
	for <linux-fsdevel@vger.kernel.org>; Thu,  1 Feb 2024 22:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706827573; cv=none; b=rWegABiGtYdx7nYyk5TOoeqySTObU3h4KGfKiI+ILzwksnxQHcrFQWT+G2Dc1WEk9WVpBKo3V6Vz2jOkCqTHM4OTavHEYIFybfjz9gAFWnklt4mO6u3uzibd/0njZtcTp9g7SNikAiomNPYjXl2W0An6vzoPTSSpCNC+lFlLhz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706827573; c=relaxed/simple;
	bh=0pgZAWjuqFQyQjPX6F27SlJdStSQ28iBvPXL+HBVAnQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b2btL50HG1KAgcp1kQtK/Sj9ESG0S4dJ8Qubl/FhHRO0iFSlPnkeD15kVcqJWBxLjznATEattyYcrR6RgOPawOE2rmPHAwSGNkNkGR08sa9q+RwtrIEzCRirqhuuMGymXq36YXa95931004HPLawZ8+dW1eVnnJDvboohZrDkfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=GzlACinS; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=tuAP8Pj11A6vSLLksQ3sdzEDeykXyvIK9phb2ySpPEM=; b=GzlACinSFCeCGzFag6Heiw3MTU
	Bw6zuKdIx7FQshrTq8nsfUA9nPCUXmIkBcgGTQH39UH8Iqq+HG2rglvmNTfcmShGyd/dHEhtqxIjp
	nBv2ECH2AfhURNHF2VOJ46iI8Ufz/CV1dN0V2uPyF06efE+6gi57Nk1rm9UicLybLHF0l+h24Scly
	KrR2GQd5QrIo2Vx9pLjYgc/QSp+1D1HR/gFa/H+JWZkBwAcueujMXz0VEpN+K37jNr40rq60VTg+y
	TVZ7yQIbf+GEeXIz0uwkl/PH4rcCc8TqcUuupiujfSDwe5Yt1PRKLCV5HJOjD952Rg1LXBj4SVEwn
	q9zZLIkg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVfot-0000000H17x-0L7o;
	Thu, 01 Feb 2024 22:46:07 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Dave Kleikamp <shaggy@kernel.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	jfs-discussion@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 01/13] jfs: Convert metapage_read_folio to use folio APIs
Date: Thu,  1 Feb 2024 22:45:50 +0000
Message-ID: <20240201224605.4055895-2-willy@infradead.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240201224605.4055895-1-willy@infradead.org>
References: <20240201224605.4055895-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use bio_add_folio_nofail() as we just allocated the bio and know
it cannot fail.  Other than that, this is a 1:1 conversion from
page APIs to folio APIs.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/jfs/jfs_metapage.c | 35 +++++++++++++----------------------
 1 file changed, 13 insertions(+), 22 deletions(-)

diff --git a/fs/jfs/jfs_metapage.c b/fs/jfs/jfs_metapage.c
index 961569c11159..8266c43ec728 100644
--- a/fs/jfs/jfs_metapage.c
+++ b/fs/jfs/jfs_metapage.c
@@ -266,14 +266,14 @@ static void last_read_complete(struct page *page)
 
 static void metapage_read_end_io(struct bio *bio)
 {
-	struct page *page = bio->bi_private;
+	struct folio *folio = bio->bi_private;
 
 	if (bio->bi_status) {
 		printk(KERN_ERR "metapage_read_end_io: I/O error\n");
-		SetPageError(page);
+		folio_set_error(folio);
 	}
 
-	dec_io(page, last_read_complete);
+	dec_io(&folio->page, last_read_complete);
 	bio_put(bio);
 }
 
@@ -469,20 +469,18 @@ static int metapage_writepage(struct page *page, struct writeback_control *wbc)
 
 static int metapage_read_folio(struct file *fp, struct folio *folio)
 {
-	struct page *page = &folio->page;
-	struct inode *inode = page->mapping->host;
+	struct inode *inode = folio->mapping->host;
 	struct bio *bio = NULL;
 	int block_offset;
-	int blocks_per_page = i_blocks_per_page(inode, page);
+	int blocks_per_page = i_blocks_per_folio(inode, folio);
 	sector_t page_start;	/* address of page in fs blocks */
 	sector_t pblock;
 	int xlen;
 	unsigned int len;
 	int offset;
 
-	BUG_ON(!PageLocked(page));
-	page_start = (sector_t)page->index <<
-		     (PAGE_SHIFT - inode->i_blkbits);
+	BUG_ON(!folio_test_locked(folio));
+	page_start = folio_pos(folio) >> inode->i_blkbits;
 
 	block_offset = 0;
 	while (block_offset < blocks_per_page) {
@@ -490,9 +488,9 @@ static int metapage_read_folio(struct file *fp, struct folio *folio)
 		pblock = metapage_get_blocks(inode, page_start + block_offset,
 					     &xlen);
 		if (pblock) {
-			if (!PagePrivate(page))
-				insert_metapage(page, NULL);
-			inc_io(page);
+			if (!folio->private)
+				insert_metapage(&folio->page, NULL);
+			inc_io(&folio->page);
 			if (bio)
 				submit_bio(bio);
 
@@ -501,11 +499,10 @@ static int metapage_read_folio(struct file *fp, struct folio *folio)
 			bio->bi_iter.bi_sector =
 				pblock << (inode->i_blkbits - 9);
 			bio->bi_end_io = metapage_read_end_io;
-			bio->bi_private = page;
+			bio->bi_private = folio;
 			len = xlen << inode->i_blkbits;
 			offset = block_offset << inode->i_blkbits;
-			if (bio_add_page(bio, page, len, offset) < len)
-				goto add_failed;
+			bio_add_folio_nofail(bio, folio, len, offset);
 			block_offset += xlen;
 		} else
 			block_offset++;
@@ -513,15 +510,9 @@ static int metapage_read_folio(struct file *fp, struct folio *folio)
 	if (bio)
 		submit_bio(bio);
 	else
-		unlock_page(page);
+		folio_unlock(folio);
 
 	return 0;
-
-add_failed:
-	printk(KERN_ERR "JFS: bio_add_page failed unexpectedly\n");
-	bio_put(bio);
-	dec_io(page, last_read_complete);
-	return -EIO;
 }
 
 static bool metapage_release_folio(struct folio *folio, gfp_t gfp_mask)
-- 
2.43.0


