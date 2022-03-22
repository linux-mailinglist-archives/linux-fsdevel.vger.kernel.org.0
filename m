Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD3C4E43A3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Mar 2022 16:58:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238884AbiCVP7V (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Mar 2022 11:59:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238880AbiCVP6y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Mar 2022 11:58:54 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AAAF6F4BE;
        Tue, 22 Mar 2022 08:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=gZN45xVE4Du0iLFZguxxdeln+25QsSKCAt3pa1usjYg=; b=ES+zSNPN7pwlUvOcdTgkmwlcIG
        Ab0UlJrr2cM5937B7ziHF1op4w5bYeDJ6YmRDk4/F5PSbg04PDItewLvC/mvY+7qwi7MhoFfN/PmE
        8ESKvTbuOeOFuCk7hiWr5XYrUq7EkbLIkC055Huc4RxvUEDVRr1lXfMKln9H4glLYiL2GYuCbJsmi
        AEvvppzHq+wXMuDryYcuYOpjbRduEkL4Ckj2PdztcWW3ojBonQPIkxuQmqYLMFbiLwm6cdffxiAJs
        omwMIZng9MNyepty7vrH3CYxTKq0+KpCmefa5Q+b2Nu43C/QbdYZ9UXSB+24RqdAndpyQ7rK6uPKi
        dUa1v7hQ==;
Received: from [2001:4bb8:19a:b822:6444:5366:9486:4da] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nWgsr-00Baza-22; Tue, 22 Mar 2022 15:57:21 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>
Cc:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 28/40] btrfs: do not allocate a btrfs_io_context in btrfs_map_bio
Date:   Tue, 22 Mar 2022 16:55:54 +0100
Message-Id: <20220322155606.1267165-29-hch@lst.de>
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

There is very little of the I/O context that is actually needed for
issuing a bio.  Add the few needed fields to struct btrfs_bio instead.

