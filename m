Return-Path: <linux-fsdevel+bounces-21147-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F3C58FF9CE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 04:00:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 159301C210B6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 02:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA1A21C2AF;
	Fri,  7 Jun 2024 02:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="wn8W7H/9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58985125C0
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Jun 2024 02:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717725603; cv=none; b=f0sKS2Ju0coU9ft+9FrdNexYmDMm40UUyF/jJs/WTw1CwBGSKKkNlzndSf53nMWdGWPvuKVbW4qYRLX13ovA/HrNcnokB66/XtYxCxa/XgPK55NRE0UfRSvQuAgPO3vxhUnzdC7PpzxGdr6NxuCFrM3VrklAacGyW7xo4HaR1nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717725603; c=relaxed/simple;
	bh=wCU7Vob8BOTErlpqdONt5vHANtK+zT2YMo8ovGRfmWQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=geX5wNPsMWSK3SY9zhIh1vYYcqm5M5YRxl7ZFq5C2e1BkrpVl/P93MxrfymNMRtsrKBerBV3cMxLqkU1SjEQ3FtmcWct7d4xPF7cD3OswvUjc3zN7QofhcHmVdCEOnvahy60MF7ePoUd9iRwGKOybejAKEYQWH1qnLxAU1ISRYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=wn8W7H/9; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=gWHqG4B0VA72DIxMeIGtuYic1XRhNVSYC5SrYxF2ZeQ=; b=wn8W7H/9tLJ1GgrGe1PFLE5Wxz
	H8+7/izyYg/0WIjBsmnUUxSFLiuqYpwrzhHBwdTrRcw1ot8YnQ9F3iplmWn5rEfb7I4ga2hupKyQI
	PlDCK6DPSGFHDS1Whx2iAl894mc9UXK+rQoas17sWi3kB8QY2lM33Ekiz2w94YvI+CnJs+iHBMhvw
	Lbe8ZWemEziKDMHgRm5XFY4AndKIDGWxjzWSF9YN5pi9/IujTsCsOIasaNYowomh5fCe345uEG+c4
	5PW1efRN6pE2qDKtxSJTFoOs62FjRUZ85IRzcex6DLdtiWCKPzu0HCSkcmHRFDqPz1bflsmR6hdUf
	/xUZMPQw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1sFOta-009xBl-2T;
	Fri, 07 Jun 2024 01:59:58 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	torvalds@linux-foundation.org
Subject: [PATCH 07/19] introduce struct fderr, convert overlayfs uses to that
Date: Fri,  7 Jun 2024 02:59:45 +0100
Message-Id: <20240607015957.2372428-7-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240607015957.2372428-1-viro@zeniv.linux.org.uk>
References: <20240607015656.GX1629371@ZenIV>
 <20240607015957.2372428-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

Similar to struct fd; unlike struct fd, it can represent
error values.

Accessors:

* fd_empty(f):	true if f represents an error
* fd_file(f):	just as for struct fd it yields a pointer to
		struct file if fd_empty(f) is false.  If
		fd_empty(f) is true, fd_file(f) is guaranteed
		_not_ to be an address of any object (IS_ERR()
		will be true in that case)
* fd_error(f):	if f represents an error, returns that error,
		otherwise the return value is junk.

Constructors:

* ERR_FD(-E...):	an instance encoding given error [ERR_FDERR, perhaps?]
* BORROWED_FDERR(file):	if file points to a struct file instance,
			return a struct fderr representing that file
			reference with no flags set.
			if file is an ERR_PTR(-E...), return a struct
			fderr representing that error.
			file MUST NOT be NULL.
* CLONED_FDERR(file):	similar, but in case when file points to
			a struct file instance, set FDPUT_FPUT in flags.

fdput_err() serves as a destructor.

See fs/overlayfs/file.c for example of use.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/overlayfs/file.c  | 149 +++++++++++++++++--------------------------
 include/linux/file.h |  39 ++++++++++-
 2 files changed, 97 insertions(+), 91 deletions(-)

diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index 458299873780..d57106966084 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -89,58 +89,51 @@ static int ovl_change_flags(struct file *file, unsigned int flags)
 	return 0;
 }
 
-static int ovl_real_fdget_meta(const struct file *file, struct fd *real,
-			       bool allow_meta)
+static struct fderr ovl_real_fdget_meta(const struct file *file, bool allow_meta)
 {
 	struct dentry *dentry = file_dentry(file);
 	struct file *private = file->private_data;
 	struct path realpath;
 	int err;
 
-	real->word = (unsigned long)private;
-
 	if (allow_meta) {
 		ovl_path_real(dentry, &realpath);
 	} else {
 		/* lazy lookup and verify of lowerdata */
 		err = ovl_verify_lowerdata(dentry);
 		if (err)
-			return err;
+			return ERR_FD(err);
 
 		ovl_path_realdata(dentry, &realpath);
 	}
 	if (!realpath.dentry)
-		return -EIO;
+		return ERR_FD(-EIO);
 
 	/* Has it been copied up since we'd opened it? */
 	if (unlikely(file_inode(private) != d_inode(realpath.dentry))) {
-		struct file *f = ovl_open_realfile(file, &realpath);
-		if (IS_ERR(f))
-			return PTR_ERR(f);
-		real->word = (unsigned long)ovl_open_realfile(file, &realpath) | FDPUT_FPUT;
-		return 0;
+		return CLONED_FDERR(ovl_open_realfile(file, &realpath));
 	}
 
 	/* Did the flags change since open? */
-	if (unlikely((file->f_flags ^ private->f_flags) & ~OVL_OPEN_FLAGS))
-		return ovl_change_flags(private, file->f_flags);
+	if (unlikely((file->f_flags ^ private->f_flags) & ~OVL_OPEN_FLAGS)) {
+		err = ovl_change_flags(private, file->f_flags);
+		if (err)
+			return ERR_FD(err);
+	}
 
-	return 0;
+	return BORROWED_FDERR(private);
 }
 
-static int ovl_real_fdget(const struct file *file, struct fd *real)
+static struct fderr ovl_real_fdget(const struct file *file)
 {
-	if (d_is_dir(file_dentry(file))) {
-		struct file *f = ovl_dir_real_file(file, false);
-		if (IS_ERR(f))
-			return PTR_ERR(f);
-		real->word = (unsigned long)f;
-		return 0;
-	}
+	if (d_is_dir(file_dentry(file)))
+		return BORROWED_FDERR(ovl_dir_real_file(file, false));
 
-	return ovl_real_fdget_meta(file, real, false);
+	return ovl_real_fdget_meta(file, false);
 }
 
