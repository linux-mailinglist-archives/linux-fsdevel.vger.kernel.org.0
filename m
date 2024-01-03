Return-Path: <linux-fsdevel+bounces-7198-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C834B822DBD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 13:57:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35082284063
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 12:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B5F01A71B;
	Wed,  3 Jan 2024 12:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="triuUe03"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777651A72B;
	Wed,  3 Jan 2024 12:56:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE5CEC433C9;
	Wed,  3 Jan 2024 12:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704286564;
	bh=xoHXT+wi01B2qt/2QyF+kX91Rlyli//ZnLVNdODMNk0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=triuUe03rOkQXGCwJK+UFtbc7uR86ltVsd/DFTL2V4bjQybzP0zK7NZX5na0URvCy
	 z0sGgDDpPJvdS6TCR7j6/6S9NUBDVK1HUePUP0gVjapLJO1LF8V4t2XD91Asd5aeZs
	 0cBeWIMGNMgpahmFnQjIbQIE6ZXHhHzougkAPwoht6T3kbiDwfQPgtTxEPuSGbm4N6
	 g3mFWA0QWmoB64e2vGLDvaZV6KZYwf7KoYI4Y6oPJJ52ak9Ts9GlUBBhF38KorQlTS
	 fOnhUbkZQqzfTYP3dAyN+IeUvyFhJfDNcUusQbDuc90EAiyLfkPSv/u7stC+cOFJ4x
	 qCQJEpRz4l5Qw==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 03 Jan 2024 13:55:15 +0100
Subject: [PATCH RFC 17/34] target: port block device access to file
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240103-vfs-bdev-file-v1-17-6c8ee55fb6ef@kernel.org>
References: <20240103-vfs-bdev-file-v1-0-6c8ee55fb6ef@kernel.org>
In-Reply-To: <20240103-vfs-bdev-file-v1-0-6c8ee55fb6ef@kernel.org>
To: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, 
 Jens Axboe <axboe@kernel.dk>
Cc: "Darrick J. Wong" <djwong@kernel.org>, linux-fsdevel@vger.kernel.org, 
 linux-block@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-4e032
X-Developer-Signature: v=1; a=openpgp-sha256; l=5156; i=brauner@kernel.org;
 h=from:subject:message-id; bh=xoHXT+wi01B2qt/2QyF+kX91Rlyli//ZnLVNdODMNk0=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaROjbSZGrI7t7/1yGn+qQsLvsu6XvkR/+l9Q/2OAv+/y
 8/HXf92v6OUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAicp2MDHcfmTDHG7cd/Vy+
 5vxh5Qe127rYWXae23Foo+X29fs7fM8w/FNpuKt85dh8Tiv2kkSpxctOsDTKqPKovjj93vRTLvd
 zLQYA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 drivers/target/target_core_iblock.c | 18 +++++++++---------
 drivers/target/target_core_iblock.h |  2 +-
 drivers/target/target_core_pscsi.c  | 22 +++++++++++-----------
 drivers/target/target_core_pscsi.h  |  2 +-
 4 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/drivers/target/target_core_iblock.c b/drivers/target/target_core_iblock.c
