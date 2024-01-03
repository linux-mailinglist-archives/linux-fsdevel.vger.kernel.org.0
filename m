Return-Path: <linux-fsdevel+bounces-7196-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80981822DB9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 13:57:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3057E28372E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 12:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0FD71A293;
	Wed,  3 Jan 2024 12:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rIvASnEw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165BF199A2;
	Wed,  3 Jan 2024 12:56:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5886DC433C7;
	Wed,  3 Jan 2024 12:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704286559;
	bh=qvHa0SQvBTTp9hnRUTS52VRn92SrlHZBR1JnfbI+qME=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=rIvASnEw1d06Gju2+1iknAmts/pG5OURqXES7oXF0Owr5nodJQiAlz5vcMag2hHgf
	 wv6q0p9xNRwfGGvwkDypCohVp/AIQ8POyXPJbNz1ZRPS7m2ry161dKVGcNl0yuTx1M
	 SD616U9xSp4d4ISZlmkqvcMD3kgJNXs+qP4gnuu4EAs/GwQRPChWPZb0q/Ko7HewMn
	 t2BRketaoPzzjZz9+stVa68nOw7wnZC12d5KhLh7c9sD9LvXELvwZGEZ2YA8sEW7IX
	 iTEZ1aY+HTrrwptSdfttccdwkWULWNieeyJAorYYyJdABKsHZiqYksv8yzybWveEdR
	 9k+IksadzosTQ==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 03 Jan 2024 13:55:13 +0100
Subject: [PATCH RFC 15/34] nvme: port block device access to file
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240103-vfs-bdev-file-v1-15-6c8ee55fb6ef@kernel.org>
References: <20240103-vfs-bdev-file-v1-0-6c8ee55fb6ef@kernel.org>
In-Reply-To: <20240103-vfs-bdev-file-v1-0-6c8ee55fb6ef@kernel.org>
To: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, 
 Jens Axboe <axboe@kernel.dk>
Cc: "Darrick J. Wong" <djwong@kernel.org>, linux-fsdevel@vger.kernel.org, 
 linux-block@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-4e032
X-Developer-Signature: v=1; a=openpgp-sha256; l=1947; i=brauner@kernel.org;
 h=from:subject:message-id; bh=qvHa0SQvBTTp9hnRUTS52VRn92SrlHZBR1JnfbI+qME=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaROjbQJbHnrZfZzsfsVvWVxZ6rCeiaI8BQdfn+tLa9wy
 8KYwtkxHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABPRXc/wPzAmYnaGUCL/B2uL
 uFnfzzKk63dUfjuXW7+491Vj46/t0xj+x3zeu0cg/tQmkzPZoi4Nks6KvwqNz5nZJKvPrJp07V0
 5PwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 drivers/nvme/target/io-cmd-bdev.c | 16 ++++++++--------
 drivers/nvme/target/nvmet.h       |  2 +-
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index f11400a908f2..60dff841aa97 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -50,10 +50,10 @@ void nvmet_bdev_set_limits(struct block_device *bdev, struct nvme_id_ns *id)
 
 void nvmet_bdev_ns_disable(struct nvmet_ns *ns)
 {
-	if (ns->bdev_handle) {
-		bdev_release(ns->bdev_handle);
+	if (ns->f_bdev) {
+		fput(ns->f_bdev);
 		ns->bdev = NULL;
-		ns->bdev_handle = NULL;
+		ns->f_bdev = NULL;
 	}
 }
 
@@ -85,18 +85,18 @@ int nvmet_bdev_ns_enable(struct nvmet_ns *ns)
 	if (ns->buffered_io)
 		return -ENOTBLK;
 
-	ns->bdev_handle = bdev_open_by_path(ns->device_path,
+	ns->f_bdev = bdev_file_open_by_path(ns->device_path,
 				BLK_OPEN_READ | BLK_OPEN_WRITE, NULL, NULL);
-	if (IS_ERR(ns->bdev_handle)) {
-		ret = PTR_ERR(ns->bdev_handle);
+	if (IS_ERR(ns->f_bdev)) {
+		ret = PTR_ERR(ns->f_bdev);
 		if (ret != -ENOTBLK) {
 			pr_err("failed to open block device %s: (%d)\n",
 					ns->device_path, ret);
 		}
-		ns->bdev_handle = NULL;
+		ns->f_bdev = NULL;
 		return ret;
 	}
-	ns->bdev = ns->bdev_handle->bdev;
+	ns->bdev = F_BDEV(ns->f_bdev);
 	ns->size = bdev_nr_bytes(ns->bdev);
 	ns->blksize_shift = blksize_bits(bdev_logical_block_size(ns->bdev));
 
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 6c8acebe1a1a..1d8a007e572d 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -58,7 +58,7 @@
 
 struct nvmet_ns {
 	struct percpu_ref	ref;
-	struct bdev_handle	*bdev_handle;
+	struct file		*f_bdev;
 	struct block_device	*bdev;
 	struct file		*file;
 	bool			readonly;

-- 
2.42.0


