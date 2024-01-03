Return-Path: <linux-fsdevel+bounces-7197-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E744822DBB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 13:57:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C6371C2143B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 12:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CA171A726;
	Wed,  3 Jan 2024 12:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FRv1KCYE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65A61A71A;
	Wed,  3 Jan 2024 12:56:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EB6AC433C8;
	Wed,  3 Jan 2024 12:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704286562;
	bh=QlHJ9MNHMXpTsM70DGdZLedAO8BPnf7wsRiAtwSFLCI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=FRv1KCYEt9z5x+77pK/EtbdPkewFeuRYgE1QFrDznku1v35VpOMVJSaykSjvyBKwy
	 lzxPZ8rAg6quW3ZpDOTi1y1EzymzsCZyI+qKPVXEDAGKcy26PA/dxPxtZRGUkDRNj5
	 yxzpMTIgKT34LmLzMX6uDUKnaQjXU73lcMrXvNpX2tvL216cWH0TVzOSrn8OWUDc9S
	 8skZCFUrxxoib3Om+2m3bc0FH1kuwfkfRSPacqq0VqGUXb8vMhsYi7nLZT4a3M+e/a
	 WcRHVJg8wFJ+8ieyLR5B+Mx84thhBphjCdyXt0Dx/QZH7AY3KiiE+xPrtBh5X54+Ut
	 sBJzcFHr7/57Q==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 03 Jan 2024 13:55:14 +0100
Subject: [PATCH RFC 16/34] s390: port block device access to file
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240103-vfs-bdev-file-v1-16-6c8ee55fb6ef@kernel.org>
References: <20240103-vfs-bdev-file-v1-0-6c8ee55fb6ef@kernel.org>
In-Reply-To: <20240103-vfs-bdev-file-v1-0-6c8ee55fb6ef@kernel.org>
To: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, 
 Jens Axboe <axboe@kernel.dk>
Cc: "Darrick J. Wong" <djwong@kernel.org>, linux-fsdevel@vger.kernel.org, 
 linux-block@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-4e032
X-Developer-Signature: v=1; a=openpgp-sha256; l=5814; i=brauner@kernel.org;
 h=from:subject:message-id; bh=QlHJ9MNHMXpTsM70DGdZLedAO8BPnf7wsRiAtwSFLCI=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaROjbTR6/+2/OyNM7MW93qoHH7UPHvbCvlXJ9+aLHtle
 P1v45GZHztKWRjEuBhkxRRZHNpNwuWW81RsNsrUgJnDygQyhIGLUwAmYn+HkeF+5c05Pw8oLBNX
 fct+bvLR0A/GTzt4vjDJSHJOOLvi0r4fDP+d+hiONr49cvnWmjvKcyynRF84/+dt5c5p+RYb5wh
 9usfMCgA=
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
index 833cfab7d877..e462dcad84b1 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -412,7 +412,7 @@ dasd_state_ready_to_online(struct dasd_device * device)
 					KOBJ_CHANGE);
 			return 0;
 		}
-		disk_uevent(device->block->bdev_handle->bdev->bd_disk,
+		disk_uevent(F_BDEV(device->block->f_bdev)->bd_disk,
 			    KOBJ_CHANGE);
 	}
 	return 0;
@@ -433,7 +433,7 @@ static int dasd_state_online_to_ready(struct dasd_device *device)
 
 	device->state = DASD_STATE_READY;
 	if (device->block && !(device->features & DASD_FEATURE_USERAW))
-		disk_uevent(device->block->bdev_handle->bdev->bd_disk,
+		disk_uevent(F_BDEV(device->block->f_bdev)->bd_disk,
 			    KOBJ_CHANGE);
 	return 0;
 }
