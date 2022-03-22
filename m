Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0E8C4E439E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Mar 2022 16:57:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238778AbiCVP7L (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Mar 2022 11:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235291AbiCVP6n (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Mar 2022 11:58:43 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E51246E8FD;
        Tue, 22 Mar 2022 08:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=J9uikMvsO0bRlj/ESmQUPcis0weRZhCS6c9pbmB37QA=; b=EKLJoMjaSySly0wzoa+puERxlg
        0OQZQqvN/rZKN2eAR+XyqpbL5MIPZemBvx5E3NFJTxZImUlUlKMmihVuAM2KL/BeSN8Cg84H+SDqD
        jILZHHLwZ0GFqPXgszqrYhSVXWdrmUyx3vHVG8oPTzcHlA2lGscuQbrMWlL5t/yVUoPN468ONK6sY
        rrGoE6CE/n4mfGfpYvsbRctnVra+08KMgedi7RdJrX6XKnr8Lw71loTo5f5PBb0388vx0rSkqDcTh
        ER8GaojisLlaDF23oF/wwuU21mEQBUR29aIf5p5hh+8Pfk6yirZNJGn+S/f8B7Me8TP+VjkJarsyU
        VHiae9uA==;
Received: from [2001:4bb8:19a:b822:6444:5366:9486:4da] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nWgsj-00Baw2-BR; Tue, 22 Mar 2022 15:57:13 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>
Cc:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 25/40] btrfs: remove btrfs_wq_submit_bio
Date:   Tue, 22 Mar 2022 16:55:51 +0100
Message-Id: <20220322155606.1267165-26-hch@lst.de>
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

Reuse the btrfs_work in struct btrfs_bio for asynchronous submission
and remove the extra allocation for async write bios.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/disk-io.c | 122 +++++++++++++--------------------------------
 fs/btrfs/disk-io.h |   8 +--
 fs/btrfs/inode.c   |  42 +++++++++-------
 3 files changed, 62 insertions(+), 110 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index bb910b78bbc82..59c1dc0b37399 100644
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
  * Lockdep class keys for extent_buffer->lock's in this root.  For a given
  * eb, the lockdep key is determined by the btrfs_root it belongs to and
@@ -691,18 +674,6 @@ int btrfs_validate_metadata_buffer(struct btrfs_bio *bbio,
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
 /*
  * In order to insert checksums into the metadata in large chunks, we wait
  * until bio submission time.   All the pages in the bio are checksummed and
@@ -711,72 +682,51 @@ static void run_one_async_start(struct btrfs_work *work)
  * At IO completion time the csums attached on the ordered extent record are
  * inserted into the tree.
  */
-static void run_one_async_done(struct btrfs_work *work)
+static void btrfs_submit_bio_work(struct btrfs_work *work)
 {
-	struct async_submit_bio *async;
-	struct inode *inode;
+	struct btrfs_bio *bbio = container_of(work, struct btrfs_bio, work);
+	struct btrfs_fs_info *fs_info = btrfs_sb(bbio->inode->i_sb);
+	struct bio *bio = &bbio->bio;
 	blk_status_t ret;
 
-	async = container_of(work, struct  async_submit_bio, work);
-	inode = async->inode;
+	/* Ensure the bio doesn't go away while linked into the workqueue */
+	bio_get(bio);
 
 	/* If an error occurred we just want to clean up the bio and move on */
-	if (async->status) {
-		async->bio->bi_status = async->status;
-		bio_endio(async->bio);
+	if (bio->bi_status) {
+		bio_endio(bio);
 		return;
 	}
 
 	/*
-	 * All of the bios that pass through here are from async helpers.
-	 * Use REQ_CGROUP_PUNT to issue them from the owning cgroup's context.
-	 * This changes nothing when cgroups aren't in use.
+	 * Use REQ_CGROUP_PUNT to issue the bio from the owning cgroup's
+	 * context. This changes nothing when cgroups aren't in use.
 	 */
-	async->bio->bi_opf |= REQ_CGROUP_PUNT;
-	ret = btrfs_map_bio(btrfs_sb(inode->i_sb), async->bio, async->mirror_num);
+	bio->bi_opf |= REQ_CGROUP_PUNT;
+	ret = btrfs_map_bio(fs_info, bio, bbio->mirror_num);
 	if (ret) {
-		async->bio->bi_status = ret;
-		bio_endio(async->bio);
+		bio->bi_status = ret;
+		bio_endio(bio);
 	}
 }
 
-static void run_one_async_free(struct btrfs_work *work)
+static void btrfs_submit_bio_done(struct btrfs_work *work)
 {
-	struct async_submit_bio *async;
+	struct btrfs_bio *bbio = container_of(work, struct btrfs_bio, work);
 
-	async = container_of(work, struct  async_submit_bio, work);
-	kfree(async);
+	bio_put(&bbio->bio);
 }
 
-blk_status_t btrfs_wq_submit_bio(struct inode *inode, struct bio *bio,
-				 int mirror_num, unsigned long bio_flags,
-				 u64 dio_file_offset,
-				 extent_submit_bio_start_t *submit_bio_start)
+void btrfs_submit_bio_async(struct btrfs_bio *bbio,
+		void (*start)(struct btrfs_work *work))
 {
-	struct btrfs_fs_info *fs_info = BTRFS_I(inode)->root->fs_info;
-	struct async_submit_bio *async;
+	ASSERT(bbio->end_io_type == BTRFS_ENDIO_NONE);
 
-	async = kmalloc(sizeof(*async), GFP_NOFS);
-	if (!async)
-		return BLK_STS_RESOURCE;
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
-		btrfs_set_work_high_priority(&async->work);
-
-	btrfs_queue_work(fs_info->workers, &async->work);
-	return 0;
+	btrfs_init_work(&bbio->work, start, btrfs_submit_bio_work,
+			btrfs_submit_bio_done);
+	if (op_is_sync(bbio->bio.bi_opf))
+		btrfs_set_work_high_priority(&bbio->work);
+	btrfs_queue_work(btrfs_sb(bbio->inode->i_sb)->workers, &bbio->work);
 }
 
 static blk_status_t btree_csum_one_bio(struct bio *bio)
@@ -797,14 +747,11 @@ static blk_status_t btree_csum_one_bio(struct bio *bio)
 	return errno_to_blk_status(ret);
 }
 
-static blk_status_t btree_submit_bio_start(struct inode *inode, struct bio *bio,
-					   u64 dio_file_offset)
+static void btree_submit_bio_start(struct btrfs_work *work)
 {
-	/*
-	 * when we're called for a write, we're already in the async
-	 * submission context.  Just jump into btrfs_map_bio
-	 */
-	return btree_csum_one_bio(bio);
+	struct btrfs_bio *bbio = container_of(work, struct btrfs_bio, work);
+
+	bbio->bio.bi_status = btree_csum_one_bio(&bbio->bio);
 }
 
 /*
@@ -827,18 +774,21 @@ blk_status_t btrfs_submit_metadata_bio(struct inode *inode, struct bio *bio,
 				       int mirror_num)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_bio *bbio = btrfs_bio(bio);
 	blk_status_t ret;
 
 	if (btrfs_op(bio) == BTRFS_MAP_WRITE) {
-		if (should_async_write(fs_info, BTRFS_I(inode)))
-			return btrfs_wq_submit_bio(inode, bio, mirror_num, 0, 0,
-						   btree_submit_bio_start);
+		if (should_async_write(fs_info, BTRFS_I(inode))) {
+			bbio->mirror_num = mirror_num;
+			btrfs_submit_bio_async(bbio, btree_submit_bio_start);
+			return BLK_STS_OK;
+		}
 		ret = btree_csum_one_bio(bio);
 		if (ret)
 			return ret;
 	} else {
 		/* checksum validation should happen in async threads: */
-		btrfs_bio(bio)->end_io_type = BTRFS_ENDIO_WQ_METADATA_READ;
+		bbio->end_io_type = BTRFS_ENDIO_WQ_METADATA_READ;
 	}
 
 	return btrfs_map_bio(fs_info, bio, mirror_num);
diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
index e8900c1b71664..25fe657ebbac1 100644
--- a/fs/btrfs/disk-io.h
+++ b/fs/btrfs/disk-io.h
@@ -113,12 +113,8 @@ int btrfs_buffer_uptodate(struct extent_buffer *buf, u64 parent_transid,
 			  int atomic);
 int btrfs_read_buffer(struct extent_buffer *buf, u64 parent_transid, int level,
 		      struct btrfs_key *first_key);
-blk_status_t btrfs_wq_submit_bio(struct inode *inode, struct bio *bio,
-				 int mirror_num, unsigned long bio_flags,
-				 u64 dio_file_offset,
-				 extent_submit_bio_start_t *submit_bio_start);
-blk_status_t btrfs_submit_bio_done(void *private_data, struct bio *bio,
-			  int mirror_num);
+void btrfs_submit_bio_async(struct btrfs_bio *bbio,
+		void (*start)(struct btrfs_work *work));
 int btrfs_alloc_log_tree_node(struct btrfs_trans_handle *trans,
 			      struct btrfs_root *root);
 int btrfs_init_log_root_tree(struct btrfs_trans_handle *trans,
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 5a5474fac0b28..70d82effe5e37 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2300,17 +2300,19 @@ void btrfs_clear_delalloc_extent(struct inode *vfs_inode,
 }
 
 /*
- * in order to insert checksums into the metadata in large chunks,
- * we wait until bio submission time.   All the pages in the bio are
- * checksummed and sums are attached onto the ordered extent record.
+ * In order to insert checksums into the metadata in large chunks, we wait until
+ * bio submission time.   All the pages in the bio are checksummed and sums are
+ * attached onto the ordered extent record.
  *
- * At IO completion time the cums attached on the ordered extent record
- * are inserted into the btree
+ * At I/O completion time the cums attached on the ordered extent record are
+ * inserted into the btree.
  */
-static blk_status_t btrfs_submit_bio_start(struct inode *inode, struct bio *bio,
-					   u64 dio_file_offset)
+static void btrfs_submit_bio_start(struct btrfs_work *work)
 {
-	return btrfs_csum_one_bio(BTRFS_I(inode), bio, 0, 0);
+	struct btrfs_bio *bbio = container_of(work, struct btrfs_bio, work);
+
+	bbio->bio.bi_status =
+		btrfs_csum_one_bio(BTRFS_I(bbio->inode), &bbio->bio, 0, 0);
 }
 
 /*
@@ -2531,8 +2533,9 @@ blk_status_t btrfs_submit_data_bio(struct inode *inode, struct bio *bio,
 			/* csum items have already been cloned */
 			if (btrfs_is_data_reloc_root(bi->root))
 				goto mapit;
-			return btrfs_wq_submit_bio(inode, bio, mirror_num, bio_flags,
-						  0, btrfs_submit_bio_start);
+			bbio->mirror_num = mirror_num;
+			btrfs_submit_bio_async(bbio, btrfs_submit_bio_start);
+			return BLK_STS_OK;
 		}
 		ret = btrfs_csum_one_bio(bi, bio, 0, 0);
 		if (ret)
@@ -7803,11 +7806,12 @@ static void __endio_write_update_ordered(struct btrfs_inode *inode,
 				       finish_ordered_fn, uptodate);
 }
 
