Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B167B67644E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Jan 2023 07:51:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbjAUGux (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 21 Jan 2023 01:50:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbjAUGut (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 21 Jan 2023 01:50:49 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1919613E7;
        Fri, 20 Jan 2023 22:50:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=VnvwOLm6Q9rjuIuCgh+ehlpEUye0YOYIcvYHqRbdSuo=; b=Nl4b9mYvv1h3FlI92MVoAbSNJ9
        J8jNHoG/toK9Lhm5r+ldCaV/l9TI12nxFTBi6P8yMH+2Igr/BrJX7UUUTTDjomr3VAU5bph5mpwi+
        7VP5yfN8ZkNBxUHjlGMYBz4XBOQCNck89SMgubVv2FEDPaG+QJURFueMqIlEHy2JS3EW2wneo2sN+
        NeubrFGx2XAZIkfFC0Z0WOJ4LKZKDWpUtRXe2LKrBWX4kMt8LygsIgJF9TQRLsLnpuDVFW4F/XRFB
        Wmx8CqJ7n9oCjxKTRNgopffKxA9/C+ZqVutoOPKWkNkTl9NideZ8ZcLb/FtbI538s5xR+dMMEFCxz
        w7wT4wEg==;
Received: from [2001:4bb8:19a:2039:6754:cc81:9ace:36fc] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pJ7i8-00DRGy-GX; Sat, 21 Jan 2023 06:50:44 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>, Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 04/34] btrfs: remove the direct I/O read checksum lookup optimization
Date:   Sat, 21 Jan 2023 07:50:01 +0100
Message-Id: <20230121065031.1139353-5-hch@lst.de>
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

To prepare for pending changes drop the optimization to only look up
csums once per bio that is submitted from the iomap layer.  In the
short run this does cause additional lookups for fragmented direct
reads, but later in the series, the bio based lookup will be used on
the entire bio submitted from iomap, restoring the old behavior
in common code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/inode.c | 32 +++++---------------------------
 1 file changed, 5 insertions(+), 27 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 0a85e42f114cc5..863a5527853c66 100644
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
@@ -7907,7 +7904,6 @@ static void btrfs_dio_private_put(struct btrfs_dio_private *dip)
 			      dip->file_offset + dip->bytes - 1, NULL);
 	}
 
-	kfree(dip->csums);
 	bio_endio(&dip->bio);
 }
 
@@ -7990,7 +7986,6 @@ static void btrfs_submit_dio_bio(struct bio *bio, struct btrfs_inode *inode,
 				 u64 file_offset, int async_submit)
 {
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
-	struct btrfs_dio_private *dip = btrfs_bio(bio)->private;
 	blk_status_t ret;
 
 	/* Save the original iter for read repair */
@@ -8017,8 +8012,11 @@ static void btrfs_submit_dio_bio(struct bio *bio, struct btrfs_inode *inode,
 			return;
 		}
 	} else {
-		btrfs_bio(bio)->csum = btrfs_csum_ptr(fs_info, dip->csums,
-						      file_offset - dip->file_offset);
+		ret = btrfs_lookup_bio_sums(&inode->vfs_inode, bio, NULL);
+		if (ret) {
+			btrfs_bio_end_io(btrfs_bio(bio), ret);
+			return;
+		}
 	}
 map:
 	btrfs_submit_bio(fs_info, bio, 0);
@@ -8030,7 +8028,6 @@ static void btrfs_submit_direct(const struct iomap_iter *iter,
 	struct btrfs_dio_private *dip =
 		container_of(dio_bio, struct btrfs_dio_private, bio);
 	struct inode *inode = iter->inode;
-	const bool write = (btrfs_op(dio_bio) == BTRFS_MAP_WRITE);
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	const bool raid56 = (btrfs_data_alloc_profile(fs_info) &
 			     BTRFS_BLOCK_GROUP_RAID56_MASK);
@@ -8051,25 +8048,6 @@ static void btrfs_submit_direct(const struct iomap_iter *iter,
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
-- 
2.39.0

