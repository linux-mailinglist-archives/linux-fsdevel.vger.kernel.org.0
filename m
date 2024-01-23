Return-Path: <linux-fsdevel+bounces-8555-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93592838FFA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 14:30:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CA692910CA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 13:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C260860879;
	Tue, 23 Jan 2024 13:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SeCSZ4rY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0725F85C;
	Tue, 23 Jan 2024 13:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706016444; cv=none; b=UWJS3Exj13/Nm5X8dGBbPF4uNG2FRzU3bG8cEVXPnbYMfMsdgPcagz9tDt+o09X8BXiiXQdS0VGLIfz6+qtXmfYRbVFSsqwwR8oHt1NBy2kJ+D7SS6GKG/zHgziBgaI1nWSOcwZlvudl3y80QgAYwKiTL/IlRalqew94SWwCji4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706016444; c=relaxed/simple;
	bh=UCP9PrBWBhxlxr7GX987d6xnXV+DZ1q4VCgfjRa1gws=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uy5gXr0IyOgRwasDYMO4xISNoyHdl/5VCO1OcS6wiWNoRToaLwANERAbO4LGM2bmwOH8Q88FvPA/wblayT3Z8F8/a2GW6F0QXHX/R/nVTqcVr7j0JjQusZG4VEOeLqLajcfIFqq1PIvZI70nktcJhNpsS5l57a61fOwez5xsKy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SeCSZ4rY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F354C4163B;
	Tue, 23 Jan 2024 13:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706016443;
	bh=UCP9PrBWBhxlxr7GX987d6xnXV+DZ1q4VCgfjRa1gws=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=SeCSZ4rYaYFLixTuSo25kCur7CZWgzeJeBuKg5iA6sjhJhSscpv7TCEIAnbcGfkkL
	 RqsciqU7qcr8lr+5JTlUq0Uyewv5KKb87MJF65KCuDY8lqCYieEpkgPc1OkcDcObGY
	 RcpCLsTnOv+Nz/e5ZWISBku027ZFrAJ4BTQzGGQ7/E4pibNQrCIKYTWPv2lGnRq7zG
	 +XPWExOsq7Mf+jIJsilM4RtowBVi9l4kfctoGUpUHGZx6Hk/IzNVaPTfuv5oicK93o
	 0xqU+H6JzeogCu3RuQIRGm7BB9uoNcGJy/DwvirI90V0cglQivzapdzrvznM4anMaA
	 YVcyxJ32xdKIQ==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 23 Jan 2024 14:26:27 +0100
Subject: [PATCH v2 10/34] rnbd: port block device access to file
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240123-vfs-bdev-file-v2-10-adbd023e19cc@kernel.org>
References: <20240123-vfs-bdev-file-v2-0-adbd023e19cc@kernel.org>
In-Reply-To: <20240123-vfs-bdev-file-v2-0-adbd023e19cc@kernel.org>
To: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, 
 Jens Axboe <axboe@kernel.dk>
Cc: "Darrick J. Wong" <djwong@kernel.org>, linux-fsdevel@vger.kernel.org, 
 linux-block@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-4e032
