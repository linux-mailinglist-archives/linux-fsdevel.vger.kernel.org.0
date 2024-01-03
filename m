Return-Path: <linux-fsdevel+bounces-7192-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A36A822DAF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 13:57:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CEF31C227FA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 12:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C80C1A714;
	Wed,  3 Jan 2024 12:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gyns0UGT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A58941A70B;
	Wed,  3 Jan 2024 12:55:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1887C433C7;
	Wed,  3 Jan 2024 12:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704286551;
	bh=JuWJr6+7i2yrkqNGwt5xMzLZMnlqBoh0zK4VKx+/xgY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=gyns0UGT80aOIXTU22XaTj+sY1rI8jgOcB7Nvtq5mbyBwdc2B0KNzWkIUHCOFtonm
	 vxJuLMliguRFSe3C42yLVYLhcYJQFUiEkXWmJLlqmXAmr7eywRhs9r9KW7iHfksDCr
	 acC6hhPur5omS5mXt3ZXbeW4P/jHC273Bp/7YMfhRuvU4XuzgNM0YcAteDeJaEiR1B
	 Dh1NMYGHcX6jkhNWsyErpsgr+dIyhfbG+j5nXawFyRonWpM47MOPgnVEwi6lvf9EOe
	 kXM5diV6i+2h5b70JibgrnP2duNYG2oiqL0TXXgTa0BKcjqoIXS+WILX+2e1vj3H9f
	 mnLaOOF8oF2VA==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 03 Jan 2024 13:55:09 +0100
Subject: [PATCH RFC 11/34] xen: port block device access to file
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240103-vfs-bdev-file-v1-11-6c8ee55fb6ef@kernel.org>
References: <20240103-vfs-bdev-file-v1-0-6c8ee55fb6ef@kernel.org>
In-Reply-To: <20240103-vfs-bdev-file-v1-0-6c8ee55fb6ef@kernel.org>
To: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, 
 Jens Axboe <axboe@kernel.dk>
Cc: "Darrick J. Wong" <djwong@kernel.org>, linux-fsdevel@vger.kernel.org, 
 linux-block@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-4e032
X-Developer-Signature: v=1; a=openpgp-sha256; l=6117; i=brauner@kernel.org;
 h=from:subject:message-id; bh=JuWJr6+7i2yrkqNGwt5xMzLZMnlqBoh0zK4VKx+/xgY=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaROjbSpPF9yTOnL0bPxU9g+M1+3/WWalemnkbll0XFum
 wS/yT1pHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABPZps/I8KdRdv7Wh1FRz/bH
 b1W/VPXmU4NoG2v2NOdtZx+bF1eIJzAy7N1rHGVYeJXjl9uk306XDnNVhmy4IRJtOv3I47Vdzl9
 7eQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 drivers/block/xen-blkback/blkback.c |  4 ++--
 drivers/block/xen-blkback/common.h  |  4 ++--
 drivers/block/xen-blkback/xenbus.c  | 36 ++++++++++++++++++------------------
 3 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/drivers/block/xen-blkback/blkback.c b/drivers/block/xen-blkback/blkback.c
index 4defd7f387c7..752fd41c5ed9 100644
--- a/drivers/block/xen-blkback/blkback.c
+++ b/drivers/block/xen-blkback/blkback.c
@@ -465,7 +465,7 @@ static int xen_vbd_translate(struct phys_req *req, struct xen_blkif *blkif,
 	}
 
 	req->dev  = vbd->pdevice;
-	req->bdev = vbd->bdev_handle->bdev;
+	req->bdev = F_BDEV(vbd->f_bdev);
 	rc = 0;
 
  out:
