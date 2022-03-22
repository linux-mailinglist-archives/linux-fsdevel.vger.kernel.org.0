Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3D124E439A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Mar 2022 16:57:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238801AbiCVP6v (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Mar 2022 11:58:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238882AbiCVP6l (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Mar 2022 11:58:41 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 176956E8DB;
        Tue, 22 Mar 2022 08:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=t0WXmgF2H5zh8KKShg5Ej9Ql9AfdVrVDcimGRKtlN04=; b=YavTmOnYI87JzHyUzFAUO8fXoj
        XN0R9ukv5pXIBfHCvIfCpEDriI5BvSB0HhQX8SBBTHRthkdmFp7z75EpAZu3KjRi5RmTzEf2TJM4e
        SwZfbzob7uBkZBoq4FF5WWaZtkMNX8O7WjJ9B5TwHot45jsorCFDBpc09Ykcxv9M5+wcCnervdxDl
        sdMmlwBYzHRfD9P77DQzkqZsdmwn54P2ULw4EAy+LTfZAeSXv2rWNR4bH6P4Wi7oH0VuVpvMdwCom
        H4cNPaXQqipKRVpTHfWhCJHcPiuWDqtmj85FBBnnriqE+Uysl+sQQH5ryFnfIqsQYg7K2R62iIx6i
        ZpaYJxrw==;
Received: from [2001:4bb8:19a:b822:6444:5366:9486:4da] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nWgsg-00Bauo-Mi; Tue, 22 Mar 2022 15:57:11 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>
Cc:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 24/40] btrfs: remove btrfs_end_io_wq
Date:   Tue, 22 Mar 2022 16:55:50 +0100
Message-Id: <20220322155606.1267165-25-hch@lst.de>
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

Avoid the extra allocation for all read bios by embedding a btrfs_work
and I/O end type into the btrfs_bio structure.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/compression.c |  24 +++------
 fs/btrfs/ctree.h       |   1 -
 fs/btrfs/disk-io.c     | 112 +----------------------------------------
 fs/btrfs/disk-io.h     |  10 ----
 fs/btrfs/inode.c       |  19 +++----
 fs/btrfs/super.c       |  11 +---
 fs/btrfs/volumes.c     |  44 ++++++++++++++--
 fs/btrfs/volumes.h     |  11 ++++
 8 files changed, 66 insertions(+), 166 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 419a09d924290..ae6f986058c75 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -423,20 +423,6 @@ static void end_compressed_bio_write(struct bio *bio)
 	bio_put(bio);
 }
 
