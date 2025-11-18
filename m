Return-Path: <linux-fsdevel+bounces-68977-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 98716C6A722
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 16:57:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4F77F4F0E6D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 15:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EC6C36A029;
	Tue, 18 Nov 2025 15:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VjB0fTH4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7E936657A
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Nov 2025 15:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763481014; cv=none; b=exS8dziD1J8ZMPXHfW7BCdnx5ivkylOQeSf87B2jSumnLu/u7Mcz645QbHpsLMzX0iN2F0TjuJ5oclYLA36dU/ex6hvpo3lKPk64eSCSJsqKaWHK3ququWHX3bCNgk/m6M2NhXvR1RHigFtLv7xyt8KPaGPOG+8wSAsD6ItcPNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763481014; c=relaxed/simple;
	bh=GXW4A1bZnWzriWcf1kjt6u78qMnWvjaz/owpBpT+gHY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OXjFM7Bhrjq3rMNDh5zMWW9893m8FofMbGKyp5FF+x5gPcAMQJW31iTjobff3DeFwD2VortUVb8viH0JKoX/+wdTCNysH0pk8AQEj5UVttFOdxLCxHiBY80eI3W1HR/+xvRD6B+TVIRedzWGsl/sJFfm99oc7Xi2ZOKCZKrGtgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VjB0fTH4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91AF0C4CEF1;
	Tue, 18 Nov 2025 15:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763481014;
	bh=GXW4A1bZnWzriWcf1kjt6u78qMnWvjaz/owpBpT+gHY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=VjB0fTH4nlHICIYetpCHEMcwODYtwKQ9Lpuy7FxnsltQ7tyWxwjnGrfElUPgzwDeB
	 c5FseKK2qCb3XKjI0YYPwHSCh6c4jkce5IHkq7GKb/+6889z11HB9rkICeeZWh5DIX
	 m/wYXtSKeBbiVcDut6dW2gwgZ0HYYVqI8KFlqSxdyWZDAo39SzYtFm2shxnVmVjRu3
	 30oMQ8mXHofkH9pXphQ8P9C2SV5tsOFWjyKl6F98JTC+A6ldtKlgNrTSv/Sw+df3EH
	 M4JCnCncT6uaS1jP4iTaRiTiYEfGbSYgyr21BEc7e0wcErugeEFk7rty9fKf6TYwuM
	 I9vRnOfEZsA2w==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 18 Nov 2025 16:48:58 +0100
Subject: [PATCH DRAFT RFC UNTESTED 18/18] drivers: drm_lease
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251118-work-fd-prepare-v1-18-c20504d97375@kernel.org>
References: <20251118-work-fd-prepare-v1-0-c20504d97375@kernel.org>
In-Reply-To: <20251118-work-fd-prepare-v1-0-c20504d97375@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2646; i=brauner@kernel.org;
 h=from:subject:message-id; bh=GXW4A1bZnWzriWcf1kjt6u78qMnWvjaz/owpBpT+gHY=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTKTO0v4ivY9fPALRbNGB1tU32tRWsepp3j0z4fI7CPo
 /en4DTHjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIms+cjIsPVI3N1+gQ1Zm5d0
 fgifZbNB78TsWW/59s3tXGHfqMX2X46RYdX8zpDTS3V4fx2U01M+/Gte5OE9p1LWbOFj7PugZuz
 DwQcA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Placeholder commit message.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 drivers/gpu/drm/drm_lease.c | 44 ++++++++++++++------------------------------
 1 file changed, 14 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/drm_lease.c b/drivers/gpu/drm/drm_lease.c
index 94375c6a5425..3feee39e464b 100644
--- a/drivers/gpu/drm/drm_lease.c
+++ b/drivers/gpu/drm/drm_lease.c
@@ -514,8 +514,7 @@ int drm_mode_create_lease_ioctl(struct drm_device *dev,
 					       object_count, sizeof(__u32));
 		if (IS_ERR(object_ids)) {
 			ret = PTR_ERR(object_ids);
-			idr_destroy(&leases);
-			goto out_lessor;
+			goto out_idr;
 		}
 
 		/* fill and validate the object idr */
@@ -524,35 +523,26 @@ int drm_mode_create_lease_ioctl(struct drm_device *dev,
 		kfree(object_ids);
 		if (ret) {
 			drm_dbg_lease(dev, "lease object lookup failed: %i\n", ret);
-			idr_destroy(&leases);
-			goto out_lessor;
+			goto out_idr;
 		}
 	}
 
-	/* Allocate a file descriptor for the lease */
-	fd = get_unused_fd_flags(cl->flags & (O_CLOEXEC | O_NONBLOCK));
-	if (fd < 0) {
-		idr_destroy(&leases);
-		ret = fd;
-		goto out_lessor;
+	drm_dbg_lease(dev, "Allocating lease file\n");
+	FD_PREPARE(fdprep, cl->flags & (O_CLOEXEC | O_NONBLOCK),
+		   file_clone_open(lessor_file));
+	if (fd_prepare_failed(fdprep)) {
+		ret = fd_prepare_error(fdprep);
+		goto out_idr;
 	}
 
+	lessee_file = fd_prepare_file(fdprep);
+
 	drm_dbg_lease(dev, "Creating lease\n");
 	/* lessee will take the ownership of leases */
 	lessee = drm_lease_create(lessor, &leases);
-
 	if (IS_ERR(lessee)) {
 		ret = PTR_ERR(lessee);
-		idr_destroy(&leases);
-		goto out_leases;
-	}
-
-	/* Clone the lessor file to create a new file for us */
-	drm_dbg_lease(dev, "Allocating lease file\n");
-	lessee_file = file_clone_open(lessor_file);
-	if (IS_ERR(lessee_file)) {
-		ret = PTR_ERR(lessee_file);
-		goto out_lessee;
+		goto out_idr;
 	}
 
 	lessee_priv = lessee_file->private_data;
@@ -564,21 +554,15 @@ int drm_mode_create_lease_ioctl(struct drm_device *dev,
 
 	/* Pass fd back to userspace */
 	drm_dbg_lease(dev, "Returning fd %d id %d\n", fd, lessee->lessee_id);
-	cl->fd = fd;
 	cl->lessee_id = lessee->lessee_id;
-
-	/* Hook up the fd */
-	fd_install(fd, lessee_file);
+	cl->fd = fd_publish(fdprep);
 
 	drm_master_put(&lessor);
 	drm_dbg_lease(dev, "drm_mode_create_lease_ioctl succeeded\n");
 	return 0;
 
-out_lessee:
-	drm_master_put(&lessee);
-
-out_leases:
-	put_unused_fd(fd);
+out_idr:
+	idr_destroy(&leases);
 
 out_lessor:
 	drm_master_put(&lessor);

-- 
2.47.3


