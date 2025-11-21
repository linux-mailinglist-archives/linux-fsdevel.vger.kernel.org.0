Return-Path: <linux-fsdevel+bounces-69418-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 360D7C7B2CB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 19:02:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB5133A101B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 18:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98C31349AF7;
	Fri, 21 Nov 2025 18:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gBQz3GWf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C5034D38E
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Nov 2025 18:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763748094; cv=none; b=oPpThKsOTSxJk0ZEIVyexuk1CiJpGEuCzVVEZZqvQCDWEMY1NkLILq8mNA8urkvtZPcyGzioYS5OXEU25bU4n6Q/+yQ2uyeCXAgrKPknJehNBpIRhH1pFBA9z010xEHAJQxGON9/BdWEVLDur/U8mkGZ+DyQ73C+I4xL55zr8jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763748094; c=relaxed/simple;
	bh=dJ0sA9hwTS+WQnqjGnBEvpyO//ddbK+qzrCwnXJ+H4o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b1/eO8dy8i5qKkA5hy7OuKPicp7H9CeRxTvnnjzaPyr1shM64upeYPwyfMvnQVNV9ReGm9ufYVZepriJAe3JYHGc36efo8Gmz5GxbU3q3tvECbHfuWdA/Td/UHnYQbBkNy3oDttjV9vFvmVp3F+yncTdF3pmVEAoRxj7kZQZ9l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gBQz3GWf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47A54C116C6;
	Fri, 21 Nov 2025 18:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763748093;
	bh=dJ0sA9hwTS+WQnqjGnBEvpyO//ddbK+qzrCwnXJ+H4o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=gBQz3GWf9U1VdqopBpgAgNqSbHvnplvq/GgpJhBaIe97c7m6fHt88Xwm/8O/yKIpA
	 ASO7NjshJ0LLZi4c7kQ7EFosxUyW36+86xkagkDUTZHWn9uDRAphXnF8Q4WjCPctxn
	 mNZVTEwGqlIfqfm7l/uzkT5e6eiqfBlhnGC+kjCX5b8YKQtsQCQzRMcPPI7qAD2Cxl
	 W1k7sIYNfmuVQnmp3amBWrVpkTzpe0iR5o9vQQTsYithdKUNZRQq8pKW5pAk2nQ272
	 IMQ1rHxif69QEozZasSueCcgpFzqu2lWXsXN8SzXKvMG1LN9CQx82PCyqu8AfveK/Q
	 dsW2X0TFZSIAA==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 21 Nov 2025 19:00:59 +0100
Subject: [PATCH RFC v3 20/47] dma: convert sync_file_ioctl_merge() to
 FD_PREPARE()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251121-work-fd-prepare-v3-20-2c6444d13e0e@kernel.org>
References: <20251121-work-fd-prepare-v3-0-2c6444d13e0e@kernel.org>
In-Reply-To: <20251121-work-fd-prepare-v3-0-2c6444d13e0e@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, 
 Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
 Jens Axboe <axboe@kernel.dk>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2144; i=brauner@kernel.org;
 h=from:subject:message-id; bh=dJ0sA9hwTS+WQnqjGnBEvpyO//ddbK+qzrCwnXJ+H4o=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQqrLiQ/G/p+h0pSTc66haVXWX5sqBx+0eRuUUmFy32R
 8+7dTClrqOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAi/3sYGSYvdm44Jd/f/NZq
 9upDJ/eELng2zTRwz1qZSyVbI/7fC/nLyLDCfnZhnHH40U1P5D/sL3p8c9+yKq2Dn8wLtCZ22FT
 F/mEDAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 drivers/dma-buf/sync_file.c | 54 ++++++++++++++++-----------------------------
 1 file changed, 19 insertions(+), 35 deletions(-)

diff --git a/drivers/dma-buf/sync_file.c b/drivers/dma-buf/sync_file.c
index 747e377fb954..842db95efddb 100644
--- a/drivers/dma-buf/sync_file.c
+++ b/drivers/dma-buf/sync_file.c
@@ -213,56 +213,40 @@ static __poll_t sync_file_poll(struct file *file, poll_table *wait)
 static long sync_file_ioctl_merge(struct sync_file *sync_file,
 				  unsigned long arg)
 {
-	int fd = get_unused_fd_flags(O_CLOEXEC);
-	int err;
 	struct sync_file *fence2, *fence3;
 	struct sync_merge_data data;
+	int err;
 
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
+	FD_PREPARE(fdf, O_CLOEXEC, fence3->file);
 	fput(fence2->file);
-	return 0;
-
-err_put_fence3:
-	fput(fence3->file);
+	err = ACQUIRE_ERR(fd_prepare, &fdf);
+	if (err) {
+		fput(fence3->file);
+		return err;
+	}
 
-err_put_fence2:
-	fput(fence2->file);
+	data.fence = fd_prepare_fd(fdf);
+	if (copy_to_user((void __user *)arg, &data, sizeof(data)))
+		return -EFAULT;
 
-err_put_fd:
-	put_unused_fd(fd);
-	return err;
+	return fd_publish(fdf);
 }
 
 static int sync_fill_fence_info(struct dma_fence *fence,

-- 
2.47.3


