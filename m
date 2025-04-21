Return-Path: <linux-fsdevel+bounces-46831-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F41A95520
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 19:19:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00EC83B0FEC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 17:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A9691E3774;
	Mon, 21 Apr 2025 17:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g2tlHUyR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD7042A9E;
	Mon, 21 Apr 2025 17:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745255949; cv=none; b=jKNiBNiTMQ8Juiopd0BfBdT2h9oZtKpFq5msDUcDx7rXl/wyTQulrUaIKEIwnsbOqxwfufJl/Qa1t6Z0YsOmylToP1Hfw8dZO1dFvbK16SbIHlyOJK20kFixGCcOBeGCZnXI1cJXa5H/iJ3Kj7e4rgPOCsh6EPDO2dRh8V++CDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745255949; c=relaxed/simple;
	bh=+H6fFWWt2/LM4OHZdgzZEKwmbr40JTh8CZAIUJwoGKc=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nS8kQkNyUuOIlcdqpjm3ondhZtg+tSqYpvIvYd/v1otE0+QUcOfjv9Ye7JLLf2Q3opo/YmjYQXbgmGqm5U7pWswMWYn7S0TOEwBQD9bkUOlCmScw9XWp1dM4lgK/Rze5iLQ+Z8AdLr7GvxTtAMH8DzwLJXw3+52GGW03yugyXr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g2tlHUyR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4382CC4CEE4;
	Mon, 21 Apr 2025 17:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745255948;
	bh=+H6fFWWt2/LM4OHZdgzZEKwmbr40JTh8CZAIUJwoGKc=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=g2tlHUyR4qqHxf3rfBK4X1nWoAmfqe//dTOepUmG+ci1hw8WBAJEFnYoCMC016PgB
	 ICE1S6CPyJjhtZIECCBXFTRvQKYw1WpHYDSPDgkFAUtOLvmBcR0HswJVnpnlemmHr1
	 c8TmIs9gzZdvESeq3+ElFoe4Rsu/uY/vyt+l/2PffGdzEWJeVx5SRpaO84u+zBY43F
	 sycqG5Og9fzsfXArQWKGq4+3lKJJaeTfI9bcOXraVmGE76c1vCs3/iJYX8ABe3phBZ
	 JEqcmfcm+29KjXpnAkXK2ZZzZA/ivGaOXOrNBfJ2QP7PAZ+XpmPOVdtj4Th1eNpWJH
	 m7ixgbDDO1dPg==
Date: Mon, 21 Apr 2025 10:19:07 -0700
Subject: [PATCH 2/3] block: hoist block size validation code to a separate
 function
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, cem@kernel.org, axboe@kernel.dk
Cc: shinichiro.kawasaki@wdc.com, linux-mm@kvack.org, mcgrof@kernel.org,
 linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
 willy@infradead.org, hch@infradead.org, linux-block@vger.kernel.org
Message-ID: <174525589069.2138337.10477679176303850629.stgit@frogsfrogsfrogs>
In-Reply-To: <174525589013.2138337.16473045486118778580.stgit@frogsfrogsfrogs>
References: <174525589013.2138337.16473045486118778580.stgit@frogsfrogsfrogs>
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
---
 include/linux/blkdev.h |    1 +
 block/bdev.c           |   33 +++++++++++++++++++++++++++------
 2 files changed, 28 insertions(+), 6 deletions(-)


diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 294bbae415aa09..462e23a1e8b261 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1618,6 +1618,7 @@ static inline void bio_end_io_acct(struct bio *bio, unsigned long start_time)
 	return bio_end_io_acct_remapped(bio, start_time, bio->bi_bdev);
 }
 
+int bdev_validate_blocksize(struct block_device *bdev, int block_size);
 int set_blocksize(struct file *file, int size);
 
 int lookup_bdev(const char *pathname, dev_t *dev);
diff --git a/block/bdev.c b/block/bdev.c
index 24984ec13e7cb2..1588f96e4f0a35 100644
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


