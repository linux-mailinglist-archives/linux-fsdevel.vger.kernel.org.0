Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8CAE4E43B0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Mar 2022 16:58:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238965AbiCVP7j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Mar 2022 11:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238887AbiCVP64 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Mar 2022 11:58:56 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D11666FA28;
        Tue, 22 Mar 2022 08:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=jpn5Aeyh/dmhhv8JvCK37lA6b5dVQZ6qM2nsrlVWYo0=; b=X1b43OO7UJ2QzZ+JlgJmi2skY0
        KMUMDQDa+1p2HZgdbHLYYuibD1B+rkE9tMt26IVBfTGDoFv39gWpZtfG7gVsR3nRnd7y6IkUM15kv
        hMKzHrFtAsrO7jF+RqK5b1kNYfYONZriuGx5QVVufQ0BcNdZ3DjYff23MY0sKhmSdDUCX2tb8QTCt
        4xbvylvbKJFHJCHK9fOM5BdCi1gYhxVN2Gyl8ekWtRIgxm9ZyPbwRPQNTFfe0k0O7hLgs4xN6FwoS
        JtKoolZ416rSHwbBZEdFkFpNz8+BX8MmzJw63WTbT2o5n0tGdZF4Gn3ZXFVZg6Ov4291WRi8szTaw
        XqP/5eVA==;
Received: from [2001:4bb8:19a:b822:6444:5366:9486:4da] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nWgst-00Bb0u-Kn; Tue, 22 Mar 2022 15:57:24 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>
Cc:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 29/40] btrfs: do not allocate a btrfs_bio for low-level bios
Date:   Tue, 22 Mar 2022 16:55:55 +0100
Message-Id: <20220322155606.1267165-30-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220322155606.1267165-1-hch@lst.de>
References: <20220322155606.1267165-1-hch@lst.de>
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

The bios submitted from btrfs_map_bio don't interact with the rest
of btrfs.  The only btrfs_bio field is the device.  Add a bbio
backpointer pointer to struct btrfs_bio_stripe so that the private
data can point to the stripe and just use a normal bio allocation
for them.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/extent_io.c | 13 -------------
 fs/btrfs/extent_io.h |  1 -
 fs/btrfs/volumes.c   | 21 +++++++++++----------
 fs/btrfs/volumes.h   |  5 ++++-
 4 files changed, 15 insertions(+), 25 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 116a65787e314..bfd91ed27bd14 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3149,19 +3149,6 @@ struct bio *btrfs_bio_alloc(struct inode *inode, unsigned int nr_iovecs,
 	return bio;
 }
 
-struct bio *btrfs_bio_clone(struct block_device *bdev, struct bio *bio)
-{
-	struct btrfs_bio *bbio;
-	struct bio *new;
-
-	/* Bio allocation backed by a bioset does not fail */
-	new = bio_alloc_clone(bdev, bio, GFP_NOFS, &btrfs_bioset);
-	bbio = btrfs_bio(new);
-	btrfs_bio_init(btrfs_bio(new), btrfs_bio(bio)->inode);
-	bbio->iter = bio->bi_iter;
-	return new;
-}
-
 struct bio *btrfs_bio_clone_partial(struct inode *inode, struct bio *orig,
 		u64 offset, u64 size)
 {
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index d5f3d9692ea29..3f0cb1ef5fdff 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -279,7 +279,6 @@ void extent_clear_unlock_delalloc(struct btrfs_inode *inode, u64 start, u64 end,
 				  u32 bits_to_clear, unsigned long page_ops);
 struct bio *btrfs_bio_alloc(struct inode *inode, unsigned int nr_iovecs,
 		unsigned int opf);
-struct bio *btrfs_bio_clone(struct block_device *bdev, struct bio *bio);
 struct bio *btrfs_bio_clone_partial(struct inode *inode, struct bio *orig,
 		u64 offset, u64 size);
 
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index cec3f6b9f5c21..7392b9f2a3323 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6749,23 +6749,21 @@ static void btrfs_end_bbio(struct btrfs_bio *bbio, bool async)
 
 static void btrfs_end_bio(struct bio *bio)
 {
-	struct btrfs_bio *bbio = bio->bi_private;
+	struct btrfs_bio_stripe *stripe = bio->bi_private;
+	struct btrfs_bio *bbio = stripe->bbio;
 
 	if (bio->bi_status) {
 		atomic_inc(&bbio->error);
 		if (bio->bi_status == BLK_STS_IOERR ||
 		    bio->bi_status == BLK_STS_TARGET) {
-			struct btrfs_device *dev = btrfs_bio(bio)->device;
-
-			ASSERT(dev->bdev);
 			if (btrfs_op(bio) == BTRFS_MAP_WRITE)
-				btrfs_dev_stat_inc_and_print(dev,
+				btrfs_dev_stat_inc_and_print(stripe->dev,
 						BTRFS_DEV_STAT_WRITE_ERRS);
 			else if (!(bio->bi_opf & REQ_RAHEAD))
-				btrfs_dev_stat_inc_and_print(dev,
+				btrfs_dev_stat_inc_and_print(stripe->dev,
 						BTRFS_DEV_STAT_READ_ERRS);
 			if (bio->bi_opf & REQ_PREFLUSH)
-				btrfs_dev_stat_inc_and_print(dev,
+				btrfs_dev_stat_inc_and_print(stripe->dev,
 						BTRFS_DEV_STAT_FLUSH_ERRS);
 		}
 	}
@@ -6796,14 +6794,17 @@ static void submit_stripe_bio(struct btrfs_bio *bbio, int dev_nr, bool clone)
 	}
 
 	if (clone) {
-		bio = btrfs_bio_clone(dev->bdev, &bbio->bio);
+		bio = bio_alloc_clone(dev->bdev, &bbio->bio, GFP_NOFS,
+				      &fs_bio_set);
 	} else {
 		bio = &bbio->bio;
 		bio_set_dev(bio, dev->bdev);
+		btrfs_bio(bio)->device = dev;
 	}
 
-	bio->bi_private = bbio;
-	btrfs_bio(bio)->device = dev;
+	bbio->stripes[dev_nr].bbio = bbio;
+	bio->bi_private = &bbio->stripes[dev_nr];
+
 	bio->bi_end_io = btrfs_end_bio;
 	bio->bi_iter.bi_sector = physical >> 9;
 	/*
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index cd71cd33a9df2..5b0e7602434b0 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -325,7 +325,10 @@ enum btrfs_endio_type {
 
 struct btrfs_bio_stripe {
 	struct btrfs_device *dev;
-	u64 physical;
+	union {
+		u64 physical;			/* block mapping */
+		struct btrfs_bio *bbio;		/* for end I/O */
+	};
 };
 
 /*
-- 
2.30.2

