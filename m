Return-Path: <linux-fsdevel+bounces-69298-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 99AC4C76846
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 23:33:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 469A235088E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 22:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C2C1358D21;
	Thu, 20 Nov 2025 22:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="naG/Cdi8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96FE2E8DE2
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Nov 2025 22:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763677974; cv=none; b=ljKls7uMarDeZfh4Lb1wx7ufUjwvrf42Gbp+2YbSoqxZ+SVWUvM4f1srZJ0s2n94IJmsFeIHmcRWcWAmIhOSPX6DFn44msa2fkU2fgl2fM+7I36yj57ykFNxNPYW2wG3lxdC/O46lfWJpxpZ9SUFaBPvpK120tDRVpWqAtJ4AOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763677974; c=relaxed/simple;
	bh=ub5oIyY+VmX+ri+ozMbLEUlzX44ZMoEaA1W0k0u4zwg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=plmK+z3bpIOLvHkm3JtVaFm13bjXbOFRdkFqKgVBxEdLuPlLDgP2H35L5tRdHBjH1G1FAImEq0AJvljCSO1EGsaLa6uqtZ+ZCJh3rzYwtFfSKT0iKHm5efaiXARDAyVDqxJfbqIVhMX4A3v1Sv270kAN/Z5PaCfSWLRgaccNtxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=naG/Cdi8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF8B8C4CEF1;
	Thu, 20 Nov 2025 22:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763677974;
	bh=ub5oIyY+VmX+ri+ozMbLEUlzX44ZMoEaA1W0k0u4zwg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=naG/Cdi8go+s3G5Xg1Gz7XqeupyITNe9RMWlRjC/6ct7XDDDpoMtDj4hFCT/JaZNo
	 Fl8t12N/fNn/iYEREuYJfM0aL43PXQjhzcIIgImIsPpufq0qou4pRTLa6k2L4n0Gs4
	 +QvhVx8oJQt2BXqcVFlYBGcqPrwNu/6SdF8TixYARL94dFFxwceAYAtIa20I+w6gP/
	 70Y0mJIZrqQgQ3jSyxy+k4LeU0sd7Q968mxIZgq2CpinmhSDWFOWwbCwUeSG3FRoiR
	 zpsMtk/NYo7kOFRTeYQ+Tsim8b/nue9Fi5Xh5xSJQxuk/MbNFFsEgf/QpEJrSnltZN
	 nZjGOdm7U0Jfg==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 20 Nov 2025 23:32:15 +0100
Subject: [PATCH RFC v2 18/48] drm: convert drm_mode_create_lease_ioctl() to
 FD_PREPARE()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251120-work-fd-prepare-v2-18-fef6ebda05d3@kernel.org>
References: <20251120-work-fd-prepare-v2-0-fef6ebda05d3@kernel.org>
In-Reply-To: <20251120-work-fd-prepare-v2-0-fef6ebda05d3@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, 
 Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
 Jens Axboe <axboe@kernel.dk>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3367; i=brauner@kernel.org;
 h=from:subject:message-id; bh=ub5oIyY+VmX+ri+ozMbLEUlzX44ZMoEaA1W0k0u4zwg=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTKT3s7IUaO59Z3TX2NWrmHCi79ugcfl/WfmKhYsVr3x
 uVVLc0uHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABMR/s/wz/R/y/1pTT8mxm/t
 WxLEPntj0W0+DvtW3YTsS1qzwngMljEyTHbcfu+jvWHA3iLB2nPH+P6s3ST00q7PIUOoQGnyqlO
 dLAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 drivers/gpu/drm/drm_lease.c | 83 +++++++++++++++++++--------------------------
 1 file changed, 34 insertions(+), 49 deletions(-)

diff --git a/drivers/gpu/drm/drm_lease.c b/drivers/gpu/drm/drm_lease.c
index 94375c6a5425..beee981329a5 100644
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
@@ -524,61 +523,47 @@ int drm_mode_create_lease_ioctl(struct drm_device *dev,
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
-	}
-
-	drm_dbg_lease(dev, "Creating lease\n");
-	/* lessee will take the ownership of leases */
-	lessee = drm_lease_create(lessor, &leases);
-
-	if (IS_ERR(lessee)) {
-		ret = PTR_ERR(lessee);
-		idr_destroy(&leases);
-		goto out_leases;
-	}
-
-	/* Clone the lessor file to create a new file for us */
 	drm_dbg_lease(dev, "Allocating lease file\n");
-	lessee_file = file_clone_open(lessor_file);
-	if (IS_ERR(lessee_file)) {
-		ret = PTR_ERR(lessee_file);
-		goto out_lessee;
-	}
-
-	lessee_priv = lessee_file->private_data;
-	/* Change the file to a master one */
-	drm_master_put(&lessee_priv->master);
-	lessee_priv->master = lessee;
-	lessee_priv->is_master = 1;
-	lessee_priv->authenticated = 1;
-
-	/* Pass fd back to userspace */
-	drm_dbg_lease(dev, "Returning fd %d id %d\n", fd, lessee->lessee_id);
-	cl->fd = fd;
-	cl->lessee_id = lessee->lessee_id;
+	FD_PREPARE(fdf, cl->flags & (O_CLOEXEC | O_NONBLOCK),
+		   file_clone_open(lessor_file)) {
+		if (fd_prepare_failed(fdf)) {
+			ret = fd_prepare_error(fdf);
+			goto out_idr;
+		}
 
-	/* Hook up the fd */
-	fd_install(fd, lessee_file);
+		lessee_file = fd_prepare_file(fdf);
 
-	drm_master_put(&lessor);
-	drm_dbg_lease(dev, "drm_mode_create_lease_ioctl succeeded\n");
-	return 0;
+		drm_dbg_lease(dev, "Creating lease\n");
+		/* lessee will take the ownership of leases */
+		lessee = drm_lease_create(lessor, &leases);
+		if (IS_ERR(lessee)) {
+			ret = PTR_ERR(lessee);
+			goto out_idr;
+		}
 
-out_lessee:
-	drm_master_put(&lessee);
+		lessee_priv = lessee_file->private_data;
+		/* Change the file to a master one */
+		drm_master_put(&lessee_priv->master);
+		lessee_priv->master = lessee;
+		lessee_priv->is_master = 1;
+		lessee_priv->authenticated = 1;
+
+		/* Pass fd back to userspace */
+		drm_dbg_lease(dev, "Returning fd %d id %d\n", fd, lessee->lessee_id);
+		cl->lessee_id = lessee->lessee_id;
+		cl->fd = fd_publish(fdf);
+
+		drm_master_put(&lessor);
+		drm_dbg_lease(dev, "drm_mode_create_lease_ioctl succeeded\n");
+		return 0;
+	}
 
-out_leases:
-	put_unused_fd(fd);
+out_idr:
+	idr_destroy(&leases);
 
 out_lessor:
 	drm_master_put(&lessor);

-- 
2.47.3


