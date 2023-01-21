Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B629C6764A0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Jan 2023 07:54:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbjAUGyE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 21 Jan 2023 01:54:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbjAUGwN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 21 Jan 2023 01:52:13 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1492F60CB6;
        Fri, 20 Jan 2023 22:52:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=sp56lRb1+bnPW2yUU/NYuWtzot417xsmogBRuxPFC9c=; b=yA9AhiUHWRRLzJfW+1P8hsPU9u
        WgTjhGsucKPl6B0G9RLUPY1f0wwx+/+3enrrEbFqawVfb4RfXL8eJsN0kyba5OQM/oGXCBM3BqEOi
        82X5F+lEsI9hWMTZmMb/Nyxuv4sNJYdGb52WQRxA07Z+O4anSbHxpZG58inqfOUXCFm0Iufjq9ND8
        E0rTNz+CIQsmmm6S1xl3aIBvg82Yq0qHgWurUo5/bEHwjZz9NlXNzxVX/C8a/O+ysgXaOFicsfCGB
        aTYu2BMy20BeewaH3dGgJoS7q2PZtPpjZT/Jybj47gxoCFfGSOtoGjAuKZbD7gjwSDBMkQfcyQgd0
        65Veoxfw==;
Received: from [2001:4bb8:19a:2039:6754:cc81:9ace:36fc] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pJ7jN-00DRkc-8D; Sat, 21 Jan 2023 06:52:01 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>, Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 33/34] btrfs: split zone append bios in btrfs_submit_bio
Date:   Sat, 21 Jan 2023 07:50:30 +0100
Message-Id: <20230121065031.1139353-34-hch@lst.de>
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

