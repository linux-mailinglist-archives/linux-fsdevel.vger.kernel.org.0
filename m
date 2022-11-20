Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 616AE631406
	for <lists+linux-fsdevel@lfdr.de>; Sun, 20 Nov 2022 13:48:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbiKTMsI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 20 Nov 2022 07:48:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiKTMsA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 20 Nov 2022 07:48:00 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0786960E0;
        Sun, 20 Nov 2022 04:48:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=4xiwJtiyL6vfnbf/HsZxUAORK3ERVB/x7XJfO8fZSaM=; b=DhnvjruM0xq3iAy1SmuoOx6SQ9
        1CReJAoqzFNzAKw5Tm1tnU5tHmrWryO+36mtYk6v9x6pIy9BTnlum3YvMWgVtYyP5ORBIHNzMFtvi
        VzNgSneqmz0UBDoXSzwIm7z7yXo+R/O/mdwysBzstub2tEq0R8oCZD2TqQO6tubm570KUPo0HdFnj
        m6pCd+G6/O1xsKlfVOhQhneolNrPkxyzQe17rLxCuIPAaSjhwECFZIttpp9eXGv1iz4eX4ClXxCiC
        7awE8NbNDOi8pUsNGvoj0Nwt1oGiE+vtqWlp9rdsdffzI35gw5Mqva1YAR83Xgkh0oRzuBB1dGKUr
        ZYHxcDcQ==;
Received: from [2001:4bb8:181:6f70:ae5d:6675:76b9:6fc3] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1owjjm-004I7Q-Kb; Sun, 20 Nov 2022 12:47:55 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>, Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 06/19] btrfs: handle recording of zoned writes in the storage layer
Date:   Sun, 20 Nov 2022 13:47:21 +0100
Message-Id: <20221120124734.18634-7-hch@lst.de>
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

Move the code that splits the ordered extents and records the physical
location for them to the storage layer so that the higher level consumers
don't have to care about physical block numbers at all.  This will also
allow to eventually remove accounting for the zone append write sizes in
the upper layer with a little bit more block layer work.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Naohiro Aota <naohiro.aota@wdc.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/bio.c         |  8 ++++++++
 fs/btrfs/btrfs_inode.h |  1 +
 fs/btrfs/compression.c |  1 -
 fs/btrfs/extent_io.c   |  6 ------
 fs/btrfs/inode.c       | 38 +++++++-------------------------------
 fs/btrfs/zoned.c       | 13 +++++--------
 fs/btrfs/zoned.h       |  6 ++----
 7 files changed, 23 insertions(+), 50 deletions(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index 67ee94fb92523..5978b795bf710 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -283,6 +283,8 @@ static void btrfs_simple_end_io(struct bio *bio)
 		INIT_WORK(&bbio->end_io_work, btrfs_end_bio_work);
 		queue_work(btrfs_end_io_wq(fs_info, bio), &bbio->end_io_work);
 	} else {
+		if (bio_op(bio) == REQ_OP_ZONE_APPEND)
+			btrfs_record_physical_zoned(bbio);
 		bbio->end_io(bbio);
 	}
 }
