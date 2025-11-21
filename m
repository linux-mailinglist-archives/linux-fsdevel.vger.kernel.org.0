Return-Path: <linux-fsdevel+bounces-69415-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 32F2EC7B304
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 19:03:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1D5544EBCF3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 18:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D29C5351FC9;
	Fri, 21 Nov 2025 18:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KJSIxBly"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24BA6238159
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Nov 2025 18:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763748088; cv=none; b=qXDMPwhoJZ1AjjYUst78IH8ANEgpxvCyMNvqQEBEEaDjHttftFROwEFzbPHp3G2i5k8DLfWVFhE3sfbEqyob0iMxBmIKqhMfy2GFlHICTb5HRXfqNyeCbiWB6J70YmghxMRV0BCfQxlyghtlUQn1ieufWk8SQDqCv3xz8wDvYdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763748088; c=relaxed/simple;
	bh=YCMBijmzhGTJGLB2u74sW9Sy5Q6BJL06hrQDe61GfO0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bv0ZvEC0bMOZjD/AMorwKdtD2kr/onnbEG9D+KPg1LSzUHc3q4QYSjOhB+HugFI88HOMMPNOWjrnOx50UqJVauetiTN+gcdaHJaUH1QfU9FeqHww+u5mQF+Ix056jCblFysQlgOIfjlEh0nr6cCDcnozzDu+MWu2lZKF16spjAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KJSIxBly; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F27FDC116C6;
	Fri, 21 Nov 2025 18:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763748087;
	bh=YCMBijmzhGTJGLB2u74sW9Sy5Q6BJL06hrQDe61GfO0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=KJSIxBly8y6wzh8R4c3ZmMhbdPYo19KeKxP97KOeRz+5n18cbW36Z9av4F4PECwfO
	 8FIFC7JABf9wPH6IRKWyky45vgCUo93sS/+oVTS8BmcEd9cUbMXqvfx50azfWFQX2E
	 44hh5Hnat6EHSt9rmqgVfMaHiUlCjhTwsQXw1eOm/GpoWvUQCEV7AMSavVPtYBO0WY
	 TchFDGrwzjNjqpeX8N5rtK3s/XcMF5Q0cz+nN49A0/5s5kyGTTlw89oCOZn/MmdDyV
	 5O952/o0kGvYBD247s7NwEkCGnf7JoTh7Q4SsGeBp6x955AXZ9jO6LRYt/MKS67jpl
	 30Ad3ygbx/Yfg==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 21 Nov 2025 19:00:56 +0100
Subject: [PATCH RFC v3 17/47] xfs: convert xfs_open_by_handle() to
 FD_PREPARE()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251121-work-fd-prepare-v3-17-2c6444d13e0e@kernel.org>
References: <20251121-work-fd-prepare-v3-0-2c6444d13e0e@kernel.org>
In-Reply-To: <20251121-work-fd-prepare-v3-0-2c6444d13e0e@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, 
 Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
 Jens Axboe <axboe@kernel.dk>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2473; i=brauner@kernel.org;
 h=from:subject:message-id; bh=YCMBijmzhGTJGLB2u74sW9Sy5Q6BJL06hrQDe61GfO0=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQqrLjAWucWff6o1vzub0enuezd07N50sLYRVPMO3OTp
 /Arb+/c3lHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRnN+MDI+W9hRL3P0tN1F7
 o/qH9Sus+itZnIMTRU+d89pn+e5HxQdGhkv7bx/36G2S454ntaDgouI0v1i1H3vecxy/fzzeujZ
 sMzsA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/xfs/xfs_handle.c | 53 +++++++++++++++++------------------------------------
 1 file changed, 17 insertions(+), 36 deletions(-)

diff --git a/fs/xfs/xfs_handle.c b/fs/xfs/xfs_handle.c
index f19fce557354..3c1895f7009d 100644
--- a/fs/xfs/xfs_handle.c
+++ b/fs/xfs/xfs_handle.c
@@ -234,13 +234,11 @@ xfs_open_by_handle(
 {
 	const struct cred	*cred = current_cred();
 	int			error;
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
@@ -252,8 +250,7 @@ xfs_open_by_handle(
 
 	/* Restrict xfs_open_by_handle to directories & regular files. */
 	if (!(S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode))) {
-		error = -EPERM;
-		goto out_dput;
+		return -EPERM;
 	}
 
 #if BITS_PER_LONG != 32
@@ -263,48 +260,32 @@ xfs_open_by_handle(
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
-
-	fd = get_unused_fd_flags(0);
-	if (fd < 0) {
-		error = fd;
-		goto out_dput;
-	}
+	if (S_ISDIR(inode->i_mode) && (fmode & FMODE_WRITE))
+		return -EISDIR;
 
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
+	error = ACQUIRE_ERR(fd_prepare, &fdf);
+	if (error)
+		return error;
 
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


