Return-Path: <linux-fsdevel+bounces-69542-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 171E0C7E3D5
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Nov 2025 17:34:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0C7E3A5317
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Nov 2025 16:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63CA62D879A;
	Sun, 23 Nov 2025 16:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DwTSpVcU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C132D94AA
	for <linux-fsdevel@vger.kernel.org>; Sun, 23 Nov 2025 16:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763915658; cv=none; b=EqtavINcQplPcmCGQfdFHVjzkXtz7hsRp7oWqoY4a1fJ7wxWXRojwYUgsfTpSHdnzQj99wVkbKZaxstIj7ufJDBrinTvldGAYsPb/lhsRreG0EJHyea/FtMTpxJelSLgtMM7iT/kU2lyZDGsVYdV89wIfAr48oOBYTXDkaYJFtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763915658; c=relaxed/simple;
	bh=5LqXF0mdq/2c83YS6nt7cs8S95GzgRowfPvVid8eGIs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nJFly9LksxxEn3TmvM+ndqLHYO+Dev0EvfeRtVCHvkFW588PkbVqGCe4vvhPSOT3cWA8TqYbKbsTvq6qgJAV5wF1kQJD8Xj1JWQueJyo3R2d1FHQmWAzUkKPBRw4HBFWTq3Z30jvwLUlTGMtHFClRwdW+SiwLGGAKxTbGHo+gi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DwTSpVcU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95943C113D0;
	Sun, 23 Nov 2025 16:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763915658;
	bh=5LqXF0mdq/2c83YS6nt7cs8S95GzgRowfPvVid8eGIs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=DwTSpVcU84XH4dfZFIMt7rEO9NtOYZ8N0iBJqAr4OO+leXpIyOlBbQz/Yz2sn0qbB
	 xudLwyFvMzF95ov/sH6gB4mKrj8Bsqx3VC8OpGoZjRr0dMunD1kJdmbDkoalkGcH+M
	 cCEmFLjSSAdqMhfoA6WHnHrUXtYZpSdunlJPkKDuXrYSxGXq+nbt+X8gYF9JaUJASQ
	 6H03Ip342pXd896tWj8O5pqf9ts6d8VeeBpbtg+OUry54t90u2DhnAa+mukIgIWeg7
	 dYy5ylweVmIHRKyuNm2HYR6ZvM6skap26Y0cUYXHAoyuasf3TLwz+BUbDENhdfR8+9
	 23u0oTtQsUxzg==
From: Christian Brauner <brauner@kernel.org>
Date: Sun, 23 Nov 2025 17:33:38 +0100
Subject: [PATCH v4 20/47] dma: convert sync_file_ioctl_merge() to
 FD_PREPARE()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251123-work-fd-prepare-v4-20-b6efa1706cfd@kernel.org>
References: <20251123-work-fd-prepare-v4-0-b6efa1706cfd@kernel.org>
In-Reply-To: <20251123-work-fd-prepare-v4-0-b6efa1706cfd@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
 Amir Goldstein <amir73il@gmail.com>, Jens Axboe <axboe@kernel.dk>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2100; i=brauner@kernel.org;
 h=from:subject:message-id; bh=5LqXF0mdq/2c83YS6nt7cs8S95GzgRowfPvVid8eGIs=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQqm0e2SXKUm/neDeDdePxqYXVDeZST7n6/t5uu3crmn
 PfL9GJeRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwES+8zP8d/c1eF/46KS/robU
 v1qWsAeWjL8cWU7xV2g1vbpokX24gJFhvYZ2xP8YkRLuB5OT/Gqn3660anCrNSlvyU2Vi3ThL2M
 DAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 drivers/dma-buf/sync_file.c | 52 +++++++++++++++------------------------------
 1 file changed, 17 insertions(+), 35 deletions(-)

diff --git a/drivers/dma-buf/sync_file.c b/drivers/dma-buf/sync_file.c
index 747e377fb954..dc2e79a1b196 100644
--- a/drivers/dma-buf/sync_file.c
+++ b/drivers/dma-buf/sync_file.c
@@ -213,56 +213,38 @@ static __poll_t sync_file_poll(struct file *file, poll_table *wait)
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
+	FD_PREPARE(fdf, O_CLOEXEC, fence3->file);
 	fput(fence2->file);
-	return 0;
-
-err_put_fence3:
-	fput(fence3->file);
+	if (fdf.err) {
+		fput(fence3->file);
+		return fdf.err;
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


