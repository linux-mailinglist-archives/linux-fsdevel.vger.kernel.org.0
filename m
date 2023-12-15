Return-Path: <linux-fsdevel+bounces-6214-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E83568150BC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Dec 2023 21:05:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A30F8286AC3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Dec 2023 20:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EF6F66AB1;
	Fri, 15 Dec 2023 20:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="e8qURtTR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBBA656392;
	Fri, 15 Dec 2023 20:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=0B/sDa1saKqxXEgZRJR/a3sr7f58TwwgS4ua8ky7x0Y=; b=e8qURtTRWssY4Mjtv1z26WCh21
	uo7XYAn73N0F0GMHC17x1N/4sjzDtGq8ql4X893T5CwDNPR7YGXhT3waInAkxYFtk3pcMT7x06YQe
	CQXxoQyRmfTRzWJwDwkbCvzy0EGlhf7Gxu4RuDAubplZH+SvGPIdh8aJkPrb0MYF28Xnzen7iYgyO
	0kFxroaOzhit50zDMcQ0rATYSd2QoVduwm9cREFbbaw4a63ATvP0g5wp6qGoyqW0cOJkcXmnVtDso
	qObeTV8nBGrkMzWZcfJUILvzDiS+ZHDYuDFyi37QlNOj2N/4i+3Sq+5RqMYHzIAJTBn6V1c2ufLhD
	5tIq2YyA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rEEOV-0038iR-6r; Fri, 15 Dec 2023 20:02:47 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Christoph Hellwig <hch@lst.de>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: [PATCH 04/14] fs: Reduce stack usage in do_mpage_readpage
Date: Fri, 15 Dec 2023 20:02:35 +0000
Message-Id: <20231215200245.748418-5-willy@infradead.org>
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

Some architectures support a very large PAGE_SIZE, so instead of the 8
pointers we see with a 4kB PAGE_SIZE, we can see 128 pointers with 64kB
or so many on Hexagon that it trips compiler warnings about exceeding
stack frame size.

All we're doing with this array is checking for block contiguity, which we
can as well do by remembering the address of the first block in the page
and checking this block is at the appropriate offset from that address.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/mpage.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/mpage.c b/fs/mpage.c
index 84b02098e7a5..d4963f3d8051 100644
--- a/fs/mpage.c
+++ b/fs/mpage.c
@@ -166,7 +166,7 @@ static struct bio *do_mpage_readpage(struct mpage_readpage_args *args)
 	sector_t block_in_file;
 	sector_t last_block;
 	sector_t last_block_in_file;
-	sector_t blocks[MAX_BUF_PER_PAGE];
+	sector_t first_block;
 	unsigned page_block;
 	unsigned first_hole = blocks_per_page;
 	struct block_device *bdev = NULL;
@@ -205,6 +205,7 @@ static struct bio *do_mpage_readpage(struct mpage_readpage_args *args)
 		unsigned map_offset = block_in_file - args->first_logical_block;
 		unsigned last = nblocks - map_offset;
 
+		first_block = map_bh->b_blocknr + map_offset;
 		for (relative_block = 0; ; relative_block++) {
 			if (relative_block == last) {
 				clear_buffer_mapped(map_bh);
@@ -212,8 +213,6 @@ static struct bio *do_mpage_readpage(struct mpage_readpage_args *args)
 			}
 			if (page_block == blocks_per_page)
 				break;
-			blocks[page_block] = map_bh->b_blocknr + map_offset +
-						relative_block;
 			page_block++;
 			block_in_file++;
 		}
@@ -259,7 +258,9 @@ static struct bio *do_mpage_readpage(struct mpage_readpage_args *args)
 			goto confused;		/* hole -> non-hole */
 
 		/* Contiguous blocks? */
-		if (page_block && blocks[page_block-1] != map_bh->b_blocknr-1)
+		if (!page_block)
+			first_block = map_bh->b_blocknr;
+		else if (first_block + page_block != map_bh->b_blocknr)
 			goto confused;
 		nblocks = map_bh->b_size >> blkbits;
 		for (relative_block = 0; ; relative_block++) {
@@ -268,7 +269,6 @@ static struct bio *do_mpage_readpage(struct mpage_readpage_args *args)
 				break;
 			} else if (page_block == blocks_per_page)
 				break;
-			blocks[page_block] = map_bh->b_blocknr+relative_block;
 			page_block++;
 			block_in_file++;
 		}
@@ -289,7 +289,7 @@ static struct bio *do_mpage_readpage(struct mpage_readpage_args *args)
 	/*
 	 * This folio will go to BIO.  Do we need to send this BIO off first?
 	 */
-	if (args->bio && (args->last_block_in_bio != blocks[0] - 1))
+	if (args->bio && (args->last_block_in_bio != first_block - 1))
 		args->bio = mpage_bio_submit_read(args->bio);
 
 alloc_new:
@@ -298,7 +298,7 @@ static struct bio *do_mpage_readpage(struct mpage_readpage_args *args)
 				      gfp);
 		if (args->bio == NULL)
 			goto confused;
-		args->bio->bi_iter.bi_sector = blocks[0] << (blkbits - 9);
+		args->bio->bi_iter.bi_sector = first_block << (blkbits - 9);
 	}
 
 	length = first_hole << blkbits;
@@ -313,7 +313,7 @@ static struct bio *do_mpage_readpage(struct mpage_readpage_args *args)
 	    (first_hole != blocks_per_page))
 		args->bio = mpage_bio_submit_read(args->bio);
 	else
-		args->last_block_in_bio = blocks[blocks_per_page - 1];
+		args->last_block_in_bio = first_block + blocks_per_page - 1;
 out:
 	return args->bio;
 
-- 
2.42.0


