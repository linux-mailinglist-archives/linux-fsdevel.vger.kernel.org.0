Return-Path: <linux-fsdevel+bounces-69539-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 597AEC7E3C6
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Nov 2025 17:34:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E39D34E2231
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Nov 2025 16:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5140028D8CC;
	Sun, 23 Nov 2025 16:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PaPWBkHa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8EFD23184F
	for <linux-fsdevel@vger.kernel.org>; Sun, 23 Nov 2025 16:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763915651; cv=none; b=lusdtgEDr1bAafmqeXYnWKn6A1t45qpkKMCG4yztFzZ9v8Ea5oJTiX25NVqQlYo0pAhurpoOZk1tJVBxhhwYNsD8/7w5WEwLSjeZINfEjY6hR74rR+xbEnKyiCe8Wtc8ZxOC3vlZvHbcG81ygDsPGET6Gb711Lx4gVWK5kPxyec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763915651; c=relaxed/simple;
	bh=ll74F7iQ/xosTBVE1qKrLiWO4kyP3ps/i7CqE1ZI9PM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UZKgbnctHTQq6rbAqx3GSJFLffCr+TAHI8iVPrWD6G4aLLeOjzbQQVj6KuyVCQ/6DCveVdM6JyovdqW910Edqbtq8t5NiMwi8WD1VsN0RVTYXCt9j0z5s3mvxPR66RzuTLwfBU82uH2vogQlfOW7aLL/o4l7vSOa7UeM0wPH8Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PaPWBkHa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D900AC113D0;
	Sun, 23 Nov 2025 16:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763915651;
	bh=ll74F7iQ/xosTBVE1qKrLiWO4kyP3ps/i7CqE1ZI9PM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=PaPWBkHa/9YImGBqjaekxEzEfHUxmnWiQzqvHFaKKXWrmsUKNnxilNI1V5s46zZE/
	 QR/ARC18tNgNnj2MrDx23FwkqjMjHIc1asDOLxE8qkPfviPMsetd5zP2igg8If6a21
	 RICRTh5MqlceXufWltpwRNSGaWzJ3EmHhhduHzQmHxB9nbnNfg4OW/8xbO83u/gsS+
	 aa0kJkyYYoXsi5QWWI9sp7LXryLRyy8fWJM6m/K71JhlCIiXEa6wuRGnhZAVvAD657
	 Z2pGcOCNvj6U3I1atGK0/GDTFKT/ekBJqQk70vOFmKTAH7RK9vf29BK+MfZQDrRpgM
	 cxoTtYTLIR2Sg==
From: Christian Brauner <brauner@kernel.org>
Date: Sun, 23 Nov 2025 17:33:35 +0100
Subject: [PATCH v4 17/47] xfs: convert xfs_open_by_handle() to FD_PREPARE()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251123-work-fd-prepare-v4-17-b6efa1706cfd@kernel.org>
References: <20251123-work-fd-prepare-v4-0-b6efa1706cfd@kernel.org>
In-Reply-To: <20251123-work-fd-prepare-v4-0-b6efa1706cfd@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
 Amir Goldstein <amir73il@gmail.com>, Jens Axboe <axboe@kernel.dk>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2466; i=brauner@kernel.org;
 h=from:subject:message-id; bh=ll74F7iQ/xosTBVE1qKrLiWO4kyP3ps/i7CqE1ZI9PM=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQqm0f+nHjN7uQO+eQHRtKv/k/+lLe2/WzYjS2716lU3
 54qGTZ3fUcpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBEAloZ/gokPGhU4Od085uR
 cW7p89cvo59+fuwy91pI03GP6XKMYiEM/32m16SpPHvSzVaUfb3+04UFTj+tdffo3Ra7E5Ld7Wo
 +nwsA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/xfs/xfs_handle.c | 53 ++++++++++++++++-------------------------------------
 1 file changed, 16 insertions(+), 37 deletions(-)

diff --git a/fs/xfs/xfs_handle.c b/fs/xfs/xfs_handle.c
index f19fce557354..e01d5c0b1113 100644
--- a/fs/xfs/xfs_handle.c
+++ b/fs/xfs/xfs_handle.c
@@ -233,14 +233,11 @@ xfs_open_by_handle(
 	xfs_fsop_handlereq_t	*hreq)
 {
 	const struct cred	*cred = current_cred();
-	int			error;
-	int			fd;
 	int			permflag;
-	struct file		*filp;
 	struct inode		*inode;
 	struct dentry		*dentry;
 	fmode_t			fmode;
-	struct path		path;
+	struct path		path __free(path_put) = {};
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
@@ -252,8 +249,7 @@ xfs_open_by_handle(
 
 	/* Restrict xfs_open_by_handle to directories & regular files. */
 	if (!(S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode))) {
-		error = -EPERM;
-		goto out_dput;
+		return -EPERM;
 	}
 
 #if BITS_PER_LONG != 32
@@ -263,48 +259,31 @@ xfs_open_by_handle(
 	permflag = hreq->oflags;
 	fmode = OPEN_FMODE(permflag);
 	if ((!(permflag & O_APPEND) || (permflag & O_TRUNC)) &&
-	    (fmode & FMODE_WRITE) && IS_APPEND(inode)) {
-		error = -EPERM;
-		goto out_dput;
-	}
+	    (fmode & FMODE_WRITE) && IS_APPEND(inode))
+		return -EPERM;
 
-	if ((fmode & FMODE_WRITE) && IS_IMMUTABLE(inode)) {
-		error = -EPERM;
-		goto out_dput;
-	}
+	if ((fmode & FMODE_WRITE) && IS_IMMUTABLE(inode))
+		return -EPERM;
 
 	/* Can't write directories. */
-	if (S_ISDIR(inode->i_mode) && (fmode & FMODE_WRITE)) {
-		error = -EISDIR;
-		goto out_dput;
-	}
+	if (S_ISDIR(inode->i_mode) && (fmode & FMODE_WRITE))
+		return -EISDIR;
 
-	fd = get_unused_fd_flags(0);
-	if (fd < 0) {
-		error = fd;
-		goto out_dput;
-	}
-
-	path.mnt = parfilp->f_path.mnt;
+	path.mnt = mntget(parfilp->f_path.mnt);
 	path.dentry = dentry;
-	filp = dentry_open(&path, hreq->oflags, cred);
-	dput(dentry);
-	if (IS_ERR(filp)) {
-		put_unused_fd(fd);
-		return PTR_ERR(filp);
-	}
+
+	FD_PREPARE(fdf, 0, dentry_open(&path, hreq->oflags, cred));
+	if (fdf.err)
+		return fdf.err;
 
 	if (S_ISREG(inode->i_mode)) {
+		struct file *filp = fd_prepare_file(fdf);
+
 		filp->f_flags |= O_NOATIME;
 		filp->f_mode |= FMODE_NOCMTIME;
 	}
 
-	fd_install(fd, filp);
-	return fd;
-
- out_dput:
-	dput(dentry);
-	return error;
+	return fd_publish(fdf);
 }
 
 int

-- 
2.47.3