@@ -3594,7 +3594,7 @@ int dasd_generic_set_offline(struct ccw_device *cdev)
 	 * in the other openers.
 	 */
 	if (device->block) {
-		max_count = device->block->bdev_handle ? 0 : -1;
+		max_count = device->block->f_bdev ? 0 : -1;
 		open_count = atomic_read(&device->block->open_count);
 		if (open_count > max_count) {
 			if (open_count > 0)
@@ -3640,8 +3640,8 @@ int dasd_generic_set_offline(struct ccw_device *cdev)
 		 * so sync bdev first and then wait for our queues to become
 		 * empty
 		 */
-		if (device->block && device->block->bdev_handle)
-			bdev_mark_dead(device->block->bdev_handle->bdev, false);
+		if (device->block && device->block->f_bdev)
+			bdev_mark_dead(F_BDEV(device->block->f_bdev), false);
 		dasd_schedule_device_bh(device);
 		rc = wait_event_interruptible(shutdown_waitq,
 					      _wait_for_empty_queues(device));
diff --git a/drivers/s390/block/dasd_genhd.c b/drivers/s390/block/dasd_genhd.c
index 55e3abe94cde..4c389b7416f8 100644
--- a/drivers/s390/block/dasd_genhd.c
+++ b/drivers/s390/block/dasd_genhd.c
@@ -127,15 +127,15 @@ void dasd_gendisk_free(struct dasd_block *block)
  */
 int dasd_scan_partitions(struct dasd_block *block)
 {
-	struct bdev_handle *bdev_handle;
+	struct file *f_bdev;
 	int rc;
 
-	bdev_handle = bdev_open_by_dev(disk_devt(block->gdp), BLK_OPEN_READ,
+	f_bdev = bdev_file_open_by_dev(disk_devt(block->gdp), BLK_OPEN_READ,
 				       NULL, NULL);
-	if (IS_ERR(bdev_handle)) {
+	if (IS_ERR(f_bdev)) {
 		DBF_DEV_EVENT(DBF_ERR, block->base,
 			      "scan partitions error, blkdev_get returned %ld",
-			      PTR_ERR(bdev_handle));
+			      PTR_ERR(f_bdev));
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
+	 * increased from 0 to 1. This is done by setting device->f_bdev
 	 * (see dasd_generic_set_offline). As long as the partition detection
 	 * is running no offline should be allowed. That is why the assignment
-	 * to block->bdev_handle is done AFTER the BLKRRPART ioctl.
+	 * to block->f_bdev is done AFTER the BLKRRPART ioctl.
 	 */
-	block->bdev_handle = bdev_handle;
+	block->f_bdev = f_bdev;
 	return 0;
 }
 
@@ -165,21 +165,21 @@ int dasd_scan_partitions(struct dasd_block *block)
  */
 void dasd_destroy_partitions(struct dasd_block *block)
 {
-	struct bdev_handle *bdev_handle;
+	struct file *f_bdev;
 
 	/*
-	 * Get the bdev_handle pointer from the device structure and clear
-	 * device->bdev_handle to lower the offline open_count limit again.
+	 * Get the f_bdev pointer from the device structure and clear
+	 * device->f_bdev to lower the offline open_count limit again.
 	 */
-	bdev_handle = block->bdev_handle;
-	block->bdev_handle = NULL;
+	f_bdev = block->f_bdev;
+	block->f_bdev = NULL;
 
-	mutex_lock(&bdev_handle->bdev->bd_disk->open_mutex);
-	bdev_disk_changed(bdev_handle->bdev->bd_disk, true);
-	mutex_unlock(&bdev_handle->bdev->bd_disk->open_mutex);
+	mutex_lock(&F_BDEV(f_bdev)->bd_disk->open_mutex);
+	bdev_disk_changed(F_BDEV(f_bdev)->bd_disk, true);
+	mutex_unlock(&F_BDEV(f_bdev)->bd_disk->open_mutex);
 
 	/* Matching blkdev_put to the blkdev_get in dasd_scan_partitions. */
-	bdev_release(bdev_handle);
+	fput(f_bdev);
 }
 
 int dasd_gendisk_init(void)
diff --git a/drivers/s390/block/dasd_int.h b/drivers/s390/block/dasd_int.h
index 1b1b8a41c4d4..a2c16434d89f 100644
--- a/drivers/s390/block/dasd_int.h
+++ b/drivers/s390/block/dasd_int.h
@@ -650,7 +650,7 @@ struct dasd_block {
 	struct gendisk *gdp;
 	spinlock_t request_queue_lock;
 	struct blk_mq_tag_set tag_set;
-	struct bdev_handle *bdev_handle;
+	struct file *f_bdev;
 	atomic_t open_count;
 
 	unsigned long blocks;	   /* size of volume in blocks */
diff --git a/drivers/s390/block/dasd_ioctl.c b/drivers/s390/block/dasd_ioctl.c
index 61b9675e2a67..c73419a09bbd 100644
--- a/drivers/s390/block/dasd_ioctl.c
+++ b/drivers/s390/block/dasd_ioctl.c
@@ -537,7 +537,7 @@ static int __dasd_ioctl_information(struct dasd_block *block,
 	 * This must be hidden from user-space.
 	 */
 	dasd_info->open_count = atomic_read(&block->open_count);
-	if (!block->bdev_handle)
+	if (!block->f_bdev)
 		dasd_info->open_count++;
 
 	/*

-- 
2.42.0