@@ -603,6 +605,12 @@ void btrfs_submit_bio(struct btrfs_fs_info *fs_info, struct bio *bio,
 	}
 
 	if (btrfs_op(bio) == BTRFS_MAP_WRITE) {
+		if (bio_op(bio) == REQ_OP_ZONE_APPEND) {
+			ret = btrfs_extract_ordered_extent(btrfs_bio(bio));
+			if (ret)
+				goto fail;
+		}
+
 		/*
 		 * Csum items for reloc roots have already been cloned at this
 		 * point, so they are handled as part of the no-checksum case.
diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index ba5f023aaf557..b83b731c63e13 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -410,6 +410,7 @@ void btrfs_submit_data_read_bio(struct btrfs_inode *inode, struct bio *bio,
 			int mirror_num, enum btrfs_compression_type compress_type);
 int btrfs_check_sector_csum(struct btrfs_fs_info *fs_info, struct page *page,
 			    u32 pgoff, u8 *csum, const u8 * const csum_expected);
+blk_status_t btrfs_extract_ordered_extent(struct btrfs_bio *bbio);
 bool btrfs_data_csum_ok(struct btrfs_bio *bbio, struct btrfs_device *dev,
 			u32 bio_offset, struct bio_vec *bv);
 noinline int can_nocow_extent(struct inode *inode, u64 offset, u64 *len,
diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 7ca4f97f5ec92..b632c95e70e76 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -273,7 +273,6 @@ static void end_compressed_bio_write(struct btrfs_bio *bbio)
 	if (refcount_dec_and_test(&cb->pending_ios)) {
 		struct btrfs_fs_info *fs_info = btrfs_sb(cb->inode->i_sb);
 
-		btrfs_record_physical_zoned(cb->inode, cb->start, &bbio->bio);
 		queue_work(fs_info->compressed_write_workers, &cb->write_end_work);
 	}
 	bio_put(&bbio->bio);
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index d31409b6d5a70..4672a954f9fd2 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -566,7 +566,6 @@ static void end_bio_extent_writepage(struct btrfs_bio *bbio)
 	u64 start;
 	u64 end;
 	struct bvec_iter_all iter_all;
-	bool first_bvec = true;
 
 	ASSERT(!bio_flagged(bio, BIO_CLONED));
 	bio_for_each_segment_all(bvec, bio, iter_all) {
@@ -588,11 +587,6 @@ static void end_bio_extent_writepage(struct btrfs_bio *bbio)
 		start = page_offset(page) + bvec->bv_offset;
 		end = start + bvec->bv_len - 1;
 
-		if (first_bvec) {
-			btrfs_record_physical_zoned(inode, start, bio);
-			first_bvec = false;
-		}
-
 		end_extent_writepage(page, error, start, end);
 
 		btrfs_page_clear_writeback(fs_info, page, start, bvec->bv_len);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index d569d9a2d0c5b..79286384ca156 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2647,19 +2647,19 @@ static int split_zoned_em(struct btrfs_inode *inode, u64 start, u64 len,
 	return ret;
 }
 
-static blk_status_t extract_ordered_extent(struct btrfs_inode *inode,
-					   struct bio *bio, loff_t file_offset)
+blk_status_t btrfs_extract_ordered_extent(struct btrfs_bio *bbio)
 {
+	u64 start = (u64)bbio->bio.bi_iter.bi_sector << SECTOR_SHIFT;
+	u64 len = bbio->bio.bi_iter.bi_size;
+	struct btrfs_inode *inode = bbio->inode;
 	struct btrfs_ordered_extent *ordered;
-	u64 start = (u64)bio->bi_iter.bi_sector << SECTOR_SHIFT;
 	u64 file_len;
-	u64 len = bio->bi_iter.bi_size;
 	u64 end = start + len;
 	u64 ordered_end;
 	u64 pre, post;
 	int ret = 0;
 
-	ordered = btrfs_lookup_ordered_extent(inode, file_offset);
+	ordered = btrfs_lookup_ordered_extent(inode, bbio->file_offset);
 	if (WARN_ON_ONCE(!ordered))
 		return BLK_STS_IOERR;
 
@@ -2699,7 +2699,7 @@ static blk_status_t extract_ordered_extent(struct btrfs_inode *inode,
 	ret = btrfs_split_ordered_extent(ordered, pre, post);
 	if (ret)
 		goto out;
-	ret = split_zoned_em(inode, file_offset, file_len, pre, post);
+	ret = split_zoned_em(inode, bbio->file_offset, file_len, pre, post);
 
 out:
 	btrfs_put_ordered_extent(ordered);
@@ -2709,19 +2709,7 @@ static blk_status_t extract_ordered_extent(struct btrfs_inode *inode,
 
 void btrfs_submit_data_write_bio(struct btrfs_inode *inode, struct bio *bio, int mirror_num)
 {
-	struct btrfs_fs_info *fs_info = inode->root->fs_info;
-	blk_status_t ret;
-
-	if (bio_op(bio) == REQ_OP_ZONE_APPEND) {
-		ret = extract_ordered_extent(inode, bio,
-				page_offset(bio_first_bvec_all(bio)->bv_page));
-		if (ret) {
-			btrfs_bio_end_io(btrfs_bio(bio), ret);
-			return;
-		}
-	}
-
-	btrfs_submit_bio(fs_info, bio, mirror_num);
+	btrfs_submit_bio(inode->root->fs_info, bio, mirror_num);
 }
 
 void btrfs_submit_data_read_bio(struct btrfs_inode *inode, struct bio *bio,
@@ -7814,8 +7802,6 @@ static void btrfs_end_dio_bio(struct btrfs_bio *bbio)
 		dip->bio.bi_status = err;
 	}
 
-	btrfs_record_physical_zoned(&dip->inode->vfs_inode, bbio->file_offset, bio);
-
 	bio_put(bio);
 	btrfs_dio_private_put(dip);
 }
@@ -7874,15 +7860,6 @@ static void btrfs_submit_direct(const struct iomap_iter *iter,
 					      dip);
 		btrfs_bio(bio)->file_offset = file_offset;
 
-		if (bio_op(bio) == REQ_OP_ZONE_APPEND) {
-			status = extract_ordered_extent(BTRFS_I(inode), bio,
-							file_offset);
-			if (status) {
-				bio_put(bio);
-				goto out_err;
-			}
-		}
-
 		ASSERT(submit_len >= clone_len);
 		submit_len -= clone_len;
 
@@ -7911,7 +7888,6 @@ static void btrfs_submit_direct(const struct iomap_iter *iter,
 
 out_err_em:
 	free_extent_map(em);
-out_err:
 	dio_bio->bi_status = status;
 	btrfs_dio_private_put(dip);
 }
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 2218b33dac568..04a16d70ed7a5 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -17,6 +17,7 @@
 #include "space-info.h"
 #include "fs.h"
 #include "accessors.h"
+#include "bio.h"
 
 /* Maximum number of zones to report per blkdev_report_zones() call */
 #define BTRFS_REPORT_NR_ZONES   4096
@@ -1655,21 +1656,17 @@ bool btrfs_use_zone_append(struct btrfs_inode *inode, u64 start)
 	return ret;
 }
 
