Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FC6C4E43A9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Mar 2022 16:58:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238805AbiCVP70 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Mar 2022 11:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238868AbiCVP7S (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Mar 2022 11:59:18 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18695710CC;
        Tue, 22 Mar 2022 08:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=f1AXuzYQGZotqabDrm8ZGJuaGvW51rTocl8VBtnmo5M=; b=Hli9/9Z5oIBc7DscaOhEvipwF1
        aO9s744u3pV5JByXJxAm+p3w/OpRsuBzrTgU8C4wfQxZRGLeLzmzVlBiKpr3ulwFEfYxbtKNu8Lu7
        uBZXQJyAm3TjgCby0WlVvcoPYgMwCquehm4yr7DJ+AwjXImTJ84gkJDGUshyd7C+mRqYHfeYUu97V
        1safvuGtc7mjIPDslMyHXkoTCjhgiFd9yXCcipSpX2Lgmna4kg5Xv0Wbq/MZmU8AXMD2DZ+bCYf2t
        +0MjkWP0G1USBnWdjb53TDZNiOsTJTD30l+PuRpnd0iPyxt3+YHblkQm4S7PvfrPV1J7Iw0O3tKNe
        D5LvgWlA==;
Received: from [2001:4bb8:19a:b822:6444:5366:9486:4da] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nWgtE-00Bb9D-5u; Tue, 22 Mar 2022 15:57:44 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>
Cc:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 37/40] btrfs: add a btrfs_get_stripe_info helper
Date:   Tue, 22 Mar 2022 16:56:03 +0100
Message-Id: <20220322155606.1267165-38-hch@lst.de>
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

---
 fs/btrfs/compression.c | 26 ++++++++-----------------
 fs/btrfs/extent_io.c   | 24 ++++++++---------------
 fs/btrfs/inode.c       | 32 ++++++++++--------------------
 fs/btrfs/volumes.c     | 44 +++++++++++++++++++++++++++++++++++++++---
 fs/btrfs/volumes.h     | 20 ++-----------------
 5 files changed, 69 insertions(+), 77 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index ae6f986058c75..fca025c327a7e 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -445,10 +445,9 @@ static struct bio *alloc_compressed_bio(struct compressed_bio *cb, u64 disk_byte
 					u64 *next_stripe_start)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(cb->inode->i_sb);
-	struct btrfs_io_geometry geom;
-	struct extent_map *em;
+	struct block_device *bdev;
 	struct bio *bio;
-	int ret;
+	u64 len;
 
 	bio = btrfs_bio_alloc(cb->inode, BIO_MAX_VECS, opf);
 	bio->bi_iter.bi_sector = disk_bytenr >> SECTOR_SHIFT;
