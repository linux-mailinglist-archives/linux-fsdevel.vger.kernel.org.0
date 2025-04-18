Return-Path: <linux-fsdevel+bounces-46677-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E38BBA93A36
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Apr 2025 17:58:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89F4544814E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Apr 2025 15:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6100F2147F1;
	Fri, 18 Apr 2025 15:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p1OCrIpr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91CA2AE66;
	Fri, 18 Apr 2025 15:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744991885; cv=none; b=Rdoh4JFQv06k0ytrSnoPnWxHRqikXzqUBq/r4STfqHQPv0PL4uWIAuTGTT0idGUd9Ywiwu+qXQzG+G6YzIQjZ3nx3KT1NuS4WWI8WUdqf9sWdXrwPyFT3zz0YKMzVwL/EwEd1q2ZTRZoCTDLmCpMLdvz14GMMPBh+XFvqRjHr2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744991885; c=relaxed/simple;
	bh=V3YS3WTbPEFUUdpSo94OwF/4mnYhwt/NdwLCN+EsU50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YmGJ4v81/1STANrH+g2pJxLD+jL4G2R/DI/+kfQs8CSM6DGWc7XRS1xqr7vywzlu0naNGx5hy8QaUq38nKFfNRbECMy1awRTcpSSS51rQWUlE8NCUmtmtPml5bFeMJ7BtMXH+E7xGAlAU08fxC5tPwUXNiJ2K1SkiTGVeUaeItk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p1OCrIpr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C7EDC4CEE2;
	Fri, 18 Apr 2025 15:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744991885;
	bh=V3YS3WTbPEFUUdpSo94OwF/4mnYhwt/NdwLCN+EsU50=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p1OCrIprZnzDkTNuxMLGkaPmhnASOwP0nXd2ZoMJ3Zq6s7QpDdrWRB0Le8bSOv5t/
	 bRygayAeB1XUg5J1dqieuBh/aI+EpiywvCM4tJV3sFuCcsGMmwZJKPXfXdbCXXwvTg
	 pXUsTf/lJsfx0pHbGK4nCmNgkNSBSo0HuwS315xeRGrqPFQ8KWHUfMT9u9Dg1LLpvR
	 jHGkG/pDLl1psrIgz5tF7kq/Q6IQv6gVWvdgXRImaaThDyTOtRRUxVdL8yz6hjSnjF
	 qjVvDEef4Ca1k91qTD6+h0lsxGGEMzTATcGDzonCARXzUnM8t9wXIsst7QHp5oGDiX
	 bP1Sc4Iky1iXQ==
Date: Fri, 18 Apr 2025 08:58:04 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Carlos Maiolino <cem@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	linux-block <linux-block@vger.kernel.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	xfs <linux-xfs@vger.kernel.org>
Subject: [PATCH 2/2] xfs: stop using set_blocksize
Message-ID: <20250418155804.GS25675@frogsfrogsfrogs>
References: <20250418155458.GR25675@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250418155458.GR25675@frogsfrogsfrogs>

From: Darrick J. Wong <djwong@kernel.org>

XFS has its own buffer cache for metadata that uses submit_bio, which
means that it no longer uses the block device pagecache for anything.
Create a more lightweight helper that runs the blocksize checks and
flushes dirty data and use that instead.  No more truncating the
pagecache because why would XFS care?

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 include/linux/blkdev.h |    1 +
 block/bdev.c           |   33 +++++++++++++++++++++++++++------
 fs/xfs/xfs_buf.c       |   15 +++++++++++----
 3 files changed, 39 insertions(+), 10 deletions(-)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index f442639dfae224..df6df616740371 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1618,6 +1618,7 @@ static inline void bio_end_io_acct(struct bio *bio, unsigned long start_time)
 	return bio_end_io_acct_remapped(bio, start_time, bio->bi_bdev);
 }
 
+int bdev_validate_blocksize(struct block_device *bdev, int block_size);
 int set_blocksize(struct file *file, int size);
 
 int lookup_bdev(const char *pathname, dev_t *dev);
diff --git a/block/bdev.c b/block/bdev.c
index 1313ad256593c5..0196b62007d343 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -152,17 +152,38 @@ static void set_init_blocksize(struct block_device *bdev)
 				    get_order(bsize), get_order(bsize));
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
diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
index 8e7f1b324b3bea..0b4bd16cb568c8 100644
--- a/fs/xfs/xfs_buf.c
+++ b/fs/xfs/xfs_buf.c
@@ -1718,18 +1718,25 @@ xfs_setsize_buftarg(
 	struct xfs_buftarg	*btp,
 	unsigned int		sectorsize)
 {
+	int			error;
+
 	/* Set up metadata sector size info */
 	btp->bt_meta_sectorsize = sectorsize;
 	btp->bt_meta_sectormask = sectorsize - 1;
 
-	if (set_blocksize(btp->bt_bdev_file, sectorsize)) {
+	error = bdev_validate_blocksize(btp->bt_bdev, sectorsize);
+	if (error) {
 		xfs_warn(btp->bt_mount,
-			"Cannot set_blocksize to %u on device %pg",
-			sectorsize, btp->bt_bdev);
+			"Cannot use blocksize %u on device %pg, err %d",
+			sectorsize, btp->bt_bdev, error);
 		return -EINVAL;
 	}
 
-	return 0;
+	/*
+	 * Flush the block device pagecache so our bios see anything dirtied
+	 * before mount.
+	 */
+	return sync_blockdev(btp->bt_bdev);
 }
 
 int

