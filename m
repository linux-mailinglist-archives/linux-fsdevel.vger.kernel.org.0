Return-Path: <linux-fsdevel+bounces-69320-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 305BAC7689A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 23:36:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EDA7F35D89E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 22:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 557AE2AF1D;
	Thu, 20 Nov 2025 22:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XbHRaBlW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2A430FC3A
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Nov 2025 22:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763678020; cv=none; b=aHM1QiP6XR+9KeNzskt4/kd15BO9onfW2h9I3yfdfOErrShkTWgonNBrhWdlSlj0AHfk4JlmdE94Re1M3+X0xwRPcPTA8t/rAZSJ0ZxD/S4SlJLzXkKpGjhIgKRqYyAKxnF0QOBXqEtxLiH0H/viPvD+WSteX437V5pADJ5it+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763678020; c=relaxed/simple;
	bh=/jipHmOdvv7ZCoe5X0BCtmNz/SjPvv1M1zWxeCgrkOw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fwyIgCYX4F7sVkWq4VdhoS1kd48dXAV8hBJ18wdmICSiNWBsw0Ig2UWjLCgiTa/KM5Z4XwDQ6uOfi4hXINaSyX4/x0v1J+n0qZPnPFqTiB7dE9Vs44XhwwcmmpWUSdcSK6De6iEhN8hfYTjLEO+5U2yx5LMUAmd7u1QsfaJXQXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XbHRaBlW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9299C116B1;
	Thu, 20 Nov 2025 22:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763678020;
	bh=/jipHmOdvv7ZCoe5X0BCtmNz/SjPvv1M1zWxeCgrkOw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=XbHRaBlWdBofVwtf02zk+a4EpDJ+RoM+LybCk2fbd0EKwA0pgHLbUcrBqzOYq4Dna
	 v9+05RAzuKUqSYM8lFdMYnJ2M2j9EohqEU+IwbJ6vMWijZX4SiTSrif8minNnJMOJX
	 tWTgKGGi3YhMj0SkXL6MglXcquX3rH4IunyJb3FhU6NoCnJ7aDeQ+gFavs/bKL3lMR
	 4lQSc7fxUAaqLG9P3H0z+eQYWZwUSMBp8kS9m4b/XnR9o/oR3u2a5tYWFS09GVM6RD
	 kHWmijl7mOa13k3k2le7C9Et13WYHw11GGDAFidwG0cozdztxmSUYrTezuJ8rTAFaq
	 ECVEAbLLJgD/w==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 20 Nov 2025 23:32:37 +0100
Subject: [PATCH RFC v2 40/48] hv: convert mshv_ioctl_create_partition() to
 FD_PREPARE()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251120-work-fd-prepare-v2-40-fef6ebda05d3@kernel.org>
References: <20251120-work-fd-prepare-v2-0-fef6ebda05d3@kernel.org>
In-Reply-To: <20251120-work-fd-prepare-v2-0-fef6ebda05d3@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, 
 Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
 Jens Axboe <axboe@kernel.dk>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1201; i=brauner@kernel.org;
 h=from:subject:message-id; bh=/jipHmOdvv7ZCoe5X0BCtmNz/SjPvv1M1zWxeCgrkOw=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTKT3v3fWH217MPPord9591ZcZS081m5+vcHpgLarXtl
 j624eHshI5SFgYxLgZZMUUWh3aTcLnlPBWbjTI1YOawMoEMYeDiFICJzDvK8N9RgtHnJVPFyjOl
 D4U+d+Vyn5wS1mxguzMl+GPoH7aOtl2MDDcfai2z+/Bz/YZ51gcPLI/9dGteNOcVvhu3H/yfYqX
 kEskOAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 drivers/hv/mshv_root_main.c | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
index e3b2bd417c46..2c962af8a3d1 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -1941,25 +1941,17 @@ mshv_ioctl_create_partition(void __user *user_arg, struct device *module_dev)
 	if (ret)
 		goto remove_partition;
 
-	fd = get_unused_fd_flags(O_CLOEXEC);
-	if (fd < 0) {
-		ret = fd;
-		goto remove_partition;
-	}
+	FD_PREPARE(fdf, O_CLOEXEC,
+		   anon_inode_getfile("mshv_partition", &mshv_partition_fops,
+				      partition, O_RDWR)) {
+		if (fd_prepare_failed(fdf)) {
+			ret = fd_prepare_error(fdf);
+			goto remove_partition;
+		}
 
-	file = anon_inode_getfile("mshv_partition", &mshv_partition_fops,
-				  partition, O_RDWR);
-	if (IS_ERR(file)) {
-		ret = PTR_ERR(file);
-		goto put_fd;
+		return fd_publish(fdf);
 	}
 
-	fd_install(fd, file);
-
-	return fd;
-
-put_fd:
-	put_unused_fd(fd);
 remove_partition:
 	remove_partition(partition);
 delete_partition:

-- 
2.47.3