-void btrfs_record_physical_zoned(struct inode *inode, u64 file_offset,
-				 struct bio *bio)
+void btrfs_record_physical_zoned(struct btrfs_bio *bbio)
 {
+	const u64 physical = bbio->bio.bi_iter.bi_sector << SECTOR_SHIFT;
 	struct btrfs_ordered_extent *ordered;
-	const u64 physical = bio->bi_iter.bi_sector << SECTOR_SHIFT;
 
-	if (bio_op(bio) != REQ_OP_ZONE_APPEND)
-		return;
-
-	ordered = btrfs_lookup_ordered_extent(BTRFS_I(inode), file_offset);
+	ordered = btrfs_lookup_ordered_extent(bbio->inode, bbio->file_offset);
 	if (WARN_ON(!ordered))
 		return;
 
 	ordered->physical = physical;
-	ordered->bdev = bio->bi_bdev;
+	ordered->bdev = bbio->bio.bi_bdev;
 
 	btrfs_put_ordered_extent(ordered);
 }
diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
index f43990985d802..bc93a740e7cf3 100644
--- a/fs/btrfs/zoned.h
+++ b/fs/btrfs/zoned.h
@@ -57,8 +57,7 @@ void btrfs_redirty_list_add(struct btrfs_transaction *trans,
 			    struct extent_buffer *eb);
 void btrfs_free_redirty_list(struct btrfs_transaction *trans);
 bool btrfs_use_zone_append(struct btrfs_inode *inode, u64 start);
-void btrfs_record_physical_zoned(struct inode *inode, u64 file_offset,
-				 struct bio *bio);
+void btrfs_record_physical_zoned(struct btrfs_bio *bbio);
 void btrfs_rewrite_logical_zoned(struct btrfs_ordered_extent *ordered);
 bool btrfs_check_meta_write_pointer(struct btrfs_fs_info *fs_info,
 				    struct extent_buffer *eb,
@@ -190,8 +189,7 @@ static inline bool btrfs_use_zone_append(struct btrfs_inode *inode, u64 start)
 	return false;
 }
 
-static inline void btrfs_record_physical_zoned(struct inode *inode,
-					       u64 file_offset, struct bio *bio)
+static inline void btrfs_record_physical_zoned(struct btrfs_bio *bbio)
 {
 }
 
-- 
2.30.2

