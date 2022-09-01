Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 441335A90BB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Sep 2022 09:43:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233080AbiIAHmz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Sep 2022 03:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233178AbiIAHmr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Sep 2022 03:42:47 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4649108538;
        Thu,  1 Sep 2022 00:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
        To:From:Sender:Reply-To:Content-ID:Content-Description;
        bh=4szSUaj6PvlcAFJXbFSRnUoLl0jMetbt1iNRmxD8bEM=; b=Kg5emx10/xoOfbqvWCFsIE5bOr
        mmvTicMKENHTMTyy+5WAvLuM9mxyf6dH1xjuDZ0LqQMSSvtjTzRnEXkzlmH6D9tl+BrTD3nLvhYDP
        kRqTfrtlfDr6kzfCQViDpbcyo2m8IBI0fKTRdGAvJp99buIg6HE3p0K3xieL0CoZl0/OZTA1CPAHw
        hYcwIj38lie/D0Nzwt4bSGjn7uEojyZnzMJkiQ3/jB8VC9N+Ff1dfKSX3QjyNbaKWPtqE7d57D64o
        L7HdUhTY6yiKIreHC+O2HfPx6gcuh0NWUiZIdMgoyU4IUPxMmgDr8X6BgB1sCkqQomMocMv9fmuo/
        BlWdALog==;
Received: from 213-225-1-14.nat.highway.a1.net ([213.225.1.14] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oTeqO-00ANXk-K6; Thu, 01 Sep 2022 07:42:33 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>, Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 03/17] btrfs: move repair_io_failure to volumes.c
Date:   Thu,  1 Sep 2022 10:42:02 +0300
Message-Id: <20220901074216.1849941-4-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220901074216.1849941-1-hch@lst.de>
References: <20220901074216.1849941-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

repair_io_failure ties directly into all the glory low-level details of
mapping a bio with a logic address to the actual physical location.
Move it right below btrfs_submit_bio to keep all the related logic
together.

Also move btrfs_repair_eb_io_failure to its caller in disk-io.c now that
repair_io_failure is available in a header.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/disk-io.c   |  24 +++++++++
 fs/btrfs/extent_io.c | 118 +------------------------------------------
 fs/btrfs/extent_io.h |   1 -
 fs/btrfs/volumes.c   |  91 +++++++++++++++++++++++++++++++++
 fs/btrfs/volumes.h   |   3 ++
 5 files changed, 120 insertions(+), 117 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 912e0b2bd0c5f..a88d6c3b59042 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -249,6 +249,30 @@ int btrfs_verify_level_key(struct extent_buffer *eb, int level,
 	return ret;
 }
 