-static blk_status_t submit_compressed_bio(struct btrfs_fs_info *fs_info,
-					  struct compressed_bio *cb,
-					  struct bio *bio, int mirror_num)
-{
-	blk_status_t ret;
-
-	ASSERT(bio->bi_iter.bi_size);
-	ret = btrfs_bio_wq_end_io(fs_info, bio, BTRFS_WQ_ENDIO_DATA);
-	if (ret)
-		return ret;
-	ret = btrfs_map_bio(fs_info, bio, mirror_num);
-	return ret;
-}
-
 /*
  * Allocate a compressed_bio, which will be used to read/write on-disk
  * (aka, compressed) * data.
@@ -468,6 +454,10 @@ static struct bio *alloc_compressed_bio(struct compressed_bio *cb, u64 disk_byte
 	bio->bi_iter.bi_sector = disk_bytenr >> SECTOR_SHIFT;
 	bio->bi_private = cb;
 	bio->bi_end_io = endio_func;
+	if (btrfs_op(bio) == BTRFS_MAP_WRITE)
+		btrfs_bio(bio)->end_io_type = BTRFS_ENDIO_WQ_DATA_WRITE;
+	else
+		btrfs_bio(bio)->end_io_type = BTRFS_ENDIO_WQ_DATA_READ;
 
 	em = btrfs_get_chunk_map(fs_info, disk_bytenr, fs_info->sectorsize);
 	if (IS_ERR(em)) {
@@ -594,7 +584,8 @@ blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
 					goto finish_cb;
 			}
 
-			ret = submit_compressed_bio(fs_info, cb, bio, 0);
+			ASSERT(bio->bi_iter.bi_size);
+			ret = btrfs_map_bio(fs_info, bio, 0);
 			if (ret)
 				goto finish_cb;
 			bio = NULL;
@@ -930,7 +921,8 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 						  fs_info->sectorsize);
 			sums += fs_info->csum_size * nr_sectors;
 
-			ret = submit_compressed_bio(fs_info, cb, comp_bio, mirror_num);
+			ASSERT(comp_bio->bi_iter.bi_size);
+			ret = btrfs_map_bio(fs_info, comp_bio, mirror_num);
 			if (ret)
 				goto finish_cb;
 			comp_bio = NULL;
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index ebb2d109e8bb2..c22a24ca81652 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -823,7 +823,6 @@ struct btrfs_fs_info {
 	struct btrfs_workqueue *endio_meta_workers;
 	struct btrfs_workqueue *endio_raid56_workers;
 	struct btrfs_workqueue *rmw_workers;
-	struct btrfs_workqueue *endio_meta_write_workers;
 	struct btrfs_workqueue *endio_write_workers;
 	struct btrfs_workqueue *endio_freespace_worker;
 	struct btrfs_workqueue *caching_workers;
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index f43c9ab86e617..bb910b78bbc82 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -51,7 +51,6 @@
 				 BTRFS_SUPER_FLAG_METADUMP |\
 				 BTRFS_SUPER_FLAG_METADUMP_V2)
 
-static void end_workqueue_fn(struct btrfs_work *work);
 static void btrfs_destroy_ordered_extents(struct btrfs_root *root);
 static int btrfs_destroy_delayed_refs(struct btrfs_transaction *trans,
 				      struct btrfs_fs_info *fs_info);
@@ -64,40 +63,6 @@ static int btrfs_destroy_pinned_extent(struct btrfs_fs_info *fs_info,
 static int btrfs_cleanup_transaction(struct btrfs_fs_info *fs_info);
 static void btrfs_error_commit_super(struct btrfs_fs_info *fs_info);
 
-/*
- * btrfs_end_io_wq structs are used to do processing in task context when an IO
- * is complete.  This is used during reads to verify checksums, and it is used
- * by writes to insert metadata for new file extents after IO is complete.
- */
-struct btrfs_end_io_wq {
-	struct bio *bio;
-	bio_end_io_t *end_io;
-	void *private;
-	struct btrfs_fs_info *info;
-	blk_status_t status;
-	enum btrfs_wq_endio_type metadata;
-	struct btrfs_work work;
-};
-
-static struct kmem_cache *btrfs_end_io_wq_cache;
-
-int __init btrfs_end_io_wq_init(void)
-{
-	btrfs_end_io_wq_cache = kmem_cache_create("btrfs_end_io_wq",
-					sizeof(struct btrfs_end_io_wq),
-					0,
-					SLAB_MEM_SPREAD,
-					NULL);
-	if (!btrfs_end_io_wq_cache)
-		return -ENOMEM;
-	return 0;
-}
-
-void __cold btrfs_end_io_wq_exit(void)
-{
-	kmem_cache_destroy(btrfs_end_io_wq_cache);
-}
-
 static void btrfs_free_csum_hash(struct btrfs_fs_info *fs_info)
 {
 	if (fs_info->csum_shash)
@@ -726,54 +691,6 @@ int btrfs_validate_metadata_buffer(struct btrfs_bio *bbio,
 	return ret;
 }
 
-static void end_workqueue_bio(struct bio *bio)
-{
-	struct btrfs_end_io_wq *end_io_wq = bio->bi_private;
-	struct btrfs_fs_info *fs_info;
-	struct btrfs_workqueue *wq;
-
-	fs_info = end_io_wq->info;
-	end_io_wq->status = bio->bi_status;
-
-	if (btrfs_op(bio) == BTRFS_MAP_WRITE) {
-		if (end_io_wq->metadata == BTRFS_WQ_ENDIO_METADATA)
-			wq = fs_info->endio_meta_write_workers;
-		else if (end_io_wq->metadata == BTRFS_WQ_ENDIO_FREE_SPACE)
-			wq = fs_info->endio_freespace_worker;
-		else
-			wq = fs_info->endio_write_workers;
-	} else {
-		if (end_io_wq->metadata)
-			wq = fs_info->endio_meta_workers;
-		else
-			wq = fs_info->endio_workers;
-	}
-
-	btrfs_init_work(&end_io_wq->work, end_workqueue_fn, NULL, NULL);
-	btrfs_queue_work(wq, &end_io_wq->work);
-}
-
-blk_status_t btrfs_bio_wq_end_io(struct btrfs_fs_info *info, struct bio *bio,
-			enum btrfs_wq_endio_type metadata)
-{
-	struct btrfs_end_io_wq *end_io_wq;
-
-	end_io_wq = kmem_cache_alloc(btrfs_end_io_wq_cache, GFP_NOFS);
-	if (!end_io_wq)
-		return BLK_STS_RESOURCE;
-
-	end_io_wq->private = bio->bi_private;
-	end_io_wq->end_io = bio->bi_end_io;
-	end_io_wq->info = info;
-	end_io_wq->status = 0;
-	end_io_wq->bio = bio;
-	end_io_wq->metadata = metadata;
-
-	bio->bi_private = end_io_wq;
-	bio->bi_end_io = end_workqueue_bio;
-	return 0;
-}
-
 static void run_one_async_start(struct btrfs_work *work)
 {
 	struct async_submit_bio *async;
@@ -921,10 +838,7 @@ blk_status_t btrfs_submit_metadata_bio(struct inode *inode, struct bio *bio,
 			return ret;
 	} else {
 		/* checksum validation should happen in async threads: */
-		ret = btrfs_bio_wq_end_io(fs_info, bio,
-					  BTRFS_WQ_ENDIO_METADATA);
-		if (ret)
-			return ret;
+		btrfs_bio(bio)->end_io_type = BTRFS_ENDIO_WQ_METADATA_READ;
 	}
 
 	return btrfs_map_bio(fs_info, bio, mirror_num);
@@ -1888,25 +1802,6 @@ struct btrfs_root *btrfs_get_fs_root_commit_root(struct btrfs_fs_info *fs_info,
 	return root;
 }
 
-/*
- * called by the kthread helper functions to finally call the bio end_io
- * functions.  This is where read checksum verification actually happens
- */
-static void end_workqueue_fn(struct btrfs_work *work)
-{
-	struct bio *bio;
-	struct btrfs_end_io_wq *end_io_wq;
-
-	end_io_wq = container_of(work, struct btrfs_end_io_wq, work);
-	bio = end_io_wq->bio;
-
-	bio->bi_status = end_io_wq->status;
-	bio->bi_private = end_io_wq->private;
-	bio->bi_end_io = end_io_wq->end_io;
-	bio_endio(bio);
-	kmem_cache_free(btrfs_end_io_wq_cache, end_io_wq);
-}
-
 static int cleaner_kthread(void *arg)
 {
 	struct btrfs_root *root = arg;
@@ -2219,7 +2114,6 @@ static void btrfs_stop_all_workers(struct btrfs_fs_info *fs_info)
 	 * queues can do metadata I/O operations.
 	 */
 	btrfs_destroy_workqueue(fs_info->endio_meta_workers);
-	btrfs_destroy_workqueue(fs_info->endio_meta_write_workers);
 }
 
 static void free_root_extent_buffers(struct btrfs_root *root)
@@ -2404,9 +2298,6 @@ static int btrfs_init_workqueues(struct btrfs_fs_info *fs_info)
 	fs_info->endio_meta_workers =
 		btrfs_alloc_workqueue(fs_info, "endio-meta", flags,
 				      max_active, 4);
-	fs_info->endio_meta_write_workers =
-		btrfs_alloc_workqueue(fs_info, "endio-meta-write", flags,
-				      max_active, 2);
 	fs_info->endio_raid56_workers =
 		btrfs_alloc_workqueue(fs_info, "endio-raid56", flags,
 				      max_active, 4);
@@ -2429,7 +2320,6 @@ static int btrfs_init_workqueues(struct btrfs_fs_info *fs_info)
 	if (!(fs_info->workers && fs_info->delalloc_workers &&
 	      fs_info->flush_workers &&
 	      fs_info->endio_workers && fs_info->endio_meta_workers &&
-	      fs_info->endio_meta_write_workers &&
 	      fs_info->endio_write_workers && fs_info->endio_raid56_workers &&
 	      fs_info->endio_freespace_worker && fs_info->rmw_workers &&
 	      fs_info->caching_workers && fs_info->fixup_workers &&
diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
index afe3bb96616c9..e8900c1b71664 100644
--- a/fs/btrfs/disk-io.h
+++ b/fs/btrfs/disk-io.h
@@ -17,12 +17,6 @@
  */
 #define BTRFS_BDEV_BLOCKSIZE	(4096)
 
-enum btrfs_wq_endio_type {
-	BTRFS_WQ_ENDIO_DATA,
-	BTRFS_WQ_ENDIO_METADATA,
-	BTRFS_WQ_ENDIO_FREE_SPACE,
-};
-
 static inline u64 btrfs_sb_offset(int mirror)
 {
 	u64 start = SZ_16K;
@@ -119,8 +113,6 @@ int btrfs_buffer_uptodate(struct extent_buffer *buf, u64 parent_transid,
 			  int atomic);
 int btrfs_read_buffer(struct extent_buffer *buf, u64 parent_transid, int level,
 		      struct btrfs_key *first_key);
-blk_status_t btrfs_bio_wq_end_io(struct btrfs_fs_info *info, struct bio *bio,
-			enum btrfs_wq_endio_type metadata);
 blk_status_t btrfs_wq_submit_bio(struct inode *inode, struct bio *bio,
 				 int mirror_num, unsigned long bio_flags,
 				 u64 dio_file_offset,
@@ -144,8 +136,6 @@ int btree_lock_page_hook(struct page *page, void *data,
 int btrfs_get_num_tolerated_disk_barrier_failures(u64 flags);
 int btrfs_get_free_objectid(struct btrfs_root *root, u64 *objectid);
 int btrfs_init_root_free_objectid(struct btrfs_root *root);
-int __init btrfs_end_io_wq_init(void);
-void __cold btrfs_end_io_wq_exit(void);
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 void btrfs_set_buffer_lockdep_class(u64 objectid,
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 18d54cfedf829..5a5474fac0b28 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2512,6 +2512,7 @@ blk_status_t btrfs_submit_data_bio(struct inode *inode, struct bio *bio,
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	struct btrfs_inode *bi = BTRFS_I(inode);
+	struct btrfs_bio *bbio = btrfs_bio(bio);
 	blk_status_t ret;
 
 	if (bio_op(bio) == REQ_OP_ZONE_APPEND) {
@@ -2537,14 +2538,10 @@ blk_status_t btrfs_submit_data_bio(struct inode *inode, struct bio *bio,
 		if (ret)
 			return ret;
 	} else {
-		enum btrfs_wq_endio_type metadata = BTRFS_WQ_ENDIO_DATA;
-
 		if (btrfs_is_free_space_inode(bi))
-			metadata = BTRFS_WQ_ENDIO_FREE_SPACE;
-
-		ret = btrfs_bio_wq_end_io(fs_info, bio, metadata);
-		if (ret)
-			return ret;
+			bbio->end_io_type = BTRFS_ENDIO_WQ_FREE_SPACE_READ;
+		else
+			bbio->end_io_type = BTRFS_ENDIO_WQ_DATA_READ;
 
 		if (bio_flags & EXTENT_BIO_COMPRESSED)
 			return btrfs_submit_compressed_read(inode, bio,
@@ -7739,9 +7736,7 @@ static blk_status_t submit_dio_repair_bio(struct inode *inode, struct bio *bio,
 
 	BUG_ON(bio_op(bio) == REQ_OP_WRITE);
 
-	ret = btrfs_bio_wq_end_io(fs_info, bio, BTRFS_WQ_ENDIO_DATA);
-	if (ret)
-		return ret;
+	btrfs_bio(bio)->end_io_type = BTRFS_ENDIO_WQ_DATA_WRITE;
 
 	refcount_inc(&dip->refs);
 	ret = btrfs_map_bio(fs_info, bio, mirror_num);
@@ -7865,9 +7860,7 @@ static inline blk_status_t btrfs_submit_dio_bio(struct bio *bio,
 				return ret;
 		}
 	} else {
-		ret = btrfs_bio_wq_end_io(fs_info, bio, BTRFS_WQ_ENDIO_DATA);
-		if (ret)
-			return ret;
+		btrfs_bio(bio)->end_io_type = BTRFS_ENDIO_WQ_DATA_READ;
 
 		if (!(bi->flags & BTRFS_INODE_NODATASUM)) {
 			u64 csum_offset;
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 4d947ba32da9d..33dedca4f0862 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1835,8 +1835,6 @@ static void btrfs_resize_thread_pool(struct btrfs_fs_info *fs_info,
 	btrfs_workqueue_set_max(fs_info->caching_workers, new_pool_size);
 	btrfs_workqueue_set_max(fs_info->endio_workers, new_pool_size);
 	btrfs_workqueue_set_max(fs_info->endio_meta_workers, new_pool_size);
-	btrfs_workqueue_set_max(fs_info->endio_meta_write_workers,
-				new_pool_size);
 	btrfs_workqueue_set_max(fs_info->endio_write_workers, new_pool_size);
 	btrfs_workqueue_set_max(fs_info->endio_freespace_worker, new_pool_size);
 	btrfs_workqueue_set_max(fs_info->delayed_workers, new_pool_size);
@@ -2593,13 +2591,9 @@ static int __init init_btrfs_fs(void)
 	if (err)
 		goto free_delayed_ref;
 
-	err = btrfs_end_io_wq_init();
-	if (err)
-		goto free_prelim_ref;
-
 	err = btrfs_interface_init();
 	if (err)
-		goto free_end_io_wq;
+		goto free_prelim_ref;
 
 	btrfs_print_mod_info();
 
@@ -2615,8 +2609,6 @@ static int __init init_btrfs_fs(void)
 
 unregister_ioctl:
 	btrfs_interface_exit();
-free_end_io_wq:
-	btrfs_end_io_wq_exit();
 free_prelim_ref:
 	btrfs_prelim_ref_exit();
 free_delayed_ref:
@@ -2654,7 +2646,6 @@ static void __exit exit_btrfs_fs(void)
 	extent_state_cache_exit();
 	extent_io_exit();
 	btrfs_interface_exit();
-	btrfs_end_io_wq_exit();
 	unregister_filesystem(&btrfs_fs_type);
 	btrfs_exit_sysfs();
 	btrfs_cleanup_fs_uuids();
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 9d1f8c27eff33..9a1eb1166d72f 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6659,11 +6659,38 @@ int btrfs_map_sblock(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 	return __btrfs_map_block(fs_info, op, logical, length, bioc_ret, 0, 1);
 }
 
-static inline void btrfs_end_bioc(struct btrfs_io_context *bioc)
+static struct btrfs_workqueue *btrfs_end_io_wq(struct btrfs_io_context *bioc)
 {
+	struct btrfs_fs_info *fs_info = bioc->fs_info;
+
+	switch (btrfs_bio(bioc->orig_bio)->end_io_type) {
+	case BTRFS_ENDIO_WQ_DATA_READ:
+		return fs_info->endio_workers;
+	case BTRFS_ENDIO_WQ_DATA_WRITE:
+		return fs_info->endio_write_workers;
+	case BTRFS_ENDIO_WQ_METADATA_READ:
+		return fs_info->endio_meta_workers;
+	case BTRFS_ENDIO_WQ_FREE_SPACE_READ:
+		return fs_info->endio_freespace_worker;
+	default:
+		return NULL;
+	}
+}
+
+static void btrfs_end_bio_work(struct btrfs_work *work)
+{
+	struct btrfs_bio *bbio = container_of(work, struct btrfs_bio, work);
+
+	bio_endio(&bbio->bio);
+}
+
+static void btrfs_end_bioc(struct btrfs_io_context *bioc, bool async)
+{
+	struct btrfs_workqueue *wq = async ? btrfs_end_io_wq(bioc) : NULL;
 	struct bio *bio = bioc->orig_bio;
+	struct btrfs_bio *bbio = btrfs_bio(bio);
 
-	btrfs_bio(bio)->mirror_num = bioc->mirror_num;
+	bbio->mirror_num = bioc->mirror_num;
 	bio->bi_private = bioc->private;
 	bio->bi_end_io = bioc->end_io;
 
@@ -6675,7 +6702,14 @@ static inline void btrfs_end_bioc(struct btrfs_io_context *bioc)
 		bio->bi_status = BLK_STS_IOERR;
 	else
 		bio->bi_status = BLK_STS_OK;
-	bio_endio(bio);
+
+	if (wq) {
+		btrfs_init_work(&bbio->work, btrfs_end_bio_work, NULL, NULL);
+		btrfs_queue_work(wq, &bbio->work);
+	} else {
+		bio_endio(bio);
+	}
+
 	btrfs_put_bioc(bioc);
 }
 
@@ -6707,7 +6741,7 @@ static void btrfs_end_bio(struct bio *bio)
 
 	btrfs_bio_counter_dec(bioc->fs_info);
 	if (atomic_dec_and_test(&bioc->stripes_pending))
-		btrfs_end_bioc(bioc);
+		btrfs_end_bioc(bioc, true);
 }
 
 static void submit_stripe_bio(struct btrfs_io_context *bioc, struct bio *bio,
@@ -6805,7 +6839,7 @@ blk_status_t btrfs_map_bio(struct btrfs_fs_info *fs_info, struct bio *bio,
 		    !test_bit(BTRFS_DEV_STATE_WRITEABLE, &dev->dev_state))) {
 			atomic_inc(&bioc->error);
 			if (atomic_dec_and_test(&bioc->stripes_pending))
-				btrfs_end_bioc(bioc);
+				btrfs_end_bioc(bioc, false);
 			continue;
 		}
 
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index a4f942547002e..51a27180004eb 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -315,6 +315,14 @@ struct btrfs_fs_devices {
 				- 2 * sizeof(struct btrfs_chunk))	\
 				/ sizeof(struct btrfs_stripe) + 1)
 
+enum btrfs_endio_type {
+	BTRFS_ENDIO_NONE = 0,
+	BTRFS_ENDIO_WQ_DATA_READ,
+	BTRFS_ENDIO_WQ_DATA_WRITE,
+	BTRFS_ENDIO_WQ_METADATA_READ,
+	BTRFS_ENDIO_WQ_FREE_SPACE_READ,
+};
+
 /*
  * Additional info to pass along bio.
  *
@@ -324,6 +332,9 @@ struct btrfs_bio {
 	struct inode *inode;
 
 	unsigned int mirror_num;
+	
+	enum btrfs_endio_type end_io_type;
+	struct btrfs_work work;
 
 	/* for direct I/O */
 	u64 file_offset;
-- 
2.30.2

