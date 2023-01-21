Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A13C0676457
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Jan 2023 07:51:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbjAUGvL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 21 Jan 2023 01:51:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbjAUGvJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 21 Jan 2023 01:51:09 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79FC26AF68;
        Fri, 20 Jan 2023 22:51:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=DyW5dkErS7RXgUBGLO5XUvG1QbrmfGDsQnyCqr3eoSA=; b=vduFGhWeGbb7BV+oSgUYud3MvY
        tWba8tVN8t2jQqdonv5xVOdvn/AllZLNwfXZWUNcW2xG7dgSIPS4IVnMcU+p+uz4Ym9Mg6mLnxv0g
        FfssSEmd4gSm0AGol9EMmBazL5btIrZDgyflH9TWUoU1+po9mNZW9SEobGMqDLNfKL3V87UnZXhQe
        UYasmpNO0SdcEX1GAkFlR2/KPm3hO+X7tRVNgCFm/TC7kUvnGUEXE9evkge2a2H4nW8ryFZteBUpj
        UrMbJDliH1iFGmokmXqltErJFFCLGTHYGerpVUPJ2JroiBl+/DsRRaBYtcdN1dafQ1yVAuY6lvlPR
        OxV+zKIQ==;
Received: from [2001:4bb8:19a:2039:6754:cc81:9ace:36fc] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pJ7iO-00DRLs-0L; Sat, 21 Jan 2023 06:51:00 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>, Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 10/34] btrfs: handle checksum validation and repair at the storage layer
Date:   Sat, 21 Jan 2023 07:50:07 +0100
Message-Id: <20230121065031.1139353-11-hch@lst.de>
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

Currently btrfs handles checksum validation and repair in the end I/O
handler for the btrfs_bio.  This leads to a lot of duplicate code
plus issues with variying semantics or bugs, e.g.

 - the until recently broken repair for compressed extents
 - the fact that encoded reads validate the checksums but do not kick
   of read repair
 - the inconsistent checking of the BTRFS_FS_STATE_NO_CSUMS flag

This commit revamps the checksum validation and repair code to instead
work below the btrfs_submit_bio interfaces.

In case of a checksum failure (or a plain old I/O error), the repair
is now kicked off before the upper level ->end_io handler is invoked.

Progress of an in-progress repair is tracked by a small structure
that is allocated using a mempool for each original bio with failed
sectors, which holds a reference to the original bio.   This new
structure is allocated using a mempool to guarantee forward progress
even under memory pressure.  The mempool will be replenished when
the repair completes, just as the mempools backing the bios.

