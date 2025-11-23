Return-Path: <linux-fsdevel+bounces-69559-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3202EC7E41A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Nov 2025 17:36:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3C5FA34AAD1
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Nov 2025 16:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 387832D94AD;
	Sun, 23 Nov 2025 16:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LH/VwhOF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E13227B83
	for <linux-fsdevel@vger.kernel.org>; Sun, 23 Nov 2025 16:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763915695; cv=none; b=Ira7Vu3ahj0i5LE206y3XdGJjDJx1/COanUa62MuCI+1ktSifhiczp+OpI88s36U/J/BwJFsEXryeS96apc0ffsIMi8T+mgvb09tdeynOl18kf4/eW0BiUAmendzvvW9nJKFugf6/BvtuqG2JNq1XdlJ31i2hu15U4FQwcy5bmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763915695; c=relaxed/simple;
	bh=6AhjAphclm3UF7joRrvY3qiugyC82s7JbdfBWjj87nk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SXN+URCt8DGbo87QGSu0WD6xHyAyV463dPWZK0HPttUw09GwynYypH2PAgqHFwWApXoyVlPdVxFt7Jr0qCfjjxKT171kBHXOdw2TFIK/4BEa8L1TKykAQV9Hl1ZQpCNdZQie7zgVWGYLykSLIv7ys7HecPp2LUJZ6Jeg8AcXRVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LH/VwhOF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9341C116D0;
	Sun, 23 Nov 2025 16:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763915695;
	bh=6AhjAphclm3UF7joRrvY3qiugyC82s7JbdfBWjj87nk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=LH/VwhOF6HZGVZ25F0Fzt9XTNX1q0OWawNtUmVQnax7OUIxTuAj58Z/98B5Wgtr1K
	 h12eznw7BnNbcKhe+Tlg4in9VYGg2FuxYyvHnGRTsaUbaHH5SprcZA3Cme1ASxFTc2
	 FvkeY56h7Fpd3SJRRLgK9s06dA0tc4t0b2aRMStsOMW1c9S4pD6+o0mINu7KIdAjhj
	 BTUtQ08xWfJG+FEAGlp3seSZrWC6FkN/MXPHEWJFEro3c8/zP9PuN9OZf5yt+mxH8k
	 SuGTDFZI2z56o5iDdlHf3GjYnSi3bN08iNNpCNlFH88s7yhvRHBiILjEZtk1tDRIqg
	 yFHXu+Tegj9nw==
From: Christian Brauner <brauner@kernel.org>
Date: Sun, 23 Nov 2025 17:33:55 +0100
Subject: [PATCH v4 37/47] dma: port sw_sync_ioctl_create_fence() to
 FD_PREPARE()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251123-work-fd-prepare-v4-37-b6efa1706cfd@kernel.org>
References: <20251123-work-fd-prepare-v4-0-b6efa1706cfd@kernel.org>
In-Reply-To: <20251123-work-fd-prepare-v4-0-b6efa1706cfd@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
 Amir Goldstein <amir73il@gmail.com>, Jens Axboe <axboe@kernel.dk>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1829; i=brauner@kernel.org;
 h=from:subject:message-id; bh=6AhjAphclm3UF7joRrvY3qiugyC82s7JbdfBWjj87nk=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQqm0cLJOr9bXs/98OmM4suus0vD43YVnH1i591OT/bL
 KXnpQKSHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABPJVmFkaDjKn3L++8wVrVrL
 SicWZnft7ZjDv1H31tLPGl99Ew7IczEynLur5cTAJLdxVsO0729Mr01p3Pshcm1VmOipI65p2qm
 /uQE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 drivers/dma-buf/sw_sync.c | 40 +++++++++++++---------------------------
 1 file changed, 13 insertions(+), 27 deletions(-)

diff --git a/drivers/dma-buf/sw_sync.c b/drivers/dma-buf/sw_sync.c
index 3c20f1d31cf5..f100a13fdc00 100644
--- a/drivers/dma-buf/sw_sync.c
+++ b/drivers/dma-buf/sw_sync.c
@@ -343,47 +343,33 @@ static int sw_sync_debugfs_release(struct inode *inode, struct file *file)
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
+	if (!sync_file)
+		return -ENOMEM;
 
-	data.fence = fd;
-	if (copy_to_user((void __user *)arg, &data, sizeof(data))) {
+	FD_PREPARE(fdf, O_CLOEXEC, sync_file->file);
+	if (fdf.err) {
 		fput(sync_file->file);
-		err = -EFAULT;
-		goto err;
+		return fdf.err;
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