X-Developer-Signature: v=1; a=openpgp-sha256; l=5077; i=brauner@kernel.org;
 h=from:subject:message-id; bh=UCP9PrBWBhxlxr7GX987d6xnXV+DZ1q4VCgfjRa1gws=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSu3zf/dLRk9efG1KY594P/33j2c/3nqQvEjj29p7WFy
 yLx8+V71ztKWRjEuBhkxRRZHNpNwuWW81RsNsrUgJnDygQyhIGLUwAmoubMyDDbwVl+1dfH6Z9F
 6pXmFXxZ672/1b2/+voc4brbr1d3B+oyMkyc/PfNJ6NUh0jLxw1fP3tG+G15pLqSw6w2s8Xn0Nz
 XX5kB
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 drivers/block/rnbd/rnbd-srv.c | 28 ++++++++++++++--------------
 drivers/block/rnbd/rnbd-srv.h |  2 +-
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/block/rnbd/rnbd-srv.c b/drivers/block/rnbd/rnbd-srv.c
index 3a0d5dcec6f2..f6e3a3c4b76c 100644
--- a/drivers/block/rnbd/rnbd-srv.c
+++ b/drivers/block/rnbd/rnbd-srv.c
@@ -145,7 +145,7 @@ static int process_rdma(struct rnbd_srv_session *srv_sess,
 	priv->sess_dev = sess_dev;
 	priv->id = id;
 
-	bio = bio_alloc(sess_dev->bdev_handle->bdev, 1,
+	bio = bio_alloc(file_bdev(sess_dev->bdev_file), 1,
 			rnbd_to_bio_flags(le32_to_cpu(msg->rw)), GFP_KERNEL);
 	if (bio_add_page(bio, virt_to_page(data), datalen,
 			offset_in_page(data)) != datalen) {
@@ -219,7 +219,7 @@ void rnbd_destroy_sess_dev(struct rnbd_srv_sess_dev *sess_dev, bool keep_id)
 	rnbd_put_sess_dev(sess_dev);
 	wait_for_completion(&dc); /* wait for inflights to drop to zero */
 
-	bdev_release(sess_dev->bdev_handle);
+	fput(sess_dev->bdev_file);
 	mutex_lock(&sess_dev->dev->lock);
 	list_del(&sess_dev->dev_list);
 	if (!sess_dev->readonly)
@@ -534,7 +534,7 @@ rnbd_srv_get_or_create_srv_dev(struct block_device *bdev,
 static void rnbd_srv_fill_msg_open_rsp(struct rnbd_msg_open_rsp *rsp,
 					struct rnbd_srv_sess_dev *sess_dev)
 {
-	struct block_device *bdev = sess_dev->bdev_handle->bdev;
+	struct block_device *bdev = file_bdev(sess_dev->bdev_file);
 
 	rsp->hdr.type = cpu_to_le16(RNBD_MSG_OPEN_RSP);
 	rsp->device_id = cpu_to_le32(sess_dev->device_id);
@@ -560,7 +560,7 @@ static void rnbd_srv_fill_msg_open_rsp(struct rnbd_msg_open_rsp *rsp,
 static struct rnbd_srv_sess_dev *
 rnbd_srv_create_set_sess_dev(struct rnbd_srv_session *srv_sess,
 			      const struct rnbd_msg_open *open_msg,
-			      struct bdev_handle *handle, bool readonly,
+			      struct file *bdev_file, bool readonly,
 			      struct rnbd_srv_dev *srv_dev)
 {
 	struct rnbd_srv_sess_dev *sdev = rnbd_sess_dev_alloc(srv_sess);
@@ -572,7 +572,7 @@ rnbd_srv_create_set_sess_dev(struct rnbd_srv_session *srv_sess,
 
 	strscpy(sdev->pathname, open_msg->dev_name, sizeof(sdev->pathname));
 
-	sdev->bdev_handle	= handle;
+	sdev->bdev_file		= bdev_file;
 	sdev->sess		= srv_sess;
 	sdev->dev		= srv_dev;
 	sdev->readonly		= readonly;
@@ -678,7 +678,7 @@ static int process_msg_open(struct rnbd_srv_session *srv_sess,
 	struct rnbd_srv_dev *srv_dev;
 	struct rnbd_srv_sess_dev *srv_sess_dev;
 	const struct rnbd_msg_open *open_msg = msg;
-	struct bdev_handle *bdev_handle;
+	struct file *bdev_file;
 	blk_mode_t open_flags = BLK_OPEN_READ;
 	char *full_path;
 	struct rnbd_msg_open_rsp *rsp = data;
@@ -716,15 +716,15 @@ static int process_msg_open(struct rnbd_srv_session *srv_sess,
 		goto reject;
 	}
 
-	bdev_handle = bdev_open_by_path(full_path, open_flags, NULL, NULL);
-	if (IS_ERR(bdev_handle)) {
-		ret = PTR_ERR(bdev_handle);
+	bdev_file = bdev_file_open_by_path(full_path, open_flags, NULL, NULL);
+	if (IS_ERR(bdev_file)) {
+		ret = PTR_ERR(bdev_file);
 		pr_err("Opening device '%s' on session %s failed, failed to open the block device, err: %pe\n",
-		       full_path, srv_sess->sessname, bdev_handle);
+		       full_path, srv_sess->sessname, bdev_file);
 		goto free_path;
 	}
 
-	srv_dev = rnbd_srv_get_or_create_srv_dev(bdev_handle->bdev, srv_sess,
+	srv_dev = rnbd_srv_get_or_create_srv_dev(file_bdev(bdev_file), srv_sess,
 						  open_msg->access_mode);
 	if (IS_ERR(srv_dev)) {
 		pr_err("Opening device '%s' on session %s failed, creating srv_dev failed, err: %pe\n",
@@ -734,7 +734,7 @@ static int process_msg_open(struct rnbd_srv_session *srv_sess,
 	}
 
 	srv_sess_dev = rnbd_srv_create_set_sess_dev(srv_sess, open_msg,
-				bdev_handle,
+				bdev_file,
 				open_msg->access_mode == RNBD_ACCESS_RO,
 				srv_dev);
 	if (IS_ERR(srv_sess_dev)) {
@@ -750,7 +750,7 @@ static int process_msg_open(struct rnbd_srv_session *srv_sess,
 	 */
 	mutex_lock(&srv_dev->lock);
 	if (!srv_dev->dev_kobj.state_in_sysfs) {
-		ret = rnbd_srv_create_dev_sysfs(srv_dev, bdev_handle->bdev);
+		ret = rnbd_srv_create_dev_sysfs(srv_dev, file_bdev(bdev_file));
 		if (ret) {
 			mutex_unlock(&srv_dev->lock);
 			rnbd_srv_err(srv_sess_dev,
@@ -793,7 +793,7 @@ static int process_msg_open(struct rnbd_srv_session *srv_sess,
 	}
 	rnbd_put_srv_dev(srv_dev);
 blkdev_put:
-	bdev_release(bdev_handle);
+	fput(bdev_file);
 free_path:
 	kfree(full_path);
 reject:
diff --git a/drivers/block/rnbd/rnbd-srv.h b/drivers/block/rnbd/rnbd-srv.h
index 343cc682b617..18d873808b8d 100644
--- a/drivers/block/rnbd/rnbd-srv.h
+++ b/drivers/block/rnbd/rnbd-srv.h
@@ -46,7 +46,7 @@ struct rnbd_srv_dev {
 struct rnbd_srv_sess_dev {
 	/* Entry inside rnbd_srv_dev struct */
 	struct list_head		dev_list;
-	struct bdev_handle		*bdev_handle;
+	struct file			*bdev_file;
 	struct rnbd_srv_session		*sess;
 	struct rnbd_srv_dev		*dev;
 	struct kobject                  kobj;

-- 
2.43.0


