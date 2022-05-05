Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BEA551CA50
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 May 2022 22:12:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385762AbiEEUPm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 May 2022 16:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385755AbiEEUPb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 May 2022 16:15:31 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0D355FF06;
        Thu,  5 May 2022 13:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=WtbEYwJtR2Fjgp7y4ng65BxJF9ljaWs0cq/rZODAVK8=; b=XoijPpKgtO61VW8la2vd1yPvD9
        pynphNPyALfHjjodvU1bSllyacSGe6zIJZv67PJ6IajoTgR5iAyojawEOL1SB5Cto9Zfkt7EX8Amx
        VMw2dSMKv5Lza8HjLaG1tqHIaRSvqiGziJFp3u27TdhnQYaZxVfJzfvXhpg94kFPOFfUF6QNXNXeo
        CyubzBIKwJZ1y7SAXikhJsw3+dKWBENpof4e1yM8dxoL8F9iMrIhK0Fabmzd04wUB7gxflnQVJG7U
        RCHE07MkK3kc7Pp1qpal6ZGmDu9IOxu3LnL+ZTSU4gUS0OwWIi0X8OyKlaWMQR9p9Bspeq/qaRYyv
        zv2pMK1w==;
Received: from 65-114-90-19.dia.static.qwest.net ([65.114.90.19] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nmhov-0006mN-Po; Thu, 05 May 2022 20:11:29 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-btrfs@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 7/7] btrfs: allocate the btrfs_dio_private as part of the iomap dio bio
Date:   Thu,  5 May 2022 15:11:15 -0500
Message-Id: <20220505201115.937837-8-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220505201115.937837-1-hch@lst.de>
References: <20220505201115.937837-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Create a new bio_set that contains all the per-bio private data needed
by btrfs for direct I/O and tell the iomap code to use that instead
of separately allocation the btrfs_dio_private structure.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/inode.c | 92 ++++++++++++++++++------------------------------
 1 file changed, 34 insertions(+), 58 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index edccfc5889e6c..9443f9cef2b05 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -85,13 +85,14 @@ struct btrfs_dio_private {
 	 */
 	refcount_t refs;
 
-	/* dio_bio came from fs/direct-io.c */
-	struct bio *dio_bio;
-
 	/* Array of checksums */
-	u8 csums[];
+	u8 *csums;
+
+	struct bio bio;
 };
 
