Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59B9E4F0E4D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Apr 2022 06:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377171AbiDDEsK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Apr 2022 00:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377178AbiDDEsG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Apr 2022 00:48:06 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8233136E21;
        Sun,  3 Apr 2022 21:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=LoJwIajq8dDPhSjXLbKlbZETQUB61MLTA56AsYNrO7w=; b=X5Tk7gksugh2o8WXZ7N6zqeZae
        jSrNkwGgdMiKI9A6tk0FgohYrFyZwFtI8sEsuDxRe2zbZrFE1pnRr7r0YBRhbw78XOVW8MYgVBMFS
        1G6xl0OoRoO/mewDjiLKsE7bGw/VR3WF93eD+WwjNUdg3LOcjX3V0M89GXcwU+sVEH7/pySS3pURQ
        ECI09nRC95D24GKhUcaIxYYWNluiO8stYpxfi1qNe6hv2IZNqK7dOUZLD6gLblNkdClCct+xddtcw
        IynBg+5+qJaSTXaKfF9bDS6rUEf5Jxq7F+LOlkMc33E7oqq5YILWjPTX2VtI9EkS1hiF2Te8HdTsB
        /Rt0BRzQ==;
Received: from 089144211060.atnat0020.highway.a1.net ([89.144.211.60] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nbEbP-00D3kE-2y; Mon, 04 Apr 2022 04:46:07 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>
Cc:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 11/12] btrfs: don't allocate a btrfs_bio for scrub bios
Date:   Mon,  4 Apr 2022 06:45:27 +0200
Message-Id: <20220404044528.71167-12-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220404044528.71167-1-hch@lst.de>
References: <20220404044528.71167-1-hch@lst.de>
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
Reviewed-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/scrub.c | 47 ++++++++++++++++++-----------------------------
 1 file changed, 18 insertions(+), 29 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 93bb480de2164..38ad158a93ba2 100644
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