@@ -459,23 +458,14 @@ static struct bio *alloc_compressed_bio(struct compressed_bio *cb, u64 disk_byte
 	else
 		btrfs_bio(bio)->end_io_type = BTRFS_ENDIO_WQ_DATA_READ;
 
-	em = btrfs_get_chunk_map(fs_info, disk_bytenr, fs_info->sectorsize);
-	if (IS_ERR(em)) {
-		bio_put(bio);
-		return ERR_CAST(em);
-	}
+	bdev = btrfs_get_stripe_info(fs_info, btrfs_op(bio), disk_bytenr,
+			      fs_info->sectorsize, &len);
+	if (IS_ERR(bdev))
+		return ERR_CAST(bdev);
 
 	if (bio_op(bio) == REQ_OP_ZONE_APPEND)
-		bio_set_dev(bio, em->map_lookup->stripes[0].dev->bdev);
-
-	ret = btrfs_get_io_geometry(fs_info, em, btrfs_op(bio), disk_bytenr, &geom);
-	free_extent_map(em);
-	if (ret < 0) {
-		bio_put(bio);
-		return ERR_PTR(ret);
-	}
-	*next_stripe_start = disk_bytenr + geom.len;
-
+		bio_set_dev(bio, bdev);
+	*next_stripe_start = disk_bytenr + len;
 	return bio;
 }
 
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index bfd91ed27bd14..10fc5e4dd14a3 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3235,11 +3235,10 @@ static int calc_bio_boundaries(struct btrfs_bio_ctrl *bio_ctrl,
 			       struct btrfs_inode *inode, u64 file_offset)
 {
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
-	struct btrfs_io_geometry geom;
 	struct btrfs_ordered_extent *ordered;
-	struct extent_map *em;
 	u64 logical = (bio_ctrl->bio->bi_iter.bi_sector << SECTOR_SHIFT);
-	int ret;
+	struct block_device *bdev;
+	u64 len;
 
 	/*
 	 * Pages for compressed extent are never submitted to disk directly,
@@ -3253,19 +3252,12 @@ static int calc_bio_boundaries(struct btrfs_bio_ctrl *bio_ctrl,
 		bio_ctrl->len_to_stripe_boundary = U32_MAX;
 		return 0;
 	}
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
+
+	bdev = btrfs_get_stripe_info(fs_info, btrfs_op(bio_ctrl->bio), logical,
+			      fs_info->sectorsize, &len);
+	if (IS_ERR(bdev))
+		return PTR_ERR(bdev);
+	bio_ctrl->len_to_stripe_boundary = min(len, (u64)U32_MAX);
 
 	if (bio_op(bio_ctrl->bio) != REQ_OP_ZONE_APPEND) {
 		bio_ctrl->len_to_oe_boundary = U32_MAX;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index d4faed31d36a4..3f7e1779ff19f 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7944,12 +7944,9 @@ static void btrfs_submit_direct(const struct iomap_iter *iter,
 	u64 submit_len;
 	u64 clone_offset = 0;
 	u64 clone_len;
-	u64 logical;
-	int ret;
 	blk_status_t status;
-	struct btrfs_io_geometry geom;
 	struct btrfs_dio_data *dio_data = iter->private;
-	struct extent_map *em = NULL;
+	u64 len;
 
 	dip = btrfs_create_dio_private(dio_bio, inode, file_offset);
 	if (!dip) {
@@ -7978,21 +7975,16 @@ static void btrfs_submit_direct(const struct iomap_iter *iter,
 	submit_len = dio_bio->bi_iter.bi_size;
 
 	do {
-		logical = start_sector << 9;
-		em = btrfs_get_chunk_map(fs_info, logical, submit_len);
-		if (IS_ERR(em)) {
-			status = errno_to_blk_status(PTR_ERR(em));
-			em = NULL;
-			goto out_err_em;
-		}
-		ret = btrfs_get_io_geometry(fs_info, em, btrfs_op(dio_bio),
-					    logical, &geom);
-		if (ret) {
-			status = errno_to_blk_status(ret);
-			goto out_err_em;
+		struct block_device *bdev;
+
+		bdev = btrfs_get_stripe_info(fs_info, btrfs_op(dio_bio),
+				      start_sector << 9, submit_len, &len);
+		if (IS_ERR(bdev)) {
+			status = errno_to_blk_status(PTR_ERR(bdev));
+			goto out_err;
 		}
 
-		clone_len = min(submit_len, geom.len);
+		clone_len = min(submit_len, len);
 		ASSERT(clone_len <= UINT_MAX);
 
 		/*
@@ -8044,20 +8036,16 @@ static void btrfs_submit_direct(const struct iomap_iter *iter,
 			bio_put(bio);
 			if (submit_len > 0)
 				refcount_dec(&dip->refs);
-			goto out_err_em;
+			goto out_err;
 		}
 
 		dio_data->submitted += clone_len;
 		clone_offset += clone_len;
 		start_sector += clone_len >> 9;
 		file_offset += clone_len;
-
-		free_extent_map(em);
 	} while (submit_len > 0);
 	return;
 
-out_err_em:
-	free_extent_map(em);
 out_err:
 	dip->dio_bio->bi_status = status;
 	btrfs_dio_private_put(dip);
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 7392b9f2a3323..f70bb3569a7ae 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6301,6 +6301,21 @@ static bool need_full_stripe(enum btrfs_map_op op)
 	return (op == BTRFS_MAP_WRITE || op == BTRFS_MAP_GET_READ_MIRRORS);
 }
 
+struct btrfs_io_geometry {
+	/* remaining bytes before crossing a stripe */
+	u64 len;
+	/* offset of logical address in chunk */
+	u64 offset;
+	/* length of single IO stripe */
+	u64 stripe_len;
+	/* number of stripe where address falls */
+	u64 stripe_nr;
+	/* offset of address in stripe */
+	u64 stripe_offset;
+	/* offset of raid56 stripe into the chunk */
+	u64 raid56_stripe_offset;
+};
+
 /*
  * Calculate the geometry of a particular (address, len) tuple. This
  * information is used to calculate how big a particular bio can get before it
@@ -6315,9 +6330,10 @@ static bool need_full_stripe(enum btrfs_map_op op)
  * Returns < 0 in case a chunk for the given logical address cannot be found,
  * usually shouldn't happen unless @logical is corrupted, 0 otherwise.
  */