The stripes array is still allocated on demand when more than a single
I/O is needed, but for single leg I/O (e.g. all reads) there is no
additional memory allocation now.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/volumes.c | 147 ++++++++++++++++++++++++++++-----------------
 fs/btrfs/volumes.h |  20 ++++--
 2 files changed, 107 insertions(+), 60 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index cc9e2565e4b64..cec3f6b9f5c21 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -253,10 +253,9 @@ static int btrfs_relocate_sys_chunks(struct btrfs_fs_info *fs_info);
 static void btrfs_dev_stat_print_on_error(struct btrfs_device *dev);
 static void btrfs_dev_stat_print_on_load(struct btrfs_device *device);
 static int __btrfs_map_block(struct btrfs_fs_info *fs_info,
-			     enum btrfs_map_op op,
-			     u64 logical, u64 *length,
-			     struct btrfs_io_context **bioc_ret,
-			     int mirror_num, int need_raid_map);
+		enum btrfs_map_op op, u64 logical, u64 *length,
+		struct btrfs_io_context **bioc_ret, struct btrfs_bio *bbio,
+		int mirror_num, int need_raid_map);
 
 /*
  * Device locking
@@ -5926,7 +5925,6 @@ static struct btrfs_io_context *alloc_btrfs_io_context(struct btrfs_fs_info *fs_
 		sizeof(u64) * (total_stripes),
 		GFP_NOFS|__GFP_NOFAIL);
 
-	atomic_set(&bioc->error, 0);
 	refcount_set(&bioc->refs, 1);
 
 	bioc->fs_info = fs_info;
@@ -6128,7 +6126,7 @@ static int get_extra_mirror_from_replace(struct btrfs_fs_info *fs_info,
 	int ret = 0;
 
 	ret = __btrfs_map_block(fs_info, BTRFS_MAP_GET_READ_MIRRORS,
-				logical, &length, &bioc, 0, 0);
+				logical, &length, &bioc, NULL, 0, 0);
 	if (ret) {
 		ASSERT(bioc == NULL);
 		return ret;
@@ -6397,10 +6395,9 @@ int btrfs_get_io_geometry(struct btrfs_fs_info *fs_info, struct extent_map *em,
 }
 
 static int __btrfs_map_block(struct btrfs_fs_info *fs_info,
-			     enum btrfs_map_op op,
-			     u64 logical, u64 *length,
-			     struct btrfs_io_context **bioc_ret,
-			     int mirror_num, int need_raid_map)
+		enum btrfs_map_op op, u64 logical, u64 *length,
+		struct btrfs_io_context **bioc_ret, struct btrfs_bio *bbio,
+		int mirror_num, int need_raid_map)
 {
 	struct extent_map *em;
 	struct map_lookup *map;
@@ -6566,6 +6563,48 @@ static int __btrfs_map_block(struct btrfs_fs_info *fs_info,
 		tgtdev_indexes = num_stripes;
 	}
 
+	if (need_full_stripe(op))
+		max_errors = btrfs_chunk_max_errors(map);
+
+	if (bbio && !need_raid_map) {
+		int replacement_idx = num_stripes;
+
+		if (num_alloc_stripes > 1) {
+			bbio->stripes = kmalloc_array(num_alloc_stripes,
+					sizeof(*bbio->stripes),
+					GFP_NOFS | __GFP_NOFAIL);
+		} else {
+			bbio->stripes = &bbio->__stripe;
+		}
+
+		atomic_set(&bbio->stripes_pending, num_stripes);
+		for (i = 0; i < num_stripes; i++) {
+			struct btrfs_bio_stripe *s = &bbio->stripes[i];
+
+			s->physical = map->stripes[stripe_index].physical +
+				stripe_offset + stripe_nr * map->stripe_len;
+			s->dev = map->stripes[stripe_index].dev;
+			stripe_index++;
+
+			if (op == BTRFS_MAP_WRITE && dev_replace_is_ongoing &&
+			    dev_replace->tgtdev &&
+			    !is_block_group_to_copy(fs_info, logical) &&
+			    s->dev->devid == dev_replace->srcdev->devid) {
+				struct btrfs_bio_stripe *r =
+					&bbio->stripes[replacement_idx++];
+
+				r->physical = s->physical;
+				r->dev = dev_replace->tgtdev;
+				max_errors++;
+				atomic_inc(&bbio->stripes_pending);
+			}
+		}
+
+		bbio->max_errors = max_errors;
+		bbio->mirror_num = mirror_num;
+		goto out;
+	}
+
 	bioc = alloc_btrfs_io_context(fs_info, num_alloc_stripes, tgtdev_indexes);
 	if (!bioc) {
 		ret = -ENOMEM;
@@ -6601,9 +6640,6 @@ static int __btrfs_map_block(struct btrfs_fs_info *fs_info,
 		sort_parity_stripes(bioc, num_stripes);
 	}
 
-	if (need_full_stripe(op))
-		max_errors = btrfs_chunk_max_errors(map);
-
 	if (dev_replace_is_ongoing && dev_replace->tgtdev != NULL &&
 	    need_full_stripe(op)) {
 		handle_ops_on_dev_replace(op, &bioc, dev_replace, logical,
@@ -6646,7 +6682,7 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 						     length, bioc_ret);
 
 	return __btrfs_map_block(fs_info, op, logical, length, bioc_ret,
-				 mirror_num, 0);
+				 NULL, mirror_num, 0);
 }
 
 /* For Scrub/replace */
@@ -6654,14 +6690,15 @@ int btrfs_map_sblock(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 		     u64 logical, u64 *length,
 		     struct btrfs_io_context **bioc_ret)
 {
-	return __btrfs_map_block(fs_info, op, logical, length, bioc_ret, 0, 1);
+	return __btrfs_map_block(fs_info, op, logical, length, bioc_ret, NULL,
+				 0, 1);
 }
 
