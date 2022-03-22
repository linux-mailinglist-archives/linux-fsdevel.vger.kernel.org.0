Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D9134E43A2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Mar 2022 16:58:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238923AbiCVP7S (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Mar 2022 11:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238863AbiCVP6r (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Mar 2022 11:58:47 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 406F26EB38;
        Tue, 22 Mar 2022 08:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=HBr8sV8cq6D3GkgcwFpbM/V3GB453+XDYqFOnfazVY0=; b=SM/SbjQvgwQ/aCVbbdsQCs0EhX
        PRi9LaLcF5O54NMOHwU7fNlpdRaLRBM7EX3+/20RHC3iOEXDpfvPPzFQGPIYoMg+M+Qt/aMSy9NzA
        fN8OtjYcR1+AJsNx9z2rtM9wya0Xv67pWvJd1SseN+kOAkv3YXRGNuhezRW+tif1qdOqFkrrKwHd5
        QSC7kk8kmSkIhYdKKAx7mc4v7TsnSljdFgVMlz5Ee1J+nOq7kfGovaX9pxcJog02EeDnLlK0HDHLx
        VBypVlRsZ3/3yEGJydQ4WcI5FpeeWBV+v7m6C0Iyb1hC1LRsKpKachbp1vxtAzHvLAlaauQF9rkdL
        DpCCOr1w==;
Received: from [2001:4bb8:19a:b822:6444:5366:9486:4da] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nWgsl-00BaxF-Ul; Tue, 22 Mar 2022 15:57:16 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>
Cc:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 26/40] btrfs: refactor btrfs_map_bio
Date:   Tue, 22 Mar 2022 16:55:52 +0100
Message-Id: <20220322155606.1267165-27-hch@lst.de>
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

Use a label for common cleanup, untangle the conditionals for parity
RAID and move all per-stripe handling into submit_stripe_bio.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/volumes.c | 88 ++++++++++++++++++++++------------------------
 1 file changed, 42 insertions(+), 46 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 9a1eb1166d72f..1cf0914b33847 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6744,10 +6744,30 @@ static void btrfs_end_bio(struct bio *bio)
 		btrfs_end_bioc(bioc, true);
 }
 
