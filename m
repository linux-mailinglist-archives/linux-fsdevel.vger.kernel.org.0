Return-Path: <linux-fsdevel+bounces-8556-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74CBF838FFC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 14:30:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 014C31F2386E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 13:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE59260888;
	Tue, 23 Jan 2024 13:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t6hvn0FO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5561660871;
	Tue, 23 Jan 2024 13:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706016446; cv=none; b=VKR2anOUewdzVioSfIHuRNxwN4WpdTVjKX+2rv3jFojp2Uhq9Sc7eU+Ogb1ESeFsjIpZi7cy4oOlCOCXHlos4WfUHlm7u5Mcc+wLLZKxKq7AQBlFrxo+b0Ay1HqXR88WyKK5mqmJyzKbCh0gB068o5eJGVrWwTBoU0PC7GWtITo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706016446; c=relaxed/simple;
	bh=ukgwKS9b74pvxt5KIxpB+SsEZQ15dEZSLmrqfVMou9g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JpPstzqhbtX0Cc/uSF+xAfJzfzv6NPM9xBeTg8eCow1SdJWCUEAtKGdxQOZ0bQ4RlRCgekb4Kv7CUX4D6rAtbyoPgod3Wx3dlKW8wgOc8Kza7skZuOJg9qI2h3J1ECCnPZLpD6E2TG1YrrvbkISw+hEgeprwjxe6l7vBNFBj1vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t6hvn0FO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45A08C4166A;
	Tue, 23 Jan 2024 13:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706016446;
	bh=ukgwKS9b74pvxt5KIxpB+SsEZQ15dEZSLmrqfVMou9g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=t6hvn0FOzEAxMSmlUsSr83M2e/H9rRNGK/Qjoac96+V9OQ4++PkFTz21mEJNHGjSJ
	 3GxDUzA2QUzMTW3A/nYR4DXDBmq38idQDDcq53c9QWwrMbuO9zsO0HI2nzzAQcdcG5
	 KSjctyijR53AIJ/ixmuH7cwkvEHPTQQBXOhd3lRe1r/UNDjK2Br0k8tFQJn05Xwlru
	 K53NXhn+DbLbo+wG6VgCKFyPVT+92wPQC4gaC42g/qpOeRulXJtXJl/6Jjn1zvQa7T
	 Z+haBkNSQmt4c0JKUqxzZDUsxOKitE+3Cg8YH0+FHT+RgT7Rz3w7DK+yc/BRWkHdJB
	 23gvDRprqkW3g==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 23 Jan 2024 14:26:28 +0100
Subject: [PATCH v2 11/34] xen: port block device access to file
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240123-vfs-bdev-file-v2-11-adbd023e19cc@kernel.org>
References: <20240123-vfs-bdev-file-v2-0-adbd023e19cc@kernel.org>
In-Reply-To: <20240123-vfs-bdev-file-v2-0-adbd023e19cc@kernel.org>
To: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, 
 Jens Axboe <axboe@kernel.dk>
Cc: "Darrick J. Wong" <djwong@kernel.org>, linux-fsdevel@vger.kernel.org, 
 linux-block@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-4e032
X-Developer-Signature: v=1; a=openpgp-sha256; l=6233; i=brauner@kernel.org;
 h=from:subject:message-id; bh=ukgwKS9b74pvxt5KIxpB+SsEZQ15dEZSLmrqfVMou9g=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSu3zf/zmK/nV1L0pwl/J+FLXaMSGH+aHzM9PCqyO7LD
 BO/bZSZ1VHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjARfU2Gv6LOMpHTTriG3xa2
 yHuyIao/bsPLlPxExek8W/tvrijaqsLw3yv1fdrhtIkJXBE8uWs1N/Z3HvnI57/KcPKy1OMrOwt
 4GAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 drivers/block/xen-blkback/blkback.c |  4 ++--
 drivers/block/xen-blkback/common.h  |  4 ++--
 drivers/block/xen-blkback/xenbus.c  | 37 ++++++++++++++++++-------------------
 3 files changed, 22 insertions(+), 23 deletions(-)

