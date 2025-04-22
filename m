Return-Path: <linux-fsdevel+bounces-46864-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C642A95A5D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 03:18:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D47313B6387
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 01:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D723B17A2F6;
	Tue, 22 Apr 2025 01:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PwFF08T5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359333D6A;
	Tue, 22 Apr 2025 01:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745284715; cv=none; b=UZRjOJzlfgfF9sgUdJ2DCtuH5leQLGhhkYV62GOaxW8Yt79NBrTQyavoDPAehslLlaKWLgsgu7E1DuIkfU0baO9pteKEhncz7t4g2vGFgHd4eGAm8ze5mN9iOa6KZPBPJg7G2OLx62UKz7dl6o5t4P+Y6jXbg3RQNWdepGfDGfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745284715; c=relaxed/simple;
	bh=5NknV69CRKa2eCarAkZK4paPoG1lYJYs8AdoP6RkhNU=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rZx2++tAZdG/nDHx6X3dMwuyxdu72E1Z76vEj9BhFR1CPkw0qk1YuAS1Wia0VU2FvoAoFPt/E/Bo1iTO2Hs/QCzFoWQRwrhPOLRCrvJMAomZv9pRgUcRwYbRAaYlUk3h4tVdJPvXPhyv3WT88p8yrKM4CJtJTQTEP+9aD3sygrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PwFF08T5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A070BC4CEE4;
	Tue, 22 Apr 2025 01:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745284714;
	bh=5NknV69CRKa2eCarAkZK4paPoG1lYJYs8AdoP6RkhNU=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=PwFF08T5s+ZsmIJbpqXg+rPnp+BKHPEslisJuRo+s0k3r/yfma9DIh7Vc0TyiEJjJ
	 fAArrvfqvxOA99JLHpeAt5OUuCvW1puhGUQXU8ufc8QW0Qce5JH7hXTorE21Zrn04o
	 Ah3VOE32fj+piHR6zGzi/0DDCk1c8JwZCeuIjEVh7tAXCiAGtyVtbQrRIgCZDn/tjZ
	 TyFm7d7L6xIzdWtdArRKPlBZz53TBEqYznhoF1nUVFlcj2kMvY9h3cWng9eBfB0Puv
	 WZc6Z+NPx0bPoL9f8a/ZnYOfSDJxwBKs4VuIipiRn6zKc1rjao7AdAxC6JtiJYEymA
	 QguJmEZn9zUyQ==
Date: Mon, 21 Apr 2025 18:18:34 -0700
Subject: [PATCH 1/3] block: fix race between set_blocksize and read paths
From: "Darrick J. Wong" <djwong@kernel.org>
To: cem@kernel.org, axboe@kernel.dk, djwong@kernel.org
Cc: hch@lst.de, mcgrof@kernel.org, linux-fsdevel@vger.kernel.org,
 mcgrof@kernel.org, linux-block@vger.kernel.org, shinichiro.kawasaki@wdc.com,
 linux-xfs@vger.kernel.org, hch@infradead.org, willy@infradead.org
Message-ID: <174528466921.2551621.8887101746798593171.stgit@frogsfrogsfrogs>
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

With the new large sector size support, it's now the case that
set_blocksize can change i_blksize and the folio order in a manner that
conflicts with a concurrent reader and causes a kernel crash.

Specifically, let's say that udev-worker calls libblkid to detect the
labels on a block device.  The read call can create an order-0 folio to
read the first 4096 bytes from the disk.  But then udev is preempted.

Next, someone tries to mount an 8k-sectorsize filesystem from the same
block device.  The filesystem calls set_blksize, which sets i_blksize to
8192 and the minimum folio order to 1.

Now udev resumes, still holding the order-0 folio it allocated.  It then
tries to schedule a read bio and do_mpage_readahead tries to create
bufferheads for the folio.  Unfortunately, blocks_per_folio == 0 because
the page size is 4096 but the blocksize is 8192 so no bufferheads are
attached and the bh walk never sets bdev.  We then submit the bio with a
NULL block device and crash.

