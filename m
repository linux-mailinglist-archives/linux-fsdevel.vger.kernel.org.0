Return-Path: <linux-fsdevel+bounces-30958-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 988769900E9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 12:24:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15EEF1F2334C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 10:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9480E155385;
	Fri,  4 Oct 2024 10:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lZxpNsfM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05CE4145B11;
	Fri,  4 Oct 2024 10:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728037444; cv=none; b=G40mnLCJ7oARK0Vmn8+fqZYGY/i8UV7x2yYc3tACiwpVng9ZeR6sc4XIAlUmntjxnJlO/R0ry/M8VDEZU2X/1nWcqM3C1488Stw8N2SgxkXbsYDSoP1I3RuJmtKp8eyHlmwWcpyaOmObrQ/7ryP0RXu95sDZtoY1z+qRxMwjvGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728037444; c=relaxed/simple;
	bh=mZkNETqk3L5qcV3oVOG2OSF89PmnYqWEQb+x8gdH1jw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fN2Fj590h0sxHlim4kn1HDPNrt12e9wCKVq5XcRWWnIO3k/8BAuKt18fMzrGW1427Rw0oHwPbpjVNz+covRFJNJ5obxN0+Ao0Ntwn8CNbsD0ztEBN5HF9j3PEZr2YWi3I0xUo7BUQtO+4q1/BY1UgSITAl8tHsZuCTU6cqdP+V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lZxpNsfM; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5398e53ca28so2236613e87.3;
        Fri, 04 Oct 2024 03:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728037440; x=1728642240; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iQ51HK7ZBpY9mejueCfZmXcDg20vSQo6CoBW7kNlEiE=;
        b=lZxpNsfM8HCDm+VLKUVTNy/LCR6tQKlV0pb8dItDKO+9kDr/Ms3EPBbYVc/yt8TuM0
         +UZC+V1GK/xtgmGeEDPMKzuPExyNSTOYIPMv8b+3RTjOTp4Sh6e+cKK7DKY2BrOcUpnK
         jnYL2mJRbPxYNv3hwWhROSE5ShhLcIvIwIjFbxagNQmj3NhEeBxkjReKyXCw4O1dyqpD
         i+izg2syeilBDG3lQzh0Bl4MOWkK9lJRvdNPKFFd+0sp7u0vZ8PyrrVmuKnuYQMbLvos
         miuM277MHEp+E7ycWpmCCQwDx8l36d4nTM1s729HJX/7r7PVYhTGceYqRF6vhv3MEwe0
         zQDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728037440; x=1728642240;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iQ51HK7ZBpY9mejueCfZmXcDg20vSQo6CoBW7kNlEiE=;
        b=a8noejBDZXg5nmBXO7V4q7lAartMJ9xNYrz/dhv59LeyGSHdsJRhd4YiU5FTgVxtrz
         XdE7YoONUxg3wqUdw0FbB1crRmjqIWzugISDPh9nyGkk6NtrmDIig2BjMJyLWSI/QcQq
         C5146Mn/vXzemBaomHdL2L8FzI3b90IsMtYHtcKTxXPtcm0qJAZF3a1dWm5UyExejTqr
         lUYs4Z0NIwsdqUN4SJRn9+kNdAHEjeWZOKZ6d1BEpeuZu3d6RCrJ/QlNPiy5NQyfeSQe
         EJUdZUnnjJPUabKVUcnjEPyce1+tdWjGwVwDgxEsfh6DbowX1P21svEPRYH0hZQ+PihY
         jSUw==
X-Forwarded-Encrypted: i=1; AJvYcCUAUIXkpv9Y+6gafsAW4q6+aE8OPPk4VAxw9G8CpHBvmifK1qpTuF+RcTcx9UFy+vJ9ti5j29ABkMrOr4E8@vger.kernel.org, AJvYcCUkuPrCciQHrzzVCyL38HXYop62G8NDQH5wE+KSX5an6s0AeD3giJBI+Uge6EhkJWRJG7oM3V/kCu9Q5TcK2w==@vger.kernel.org
X-Gm-Message-State: AOJu0YyqnOALsWrlzTPUFH6a59ZyE7nG8I+fdrQ+cJBZ8uGyQ571hZ9/
	fmm1EB1u1FMcXA235WUUi8LytmVxtRr4mDyLkl+yPYONPU7VLP2JQxXya5j/
X-Google-Smtp-Source: AGHT+IG15En7S3WYFXfhSjChlhSzHfeE82pRUDE6Gh7e3SVfbcfbHSLUn7/HINMyC9Dtzc8TJGZ7+Q==
X-Received: by 2002:a17:906:dc93:b0:a99:bb:737b with SMTP id a640c23a62f3a-a991c077e09mr255393966b.55.1728037429199;
        Fri, 04 Oct 2024 03:23:49 -0700 (PDT)
