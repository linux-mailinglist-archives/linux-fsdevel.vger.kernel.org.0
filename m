Return-Path: <linux-fsdevel+bounces-16699-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DA55C8A17F2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 16:55:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0583DB23F29
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 14:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0F3917C7B;
	Thu, 11 Apr 2024 14:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="azXEgjsi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE05D1758E;
	Thu, 11 Apr 2024 14:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712847241; cv=none; b=UZLz/p/iGNBGfc7WtlaZYdtIhVHUaGQEqpp/AyKAo+42VD63xGv47436lRtFhg3pZVm/vo+9BdecAAAc/z45+0r1cir1OzGf72kMwVuEcoy/bqZLiAa1Gou8xnIJiPR4M8c5q/MlOP1G4NJH/bchnGD2yskiuniH6dzsj3i8aPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712847241; c=relaxed/simple;
	bh=/lwURI1p3qUminbYVw0Ldfqo/aYY6MLL0egSmCMn7ks=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NFkp8y5h96SHM9Ta6+yyKOfQwoNOauLohcTCQRZYIoLMzjTa9vbn0ilkKO56QRBVrZexNMfITsEAjvHTrK+CGUBXb1cctpfXa1U4LQU/t/MI3AGpPy72dZ1bVOQuct63l8z9IjtAwS/7nbO+PW2vHvIrC8zSWsq3+eLHwyd6c1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=azXEgjsi; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=kH1h+8eIBeptEdKdQd0QY4wuE/Dkd/KFTe++Dq/YVP0=; b=azXEgjsizaLjeNj6DVj4FBNIfC
	HaqFarHOUvtCwNcf/juObK8CnNpdNBzpwxrQzY2cY3UVxnnoOYyBJ+OPd+MYi8B8jlrpnC1tN/NWk
	NDKQYNkWeg50TXDwL+g7u8P56fVMeBaIbrym9y6GQXp5qrnYzjk1oWm6xfouP2BBeVvt/G7d9ytfX
	KPiA5FRolAK4m6+vdfkmN9hcNsmwZEfNDnokd6/GJMhVn4e7Yz0hUGb0i6hQpXT5Q4YvlC+k6vTWv
	CHa0gAFlVJio8tPtw7X/R9ywas+PA7lxgQxFpri/OhWOXAEblWkEc/i7r1b70TmSLnHPZco72RXpq
	gyS75DkQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1ruvoB-00AYl1-2M;
	Thu, 11 Apr 2024 14:53:47 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	Yu Kuai <yukuai1@huaweicloud.com>,
	hch@lst.de,
	axboe@kernel.dk,
	linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	"yukuai (C)" <yukuai3@huawei.com>
Subject: [PATCH 08/11] block: move two helpers into bdev.c
Date: Thu, 11 Apr 2024 15:53:43 +0100
Message-Id: <20240411145346.2516848-8-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240411145346.2516848-1-viro@zeniv.linux.org.uk>
References: <20240411144930.GI2118490@ZenIV>
 <20240411145346.2516848-1-viro@zeniv.linux.org.uk>
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
---
 block/bdev.c           | 12 ++++++++++++
 include/linux/blkdev.h | 12 ++----------
 2 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index 39a2fe9f84dd..31384396fc31 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -1252,6 +1252,18 @@ void bdev_statx_dioalign(struct inode *inode, struct kstat *stat)
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
index 172c91879999..2c0d3a89002c 100644
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


