Return-Path: <linux-fsdevel+bounces-7189-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9679F822DAA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 13:56:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11F93B2205B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 12:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3C641A5A3;
	Wed,  3 Jan 2024 12:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="grxu89kJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1101A58B;
	Wed,  3 Jan 2024 12:55:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C096C433C8;
	Wed,  3 Jan 2024 12:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704286545;
	bh=E1pb3tWRhbIb1ThnWwVIbSlHfg+upza6Ty2NR9Cnaeo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=grxu89kJ+vydYrrXOCzqK7V1iNBZwNjTe1Vu6CBbIB6DlYRbSKRhWqkvcklp+SIls
	 F+lO9QL3sB1bFNut4UAZAt0SAV1Mia6ENpM1hWWzNSLGvyC/UnS6PqC+emxYSX/lag
	 H/Yuo2tQkjmYfI2C7XBU/Uogj071XL9f5hqWQ2UWRUNag4ezPFxf2y3Tk0Lb7VAGSe
	 jMz+mtZQBtaN7XZdHbRXCxpNwCjiGX3dYEg+FcztR+DWbkcuvXD3YM1yXuqgpW7LBQ
	 PfDQnSW25qlfjolbUwhJGic26KUrBlJ2a4JRWoDYfC5tFCVJhoiHczckAnvpLpcJdP
	 K80I/LgSuJlJQ==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 03 Jan 2024 13:55:06 +0100
Subject: [PATCH RFC 08/34] drbd: port block device access to file
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240103-vfs-bdev-file-v1-8-6c8ee55fb6ef@kernel.org>
References: <20240103-vfs-bdev-file-v1-0-6c8ee55fb6ef@kernel.org>
In-Reply-To: <20240103-vfs-bdev-file-v1-0-6c8ee55fb6ef@kernel.org>
To: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, 
 Jens Axboe <axboe@kernel.dk>
Cc: "Darrick J. Wong" <djwong@kernel.org>, linux-fsdevel@vger.kernel.org, 
 linux-block@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-4e032
X-Developer-Signature: v=1; a=openpgp-sha256; l=5353; i=brauner@kernel.org;
 h=from:subject:message-id; bh=E1pb3tWRhbIb1ThnWwVIbSlHfg+upza6Ty2NR9Cnaeo=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaROjbThjwlW8Ln7f37nk4Lzx67FHp36eGZLAsfZ/2vch
 QUic2dP7ChhYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjI5HaGv4Knar7VNfZ9KT9t
 5GLzoJfz2KaeRZwsmUc3V2t9XGX4fTnDN31nz6+fvVYwFgtYnpBYIzVvxuPpF//bGs+Zr5jYadD
 PCQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 drivers/block/drbd/drbd_int.h |  4 +--
 drivers/block/drbd/drbd_nl.c  | 58 +++++++++++++++++++++----------------------
 2 files changed, 31 insertions(+), 31 deletions(-)

diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index c21e3732759e..3f57b3a04f39 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -524,9 +524,9 @@ struct drbd_md {
 
 struct drbd_backing_dev {
 	struct block_device *backing_bdev;
-	struct bdev_handle *backing_bdev_handle;
+	struct file *f_backing_bdev;
 	struct block_device *md_bdev;
-	struct bdev_handle *md_bdev_handle;
+	struct file *f_md_bdev;
 	struct drbd_md md;
 	struct disk_conf *disk_conf; /* RCU, for updates: resource->conf_update */
 	sector_t known_size; /* last known size of that backing device */
diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index 43747a1aae43..d53a681286cd 100644
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
+	err = bd_link_disk_holder(F_BDEV(file), device->vdisk);
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
+	nbc->backing_bdev = F_BDEV(file);
+	nbc->f_backing_bdev = file;
 
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
+	nbc->md_bdev = F_BDEV(file);
+	nbc->f_md_bdev = file;
 	return NO_ERROR;
 }
 
 static void close_backing_dev(struct drbd_device *device,
-		struct bdev_handle *handle, bool do_bd_unlink)
+		struct file *f_bdev, bool do_bd_unlink)
 {
-	if (!handle)
+	if (!f_bdev)
 		return;
 	if (do_bd_unlink)
-		bd_unlink_disk_holder(handle->bdev, device->vdisk);
-	bdev_release(handle);
+		bd_unlink_disk_holder(F_BDEV(f_bdev), device->vdisk);
+	fput(f_bdev);
 }
 
 void drbd_backing_dev_free(struct drbd_device *device, struct drbd_backing_dev *ldev)
@@ -1713,9 +1713,9 @@ void drbd_backing_dev_free(struct drbd_device *device, struct drbd_backing_dev *
 	if (ldev == NULL)
 		return;
 
-	close_backing_dev(device, ldev->md_bdev_handle,
+	close_backing_dev(device, ldev->f_md_bdev,
 			  ldev->md_bdev != ldev->backing_bdev);
-	close_backing_dev(device, ldev->backing_bdev_handle, true);
+	close_backing_dev(device, ldev->f_backing_bdev, true);
 
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
+		close_backing_dev(device, nbc->f_backing_bdev, true);
 		kfree(nbc);
 	}
 	kfree(new_disk_conf);

-- 
2.42.0