The current btrfs zoned device support is a little cumbersome in the data
I/O path as it requires the callers to not issue I/O larger than the
supported ZONE_APPEND size of the underlying device.  This leads to a lot
of extra accounting.  Instead change btrfs_submit_bio so that it can take
write bios of arbitrary size and form from the upper layers, and just
split them internally to the ZONE_APPEND queue limits.  Then remove all
the upper layer warts catering to limited write sized on zoned devices,
including the extra refcount in the compressed_bio.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/bio.c         |  44 +++++++++-------
 fs/btrfs/compression.c | 112 ++++++++---------------------------------
 fs/btrfs/compression.h |   3 --
 fs/btrfs/extent_io.c   |  72 ++++++--------------------
 fs/btrfs/inode.c       |   4 --
 fs/btrfs/zoned.c       |  20 --------
 fs/btrfs/zoned.h       |   9 ----
 7 files changed, 64 insertions(+), 200 deletions(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index 38a2d2bb5c2fa9..e6fe1b7dbc504c 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -59,13 +59,22 @@ struct bio *btrfs_bio_alloc(unsigned int nr_vecs, blk_opf_t opf,
 	return bio;
 }
 
-static struct bio *btrfs_split_bio(struct bio *orig, u64 map_length)
+static struct bio *btrfs_split_bio(struct btrfs_fs_info *fs_info,
+				   struct bio *orig, u64 map_length,
+				   bool use_append)
 {
 	struct btrfs_bio *orig_bbio = btrfs_bio(orig);
 	struct bio *bio;
 
-	bio = bio_split(orig, map_length >> SECTOR_SHIFT, GFP_NOFS,
-			&btrfs_clone_bioset);
+	if (use_append) {
+		unsigned int nr_segs;
+
+		bio = bio_split_rw(orig, &fs_info->limits, &nr_segs,
+				   &btrfs_clone_bioset, map_length);
+	} else {
+		bio = bio_split(orig, map_length >> SECTOR_SHIFT, GFP_NOFS,
+				&btrfs_clone_bioset);
+	}
 	btrfs_bio_init(btrfs_bio(bio), orig_bbio->inode, NULL, orig_bbio);
 
 	btrfs_bio(bio)->file_offset = orig_bbio->file_offset;
@@ -399,16 +408,10 @@ static void btrfs_submit_dev_bio(struct btrfs_device *dev, struct bio *bio)
 	 */
 	if (bio_op(bio) == REQ_OP_ZONE_APPEND) {
 		u64 physical = bio->bi_iter.bi_sector << SECTOR_SHIFT;
+		u64 zone_start = round_down(physical, dev->fs_info->zone_size);
 
-		if (btrfs_dev_is_sequential(dev, physical)) {
-			u64 zone_start = round_down(physical,
-						    dev->fs_info->zone_size);
-
-			bio->bi_iter.bi_sector = zone_start >> SECTOR_SHIFT;
-		} else {
-			bio->bi_opf &= ~REQ_OP_ZONE_APPEND;
-			bio->bi_opf |= REQ_OP_WRITE;
-		}
+		ASSERT(btrfs_dev_is_sequential(dev, physical));
+		bio->bi_iter.bi_sector = zone_start >> SECTOR_SHIFT;
 	}
 	btrfs_debug_in_rcu(dev->fs_info,
 	"%s: rw %d 0x%x, sector=%llu, dev=%lu (%s id %llu), size=%u",
@@ -606,10 +609,12 @@ static bool btrfs_wq_submit_bio(struct btrfs_bio *bbio,
 static bool btrfs_submit_chunk(struct bio *bio, int mirror_num)
 {
 	struct btrfs_bio *bbio = btrfs_bio(bio);
-	struct btrfs_fs_info *fs_info = bbio->inode->root->fs_info;
+	struct btrfs_inode *inode = bbio->inode;
+	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	u64 logical = bio->bi_iter.bi_sector << 9;
 	u64 length = bio->bi_iter.bi_size;
 	u64 map_length = length;
+	bool use_append = btrfs_use_zone_append(inode, logical);
 	struct btrfs_io_context *bioc = NULL;
 	struct btrfs_io_stripe smap;
 	blk_status_t ret;
@@ -624,8 +629,11 @@ static bool btrfs_submit_chunk(struct bio *bio, int mirror_num)
 	}
 
 	map_length = min(map_length, length);
+	if (use_append)
+		map_length = min(map_length, fs_info->max_zone_append_size);
+
 	if (map_length < length) {
-		bio = btrfs_split_bio(bio, map_length);
+		bio = btrfs_split_bio(fs_info, bio, map_length, use_append);
 		bbio = btrfs_bio(bio);
 	}
 
@@ -641,7 +649,9 @@ static bool btrfs_submit_chunk(struct bio *bio, int mirror_num)
 	}
 
 	if (btrfs_op(bio) == BTRFS_MAP_WRITE) {
-		if (bio_op(bio) == REQ_OP_ZONE_APPEND) {
+		if (use_append) {
+			bio->bi_opf &= ~REQ_OP_WRITE;
+			bio->bi_opf |= REQ_OP_ZONE_APPEND;
 			ret = btrfs_extract_ordered_extent(btrfs_bio(bio));
 			if (ret)
 				goto fail_put_bio;
@@ -651,9 +661,9 @@ static bool btrfs_submit_chunk(struct bio *bio, int mirror_num)
 		 * Csum items for reloc roots have already been cloned at this
 		 * point, so they are handled as part of the no-checksum case.
 		 */
-		if (!(bbio->inode->flags & BTRFS_INODE_NODATASUM) &&
+		if (!(inode->flags & BTRFS_INODE_NODATASUM) &&
 		    !test_bit(BTRFS_FS_STATE_NO_CSUMS, &fs_info->fs_state) &&
-		    !btrfs_is_data_reloc_root(bbio->inode->root)) {
+		    !btrfs_is_data_reloc_root(inode->root)) {
 			if (should_async_write(bbio) &&
 			    btrfs_wq_submit_bio(bbio, bioc, &smap, mirror_num))
 				goto done;
diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 41c1f8937bf5d6..361ed31db3a1fe 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -258,57 +258,14 @@ static void btrfs_finish_compressed_write_work(struct work_struct *work)
 static void end_compressed_bio_write(struct btrfs_bio *bbio)
 {
 	struct compressed_bio *cb = bbio->private;
+	struct btrfs_fs_info *fs_info = btrfs_sb(cb->inode->i_sb);
 
-	if (bbio->bio.bi_status)
-		cb->status = bbio->bio.bi_status;
-
-	if (refcount_dec_and_test(&cb->pending_ios)) {
-		struct btrfs_fs_info *fs_info = btrfs_sb(cb->inode->i_sb);
+	cb->status = bbio->bio.bi_status;
+	queue_work(fs_info->compressed_write_workers, &cb->write_end_work);
 
-		queue_work(fs_info->compressed_write_workers, &cb->write_end_work);
-	}
 	bio_put(&bbio->bio);
 }
 
-/*
- * Allocate a compressed_bio, which will be used to read/write on-disk
- * (aka, compressed) * data.
- *
- * @cb:                 The compressed_bio structure, which records all the needed
- *                      information to bind the compressed data to the uncompressed
- *                      page cache.
- * @disk_byten:         The logical bytenr where the compressed data will be read
- *                      from or written to.
- * @endio_func:         The endio function to call after the IO for compressed data
- *                      is finished.
- */
-static struct bio *alloc_compressed_bio(struct compressed_bio *cb, u64 disk_bytenr,
-					blk_opf_t opf,
-					btrfs_bio_end_io_t endio_func)
-{
-	struct bio *bio;
-
-	bio = btrfs_bio_alloc(BIO_MAX_VECS, opf, BTRFS_I(cb->inode), endio_func,
-			      cb);
-	bio->bi_iter.bi_sector = disk_bytenr >> SECTOR_SHIFT;
-
-	if (bio_op(bio) == REQ_OP_ZONE_APPEND) {
-		struct btrfs_fs_info *fs_info = btrfs_sb(cb->inode->i_sb);
-		struct btrfs_device *device;
-
-		device = btrfs_zoned_get_device(fs_info, disk_bytenr,
-						fs_info->sectorsize);
-		if (IS_ERR(device)) {
-			bio_put(bio);
-			return ERR_CAST(device);
-		}
-
-		bio_set_dev(bio, device->bdev);
-	}
-	refcount_inc(&cb->pending_ios);
-	return bio;
-}
-
 /*
  * worker function to build and submit bios for previously compressed pages.
  * The corresponding pages in the inode should be marked for writeback
@@ -332,16 +289,12 @@ blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
 	struct compressed_bio *cb;
 	u64 cur_disk_bytenr = disk_start;
 	blk_status_t ret = BLK_STS_OK;
-	const bool use_append = btrfs_use_zone_append(inode, disk_start);
-	const enum req_op bio_op = REQ_BTRFS_ONE_ORDERED |
-		(use_append ? REQ_OP_ZONE_APPEND : REQ_OP_WRITE);
 
 	ASSERT(IS_ALIGNED(start, fs_info->sectorsize) &&
 	       IS_ALIGNED(len, fs_info->sectorsize));
 	cb = kmalloc(sizeof(struct compressed_bio), GFP_NOFS);
 	if (!cb)
 		return BLK_STS_RESOURCE;
-	refcount_set(&cb->pending_ios, 1);
 	cb->status = BLK_STS_OK;
 	cb->inode = &inode->vfs_inode;
 	cb->start = start;
@@ -352,8 +305,16 @@ blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
 	INIT_WORK(&cb->write_end_work, btrfs_finish_compressed_write_work);
 	cb->nr_pages = nr_pages;
 
-	if (blkcg_css)
+	if (blkcg_css) {
 		kthread_associate_blkcg(blkcg_css);
+		write_flags |= REQ_CGROUP_PUNT;
+	}
+
+	write_flags |= REQ_BTRFS_ONE_ORDERED;
+	bio = btrfs_bio_alloc(BIO_MAX_VECS, REQ_OP_WRITE | write_flags,
+			      BTRFS_I(cb->inode), end_compressed_bio_write, cb);
+	bio->bi_iter.bi_sector = cur_disk_bytenr >> SECTOR_SHIFT;
+	btrfs_bio(bio)->file_offset = start;
 
 	while (cur_disk_bytenr < disk_start + compressed_len) {
 		u64 offset = cur_disk_bytenr - disk_start;
@@ -361,20 +322,7 @@ blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
 		unsigned int real_size;
 		unsigned int added;
 		struct page *page = compressed_pages[index];
-		bool submit = false;
-
-		/* Allocate new bio if submitted or not yet allocated */
-		if (!bio) {
-			bio = alloc_compressed_bio(cb, cur_disk_bytenr,
-				bio_op | write_flags, end_compressed_bio_write);
-			if (IS_ERR(bio)) {
-				ret = errno_to_blk_status(PTR_ERR(bio));
-				break;
-			}
-			btrfs_bio(bio)->file_offset = start;
-			if (blkcg_css)
-				bio->bi_opf |= REQ_CGROUP_PUNT;
-		}
+
 		/*
 		 * We have various limits on the real read size:
 		 * - page boundary
@@ -384,35 +332,20 @@ blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
 		real_size = min_t(u64, real_size, compressed_len - offset);
 		ASSERT(IS_ALIGNED(real_size, fs_info->sectorsize));
 
-		if (use_append)
-			added = bio_add_zone_append_page(bio, page, real_size,
-					offset_in_page(offset));
-		else
-			added = bio_add_page(bio, page, real_size,
-					offset_in_page(offset));
-		/* Reached zoned boundary */
-		if (added == 0)
-			submit = true;
-
+		added = bio_add_page(bio, page, real_size, offset_in_page(offset));
+		/*
+		 * Maximum compressed extent is smaller than bio size limit,
+		 * thus bio_add_page() should always success.
+		 */
+		ASSERT(added == real_size);
 		cur_disk_bytenr += added;
-
-		/* Finished the range */
-		if (cur_disk_bytenr == disk_start + compressed_len)
-			submit = true;
-
-		if (submit) {
-			ASSERT(bio->bi_iter.bi_size);
-			btrfs_submit_bio(bio, 0);
-			bio = NULL;
-		}
-		cond_resched();
 	}
 
+	/* Finished the range */
+	ASSERT(bio->bi_iter.bi_size);
+	btrfs_submit_bio(bio, 0);
 	if (blkcg_css)
 		kthread_associate_blkcg(NULL);
-
-	if (refcount_dec_and_test(&cb->pending_ios))
-		finish_compressed_bio_write(cb);
 	return ret;
 }
 
@@ -624,7 +557,6 @@ void btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 		goto out;
 	}
 
-	refcount_set(&cb->pending_ios, 1);
 	cb->status = BLK_STS_OK;
 	cb->inode = inode;
 
diff --git a/fs/btrfs/compression.h b/fs/btrfs/compression.h
index 6209d40a1e08e3..a5e3377db9adc9 100644
--- a/fs/btrfs/compression.h
+++ b/fs/btrfs/compression.h
@@ -31,9 +31,6 @@ static_assert((BTRFS_MAX_COMPRESSED % PAGE_SIZE) == 0);
 #define	BTRFS_ZLIB_DEFAULT_LEVEL		3
 
 struct compressed_bio {
-	/* Number of outstanding bios */
-	refcount_t pending_ios;
-
 	/* Number of compressed pages in the array */
 	unsigned int nr_pages;
 
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 66134bb75f8941..477be146b981ec 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -897,7 +897,6 @@ static int btrfs_bio_add_page(struct btrfs_bio_ctrl *bio_ctrl,
 	u32 real_size;
 	const sector_t sector = disk_bytenr >> SECTOR_SHIFT;
 	bool contig = false;
-	int ret;
 
 	ASSERT(bio);
 	/* The limit should be calculated when bio_ctrl->bio is allocated */
@@ -946,12 +945,7 @@ static int btrfs_bio_add_page(struct btrfs_bio_ctrl *bio_ctrl,
 	if (real_size == 0)
 		return 0;
 
-	if (bio_op(bio) == REQ_OP_ZONE_APPEND)
-		ret = bio_add_zone_append_page(bio, page, real_size, pg_offset);
-	else
-		ret = bio_add_page(bio, page, real_size, pg_offset);
-
-	return ret;
+	return bio_add_page(bio, page, real_size, pg_offset);
 }
 
 static void calc_bio_boundaries(struct btrfs_bio_ctrl *bio_ctrl,
@@ -966,7 +960,7 @@ static void calc_bio_boundaries(struct btrfs_bio_ctrl *bio_ctrl,
 	 * to them.
 	 */
 	if (bio_ctrl->compress_type == BTRFS_COMPRESS_NONE &&
-	    bio_op(bio_ctrl->bio) == REQ_OP_ZONE_APPEND) {
+	    btrfs_use_zone_append(inode, logical)) {
 		ordered = btrfs_lookup_ordered_extent(inode, file_offset);
 		if (ordered) {
 			bio_ctrl->len_to_oe_boundary = min_t(u32, U32_MAX,
@@ -980,16 +974,14 @@ static void calc_bio_boundaries(struct btrfs_bio_ctrl *bio_ctrl,
 	bio_ctrl->len_to_oe_boundary = U32_MAX;
 }
 
-static int alloc_new_bio(struct btrfs_inode *inode,
-			 struct btrfs_bio_ctrl *bio_ctrl,
-			 struct writeback_control *wbc,
-			 blk_opf_t opf,
-			 u64 disk_bytenr, u32 offset, u64 file_offset,
-			 enum btrfs_compression_type compress_type)
+static void alloc_new_bio(struct btrfs_inode *inode,
+			  struct btrfs_bio_ctrl *bio_ctrl,
+			  struct writeback_control *wbc, blk_opf_t opf,
+			  u64 disk_bytenr, u32 offset, u64 file_offset,
+			  enum btrfs_compression_type compress_type)
 {
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	struct bio *bio;
-	int ret;
 
 	bio = btrfs_bio_alloc(BIO_MAX_VECS, opf, inode, bio_ctrl->end_io_func,
 			      NULL);
@@ -1007,40 +999,14 @@ static int alloc_new_bio(struct btrfs_inode *inode,
 
 	if (wbc) {
 		/*
-		 * For Zone append we need the correct block_device that we are
-		 * going to write to set in the bio to be able to respect the
-		 * hardware limitation.  Look it up here:
+		 * Pick the last added device to support cgroup writeback.  For
+		 * multi-device file systems this means blk-cgroup policies have
+		 * to always be set on the last added/replaced device.
+		 * This is a bit odd but has been like that for a long time.
 		 */
-		if (bio_op(bio) == REQ_OP_ZONE_APPEND) {
-			struct btrfs_device *dev;
-
-			dev = btrfs_zoned_get_device(fs_info, disk_bytenr,
-						     fs_info->sectorsize);
-			if (IS_ERR(dev)) {
-				ret = PTR_ERR(dev);
-				goto error;
-			}
-
-			bio_set_dev(bio, dev->bdev);
-		} else {
-			/*
-			 * Otherwise pick the last added device to support
-			 * cgroup writeback.  For multi-device file systems this
-			 * means blk-cgroup policies have to always be set on the
-			 * last added/replaced device.  This is a bit odd but has
-			 * been like that for a long time.
-			 */
-			bio_set_dev(bio, fs_info->fs_devices->latest_dev->bdev);
-		}
+		bio_set_dev(bio, fs_info->fs_devices->latest_dev->bdev);
 		wbc_init_bio(wbc, bio);
-	} else {
-		ASSERT(bio_op(bio) != REQ_OP_ZONE_APPEND);
 	}
-	return 0;
-error:
-	bio_ctrl->bio = NULL;
-	btrfs_bio_end_io(btrfs_bio(bio), errno_to_blk_status(ret));
-	return ret;
 }
 
 /*
@@ -1066,7 +1032,6 @@ static int submit_extent_page(blk_opf_t opf,
 			      enum btrfs_compression_type compress_type,
 			      bool force_bio_submit)
 {
-	int ret = 0;
 	struct btrfs_inode *inode = BTRFS_I(page->mapping->host);
 	unsigned int cur = pg_offset;
 
@@ -1086,12 +1051,9 @@ static int submit_extent_page(blk_opf_t opf,
 
 		/* Allocate new bio if needed */
 		if (!bio_ctrl->bio) {
-			ret = alloc_new_bio(inode, bio_ctrl, wbc, opf,
-					    disk_bytenr, offset,
-					    page_offset(page) + cur,
-					    compress_type);
-			if (ret < 0)
-				return ret;
+			alloc_new_bio(inode, bio_ctrl, wbc, opf, disk_bytenr,
+				      offset, page_offset(page) + cur,
+				      compress_type);
 		}
 		/*
 		 * We must go through btrfs_bio_add_page() to ensure each
@@ -1648,10 +1610,6 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
 		 * find_next_dirty_byte() are all exclusive
 		 */
 		iosize = min(min(em_end, end + 1), dirty_range_end) - cur;
-
-		if (btrfs_use_zone_append(inode, em->block_start))
-			op = REQ_OP_ZONE_APPEND;
-
 		free_extent_map(em);
 		em = NULL;
 
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 383219f51d86ab..36ae541ad51baa 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7678,10 +7678,6 @@ static int btrfs_dio_iomap_begin(struct inode *inode, loff_t start,
 	iomap->offset = start;
 	iomap->bdev = fs_info->fs_devices->latest_dev->bdev;
 	iomap->length = len;
-
-	if (write && btrfs_use_zone_append(BTRFS_I(inode), em->block_start))
-		iomap->flags |= IOMAP_F_ZONE_APPEND;
-
 	free_extent_map(em);
 
 	return 0;
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index d6a8f8a07d7581..d862477f79f36d 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1845,26 +1845,6 @@ int btrfs_sync_zone_write_pointer(struct btrfs_device *tgt_dev, u64 logical,
 	return btrfs_zoned_issue_zeroout(tgt_dev, physical_pos, length);
 }
 
-struct btrfs_device *btrfs_zoned_get_device(struct btrfs_fs_info *fs_info,
-					    u64 logical, u64 length)
-{
-	struct btrfs_device *device;
-	struct extent_map *em;
-	struct map_lookup *map;
-
-	em = btrfs_get_chunk_map(fs_info, logical, length);
-	if (IS_ERR(em))
-		return ERR_CAST(em);
-
-	map = em->map_lookup;
-	/* We only support single profile for now */
-	device = map->stripes[0].dev;
-
-	free_extent_map(em);
-
-	return device;
-}
-
 /*
  * Activate block group and underlying device zones
  *
diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
index f25f332b772859..157f46132c56e0 100644
--- a/fs/btrfs/zoned.h
+++ b/fs/btrfs/zoned.h
@@ -66,8 +66,6 @@ void btrfs_revert_meta_write_pointer(struct btrfs_block_group *cache,
 int btrfs_zoned_issue_zeroout(struct btrfs_device *device, u64 physical, u64 length);
 int btrfs_sync_zone_write_pointer(struct btrfs_device *tgt_dev, u64 logical,
 				  u64 physical_start, u64 physical_pos);
-struct btrfs_device *btrfs_zoned_get_device(struct btrfs_fs_info *fs_info,
-					    u64 logical, u64 length);
 bool btrfs_zone_activate(struct btrfs_block_group *block_group);
 int btrfs_zone_finish(struct btrfs_block_group *block_group);
 bool btrfs_can_activate_zone(struct btrfs_fs_devices *fs_devices, u64 flags);
@@ -221,13 +219,6 @@ static inline int btrfs_sync_zone_write_pointer(struct btrfs_device *tgt_dev,
 	return -EOPNOTSUPP;
 }
 
-static inline struct btrfs_device *btrfs_zoned_get_device(
-						  struct btrfs_fs_info *fs_info,
-						  u64 logical, u64 length)
-{
-	return ERR_PTR(-EOPNOTSUPP);
-}
-
 static inline bool btrfs_zone_activate(struct btrfs_block_group *block_group)
 {
 	return true;
-- 
2.39.0

