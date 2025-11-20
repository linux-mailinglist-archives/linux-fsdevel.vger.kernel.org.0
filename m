Return-Path: <linux-fsdevel+bounces-69324-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E014FC7686A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 23:34:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id A2B202A6B2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 22:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AD1D3242B8;
	Thu, 20 Nov 2025 22:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="THas4W58"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA47A3019CD
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Nov 2025 22:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763678028; cv=none; b=fNAshsg9Pqz+g8vYbs0hLqegyJ6rssWGLFAd3YIdxrWB9ko4+pz6hagA86vn5vhYDiFV1YRKNGnHTv64GcCneIv349ctAiJg00wsPfsHqnUpZLfB5i8PvxJoU+Zp+lVGb8ffaOOVL/Gy5L3q8YvdnrlMX+V5hYVDHGuegA9dOs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763678028; c=relaxed/simple;
	bh=btYjNI9G/ai3n7j4aB53hGAX/DpPTvCXWAJawBi/nn4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rc4DellSkzQ4RC/g2ptNgyST6yPmTjgmx0oRCNVvAObq6HFJi49DUadYt+QTLAqfNPUHICCnW3xKB5c0Ap/4+zjvy8ICBzQJBhK5u1MGde4a+88Qd/nJ6VMiRpW2T7rEX/NwdIj1D0wi2B+1d4+wWO9vDz+zrWbVW0LL3F78P8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=THas4W58; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EAB0C4CEF1;
	Thu, 20 Nov 2025 22:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763678028;
	bh=btYjNI9G/ai3n7j4aB53hGAX/DpPTvCXWAJawBi/nn4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=THas4W581sByiDU+wBrB8sEtbIWod9Lrq7VGh7wLGUFUqs5veNj7+IlGIky4qbNEn
	 istAN8+vfMRPV/vQ6M8kKfCAd62+OUFNDwF2nVVIYNiK4c51Cbh6Jq0kVP5r39/rU5
	 UUkBeFyURVAtM785flUsZ1Co2wNHn4dZLt00mPC3m9xvB2NwJR3yj6gvAA+Ny+B5cl
	 lYLFUFf2QIMYrPTuWh5sumMb8ymK1DixB9Z896qM81QF6lNS/XutCVmpKSrJPR785j
	 ZXfLk1/mipAuWY8thYvgLzpaIG7POWPvTd+Fy0b1w2RQAJ1SIexMME9RWFjSEi4YJo
	 8l9fmeQsAipAQ==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 20 Nov 2025 23:32:41 +0100
Subject: [PATCH RFC v2 44/48] vfio: convert
 vfio_group_ioctl_get_device_fd() to FD_PREPARE()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251120-work-fd-prepare-v2-44-fef6ebda05d3@kernel.org>
References: <20251120-work-fd-prepare-v2-0-fef6ebda05d3@kernel.org>
In-Reply-To: <20251120-work-fd-prepare-v2-0-fef6ebda05d3@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, 
 Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
 Jens Axboe <axboe@kernel.dk>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1437; i=brauner@kernel.org;
 h=from:subject:message-id; bh=btYjNI9G/ai3n7j4aB53hGAX/DpPTvCXWAJawBi/nn4=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTKT3tX9yq6fMLbbzPS/fSVVoq5nvlyWaq6zinRZd7CQ
 vlm/di/HaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABPpCWBk+Dnt//tTF9qUQvNO
 CDCphexZ9D+Gj9d08XOzexNXd4hpijEyvPu6XiHm6lSBfzb/1AOrtfaWNoVJicyfNXnL29qe9Vt
 DuQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 drivers/vfio/group.c | 27 ++++++---------------------
 1 file changed, 6 insertions(+), 21 deletions(-)

diff --git a/drivers/vfio/group.c b/drivers/vfio/group.c
index c376a6279de0..24edf9b3de15 100644
--- a/drivers/vfio/group.c
+++ b/drivers/vfio/group.c
@@ -299,10 +299,7 @@ static int vfio_group_ioctl_get_device_fd(struct vfio_group *group,
 					  char __user *arg)
 {
 	struct vfio_device *device;
-	struct file *filep;
 	char *buf;
-	int fdno;
-	int ret;
 
 	buf = strndup_user(arg, PAGE_SIZE);
 	if (IS_ERR(buf))
@@ -313,26 +310,14 @@ static int vfio_group_ioctl_get_device_fd(struct vfio_group *group,
 	if (IS_ERR(device))
 		return PTR_ERR(device);
 
-	fdno = get_unused_fd_flags(O_CLOEXEC);
-	if (fdno < 0) {
-		ret = fdno;
-		goto err_put_device;
-	}
+	FD_PREPARE(fdf, O_CLOEXEC, vfio_device_open_file(device)) {
+		if (fd_prepare_failed(fdf)) {
+			vfio_device_put_registration(device);
+			return fd_prepare_error(fdf);
+		}
 
-	filep = vfio_device_open_file(device);
-	if (IS_ERR(filep)) {
-		ret = PTR_ERR(filep);
-		goto err_put_fdno;
+		return fd_publish(fdf);
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
 }
 
 static int vfio_group_ioctl_get_status(struct vfio_group *group,

-- 
2.47.3


