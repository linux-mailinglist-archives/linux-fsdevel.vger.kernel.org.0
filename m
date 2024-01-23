Return-Path: <linux-fsdevel+bounces-8572-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AC85839020
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 14:32:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 208501F24420
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 13:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E9ED60ECD;
	Tue, 23 Jan 2024 13:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fMBdj5Ht"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DEB960255;
	Tue, 23 Jan 2024 13:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706016484; cv=none; b=pf+Cr5MtDfVI1SjQXhNfxt4+CdA298FY8ZQJhejbBZu/UdHHudNH93KuUSgYplkhzQQQjBELh7bphCHAt40u2HOsz1rL29fGDyMbT2IadkyyykpTqWVLZjnMXvU8J4OxXN2w0Jh3fQXB3s1w5ZP1sriSzdV19FZ/dA9AGWbAk3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706016484; c=relaxed/simple;
	bh=fC70weLXZbhQZ9XoVrvnkfuLom4WpLfUXfZw7kFY/lM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GeSyyGqRWPYvUrlvHXVScT32JFhBFj8BpAkaCDPrN09NtFTzCuTw9JqR96Szyt4PnZus8/5bLVJz5JzcF7mz9k+KEhmCO5pI/edwMxeGmrKncRiQ6BscCE2C1fxExqSSgAtNaCoPIB/s3vNGHu7PibmmYkYbVchh5MI9uW2sP58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fMBdj5Ht; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41F4BC43143;
	Tue, 23 Jan 2024 13:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706016484;
	bh=fC70weLXZbhQZ9XoVrvnkfuLom4WpLfUXfZw7kFY/lM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=fMBdj5HtIEQQlOLQnQqqdDvcttJS9Xal2jsGCobxmk22JBr2G8r623y06Vt8tk2mX
	 IMYibTqwo5gBy+E+Bln/RZDOB6JaOfdRIR775luPU2H9ecKh/OgU3iIXwp0DnZJ4dB
	 SrZd/Xn2PZr9UrED4hTgNnlJolTK2NZrvCZ/URNhCPiHMsEx7oiBesrgb/Ky4LsB6w
	 9qUmy+OiTEeQy429r0DZWQJqDyIVqQZPCmURflWvDkkXGsPrh0IyIENwQx8gNg/Qm/
	 EcuTStzxcjFLBAJrT/PB/EAzsxjz9b5tW8QabYr3q9JQK9OTvBL8AaoEuDwXKvu5qe
	 oEZOYm5XXaAjw==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 23 Jan 2024 14:26:44 +0100
Subject: [PATCH v2 27/34] bdev: remove bdev_open_by_path()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240123-vfs-bdev-file-v2-27-adbd023e19cc@kernel.org>
References: <20240123-vfs-bdev-file-v2-0-adbd023e19cc@kernel.org>
In-Reply-To: <20240123-vfs-bdev-file-v2-0-adbd023e19cc@kernel.org>
To: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, 
 Jens Axboe <axboe@kernel.dk>
Cc: "Darrick J. Wong" <djwong@kernel.org>, linux-fsdevel@vger.kernel.org, 
 linux-block@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-4e032
X-Developer-Signature: v=1; a=openpgp-sha256; l=2348; i=brauner@kernel.org;
 h=from:subject:message-id; bh=fC70weLXZbhQZ9XoVrvnkfuLom4WpLfUXfZw7kFY/lM=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSu37dgSsCmr/WHJNdKX/rWfO6O17Nfkx/f4PHKOGWl3
 fjdj022r6OUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAiNvaMDP+C6hrnWVtwWDJv
 SP9VdzT9AcPV9vC3Go/4DsZI3bPYEsvIMMXuvu2Kaptrt10dn956MO+XVdBF4YqWO3f1Liearze
 LZgIA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 block/bdev.c           | 40 ----------------------------------------
 include/linux/blkdev.h |  2 --
 2 files changed, 42 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index 4246a57a7c5a..eb5607af6ec5 100644
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
index 76706aa47316..5880d5abfebe 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1484,8 +1484,6 @@ struct bdev_handle {
 
 struct bdev_handle *bdev_open_by_dev(dev_t dev, blk_mode_t mode, void *holder,
 		const struct blk_holder_ops *hops);
-struct bdev_handle *bdev_open_by_path(const char *path, blk_mode_t mode,
-		void *holder, const struct blk_holder_ops *hops);
 struct file *bdev_file_open_by_dev(dev_t dev, blk_mode_t mode, void *holder,
 		const struct blk_holder_ops *hops);
 struct file *bdev_file_open_by_path(const char *path, blk_mode_t mode,

-- 
2.43.0


