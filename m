Return-Path: <linux-fsdevel+bounces-17197-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AAEA8A8AAD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 19:58:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 302141F251F1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 17:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 673CF173339;
	Wed, 17 Apr 2024 17:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vgcdcrxB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86382175558
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Apr 2024 17:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713376626; cv=none; b=jCTVY1jeXHVTcJco92ILTj5J2hnq9yguKKAWfY+SFzFbw0+qxXTSVoLHnw9gdiaM82R0YcIk1R0Gu+12Q0+WAuCk+M9PCTpC9PVxnxlB89yDk9BcFwS3OFxdk4YPNJeA/xclcpvIzXCE9hxYxSw2vvjK2Hthl7+GJMSuAdMqABU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713376626; c=relaxed/simple;
	bh=0pgZAWjuqFQyQjPX6F27SlJdStSQ28iBvPXL+HBVAnQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P7T7JgMD+Qu4y6VWQ7TvfpSdWwjk/n7r3dJooxDDJnRiiB2S3dKy0wDsqlWQ+Urf9VhNAIiCJ+t02c+ovBgc7hI4aiv4uhdzp55hIig5RQwJhb4IVMixo0aASl4L1ddDHxZDKzxphqOJplZqLepBNis3z+b7cuccgnGC/EVCZ08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=vgcdcrxB; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=tuAP8Pj11A6vSLLksQ3sdzEDeykXyvIK9phb2ySpPEM=; b=vgcdcrxBtHehy2RcT2TwJyfETJ
	E/z8u0bmwPu/oXYtLIDVeNhVOh/PUwR2G39v7IibHpQ3ugGAfsXUCempOsHw9DSV19xo+Ez2GlGK/
	Htm8CLQNS3MUUnROGh1dLGBeXsKPzgOiiuZT709kDd0XkoLUq+B1wrfiyQpeilGtG0h9k0zAGWiOy
	D9ZHjRhb0+U+2ikdBj10dbP75RkJLF/pUEuPHI8XO4nPjaAr5OIzfDwaIIfufk2YlXA+lo0w8fc1k
	E7DeKeYZx/63gkfigLNodpMoY5wnkMqYKwBg145CThoIJWgR/J5eWigeo/25e/x40nL15isAlzW8I
	BWnO3Yag==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rx9Wm-00000003Qsh-3mnh;
	Wed, 17 Apr 2024 17:57:00 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Dave Kleikamp <shaggy@kernel.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	jfs-discussion@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 01/13] jfs: Convert metapage_read_folio to use folio APIs
Date: Wed, 17 Apr 2024 18:56:45 +0100
Message-ID: <20240417175659.818299-2-willy@infradead.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240417175659.818299-1-willy@infradead.org>
References: <20240417175659.818299-1-willy@infradead.org>
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


