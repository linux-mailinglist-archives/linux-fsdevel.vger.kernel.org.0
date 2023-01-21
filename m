Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57E6B676444
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Jan 2023 07:51:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbjAUGvA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 21 Jan 2023 01:51:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbjAUGuy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 21 Jan 2023 01:50:54 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5916A60C9B;
        Fri, 20 Jan 2023 22:50:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=g4BMgkyFkJpwD9T3cD317rkUEi3U2bIiwt8HEpkAamw=; b=xbZFutkhwLHwRtxdyAjA7U4Y22
        gC1DZYVa0F2yPSp2iv/+HEvFy2gSh5jzagH8N7ZW1PWqFuL2Lyrg4Lb29CbsPfOcXr28QDG9Wexgt
        Z4boud00P2audYLMl9xpUrLOSxuGucxIGBSOm25SxYnvO5lwVeqpBoa4+ncoSAFs0EZbngKA5wEKG
        4DEQe+Usm5pmBSlMkIivHc8MM1WpSPQjV7rcVN05thm2s26/kYEu8msVz3SLLWq0BOk0LxwWI3/Zg
        ld2jQI08Cs5Fo3OwID9pE2a6QTVYKG5mFqICFfMorMoSfbt3R6D7dqpkb3ImlJOp8xhxvNZWYws6G
        OZ++9hbw==;
Received: from [2001:4bb8:19a:2039:6754:cc81:9ace:36fc] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pJ7iD-00DRJF-Il; Sat, 21 Jan 2023 06:50:50 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>, Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 06/34] btrfs: slightly refactor btrfs_submit_bio
Date:   Sat, 21 Jan 2023 07:50:03 +0100
Message-Id: <20230121065031.1139353-7-hch@lst.de>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230121065031.1139353-1-hch@lst.de>
References: <20230121065031.1139353-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a bbio local variable and to prepare for calling functions that
return a blk_status_t, rename the existing int used for error handling
so that ret can be reused for the blk_status_t, and a label that can be
reused for failing the passed in bio.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/bio.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index 2398bb263957b2..23afeeb6dbc8eb 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -230,20 +230,21 @@ static void btrfs_submit_mirrored_bio(struct btrfs_io_context *bioc, int dev_nr)
 
 void btrfs_submit_bio(struct btrfs_fs_info *fs_info, struct bio *bio, int mirror_num)
 {
+	struct btrfs_bio *bbio = btrfs_bio(bio);
 	u64 logical = bio->bi_iter.bi_sector << 9;
 	u64 length = bio->bi_iter.bi_size;
 	u64 map_length = length;
 	struct btrfs_io_context *bioc = NULL;
 	struct btrfs_io_stripe smap;
-	int ret;
+	blk_status_t ret;
+	int error;
 
 	btrfs_bio_counter_inc_blocked(fs_info);
-	ret = __btrfs_map_block(fs_info, btrfs_op(bio), logical, &map_length,
-				&bioc, &smap, &mirror_num, 1);
-	if (ret) {
-		btrfs_bio_counter_dec(fs_info);
-		btrfs_bio_end_io(btrfs_bio(bio), errno_to_blk_status(ret));
-		return;
+	error = __btrfs_map_block(fs_info, btrfs_op(bio), logical, &map_length,
+				  &bioc, &smap, &mirror_num, 1);
+	if (error) {
+		ret = errno_to_blk_status(error);
+		goto fail;
 	}
 
 	if (map_length < length) {
@@ -255,8 +256,8 @@ void btrfs_submit_bio(struct btrfs_fs_info *fs_info, struct bio *bio, int mirror
 
 	if (!bioc) {
 		/* Single mirror read/write fast path */
-		btrfs_bio(bio)->mirror_num = mirror_num;
-		btrfs_bio(bio)->device = smap.dev;
+		bbio->mirror_num = mirror_num;
+		bbio->device = smap.dev;
 		bio->bi_iter.bi_sector = smap.physical >> SECTOR_SHIFT;
 		bio->bi_private = fs_info;
 		bio->bi_end_io = btrfs_simple_end_io;
@@ -278,6 +279,11 @@ void btrfs_submit_bio(struct btrfs_fs_info *fs_info, struct bio *bio, int mirror
 		for (dev_nr = 0; dev_nr < total_devs; dev_nr++)
 			btrfs_submit_mirrored_bio(bioc, dev_nr);
 	}
+	return;
+
+fail:
+	btrfs_bio_counter_dec(fs_info);
+	btrfs_bio_end_io(bbio, ret);
 }
 
 /*
-- 
2.39.0

