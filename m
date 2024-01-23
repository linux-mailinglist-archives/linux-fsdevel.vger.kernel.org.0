Return-Path: <linux-fsdevel+bounces-8553-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ABEE838FF6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 14:30:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFE802905C7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 13:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D930360866;
	Tue, 23 Jan 2024 13:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aPjmsj4x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444A55F842;
	Tue, 23 Jan 2024 13:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706016439; cv=none; b=Vdh2cM3DrtYuK91iD7ED4F7bqzQ/vB8wQgY3SE9DKaEcOL94pohlo1QnPn+9hP/8xoF1MlRdv8vfF28NxYfowFgLKK9Es5yNwbG0i6/cvyP/Dg/We37HnIYd2qrp3PQXk9uOkzpLHtnHSZL9uIqE+aCXRVEpBxD9LjV74NvhCqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706016439; c=relaxed/simple;
	bh=AICIsfSGfmGGqywI3PPveZdAo5NPjOb0vqma3yT2q1c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EIL7vbdGeCT0ApkV9cIJcKQsrUN21klQk1QUCvGJ6IQ/ORqKt0XR7daD4m8XLdayE+fIfCvxRzfYzgP0GCMSqJVLUrENcSTPL4ZH1mKPFTZ7LIjJa0sZI0XJ2lSEcDLUZOkvlvyFfXwALdRfkUQ36bG+PATmEwW9Uwgfk3KMghY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aPjmsj4x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01A5DC4166A;
	Tue, 23 Jan 2024 13:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706016438;
	bh=AICIsfSGfmGGqywI3PPveZdAo5NPjOb0vqma3yT2q1c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=aPjmsj4xw6HUBVI6nAbXPonS+TW8whDvlx9eh5x9MI7WfegNz9wrjI1y+NXO2ajWR
	 A+vC93x7eMw3ia8kVZf8nPPUFbWM8Kabmn+GV3weVKuVbbzPxuXxhOL2xH4T2SAW2v
	 qVzTiwerJzLsuEh3cAN4kM7ritOA+F9pJMW8nV/uc9nJx/x5DrmIUADkDw6rLCb7yg
	 xM/4uN0muB12MgawHDzKwmScqkVLzwl5W3jawi3KKOszCtVlbNiHOLUYQb7OeP1mu7
	 t72QJRgFIWRSatAGffX5JXYCs4U956YhLHOvtQxTjEliit6/xG5zFo+gzlI+I98Yzc
	 0SCXFD8TNLk2w==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 23 Jan 2024 14:26:25 +0100
Subject: [PATCH v2 08/34] drbd: port block device access to file
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240123-vfs-bdev-file-v2-8-adbd023e19cc@kernel.org>
References: <20240123-vfs-bdev-file-v2-0-adbd023e19cc@kernel.org>
In-Reply-To: <20240123-vfs-bdev-file-v2-0-adbd023e19cc@kernel.org>
To: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, 
 Jens Axboe <axboe@kernel.dk>
Cc: "Darrick J. Wong" <djwong@kernel.org>, linux-fsdevel@vger.kernel.org, 
 linux-block@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-4e032
X-Developer-Signature: v=1; a=openpgp-sha256; l=5389; i=brauner@kernel.org;
 h=from:subject:message-id; bh=AICIsfSGfmGGqywI3PPveZdAo5NPjOb0vqma3yT2q1c=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSu3zcv/WdOeNuj7KJ9HZeMqz+bVW6aeLZVM01baVZ/p
 GTLhhX/O0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACZyUIbhv4P99DXd5h8EuLaf
 z+0sOnmoa+F1nT6h1Q85XLJ8Pk9iV2JkeJx+xXHhrLxZD9z3fX/qP8fLZI1Ls7qKVdi2/xzOsya
 fZgQA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 drivers/block/drbd/drbd_int.h |  4 +--
 drivers/block/drbd/drbd_nl.c  | 58 +++++++++++++++++++++----------------------
 2 files changed, 31 insertions(+), 31 deletions(-)

diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index c21e3732759e..94dc0a235919 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -524,9 +524,9 @@ struct drbd_md {
 
 struct drbd_backing_dev {
 	struct block_device *backing_bdev;
-	struct bdev_handle *backing_bdev_handle;
+	struct file *backing_bdev_file;
 	struct block_device *md_bdev;
-	struct bdev_handle *md_bdev_handle;
+	struct file *f_md_bdev;
 	struct drbd_md md;
 	struct disk_conf *disk_conf; /* RCU, for updates: resource->conf_update */
 	sector_t known_size; /* last known size of that backing device */
diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index 43747a1aae43..6aed67278e8b 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -1635,45 +1635,45 @@ int drbd_adm_disk_opts(struct sk_buff *skb, struct genl_info *info)
 	return 0;
 }
 
-static struct bdev_handle *open_backing_dev(struct drbd_device *device,
+static struct file *open_backing_dev(struct drbd_device *device,
 		const char *bdev_path, void *claim_ptr, bool do_bd_link)
 {
-	struct bdev_handle *handle;
+	struct file *file;
 	int err = 0;
 
-	handle = bdev_open_by_path(bdev_path, BLK_OPEN_READ | BLK_OPEN_WRITE,
-				   claim_ptr, NULL);
-	if (IS_ERR(handle)) {
+	file = bdev_file_open_by_path(bdev_path, BLK_OPEN_READ | BLK_OPEN_WRITE,
+				      claim_ptr, NULL);
+	if (IS_ERR(file)) {
 		drbd_err(device, "open(\"%s\") failed with %ld\n",
-				bdev_path, PTR_ERR(handle));
-		return handle;
+				bdev_path, PTR_ERR(file));
+		return file;
 	}
 
 	if (!do_bd_link)
-		return handle;
+		return file;
 
-	err = bd_link_disk_holder(handle->bdev, device->vdisk);
+	err = bd_link_disk_holder(file_bdev(file), device->vdisk);
 	if (err) {
-		bdev_release(handle);
+		fput(file);
 		drbd_err(device, "bd_link_disk_holder(\"%s\", ...) failed with %d\n",
 				bdev_path, err);
-		handle = ERR_PTR(err);
+		file = ERR_PTR(err);
 	}
-	return handle;
+	return file;
 }
 
 static int open_backing_devices(struct drbd_device *device,
 		struct disk_conf *new_disk_conf,
 		struct drbd_backing_dev *nbc)
 {
-	struct bdev_handle *handle;
+	struct file *file;
 
-	handle = open_backing_dev(device, new_disk_conf->backing_dev, device,
+	file = open_backing_dev(device, new_disk_conf->backing_dev, device,
 				  true);
-	if (IS_ERR(handle))
+	if (IS_ERR(file))
 		return ERR_OPEN_DISK;
-	nbc->backing_bdev = handle->bdev;
-	nbc->backing_bdev_handle = handle;
+	nbc->backing_bdev = file_bdev(file);
+	nbc->backing_bdev_file = file;
 
 	/*
 	 * meta_dev_idx >= 0: external fixed size, possibly multiple
@@ -1683,7 +1683,7 @@ static int open_backing_devices(struct drbd_device *device,
 	 * should check it for you already; but if you don't, or
 	 * someone fooled it, we need to double check here)
 	 */
-	handle = open_backing_dev(device, new_disk_conf->meta_dev,
+	file = open_backing_dev(device, new_disk_conf->meta_dev,
 		/* claim ptr: device, if claimed exclusively; shared drbd_m_holder,
 		 * if potentially shared with other drbd minors */
 			(new_disk_conf->meta_dev_idx < 0) ? (void*)device : (void*)drbd_m_holder,
@@ -1691,21 +1691,21 @@ static int open_backing_devices(struct drbd_device *device,
 		 * as would happen with internal metadata. */
 			(new_disk_conf->meta_dev_idx != DRBD_MD_INDEX_FLEX_INT &&
 			 new_disk_conf->meta_dev_idx != DRBD_MD_INDEX_INTERNAL));
-	if (IS_ERR(handle))
+	if (IS_ERR(file))
 		return ERR_OPEN_MD_DISK;
-	nbc->md_bdev = handle->bdev;
-	nbc->md_bdev_handle = handle;
+	nbc->md_bdev = file_bdev(file);
+	nbc->f_md_bdev = file;
 	return NO_ERROR;
 }
 
 static void close_backing_dev(struct drbd_device *device,
-		struct bdev_handle *handle, bool do_bd_unlink)
+		struct file *bdev_file, bool do_bd_unlink)
 {
-	if (!handle)
+	if (!bdev_file)
 		return;
 	if (do_bd_unlink)
-		bd_unlink_disk_holder(handle->bdev, device->vdisk);
-	bdev_release(handle);
+		bd_unlink_disk_holder(file_bdev(bdev_file), device->vdisk);
+	fput(bdev_file);
 }
 
 void drbd_backing_dev_free(struct drbd_device *device, struct drbd_backing_dev *ldev)
@@ -1713,9 +1713,9 @@ void drbd_backing_dev_free(struct drbd_device *device, struct drbd_backing_dev *
 	if (ldev == NULL)
 		return;
 
-	close_backing_dev(device, ldev->md_bdev_handle,
+	close_backing_dev(device, ldev->f_md_bdev,
 			  ldev->md_bdev != ldev->backing_bdev);
-	close_backing_dev(device, ldev->backing_bdev_handle, true);
+	close_backing_dev(device, ldev->backing_bdev_file, true);
 
 	kfree(ldev->disk_conf);
 	kfree(ldev);
@@ -2131,9 +2131,9 @@ int drbd_adm_attach(struct sk_buff *skb, struct genl_info *info)
  fail:
 	conn_reconfig_done(connection);
 	if (nbc) {
-		close_backing_dev(device, nbc->md_bdev_handle,
+		close_backing_dev(device, nbc->f_md_bdev,
 			  nbc->md_bdev != nbc->backing_bdev);
-		close_backing_dev(device, nbc->backing_bdev_handle, true);
+		close_backing_dev(device, nbc->backing_bdev_file, true);
 		kfree(nbc);
 	}
 	kfree(new_disk_conf);

-- 
2.43.0


