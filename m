Return-Path: <linux-fsdevel+bounces-8561-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 161D0839008
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 14:31:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBCB329313E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 13:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A977560B8C;
	Tue, 23 Jan 2024 13:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kpEYDYxu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1102F5F873;
	Tue, 23 Jan 2024 13:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706016458; cv=none; b=chSss9UYhGOIFPLXrbiqfUkSuxKXpLn0MkA0SCZrq+G56O/oP1jSQ8ep/exXRBW4h4eLIsqfI2Z6stvKvCiXfBLKQC9S7KZrot8aZ8d/KZYfMZ6q20yAIxJ9gXY1MwVDHkr+pkQ1Qck+4Udco5mN9g+Tj7nGA97eCeU8x90SFAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706016458; c=relaxed/simple;
	bh=/Lzq2WyJ5jXwE7poXUCsLonnk1Fw0LCSQ2psJQf2w9w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IGe0BmNhz7s+y+JZ6+nG5w5eg6GyLcUvCF97jdanIvY3nJ3oz56MvQHBXg+mMDxmucXyM69gCBzfuKeXK+vDW7OVhl1VI/7ubTmBoQUlmsgr3cg5pZ0syvHch21rHeY87L+QncFKfDD67rGpq3iYs3dPR6EIEWC43Phi3x6rRRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kpEYDYxu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B63DAC4166C;
	Tue, 23 Jan 2024 13:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706016457;
	bh=/Lzq2WyJ5jXwE7poXUCsLonnk1Fw0LCSQ2psJQf2w9w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=kpEYDYxuRLVLpZj8SQ/g5YVCO6wdAUggc/O0Z14UBYFA63LgVFzhtUZmc/EfTYF8Y
	 BRua1bRa0KtPEtA+KFZERRUF7H+Aval8fM7Oq62vCXKxiny+2MFfc2KnROlnC25DGH
	 QbU6XormD6TlI52SFwIS3Os6Mnuwa885yh5YJzw0itd8wPzJXXgz+F9TsCZoV6rP9G
	 X1sRsdOXRVg3fd58Sf4rdQzEV4/e3pIK7NbUPzxdxtmW0gFE0SUFgXOVN5r/YiJivk
	 lfioYPdODMnpWVKLMybb7DBwxiEMr7DI3UoUA5cHaXTrFrQ+vI4z5X5GvY4XlFFVKQ
	 JbKtLiw022csg==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 23 Jan 2024 14:26:33 +0100
Subject: [PATCH v2 16/34] s390: port block device access to file
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240123-vfs-bdev-file-v2-16-adbd023e19cc@kernel.org>
References: <20240123-vfs-bdev-file-v2-0-adbd023e19cc@kernel.org>
In-Reply-To: <20240123-vfs-bdev-file-v2-0-adbd023e19cc@kernel.org>
To: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, 
 Jens Axboe <axboe@kernel.dk>
Cc: "Darrick J. Wong" <djwong@kernel.org>, linux-fsdevel@vger.kernel.org, 
 linux-block@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-4e032
X-Developer-Signature: v=1; a=openpgp-sha256; l=5907; i=brauner@kernel.org;
 h=from:subject:message-id; bh=/Lzq2WyJ5jXwE7poXUCsLonnk1Fw0LCSQ2psJQf2w9w=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSu3zf/uUr+6Q0/7ZpXTDnr++HfrMmZ9htD7Fa3JM3tu
 +uns85iZUcpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBEWk0ZGXYbr105bS7rEfn0
 T+K35hS6rD0RLiOtkH+kb9NyAdlnM4MZGTb3Jbce+MPSMDlMwEWa/6C6cvuXC4WLHPYUtirEik2
 04QEA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 drivers/s390/block/dasd.c       | 10 +++++-----
 drivers/s390/block/dasd_genhd.c | 36 ++++++++++++++++++------------------
 drivers/s390/block/dasd_int.h   |  2 +-
 drivers/s390/block/dasd_ioctl.c |  2 +-
 4 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
index 7327e81352e9..c833a7c7d7b2 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -412,7 +412,7 @@ dasd_state_ready_to_online(struct dasd_device * device)
 					KOBJ_CHANGE);
 			return 0;
 		}
-		disk_uevent(device->block->bdev_handle->bdev->bd_disk,
+		disk_uevent(file_bdev(device->block->bdev_file)->bd_disk,
 			    KOBJ_CHANGE);
 	}
 	return 0;
@@ -433,7 +433,7 @@ static int dasd_state_online_to_ready(struct dasd_device *device)
 
 	device->state = DASD_STATE_READY;
 	if (device->block && !(device->features & DASD_FEATURE_USERAW))
-		disk_uevent(device->block->bdev_handle->bdev->bd_disk,
+		disk_uevent(file_bdev(device->block->bdev_file)->bd_disk,
 			    KOBJ_CHANGE);
 	return 0;
 }
