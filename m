Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 513124E439B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Mar 2022 16:57:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234304AbiCVP6y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Mar 2022 11:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238881AbiCVP6l (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Mar 2022 11:58:41 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 919326E8CC;
        Tue, 22 Mar 2022 08:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=qzxsIcm5bjCsd5hcdmo9jxKnwHIPDhBz77vOlLF/vFU=; b=FbdPlVZwFUvmJ7YqBAU6smjXEX
        4rw+Jcnr+IpLKFahqWZan1OW1bu+wuDfIgSp3bnzMldbEZpx0rM25XlMmWxujJ0Jc7Nq0Tk24fTJK
        raZ1wUq8rVKD3XBBwi/99B+qRZgS/v5z1xIvGO+vo9F27H1PYfP1Nc9OQ8y63JiXxcKa11Oq7Dw4u
        aXMKSMt22vCsVjxsPxYD4aVA8kOj/wakTRyiTTn1bmHM0Ml7zamKdB/6EhUo2BcL+RRUH0E673S5O
        p9oyCIWWSD8krb3ImsMHBwKDSScc2ht1b6TaXMX2wFLT78BkjXgt0gh8/3A07NWDVTC8ULgIc50Ki
        rBb0n2CQ==;
Received: from [2001:4bb8:19a:b822:6444:5366:9486:4da] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nWgse-00Batr-4x; Tue, 22 Mar 2022 15:57:08 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>
Cc:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 23/40] btrfs: store an inode pointer in struct btrfs_bio
Date:   Tue, 22 Mar 2022 16:55:49 +0100
Message-Id: <20220322155606.1267165-24-hch@lst.de>
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

All the I/O going through the btrfs_bio based path are associated with an
inode.  Add a pointer to it to simplify a few things soon.  Also pass the
bio operation to btrfs_bio_alloc given that we have to touch it anyway.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/compression.c |  4 +---
 fs/btrfs/extent_io.c   | 23 ++++++++++++-----------
 fs/btrfs/extent_io.h   |  6 ++++--
 fs/btrfs/inode.c       |  3 ++-
 fs/btrfs/volumes.h     |  2 ++
 5 files changed, 21 insertions(+), 17 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 71e5b2e9a1ba8..419a09d924290 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -464,10 +464,8 @@ static struct bio *alloc_compressed_bio(struct compressed_bio *cb, u64 disk_byte
 	struct bio *bio;
 	int ret;
 
-	bio = btrfs_bio_alloc(BIO_MAX_VECS);
-
+	bio = btrfs_bio_alloc(cb->inode, BIO_MAX_VECS, opf);
 	bio->bi_iter.bi_sector = disk_bytenr >> SECTOR_SHIFT;
-	bio->bi_opf = opf;
 	bio->bi_private = cb;
 	bio->bi_end_io = endio_func;
 
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 58ef0f4fca361..116a65787e314 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2657,10 +2657,9 @@ int btrfs_repair_one_sector(struct inode *inode,
 		return -EIO;
 	}
 
-	repair_bio = btrfs_bio_alloc(1);
+	repair_bio = btrfs_bio_alloc(inode, 1, REQ_OP_READ);
 	repair_bbio = btrfs_bio(repair_bio);
 	repair_bbio->file_offset = start;
-	repair_bio->bi_opf = REQ_OP_READ;
 	repair_bio->bi_end_io = failed_bio->bi_end_io;
 	repair_bio->bi_iter.bi_sector = failrec->logical >> 9;
 	repair_bio->bi_private = failed_bio->bi_private;
@@ -3128,9 +3127,10 @@ static void end_bio_extent_readpage(struct bio *bio)
  * new bio by bio_alloc_bioset as it does not initialize the bytes outside of
  * 'bio' because use of __GFP_ZERO is not supported.
  */
-static inline void btrfs_bio_init(struct btrfs_bio *bbio)
+static inline void btrfs_bio_init(struct btrfs_bio *bbio, struct inode *inode)
 {
 	memset(bbio, 0, offsetof(struct btrfs_bio, bio));
+	bbio->inode = inode;
 }
 
 /*
@@ -3138,13 +3138,14 @@ static inline void btrfs_bio_init(struct btrfs_bio *bbio)
  *
  * The bio allocation is backed by bioset and does not fail.
  */
-struct bio *btrfs_bio_alloc(unsigned int nr_iovecs)
+struct bio *btrfs_bio_alloc(struct inode *inode, unsigned int nr_iovecs,
+		unsigned int opf)
 {
 	struct bio *bio;
 
 	ASSERT(0 < nr_iovecs && nr_iovecs <= BIO_MAX_VECS);
-	bio = bio_alloc_bioset(NULL, nr_iovecs, 0, GFP_NOFS, &btrfs_bioset);
-	btrfs_bio_init(btrfs_bio(bio));
+	bio = bio_alloc_bioset(NULL, nr_iovecs, opf, GFP_NOFS, &btrfs_bioset);
+	btrfs_bio_init(btrfs_bio(bio), inode);
 	return bio;
 }
 
@@ -3156,12 +3157,13 @@ struct bio *btrfs_bio_clone(struct block_device *bdev, struct bio *bio)
 	/* Bio allocation backed by a bioset does not fail */
 	new = bio_alloc_clone(bdev, bio, GFP_NOFS, &btrfs_bioset);
 	bbio = btrfs_bio(new);
-	btrfs_bio_init(bbio);
+	btrfs_bio_init(btrfs_bio(new), btrfs_bio(bio)->inode);
 	bbio->iter = bio->bi_iter;
 	return new;
 }
 