Therefore, truncate the page cache after flushing but before updating
i_blksize.  However, that's not enough -- we also need to lock out file
IO and page faults during the update.  Take both the i_rwsem and the
invalidate_lock in exclusive mode for invalidations, and in shared mode
for read/write operations.

I don't know if this is the correct fix, but xfs/259 found it.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
---
 block/bdev.c      |   17 +++++++++++++++++
 block/blk-zoned.c |    5 ++++-
 block/fops.c      |   16 ++++++++++++++++
 block/ioctl.c     |    6 ++++++
 4 files changed, 43 insertions(+), 1 deletion(-)


diff --git a/block/bdev.c b/block/bdev.c
index 6a34179192c913..04808632f8dab4 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -169,10 +169,27 @@ int set_blocksize(struct file *file, int size)
 
 	/* Don't change the size if it is same as current */
 	if (inode->i_blkbits != blksize_bits(size)) {
+		/*
+		 * Flush and truncate the pagecache before we reconfigure the
+		 * mapping geometry because folio sizes are variable now.  If a
+		 * reader has already allocated a folio whose size is smaller
+		 * than the new min_order but invokes readahead after the new
+		 * min_order becomes visible, readahead will think there are
+		 * "zero" blocks per folio and crash.  Take the inode and
+		 * invalidation locks to avoid racing with
+		 * read/write/fallocate.
+		 */
+		inode_lock(inode);
+		filemap_invalidate_lock(inode->i_mapping);
+
 		sync_blockdev(bdev);
+		kill_bdev(bdev);
+
 		inode->i_blkbits = blksize_bits(size);
 		mapping_set_folio_min_order(inode->i_mapping, get_order(size));
 		kill_bdev(bdev);
+		filemap_invalidate_unlock(inode->i_mapping);
+		inode_unlock(inode);
 	}
 	return 0;
 }
diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 0c77244a35c92e..8f15d1aa6eb89a 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -343,6 +343,7 @@ int blkdev_zone_mgmt_ioctl(struct block_device *bdev, blk_mode_t mode,
 		op = REQ_OP_ZONE_RESET;
 
 		/* Invalidate the page cache, including dirty pages. */
+		inode_lock(bdev->bd_mapping->host);
 		filemap_invalidate_lock(bdev->bd_mapping);
 		ret = blkdev_truncate_zone_range(bdev, mode, &zrange);
 		if (ret)
@@ -364,8 +365,10 @@ int blkdev_zone_mgmt_ioctl(struct block_device *bdev, blk_mode_t mode,
 	ret = blkdev_zone_mgmt(bdev, op, zrange.sector, zrange.nr_sectors);
 
 fail:
-	if (cmd == BLKRESETZONE)
+	if (cmd == BLKRESETZONE) {
 		filemap_invalidate_unlock(bdev->bd_mapping);
+		inode_unlock(bdev->bd_mapping->host);
+	}
 
 	return ret;
 }
diff --git a/block/fops.c b/block/fops.c
index be9f1dbea9ce0a..e221fdcaa8aaf8 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -746,7 +746,14 @@ static ssize_t blkdev_write_iter(struct kiocb *iocb, struct iov_iter *from)
 			ret = direct_write_fallback(iocb, from, ret,
 					blkdev_buffered_write(iocb, from));
 	} else {
+		/*
+		 * Take i_rwsem and invalidate_lock to avoid racing with
+		 * set_blocksize changing i_blkbits/folio order and punching
+		 * out the pagecache.
+		 */
+		inode_lock_shared(bd_inode);
 		ret = blkdev_buffered_write(iocb, from);
+		inode_unlock_shared(bd_inode);
 	}
 
 	if (ret > 0)