@@ -969,7 +969,7 @@ static int dispatch_discard_io(struct xen_blkif_ring *ring,
 	int err = 0;
 	int status = BLKIF_RSP_OKAY;
 	struct xen_blkif *blkif = ring->blkif;
-	struct block_device *bdev = blkif->vbd.bdev_handle->bdev;
+	struct block_device *bdev = F_BDEV(blkif->vbd.f_bdev);
 	struct phys_req preq;
 
 	xen_blkif_get(blkif);
diff --git a/drivers/block/xen-blkback/common.h b/drivers/block/xen-blkback/common.h
index 5ff50e76cee5..44070e38e5c2 100644
--- a/drivers/block/xen-blkback/common.h
+++ b/drivers/block/xen-blkback/common.h
@@ -221,7 +221,7 @@ struct xen_vbd {
 	unsigned char		type;
 	/* phys device that this vbd maps to. */
 	u32			pdevice;
-	struct bdev_handle	*bdev_handle;
+	struct file		*f_bdev;
 	/* Cached size parameter. */
 	sector_t		size;
 	unsigned int		flush_support:1;
@@ -360,7 +360,7 @@ struct pending_req {
 };
 
 
-#define vbd_sz(_v)	bdev_nr_sectors((_v)->bdev_handle->bdev)
+#define vbd_sz(_v)	bdev_nr_sectors(F_BDEV((_v)->f_bdev))
 
 #define xen_blkif_get(_b) (atomic_inc(&(_b)->refcnt))
 #define xen_blkif_put(_b)				\
diff --git a/drivers/block/xen-blkback/xenbus.c b/drivers/block/xen-blkback/xenbus.c
index e34219ea2b05..5386e123fada 100644
--- a/drivers/block/xen-blkback/xenbus.c
+++ b/drivers/block/xen-blkback/xenbus.c
@@ -81,7 +81,7 @@ static void xen_update_blkif_status(struct xen_blkif *blkif)
 	int i;
 
 	/* Not ready to connect? */
-	if (!blkif->rings || !blkif->rings[0].irq || !blkif->vbd.bdev_handle)
+	if (!blkif->rings || !blkif->rings[0].irq || !blkif->vbd.f_bdev)
 		return;
 
 	/* Already connected? */
@@ -99,13 +99,13 @@ static void xen_update_blkif_status(struct xen_blkif *blkif)
 		return;
 	}
 
-	err = sync_blockdev(blkif->vbd.bdev_handle->bdev);
+	err = sync_blockdev(F_BDEV(blkif->vbd.f_bdev));
 	if (err) {
 		xenbus_dev_error(blkif->be->dev, err, "block flush");
 		return;
 	}
 	invalidate_inode_pages2(
-			blkif->vbd.bdev_handle->bdev->bd_inode->i_mapping);
+			file_inode(blkif->vbd.f_bdev)->i_mapping);
 
 	for (i = 0; i < blkif->nr_rings; i++) {
 		ring = &blkif->rings[i];
@@ -473,9 +473,9 @@ static void xenvbd_sysfs_delif(struct xenbus_device *dev)
 
 static void xen_vbd_free(struct xen_vbd *vbd)
 {
-	if (vbd->bdev_handle)
-		bdev_release(vbd->bdev_handle);
-	vbd->bdev_handle = NULL;
+	if (vbd->f_bdev)
+		fput(vbd->f_bdev);
+	vbd->f_bdev = NULL;
 }
 
 static int xen_vbd_create(struct xen_blkif *blkif, blkif_vdev_t handle,
@@ -483,7 +483,7 @@ static int xen_vbd_create(struct xen_blkif *blkif, blkif_vdev_t handle,
 			  int cdrom)
 {
 	struct xen_vbd *vbd;
-	struct bdev_handle *bdev_handle;
+	struct file *f_bdev;
 
 	vbd = &blkif->vbd;
 	vbd->handle   = handle;
@@ -492,17 +492,17 @@ static int xen_vbd_create(struct xen_blkif *blkif, blkif_vdev_t handle,
 
 	vbd->pdevice  = MKDEV(major, minor);
 
-	bdev_handle = bdev_open_by_dev(vbd->pdevice, vbd->readonly ?
+	f_bdev = bdev_file_open_by_dev(vbd->pdevice, vbd->readonly ?
 				 BLK_OPEN_READ : BLK_OPEN_WRITE, NULL, NULL);
 
-	if (IS_ERR(bdev_handle)) {
+	if (IS_ERR(f_bdev)) {
 		pr_warn("xen_vbd_create: device %08x could not be opened\n",
 			vbd->pdevice);
 		return -ENOENT;
 	}
 
-	vbd->bdev_handle = bdev_handle;
-	if (vbd->bdev_handle->bdev->bd_disk == NULL) {
+	vbd->f_bdev = f_bdev;
+	if (F_BDEV(vbd->f_bdev)->bd_disk == NULL) {
 		pr_warn("xen_vbd_create: device %08x doesn't exist\n",
 			vbd->pdevice);
 		xen_vbd_free(vbd);
@@ -510,14 +510,14 @@ static int xen_vbd_create(struct xen_blkif *blkif, blkif_vdev_t handle,
 	}
 	vbd->size = vbd_sz(vbd);
 
-	if (cdrom || disk_to_cdi(vbd->bdev_handle->bdev->bd_disk))
+	if (cdrom || disk_to_cdi(F_BDEV(vbd->f_bdev)->bd_disk))
 		vbd->type |= VDISK_CDROM;
-	if (vbd->bdev_handle->bdev->bd_disk->flags & GENHD_FL_REMOVABLE)
+	if (F_BDEV(vbd->f_bdev)->bd_disk->flags & GENHD_FL_REMOVABLE)
 		vbd->type |= VDISK_REMOVABLE;
 
-	if (bdev_write_cache(bdev_handle->bdev))
+	if (bdev_write_cache(F_BDEV(f_bdev)))
 		vbd->flush_support = true;
-	if (bdev_max_secure_erase_sectors(bdev_handle->bdev))
+	if (bdev_max_secure_erase_sectors(F_BDEV(f_bdev)))
 		vbd->discard_secure = true;
 
 	pr_debug("Successful creation of handle=%04x (dom=%u)\n",
@@ -570,7 +570,7 @@ static void xen_blkbk_discard(struct xenbus_transaction xbt, struct backend_info
 	struct xen_blkif *blkif = be->blkif;
 	int err;
 	int state = 0;
-	struct block_device *bdev = be->blkif->vbd.bdev_handle->bdev;
+	struct block_device *bdev = F_BDEV(be->blkif->vbd.f_bdev);
 
 	if (!xenbus_read_unsigned(dev->nodename, "discard-enable", 1))
 		return;
@@ -932,7 +932,7 @@ static void connect(struct backend_info *be)
 	}
 	err = xenbus_printf(xbt, dev->nodename, "sector-size", "%lu",
 			    (unsigned long)bdev_logical_block_size(
-					be->blkif->vbd.bdev_handle->bdev));
+					F_BDEV(be->blkif->vbd.f_bdev)));
 	if (err) {
 		xenbus_dev_fatal(dev, err, "writing %s/sector-size",
 				 dev->nodename);
@@ -940,7 +940,7 @@ static void connect(struct backend_info *be)
 	}
 	err = xenbus_printf(xbt, dev->nodename, "physical-sector-size", "%u",
 			    bdev_physical_block_size(
-					be->blkif->vbd.bdev_handle->bdev));
+					F_BDEV(be->blkif->vbd.f_bdev)));
 	if (err)
 		xenbus_dev_error(dev, err, "writing %s/physical-sector-size",
 				 dev->nodename);

-- 
2.42.0


