Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 531E15A90DE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Sep 2022 09:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234026AbiIAHnJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Sep 2022 03:43:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233696AbiIAHmy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Sep 2022 03:42:54 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72033125B84;
        Thu,  1 Sep 2022 00:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=mn7IyLnu9OyHB9Afty6QvRyM2MaZlJlCS5YdvUAQ14Y=; b=PqPSgQNF3R4TbkeB1FuC8l1tvp
        bV97FNLFFBVocnSgZ9IwOF+CVxiWt4cSeK09oG6DtW470CqC7czHCt+oK54OV0EZ0p/GKy+lMg0bq
        x1TyvU6tlbDMsmeNxm9L6sA1keVLReZp5STEHkwVD1YsuXcFWbl6JbFDzKMm0Lrm/FJmrRxrRxiBs
        y0cWD+gVJv8bgS3eMQPhf+JYSNncH9TyzD2uwjzwDq0xdNHim8e0EMj9JNxRPkxKwtbKm2Q0uvGh7
        W3aUOiRb9msuFtSsaBMqKzbuD3hyScsKzkwXv5boE7VhhwzPC+ev4/4M82NPJDo75YZTU7qxAIG6g
        jyd0J9Dg==;
Received: from 213-225-1-14.nat.highway.a1.net ([213.225.1.14] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oTeqX-00ANak-Du; Thu, 01 Sep 2022 07:42:42 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>, Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 05/17] btrfs: handle checksum generation in the storage layer
Date:   Thu,  1 Sep 2022 10:42:04 +0300
Message-Id: <20220901074216.1849941-6-hch@lst.de>
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

Instead of letting the callers of btrfs_submit_bio deal with checksumming
the (meta)data in the bio and making decisions on when to offload the
checksumming to the bio, leave that to btrfs_submit_bio.  Do do so the
existing btrfs_submit_bio function is split into an upper and a lower
half, so that the lower half can be offloaded to a workqueue.

The driver-private REQ_DRV flag is used to indicate the special 'bio must
be contained in a single ordered extent case' that is used by the
compressed write case instead of passing a new flag all the way down the
stack.

Note that this changes the behavior for direct writes to raid56 volumes so
that async checksum offloading is not skipped when more I/O is expected.
This runs counter to the argument explaining why it was done, although I
can't measure any affects of the change.  Commits later in this series
will make sure the entire direct writes is offloaded to the workqueue
at once and thus make sure it is sent to the raid56 code from a single
thread.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/compression.c |  13 +--
 fs/btrfs/ctree.h       |   4 +-
 fs/btrfs/disk-io.c     | 170 ++-------------------------------
 fs/btrfs/disk-io.h     |   5 -
 fs/btrfs/extent_io.h   |   3 -
 fs/btrfs/file-item.c   |  25 ++---
 fs/btrfs/inode.c       |  89 +-----------------
 fs/btrfs/volumes.c     | 208 ++++++++++++++++++++++++++++++++++++-----
 fs/btrfs/volumes.h     |   7 +-
 9 files changed, 215 insertions(+), 309 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index f932415a4f1df..53f9e123712b0 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -351,9 +351,9 @@ blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
 	u64 cur_disk_bytenr = disk_start;
 	u64 next_stripe_start;
 	blk_status_t ret = BLK_STS_OK;
-	int skip_sum = inode->flags & BTRFS_INODE_NODATASUM;
 	const bool use_append = btrfs_use_zone_append(inode, disk_start);
-	const enum req_op bio_op = use_append ? REQ_OP_ZONE_APPEND : REQ_OP_WRITE;
+	const enum req_op bio_op = REQ_BTRFS_ONE_ORDERED |
+		(use_append ? REQ_OP_ZONE_APPEND : REQ_OP_WRITE);
 
 	ASSERT(IS_ALIGNED(start, fs_info->sectorsize) &&
 	       IS_ALIGNED(len, fs_info->sectorsize));
