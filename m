Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A03507A47DD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Sep 2023 13:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241202AbjIRLF5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Sep 2023 07:05:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234735AbjIRLFZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Sep 2023 07:05:25 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF819FD;
        Mon, 18 Sep 2023 04:05:18 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 7BF781FDFF;
        Mon, 18 Sep 2023 11:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1695035117; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JUAe4yzlD4Eoh42gjXbVpU2X4y7THkjmua5ySlekNfg=;
        b=1/tZ3PU6BLkKC52ewzLRI/ybegGD7vJNp3HGk9M2dQsQ9S2ozKGfrdXsPJd7nnlwFW53xN
        4yYyTdqIdZmrg3+cnx0wPx2jVwwJwLAx6O74iyTrQ6jpBTIe7ARfZvk2DgadSNuTQUX2w5
        r6q3hl9c4OzSl30+8JBtjjwZQR27tPg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1695035117;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JUAe4yzlD4Eoh42gjXbVpU2X4y7THkjmua5ySlekNfg=;
        b=Fi+IlHP27ptD5VAo6UDbEfvUpyN+KyyvjdD/tT1lKA25UBKjcr/89Ug8hBItC+lVe53Rrj
        BMfE2u5JpUfNmlDw==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 6347B2C153;
        Mon, 18 Sep 2023 11:05:17 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id 1265251CD147; Mon, 18 Sep 2023 13:05:17 +0200 (CEST)
From:   Hannes Reinecke <hare@suse.de>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Pankaj Raghav <p.raghav@samsung.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH 05/18] fs/mpage: use accessor function to translate page index to sectors
Date:   Mon, 18 Sep 2023 13:04:57 +0200
Message-Id: <20230918110510.66470-6-hare@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230918110510.66470-1-hare@suse.de>
References: <20230918110510.66470-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use accessor functions to translate between page index and block sectors
and ensure the resulting buffer size is calculated correctly.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 fs/mpage.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/fs/mpage.c b/fs/mpage.c
index c9d9fdadb500..26460afd829a 100644
--- a/fs/mpage.c
+++ b/fs/mpage.c
@@ -168,7 +168,7 @@ static struct bio *do_mpage_readpage(struct mpage_readpage_args *args)
 	sector_t last_block;
 	sector_t last_block_in_file;
 	sector_t blocks[MAX_BUF_PER_PAGE];
-	unsigned page_block;
+	unsigned num_blocks, page_block;
 	unsigned first_hole = blocks_per_folio;
 	struct block_device *bdev = NULL;
 	int length;
@@ -189,8 +189,12 @@ static struct bio *do_mpage_readpage(struct mpage_readpage_args *args)
 	if (folio_buffers(folio))
 		goto confused;
 
-	block_in_file = (sector_t)folio->index << (PAGE_SHIFT - blkbits);
-	last_block = block_in_file + args->nr_pages * blocks_per_folio;
+	block_in_file = block_index_to_sector(folio->index, blkbits);
+	if (blkbits > PAGE_SHIFT)
+		num_blocks = args->nr_pages >> (blkbits - PAGE_SHIFT);
+	else
+		num_blocks = args->nr_pages * blocks_per_folio;
+	last_block = block_in_file + num_blocks;
 	last_block_in_file = (i_size_read(inode) + blocksize - 1) >> blkbits;
 	if (last_block > last_block_in_file)
 		last_block = last_block_in_file;
@@ -277,7 +281,7 @@ static struct bio *do_mpage_readpage(struct mpage_readpage_args *args)
 	}
 
 	if (first_hole != blocks_per_folio) {
-		folio_zero_segment(folio, first_hole << blkbits, PAGE_SIZE);
+		folio_zero_segment(folio, first_hole << blkbits, folio_size(folio));
 		if (first_hole == 0) {
 			folio_mark_uptodate(folio);
 			folio_unlock(folio);
@@ -543,7 +547,7 @@ static int __mpage_writepage(struct folio *folio, struct writeback_control *wbc,
 	 * The page has no buffers: map it to disk
 	 */
 	BUG_ON(!folio_test_uptodate(folio));
-	block_in_file = (sector_t)folio->index << (PAGE_SHIFT - blkbits);
+	block_in_file = block_index_to_sector(folio->index, blkbits);
 	/*
 	 * Whole page beyond EOF? Skip allocating blocks to avoid leaking
 	 * space.
-- 
2.35.3

