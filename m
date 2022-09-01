Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D42395A90CE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Sep 2022 09:44:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234016AbiIAHnM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Sep 2022 03:43:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234039AbiIAHmz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Sep 2022 03:42:55 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82B9B11E821;
        Thu,  1 Sep 2022 00:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=n33iwIKld7aEIuI5+A0J12bO2Y5oj8H2AV3grZDE9Po=; b=tNtruTtNwaODP5yLbgU7AgK7UP
        zjHy7T1JFIfCRUSjK153xaVpBrt++1TJGOeD9nW/2Teahoi7i7TTqjrc/xP72lHq6t6RwzWDYkkSp
        /ornB7EKbbnqEGjhQFtLrWnEteD0Uoyh8XY0psK26rcaPFVjzIW53bnjp9iJPqO+zinBBpABLkthn
        YvvcwiIGEJUR7jOSVwA2+7hz5doPfatmA9vgLhapaF6TDeaOC83FnlbtrUs/jB9pipeFAZa4/FLHX
        GyZ+IZVciGAybVTV4k4UtRS1Vsx4KPjWlTbdLEAfVzHdj7vvlOD8ApW0hRCzS86ahatJITf8Jo4ox
        v3d602AA==;
Received: from 213-225-1-14.nat.highway.a1.net ([213.225.1.14] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oTeqb-00ANcF-KW; Thu, 01 Sep 2022 07:42:46 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>, Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 06/17] btrfs: handle recording of zoned writes in the storage layer
Date:   Thu,  1 Sep 2022 10:42:05 +0300
Message-Id: <20220901074216.1849941-7-hch@lst.de>
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

Move the code that splits the ordered extents and records the physical
location for them to the storage layer so that the higher level consumers
don't have to care about physical block numbers at all.  This will also
allow to eventually remove accounting for the zone append write sizes in
the upper layer with a little bit more block layer work.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/compression.c  |  1 -
 fs/btrfs/extent_io.c    |  6 ------
 fs/btrfs/inode.c        | 40 ++++++++--------------------------------
 fs/btrfs/ordered-data.h |  1 +
 fs/btrfs/volumes.c      |  8 ++++++++
 fs/btrfs/zoned.c        | 13 +++++--------
 fs/btrfs/zoned.h        |  6 ++----
 7 files changed, 24 insertions(+), 51 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 53f9e123712b0..1f10f86e70557 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -270,7 +270,6 @@ static void end_compressed_bio_write(struct btrfs_bio *bbio)
 	if (refcount_dec_and_test(&cb->pending_ios)) {
 		struct btrfs_fs_info *fs_info = btrfs_sb(cb->inode->i_sb);
 
-		btrfs_record_physical_zoned(cb->inode, cb->start, &bbio->bio);
 		queue_work(fs_info->compressed_write_workers, &cb->write_end_work);
 	}
 	bio_put(&bbio->bio);
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index d8c43e2111a99..4c00bdefe5b45 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2285,7 +2285,6 @@ static void end_bio_extent_writepage(struct btrfs_bio *bbio)
 	u64 start;
 	u64 end;
 	struct bvec_iter_all iter_all;
-	bool first_bvec = true;
 
 	ASSERT(!bio_flagged(bio, BIO_CLONED));
 	bio_for_each_segment_all(bvec, bio, iter_all) {
@@ -2307,11 +2306,6 @@ static void end_bio_extent_writepage(struct btrfs_bio *bbio)
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
index 88dd99997631a..03953c1f176dd 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2615,21 +2615,21 @@ static int split_zoned_em(struct btrfs_inode *inode, u64 start, u64 len,
 	return ret;
 }
 
-static blk_status_t extract_ordered_extent(struct btrfs_inode *inode,
-					   struct bio *bio, loff_t file_offset)
+int btrfs_extract_ordered_extent(struct btrfs_bio *bbio)
 {
+	u64 start = (u64)bbio->bio.bi_iter.bi_sector << SECTOR_SHIFT;
+	u64 len = bbio->bio.bi_iter.bi_size;
+	struct btrfs_inode *bi = BTRFS_I(bbio->inode);
 	struct btrfs_ordered_extent *ordered;
-	u64 start = (u64)bio->bi_iter.bi_sector << SECTOR_SHIFT;
 	u64 file_len;
-	u64 len = bio->bi_iter.bi_size;
 	u64 end = start + len;
 	u64 ordered_end;
 	u64 pre, post;
 	int ret = 0;
 
-	ordered = btrfs_lookup_ordered_extent(inode, file_offset);
+	ordered = btrfs_lookup_ordered_extent(bi, bbio->file_offset);
 	if (WARN_ON_ONCE(!ordered))
-		return BLK_STS_IOERR;
+		return -EIO;
 
 	/* No need to split */
 	if (ordered->disk_num_bytes == len)
@@ -2667,28 +2667,16 @@ static blk_status_t extract_ordered_extent(struct btrfs_inode *inode,
 	ret = btrfs_split_ordered_extent(ordered, pre, post);
 	if (ret)
 		goto out;
-	ret = split_zoned_em(inode, file_offset, file_len, pre, post);
+	ret = split_zoned_em(bi, bbio->file_offset, file_len, pre, post);
 
 out:
 	btrfs_put_ordered_extent(ordered);
-
-	return errno_to_blk_status(ret);
+	return ret;
 }
 
 void btrfs_submit_data_write_bio(struct inode *inode, struct bio *bio, int mirror_num)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
-	struct btrfs_inode *bi = BTRFS_I(inode);
-	blk_status_t ret;
-
-	if (bio_op(bio) == REQ_OP_ZONE_APPEND) {
-		ret = extract_ordered_extent(bi, bio,
-				page_offset(bio_first_bvec_all(bio)->bv_page));
-		if (ret) {
-			btrfs_bio_end_io(btrfs_bio(bio), ret);
-			return;
-		}
-	}
 
 	btrfs_submit_bio(fs_info, bio, mirror_num);
 }
@@ -7864,8 +7852,6 @@ static void btrfs_end_dio_bio(struct btrfs_bio *bbio)
 		dip->bio.bi_status = err;
 	}
 