+static struct bio_set btrfs_dio_bioset;
+
 struct btrfs_rename_ctx {
 	/* Output field. Stores the index number of the old directory entry. */
 	u64 index;
@@ -7828,19 +7829,19 @@ static void btrfs_dio_private_put(struct btrfs_dio_private *dip)
 	if (!refcount_dec_and_test(&dip->refs))
 		return;
 
-	if (btrfs_op(dip->dio_bio) == BTRFS_MAP_WRITE) {
+	if (btrfs_op(&dip->bio) == BTRFS_MAP_WRITE) {
 		__endio_write_update_ordered(BTRFS_I(dip->inode),
 					     dip->file_offset,
 					     dip->bytes,
-					     !dip->dio_bio->bi_status);
+					     !dip->bio.bi_status);
 	} else {
 		unlock_extent(&BTRFS_I(dip->inode)->io_tree,
 			      dip->file_offset,
 			      dip->file_offset + dip->bytes - 1);
 	}
 
-	bio_endio(dip->dio_bio);
-	kfree(dip);
+	kfree(dip->csums);
+	bio_endio(&dip->bio);
 }
 
 static void submit_dio_repair_bio(struct inode *inode, struct bio *bio,
@@ -7942,7 +7943,7 @@ static void btrfs_end_dio_bio(struct bio *bio)
 		err = btrfs_check_read_dio_bio(dip, bbio, !err);
 
 	if (err)
-		dip->dio_bio->bi_status = err;
+		dip->bio.bi_status = err;
 
 	btrfs_record_physical_zoned(dip->inode, bbio->file_offset, bio);
 
@@ -7997,49 +7998,16 @@ static inline blk_status_t btrfs_submit_dio_bio(struct bio *bio,
 	return ret;
 }
 
-/*
- * If this succeeds, the btrfs_dio_private is responsible for cleaning up locked
- * or ordered extents whether or not we submit any bios.
- */
-static struct btrfs_dio_private *btrfs_create_dio_private(struct bio *dio_bio,
-							  struct inode *inode,
-							  loff_t file_offset)
-{
-	const bool write = (btrfs_op(dio_bio) == BTRFS_MAP_WRITE);
-	const bool csum = !(BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM);
-	size_t dip_size;
-	struct btrfs_dio_private *dip;
-
-	dip_size = sizeof(*dip);
-	if (!write && csum) {
-		struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
-		size_t nblocks;
-
-		nblocks = dio_bio->bi_iter.bi_size >> fs_info->sectorsize_bits;
-		dip_size += fs_info->csum_size * nblocks;
-	}
-
-	dip = kzalloc(dip_size, GFP_NOFS);
-	if (!dip)
-		return NULL;
-
-	dip->inode = inode;
-	dip->file_offset = file_offset;
-	dip->bytes = dio_bio->bi_iter.bi_size;
-	dip->dio_bio = dio_bio;
-	refcount_set(&dip->refs, 1);
-	return dip;
-}
-
 static void btrfs_submit_direct(const struct iomap_iter *iter,
 		struct bio *dio_bio, loff_t file_offset)
 {
+	struct btrfs_dio_private *dip =
+		container_of(dio_bio, struct btrfs_dio_private, bio);
 	struct inode *inode = iter->inode;
 	const bool write = (btrfs_op(dio_bio) == BTRFS_MAP_WRITE);
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	const bool raid56 = (btrfs_data_alloc_profile(fs_info) &
 			     BTRFS_BLOCK_GROUP_RAID56_MASK);
-	struct btrfs_dio_private *dip;
 	struct bio *bio;
 	u64 start_sector;
 	int async_submit = 0;
@@ -8053,24 +8021,25 @@ static void btrfs_submit_direct(const struct iomap_iter *iter,
 	struct btrfs_dio_data *dio_data = iter->private;
 	struct extent_map *em = NULL;
 
-	dip = btrfs_create_dio_private(dio_bio, inode, file_offset);
-	if (!dip) {
-		if (!write) {
-			unlock_extent(&BTRFS_I(inode)->io_tree, file_offset,
-				file_offset + dio_bio->bi_iter.bi_size - 1);
-		}
-		dio_bio->bi_status = BLK_STS_RESOURCE;
-		bio_endio(dio_bio);
-		return;
-	}
+	dip->inode = inode;
+	dip->file_offset = file_offset;
+	dip->bytes = dio_bio->bi_iter.bi_size;
+	refcount_set(&dip->refs, 1);
+	dip->csums = NULL;
+
+	if (!write && !(BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM)) {
+		unsigned int nr_sectors = 
+			(dio_bio->bi_iter.bi_size >> fs_info->sectorsize_bits);
 
-	if (!write) {
 		/*
 		 * Load the csums up front to reduce csum tree searches and
 		 * contention when submitting bios.
-		 *
-		 * If we have csums disabled this will do nothing.
 		 */
+		status = BLK_STS_RESOURCE;
+		dip->csums = kcalloc(nr_sectors, fs_info->csum_size, GFP_NOFS);
+		if (!dip)
+			goto out_err;
+
 		status = btrfs_lookup_bio_sums(inode, dio_bio, dip->csums);
 		if (status != BLK_STS_OK)
 			goto out_err;
@@ -8160,7 +8129,7 @@ static void btrfs_submit_direct(const struct iomap_iter *iter,
 out_err_em:
 	free_extent_map(em);
 out_err:
-	dip->dio_bio->bi_status = status;
+	dio_bio->bi_status = status;
 	btrfs_dio_private_put(dip);
 }
 
@@ -8171,6 +8140,7 @@ static const struct iomap_ops btrfs_dio_iomap_ops = {
 
 static const struct iomap_dio_ops btrfs_dio_ops = {
 	.submit_io		= btrfs_submit_direct,
+	.bio_set		= &btrfs_dio_bioset,
 };
 
 ssize_t btrfs_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
@@ -8992,6 +8962,7 @@ void __cold btrfs_destroy_cachep(void)
 	 * destroy cache.
 	 */
 	rcu_barrier();
+	bioset_exit(&btrfs_dio_bioset);
 	kmem_cache_destroy(btrfs_inode_cachep);
 	kmem_cache_destroy(btrfs_trans_handle_cachep);
 	kmem_cache_destroy(btrfs_path_cachep);
@@ -9032,6 +9003,11 @@ int __init btrfs_init_cachep(void)
 	if (!btrfs_free_space_bitmap_cachep)
 		goto fail;
 
+	if (bioset_init(&btrfs_dio_bioset, BIO_POOL_SIZE,
+			offsetof(struct btrfs_dio_private, bio),
+			BIOSET_NEED_BVECS))
+		goto fail;
+
 	return 0;
 fail:
 	btrfs_destroy_cachep();
-- 
2.30.2