-static blk_status_t btrfs_submit_bio_start_direct_io(struct inode *inode,
-						     struct bio *bio,
-						     u64 dio_file_offset)
+static void btrfs_submit_bio_start_direct_io(struct btrfs_work *work)
 {
-	return btrfs_csum_one_bio(BTRFS_I(inode), bio, dio_file_offset, 1);
+	struct btrfs_bio *bbio = container_of(work, struct btrfs_bio, work);
+
+	bbio->bio.bi_status = btrfs_csum_one_bio(BTRFS_I(bbio->inode),
+			&bbio->bio, bbio->file_offset, 1);
 }
 
 static void btrfs_end_dio_bio(struct bio *bio)
@@ -7841,15 +7845,17 @@ static inline blk_status_t btrfs_submit_dio_bio(struct bio *bio,
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	struct btrfs_inode *bi = BTRFS_I(inode);
 	struct btrfs_dio_private *dip = bio->bi_private;
+	struct btrfs_bio *bbio = btrfs_bio(bio);
 	blk_status_t ret;
 
 	if (btrfs_op(bio) == BTRFS_MAP_WRITE) {
 		if (!(bi->flags & BTRFS_INODE_NODATASUM)) {
 			/* See btrfs_submit_data_bio for async submit rules */
-			if (async_submit && !atomic_read(&bi->sync_writers))
-				return btrfs_wq_submit_bio(inode, bio, 0, 0,
-					file_offset,
+			if (async_submit && !atomic_read(&bi->sync_writers)) {
+				btrfs_submit_bio_async(bbio,
 					btrfs_submit_bio_start_direct_io);
+				return BLK_STS_OK;
+			}
 
 			/*
 			 * If we aren't doing async submit, calculate the csum of the
@@ -7860,7 +7866,7 @@ static inline blk_status_t btrfs_submit_dio_bio(struct bio *bio,
 				return ret;
 		}
 	} else {
-		btrfs_bio(bio)->end_io_type = BTRFS_ENDIO_WQ_DATA_READ;
+		bbio->end_io_type = BTRFS_ENDIO_WQ_DATA_READ;
 
 		if (!(bi->flags & BTRFS_INODE_NODATASUM)) {
 			u64 csum_offset;
-- 
2.30.2