@@ -431,15 +431,8 @@ blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
 			submit = true;
 
 		if (submit) {
-			if (!skip_sum) {
-				ret = btrfs_csum_one_bio(inode, bio, start, true);
-				if (ret) {
-					btrfs_bio_end_io(btrfs_bio(bio), ret);
-					break;
-				}
-			}
-
 			ASSERT(bio->bi_iter.bi_size);
+			btrfs_bio(bio)->file_offset = start;
 			btrfs_submit_bio(fs_info, bio, 0);
 			bio = NULL;
 		}
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 3dcb0d5f8faa0..33c3c394e43e3 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3355,8 +3355,8 @@ int btrfs_lookup_file_extent(struct btrfs_trans_handle *trans,
 int btrfs_csum_file_blocks(struct btrfs_trans_handle *trans,
 			   struct btrfs_root *root,
 			   struct btrfs_ordered_sum *sums);
-blk_status_t btrfs_csum_one_bio(struct btrfs_inode *inode, struct bio *bio,
-				u64 offset, bool one_ordered);
+int btrfs_csum_one_bio(struct btrfs_bio *bbio);
+int btree_csum_one_bio(struct btrfs_bio *bbio);
 int btrfs_lookup_csums_range(struct btrfs_root *root, u64 start, u64 end,
 			     struct list_head *list, int search_commit);
 void btrfs_extent_item_to_extent_map(struct btrfs_inode *inode,
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index a88d6c3b59042..ceee039b65ea0 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -69,23 +69,6 @@ static void btrfs_free_csum_hash(struct btrfs_fs_info *fs_info)
 		crypto_free_shash(fs_info->csum_shash);
 }
 
-/*
- * async submit bios are used to offload expensive checksumming
- * onto the worker threads.  They checksum file and metadata bios
- * just before they are sent down the IO stack.
- */
-struct async_submit_bio {
-	struct inode *inode;
-	struct bio *bio;
-	extent_submit_bio_start_t *submit_bio_start;
-	int mirror_num;
-
-	/* Optional parameter for submit_bio_start used by direct io */
-	u64 dio_file_offset;
-	struct btrfs_work work;
-	blk_status_t status;
-};
-
 /*
  * Compute the csum of a btree block and store the result to provided buffer.
  */
@@ -649,161 +632,26 @@ int btrfs_validate_metadata_buffer(struct btrfs_bio *bbio,
 	return ret;
 }
 
-static void run_one_async_start(struct btrfs_work *work)
-{
-	struct async_submit_bio *async;
-	blk_status_t ret;
-
-	async = container_of(work, struct  async_submit_bio, work);
-	ret = async->submit_bio_start(async->inode, async->bio,
-				      async->dio_file_offset);
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
-	struct inode *inode = async->inode;
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
-	btrfs_submit_bio(btrfs_sb(inode->i_sb), async->bio, async->mirror_num);
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
-bool btrfs_wq_submit_bio(struct inode *inode, struct bio *bio, int mirror_num,
-			 u64 dio_file_offset,
-			 extent_submit_bio_start_t *submit_bio_start)
-{
-	struct btrfs_fs_info *fs_info = BTRFS_I(inode)->root->fs_info;
-	struct async_submit_bio *async;
-
-	async = kmalloc(sizeof(*async), GFP_NOFS);
-	if (!async)
-		return false;
-
-	async->inode = inode;
-	async->bio = bio;
-	async->mirror_num = mirror_num;
-	async->submit_bio_start = submit_bio_start;
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
-static blk_status_t btree_csum_one_bio(struct bio *bio)
+int btree_csum_one_bio(struct btrfs_bio *bbio)
 {
-	struct bio_vec *bvec;
-	struct btrfs_root *root;
-	int ret = 0;
-	struct bvec_iter_all iter_all;
+	struct btrfs_fs_info *fs_info = btrfs_sb(bbio->inode->i_sb);
+	struct bvec_iter iter;
+	struct bio_vec bvec;
+	int ret;
 
-	ASSERT(!bio_flagged(bio, BIO_CLONED));
-	bio_for_each_segment_all(bvec, bio, iter_all) {
-		root = BTRFS_I(bvec->bv_page->mapping->host)->root;
-		ret = csum_dirty_buffer(root->fs_info, bvec);
+	bio_for_each_segment(bvec, &bbio->bio, iter) {
+		ret = csum_dirty_buffer(fs_info, &bvec);
 		if (ret)
 			break;
 	}
 
-	return errno_to_blk_status(ret);
-}
-
-static blk_status_t btree_submit_bio_start(struct inode *inode, struct bio *bio,
-					   u64 dio_file_offset)
-{
-	/*
-	 * when we're called for a write, we're already in the async
-	 * submission context.  Just jump into btrfs_submit_bio.
-	 */
-	return btree_csum_one_bio(bio);
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
+	return ret;
 }
 
 void btrfs_submit_metadata_bio(struct inode *inode, struct bio *bio, int mirror_num)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
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
-	if (should_async_write(fs_info, BTRFS_I(inode)) &&
-	    btrfs_wq_submit_bio(inode, bio, mirror_num, 0, btree_submit_bio_start))
-		return;
-
-	ret = btree_csum_one_bio(bio);
-	if (ret) {
-		btrfs_bio_end_io(bbio, ret);
-		return;
-	}
-
-	btrfs_submit_bio(fs_info, bio, mirror_num);
+	btrfs_submit_bio(btrfs_sb(inode->i_sb), bio, mirror_num);
 }
 
 #ifdef CONFIG_MIGRATION
diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
index 47ad8e0a2d33f..9d4e0e36f7bb9 100644
--- a/fs/btrfs/disk-io.h
+++ b/fs/btrfs/disk-io.h
@@ -114,11 +114,6 @@ int btrfs_buffer_uptodate(struct extent_buffer *buf, u64 parent_transid,
 			  int atomic);
 int btrfs_read_extent_buffer(struct extent_buffer *buf, u64 parent_transid,
 			     int level, struct btrfs_key *first_key);
-bool btrfs_wq_submit_bio(struct inode *inode, struct bio *bio, int mirror_num,
-			 u64 dio_file_offset,
-			 extent_submit_bio_start_t *submit_bio_start);
-blk_status_t btrfs_submit_bio_done(void *private_data, struct bio *bio,
-			  int mirror_num);
 int btrfs_alloc_log_tree_node(struct btrfs_trans_handle *trans,
 			      struct btrfs_root *root);
 int btrfs_init_log_root_tree(struct btrfs_trans_handle *trans,
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index caf3343d1a36c..ddbeba7c6118a 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -62,9 +62,6 @@ struct btrfs_inode;
 struct btrfs_fs_info;
 struct extent_io_tree;
 
-typedef blk_status_t (extent_submit_bio_start_t)(struct inode *inode,
-		struct bio *bio, u64 dio_file_offset);
-
 #define INLINE_EXTENT_BUFFER_PAGES     (BTRFS_MAX_METADATA_BLOCKSIZE / PAGE_SIZE)
 struct extent_buffer {
 	u64 start;
diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index ffbac8f257908..5b3279e38665b 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -613,23 +613,17 @@ int btrfs_lookup_csums_range(struct btrfs_root *root, u64 start, u64 end,
 
 /**
  * Calculate checksums of the data contained inside a bio
- *
- * @inode:	 Owner of the data inside the bio
- * @bio:	 Contains the data to be checksummed
- * @offset:      If (u64)-1, @bio may contain discontiguous bio vecs, so the
- *               file offsets are determined from the page offsets in the bio.
- *               Otherwise, this is the starting file offset of the bio vecs in
- *               @bio, which must be contiguous.
- * @one_ordered: If true, @bio only refers to one ordered extent.
+ * @bbio:	 Contains the data to be checksummed
  */
-blk_status_t btrfs_csum_one_bio(struct btrfs_inode *inode, struct bio *bio,
-				u64 offset, bool one_ordered)
+int btrfs_csum_one_bio(struct btrfs_bio *bbio)
 {
+	struct btrfs_inode *inode = BTRFS_I(bbio->inode);
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
+	struct bio *bio = &bbio->bio;
+	u64 offset = bbio->file_offset;
 	struct btrfs_ordered_sum *sums;
 	struct btrfs_ordered_extent *ordered = NULL;
-	const bool use_page_offsets = (offset == (u64)-1);
 	char *data;
 	struct bvec_iter iter;
 	struct bio_vec bvec;
@@ -646,7 +640,7 @@ blk_status_t btrfs_csum_one_bio(struct btrfs_inode *inode, struct bio *bio,
 	memalloc_nofs_restore(nofs_flag);
 
 	if (!sums)
-		return BLK_STS_RESOURCE;
+		return -ENOMEM;
 
 	sums->len = bio->bi_iter.bi_size;
 	INIT_LIST_HEAD(&sums->list);
@@ -657,9 +651,6 @@ blk_status_t btrfs_csum_one_bio(struct btrfs_inode *inode, struct bio *bio,
 	shash->tfm = fs_info->csum_shash;
 
 	bio_for_each_segment(bvec, bio, iter) {
-		if (use_page_offsets)
-			offset = page_offset(bvec.bv_page) + bvec.bv_offset;
-
 		if (!ordered) {
 			ordered = btrfs_lookup_ordered_extent(inode, offset);
 			/*
@@ -672,7 +663,7 @@ blk_status_t btrfs_csum_one_bio(struct btrfs_inode *inode, struct bio *bio,
 				     inode->root->root_key.objectid,
 				     btrfs_ino(inode), offset);
 				kvfree(sums);
-				return BLK_STS_IOERR;
+				return -EIO;
 			}
 		}
 
@@ -681,7 +672,7 @@ blk_status_t btrfs_csum_one_bio(struct btrfs_inode *inode, struct bio *bio,
 						 - 1);
 
 		for (i = 0; i < blockcount; i++) {
-			if (!one_ordered &&
+			if (!(bio->bi_opf & REQ_BTRFS_ONE_ORDERED) &&
 			    !in_range(offset, ordered->file_offset,
 				      ordered->num_bytes)) {
 				unsigned long bytes_left;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index b3466015008c7..88dd99997631a 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2500,20 +2500,6 @@ void btrfs_clear_delalloc_extent(struct inode *vfs_inode,
 	}
 }
 
-/*
- * in order to insert checksums into the metadata in large chunks,
- * we wait until bio submission time.   All the pages in the bio are
- * checksummed and sums are attached onto the ordered extent record.
- *
- * At IO completion time the cums attached on the ordered extent record
- * are inserted into the btree
- */
-static blk_status_t btrfs_submit_bio_start(struct inode *inode, struct bio *bio,
-					   u64 dio_file_offset)
-{
-	return btrfs_csum_one_bio(BTRFS_I(inode), bio, (u64)-1, false);
-}
-
 /*
  * Split an extent_map at [start, start + len]
  *
@@ -2704,28 +2690,6 @@ void btrfs_submit_data_write_bio(struct inode *inode, struct bio *bio, int mirro
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
-	if (!(bi->flags & BTRFS_INODE_NODATASUM) &&
-	    !test_bit(BTRFS_FS_STATE_NO_CSUMS, &fs_info->fs_state) &&
-	    !btrfs_is_data_reloc_root(bi->root)) {
-		if (!atomic_read(&bi->sync_writers) &&
-		    btrfs_wq_submit_bio(inode, bio, mirror_num, 0,
-					btrfs_submit_bio_start))
-			return;
-
-		ret = btrfs_csum_one_bio(bi, bio, (u64)-1, false);
-		if (ret) {
-			btrfs_bio_end_io(btrfs_bio(bio), ret);
-			return;
-		}
-	}
 	btrfs_submit_bio(fs_info, bio, mirror_num);
 }
 
@@ -7885,13 +7849,6 @@ static void btrfs_dio_private_put(struct btrfs_dio_private *dip)
 	bio_endio(&dip->bio);
 }
 
-static blk_status_t btrfs_submit_bio_start_direct_io(struct inode *inode,
-						     struct bio *bio,
-						     u64 dio_file_offset)
-{
-	return btrfs_csum_one_bio(BTRFS_I(inode), bio, dio_file_offset, false);
-}
-
 static void btrfs_end_dio_bio(struct btrfs_bio *bbio)
 {
 	struct btrfs_dio_private *dip = bbio->private;
@@ -7913,36 +7870,6 @@ static void btrfs_end_dio_bio(struct btrfs_bio *bbio)
 	btrfs_dio_private_put(dip);
 }
 
-static void btrfs_submit_dio_bio(struct bio *bio, struct inode *inode,
-				 u64 file_offset, int async_submit)
-{
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
-	blk_status_t ret;
-		
-	if (BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM)
-		goto map;
-
-	if (btrfs_op(bio) == BTRFS_MAP_WRITE) {
-		/* Check btrfs_submit_data_write_bio() for async submit rules */
-		if (async_submit && !atomic_read(&BTRFS_I(inode)->sync_writers) &&
-		    btrfs_wq_submit_bio(inode, bio, 0, file_offset,
-					btrfs_submit_bio_start_direct_io))
-			return;
-
-		/*
-		 * If we aren't doing async submit, calculate the csum of the
-		 * bio now.
-		 */
-		ret = btrfs_csum_one_bio(BTRFS_I(inode), bio, file_offset, false);
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
@@ -7950,11 +7877,8 @@ static void btrfs_submit_direct(const struct iomap_iter *iter,
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
@@ -8020,19 +7944,10 @@ static void btrfs_submit_direct(const struct iomap_iter *iter,
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
 
-		btrfs_submit_dio_bio(bio, inode, file_offset, async_submit);
+		btrfs_submit_bio(fs_info, bio, 0);
 
 		dio_data->submitted += clone_len;
 		clone_offset += clone_len;
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index b8472ab466abe..2d13e8b52c94f 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -7026,7 +7026,170 @@ static void btrfs_submit_mirrored_bio(struct btrfs_io_context *bioc, int dev_nr)
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
+	struct btrfs_bio *bbio = async->bbio;
+	blk_status_t ret;
+
+	if (bbio->bio.bi_opf & REQ_META)
+		ret = btree_csum_one_bio(bbio);
+	else
+		ret = btrfs_csum_one_bio(bbio);
+	if (ret)
+		bbio->bio.bi_status = errno_to_blk_status(ret);
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
+	struct btrfs_inode *bi = BTRFS_I(bbio->inode);
+
+	/*
+	 * If the I/O is not issued by fsync and friends, (->sync_writers != 0),
+	 * then try to defer the submission to a workqueue to parallelize the
+	 * checksum calculation.
+	 */
+	if (atomic_read(&bi->sync_writers))
+		return false;
+
+	/*
+	 * Submit metadata writes synchronously if the checksum implementation
+	 * is fast, or we are on a zoned device that wants I/O to be submitted
+	 * in order.
+	 */
+	if (bbio->bio.bi_opf & REQ_META) {
+		struct btrfs_fs_info *fs_info = bi->root->fs_info;
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
+ * Retrun:
+ * - true if the work has been succesfuly submitted
+ * - false in case of error
+ */
+static bool btrfs_wq_submit_bio(struct btrfs_bio *bbio,
+				struct btrfs_io_context *bioc,
+			        struct btrfs_io_stripe *smap, int mirror_num)
+{
+	struct btrfs_fs_info *fs_info = btrfs_sb(bbio->inode->i_sb);
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
@@ -7060,31 +7223,30 @@ void btrfs_submit_bio(struct btrfs_fs_info *fs_info, struct bio *bio, int mirror
 			goto fail;
 	}
 
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
+	if (btrfs_op(bio) == BTRFS_MAP_WRITE) {
+		struct btrfs_inode *bi = BTRFS_I(bbio->inode);
 
-		bioc->orig_bio = bio;
-		for (dev_nr = 0; dev_nr < total_devs; dev_nr++)
-			btrfs_submit_mirrored_bio(bioc, dev_nr);
+		/*
+		 * Csum items for reloc roots have already been cloned at this
+		 * point, so they are handled as part of the no-checksum case.
+		 */
+		if (!(bi->flags & BTRFS_INODE_NODATASUM) &&
+		    !test_bit(BTRFS_FS_STATE_NO_CSUMS, &fs_info->fs_state) &&
+		    !btrfs_is_data_reloc_root(bi->root)) {
+			if (should_async_write(bbio) &&
+			    btrfs_wq_submit_bio(bbio, bioc, &smap, mirror_num))
+				return;
+
+			if (bio->bi_opf & REQ_META)
+				ret = btree_csum_one_bio(bbio);
+			else
+				ret = btrfs_csum_one_bio(bbio);
+			if (ret)
+				goto fail;
+		}
 	}
 
+	__btrfs_submit_bio(bio, bioc, &smap, mirror_num);
 	return;
 fail:
 	btrfs_bio_counter_dec(fs_info);
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 58c4156caa736..8b248c9bd602b 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -576,7 +576,12 @@ int btrfs_read_chunk_tree(struct btrfs_fs_info *fs_info);
 struct btrfs_block_group *btrfs_create_chunk(struct btrfs_trans_handle *trans,
 					    u64 type);
 void btrfs_mapping_tree_free(struct extent_map_tree *tree);
-void btrfs_submit_bio(struct btrfs_fs_info *fs_info, struct bio *bio, int mirror_num);
+
+/* bio only refers to one ordered extent */
+#define REQ_BTRFS_ONE_ORDERED	REQ_DRV
+
+void btrfs_submit_bio(struct btrfs_fs_info *fs_info, struct bio *bio,
+		      int mirror_num);
 int btrfs_repair_io_failure(struct btrfs_fs_info *fs_info, u64 ino, u64 start,
 			    u64 length, u64 logical, struct page *page,
 			    unsigned int pg_offset, int mirror_num);
-- 
2.30.2