index 8eb9eb7ce5df..79e79ec06856 100644
--- a/drivers/target/target_core_iblock.c
+++ b/drivers/target/target_core_iblock.c
@@ -91,7 +91,7 @@ static int iblock_configure_device(struct se_device *dev)
 {
 	struct iblock_dev *ib_dev = IBLOCK_DEV(dev);
 	struct request_queue *q;
-	struct bdev_handle *bdev_handle;
+	struct file *f_bdev;
 	struct block_device *bd;
 	struct blk_integrity *bi;
 	blk_mode_t mode = BLK_OPEN_READ;
@@ -117,14 +117,14 @@ static int iblock_configure_device(struct se_device *dev)
 	else
 		dev->dev_flags |= DF_READ_ONLY;
 
-	bdev_handle = bdev_open_by_path(ib_dev->ibd_udev_path, mode, ib_dev,
+	f_bdev = bdev_file_open_by_path(ib_dev->ibd_udev_path, mode, ib_dev,
 					NULL);
-	if (IS_ERR(bdev_handle)) {
-		ret = PTR_ERR(bdev_handle);
+	if (IS_ERR(f_bdev)) {
+		ret = PTR_ERR(f_bdev);
 		goto out_free_bioset;
 	}
-	ib_dev->ibd_bdev_handle = bdev_handle;
-	ib_dev->ibd_bd = bd = bdev_handle->bdev;
+	ib_dev->ibd_f_bdev = f_bdev;
+	ib_dev->ibd_bd = bd = F_BDEV(f_bdev);
 
 	q = bdev_get_queue(bd);
 
@@ -180,7 +180,7 @@ static int iblock_configure_device(struct se_device *dev)
 	return 0;
 
 out_blkdev_put:
-	bdev_release(ib_dev->ibd_bdev_handle);
+	fput(ib_dev->ibd_f_bdev);
 out_free_bioset:
 	bioset_exit(&ib_dev->ibd_bio_set);
 out:
@@ -205,8 +205,8 @@ static void iblock_destroy_device(struct se_device *dev)
 {
 	struct iblock_dev *ib_dev = IBLOCK_DEV(dev);
 
-	if (ib_dev->ibd_bdev_handle)
-		bdev_release(ib_dev->ibd_bdev_handle);
+	if (ib_dev->ibd_f_bdev)
+		fput(ib_dev->ibd_f_bdev);
 	bioset_exit(&ib_dev->ibd_bio_set);
 }
 
diff --git a/drivers/target/target_core_iblock.h b/drivers/target/target_core_iblock.h
index 683f9a55945b..769b6b7731a9 100644
--- a/drivers/target/target_core_iblock.h
+++ b/drivers/target/target_core_iblock.h
@@ -32,7 +32,7 @@ struct iblock_dev {
 	u32	ibd_flags;
 	struct bio_set	ibd_bio_set;
 	struct block_device *ibd_bd;
-	struct bdev_handle *ibd_bdev_handle;
+	struct file *ibd_f_bdev;
 	bool ibd_readonly;
 	struct iblock_dev_plug *ibd_plug;
 } ____cacheline_aligned;
diff --git a/drivers/target/target_core_pscsi.c b/drivers/target/target_core_pscsi.c
index 41b7489d37ce..9f7e423ed11b 100644
--- a/drivers/target/target_core_pscsi.c
+++ b/drivers/target/target_core_pscsi.c
@@ -352,7 +352,7 @@ static int pscsi_create_type_disk(struct se_device *dev, struct scsi_device *sd)
 	struct pscsi_hba_virt *phv = dev->se_hba->hba_ptr;
 	struct pscsi_dev_virt *pdv = PSCSI_DEV(dev);
 	struct Scsi_Host *sh = sd->host;
-	struct bdev_handle *bdev_handle;
+	struct file *f_bdev;
 	int ret;
 
 	if (scsi_device_get(sd)) {
@@ -366,18 +366,18 @@ static int pscsi_create_type_disk(struct se_device *dev, struct scsi_device *sd)
 	 * Claim exclusive struct block_device access to struct scsi_device
 	 * for TYPE_DISK and TYPE_ZBC using supplied udev_path
 	 */
-	bdev_handle = bdev_open_by_path(dev->udev_path,
+	f_bdev = bdev_file_open_by_path(dev->udev_path,
 				BLK_OPEN_WRITE | BLK_OPEN_READ, pdv, NULL);
-	if (IS_ERR(bdev_handle)) {
+	if (IS_ERR(f_bdev)) {
 		pr_err("pSCSI: bdev_open_by_path() failed\n");
 		scsi_device_put(sd);
-		return PTR_ERR(bdev_handle);
+		return PTR_ERR(f_bdev);
 	}
-	pdv->pdv_bdev_handle = bdev_handle;
+	pdv->pdv_f_bdev = f_bdev;
 
 	ret = pscsi_add_device_to_list(dev, sd);
 	if (ret) {
-		bdev_release(bdev_handle);
+		fput(f_bdev);
 		scsi_device_put(sd);
 		return ret;
 	}
@@ -564,9 +564,9 @@ static void pscsi_destroy_device(struct se_device *dev)
 		 * from pscsi_create_type_disk()
 		 */
 		if ((sd->type == TYPE_DISK || sd->type == TYPE_ZBC) &&
-		    pdv->pdv_bdev_handle) {
-			bdev_release(pdv->pdv_bdev_handle);
-			pdv->pdv_bdev_handle = NULL;
+		    pdv->pdv_f_bdev) {
+			fput(pdv->pdv_f_bdev);
+			pdv->pdv_f_bdev = NULL;
 		}
 		/*
 		 * For HBA mode PHV_LLD_SCSI_HOST_NO, release the reference
@@ -994,8 +994,8 @@ static sector_t pscsi_get_blocks(struct se_device *dev)
 {
 	struct pscsi_dev_virt *pdv = PSCSI_DEV(dev);
 
-	if (pdv->pdv_bdev_handle)
-		return bdev_nr_sectors(pdv->pdv_bdev_handle->bdev);
+	if (pdv->pdv_f_bdev)
+		return bdev_nr_sectors(F_BDEV(pdv->pdv_f_bdev));
 	return 0;
 }
 
diff --git a/drivers/target/target_core_pscsi.h b/drivers/target/target_core_pscsi.h
index b0a3ef136592..8cdbe3f32262 100644
--- a/drivers/target/target_core_pscsi.h
+++ b/drivers/target/target_core_pscsi.h
@@ -37,7 +37,7 @@ struct pscsi_dev_virt {
 	int	pdv_channel_id;
 	int	pdv_target_id;
 	int	pdv_lun_id;
-	struct bdev_handle *pdv_bdev_handle;
+	struct file *pdv_f_bdev;
 	struct scsi_device *pdv_sd;
 	struct Scsi_Host *pdv_lld_host;
 } ____cacheline_aligned;

-- 
2.42.0


