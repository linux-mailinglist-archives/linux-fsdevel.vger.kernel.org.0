Return-Path: <linux-fsdevel+bounces-69436-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 31652C7B352
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 19:05:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DBCF038215E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 18:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3B6D35389B;
	Fri, 21 Nov 2025 18:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LFHMs8dS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A6B35388B
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Nov 2025 18:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763748132; cv=none; b=CJ8PYugiQkdlZcPfaTaEVOdVzYJtIg/mgqnPvR1k81vzpdd1L/mC38eMzseSjEjVqw+LUZyjPCyee1DCW351eSkPEKDQmjbPpUvWSBWgiLZnaSMNSjKIWwgvi0JZ7o5TRJAYO/Yzwu06wSO4t6MksatfRUDWgngCBvn3Az8pnZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763748132; c=relaxed/simple;
	bh=coUZDCy5PRMyjX4WE5SpY9ZBROsAIFFLI8nR39fnM78=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FTfzZqAljjMfK/w17mcIHT+mTt+vRExFJJqqosp0c4wuGVUJvbtbsc98b8wxINMdfczG87W+AJGCD+ZugEAkgexzqG/S0R3phvYuhHWcsk5SVCChSzKVsogxE+bXjRyL4nkFtn83smTpWH6zVeIP3Zqm8cYZDPpwN6di1/T81Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LFHMs8dS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4AA6C116C6;
	Fri, 21 Nov 2025 18:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763748131;
	bh=coUZDCy5PRMyjX4WE5SpY9ZBROsAIFFLI8nR39fnM78=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=LFHMs8dSynX1vo3hRTu0UzptbDNIDRZnyoH1K/hSDOoJtYgR1yCSBElA24/da201b
	 KtCo/QFMsKqrD8uIM39SBTQXNr4f4jIifBpX9oqTcl9RkDhnz64yREBQZJCxkutbaf
	 Mje9+HAwoDMCdoj1qfsUh9SiYDSfh/lLZ4WtEVVWX8mXgHKYda5T3cVZbPb3ECpqO9
	 8xio3/KWeZ+623pkG0XAgkXofe+pd9Oi4S0xtR3V+WeaDNqasl6Myku/Y0ZRR/1+LZ
	 0QLc2y8V5SjuUvBkQmbzSIIGg7fW0WgRpNXTDE3KPqxvu8DKzG0QkhQu40RMJYvj0Q
	 TS21QjUiGkBqA==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 21 Nov 2025 19:01:17 +0100
Subject: [PATCH RFC v3 38/47] gpio: convert linehandle_create() to
 FD_PREPARE()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251121-work-fd-prepare-v3-38-2c6444d13e0e@kernel.org>
References: <20251121-work-fd-prepare-v3-0-2c6444d13e0e@kernel.org>
In-Reply-To: <20251121-work-fd-prepare-v3-0-2c6444d13e0e@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, 
 Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
 Jens Axboe <axboe@kernel.dk>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2424; i=brauner@kernel.org;
 h=from:subject:message-id; bh=coUZDCy5PRMyjX4WE5SpY9ZBROsAIFFLI8nR39fnM78=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQqrLh4yMmrrfXd9rmSvmFT5FPFl0QUSzH8fvOvrH/5y
 ykLuh41dJSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzE6RYjw++6bR+DJvdP15+h
 +SDFyoYvP+0RjyvHuynrf6W9XXX7QDsjQ+PdALvLa2N/Vr5sFglY18f28GmP7ekstoAeo/iOM7q
 ybAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 drivers/gpio/gpiolib-cdev.c | 61 ++++++++++++++++++++-------------------------
 1 file changed, 27 insertions(+), 34 deletions(-)

diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index 175836467f21..195bee9018fb 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -298,12 +298,35 @@ static const struct file_operations linehandle_fileops = {
 #endif
 };
 
+static int linehandle_fd_create(struct gpio_device *gdev,
+				struct linehandle_state *lh,
+				struct gpiohandle_request *handlereq,
+				void __user *ip)
+{
+	int ret;
+
+	FD_PREPARE(fdf, O_RDONLY | O_CLOEXEC,
+		   anon_inode_getfile("gpio-linehandle", &linehandle_fileops,
+				      lh, O_RDONLY | O_CLOEXEC));
+	ret = ACQUIRE_ERR(fd_prepare, &fdf);
+	if (ret)
+		return ret;
+
+	handlereq->fd = fd_prepare_fd(fdf);
+	if (copy_to_user(ip, handlereq, sizeof(handlereq)))
+		return -EFAULT;
+
+	dev_dbg(&gdev->dev, "registered chardev handle for %d lines\n", lh->num_descs);
+
+	fd_publish(fdf);
+	return 0;
+}
+
 static int linehandle_create(struct gpio_device *gdev, void __user *ip)
 {
 	struct gpiohandle_request handlereq;
 	struct linehandle_state *lh;
-	struct file *file;
-	int fd, i, ret;
+	int i, ret;
 	u32 lflags;
 
 	if (copy_from_user(&handlereq, ip, sizeof(handlereq)))
@@ -377,41 +400,11 @@ static int linehandle_create(struct gpio_device *gdev, void __user *ip)
 			offset);
 	}
 
-	fd = get_unused_fd_flags(O_RDONLY | O_CLOEXEC);
-	if (fd < 0) {
-		ret = fd;
+	ret = linehandle_fd_create(gdev, lh, &handlereq, ip);
+	if (ret)
 		goto out_free_lh;
-	}
-
-	file = anon_inode_getfile("gpio-linehandle",
-				  &linehandle_fileops,
-				  lh,
-				  O_RDONLY | O_CLOEXEC);
-	if (IS_ERR(file)) {
-		ret = PTR_ERR(file);
-		goto out_put_unused_fd;
-	}
-
-	handlereq.fd = fd;
-	if (copy_to_user(ip, &handlereq, sizeof(handlereq))) {
-		/*
-		 * fput() will trigger the release() callback, so do not go onto
-		 * the regular error cleanup path here.
-		 */
-		fput(file);
-		put_unused_fd(fd);
-		return -EFAULT;
-	}
-
-	fd_install(fd, file);
-
-	dev_dbg(&gdev->dev, "registered chardev handle for %d lines\n",
-		lh->num_descs);
-
 	return 0;
 
-out_put_unused_fd:
-	put_unused_fd(fd);
 out_free_lh:
 	linehandle_free(lh);
 	return ret;

-- 
2.47.3


