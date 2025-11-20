Return-Path: <linux-fsdevel+bounces-69319-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CF91C7687C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 23:35:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E19F14E4E54
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 22:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DD0F30CD8E;
	Thu, 20 Nov 2025 22:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="udKDaup+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3AC26FDA5
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Nov 2025 22:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763678018; cv=none; b=agk+vraOe7rQ5BwCkxVzRhaqi2ThX9GECUw6eKVLlRqp6uumyzNrSq2TDxKz8kWzDw5MJ3iqDye4cE5A2FHkUmqoZDYlQQhpWPg5/y8pJmDMyx33t8dIWlnhFkjGXLQHXdJaWxj/D7RD2CyoEkicJqxttHG+wVf6FYN5FSMQTEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763678018; c=relaxed/simple;
	bh=xAIeW2ZoP2TbOT6v2jTJI/a/uJJ45UGfu2VSTLlqIwc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Wjgq8sFzTCAFklO7ruQPj8AoBXq3ABtFco3p7/v+m1Mz9+oMvI7/w/XRmCrc33NWVbPXszQu+Btb2/RmqkjMZT6cQ7kR29gy3MUgDnMPfi6cJjv+E5IU07UymwOrR4K/nktK/ZRwjnlMB4mPDItQ37PxJA98wsWlKIamKtqA4y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=udKDaup+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEE20C113D0;
	Thu, 20 Nov 2025 22:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763678018;
	bh=xAIeW2ZoP2TbOT6v2jTJI/a/uJJ45UGfu2VSTLlqIwc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=udKDaup+8i7T/7zU0A0ZXtmNeIpRQQXfiwyt7r4eI2H2GOG3qOR9EGCYVmAAt5NRo
	 FZhQnRXE42pwW2hhDBFBwhEs+129nAjBB/kZg+2rTDLCAOkRR/Q5K/vNacIFSulWvz
	 Vnlg9DqhCTfXIdy7/d5MxNhiOGVz/+IuvXaDA/3xHqNFBVtfwHBz3gZpiX5CHzr8Ma
	 rcV1Vf/JZ76tXxYQ5GmSiMV4WMx43UdhSkSjuz2j2mrJCTHbgE6u67AuVchBIpRiRY
	 ApJrrK5FaiOkEh95ZSuAQnzmFXg1IfOrCKPpXCTOKQChmdyGpLePCO5nB3VXk6IzTj
	 pU55Gw1T3pshA==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 20 Nov 2025 23:32:36 +0100
Subject: [PATCH RFC v2 39/48] gpio: convert linehandle_create() to
 FD_PREPARE()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251120-work-fd-prepare-v2-39-fef6ebda05d3@kernel.org>
References: <20251120-work-fd-prepare-v2-0-fef6ebda05d3@kernel.org>
In-Reply-To: <20251120-work-fd-prepare-v2-0-fef6ebda05d3@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, 
 Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
 Jens Axboe <axboe@kernel.dk>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2117; i=brauner@kernel.org;
 h=from:subject:message-id; bh=xAIeW2ZoP2TbOT6v2jTJI/a/uJJ45UGfu2VSTLlqIwc=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTKT3vXksyqK7vpwMenvFFLl1qbeG2d/P1eUdKBJyevT
 7l3qEBsQUcpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBEHu9i+J+c6Bn3fAN/vn1Y
 03vvQ7Vce0tzJ4XJduZclVy78VFgtDLDX6HSzGPPX7osmeR+d0/gH/cQc1OmFYp+bxZGODLsmb/
 JhBUA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 drivers/gpio/gpiolib-cdev.c | 48 ++++++++++++++-------------------------------
 1 file changed, 15 insertions(+), 33 deletions(-)

diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index 175836467f21..18503927f0d3 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -302,8 +302,7 @@ static int linehandle_create(struct gpio_device *gdev, void __user *ip)
 {
 	struct gpiohandle_request handlereq;
 	struct linehandle_state *lh;
-	struct file *file;
-	int fd, i, ret;
+	int i, ret;
 	u32 lflags;
 
 	if (copy_from_user(&handlereq, ip, sizeof(handlereq)))
@@ -377,41 +376,24 @@ static int linehandle_create(struct gpio_device *gdev, void __user *ip)
 			offset);
 	}
 
-	fd = get_unused_fd_flags(O_RDONLY | O_CLOEXEC);
-	if (fd < 0) {
-		ret = fd;
-		goto out_free_lh;
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
+	FD_PREPARE(fdf, O_RDONLY | O_CLOEXEC,
+		   anon_inode_getfile("gpio-linehandle", &linehandle_fileops,
+				      lh, O_RDONLY | O_CLOEXEC)) {
+		if (fd_prepare_failed(fdf)) {
+			ret = fd_prepare_error(fdf);
+			goto out_free_lh;
+		}
 
-	fd_install(fd, file);
+		handlereq.fd = fd_prepare_fd(fdf);
+		if (copy_to_user(ip, &handlereq, sizeof(handlereq)))
+			return -EFAULT;
 
-	dev_dbg(&gdev->dev, "registered chardev handle for %d lines\n",
-		lh->num_descs);
+		dev_dbg(&gdev->dev, "registered chardev handle for %d lines\n",
+			lh->num_descs);
 
-	return 0;
+		return fd_publish(fdf);
+	}
 
-out_put_unused_fd:
-	put_unused_fd(fd);
 out_free_lh:
 	linehandle_free(lh);
 	return ret;

-- 
2.47.3


