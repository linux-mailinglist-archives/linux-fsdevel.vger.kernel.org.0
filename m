Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0C43676482
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Jan 2023 07:52:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbjAUGwN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 21 Jan 2023 01:52:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbjAUGvy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 21 Jan 2023 01:51:54 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD52E73157;
        Fri, 20 Jan 2023 22:51:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=faMyLbqo3D/mbj8LGlVszOJAGYAYtVDJPWUkJB3m7tE=; b=xSJXM64rgXVmsj9mxlp9weUqxV
        UdRBU4VL7Qdjrj8v993ejXSVJvhJndZsAVgPthIafdAn287YhbKpOZmlT3M/tF15X/gsPirWjdQte
        baCy5S36mW9KPcGFOqAkME7vZwH4Idl3Qclq02u9lNHOkGeCGXkcZ9cjVyJVyen3QHeGqOCfuyXNn
        XZhQqywNht52o2kNIYMSydr0O20vBH6VGyOLvRA0GuYZrOl5PwzH0EaqV4+wfW2fDuvmRk+HIUuOW
        Agbr+D0SZ+dd7nTgW3HuceKQ8u3qJIVWaalc6cyvMVqh6NqfqXA6rWDtorSqeErfO/iza7eiem4ez
        zcqcBkaw==;
Received: from [2001:4bb8:19a:2039:6754:cc81:9ace:36fc] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pJ7j0-00DRbi-77; Sat, 21 Jan 2023 06:51:38 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>, Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 24/34] btrfs: pass the iomap bio to btrfs_submit_bio
Date:   Sat, 21 Jan 2023 07:50:21 +0100
Message-Id: <20230121065031.1139353-25-hch@lst.de>
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

Now that btrfs_submit_bio splits the bio when crossing stripe boundaries,
there is no need for the higher level code to do that manually.

For direct I/O this is really helpful, as btrfs_submit_io can now simply
take the bio allocated by iomap and send it on to btrfs_submit_bio
instead of allocating clones.

For that to work, the bio embedded into struct btrfs_dio_private needs to
become a full btrfs_bio as expected by btrfs_submit_bio.

