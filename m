Return-Path: <linux-fsdevel+bounces-24540-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62B0F9406ED
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 07:17:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E232C1F2368A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 05:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 034B519148F;
	Tue, 30 Jul 2024 05:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="axZp9i4w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E01C19066C;
	Tue, 30 Jul 2024 05:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722316494; cv=none; b=V1rsXnUxLLaJPfPxBoIRwEXahFWWz4Kz8J14zYjOuoflfuzADcrSAEPsl8G5XS9e7PkMQp5rS0a77gLDgEMfoupkG45vbSyLPVM//RLXGGJysd58lyV7T2pHz+tY3hz5JHzaQhaIqPuKX7zYe4D2U1whSg0E0PodbNK6ZN9/gmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722316494; c=relaxed/simple;
	bh=GMiamKtcXQUOWKUGB80s5vm8czVFoIjuCig72yQL8LM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WjggxcsZnRA7L6vAoLDLcegNCbCSk0ggmfG8KpdobSEPqra9plnH58TOMoqLaCzaPoUqVN65wUFiVYbIFP8bjk9KJQX3nAEuBfbCXQvMfmrVZhMgaTGjCql4WRbu+iqbewLuRn3zGuwqJqy9NVE9SdXAv75V6h32hYSreBa8DQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=axZp9i4w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 733B6C32782;
	Tue, 30 Jul 2024 05:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722316494;
	bh=GMiamKtcXQUOWKUGB80s5vm8czVFoIjuCig72yQL8LM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=axZp9i4wvzi2Yd+etF2WcVPLBnouEb7GqJkhMW5Fi4r8vgTv9dYTL39WWhdQxCOhG
	 kitMmpDG2NJeuri6vNviV1nZr0TI1a3Dt6rEl5bN2arazA5bA8tTWqjMEYUdq3w2mp
	 c+HDFBaDty8nyE80Gx4gvdZJ1jLmSkyJWL0+TsHAfN/HgLteIIet/uZECVlq9HltkX
	 c0DqXi227QCIds55KZbvyPRid5D/hXam8e3oYRl84fsNiWa/q3QE6dGbSADqGl8doi
	 REzyBc9/EWFMFECcAzxIKTA7ZEGLCCLwDh/GDkDoXhq6XE5ScqZN2JY6JeBY/fVhwQ
	 aLyWsaaJd/cMg==
From: viro@kernel.org
To: linux-fsdevel@vger.kernel.org
Cc: amir73il@gmail.com,
	bpf@vger.kernel.org,
	brauner@kernel.org,
	cgroups@vger.kernel.org,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	torvalds@linux-foundation.org
Subject: [PATCH 08/39] experimental: convert fs/overlayfs/file.c to CLASS(...)
Date: Tue, 30 Jul 2024 01:15:54 -0400
Message-Id: <20240730051625.14349-8-viro@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240730051625.14349-1-viro@kernel.org>
References: <20240730050927.GC5334@ZenIV>
 <20240730051625.14349-1-viro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Al Viro <viro@zeniv.linux.org.uk>

There are four places where we end up adding an extra scope
covering just the range from constructor to destructor;
not sure if that's the best way to handle that.

The functions in question are ovl_write_iter(), ovl_splice_write(),
ovl_fadvise() and ovl_copyfile().

This is very likely *NOT* the final form of that thing - it
needs to be discussed.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/overlayfs/file.c | 72 ++++++++++++++++++---------------------------
 1 file changed, 29 insertions(+), 43 deletions(-)

diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index 4b9e145bc7b8..a2911c632137 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -132,6 +132,8 @@ static struct fderr ovl_real_fdget(const struct file *file)
 	return ovl_real_fdget_meta(file, false);
 }
 
