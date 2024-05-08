Return-Path: <linux-fsdevel+bounces-19010-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B2B28BF674
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 08:43:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82F17B21F7D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 06:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D3C526291;
	Wed,  8 May 2024 06:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="TrvnGpqv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09DF9225D9
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 May 2024 06:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715150585; cv=none; b=bRKrJE+iTmQAG5k+aPeKDBlcNIw3fjHo0jZzVT0o6S3K2Q2VYvUiliMlW1HqAsNx18bPPpDsPFXhlIw5P2iXcHKcHrZk0EkAaw/YfI9RjjhJHW4jF4MPCMsYA77J+VtPHd8nWE7HJ3iFyJf9xFQvEFzU2yxbaHQj4jFd/Kk5YLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715150585; c=relaxed/simple;
	bh=7CXhcn6v3eRyqRNxQHV+jKyrjhNAmPq6RQEebi+AY7A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EWBfSu2fkZOqZ9W9jimkSHQ0DW2+QuGJBU9Q6jEWhdaNm9yneiuQ6mURQAQtjvpxHTM8Pln+eJ6PI9NiSTXPMnky+s036AeKgASRRWV7pTK3H9doXq2Pnso+qP+WUkCd1ueXEZoNLTx7nkoxVd/DKpsZBx9pZ6lWc5p8zrAXI+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=TrvnGpqv; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=unLU6pu3cZKcxS6z/DPlTL3Ib06ii51m5b67kS8y7AM=; b=TrvnGpqvl3n4cQH3A4FXIPsh8u
	RbyfH9bPGWhUY3RVokdu2b2LpWcadGxxwt71PyiE6un3DF9/+bxJ0owbIu/TTgWUSgIuyuSHlrMYs
	lX2jDIXWtD80MFTjr3auH9wol7DLjy331u6JWQnms0DNc1JGXfGgX6kpv0njc6dx3oCYsqxBj2lL1
	WNBRG3z5sSW+aHgifAdkWxcZQ13SpE8UWAnmAZgeQ//mTncPfiJsbAwURoXQRUUYsOl3bRV477sLI
	Qdi/otASS7OyKXeAIZpTP26EB5egyQvJz2ykZKMH1jHqCPtzLorDFZJ579LEooTtR/pFHtk/PNJfw
	sWsTsDPw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1s4b14-00FvpS-1b;
	Wed, 08 May 2024 06:43:02 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: axboe@kernel.dk,
	brauner@kernel.org,
	hch@lst.de
Subject: [PATCHES part 1 6/7] block: move two helpers into bdev.c
Date: Wed,  8 May 2024 07:43:00 +0100
Message-Id: <20240508064301.3797191-6-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240508064301.3797191-1-viro@zeniv.linux.org.uk>
References: <20240508063522.GO2118490@ZenIV>
 <20240508064301.3797191-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

From: Yu Kuai <yukuai3@huawei.com>

disk_live() and block_size() access bd_inode directly, prepare to remove
the field bd_inode from block_device, and only access bd_inode in block
layer.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Link: https://lore.kernel.org/r/20240411145346.2516848-8-viro@zeniv.linux.org.uk
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 block/bdev.c           | 12 ++++++++++++
 include/linux/blkdev.h | 12 ++----------
 2 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index a89bce368b64..536233ac3e99 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -1257,6 +1257,18 @@ void bdev_statx_dioalign(struct inode *inode, struct kstat *stat)
 	blkdev_put_no_open(bdev);
 }
 
+bool disk_live(struct gendisk *disk)
+{
+	return !inode_unhashed(disk->part0->bd_inode);
+}
+EXPORT_SYMBOL_GPL(disk_live);
+
+unsigned int block_size(struct block_device *bdev)
+{
+	return 1 << bdev->bd_inode->i_blkbits;
+}
+EXPORT_SYMBOL_GPL(block_size);
+
 static int __init setup_bdev_allow_write_mounted(char *str)
 {
 	if (kstrtobool(str, &bdev_allow_write_mounted))
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 20c749b2ebc2..99ac98ed9548 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -211,11 +211,6 @@ struct gendisk {
 	struct blk_independent_access_ranges *ia_ranges;
 };
 
-static inline bool disk_live(struct gendisk *disk)
-{
-	return !inode_unhashed(disk->part0->bd_inode);
-}
-
 /**
  * disk_openers - returns how many openers are there for a disk
  * @disk: disk to check
@@ -1364,11 +1359,6 @@ static inline unsigned int blksize_bits(unsigned int size)
 	return order_base_2(size >> SECTOR_SHIFT) + SECTOR_SHIFT;
 }
 
-static inline unsigned int block_size(struct block_device *bdev)
-{
-	return 1 << bdev->bd_inode->i_blkbits;
-}
-
 int kblockd_schedule_work(struct work_struct *work);
 int kblockd_mod_delayed_work_on(int cpu, struct delayed_work *dwork, unsigned long delay);
 
@@ -1536,6 +1526,8 @@ void blkdev_put_no_open(struct block_device *bdev);
 
 struct block_device *I_BDEV(struct inode *inode);
 struct block_device *file_bdev(struct file *bdev_file);
+bool disk_live(struct gendisk *disk);
+unsigned int block_size(struct block_device *bdev);
 
 #ifdef CONFIG_BLOCK
 void invalidate_bdev(struct block_device *bdev);
-- 
2.39.2


