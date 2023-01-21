Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A455E676445
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Jan 2023 07:51:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbjAUGuw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 21 Jan 2023 01:50:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbjAUGur (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 21 Jan 2023 01:50:47 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C64D60C95;
        Fri, 20 Jan 2023 22:50:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=YVU9VRc6L3WZtxwJstAm835lKVttiuBdwZQIPJDTkL4=; b=D+U4EumAFtGefjsZEYx97sFMzj
        m2MrI0vixEJV/qtb6uzj/drqylfTejpdMoKVenURZbMRP/HdfmqqH8cob2OS0uDgl9o2gADXoMdHV
        s6QLZFgvZhqMtwcQUl3o6b4BA1zEfsuZMUXDUW/ETWVyRnfEUsmSghbo4GyWYUwMMxhz4VruaffNd
        i+KK11KjX7aX18HLhEQxREQb/joesZjnaiQ1egXJoYU8mO/7uJe7nPnQp1r97oUK5mXu5nXc6oCGt
        Xnr5qrvDcQbAoQUXAoEMlIqHh+LWiSFzGEhcfyNptB7UL0xoYRmWoDfXCJMoD5+DGwTN8JssF8YUf
        I511cs2w==;
Received: from [2001:4bb8:19a:2039:6754:cc81:9ace:36fc] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pJ7i5-00DRG3-Om; Sat, 21 Jan 2023 06:50:42 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>, Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 03/34] btrfs: add a btrfs_inode pointer to struct btrfs_bio
Date:   Sat, 21 Jan 2023 07:50:00 +0100
Message-Id: <20230121065031.1139353-4-hch@lst.de>
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

All btrfs_bio I/Os are associated with an inode.  Add a pointer to that
inode, which will allow to simplify a lot of calling conventions, and
which will be needed in the I/O completion path in the future.

This grow the btrfs_bio struture by a pointer, but that grows will
be offset by the removal of the device pointer soon.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/bio.c         | 8 ++++++--
 fs/btrfs/bio.h         | 5 ++++-
 fs/btrfs/compression.c | 3 ++-
 fs/btrfs/extent_io.c   | 8 ++++----
 fs/btrfs/inode.c       | 4 +++-
 5 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index 8affc88b0e0a4b..2398bb263957b2 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -22,9 +22,11 @@ static struct bio_set btrfs_bioset;
  * is already initialized by the block layer.
  */
 static inline void btrfs_bio_init(struct btrfs_bio *bbio,
+				  struct btrfs_inode *inode,
 				  btrfs_bio_end_io_t end_io, void *private)
 {
 	memset(bbio, 0, offsetof(struct btrfs_bio, bio));
+	bbio->inode = inode;
 	bbio->end_io = end_io;
 	bbio->private = private;
 }