Received: from amir-ThinkPad-T480.arnhem.chello.nl (92-109-99-123.cable.dynamic.v4.ziggo.nl. [92.109.99.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99100a37cdsm207335066b.3.2024.10.04.03.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 03:23:48 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Miklos Szeredi <miklos@szeredi.hu>,
	Al Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-unionfs@vger.kernel.org
Subject: [PATCH 4/4] ovl: convert ovl_real_fdget() callers to ovl_real_file()
Date: Fri,  4 Oct 2024 12:23:42 +0200
Message-Id: <20241004102342.179434-5-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241004102342.179434-1-amir73il@gmail.com>
References: <20241004102342.179434-1-amir73il@gmail.com>
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
 fs/overlayfs/file.c | 142 ++++++++++++++++++--------------------------
 1 file changed, 58 insertions(+), 84 deletions(-)

diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index d383ff22ccdb..b8581c253d45 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -161,15 +161,6 @@ static struct file *ovl_real_file(const struct file *file)
 	return ovl_real_file_meta(file, false);
 }
 
-static int ovl_real_fdget(const struct file *file, struct fd *real)
-{
-	struct file *f = ovl_real_file(file, false);
-	if (IS_ERR(f))
-		return PTR_ERR(f);
-	real->word = (unsigned long)f;
-	return 0;
-}
-
 static int ovl_open(struct inode *inode, struct file *file)
 {
 	struct dentry *dentry = file_dentry(file);
@@ -221,7 +212,7 @@ static int ovl_release(struct inode *inode, struct file *file)
 static loff_t ovl_llseek(struct file *file, loff_t offset, int whence)
 {
 	struct inode *inode = file_inode(file);
-	struct fd real;
+	struct file *realfile;
 	const struct cred *old_cred;
 	loff_t ret;
 
@@ -237,9 +228,9 @@ static loff_t ovl_llseek(struct file *file, loff_t offset, int whence)
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
@@ -249,17 +240,15 @@ static loff_t ovl_llseek(struct file *file, loff_t offset, int whence)
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
 
@@ -300,8 +289,7 @@ static void ovl_file_accessed(struct file *file)
 static ssize_t ovl_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 {
 	struct file *file = iocb->ki_filp;
-	struct fd real;
-	ssize_t ret;
+	struct file *realfile;
 	struct backing_file_ctx ctx = {
 		.cred = ovl_creds(file_inode(file)->i_sb),
 		.user_file = file,
@@ -311,22 +299,19 @@ static ssize_t ovl_read_iter(struct kiocb *iocb, struct iov_iter *iter)
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
@@ -342,8 +327,9 @@ static ssize_t ovl_write_iter(struct kiocb *iocb, struct iov_iter *iter)
 	/* Update mode */
 	ovl_copyattr(inode);
 
-	ret = ovl_real_fdget(file, &real);
-	if (ret)
+	realfile = ovl_real_file(file);
+	ret = PTR_ERR(realfile);
+	if (IS_ERR(realfile))
 		goto out_unlock;
 
 	if (!ovl_should_sync(OVL_FS(inode->i_sb)))
@@ -354,8 +340,7 @@ static ssize_t ovl_write_iter(struct kiocb *iocb, struct iov_iter *iter)
 	 * this property in case it is set by the issuer.
 	 */
 	ifl &= ~IOCB_DIO_CALLER_COMP;
-	ret = backing_file_write_iter(fd_file(real), iter, iocb, ifl, &ctx);
-	fdput(real);
+	ret = backing_file_write_iter(realfile, iter, iocb, ifl, &ctx);
 
 out_unlock:
 	inode_unlock(inode);
@@ -367,28 +352,24 @@ static ssize_t ovl_splice_read(struct file *in, loff_t *ppos,
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
@@ -396,7 +377,7 @@ static ssize_t ovl_splice_read(struct file *in, loff_t *ppos,
 static ssize_t ovl_splice_write(struct pipe_inode_info *pipe, struct file *out,
 				loff_t *ppos, size_t len, unsigned int flags)
 {
-	struct fd real;
+	struct file *realfile;
 	struct inode *inode = file_inode(out);
 	ssize_t ret;
 	struct backing_file_ctx ctx = {
@@ -409,12 +390,12 @@ static ssize_t ovl_splice_write(struct pipe_inode_info *pipe, struct file *out,
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
@@ -461,7 +442,7 @@ static int ovl_mmap(struct file *file, struct vm_area_struct *vma)
 static long ovl_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
 {
 	struct inode *inode = file_inode(file);
-	struct fd real;
+	struct file *realfile;
 	const struct cred *old_cred;
 	int ret;
 
@@ -472,19 +453,18 @@ static long ovl_fallocate(struct file *file, int mode, loff_t offset, loff_t len
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
 
@@ -493,20 +473,18 @@ static long ovl_fallocate(struct file *file, int mode, loff_t offset, loff_t len
 
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
 
@@ -521,7 +499,7 @@ static loff_t ovl_copyfile(struct file *file_in, loff_t pos_in,
 			    loff_t len, unsigned int flags, enum ovl_copyop op)
 {
 	struct inode *inode_out = file_inode(file_out);
-	struct fd real_in, real_out;
+	struct file *realfile_in, *realfile_out;
 	const struct cred *old_cred;
 	loff_t ret;
 
@@ -534,31 +512,31 @@ static loff_t ovl_copyfile(struct file *file_in, loff_t pos_in,
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
@@ -567,9 +545,6 @@ static loff_t ovl_copyfile(struct file *file_in, loff_t pos_in,
 	/* Update size */
 	ovl_file_modified(file_out);
 
-	fdput(real_in);
-	fdput(real_out);
-
 out_unlock:
 	inode_unlock(inode_out);
 
@@ -613,20 +588,19 @@ static loff_t ovl_remap_file_range(struct file *file_in, loff_t pos_in,
 
 static int ovl_flush(struct file *file, fl_owner_t id)
 {
-	struct fd real;
+	struct file *realfile;
 	const struct cred *old_cred;
 	int err;
 
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