diff --git a/drivers/block/xen-blkback/blkback.c b/drivers/block/xen-blkback/blkback.c
index 4defd7f387c7..944576d582fb 100644
--- a/drivers/block/xen-blkback/blkback.c
+++ b/drivers/block/xen-blkback/blkback.c
@@ -465,7 +465,7 @@ static int xen_vbd_translate(struct phys_req *req, struct xen_blkif *blkif,
 	}
 
 	req->dev  = vbd->pdevice;
-	req->bdev = vbd->bdev_handle->bdev;
+	req->bdev = file_bdev(vbd->bdev_file);
 	rc = 0;
 
  out:
@@ -969,7 +969,7 @@ static int dispatch_discard_io(struct xen_blkif_ring *ring,
 	int err = 0;
 	int status = BLKIF_RSP_OKAY;
 	struct xen_blkif *blkif = ring->blkif;
-	struct block_device *bdev = blkif->vbd.bdev_handle->bdev;
+	struct block_device *bdev = file_bdev(blkif->vbd.bdev_file);
 	struct phys_req preq;
 
 	xen_blkif_get(blkif);
diff --git a/drivers/block/xen-blkback/common.h b/drivers/block/xen-blkback/common.h
index 1432c83183d0..b427d54bc120 100644
--- a/drivers/block/xen-blkback/common.h
+++ b/drivers/block/xen-blkback/common.h
@@ -221,7 +221,7 @@ struct xen_vbd {
 	unsigned char		type;
 	/* phys device that this vbd maps to. */
 	u32			pdevice;
-	struct bdev_handle	*bdev_handle;
+	struct file		*bdev_file;
 	/* Cached size parameter. */
 	sector_t		size;
 	unsigned int		flush_support:1;
@@ -360,7 +360,7 @@ struct pending_req {
 };
 
 
-#define vbd_sz(_v)	bdev_nr_sectors((_v)->bdev_handle->bdev)
+#define vbd_sz(_v)	bdev_nr_sectors(file_bdev((_v)->bdev_file))
 
 #define xen_blkif_get(_b) (atomic_inc(&(_b)->refcnt))
 #define xen_blkif_put(_b)				\
diff --git a/drivers/block/xen-blkback/xenbus.c b/drivers/block/xen-blkback/xenbus.c
index e34219ea2b05..0621878940ae 100644
--- a/drivers/block/xen-blkback/xenbus.c
+++ b/drivers/block/xen-blkback/xenbus.c
@@ -81,7 +81,7 @@ static void xen_update_blkif_status(struct xen_blkif *blkif)
 	int i;
 
 	/* Not ready to connect? */
-	if (!blkif->rings || !blkif->rings[0].irq || !blkif->vbd.bdev_handle)
+	if (!blkif->rings || !blkif->rings[0].irq || !blkif->vbd.bdev_file)
 		return;
 
 	/* Already connected? */
@@ -99,13 +99,12 @@ static void xen_update_blkif_status(struct xen_blkif *blkif)
 		return;
 	}
 
-	err = sync_blockdev(blkif->vbd.bdev_handle->bdev);
+	err = sync_blockdev(file_bdev(blkif->vbd.bdev_file));
 	if (err) {
 		xenbus_dev_error(blkif->be->dev, err, "block flush");
 		return;
 	}
-	invalidate_inode_pages2(
-			blkif->vbd.bdev_handle->bdev->bd_inode->i_mapping);
+	invalidate_inode_pages2(blkif->vbd.bdev_file->f_mapping);
 
 	for (i = 0; i < blkif->nr_rings; i++) {
 		ring = &blkif->rings[i];
@@ -473,9 +472,9 @@ static void xenvbd_sysfs_delif(struct xenbus_device *dev)
 
 static void xen_vbd_free(struct xen_vbd *vbd)
 {
-	if (vbd->bdev_handle)
-		bdev_release(vbd->bdev_handle);
-	vbd->bdev_handle = NULL;
+	if (vbd->bdev_file)
+		fput(vbd->bdev_file);
+	vbd->bdev_file = NULL;
 }
 
 static int xen_vbd_create(struct xen_blkif *blkif, blkif_vdev_t handle,
@@ -483,7 +482,7 @@ static int xen_vbd_create(struct xen_blkif *blkif, blkif_vdev_t handle,
 			  int cdrom)
 {
 	struct xen_vbd *vbd;
-	struct bdev_handle *bdev_handle;
+	struct file *bdev_file;
 
 	vbd = &blkif->vbd;
 	vbd->handle   = handle;
@@ -492,17 +491,17 @@ static int xen_vbd_create(struct xen_blkif *blkif, blkif_vdev_t handle,
 
 	vbd->pdevice  = MKDEV(major, minor);
 
-	bdev_handle = bdev_open_by_dev(vbd->pdevice, vbd->readonly ?
+	bdev_file = bdev_file_open_by_dev(vbd->pdevice, vbd->readonly ?
 				 BLK_OPEN_READ : BLK_OPEN_WRITE, NULL, NULL);
 
-	if (IS_ERR(bdev_handle)) {
+	if (IS_ERR(bdev_file)) {
 		pr_warn("xen_vbd_create: device %08x could not be opened\n",
 			vbd->pdevice);
 		return -ENOENT;
 	}
 
-	vbd->bdev_handle = bdev_handle;
-	if (vbd->bdev_handle->bdev->bd_disk == NULL) {
+	vbd->bdev_file = bdev_file;
+	if (file_bdev(vbd->bdev_file)->bd_disk == NULL) {
 		pr_warn("xen_vbd_create: device %08x doesn't exist\n",
 			vbd->pdevice);
 		xen_vbd_free(vbd);
@@ -510,14 +509,14 @@ static int xen_vbd_create(struct xen_blkif *blkif, blkif_vdev_t handle,
 	}
 	vbd->size = vbd_sz(vbd);
 
-	if (cdrom || disk_to_cdi(vbd->bdev_handle->bdev->bd_disk))
+	if (cdrom || disk_to_cdi(file_bdev(vbd->bdev_file)->bd_disk))
 		vbd->type |= VDISK_CDROM;
-	if (vbd->bdev_handle->bdev->bd_disk->flags & GENHD_FL_REMOVABLE)
+	if (file_bdev(vbd->bdev_file)->bd_disk->flags & GENHD_FL_REMOVABLE)
 		vbd->type |= VDISK_REMOVABLE;
 
-	if (bdev_write_cache(bdev_handle->bdev))
+	if (bdev_write_cache(file_bdev(bdev_file)))
 		vbd->flush_support = true;
-	if (bdev_max_secure_erase_sectors(bdev_handle->bdev))
+	if (bdev_max_secure_erase_sectors(file_bdev(bdev_file)))
 		vbd->discard_secure = true;
 
 	pr_debug("Successful creation of handle=%04x (dom=%u)\n",
@@ -570,7 +569,7 @@ static void xen_blkbk_discard(struct xenbus_transaction xbt, struct backend_info
 	struct xen_blkif *blkif = be->blkif;
 	int err;
 	int state = 0;
-	struct block_device *bdev = be->blkif->vbd.bdev_handle->bdev;
+	struct block_device *bdev = file_bdev(be->blkif->vbd.bdev_file);
 
 	if (!xenbus_read_unsigned(dev->nodename, "discard-enable", 1))
 		return;
@@ -932,7 +931,7 @@ static void connect(struct backend_info *be)
 	}
 	err = xenbus_printf(xbt, dev->nodename, "sector-size", "%lu",
 			    (unsigned long)bdev_logical_block_size(
-					be->blkif->vbd.bdev_handle->bdev));
+					file_bdev(be->blkif->vbd.bdev_file)));
 	if (err) {
 		xenbus_dev_fatal(dev, err, "writing %s/sector-size",
 				 dev->nodename);
@@ -940,7 +939,7 @@ static void connect(struct backend_info *be)
 	}
 	err = xenbus_printf(xbt, dev->nodename, "physical-sector-size", "%u",
 			    bdev_physical_block_size(
-					be->blkif->vbd.bdev_handle->bdev));
+					file_bdev(be->blkif->vbd.bdev_file)));
 	if (err)
 		xenbus_dev_error(dev, err, "writing %s/physical-sector-size",
 				 dev->nodename);

-- 
2.43.0


