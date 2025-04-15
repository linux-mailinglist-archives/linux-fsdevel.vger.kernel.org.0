Return-Path: <linux-fsdevel+bounces-46426-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3AB6A8905E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 02:14:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 083E41899495
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 00:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA2BF5695;
	Tue, 15 Apr 2025 00:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AsQ7eLj0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A323849C;
	Tue, 15 Apr 2025 00:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744676047; cv=none; b=DdB8zUOutpAvFSktiMNXqmmYji5FgHvp3WxmJtx28IM2Ggob+PCHZPJYYGcQ8WaJx/M2DH+2urf5SeD+2ptZn1ARuUFZrhJnecD7R+X3yUlOzoeSAHHzESqtMFZxEunvXOjB/t47FpMr41wLRFeMfv88kypWhvrStKoMiaWRVqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744676047; c=relaxed/simple;
	bh=a6Lq/GiKmX1UHcnKSF/sNR0mGQolJhfULhsR14qULXM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=RIhklB7SJmhiCiafgfgSpG7Rslu1bBxODNtYNed1K26v9F9ZmdCfgDFsb51g84qXMUNl7g15PvTtVpqebqc7UZrFX97oCRxgpkK7OvhsTrIyq9QKxJk2DzRMZyORZr+k7i5zj2fIGo1KvMIZpeFx5p7Va1blrWJDWB6aZcEswTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AsQ7eLj0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 743E2C4CEE2;
	Tue, 15 Apr 2025 00:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744676046;
	bh=a6Lq/GiKmX1UHcnKSF/sNR0mGQolJhfULhsR14qULXM=;
	h=Date:From:To:Cc:Subject:From;
	b=AsQ7eLj0dGX4n529lXkXZUELeUdaJAAVnzNg2z9UUNhqbtjPwG176LPRevCPscRzl
	 q60Uz7pVssMqlKBM/x6XHVZln3yRJK6BAx+PyW6MWI4TgAuSJ8/VTX5OLIZvyVDSjc
	 1SM9RpvTSWPdhz2NesoW7BOWhmzFQz46uLIHTP58L3zlGRWEXra6rqeVUBI4aAKHK3
	 df7tyUOJRo2XVBW0adl++2ndYTZlSKSs2M6f6aiaAZjDMYk4cc19Bj4Eaq5XSKqxub
	 ALy1UdHQ5WvvQczH1tGp1hNhhEJ4v+0DMWD8Iq76jsoz0tHLNLR8uh3ZJTj+eWnr96
	 eBYvmddPJ+5mg==
Date: Mon, 14 Apr 2025 17:14:05 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: axboe@kernel.dk
Cc: Christoph Hellwig <hch@infradead.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	linux-block <linux-block@vger.kernel.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	xfs <linux-xfs@vger.kernel.org>, Jack Vogel <jack.vogel@oracle.com>
Subject: [RFC[RAP] 1/2] block: fix race between set_blocksize and read paths
Message-ID: <20250415001405.GA25659@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

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
---
 block/bdev.c      |   12 ++++++++++++
 block/blk-zoned.c |    5 ++++-
 block/fops.c      |    7 +++++++
 block/ioctl.c     |    6 ++++++
 4 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/block/bdev.c b/block/bdev.c
index 7b4e35a661b0c9..0cbdac46d98d86 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -169,11 +169,23 @@ int set_blocksize(struct file *file, int size)
 
 	/* Don't change the size if it is same as current */
 	if (inode->i_blkbits != blksize_bits(size)) {
+		/* Prevent concurrent IO operations */
+		inode_lock(inode);
+		filemap_invalidate_lock(inode->i_mapping);
+
+		/*
+		 * Flush and truncate the pagecache before we reconfigure the
+		 * mapping geometry because folio sizes are variable now.
+		 */
 		sync_blockdev(bdev);
+		kill_bdev(bdev);
+
 		inode->i_blkbits = blksize_bits(size);
 		mapping_set_folio_order_range(inode->i_mapping,
 				get_order(size), get_order(size));
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
index be9f1dbea9ce0a..f46ae08fac33dd 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -746,7 +746,9 @@ static ssize_t blkdev_write_iter(struct kiocb *iocb, struct iov_iter *from)
 			ret = direct_write_fallback(iocb, from, ret,
 					blkdev_buffered_write(iocb, from));
 	} else {
+		inode_lock_shared(bd_inode);
 		ret = blkdev_buffered_write(iocb, from);
+		inode_unlock_shared(bd_inode);
 	}
 
 	if (ret > 0)
@@ -757,6 +759,7 @@ static ssize_t blkdev_write_iter(struct kiocb *iocb, struct iov_iter *from)
 
 static ssize_t blkdev_read_iter(struct kiocb *iocb, struct iov_iter *to)
 {
+	struct inode *bd_inode = bdev_file_inode(iocb->ki_filp);
 	struct block_device *bdev = I_BDEV(iocb->ki_filp->f_mapping->host);
 	loff_t size = bdev_nr_bytes(bdev);
 	loff_t pos = iocb->ki_pos;
@@ -793,7 +796,9 @@ static ssize_t blkdev_read_iter(struct kiocb *iocb, struct iov_iter *to)
 			goto reexpand;
 	}
 
+	inode_lock_shared(bd_inode);
 	ret = filemap_read(iocb, to, ret);
+	inode_unlock_shared(bd_inode);
 
 reexpand:
 	if (unlikely(shorted))
@@ -836,6 +841,7 @@ static long blkdev_fallocate(struct file *file, int mode, loff_t start,
 	if ((start | len) & (bdev_logical_block_size(bdev) - 1))
 		return -EINVAL;
 
+	inode_lock(inode);
 	filemap_invalidate_lock(inode->i_mapping);
 
 	/*
@@ -868,6 +874,7 @@ static long blkdev_fallocate(struct file *file, int mode, loff_t start,
 
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
 

