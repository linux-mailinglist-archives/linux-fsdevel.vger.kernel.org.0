Return-Path: <linux-fsdevel+bounces-69563-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 24255C7E40B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Nov 2025 17:35:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 154004E38FE
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Nov 2025 16:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F32642D979C;
	Sun, 23 Nov 2025 16:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="diYtzyhY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2F319F40A
	for <linux-fsdevel@vger.kernel.org>; Sun, 23 Nov 2025 16:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763915704; cv=none; b=llT5uS7GvdGfC40pp/oDCRhmI6Nqr8liriZ/FJ4AH3tnP+S+LFwk1wu63eKw+Mc5RNdUVmSmMzZ+ds2lN3/bDjSU6sy12LdejyTdF6V3faYD1WD+8mP5itpr0/4JTntgq6skP2/vKddb/xjkWwBPvTOb6NxLsbPazOPYdYSzTIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763915704; c=relaxed/simple;
	bh=2D/f1isgO+0iEZX+RYjDVeosEKzTc82UACIJ0gH4xKU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EZQa4Nf+GmXe1MCG73lGh90QgnrMQoh9gGZgFU252K974d2p5fwPwEOveeh6SWSTBmhDE5tC16itITzaLYRTLQI00xCpDsU5HvULj+Rrfq0aDyhvzxF8IZZweOQgdm38JcuLFuAx59I12KXiJVswIPYrP2ehtyeT5/v8kWs1DWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=diYtzyhY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 794EAC16AAE;
	Sun, 23 Nov 2025 16:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763915704;
	bh=2D/f1isgO+0iEZX+RYjDVeosEKzTc82UACIJ0gH4xKU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=diYtzyhYdCrEw0iWEU8S1WDbKByrprx92yIo36wsHo10mu7P9mVm/EG7a6Ttu4N4b
	 dc3WN6SKESFdCS/da8hcDO/7tfX/NbJBZ4/ryQuj/wJ5rh5/oL1KB86iOld8WAJ0zV
	 8St6W5gwiXzNUGNG/IS9BM9z5bixLvbnpJG7lsl8Jl8qGTcNnuQKsmjcWrGBUoizj0
	 kPNUYA93Nu7MHsJNVTZm3hhHk0am8+TaiV8SWhIFW80HdL6rHD6Ej2rBRivciocuXV
	 VH+JcinY3fm6oZJalM24ojM3fLnD7M9phq7o198MbXVBuqQc8dM7VOzQF3fyQ9uSbH
	 dWKXJlnNPySMg==
From: Christian Brauner <brauner@kernel.org>
Date: Sun, 23 Nov 2025 17:33:59 +0100
Subject: [PATCH v4 41/47] ntsync: convert ntsync_obj_get_fd() to
 FD_PREPARE()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251123-work-fd-prepare-v4-41-b6efa1706cfd@kernel.org>
References: <20251123-work-fd-prepare-v4-0-b6efa1706cfd@kernel.org>
In-Reply-To: <20251123-work-fd-prepare-v4-0-b6efa1706cfd@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
 Amir Goldstein <amir73il@gmail.com>, Jens Axboe <axboe@kernel.dk>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1074; i=brauner@kernel.org;
 h=from:subject:message-id; bh=2D/f1isgO+0iEZX+RYjDVeosEKzTc82UACIJ0gH4xKU=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQqm0f3H3jauzPu93zm7sAPdfIP7/R9/H5Vpco59q7F2
 YITmqUvOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbif46RYfoM32sWy6+dk6jN
 Ffs1R8om8kyFiPw6iaapuy+eu7Tc34HhvweLyQar7Bcue7VPKM06vNXJ48bD0zWexY9WsoZGLuR
 dwgYA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 drivers/misc/ntsync.c | 20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/drivers/misc/ntsync.c b/drivers/misc/ntsync.c
index 999026a1ae04..3f88cd46dd25 100644
--- a/drivers/misc/ntsync.c
+++ b/drivers/misc/ntsync.c
@@ -721,21 +721,11 @@ static struct ntsync_obj *ntsync_alloc_obj(struct ntsync_device *dev,
 
 static int ntsync_obj_get_fd(struct ntsync_obj *obj)
 {
-	struct file *file;
-	int fd;
-
-	fd = get_unused_fd_flags(O_CLOEXEC);
-	if (fd < 0)
-		return fd;
-	file = anon_inode_getfile("ntsync", &ntsync_obj_fops, obj, O_RDWR);
-	if (IS_ERR(file)) {
-		put_unused_fd(fd);
-		return PTR_ERR(file);
-	}
-	obj->file = file;
-	fd_install(fd, file);
-
-	return fd;
+	FD_PREPARE(fdf, O_CLOEXEC,
+		   anon_inode_getfile("ntsync", &ntsync_obj_fops, obj, O_RDWR));
+	if (!fdf.err)
+		obj->file = fd_prepare_file(fdf);
+	return fd_publish(fdf);
 }
 
 static int ntsync_create_sem(struct ntsync_device *dev, void __user *argp)

-- 
2.47.3


