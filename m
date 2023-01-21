Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D92E967648A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Jan 2023 07:52:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbjAUGwP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 21 Jan 2023 01:52:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbjAUGvz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 21 Jan 2023 01:51:55 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC60D73141;
        Fri, 20 Jan 2023 22:51:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=vbxlwgoaNKG5zS4zWsaWy+tI8W9EvaxOoopXVg8ytoM=; b=xdMZqyDVYqNQYvh5tNvZdy9Yn0
        hag+wURTpxIhf7/pBflLAzIM9k91SJn3VUnPDNOojDdJqMc6PYGV/zdhNzeqUPpjELl8DEonYK0wh
        +bwSsk+qSBw6Zf31vzbkdFzTt61J33yCz4zmtq0QTtDXzInACCN26zPZ2fVKmKk6koTRgjVeuiCh6
        Djmfyjt6+QM4q5TkPtrwm9TqB4i/3mIQEUbTFSMoIBaTq3SSOqy+rejWpcuHfMUaLJz90NQRRUVuc
        vVovsKLWJczqF5dFA2Zg/FP8DO1lLusXT+9yXwRIj4QJQqi3gZsQExs8HwNxwvbhUCc94iFYe9xUG
        UXq5sdrA==;
Received: from [2001:4bb8:19a:2039:6754:cc81:9ace:36fc] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pJ7j5-00DReC-MH; Sat, 21 Jan 2023 06:51:44 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>, Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 26/34] btrfs: remove stripe boundary calculation for compressed I/O
Date:   Sat, 21 Jan 2023 07:50:23 +0100
Message-Id: <20230121065031.1139353-27-hch@lst.de>
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

From: Qu Wenruo <wqu@suse.com>

Stop looking at the stripe boundary in alloc_compressed_bio() now that
that btrfs_submit_bio can split bios, open code the now trivial code
from alloc_compressed_bio() in btrfs_submit_compressed_read and stop
maintaining the pending_ios count for reads as there is always just
a single bio now.

Signed-off-by: Qu Wenruo <wqu@suse.com>
[hch: remove more cruft in btrfs_submit_compressed_read,
      use btrfs_zoned_get_device in alloc_compressed_bio]
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/compression.c | 131 +++++++++++------------------------------
 1 file changed, 34 insertions(+), 97 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index efa040eb6b19d1..547cb626dfdeb9 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -141,12 +141,15 @@ static int compression_decompress(int type, struct list_head *ws,
 
 static int btrfs_decompress_bio(struct compressed_bio *cb);
 
-static void finish_compressed_bio_read(struct compressed_bio *cb)
+static void end_compressed_bio_read(struct btrfs_bio *bbio)
 {
+	struct compressed_bio *cb = bbio->private;
 	unsigned int index;
 	struct page *page;
 
-	if (cb->status == BLK_STS_OK)
+	if (bbio->bio.bi_status)
+		cb->status = bbio->bio.bi_status;
+	else
 		cb->status = errno_to_blk_status(btrfs_decompress_bio(cb));
 
 	/* Release the compressed pages */
@@ -162,17 +165,6 @@ static void finish_compressed_bio_read(struct compressed_bio *cb)
 	/* Finally free the cb struct */
 	kfree(cb->compressed_pages);
 	kfree(cb);
-}
-
-static void end_compressed_bio_read(struct btrfs_bio *bbio)
-{
-	struct compressed_bio *cb = bbio->private;
-
-	if (bbio->bio.bi_status)
-		cb->status = bbio->bio.bi_status;
-
-	if (refcount_dec_and_test(&cb->pending_ios))
-		finish_compressed_bio_read(cb);
 	bio_put(&bbio->bio);
 }
 
@@ -289,43 +281,30 @@ static void end_compressed_bio_write(struct btrfs_bio *bbio)
  *                      from or written to.
  * @endio_func:         The endio function to call after the IO for compressed data
  *                      is finished.
- * @next_stripe_start:  Return value of logical bytenr of where next stripe starts.
- *                      Let the caller know to only fill the bio up to the stripe
- *                      boundary.
  */
-
-
 static struct bio *alloc_compressed_bio(struct compressed_bio *cb, u64 disk_bytenr,
 					blk_opf_t opf,
-					btrfs_bio_end_io_t endio_func,
-					u64 *next_stripe_start)
+					btrfs_bio_end_io_t endio_func)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(cb->inode->i_sb);
-	struct btrfs_io_geometry geom;
-	struct extent_map *em;
 	struct bio *bio;