-static void submit_stripe_bio(struct btrfs_io_context *bioc, struct bio *bio,
-			      u64 physical, struct btrfs_device *dev)
+static void submit_stripe_bio(struct btrfs_io_context *bioc,
+		struct bio *orig_bio, int dev_nr, bool clone)
 {
 	struct btrfs_fs_info *fs_info = bioc->fs_info;
+	struct btrfs_device *dev = bioc->stripes[dev_nr].dev;
+	u64 physical = bioc->stripes[dev_nr].physical;
+	struct bio *bio;
+
+	if (!dev || !dev->bdev ||
+	    test_bit(BTRFS_DEV_STATE_MISSING, &dev->dev_state) ||
+	    (btrfs_op(orig_bio) == BTRFS_MAP_WRITE &&
+	     !test_bit(BTRFS_DEV_STATE_WRITEABLE, &dev->dev_state))) {
+		atomic_inc(&bioc->error);
+		if (atomic_dec_and_test(&bioc->stripes_pending))
+			btrfs_end_bioc(bioc, false);
+		return;
+	}
+
+	if (clone) {
+		bio = btrfs_bio_clone(dev->bdev, orig_bio);
+	} else {
+		bio = orig_bio;
+		bio_set_dev(bio, dev->bdev);
+	}
 
 	bio->bi_private = bioc;
 	btrfs_bio(bio)->device = dev;
@@ -6782,46 +6802,40 @@ static void submit_stripe_bio(struct btrfs_io_context *bioc, struct bio *bio,
 blk_status_t btrfs_map_bio(struct btrfs_fs_info *fs_info, struct bio *bio,
 			   int mirror_num)
 {
-	struct btrfs_device *dev;
-	struct bio *first_bio = bio;
 	u64 logical = bio->bi_iter.bi_sector << 9;
-	u64 length = 0;
-	u64 map_length;
+	u64 length = bio->bi_iter.bi_size;
+	u64 map_length = length;
 	int ret;
 	int dev_nr;
 	int total_devs;
 	struct btrfs_io_context *bioc = NULL;
 
-	length = bio->bi_iter.bi_size;
-	map_length = length;
-
 	btrfs_bio_counter_inc_blocked(fs_info);
 	ret = __btrfs_map_block(fs_info, btrfs_op(bio), logical,
 				&map_length, &bioc, mirror_num, 1);
-	if (ret) {
-		btrfs_bio_counter_dec(fs_info);
-		return errno_to_blk_status(ret);
-	}
+	if (ret)
+		goto out_dec;
 
 	total_devs = bioc->num_stripes;
-	bioc->orig_bio = first_bio;
-	bioc->private = first_bio->bi_private;
-	bioc->end_io = first_bio->bi_end_io;
+	bioc->orig_bio = bio;
+	bioc->private = bio->bi_private;
+	bioc->end_io = bio->bi_end_io;
 	atomic_set(&bioc->stripes_pending, bioc->num_stripes);
 
-	if ((bioc->map_type & BTRFS_BLOCK_GROUP_RAID56_MASK) &&
-	    ((btrfs_op(bio) == BTRFS_MAP_WRITE) || (mirror_num > 1))) {
-		/* In this case, map_length has been set to the length of
-		   a single stripe; not the whole write */
+	if (bioc->map_type & BTRFS_BLOCK_GROUP_RAID56_MASK) {
+		/*
+		 * In this case, map_length has been set to the length of a
+		 * single stripe; not the whole write.
+		 */
 		if (btrfs_op(bio) == BTRFS_MAP_WRITE) {
 			ret = raid56_parity_write(bio, bioc, map_length);
-		} else {
+			goto out_dec;
+		}
+		if (mirror_num > 1) {
 			ret = raid56_parity_recover(bio, bioc, map_length,
 						    mirror_num, 1);
+			goto out_dec;
 		}
-
-		btrfs_bio_counter_dec(fs_info);
-		return errno_to_blk_status(ret);
 	}
 
 	if (map_length < length) {
@@ -6831,29 +6845,11 @@ blk_status_t btrfs_map_bio(struct btrfs_fs_info *fs_info, struct bio *bio,
 		BUG();
 	}
 
-	for (dev_nr = 0; dev_nr < total_devs; dev_nr++) {
-		dev = bioc->stripes[dev_nr].dev;
-		if (!dev || !dev->bdev || test_bit(BTRFS_DEV_STATE_MISSING,
-						   &dev->dev_state) ||
-		    (btrfs_op(first_bio) == BTRFS_MAP_WRITE &&
-		    !test_bit(BTRFS_DEV_STATE_WRITEABLE, &dev->dev_state))) {
-			atomic_inc(&bioc->error);
-			if (atomic_dec_and_test(&bioc->stripes_pending))
-				btrfs_end_bioc(bioc, false);
-			continue;
-		}
-
-		if (dev_nr < total_devs - 1) {
-			bio = btrfs_bio_clone(dev->bdev, first_bio);
-		} else {
-			bio = first_bio;
-			bio_set_dev(bio, dev->bdev);
-		}
-
-		submit_stripe_bio(bioc, bio, bioc->stripes[dev_nr].physical, dev);
-	}
+	for (dev_nr = 0; dev_nr < total_devs; dev_nr++)
+		submit_stripe_bio(bioc, bio, dev_nr, dev_nr < total_devs - 1);
+out_dec:
 	btrfs_bio_counter_dec(fs_info);
-	return BLK_STS_OK;
+	return errno_to_blk_status(ret);
 }
 
 static bool dev_args_match_fs_devices(const struct btrfs_dev_lookup_args *args,
-- 
2.30.2