-	btrfs_record_physical_zoned(dip->inode, bbio->file_offset, bio);
-
 	bio_put(bio);
 	btrfs_dio_private_put(dip);
 }
@@ -7923,15 +7909,6 @@ static void btrfs_submit_direct(const struct iomap_iter *iter,
 					      inode, btrfs_end_dio_bio, dip);
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
 
@@ -7960,7 +7937,6 @@ static void btrfs_submit_direct(const struct iomap_iter *iter,
 
 out_err_em:
 	free_extent_map(em);
-out_err:
 	dio_bio->bi_status = status;
 	btrfs_dio_private_put(dip);
 }
diff --git a/fs/btrfs/ordered-data.h b/fs/btrfs/ordered-data.h
index 87792f85e2c4a..0cef17f4b752f 100644
--- a/fs/btrfs/ordered-data.h
+++ b/fs/btrfs/ordered-data.h
@@ -220,6 +220,7 @@ void btrfs_lock_and_flush_ordered_range(struct btrfs_inode *inode, u64 start,
 					struct extent_state **cached_state);
 int btrfs_split_ordered_extent(struct btrfs_ordered_extent *ordered, u64 pre,
 			       u64 post);
+int btrfs_extract_ordered_extent(struct btrfs_bio *bbio);
 int __init ordered_data_init(void);
 void __cold ordered_data_exit(void);
 
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 2d13e8b52c94f..5c6535e10085d 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6906,6 +6906,8 @@ static void btrfs_simple_end_io(struct bio *bio)
 		INIT_WORK(&bbio->end_io_work, btrfs_end_bio_work);
 		queue_work(btrfs_end_io_wq(fs_info, bio), &bbio->end_io_work);
 	} else {
+		if (bio_op(bio) == REQ_OP_ZONE_APPEND)
+			btrfs_record_physical_zoned(bbio);
 		bbio->end_io(bbio);
 	}
 }
@@ -7226,6 +7228,12 @@ void btrfs_submit_bio(struct btrfs_fs_info *fs_info, struct bio *bio,
 	if (btrfs_op(bio) == BTRFS_MAP_WRITE) {
 		struct btrfs_inode *bi = BTRFS_I(bbio->inode);
 
+		if (bio_op(bio) == REQ_OP_ZONE_APPEND) {
+			ret = btrfs_extract_ordered_extent(btrfs_bio(bio));
+			if (ret)
+				goto fail;
+		}
+
 		/*
 		 * Csum items for reloc roots have already been cloned at this
 		 * point, so they are handled as part of the no-checksum case.
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index dc96b3331bfb7..2638f71eec4b6 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1633,21 +1633,18 @@ bool btrfs_use_zone_append(struct btrfs_inode *inode, u64 start)
 	return ret;
 }
 
-void btrfs_record_physical_zoned(struct inode *inode, u64 file_offset,
-				 struct bio *bio)
+void btrfs_record_physical_zoned(struct btrfs_bio *bbio)
 {
+	const u64 physical = bbio->bio.bi_iter.bi_sector << SECTOR_SHIFT;
+	struct btrfs_inode *bi = BTRFS_I(bbio->inode);
 	struct btrfs_ordered_extent *ordered;
-	const u64 physical = bio->bi_iter.bi_sector << SECTOR_SHIFT;
 
-	if (bio_op(bio) != REQ_OP_ZONE_APPEND)
-		return;
-
-	ordered = btrfs_lookup_ordered_extent(BTRFS_I(inode), file_offset);
+	ordered = btrfs_lookup_ordered_extent(bi, bbio->file_offset);
 	if (WARN_ON(!ordered))
 		return;
 
 	ordered->physical = physical;
-	ordered->bdev = bio->bi_bdev;
+	ordered->bdev = bbio->bio.bi_bdev;
 
 	btrfs_put_ordered_extent(ordered);
 }
diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
index e17462db3a842..cafa639927050 100644
--- a/fs/btrfs/zoned.h
+++ b/fs/btrfs/zoned.h
@@ -55,8 +55,7 @@ void btrfs_redirty_list_add(struct btrfs_transaction *trans,
 			    struct extent_buffer *eb);
 void btrfs_free_redirty_list(struct btrfs_transaction *trans);
 bool btrfs_use_zone_append(struct btrfs_inode *inode, u64 start);
-void btrfs_record_physical_zoned(struct inode *inode, u64 file_offset,
-				 struct bio *bio);
+void btrfs_record_physical_zoned(struct btrfs_bio *bbio);
 void btrfs_rewrite_logical_zoned(struct btrfs_ordered_extent *ordered);
 bool btrfs_check_meta_write_pointer(struct btrfs_fs_info *fs_info,
 				    struct extent_buffer *eb,
@@ -178,8 +177,7 @@ static inline bool btrfs_use_zone_append(struct btrfs_inode *inode, u64 start)
 	return false;
 }
 
-static inline void btrfs_record_physical_zoned(struct inode *inode,
-					       u64 file_offset, struct bio *bio)
+static inline void btrfs_record_physical_zoned(struct btrfs_bio *bbio)
 {
 }
 
-- 
2.30.2

