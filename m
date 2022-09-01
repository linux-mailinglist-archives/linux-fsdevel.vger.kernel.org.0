Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2790E5A90C4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Sep 2022 09:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233828AbiIAHng (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Sep 2022 03:43:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234015AbiIAHm4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Sep 2022 03:42:56 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21ABC11EB44;
        Thu,  1 Sep 2022 00:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=JYdpoe6k7CY+uRGDzKFOf7z0fsAL04X/cS+MN4M+zIg=; b=LTZy62o35zMsEaIUWz6yHjx0aL
        1pCR46hziQMA5hNBK05rGagU5JlDcJ/vZyWF0LV+7iceXt5aNg/3efxngoItoL4JotV1BQ80vKA5w
        MQlJXcJCO5q3Ga3P8p9WS8NDFVi44269xJaMUmHKuwcg00KaB5mteHEdFR2JbEbolheRKhWxTt/KU
        EHOupbERKoFN3e8AnQ49tnmDi4J+BIodRlTZ6yTzXm+yk5S2wFk5rIGRrMHodFjcl3WjPcxVIrlgO
        fahJ9YWO+u1iqLnKAQm9JZ8ThtfVxPsePcrNVh68t9cyoAcS5j9PLXhvUoMnR58WZWNmM/BTRI1Vz
        MMA54RlA==;
Received: from 213-225-1-14.nat.highway.a1.net ([213.225.1.14] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oTeqe-00ANco-VJ; Thu, 01 Sep 2022 07:42:49 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>, Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 07/17] btrfs: allow btrfs_submit_bio to split bios
Date:   Thu,  1 Sep 2022 10:42:06 +0300
Message-Id: <20220901074216.1849941-8-hch@lst.de>
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

Currently the I/O submitters have to split bios according to the
chunk stripe boundaries.  This leads to extra lookups in the extent
trees and a lot of boilerplate code.

To drop this requirement, split the bio when __btrfs_map_block
returns a mapping that is smaller than the requested size and
keep a count of pending bios in the original btrfs_bio so that
the upper level completion is only invoked when all clones have
completed.

Based on a patch from Qu Wenruo.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/volumes.c | 106 +++++++++++++++++++++++++++++++++++++--------
 fs/btrfs/volumes.h |   1 +
 2 files changed, 90 insertions(+), 17 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 5c6535e10085d..0a2d144c20604 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -35,6 +35,7 @@
 #include "zoned.h"
 
 static struct bio_set btrfs_bioset;
+static struct bio_set btrfs_clone_bioset;
 static struct bio_set btrfs_repair_bioset;
 static mempool_t btrfs_failed_bio_pool;
 
@@ -6661,6 +6662,7 @@ static void btrfs_bio_init(struct btrfs_bio *bbio, struct inode *inode,
 	bbio->inode = inode;
 	bbio->end_io = end_io;
 	bbio->private = private;
+	atomic_set(&bbio->pending_ios, 1);
 }
 
 /*
@@ -6698,6 +6700,57 @@ struct bio *btrfs_bio_clone_partial(struct bio *orig, u64 offset, u64 size,
 	return bio;
 }
 
+static struct bio *btrfs_split_bio(struct bio *orig, u64 map_length)
+{
+	struct btrfs_bio *orig_bbio = btrfs_bio(orig);
+	struct bio *bio;
+
+	bio = bio_split(orig, map_length >> SECTOR_SHIFT, GFP_NOFS,
+			&btrfs_clone_bioset);
+	btrfs_bio_init(btrfs_bio(bio), orig_bbio->inode, NULL, orig_bbio);
+
+	btrfs_bio(bio)->file_offset = orig_bbio->file_offset;
+	orig_bbio->file_offset += map_length;
+
+	atomic_inc(&orig_bbio->pending_ios);
+	return bio;
+}
+
+static void btrfs_orig_write_end_io(struct bio *bio);
+static void btrfs_bbio_propagate_error(struct btrfs_bio *bbio,
+				       struct btrfs_bio *orig_bbio)
+{
+	/*
+	 * For writes btrfs tolerates nr_mirrors - 1 write failures, so we
+	 * can't just blindly propagate a write failure here.
+	 * Instead increment the error count in the original I/O context so
+	 * that it is guaranteed to be larger than the error tolerance.
+	 */
+	if (bbio->bio.bi_end_io == &btrfs_orig_write_end_io) {
+		struct btrfs_io_stripe *orig_stripe = orig_bbio->bio.bi_private;
+		struct btrfs_io_context *orig_bioc = orig_stripe->bioc;
+		
+		atomic_add(orig_bioc->max_errors, &orig_bioc->error);
+	} else {
+		orig_bbio->bio.bi_status = bbio->bio.bi_status;
+	}
+}
+
+static void btrfs_orig_bbio_end_io(struct btrfs_bio *bbio)
+{
+	if (bbio->bio.bi_pool == &btrfs_clone_bioset) {
+		struct btrfs_bio *orig_bbio = bbio->private;
+
+		if (bbio->bio.bi_status)
+			btrfs_bbio_propagate_error(bbio, orig_bbio);
+		bio_put(&bbio->bio);
+		bbio = orig_bbio;
+	}
+
+	if (atomic_dec_and_test(&bbio->pending_ios))
+		bbio->end_io(bbio);
+}
+
 static int next_repair_mirror(struct btrfs_failed_bio *fbio, int cur_mirror)
 {
 	if (cur_mirror == fbio->num_copies)
@@ -6715,7 +6768,7 @@ static int prev_repair_mirror(struct btrfs_failed_bio *fbio, int cur_mirror)
 static void btrfs_repair_done(struct btrfs_failed_bio *fbio)
 {
 	if (atomic_dec_and_test(&fbio->repair_count)) {
-		fbio->bbio->end_io(fbio->bbio);
+		btrfs_orig_bbio_end_io(fbio->bbio);
 		mempool_free(fbio, &btrfs_failed_bio_pool);
 	}
 }
@@ -6857,7 +6910,7 @@ static void btrfs_check_read_bio(struct btrfs_bio *bbio,
 	if (unlikely(fbio))
 		btrfs_repair_done(fbio);
 	else
-		bbio->end_io(bbio);
+		btrfs_orig_bbio_end_io(bbio);
 }
 
 static void btrfs_log_dev_io_error(struct bio *bio, struct btrfs_device *dev)
@@ -6908,7 +6961,7 @@ static void btrfs_simple_end_io(struct bio *bio)
 	} else {
 		if (bio_op(bio) == REQ_OP_ZONE_APPEND)
 			btrfs_record_physical_zoned(bbio);
-		bbio->end_io(bbio);
+		btrfs_orig_bbio_end_io(bbio);
 	}
 }
 
