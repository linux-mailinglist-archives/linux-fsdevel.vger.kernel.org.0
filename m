Return-Path: <linux-fsdevel+bounces-46865-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F21EA95A60
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 03:18:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CD9D1705C7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 01:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89926166F1A;
	Tue, 22 Apr 2025 01:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gwaZZr3c"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB1E33F6;
	Tue, 22 Apr 2025 01:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745284731; cv=none; b=jRpzXvRohoiHJ3XFq7AzprxWMsv2RQjVH8LDEqQ/ty2vUVvqp/t7mz9tjX10zTZDw4v/D/JhsT+/ZgIJD2uP9XnWaaAYvZypjhqwucVEweZxEM025p/lP1+qB5PwsrMPCseHNj5N8pSRBeK9em6LkL1TyAg6IroQeTnyn+nD0tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745284731; c=relaxed/simple;
	bh=Rakc4kz9TGcIkReAzLdYtEghvFTsJJayofNJz0KqWcc=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QqryxC1zGfOZGkKIf3KvHsjMZsy+PGmz9RJ6DqlaaDjdgyRGixZqPaiMhN9IQpK1P08y1U31pfJhYd0etu56mywhKMpbNvyTi9rQ+g8gWnbNEKGGWXf/KlMaD7jMeCvl9z20ZLTbMeIJ1dgDFisRmbhu1y96KvB/k5tdn+UPUzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gwaZZr3c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 484B8C4CEE4;
	Tue, 22 Apr 2025 01:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745284730;
	bh=Rakc4kz9TGcIkReAzLdYtEghvFTsJJayofNJz0KqWcc=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=gwaZZr3cvAW47oK6VZjI+u1+XsNXWKYA0ioW+l64t2PPUnfIOObGbDChmdS16806F
	 c44VMD36w7v/2p+PDTEfmj3mxrzyytuAA7G6SbJmaXobBqj7dajd8spbdiykUn4ech
	 N0ceEu3rkDHuUKy8EwP4b3zN3I5VWZrJNmMKZwy/DWi/aKFMkTppJmRJw5Ak3zKW40
	 1cHz9pq3178nvhx68P4DxFVbYqRCU03XLqRkTS7tXpYDYPXgWnNeuW4qxXejS4gjpX
	 Z4W36t6Ckmz76F+wJZvlTV1wilkzWxs/upxBSxdBjoE9W2ER7tkLz9EPK613vqvven
	 Xv5Jdd9oKabFA==
Date: Mon, 21 Apr 2025 18:18:49 -0700
Subject: [PATCH 2/3] block: hoist block size validation code to a separate
 function
From: "Darrick J. Wong" <djwong@kernel.org>
To: cem@kernel.org, axboe@kernel.dk, djwong@kernel.org
Cc: mcgrof@kernel.org, linux-fsdevel@vger.kernel.org, mcgrof@kernel.org,
 linux-block@vger.kernel.org, shinichiro.kawasaki@wdc.com,
 linux-xfs@vger.kernel.org, hch@infradead.org, willy@infradead.org
Message-ID: <174528466942.2551621.2138548156826449549.stgit@frogsfrogsfrogs>
In-Reply-To: <174528466886.2551621.12802195876907852208.stgit@frogsfrogsfrogs>
References: <174528466886.2551621.12802195876907852208.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Hoist the block size validation code to bdev_validate_blocksize so that
we can call it from filesystems that don't care about the bdev pagecache
manipulations of set_blocksize.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
---
 include/linux/blkdev.h |    1 +
 block/bdev.c           |   33 +++++++++++++++++++++++++++------
 2 files changed, 28 insertions(+), 6 deletions(-)


diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 678dc38442bfdd..f704d7ae72cfa3 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1614,6 +1614,7 @@ static inline void bio_end_io_acct(struct bio *bio, unsigned long start_time)
 	return bio_end_io_acct_remapped(bio, start_time, bio->bi_bdev);
 }
 
+int bdev_validate_blocksize(struct block_device *bdev, int block_size);
 int set_blocksize(struct file *file, int size);
 
 int lookup_bdev(const char *pathname, dev_t *dev);
diff --git a/block/bdev.c b/block/bdev.c
index 04808632f8dab4..83da12349c689d 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -152,17 +152,38 @@ static void set_init_blocksize(struct block_device *bdev)
 				    get_order(bsize));
 }
 
+/**
+ * bdev_validate_blocksize - check that this block size is acceptable
+ * @bdev:	blockdevice to check
+ * @block_size:	block size to check
+ *
+ * For block device users that do not use buffer heads or the block device
+ * page cache, make sure that this block size can be used with the device.
+ *
+ * Return: On success zero is returned, negative error code on failure.
+ */
+int bdev_validate_blocksize(struct block_device *bdev, int block_size)
+{
+	if (blk_validate_block_size(block_size))
+		return -EINVAL;
+
+	/* Size cannot be smaller than the size supported by the device */
+	if (block_size < bdev_logical_block_size(bdev))
+		return -EINVAL;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(bdev_validate_blocksize);
+
 int set_blocksize(struct file *file, int size)
 {
 	struct inode *inode = file->f_mapping->host;
 	struct block_device *bdev = I_BDEV(inode);
+	int ret;
 
-	if (blk_validate_block_size(size))
-		return -EINVAL;
-
-	/* Size cannot be smaller than the size supported by the device */
-	if (size < bdev_logical_block_size(bdev))
-		return -EINVAL;
+	ret = bdev_validate_blocksize(bdev, size);
+	if (ret)
+		return ret;
 
 	if (!file->private_data)
 		return -EINVAL;