@@ -757,6 +764,7 @@ static ssize_t blkdev_write_iter(struct kiocb *iocb, struct iov_iter *from)
 
 static ssize_t blkdev_read_iter(struct kiocb *iocb, struct iov_iter *to)
 {
+	struct inode *bd_inode = bdev_file_inode(iocb->ki_filp);
 	struct block_device *bdev = I_BDEV(iocb->ki_filp->f_mapping->host);
 	loff_t size = bdev_nr_bytes(bdev);
 	loff_t pos = iocb->ki_pos;
@@ -793,7 +801,13 @@ static ssize_t blkdev_read_iter(struct kiocb *iocb, struct iov_iter *to)
 			goto reexpand;
 	}
 
+	/*
+	 * Take i_rwsem and invalidate_lock to avoid racing with set_blocksize
+	 * changing i_blkbits/folio order and punching out the pagecache.
+	 */
+	inode_lock_shared(bd_inode);
 	ret = filemap_read(iocb, to, ret);
+	inode_unlock_shared(bd_inode);
 
 reexpand:
 	if (unlikely(shorted))
@@ -836,6 +850,7 @@ static long blkdev_fallocate(struct file *file, int mode, loff_t start,
 	if ((start | len) & (bdev_logical_block_size(bdev) - 1))
 		return -EINVAL;
 
+	inode_lock(inode);
 	filemap_invalidate_lock(inode->i_mapping);
 
 	/*
@@ -868,6 +883,7 @@ static long blkdev_fallocate(struct file *file, int mode, loff_t start,
 
  fail:
 	filemap_invalidate_unlock(inode->i_mapping);
+	inode_unlock(inode);
 	return error;
 }
 
diff --git a/block/ioctl.c b/block/ioctl.c
index faa40f383e2736..e472cc1030c60c 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -142,6 +142,7 @@ static int blk_ioctl_discard(struct block_device *bdev, blk_mode_t mode,
 	if (err)
 		return err;
 
+	inode_lock(bdev->bd_mapping->host);
 	filemap_invalidate_lock(bdev->bd_mapping);
 	err = truncate_bdev_range(bdev, mode, start, start + len - 1);
 	if (err)
@@ -174,6 +175,7 @@ static int blk_ioctl_discard(struct block_device *bdev, blk_mode_t mode,
 	blk_finish_plug(&plug);
 fail:
 	filemap_invalidate_unlock(bdev->bd_mapping);
+	inode_unlock(bdev->bd_mapping->host);
 	return err;
 }
 
@@ -199,12 +201,14 @@ static int blk_ioctl_secure_erase(struct block_device *bdev, blk_mode_t mode,
 	    end > bdev_nr_bytes(bdev))
 		return -EINVAL;
 
+	inode_lock(bdev->bd_mapping->host);
 	filemap_invalidate_lock(bdev->bd_mapping);
 	err = truncate_bdev_range(bdev, mode, start, end - 1);
 	if (!err)
 		err = blkdev_issue_secure_erase(bdev, start >> 9, len >> 9,
 						GFP_KERNEL);
 	filemap_invalidate_unlock(bdev->bd_mapping);
+	inode_unlock(bdev->bd_mapping->host);
 	return err;
 }
 
@@ -236,6 +240,7 @@ static int blk_ioctl_zeroout(struct block_device *bdev, blk_mode_t mode,
 		return -EINVAL;
 
 	/* Invalidate the page cache, including dirty pages */
+	inode_lock(bdev->bd_mapping->host);
 	filemap_invalidate_lock(bdev->bd_mapping);
 	err = truncate_bdev_range(bdev, mode, start, end);
 	if (err)
@@ -246,6 +251,7 @@ static int blk_ioctl_zeroout(struct block_device *bdev, blk_mode_t mode,
 
 fail:
 	filemap_invalidate_unlock(bdev->bd_mapping);
+	inode_unlock(bdev->bd_mapping->host);
 	return err;
 }
 