@@ -37,16 +39,18 @@ static inline void btrfs_bio_init(struct btrfs_bio *bbio,
  * a mempool.
  */
 struct bio *btrfs_bio_alloc(unsigned int nr_vecs, blk_opf_t opf,
+			    struct btrfs_inode *inode,
 			    btrfs_bio_end_io_t end_io, void *private)
 {
 	struct bio *bio;
 
 	bio = bio_alloc_bioset(NULL, nr_vecs, opf, GFP_NOFS, &btrfs_bioset);
-	btrfs_bio_init(btrfs_bio(bio), end_io, private);
+	btrfs_bio_init(btrfs_bio(bio), inode, end_io, private);
 	return bio;
 }
 
 struct bio *btrfs_bio_clone_partial(struct bio *orig, u64 offset, u64 size,
+				    struct btrfs_inode *inode,
 				    btrfs_bio_end_io_t end_io, void *private)
 {
 	struct bio *bio;
@@ -56,7 +60,7 @@ struct bio *btrfs_bio_clone_partial(struct bio *orig, u64 offset, u64 size,
 
 	bio = bio_alloc_clone(orig->bi_bdev, orig, GFP_NOFS, &btrfs_bioset);
 	bbio = btrfs_bio(bio);
-	btrfs_bio_init(bbio, end_io, private);
+	btrfs_bio_init(bbio, inode, end_io, private);
 
 	bio_trim(bio, offset >> 9, size >> 9);
 	bbio->iter = bio->bi_iter;
diff --git a/fs/btrfs/bio.h b/fs/btrfs/bio.h
index baaa27961cc812..8d69d0b226d99b 100644
--- a/fs/btrfs/bio.h
+++ b/fs/btrfs/bio.h
@@ -41,7 +41,8 @@ struct btrfs_bio {
 	unsigned int is_metadata:1;
 	struct bvec_iter iter;
 
-	/* File offset that this I/O operates on. */
+	/* Inode and offset into it that this I/O operates on. */
+	struct btrfs_inode *inode;
 	u64 file_offset;
 
 	/* @device is for stripe IO submission. */
@@ -80,8 +81,10 @@ int __init btrfs_bioset_init(void);
 void __cold btrfs_bioset_exit(void);
 
 struct bio *btrfs_bio_alloc(unsigned int nr_vecs, blk_opf_t opf,
+			    struct btrfs_inode *inode,
 			    btrfs_bio_end_io_t end_io, void *private);
 struct bio *btrfs_bio_clone_partial(struct bio *orig, u64 offset, u64 size,
+				    struct btrfs_inode *inode,
 				    btrfs_bio_end_io_t end_io, void *private);
 
 
diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 4a5aeb8dd4793a..b8e3e899974b34 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -344,7 +344,8 @@ static struct bio *alloc_compressed_bio(struct compressed_bio *cb, u64 disk_byte
 	struct bio *bio;
 	int ret;
 
-	bio = btrfs_bio_alloc(BIO_MAX_VECS, opf, endio_func, cb);
+	bio = btrfs_bio_alloc(BIO_MAX_VECS, opf, BTRFS_I(cb->inode), endio_func,
+			      cb);
 	bio->bi_iter.bi_sector = disk_bytenr >> SECTOR_SHIFT;
 
 	em = btrfs_get_chunk_map(fs_info, disk_bytenr, fs_info->sectorsize);
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 9bd32daa9b9a6f..faf9312a46c0e1 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -740,7 +740,8 @@ int btrfs_repair_one_sector(struct btrfs_inode *inode, struct btrfs_bio *failed_
 		return -EIO;
 	}
 
-	repair_bio = btrfs_bio_alloc(1, REQ_OP_READ, failed_bbio->end_io,
+	repair_bio = btrfs_bio_alloc(1, REQ_OP_READ, failed_bbio->inode,
+				     failed_bbio->end_io,
 				     failed_bbio->private);
 	repair_bbio = btrfs_bio(repair_bio);
 	repair_bbio->file_offset = start;
@@ -1394,9 +1395,8 @@ static int alloc_new_bio(struct btrfs_inode *inode,
 	struct bio *bio;
 	int ret;
 
-	ASSERT(bio_ctrl->end_io_func);
-
-	bio = btrfs_bio_alloc(BIO_MAX_VECS, opf, bio_ctrl->end_io_func, NULL);
+	bio = btrfs_bio_alloc(BIO_MAX_VECS, opf, inode, bio_ctrl->end_io_func,
+			      NULL);
 	/*
 	 * For compressed page range, its disk_bytenr is always @disk_bytenr
 	 * passed in, no matter if we have added any range into previous bio.
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 3c49742f0d4556..0a85e42f114cc5 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8097,7 +8097,8 @@ static void btrfs_submit_direct(const struct iomap_iter *iter,
 		 * the allocation is backed by btrfs_bioset.
 		 */
 		bio = btrfs_bio_clone_partial(dio_bio, clone_offset, clone_len,
-					      btrfs_end_dio_bio, dip);
+					      BTRFS_I(inode), btrfs_end_dio_bio,
+					      dip);
 		btrfs_bio(bio)->file_offset = file_offset;
 
 		if (bio_op(bio) == REQ_OP_ZONE_APPEND) {
@@ -10409,6 +10410,7 @@ int btrfs_encoded_read_regular_fill_pages(struct btrfs_inode *inode,
 
 			if (!bio) {
 				bio = btrfs_bio_alloc(BIO_MAX_VECS, REQ_OP_READ,
+						      inode,
 						      btrfs_encoded_read_endio,
 						      &priv);
 				bio->bi_iter.bi_sector =
-- 
2.39.0

