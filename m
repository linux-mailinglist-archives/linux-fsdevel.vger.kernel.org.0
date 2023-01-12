Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEA11666DA4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jan 2023 10:11:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239884AbjALJLe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Jan 2023 04:11:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239911AbjALJKT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Jan 2023 04:10:19 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FEC9B84;
        Thu, 12 Jan 2023 01:05:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=gEIavy2W6F4Lz3Q3v1LrWtwjmZI+ZvjaJnV/vwTujA8=; b=CmraD2cy/UGHSm1IlqylVVykFB
        ubWg0YXOz5E6Ehdr3lavHz2DfuLds3ffuROf1I+PS44GCJj4yJgsYbdNyRDCkkyJeLfJVexSNc+bu
        MliAWh+Kb3bW7CaiPCyswQeUvhug+XzShTmFs3784K+eBYR2J5M26ONho+Tp8ZrONAuCOzw4jFQfh
        E5l9OnDF6FwV7o9WykpWsRXycUtJy9WQ4gOOLMLZxa+48v2Sc8vVAPYyeVXld1MVf5i4tz2o6VKS8
        C25hHZhGNo/abRu/uCWCQPD1T0P5KFdAmXjXzjUnaGPNfUY3glfg+1sQy7iG7BKmRbsqxXIqKaN5z
        D/EGtrAw==;
Received: from [2001:4bb8:181:656b:c87d:36c9:914c:c2ea] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pFtWv-00EGHY-1c; Thu, 12 Jan 2023 09:05:49 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>, Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 05/19] btrfs: handle checksum generation in the storage layer
Date:   Thu, 12 Jan 2023 10:05:17 +0100
Message-Id: <20230112090532.1212225-6-hch@lst.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230112090532.1212225-1-hch@lst.de>
References: <20230112090532.1212225-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Instead of letting the callers of btrfs_submit_bio deal with checksumming
the (meta)data in the bio and making decisions on when to offload the
checksumming to the bio, leave that to btrfs_submit_bio.  Do do so the
existing btrfs_submit_bio function is split into an upper and a lower
half, so that the lower half can be offloaded to a workqueue.

Note that this changes the behavior for direct writes to raid56 volumes so
that async checksum offloading is not skipped when more I/O is expected.
This runs counter to the argument explaining why it was done, although I
can't measure any affects of the change.  Commits later in this series
will make sure the entire direct writes is offloaded to the workqueue
at once and thus make sure it is sent to the raid56 code from a single
thread.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/bio.c         | 207 +++++++++++++++++++++++++++++++++++------
 fs/btrfs/compression.c |   9 --
 fs/btrfs/disk-io.c     | 155 +-----------------------------
 fs/btrfs/disk-io.h     |   9 +-
 fs/btrfs/inode.c       |  67 +------------
 5 files changed, 185 insertions(+), 262 deletions(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index 9de6a411cad166..8fe75e6aae4c69 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -403,7 +403,169 @@ static void btrfs_submit_mirrored_bio(struct btrfs_io_context *bioc, int dev_nr)
 	btrfs_submit_dev_bio(bioc->stripes[dev_nr].dev, bio);
 }
 
