Return-Path: <linux-fsdevel+bounces-8562-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7986983900A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 14:31:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E79F51F212BE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 13:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2330B60DCF;
	Tue, 23 Jan 2024 13:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pv6dwA8g"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85AD160DC1;
	Tue, 23 Jan 2024 13:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706016460; cv=none; b=W9RRohzWSyCUjiBpcIqgu91FEEqYRBMjExctc/v6BTg8WlJQvuSQAffN1U4OHFOVh8nYN36UrZYzY3Ikt3kqVrd26RkKvU86DO6upI5j8SNlHC6Y3gigwbpyCvECI/8qOSsAsaIl3B/2+5K2Ut9i8oZf/IskYs5q243c5FbCe2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706016460; c=relaxed/simple;
	bh=AbLpJlqIN5gmhItRxYi8zwA/uYtqbYgjYPa+2u3UvDM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DTvwzNu8MV97RlHBqjFfOW6UNrSiAQMT5hP+iTD4xyR60zFo+g3rIjWlwyNzcXefxsrsWEZZxb9piRJWU6hpTgecqQU6RMwDiD0MtKPebhp9CHmzUM5iGgq/Slq4ftEXx9k4kmhbd7i8dO4852/5jgxtE14wF29idjEh5DIoenQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pv6dwA8g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18BB6C43394;
	Tue, 23 Jan 2024 13:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706016460;
	bh=AbLpJlqIN5gmhItRxYi8zwA/uYtqbYgjYPa+2u3UvDM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Pv6dwA8gZXDsFbT/L5pOEXAfHObeW98Ck8wVNSck2OInHL2dokVz5ux9Ozg0bfP+2
	 cUGGWZldMOWy5nhi/6hvHeRVjTkQl2EYZ8YZImTfnnGBMd3fatW0wQ3f7brWle13ft
	 B0sYi7hBC/LUgPlFO2JcAuagpLe3R3MkpDXIPzG3k9dfRiG7/89T5qdU2aghBwc72/
	 gzCgbyZJS023oeh09UlLvwerOT5AK5T6U/O4VWuzPan+79l3D/dptgvNwQFtd6H6O/
	 eBZbBz/NLXAYmf4HPkhQURn2YIZo7WsDId1h7VkAHazy5zIytVuDzkj8FaJW3Uipdx
	 JJCny/AvPd95A==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 23 Jan 2024 14:26:34 +0100
Subject: [PATCH v2 17/34] target: port block device access to file
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240123-vfs-bdev-file-v2-17-adbd023e19cc@kernel.org>
References: <20240123-vfs-bdev-file-v2-0-adbd023e19cc@kernel.org>
In-Reply-To: <20240123-vfs-bdev-file-v2-0-adbd023e19cc@kernel.org>
To: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, 
 Jens Axboe <axboe@kernel.dk>
Cc: "Darrick J. Wong" <djwong@kernel.org>, linux-fsdevel@vger.kernel.org, 
 linux-block@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-4e032
