Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D13874E4370
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Mar 2022 16:57:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238800AbiCVP6Z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Mar 2022 11:58:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238840AbiCVP6O (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Mar 2022 11:58:14 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA6886D4C1;
        Tue, 22 Mar 2022 08:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Fx7jZlyqZDr9QDjQrJ2uRvV3BbZE9kqhIwHYKFMawl4=; b=YfmHJ7OLMbkBv6zxg7F8Md3X1m
        NCzKsTn4pgqR92y3DTByfo/BKhf/sp6vJ/W0hlkQrVJqgExDEFes3PT2SnDr9Yvwn/d9QZxKvVNhe
        Dpk7B4nLjilzfVDXCJnWfzX+LLwTal9YaFwVL33fBY60nD9p81Dm6c6WeO505Ft/KjVhh9diE4n2L
        lO2MCIxVDhqH0+M1sHLe09CHpN6UlAxnBEFbVUhym59va3WrLerbMtmc74sJgmPbd3pL6V7RslHy0
        Zwcl05/+u/ZBIf4gkxP/Yb7+09jTmmQkW3be4p4uEQqcms3WRVVr6ZydaLO7m6nLOgl4F70IoPpkW
        AvmO5zDw==;
Received: from [2001:4bb8:19a:b822:6444:5366:9486:4da] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nWgsE-00Bais-CM; Tue, 22 Mar 2022 15:56:42 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>
Cc:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 13/40] btrfs: initialize ->bi_opf and ->bi_private in rbio_add_io_page
Date:   Tue, 22 Mar 2022 16:55:39 +0100
Message-Id: <20220322155606.1267165-14-hch@lst.de>
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

Prepare for further refactoring by moving this initialization to a single
place.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/raid56.c | 38 ++++++++++++++++++--------------------
 1 file changed, 18 insertions(+), 20 deletions(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index 0e239a4c3b264..2f1f7ca27acd5 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -1069,7 +1069,8 @@ static int rbio_add_io_page(struct btrfs_raid_bio *rbio,
 			    struct page *page,
 			    int stripe_nr,
 			    unsigned long page_index,
-			    unsigned long bio_max_len)
+			    unsigned long bio_max_len,
+			    unsigned int opf)
 {
 	struct bio *last = bio_list->tail;
 	int ret;
@@ -1106,7 +1107,9 @@ static int rbio_add_io_page(struct btrfs_raid_bio *rbio,
 	btrfs_bio(bio)->device = stripe->dev;
 	bio->bi_iter.bi_size = 0;
 	bio_set_dev(bio, stripe->dev->bdev);
+	bio->bi_opf = opf;
 	bio->bi_iter.bi_sector = disk_start >> 9;
+	bio->bi_private = rbio;
 
 	bio_add_page(bio, page, PAGE_SIZE, 0);
 	bio_list_add(bio_list, bio);
@@ -1275,7 +1278,8 @@ static noinline void finish_rmw(struct btrfs_raid_bio *rbio)
 			}
 
 			ret = rbio_add_io_page(rbio, &bio_list,
-				       page, stripe, pagenr, rbio->stripe_len);
+				       page, stripe, pagenr, rbio->stripe_len,
+				       REQ_OP_WRITE);
 			if (ret)
 				goto cleanup;
 		}
@@ -1300,7 +1304,8 @@ static noinline void finish_rmw(struct btrfs_raid_bio *rbio)
 
 			ret = rbio_add_io_page(rbio, &bio_list, page,
 					       rbio->bioc->tgtdev_map[stripe],
-					       pagenr, rbio->stripe_len);
+					       pagenr, rbio->stripe_len,
+					       REQ_OP_WRITE);
 			if (ret)
 				goto cleanup;
 		}
@@ -1311,9 +1316,7 @@ static noinline void finish_rmw(struct btrfs_raid_bio *rbio)
 	BUG_ON(atomic_read(&rbio->stripes_pending) == 0);
 
 	while ((bio = bio_list_pop(&bio_list))) {
-		bio->bi_private = rbio;
 		bio->bi_end_io = raid_write_end_io;
-		bio->bi_opf = REQ_OP_WRITE;
 
 		submit_bio(bio);
 	}
@@ -1517,7 +1520,8 @@ static int raid56_rmw_stripe(struct btrfs_raid_bio *rbio)
 				continue;
 
 			ret = rbio_add_io_page(rbio, &bio_list, page,
-				       stripe, pagenr, rbio->stripe_len);
+				       stripe, pagenr, rbio->stripe_len,
+				       REQ_OP_READ);
 			if (ret)
 				goto cleanup;
 		}