-int btrfs_get_io_geometry(struct btrfs_fs_info *fs_info, struct extent_map *em,
-			  enum btrfs_map_op op, u64 logical,
-			  struct btrfs_io_geometry *io_geom)
+static int btrfs_get_io_geometry(struct btrfs_fs_info *fs_info,
+		struct extent_map *em,
+		enum btrfs_map_op op, u64 logical,
+		struct btrfs_io_geometry *io_geom)
 {
 	struct map_lookup *map;
 	u64 len;
@@ -6394,6 +6410,28 @@ int btrfs_get_io_geometry(struct btrfs_fs_info *fs_info, struct extent_map *em,
 	return 0;
 }
 
+struct block_device *btrfs_get_stripe_info(struct btrfs_fs_info *fs_info,
+		enum btrfs_map_op op, u64 logical, u64 len, u64 *lenp)
+{
+	struct btrfs_io_geometry geom;
+	struct block_device *bdev;
+	struct extent_map *em;
+	int ret;
+
+	em = btrfs_get_chunk_map(fs_info, logical, len);
+	if (IS_ERR(em))
+		return ERR_CAST(em);
+
+	bdev = em->map_lookup->stripes[0].dev->bdev;
+
+	ret = btrfs_get_io_geometry(fs_info, em, op, logical, &geom);
+	free_extent_map(em);
+	if (ret < 0)
+		return ERR_PTR(ret);
+	*lenp = geom.len;
+	return bdev;
+}
+
 static int __btrfs_map_block(struct btrfs_fs_info *fs_info,
 		enum btrfs_map_op op, u64 logical, u64 *length,
 		struct btrfs_io_context **bioc_ret, struct btrfs_bio *bbio,
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 5b0e7602434b0..c6425760f69da 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -17,21 +17,6 @@ extern struct mutex uuid_mutex;
 
 #define BTRFS_STRIPE_LEN	SZ_64K
 
-struct btrfs_io_geometry {
-	/* remaining bytes before crossing a stripe */
-	u64 len;
-	/* offset of logical address in chunk */
-	u64 offset;
-	/* length of single IO stripe */
-	u64 stripe_len;
-	/* number of stripe where address falls */
-	u64 stripe_nr;
-	/* offset of address in stripe */
-	u64 stripe_offset;
-	/* offset of raid56 stripe into the chunk */
-	u64 raid56_stripe_offset;
-};
-
 /*
  * Use sequence counter to get consistent device stat data on
  * 32-bit processors.
@@ -520,9 +505,8 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 int btrfs_map_sblock(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 		     u64 logical, u64 *length,
 		     struct btrfs_io_context **bioc_ret);
-int btrfs_get_io_geometry(struct btrfs_fs_info *fs_info, struct extent_map *map,
-			  enum btrfs_map_op op, u64 logical,
-			  struct btrfs_io_geometry *io_geom);
+struct block_device *btrfs_get_stripe_info(struct btrfs_fs_info *fs_info,
+		enum btrfs_map_op op, u64 logical, u64 length, u64 *lenp);
 int btrfs_read_sys_array(struct btrfs_fs_info *fs_info);
 int btrfs_read_chunk_tree(struct btrfs_fs_info *fs_info);
 struct btrfs_block_group *btrfs_create_chunk(struct btrfs_trans_handle *trans,
-- 
2.30.2

