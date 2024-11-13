Return-Path: <linux-fsdevel+bounces-34607-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84AC59C6BD8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 10:48:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 153F31F238F0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 09:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 777221F8F14;
	Wed, 13 Nov 2024 09:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="4DDs/JDa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2A218B460;
	Wed, 13 Nov 2024 09:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731491255; cv=none; b=gJFM7ZSz2/4MT/+Osnh8lBkDvSznHZYk6xglOuRmUspd8wvmLPXHg4+rCnlsh0fWpJjaih443NNnzH5VtnTL8GwMdQyZMYUZKAlW1VAdyjXhVkcGVJE3jGxHeHSbE7KHxxGg7mQOium2trfsAs5cEiI2EZ6viVu05YkIHvp2K00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731491255; c=relaxed/simple;
	bh=utrpOJ55Xx9Nisul1czzp8Mu91L5n7h0eXEp6yFDifQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t8xcHKgtL8Lgtu9ISIUcJs+P+WF6kI/43RoUn0ETmDKF4mCNA7MahRzPrm6hALWfsTUCaAvxaUw3ZdeFh26jsuL4j0OPIIqppAh39SwyA5T8n+gXZf2ymV9itskUwDwhrTuwh3tZbiw0HV5JoZpm8OIFqUC2k0X98MPIe3erCys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=4DDs/JDa; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=ns/7m4rN3Pzx9FwaAtcwSt3EF1rHNhns2eROAPx84Uw=; b=4DDs/JDaSOGto5fCjDTWI+nVjP
	bhTdPEcjrovcFCCUG1DjV0x1blqchw5Z2Y6joGv4tEMV0M6J5mNB3sXZWi4gcwtGbbOtroBBibJc8
	GnHPf3L+e+blGHbME6PNZvXH7yQYl8Y7vMwDalxQ8Lf0SBT9W5xYaMIcaEEPPTIl5LFQVVvD0GuOe
	zYX5SCVyQ6CzJGMHuCXSZIkkrMiRwoohXUhIO/4tjsrDxN+8ZxV+MNtikafpHD1r0aCyge+SVAwoc
	S5ct3gcAq2eDLY3j58Us7EOQf4mAwyYU1MNF+Bh45qYnIR4lNZHmTV2gFrwgIA4szdPWM7/wIf05B
	D1RL9rpQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tB9yC-00000006Hcz-3lX4;
	Wed, 13 Nov 2024 09:47:28 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
To: willy@infradead.org,
	hch@lst.de,
	hare@suse.de,
	david@fromorbit.com,
	djwong@kernel.org
Cc: john.g.garry@oracle.com,
	ritesh.list@gmail.com,
	kbusch@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-mm@kvack.org,
	linux-block@vger.kernel.org,
	gost.dev@samsung.com,
	p.raghav@samsung.com,
	da.gomez@samsung.com,
	kernel@pankajraghav.com,
	mcgrof@kernel.org
Subject: [RFC 1/8] fs/mpage: use blocks_per_folio instead of blocks_per_page
Date: Wed, 13 Nov 2024 01:47:20 -0800
Message-ID: <20241113094727.1497722-2-mcgrof@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241113094727.1497722-1-mcgrof@kernel.org>
References: <20241113094727.1497722-1-mcgrof@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>

From: Hannes Reinecke <hare@suse.de>

