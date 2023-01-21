Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB302676451
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Jan 2023 07:51:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbjAUGuz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 21 Jan 2023 01:50:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbjAUGuw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 21 Jan 2023 01:50:52 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7604764DA1;
        Fri, 20 Jan 2023 22:50:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=UUIQ0WfkB0OWqxnnjRo6TSIB2GW/uehEKf5YRJIoCrw=; b=ItwsOJzdS32Wgoi3qf1PhnT81/
        ZUWGIB80uToTne9LOWJqQHOC8yewZwNU0tdxRe1HNqGJ00PgtjePTBZELtiDgEKqT3Wy/ysbnF/kR
        H946VxBS5raKkbreipLdqvmDPTNYrSOrUs/inEdw9UXVkAM8P1A4B5TaT5m38LiOWzJU51D0/44my
        fuxHK8TPYVFJKQ7WpV/dRBfJf6n4P4/ImYa/DG0n05WwrHid95pv1671TzVvYZ6I5Sdhh3OtmDn21
        cjmE9neWKMCcQja75eN/szFtzoh+bt0RzLz9qOYi/7gKEZPh7qFTKPZoVvDrasyuSr5SQ1TQN1fcY
        6FRf3k6A==;
Received: from [2001:4bb8:19a:2039:6754:cc81:9ace:36fc] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pJ7iB-00DRHX-1b; Sat, 21 Jan 2023 06:50:47 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>, Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 05/34] btrfs: simplify btrfs_lookup_bio_sums
Date:   Sat, 21 Jan 2023 07:50:02 +0100
Message-Id: <20230121065031.1139353-6-hch@lst.de>
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

The csums argument is always NULL now, so remove it and always allocate
the csums array in the btrfs_bio.  Also pass the btrfs_bio instead of
inode + bio to document that this function requires a btrfs_bio and
not just any bio.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/compression.c |  2 +-
 fs/btrfs/file-item.c   | 52 ++++++++++++++++--------------------------
 fs/btrfs/file-item.h   |  2 +-
 fs/btrfs/inode.c       |  6 ++---
 4 files changed, 25 insertions(+), 37 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index b8e3e899974b34..ab7f7ea499d9ca 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -801,7 +801,7 @@ void btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 			 */
 			btrfs_bio(comp_bio)->file_offset = file_offset;
 
-			ret = btrfs_lookup_bio_sums(inode, comp_bio, NULL);
+			ret = btrfs_lookup_bio_sums(btrfs_bio(comp_bio));
 			if (ret) {
 				btrfs_bio_end_io(btrfs_bio(comp_bio), ret);
 				break;
diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index 5de73466b2ca2d..c5324fe8f4be7a 100644
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
index 0312256684349b..a2f9747adf3ac0 100644
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
index 863a5527853c66..7c8f5349ed7a4c 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2780,7 +2780,7 @@ void btrfs_submit_data_read_bio(struct btrfs_inode *inode, struct bio *bio,
 	 * Lookup bio sums does extra checks around whether we need to csum or
 	 * not, which is why we ignore skip_sum here.
 	 */
-	ret = btrfs_lookup_bio_sums(&inode->vfs_inode, bio, NULL);
+	ret = btrfs_lookup_bio_sums(btrfs_bio(bio));
 	if (ret) {
 		btrfs_bio_end_io(btrfs_bio(bio), ret);
 		return;
@@ -8012,7 +8012,7 @@ static void btrfs_submit_dio_bio(struct bio *bio, struct btrfs_inode *inode,
 			return;
 		}
 	} else {
-		ret = btrfs_lookup_bio_sums(&inode->vfs_inode, bio, NULL);
+		ret = btrfs_lookup_bio_sums(btrfs_bio(bio));
 		if (ret) {
 			btrfs_bio_end_io(btrfs_bio(bio), ret);
 			return;
@@ -10279,7 +10279,7 @@ static blk_status_t submit_encoded_read_bio(struct btrfs_inode *inode,
 	blk_status_t ret;
 
 	if (!priv->skip_csum) {
-		ret = btrfs_lookup_bio_sums(&inode->vfs_inode, bio, NULL);
+		ret = btrfs_lookup_bio_sums(btrfs_bio(bio));
 		if (ret)
 			return ret;
 	}
-- 
2.39.0