X-Developer-Signature: v=1; a=openpgp-sha256; l=5234; i=brauner@kernel.org;
 h=from:subject:message-id; bh=AbLpJlqIN5gmhItRxYi8zwA/uYtqbYgjYPa+2u3UvDM=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSu3ze/o8Ynb3Pk7W8PPrlVx5n5WJ29/lHOyK01ffMdc
 ak5vRqmHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABP5e4mR4X8jh3bir8Xlp0N1
 As7XVz06x7LSYb7WIo3CJvnAA7c4cxj+Z6ZpTg2VnFHpPGNmoRvDZfW1X1UL084/D9zx8qWcHuc
 aDgA=
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
index 8eb9eb7ce5df..7f6ca8177845 100644
--- a/drivers/target/target_core_iblock.c
+++ b/drivers/target/target_core_iblock.c
@@ -91,7 +91,7 @@ static int iblock_configure_device(struct se_device *dev)
 {
 	struct iblock_dev *ib_dev = IBLOCK_DEV(dev);
 	struct request_queue *q;
-	struct bdev_handle *bdev_handle;
+	struct file *bdev_file;
 	struct block_device *bd;
 	struct blk_integrity *bi;
 	blk_mode_t mode = BLK_OPEN_READ;
@@ -117,14 +117,14 @@ static int iblock_configure_device(struct se_device *dev)
 	else
 		dev->dev_flags |= DF_READ_ONLY;
 
-	bdev_handle = bdev_open_by_path(ib_dev->ibd_udev_path, mode, ib_dev,
+	bdev_file = bdev_file_open_by_path(ib_dev->ibd_udev_path, mode, ib_dev,
 					NULL);
-	if (IS_ERR(bdev_handle)) {
-		ret = PTR_ERR(bdev_handle);
+	if (IS_ERR(bdev_file)) {
+		ret = PTR_ERR(bdev_file);
 		goto out_free_bioset;
 	}
-	ib_dev->ibd_bdev_handle = bdev_handle;
-	ib_dev->ibd_bd = bd = bdev_handle->bdev;
+	ib_dev->ibd_bdev_file = bdev_file;
+	ib_dev->ibd_bd = bd = file_bdev(bdev_file);
 
 	q = bdev_get_queue(bd);
 
@@ -180,7 +180,7 @@ static int iblock_configure_device(struct se_device *dev)
 	return 0;
 
 out_blkdev_put:
-	bdev_release(ib_dev->ibd_bdev_handle);
+	fput(ib_dev->ibd_bdev_file);
 out_free_bioset:
 	bioset_exit(&ib_dev->ibd_bio_set);
 out:
@@ -205,8 +205,8 @@ static void iblock_destroy_device(struct se_device *dev)
 {
 	struct iblock_dev *ib_dev = IBLOCK_DEV(dev);
 
-	if (ib_dev->ibd_bdev_handle)
-		bdev_release(ib_dev->ibd_bdev_handle);
+	if (ib_dev->ibd_bdev_file)
+		fput(ib_dev->ibd_bdev_file);
 	bioset_exit(&ib_dev->ibd_bio_set);
 }
 
diff --git a/drivers/target/target_core_iblock.h b/drivers/target/target_core_iblock.h
index 683f9a55945b..91f6f4280666 100644
--- a/drivers/target/target_core_iblock.h
+++ b/drivers/target/target_core_iblock.h
@@ -32,7 +32,7 @@ struct iblock_dev {
 	u32	ibd_flags;
 	struct bio_set	ibd_bio_set;
 	struct block_device *ibd_bd;
-	struct bdev_handle *ibd_bdev_handle;
+	struct file *ibd_bdev_file;
 	bool ibd_readonly;
 	struct iblock_dev_plug *ibd_plug;
 } ____cacheline_aligned;
diff --git a/drivers/target/target_core_pscsi.c b/drivers/target/target_core_pscsi.c
index 41b7489d37ce..9aedd682d10c 100644
--- a/drivers/target/target_core_pscsi.c
+++ b/drivers/target/target_core_pscsi.c
@@ -352,7 +352,7 @@ static int pscsi_create_type_disk(struct se_device *dev, struct scsi_device *sd)
 	struct pscsi_hba_virt *phv = dev->se_hba->hba_ptr;
 	struct pscsi_dev_virt *pdv = PSCSI_DEV(dev);
 	struct Scsi_Host *sh = sd->host;
-	struct bdev_handle *bdev_handle;
+	struct file *bdev_file;
 	int ret;
 
 	if (scsi_device_get(sd)) {
@@ -366,18 +366,18 @@ static int pscsi_create_type_disk(struct se_device *dev, struct scsi_device *sd)
 	 * Claim exclusive struct block_device access to struct scsi_device
 	 * for TYPE_DISK and TYPE_ZBC using supplied udev_path
 	 */
-	bdev_handle = bdev_open_by_path(dev->udev_path,
+	bdev_file = bdev_file_open_by_path(dev->udev_path,
 				BLK_OPEN_WRITE | BLK_OPEN_READ, pdv, NULL);
-	if (IS_ERR(bdev_handle)) {
+	if (IS_ERR(bdev_file)) {
 		pr_err("pSCSI: bdev_open_by_path() failed\n");
 		scsi_device_put(sd);
-		return PTR_ERR(bdev_handle);
+		return PTR_ERR(bdev_file);
 	}
-	pdv->pdv_bdev_handle = bdev_handle;
+	pdv->pdv_bdev_file = bdev_file;
 
 	ret = pscsi_add_device_to_list(dev, sd);
 	if (ret) {
-		bdev_release(bdev_handle);
+		fput(bdev_file);
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
+		    pdv->pdv_bdev_file) {
+			fput(pdv->pdv_bdev_file);
+			pdv->pdv_bdev_file = NULL;
 		}
 		/*
 		 * For HBA mode PHV_LLD_SCSI_HOST_NO, release the reference
@@ -994,8 +994,8 @@ static sector_t pscsi_get_blocks(struct se_device *dev)
 {
 	struct pscsi_dev_virt *pdv = PSCSI_DEV(dev);
 
-	if (pdv->pdv_bdev_handle)
-		return bdev_nr_sectors(pdv->pdv_bdev_handle->bdev);
+	if (pdv->pdv_bdev_file)
+		return bdev_nr_sectors(file_bdev(pdv->pdv_bdev_file));
 	return 0;
 }
 
diff --git a/drivers/target/target_core_pscsi.h b/drivers/target/target_core_pscsi.h
index b0a3ef136592..9acaa21e4c78 100644
--- a/drivers/target/target_core_pscsi.h
+++ b/drivers/target/target_core_pscsi.h
@@ -37,7 +37,7 @@ struct pscsi_dev_virt {
 	int	pdv_channel_id;
 	int	pdv_target_id;
 	int	pdv_lun_id;
-	struct bdev_handle *pdv_bdev_handle;
+	struct file *pdv_bdev_file;
 	struct scsi_device *pdv_sd;
 	struct Scsi_Host *pdv_lld_host;
 } ____cacheline_aligned;

-- 
2.43.0


