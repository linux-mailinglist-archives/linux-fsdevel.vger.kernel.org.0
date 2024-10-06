Return-Path: <linux-fsdevel+bounces-31115-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82325991D32
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Oct 2024 10:24:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF180B21E98
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Oct 2024 08:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC0E5171E5A;
	Sun,  6 Oct 2024 08:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="neJXzSq9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D513170A3D;
	Sun,  6 Oct 2024 08:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728203051; cv=none; b=t82+TDrbidL/sZ/2MC9dIeaJUE9R0VpsahPag2sC3lErLVdoRn3xla0asdV90sE0Lkpi7Zp439Do3kNNhgVFZZG6T0EgxVBEGqbvpt6O0dXE0srgmX0DA+gcGeTTalCrk1huEie8H9479TOBwy1DJBoN9g0YjLt7YCA4gsCOk0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728203051; c=relaxed/simple;
	bh=EBsdYo7bjPZ1aqvaTJFltbGN+wMV4FZuX0JUqmqPrGM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZQ3L6THgbc1yMhA/HsOpL2SAXZ0sOePN98U98JDXuYVdXtc8oy88GbN9WnPLsMGrAVkMgb9htghsBLKDgLrcIrijNkPmW7FRiEBPXe0GGUJ51eRRwnyCqvHDg4coj4xL/J8GZPkarfa44IpTdKVfPyIBVNS/AAGenzedM6aD/u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=neJXzSq9; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a9932aa108cso188878366b.2;
        Sun, 06 Oct 2024 01:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728203048; x=1728807848; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+teoezE0H0ewSa/OIMieId5ijhGIgbWQwtLr4wiUezo=;
        b=neJXzSq96n8idqYu01voJdAnMyjE6B2f/fzTK5ylyn/fNgXedndFtN0c8AcAoik1oB
         lwAdC7F8OJJuz4+OjkHRNUtZ7Epc+EqctP+UJfO/YA6hK7kL0Hkn90B1aILryVQYPipq
         RUJQBAtCRWyhDU9JmSjw0wclBuaBwhL1LsbWUP3BJNS+h5ffHrrSpZHzC+H9MIFX8Sl7
         17qrbC6T1XV0HJ2clfsXvHQUXAEMoXwGUgi/0ba1UBNPRYooTLdNKNkRGdPmmakq1+GY
         TEmY9MZO6bdkrIMixDeKq564yxn+PKAF9BgFhQ0xL2w2QRsXkLKSB5LZMGSFKJLeGqF/
         OieA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728203048; x=1728807848;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+teoezE0H0ewSa/OIMieId5ijhGIgbWQwtLr4wiUezo=;
        b=kto4e1azsbbvrFsTFvPuyOTvw40IloUZtQk5F6A/huwTrOVkoPReBFLNp4Cnw0GqeY
         JtPK7WXT0sZHB+wS2jIlRq3XeXLYSnbiG/kFr/yCQiotpPnAD3MOHggF07D3Lcqj/g1C
         s2VtpQbIfpc56i+WK7QX5lwg3tTpavAivvgIGo4GSaB6dVxo9fUzyyrqzmfs9YQQZD9r
         ACNSbMo2MWfW3pMrtTgSffzFxh4p5Kk/DjyY51yMmwaSkPmc5eoRYiooDVn1Eql4g0LF
         +2l2FbWdk1axVDfwcTrcmbFTfYbjynkLPOpIpGNdTOFmW+zNpwhSvad3zsXjdaVG1oj/
         BRRA==
X-Forwarded-Encrypted: i=1; AJvYcCU5NtGjvHJKSjeLhzKUeT3UIm3YmF9bEvR6zu5NwL0UV4kdjHZNJ0SaiZNbj0A0vO0de+f3WxpQemZeRxrrCg==@vger.kernel.org, AJvYcCUh/85Tuhjcs32Rfkzrqb4abkTsTkdASBNmz8xNlRP1E1AodmdSXBYg/bQMvjpncQRKX2qeNOlQL/0QeNgl@vger.kernel.org
X-Gm-Message-State: AOJu0YyLUvhMmd1NGjcb2Mko30gIcyMH2v8aVtdFWHSHkQdOAYLdgWL7
	CMm01c23XJz4772MEldZ+9GLtBaYBIo4OwIwrmNDYTWlZxsfi07g
X-Google-Smtp-Source: AGHT+IFYekoqVOml8l0CmtVFgAGuu6Q6Du1f0bxVqfg9jRAEuebkWv8k8ZJgWfhmBzgIkt8hSA6bzg==
X-Received: by 2002:a17:907:9445:b0:a99:bb:736c with SMTP id a640c23a62f3a-a991c01a797mr889263566b.55.1728203047601;
        Sun, 06 Oct 2024 01:24:07 -0700 (PDT)
