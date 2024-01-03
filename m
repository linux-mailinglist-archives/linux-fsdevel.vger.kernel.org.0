Return-Path: <linux-fsdevel+bounces-7206-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0D1A822DCD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 13:58:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E41A283E51
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 12:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 221331C282;
	Wed,  3 Jan 2024 12:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UA1o5p8x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2931BDDA;
	Wed,  3 Jan 2024 12:56:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF4B9C433C9;
	Wed,  3 Jan 2024 12:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704286581;
	bh=7sfYV/mhryxnVrcvVKVN+lciO7NJYo09pExkMvO7T7A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=UA1o5p8xm8/2TDGhP9A4o6/e7mB+WudnvqmlO8Plu0HMjqnUb3PeYLfC99oiyFWmi
	 aOvFXWU5mbaJ9i6wSYGafKwovjNY9q9WCpeckh/1SDWdPMmGMbWJwBo/xkl2QvT4+0
	 Y6oQGn8v2M1ne3i2I6h6CCB/Vs/yLzFgpurSkohBf9sZSVY5br0zctI2ESMC/AaLTM
	 DuYo+CsTVUFiZXTpTYUDSneFwsUYU6f/L28dRkvJ26B6VmZ39KBEK332ghvq2CX34z
	 QPN7kGzj/StnL1cs+dwDw6UkV7b3bHPB0N6rOaGJcbr6jjuhDb99McTtPrPpdraJnb
	 tWcTzVlLLu5OQ==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 03 Jan 2024 13:55:23 +0100
Subject: [PATCH RFC 25/34] ocfs2: port block device access to file
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240103-vfs-bdev-file-v1-25-6c8ee55fb6ef@kernel.org>
References: <20240103-vfs-bdev-file-v1-0-6c8ee55fb6ef@kernel.org>
In-Reply-To: <20240103-vfs-bdev-file-v1-0-6c8ee55fb6ef@kernel.org>
To: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, 
 Jens Axboe <axboe@kernel.dk>
Cc: "Darrick J. Wong" <djwong@kernel.org>, linux-fsdevel@vger.kernel.org, 
 linux-block@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-4e032
X-Developer-Signature: v=1; a=openpgp-sha256; l=3722; i=brauner@kernel.org;
 h=from:subject:message-id; bh=7sfYV/mhryxnVrcvVKVN+lciO7NJYo09pExkMvO7T7A=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaROjbQ1jvQ+ukBpZnhtY4btv/d3eGbtf7P964cpl/Tq+
 S0l3NdP7ihlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZhISQXD/2qWiS7rzq58aTuX
 5yT/9OD6BsM+PzG1uugdEgdcT56OVWdkeL1HwtHo6A8bj5iiK6/5Sy49WfpqsvScf62VkYI67Vs
 ruAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/ocfs2/cluster/heartbeat.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/fs/ocfs2/cluster/heartbeat.c b/fs/ocfs2/cluster/heartbeat.c