-	int ret;
 
 	bio = btrfs_bio_alloc(BIO_MAX_VECS, opf, BTRFS_I(cb->inode), endio_func,
 			      cb);
 	bio->bi_iter.bi_sector = disk_bytenr >> SECTOR_SHIFT;
 
-	em = btrfs_get_chunk_map(fs_info, disk_bytenr, fs_info->sectorsize);
-	if (IS_ERR(em)) {
-		bio_put(bio);
-		return ERR_CAST(em);
-	}
+	if (bio_op(bio) == REQ_OP_ZONE_APPEND) {
+		struct btrfs_fs_info *fs_info = btrfs_sb(cb->inode->i_sb);
+		struct btrfs_device *device;
 
-	if (bio_op(bio) == REQ_OP_ZONE_APPEND)
-		bio_set_dev(bio, em->map_lookup->stripes[0].dev->bdev);
+		device = btrfs_zoned_get_device(fs_info, disk_bytenr,
+						fs_info->sectorsize);
+		if (IS_ERR(device)) {
+			bio_put(bio);
+			return ERR_CAST(device);
+		}
 
-	ret = btrfs_get_io_geometry(fs_info, em, btrfs_op(bio), disk_bytenr, &geom);
-	free_extent_map(em);
-	if (ret < 0) {
-		bio_put(bio);
-		return ERR_PTR(ret);
+		bio_set_dev(bio, device->bdev);
 	}
-	*next_stripe_start = disk_bytenr + geom.len;
 	refcount_inc(&cb->pending_ios);
 	return bio;
 }
@@ -352,7 +331,6 @@ blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
 	struct bio *bio = NULL;
 	struct compressed_bio *cb;
 	u64 cur_disk_bytenr = disk_start;
-	u64 next_stripe_start;
 	blk_status_t ret = BLK_STS_OK;
 	const bool use_append = btrfs_use_zone_append(inode, disk_start);
 	const enum req_op bio_op = REQ_BTRFS_ONE_ORDERED |
@@ -388,8 +366,7 @@ blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
 		/* Allocate new bio if submitted or not yet allocated */
 		if (!bio) {
 			bio = alloc_compressed_bio(cb, cur_disk_bytenr,
-				bio_op | write_flags, end_compressed_bio_write,
-				&next_stripe_start);
+				bio_op | write_flags, end_compressed_bio_write);
 			if (IS_ERR(bio)) {
 				ret = errno_to_blk_status(PTR_ERR(bio));
 				break;
@@ -398,20 +375,12 @@ blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
 			if (blkcg_css)
 				bio->bi_opf |= REQ_CGROUP_PUNT;
 		}
-		/*
-		 * We should never reach next_stripe_start start as we will
-		 * submit comp_bio when reach the boundary immediately.
-		 */
-		ASSERT(cur_disk_bytenr != next_stripe_start);
-
 		/*
 		 * We have various limits on the real read size:
-		 * - stripe boundary
 		 * - page boundary
 		 * - compressed length boundary
 		 */
-		real_size = min_t(u64, U32_MAX, next_stripe_start - cur_disk_bytenr);
-		real_size = min_t(u64, real_size, PAGE_SIZE - offset_in_page(offset));
+		real_size = min_t(u64, U32_MAX, PAGE_SIZE - offset_in_page(offset));
 		real_size = min_t(u64, real_size, compressed_len - offset);
 		ASSERT(IS_ALIGNED(real_size, fs_info->sectorsize));
 
@@ -426,9 +395,6 @@ blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
 			submit = true;
 
 		cur_disk_bytenr += added;
-		/* Reached stripe boundary */
-		if (cur_disk_bytenr == next_stripe_start)
-			submit = true;
 
 		/* Finished the range */
 		if (cur_disk_bytenr == disk_start + compressed_len)
