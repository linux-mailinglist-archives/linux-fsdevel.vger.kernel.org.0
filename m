Return-Path: <linux-fsdevel+bounces-7191-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0ED6822DAE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 13:56:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B73AB2298E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 12:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 198491A703;
	Wed,  3 Jan 2024 12:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="peFQDMso"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843221A5B5;
	Wed,  3 Jan 2024 12:55:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCBB6C433C8;
	Wed,  3 Jan 2024 12:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704286549;
	bh=gUlJGbwQM/Tvz70GqGux5aXGVz5fJJJBN/HbpMr9nDQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=peFQDMsoJfyTel+udKHo75p1FUK6i6ssJ10+X0J8w8VW/t2GNRW9dXACJ4Hpw4FoO
	 nqgydYrVQHUX8zhpSJOcZLP4tb55v2HnJwASTBgfsYdOggl80Y4c/Hyovo20D+k1Jf
	 XF5f1TUlgahEUw45qw3R6CgV5W6w5PCBvSsi9mrJxK+Auuo4/xVQfl3GQEE/cOmqwb
	 2D7Ej9SvrknJWhGN3O7HIULI+eN+yW3M8kr9A8FesG1wyWrw3gpcOE+XvW35Wye1s3
	 Zh8SzTCQzW6mDt8KhGtuPnkYi4+m5CSDakV7Gl7SLFDNn9hamZmLnirnRgvx7tmsdf
	 3iRTySsBnSafQ==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 03 Jan 2024 13:55:08 +0100
Subject: [PATCH RFC 10/34] rnbd: port block device access to file
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240103-vfs-bdev-file-v1-10-6c8ee55fb6ef@kernel.org>
References: <20240103-vfs-bdev-file-v1-0-6c8ee55fb6ef@kernel.org>
In-Reply-To: <20240103-vfs-bdev-file-v1-0-6c8ee55fb6ef@kernel.org>
To: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, 
 Jens Axboe <axboe@kernel.dk>
Cc: "Darrick J. Wong" <djwong@kernel.org>, linux-fsdevel@vger.kernel.org, 
 linux-block@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-4e032
