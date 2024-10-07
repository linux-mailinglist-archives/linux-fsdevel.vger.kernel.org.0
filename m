Return-Path: <linux-fsdevel+bounces-31189-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A230992EE7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 16:21:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 126761F20F11
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 14:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7AB81D8E10;
	Mon,  7 Oct 2024 14:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QmkYRRRs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299EB1D8E12;
	Mon,  7 Oct 2024 14:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728310778; cv=none; b=qF6C7VtAfmGbVzoa7PnWWMhA7BmoDKto8YjFGksbcTccFqpgw/kP3cNXmZ0VIqqc8gtr27dpB9+1lKiDxNAOQoDBFsKvpWBwjPyMvIfXUmw03suhM8LeTjS1EYZJ35IyNgr1rUXJo0Rsw2nrYrvXMrpZ4pFmE3IQZWY7Pk+TfTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728310778; c=relaxed/simple;
	bh=uOc7LgbeTozMzxPISY+P0F6t7+XoC/59xEXd0gSKaTQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=loh5N7jCdbynkCAHbvrE1m+VyhuErZtzvJ2qa1gGofX13m5NTCMeDZVlqELFdlrBp6wTO+LuaeQqeZ5xfzKE/f+RDt8Mpic/e4qZdOoC0IpQfbjgjLeHbajrGq58xFk1mYtd8AaBHJtr5shVTVEOTeJaSPZroJ6hCD6GDjiK83g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QmkYRRRs; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42cb5b3c57eso46123425e9.2;
        Mon, 07 Oct 2024 07:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728310774; x=1728915574; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l6AatFEIpl32Sf0JO7MLVCai4CToQOaM2lvYJFVBW/M=;
        b=QmkYRRRsFzrt2HQ6U+KYe+6IjZCwrVa9nCAwH35FVYF7AnEjdkizx61RopG7Mzwa0c
         gvmltM0ua7VnjEcpW7a7YEF5x1oFYqMHzRUT11To+CRqqdJv11fsncihEXAMLy14E7Ai
         E/o4x825DXAHZbBzDcKR3vi3hcSYlJkmuxabUj/I0lIGynrV5bSTllOIxK7BJ8vTGSN/
         iJowQk6BS7T429BbMX+PpxbXVAfMs4dCFw2tri8BYry5FWoSDjDz4ZqLe1U8xoov7tJP
         MIUOrLoOdvvTNv1eBS1h598/36FYl8LbXRaJnCDBCv2zvjSjCU+DYwVhorntX+RDQvZK
         MQAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728310774; x=1728915574;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l6AatFEIpl32Sf0JO7MLVCai4CToQOaM2lvYJFVBW/M=;
        b=Q7wYwlL+pkw7dY9V+l2qn5qHvGVPOxj/U09UW6pZ4henPCGZxhsjygVIDpcZzS+0pK
         7jo+o/hvyS9D+VfhMEAChszbg33YeMVAcb7vbuIhhevwc9zu2DdngfjiG80XCxZJ1rql
         o4iugHwe5YsPeknXzSce+C3kEh6gWQVq+hIMj2Ak+mBxFy4znLj+IPu3gCM5vc6Hqe7o
         vHMRIAuGo0lyeL9pbVmpcwfJPmof/h46+sSVMFWvwYZyAVjT4Lrlrz6Br4YeKcVIb1+6
         npan76ynzr6tYWKLK8pJrIT9FdQEzJchmOiaJtOJJB2/WBnfvCxRQE/ho77T8OtjfBtw
         y+xQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhvdS6cHhBf9/PwEuDYzbJZi/RSYxbpEJaOUf8O0lkC/itAsoYsSd0Kvj/b5TTUgSZO6LubxP/07X8bQjw@vger.kernel.org, AJvYcCUvFRT1LhL4M9xtV4o+10vEL+owuqHLBQQkp56hsoPMvgY+FHHl53reEan3uKmXFVGs9g7yR0JQCMj4seyY/w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxP3IrZ5iUWtgsWhazUzve8ykjJpKredabQ2xG8eqoz1oSMRqrg
	b9Z0ZoizNgSy1AGqMWZikX+qSk7rgpFjWQKmkzijaT87qpUhl7z2
X-Google-Smtp-Source: AGHT+IEzrJ5onqsSRhtq2z/x8MzpBInyLvLW3tEHtP6swCEEnm2BRyl6KFRx2hW98rG8i5bC2Ajl+A==
X-Received: by 2002:a05:600c:46c6:b0:42c:e0da:f15c with SMTP id 5b1f17b1804b1-42f85ab8695mr82976565e9.20.1728310773960;
        Mon, 07 Oct 2024 07:19:33 -0700 (PDT)
