Return-Path: <linux-fsdevel+bounces-8548-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BAF00838FED
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 14:30:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 564521F234B6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 13:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABEED5FF0A;
	Tue, 23 Jan 2024 13:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VtrsCsyS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A7B5FEE0;
	Tue, 23 Jan 2024 13:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706016427; cv=none; b=miPW4QRvGC7O9ikmI2JsLpCo5Kt0T5VdJkMaVv3/w+hhrL2XbVyswMJuQByjjbud6GyvLDUWU10fI7nmwFM8dJSJG2ovBZGOqM6zKTF9/DDbi9Fko5pfmy4fHopOGy6PNIGl+rmZFhsaHUl2A5LBUcmpJjQNGOjJHbtYF+kknFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706016427; c=relaxed/simple;
	bh=w/BI/CWG6mKIPmQJcg3qPvG+S7M23Mv6gXz11R2lCts=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bo797QfoqE+EUhDXQKEPdKi5m9FJ+yKzUJcLainMUN2EacsOWwkWnV9797tmzBzK7HLvmMwPlcd6oMJt1lm2na9P+GhsVBGhTZxkhTqkUx9OL15uFCbZxYPQNMXMkJ7KKJDQcbyRZ9aOY/bHFh3sbgiUHeeTxH8uBQtT6DY1sOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VtrsCsyS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 277E1C433B1;
	Tue, 23 Jan 2024 13:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706016426;
	bh=w/BI/CWG6mKIPmQJcg3qPvG+S7M23Mv6gXz11R2lCts=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=VtrsCsySWz7+3QWyCNXdnozn51VjNS+Sz9dtAgw6LfBSexU3AahKaSoBN7VLf4m8b
	 zzZV3eGhuT8TXikgAgfsvWpWJrcT6X410v+fiD4gx29fIBhXoDvsOWV0w6MbRn5J4o
	 AJbi7TG0XBKeFYki5lafHYxpDlMfmH+a9ykHER9HSOeNNYi0GzFFUd+sjdw6DwP/gY
	 jwS3MLSiqZzChSpIrruLarfCVHPwVcigmZ/DJl0P5dWhlI7KqoxjffbjsExBKxVmaN
	 MnnhCuYg9o+0xo6hMOFpSTKo2Uw54jIqfw9HC7LuwhF/rLwHDe96453zmJVD4VgPyh
	 VvP6xNEPNA79A==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 23 Jan 2024 14:26:20 +0100
Subject: [PATCH v2 03/34] block/genhd: port disk_scan_partitions() to file
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240123-vfs-bdev-file-v2-3-adbd023e19cc@kernel.org>
References: <20240123-vfs-bdev-file-v2-0-adbd023e19cc@kernel.org>
In-Reply-To: <20240123-vfs-bdev-file-v2-0-adbd023e19cc@kernel.org>
To: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, 
 Jens Axboe <axboe@kernel.dk>
Cc: "Darrick J. Wong" <djwong@kernel.org>, linux-fsdevel@vger.kernel.org, 
 linux-block@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-4e032
X-Developer-Signature: v=1; a=openpgp-sha256; l=1511; i=brauner@kernel.org;
 h=from:subject:message-id; bh=w/BI/CWG6mKIPmQJcg3qPvG+S7M23Mv6gXz11R2lCts=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSu3zcv6MMLodj7R2r4nlqtKQ6UUZl65ddx4US9sEsmQ
 lXf7sdXdpSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEyk6TXDP+1PLaLWj0z+rkhq
 t9Bxky88Yej1pUjEmj/LqGr+XPMF+xkZLp5+3bWxSOQ0Z91DD9cZHkZ/Aw0Kd6T8m7TW5VHQjm4
 zHgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

This may run from a kernel thread via device_add_disk(). So this could
also use __fput_sync() if we were worried about EBUSY. But when it is
called from a kernel thread it's always BLK_OPEN_READ so EBUSY can't
really happen even if we do BLK_OPEN_RESTRICT_WRITES or BLK_OPEN_EXCL.

Otherwise it's called from an ioctl on the block device which is only
called from userspace and can rely on task work.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 block/genhd.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index d74fb5b4ae68..a911d2969c07 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -342,7 +342,7 @@ EXPORT_SYMBOL_GPL(disk_uevent);
 
 int disk_scan_partitions(struct gendisk *disk, blk_mode_t mode)
 {
-	struct bdev_handle *handle;
+	struct file *file;
 	int ret = 0;
 
 	if (disk->flags & (GENHD_FL_NO_PART | GENHD_FL_HIDDEN))
@@ -366,12 +366,12 @@ int disk_scan_partitions(struct gendisk *disk, blk_mode_t mode)
 	}
 
 	set_bit(GD_NEED_PART_SCAN, &disk->state);
-	handle = bdev_open_by_dev(disk_devt(disk), mode & ~BLK_OPEN_EXCL, NULL,
-				  NULL);
-	if (IS_ERR(handle))
-		ret = PTR_ERR(handle);
+	file = bdev_file_open_by_dev(disk_devt(disk), mode & ~BLK_OPEN_EXCL,
+				     NULL, NULL);
+	if (IS_ERR(file))
+		ret = PTR_ERR(file);
 	else
-		bdev_release(handle);
+		fput(file);
 
 	/*
 	 * If blkdev_get_by_dev() failed early, GD_NEED_PART_SCAN is still set,

-- 
2.43.0


