Return-Path: <linux-fsdevel+bounces-47126-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2B2DA998FD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 21:54:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CC591B8259B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 19:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 846F0269AF9;
	Wed, 23 Apr 2025 19:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dBM8VD99"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE592701AB;
	Wed, 23 Apr 2025 19:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745438039; cv=none; b=Eino988y0ZCXI+a7Dqil45JH95tEfsZMGqS5X0qFGQcEQuP88bR6zCSeYOsswYve22WE8uOcWfYUBSDe6FkDyqPQG7kztU5XeJOy3mgfH+z8GfSCpV1dX2UeFzfm3abAmsUCDBEmAKnxOeobI3VTeU7Yz0x1I+TK+f2HecOPlGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745438039; c=relaxed/simple;
	bh=kuqE4f4Z0MbKUgyPy5zGF7TbmVO8nc/e4Do1rZJxExU=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KFZzIrI7/ne6sqtmN4HfL32Tq9UZ30QmdWfv/3Mi/Z8qwSxTpKSEqDuHGuDZXb+M/e0EOUrIRcb1UoHqaNlKkWz6EKuiuXQKSc9mjG8aDC0PkiKlcjzJN4Xp4f9BFKFrfykzz7jGzTq5QtnRSxiyfl2YAkfuAF3DXM5Obw64u/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dBM8VD99; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49015C4CEE8;
	Wed, 23 Apr 2025 19:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745438038;
	bh=kuqE4f4Z0MbKUgyPy5zGF7TbmVO8nc/e4Do1rZJxExU=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=dBM8VD99sSHeazoumHn8h5SnjxSOoMcTwBflj83LxH8GJvw2tLPdeHOWDNgSTRWfr
	 xaJdmaU0fdpRoH6C+ihC5Em7k8Ylr6FZesm/TicN97kiq1JFxSsvQnb3aiVirNBfTW
	 ehQ++TN2w2sylygyb1tkkE1wp7k2QyzmVYqYphG2jcOgx9LF2+ybzSpeZwm1mxFeNF
	 EyIiDv+KBs9jgP/U3nfRCjC6qjT9eKJn4JfQpp/wIG+KzMm8WjaiMoN5rhuIThjsFy
	 IWd5w6PgZUZHYGTjOzd7UlVHS91pSRPI36jSAzkDa2WVPlcZVRxPNian6j79BEj6LU
	 6EmZ8Q538eufQ==
Date: Wed, 23 Apr 2025 12:53:57 -0700
Subject: [PATCH 2/3] block: hoist block size validation code to a separate
 function
From: "Darrick J. Wong" <djwong@kernel.org>
To: cem@kernel.org, djwong@kernel.org, axboe@kernel.dk
Cc: hch@lst.de, mcgrof@kernel.org, hch@infradead.org, willy@infradead.org,
 linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 shinichiro.kawasaki@wdc.com, linux-block@vger.kernel.org, mcgrof@kernel.org
Message-ID: <174543795720.4139148.840349813093799165.stgit@frogsfrogsfrogs>
In-Reply-To: <174543795664.4139148.8846677768151191269.stgit@frogsfrogsfrogs>
References: <174543795664.4139148.8846677768151191269.stgit@frogsfrogsfrogs>
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
Reviewed-by: Christoph Hellwig <hch@lst.de>
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


