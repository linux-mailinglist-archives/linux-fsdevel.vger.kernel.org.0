Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BDD14F0E4C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Apr 2022 06:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377150AbiDDErv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Apr 2022 00:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377142AbiDDErp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Apr 2022 00:47:45 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17D4432EEB;
        Sun,  3 Apr 2022 21:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=xuD6+ubfjLGD77PtcNObyK7VoDf8VbASzFZro4tX/2s=; b=gaJ/dGp2R0JAKAMKYAyQTbMmxI
        zlTSh4/oN2VOERx1izwhmLjo9FMCILJwK/mTG648BkrjCEydjqU0jRBvkLnO3pFhUVA5I2kt/BJaz
        gxj4rIT6MhblQ3Z18rvHJIemRgDJE8WoolZ45q2Y53z1yAy7dVU2GYQ6Tym8caqoOtDMVXCk4XQho
        cE5RGOF7FfoDM7TuiAeNuf6anwilUF+dMxLU+k97klO4WAxQ9vshhoENAh/N+ro6GmS8NO1878dDf
        Yjg5D2gY3lelF6XCuo6ZOTKerVdVDeKDe8wYyiirQGRcxEKCTgX4aGsWFNeCEaGVhe1iLGyd2z/KW
        GXE1VI/A==;
Received: from 089144211060.atnat0020.highway.a1.net ([89.144.211.60] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nbEb4-00D3XX-3Q; Mon, 04 Apr 2022 04:45:46 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>
Cc:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 04/12] btrfs: simplify repair_io_failure
Date:   Mon,  4 Apr 2022 06:45:20 +0200
Message-Id: <20220404044528.71167-5-hch@lst.de>
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

The I/O in repair_io_failue is synchronous and doesn't need a btrfs_bio,
so just use an on-stack bio.  Also cleanup the error handling to use goto
labels and not discard the actual return values.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 52 ++++++++++++++++++++------------------------
 1 file changed, 24 insertions(+), 28 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 3f77abefebde0..e4af9a0935ca0 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2303,12 +2303,13 @@ static int repair_io_failure(struct btrfs_fs_info *fs_info, u64 ino, u64 start,
 			     u64 length, u64 logical, struct page *page,
 			     unsigned int pg_offset, int mirror_num)
 {
-	struct bio *bio;
 	struct btrfs_device *dev;
+	struct bio_vec bvec;
+	struct bio bio;
 	u64 map_length = 0;
 	u64 sector;
 	struct btrfs_io_context *bioc = NULL;
-	int ret;
+	int ret = 0;
 
 	ASSERT(!(fs_info->sb->s_flags & SB_RDONLY));
 	BUG_ON(!mirror_num);
@@ -2316,8 +2317,6 @@ static int repair_io_failure(struct btrfs_fs_info *fs_info, u64 ino, u64 start,
 	if (btrfs_repair_one_zone(fs_info, logical))
 		return 0;
 
-	bio = btrfs_bio_alloc(1);
-	bio->bi_iter.bi_size = 0;
 	map_length = length;
 
 	/*
@@ -2335,53 +2334,50 @@ static int repair_io_failure(struct btrfs_fs_info *fs_info, u64 ino, u64 start,
 		 */
 		ret = btrfs_map_block(fs_info, BTRFS_MAP_READ, logical,
 				      &map_length, &bioc, 0);
-		if (ret) {
-			btrfs_bio_counter_dec(fs_info);
-			bio_put(bio);
-			return -EIO;
-		}
+		if (ret)
+			goto out_counter_dec;
 		ASSERT(bioc->mirror_num == 1);
 	} else {
 		ret = btrfs_map_block(fs_info, BTRFS_MAP_WRITE, logical,
 				      &map_length, &bioc, mirror_num);
-		if (ret) {
-			btrfs_bio_counter_dec(fs_info);
-			bio_put(bio);
-			return -EIO;
-		}
+		if (ret)
+			goto out_counter_dec;
 		BUG_ON(mirror_num != bioc->mirror_num);
 	}
 
 	sector = bioc->stripes[bioc->mirror_num - 1].physical >> 9;
-	bio->bi_iter.bi_sector = sector;
 	dev = bioc->stripes[bioc->mirror_num - 1].dev;
 	btrfs_put_bioc(bioc);
+
 	if (!dev || !dev->bdev ||
 	    !test_bit(BTRFS_DEV_STATE_WRITEABLE, &dev->dev_state)) {
-		btrfs_bio_counter_dec(fs_info);
-		bio_put(bio);
-		return -EIO;
+		ret = -EIO;
+		goto out_counter_dec;
 	}
-	bio_set_dev(bio, dev->bdev);
-	bio->bi_opf = REQ_OP_WRITE | REQ_SYNC;
-	bio_add_page(bio, page, length, pg_offset);
 
-	btrfsic_check_bio(bio);
-	if (submit_bio_wait(bio)) {
+	bio_init(&bio, dev->bdev, &bvec, 1, REQ_OP_WRITE | REQ_SYNC);
+	bio.bi_iter.bi_sector = sector;
+	__bio_add_page(&bio, page, length, pg_offset);
+
+	btrfsic_check_bio(&bio);
+	ret = submit_bio_wait(&bio);
+	if (ret) {
 		/* try to remap that extent elsewhere? */
-		btrfs_bio_counter_dec(fs_info);
-		bio_put(bio);
 		btrfs_dev_stat_inc_and_print(dev, BTRFS_DEV_STAT_WRITE_ERRS);
-		return -EIO;
+		goto out_bio_uninit;
 	}
 
 	btrfs_info_rl_in_rcu(fs_info,
 		"read error corrected: ino %llu off %llu (dev %s sector %llu)",
 				  ino, start,
 				  rcu_str_deref(dev->name), sector);
+	ret = 0;
+
+out_bio_uninit:
+	bio_uninit(&bio);
+out_counter_dec:
 	btrfs_bio_counter_dec(fs_info);
-	bio_put(bio);
-	return 0;
+	return ret;
 }
 
 int btrfs_repair_eb_io_failure(const struct extent_buffer *eb, int mirror_num)
-- 
2.30.2

