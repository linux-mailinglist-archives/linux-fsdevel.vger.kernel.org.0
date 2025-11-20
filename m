Return-Path: <linux-fsdevel+bounces-69323-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 03E2FC7687F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 23:35:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B11A24E3156
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 22:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CCF930AAC7;
	Thu, 20 Nov 2025 22:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nZgWxEzV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B463A3019CD
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Nov 2025 22:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763678026; cv=none; b=hqcQuccP3dqnUf6vA/M/vuwjqcqhQ3CQNTv55gNe2E+lkjkvF1hWTDIX2OUbOYaXkyJUqg1hZn+SU/oV16fbJUoepHlFO50J/ekiEEw75X26Zx5fbBcuxm0D09E8J+yIUq4EyvaXd+21lLZHU7MVQbsENnTu2jnzciXHIXPPR1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763678026; c=relaxed/simple;
	bh=4BQOJqWgIcvxkttlE4SAiH702RkHaT6k5hy8RKyzXm8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F9qSqtts6ozAK0MfvFN61tx68cpg0B1HjFHYkvARyuwoShgAaa4yeKCRGEFNvIkts0cm+LosV7ewjBFq4fAlVKdN+gHFV2DkcCeT+C5c2Va6rP4RTUf6z2jriFQMCOiPre1M3iyUzAUtYruv/Vf0QKbyikIsmcXH458Vhto5Wto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nZgWxEzV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DC3BC116B1;
	Thu, 20 Nov 2025 22:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763678026;
	bh=4BQOJqWgIcvxkttlE4SAiH702RkHaT6k5hy8RKyzXm8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=nZgWxEzVkP0iJ6fP8uMM1LuRTQ5MWP4hPzbEAEv4la2LOn426qINvEp9TGpGiWx50
	 2fApb241fbjI3350qchWmn9d7oIW5prtL4q5ZkCwWibS/cZF1qQjidmy3n283KvvYK
	 6YGI+d6erePX3xP8uU5fCPnnzqYcPt0AyYbc6827mtiP8XzrJ+kuSyB8cpGJlJ9A8t
	 r0bYfzK6MQCMDf07ZDKG6h0d2jXNNdPq7DjUU+fgGyQv1+Tx8qtPrcfZ8+1Umfl54L
	 Gb/1ywI0mAIzNjYS71FVyHqXmrVKKkGfNsOy3e3eCA2HbHWwqnT+cmLbFvcEA+JcAu
	 NzBtI4gAVfSgA==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 20 Nov 2025 23:32:40 +0100
Subject: [PATCH RFC v2 43/48] tty: convert ptm_open_peer() to FD_PREPARE()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251120-work-fd-prepare-v2-43-fef6ebda05d3@kernel.org>
References: <20251120-work-fd-prepare-v2-0-fef6ebda05d3@kernel.org>
In-Reply-To: <20251120-work-fd-prepare-v2-0-fef6ebda05d3@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, 
 Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
 Jens Axboe <axboe@kernel.dk>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1483; i=brauner@kernel.org;
 h=from:subject:message-id; bh=4BQOJqWgIcvxkttlE4SAiH702RkHaT6k5hy8RKyzXm8=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTKT3vneXrq5D9/PH689GfVit3NdFLX9cPhsjVMuX8br
 kpc2Kfq1lHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRpSsY/qe3ZdSaca27UMl5
 ZlpM7iRJ8WkpPMebfhpqqhr3PCv4lMjIML9h/UXB97dl0j9GOdgmC7lZmcZt3ax8NuWNX9ebsq9
 BjAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 drivers/tty/pty.c | 35 +++++++++--------------------------
 1 file changed, 9 insertions(+), 26 deletions(-)

diff --git a/drivers/tty/pty.c b/drivers/tty/pty.c
index 8bb1a01fef2a..87a794c4a9de 100644
--- a/drivers/tty/pty.c
+++ b/drivers/tty/pty.c
@@ -601,42 +601,25 @@ static struct cdev ptmx_cdev;
  */
 int ptm_open_peer(struct file *master, struct tty_struct *tty, int flags)
 {
-	int fd;
-	struct file *filp;
-	int retval = -EINVAL;
 	struct path path;
 
 	if (tty->driver != ptm_driver)
 		return -EIO;
 
-	fd = get_unused_fd_flags(flags);
-	if (fd < 0) {
-		retval = fd;
-		goto err;
-	}
-
 	/* Compute the slave's path */
 	path.mnt = devpts_mntget(master, tty->driver_data);
-	if (IS_ERR(path.mnt)) {
-		retval = PTR_ERR(path.mnt);
-		goto err_put;
-	}
+	if (IS_ERR(path.mnt))
+		return PTR_ERR(path.mnt);
 	path.dentry = tty->link->driver_data;
 
-	filp = dentry_open(&path, flags, current_cred());
-	mntput(path.mnt);
-	if (IS_ERR(filp)) {
-		retval = PTR_ERR(filp);
-		goto err_put;
-	}
-
-	fd_install(fd, filp);
-	return fd;
+	FD_PREPARE(fdf, flags, dentry_open(&path, flags, current_cred())) {
+		if (fd_prepare_failed(fdf)) {
+			mntput(path.mnt);
+			return fd_prepare_error(fdf);
+		}
 
-err_put:
-	put_unused_fd(fd);
-err:
-	return retval;
+		return fd_publish(fdf);
+	}
 }
 
 static int pty_unix98_ioctl(struct tty_struct *tty,

-- 
2.47.3