@@ -3588,7 +3588,7 @@ int dasd_generic_set_offline(struct ccw_device *cdev)
 	 * in the other openers.
 	 */
 	if (device->block) {
-		max_count = device->block->bdev_handle ? 0 : -1;
+		max_count = device->block->bdev_file ? 0 : -1;
 		open_count = atomic_read(&device->block->open_count);
 		if (open_count > max_count) {
 			if (open_count > 0)
@@ -3634,8 +3634,8 @@ int dasd_generic_set_offline(struct ccw_device *cdev)
 		 * so sync bdev first and then wait for our queues to become
 		 * empty
 		 */
-		if (device->block && device->block->bdev_handle)
-			bdev_mark_dead(device->block->bdev_handle->bdev, false);
+		if (device->block && device->block->bdev_file)
+			bdev_mark_dead(file_bdev(device->block->bdev_file), false);
 		dasd_schedule_device_bh(device);
 		rc = wait_event_interruptible(shutdown_waitq,
 					      _wait_for_empty_queues(device));
diff --git a/drivers/s390/block/dasd_genhd.c b/drivers/s390/block/dasd_genhd.c
index 55e3abe94cde..8bf2cf0ccc15 100644
--- a/drivers/s390/block/dasd_genhd.c
+++ b/drivers/s390/block/dasd_genhd.c
@@ -127,15 +127,15 @@ void dasd_gendisk_free(struct dasd_block *block)
  */
 int dasd_scan_partitions(struct dasd_block *block)
 {
-	struct bdev_handle *bdev_handle;
+	struct file *bdev_file;
 	int rc;
 
-	bdev_handle = bdev_open_by_dev(disk_devt(block->gdp), BLK_OPEN_READ,
+	bdev_file = bdev_file_open_by_dev(disk_devt(block->gdp), BLK_OPEN_READ,
 				       NULL, NULL);
-	if (IS_ERR(bdev_handle)) {
+	if (IS_ERR(bdev_file)) {
 		DBF_DEV_EVENT(DBF_ERR, block->base,
 			      "scan partitions error, blkdev_get returned %ld",
-			      PTR_ERR(bdev_handle));
+			      PTR_ERR(bdev_file));
 		return -ENODEV;
 	}
 
@@ -147,15 +147,15 @@ int dasd_scan_partitions(struct dasd_block *block)
 				"scan partitions error, rc %d", rc);
 
 	/*
-	 * Since the matching bdev_release() call to the
-	 * bdev_open_by_path() in this function is not called before
+	 * Since the matching fput() call to the
+	 * bdev_file_open_by_path() in this function is not called before
 	 * dasd_destroy_partitions the offline open_count limit needs to be
-	 * increased from 0 to 1. This is done by setting device->bdev_handle
+	 * increased from 0 to 1. This is done by setting device->bdev_file
 	 * (see dasd_generic_set_offline). As long as the partition detection
 	 * is running no offline should be allowed. That is why the assignment
-	 * to block->bdev_handle is done AFTER the BLKRRPART ioctl.
+	 * to block->bdev_file is done AFTER the BLKRRPART ioctl.
 	 */
-	block->bdev_handle = bdev_handle;
+	block->bdev_file = bdev_file;
 	return 0;
 }
 
@@ -165,21 +165,21 @@ int dasd_scan_partitions(struct dasd_block *block)
  */
 void dasd_destroy_partitions(struct dasd_block *block)
 {
-	struct bdev_handle *bdev_handle;
+	struct file *bdev_file;
 
 	/*
-	 * Get the bdev_handle pointer from the device structure and clear
-	 * device->bdev_handle to lower the offline open_count limit again.
+	 * Get the bdev_file pointer from the device structure and clear
+	 * device->bdev_file to lower the offline open_count limit again.
 	 */
-	bdev_handle = block->bdev_handle;
-	block->bdev_handle = NULL;
+	bdev_file = block->bdev_file;
+	block->bdev_file = NULL;
 
-	mutex_lock(&bdev_handle->bdev->bd_disk->open_mutex);
-	bdev_disk_changed(bdev_handle->bdev->bd_disk, true);
-	mutex_unlock(&bdev_handle->bdev->bd_disk->open_mutex);
+	mutex_lock(&file_bdev(bdev_file)->bd_disk->open_mutex);
+	bdev_disk_changed(file_bdev(bdev_file)->bd_disk, true);
+	mutex_unlock(&file_bdev(bdev_file)->bd_disk->open_mutex);
 
 	/* Matching blkdev_put to the blkdev_get in dasd_scan_partitions. */
-	bdev_release(bdev_handle);
+	fput(bdev_file);
 }
 
 int dasd_gendisk_init(void)
diff --git a/drivers/s390/block/dasd_int.h b/drivers/s390/block/dasd_int.h
index 1b1b8a41c4d4..aecd502aec51 100644
--- a/drivers/s390/block/dasd_int.h
+++ b/drivers/s390/block/dasd_int.h
@@ -650,7 +650,7 @@ struct dasd_block {
 	struct gendisk *gdp;
 	spinlock_t request_queue_lock;
 	struct blk_mq_tag_set tag_set;
-	struct bdev_handle *bdev_handle;
+	struct file *bdev_file;
 	atomic_t open_count;
 
 	unsigned long blocks;	   /* size of volume in blocks */
diff --git a/drivers/s390/block/dasd_ioctl.c b/drivers/s390/block/dasd_ioctl.c
index 61b9675e2a67..de85a5e4e21b 100644
--- a/drivers/s390/block/dasd_ioctl.c
+++ b/drivers/s390/block/dasd_ioctl.c
@@ -537,7 +537,7 @@ static int __dasd_ioctl_information(struct dasd_block *block,
 	 * This must be hidden from user-space.
 	 */
 	dasd_info->open_count = atomic_read(&block->open_count);
-	if (!block->bdev_handle)
+	if (!block->bdev_file)
 		dasd_info->open_count++;
 
 	/*

-- 
2.43.0


