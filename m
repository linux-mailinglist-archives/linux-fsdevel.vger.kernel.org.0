Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C57A108CD3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2019 12:19:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727779AbfKYLTF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Nov 2019 06:19:05 -0500
Received: from mx2.suse.de ([195.135.220.15]:50346 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727659AbfKYLTE (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Nov 2019 06:19:04 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6223DB3F5;
        Mon, 25 Nov 2019 11:19:02 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id E82581E04C9; Mon, 25 Nov 2019 12:19:01 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        <linux-fsdevel@vger.kernel.org>,
        Eric Biggers <ebiggers@kernel.org>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH] iomap: Do not create fake iter in iomap_dio_bio_actor()
Date:   Mon, 25 Nov 2019 12:18:57 +0100
Message-Id: <20191125111901.11910-1-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191125083930.11854-1-jack@suse.cz>
References: <20191125083930.11854-1-jack@suse.cz>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

iomap_dio_bio_actor() copies iter to a local variable and then limits it
to a file extent we have mapped. When IO is submitted,
iomap_dio_bio_actor() advances the original iter while the copied iter
is advanced inside bio_iov_iter_get_pages(). This logic is non-obvious
especially because both iters still point to same shared structures
(such as pipe info) so if iov_iter_advance() changes anything in the
shared structure, this scheme breaks. Let's just truncate and reexpand
the original iter as needed instead of playing games with copying iters
and keeping them in sync.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/iomap/direct-io.c | 31 ++++++++++++++++++-------------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 420c0c82f0ac..b75cd0b0609b 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -201,12 +201,12 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
 	unsigned int blkbits = blksize_bits(bdev_logical_block_size(iomap->bdev));
 	unsigned int fs_block_size = i_blocksize(inode), pad;
 	unsigned int align = iov_iter_alignment(dio->submit.iter);
-	struct iov_iter iter;
 	struct bio *bio;
 	bool need_zeroout = false;
 	bool use_fua = false;
 	int nr_pages, ret = 0;
 	size_t copied = 0;
+	size_t orig_count;
 
 	if ((pos | length | align) & ((1 << blkbits) - 1))
 		return -EINVAL;
@@ -236,15 +236,18 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
 	}
 
 	/*
-	 * Operate on a partial iter trimmed to the extent we were called for.
-	 * We'll update the iter in the dio once we're done with this extent.
+	 * Save the original count and trim the iter to just the extent we
+	 * are operating on right now.  The iter will be re-expanded once
+	 * we are done.
 	 */
-	iter = *dio->submit.iter;
-	iov_iter_truncate(&iter, length);
+	orig_count = iov_iter_count(dio->submit.iter);
+	iov_iter_truncate(dio->submit.iter, length);
 
-	nr_pages = iov_iter_npages(&iter, BIO_MAX_PAGES);
-	if (nr_pages <= 0)
-		return nr_pages;
+	nr_pages = iov_iter_npages(dio->submit.iter, BIO_MAX_PAGES);
+	if (nr_pages <= 0) {
+		ret = nr_pages;
+		goto out;
+	}
 
 	if (need_zeroout) {
 		/* zero out from the start of the block to the write offset */
@@ -257,7 +260,8 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
 		size_t n;
 		if (dio->error) {
 			iov_iter_revert(dio->submit.iter, copied);
-			return 0;
+			copied = ret = 0;
+			goto out;
 		}
 
 		bio = bio_alloc(GFP_KERNEL, nr_pages);
@@ -268,7 +272,7 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
 		bio->bi_private = dio;
 		bio->bi_end_io = iomap_dio_bio_end_io;
 
-		ret = bio_iov_iter_get_pages(bio, &iter);
+		ret = bio_iov_iter_get_pages(bio, dio->submit.iter);
 		if (unlikely(ret)) {
 			/*
 			 * We have to stop part way through an IO. We must fall
@@ -294,13 +298,11 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
 				bio_set_pages_dirty(bio);
 		}
 
-		iov_iter_advance(dio->submit.iter, n);
-
 		dio->size += n;
 		pos += n;
 		copied += n;
 
-		nr_pages = iov_iter_npages(&iter, BIO_MAX_PAGES);
+		nr_pages = iov_iter_npages(dio->submit.iter, BIO_MAX_PAGES);
 		iomap_dio_submit_bio(dio, iomap, bio);
 	} while (nr_pages);
 
@@ -318,6 +320,9 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
 		if (pad)
 			iomap_dio_zero(dio, iomap, pos, fs_block_size - pad);
 	}
+out:
+	/* Undo iter limitation to current extent */
+	iov_iter_reexpand(dio->submit.iter, orig_count - copied);
 	if (copied)
 		return copied;
 	return ret;
-- 
2.16.4

