Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E32E26313FB
	for <lists+linux-fsdevel@lfdr.de>; Sun, 20 Nov 2022 13:47:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbiKTMr5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 20 Nov 2022 07:47:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiKTMrw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 20 Nov 2022 07:47:52 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BF2C2BC3;
        Sun, 20 Nov 2022 04:47:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=XpfdPFA209YKW01DgBcas66vXYX1GBuhVKTpppI17o0=; b=1cwK1orUenjgTod7LFFTOoT1yj
        Vk6Dim21+Iyj9tEkvrP/FcWbnjMlSfGbIItSzrBpCMD9kpZlSsBaLe0SQ4sRWcWJQ4f9DiLF5eJpM
        5m6twTHdIwsQdOXv6fdZk9+9gyS5oOkENeXFlBimFzlQPcn+MUB/0HyVrN9Kbfnh653a+OpBEyQPe
        G16NAqX6Z3U2jH91UBNX9zV0PPvQ0dGsMm6DtIUanvquePwe3PEb0G1BuAq59YCv1VI1mKY/VFTxK
        HPAf2A0VapEo2M1dSHb7IC6m8IrIHqhRaVNizlKpPMCSrzPQKEolVKckX1QmjRVWKYvehkbBKaKbN
        jzgVxBDA==;
Received: from [2001:4bb8:181:6f70:ae5d:6675:76b9:6fc3] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1owjja-004I4u-Lh; Sun, 20 Nov 2022 12:47:43 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>, Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 02/19] btrfs: handle checksum validation and repair at the storage layer
Date:   Sun, 20 Nov 2022 13:47:17 +0100
Message-Id: <20221120124734.18634-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221120124734.18634-1-hch@lst.de>
References: <20221120124734.18634-1-hch@lst.de>
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

Currently btrfs handles checksum validation and repair in the end I/O
handler for the btrfs_bio.  This leads to a lot of duplicate code
plus issues with variying semantics or bugs, e.g.

 - the until recently broken repair for compressed extents
 - the fact that encoded reads validate the checksums but do not kick
   of read repair
 - the inconsistent checking of the BTRFS_FS_STATE_NO_CSUMS flag

This commit revamps the checksum validation and repair code to instead
work below the btrfs_submit_bio interfaces.  For this to work we need
to make sure an inode is available, so that is added as a parameter
to btrfs_bio_alloc.  With that btrfs_submit_bio can preload
btrfs_bio.csum from the csum tree without help from the upper layers,
and the low-level I/O completion can iterate over the bio and verify
the checksums.

In case of a checksum failure (or a plain old I/O error), the repair
is now kicked off before the upper level ->end_io handler is invoked.
Tracking of the repair status is massively simplified by just keeping
a small failed_bio structure per bio with failed sectors and otherwise
using the information in the repair bio.  The per-inode I/O failure
tree can be entirely removed.

The saved bvec_iter in the btrfs_bio is now competely managed by
btrfs_submit_bio and must not be accessed by the callers.

