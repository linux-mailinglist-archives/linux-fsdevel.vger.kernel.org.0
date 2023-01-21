Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 599C8676461
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Jan 2023 07:51:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbjAUGvb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 21 Jan 2023 01:51:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbjAUGv0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 21 Jan 2023 01:51:26 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D5086AF76;
        Fri, 20 Jan 2023 22:51:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=FVBdjdtS2xAVxFJcZ9+a5Vf7c7f9xiVy+guacbomNHU=; b=xZQI7B32iexcd2zZM/6gsmrwq0
        hhyIms99AsuLN32rNoMH91oTzqvRycMURo7KFr0DDWkNBYWcfZk/QaxLMcQHUzmSTyDtb42t2DuAW
        N+h/ym9acZUkE+KcNIqfU/zoQZiE4KKJICHOWJ5nKFveVSIqKz8kMhzoi2AJ19QaZ+wwKM3pVfAK2
        1VKQbbKmNf+/U/MRSuw0ydwLbVwu4OIPuYj2Xo7rLbzwi2CNO7WmTD+z8Mz5ILNLvZasabsAFuYUo
        5qJvpiI2DeSpGiTpDZUaNRDxFet+7TxVev9ebhBa53sCyn7dzf6XPgsZp/irVoSPS5oZfgCjmXSV0
        w5kWXjSg==;
Received: from [2001:4bb8:19a:2039:6754:cc81:9ace:36fc] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pJ7iW-00DRRR-10; Sat, 21 Jan 2023 06:51:08 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>, Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 13/34] btrfs: remove now unused checksumming helpers
Date:   Sat, 21 Jan 2023 07:50:10 +0100
Message-Id: <20230121065031.1139353-14-hch@lst.de>
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

Remove the unused btrfs_verify_data_csum helper, and fold
btrfs_check_data_csum into its only caller.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/btrfs_inode.h |   5 --
 fs/btrfs/inode.c       | 127 ++++++-----------------------------------
 2 files changed, 17 insertions(+), 115 deletions(-)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index 3faabcef9898fb..99430d0ebbb5fd 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -421,13 +421,8 @@ blk_status_t btrfs_submit_bio_start_direct_io(struct btrfs_inode *inode,
 					      u64 dio_file_offset);
 int btrfs_check_sector_csum(struct btrfs_fs_info *fs_info, struct page *page,
 			    u32 pgoff, u8 *csum, const u8 * const csum_expected);
-int btrfs_check_data_csum(struct btrfs_inode *inode, struct btrfs_bio *bbio,
-			  u32 bio_offset, struct page *page, u32 pgoff);
 bool btrfs_data_csum_ok(struct btrfs_bio *bbio, struct btrfs_device *dev,
 			u32 bio_offset, struct bio_vec *bv);
-unsigned int btrfs_verify_data_csum(struct btrfs_bio *bbio,
-				    u32 bio_offset, struct page *page,
-				    u64 start, u64 end);
 noinline int can_nocow_extent(struct inode *inode, u64 offset, u64 *len,
 			      u64 *orig_start, u64 *orig_block_len,
 			      u64 *ram_bytes, bool nowait, bool strict);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index d122bf9a72aaff..c63160cf135d98 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3456,45 +3456,6 @@ static u8 *btrfs_csum_ptr(const struct btrfs_fs_info *fs_info, u8 *csums, u64 of
 	return csums + offset_in_sectors * fs_info->csum_size;
 }
 
-/*
- * check_data_csum - verify checksum of one sector of uncompressed data
- * @inode:	inode
- * @bbio:	btrfs_bio which contains the csum
- * @bio_offset:	offset to the beginning of the bio (in bytes)
- * @page:	page where is the data to be verified
- * @pgoff:	offset inside the page
- *
- * The length of such check is always one sector size.
- *
- * When csum mismatch is detected, we will also report the error and fill the
- * corrupted range with zero. (Thus it needs the extra parameters)
- */
-int btrfs_check_data_csum(struct btrfs_inode *inode, struct btrfs_bio *bbio,
-			  u32 bio_offset, struct page *page, u32 pgoff)
-{
-	struct btrfs_fs_info *fs_info = inode->root->fs_info;
-	u32 len = fs_info->sectorsize;
-	u8 *csum_expected;
-	u8 csum[BTRFS_CSUM_SIZE];
-
-	ASSERT(pgoff + len <= PAGE_SIZE);
-
-	csum_expected = btrfs_csum_ptr(fs_info, bbio->csum, bio_offset);
-
-	if (btrfs_check_sector_csum(fs_info, page, pgoff, csum, csum_expected))
-		goto zeroit;
-	return 0;
-
-zeroit:
-	btrfs_print_data_csum_error(inode, bbio->file_offset + bio_offset,
-				    csum, csum_expected, bbio->mirror_num);
-	if (bbio->device)
-		btrfs_dev_stat_inc_and_print(bbio->device,
-					     BTRFS_DEV_STAT_CORRUPTION_ERRS);
-	memzero_page(page, pgoff, len);
-	return -EIO;
-}
-
 /*
  * btrfs_data_csum_ok - verify the checksum of single data sector
  * @bbio:	btrfs_io_bio which contains the csum
@@ -3512,8 +3473,13 @@ bool btrfs_data_csum_ok(struct btrfs_bio *bbio, struct btrfs_device *dev,
 			u32 bio_offset, struct bio_vec *bv)
 {
 	struct btrfs_inode *inode = bbio->inode;
+	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	u64 file_offset = bbio->file_offset + bio_offset;
 	u64 end = file_offset + bv->bv_len - 1;
+	u8 *csum_expected;
+	u8 csum[BTRFS_CSUM_SIZE];
+
+	ASSERT(bv->bv_len == fs_info->sectorsize);
 
 	if (!bbio->csum)
 		return true;
@@ -3527,78 +3493,19 @@ bool btrfs_data_csum_ok(struct btrfs_bio *bbio, struct btrfs_device *dev,
 		return true;
 	}
 
-	if (btrfs_check_data_csum(inode, bbio, bio_offset, bv->bv_page,
-				  bv->bv_offset) < 0)
-		return false;
+	csum_expected = btrfs_csum_ptr(fs_info, bbio->csum, bio_offset);
+	if (btrfs_check_sector_csum(fs_info, bv->bv_page, bv->bv_offset, csum,
+				    csum_expected))
+		goto zeroit;
 	return true;
-}
-
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
+zeroit:
+	btrfs_print_data_csum_error(inode, file_offset, csum, csum_expected,
+				    bbio->mirror_num);
+	if (dev)
+		btrfs_dev_stat_inc_and_print(dev,
+					     BTRFS_DEV_STAT_CORRUPTION_ERRS);
+	memzero_bvec(bv);
+	return false;
 }
 
 /*
-- 
2.39.0

