Return-Path: <linux-fsdevel+bounces-69301-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EEF2C76855
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 23:34:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D540B4E333C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 22:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70367363C6F;
	Thu, 20 Nov 2025 22:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iYCnLWeg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB4D3112AD
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Nov 2025 22:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763677980; cv=none; b=FdvTVtOZOfLxCbSz5wk6WFuPK7v1nz6R2hHZ2RKB9spaoyyOCi2sW5MvzTEk8G9pTFFWAjN+Ri8Q3V7vdvNz730Jpfx4hmiM6qYvW1x8uN7d0VHVMfT/mR9VRtRLu+z3WBSrsfRcGeHrZIkZb6LVgOuWDDLNIyczflI2JiQFjmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763677980; c=relaxed/simple;
	bh=bRnzIOsV8+oOCDF0WjzjDQ5r7sWOshKY4V+YsMs9JHI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kpy1PGmN/+hlod3AxY1F0473kzLgvJrPpZWGGFXERa7yjUcDAi5Ur2n5gAAE8I4Zq1WN7Wq8LW/0dAbM55C6ZBN/1HhsXKq/f4D55NkAnF6u+KkN6CiWVVnTLofsRqVT0J79XlMNTFpmoRAirbFkm0fN6z4o31BoR0kCuCPsn9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iYCnLWeg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24FF8C4CEF1;
	Thu, 20 Nov 2025 22:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763677980;
	bh=bRnzIOsV8+oOCDF0WjzjDQ5r7sWOshKY4V+YsMs9JHI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=iYCnLWegM8eZD/DF6Wgo3vZwSbT8uAdI9N7rR0me1tKHDqhu9F02f1ChZNviXBy7c
	 MPhOPrRvtIiGvb6kkl5CLK2T6MLVl5f0uLrt7VwUPPD3BZD44EtEUtNlhVTpmJG/2I
	 DQr9sWCqezKtANum+M48GtATU/lsQUqjkA0LGmvawOp+j13xhvffxaYfaOsi5QuNHh
	 heqFQTfZGufDuDrX94olg7gc9BvHs1frtp1PGqZhsVY8KKtERCnrwh4JyP1NpLaaDl
	 lLYsfJvkGNWXD7R8D3uRKZ/JpYlyCP7OUnd1H27lO17z/kXlon482Fgk7d5RPoKJb/
	 Dh4BYlSeQTizg==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 20 Nov 2025 23:32:18 +0100
Subject: [PATCH RFC v2 21/48] dma: convert sync_file_ioctl_merge() to
 FD_PREPARE()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251120-work-fd-prepare-v2-21-fef6ebda05d3@kernel.org>
References: <20251120-work-fd-prepare-v2-0-fef6ebda05d3@kernel.org>
In-Reply-To: <20251120-work-fd-prepare-v2-0-fef6ebda05d3@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, 
 Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
 Jens Axboe <axboe@kernel.dk>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2167; i=brauner@kernel.org;
 h=from:subject:message-id; bh=bRnzIOsV8+oOCDF0WjzjDQ5r7sWOshKY4V+YsMs9JHI=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTKT3urVv/ZMEy7fHni8Y2HzkVJH+WJ6vtrM6V01yfJV
 LdXJ/ZzdpSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEyk7yfDX7nvd2z2PBDtmGp4
 vGv5usqPsy4fqQxI2C0+4fDDW7fkXZMZ/qme/BOwoDl3kZkUfxnPlZSCqNmxgbbmx/Ku/6k7Od1
 qEyMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 drivers/dma-buf/sync_file.c | 55 ++++++++++++++++-----------------------------
 1 file changed, 19 insertions(+), 36 deletions(-)

diff --git a/drivers/dma-buf/sync_file.c b/drivers/dma-buf/sync_file.c
index 747e377fb954..f11f67551e6d 100644
--- a/drivers/dma-buf/sync_file.c
+++ b/drivers/dma-buf/sync_file.c
@@ -213,56 +213,39 @@ static __poll_t sync_file_poll(struct file *file, poll_table *wait)
 static long sync_file_ioctl_merge(struct sync_file *sync_file,
 				  unsigned long arg)
 {
-	int fd = get_unused_fd_flags(O_CLOEXEC);
-	int err;
 	struct sync_file *fence2, *fence3;
 	struct sync_merge_data data;
 
-	if (fd < 0)
-		return fd;
-
-	if (copy_from_user(&data, (void __user *)arg, sizeof(data))) {
-		err = -EFAULT;
-		goto err_put_fd;
-	}
+	if (copy_from_user(&data, (void __user *)arg, sizeof(data)))
+		return -EFAULT;
 
-	if (data.flags || data.pad) {
-		err = -EINVAL;
-		goto err_put_fd;
-	}
+	if (data.flags || data.pad)
+		return -EINVAL;
 
 	fence2 = sync_file_fdget(data.fd2);
-	if (!fence2) {
-		err = -ENOENT;
-		goto err_put_fd;
-	}
+	if (!fence2)
+		return -ENOENT;
 
 	data.name[sizeof(data.name) - 1] = '\0';
 	fence3 = sync_file_merge(data.name, sync_file, fence2);
 	if (!fence3) {
-		err = -ENOMEM;
-		goto err_put_fence2;
-	}
-
-	data.fence = fd;
-	if (copy_to_user((void __user *)arg, &data, sizeof(data))) {
-		err = -EFAULT;
-		goto err_put_fence3;
+		fput(fence2->file);
+		return -ENOMEM;
 	}
 
-	fd_install(fd, fence3->file);
-	fput(fence2->file);
-	return 0;
-
-err_put_fence3:
-	fput(fence3->file);
+	FD_PREPARE(fdf, O_CLOEXEC, fence3->file) {
+		fput(fence2->file);
+		if (fd_prepare_failed(fdf)) {
+			fput(fence3->file);
+			return fd_prepare_error(fdf);
+		}
 
-err_put_fence2:
-	fput(fence2->file);
+		data.fence = fd_prepare_fd(fdf);
+		if (copy_to_user((void __user *)arg, &data, sizeof(data)))
+			return -EFAULT;
 
-err_put_fd:
-	put_unused_fd(fd);
-	return err;
+		return fd_publish(fdf);
+	}
 }
 
 static int sync_fill_fence_info(struct dma_fence *fence,

-- 
2.47.3