+DEFINE_CLASS(fd_real, struct fderr, fdput(_T), ovl_real_fdget(file), struct file *file)
+
 static int ovl_open(struct inode *inode, struct file *file)
 {
 	struct dentry *dentry = file_dentry(file);
@@ -174,7 +176,6 @@ static int ovl_release(struct inode *inode, struct file *file)
 static loff_t ovl_llseek(struct file *file, loff_t offset, int whence)
 {
 	struct inode *inode = file_inode(file);
-	struct fderr real;
 	const struct cred *old_cred;
 	loff_t ret;
 
@@ -190,7 +191,7 @@ static loff_t ovl_llseek(struct file *file, loff_t offset, int whence)
 			return vfs_setpos(file, 0, 0);
 	}
 
-	real = ovl_real_fdget(file);
+	CLASS(fd_real, real)(file);
 	if (fd_empty(real))
 		return fd_error(real);
 
@@ -211,8 +212,6 @@ static loff_t ovl_llseek(struct file *file, loff_t offset, int whence)
 	file->f_pos = fd_file(real)->f_pos;
 	ovl_inode_unlock(inode);
 
-	fdput(real);
-
 	return ret;
 }
 
@@ -253,8 +252,6 @@ static void ovl_file_accessed(struct file *file)
 static ssize_t ovl_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 {
 	struct file *file = iocb->ki_filp;
-	struct fderr real;
-	ssize_t ret;
 	struct backing_file_ctx ctx = {
 		.cred = ovl_creds(file_inode(file)->i_sb),
 		.user_file = file,
@@ -264,22 +261,18 @@ static ssize_t ovl_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 	if (!iov_iter_count(iter))
 		return 0;
 
-	real = ovl_real_fdget(file);
+	CLASS(fd_real, real)(file);
 	if (fd_empty(real))
 		return fd_error(real);
 
-	ret = backing_file_read_iter(fd_file(real), iter, iocb, iocb->ki_flags,
-				     &ctx);
-	fdput(real);
-
-	return ret;
+	return backing_file_read_iter(fd_file(real), iter, iocb, iocb->ki_flags,
+				      &ctx);
 }
 
 static ssize_t ovl_write_iter(struct kiocb *iocb, struct iov_iter *iter)
 {
 	struct file *file = iocb->ki_filp;
 	struct inode *inode = file_inode(file);
-	struct fderr real;
 	ssize_t ret;
 	int ifl = iocb->ki_flags;
 	struct backing_file_ctx ctx = {
@@ -295,7 +288,9 @@ static ssize_t ovl_write_iter(struct kiocb *iocb, struct iov_iter *iter)
 	/* Update mode */
 	ovl_copyattr(inode);
 
-	real = ovl_real_fdget(file);
+	{
+
+	CLASS(fd_real, real)(file);
 	if (fd_empty(real)) {
 		ret = fd_error(real);
 		goto out_unlock;
@@ -310,7 +305,8 @@ static ssize_t ovl_write_iter(struct kiocb *iocb, struct iov_iter *iter)
 	 */
 	ifl &= ~IOCB_DIO_CALLER_COMP;
 	ret = backing_file_write_iter(fd_file(real), iter, iocb, ifl, &ctx);
-	fdput(real);
+
+	}
 
 out_unlock:
 	inode_unlock(inode);
@@ -322,22 +318,18 @@ static ssize_t ovl_splice_read(struct file *in, loff_t *ppos,
 			       struct pipe_inode_info *pipe, size_t len,
 			       unsigned int flags)
 {
-	struct fderr real;
-	ssize_t ret;
+	CLASS(fd_real, real)(in);
 	struct backing_file_ctx ctx = {
 		.cred = ovl_creds(file_inode(in)->i_sb),
 		.user_file = in,
 		.accessed = ovl_file_accessed,
 	};
 
-	real = ovl_real_fdget(in);
 	if (fd_empty(real))
 		return fd_error(real);
 
-	ret = backing_file_splice_read(fd_file(real), ppos, pipe, len, flags, &ctx);
-	fdput(real);
-
-	return ret;
+	return backing_file_splice_read(fd_file(real), ppos, pipe, len, flags,
+					&ctx);
 }
 
 /*
@@ -351,7 +343,6 @@ static ssize_t ovl_splice_read(struct file *in, loff_t *ppos,
 static ssize_t ovl_splice_write(struct pipe_inode_info *pipe, struct file *out,
 				loff_t *ppos, size_t len, unsigned int flags)
 {
-	struct fderr real;
 	struct inode *inode = file_inode(out);
 	ssize_t ret;
 	struct backing_file_ctx ctx = {
@@ -364,15 +355,17 @@ static ssize_t ovl_splice_write(struct pipe_inode_info *pipe, struct file *out,
 	/* Update mode */
 	ovl_copyattr(inode);
 
-	real = ovl_real_fdget(out);
+	{
+
+	CLASS(fd_real, real)(out);
 	if (fd_empty(real)) {
 		ret = fd_error(real);
 		goto out_unlock;
 	}
 
 	ret = backing_file_splice_write(pipe, fd_file(real), ppos, len, flags, &ctx);
-	fdput(real);
 
+	}
 out_unlock:
 	inode_unlock(inode);
 
@@ -420,7 +413,6 @@ static int ovl_mmap(struct file *file, struct vm_area_struct *vma)
 static long ovl_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
 {
 	struct inode *inode = file_inode(file);
-	struct fderr real;
 	const struct cred *old_cred;
 	int ret;
 
@@ -430,7 +422,9 @@ static long ovl_fallocate(struct file *file, int mode, loff_t offset, loff_t len
 	ret = file_remove_privs(file);
 	if (ret)
 		goto out_unlock;
-	real = ovl_real_fdget(file);
+	{
+
+	CLASS(fd_real, real)(file);
 	if (fd_empty(real)) {
 		ret = fd_error(real);
 		goto out_unlock;
@@ -443,8 +437,7 @@ static long ovl_fallocate(struct file *file, int mode, loff_t offset, loff_t len
 	/* Update size */
 	ovl_file_modified(file);
 
-	fdput(real);
-
+	}
 out_unlock:
 	inode_unlock(inode);
 
@@ -453,11 +446,10 @@ static long ovl_fallocate(struct file *file, int mode, loff_t offset, loff_t len
 
 static int ovl_fadvise(struct file *file, loff_t offset, loff_t len, int advice)
 {
-	struct fderr real;
+	CLASS(fd_real, real)(file);
 	const struct cred *old_cred;
 	int ret;
 
-	real = ovl_real_fdget(file);
 	if (fd_empty(real))
 		return fd_error(real);
 
@@ -465,8 +457,6 @@ static int ovl_fadvise(struct file *file, loff_t offset, loff_t len, int advice)
 	ret = vfs_fadvise(fd_file(real), offset, len, advice);
 	revert_creds(old_cred);
 
-	fdput(real);
-
 	return ret;
 }
 
@@ -481,7 +471,6 @@ static loff_t ovl_copyfile(struct file *file_in, loff_t pos_in,
 			    loff_t len, unsigned int flags, enum ovl_copyop op)
 {
 	struct inode *inode_out = file_inode(file_out);
-	struct fderr real_in, real_out;
 	const struct cred *old_cred;
 	loff_t ret;
 
@@ -494,15 +483,16 @@ static loff_t ovl_copyfile(struct file *file_in, loff_t pos_in,
 			goto out_unlock;
 	}
 
-	real_out = ovl_real_fdget(file_out);
+	{
+
+	CLASS(fd_real, real_out)(file_out);
 	if (fd_empty(real_out)) {
 		ret = fd_error(real_out);
 		goto out_unlock;
 	}
 
-	real_in = ovl_real_fdget(file_in);
+	CLASS(fd_real, real_in)(file_in);
 	if (fd_empty(real_in)) {
-		fdput(real_out);
 		ret = fd_error(real_in);
 		goto out_unlock;
 	}
@@ -530,8 +520,7 @@ static loff_t ovl_copyfile(struct file *file_in, loff_t pos_in,
 	/* Update size */
 	ovl_file_modified(file_out);
 
-	fdput(real_in);
-	fdput(real_out);
+	}
 
 out_unlock:
 	inode_unlock(inode_out);
@@ -576,11 +565,10 @@ static loff_t ovl_remap_file_range(struct file *file_in, loff_t pos_in,
 
 static int ovl_flush(struct file *file, fl_owner_t id)
 {
-	struct fderr real;
+	CLASS(fd_real, real)(file);
 	const struct cred *old_cred;
 	int err = 0;
 
-	real = ovl_real_fdget(file);
 	if (fd_empty(real))
 		return fd_error(real);
 
@@ -589,8 +577,6 @@ static int ovl_flush(struct file *file, fl_owner_t id)
 		err = fd_file(real)->f_op->flush(fd_file(real), id);
 		revert_creds(old_cred);
 	}
-	fdput(real);
-
 	return err;
 }
 
-- 
2.39.2


