Return-Path: <linux-fsdevel+bounces-46427-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 988C0A890B6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 02:33:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A708017D42D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 00:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71269E552;
	Tue, 15 Apr 2025 00:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pZBq0Msh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4915182BD;
	Tue, 15 Apr 2025 00:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744677189; cv=none; b=LnSES1UrZS90ZYBZlsZi5ngqNyDDWCeYSPv6DDeMQzmQ04becH5M9Hg1CLr+L7dNfDbid5X2GKBlAJV6Q6EPIgfInm06mvPdtO7fK7uVnYKW0yXAV4odemKV5Q8Qu5ITWy0wqHkJZhG3tpbw04JkFtd3ZUrY/dZ86bcQZirK5s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744677189; c=relaxed/simple;
	bh=5Pahrhy8qFJY6lzVfKp6QObVcVFpNTvrdsxGF+Dh6uQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cLePsp49h9bklfr2EXQG2TwZGMTTV0k7rgR6rLMPwE/xVUweSsBOQZ4ffDftYyCO0o6jf9Mquukdw6iLpjOKCC4wULs+HigHRH8Zz00KxWYI5/4nmCu/OfWVGldc3mmJaULCe1BO7i7MjVGxVt8mh57384kVTNNAsONfKUIYpdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pZBq0Msh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7CF6C4CEEA;
	Tue, 15 Apr 2025 00:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744677189;
	bh=5Pahrhy8qFJY6lzVfKp6QObVcVFpNTvrdsxGF+Dh6uQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pZBq0MshnSFZNduirJiPwbcKTnE2HowWM/EX4hWHyY/BnVfdsHJ/faK2GsNKpW9cB
	 0DIgxg7ge8DhIxRlfNMFF/o9Wv1MO3D+Nx3cA3kgaZiMyrF4zzCPUxH69leM9bHBDR
	 a9j+tSuX0/k5egVi9qkmBVN/ozNUOEYubebDwtyGAiVMuFuG4l+10x7q4hSuuQllGD
	 PIM4Rcx/1PJSjezUsLG+lNzfMJn2Kna7QUgiqRa6CCSYao7NE44nKChPIU9GBshz4s
	 jiDRAWd8ilg6z7TDqPwhoB15HkLeuq8W6G18xgZGAAKEr1hqmcsO/3scUOB/CGoBs1
	 JnznE0juwnKeA==
Date: Mon, 14 Apr 2025 17:33:08 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Carlos Maiolino <cem@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, axboe@kernel.dk,
	Luis Chamberlain <mcgrof@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	linux-block <linux-block@vger.kernel.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	xfs <linux-xfs@vger.kernel.org>, Jack Vogel <jack.vogel@oracle.com>
Subject: [RF[CRAP] 2/2] xfs: stop using set_blocksize
Message-ID: <20250415003308.GE25675@frogsfrogsfrogs>
References: <20250415001405.GA25659@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250415001405.GA25659@frogsfrogsfrogs>

From: Darrick J. Wong <djwong@kernel.org>

XFS has its own buffer cache for metadata that uses submit_bio, which
means that it no longer uses the block device pagecache for anything.
Create a more lightweight helper that runs the blocksize checks and
flushes dirty data and use that instead.  No more truncating the
pagecache because why would XFS care? ;)

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 include/linux/blkdev.h |    1 +
 block/bdev.c           |   23 +++++++++++++++++++++++
 fs/xfs/xfs_buf.c       |    9 ++++++---
 3 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index f442639dfae224..ae83dd12351c2e 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1618,6 +1618,7 @@ static inline void bio_end_io_acct(struct bio *bio, unsigned long start_time)
 	return bio_end_io_acct_remapped(bio, start_time, bio->bi_bdev);
 }
 
+int bdev_use_blocksize(struct file *file, int size);
 int set_blocksize(struct file *file, int size);
 
 int lookup_bdev(const char *pathname, dev_t *dev);
diff --git a/block/bdev.c b/block/bdev.c
index 0cbdac46d98d86..201d61d743592e 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -152,6 +152,29 @@ static void set_init_blocksize(struct block_device *bdev)
 				    get_order(bsize), get_order(bsize));
 }
 
+/*
+ * For bdev filesystems that do not use buffer heads, check that this block
+ * size is acceptable and flush dirty pagecache to disk.
+ */
+int bdev_use_blocksize(struct file *file, int size)
+{
+	struct inode *inode = file->f_mapping->host;
+	struct block_device *bdev = I_BDEV(inode);
+
+	if (blk_validate_block_size(size))
+		return -EINVAL;
+
+	/* Size cannot be smaller than the size supported by the device */
+	if (size < bdev_logical_block_size(bdev))
+		return -EINVAL;
+
+	if (!file->private_data)
+		return -EINVAL;
+
+	return sync_blockdev(bdev);
+}
+EXPORT_SYMBOL_GPL(bdev_use_blocksize);
+
 int set_blocksize(struct file *file, int size)
 {
 	struct inode *inode = file->f_mapping->host;
diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
index 8e7f1b324b3bea..2c8531103c01bb 100644
--- a/fs/xfs/xfs_buf.c
+++ b/fs/xfs/xfs_buf.c
@@ -1718,14 +1718,17 @@ xfs_setsize_buftarg(
 	struct xfs_buftarg	*btp,
 	unsigned int		sectorsize)
 {
+	int			error;
+
 	/* Set up metadata sector size info */
 	btp->bt_meta_sectorsize = sectorsize;
 	btp->bt_meta_sectormask = sectorsize - 1;
 
-	if (set_blocksize(btp->bt_bdev_file, sectorsize)) {
+	error = bdev_use_blocksize(btp->bt_bdev_file, sectorsize);
+	if (error) {
 		xfs_warn(btp->bt_mount,
-			"Cannot set_blocksize to %u on device %pg",
-			sectorsize, btp->bt_bdev);
+			"Cannot use blocksize %u on device %pg, err %d",
+			sectorsize, btp->bt_bdev, error);
 		return -EINVAL;
 	}
 

