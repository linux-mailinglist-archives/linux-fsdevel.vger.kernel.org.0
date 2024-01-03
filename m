Return-Path: <linux-fsdevel+bounces-7184-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D05822D9E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 13:56:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B32CAB22383
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 12:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B2C1199B0;
	Wed,  3 Jan 2024 12:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fRy/LJxM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124CA199AD;
	Wed,  3 Jan 2024 12:55:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09DA7C433CA;
	Wed,  3 Jan 2024 12:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704286534;
	bh=+u2K3zuRzOORkTxeWdFEGbJR7iIhi6M9uJ5rQ5EvY4w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=fRy/LJxMUHpsfN7q4RaNhKIg0yFM2QQw+RgM/HsHEcl+ORS979wddE7r30eAbPLMQ
	 1NsxfQIfm5tWQ4LI1XCI7axXYL+Ly9QiXbiUyCzWAOZE00rymwu9qrPMF3kSDHpQM8
	 xNZO4ag5Y+Aa88BtciuA7V2lP0Au13xEUy39vKydmcmb506jzAt45BZ/UkK6Pequnm
	 EeQkId6kG93F64LTqFS7wggK33DEIaqjzVgttfGq6MV+epmRT9DxPDOQY1kQl3sJUE
	 Yt4BFxgZn/TGmcIpz8V2FobXBqNzob4nzkKVR74TtFQltBK7Kxa4bzRs0MQke2bw6k
	 bUiUemlBJ4UeA==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 03 Jan 2024 13:55:01 +0100
Subject: [PATCH RFC 03/34] block/genhd: port disk_scan_partitions() to file
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240103-vfs-bdev-file-v1-3-6c8ee55fb6ef@kernel.org>
References: <20240103-vfs-bdev-file-v1-0-6c8ee55fb6ef@kernel.org>
In-Reply-To: <20240103-vfs-bdev-file-v1-0-6c8ee55fb6ef@kernel.org>
To: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, 
 Jens Axboe <axboe@kernel.dk>
Cc: "Darrick J. Wong" <djwong@kernel.org>, linux-fsdevel@vger.kernel.org, 
 linux-block@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-4e032
X-Developer-Signature: v=1; a=openpgp-sha256; l=1101; i=brauner@kernel.org;
 h=from:subject:message-id; bh=+u2K3zuRzOORkTxeWdFEGbJR7iIhi6M9uJ5rQ5EvY4w=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaROjbTWF3M9JJj8o2rHo76/S4/mHV/SInAhPyTQPbBxi
 +7Fh4cKO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbiXMLI0HA248CXVo6f/fxN
 G28JRedE3OZc+GMf922NGmfLPe9qWBkZDnVs+cCyI4nx5Wfu/kfeZw/Ux/Z53jnEa7CKcz+jqe1
 JDgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 block/genhd.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index c9d06f72c587..bae0503fe6a2 100644
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
2.42.0