Received: from amir-ThinkPad-T480.arnhem.chello.nl (92-109-99-123.cable.dynamic.v4.ziggo.nl. [92.109.99.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d16970520sm5829396f8f.96.2024.10.07.07.19.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 07:19:33 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Miklos Szeredi <miklos@szeredi.hu>,
	Al Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-unionfs@vger.kernel.org
Subject: [PATCH v3 5/5] ovl: convert ovl_real_fdget() callers to ovl_real_file()
Date: Mon,  7 Oct 2024 16:19:25 +0200
Message-Id: <20241007141925.327055-6-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241007141925.327055-1-amir73il@gmail.com>
References: <20241007141925.327055-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Stop using struct fd to return a real file from ovl_real_fdget(),
because we no longer return a temporary file object and the callers
always get a borrowed file reference.

Rename the helper to ovl_real_file(), return a borrowed reference of
the real file that is referenced from the overlayfs file or an error.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/overlayfs/file.c | 145 ++++++++++++++++++--------------------------
 1 file changed, 59 insertions(+), 86 deletions(-)

diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index b6d6ccc39dad..b7bec2adb575 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -176,16 +176,6 @@ static struct file *ovl_real_file(const struct file *file)
 	return ovl_real_file_path(file, &realpath);
 }
 
-static int ovl_real_fdget(const struct file *file, struct fd *real)
-{
-	struct file *f = ovl_real_file(file);
-
-	if (IS_ERR(f))
-		return PTR_ERR(f);
-	real->word = (unsigned long)f;
-	return 0;
-}
-
 static struct file *ovl_upper_file(const struct file *file, bool data)
 {
 	struct dentry *dentry = file_dentry(file);
@@ -259,7 +249,7 @@ static int ovl_release(struct inode *inode, struct file *file)
 static loff_t ovl_llseek(struct file *file, loff_t offset, int whence)
 {
 	struct inode *inode = file_inode(file);
-	struct fd real;
+	struct file *realfile;
 	const struct cred *old_cred;
 	loff_t ret;
 
@@ -275,9 +265,9 @@ static loff_t ovl_llseek(struct file *file, loff_t offset, int whence)
 			return vfs_setpos(file, 0, 0);
 	}
 
-	ret = ovl_real_fdget(file, &real);
-	if (ret)
-		return ret;
+	realfile = ovl_real_file(file);
+	if (IS_ERR(realfile))
+		return PTR_ERR(realfile);
 
 	/*
 	 * Overlay file f_pos is the master copy that is preserved
@@ -287,17 +277,15 @@ static loff_t ovl_llseek(struct file *file, loff_t offset, int whence)
 	 * files, so we use the real file to perform seeks.
 	 */
 	ovl_inode_lock(inode);
-	fd_file(real)->f_pos = file->f_pos;
+	realfile->f_pos = file->f_pos;
 
 	old_cred = ovl_override_creds(inode->i_sb);
-	ret = vfs_llseek(fd_file(real), offset, whence);
+	ret = vfs_llseek(realfile, offset, whence);
 	revert_creds(old_cred);
 
-	file->f_pos = fd_file(real)->f_pos;
+	file->f_pos = realfile->f_pos;
 	ovl_inode_unlock(inode);
 
-	fdput(real);
-
 	return ret;
 }
 
@@ -338,8 +326,7 @@ static void ovl_file_accessed(struct file *file)
 static ssize_t ovl_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 {
 	struct file *file = iocb->ki_filp;
-	struct fd real;
-	ssize_t ret;
+	struct file *realfile;
 	struct backing_file_ctx ctx = {
 		.cred = ovl_creds(file_inode(file)->i_sb),
 		.user_file = file,
@@ -349,22 +336,19 @@ static ssize_t ovl_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 	if (!iov_iter_count(iter))
 		return 0;
 
-	ret = ovl_real_fdget(file, &real);
-	if (ret)
-		return ret;
-
-	ret = backing_file_read_iter(fd_file(real), iter, iocb, iocb->ki_flags,
-				     &ctx);
-	fdput(real);
+	realfile = ovl_real_file(file);
+	if (IS_ERR(realfile))
+		return PTR_ERR(realfile);
 
-	return ret;
+	return backing_file_read_iter(realfile, iter, iocb, iocb->ki_flags,
+				      &ctx);
 }
 
 static ssize_t ovl_write_iter(struct kiocb *iocb, struct iov_iter *iter)
 {
 	struct file *file = iocb->ki_filp;
 	struct inode *inode = file_inode(file);
-	struct fd real;
+	struct file *realfile;
 	ssize_t ret;
 	int ifl = iocb->ki_flags;
 	struct backing_file_ctx ctx = {
@@ -380,8 +364,9 @@ static ssize_t ovl_write_iter(struct kiocb *iocb, struct iov_iter *iter)
 	/* Update mode */
 	ovl_copyattr(inode);
 
-	ret = ovl_real_fdget(file, &real);
-	if (ret)
+	realfile = ovl_real_file(file);
+	ret = PTR_ERR(realfile);
+	if (IS_ERR(realfile))
 		goto out_unlock;
 
 	if (!ovl_should_sync(OVL_FS(inode->i_sb)))
@@ -392,8 +377,7 @@ static ssize_t ovl_write_iter(struct kiocb *iocb, struct iov_iter *iter)
 	 * this property in case it is set by the issuer.
 	 */
 	ifl &= ~IOCB_DIO_CALLER_COMP;
-	ret = backing_file_write_iter(fd_file(real), iter, iocb, ifl, &ctx);
-	fdput(real);
+	ret = backing_file_write_iter(realfile, iter, iocb, ifl, &ctx);
 
 out_unlock:
 	inode_unlock(inode);
@@ -405,28 +389,24 @@ static ssize_t ovl_splice_read(struct file *in, loff_t *ppos,
 			       struct pipe_inode_info *pipe, size_t len,
 			       unsigned int flags)
 {
-	struct fd real;
-	ssize_t ret;
+	struct file *realfile;
 	struct backing_file_ctx ctx = {
 		.cred = ovl_creds(file_inode(in)->i_sb),
 		.user_file = in,
 		.accessed = ovl_file_accessed,
 	};
 
-	ret = ovl_real_fdget(in, &real);
-	if (ret)
-		return ret;
-
-	ret = backing_file_splice_read(fd_file(real), ppos, pipe, len, flags, &ctx);
-	fdput(real);
+	realfile = ovl_real_file(in);
+	if (IS_ERR(realfile))
+		return PTR_ERR(realfile);
 
-	return ret;
+	return backing_file_splice_read(realfile, ppos, pipe, len, flags, &ctx);
 }
 
 /*
  * Calling iter_file_splice_write() directly from overlay's f_op may deadlock
  * due to lock order inversion between pipe->mutex in iter_file_splice_write()
- * and file_start_write(fd_file(real)) in ovl_write_iter().
+ * and file_start_write(realfile) in ovl_write_iter().
  *
  * So do everything ovl_write_iter() does and call iter_file_splice_write() on
  * the real file.
@@ -434,7 +414,7 @@ static ssize_t ovl_splice_read(struct file *in, loff_t *ppos,
 static ssize_t ovl_splice_write(struct pipe_inode_info *pipe, struct file *out,
 				loff_t *ppos, size_t len, unsigned int flags)
 {
-	struct fd real;
+	struct file *realfile;
 	struct inode *inode = file_inode(out);
 	ssize_t ret;
 	struct backing_file_ctx ctx = {
@@ -447,12 +427,12 @@ static ssize_t ovl_splice_write(struct pipe_inode_info *pipe, struct file *out,
 	/* Update mode */
 	ovl_copyattr(inode);
 
-	ret = ovl_real_fdget(out, &real);
-	if (ret)
+	realfile = ovl_real_file(out);
+	ret = PTR_ERR(realfile);
+	if (IS_ERR(realfile))
 		goto out_unlock;
 
-	ret = backing_file_splice_write(pipe, fd_file(real), ppos, len, flags, &ctx);
-	fdput(real);
+	ret = backing_file_splice_write(pipe, realfile, ppos, len, flags, &ctx);
 
 out_unlock:
 	inode_unlock(inode);
@@ -497,7 +477,7 @@ static int ovl_mmap(struct file *file, struct vm_area_struct *vma)
 static long ovl_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
 {
 	struct inode *inode = file_inode(file);
-	struct fd real;
+	struct file *realfile;
 	const struct cred *old_cred;
 	int ret;
 
@@ -508,19 +488,18 @@ static long ovl_fallocate(struct file *file, int mode, loff_t offset, loff_t len
 	if (ret)
 		goto out_unlock;
 
-	ret = ovl_real_fdget(file, &real);
-	if (ret)
+	realfile = ovl_real_file(file);
+	ret = PTR_ERR(realfile);
+	if (IS_ERR(realfile))
 		goto out_unlock;
 
 	old_cred = ovl_override_creds(file_inode(file)->i_sb);
-	ret = vfs_fallocate(fd_file(real), mode, offset, len);
+	ret = vfs_fallocate(realfile, mode, offset, len);
 	revert_creds(old_cred);
 
 	/* Update size */
 	ovl_file_modified(file);
 
-	fdput(real);
-
 out_unlock:
 	inode_unlock(inode);
 
@@ -529,20 +508,18 @@ static long ovl_fallocate(struct file *file, int mode, loff_t offset, loff_t len
 
 static int ovl_fadvise(struct file *file, loff_t offset, loff_t len, int advice)
 {
-	struct fd real;
+	struct file *realfile;
 	const struct cred *old_cred;
 	int ret;
 
-	ret = ovl_real_fdget(file, &real);
-	if (ret)
-		return ret;
+	realfile = ovl_real_file(file);
+	if (IS_ERR(realfile))
+		return PTR_ERR(realfile);
 
 	old_cred = ovl_override_creds(file_inode(file)->i_sb);
-	ret = vfs_fadvise(fd_file(real), offset, len, advice);
+	ret = vfs_fadvise(realfile, offset, len, advice);
 	revert_creds(old_cred);
 
-	fdput(real);
-
 	return ret;
 }
 
@@ -557,7 +534,7 @@ static loff_t ovl_copyfile(struct file *file_in, loff_t pos_in,
 			    loff_t len, unsigned int flags, enum ovl_copyop op)
 {
 	struct inode *inode_out = file_inode(file_out);
-	struct fd real_in, real_out;
+	struct file *realfile_in, *realfile_out;
 	const struct cred *old_cred;
 	loff_t ret;
 
@@ -570,31 +547,31 @@ static loff_t ovl_copyfile(struct file *file_in, loff_t pos_in,
 			goto out_unlock;
 	}
 
-	ret = ovl_real_fdget(file_out, &real_out);
-	if (ret)
+	realfile_out = ovl_real_file(file_out);
+	ret = PTR_ERR(realfile_out);
+	if (IS_ERR(realfile_out))
 		goto out_unlock;
 
-	ret = ovl_real_fdget(file_in, &real_in);
-	if (ret) {
-		fdput(real_out);
+	realfile_in = ovl_real_file(file_in);
+	ret = PTR_ERR(realfile_in);
+	if (IS_ERR(realfile_in))
 		goto out_unlock;
-	}
 
 	old_cred = ovl_override_creds(file_inode(file_out)->i_sb);
 	switch (op) {
 	case OVL_COPY:
-		ret = vfs_copy_file_range(fd_file(real_in), pos_in,
-					  fd_file(real_out), pos_out, len, flags);
+		ret = vfs_copy_file_range(realfile_in, pos_in,
+					  realfile_out, pos_out, len, flags);
 		break;
 
 	case OVL_CLONE:
-		ret = vfs_clone_file_range(fd_file(real_in), pos_in,
-					   fd_file(real_out), pos_out, len, flags);
+		ret = vfs_clone_file_range(realfile_in, pos_in,
+					   realfile_out, pos_out, len, flags);
 		break;
 
 	case OVL_DEDUPE:
-		ret = vfs_dedupe_file_range_one(fd_file(real_in), pos_in,
-						fd_file(real_out), pos_out, len,
+		ret = vfs_dedupe_file_range_one(realfile_in, pos_in,
+						realfile_out, pos_out, len,
 						flags);
 		break;
 	}
@@ -603,9 +580,6 @@ static loff_t ovl_copyfile(struct file *file_in, loff_t pos_in,
 	/* Update size */
 	ovl_file_modified(file_out);
 
-	fdput(real_in);
-	fdput(real_out);
-
 out_unlock:
 	inode_unlock(inode_out);
 
@@ -649,20 +623,19 @@ static loff_t ovl_remap_file_range(struct file *file_in, loff_t pos_in,
 
 static int ovl_flush(struct file *file, fl_owner_t id)
 {
-	struct fd real;
+	struct file *realfile;
 	const struct cred *old_cred;
-	int err;
+	int err = 0;
 
-	err = ovl_real_fdget(file, &real);
-	if (err)
-		return err;
+	realfile = ovl_real_file(file);
+	if (IS_ERR(realfile))
+		return PTR_ERR(realfile);
 
-	if (fd_file(real)->f_op->flush) {
+	if (realfile->f_op->flush) {
 		old_cred = ovl_override_creds(file_inode(file)->i_sb);
-		err = fd_file(real)->f_op->flush(fd_file(real), id);
+		err = realfile->f_op->flush(realfile, id);
 		revert_creds(old_cred);
 	}
-	fdput(real);
 
 	return err;
 }
-- 
2.34.1