+DEFINE_CLASS(fd_real, struct fderr, fdput_err(_T), ovl_real_fdget(file), struct file *file)
+
 static int ovl_open(struct inode *inode, struct file *file)
 {
 	struct dentry *dentry = file_dentry(file);
@@ -183,7 +176,6 @@ static int ovl_release(struct inode *inode, struct file *file)
 static loff_t ovl_llseek(struct file *file, loff_t offset, int whence)
 {
 	struct inode *inode = file_inode(file);
-	struct fd real;
 	const struct cred *old_cred;
 	loff_t ret;
 
@@ -199,9 +191,9 @@ static loff_t ovl_llseek(struct file *file, loff_t offset, int whence)
 			return vfs_setpos(file, 0, 0);
 	}
 
-	ret = ovl_real_fdget(file, &real);
-	if (ret)
-		return ret;
+	CLASS(fd_real, real)(file);
+	if (fd_empty(real))
+		return fd_error(real);
 
 	/*
 	 * Overlay file f_pos is the master copy that is preserved
@@ -220,8 +212,6 @@ static loff_t ovl_llseek(struct file *file, loff_t offset, int whence)
 	file->f_pos = fd_file(real)->f_pos;
 	ovl_inode_unlock(inode);
 
-	fdput(real);
-
 	return ret;
 }
 
@@ -262,8 +252,6 @@ static void ovl_file_accessed(struct file *file)
 static ssize_t ovl_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 {
 	struct file *file = iocb->ki_filp;
-	struct fd real;
-	ssize_t ret;
 	struct backing_file_ctx ctx = {
 		.cred = ovl_creds(file_inode(file)->i_sb),
 		.user_file = file,
@@ -273,22 +261,18 @@ static ssize_t ovl_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 	if (!iov_iter_count(iter))
 		return 0;
 
-	ret = ovl_real_fdget(file, &real);
-	if (ret)
-		return ret;
-
-	ret = backing_file_read_iter(fd_file(real), iter, iocb, iocb->ki_flags,
-				     &ctx);
-	fdput(real);
+	CLASS(fd_real, real)(file);
+	if (fd_empty(real))
+		return fd_error(real);
 
-	return ret;
+	return backing_file_read_iter(fd_file(real), iter, iocb, iocb->ki_flags,
+				      &ctx);
 }
 
 static ssize_t ovl_write_iter(struct kiocb *iocb, struct iov_iter *iter)
 {
 	struct file *file = iocb->ki_filp;
 	struct inode *inode = file_inode(file);
-	struct fd real;
 	ssize_t ret;
 	int ifl = iocb->ki_flags;
 	struct backing_file_ctx ctx = {
@@ -304,9 +288,11 @@ static ssize_t ovl_write_iter(struct kiocb *iocb, struct iov_iter *iter)
 	/* Update mode */
 	ovl_copyattr(inode);
 
-	ret = ovl_real_fdget(file, &real);
-	if (ret)
+	CLASS(fd_real, real)(file);
+	if (fd_empty(real)) {
+		ret = fd_error(real);
 		goto out_unlock;
+	}
 
 	if (!ovl_should_sync(OVL_FS(inode->i_sb)))
 		ifl &= ~(IOCB_DSYNC | IOCB_SYNC);
@@ -317,7 +303,6 @@ static ssize_t ovl_write_iter(struct kiocb *iocb, struct iov_iter *iter)
 	 */
 	ifl &= ~IOCB_DIO_CALLER_COMP;
 	ret = backing_file_write_iter(fd_file(real), iter, iocb, ifl, &ctx);
-	fdput(real);
 
 out_unlock:
 	inode_unlock(inode);
@@ -329,22 +314,18 @@ static ssize_t ovl_splice_read(struct file *in, loff_t *ppos,
 			       struct pipe_inode_info *pipe, size_t len,
 			       unsigned int flags)
 {
-	struct fd real;
-	ssize_t ret;
+	CLASS(fd_real, real)(in);
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
+	if (fd_empty(real))
+		return fd_error(real);
 
-	return ret;
+	return backing_file_splice_read(fd_file(real), ppos, pipe, len, flags,
+					&ctx);
 }
 
 /*
@@ -358,7 +339,6 @@ static ssize_t ovl_splice_read(struct file *in, loff_t *ppos,
 static ssize_t ovl_splice_write(struct pipe_inode_info *pipe, struct file *out,
 				loff_t *ppos, size_t len, unsigned int flags)
 {
-	struct fd real;
 	struct inode *inode = file_inode(out);
 	ssize_t ret;
 	struct backing_file_ctx ctx = {
@@ -371,13 +351,13 @@ static ssize_t ovl_splice_write(struct pipe_inode_info *pipe, struct file *out,
 	/* Update mode */
 	ovl_copyattr(inode);
 
-	ret = ovl_real_fdget(out, &real);
-	if (ret)
+	CLASS(fd_real, real)(out);
+	if (fd_empty(real)) {
+		ret = fd_error(real);
 		goto out_unlock;
+	}
 
 	ret = backing_file_splice_write(pipe, fd_file(real), ppos, len, flags, &ctx);
-	fdput(real);
-
 out_unlock:
 	inode_unlock(inode);
 
@@ -386,7 +366,7 @@ static ssize_t ovl_splice_write(struct pipe_inode_info *pipe, struct file *out,
 
 static int ovl_fsync(struct file *file, loff_t start, loff_t end, int datasync)
 {
-	struct fd real;
+	struct fderr real;
 	const struct cred *old_cred;
 	int ret;
 
@@ -394,9 +374,9 @@ static int ovl_fsync(struct file *file, loff_t start, loff_t end, int datasync)
 	if (ret <= 0)
 		return ret;
 
-	ret = ovl_real_fdget_meta(file, &real, !datasync);
-	if (ret)
-		return ret;
+	real = ovl_real_fdget_meta(file, !datasync);
+	if (fd_empty(real))
+		return fd_error(real);
 
 	/* Don't sync lower file for fear of receiving EROFS error */
 	if (file_inode(fd_file(real)) == ovl_inode_upper(file_inode(file))) {
@@ -405,7 +385,7 @@ static int ovl_fsync(struct file *file, loff_t start, loff_t end, int datasync)
 		revert_creds(old_cred);
 	}
 
-	fdput(real);
+	fdput_err(real);
 
 	return ret;
 }
@@ -425,7 +405,6 @@ static int ovl_mmap(struct file *file, struct vm_area_struct *vma)
 static long ovl_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
 {
 	struct inode *inode = file_inode(file);
-	struct fd real;
 	const struct cred *old_cred;
 	int ret;
 
@@ -436,9 +415,11 @@ static long ovl_fallocate(struct file *file, int mode, loff_t offset, loff_t len
 	if (ret)
 		goto out_unlock;
 
-	ret = ovl_real_fdget(file, &real);
-	if (ret)
+	CLASS(fd_real, real)(file);
+	if (fd_empty(real)) {
+		ret = fd_error(real);
 		goto out_unlock;
+	}
 
 	old_cred = ovl_override_creds(file_inode(file)->i_sb);
 	ret = vfs_fallocate(fd_file(real), mode, offset, len);
@@ -447,8 +428,6 @@ static long ovl_fallocate(struct file *file, int mode, loff_t offset, loff_t len
 	/* Update size */
 	ovl_file_modified(file);
 
-	fdput(real);
-
 out_unlock:
 	inode_unlock(inode);
 
@@ -457,20 +436,17 @@ static long ovl_fallocate(struct file *file, int mode, loff_t offset, loff_t len
 
 static int ovl_fadvise(struct file *file, loff_t offset, loff_t len, int advice)
 {
-	struct fd real;
+	CLASS(fd_real, real)(file);
 	const struct cred *old_cred;
 	int ret;
 
-	ret = ovl_real_fdget(file, &real);
-	if (ret)
-		return ret;
+	if (fd_empty(real))
+		return fd_error(real);
 
 	old_cred = ovl_override_creds(file_inode(file)->i_sb);
 	ret = vfs_fadvise(fd_file(real), offset, len, advice);
 	revert_creds(old_cred);
 
-	fdput(real);
-
 	return ret;
 }
 
@@ -485,7 +461,6 @@ static loff_t ovl_copyfile(struct file *file_in, loff_t pos_in,
 			    loff_t len, unsigned int flags, enum ovl_copyop op)
 {
 	struct inode *inode_out = file_inode(file_out);
-	struct fd real_in, real_out;
 	const struct cred *old_cred;
 	loff_t ret;
 
@@ -498,13 +473,15 @@ static loff_t ovl_copyfile(struct file *file_in, loff_t pos_in,
 			goto out_unlock;
 	}
 
-	ret = ovl_real_fdget(file_out, &real_out);
-	if (ret)
+	CLASS(fd_real, real_out)(file_out);
+	if (fd_empty(real_out)) {
+		ret = fd_error(real_out);
 		goto out_unlock;
+	}
 
-	ret = ovl_real_fdget(file_in, &real_in);
-	if (ret) {
-		fdput(real_out);
+	CLASS(fd_real, real_in)(file_in);
+	if (fd_empty(real_in)) {
+		ret = fd_error(real_in);
 		goto out_unlock;
 	}
 
@@ -531,9 +508,6 @@ static loff_t ovl_copyfile(struct file *file_in, loff_t pos_in,
 	/* Update size */
 	ovl_file_modified(file_out);
 
-	fdput(real_in);
-	fdput(real_out);
-
 out_unlock:
 	inode_unlock(inode_out);
 
@@ -577,21 +551,18 @@ static loff_t ovl_remap_file_range(struct file *file_in, loff_t pos_in,
 
 static int ovl_flush(struct file *file, fl_owner_t id)
 {
-	struct fd real;
+	CLASS(fd_real, real)(file);
 	const struct cred *old_cred;
-	int err;
+	int err = 0;
 
-	err = ovl_real_fdget(file, &real);
-	if (err)
-		return err;
+	if (fd_empty(real))
+		return fd_error(real);
 
 	if (fd_file(real)->f_op->flush) {
 		old_cred = ovl_override_creds(file_inode(file)->i_sb);
 		err = fd_file(real)->f_op->flush(fd_file(real), id);
 		revert_creds(old_cred);
 	}
-	fdput(real);
-
 	return err;
 }
 
diff --git a/include/linux/file.h b/include/linux/file.h
index 744a6315f1ac..6571ef345d35 100644
--- a/include/linux/file.h
+++ b/include/linux/file.h
@@ -10,6 +10,7 @@
 #include <linux/types.h>
 #include <linux/posix_types.h>
 #include <linux/errno.h>
+#include <linux/err.h>
 #include <linux/cleanup.h>
 
 struct file;
@@ -37,13 +38,26 @@ extern struct file *alloc_file_clone(struct file *, int flags,
 struct fd {
 	unsigned long word;
 };
+
+/* either a reference to struct file + flags
+ * (cloned vs. borrowed, pos locked), with
+ * flags stored in lower bits of value,
+ * or an error (represented by small negative value).
+ */
+struct fderr {
+	unsigned long word;
+};
+
 #define FDPUT_FPUT       1
 #define FDPUT_POS_UNLOCK 2
 
+#define fd_empty(f)	_Generic((f), \
+				struct fd: unlikely(!(f).word), \
+				struct fderr: IS_ERR_VALUE((f).word))
 #define fd_file(f) ((struct file *)((f).word & ~3))
-static inline bool fd_empty(struct fd f)
+static inline long fd_error(struct fderr f)
 {
-	return unlikely(!f.word);
+	return (long)f.word;
 }
 
 #define EMPTY_FD (struct fd){0}
@@ -56,12 +70,33 @@ static inline struct fd CLONED_FD(struct file *f)
 	return (struct fd){(unsigned long)f | FDPUT_FPUT};
 }
 
+static inline struct fderr ERR_FD(long n)
+{
+	return (struct fderr){(unsigned long)n};
+}
+static inline struct fderr BORROWED_FDERR(struct file *f)
+{
+	return (struct fderr){(unsigned long)f};
+}
+static inline struct fderr CLONED_FDERR(struct file *f)
+{
+	if (IS_ERR(f))
+		return BORROWED_FDERR(f);
+	return (struct fderr){(unsigned long)f | FDPUT_FPUT};
+}
+
 static inline void fdput(struct fd fd)
 {
 	if (fd.word & FDPUT_FPUT)
 		fput(fd_file(fd));
 }
 
+static inline void fdput_err(struct fderr fd)
+{
+	if (!fd_empty(fd) && fd.word & FDPUT_FPUT)
+		fput(fd_file(fd));
+}
+
 extern struct file *fget(unsigned int fd);
 extern struct file *fget_raw(unsigned int fd);
 extern struct file *fget_task(struct task_struct *task, unsigned int fd);
-- 
2.39.2