-static struct btrfs_workqueue *btrfs_end_io_wq(struct btrfs_io_context *bioc)
+static struct btrfs_workqueue *btrfs_end_io_wq(struct btrfs_bio *bbio)
 {
-	struct btrfs_fs_info *fs_info = bioc->fs_info;
+	struct btrfs_fs_info *fs_info = btrfs_sb(bbio->inode->i_sb);
 
-	switch (btrfs_bio(bioc->orig_bio)->end_io_type) {
+	switch (bbio->end_io_type) {
 	case BTRFS_ENDIO_WQ_DATA_READ:
 		return fs_info->endio_workers;
 	case BTRFS_ENDIO_WQ_DATA_WRITE:
@@ -6682,21 +6719,22 @@ static void btrfs_end_bio_work(struct btrfs_work *work)
 	bio_endio(&bbio->bio);
 }
 
-static void btrfs_end_bioc(struct btrfs_io_context *bioc, bool async)
+static void btrfs_end_bbio(struct btrfs_bio *bbio, bool async)
 {
-	struct btrfs_workqueue *wq = async ? btrfs_end_io_wq(bioc) : NULL;
-	struct bio *bio = bioc->orig_bio;
-	struct btrfs_bio *bbio = btrfs_bio(bio);
+	struct btrfs_workqueue *wq = async ? btrfs_end_io_wq(bbio) : NULL;
+	struct bio *bio = &bbio->bio;
 
-	bbio->mirror_num = bioc->mirror_num;
-	bio->bi_private = bioc->private;
-	bio->bi_end_io = bioc->end_io;
+	bio->bi_private = bbio->private;
+	bio->bi_end_io = bbio->end_io;
+
+	if (bbio->stripes != &bbio->__stripe)
+		kfree(bbio->stripes);
 
 	/*
 	 * Only send an error to the higher layers if it is beyond the tolerance
 	 * threshold.
 	 */
-	if (atomic_read(&bioc->error) > bioc->max_errors)
+	if (atomic_read(&bbio->error) > bbio->max_errors)
 		bio->bi_status = BLK_STS_IOERR;
 	else
 		bio->bi_status = BLK_STS_OK;
@@ -6707,16 +6745,14 @@ static void btrfs_end_bioc(struct btrfs_io_context *bioc, bool async)
 	} else {
 		bio_endio(bio);
 	}
-
-	btrfs_put_bioc(bioc);
 }
 
 static void btrfs_end_bio(struct bio *bio)
 {
-	struct btrfs_io_context *bioc = bio->bi_private;
+	struct btrfs_bio *bbio = bio->bi_private;
 
 	if (bio->bi_status) {
-		atomic_inc(&bioc->error);
+		atomic_inc(&bbio->error);
 		if (bio->bi_status == BLK_STS_IOERR ||
 		    bio->bi_status == BLK_STS_TARGET) {
 			struct btrfs_device *dev = btrfs_bio(bio)->device;
@@ -6734,40 +6770,39 @@ static void btrfs_end_bio(struct bio *bio)
 		}
 	}
 
-	if (bio != bioc->orig_bio)
+	if (bio != &bbio->bio)
 		bio_put(bio);
 
-	btrfs_bio_counter_dec(bioc->fs_info);
-	if (atomic_dec_and_test(&bioc->stripes_pending))
-		btrfs_end_bioc(bioc, true);
+	btrfs_bio_counter_dec(btrfs_sb(bbio->inode->i_sb));
+	if (atomic_dec_and_test(&bbio->stripes_pending))
+		btrfs_end_bbio(bbio, true);
 }
 
-static void submit_stripe_bio(struct btrfs_io_context *bioc,
-		struct bio *orig_bio, int dev_nr, bool clone)
+static void submit_stripe_bio(struct btrfs_bio *bbio, int dev_nr, bool clone)
 {
-	struct btrfs_fs_info *fs_info = bioc->fs_info;
-	struct btrfs_device *dev = bioc->stripes[dev_nr].dev;
-	u64 physical = bioc->stripes[dev_nr].physical;
+	struct btrfs_fs_info *fs_info = btrfs_sb(bbio->inode->i_sb);
+	struct btrfs_device *dev = bbio->stripes[dev_nr].dev;
+	u64 physical = bbio->stripes[dev_nr].physical;
 	struct bio *bio;
 
 	if (!dev || !dev->bdev ||
 	    test_bit(BTRFS_DEV_STATE_MISSING, &dev->dev_state) ||
-	    (btrfs_op(orig_bio) == BTRFS_MAP_WRITE &&
+	    (btrfs_op(&bbio->bio) == BTRFS_MAP_WRITE &&
 	     !test_bit(BTRFS_DEV_STATE_WRITEABLE, &dev->dev_state))) {
-		atomic_inc(&bioc->error);
-		if (atomic_dec_and_test(&bioc->stripes_pending))
-			btrfs_end_bioc(bioc, false);
+		atomic_inc(&bbio->error);
+		if (atomic_dec_and_test(&bbio->stripes_pending))
+			btrfs_end_bbio(bbio, false);
 		return;
 	}
 
 	if (clone) {
-		bio = btrfs_bio_clone(dev->bdev, orig_bio);
+		bio = btrfs_bio_clone(dev->bdev, &bbio->bio);
 	} else {
-		bio = orig_bio;
+		bio = &bbio->bio;
 		bio_set_dev(bio, dev->bdev);
 	}
 
-	bio->bi_private = bioc;
+	bio->bi_private = bbio;
 	btrfs_bio(bio)->device = dev;
 	bio->bi_end_io = btrfs_end_bio;
 	bio->bi_iter.bi_sector = physical >> 9;
@@ -6800,6 +6835,7 @@ static void submit_stripe_bio(struct btrfs_io_context *bioc,
 blk_status_t btrfs_map_bio(struct btrfs_fs_info *fs_info, struct bio *bio,
 			   int mirror_num)
 {
+	struct btrfs_bio *bbio = btrfs_bio(bio);
 	u64 logical = bio->bi_iter.bi_sector << 9;
 	u64 length = bio->bi_iter.bi_size;
 	u64 map_length = length;
@@ -6809,18 +6845,17 @@ blk_status_t btrfs_map_bio(struct btrfs_fs_info *fs_info, struct bio *bio,
 	struct btrfs_io_context *bioc = NULL;
 
 	btrfs_bio_counter_inc_blocked(fs_info);
-	ret = __btrfs_map_block(fs_info, btrfs_op(bio), logical,
-				&map_length, &bioc, mirror_num, 1);
+	ret = __btrfs_map_block(fs_info, btrfs_op(bio), logical, &map_length,
+				&bioc, bbio, mirror_num, 1);
 	if (ret)
 		goto out_dec;
 
-	total_devs = bioc->num_stripes;
-	bioc->orig_bio = bio;
-	bioc->private = bio->bi_private;
-	bioc->end_io = bio->bi_end_io;
-	atomic_set(&bioc->stripes_pending, bioc->num_stripes);
+	bbio->private = bio->bi_private;
+	bbio->end_io = bio->bi_end_io;
+
+	if (bioc) {
+		ASSERT(bioc->map_type & BTRFS_BLOCK_GROUP_RAID56_MASK);
 
-	if (bioc->map_type & BTRFS_BLOCK_GROUP_RAID56_MASK) {
 		/*
 		 * In this case, map_length has been set to the length of a
 		 * single stripe; not the whole write.
@@ -6834,6 +6869,7 @@ blk_status_t btrfs_map_bio(struct btrfs_fs_info *fs_info, struct bio *bio,
 						    mirror_num, 1);
 			goto out_dec;
 		}
+		ASSERT(0);
 	}
 
 	if (map_length < length) {
@@ -6843,8 +6879,9 @@ blk_status_t btrfs_map_bio(struct btrfs_fs_info *fs_info, struct bio *bio,
 		BUG();
 	}
 
+	total_devs = atomic_read(&bbio->stripes_pending);
 	for (dev_nr = 0; dev_nr < total_devs; dev_nr++)
-		submit_stripe_bio(bioc, bio, dev_nr, dev_nr < total_devs - 1);
+		submit_stripe_bio(bbio, dev_nr, dev_nr < total_devs - 1);
 out_dec:
 	btrfs_bio_counter_dec(fs_info);
 	return errno_to_blk_status(ret);
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 51a27180004eb..cd71cd33a9df2 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -323,6 +323,11 @@ enum btrfs_endio_type {
 	BTRFS_ENDIO_WQ_FREE_SPACE_READ,
 };
 
+struct btrfs_bio_stripe {
+	struct btrfs_device *dev;
+	u64 physical;
+};
+
 /*
  * Additional info to pass along bio.
  *
@@ -333,6 +338,16 @@ struct btrfs_bio {
 
 	unsigned int mirror_num;
 	
+	atomic_t stripes_pending;
+	atomic_t error;
+	int max_errors;
+
+	struct btrfs_bio_stripe *stripes;
+	struct btrfs_bio_stripe __stripe;
+
+	bio_end_io_t *end_io;
+	void *private;
+
 	enum btrfs_endio_type end_io_type;
 	struct btrfs_work work;
 
@@ -389,13 +404,8 @@ struct btrfs_io_stripe {
  */
 struct btrfs_io_context {
 	refcount_t refs;
-	atomic_t stripes_pending;
 	struct btrfs_fs_info *fs_info;
 	u64 map_type; /* get from map_lookup->type */
-	bio_end_io_t *end_io;
-	struct bio *orig_bio;
-	void *private;
-	atomic_t error;
 	int max_errors;
 	int num_stripes;
 	int mirror_num;
-- 
2.30.2