X-Developer-Signature: v=1; a=openpgp-sha256; l=4955; i=brauner@kernel.org;
 h=from:subject:message-id; bh=gUlJGbwQM/Tvz70GqGux5aXGVz5fJJJBN/HbpMr9nDQ=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaROjbRxm3UlVWgG43IvGfnkqDdhfZGzlwQvnTBXbPLjL
 ofpi61Wd5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEykX4yRYd368yacAs7X7u3n
 KNifdP6E3xaz7DtpKkECi013hT+6ZcvIcPaDX1Xg3x2fZVgCdEyEFOZkl1VaRu+cJVd6+n9z3fP
 l/AA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 drivers/block/rnbd/rnbd-srv.c | 26 +++++++++++++-------------
 drivers/block/rnbd/rnbd-srv.h |  2 +-
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/block/rnbd/rnbd-srv.c b/drivers/block/rnbd/rnbd-srv.c
index 65de51f3dfd9..2aeedca4ba21 100644
--- a/drivers/block/rnbd/rnbd-srv.c
+++ b/drivers/block/rnbd/rnbd-srv.c
@@ -145,7 +145,7 @@ static int process_rdma(struct rnbd_srv_session *srv_sess,
 	priv->sess_dev = sess_dev;
 	priv->id = id;
 
-	bio = bio_alloc(sess_dev->bdev_handle->bdev, 1,
+	bio = bio_alloc(F_BDEV(sess_dev->f_bdev), 1,
 			rnbd_to_bio_flags(le32_to_cpu(msg->rw)), GFP_KERNEL);
 	if (bio_add_page(bio, virt_to_page(data), datalen,
 			offset_in_page(data)) != datalen) {
@@ -219,7 +219,7 @@ void rnbd_destroy_sess_dev(struct rnbd_srv_sess_dev *sess_dev, bool keep_id)
 	rnbd_put_sess_dev(sess_dev);
 	wait_for_completion(&dc); /* wait for inflights to drop to zero */
 
-	bdev_release(sess_dev->bdev_handle);
+	fput(sess_dev->f_bdev);
 	mutex_lock(&sess_dev->dev->lock);
 	list_del(&sess_dev->dev_list);
 	if (!sess_dev->readonly)
@@ -534,7 +534,7 @@ rnbd_srv_get_or_create_srv_dev(struct block_device *bdev,
 static void rnbd_srv_fill_msg_open_rsp(struct rnbd_msg_open_rsp *rsp,
 					struct rnbd_srv_sess_dev *sess_dev)
 {
-	struct block_device *bdev = sess_dev->bdev_handle->bdev;
+	struct block_device *bdev = F_BDEV(sess_dev->f_bdev);
 
 	rsp->hdr.type = cpu_to_le16(RNBD_MSG_OPEN_RSP);
 	rsp->device_id = cpu_to_le32(sess_dev->device_id);
@@ -559,7 +559,7 @@ static void rnbd_srv_fill_msg_open_rsp(struct rnbd_msg_open_rsp *rsp,
 static struct rnbd_srv_sess_dev *
 rnbd_srv_create_set_sess_dev(struct rnbd_srv_session *srv_sess,
 			      const struct rnbd_msg_open *open_msg,
-			      struct bdev_handle *handle, bool readonly,
+			      struct file *f_bdev, bool readonly,
 			      struct rnbd_srv_dev *srv_dev)
 {
 	struct rnbd_srv_sess_dev *sdev = rnbd_sess_dev_alloc(srv_sess);
@@ -571,7 +571,7 @@ rnbd_srv_create_set_sess_dev(struct rnbd_srv_session *srv_sess,
 
 	strscpy(sdev->pathname, open_msg->dev_name, sizeof(sdev->pathname));
 
-	sdev->bdev_handle	= handle;
+	sdev->f_bdev		= f_bdev;
 	sdev->sess		= srv_sess;
 	sdev->dev		= srv_dev;
 	sdev->readonly		= readonly;
@@ -676,7 +676,7 @@ static int process_msg_open(struct rnbd_srv_session *srv_sess,
 	struct rnbd_srv_dev *srv_dev;
 	struct rnbd_srv_sess_dev *srv_sess_dev;
 	const struct rnbd_msg_open *open_msg = msg;
-	struct bdev_handle *bdev_handle;
+	struct file *f_bdev;
 	blk_mode_t open_flags = BLK_OPEN_READ;
 	char *full_path;
 	struct rnbd_msg_open_rsp *rsp = data;
@@ -714,15 +714,15 @@ static int process_msg_open(struct rnbd_srv_session *srv_sess,
 		goto reject;
 	}
 
-	bdev_handle = bdev_open_by_path(full_path, open_flags, NULL, NULL);
-	if (IS_ERR(bdev_handle)) {
-		ret = PTR_ERR(bdev_handle);
+	f_bdev = bdev_file_open_by_path(full_path, open_flags, NULL, NULL);
+	if (IS_ERR(f_bdev)) {
+		ret = PTR_ERR(f_bdev);
 		pr_err("Opening device '%s' on session %s failed, failed to open the block device, err: %d\n",
 		       full_path, srv_sess->sessname, ret);
 		goto free_path;
 	}
 
-	srv_dev = rnbd_srv_get_or_create_srv_dev(bdev_handle->bdev, srv_sess,
+	srv_dev = rnbd_srv_get_or_create_srv_dev(F_BDEV(f_bdev), srv_sess,
 						  open_msg->access_mode);
 	if (IS_ERR(srv_dev)) {
 		pr_err("Opening device '%s' on session %s failed, creating srv_dev failed, err: %ld\n",
@@ -732,7 +732,7 @@ static int process_msg_open(struct rnbd_srv_session *srv_sess,
 	}
 
 	srv_sess_dev = rnbd_srv_create_set_sess_dev(srv_sess, open_msg,
-				bdev_handle,
+				f_bdev,
 				open_msg->access_mode == RNBD_ACCESS_RO,
 				srv_dev);
 	if (IS_ERR(srv_sess_dev)) {
@@ -748,7 +748,7 @@ static int process_msg_open(struct rnbd_srv_session *srv_sess,
 	 */
 	mutex_lock(&srv_dev->lock);
 	if (!srv_dev->dev_kobj.state_in_sysfs) {
-		ret = rnbd_srv_create_dev_sysfs(srv_dev, bdev_handle->bdev);
+		ret = rnbd_srv_create_dev_sysfs(srv_dev, F_BDEV(f_bdev));
 		if (ret) {
 			mutex_unlock(&srv_dev->lock);
 			rnbd_srv_err(srv_sess_dev,
@@ -791,7 +791,7 @@ static int process_msg_open(struct rnbd_srv_session *srv_sess,
 	}
 	rnbd_put_srv_dev(srv_dev);
 blkdev_put:
-	bdev_release(bdev_handle);
+	fput(f_bdev);
 free_path:
 	kfree(full_path);
 reject:
diff --git a/drivers/block/rnbd/rnbd-srv.h b/drivers/block/rnbd/rnbd-srv.h
index 343cc682b617..c91973f4326e 100644
--- a/drivers/block/rnbd/rnbd-srv.h
+++ b/drivers/block/rnbd/rnbd-srv.h
@@ -46,7 +46,7 @@ struct rnbd_srv_dev {
 struct rnbd_srv_sess_dev {
 	/* Entry inside rnbd_srv_dev struct */
 	struct list_head		dev_list;
-	struct bdev_handle		*bdev_handle;
+	struct file			*f_bdev;
 	struct rnbd_srv_session		*sess;
 	struct rnbd_srv_dev		*dev;
 	struct kobject                  kobj;

-- 
2.42.0