Convert mpage to folios and associate the number of blocks with
a folio and not a page.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 fs/mpage.c | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/fs/mpage.c b/fs/mpage.c
index b5b5ddf9d513..5b5989c7c2a0 100644
--- a/fs/mpage.c
+++ b/fs/mpage.c
@@ -107,7 +107,7 @@ static void map_buffer_to_folio(struct folio *folio, struct buffer_head *bh,
 		 * don't make any buffers if there is only one buffer on
 		 * the folio and the folio just needs to be set up to date
 		 */
-		if (inode->i_blkbits == PAGE_SHIFT &&
+		if (inode->i_blkbits == folio_shift(folio) &&
 		    buffer_uptodate(bh)) {
 			folio_mark_uptodate(folio);
 			return;
@@ -153,7 +153,7 @@ static struct bio *do_mpage_readpage(struct mpage_readpage_args *args)
 	struct folio *folio = args->folio;
 	struct inode *inode = folio->mapping->host;
 	const unsigned blkbits = inode->i_blkbits;
-	const unsigned blocks_per_page = PAGE_SIZE >> blkbits;
+	const unsigned blocks_per_folio = folio_size(folio) >> blkbits;
 	const unsigned blocksize = 1 << blkbits;
 	struct buffer_head *map_bh = &args->map_bh;
 	sector_t block_in_file;
@@ -161,7 +161,7 @@ static struct bio *do_mpage_readpage(struct mpage_readpage_args *args)
 	sector_t last_block_in_file;
 	sector_t first_block;
 	unsigned page_block;
-	unsigned first_hole = blocks_per_page;
+	unsigned first_hole = blocks_per_folio;
 	struct block_device *bdev = NULL;
 	int length;
 	int fully_mapped = 1;
@@ -182,7 +182,7 @@ static struct bio *do_mpage_readpage(struct mpage_readpage_args *args)
 		goto confused;
 
 	block_in_file = (sector_t)folio->index << (PAGE_SHIFT - blkbits);
-	last_block = block_in_file + args->nr_pages * blocks_per_page;
+	last_block = block_in_file + args->nr_pages * blocks_per_folio;
 	last_block_in_file = (i_size_read(inode) + blocksize - 1) >> blkbits;
 	if (last_block > last_block_in_file)
 		last_block = last_block_in_file;
@@ -204,7 +204,7 @@ static struct bio *do_mpage_readpage(struct mpage_readpage_args *args)
 				clear_buffer_mapped(map_bh);
 				break;
 			}
-			if (page_block == blocks_per_page)
+			if (page_block == blocks_per_folio)
 				break;
 			page_block++;
 			block_in_file++;
@@ -216,7 +216,7 @@ static struct bio *do_mpage_readpage(struct mpage_readpage_args *args)
 	 * Then do more get_blocks calls until we are done with this folio.
 	 */
 	map_bh->b_folio = folio;
-	while (page_block < blocks_per_page) {
+	while (page_block < blocks_per_folio) {
 		map_bh->b_state = 0;
 		map_bh->b_size = 0;
 
@@ -229,7 +229,7 @@ static struct bio *do_mpage_readpage(struct mpage_readpage_args *args)
 
 		if (!buffer_mapped(map_bh)) {
 			fully_mapped = 0;
-			if (first_hole == blocks_per_page)
+			if (first_hole == blocks_per_folio)
 				first_hole = page_block;
 			page_block++;
 			block_in_file++;
@@ -247,7 +247,7 @@ static struct bio *do_mpage_readpage(struct mpage_readpage_args *args)
 			goto confused;
 		}
 	
-		if (first_hole != blocks_per_page)
+		if (first_hole != blocks_per_folio)
 			goto confused;		/* hole -> non-hole */
 
 		/* Contiguous blocks? */
@@ -260,7 +260,7 @@ static struct bio *do_mpage_readpage(struct mpage_readpage_args *args)
 			if (relative_block == nblocks) {
 				clear_buffer_mapped(map_bh);
 				break;
-			} else if (page_block == blocks_per_page)
+			} else if (page_block == blocks_per_folio)
 				break;
 			page_block++;
 			block_in_file++;
@@ -268,7 +268,7 @@ static struct bio *do_mpage_readpage(struct mpage_readpage_args *args)
 		bdev = map_bh->b_bdev;
 	}
 
-	if (first_hole != blocks_per_page) {
+	if (first_hole != blocks_per_folio) {
 		folio_zero_segment(folio, first_hole << blkbits, PAGE_SIZE);
 		if (first_hole == 0) {
 			folio_mark_uptodate(folio);
@@ -303,10 +303,10 @@ static struct bio *do_mpage_readpage(struct mpage_readpage_args *args)
 	relative_block = block_in_file - args->first_logical_block;
 	nblocks = map_bh->b_size >> blkbits;
 	if ((buffer_boundary(map_bh) && relative_block == nblocks) ||
-	    (first_hole != blocks_per_page))
+	    (first_hole != blocks_per_folio))
 		args->bio = mpage_bio_submit_read(args->bio);
 	else
-		args->last_block_in_bio = first_block + blocks_per_page - 1;
+		args->last_block_in_bio = first_block + blocks_per_folio - 1;
 out:
 	return args->bio;
 
@@ -385,7 +385,7 @@ int mpage_read_folio(struct folio *folio, get_block_t get_block)
 {
 	struct mpage_readpage_args args = {
 		.folio = folio,
-		.nr_pages = 1,
+		.nr_pages = folio_nr_pages(folio),
 		.get_block = get_block,
 	};
 
@@ -456,12 +456,12 @@ static int __mpage_writepage(struct folio *folio, struct writeback_control *wbc,
 	struct address_space *mapping = folio->mapping;
 	struct inode *inode = mapping->host;
 	const unsigned blkbits = inode->i_blkbits;
-	const unsigned blocks_per_page = PAGE_SIZE >> blkbits;
+	const unsigned blocks_per_folio = folio_size(folio) >> blkbits;
 	sector_t last_block;
 	sector_t block_in_file;
 	sector_t first_block;
 	unsigned page_block;
-	unsigned first_unmapped = blocks_per_page;
+	unsigned first_unmapped = blocks_per_folio;
 	struct block_device *bdev = NULL;
 	int boundary = 0;
 	sector_t boundary_block = 0;
@@ -486,12 +486,12 @@ static int __mpage_writepage(struct folio *folio, struct writeback_control *wbc,
 				 */
 				if (buffer_dirty(bh))
 					goto confused;
-				if (first_unmapped == blocks_per_page)
+				if (first_unmapped == blocks_per_folio)
 					first_unmapped = page_block;
 				continue;
 			}
 
-			if (first_unmapped != blocks_per_page)
+			if (first_unmapped != blocks_per_folio)
 				goto confused;	/* hole -> non-hole */
 
 			if (!buffer_dirty(bh) || !buffer_uptodate(bh))
@@ -536,7 +536,7 @@ static int __mpage_writepage(struct folio *folio, struct writeback_control *wbc,
 		goto page_is_mapped;
 	last_block = (i_size - 1) >> blkbits;
 	map_bh.b_folio = folio;
-	for (page_block = 0; page_block < blocks_per_page; ) {
+	for (page_block = 0; page_block < blocks_per_folio; ) {
 
 		map_bh.b_state = 0;
 		map_bh.b_size = 1 << blkbits;
@@ -618,14 +618,14 @@ static int __mpage_writepage(struct folio *folio, struct writeback_control *wbc,
 	BUG_ON(folio_test_writeback(folio));
 	folio_start_writeback(folio);
 	folio_unlock(folio);
-	if (boundary || (first_unmapped != blocks_per_page)) {
+	if (boundary || (first_unmapped != blocks_per_folio)) {
 		bio = mpage_bio_submit_write(bio);
 		if (boundary_block) {
 			write_boundary_block(boundary_bdev,
 					boundary_block, 1 << blkbits);
 		}
 	} else {
-		mpd->last_block_in_bio = first_block + blocks_per_page - 1;
+		mpd->last_block_in_bio = first_block + blocks_per_folio - 1;
 	}
 	goto out;
 
-- 
2.43.0


