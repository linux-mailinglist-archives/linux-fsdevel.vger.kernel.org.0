Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E9185A90C8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Sep 2022 09:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234088AbiIAHnn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Sep 2022 03:43:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233173AbiIAHnC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Sep 2022 03:43:02 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1D261090AC;
        Thu,  1 Sep 2022 00:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=IV+WAuANa6nQ5NvpFQWf0zbFE6Say9xQtaAnlrgmYx0=; b=njEAEUz2E0R7VlYFin50NIWhAf
        xcExK6kpBNt/XyTRY7mLbkIvRNJKbwd0g7X3MAabR9stZqcU7xfUhMv9EX0IOUOFRg9zGaYwMBqt8
        iwlcbPXWYjbHOntlkhvUJWf8+NxrZRPzE2ErYVTohY/DmwhwcH1yZQHtRJK67RIbOQznsU82jzcNq
        wsE/Su55jQ8hP8RYjAJ11qjDxO05CadOvuzPVMcxUpUelDD57vVx+NQA8mlsGhv77PWP0J7tbQ1YB
        xQHeR+ahKk5ZFeeV8J/XjyyMn6I5o1kLBkHPq9Bih2oVFGWc3uIEZI3BZs81Dayw+zmemwGsYMMdh
        IQGkX8Rg==;
Received: from 213-225-1-14.nat.highway.a1.net ([213.225.1.14] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oTeqm-00ANfR-Tl; Thu, 01 Sep 2022 07:42:57 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>, Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 09/17] btrfs: remove stripe boundary calculation for buffered I/O
Date:   Thu,  1 Sep 2022 10:42:08 +0300
Message-Id: <20220901074216.1849941-10-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220901074216.1849941-1-hch@lst.de>
References: <20220901074216.1849941-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Qu Wenruo <wqu@suse.com>

Remove btrfs_bio_ctrl::len_to_stripe_boundary, so that buffer
I/O will no longer limit its bio size according to stripe length
now that btrfs_submit_bio can split bios at stripe boundaries.

Signed-off-by: Qu Wenruo <wqu@suse.com>
[hch: simplify calc_bio_boundaries a little more]
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/extent_io.c | 71 ++++++++++++--------------------------------
 1 file changed, 19 insertions(+), 52 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 4c00bdefe5b45..46a3f0e33fb69 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -145,7 +145,6 @@ struct btrfs_bio_ctrl {
 	struct bio *bio;
 	int mirror_num;
 	enum btrfs_compression_type compress_type;
-	u32 len_to_stripe_boundary;
 	u32 len_to_oe_boundary;
 };
 
