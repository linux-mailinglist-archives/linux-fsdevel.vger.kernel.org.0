Return-Path: <linux-fsdevel+bounces-69318-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 63C5DC76894
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 23:36:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id BC5502FD84
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 22:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B433363C6F;
	Thu, 20 Nov 2025 22:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e/RrUJAg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B8C2FDC41
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Nov 2025 22:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763678016; cv=none; b=nDDFhIRp167nFvtK9sOutcFwxnOLelglUBfCH05cGy5+lEksDxN5twEWjwWt6+/l9Mx8/+INJsLeDb+fbCm0qrOf/mCrSxXhGcg2Qmu6WT5b3En+wwwkVrOsPs2xdKobUC229q2pFVNJVCUFM98ksmDCpYoEdkRHRkXRVXRlHTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763678016; c=relaxed/simple;
	bh=wHRxDr9Q7wUNmVTw9WCoKuF55LwDsktDIfSV/4ZQjKU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H2w+CWKvCpTVY5IW2NEPuOwEH4BAgsnw0fG3C9XJNijI0Ln9+RUPnbpd280Zw1MayJFGPirsxDgB4bCA9sckRV4WxslOBAZCwlkavOqfT4hr8pVaoPlhYyyY2HmJPGLUwYpxvi+ohKuGUtOzzgJNWxe77OXP9j36ZDTOp9uNE70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e/RrUJAg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1418C116B1;
	Thu, 20 Nov 2025 22:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763678016;
	bh=wHRxDr9Q7wUNmVTw9WCoKuF55LwDsktDIfSV/4ZQjKU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=e/RrUJAgBhfiCXZSnFIfUK5tXKsGEdWyf4u2LCr7PmSl+YVg8bGAiRqdHuSawQSeh
	 hbYpaimKmxFKTcs219lne4ymuFeZkAhIwUbx+6s/L2JjwCF/ZVPX+5pj4l+Caa3ApJ
	 jenVO1Dy7GcVfpNe+OxOvwWiW2ZFPqJxZ0lB39JlcUWxO0KDbK24u+y5upeT8I2T/T
	 6wNrpESoMk95wMe3MZ13JiaQYGgmlcsYawzOX6FZxbPCiTDoTmvK2TtbTYsuz8EPI1
	 f+SDgtrkh5GJwveNSq49eutJOUrj0n152mPYCDelIyOZHP4YbLWDoCh7xb9esMOM6j
	 KvyuiStTyQG/w==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 20 Nov 2025 23:32:35 +0100
Subject: [PATCH RFC v2 38/48] dma: port sw_sync_ioctl_create_fence() to
 FD_PREPARE()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251120-work-fd-prepare-v2-38-fef6ebda05d3@kernel.org>
References: <20251120-work-fd-prepare-v2-0-fef6ebda05d3@kernel.org>
In-Reply-To: <20251120-work-fd-prepare-v2-0-fef6ebda05d3@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, 
 Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
 Jens Axboe <axboe@kernel.dk>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1909; i=brauner@kernel.org;
 h=from:subject:message-id; bh=wHRxDr9Q7wUNmVTw9WCoKuF55LwDsktDIfSV/4ZQjKU=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTKT3t36OJX0+9BTvzT1JXOpij52b9d2rQiTyd5P9dtI
 8slj+1iO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACYSs4GR4Vp1sj9nkaH17hrN
 WS6+7fytPfuF817blXf1ZvA1eOpbMzJsPnPOlnm72F9zff60ANXTUv4LBV3rflupHDzQsvuxTDc
 7AA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 drivers/dma-buf/sw_sync.c | 45 ++++++++++++++++-----------------------------
 1 file changed, 16 insertions(+), 29 deletions(-)

diff --git a/drivers/dma-buf/sw_sync.c b/drivers/dma-buf/sw_sync.c
index 3c20f1d31cf5..271bfa0c7d1f 100644
--- a/drivers/dma-buf/sw_sync.c
+++ b/drivers/dma-buf/sw_sync.c
@@ -343,47 +343,34 @@ static int sw_sync_debugfs_release(struct inode *inode, struct file *file)
 static long sw_sync_ioctl_create_fence(struct sync_timeline *obj,
 				       unsigned long arg)
 {
-	int fd = get_unused_fd_flags(O_CLOEXEC);
-	int err;
 	struct sync_pt *pt;
 	struct sync_file *sync_file;
 	struct sw_sync_create_fence_data data;
 
-	if (fd < 0)
-		return fd;
-
-	if (copy_from_user(&data, (void __user *)arg, sizeof(data))) {
-		err = -EFAULT;
-		goto err;
-	}
+	if (copy_from_user(&data, (void __user *)arg, sizeof(data)))
+		return -EFAULT;
 
 	pt = sync_pt_create(obj, data.value);
-	if (!pt) {
-		err = -ENOMEM;
-		goto err;
-	}
+	if (!pt)
+		return -ENOMEM;
 
 	sync_file = sync_file_create(&pt->base);
 	dma_fence_put(&pt->base);
-	if (!sync_file) {
-		err = -ENOMEM;
-		goto err;
-	}
-
-	data.fence = fd;
-	if (copy_to_user((void __user *)arg, &data, sizeof(data))) {
-		fput(sync_file->file);
-		err = -EFAULT;
-		goto err;
-	}
+	if (!sync_file)
+		return -ENOMEM;
 
-	fd_install(fd, sync_file->file);
+	FD_PREPARE(fdf, O_CLOEXEC, sync_file->file) {
+		if (fd_prepare_failed(fdf)) {
+			fput(sync_file->file);
+			return fd_prepare_error(fdf);
+		}
 
-	return 0;
+		data.fence = fd_prepare_fd(fdf);
+		if (copy_to_user((void __user *)arg, &data, sizeof(data)))
+			return -EFAULT;
 
-err:
-	put_unused_fd(fd);
-	return err;
+		return fd_publish(fdf);
+	}
 }
 
 static long sw_sync_ioctl_inc(struct sync_timeline *obj, unsigned long arg)

-- 
2.47.3


