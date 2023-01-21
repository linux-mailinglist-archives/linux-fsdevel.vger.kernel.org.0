Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D92F676468
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Jan 2023 07:51:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbjAUGvh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 21 Jan 2023 01:51:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbjAUGv1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 21 Jan 2023 01:51:27 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3547C6E436;
        Fri, 20 Jan 2023 22:51:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=AxZBuhk0TrwjnZEimqYjPUz1ioi7d2NRsclmrZFBSgo=; b=m73O3ObEiEq9hDDNY+p30lktks
        WtjBt7N1/41nt1JJu5XfFa4aMHVlAHX5/Ltq1Kv1PKiEEk7fwZiDK9tnDv1ZnhM8BKxMsFoNT1/m5
        rBkkxvFjdoWFh+pcvcSsALe+5u8eQWQANT2UkyGx53tN1sPR2G/8mwqCt7pfKyZf7SRPN1gqVQVWm
        ATsmpxMveqbPJf6OFVWjps2kRq0ugzctqByCBOKNJKhKx6IFZiWEDiVll8lnk3zxNTp4e55X+6T7P
        Zimf0AwhOb3/EyMFO3wfFpVrfFbxZCxPzxmhUvm9h+aVtA1qrJ64blqtAuNOkFqGfuwW5bdhiC1B6
        JtyAJ4tw==;
Received: from [2001:4bb8:19a:2039:6754:cc81:9ace:36fc] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pJ7ib-00DRSe-Ek; Sat, 21 Jan 2023 06:51:14 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>, Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 15/34] btrfs: remove the io_failure_record infrastructure
Date:   Sat, 21 Jan 2023 07:50:12 +0100
Message-Id: <20230121065031.1139353-16-hch@lst.de>
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

strutc io_failure_record and the io_failure_tree tree are unused now,
so remove them.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/btrfs_inode.h    |   7 -
 fs/btrfs/extent-io-tree.h |   1 -
 fs/btrfs/extent_io.c      | 260 --------------------------------------
 fs/btrfs/extent_io.h      |  31 -----
 fs/btrfs/inode.c          |  16 ---
 5 files changed, 315 deletions(-)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index 99430d0ebbb5fd..78c7979b8dcac7 100644
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
@@ -414,7 +408,6 @@ static inline void btrfs_inode_split_flags(u64 inode_item_flags,
 void btrfs_submit_data_write_bio(struct btrfs_inode *inode, struct bio *bio, int mirror_num);
 void btrfs_submit_data_read_bio(struct btrfs_inode *inode, struct bio *bio,
 			int mirror_num, enum btrfs_compression_type compress_type);
-void btrfs_submit_dio_repair_bio(struct btrfs_inode *inode, struct bio *bio, int mirror_num);
 blk_status_t btrfs_submit_bio_start(struct btrfs_inode *inode, struct bio *bio);
 blk_status_t btrfs_submit_bio_start_direct_io(struct btrfs_inode *inode,
 					      struct bio *bio,
diff --git a/fs/btrfs/extent-io-tree.h b/fs/btrfs/extent-io-tree.h
index e3eeec380844c7..21766e49ec02e7 100644
--- a/fs/btrfs/extent-io-tree.h
+++ b/fs/btrfs/extent-io-tree.h
@@ -6,7 +6,6 @@
 #include "misc.h"
 
 struct extent_changeset;
-struct io_failure_record;
 
 /* Bits for the extent state */
 enum {
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 81f44b6c9fad50..75b717a7b0f97d 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -515,266 +515,6 @@ void extent_clear_unlock_delalloc(struct btrfs_inode *inode, u64 start, u64 end,
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
-	repair_bio = btrfs_bio_alloc(1, REQ_OP_READ, failed_bbio->inode,
-				     failed_bbio->end_io,
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
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index a2c82448b2e076..1b311cd6978321 100644
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
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index c63160cf135d98..190c5ba92f9320 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3249,8 +3249,6 @@ int btrfs_finish_ordered_io(struct btrfs_ordered_extent *ordered_extent)
 					ordered_extent->disk_num_bytes);
 	}
 
-	btrfs_free_io_failure_record(inode, start, end);
-
 	if (test_bit(BTRFS_ORDERED_TRUNCATED, &ordered_extent->flags)) {
 		truncated = true;
 		logical_len = ordered_extent->truncated_len;
@@ -5395,8 +5393,6 @@ void btrfs_evict_inode(struct inode *inode)
 	if (is_bad_inode(inode))
 		goto no_delete;
 
-	btrfs_free_io_failure_record(BTRFS_I(inode), 0, (u64)-1);
-
 	if (test_bit(BTRFS_FS_LOG_RECOVERING, &fs_info->flags))
 		goto no_delete;
 
@@ -7839,16 +7835,6 @@ static void btrfs_dio_private_put(struct btrfs_dio_private *dip)
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
 blk_status_t btrfs_submit_bio_start_direct_io(struct btrfs_inode *inode,
 					      struct bio *bio,
 					      u64 dio_file_offset)
@@ -8714,7 +8700,6 @@ struct inode *btrfs_alloc_inode(struct super_block *sb)
 	ei->last_log_commit = 0;
 
 	spin_lock_init(&ei->lock);
-	spin_lock_init(&ei->io_failure_lock);
 	ei->outstanding_extents = 0;
 	if (sb->s_magic != BTRFS_TEST_MAGIC)
 		btrfs_init_metadata_block_rsv(fs_info, &ei->block_rsv,
@@ -8734,7 +8719,6 @@ struct inode *btrfs_alloc_inode(struct super_block *sb)
 	ei->io_tree.inode = ei;
 	extent_io_tree_init(fs_info, &ei->file_extent_tree,
 			    IO_TREE_INODE_FILE_EXTENT);
-	ei->io_failure_tree = RB_ROOT;
 	atomic_set(&ei->sync_writers, 0);
 	mutex_init(&ei->log_mutex);
 	btrfs_ordered_inode_tree_init(&ei->ordered_tree);
-- 
2.39.0

