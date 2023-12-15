Return-Path: <linux-fsdevel+bounces-6218-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8F2B8150C6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Dec 2023 21:05:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60D2F2870C6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Dec 2023 20:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 070CF68E80;
	Fri, 15 Dec 2023 20:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CgLipEpS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBBE45639E;
	Fri, 15 Dec 2023 20:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=y2LTUl+ZxJP8korj46ZIojz6qFBZmH/UltM1ueD//bY=; b=CgLipEpSQeL7n3K7h5qv//dI1J
	Hyxu1SNcuc6KE8jhGSWFs58vYD3Ub89XHd7GA8EZWVff0bnCAQ2AUPlYAcWmRslUjziZa2Txj/tdR
	lZb6urewEhwHsr+FYouUuqEuHYuh6LVjV4L23AiWMXhDxMJGDXScMgR0BKTTWz/qXkwG/ZCxdq8Ir
	lPuibOk7rQWaudaDIcmh+imazfOubEGNxtJd+4tg2i92riw+HuTk67lZpzaAQ5j8acssDeDrM1W2d
	RQEqLCazr3B5+hkCZ5B8FYOaHepMoxpgtSmO8YS/auXztCf+iqOwvANUpuLNAb3LtykX77pNzIHHZ
	PDjxz1zg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rEEOV-0038iK-3c; Fri, 15 Dec 2023 20:02:47 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Christoph Hellwig <hch@lst.de>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: [PATCH 03/14] fs: Reduce stack usage in __mpage_writepage
Date: Fri, 15 Dec 2023 20:02:34 +0000
Message-Id: <20231215200245.748418-4-willy@infradead.org>
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
 fs/mpage.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/fs/mpage.c b/fs/mpage.c
index 630f4a7c7d03..84b02098e7a5 100644
--- a/fs/mpage.c
+++ b/fs/mpage.c
@@ -466,7 +466,7 @@ static int __mpage_writepage(struct folio *folio, struct writeback_control *wbc,
 	const unsigned blocks_per_page = PAGE_SIZE >> blkbits;
 	sector_t last_block;
 	sector_t block_in_file;
-	sector_t blocks[MAX_BUF_PER_PAGE];
+	sector_t first_block;
 	unsigned page_block;
 	unsigned first_unmapped = blocks_per_page;
 	struct block_device *bdev = NULL;
@@ -504,10 +504,12 @@ static int __mpage_writepage(struct folio *folio, struct writeback_control *wbc,
 			if (!buffer_dirty(bh) || !buffer_uptodate(bh))
 				goto confused;
 			if (page_block) {
-				if (bh->b_blocknr != blocks[page_block-1] + 1)
+				if (bh->b_blocknr != first_block + page_block)
 					goto confused;
+			} else {
+				first_block = bh->b_blocknr;
 			}
-			blocks[page_block++] = bh->b_blocknr;
+			page_block++;
 			boundary = buffer_boundary(bh);
 			if (boundary) {
 				boundary_block = bh->b_blocknr;
@@ -556,10 +558,12 @@ static int __mpage_writepage(struct folio *folio, struct writeback_control *wbc,
 			boundary_bdev = map_bh.b_bdev;
 		}
 		if (page_block) {
-			if (map_bh.b_blocknr != blocks[page_block-1] + 1)
+			if (map_bh.b_blocknr != first_block + page_block)
 				goto confused;
+		} else {
+			first_block = map_bh.b_blocknr;
 		}
-		blocks[page_block++] = map_bh.b_blocknr;
+		page_block++;
 		boundary = buffer_boundary(&map_bh);
 		bdev = map_bh.b_bdev;
 		if (block_in_file == last_block)
@@ -591,7 +595,7 @@ static int __mpage_writepage(struct folio *folio, struct writeback_control *wbc,
 	/*
 	 * This page will go to BIO.  Do we need to send this BIO off first?
 	 */
-	if (bio && mpd->last_block_in_bio != blocks[0] - 1)
+	if (bio && mpd->last_block_in_bio != first_block - 1)
 		bio = mpage_bio_submit_write(bio);
 
 alloc_new:
@@ -599,7 +603,7 @@ static int __mpage_writepage(struct folio *folio, struct writeback_control *wbc,
 		bio = bio_alloc(bdev, BIO_MAX_VECS,
 				REQ_OP_WRITE | wbc_to_write_flags(wbc),
 				GFP_NOFS);
-		bio->bi_iter.bi_sector = blocks[0] << (blkbits - 9);
+		bio->bi_iter.bi_sector = first_block << (blkbits - 9);
 		wbc_init_bio(wbc, bio);
 	}
 
@@ -627,7 +631,7 @@ static int __mpage_writepage(struct folio *folio, struct writeback_control *wbc,
 					boundary_block, 1 << blkbits);
 		}
 	} else {
-		mpd->last_block_in_bio = blocks[blocks_per_page - 1];
+		mpd->last_block_in_bio = first_block + blocks_per_page - 1;
 	}
 	goto out;
 
-- 
2.42.0