@@ -1540,9 +1544,7 @@ static int raid56_rmw_stripe(struct btrfs_raid_bio *rbio)
 	 */
 	atomic_set(&rbio->stripes_pending, bios_to_read);
 	while ((bio = bio_list_pop(&bio_list))) {
-		bio->bi_private = rbio;
 		bio->bi_end_io = raid_rmw_end_io;
-		bio->bi_opf = REQ_OP_READ;
 
 		btrfs_bio_wq_end_io(rbio->bioc->fs_info, bio, BTRFS_WQ_ENDIO_RAID56);
 
@@ -2059,7 +2061,8 @@ static int __raid56_parity_recover(struct btrfs_raid_bio *rbio)
 
 			ret = rbio_add_io_page(rbio, &bio_list,
 				       rbio_stripe_page(rbio, stripe, pagenr),
-				       stripe, pagenr, rbio->stripe_len);
+				       stripe, pagenr, rbio->stripe_len,
+				       REQ_OP_READ);
 			if (ret < 0)
 				goto cleanup;
 		}
@@ -2086,9 +2089,7 @@ static int __raid56_parity_recover(struct btrfs_raid_bio *rbio)
 	 */
 	atomic_set(&rbio->stripes_pending, bios_to_read);
 	while ((bio = bio_list_pop(&bio_list))) {
-		bio->bi_private = rbio;
 		bio->bi_end_io = raid_recover_end_io;
-		bio->bi_opf = REQ_OP_READ;
 
 		btrfs_bio_wq_end_io(rbio->bioc->fs_info, bio, BTRFS_WQ_ENDIO_RAID56);
 
@@ -2419,8 +2420,8 @@ static noinline void finish_parity_scrub(struct btrfs_raid_bio *rbio,
 		struct page *page;
 
 		page = rbio_stripe_page(rbio, rbio->scrubp, pagenr);
-		ret = rbio_add_io_page(rbio, &bio_list,
-			       page, rbio->scrubp, pagenr, rbio->stripe_len);
+		ret = rbio_add_io_page(rbio, &bio_list, page, rbio->scrubp,
+				       pagenr, rbio->stripe_len, REQ_OP_WRITE);
 		if (ret)
 			goto cleanup;
 	}
@@ -2434,7 +2435,7 @@ static noinline void finish_parity_scrub(struct btrfs_raid_bio *rbio,
 		page = rbio_stripe_page(rbio, rbio->scrubp, pagenr);
 		ret = rbio_add_io_page(rbio, &bio_list, page,
 				       bioc->tgtdev_map[rbio->scrubp],
-				       pagenr, rbio->stripe_len);
+				       pagenr, rbio->stripe_len, REQ_OP_WRITE);
 		if (ret)
 			goto cleanup;
 	}
@@ -2450,9 +2451,7 @@ static noinline void finish_parity_scrub(struct btrfs_raid_bio *rbio,
 	atomic_set(&rbio->stripes_pending, nr_data);
 
 	while ((bio = bio_list_pop(&bio_list))) {
-		bio->bi_private = rbio;
 		bio->bi_end_io = raid_write_end_io;
-		bio->bi_opf = REQ_OP_WRITE;
 
 		submit_bio(bio);
 	}
@@ -2604,8 +2603,9 @@ static void raid56_parity_scrub_stripe(struct btrfs_raid_bio *rbio)
 			if (PageUptodate(page))
 				continue;
 
-			ret = rbio_add_io_page(rbio, &bio_list, page,
-				       stripe, pagenr, rbio->stripe_len);
+			ret = rbio_add_io_page(rbio, &bio_list, page, stripe,
+					       pagenr, rbio->stripe_len,
+					       REQ_OP_READ);
 			if (ret)
 				goto cleanup;
 		}
@@ -2628,9 +2628,7 @@ static void raid56_parity_scrub_stripe(struct btrfs_raid_bio *rbio)
 	 */
 	atomic_set(&rbio->stripes_pending, bios_to_read);
 	while ((bio = bio_list_pop(&bio_list))) {
-		bio->bi_private = rbio;
 		bio->bi_end_io = raid56_parity_scrub_end_io;
-		bio->bi_opf = REQ_OP_READ;
 
 		btrfs_bio_wq_end_io(rbio->bioc->fs_info, bio, BTRFS_WQ_ENDIO_RAID56);
 
-- 
2.30.2