@@ -6922,7 +6975,7 @@ static void btrfs_raid56_end_io(struct bio *bio)
 	if (bio_op(bio) == REQ_OP_READ)
 		btrfs_check_read_bio(bbio, NULL);
 	else
-		bbio->end_io(bbio);
+		btrfs_orig_bbio_end_io(bbio);
 
 	btrfs_put_bioc(bioc);
 }
@@ -6949,7 +7002,7 @@ static void btrfs_orig_write_end_io(struct bio *bio)
 	else
 		bio->bi_status = BLK_STS_OK;
 
-	bbio->end_io(bbio);
+	btrfs_orig_bbio_end_io(bbio);
 	btrfs_put_bioc(bioc);
 }
 
@@ -7190,8 +7243,8 @@ static bool btrfs_wq_submit_bio(struct btrfs_bio *bbio,
 	return true;
 }
 
-void btrfs_submit_bio(struct btrfs_fs_info *fs_info, struct bio *bio,
-		      int mirror_num)
+static bool btrfs_submit_chunk(struct btrfs_fs_info *fs_info, struct bio *bio,
+			       int mirror_num)
 {
 	struct btrfs_bio *bbio = btrfs_bio(bio);
 	u64 logical = bio->bi_iter.bi_sector << 9;
@@ -7207,11 +7260,10 @@ void btrfs_submit_bio(struct btrfs_fs_info *fs_info, struct bio *bio,
 	if (ret)
 		goto fail;
 
+	map_length = min(map_length, length);
 	if (map_length < length) {
-		btrfs_crit(fs_info,
-			   "mapping failed logical %llu bio len %llu len %llu",
-			   logical, length, map_length);
-		BUG();
+		bio = btrfs_split_bio(bio, map_length);
+		bbio = btrfs_bio(bio);
 	}
 
 	/*
@@ -7222,7 +7274,7 @@ void btrfs_submit_bio(struct btrfs_fs_info *fs_info, struct bio *bio,
 		bbio->saved_iter = bio->bi_iter;
 		ret = btrfs_lookup_bio_sums(bbio);
 		if (ret)
-			goto fail;
+			goto fail_put_bio;
 	}
 
 	if (btrfs_op(bio) == BTRFS_MAP_WRITE) {
@@ -7231,7 +7283,7 @@ void btrfs_submit_bio(struct btrfs_fs_info *fs_info, struct bio *bio,
 		if (bio_op(bio) == REQ_OP_ZONE_APPEND) {
 			ret = btrfs_extract_ordered_extent(btrfs_bio(bio));
 			if (ret)
-				goto fail;
+				goto fail_put_bio;
 		}
 
 		/*
@@ -7243,22 +7295,36 @@ void btrfs_submit_bio(struct btrfs_fs_info *fs_info, struct bio *bio,
 		    !btrfs_is_data_reloc_root(bi->root)) {
 			if (should_async_write(bbio) &&
 			    btrfs_wq_submit_bio(bbio, bioc, &smap, mirror_num))
-				return;
+				goto done;
 
 			if (bio->bi_opf & REQ_META)
 				ret = btree_csum_one_bio(bbio);
 			else
 				ret = btrfs_csum_one_bio(bbio);
 			if (ret)
-				goto fail;
+				goto fail_put_bio;
 		}
 	}
 
 	__btrfs_submit_bio(bio, bioc, &smap, mirror_num);
-	return;
+done:
+	return map_length == length;
+
+fail_put_bio:
+	if (map_length < length)
+		bio_put(bio);
 fail:
 	btrfs_bio_counter_dec(fs_info);
 	btrfs_bio_end_io(bbio, errno_to_blk_status(ret));
+	/* Do not submit another chunk */
+	return true;
+}
+
+void btrfs_submit_bio(struct btrfs_fs_info *fs_info, struct bio *bio,
+		      int mirror_num)
+{
+	while (!btrfs_submit_chunk(fs_info, bio, mirror_num))
+		;
 }
 
 /*
@@ -8858,10 +8924,13 @@ int __init btrfs_bioset_init(void)
 			offsetof(struct btrfs_bio, bio),
 			BIOSET_NEED_BVECS))
 		return -ENOMEM;
+	if (bioset_init(&btrfs_clone_bioset, BIO_POOL_SIZE,
+			offsetof(struct btrfs_bio, bio), 0))
+		goto out_free_bioset;
 	if (bioset_init(&btrfs_repair_bioset, BIO_POOL_SIZE,
 			offsetof(struct btrfs_bio, bio),
 			BIOSET_NEED_BVECS))
-		goto out_free_bioset;
+		goto out_free_clone_bioset;
 	if (mempool_init_kmalloc_pool(&btrfs_failed_bio_pool, BIO_POOL_SIZE,
 				      sizeof(struct btrfs_failed_bio)))
 		goto out_free_repair_bioset;
@@ -8869,6 +8938,8 @@ int __init btrfs_bioset_init(void)
 
 out_free_repair_bioset:
 	bioset_exit(&btrfs_repair_bioset);
+out_free_clone_bioset:
+	bioset_exit(&btrfs_clone_bioset);
 out_free_bioset:
 	bioset_exit(&btrfs_bioset);
 	return -ENOMEM;
@@ -8878,5 +8949,6 @@ void __cold btrfs_bioset_exit(void)
 {
 	mempool_exit(&btrfs_failed_bio_pool);
 	bioset_exit(&btrfs_repair_bioset);
+	bioset_exit(&btrfs_clone_bioset);
 	bioset_exit(&btrfs_bioset);
 }
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 8b248c9bd602b..97877184d0db1 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -386,6 +386,7 @@ struct btrfs_bio {
 
 	/* For internal use in read end I/O handling */
 	unsigned int mirror_num;
+	atomic_t pending_ios;
 	struct work_struct end_io_work;
 
 	/*
-- 
2.30.2