index 4d7efefa98c5..e212961493d4 100644
--- a/fs/ocfs2/cluster/heartbeat.c
+++ b/fs/ocfs2/cluster/heartbeat.c
@@ -213,7 +213,7 @@ struct o2hb_region {
 	unsigned int		hr_num_pages;
 
 	struct page             **hr_slot_data;
-	struct bdev_handle	*hr_bdev_handle;
+	struct file		*hr_f_bdev;
 	struct o2hb_disk_slot	*hr_slots;
 
 	/* live node map of this region */
@@ -263,7 +263,7 @@ struct o2hb_region {
 
 static inline struct block_device *reg_bdev(struct o2hb_region *reg)
 {
-	return reg->hr_bdev_handle ? reg->hr_bdev_handle->bdev : NULL;
+	return reg->hr_f_bdev ? F_BDEV(reg->hr_f_bdev) : NULL;
 }
 
 struct o2hb_bio_wait_ctxt {
@@ -1509,8 +1509,8 @@ static void o2hb_region_release(struct config_item *item)
 		kfree(reg->hr_slot_data);
 	}
 
-	if (reg->hr_bdev_handle)
-		bdev_release(reg->hr_bdev_handle);
+	if (reg->hr_f_bdev)
+		fput(reg->hr_f_bdev);
 
 	kfree(reg->hr_slots);
 
@@ -1569,7 +1569,7 @@ static ssize_t o2hb_region_block_bytes_store(struct config_item *item,
 	unsigned long block_bytes;
 	unsigned int block_bits;
 
-	if (reg->hr_bdev_handle)
+	if (reg->hr_f_bdev)
 		return -EINVAL;
 
 	status = o2hb_read_block_input(reg, page, &block_bytes,
@@ -1598,7 +1598,7 @@ static ssize_t o2hb_region_start_block_store(struct config_item *item,
 	char *p = (char *)page;
 	ssize_t ret;
 
-	if (reg->hr_bdev_handle)
+	if (reg->hr_f_bdev)
 		return -EINVAL;
 
 	ret = kstrtoull(p, 0, &tmp);
@@ -1623,7 +1623,7 @@ static ssize_t o2hb_region_blocks_store(struct config_item *item,
 	unsigned long tmp;
 	char *p = (char *)page;
 
-	if (reg->hr_bdev_handle)
+	if (reg->hr_f_bdev)
 		return -EINVAL;
 
 	tmp = simple_strtoul(p, &p, 0);
@@ -1642,7 +1642,7 @@ static ssize_t o2hb_region_dev_show(struct config_item *item, char *page)
 {
 	unsigned int ret = 0;
 
-	if (to_o2hb_region(item)->hr_bdev_handle)
+	if (to_o2hb_region(item)->hr_f_bdev)
 		ret = sprintf(page, "%pg\n", reg_bdev(to_o2hb_region(item)));
 
 	return ret;
@@ -1753,7 +1753,7 @@ static int o2hb_populate_slot_data(struct o2hb_region *reg)
 }
 
 /*
- * this is acting as commit; we set up all of hr_bdev_handle and hr_task or
+ * this is acting as commit; we set up all of hr_f_bdev and hr_task or
  * nothing
  */
 static ssize_t o2hb_region_dev_store(struct config_item *item,
@@ -1769,7 +1769,7 @@ static ssize_t o2hb_region_dev_store(struct config_item *item,
 	ssize_t ret = -EINVAL;
 	int live_threshold;
 
-	if (reg->hr_bdev_handle)
+	if (reg->hr_f_bdev)
 		goto out;
 
 	/* We can't heartbeat without having had our node number
@@ -1795,11 +1795,11 @@ static ssize_t o2hb_region_dev_store(struct config_item *item,
 	if (!S_ISBLK(f.file->f_mapping->host->i_mode))
 		goto out2;
 
-	reg->hr_bdev_handle = bdev_open_by_dev(f.file->f_mapping->host->i_rdev,
+	reg->hr_f_bdev = bdev_file_open_by_dev(f.file->f_mapping->host->i_rdev,
 			BLK_OPEN_WRITE | BLK_OPEN_READ, NULL, NULL);
-	if (IS_ERR(reg->hr_bdev_handle)) {
-		ret = PTR_ERR(reg->hr_bdev_handle);
-		reg->hr_bdev_handle = NULL;
+	if (IS_ERR(reg->hr_f_bdev)) {
+		ret = PTR_ERR(reg->hr_f_bdev);
+		reg->hr_f_bdev = NULL;
 		goto out2;
 	}
 
@@ -1903,8 +1903,8 @@ static ssize_t o2hb_region_dev_store(struct config_item *item,
 
 out3:
 	if (ret < 0) {
-		bdev_release(reg->hr_bdev_handle);
-		reg->hr_bdev_handle = NULL;
+		fput(reg->hr_f_bdev);
+		reg->hr_f_bdev = NULL;
 	}
 out2:
 	fdput(f);

-- 
2.42.0


