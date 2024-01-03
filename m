Return-Path: <linux-fsdevel+bounces-7208-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56F1C822DD2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 13:58:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57A9F1C2348A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 12:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 534701C2AC;
	Wed,  3 Jan 2024 12:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="azIPV4j5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE3D1C289;
	Wed,  3 Jan 2024 12:56:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3C45C433CA;
	Wed,  3 Jan 2024 12:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704286585;
	bh=zKpbTwDSSErN4oTBoA1ZuGoBeMNaSB+oZPYayS5Lk6o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=azIPV4j5i8sXVlFKxTcc+cifAalu3DiBAlAYD83XDFzXllfB6tJZqTbzxtO+4t6w2
	 pqJc3rkdgU57o/wBcpfXq1PvlpPrbDneDnHbyAhUyRaukXJ0SO0HbKWKhYKpRxT3ve
	 2fvrp6q5UeZvRnEV8iEvMFaCXKuGirFXiL0tyLv5WllDsklQMZXcKpSSfisIZWwPrc
	 uQ+VY9m2Rz5cYVDfxJLWjLHu+Kzbsmlhk/vVEZ4yolp/S3X8HsA6ZeVBO9NKg4QZXK
	 7afZAHHpUgGivqNPGPiAElZWYDr5IlI4HXBB3iFS+zR4fnatNXKwuGH7OEaGcQfFs3
	 XTUEMYMIdnwdQ==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 03 Jan 2024 13:55:25 +0100
Subject: [PATCH RFC 27/34] bdev: remove bdev_open_by_path()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240103-vfs-bdev-file-v1-27-6c8ee55fb6ef@kernel.org>
References: <20240103-vfs-bdev-file-v1-0-6c8ee55fb6ef@kernel.org>
In-Reply-To: <20240103-vfs-bdev-file-v1-0-6c8ee55fb6ef@kernel.org>
To: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, 
 Jens Axboe <axboe@kernel.dk>
Cc: "Darrick J. Wong" <djwong@kernel.org>, linux-fsdevel@vger.kernel.org, 
 linux-block@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-4e032
X-Developer-Signature: v=1; a=openpgp-sha256; l=2348; i=brauner@kernel.org;
 h=from:subject:message-id; bh=zKpbTwDSSErN4oTBoA1ZuGoBeMNaSB+oZPYayS5Lk6o=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaROjbTN4Mxgk3v7OfZnpMXtzn29Z29vvvum3dfn1FnLZ
 xO+Mt6u7ChlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZiI1B5GhsubN4ov3bi9/h1f
 2ZYrHBtvRC49Lvpq1SnhCK77/IySWfcZ/ucXFCypmsfP+a7wlUfPxv2b8nKXXf507NmivbOf3Dt
 7kIkdAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 block/bdev.c           | 40 ----------------------------------------
 include/linux/blkdev.h |  2 --
 2 files changed, 42 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index 853731fb41ed..a5a1b6cd51ee 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -1007,46 +1007,6 @@ struct file *bdev_file_open_by_path(const char *path, blk_mode_t mode,
 }
 EXPORT_SYMBOL(bdev_file_open_by_path);
 
-/**
- * bdev_open_by_path - open a block device by name
- * @path: path to the block device to open
- * @mode: open mode (BLK_OPEN_*)
- * @holder: exclusive holder identifier
- * @hops: holder operations
- *
- * Open the block device described by the device file at @path.  If @holder is
- * not %NULL, the block device is opened with exclusive access.  Exclusive opens
- * may nest for the same @holder.
- *
- * CONTEXT:
- * Might sleep.
- *
- * RETURNS:
- * Handle with a reference to the block_device on success, ERR_PTR(-errno) on
- * failure.
- */
-struct bdev_handle *bdev_open_by_path(const char *path, blk_mode_t mode,
-		void *holder, const struct blk_holder_ops *hops)
-{
-	struct bdev_handle *handle;
-	dev_t dev;
-	int error;
-
-	error = lookup_bdev(path, &dev);
-	if (error)
-		return ERR_PTR(error);
-
-	handle = bdev_open_by_dev(dev, mode, holder, hops);
-	if (!IS_ERR(handle) && (mode & BLK_OPEN_WRITE) &&
-	    bdev_read_only(handle->bdev)) {
-		bdev_release(handle);
-		return ERR_PTR(-EACCES);
-	}
-
-	return handle;
-}
-EXPORT_SYMBOL(bdev_open_by_path);
-
 void bdev_release(struct bdev_handle *handle)
 {
 	struct block_device *bdev = handle->bdev;
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index e8d11083acbc..8864b978fdb0 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1506,8 +1506,6 @@ struct bdev_handle {
 
 struct bdev_handle *bdev_open_by_dev(dev_t dev, blk_mode_t mode, void *holder,
 		const struct blk_holder_ops *hops);
-struct bdev_handle *bdev_open_by_path(const char *path, blk_mode_t mode,
-		void *holder, const struct blk_holder_ops *hops);
 struct file *bdev_file_open_by_dev(dev_t dev, blk_mode_t mode, void *holder,
 		const struct blk_holder_ops *hops);
 struct file *bdev_file_open_by_path(const char *path, blk_mode_t mode,

-- 
2.42.0


