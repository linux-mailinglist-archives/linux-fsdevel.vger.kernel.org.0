Return-Path: <linux-fsdevel+bounces-8576-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D30FA839027
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 14:33:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1214B1C273EB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 13:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AC6061675;
	Tue, 23 Jan 2024 13:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZNUn490S"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC5E26166B;
	Tue, 23 Jan 2024 13:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706016493; cv=none; b=Gi8EfsMisJ7RWGDzeWycdF8Gxz0hc22jU3WvWyJkKgpWrVEA1NCcQQGvw6dvwLmOejsd52sGu9uxkdbbdxRVA6lithmRZis/el48JAu+jKvz0B8BVttd+cUhmTsI8LdHu0h300qfkPrrBKmxdIJVBH6+qwXQEXPUNxJYsIfbWek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706016493; c=relaxed/simple;
	bh=yV7SVkSrYEeoPhuYb1An16VmhRZ0M1wCt75Ua4rfrVw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kvihLIPCWUswkKDAQD0H0uQUQCAVxFjn+gk9bjOsr4qvMV3VELwv+lFweCJtc1WSMUPnb6SIJb97YX8Gkk8J1IhfsyXg4W8L+GA4qt8Afjte+QcFEilbl3Kjm/WKtjhsblXw69nPunl08SXDwnch6EyIB//wvGqJhKWIvtY2IlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZNUn490S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA2FCC3278D;
	Tue, 23 Jan 2024 13:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706016493;
	bh=yV7SVkSrYEeoPhuYb1An16VmhRZ0M1wCt75Ua4rfrVw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ZNUn490SQ5eWY19uWO0/3TJKv7qQYPeLJTDRosLcaKz21PElVQC9scPCcB0BelVqQ
	 lKmvWQgbCvpruMPPjf/xENDeWMKMpdmCoh+fgROOeXGntJRuuXeZhyWvhhgAl4UsVK
	 m4vJtCUu6HaN+Y4KyJMs3e2eUMUQFbIvUwVhqabnfwv57Txb8SZM1TqYRqRYsZEwdM
	 fA1frTU359gAxcLIVZDgdKUc4ESzj4S6WaZfdM8pY99nhGDoKkzP8tJC6jY2rziB9V
	 y46/bZXaAXutQ3BcdwJfl813Pl+IkEfEE+In02OV+C2sj4FARfspbtdzjEkBF2qse7
	 gtNI9Ep/tGJlw==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 23 Jan 2024 14:26:48 +0100
Subject: [PATCH v2 31/34] block: use file->f_op to indicate restricted
 writes
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240123-vfs-bdev-file-v2-31-adbd023e19cc@kernel.org>
References: <20240123-vfs-bdev-file-v2-0-adbd023e19cc@kernel.org>
In-Reply-To: <20240123-vfs-bdev-file-v2-0-adbd023e19cc@kernel.org>
To: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, 
 Jens Axboe <axboe@kernel.dk>
Cc: "Darrick J. Wong" <djwong@kernel.org>, linux-fsdevel@vger.kernel.org, 
 linux-block@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-4e032
X-Developer-Signature: v=1; a=openpgp-sha256; l=3261; i=brauner@kernel.org;
 h=from:subject:message-id; bh=yV7SVkSrYEeoPhuYb1An16VmhRZ0M1wCt75Ua4rfrVw=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSu37eQJTxv7hPP+cWXzp0sDTB7Pl0l6+2MshSFNHMGu
 WOqAZelOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACYSqM3IMOG47CV3+ekuxtUb
 DZ/afjdr+i/vVnbh7tnIqcxBh9oqZzMyHNv2/DFrns299WV5e89b/F/xq9L+ZPrpI4c5XRTn9ez
 V5wIA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Make it possible to detected a block device that was opened with
restricted write access solely based on its file operations that it was
opened with. This avoids wasting an FMODE_* flag.

def_blk_fops isn't needed to check whether something is a block device
checking the inode type is enough for that. And def_blk_fops_restricted
can be kept private to the block layer.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 block/bdev.c | 16 ++++++++++++----
 block/blk.h  |  2 ++
 block/fops.c |  3 +++
 3 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index 71eaa1b5b7eb..9d96a43f198d 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -799,13 +799,16 @@ static void bdev_claim_write_access(struct block_device *bdev, blk_mode_t mode)
 		bdev->bd_writers++;
 }
 
-static void bdev_yield_write_access(struct block_device *bdev, blk_mode_t mode)
+static void bdev_yield_write_access(struct file *bdev_file, blk_mode_t mode)
 {
+	struct block_device *bdev;
+
 	if (bdev_allow_write_mounted)
 		return;
 
+	bdev = file_bdev(bdev_file);
 	/* Yield exclusive or shared write access. */
-	if (mode & BLK_OPEN_RESTRICT_WRITES)
+	if (bdev_file->f_op == &def_blk_fops_restricted)
 		bdev_unblock_writes(bdev);
 	else if (mode & BLK_OPEN_WRITE)
 		bdev->bd_writers--;
@@ -959,6 +962,7 @@ struct file *bdev_file_open_by_dev(dev_t dev, blk_mode_t mode, void *holder,
 				   const struct blk_holder_ops *hops)
 {
 	struct file *bdev_file;
+	const struct file_operations *blk_fops;
 	struct block_device *bdev;
 	unsigned int flags;
 	int ret;
@@ -972,8 +976,12 @@ struct file *bdev_file_open_by_dev(dev_t dev, blk_mode_t mode, void *holder,
 		return ERR_PTR(-ENXIO);
 
 	flags = blk_to_file_flags(mode);
+	if (mode & BLK_OPEN_RESTRICT_WRITES)
+		blk_fops = &def_blk_fops_restricted;
+	else
+		blk_fops = &def_blk_fops;
 	bdev_file = alloc_file_pseudo_noaccount(bdev->bd_inode,
-			blockdev_mnt, "", flags | O_LARGEFILE, &def_blk_fops);
+			blockdev_mnt, "", flags | O_LARGEFILE, blk_fops);
 	if (IS_ERR(bdev_file)) {
 		blkdev_put_no_open(bdev);
 		return bdev_file;
@@ -1033,7 +1041,7 @@ void bdev_release(struct file *bdev_file)
 		sync_blockdev(bdev);
 
 	mutex_lock(&disk->open_mutex);
-	bdev_yield_write_access(bdev, handle->mode);
+	bdev_yield_write_access(bdev_file, handle->mode);
 
 	if (handle->holder)
 		bd_end_claim(bdev, handle->holder);
diff --git a/block/blk.h b/block/blk.h
index 7ca24814f3a0..dfa958909c54 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -9,6 +9,8 @@
 
 struct elevator_type;
 
+extern const struct file_operations def_blk_fops_restricted;
+
 /* Max future timer expiry for timeouts */
 #define BLK_MAX_TIMEOUT		(5 * HZ)
 
diff --git a/block/fops.c b/block/fops.c
index 5589bf9c3822..f56bdfe459de 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -862,6 +862,9 @@ const struct file_operations def_blk_fops = {
 	.fallocate	= blkdev_fallocate,
 };
 
+/* Indicator that this block device is opened with restricted write access. */
+const struct file_operations def_blk_fops_restricted = def_blk_fops;
+
 static __init int blkdev_init(void)
 {
 	return bioset_init(&blkdev_dio_pool, 4,

-- 
2.43.0