+static int btrfs_repair_eb_io_failure(const struct extent_buffer *eb,
+				      int mirror_num)
+{
+	struct btrfs_fs_info *fs_info = eb->fs_info;
+	u64 start = eb->start;
+	int i, num_pages = num_extent_pages(eb);
+	int ret = 0;
+
+	if (sb_rdonly(fs_info->sb))
+		return -EROFS;
+
+	for (i = 0; i < num_pages; i++) {
+		struct page *p = eb->pages[i];
+
+		ret = btrfs_repair_io_failure(fs_info, 0, start, PAGE_SIZE,
+				start, p, start - page_offset(p), mirror_num);
+		if (ret)
+			break;
+		start += PAGE_SIZE;
+	}
+
+	return ret;
+}
+
 /*
  * helper to read a given tree block, doing retries as required when
  * the checksums don't match and we have alternate mirrors to try.
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 6ac76534d2c9e..c83cc5677a08a 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2289,120 +2289,6 @@ int free_io_failure(struct extent_io_tree *failure_tree,
 	return ret;
 }
 
-/*
- * this bypasses the standard btrfs submit functions deliberately, as
- * the standard behavior is to write all copies in a raid setup. here we only
- * want to write the one bad copy. so we do the mapping for ourselves and issue
- * submit_bio directly.
- * to avoid any synchronization issues, wait for the data after writing, which
- * actually prevents the read that triggered the error from finishing.
- * currently, there can be no more than two copies of every data bit. thus,
- * exactly one rewrite is required.
- */
-static int repair_io_failure(struct btrfs_fs_info *fs_info, u64 ino, u64 start,
-			     u64 length, u64 logical, struct page *page,
-			     unsigned int pg_offset, int mirror_num)
-{
-	struct btrfs_device *dev;
-	struct bio_vec bvec;
-	struct bio bio;
-	u64 map_length = 0;
-	u64 sector;
-	struct btrfs_io_context *bioc = NULL;
-	int ret = 0;
-
-	ASSERT(!(fs_info->sb->s_flags & SB_RDONLY));
-	BUG_ON(!mirror_num);
-
-	if (btrfs_repair_one_zone(fs_info, logical))
-		return 0;
-
-	map_length = length;
-
-	/*
-	 * Avoid races with device replace and make sure our bioc has devices
-	 * associated to its stripes that don't go away while we are doing the
-	 * read repair operation.
-	 */
-	btrfs_bio_counter_inc_blocked(fs_info);
-	if (btrfs_is_parity_mirror(fs_info, logical, length)) {
-		/*
-		 * Note that we don't use BTRFS_MAP_WRITE because it's supposed
-		 * to update all raid stripes, but here we just want to correct
-		 * bad stripe, thus BTRFS_MAP_READ is abused to only get the bad
-		 * stripe's dev and sector.
-		 */
-		ret = btrfs_map_block(fs_info, BTRFS_MAP_READ, logical,
-				      &map_length, &bioc, 0);
-		if (ret)
-			goto out_counter_dec;
-		ASSERT(bioc->mirror_num == 1);
-	} else {
-		ret = btrfs_map_block(fs_info, BTRFS_MAP_WRITE, logical,
-				      &map_length, &bioc, mirror_num);
-		if (ret)
-			goto out_counter_dec;
-		BUG_ON(mirror_num != bioc->mirror_num);
-	}
-
-	sector = bioc->stripes[bioc->mirror_num - 1].physical >> 9;
-	dev = bioc->stripes[bioc->mirror_num - 1].dev;
-	btrfs_put_bioc(bioc);
-
-	if (!dev || !dev->bdev ||
-	    !test_bit(BTRFS_DEV_STATE_WRITEABLE, &dev->dev_state)) {
-		ret = -EIO;
-		goto out_counter_dec;
-	}
-
-	bio_init(&bio, dev->bdev, &bvec, 1, REQ_OP_WRITE | REQ_SYNC);
-	bio.bi_iter.bi_sector = sector;
-	__bio_add_page(&bio, page, length, pg_offset);
-
-	btrfsic_check_bio(&bio);
-	ret = submit_bio_wait(&bio);
-	if (ret) {
-		/* try to remap that extent elsewhere? */
-		btrfs_dev_stat_inc_and_print(dev, BTRFS_DEV_STAT_WRITE_ERRS);
-		goto out_bio_uninit;
-	}
-
-	btrfs_info_rl_in_rcu(fs_info,
-		"read error corrected: ino %llu off %llu (dev %s sector %llu)",
-				  ino, start,
-				  rcu_str_deref(dev->name), sector);
-	ret = 0;
-
-out_bio_uninit:
-	bio_uninit(&bio);
-out_counter_dec:
-	btrfs_bio_counter_dec(fs_info);
-	return ret;
-}
-
-int btrfs_repair_eb_io_failure(const struct extent_buffer *eb, int mirror_num)
-{
-	struct btrfs_fs_info *fs_info = eb->fs_info;
-	u64 start = eb->start;
-	int i, num_pages = num_extent_pages(eb);
-	int ret = 0;
-
-	if (sb_rdonly(fs_info->sb))
-		return -EROFS;
-
-	for (i = 0; i < num_pages; i++) {
-		struct page *p = eb->pages[i];
-
-		ret = repair_io_failure(fs_info, 0, start, PAGE_SIZE, start, p,
-					start - page_offset(p), mirror_num);
-		if (ret)
-			break;
-		start += PAGE_SIZE;
-	}
-
-	return ret;
-}
-
 static int next_mirror(const struct io_failure_record *failrec, int cur_mirror)
 {
 	if (cur_mirror == failrec->num_copies)
@@ -2460,7 +2346,7 @@ int clean_io_failure(struct btrfs_fs_info *fs_info,
 	mirror = failrec->this_mirror;
 	do {
 		mirror = prev_mirror(failrec, mirror);
-		repair_io_failure(fs_info, ino, start, failrec->len,
+		btrfs_repair_io_failure(fs_info, ino, start, failrec->len,
 				  failrec->logical, page, pg_offset, mirror);
 	} while (mirror != failrec->failed_mirror);
 
@@ -2600,7 +2486,7 @@ int btrfs_repair_one_sector(struct inode *inode, struct btrfs_bio *failed_bbio,
 	 *
 	 * Since we're only doing repair for one sector, we only need to get
 	 * a good copy of the failed sector and if we succeed, we have setup
-	 * everything for repair_io_failure to do the rest for us.
+	 * everything for btrfs_repair_io_failure to do the rest for us.
 	 */
 	failrec->this_mirror = next_mirror(failrec, failrec->this_mirror);
 	if (failrec->this_mirror == failrec->failed_mirror) {
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 69a86ae6fd508..e653e64598bf7 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -243,7 +243,6 @@ void extent_clear_unlock_delalloc(struct btrfs_inode *inode, u64 start, u64 end,
 int btrfs_alloc_page_array(unsigned int nr_pages, struct page **page_array);
 
 void end_extent_writepage(struct page *page, int err, u64 start, u64 end);
-int btrfs_repair_eb_io_failure(const struct extent_buffer *eb, int mirror_num);
 
 /*
  * When IO fails, either with EIO or csum verification fails, we
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 19f7858aa2b91..dff735e36da96 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6902,6 +6902,97 @@ void btrfs_submit_bio(struct btrfs_fs_info *fs_info, struct bio *bio, int mirror
 	}
 }
 
+/*
+ * Submit a repair write.
+ *
+ * This bypasses btrfs_submit_bio deliberately, as that writes all copies in a
+ * RAID setup.  Here we only want to write the one bad copy, so we do the
+ * mapping ourselves and submit the bio directly.
+ *
+ * The I/O is іssued sychronously to block the repair read completion from
+ * freeing the bio.
+ */
+int btrfs_repair_io_failure(struct btrfs_fs_info *fs_info, u64 ino, u64 start,
+			    u64 length, u64 logical, struct page *page,
+			    unsigned int pg_offset, int mirror_num)
+{
+	struct btrfs_device *dev;
+	struct bio_vec bvec;
+	struct bio bio;
+	u64 map_length = 0;
+	u64 sector;
+	struct btrfs_io_context *bioc = NULL;
+	int ret = 0;
+
+	ASSERT(!(fs_info->sb->s_flags & SB_RDONLY));
+	BUG_ON(!mirror_num);
+
+	if (btrfs_repair_one_zone(fs_info, logical))
+		return 0;
+
+	map_length = length;
+
+	/*
+	 * Avoid races with device replace and make sure our bioc has devices
+	 * associated to its stripes that don't go away while we are doing the
+	 * read repair operation.
+	 */
+	btrfs_bio_counter_inc_blocked(fs_info);
+	if (btrfs_is_parity_mirror(fs_info, logical, length)) {
+		/*
+		 * Note that we don't use BTRFS_MAP_WRITE because it's supposed
+		 * to update all raid stripes, but here we just want to correct
+		 * bad stripe, thus BTRFS_MAP_READ is abused to only get the bad
+		 * stripe's dev and sector.
+		 */
+		ret = btrfs_map_block(fs_info, BTRFS_MAP_READ, logical,
+				      &map_length, &bioc, 0);
+		if (ret)
+			goto out_counter_dec;
+		ASSERT(bioc->mirror_num == 1);
+	} else {
+		ret = btrfs_map_block(fs_info, BTRFS_MAP_WRITE, logical,
+				      &map_length, &bioc, mirror_num);
+		if (ret)
+			goto out_counter_dec;
+		BUG_ON(mirror_num != bioc->mirror_num);
+	}
+
+	sector = bioc->stripes[bioc->mirror_num - 1].physical >> 9;
+	dev = bioc->stripes[bioc->mirror_num - 1].dev;
+	btrfs_put_bioc(bioc);
+
+	if (!dev || !dev->bdev ||
+	    !test_bit(BTRFS_DEV_STATE_WRITEABLE, &dev->dev_state)) {
+		ret = -EIO;
+		goto out_counter_dec;
+	}
+
+	bio_init(&bio, dev->bdev, &bvec, 1, REQ_OP_WRITE | REQ_SYNC);
+	bio.bi_iter.bi_sector = sector;
+	__bio_add_page(&bio, page, length, pg_offset);
+
+	btrfsic_check_bio(&bio);
+	ret = submit_bio_wait(&bio);
+	if (ret) {
+		/* try to remap that extent elsewhere? */
+		btrfs_dev_stat_inc_and_print(dev, BTRFS_DEV_STAT_WRITE_ERRS);
+		goto out_bio_uninit;
+	}
+
+	btrfs_info_rl_in_rcu(fs_info,
+		"read error corrected: ino %llu off %llu (dev %s sector %llu)",
+				  ino, start,
+				  rcu_str_deref(dev->name), sector);
+	ret = 0;
+
+out_bio_uninit:
+	bio_uninit(&bio);
+out_counter_dec:
+	btrfs_bio_counter_dec(fs_info);
+	return ret;
+}
+
 static bool dev_args_match_fs_devices(const struct btrfs_dev_lookup_args *args,
 				      const struct btrfs_fs_devices *fs_devices)
 {
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index f19a1cd1bfcf2..b368356fa78a1 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -598,6 +598,9 @@ struct btrfs_block_group *btrfs_create_chunk(struct btrfs_trans_handle *trans,
 					    u64 type);
 void btrfs_mapping_tree_free(struct extent_map_tree *tree);
 void btrfs_submit_bio(struct btrfs_fs_info *fs_info, struct bio *bio, int mirror_num);
+int btrfs_repair_io_failure(struct btrfs_fs_info *fs_info, u64 ino, u64 start,
+			    u64 length, u64 logical, struct page *page,
+			    unsigned int pg_offset, int mirror_num);
 int btrfs_open_devices(struct btrfs_fs_devices *fs_devices,
 		       fmode_t flags, void *holder);
 struct btrfs_device *btrfs_scan_one_device(const char *path,
-- 
2.30.2