-struct bio *btrfs_bio_clone_partial(struct bio *orig, u64 offset, u64 size)
+struct bio *btrfs_bio_clone_partial(struct inode *inode, struct bio *orig,
+		u64 offset, u64 size)
 {
 	struct bio *bio;
 	struct btrfs_bio *bbio;
@@ -3173,7 +3175,7 @@ struct bio *btrfs_bio_clone_partial(struct bio *orig, u64 offset, u64 size)
 	ASSERT(bio);
 
 	bbio = btrfs_bio(bio);
-	btrfs_bio_init(bbio);
+	btrfs_bio_init(btrfs_bio(bio), inode);
 
 	bio_trim(bio, offset >> 9, size >> 9);
 	bbio->iter = bio->bi_iter;
@@ -3308,7 +3310,7 @@ static int alloc_new_bio(struct btrfs_inode *inode,
 	struct bio *bio;
 	int ret;
 
-	bio = btrfs_bio_alloc(BIO_MAX_VECS);
+	bio = btrfs_bio_alloc(&inode->vfs_inode, BIO_MAX_VECS, opf);
 	/*
 	 * For compressed page range, its disk_bytenr is always @disk_bytenr
 	 * passed in, no matter if we have added any range into previous bio.
@@ -3321,7 +3323,6 @@ static int alloc_new_bio(struct btrfs_inode *inode,
 	bio_ctrl->bio_flags = bio_flags;
 	bio->bi_end_io = end_io_func;
 	bio->bi_private = &inode->io_tree;
-	bio->bi_opf = opf;
 	ret = calc_bio_boundaries(bio_ctrl, inode, file_offset);
 	if (ret < 0)
 		goto error;
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 72d86f228c56e..d5f3d9692ea29 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -277,9 +277,11 @@ void extent_range_redirty_for_io(struct inode *inode, u64 start, u64 end);
 void extent_clear_unlock_delalloc(struct btrfs_inode *inode, u64 start, u64 end,
 				  struct page *locked_page,
 				  u32 bits_to_clear, unsigned long page_ops);
-struct bio *btrfs_bio_alloc(unsigned int nr_iovecs);
+struct bio *btrfs_bio_alloc(struct inode *inode, unsigned int nr_iovecs,
+		unsigned int opf);
 struct bio *btrfs_bio_clone(struct block_device *bdev, struct bio *bio);
-struct bio *btrfs_bio_clone_partial(struct bio *orig, u64 offset, u64 size);
+struct bio *btrfs_bio_clone_partial(struct inode *inode, struct bio *orig,
+		u64 offset, u64 size);
 
 void end_extent_writepage(struct page *page, int err, u64 start, u64 end);
 int btrfs_repair_eb_io_failure(const struct extent_buffer *eb, int mirror_num);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 5c9d8e8a98466..18d54cfedf829 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7987,7 +7987,8 @@ static void btrfs_submit_direct(const struct iomap_iter *iter,
 		 * This will never fail as it's passing GPF_NOFS and
 		 * the allocation is backed by btrfs_bioset.
 		 */
-		bio = btrfs_bio_clone_partial(dio_bio, clone_offset, clone_len);
+		bio = btrfs_bio_clone_partial(inode, dio_bio, clone_offset,
+					      clone_len);
 		bio->bi_private = dip;
 		bio->bi_end_io = btrfs_end_dio_bio;
 		btrfs_bio(bio)->file_offset = file_offset;
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index c22148bebc2f5..a4f942547002e 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -321,6 +321,8 @@ struct btrfs_fs_devices {
  * Mostly for btrfs specific features like csum and mirror_num.
  */
 struct btrfs_bio {
+	struct inode *inode;
+
 	unsigned int mirror_num;
 
 	/* for direct I/O */
-- 
2.30.2

