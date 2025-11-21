Return-Path: <linux-fsdevel+bounces-69435-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D36C7B301
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 19:03:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAA3E3A438F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 18:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B8EF350A15;
	Fri, 21 Nov 2025 18:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rbJMybx+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 870E53502B1
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Nov 2025 18:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763748129; cv=none; b=IYGApki0Dd4zRgLSEx9uV27ZgJCbItbRedWyTSOauA1YcidE807tr5Y5HCrbgcxHF0A8mz+KYVGt2uXOMB2Kquggp17//cAu1XoF9tnv0TKZGn8U7dnKQ6nwzF3MsoZMj3ZaWcCzVEC1LJsahEdRKZlKcysHdtlIIMOWje048VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763748129; c=relaxed/simple;
	bh=yBJG+gcsFKeReTOVXRaEFzIRWSuecQsEPy0LHSIHHtM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q6GcLvPgkvz35KKWh48/Qz7oCu31Nl/hksTI5UHSbOjYA9QX3pNVYB+naGaxZFggjagmCtlGuJY/5HgV0DeIVcfZqRoDw8AglxdZQOPBgnIHh1Rr8wyFJ+jWKMrmjR0lGPlZVmeX06lSk6x++gtGChfvzHS3GwGUBkgxILjwDZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rbJMybx+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B917EC19422;
	Fri, 21 Nov 2025 18:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763748129;
	bh=yBJG+gcsFKeReTOVXRaEFzIRWSuecQsEPy0LHSIHHtM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=rbJMybx+jCxWGBD31cbWEFg/k5LqD42jylpD8RI+ZDmZxmneySr7kTBFdVOWl+3R0
	 8ENy/x9+oueZy0mkFho3yt42PnkE2Bp+b9D7wl0ZAVnCO4nnZQgmG8kS6D5LreryEc
	 6iRUJkXBD24CsUlnec42vv4JSKp/4GMlKjCfjmxgIA3C5yqWdxn62kmteHtE3q7NwE
	 cdzCjCmvbhFbDOaLgHFBmnxSWmG7jryg3kOHFxu+Ax9zZUdH4q1HDQaThu1Y384fJu
	 QQ2Jb8YTq9vuJp2+zV5uSq9FxLe/wwFUyVbJBf+vh7txieYOziDMzY2CrOfd+mZOIv
	 p6G6xRGB36PNQ==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 21 Nov 2025 19:01:16 +0100
Subject: [PATCH RFC v3 37/47] dma: port sw_sync_ioctl_create_fence() to
 FD_PREPARE()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251121-work-fd-prepare-v3-37-2c6444d13e0e@kernel.org>
References: <20251121-work-fd-prepare-v3-0-2c6444d13e0e@kernel.org>
In-Reply-To: <20251121-work-fd-prepare-v3-0-2c6444d13e0e@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, 
 Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
 Jens Axboe <axboe@kernel.dk>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1875; i=brauner@kernel.org;
 h=from:subject:message-id; bh=yBJG+gcsFKeReTOVXRaEFzIRWSuecQsEPy0LHSIHHtM=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQqrLhYI/nfzX5j2KeSI7fS/qzlPbyl3FtX7kjcu/6Dz
 hk6N47c7ihlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjIHwaG/8Wzog/wXLPp1/Ls
 XPyfb0fxcRaZ95tfJNn8PPtwcQ8Lqysjw+aLBx1+cx5oWTs313uz8G+lVsakG2IHbU5uPJeq21A
 SywgA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 drivers/dma-buf/sw_sync.c | 42 +++++++++++++++---------------------------
 1 file changed, 15 insertions(+), 27 deletions(-)

diff --git a/drivers/dma-buf/sw_sync.c b/drivers/dma-buf/sw_sync.c
index 3c20f1d31cf5..7ff0d0e7dbc7 100644
--- a/drivers/dma-buf/sw_sync.c
+++ b/drivers/dma-buf/sw_sync.c
@@ -343,47 +343,35 @@ static int sw_sync_debugfs_release(struct inode *inode, struct file *file)
 static long sw_sync_ioctl_create_fence(struct sync_timeline *obj,
 				       unsigned long arg)
 {
-	int fd = get_unused_fd_flags(O_CLOEXEC);
-	int err;
 	struct sync_pt *pt;
 	struct sync_file *sync_file;
 	struct sw_sync_create_fence_data data;
+	int err;
 
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
+	if (!sync_file)
+		return -ENOMEM;
 
-	data.fence = fd;
-	if (copy_to_user((void __user *)arg, &data, sizeof(data))) {
+	FD_PREPARE(fdf, O_CLOEXEC, sync_file->file);
+	err = ACQUIRE_ERR(fd_prepare, &fdf);
+	if (err) {
 		fput(sync_file->file);
-		err = -EFAULT;
-		goto err;
+		return err;
 	}
 
-	fd_install(fd, sync_file->file);
-
-	return 0;
+	data.fence = fd_prepare_fd(fdf);
+	if (copy_to_user((void __user *)arg, &data, sizeof(data)))
+		return -EFAULT;
 
-err:
-	put_unused_fd(fd);
-	return err;
+	return fd_publish(fdf);
 }
 
 static long sw_sync_ioctl_inc(struct sync_timeline *obj, unsigned long arg)

-- 
2.47.3