-void btrfs_submit_bio(struct btrfs_fs_info *fs_info, struct bio *bio, int mirror_num)
+static void __btrfs_submit_bio(struct bio *bio, struct btrfs_io_context *bioc,
+			       struct btrfs_io_stripe *smap, int mirror_num)
+{
+	/* Do not leak our private flag into the block layer */
+	bio->bi_opf &= ~REQ_BTRFS_ONE_ORDERED;
+
+	if (!bioc) {
+		/* Single mirror read/write fast path */
+		btrfs_bio(bio)->mirror_num = mirror_num;
+		bio->bi_iter.bi_sector = smap->physical >> SECTOR_SHIFT;
+		bio->bi_private = smap->dev;
+		bio->bi_end_io = btrfs_simple_end_io;
+		btrfs_submit_dev_bio(smap->dev, bio);
+	} else if (bioc->map_type & BTRFS_BLOCK_GROUP_RAID56_MASK) {
+		/* Parity RAID write or read recovery */
+		bio->bi_private = bioc;
+		bio->bi_end_io = btrfs_raid56_end_io;
+		if (bio_op(bio) == REQ_OP_READ)
+			raid56_parity_recover(bio, bioc, mirror_num);
+		else
+			raid56_parity_write(bio, bioc);
+	} else {
+		/* Write to multiple mirrors */
+		int total_devs = bioc->num_stripes;
+		int dev_nr;
+
+		bioc->orig_bio = bio;
+		for (dev_nr = 0; dev_nr < total_devs; dev_nr++)
+			btrfs_submit_mirrored_bio(bioc, dev_nr);
+	}
+}
+
+static blk_status_t btrfs_bio_csum(struct btrfs_bio *bbio)
+{
+	if (bbio->bio.bi_opf & REQ_META)
+		return btree_csum_one_bio(&bbio->bio);
+	return btrfs_csum_one_bio(bbio);
+}
+
+/*
+ * async submit bios are used to offload expensive checksumming
+ * onto the worker threads.
+ */
+struct async_submit_bio {
+	struct btrfs_bio *bbio;
+	struct btrfs_io_context *bioc;
+	struct btrfs_io_stripe smap;
+	int mirror_num;
+	struct btrfs_work work;
+};
+
+/*
+ * In order to insert checksums into the metadata in large chunks,
+ * we wait until bio submission time.   All the pages in the bio are
+ * checksummed and sums are attached onto the ordered extent record.
+ *
+ * At IO completion time the cums attached on the ordered extent record
+ * are inserted into the btree
+ */
+static void run_one_async_start(struct btrfs_work *work)
+{
+	struct async_submit_bio *async =
+		container_of(work, struct async_submit_bio, work);
+	blk_status_t ret;
+
+	ret = btrfs_bio_csum(async->bbio);
+	if (ret)
+		async->bbio->bio.bi_status = ret;
+}
+
+/*
+ * In order to insert checksums into the metadata in large chunks, we wait
+ * until bio submission time.   All the pages in the bio are checksummed and
+ * sums are attached onto the ordered extent record.
+ *
+ * At IO completion time the csums attached on the ordered extent record are
+ * inserted into the tree.
+ */
+static void run_one_async_done(struct btrfs_work *work)
+{
+	struct async_submit_bio *async =
+		container_of(work, struct async_submit_bio, work);
+	struct bio *bio = &async->bbio->bio;
+
+	/* If an error occurred we just want to clean up the bio and move on */
+	if (bio->bi_status) {
+		btrfs_bio_end_io(async->bbio, bio->bi_status);
+		return;
+	}
+
+	/*
+	 * All of the bios that pass through here are from async helpers.
+	 * Use REQ_CGROUP_PUNT to issue them from the owning cgroup's context.
+	 * This changes nothing when cgroups aren't in use.
+	 */
+	bio->bi_opf |= REQ_CGROUP_PUNT;
+	__btrfs_submit_bio(bio, async->bioc, &async->smap, async->mirror_num);
+}
+
+static void run_one_async_free(struct btrfs_work *work)
+{
+	kfree(container_of(work, struct async_submit_bio, work));
+}
+
+static bool should_async_write(struct btrfs_bio *bbio)
+{
+	/*
+	 * If the I/O is not issued by fsync and friends, (->sync_writers != 0),
+	 * then try to defer the submission to a workqueue to parallelize the
+	 * checksum calculation.
+	 */
+	if (atomic_read(&bbio->inode->sync_writers))
+		return false;
+
+	/*
+	 * Submit metadata writes synchronously if the checksum implementation
+	 * is fast, or we are on a zoned device that wants I/O to be submitted
+	 * in order.
+	 */
+	if (bbio->bio.bi_opf & REQ_META) {
+		struct btrfs_fs_info *fs_info = bbio->inode->root->fs_info;
+
+		if (btrfs_is_zoned(fs_info))
+			return false;
+		if (test_bit(BTRFS_FS_CSUM_IMPL_FAST, &fs_info->flags))
+			return false;
+	}
+
+	return true;
+}
+
+/*
+ * Submit bio to an async queue.
+ *
+ * Returns true if the work has been succesfuly submitted, else false.
+ */
+static bool btrfs_wq_submit_bio(struct btrfs_bio *bbio,
+				struct btrfs_io_context *bioc,
+				struct btrfs_io_stripe *smap, int mirror_num)
+{
+	struct btrfs_fs_info *fs_info = bbio->inode->root->fs_info;
+	struct async_submit_bio *async;
+
+	async = kmalloc(sizeof(*async), GFP_NOFS);
+	if (!async)
+		return false;
+
+	async->bbio = bbio;
+	async->bioc = bioc;
+	async->smap = *smap;
+	async->mirror_num = mirror_num;
+
+	btrfs_init_work(&async->work, run_one_async_start, run_one_async_done,
+			run_one_async_free);
+	if (op_is_sync(bbio->bio.bi_opf))
+		btrfs_queue_work(fs_info->hipri_workers, &async->work);
+	else
+		btrfs_queue_work(fs_info->workers, &async->work);
+	return true;
+}
+
+void btrfs_submit_bio(struct btrfs_fs_info *fs_info, struct bio *bio,
+		      int mirror_num)
 {
 	struct btrfs_bio *bbio = btrfs_bio(bio);
 	u64 logical = bio->bi_iter.bi_sector << 9;
@@ -440,34 +602,25 @@ void btrfs_submit_bio(struct btrfs_fs_info *fs_info, struct bio *bio, int mirror
 			goto fail;
 	}
 
-	/* Do not leak our private flag into the block layer */
-	bio->bi_opf &= ~REQ_BTRFS_ONE_ORDERED;
-
-	if (!bioc) {
-		/* Single mirror read/write fast path */
-		btrfs_bio(bio)->mirror_num = mirror_num;
-		bio->bi_iter.bi_sector = smap.physical >> SECTOR_SHIFT;
-		bio->bi_private = smap.dev;
-		bio->bi_end_io = btrfs_simple_end_io;
-		btrfs_submit_dev_bio(smap.dev, bio);
-	} else if (bioc->map_type & BTRFS_BLOCK_GROUP_RAID56_MASK) {
-		/* Parity RAID write or read recovery */
-		bio->bi_private = bioc;
-		bio->bi_end_io = btrfs_raid56_end_io;
-		if (bio_op(bio) == REQ_OP_READ)
-			raid56_parity_recover(bio, bioc, mirror_num);
-		else
-			raid56_parity_write(bio, bioc);
-	} else {
-		/* Write to multiple mirrors */
-		int total_devs = bioc->num_stripes;
-		int dev_nr;
-
-		bioc->orig_bio = bio;
-		for (dev_nr = 0; dev_nr < total_devs; dev_nr++)
-			btrfs_submit_mirrored_bio(bioc, dev_nr);
+	if (btrfs_op(bio) == BTRFS_MAP_WRITE) {
+		/*
+		 * Csum items for reloc roots have already been cloned at this
+		 * point, so they are handled as part of the no-checksum case.
+		 */
+		if (!(bbio->inode->flags & BTRFS_INODE_NODATASUM) &&
+		    !test_bit(BTRFS_FS_STATE_NO_CSUMS, &fs_info->fs_state) &&
+		    !btrfs_is_data_reloc_root(bbio->inode->root)) {
+			if (should_async_write(bbio) &&
+			    btrfs_wq_submit_bio(bbio, bioc, &smap, mirror_num))
+				return;
+
+			ret = btrfs_bio_csum(bbio);
+			if (ret)
+				goto fail;
+		}
 	}
 
+	__btrfs_submit_bio(bio, bioc, &smap, mirror_num);
 	return;
 fail:
 	btrfs_bio_counter_dec(fs_info);
diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 002af327705605..21c064c8cf8ada 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -355,7 +355,6 @@ blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
 	u64 cur_disk_bytenr = disk_start;
 	u64 next_stripe_start;
 	blk_status_t ret = BLK_STS_OK;
-	int skip_sum = inode->flags & BTRFS_INODE_NODATASUM;
 	const bool use_append = btrfs_use_zone_append(inode, disk_start);
 	const enum req_op bio_op = REQ_BTRFS_ONE_ORDERED |
 		(use_append ? REQ_OP_ZONE_APPEND : REQ_OP_WRITE);
@@ -437,14 +436,6 @@ blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
 			submit = true;
 
 		if (submit) {
-			if (!skip_sum) {
-				ret = btrfs_csum_one_bio(btrfs_bio(bio));
-				if (ret) {
-					btrfs_bio_end_io(btrfs_bio(bio), ret);
-					break;
-				}
-			}
-
 			ASSERT(bio->bi_iter.bi_size);
 			btrfs_submit_bio(fs_info, bio, 0);
 			bio = NULL;
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index d05b311d86cad1..146b64715745bb 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -52,7 +52,6 @@
 #include "relocation.h"
 #include "scrub.h"
 #include "super.h"
-#include "file-item.h"
 
 #define BTRFS_SUPER_FLAG_SUPP	(BTRFS_HEADER_FLAG_WRITTEN |\
 				 BTRFS_HEADER_FLAG_RELOC |\
@@ -79,23 +78,6 @@ static void btrfs_free_csum_hash(struct btrfs_fs_info *fs_info)
 		crypto_free_shash(fs_info->csum_shash);
 }
 
-/*
- * async submit bios are used to offload expensive checksumming
- * onto the worker threads.  They checksum file and metadata bios
- * just before they are sent down the IO stack.
- */
-struct async_submit_bio {
-	struct btrfs_inode *inode;
-	struct bio *bio;
-	enum btrfs_wq_submit_cmd submit_cmd;
-	int mirror_num;
-
-	/* Optional parameter for used by direct io */
-	u64 dio_file_offset;
-	struct btrfs_work work;
-	blk_status_t status;
-};
-
 /*
  * Compute the csum of a btree block and store the result to provided buffer.
  */
@@ -456,7 +438,7 @@ static int csum_dirty_buffer(struct btrfs_fs_info *fs_info, struct bio_vec *bvec
 	return csum_one_extent_buffer(eb);
 }
 
-static blk_status_t btree_csum_one_bio(struct bio *bio)
+blk_status_t btree_csum_one_bio(struct bio *bio)
 {
 	struct bio_vec *bvec;
 	struct btrfs_root *root;
@@ -719,143 +701,10 @@ int btrfs_validate_metadata_buffer(struct btrfs_bio *bbio,
 	return ret;
 }
 
-static void run_one_async_start(struct btrfs_work *work)
-{
-	struct async_submit_bio *async;
-	blk_status_t ret;
-
-	async = container_of(work, struct  async_submit_bio, work);
-	switch (async->submit_cmd) {
-	case WQ_SUBMIT_METADATA:
-		ret = btree_csum_one_bio(async->bio);
-		break;
-	case WQ_SUBMIT_DATA:
-	case WQ_SUBMIT_DATA_DIO:
-		ret = btrfs_csum_one_bio(btrfs_bio(async->bio));
-		break;
-	default:
-		/* Can't happen so return something that would prevent the IO. */
-		ret = BLK_STS_IOERR;
-		ASSERT(0);
-	}
-	if (ret)
-		async->status = ret;
-}
-
-/*
- * In order to insert checksums into the metadata in large chunks, we wait
- * until bio submission time.   All the pages in the bio are checksummed and
- * sums are attached onto the ordered extent record.
- *
- * At IO completion time the csums attached on the ordered extent record are
- * inserted into the tree.
- */
-static void run_one_async_done(struct btrfs_work *work)
-{
-	struct async_submit_bio *async =
-		container_of(work, struct  async_submit_bio, work);
-	struct btrfs_inode *inode = async->inode;
-	struct btrfs_bio *bbio = btrfs_bio(async->bio);
-
-	/* If an error occurred we just want to clean up the bio and move on */
-	if (async->status) {
-		btrfs_bio_end_io(bbio, async->status);
-		return;
-	}
-
-	/*
-	 * All of the bios that pass through here are from async helpers.
-	 * Use REQ_CGROUP_PUNT to issue them from the owning cgroup's context.
-	 * This changes nothing when cgroups aren't in use.
-	 */
-	async->bio->bi_opf |= REQ_CGROUP_PUNT;
-	btrfs_submit_bio(inode->root->fs_info, async->bio, async->mirror_num);
-}
-
-static void run_one_async_free(struct btrfs_work *work)
-{
-	struct async_submit_bio *async;
-
-	async = container_of(work, struct  async_submit_bio, work);
-	kfree(async);
-}
-
-/*
- * Submit bio to an async queue.
- *
- * Retrun:
- * - true if the work has been succesfuly submitted
- * - false in case of error
- */
-bool btrfs_wq_submit_bio(struct btrfs_inode *inode, struct bio *bio, int mirror_num,
-			 u64 dio_file_offset, enum btrfs_wq_submit_cmd cmd)
-{
-	struct btrfs_fs_info *fs_info = inode->root->fs_info;
-	struct async_submit_bio *async;
-
-	async = kmalloc(sizeof(*async), GFP_NOFS);
-	if (!async)
-		return false;
-
-	async->inode = inode;
-	async->bio = bio;
-	async->mirror_num = mirror_num;
-	async->submit_cmd = cmd;
-
-	btrfs_init_work(&async->work, run_one_async_start, run_one_async_done,
-			run_one_async_free);
-
-	async->dio_file_offset = dio_file_offset;
-
-	async->status = 0;
-
-	if (op_is_sync(bio->bi_opf))
-		btrfs_queue_work(fs_info->hipri_workers, &async->work);
-	else
-		btrfs_queue_work(fs_info->workers, &async->work);
-	return true;
-}
-
-static bool should_async_write(struct btrfs_fs_info *fs_info,
-			     struct btrfs_inode *bi)
-{
-	if (btrfs_is_zoned(fs_info))
-		return false;
-	if (atomic_read(&bi->sync_writers))
-		return false;
-	if (test_bit(BTRFS_FS_CSUM_IMPL_FAST, &fs_info->flags))
-		return false;
-	return true;
-}
-
 void btrfs_submit_metadata_bio(struct btrfs_inode *inode, struct bio *bio, int mirror_num)
 {
-	struct btrfs_fs_info *fs_info = inode->root->fs_info;
-	struct btrfs_bio *bbio = btrfs_bio(bio);
-	blk_status_t ret;
-
 	bio->bi_opf |= REQ_META;
-
-	if (btrfs_op(bio) != BTRFS_MAP_WRITE) {
-		btrfs_submit_bio(fs_info, bio, mirror_num);
-		return;
-	}
-
-	/*
-	 * Kthread helpers are used to submit writes so that checksumming can
-	 * happen in parallel across all CPUs.
-	 */
-	if (should_async_write(fs_info, inode) &&
-	    btrfs_wq_submit_bio(inode, bio, mirror_num, 0, WQ_SUBMIT_METADATA))
-		return;
-
-	ret = btree_csum_one_bio(bio);
-	if (ret) {
-		btrfs_bio_end_io(bbio, ret);
-		return;
-	}
-
-	btrfs_submit_bio(fs_info, bio, mirror_num);
+	btrfs_submit_bio(inode->root->fs_info, bio, mirror_num);
 }
 
 #ifdef CONFIG_MIGRATION
diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
index 5898beb648484a..ac55f8ec3a31a7 100644
--- a/fs/btrfs/disk-io.h
+++ b/fs/btrfs/disk-io.h
@@ -114,14 +114,7 @@ int btrfs_buffer_uptodate(struct extent_buffer *buf, u64 parent_transid,
 int btrfs_read_extent_buffer(struct extent_buffer *buf,
 			     struct btrfs_tree_parent_check *check);
 
-enum btrfs_wq_submit_cmd {
-	WQ_SUBMIT_METADATA,
-	WQ_SUBMIT_DATA,
-	WQ_SUBMIT_DATA_DIO,
-};
-
-bool btrfs_wq_submit_bio(struct btrfs_inode *inode, struct bio *bio, int mirror_num,
-			 u64 dio_file_offset, enum btrfs_wq_submit_cmd cmd);
+blk_status_t btree_csum_one_bio(struct bio *bio);
 int btrfs_alloc_log_tree_node(struct btrfs_trans_handle *trans,
 			      struct btrfs_root *root);
 int btrfs_init_log_root_tree(struct btrfs_trans_handle *trans,
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index f24f9f6fe755f8..b675d98c52bf01 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2721,27 +2721,6 @@ void btrfs_submit_data_write_bio(struct btrfs_inode *inode, struct bio *bio, int
 		}
 	}
 
-	/*
-	 * If we need to checksum, and the I/O is not issued by fsync and
-	 * friends, that is ->sync_writers != 0, defer the submission to a
-	 * workqueue to parallelize it.
-	 *
-	 * Csum items for reloc roots have already been cloned at this point,
-	 * so they are handled as part of the no-checksum case.
-	 */
-	if (!(inode->flags & BTRFS_INODE_NODATASUM) &&
-	    !test_bit(BTRFS_FS_STATE_NO_CSUMS, &fs_info->fs_state) &&
-	    !btrfs_is_data_reloc_root(inode->root)) {
-		if (!atomic_read(&inode->sync_writers) &&
-		    btrfs_wq_submit_bio(inode, bio, mirror_num, 0, WQ_SUBMIT_DATA))
-			return;
-
-		ret = btrfs_csum_one_bio(btrfs_bio(bio));
-		if (ret) {
-			btrfs_bio_end_io(btrfs_bio(bio), ret);
-			return;
-		}
-	}
 	btrfs_submit_bio(fs_info, bio, mirror_num);
 }
 
@@ -7841,36 +7820,6 @@ static void btrfs_end_dio_bio(struct btrfs_bio *bbio)
 	btrfs_dio_private_put(dip);
 }
 
-static void btrfs_submit_dio_bio(struct bio *bio, struct btrfs_inode *inode,
-				 u64 file_offset, int async_submit)
-{
-	struct btrfs_fs_info *fs_info = inode->root->fs_info;
-	blk_status_t ret;
-
-	if (inode->flags & BTRFS_INODE_NODATASUM)
-		goto map;
-
-	if (btrfs_op(bio) == BTRFS_MAP_WRITE) {
-		/* Check btrfs_submit_data_write_bio() for async submit rules */
-		if (async_submit && !atomic_read(&inode->sync_writers) &&
-		    btrfs_wq_submit_bio(inode, bio, 0, file_offset,
-					WQ_SUBMIT_DATA_DIO))
-			return;
-
-		/*
-		 * If we aren't doing async submit, calculate the csum of the
-		 * bio now.
-		 */
-		ret = btrfs_csum_one_bio(btrfs_bio(bio));
-		if (ret) {
-			btrfs_bio_end_io(btrfs_bio(bio), ret);
-			return;
-		}
-	}
-map:
-	btrfs_submit_bio(fs_info, bio, 0);
-}
-
 static void btrfs_submit_direct(const struct iomap_iter *iter,
 		struct bio *dio_bio, loff_t file_offset)
 {
@@ -7878,11 +7827,8 @@ static void btrfs_submit_direct(const struct iomap_iter *iter,
 		container_of(dio_bio, struct btrfs_dio_private, bio);
 	struct inode *inode = iter->inode;
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
-	const bool raid56 = (btrfs_data_alloc_profile(fs_info) &
-			     BTRFS_BLOCK_GROUP_RAID56_MASK);
 	struct bio *bio;
 	u64 start_sector;
-	int async_submit = 0;
 	u64 submit_len;
 	u64 clone_offset = 0;
 	u64 clone_len;
@@ -7949,19 +7895,10 @@ static void btrfs_submit_direct(const struct iomap_iter *iter,
 		 * We transfer the initial reference to the last bio, so we
 		 * don't need to increment the reference count for the last one.
 		 */
-		if (submit_len > 0) {
+		if (submit_len > 0)
 			refcount_inc(&dip->refs);
-			/*
-			 * If we are submitting more than one bio, submit them
-			 * all asynchronously. The exception is RAID 5 or 6, as
-			 * asynchronous checksums make it difficult to collect
-			 * full stripe writes.
-			 */
-			if (!raid56)
-				async_submit = 1;
-		}
 
-		btrfs_submit_dio_bio(bio, BTRFS_I(inode), file_offset, async_submit);
+		btrfs_submit_bio(fs_info, bio, 0);
 
 		dio_data->submitted += clone_len;
 		clone_offset += clone_len;
-- 
2.35.1