There is one significant behavior change here:  If repair fails or
is impossible to start with, the whole bio will be failed to the
upper layer.  This is the behavior that all I/O submitters except
for buffered I/O already emulated in their end_io handler.  For
buffered I/O this now means that a large readahead request can
fail due to a single bad sector, but as readahead errors are igored
the following readpage if the sector is actually accessed will
still be able to read.  This also matches the I/O failure handling
in other file systems.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/bio.c         | 193 ++++++++++++++++++++++++++++++++++++++++-
 fs/btrfs/compression.c |  41 +--------
 fs/btrfs/extent_io.c   | 125 ++------------------------
 fs/btrfs/inode.c       |  81 +----------------
 4 files changed, 206 insertions(+), 234 deletions(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index 6fbb71e60037be..d1a545158bb0a0 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -17,6 +17,14 @@
 #include "file-item.h"
 
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
@@ -67,6 +75,165 @@ struct bio *btrfs_bio_clone_partial(struct bio *orig, u64 offset, u64 size,
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
+		repair_bbio->bio.bi_iter = repair_bbio->iter;
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
+				  repair_bbio->iter.bi_sector <<
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
+	const u64 logical = failed_bbio->iter.bi_sector << SECTOR_SHIFT;
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
+	repair_bio->bi_iter.bi_sector = failed_bbio->iter.bi_sector;
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
+	struct bvec_iter *iter = &bbio->iter;
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
+	btrfs_bio_free_csum(bbio);
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
@@ -94,7 +261,11 @@ static void btrfs_end_bio_work(struct work_struct *work)
 {
 	struct btrfs_bio *bbio = container_of(work, struct btrfs_bio, end_io_work);
 
-	bbio->end_io(bbio);
+	/* Metadata reads are checked and repaired by the submitter */
+	if (bbio->bio.bi_opf & REQ_META)
+		bbio->end_io(bbio);
+	else
+		btrfs_check_read_bio(bbio, bbio->device);
 }
 
 static void btrfs_simple_end_io(struct bio *bio)
@@ -122,7 +293,10 @@ static void btrfs_raid56_end_io(struct bio *bio)
 
 	btrfs_bio_counter_dec(bioc->fs_info);
 	bbio->mirror_num = bioc->mirror_num;
-	bbio->end_io(bbio);
+	if (bio_op(bio) == REQ_OP_READ && !(bbio->bio.bi_opf & REQ_META))
+		btrfs_check_read_bio(bbio, NULL);
+	else
+		bbio->end_io(bbio);
 
 	btrfs_put_bioc(bioc);
 }
@@ -402,10 +576,25 @@ int __init btrfs_bioset_init(void)
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
diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index fdcc6f3b90b128..f84ccb185c2a6f 100644
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
 
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 44cacf62e4314e..81f44b6c9fad50 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -803,79 +803,6 @@ static void end_page_read(struct page *page, bool uptodate, u64 start, u32 len)
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
@@ -1093,8 +1020,6 @@ static void end_bio_extent_readpage(struct btrfs_bio *bbio)
 		struct inode *inode = page->mapping->host;
 		struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 		const u32 sectorsize = fs_info->sectorsize;
-		unsigned int error_bitmap = (unsigned int)-1;
-		bool repair = false;
 		u64 start;
 		u64 end;
 		u32 len;
@@ -1126,25 +1051,15 @@ static void end_bio_extent_readpage(struct btrfs_bio *bbio)
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
@@ -1161,19 +1076,7 @@ static void end_bio_extent_readpage(struct btrfs_bio *bbio)
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
@@ -1182,19 +1085,10 @@ static void end_bio_extent_readpage(struct btrfs_bio *bbio)
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
@@ -1202,7 +1096,6 @@ static void end_bio_extent_readpage(struct btrfs_bio *bbio)
 	}
 	/* Release the last extent */
 	endio_readpage_release_extent(&processed, NULL, 0, 0, false);
-	btrfs_bio_free_csum(bbio);
 	bio_put(bio);
 }
 
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 12b76d272f08d5..d122bf9a72aaff 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7942,39 +7942,6 @@ void btrfs_submit_dio_repair_bio(struct btrfs_inode *inode, struct bio *bio, int
 	btrfs_submit_bio(inode->root->fs_info, bio, mirror_num);
 }
 
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
@@ -7988,18 +7955,14 @@ static void btrfs_end_dio_bio(struct btrfs_bio *bbio)
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
 
@@ -10283,7 +10246,6 @@ struct btrfs_encoded_read_private {
 	wait_queue_head_t wait;
 	atomic_t pending;
 	blk_status_t status;
-	bool skip_csum;
 };
 
 static blk_status_t submit_encoded_read_bio(struct btrfs_inode *inode,
@@ -10297,44 +10259,11 @@ static blk_status_t submit_encoded_read_bio(struct btrfs_inode *inode,
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
@@ -10343,11 +10272,10 @@ static void btrfs_encoded_read_endio(struct btrfs_bio *bbio)
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
 
@@ -10360,7 +10288,6 @@ int btrfs_encoded_read_regular_fill_pages(struct btrfs_inode *inode,
 		.inode = inode,
 		.file_offset = file_offset,
 		.pending = ATOMIC_INIT(1),
-		.skip_csum = (inode->flags & BTRFS_INODE_NODATASUM),
 	};
 	unsigned long i = 0;
 	u64 cur = 0;
-- 
2.39.0

