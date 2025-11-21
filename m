Return-Path: <linux-fsdevel+bounces-69431-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B6F2BC7B31C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 19:04:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 612254EDDB5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 18:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1C14352FB7;
	Fri, 21 Nov 2025 18:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mb+X5HqI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A27352FB3
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Nov 2025 18:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763748121; cv=none; b=f/8fh+Suph/0dKSoh1HSdMBedSTyYWpAT8JGEV0GIFaiqQiwvM21euYlzhgy9Zol/iivyr5gp6SG4jdnK+80oUg3z1rzeOdKSjX9yJhTPsiXciIoFOQXM9K47Vpn8m28X+t2S4l/l5/MGOrGP3F8oUEWd8IkN6pnSDspgWXZVnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763748121; c=relaxed/simple;
	bh=rh0GlqXZG060kGhzXcuFTs4wtqCOzzOpjB70T1Lstz0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a5qfE+Et4tPpztmKubCanFkHoY0cfNt2qqPfEa9Lmc/X+aMU3mt02fw/WRxfG2JJpFwspt1rWUKMy6l59u7oXFuwXNQZAJe2pBOrXU+9KBs0Jrho75KK9b6Wa+DIfwXbizzQdTgLW6g0LfZiI1O7T56NCGzlyDmZBj5TA/z/Mdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mb+X5HqI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72E1AC116D0;
	Fri, 21 Nov 2025 18:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763748121;
	bh=rh0GlqXZG060kGhzXcuFTs4wtqCOzzOpjB70T1Lstz0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Mb+X5HqIk7ktwUoJaR2DMl58x4f07wG2lSm6nsry79YsKlIEuPiws7snOA6dOoyY3
	 EPWEWTH+cY39SABJsYuOx94i2XzZKQP1AbEJp2vOnG71k78WDVUQs7giKlQ+xz3EGp
	 5orvK8wrLjn6Uwn2yAdNve/AwGEPAQHEAK1OQ1Fu8FU+whEuO/l1U3IVOsKXNwd+q8
	 SSBHkAND/xyWiFxqU9imHItToJAjVtq5QYyVSnUvhmirufyDydbs/g/MLNTi09L+Qx
	 /mqosF8sSJvGpMAp3BDe/mzgZBlz2U0jj1rHdFhOQWXSil6JEckPElsw1rbpHHMT4L
	 r4/UWta9zxrmw==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 21 Nov 2025 19:01:12 +0100
Subject: [PATCH RFC v3 33/47] papr-hvpipe: convert
 papr_hvpipe_dev_create_handle() to FD_PREPARE()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251121-work-fd-prepare-v3-33-2c6444d13e0e@kernel.org>
References: <20251121-work-fd-prepare-v3-0-2c6444d13e0e@kernel.org>
In-Reply-To: <20251121-work-fd-prepare-v3-0-2c6444d13e0e@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, 
 Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
 Jens Axboe <axboe@kernel.dk>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2119; i=brauner@kernel.org;
 h=from:subject:message-id; bh=rh0GlqXZG060kGhzXcuFTs4wtqCOzzOpjB70T1Lstz0=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQqrLi4KrQ1+HLOaXYVtiyBbI8fbgZGL8XFhcNnXSk/I
 LcjkN2lo5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCL2UYwMt757+Efc2/rvpN/C
 jNLL0c/uBu6LmH7k9JJTK44874l/H8TIsMj6InPxJOvdO9SX7fKc6j/lruA/DinRtaKRZUZpQeX
 vuQE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Fixes a UAF for src_info as well.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 arch/powerpc/platforms/pseries/papr-hvpipe.c | 37 +++++++---------------------
 1 file changed, 9 insertions(+), 28 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/papr-hvpipe.c b/arch/powerpc/platforms/pseries/papr-hvpipe.c
index 21a2f447c43f..e752f3404af6 100644
--- a/arch/powerpc/platforms/pseries/papr-hvpipe.c
+++ b/arch/powerpc/platforms/pseries/papr-hvpipe.c
@@ -479,10 +479,8 @@ static const struct file_operations papr_hvpipe_handle_ops = {
 
 static int papr_hvpipe_dev_create_handle(u32 srcID)
 {
-	struct hvpipe_source_info *src_info;
-	struct file *file;
+	struct hvpipe_source_info *src_info __free(kfree) = NULL;
 	long err;
-	int fd;
 
 	spin_lock(&hvpipe_src_list_lock);
 	/*
@@ -506,20 +504,14 @@ static int papr_hvpipe_dev_create_handle(u32 srcID)
 	src_info->tsk = current;
 	init_waitqueue_head(&src_info->recv_wqh);
 
-	fd = get_unused_fd_flags(O_RDONLY | O_CLOEXEC);
-	if (fd < 0) {
-		err = fd;
+	FD_PREPARE(fdf, O_RDONLY | O_CLOEXEC,
+		   anon_inode_getfile("[papr-hvpipe]", &papr_hvpipe_handle_ops,
+				      (void *)src_info, O_RDWR));
+	err = ACQUIRE_ERR(fd_prepare, &fdf);
+	if (err)
 		goto free_buf;
-	}
-
-	file = anon_inode_getfile("[papr-hvpipe]",
-			&papr_hvpipe_handle_ops, (void *)src_info,
-			O_RDWR);
-	if (IS_ERR(file)) {
-		err = PTR_ERR(file);
-		goto free_fd;
-	}
 
+	retain_and_null_ptr(src_info);
 	spin_lock(&hvpipe_src_list_lock);
 	/*
 	 * If two processes are executing ioctl() for the same
@@ -528,22 +520,11 @@ static int papr_hvpipe_dev_create_handle(u32 srcID)
 	 */
 	if (hvpipe_find_source(srcID)) {
 		spin_unlock(&hvpipe_src_list_lock);
-		err = -EALREADY;
-		goto free_file;
+		return -EALREADY;
 	}
 	list_add(&src_info->list, &hvpipe_src_list);
 	spin_unlock(&hvpipe_src_list_lock);
-
-	fd_install(fd, file);
-	return fd;
-
-free_file:
-	fput(file);
-free_fd:
-	put_unused_fd(fd);
-free_buf:
-	kfree(src_info);
-	return err;
+	return fd_publish(fdf);
 }
 
 /*

-- 
2.47.3


