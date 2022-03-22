Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 669054E438C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Mar 2022 16:57:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238773AbiCVP6c (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Mar 2022 11:58:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238176AbiCVP6Y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Mar 2022 11:58:24 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FFE36D87D;
        Tue, 22 Mar 2022 08:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=f0E5HuNGbNOwy9eq2zwG8qMKqTEPyTFYjz5yc6v/F7k=; b=HXdPOs3hJkjq/1bPXlQuk3olxx
        EoO5qt9cJtrJkZuqBpLty2qMjkBe2fwJ0Z9ZF3pwGUyl7ATK/rKz7UlTzaDxIto5x2mFTZdERbBK5
        2T98XliYHh/AtuGnBfZsuHiAqXF0VMYr9bVJkGNSJpQNhsWDspX8bn/hxyLel01jXRHnrHau5xymC
        7ZnbAPgpyxgV5YXkN0v6pOGZ2QjMJFXnj6HCGQ5yacdLnAq5hKqJ9GExG35hRSfNBXJMckPsP6LT5
        GaXV6sGOhYbf0AP8umPS/EEeyAv99LjTAmtyHv4G9CF2XcSecHxBbRo37nic4nX6IoMDDUj2aVt8N
        VHcS9BsQ==;
Received: from [2001:4bb8:19a:b822:6444:5366:9486:4da] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nWgsJ-00Bal0-HW; Tue, 22 Mar 2022 15:56:47 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>
Cc:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 15/40] btrfs: don't allocate a btrfs_bio for scrub bios
Date:   Tue, 22 Mar 2022 16:55:41 +0100
Message-Id: <20220322155606.1267165-16-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220322155606.1267165-1-hch@lst.de>
References: <20220322155606.1267165-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

All the scrub bios go straight to the block device or the raid56 code,
none of which looks at the btrfs_bio.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/scrub.c | 47 ++++++++++++++++++-----------------------------
 1 file changed, 18 insertions(+), 29 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index bb9382c02714f..250d271b02341 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -1415,8 +1415,8 @@ static void scrub_recheck_block_on_raid56(struct btrfs_fs_info *fs_info,
 	if (!first_page->dev->bdev)
 		goto out;
 
-	bio = btrfs_bio_alloc(BIO_MAX_VECS);
-	bio_set_dev(bio, first_page->dev->bdev);
+	bio = bio_alloc(first_page->dev->bdev, BIO_MAX_VECS, REQ_OP_READ,
+			GFP_NOFS);
 
 	for (page_num = 0; page_num < sblock->page_count; page_num++) {
 		struct scrub_page *spage = sblock->pagev[page_num];
@@ -1649,8 +1649,6 @@ static int scrub_add_page_to_wr_bio(struct scrub_ctx *sctx,
 	}
 	sbio = sctx->wr_curr_bio;
 	if (sbio->page_count == 0) {
-		struct bio *bio;
-
 		ret = fill_writer_pointer_gap(sctx,
 					      spage->physical_for_dev_replace);
 		if (ret) {
@@ -1661,17 +1659,14 @@ static int scrub_add_page_to_wr_bio(struct scrub_ctx *sctx,
 		sbio->physical = spage->physical_for_dev_replace;
 		sbio->logical = spage->logical;
 		sbio->dev = sctx->wr_tgtdev;
-		bio = sbio->bio;
-		if (!bio) {
-			bio = btrfs_bio_alloc(sctx->pages_per_bio);
-			sbio->bio = bio;
+		if (!sbio->bio) {
+			sbio->bio = bio_alloc(sbio->dev->bdev,
+					      sctx->pages_per_bio,
+					      REQ_OP_WRITE, GFP_NOFS);
 		}
-
-		bio->bi_private = sbio;
-		bio->bi_end_io = scrub_wr_bio_end_io;
-		bio_set_dev(bio, sbio->dev->bdev);
-		bio->bi_iter.bi_sector = sbio->physical >> 9;
-		bio->bi_opf = REQ_OP_WRITE;
+		sbio->bio->bi_private = sbio;
+		sbio->bio->bi_end_io = scrub_wr_bio_end_io;
+		sbio->bio->bi_iter.bi_sector = sbio->physical >> 9;
 		sbio->status = 0;
 	} else if (sbio->physical + sbio->page_count * sectorsize !=
 		   spage->physical_for_dev_replace ||
@@ -1712,7 +1707,6 @@ static void scrub_wr_submit(struct scrub_ctx *sctx)
 
 	sbio = sctx->wr_curr_bio;
 	sctx->wr_curr_bio = NULL;
-	WARN_ON(!sbio->bio->bi_bdev);
 	scrub_pending_bio_inc(sctx);
 	/* process all writes in a single worker thread. Then the block layer
 	 * orders the requests before sending them to the driver which
@@ -2084,22 +2078,17 @@ static int scrub_add_page_to_rd_bio(struct scrub_ctx *sctx,
 	}
 	sbio = sctx->bios[sctx->curr];
 	if (sbio->page_count == 0) {
-		struct bio *bio;
-
 		sbio->physical = spage->physical;
 		sbio->logical = spage->logical;
 		sbio->dev = spage->dev;
-		bio = sbio->bio;
-		if (!bio) {
-			bio = btrfs_bio_alloc(sctx->pages_per_bio);
-			sbio->bio = bio;
+		if (!sbio->bio) {
+			sbio->bio = bio_alloc(sbio->dev->bdev,
+					      sctx->pages_per_bio,
+					      REQ_OP_READ, GFP_NOFS);
 		}
-
-		bio->bi_private = sbio;
-		bio->bi_end_io = scrub_bio_end_io;
-		bio_set_dev(bio, sbio->dev->bdev);
-		bio->bi_iter.bi_sector = sbio->physical >> 9;
-		bio->bi_opf = REQ_OP_READ;
+		sbio->bio->bi_private = sbio;
+		sbio->bio->bi_end_io = scrub_bio_end_io;
+		sbio->bio->bi_iter.bi_sector = sbio->physical >> 9;
 		sbio->status = 0;
 	} else if (sbio->physical + sbio->page_count * sectorsize !=
 		   spage->physical ||
@@ -2215,7 +2204,7 @@ static void scrub_missing_raid56_pages(struct scrub_block *sblock)
 		goto bioc_out;
 	}
 
-	bio = btrfs_bio_alloc(BIO_MAX_VECS);
+	bio = bio_alloc(NULL, BIO_MAX_VECS, REQ_OP_READ, GFP_NOFS);
 	bio->bi_iter.bi_sector = logical >> 9;
 	bio->bi_private = sblock;
 	bio->bi_end_io = scrub_missing_raid56_end_io;
@@ -2831,7 +2820,7 @@ static void scrub_parity_check_and_repair(struct scrub_parity *sparity)
 	if (ret || !bioc || !bioc->raid_map)
 		goto bioc_out;
 
-	bio = btrfs_bio_alloc(BIO_MAX_VECS);
+	bio = bio_alloc(NULL, BIO_MAX_VECS, REQ_OP_READ, GFP_NOFS);
 	bio->bi_iter.bi_sector = sparity->logic_start >> 9;
 	bio->bi_private = sparity;
 	bio->bi_end_io = scrub_parity_bio_endio;
-- 
2.30.2