With this change there is a single work item to offload the entire iomap
bio so the heuristics to skip async processing for bios that were split
isn't needed anymore either.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/bio.c   |  22 +------
 fs/btrfs/bio.h   |   6 +-
 fs/btrfs/inode.c | 162 ++++++++++-------------------------------------
 3 files changed, 37 insertions(+), 153 deletions(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index ff42b783902140..5d4b67fc44f4de 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -31,9 +31,8 @@ struct btrfs_failed_bio {
  * Initialize a btrfs_bio structure.  This skips the embedded bio itself as it
  * is already initialized by the block layer.
  */
-static inline void btrfs_bio_init(struct btrfs_bio *bbio,
-				  struct btrfs_inode *inode,
-				  btrfs_bio_end_io_t end_io, void *private)
+void btrfs_bio_init(struct btrfs_bio *bbio, struct btrfs_inode *inode,
+			   btrfs_bio_end_io_t end_io, void *private)
 {
 	memset(bbio, 0, offsetof(struct btrfs_bio, bio));
 	bbio->inode = inode;
@@ -60,23 +59,6 @@ struct bio *btrfs_bio_alloc(unsigned int nr_vecs, blk_opf_t opf,
 	return bio;
 }
 
-struct bio *btrfs_bio_clone_partial(struct bio *orig, u64 offset, u64 size,
-				    struct btrfs_inode *inode,
-				    btrfs_bio_end_io_t end_io, void *private)
-{
-	struct bio *bio;
-	struct btrfs_bio *bbio;
-
-	ASSERT(offset <= UINT_MAX && size <= UINT_MAX);
-
-	bio = bio_alloc_clone(orig->bi_bdev, orig, GFP_NOFS, &btrfs_bioset);
-	bbio = btrfs_bio(bio);
-	btrfs_bio_init(bbio, inode, end_io, private);
-
-	bio_trim(bio, offset >> 9, size >> 9);
-	return bio;
-}
-
 static struct bio *btrfs_split_bio(struct bio *orig, u64 map_length)
 {
 	struct btrfs_bio *orig_bbio = btrfs_bio(orig);
diff --git a/fs/btrfs/bio.h b/fs/btrfs/bio.h
index 7c50f757cf5106..5acbcc18026d52 100644
--- a/fs/btrfs/bio.h
+++ b/fs/btrfs/bio.h
@@ -73,13 +73,11 @@ static inline struct btrfs_bio *btrfs_bio(struct bio *bio)
 int __init btrfs_bioset_init(void);
 void __cold btrfs_bioset_exit(void);
 
+void btrfs_bio_init(struct btrfs_bio *bbio, struct btrfs_inode *inode,
+		    btrfs_bio_end_io_t end_io, void *private);
 struct bio *btrfs_bio_alloc(unsigned int nr_vecs, blk_opf_t opf,
 			    struct btrfs_inode *inode,
 			    btrfs_bio_end_io_t end_io, void *private);
-struct bio *btrfs_bio_clone_partial(struct bio *orig, u64 offset, u64 size,
-				    struct btrfs_inode *inode,
-				    btrfs_bio_end_io_t end_io, void *private);
-
 
 static inline void btrfs_bio_end_io(struct btrfs_bio *bbio, blk_status_t status)
 {
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index da71e2a6a2e68b..46ff73c09da7d3 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -84,24 +84,12 @@ struct btrfs_dio_data {
 };
 
 struct btrfs_dio_private {
-	struct btrfs_inode *inode;
-
-	/*
-	 * Since DIO can use anonymous page, we cannot use page_offset() to
-	 * grab the file offset, thus need a dedicated member for file offset.
-	 */
+	/* Range of I/O */
 	u64 file_offset;
-	/* Used for bio::bi_size */
 	u32 bytes;
 
-	/*
-	 * References to this structure. There is one reference per in-flight
-	 * bio plus one while we're still setting up.
-	 */
-	refcount_t refs;
-
 	/* This must be last */
-	struct bio bio;
+	struct btrfs_bio bbio;
 };
 
 static struct bio_set btrfs_dio_bioset;
@@ -7767,132 +7755,48 @@ static int btrfs_dio_iomap_end(struct inode *inode, loff_t pos, loff_t length,
 	return ret;
 }
 
-static void btrfs_dio_private_put(struct btrfs_dio_private *dip)
+static void btrfs_dio_end_io(struct btrfs_bio *bbio)
 {
-	/*
-	 * This implies a barrier so that stores to dio_bio->bi_status before
-	 * this and loads of dio_bio->bi_status after this are fully ordered.
-	 */
-	if (!refcount_dec_and_test(&dip->refs))
-		return;
-
-	if (btrfs_op(&dip->bio) == BTRFS_MAP_WRITE) {
-		btrfs_mark_ordered_io_finished(dip->inode, NULL,
-					       dip->file_offset, dip->bytes,
-					       !dip->bio.bi_status);
-	} else {
-		unlock_extent(&dip->inode->io_tree,
-			      dip->file_offset,
-			      dip->file_offset + dip->bytes - 1, NULL);
-	}
-
-	bio_endio(&dip->bio);
-}
-
-static void btrfs_end_dio_bio(struct btrfs_bio *bbio)
-{
-	struct btrfs_dio_private *dip = bbio->private;
+	struct btrfs_dio_private *dip =
+		container_of(bbio, struct btrfs_dio_private, bbio);
+	struct btrfs_inode *inode = bbio->inode;
 	struct bio *bio = &bbio->bio;
-	blk_status_t err = bio->bi_status;
 
-	if (err) {
-		btrfs_warn(dip->inode->root->fs_info,
-			   "direct IO failed ino %llu rw %d,%u sector %#Lx len %u err no %d",
-			   btrfs_ino(dip->inode), bio_op(bio),
-			   bio->bi_opf, bio->bi_iter.bi_sector,
-			   bio->bi_iter.bi_size, err);
-		dip->bio.bi_status = err;
+	if (bio->bi_status) {
+		btrfs_warn(inode->root->fs_info,
+			   "direct IO failed ino %llu op 0x%0x offset %#llx len %u err no %d",
+			   btrfs_ino(inode), bio->bi_opf,
+			   dip->file_offset, dip->bytes, bio->bi_status);
 	}
 
-	bio_put(bio);
-	btrfs_dio_private_put(dip);
+	if (btrfs_op(bio) == BTRFS_MAP_WRITE)
+		btrfs_mark_ordered_io_finished(inode, NULL, dip->file_offset,
+					       dip->bytes, !bio->bi_status);
+	else
+		unlock_extent(&inode->io_tree, dip->file_offset,
+			      dip->file_offset + dip->bytes - 1, NULL);
+
+	bbio->bio.bi_private = bbio->private;
+	iomap_dio_bio_end_io(bio);
 }
 
-static void btrfs_submit_direct(const struct iomap_iter *iter,
-		struct bio *dio_bio, loff_t file_offset)
+static void btrfs_dio_submit_io(const struct iomap_iter *iter, struct bio *bio,
+				loff_t file_offset)
 {
+	struct btrfs_bio *bbio = btrfs_bio(bio);
 	struct btrfs_dio_private *dip =
-		container_of(dio_bio, struct btrfs_dio_private, bio);
-	struct inode *inode = iter->inode;
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
-	struct bio *bio;
-	u64 start_sector;
-	u64 submit_len;
-	u64 clone_offset = 0;
-	u64 clone_len;
-	u64 logical;
-	int ret;
-	blk_status_t status;
-	struct btrfs_io_geometry geom;
+		container_of(bbio, struct btrfs_dio_private, bbio);
 	struct btrfs_dio_data *dio_data = iter->private;
-	struct extent_map *em = NULL;
 
-	dip->inode = BTRFS_I(inode);
-	dip->file_offset = file_offset;
-	dip->bytes = dio_bio->bi_iter.bi_size;
-	refcount_set(&dip->refs, 1);
+	btrfs_bio_init(bbio, BTRFS_I(iter->inode), btrfs_dio_end_io,
+			bio->bi_private);
+	bbio->file_offset = file_offset;
 
-	start_sector = dio_bio->bi_iter.bi_sector;
-	submit_len = dio_bio->bi_iter.bi_size;
-
-	do {
-		logical = start_sector << 9;
-		em = btrfs_get_chunk_map(fs_info, logical, submit_len);
-		if (IS_ERR(em)) {
-			status = errno_to_blk_status(PTR_ERR(em));
-			em = NULL;
-			goto out_err;
-		}
-		ret = btrfs_get_io_geometry(fs_info, em, btrfs_op(dio_bio),
-					    logical, &geom);
-		if (ret) {
-			status = errno_to_blk_status(ret);
-			goto out_err_em;
-		}
-
-		clone_len = min(submit_len, geom.len);
-		ASSERT(clone_len <= UINT_MAX);
-
-		/*
-		 * This will never fail as it's passing GPF_NOFS and
-		 * the allocation is backed by btrfs_bioset.
-		 */
-		bio = btrfs_bio_clone_partial(dio_bio, clone_offset, clone_len,
-					      BTRFS_I(inode), btrfs_end_dio_bio,
-					      dip);
-		btrfs_bio(bio)->file_offset = file_offset;
-
-		ASSERT(submit_len >= clone_len);
-		submit_len -= clone_len;
-
-		/*
-		 * Increase the count before we submit the bio so we know
-		 * the end IO handler won't happen before we increase the
-		 * count. Otherwise, the dip might get freed before we're
-		 * done setting it up.
-		 *
-		 * We transfer the initial reference to the last bio, so we
-		 * don't need to increment the reference count for the last one.
-		 */
-		if (submit_len > 0)
-			refcount_inc(&dip->refs);
-
-		btrfs_submit_bio(fs_info, bio, 0);
-
-		dio_data->submitted += clone_len;
-		clone_offset += clone_len;
-		start_sector += clone_len >> 9;
-		file_offset += clone_len;
-
-		free_extent_map(em);
-	} while (submit_len > 0);
-	return;
+	dip->file_offset = file_offset;
+	dip->bytes = bio->bi_iter.bi_size;
 
-out_err_em:
-	free_extent_map(em);
-out_err:
-	dio_bio->bi_status = status;
-	btrfs_dio_private_put(dip);
+	dio_data->submitted += bio->bi_iter.bi_size;
+	btrfs_submit_bio(btrfs_sb(iter->inode->i_sb), bio, 0);
 }
 
 static const struct iomap_ops btrfs_dio_iomap_ops = {
@@ -7901,7 +7805,7 @@ static const struct iomap_ops btrfs_dio_iomap_ops = {
 };
 
 static const struct iomap_dio_ops btrfs_dio_ops = {
-	.submit_io		= btrfs_submit_direct,
+	.submit_io		= btrfs_dio_submit_io,
 	.bio_set		= &btrfs_dio_bioset,
 };
 
@@ -8736,7 +8640,7 @@ int __init btrfs_init_cachep(void)
 		goto fail;
 
 	if (bioset_init(&btrfs_dio_bioset, BIO_POOL_SIZE,
-			offsetof(struct btrfs_dio_private, bio),
+			offsetof(struct btrfs_dio_private, bbio.bio),
 			BIOSET_NEED_BVECS))
 		goto fail;
 
-- 
2.39.0