@@ -623,10 +589,9 @@ void btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 	struct extent_map_tree *em_tree;
 	struct compressed_bio *cb;
 	unsigned int compressed_len;
-	struct bio *comp_bio = NULL;
+	struct bio *comp_bio;
 	const u64 disk_bytenr = bio->bi_iter.bi_sector << SECTOR_SHIFT;
 	u64 cur_disk_byte = disk_bytenr;
-	u64 next_stripe_start;
 	u64 file_offset;
 	u64 em_len;
 	u64 em_start;
@@ -693,37 +658,24 @@ void btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 	/* include any pages we added in add_ra-bio_pages */
 	cb->len = bio->bi_iter.bi_size;
 
+	comp_bio = btrfs_bio_alloc(BIO_MAX_VECS, REQ_OP_READ,
+				   BTRFS_I(cb->inode),
+				   end_compressed_bio_read, cb);
+	comp_bio->bi_iter.bi_sector = cur_disk_byte >> SECTOR_SHIFT;
+
 	while (cur_disk_byte < disk_bytenr + compressed_len) {
 		u64 offset = cur_disk_byte - disk_bytenr;
 		unsigned int index = offset >> PAGE_SHIFT;
 		unsigned int real_size;
 		unsigned int added;
 		struct page *page = cb->compressed_pages[index];
-		bool submit = false;
 
-		/* Allocate new bio if submitted or not yet allocated */
-		if (!comp_bio) {
-			comp_bio = alloc_compressed_bio(cb, cur_disk_byte,
-					REQ_OP_READ, end_compressed_bio_read,
-					&next_stripe_start);
-			if (IS_ERR(comp_bio)) {
-				cb->status = errno_to_blk_status(PTR_ERR(comp_bio));
-				break;
-			}
-		}
-		/*
-		 * We should never reach next_stripe_start start as we will
-		 * submit comp_bio when reach the boundary immediately.
-		 */
-		ASSERT(cur_disk_byte != next_stripe_start);
 		/*
 		 * We have various limit on the real read size:
-		 * - stripe boundary
 		 * - page boundary
 		 * - compressed length boundary
 		 */
-		real_size = min_t(u64, U32_MAX, next_stripe_start - cur_disk_byte);
-		real_size = min_t(u64, real_size, PAGE_SIZE - offset_in_page(offset));
+		real_size = min_t(u64, U32_MAX, PAGE_SIZE - offset_in_page(offset));
 		real_size = min_t(u64, real_size, compressed_len - offset);
 		ASSERT(IS_ALIGNED(real_size, fs_info->sectorsize));
 
@@ -734,35 +686,20 @@ void btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 		 */
 		ASSERT(added == real_size);
 		cur_disk_byte += added;
-
-		/* Reached stripe boundary, need to submit */
-		if (cur_disk_byte == next_stripe_start)
-			submit = true;
-
-		/* Has finished the range, need to submit */
-		if (cur_disk_byte == disk_bytenr + compressed_len)
-			submit = true;
-
-		if (submit) {
-			/*
-			 * Save the initial offset of this chunk, as there
-			 * is no direct correlation between compressed pages and
-			 * the original file offset.  The field is only used for
-			 * priting error messages.
-			 */
-			btrfs_bio(comp_bio)->file_offset = file_offset;
-
-			ASSERT(comp_bio->bi_iter.bi_size);
-			btrfs_submit_bio(fs_info, comp_bio, mirror_num);
-			comp_bio = NULL;
-		}
 	}
 
 	if (memstall)
 		psi_memstall_leave(&pflags);
 
-	if (refcount_dec_and_test(&cb->pending_ios))
-		finish_compressed_bio_read(cb);
+	/*
+	 * Just stash the initial offset of this chunk, as there is no direct
+	 * correlation between compressed pages and the original file offset.
+	 * The field is only used for priting error messages anyway.
+	 */
+	btrfs_bio(comp_bio)->file_offset = file_offset;
+
+	ASSERT(comp_bio->bi_iter.bi_size);
+	btrfs_submit_bio(fs_info, comp_bio, mirror_num);
 	return;
 
 fail:
-- 
2.39.0

