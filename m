Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CCB55A90CD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Sep 2022 09:44:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234062AbiIAHni (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Sep 2022 03:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233888AbiIAHm6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Sep 2022 03:42:58 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AB531257D7;
        Thu,  1 Sep 2022 00:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=TnqeoHFrh1MxV+hta84LlYAbhOieggrswEFSvOzv2cA=; b=b6AQffJfPnbPaEK83CapsmmIhB
        /Ctwrxd9/M1sHpZv7Corv7kiollJ8TNqnTbz9zNQVcGtefiAT3RjZBkGwlu0dBJ/1lO0pDIBkZrAS
        JC/iuHVfWbXs3afJ9TVFBVs7/YUU95c6sJrcp0h8+zeCP3v793pGtnAazv1KUHpS+mc4mkjVV96fK
        eEJT7+SwytBzm3IyhMXzr3GzylxHnNbWxpfFxR+fkAIXSJe9rcwpm8zPGhbm+Esvn6dDUkIfa4EA0
        8DjIqzSsbfoXOv346C+R2wRamKfPinqZwq8G62tt9JQWxkhSOVM+7PxtAQMUWQb9KwBrqI7SyaPpA
        svaUXphA==;
Received: from 213-225-1-14.nat.highway.a1.net ([213.225.1.14] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oTeqj-00ANdq-4g; Thu, 01 Sep 2022 07:42:53 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>, Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 08/17] btrfs: pass the iomap bio to btrfs_submit_bio
Date:   Thu,  1 Sep 2022 10:42:07 +0300
Message-Id: <20220901074216.1849941-9-hch@lst.de>
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
---
 fs/btrfs/inode.c   | 159 +++++++++------------------------------------
 fs/btrfs/volumes.c |  21 +-----
 fs/btrfs/volumes.h |   7 +-
 3 files changed, 37 insertions(+), 150 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 03953c1f176dd..833ea647f7887 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -69,24 +69,12 @@ struct btrfs_dio_data {
 };
 
 struct btrfs_dio_private {
-	struct inode *inode;
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
@@ -7815,130 +7803,47 @@ static int btrfs_dio_iomap_end(struct inode *inode, loff_t pos, loff_t length,
 	return ret;
 }
 
-static void btrfs_dio_private_put(struct btrfs_dio_private *dip)
-{
-	/*
-	 * This implies a barrier so that stores to dio_bio->bi_status before
-	 * this and loads of dio_bio->bi_status after this are fully ordered.
-	 */
-	if (!refcount_dec_and_test(&dip->refs))
-		return;
-
-	if (btrfs_op(&dip->bio) == BTRFS_MAP_WRITE) {
-		btrfs_mark_ordered_io_finished(BTRFS_I(dip->inode), NULL,
-					       dip->file_offset, dip->bytes,
-					       !dip->bio.bi_status);
-	} else {
-		unlock_extent(&BTRFS_I(dip->inode)->io_tree,
-			      dip->file_offset,
-			      dip->file_offset + dip->bytes - 1);
-	}
-
-	bio_endio(&dip->bio);
-}
-
-static void btrfs_end_dio_bio(struct btrfs_bio *bbio)
+static void btrfs_dio_end_io(struct btrfs_bio *bbio)
 {
-	struct btrfs_dio_private *dip = bbio->private;
+	struct btrfs_dio_private *dip =
+		container_of(bbio, struct btrfs_dio_private, bbio);
+	struct btrfs_inode *bi = BTRFS_I(bbio->inode);
 	struct bio *bio = &bbio->bio;
-	blk_status_t err = bio->bi_status;
 
-	if (err) {
-		btrfs_warn(BTRFS_I(dip->inode)->root->fs_info,
-			   "direct IO failed ino %llu rw %d,%u sector %#Lx len %u err no %d",
-			   btrfs_ino(BTRFS_I(dip->inode)), bio_op(bio),
-			   bio->bi_opf, bio->bi_iter.bi_sector,
-			   bio->bi_iter.bi_size, err);
-		dip->bio.bi_status = err;
+	if (bio->bi_status) {
+		btrfs_warn(bi->root->fs_info,
+			   "direct IO failed ino %llu op 0x%0x offset %#llx len %u err no %d",
+			   btrfs_ino(bi), bio->bi_opf,
+			   dip->file_offset, dip->bytes, bio->bi_status);
 	}
 
-	bio_put(bio);
-	btrfs_dio_private_put(dip);
+	if (btrfs_op(bio) == BTRFS_MAP_WRITE)
+		btrfs_mark_ordered_io_finished(bi, NULL, dip->file_offset,
+					       dip->bytes, !bio->bi_status);
+	else
+		unlock_extent(&bi->io_tree, dip->file_offset,
+			      dip->file_offset + dip->bytes - 1);
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
-
-	dip->inode = inode;
-	dip->file_offset = file_offset;
-	dip->bytes = dio_bio->bi_iter.bi_size;
-	refcount_set(&dip->refs, 1);
 
-	start_sector = dio_bio->bi_iter.bi_sector;
-	submit_len = dio_bio->bi_iter.bi_size;
+	btrfs_bio_init(bbio, iter->inode, btrfs_dio_end_io, bio->bi_private);
+	bbio->file_offset = file_offset;
 
-	do {
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
-					      inode, btrfs_end_dio_bio, dip);
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
-	dio_bio->bi_status = status;
-	btrfs_dio_private_put(dip);
+	dio_data->submitted += bio->bi_iter.bi_size;
+	btrfs_submit_bio(btrfs_sb(iter->inode->i_sb), bio, 0);
 }
 
 static const struct iomap_ops btrfs_dio_iomap_ops = {
@@ -7947,7 +7852,7 @@ static const struct iomap_ops btrfs_dio_iomap_ops = {
 };
 
 static const struct iomap_dio_ops btrfs_dio_ops = {
-	.submit_io		= btrfs_submit_direct,
+	.submit_io		= btrfs_dio_submit_io,
 	.bio_set		= &btrfs_dio_bioset,
 };
 
@@ -8788,7 +8693,7 @@ int __init btrfs_init_cachep(void)
 		goto fail;
 
 	if (bioset_init(&btrfs_dio_bioset, BIO_POOL_SIZE,
-			offsetof(struct btrfs_dio_private, bio),
+			offsetof(struct btrfs_dio_private, bbio.bio),
 			BIOSET_NEED_BVECS))
 		goto fail;
 
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 0a2d144c20604..dba8e53101ed9 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6655,8 +6655,8 @@ int btrfs_map_sblock(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
  * Initialize a btrfs_bio structure.  This skips the embedded bio itself as it
  * is already initialized by the block layer.
  */
-static void btrfs_bio_init(struct btrfs_bio *bbio, struct inode *inode,
-			   btrfs_bio_end_io_t end_io, void *private)
+void btrfs_bio_init(struct btrfs_bio *bbio, struct inode *inode,
+		    btrfs_bio_end_io_t end_io, void *private)
 {
 	memset(bbio, 0, offsetof(struct btrfs_bio, bio));
 	bbio->inode = inode;
@@ -6683,23 +6683,6 @@ struct bio *btrfs_bio_alloc(unsigned int nr_vecs, blk_opf_t opf,
 	return bio;
 }
 
-struct bio *btrfs_bio_clone_partial(struct bio *orig, u64 offset, u64 size,
-				    struct inode *inode,
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
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 97877184d0db1..82bbc0aa7081d 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -404,12 +404,11 @@ static inline struct btrfs_bio *btrfs_bio(struct bio *bio)
 int __init btrfs_bioset_init(void);
 void __cold btrfs_bioset_exit(void);
 
-struct bio *btrfs_bio_alloc(unsigned int nr_vecs, blk_opf_t opf,
+void btrfs_bio_init(struct btrfs_bio *bbio, struct inode *inode,
+		    btrfs_bio_end_io_t end_io, void *private);
+struct bio *btrfs_bio_alloc(unsigned int nr_vecs, unsigned int opf,
 			    struct inode *inode, btrfs_bio_end_io_t end_io,
 			    void *private);
-struct bio *btrfs_bio_clone_partial(struct bio *orig, u64 offset, u64 size,
-				    struct inode *inode,
-				    btrfs_bio_end_io_t end_io, void *private);
 
 static inline void btrfs_bio_end_io(struct btrfs_bio *bbio, blk_status_t status)
 {
-- 
2.30.2

