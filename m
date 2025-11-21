Return-Path: <linux-fsdevel+bounces-69441-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5291FC7B358
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 19:06:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3474F4EB5BE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 18:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5305B3538BB;
	Fri, 21 Nov 2025 18:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hFoOHaV1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6677E34846A
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Nov 2025 18:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763748142; cv=none; b=TWQNA3XdjCHvL/fbAj8sybGAZ6Yw0V/+PhAZwD8U+QVGjeI9kFEZ+qZjtkT7xpceW65jxRlpDVO01xwlRZE4sI9Nb+6F+RGktFmr9PJ2ca0RktyvVsHSoMzcPFQmcD2YnHHQOp+XOf8cScfTy8MhUN5nG+75Nx9vNc8fVRohqZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763748142; c=relaxed/simple;
	bh=Sr8NsX+viYSPRINKfSx/vBbE4oUwogrQ5wZeHiYHtak=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tb62kiPmjePfxMQX1+8yBSU5je4/Zv5L5XoVBROCEnDdrR/Bg2aCrUupsoiB83CTS+gZX3a+v6X/kF5MhgjqRZdtYxHGRyQfZSKYrM3a6veoENOgy/xEdQIKEEs8GRT73oso74CIpAPFcOkbYWwqbD5mEzGvsYYMAmn/S4M/eXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hFoOHaV1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95D89C116D0;
	Fri, 21 Nov 2025 18:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763748142;
	bh=Sr8NsX+viYSPRINKfSx/vBbE4oUwogrQ5wZeHiYHtak=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hFoOHaV1fvreq4Ona+SQR+CxSeCHWRTxJBcSZ1wiWzj2mVgib9tBi31unZUBjiyg8
	 bGT4fJmxOqtMjRc1Sg/CiS7kx2SKUyHg+9VOwAn+HYN4LtGdkSfuDTmD2eDtA3xJJ8
	 NZCPz2BKtIopQ2lpmD0CNwlLkDPrTo6g1NY3PBLvAKlo4RX46dGd4DmIWNlWIBQ6B+
	 FfffPvZ5qgcSLFc2qu1uSF09t6PGMfutojJn2Q+x/Xw3L/L9O0hv4mv5WLlqsgCMaM
	 sfH1KTIpI2WH5DnVMBvPe31ciiDshqzZWotVVnj1Gfq7tQBsf4hg594u2jseA6snLZ
	 unrQfN9LZdxzQ==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 21 Nov 2025 19:01:22 +0100
Subject: [PATCH RFC v3 43/47] vfio: convert
 vfio_group_ioctl_get_device_fd() to FD_PREPARE()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251121-work-fd-prepare-v3-43-2c6444d13e0e@kernel.org>
References: <20251121-work-fd-prepare-v3-0-2c6444d13e0e@kernel.org>
In-Reply-To: <20251121-work-fd-prepare-v3-0-2c6444d13e0e@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, 
 Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
 Jens Axboe <axboe@kernel.dk>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1408; i=brauner@kernel.org;
 h=from:subject:message-id; bh=Sr8NsX+viYSPRINKfSx/vBbE4oUwogrQ5wZeHiYHtak=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQqrLhob37mLcf7xVfij79u2hh13nqV5CyVeHEuDlGt1
 6bSz53EO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACZyVYKR4dP0O/9XM827ahZ+
 LJa/YvPMkCyT7clL7zw66tuXFHZGRI7hD1dboe+OBYFLriVteHG4fo3a3CclE1m5E1/d2eZ5/8A
 fHm4A
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 drivers/vfio/group.c | 27 ++++++---------------------
 1 file changed, 6 insertions(+), 21 deletions(-)

diff --git a/drivers/vfio/group.c b/drivers/vfio/group.c
index c376a6279de0..7f706991b867 100644
--- a/drivers/vfio/group.c
+++ b/drivers/vfio/group.c
@@ -299,9 +299,7 @@ static int vfio_group_ioctl_get_device_fd(struct vfio_group *group,
 					  char __user *arg)
 {
 	struct vfio_device *device;
-	struct file *filep;
 	char *buf;
-	int fdno;
 	int ret;
 
 	buf = strndup_user(arg, PAGE_SIZE);
@@ -313,26 +311,13 @@ static int vfio_group_ioctl_get_device_fd(struct vfio_group *group,
 	if (IS_ERR(device))
 		return PTR_ERR(device);
 
-	fdno = get_unused_fd_flags(O_CLOEXEC);
-	if (fdno < 0) {
-		ret = fdno;
-		goto err_put_device;
-	}
-
-	filep = vfio_device_open_file(device);
-	if (IS_ERR(filep)) {
-		ret = PTR_ERR(filep);
-		goto err_put_fdno;
+	FD_PREPARE(fdf, O_CLOEXEC, vfio_device_open_file(device));
+	ret = ACQUIRE_ERR(fd_prepare, &fdf);
+	if (ret) {
+		vfio_device_put_registration(device);
+		return ret;
 	}
-
-	fd_install(fdno, filep);
-	return fdno;
-
-err_put_fdno:
-	put_unused_fd(fdno);
-err_put_device:
-	vfio_device_put_registration(device);
-	return ret;
+	return fd_publish(fdf);
 }
 
 static int vfio_group_ioctl_get_status(struct vfio_group *group,

-- 
2.47.3