@@ -2601,7 +2600,7 @@ static int btrfs_bio_add_page(struct btrfs_bio_ctrl *bio_ctrl,
 
 	ASSERT(bio);
 	/* The limit should be calculated when bio_ctrl->bio is allocated */
-	ASSERT(bio_ctrl->len_to_oe_boundary && bio_ctrl->len_to_stripe_boundary);
+	ASSERT(bio_ctrl->len_to_oe_boundary);
 	if (bio_ctrl->compress_type != compress_type)
 		return 0;
 
@@ -2637,9 +2636,7 @@ static int btrfs_bio_add_page(struct btrfs_bio_ctrl *bio_ctrl,
 	if (!contig)
 		return 0;
 
-	real_size = min(bio_ctrl->len_to_oe_boundary,
-			bio_ctrl->len_to_stripe_boundary) - bio_size;
-	real_size = min(real_size, size);
+	real_size = min(bio_ctrl->len_to_oe_boundary - bio_size, size);
 
 	/*
 	 * If real_size is 0, never call bio_add_*_page(), as even size is 0,
@@ -2656,58 +2653,30 @@ static int btrfs_bio_add_page(struct btrfs_bio_ctrl *bio_ctrl,
 	return ret;
 }
 
-static int calc_bio_boundaries(struct btrfs_bio_ctrl *bio_ctrl,
-			       struct btrfs_inode *inode, u64 file_offset)
+static void calc_bio_boundaries(struct btrfs_bio_ctrl *bio_ctrl,
+			        struct btrfs_inode *inode, u64 file_offset)
 {
-	struct btrfs_fs_info *fs_info = inode->root->fs_info;
-	struct btrfs_io_geometry geom;
 	struct btrfs_ordered_extent *ordered;
-	struct extent_map *em;
 	u64 logical = (bio_ctrl->bio->bi_iter.bi_sector << SECTOR_SHIFT);
-	int ret;
 
 	/*
-	 * Pages for compressed extent are never submitted to disk directly,
-	 * thus it has no real boundary, just set them to U32_MAX.
-	 *
-	 * The split happens for real compressed bio, which happens in
-	 * btrfs_submit_compressed_read/write().
+	 * Limit the extent to the ordered boundary for Zone Append.
+	 * Compressed bios aren't submitted directly, so it doesn't apply
+	 * to them.
 	 */
-	if (bio_ctrl->compress_type != BTRFS_COMPRESS_NONE) {
-		bio_ctrl->len_to_oe_boundary = U32_MAX;
-		bio_ctrl->len_to_stripe_boundary = U32_MAX;
-		return 0;
-	}
-	em = btrfs_get_chunk_map(fs_info, logical, fs_info->sectorsize);
-	if (IS_ERR(em))
-		return PTR_ERR(em);
-	ret = btrfs_get_io_geometry(fs_info, em, btrfs_op(bio_ctrl->bio),
-				    logical, &geom);
-	free_extent_map(em);
-	if (ret < 0) {
-		return ret;
-	}
-	if (geom.len > U32_MAX)
-		bio_ctrl->len_to_stripe_boundary = U32_MAX;
-	else
-		bio_ctrl->len_to_stripe_boundary = (u32)geom.len;
-
-	if (bio_op(bio_ctrl->bio) != REQ_OP_ZONE_APPEND) {
-		bio_ctrl->len_to_oe_boundary = U32_MAX;
-		return 0;
-	}
-
-	/* Ordered extent not yet created, so we're good */
-	ordered = btrfs_lookup_ordered_extent(inode, file_offset);
-	if (!ordered) {
-		bio_ctrl->len_to_oe_boundary = U32_MAX;
-		return 0;
+	if (bio_ctrl->compress_type == BTRFS_COMPRESS_NONE &&
+	    bio_op(bio_ctrl->bio) == REQ_OP_ZONE_APPEND) {
+		ordered = btrfs_lookup_ordered_extent(inode, file_offset);
+		if (ordered) {
+			bio_ctrl->len_to_oe_boundary = min_t(u32, U32_MAX,
+					ordered->disk_bytenr +
+					ordered->disk_num_bytes - logical);
+			btrfs_put_ordered_extent(ordered);
+			return;
+		}
 	}
 
-	bio_ctrl->len_to_oe_boundary = min_t(u32, U32_MAX,
-		ordered->disk_bytenr + ordered->disk_num_bytes - logical);
-	btrfs_put_ordered_extent(ordered);
-	return 0;
+	bio_ctrl->len_to_oe_boundary = U32_MAX;
 }
 
 static int alloc_new_bio(struct btrfs_inode *inode,
@@ -2734,9 +2703,7 @@ static int alloc_new_bio(struct btrfs_inode *inode,
 		bio->bi_iter.bi_sector = (disk_bytenr + offset) >> SECTOR_SHIFT;
 	bio_ctrl->bio = bio;
 	bio_ctrl->compress_type = compress_type;
-	ret = calc_bio_boundaries(bio_ctrl, inode, file_offset);
-	if (ret < 0)
-		goto error;
+	calc_bio_boundaries(bio_ctrl, inode, file_offset);
 
 	if (wbc) {
 		/*
-- 
2.30.2