Received: from amir-ThinkPad-T480.arnhem.chello.nl (92-109-99-123.cable.dynamic.v4.ziggo.nl. [92.109.99.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a993fdd2202sm153215766b.55.2024.10.06.01.24.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2024 01:24:07 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Miklos Szeredi <miklos@szeredi.hu>,
	Al Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-unionfs@vger.kernel.org
Subject: [PATCH v2 4/4] ovl: convert ovl_real_fdget() callers to ovl_real_file()
Date: Sun,  6 Oct 2024 10:23:59 +0200
Message-Id: <20241006082359.263755-5-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241006082359.263755-1-amir73il@gmail.com>
References: <20241006082359.263755-1-amir73il@gmail.com>
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
index ead805e9f2d6..5e3f688ae908 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -183,16 +183,6 @@ static struct file *ovl_real_file(const struct file *file)
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
@@ -262,7 +252,7 @@ static int ovl_release(struct inode *inode, struct file *file)
 static loff_t ovl_llseek(struct file *file, loff_t offset, int whence)
 {
 	struct inode *inode = file_inode(file);
-	struct fd real;
+	struct file *realfile;
 	const struct cred *old_cred;
 	loff_t ret;
 
@@ -278,9 +268,9 @@ static loff_t ovl_llseek(struct file *file, loff_t offset, int whence)
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
@@ -290,17 +280,15 @@ static loff_t ovl_llseek(struct file *file, loff_t offset, int whence)
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
 
@@ -341,8 +329,7 @@ static void ovl_file_accessed(struct file *file)
 static ssize_t ovl_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 {
 	struct file *file = iocb->ki_filp;
-	struct fd real;
-	ssize_t ret;
+	struct file *realfile;
 	struct backing_file_ctx ctx = {
 		.cred = ovl_creds(file_inode(file)->i_sb),
 		.user_file = file,
@@ -352,22 +339,19 @@ static ssize_t ovl_read_iter(struct kiocb *iocb, struct iov_iter *iter)
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
@@ -383,8 +367,9 @@ static ssize_t ovl_write_iter(struct kiocb *iocb, struct iov_iter *iter)
 	/* Update mode */
 	ovl_copyattr(inode);
 
-	ret = ovl_real_fdget(file, &real);
-	if (ret)
+	realfile = ovl_real_file(file);
+	ret = PTR_ERR(realfile);
+	if (IS_ERR(realfile))
 		goto out_unlock;
 
 	if (!ovl_should_sync(OVL_FS(inode->i_sb)))
@@ -395,8 +380,7 @@ static ssize_t ovl_write_iter(struct kiocb *iocb, struct iov_iter *iter)
 	 * this property in case it is set by the issuer.
 	 */
 	ifl &= ~IOCB_DIO_CALLER_COMP;
-	ret = backing_file_write_iter(fd_file(real), iter, iocb, ifl, &ctx);
-	fdput(real);
+	ret = backing_file_write_iter(realfile, iter, iocb, ifl, &ctx);
 
 out_unlock:
 	inode_unlock(inode);
@@ -408,28 +392,24 @@ static ssize_t ovl_splice_read(struct file *in, loff_t *ppos,
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
@@ -437,7 +417,7 @@ static ssize_t ovl_splice_read(struct file *in, loff_t *ppos,
 static ssize_t ovl_splice_write(struct pipe_inode_info *pipe, struct file *out,
 				loff_t *ppos, size_t len, unsigned int flags)
 {
-	struct fd real;
+	struct file *realfile;
 	struct inode *inode = file_inode(out);
 	ssize_t ret;
 	struct backing_file_ctx ctx = {
@@ -450,12 +430,12 @@ static ssize_t ovl_splice_write(struct pipe_inode_info *pipe, struct file *out,
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
@@ -502,7 +482,7 @@ static int ovl_mmap(struct file *file, struct vm_area_struct *vma)
 static long ovl_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
 {
 	struct inode *inode = file_inode(file);
-	struct fd real;
+	struct file *realfile;
 	const struct cred *old_cred;
 	int ret;
 
@@ -513,19 +493,18 @@ static long ovl_fallocate(struct file *file, int mode, loff_t offset, loff_t len
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
 
@@ -534,20 +513,18 @@ static long ovl_fallocate(struct file *file, int mode, loff_t offset, loff_t len
 
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
 
@@ -562,7 +539,7 @@ static loff_t ovl_copyfile(struct file *file_in, loff_t pos_in,
 			    loff_t len, unsigned int flags, enum ovl_copyop op)
 {
 	struct inode *inode_out = file_inode(file_out);
-	struct fd real_in, real_out;
+	struct file *realfile_in, *realfile_out;
 	const struct cred *old_cred;
 	loff_t ret;
 
@@ -575,31 +552,31 @@ static loff_t ovl_copyfile(struct file *file_in, loff_t pos_in,
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
@@ -608,9 +585,6 @@ static loff_t ovl_copyfile(struct file *file_in, loff_t pos_in,
 	/* Update size */
 	ovl_file_modified(file_out);
 
-	fdput(real_in);
-	fdput(real_out);
-
 out_unlock:
 	inode_unlock(inode_out);
 
@@ -654,20 +628,19 @@ static loff_t ovl_remap_file_range(struct file *file_in, loff_t pos_in,
 
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


