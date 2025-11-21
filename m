Return-Path: <linux-fsdevel+bounces-69438-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99AD2C7B30A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 19:03:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 133553A075B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 18:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07F12353898;
	Fri, 21 Nov 2025 18:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GVZM81pJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DFA534D388
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Nov 2025 18:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763748136; cv=none; b=iBpUXbFL6yE9CsmpO8BTxhEUtTTK6q+mQtp61Zx3zveoNioUi8yYFpkCTXyQlLT6CYuH1Yj1XnLoN+6VAFTWMaKweomIKIRZJc67dJOEx2HvDYEnXOe3SQYhakZc5Lyk0bHuB9uAznr+JxV6eaF33qqXlFZHC9a6UNQvQ1VUeNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763748136; c=relaxed/simple;
	bh=y4y73786/Po1Y1iuLy/shegoP4KyI9Q430iAJ2zBcDg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X/j0D9G8h4DYbr8iW3OqhhQWRPmF37J2CxC6Vxzo37b9Ii/0C7pRkNICg/cYrZFrG3+YKF1oO0beQjslrWF1mgnHqgD7IY2cPjIXDrdY/EVe3NshVLUXMPBsRMdrxTDJLTkztCCzxN1zixScQMeWE0G80nzNPgI3V+9sHLd00wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GVZM81pJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44177C4CEF1;
	Fri, 21 Nov 2025 18:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763748135;
	bh=y4y73786/Po1Y1iuLy/shegoP4KyI9Q430iAJ2zBcDg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=GVZM81pJ7fWPq621MY2rBadF6GnU6NHtuxDjV3GWMTozoAlFqoIAVGtJAN0NJc8P7
	 JmCNNvWg+T9G9vIvVIfTYjnGAtJcAN+rA3Kr18pAUTtgEr5uTLxFDoI+eaAZkKMhp2
	 ngCEScF1Bn7EjGgUffyflxA4Rboi7WUk357VEHrHvY0Jw7ZkYOCMH9/GDXCUawL7Jz
	 xwSOAf3/KyTLKGbJi0xPX2FZFH2QEDT6TXCb6X6SgIL97wpeFEMc8D0suO8bczBc3H
	 YfgBvX3+pNe1qh/TEQ/gKggM0KZMlKwcQjvl2xHwHSuJJT7r0hCoQWO8Ap9B4tIGnQ
	 oyRTSvfCkSkbw==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 21 Nov 2025 19:01:19 +0100
Subject: [PATCH RFC v3 40/47] media: convert media_request_alloc() to
 FD_PREPARE()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251121-work-fd-prepare-v3-40-2c6444d13e0e@kernel.org>
References: <20251121-work-fd-prepare-v3-0-2c6444d13e0e@kernel.org>
In-Reply-To: <20251121-work-fd-prepare-v3-0-2c6444d13e0e@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, 
 Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
 Jens Axboe <axboe@kernel.dk>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1990; i=brauner@kernel.org;
 h=from:subject:message-id; bh=y4y73786/Po1Y1iuLy/shegoP4KyI9Q430iAJ2zBcDg=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQqrLgY+m9HidofZbHXB7JPXo3dHXags9i9ymaL88M2F
 k+lD83uHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABNZsZjhf0bfjPLddupcVao3
 b9bm6yWs5LD8tKIv424046FWRWO1owz/CxJYDUJ2BD/l/PHu8cJjwUfc/pVs2Hd4Yss9swhlzq0
 VvAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 drivers/media/mc/mc-request.c | 33 +++++++++++----------------------
 1 file changed, 11 insertions(+), 22 deletions(-)

diff --git a/drivers/media/mc/mc-request.c b/drivers/media/mc/mc-request.c
index f66f728b1b43..bf039ab7be93 100644
--- a/drivers/media/mc/mc-request.c
+++ b/drivers/media/mc/mc-request.c
@@ -282,8 +282,6 @@ EXPORT_SYMBOL_GPL(media_request_get_by_fd);
 int media_request_alloc(struct media_device *mdev, int *alloc_fd)
 {
 	struct media_request *req;
-	struct file *filp;
-	int fd;
 	int ret;
 
 	/* Either both are NULL or both are non-NULL */
@@ -297,19 +295,6 @@ int media_request_alloc(struct media_device *mdev, int *alloc_fd)
 	if (!req)
 		return -ENOMEM;
 
-	fd = get_unused_fd_flags(O_CLOEXEC);
-	if (fd < 0) {
-		ret = fd;
-		goto err_free_req;
-	}
-
-	filp = anon_inode_getfile("request", &request_fops, NULL, O_CLOEXEC);
-	if (IS_ERR(filp)) {
-		ret = PTR_ERR(filp);
-		goto err_put_fd;
-	}
-
-	filp->private_data = req;
 	req->mdev = mdev;
 	req->state = MEDIA_REQUEST_STATE_IDLE;
 	req->num_incomplete_objects = 0;
@@ -320,19 +305,23 @@ int media_request_alloc(struct media_device *mdev, int *alloc_fd)
 	req->updating_count = 0;
 	req->access_count = 0;
 
-	*alloc_fd = fd;
+	FD_PREPARE(fdf, O_CLOEXEC,
+		   anon_inode_getfile("request", &request_fops, NULL,
+				      O_CLOEXEC));
+	ret = ACQUIRE_ERR(fd_prepare, &fdf);
+	if (ret)
+		goto err_free_req;
+
+	fd_prepare_file(fdf)->private_data = req;
+
+	*alloc_fd = fd_publish(fdf);
 
 	snprintf(req->debug_str, sizeof(req->debug_str), "%u:%d",
-		 atomic_inc_return(&mdev->request_id), fd);
+		 atomic_inc_return(&mdev->request_id), *alloc_fd);
 	dev_dbg(mdev->dev, "request: allocated %s\n", req->debug_str);
 
-	fd_install(fd, filp);
-
 	return 0;
 
-err_put_fd:
-	put_unused_fd(fd);
-
 err_free_req:
 	if (mdev->ops->req_free)
 		mdev->ops->req_free(req);

-- 
2.47.3