There is one significant behavior change here:  If repair fails or
is impossible to start with, the whole bio will be failed to the
upper layer.  This is the behavior that all I/O submitters execept
for buffered I/O already emulated in their end_io handler.  For
buffered I/O this now means that a large readahead request can
fail due to a single bad sector, but as readahead errors are igored
the following readpage if the sector is actually accessed will
still be able to read.  This also matches the I/O failure handling
in other file systems.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/bio.c            | 246 ++++++++++++++++++++++--
 fs/btrfs/bio.h            |  58 ++----
 fs/btrfs/btrfs_inode.h    |  14 +-
 fs/btrfs/compression.c    |  54 +-----
 fs/btrfs/disk-io.c        |   1 -
 fs/btrfs/extent-io-tree.h |   1 -
 fs/btrfs/extent_io.c      | 390 ++------------------------------------
 fs/btrfs/extent_io.h      |  31 ---
 fs/btrfs/file-item.c      |  52 ++---
 fs/btrfs/file-item.h      |   2 +-
 fs/btrfs/inode.c          | 282 +++++----------------------
 11 files changed, 322 insertions(+), 809 deletions(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index b8fb7ef6b5206..61c7a6b3eb829 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -14,17 +14,27 @@
 #include "dev-replace.h"
 #include "rcu-string.h"
 #include "zoned.h"
+#include "file-item.h"
 
 static struct bio_set btrfs_bioset;
+static struct bio_set btrfs_repair_bioset;
+static mempool_t btrfs_failed_bio_pool;
+
+struct btrfs_failed_bio {
+	struct btrfs_bio *bbio;
+	int num_copies;
+	atomic_t repair_count;
+};
 
 /*
  * Initialize a btrfs_bio structure.  This skips the embedded bio itself as it
  * is already initialized by the block layer.
  */
-static inline void btrfs_bio_init(struct btrfs_bio *bbio,
-				  btrfs_bio_end_io_t end_io, void *private)
+static void btrfs_bio_init(struct btrfs_bio *bbio, struct btrfs_inode *inode,
+			   btrfs_bio_end_io_t end_io, void *private)
 {
 	memset(bbio, 0, offsetof(struct btrfs_bio, bio));
+	bbio->inode = inode;
 	bbio->end_io = end_io;
 	bbio->private = private;
 }
@@ -37,16 +47,18 @@ static inline void btrfs_bio_init(struct btrfs_bio *bbio,
  * a mempool.
  */
 struct bio *btrfs_bio_alloc(unsigned int nr_vecs, blk_opf_t opf,
+			    struct btrfs_inode *inode,
 			    btrfs_bio_end_io_t end_io, void *private)
 {
 	struct bio *bio;
 
 	bio = bio_alloc_bioset(NULL, nr_vecs, opf, GFP_NOFS, &btrfs_bioset);
-	btrfs_bio_init(btrfs_bio(bio), end_io, private);
+	btrfs_bio_init(btrfs_bio(bio), inode, end_io, private);
 	return bio;
 }
 
 struct bio *btrfs_bio_clone_partial(struct bio *orig, u64 offset, u64 size,
+				    struct btrfs_inode *inode,
 				    btrfs_bio_end_io_t end_io, void *private)
 {
 	struct bio *bio;
@@ -56,13 +68,172 @@ struct bio *btrfs_bio_clone_partial(struct bio *orig, u64 offset, u64 size,
 
 	bio = bio_alloc_clone(orig->bi_bdev, orig, GFP_NOFS, &btrfs_bioset);
 	bbio = btrfs_bio(bio);
-	btrfs_bio_init(bbio, end_io, private);
+	btrfs_bio_init(bbio, inode, end_io, private);
 
 	bio_trim(bio, offset >> 9, size >> 9);
-	bbio->iter = bio->bi_iter;
 	return bio;
 }
 
+static int next_repair_mirror(struct btrfs_failed_bio *fbio, int cur_mirror)
+{
+	if (cur_mirror == fbio->num_copies)
+		return cur_mirror + 1 - fbio->num_copies;
+	return cur_mirror + 1;
+}
+
+static int prev_repair_mirror(struct btrfs_failed_bio *fbio, int cur_mirror)
+{
+	if (cur_mirror == 1)
+		return fbio->num_copies;
+	return cur_mirror - 1;
+}
+
+static void btrfs_repair_done(struct btrfs_failed_bio *fbio)
+{
+	if (atomic_dec_and_test(&fbio->repair_count)) {
+		fbio->bbio->end_io(fbio->bbio);
+		mempool_free(fbio, &btrfs_failed_bio_pool);
+	}
+}
+
+static void btrfs_end_repair_bio(struct btrfs_bio *repair_bbio,
+				 struct btrfs_device *dev)
+{
+	struct btrfs_failed_bio *fbio = repair_bbio->private;
+	struct btrfs_inode *inode = repair_bbio->inode;
+	struct btrfs_fs_info *fs_info = inode->root->fs_info;
+	struct bio_vec *bv = bio_first_bvec_all(&repair_bbio->bio);
+	int mirror = repair_bbio->mirror_num;
+
+	if (repair_bbio->bio.bi_status ||
+	    !btrfs_data_csum_ok(repair_bbio, dev, 0, bv)) {
+		bio_reset(&repair_bbio->bio, NULL, REQ_OP_READ);
+		repair_bbio->bio.bi_iter = repair_bbio->saved_iter;
+
+		mirror = next_repair_mirror(fbio, mirror);
+		if (mirror == fbio->bbio->mirror_num) {
+			btrfs_debug(fs_info, "no mirror left");
+			fbio->bbio->bio.bi_status = BLK_STS_IOERR;
+			goto done;
+		}
+
+		btrfs_submit_bio(fs_info, &repair_bbio->bio, mirror);
+		return;
+	}
+
+	do {
+		mirror = prev_repair_mirror(fbio, mirror);
+		btrfs_repair_io_failure(fs_info, btrfs_ino(inode),
+				  repair_bbio->file_offset, fs_info->sectorsize,
+				  repair_bbio->saved_iter.bi_sector <<
+					SECTOR_SHIFT,
+				  bv->bv_page, bv->bv_offset, mirror);
+	} while (mirror != fbio->bbio->mirror_num);
+
+done:
+	btrfs_repair_done(fbio);
+	bio_put(&repair_bbio->bio);
+}
+
+/*
+ * Try to kick off a repair read to the next available mirror for a bad
+ * sector.
+ *
+ * This primarily tries to recover good data to serve the actual read request,
+ * but also tries to write the good data back to the bad mirror(s) when a
+ * read succeeded to restore the redundancy.
+ */
+static struct btrfs_failed_bio *repair_one_sector(struct btrfs_bio *failed_bbio,
+						  u32 bio_offset,
+						  struct bio_vec *bv,
+						  struct btrfs_failed_bio *fbio)
+{
+	struct btrfs_inode *inode = failed_bbio->inode;
+	struct btrfs_fs_info *fs_info = inode->root->fs_info;
+	const u32 sectorsize = fs_info->sectorsize;
+	const u64 logical = failed_bbio->saved_iter.bi_sector << SECTOR_SHIFT;
+	struct btrfs_bio *repair_bbio;
+	struct bio *repair_bio;
+	int num_copies;
+	int mirror;
+
+	btrfs_debug(fs_info, "repair read error: read error at %llu",
+		    failed_bbio->file_offset + bio_offset);
+
+	num_copies = btrfs_num_copies(fs_info, logical, sectorsize);
+	if (num_copies == 1) {
+		btrfs_debug(fs_info, "no copy to repair from");
+		failed_bbio->bio.bi_status = BLK_STS_IOERR;
+		return fbio;
+	}
+
+	if (!fbio) {
+		fbio = mempool_alloc(&btrfs_failed_bio_pool, GFP_NOFS);
+		fbio->bbio = failed_bbio;
+		fbio->num_copies = num_copies;
+		atomic_set(&fbio->repair_count, 1);
+	}
+
+	atomic_inc(&fbio->repair_count);
+
+	repair_bio = bio_alloc_bioset(NULL, 1, REQ_OP_READ, GFP_NOFS,
+				      &btrfs_repair_bioset);
+	repair_bio->bi_iter.bi_sector = failed_bbio->saved_iter.bi_sector;
+	bio_add_page(repair_bio, bv->bv_page, bv->bv_len, bv->bv_offset);
+
+	repair_bbio = btrfs_bio(repair_bio);
+	btrfs_bio_init(repair_bbio, failed_bbio->inode, NULL, fbio);
+	repair_bbio->file_offset = failed_bbio->file_offset + bio_offset;
+
+	mirror = next_repair_mirror(fbio, failed_bbio->mirror_num);
+	btrfs_debug(fs_info, "submitting repair read to mirror %d", mirror);
+	btrfs_submit_bio(fs_info, repair_bio, mirror);
+	return fbio;
+}
+
+static void btrfs_check_read_bio(struct btrfs_bio *bbio,
+				 struct btrfs_device *dev)
+{
+	struct btrfs_inode *inode = bbio->inode;
+	struct btrfs_fs_info *fs_info = inode->root->fs_info;
+	unsigned int sectorsize = fs_info->sectorsize;
+	struct bvec_iter *iter = &bbio->saved_iter;
+	blk_status_t status = bbio->bio.bi_status;
+	struct btrfs_failed_bio *fbio = NULL;
+	u32 offset = 0;
+
+	/*
+	 * Hand off repair bios to the repair code as there is no upper level
+	 * submitter for them.
+	 */
+	if (unlikely(bbio->bio.bi_pool == &btrfs_repair_bioset)) {
+		btrfs_end_repair_bio(bbio, dev);
+		return;
+	}
+
+	/* Clear the I/O error.  A failed repair will reset it */
+	bbio->bio.bi_status = BLK_STS_OK;
+
+	while (iter->bi_size) {
+		struct bio_vec bv = bio_iter_iovec(&bbio->bio, *iter);
+
+		bv.bv_len = min(bv.bv_len, sectorsize);
+		if (status || !btrfs_data_csum_ok(bbio, dev, offset, &bv))
+			fbio = repair_one_sector(bbio, offset, &bv, fbio);
+
+		bio_advance_iter_single(&bbio->bio, iter, sectorsize);
+		offset += sectorsize;
+	}
+
+	if (bbio->csum != bbio->csum_inline)
+		kfree(bbio->csum);
+
+	if (unlikely(fbio))
+		btrfs_repair_done(fbio);
+	else
+		bbio->end_io(bbio);
+}
+
 static void btrfs_log_dev_io_error(struct bio *bio, struct btrfs_device *dev)
 {
 	if (!dev || !dev->bdev)
@@ -90,18 +261,23 @@ static void btrfs_end_bio_work(struct work_struct *work)
 {
 	struct btrfs_bio *bbio = container_of(work, struct btrfs_bio, end_io_work);
 
-	bbio->end_io(bbio);
+	/* Metadata reads are checked and repaired by the submitter */
+	if (bbio->bio.bi_opf & REQ_META)
+		bbio->end_io(bbio);
+	else
+		btrfs_check_read_bio(bbio, bbio->bio.bi_private);
 }
 
 static void btrfs_simple_end_io(struct bio *bio)
 {
-	struct btrfs_fs_info *fs_info = bio->bi_private;
 	struct btrfs_bio *bbio = btrfs_bio(bio);
+	struct btrfs_device *dev = bio->bi_private;
+	struct btrfs_fs_info *fs_info = bbio->inode->root->fs_info;
 
 	btrfs_bio_counter_dec(fs_info);
 
 	if (bio->bi_status)
-		btrfs_log_dev_io_error(bio, bbio->device);
+		btrfs_log_dev_io_error(bio, dev);
 
 	if (bio_op(bio) == REQ_OP_READ) {
 		INIT_WORK(&bbio->end_io_work, btrfs_end_bio_work);
@@ -118,7 +294,10 @@ static void btrfs_raid56_end_io(struct bio *bio)
 
 	btrfs_bio_counter_dec(bioc->fs_info);
 	bbio->mirror_num = bioc->mirror_num;
-	bbio->end_io(bbio);
+	if (bio_op(bio) == REQ_OP_READ && !(bbio->bio.bi_opf & REQ_META))
+		btrfs_check_read_bio(bbio, NULL);
+	else
+		bbio->end_io(bbio);
 
 	btrfs_put_bioc(bioc);
 }
@@ -226,20 +405,21 @@ static void btrfs_submit_mirrored_bio(struct btrfs_io_context *bioc, int dev_nr)
 
 void btrfs_submit_bio(struct btrfs_fs_info *fs_info, struct bio *bio, int mirror_num)
 {
+	struct btrfs_bio *bbio = btrfs_bio(bio);
 	u64 logical = bio->bi_iter.bi_sector << 9;
 	u64 length = bio->bi_iter.bi_size;
 	u64 map_length = length;
 	struct btrfs_io_context *bioc = NULL;
 	struct btrfs_io_stripe smap;
-	int ret;
+	blk_status_t ret;
+	int error;
 
 	btrfs_bio_counter_inc_blocked(fs_info);
-	ret = __btrfs_map_block(fs_info, btrfs_op(bio), logical, &map_length,
-				&bioc, &smap, &mirror_num, 1);
-	if (ret) {
-		btrfs_bio_counter_dec(fs_info);
-		btrfs_bio_end_io(btrfs_bio(bio), errno_to_blk_status(ret));
-		return;
+	error = __btrfs_map_block(fs_info, btrfs_op(bio), logical, &map_length,
+				  &bioc, &smap, &mirror_num, 1);
+	if (error) {
+		ret = errno_to_blk_status(error);
+		goto fail;
 	}
 
 	if (map_length < length) {
@@ -249,12 +429,22 @@ void btrfs_submit_bio(struct btrfs_fs_info *fs_info, struct bio *bio, int mirror
 		BUG();
 	}
 
+	/*
+	 * Save the iter for the end_io handler and preload the checksums for
+	 * data reads.
+	 */
+	if (bio_op(bio) == REQ_OP_READ && !(bio->bi_opf & REQ_META)) {
+		bbio->saved_iter = bio->bi_iter;
+		ret = btrfs_lookup_bio_sums(bbio);
+		if (ret)
+			goto fail;
+	}
+
 	if (!bioc) {
 		/* Single mirror read/write fast path */
 		btrfs_bio(bio)->mirror_num = mirror_num;
-		btrfs_bio(bio)->device = smap.dev;
 		bio->bi_iter.bi_sector = smap.physical >> SECTOR_SHIFT;
-		bio->bi_private = fs_info;
+		bio->bi_private = smap.dev;
 		bio->bi_end_io = btrfs_simple_end_io;
 		btrfs_submit_dev_bio(smap.dev, bio);
 	} else if (bioc->map_type & BTRFS_BLOCK_GROUP_RAID56_MASK) {
@@ -274,6 +464,11 @@ void btrfs_submit_bio(struct btrfs_fs_info *fs_info, struct bio *bio, int mirror
 		for (dev_nr = 0; dev_nr < total_devs; dev_nr++)
 			btrfs_submit_mirrored_bio(bioc, dev_nr);
 	}
+
+	return;
+fail:
+	btrfs_bio_counter_dec(fs_info);
+	btrfs_bio_end_io(bbio, ret);
 }
 
 /*
@@ -372,10 +567,25 @@ int __init btrfs_bioset_init(void)
 			offsetof(struct btrfs_bio, bio),
 			BIOSET_NEED_BVECS))
 		return -ENOMEM;
+	if (bioset_init(&btrfs_repair_bioset, BIO_POOL_SIZE,
+			offsetof(struct btrfs_bio, bio),
+			BIOSET_NEED_BVECS))
+		goto out_free_bioset;
+	if (mempool_init_kmalloc_pool(&btrfs_failed_bio_pool, BIO_POOL_SIZE,
+				      sizeof(struct btrfs_failed_bio)))
+		goto out_free_repair_bioset;
 	return 0;
+
+out_free_repair_bioset:
+	bioset_exit(&btrfs_repair_bioset);
+out_free_bioset:
+	bioset_exit(&btrfs_bioset);
+	return -ENOMEM;
 }
 
 void __cold btrfs_bioset_exit(void)
 {
+	mempool_exit(&btrfs_failed_bio_pool);
+	bioset_exit(&btrfs_repair_bioset);
 	bioset_exit(&btrfs_bioset);
 }
diff --git a/fs/btrfs/bio.h b/fs/btrfs/bio.h
index b12f84b3b3410..a96bcb3f36f68 100644
--- a/fs/btrfs/bio.h
+++ b/fs/btrfs/bio.h
@@ -26,32 +26,23 @@ struct btrfs_fs_info;
 typedef void (*btrfs_bio_end_io_t)(struct btrfs_bio *bbio);
 
 /*
- * Additional info to pass along bio.
- *
- * Mostly for btrfs specific features like csum and mirror_num.
+ * Highlevel btrfs I/O structure.  It is allocated by btrfs_bio_alloc and
+ * passed to btrfs_submit_bio for mapping to the physical devices.
  */
 struct btrfs_bio {
-	unsigned int mirror_num:7;
-
-	/*
-	 * Extra indicator for metadata bios.
-	 * For some btrfs bios they use pages without a mapping, thus
-	 * we can not rely on page->mapping->host to determine if
-	 * it's a metadata bio.
-	 */
-	unsigned int is_metadata:1;
-	struct bvec_iter iter;
-
-	/* for direct I/O */
+	/* Inode and offset into it that this I/O operates on. */
+	struct btrfs_inode *inode;
 	u64 file_offset;
 
-	/* @device is for stripe IO submission. */
-	struct btrfs_device *device;
 	union {
-		/* For data checksum verification. */
+		/*
+		 * Data checksumming and original I/O information for internal
+		 * use in the btrfs_submit_bio machinery.
+		 */
 		struct {
 			u8 *csum;
 			u8 csum_inline[BTRFS_BIO_INLINE_CSUM_SIZE];
+			struct bvec_iter saved_iter;
 		};
 
 		/* For metadata parentness verification. */
@@ -62,7 +53,8 @@ struct btrfs_bio {
 	btrfs_bio_end_io_t end_io;
 	void *private;
 
-	/* For read end I/O handling */
+	/* For internal use in read end I/O handling */
+	unsigned int mirror_num;
 	struct work_struct end_io_work;
 
 	/*
@@ -81,8 +73,10 @@ int __init btrfs_bioset_init(void);
 void __cold btrfs_bioset_exit(void);
 
 struct bio *btrfs_bio_alloc(unsigned int nr_vecs, blk_opf_t opf,
+			    struct btrfs_inode *inode,
 			    btrfs_bio_end_io_t end_io, void *private);
 struct bio *btrfs_bio_clone_partial(struct bio *orig, u64 offset, u64 size,
+				    struct btrfs_inode *inode,
 				    btrfs_bio_end_io_t end_io, void *private);
 
 
@@ -92,32 +86,6 @@ static inline void btrfs_bio_end_io(struct btrfs_bio *bbio, blk_status_t status)
 	bbio->end_io(bbio);
 }
 
-static inline void btrfs_bio_free_csum(struct btrfs_bio *bbio)
-{
-	if (bbio->is_metadata)
-		return;
-	if (bbio->csum != bbio->csum_inline) {
-		kfree(bbio->csum);
-		bbio->csum = NULL;
-	}
-}
-
-/*
- * Iterate through a btrfs_bio (@bbio) on a per-sector basis.
- *
- * bvl        - struct bio_vec
- * bbio       - struct btrfs_bio
- * iters      - struct bvec_iter
- * bio_offset - unsigned int
- */
-#define btrfs_bio_for_each_sector(fs_info, bvl, bbio, iter, bio_offset)	\
-	for ((iter) = (bbio)->iter, (bio_offset) = 0;			\
-	     (iter).bi_size &&					\
-	     (((bvl) = bio_iter_iovec((&(bbio)->bio), (iter))), 1);	\
-	     (bio_offset) += fs_info->sectorsize,			\
-	     bio_advance_iter_single(&(bbio)->bio, &(iter),		\
-	     (fs_info)->sectorsize))
-
 void btrfs_submit_bio(struct btrfs_fs_info *fs_info, struct bio *bio,
 		      int mirror_num);
 int btrfs_repair_io_failure(struct btrfs_fs_info *fs_info, u64 ino, u64 start,
diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index 195c09e20609e..78c7979b8dcac 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -93,12 +93,6 @@ struct btrfs_inode {
 	/* the io_tree does range state (DIRTY, LOCKED etc) */
 	struct extent_io_tree io_tree;
 
-	/* special utility tree used to record which mirrors have already been
-	 * tried when checksums fail for a given block
-	 */
-	struct rb_root io_failure_tree;
-	spinlock_t io_failure_lock;
-
 	/*
 	 * Keep track of where the inode has extent items mapped in order to
 	 * make sure the i_size adjustments are accurate
@@ -414,18 +408,14 @@ static inline void btrfs_inode_split_flags(u64 inode_item_flags,
 void btrfs_submit_data_write_bio(struct btrfs_inode *inode, struct bio *bio, int mirror_num);
 void btrfs_submit_data_read_bio(struct btrfs_inode *inode, struct bio *bio,
 			int mirror_num, enum btrfs_compression_type compress_type);
-void btrfs_submit_dio_repair_bio(struct btrfs_inode *inode, struct bio *bio, int mirror_num);
 blk_status_t btrfs_submit_bio_start(struct btrfs_inode *inode, struct bio *bio);
 blk_status_t btrfs_submit_bio_start_direct_io(struct btrfs_inode *inode,
 					      struct bio *bio,
 					      u64 dio_file_offset);
 int btrfs_check_sector_csum(struct btrfs_fs_info *fs_info, struct page *page,
 			    u32 pgoff, u8 *csum, const u8 * const csum_expected);
-int btrfs_check_data_csum(struct btrfs_inode *inode, struct btrfs_bio *bbio,
-			  u32 bio_offset, struct page *page, u32 pgoff);
-unsigned int btrfs_verify_data_csum(struct btrfs_bio *bbio,
-				    u32 bio_offset, struct page *page,
-				    u64 start, u64 end);
+bool btrfs_data_csum_ok(struct btrfs_bio *bbio, struct btrfs_device *dev,
+			u32 bio_offset, struct bio_vec *bv);
 noinline int can_nocow_extent(struct inode *inode, u64 offset, u64 *len,
 			      u64 *orig_start, u64 *orig_block_len,
 			      u64 *ram_bytes, bool nowait, bool strict);
diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 5122ca79f7ea4..bb16893363f82 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -164,52 +164,15 @@ static void finish_compressed_bio_read(struct compressed_bio *cb)
 	kfree(cb);
 }
 
-/*
- * Verify the checksums and kick off repair if needed on the uncompressed data
- * before decompressing it into the original bio and freeing the uncompressed
- * pages.
- */
 static void end_compressed_bio_read(struct btrfs_bio *bbio)
 {
 	struct compressed_bio *cb = bbio->private;
-	struct inode *inode = cb->inode;
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
-	struct btrfs_inode *bi = BTRFS_I(inode);
-	bool csum = !(bi->flags & BTRFS_INODE_NODATASUM) &&
-		    !test_bit(BTRFS_FS_STATE_NO_CSUMS, &fs_info->fs_state);
-	blk_status_t status = bbio->bio.bi_status;
-	struct bvec_iter iter;
-	struct bio_vec bv;
-	u32 offset;
-
-	btrfs_bio_for_each_sector(fs_info, bv, bbio, iter, offset) {
-		u64 start = bbio->file_offset + offset;
-
-		if (!status &&
-		    (!csum || !btrfs_check_data_csum(bi, bbio, offset,
-						     bv.bv_page, bv.bv_offset))) {
-			btrfs_clean_io_failure(bi, start, bv.bv_page,
-					       bv.bv_offset);
-		} else {
-			int ret;
-
-			refcount_inc(&cb->pending_ios);
-			ret = btrfs_repair_one_sector(BTRFS_I(inode), bbio, offset,
-						      bv.bv_page, bv.bv_offset,
-						      true);
-			if (ret) {
-				refcount_dec(&cb->pending_ios);
-				status = errno_to_blk_status(ret);
-			}
-		}
-	}
 
-	if (status)
-		cb->status = status;
+	if (bbio->bio.bi_status)
+		cb->status = bbio->bio.bi_status;
 
 	if (refcount_dec_and_test(&cb->pending_ios))
 		finish_compressed_bio_read(cb);
-	btrfs_bio_free_csum(bbio);
 	bio_put(&bbio->bio);
 }
 
@@ -344,7 +307,8 @@ static struct bio *alloc_compressed_bio(struct compressed_bio *cb, u64 disk_byte
 	struct bio *bio;
 	int ret;
 
-	bio = btrfs_bio_alloc(BIO_MAX_VECS, opf, endio_func, cb);
+	bio = btrfs_bio_alloc(BIO_MAX_VECS, opf, BTRFS_I(cb->inode), endio_func,
+			      cb);
 	bio->bi_iter.bi_sector = disk_bytenr >> SECTOR_SHIFT;
 
 	em = btrfs_get_chunk_map(fs_info, disk_bytenr, fs_info->sectorsize);
@@ -788,10 +752,6 @@ void btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 			submit = true;
 
 		if (submit) {
-			/* Save the original iter for read repair */
-			if (bio_op(comp_bio) == REQ_OP_READ)
-				btrfs_bio(comp_bio)->iter = comp_bio->bi_iter;
-
 			/*
 			 * Save the initial offset of this chunk, as there
 			 * is no direct correlation between compressed pages and
@@ -800,12 +760,6 @@ void btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 			 */
 			btrfs_bio(comp_bio)->file_offset = file_offset;
 
-			ret = btrfs_lookup_bio_sums(inode, comp_bio, NULL);
-			if (ret) {
-				btrfs_bio_end_io(btrfs_bio(comp_bio), ret);
-				break;
-			}
-
 			ASSERT(comp_bio->bi_iter.bi_size);
 			btrfs_submit_bio(fs_info, comp_bio, mirror_num);
 			comp_bio = NULL;
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 0888d484df80c..74455977afe73 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -832,7 +832,6 @@ void btrfs_submit_metadata_bio(struct btrfs_inode *inode, struct bio *bio, int m
 	blk_status_t ret;
 
 	bio->bi_opf |= REQ_META;
-	bbio->is_metadata = 1;
 
 	if (btrfs_op(bio) != BTRFS_MAP_WRITE) {
 		btrfs_submit_bio(fs_info, bio, mirror_num);
diff --git a/fs/btrfs/extent-io-tree.h b/fs/btrfs/extent-io-tree.h
index e3eeec380844c..21766e49ec02e 100644
--- a/fs/btrfs/extent-io-tree.h
+++ b/fs/btrfs/extent-io-tree.h
@@ -6,7 +6,6 @@
 #include "misc.h"
 
 struct extent_changeset;
-struct io_failure_record;
 
 /* Bits for the extent state */
 enum {
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 83dd3aa596635..d31409b6d5a70 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -495,266 +495,6 @@ void extent_clear_unlock_delalloc(struct btrfs_inode *inode, u64 start, u64 end,
 			       start, end, page_ops, NULL);
 }
 
-static int insert_failrec(struct btrfs_inode *inode,
-			  struct io_failure_record *failrec)
-{
-	struct rb_node *exist;
-
-	spin_lock(&inode->io_failure_lock);
-	exist = rb_simple_insert(&inode->io_failure_tree, failrec->bytenr,
-				 &failrec->rb_node);
-	spin_unlock(&inode->io_failure_lock);
-
-	return (exist == NULL) ? 0 : -EEXIST;
-}
-
-static struct io_failure_record *get_failrec(struct btrfs_inode *inode, u64 start)
-{
-	struct rb_node *node;
-	struct io_failure_record *failrec = ERR_PTR(-ENOENT);
-
-	spin_lock(&inode->io_failure_lock);
-	node = rb_simple_search(&inode->io_failure_tree, start);
-	if (node)
-		failrec = rb_entry(node, struct io_failure_record, rb_node);
-	spin_unlock(&inode->io_failure_lock);
-	return failrec;
-}
-
-static void free_io_failure(struct btrfs_inode *inode,
-			    struct io_failure_record *rec)
-{
-	spin_lock(&inode->io_failure_lock);
-	rb_erase(&rec->rb_node, &inode->io_failure_tree);
-	spin_unlock(&inode->io_failure_lock);
-
-	kfree(rec);
-}
-
-static int next_mirror(const struct io_failure_record *failrec, int cur_mirror)
-{
-	if (cur_mirror == failrec->num_copies)
-		return cur_mirror + 1 - failrec->num_copies;
-	return cur_mirror + 1;
-}
-
-static int prev_mirror(const struct io_failure_record *failrec, int cur_mirror)
-{
-	if (cur_mirror == 1)
-		return failrec->num_copies;
-	return cur_mirror - 1;
-}
-
-/*
- * each time an IO finishes, we do a fast check in the IO failure tree
- * to see if we need to process or clean up an io_failure_record
- */
-int btrfs_clean_io_failure(struct btrfs_inode *inode, u64 start,
-			   struct page *page, unsigned int pg_offset)
-{
-	struct btrfs_fs_info *fs_info = inode->root->fs_info;
-	struct extent_io_tree *io_tree = &inode->io_tree;
-	u64 ino = btrfs_ino(inode);
-	u64 locked_start, locked_end;
-	struct io_failure_record *failrec;
-	int mirror;
-	int ret;
-
-	failrec = get_failrec(inode, start);
-	if (IS_ERR(failrec))
-		return 0;
-
-	BUG_ON(!failrec->this_mirror);
-
-	if (sb_rdonly(fs_info->sb))
-		goto out;
-
-	ret = find_first_extent_bit(io_tree, failrec->bytenr, &locked_start,
-				    &locked_end, EXTENT_LOCKED, NULL);
-	if (ret || locked_start > failrec->bytenr ||
-	    locked_end < failrec->bytenr + failrec->len - 1)
-		goto out;
-
-	mirror = failrec->this_mirror;
-	do {
-		mirror = prev_mirror(failrec, mirror);
-		btrfs_repair_io_failure(fs_info, ino, start, failrec->len,
-				  failrec->logical, page, pg_offset, mirror);
-	} while (mirror != failrec->failed_mirror);
-
-out:
-	free_io_failure(inode, failrec);
-	return 0;
-}
-
-/*
- * Can be called when
- * - hold extent lock
- * - under ordered extent
- * - the inode is freeing
- */
-void btrfs_free_io_failure_record(struct btrfs_inode *inode, u64 start, u64 end)
-{
-	struct io_failure_record *failrec;
-	struct rb_node *node, *next;
-
-	if (RB_EMPTY_ROOT(&inode->io_failure_tree))
-		return;
-
-	spin_lock(&inode->io_failure_lock);
-	node = rb_simple_search_first(&inode->io_failure_tree, start);
-	while (node) {
-		failrec = rb_entry(node, struct io_failure_record, rb_node);
-		if (failrec->bytenr > end)
-			break;
-
-		next = rb_next(node);
-		rb_erase(&failrec->rb_node, &inode->io_failure_tree);
-		kfree(failrec);
-
-		node = next;
-	}
-	spin_unlock(&inode->io_failure_lock);
-}
-
-static struct io_failure_record *btrfs_get_io_failure_record(struct inode *inode,
-							     struct btrfs_bio *bbio,
-							     unsigned int bio_offset)
-{
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
-	u64 start = bbio->file_offset + bio_offset;
-	struct io_failure_record *failrec;
-	const u32 sectorsize = fs_info->sectorsize;
-	int ret;
-
-	failrec = get_failrec(BTRFS_I(inode), start);
-	if (!IS_ERR(failrec)) {
-		btrfs_debug(fs_info,
-	"Get IO Failure Record: (found) logical=%llu, start=%llu, len=%llu",
-			failrec->logical, failrec->bytenr, failrec->len);
-		/*
-		 * when data can be on disk more than twice, add to failrec here
-		 * (e.g. with a list for failed_mirror) to make
-		 * clean_io_failure() clean all those errors at once.
-		 */
-		ASSERT(failrec->this_mirror == bbio->mirror_num);
-		ASSERT(failrec->len == fs_info->sectorsize);
-		return failrec;
-	}
-
-	failrec = kzalloc(sizeof(*failrec), GFP_NOFS);
-	if (!failrec)
-		return ERR_PTR(-ENOMEM);
-
-	RB_CLEAR_NODE(&failrec->rb_node);
-	failrec->bytenr = start;
-	failrec->len = sectorsize;
-	failrec->failed_mirror = bbio->mirror_num;
-	failrec->this_mirror = bbio->mirror_num;
-	failrec->logical = (bbio->iter.bi_sector << SECTOR_SHIFT) + bio_offset;
-
-	btrfs_debug(fs_info,
-		    "new io failure record logical %llu start %llu",
-		    failrec->logical, start);
-
-	failrec->num_copies = btrfs_num_copies(fs_info, failrec->logical, sectorsize);
-	if (failrec->num_copies == 1) {
-		/*
-		 * We only have a single copy of the data, so don't bother with
-		 * all the retry and error correction code that follows. No
-		 * matter what the error is, it is very likely to persist.
-		 */
-		btrfs_debug(fs_info,
-			"cannot repair logical %llu num_copies %d",
-			failrec->logical, failrec->num_copies);
-		kfree(failrec);
-		return ERR_PTR(-EIO);
-	}
-
-	/* Set the bits in the private failure tree */
-	ret = insert_failrec(BTRFS_I(inode), failrec);
-	if (ret) {
-		kfree(failrec);
-		return ERR_PTR(ret);
-	}
-
-	return failrec;
-}
-
-int btrfs_repair_one_sector(struct btrfs_inode *inode, struct btrfs_bio *failed_bbio,
-			    u32 bio_offset, struct page *page, unsigned int pgoff,
-			    bool submit_buffered)
-{
-	u64 start = failed_bbio->file_offset + bio_offset;
-	struct io_failure_record *failrec;
-	struct btrfs_fs_info *fs_info = inode->root->fs_info;
-	struct bio *failed_bio = &failed_bbio->bio;
-	const int icsum = bio_offset >> fs_info->sectorsize_bits;
-	struct bio *repair_bio;
-	struct btrfs_bio *repair_bbio;
-
-	btrfs_debug(fs_info,
-		   "repair read error: read error at %llu", start);
-
-	BUG_ON(bio_op(failed_bio) == REQ_OP_WRITE);
-
-	failrec = btrfs_get_io_failure_record(&inode->vfs_inode, failed_bbio, bio_offset);
-	if (IS_ERR(failrec))
-		return PTR_ERR(failrec);
-
-	/*
-	 * There are two premises:
-	 * a) deliver good data to the caller
-	 * b) correct the bad sectors on disk
-	 *
-	 * Since we're only doing repair for one sector, we only need to get
-	 * a good copy of the failed sector and if we succeed, we have setup
-	 * everything for btrfs_repair_io_failure to do the rest for us.
-	 */
-	failrec->this_mirror = next_mirror(failrec, failrec->this_mirror);
-	if (failrec->this_mirror == failrec->failed_mirror) {
-		btrfs_debug(fs_info,
-			"failed to repair num_copies %d this_mirror %d failed_mirror %d",
-			failrec->num_copies, failrec->this_mirror, failrec->failed_mirror);
-		free_io_failure(inode, failrec);
-		return -EIO;
-	}
-
-	repair_bio = btrfs_bio_alloc(1, REQ_OP_READ, failed_bbio->end_io,
-				     failed_bbio->private);
-	repair_bbio = btrfs_bio(repair_bio);
-	repair_bbio->file_offset = start;
-	repair_bio->bi_iter.bi_sector = failrec->logical >> 9;
-
-	if (failed_bbio->csum) {
-		const u32 csum_size = fs_info->csum_size;
-
-		repair_bbio->csum = repair_bbio->csum_inline;
-		memcpy(repair_bbio->csum,
-		       failed_bbio->csum + csum_size * icsum, csum_size);
-	}
-
-	bio_add_page(repair_bio, page, failrec->len, pgoff);
-	repair_bbio->iter = repair_bio->bi_iter;
-
-	btrfs_debug(fs_info,
-		    "repair read error: submitting new read to mirror %d",
-		    failrec->this_mirror);
-
-	/*
-	 * At this point we have a bio, so any errors from bio submission will
-	 * be handled by the endio on the repair_bio, so we can't return an
-	 * error here.
-	 */
-	if (submit_buffered)
-		btrfs_submit_data_read_bio(inode, repair_bio,
-					   failrec->this_mirror, 0);
-	else
-		btrfs_submit_dio_repair_bio(inode, repair_bio, failrec->this_mirror);
-
-	return BLK_STS_OK;
-}
-
 static void end_page_read(struct page *page, bool uptodate, u64 start, u32 len)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(page->mapping->host->i_sb);
@@ -783,79 +523,6 @@ static void end_page_read(struct page *page, bool uptodate, u64 start, u32 len)
 		btrfs_subpage_end_reader(fs_info, page, start, len);
 }
 
-static void end_sector_io(struct page *page, u64 offset, bool uptodate)
-{
-	struct btrfs_inode *inode = BTRFS_I(page->mapping->host);
-	const u32 sectorsize = inode->root->fs_info->sectorsize;
-
-	end_page_read(page, uptodate, offset, sectorsize);
-	unlock_extent(&inode->io_tree, offset, offset + sectorsize - 1, NULL);
-}
-
-static void submit_data_read_repair(struct inode *inode,
-				    struct btrfs_bio *failed_bbio,
-				    u32 bio_offset, const struct bio_vec *bvec,
-				    unsigned int error_bitmap)
-{
-	const unsigned int pgoff = bvec->bv_offset;
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
-	struct page *page = bvec->bv_page;
-	const u64 start = page_offset(bvec->bv_page) + bvec->bv_offset;
-	const u64 end = start + bvec->bv_len - 1;
-	const u32 sectorsize = fs_info->sectorsize;
-	const int nr_bits = (end + 1 - start) >> fs_info->sectorsize_bits;
-	int i;
-
-	BUG_ON(bio_op(&failed_bbio->bio) == REQ_OP_WRITE);
-
-	/* This repair is only for data */
-	ASSERT(is_data_inode(inode));
-
-	/* We're here because we had some read errors or csum mismatch */
-	ASSERT(error_bitmap);
-
-	/*
-	 * We only get called on buffered IO, thus page must be mapped and bio
-	 * must not be cloned.
-	 */
-	ASSERT(page->mapping && !bio_flagged(&failed_bbio->bio, BIO_CLONED));
-
-	/* Iterate through all the sectors in the range */
-	for (i = 0; i < nr_bits; i++) {
-		const unsigned int offset = i * sectorsize;
-		bool uptodate = false;
-		int ret;
-
-		if (!(error_bitmap & (1U << i))) {
-			/*
-			 * This sector has no error, just end the page read
-			 * and unlock the range.
-			 */
-			uptodate = true;
-			goto next;
-		}
-
-		ret = btrfs_repair_one_sector(BTRFS_I(inode), failed_bbio,
-				bio_offset + offset, page, pgoff + offset,
-				true);
-		if (!ret) {
-			/*
-			 * We have submitted the read repair, the page release
-			 * will be handled by the endio function of the
-			 * submitted repair bio.
-			 * Thus we don't need to do any thing here.
-			 */
-			continue;
-		}
-		/*
-		 * Continue on failed repair, otherwise the remaining sectors
-		 * will not be properly unlocked.
-		 */
-next:
-		end_sector_io(page, start + offset, uptodate);
-	}
-}
-
 /* lots and lots of room for performance fixes in the end_bio funcs */
 
 void end_extent_writepage(struct page *page, int err, u64 start, u64 end)
@@ -1073,8 +740,6 @@ static void end_bio_extent_readpage(struct btrfs_bio *bbio)
 		struct inode *inode = page->mapping->host;
 		struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 		const u32 sectorsize = fs_info->sectorsize;
-		unsigned int error_bitmap = (unsigned int)-1;
-		bool repair = false;
 		u64 start;
 		u64 end;
 		u32 len;
@@ -1106,25 +771,15 @@ static void end_bio_extent_readpage(struct btrfs_bio *bbio)
 		len = bvec->bv_len;
 
 		mirror = bbio->mirror_num;
-		if (likely(uptodate)) {
-			if (is_data_inode(inode)) {
-				error_bitmap = btrfs_verify_data_csum(bbio,
-						bio_offset, page, start, end);
-				if (error_bitmap)
-					uptodate = false;
-			} else {
-				if (btrfs_validate_metadata_buffer(bbio,
-						page, start, end, mirror))
-					uptodate = false;
-			}
-		}
+		if (uptodate && !is_data_inode(inode) &&
+		    btrfs_validate_metadata_buffer(bbio, page, start, end,
+						   mirror))
+			uptodate = false;
 
 		if (likely(uptodate)) {
 			loff_t i_size = i_size_read(inode);
 			pgoff_t end_index = i_size >> PAGE_SHIFT;
 
-			btrfs_clean_io_failure(BTRFS_I(inode), start, page, 0);
-
 			/*
 			 * Zero out the remaining part if this range straddles
 			 * i_size.
@@ -1141,19 +796,7 @@ static void end_bio_extent_readpage(struct btrfs_bio *bbio)
 				zero_user_segment(page, zero_start,
 						  offset_in_page(end) + 1);
 			}
-		} else if (is_data_inode(inode)) {
-			/*
-			 * Only try to repair bios that actually made it to a
-			 * device.  If the bio failed to be submitted mirror
-			 * is 0 and we need to fail it without retrying.
-			 *
-			 * This also includes the high level bios for compressed
-			 * extents - these never make it to a device and repair
-			 * is already handled on the lower compressed bio.
-			 */
-			if (mirror > 0)
-				repair = true;
-		} else {
+		} else if (!is_data_inode(inode)) {
 			struct extent_buffer *eb;
 
 			eb = find_extent_buffer_readpage(fs_info, page, start);
@@ -1162,19 +805,10 @@ static void end_bio_extent_readpage(struct btrfs_bio *bbio)
 			atomic_dec(&eb->io_pages);
 		}
 
-		if (repair) {
-			/*
-			 * submit_data_read_repair() will handle all the good
-			 * and bad sectors, we just continue to the next bvec.
-			 */
-			submit_data_read_repair(inode, bbio, bio_offset, bvec,
-						error_bitmap);
-		} else {
-			/* Update page status and unlock */
-			end_page_read(page, uptodate, start, len);
-			endio_readpage_release_extent(&processed, BTRFS_I(inode),
-					start, end, PageUptodate(page));
-		}
+		/* Update page status and unlock */
+		end_page_read(page, uptodate, start, len);
+		endio_readpage_release_extent(&processed, BTRFS_I(inode),
+				start, end, PageUptodate(page));
 
 		ASSERT(bio_offset + len > bio_offset);
 		bio_offset += len;
@@ -1182,7 +816,6 @@ static void end_bio_extent_readpage(struct btrfs_bio *bbio)
 	}
 	/* Release the last extent */
 	endio_readpage_release_extent(&processed, NULL, 0, 0, false);
-	btrfs_bio_free_csum(bbio);
 	bio_put(bio);
 }
 
@@ -1374,9 +1007,8 @@ static int alloc_new_bio(struct btrfs_inode *inode,
 	struct bio *bio;
 	int ret;
 
-	ASSERT(bio_ctrl->end_io_func);
-
-	bio = btrfs_bio_alloc(BIO_MAX_VECS, opf, bio_ctrl->end_io_func, NULL);
+	bio = btrfs_bio_alloc(BIO_MAX_VECS, opf, inode, bio_ctrl->end_io_func,
+			      NULL);
 	/*
 	 * For compressed page range, its disk_bytenr is always @disk_bytenr
 	 * passed in, no matter if we have added any range into previous bio.
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index a2c82448b2e07..1b311cd697832 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -60,11 +60,9 @@ enum {
 #define BITMAP_LAST_BYTE_MASK(nbits) \
 	(BYTE_MASK >> (-(nbits) & (BITS_PER_BYTE - 1)))
 
-struct btrfs_bio;
 struct btrfs_root;
 struct btrfs_inode;
 struct btrfs_fs_info;
-struct io_failure_record;
 struct extent_io_tree;
 struct btrfs_tree_parent_check;
 
@@ -279,35 +277,6 @@ int btrfs_alloc_page_array(unsigned int nr_pages, struct page **page_array);
 
 void end_extent_writepage(struct page *page, int err, u64 start, u64 end);
 
-/*
- * When IO fails, either with EIO or csum verification fails, we
- * try other mirrors that might have a good copy of the data.  This
- * io_failure_record is used to record state as we go through all the
- * mirrors.  If another mirror has good data, the sector is set up to date
- * and things continue.  If a good mirror can't be found, the original
- * bio end_io callback is called to indicate things have failed.
- */
-struct io_failure_record {
-	/* Use rb_simple_node for search/insert */
-	struct {
-		struct rb_node rb_node;
-		u64 bytenr;
-	};
-	struct page *page;
-	u64 len;
-	u64 logical;
-	int this_mirror;
-	int failed_mirror;
-	int num_copies;
-};
-
-int btrfs_repair_one_sector(struct btrfs_inode *inode, struct btrfs_bio *failed_bbio,
-			    u32 bio_offset, struct page *page, unsigned int pgoff,
-			    bool submit_buffered);
-void btrfs_free_io_failure_record(struct btrfs_inode *inode, u64 start, u64 end);
-int btrfs_clean_io_failure(struct btrfs_inode *inode, u64 start,
-			   struct page *page, unsigned int pg_offset);
-
 #ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
 bool find_lock_delalloc_range(struct inode *inode,
 			     struct page *locked_page, u64 *start,
diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index 5de73466b2ca2..c5324fe8f4be7 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -380,32 +380,25 @@ static int search_file_offset_in_bio(struct bio *bio, struct inode *inode,
 /*
  * Lookup the checksum for the read bio in csum tree.
  *
- * @inode:  inode that the bio is for.
- * @bio:    bio to look up.
- * @dst:    Buffer of size nblocks * btrfs_super_csum_size() used to return
- *          checksum (nblocks = bio->bi_iter.bi_size / fs_info->sectorsize). If
- *          NULL, the checksum buffer is allocated and returned in
- *          btrfs_bio(bio)->csum instead.
- *
  * Return: BLK_STS_RESOURCE if allocating memory fails, BLK_STS_OK otherwise.
  */
-blk_status_t btrfs_lookup_bio_sums(struct inode *inode, struct bio *bio, u8 *dst)
+blk_status_t btrfs_lookup_bio_sums(struct btrfs_bio *bbio)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
-	struct extent_io_tree *io_tree = &BTRFS_I(inode)->io_tree;
-	struct btrfs_bio *bbio = NULL;
+	struct btrfs_inode *inode = bbio->inode;
+	struct btrfs_fs_info *fs_info = inode->root->fs_info;
+	struct extent_io_tree *io_tree = &inode->io_tree;
+	struct bio *bio = &bbio->bio;
 	struct btrfs_path *path;
 	const u32 sectorsize = fs_info->sectorsize;
 	const u32 csum_size = fs_info->csum_size;
 	u32 orig_len = bio->bi_iter.bi_size;
 	u64 orig_disk_bytenr = bio->bi_iter.bi_sector << SECTOR_SHIFT;
 	u64 cur_disk_bytenr;
-	u8 *csum;
 	const unsigned int nblocks = orig_len >> fs_info->sectorsize_bits;
 	int count = 0;
 	blk_status_t ret = BLK_STS_OK;
 
-	if ((BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM) ||
+	if ((inode->flags & BTRFS_INODE_NODATASUM) ||
 	    test_bit(BTRFS_FS_STATE_NO_CSUMS, &fs_info->fs_state))
 		return BLK_STS_OK;
 
@@ -426,21 +419,14 @@ blk_status_t btrfs_lookup_bio_sums(struct inode *inode, struct bio *bio, u8 *dst
 	if (!path)
 		return BLK_STS_RESOURCE;
 
-	if (!dst) {
-		bbio = btrfs_bio(bio);
-
-		if (nblocks * csum_size > BTRFS_BIO_INLINE_CSUM_SIZE) {
-			bbio->csum = kmalloc_array(nblocks, csum_size, GFP_NOFS);
-			if (!bbio->csum) {
-				btrfs_free_path(path);
-				return BLK_STS_RESOURCE;
-			}
-		} else {
-			bbio->csum = bbio->csum_inline;
+	if (nblocks * csum_size > BTRFS_BIO_INLINE_CSUM_SIZE) {
+		bbio->csum = kmalloc_array(nblocks, csum_size, GFP_NOFS);
+		if (!bbio->csum) {
+			btrfs_free_path(path);
+			return BLK_STS_RESOURCE;
 		}
-		csum = bbio->csum;
 	} else {
-		csum = dst;
+		bbio->csum = bbio->csum_inline;
 	}
 
 	/*
@@ -456,7 +442,7 @@ blk_status_t btrfs_lookup_bio_sums(struct inode *inode, struct bio *bio, u8 *dst
 	 * read from the commit root and sidestep a nasty deadlock
 	 * between reading the free space cache and updating the csum tree.
 	 */
-	if (btrfs_is_free_space_inode(BTRFS_I(inode))) {
+	if (btrfs_is_free_space_inode(inode)) {
 		path->search_commit_root = 1;
 		path->skip_locking = 1;
 	}
@@ -479,14 +465,15 @@ blk_status_t btrfs_lookup_bio_sums(struct inode *inode, struct bio *bio, u8 *dst
 		ASSERT(cur_disk_bytenr - orig_disk_bytenr < UINT_MAX);
 		sector_offset = (cur_disk_bytenr - orig_disk_bytenr) >>
 				fs_info->sectorsize_bits;
-		csum_dst = csum + sector_offset * csum_size;
+		csum_dst = bbio->csum + sector_offset * csum_size;
 
 		count = search_csum_tree(fs_info, path, cur_disk_bytenr,
 					 search_len, csum_dst);
 		if (count < 0) {
 			ret = errno_to_blk_status(count);
-			if (bbio)
-				btrfs_bio_free_csum(bbio);
+			if (bbio->csum != bbio->csum_inline)
+				kfree(bbio->csum);
+			bbio->csum = NULL;
 			break;
 		}
 
@@ -504,12 +491,13 @@ blk_status_t btrfs_lookup_bio_sums(struct inode *inode, struct bio *bio, u8 *dst
 			memset(csum_dst, 0, csum_size);
 			count = 1;
 
-			if (BTRFS_I(inode)->root->root_key.objectid ==
+			if (inode->root->root_key.objectid ==
 			    BTRFS_DATA_RELOC_TREE_OBJECTID) {
 				u64 file_offset;
 				int ret;
 
-				ret = search_file_offset_in_bio(bio, inode,
+				ret = search_file_offset_in_bio(bio,
+						&inode->vfs_inode,
 						cur_disk_bytenr, &file_offset);
 				if (ret)
 					set_extent_bits(io_tree, file_offset,
diff --git a/fs/btrfs/file-item.h b/fs/btrfs/file-item.h
index 0312256684349..a2f9747adf3ac 100644
--- a/fs/btrfs/file-item.h
+++ b/fs/btrfs/file-item.h
@@ -38,7 +38,7 @@ static inline u32 btrfs_file_extent_calc_inline_size(u32 datasize)
 
 int btrfs_del_csums(struct btrfs_trans_handle *trans,
 		    struct btrfs_root *root, u64 bytenr, u64 len);
-blk_status_t btrfs_lookup_bio_sums(struct inode *inode, struct bio *bio, u8 *dst);
+blk_status_t btrfs_lookup_bio_sums(struct btrfs_bio *bbio);
 int btrfs_insert_hole_extent(struct btrfs_trans_handle *trans,
 			     struct btrfs_root *root, u64 objectid, u64 pos,
 			     u64 num_bytes);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 905ea19df125b..539fa462b473d 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -100,9 +100,6 @@ struct btrfs_dio_private {
 	 */
 	refcount_t refs;
 
-	/* Array of checksums */
-	u8 *csums;
-
 	/* This must be last */
 	struct bio bio;
 };
@@ -2764,9 +2761,6 @@ void btrfs_submit_data_write_bio(struct btrfs_inode *inode, struct bio *bio, int
 void btrfs_submit_data_read_bio(struct btrfs_inode *inode, struct bio *bio,
 			int mirror_num, enum btrfs_compression_type compress_type)
 {
-	struct btrfs_fs_info *fs_info = inode->root->fs_info;
-	blk_status_t ret;
-
 	if (compress_type != BTRFS_COMPRESS_NONE) {
 		/*
 		 * btrfs_submit_compressed_read will handle completing the bio
@@ -2776,20 +2770,7 @@ void btrfs_submit_data_read_bio(struct btrfs_inode *inode, struct bio *bio,
 		return;
 	}
 
-	/* Save the original iter for read repair */
-	btrfs_bio(bio)->iter = bio->bi_iter;
-
-	/*
-	 * Lookup bio sums does extra checks around whether we need to csum or
-	 * not, which is why we ignore skip_sum here.
-	 */
-	ret = btrfs_lookup_bio_sums(&inode->vfs_inode, bio, NULL);
-	if (ret) {
-		btrfs_bio_end_io(btrfs_bio(bio), ret);
-		return;
-	}
-
-	btrfs_submit_bio(fs_info, bio, mirror_num);
+	btrfs_submit_bio(inode->root->fs_info, bio, mirror_num);
 }
 
 /*
@@ -3266,8 +3247,6 @@ int btrfs_finish_ordered_io(struct btrfs_ordered_extent *ordered_extent)
 					ordered_extent->disk_num_bytes);
 	}
 
-	btrfs_free_io_failure_record(inode, start, end);
-
 	if (test_bit(BTRFS_ORDERED_TRUNCATED, &ordered_extent->flags)) {
 		truncated = true;
 		logical_len = ordered_extent->truncated_len;
@@ -3474,109 +3453,55 @@ static u8 *btrfs_csum_ptr(const struct btrfs_fs_info *fs_info, u8 *csums, u64 of
 }
 
 /*
- * check_data_csum - verify checksum of one sector of uncompressed data
- * @inode:	inode
- * @bbio:	btrfs_bio which contains the csum
+ * btrfs_data_csum_ok - verify the checksum of single data sector
+ * @bbio:	btrfs_io_bio which contains the csum
+ * @dev:	device the sector is on
  * @bio_offset:	offset to the beginning of the bio (in bytes)
- * @page:	page where is the data to be verified
- * @pgoff:	offset inside the page
+ * @bv:		bio_vec to check
  *
- * The length of such check is always one sector size.
+ * Check if the checksum on a data block is valid.  When a checksum mismatch is
+ * detected, report the error and fill the corrupted range with zero.
  *
- * When csum mismatch is detected, we will also report the error and fill the
- * corrupted range with zero. (Thus it needs the extra parameters)
+ * Return %true if the sector is ok or had no checksum to start with, else
+ * %false.
  */
-int btrfs_check_data_csum(struct btrfs_inode *inode, struct btrfs_bio *bbio,
-			  u32 bio_offset, struct page *page, u32 pgoff)
+bool btrfs_data_csum_ok(struct btrfs_bio *bbio, struct btrfs_device *dev,
+			u32 bio_offset, struct bio_vec *bv)
 {
+	struct btrfs_inode *inode = bbio->inode;
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
-	u32 len = fs_info->sectorsize;
+	u64 file_offset = bbio->file_offset + bio_offset;
+	u64 end = file_offset + bv->bv_len - 1;
 	u8 *csum_expected;
 	u8 csum[BTRFS_CSUM_SIZE];
 
-	ASSERT(pgoff + len <= PAGE_SIZE);
+	ASSERT(bv->bv_len == fs_info->sectorsize);
 
-	csum_expected = btrfs_csum_ptr(fs_info, bbio->csum, bio_offset);
+	if (!bbio->csum)
+		return true;
 
-	if (btrfs_check_sector_csum(fs_info, page, pgoff, csum, csum_expected))
-		goto zeroit;
-	return 0;
+	if (btrfs_is_data_reloc_root(inode->root) &&
+	    test_range_bit(&inode->io_tree, file_offset, end, EXTENT_NODATASUM,
+			1, NULL)) {
+		/* Skip the range without csum for data reloc inode */
+		clear_extent_bits(&inode->io_tree, file_offset, end,
+				  EXTENT_NODATASUM);
+		return true;
+	}
 
+	csum_expected = btrfs_csum_ptr(fs_info, bbio->csum, bio_offset);
+	if (btrfs_check_sector_csum(fs_info, bv->bv_page, bv->bv_offset, csum,
+				    csum_expected))
+		goto zeroit;
+	return true;
 zeroit:
-	btrfs_print_data_csum_error(inode, bbio->file_offset + bio_offset,
-				    csum, csum_expected, bbio->mirror_num);
-	if (bbio->device)
-		btrfs_dev_stat_inc_and_print(bbio->device,
+	btrfs_print_data_csum_error(inode, file_offset, csum, csum_expected,
+				    bbio->mirror_num);
+	if (dev)
+		btrfs_dev_stat_inc_and_print(dev,
 					     BTRFS_DEV_STAT_CORRUPTION_ERRS);
-	memzero_page(page, pgoff, len);
-	return -EIO;
-}
-
-/*
- * When reads are done, we need to check csums to verify the data is correct.
- * if there's a match, we allow the bio to finish.  If not, the code in
- * extent_io.c will try to find good copies for us.
- *
- * @bio_offset:	offset to the beginning of the bio (in bytes)
- * @start:	file offset of the range start
- * @end:	file offset of the range end (inclusive)
- *
- * Return a bitmap where bit set means a csum mismatch, and bit not set means
- * csum match.
- */
-unsigned int btrfs_verify_data_csum(struct btrfs_bio *bbio,
-				    u32 bio_offset, struct page *page,
-				    u64 start, u64 end)
-{
-	struct btrfs_inode *inode = BTRFS_I(page->mapping->host);
-	struct btrfs_root *root = inode->root;
-	struct btrfs_fs_info *fs_info = root->fs_info;
-	struct extent_io_tree *io_tree = &inode->io_tree;
-	const u32 sectorsize = root->fs_info->sectorsize;
-	u32 pg_off;
-	unsigned int result = 0;
-
-	/*
-	 * This only happens for NODATASUM or compressed read.
-	 * Normally this should be covered by above check for compressed read
-	 * or the next check for NODATASUM.  Just do a quicker exit here.
-	 */
-	if (bbio->csum == NULL)
-		return 0;
-
-	if (inode->flags & BTRFS_INODE_NODATASUM)
-		return 0;
-
-	if (unlikely(test_bit(BTRFS_FS_STATE_NO_CSUMS, &fs_info->fs_state)))
-		return 0;
-
-	ASSERT(page_offset(page) <= start &&
-	       end <= page_offset(page) + PAGE_SIZE - 1);
-	for (pg_off = offset_in_page(start);
-	     pg_off < offset_in_page(end);
-	     pg_off += sectorsize, bio_offset += sectorsize) {
-		u64 file_offset = pg_off + page_offset(page);
-		int ret;
-
-		if (btrfs_is_data_reloc_root(root) &&
-		    test_range_bit(io_tree, file_offset,
-				   file_offset + sectorsize - 1,
-				   EXTENT_NODATASUM, 1, NULL)) {
-			/* Skip the range without csum for data reloc inode */
-			clear_extent_bits(io_tree, file_offset,
-					  file_offset + sectorsize - 1,
-					  EXTENT_NODATASUM);
-			continue;
-		}
-		ret = btrfs_check_data_csum(inode, bbio, bio_offset, page, pg_off);
-		if (ret < 0) {
-			const int nr_bit = (pg_off - offset_in_page(start)) >>
-				     root->fs_info->sectorsize_bits;
-
-			result |= (1U << nr_bit);
-		}
-	}
-	return result;
+	memzero_bvec(bv);
+	return false;
 }
 
 /*
@@ -5466,8 +5391,6 @@ void btrfs_evict_inode(struct inode *inode)
 	if (is_bad_inode(inode))
 		goto no_delete;
 
-	btrfs_free_io_failure_record(BTRFS_I(inode), 0, (u64)-1);
-
 	if (test_bit(BTRFS_FS_LOG_RECOVERING, &fs_info->flags))
 		goto no_delete;
 
@@ -7907,53 +7830,9 @@ static void btrfs_dio_private_put(struct btrfs_dio_private *dip)
 			      dip->file_offset + dip->bytes - 1, NULL);
 	}
 
-	kfree(dip->csums);
 	bio_endio(&dip->bio);
 }
 
-void btrfs_submit_dio_repair_bio(struct btrfs_inode *inode, struct bio *bio, int mirror_num)
-{
-	struct btrfs_dio_private *dip = btrfs_bio(bio)->private;
-
-	BUG_ON(bio_op(bio) == REQ_OP_WRITE);
-
-	refcount_inc(&dip->refs);
-	btrfs_submit_bio(inode->root->fs_info, bio, mirror_num);
-}
-
-static blk_status_t btrfs_check_read_dio_bio(struct btrfs_dio_private *dip,
-					     struct btrfs_bio *bbio,
-					     const bool uptodate)
-{
-	struct inode *inode = &dip->inode->vfs_inode;
-	struct btrfs_fs_info *fs_info = BTRFS_I(inode)->root->fs_info;
-	const bool csum = !(BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM);
-	blk_status_t err = BLK_STS_OK;
-	struct bvec_iter iter;
-	struct bio_vec bv;
-	u32 offset;
-
-	btrfs_bio_for_each_sector(fs_info, bv, bbio, iter, offset) {
-		u64 start = bbio->file_offset + offset;
-
-		if (uptodate &&
-		    (!csum || !btrfs_check_data_csum(BTRFS_I(inode), bbio, offset,
-						     bv.bv_page, bv.bv_offset))) {
-			btrfs_clean_io_failure(BTRFS_I(inode), start,
-					       bv.bv_page, bv.bv_offset);
-		} else {
-			int ret;
-
-			ret = btrfs_repair_one_sector(BTRFS_I(inode), bbio, offset,
-					bv.bv_page, bv.bv_offset, false);
-			if (ret)
-				err = errno_to_blk_status(ret);
-		}
-	}
-
-	return err;
-}
-
 blk_status_t btrfs_submit_bio_start_direct_io(struct btrfs_inode *inode,
 					      struct bio *bio,
 					      u64 dio_file_offset)
@@ -7967,18 +7846,14 @@ static void btrfs_end_dio_bio(struct btrfs_bio *bbio)
 	struct bio *bio = &bbio->bio;
 	blk_status_t err = bio->bi_status;
 
-	if (err)
+	if (err) {
 		btrfs_warn(dip->inode->root->fs_info,
 			   "direct IO failed ino %llu rw %d,%u sector %#Lx len %u err no %d",
 			   btrfs_ino(dip->inode), bio_op(bio),
 			   bio->bi_opf, bio->bi_iter.bi_sector,
 			   bio->bi_iter.bi_size, err);
-
-	if (bio_op(bio) == REQ_OP_READ)
-		err = btrfs_check_read_dio_bio(dip, bbio, !err);
-
-	if (err)
 		dip->bio.bi_status = err;
+	}
 
 	btrfs_record_physical_zoned(&dip->inode->vfs_inode, bbio->file_offset, bio);
 
@@ -7990,13 +7865,8 @@ static void btrfs_submit_dio_bio(struct bio *bio, struct btrfs_inode *inode,
 				 u64 file_offset, int async_submit)
 {
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
-	struct btrfs_dio_private *dip = btrfs_bio(bio)->private;
 	blk_status_t ret;
 
-	/* Save the original iter for read repair */
-	if (btrfs_op(bio) == BTRFS_MAP_READ)
-		btrfs_bio(bio)->iter = bio->bi_iter;
-
 	if (inode->flags & BTRFS_INODE_NODATASUM)
 		goto map;
 
@@ -8016,9 +7886,6 @@ static void btrfs_submit_dio_bio(struct bio *bio, struct btrfs_inode *inode,
 			btrfs_bio_end_io(btrfs_bio(bio), ret);
 			return;
 		}
-	} else {
-		btrfs_bio(bio)->csum = btrfs_csum_ptr(fs_info, dip->csums,
-						      file_offset - dip->file_offset);
 	}
 map:
 	btrfs_submit_bio(fs_info, bio, 0);
@@ -8030,7 +7897,6 @@ static void btrfs_submit_direct(const struct iomap_iter *iter,
 	struct btrfs_dio_private *dip =
 		container_of(dio_bio, struct btrfs_dio_private, bio);
 	struct inode *inode = iter->inode;
-	const bool write = (btrfs_op(dio_bio) == BTRFS_MAP_WRITE);
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	const bool raid56 = (btrfs_data_alloc_profile(fs_info) &
 			     BTRFS_BLOCK_GROUP_RAID56_MASK);
@@ -8051,25 +7917,6 @@ static void btrfs_submit_direct(const struct iomap_iter *iter,
 	dip->file_offset = file_offset;
 	dip->bytes = dio_bio->bi_iter.bi_size;
 	refcount_set(&dip->refs, 1);
-	dip->csums = NULL;
-
-	if (!write && !(BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM)) {
-		unsigned int nr_sectors =
-			(dio_bio->bi_iter.bi_size >> fs_info->sectorsize_bits);
-
-		/*
-		 * Load the csums up front to reduce csum tree searches and
-		 * contention when submitting bios.
-		 */
-		status = BLK_STS_RESOURCE;
-		dip->csums = kcalloc(nr_sectors, fs_info->csum_size, GFP_NOFS);
-		if (!dip->csums)
-			goto out_err;
-
-		status = btrfs_lookup_bio_sums(inode, dio_bio, dip->csums);
-		if (status != BLK_STS_OK)
-			goto out_err;
-	}
 
 	start_sector = dio_bio->bi_iter.bi_sector;
 	submit_len = dio_bio->bi_iter.bi_size;
@@ -8097,7 +7944,8 @@ static void btrfs_submit_direct(const struct iomap_iter *iter,
 		 * the allocation is backed by btrfs_bioset.
 		 */
 		bio = btrfs_bio_clone_partial(dio_bio, clone_offset, clone_len,
-					      btrfs_end_dio_bio, dip);
+					      BTRFS_I(inode), btrfs_end_dio_bio,
+					      dip);
 		btrfs_bio(bio)->file_offset = file_offset;
 
 		if (bio_op(bio) == REQ_OP_ZONE_APPEND) {
@@ -8850,7 +8698,6 @@ struct inode *btrfs_alloc_inode(struct super_block *sb)
 	ei->last_log_commit = 0;
 
 	spin_lock_init(&ei->lock);
-	spin_lock_init(&ei->io_failure_lock);
 	ei->outstanding_extents = 0;
 	if (sb->s_magic != BTRFS_TEST_MAGIC)
 		btrfs_init_metadata_block_rsv(fs_info, &ei->block_rsv,
@@ -8870,7 +8717,6 @@ struct inode *btrfs_alloc_inode(struct super_block *sb)
 	ei->io_tree.inode = ei;
 	extent_io_tree_init(fs_info, &ei->file_extent_tree,
 			    IO_TREE_INODE_FILE_EXTENT);
-	ei->io_failure_tree = RB_ROOT;
 	atomic_set(&ei->sync_writers, 0);
 	mutex_init(&ei->log_mutex);
 	btrfs_ordered_inode_tree_init(&ei->ordered_tree);
@@ -10287,7 +10133,6 @@ struct btrfs_encoded_read_private {
 	wait_queue_head_t wait;
 	atomic_t pending;
 	blk_status_t status;
-	bool skip_csum;
 };
 
 static blk_status_t submit_encoded_read_bio(struct btrfs_inode *inode,
@@ -10295,57 +10140,17 @@ static blk_status_t submit_encoded_read_bio(struct btrfs_inode *inode,
 {
 	struct btrfs_encoded_read_private *priv = btrfs_bio(bio)->private;
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
-	blk_status_t ret;
-
-	if (!priv->skip_csum) {
-		ret = btrfs_lookup_bio_sums(&inode->vfs_inode, bio, NULL);
-		if (ret)
-			return ret;
-	}
 
 	atomic_inc(&priv->pending);
 	btrfs_submit_bio(fs_info, bio, mirror_num);
 	return BLK_STS_OK;
 }
 
-static blk_status_t btrfs_encoded_read_verify_csum(struct btrfs_bio *bbio)
-{
-	const bool uptodate = (bbio->bio.bi_status == BLK_STS_OK);
-	struct btrfs_encoded_read_private *priv = bbio->private;
-	struct btrfs_inode *inode = priv->inode;
-	struct btrfs_fs_info *fs_info = inode->root->fs_info;
-	u32 sectorsize = fs_info->sectorsize;
-	struct bio_vec *bvec;
-	struct bvec_iter_all iter_all;
-	u32 bio_offset = 0;
-
-	if (priv->skip_csum || !uptodate)
-		return bbio->bio.bi_status;
-
-	bio_for_each_segment_all(bvec, &bbio->bio, iter_all) {
-		unsigned int i, nr_sectors, pgoff;
-
-		nr_sectors = BTRFS_BYTES_TO_BLKS(fs_info, bvec->bv_len);
-		pgoff = bvec->bv_offset;
-		for (i = 0; i < nr_sectors; i++) {
-			ASSERT(pgoff < PAGE_SIZE);
-			if (btrfs_check_data_csum(inode, bbio, bio_offset,
-					    bvec->bv_page, pgoff))
-				return BLK_STS_IOERR;
-			bio_offset += sectorsize;
-			pgoff += sectorsize;
-		}
-	}
-	return BLK_STS_OK;
-}
-
 static void btrfs_encoded_read_endio(struct btrfs_bio *bbio)
 {
 	struct btrfs_encoded_read_private *priv = bbio->private;
-	blk_status_t status;
 
-	status = btrfs_encoded_read_verify_csum(bbio);
-	if (status) {
+	if (bbio->bio.bi_status) {
 		/*
 		 * The memory barrier implied by the atomic_dec_return() here
 		 * pairs with the memory barrier implied by the
@@ -10354,11 +10159,10 @@ static void btrfs_encoded_read_endio(struct btrfs_bio *bbio)
 		 * write is observed before the load of status in
 		 * btrfs_encoded_read_regular_fill_pages().
 		 */
-		WRITE_ONCE(priv->status, status);
+		WRITE_ONCE(priv->status, bbio->bio.bi_status);
 	}
 	if (!atomic_dec_return(&priv->pending))
 		wake_up(&priv->wait);
-	btrfs_bio_free_csum(bbio);
 	bio_put(&bbio->bio);
 }
 
@@ -10371,7 +10175,6 @@ int btrfs_encoded_read_regular_fill_pages(struct btrfs_inode *inode,
 		.inode = inode,
 		.file_offset = file_offset,
 		.pending = ATOMIC_INIT(1),
-		.skip_csum = (inode->flags & BTRFS_INODE_NODATASUM),
 	};
 	unsigned long i = 0;
 	u64 cur = 0;
@@ -10407,6 +10210,7 @@ int btrfs_encoded_read_regular_fill_pages(struct btrfs_inode *inode,
 
 			if (!bio) {
 				bio = btrfs_bio_alloc(BIO_MAX_VECS, REQ_OP_READ,
+						      inode,
 						      btrfs_encoded_read_endio,
 						      &priv);
 				bio->bi_iter.bi_sector =
-- 
2.30.2

