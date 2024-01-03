Return-Path: <linux-fsdevel+bounces-7183-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC0E5822D9C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 13:55:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70ADD1F23CEC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 12:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D60B199A4;
	Wed,  3 Jan 2024 12:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YVaLnsEf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B651419465;
	Wed,  3 Jan 2024 12:55:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEF00C433CB;
	Wed,  3 Jan 2024 12:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704286532;
	bh=L1B+sEXRETIx3ANuEWFkg77MUvIZc1j2UlM5lbdWQt8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=YVaLnsEfZjcAWDZHX2QkgEjc11sr64xbacMRlSMH8MrpdFxdgmi482Yf2/POihtu9
	 p/xzWp3sulgX5j0u89WN3g+VuGBmjvgbtYr1ZtIQWmjH1DYOooMzuONSs9lhrZYKv0
	 7I8oX8okMZLcQvHpTI1DOqIz6xg1ag2oHn3sMQ9SXaf/+oMGCTWzXcxwyAP7nRyK+7
	 D26IPfoN9NhPP07D1DDzMCUknEjD273gK0Uq7S8R8sIqpFB16ZbGfVlv2+FMIEOgip
	 ILkMI7uGPpwB5E3py+ygrYue8ZeC7W5pyCyTs0I0u7X4wQxydirL3/tD92VVEWrrGJ
	 muOjgZ6ma3Zgw==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 03 Jan 2024 13:55:00 +0100
Subject: [PATCH RFC 02/34] block/ioctl: port blkdev_bszset() to file
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240103-vfs-bdev-file-v1-2-6c8ee55fb6ef@kernel.org>
References: <20240103-vfs-bdev-file-v1-0-6c8ee55fb6ef@kernel.org>
In-Reply-To: <20240103-vfs-bdev-file-v1-0-6c8ee55fb6ef@kernel.org>
To: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, 
 Jens Axboe <axboe@kernel.dk>
Cc: "Darrick J. Wong" <djwong@kernel.org>, linux-fsdevel@vger.kernel.org, 
 linux-block@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-4e032
X-Developer-Signature: v=1; a=openpgp-sha256; l=972; i=brauner@kernel.org;
 h=from:subject:message-id; bh=L1B+sEXRETIx3ANuEWFkg77MUvIZc1j2UlM5lbdWQt8=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaROjbTWn3Bqj9DrX462r0x+PXS7XKfnIf2i6aW4YIHC4
 VXNlnFfOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACaixcDw383nYcvBy7Lpyo8j
 E9i9bXiOxnLkfF4uu5X99bsEs48uzgz/gx5viLRqzonetUgmZOk8We/LT8rMXr3M9J2bK/Dq4Nc
 9zAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 block/ioctl.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/block/ioctl.c b/block/ioctl.c
index 4160f4e6bd5b..d04641fe541c 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -468,7 +468,7 @@ static int blkdev_bszset(struct block_device *bdev, blk_mode_t mode,
 		int __user *argp)
 {
 	int ret, n;
-	struct bdev_handle *handle;
+	struct file *file;
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EACCES;
@@ -480,12 +480,11 @@ static int blkdev_bszset(struct block_device *bdev, blk_mode_t mode,
 	if (mode & BLK_OPEN_EXCL)
 		return set_blocksize(bdev, n);
 
-	handle = bdev_open_by_dev(bdev->bd_dev, mode, &bdev, NULL);
-	if (IS_ERR(handle))
+	file = bdev_file_open_by_dev(bdev->bd_dev, mode, &bdev, NULL);
+	if (IS_ERR(file))
 		return -EBUSY;
 	ret = set_blocksize(bdev, n);
-	bdev_release(handle);
-
+	fput(file);
 	return ret;
 }
 

-- 
2.42.0


