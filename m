Return-Path: <linux-fsdevel+bounces-30919-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B336E98FB02
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 01:48:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D75B31C22172
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 23:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E4421D0BA7;
	Thu,  3 Oct 2024 23:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="nbXcX4LK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86FCE1CF5CE
	for <linux-fsdevel@vger.kernel.org>; Thu,  3 Oct 2024 23:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727999256; cv=none; b=QsAKugztcZHtlzKTyT0t6KBScM+JbQYDzjvAoI/myWIF/KiEOTZqfbOZIs/MrhKSN7HDu/G/p8+hUSBEgNo6aTlEs9J83kv1AXrL3CQYO/at8Zi1tVBbyWcGDrnR7Q8JDPirQHZoKDkskoLo51huFIul+NYAM1gpwuFhtYETzJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727999256; c=relaxed/simple;
	bh=emPD/oEFgXBRXBtrWDKBc/L+AQIw+LWtCXIkuLM96As=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S9AKQBi+9fylgeQNq/ejjK2AdN5pMVc3plQSy4f213CQoWETo20kItbPpHtn+h2806laHOJMcEn7EndDE4WVoANwh402Z7WPn5uJM83D/51XWUueqDRyiNwEzExwnczSAvorAOA0EsuHDZQoLr1gxs8aRWdmtmo5zVmbc9tcVRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=nbXcX4LK; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ecZvfcDQiI7UJbJUMdCSWVfkiuWs1COsxX3tGJirspA=; b=nbXcX4LKw0Ak6EeGrp3cXfmiqv
	X/uaqQ7GTE4eLvF6O1oqeeIoJtFDyZ1ZO7nMXT4cvaPsy+9NYc5ZeqTQkpTXbtFNubaXdGVdxPan0
	d0aptXQGSWwnKAjOc1mFWroeX9gvDI8xUPU5nlbyPFrzMZxNJewXOD6HWBE/zI2ArqvEnbQgVHbkp
	HLwI+5ydqQIW0UK5rGOwSteNyNTUh13ofm0lCIc4PN2ZCen7CkhBrmWhd6SE01n3zRanZDicE/QGZ
	mTiRVNoEEzzFpgD4BvxT65bqT1yHvCxVr1eGBUUcHRmOsLn6DOtupXt7pRFCyCsdIulA7nFLI0WV3
	+FdOO2tw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1swVXg-00000000cTg-0Ju6;
	Thu, 03 Oct 2024 23:47:32 +0000
Date: Fri, 4 Oct 2024 00:47:32 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Amir Goldstein <amir73il@gmail.com>,
	Miklos Szeredi <miklos@szeredi.hu>
Subject: introduce struct fderr, convert overlayfs uses to that
Message-ID: <20241003234732.GB147780@ZenIV>
References: <20241003234534.GM4017910@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241003234534.GM4017910@ZenIV>
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
* fd_err(f):	if f represents an error, returns that error,
		otherwise the return value is junk.

Constructors:

* ERR_FDERR(-E...):	an instance encoding given error [ERR_FDERR, perhaps?]
* BORROWED_FDERR(file):	if file points to a struct file instance,
			return a struct fderr representing that file
			reference with no flags set.
			if file is an ERR_PTR(-E...), return a struct
			fderr representing that error.
			file MUST NOT be NULL.
* CLONED_FDERR(file):	similar, but in case when file points to
			a struct file instance, set FDPUT_FPUT in flags.

Same destructor as for struct fd; I'm not entirely convinced that
playing with _Generic is a good idea here, but for now let's go
that way...

See fs/overlayfs/file.c for example of use.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/overlayfs/file.c  | 128 +++++++++++++++++++++----------------------
 include/linux/file.h |  37 +++++++++++--
 2 files changed, 95 insertions(+), 70 deletions(-)

diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index 4504493b20be..c711fa5d802f 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -89,56 +89,46 @@ static int ovl_change_flags(struct file *file, unsigned int flags)
 	return 0;
 }
 
-static int ovl_real_fdget_meta(const struct file *file, struct fd *real,
-			       bool allow_meta)
+static struct fderr ovl_real_fdget_meta(const struct file *file, bool allow_meta)
 {
 	struct dentry *dentry = file_dentry(file);
 	struct file *realfile = file->private_data;
 	struct path realpath;
 	int err;
 
-	real->word = (unsigned long)realfile;
-
 	if (allow_meta) {
 		ovl_path_real(dentry, &realpath);
 	} else {
 		/* lazy lookup and verify of lowerdata */
 		err = ovl_verify_lowerdata(dentry);
 		if (err)
-			return err;
+			return ERR_FDERR(err);
 
 		ovl_path_realdata(dentry, &realpath);
 	}
 	if (!realpath.dentry)
-		return -EIO;
+		return ERR_FDERR(-EIO);
 
 	/* Has it been copied up since we'd opened it? */
-	if (unlikely(file_inode(realfile) != d_inode(realpath.dentry))) {
-		struct file *f = ovl_open_realfile(file, &realpath);
-		if (IS_ERR(f))
-			return PTR_ERR(f);
-		real->word = (unsigned long)f | FDPUT_FPUT;
-		return 0;
-	}
+	if (unlikely(file_inode(realfile) != d_inode(realpath.dentry)))
+		return CLONED_FDERR(ovl_open_realfile(file, &realpath));
 
 	/* Did the flags change since open? */
-	if (unlikely((file->f_flags ^ realfile->f_flags) & ~OVL_OPEN_FLAGS))
-		return ovl_change_flags(realfile, file->f_flags);
+	if (unlikely((file->f_flags ^ realfile->f_flags) & ~OVL_OPEN_FLAGS)) {
+		err = ovl_change_flags(realfile, file->f_flags);
+		if (err)
+			return ERR_FDERR(err);
+	}
 
-	return 0;
+	return BORROWED_FDERR(realfile);
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
 
 static int ovl_open(struct inode *inode, struct file *file)
@@ -183,7 +173,7 @@ static int ovl_release(struct inode *inode, struct file *file)
 static loff_t ovl_llseek(struct file *file, loff_t offset, int whence)
 {
 	struct inode *inode = file_inode(file);
-	struct fd real;
+	struct fderr real;
 	const struct cred *old_cred;
 	loff_t ret;
 
@@ -199,9 +189,9 @@ static loff_t ovl_llseek(struct file *file, loff_t offset, int whence)
 			return vfs_setpos(file, 0, 0);
 	}
 
-	ret = ovl_real_fdget(file, &real);
-	if (ret)
-		return ret;
+	real = ovl_real_fdget(file);
+	if (fd_empty(real))
+		return fd_err(real);
 
 	/*
 	 * Overlay file f_pos is the master copy that is preserved
@@ -262,7 +252,7 @@ static void ovl_file_accessed(struct file *file)
 static ssize_t ovl_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 {
 	struct file *file = iocb->ki_filp;
-	struct fd real;
+	struct fderr real;
 	ssize_t ret;
 	struct backing_file_ctx ctx = {
 		.cred = ovl_creds(file_inode(file)->i_sb),
@@ -273,9 +263,9 @@ static ssize_t ovl_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 	if (!iov_iter_count(iter))
 		return 0;
 
-	ret = ovl_real_fdget(file, &real);
-	if (ret)
-		return ret;
+	real = ovl_real_fdget(file);
+	if (fd_empty(real))
+		return fd_err(real);
 
 	ret = backing_file_read_iter(fd_file(real), iter, iocb, iocb->ki_flags,
 				     &ctx);
@@ -288,7 +278,7 @@ static ssize_t ovl_write_iter(struct kiocb *iocb, struct iov_iter *iter)
 {
 	struct file *file = iocb->ki_filp;
 	struct inode *inode = file_inode(file);
-	struct fd real;
+	struct fderr real;
 	ssize_t ret;
 	int ifl = iocb->ki_flags;
 	struct backing_file_ctx ctx = {
@@ -304,9 +294,11 @@ static ssize_t ovl_write_iter(struct kiocb *iocb, struct iov_iter *iter)
 	/* Update mode */
 	ovl_copyattr(inode);
 
-	ret = ovl_real_fdget(file, &real);
-	if (ret)
+	real = ovl_real_fdget(file);
+	if (fd_empty(real)) {
+		ret = fd_err(real);
 		goto out_unlock;
+	}
 
 	if (!ovl_should_sync(OVL_FS(inode->i_sb)))
 		ifl &= ~(IOCB_DSYNC | IOCB_SYNC);
@@ -329,7 +321,7 @@ static ssize_t ovl_splice_read(struct file *in, loff_t *ppos,
 			       struct pipe_inode_info *pipe, size_t len,
 			       unsigned int flags)
 {
-	struct fd real;
+	struct fderr real;
 	ssize_t ret;
 	struct backing_file_ctx ctx = {
 		.cred = ovl_creds(file_inode(in)->i_sb),
@@ -337,9 +329,9 @@ static ssize_t ovl_splice_read(struct file *in, loff_t *ppos,
 		.accessed = ovl_file_accessed,
 	};
 
-	ret = ovl_real_fdget(in, &real);
-	if (ret)
-		return ret;
+	real = ovl_real_fdget(in);
+	if (fd_empty(real))
+		return fd_err(real);
 
 	ret = backing_file_splice_read(fd_file(real), ppos, pipe, len, flags, &ctx);
 	fdput(real);
@@ -358,7 +350,7 @@ static ssize_t ovl_splice_read(struct file *in, loff_t *ppos,
 static ssize_t ovl_splice_write(struct pipe_inode_info *pipe, struct file *out,
 				loff_t *ppos, size_t len, unsigned int flags)
 {
-	struct fd real;
+	struct fderr real;
 	struct inode *inode = file_inode(out);
 	ssize_t ret;
 	struct backing_file_ctx ctx = {
@@ -371,9 +363,11 @@ static ssize_t ovl_splice_write(struct pipe_inode_info *pipe, struct file *out,
 	/* Update mode */
 	ovl_copyattr(inode);
 
-	ret = ovl_real_fdget(out, &real);
-	if (ret)
+	real = ovl_real_fdget(out);
+	if (fd_empty(real)) {
+		ret = fd_err(real);
 		goto out_unlock;
+	}
 
 	ret = backing_file_splice_write(pipe, fd_file(real), ppos, len, flags, &ctx);
 	fdput(real);
@@ -386,7 +380,7 @@ static ssize_t ovl_splice_write(struct pipe_inode_info *pipe, struct file *out,
 
 static int ovl_fsync(struct file *file, loff_t start, loff_t end, int datasync)
 {
-	struct fd real;
+	struct fderr real;
 	const struct cred *old_cred;
 	int ret;
 
@@ -394,9 +388,9 @@ static int ovl_fsync(struct file *file, loff_t start, loff_t end, int datasync)
 	if (ret <= 0)
 		return ret;
 
-	ret = ovl_real_fdget_meta(file, &real, !datasync);
-	if (ret)
-		return ret;
+	real = ovl_real_fdget_meta(file, !datasync);
+	if (fd_empty(real))
+		return fd_err(real);
 
 	/* Don't sync lower file for fear of receiving EROFS error */
 	if (file_inode(fd_file(real)) == ovl_inode_upper(file_inode(file))) {
@@ -425,7 +419,7 @@ static int ovl_mmap(struct file *file, struct vm_area_struct *vma)
 static long ovl_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
 {
 	struct inode *inode = file_inode(file);
-	struct fd real;
+	struct fderr real;
 	const struct cred *old_cred;
 	int ret;
 
@@ -435,10 +429,11 @@ static long ovl_fallocate(struct file *file, int mode, loff_t offset, loff_t len
 	ret = file_remove_privs(file);
 	if (ret)
 		goto out_unlock;
-
-	ret = ovl_real_fdget(file, &real);
-	if (ret)
+	real = ovl_real_fdget(file);
+	if (fd_empty(real)) {
+		ret = fd_err(real);
 		goto out_unlock;
+	}
 
 	old_cred = ovl_override_creds(file_inode(file)->i_sb);
 	ret = vfs_fallocate(fd_file(real), mode, offset, len);
@@ -457,13 +452,13 @@ static long ovl_fallocate(struct file *file, int mode, loff_t offset, loff_t len
 
 static int ovl_fadvise(struct file *file, loff_t offset, loff_t len, int advice)
 {
-	struct fd real;
+	struct fderr real;
 	const struct cred *old_cred;
 	int ret;
 
-	ret = ovl_real_fdget(file, &real);
-	if (ret)
-		return ret;
+	real = ovl_real_fdget(file);
+	if (fd_empty(real))
+		return fd_err(real);
 
 	old_cred = ovl_override_creds(file_inode(file)->i_sb);
 	ret = vfs_fadvise(fd_file(real), offset, len, advice);
@@ -485,7 +480,7 @@ static loff_t ovl_copyfile(struct file *file_in, loff_t pos_in,
 			    loff_t len, unsigned int flags, enum ovl_copyop op)
 {
 	struct inode *inode_out = file_inode(file_out);
-	struct fd real_in, real_out;
+	struct fderr real_in, real_out;
 	const struct cred *old_cred;
 	loff_t ret;
 
@@ -498,13 +493,16 @@ static loff_t ovl_copyfile(struct file *file_in, loff_t pos_in,
 			goto out_unlock;
 	}
 
-	ret = ovl_real_fdget(file_out, &real_out);
-	if (ret)
+	real_out = ovl_real_fdget(file_out);
+	if (fd_empty(real_out)) {
+		ret = fd_err(real_out);
 		goto out_unlock;
+	}
 
-	ret = ovl_real_fdget(file_in, &real_in);
-	if (ret) {
+	real_in = ovl_real_fdget(file_in);
+	if (fd_empty(real_in)) {
 		fdput(real_out);
+		ret = fd_err(real_in);
 		goto out_unlock;
 	}
 
@@ -577,13 +575,13 @@ static loff_t ovl_remap_file_range(struct file *file_in, loff_t pos_in,
 
 static int ovl_flush(struct file *file, fl_owner_t id)
 {
-	struct fd real;
+	struct fderr real;
 	const struct cred *old_cred;
-	int err;
+	int err = 0;
 
-	err = ovl_real_fdget(file, &real);
-	if (err)
-		return err;
+	real = ovl_real_fdget(file);
+	if (fd_empty(real))
+		return fd_err(real);
 
 	if (fd_file(real)->f_op->flush) {
 		old_cred = ovl_override_creds(file_inode(file)->i_sb);
diff --git a/include/linux/file.h b/include/linux/file.h
index f98de143245a..d85352523368 100644
--- a/include/linux/file.h
+++ b/include/linux/file.h
@@ -44,13 +44,26 @@ static inline void fput_light(struct file *file, int fput_needed)
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
 #define fd_file(f) ((struct file *)((f).word & ~(FDPUT_FPUT|FDPUT_POS_UNLOCK)))
-static inline bool fd_empty(struct fd f)
+static inline long fd_err(struct fderr f)
 {
-	return unlikely(!f.word);
+	return (long)f.word;
 }
 
 #define EMPTY_FD (struct fd){0}
@@ -63,11 +76,25 @@ static inline struct fd CLONED_FD(struct file *f)
 	return (struct fd){(unsigned long)f | FDPUT_FPUT};
 }
 
-static inline void fdput(struct fd fd)
+static inline struct fderr ERR_FDERR(long n)
+{
+	return (struct fderr){(unsigned long)n};
+}
+static inline struct fderr BORROWED_FDERR(struct file *f)
 {
-	if (fd.word & FDPUT_FPUT)
-		fput(fd_file(fd));
+	return (struct fderr){(unsigned long)f};
 }
+static inline struct fderr CLONED_FDERR(struct file *f)
+{
+	if (IS_ERR(f))
+		return BORROWED_FDERR(f);
+	return (struct fderr){(unsigned long)f | FDPUT_FPUT};
+}
+
+#define fdput(f)	(void) (_Generic((f), \
+				struct fderr: IS_ERR_VALUE((f).word),	\
+				struct fd: true) && \
+			    ((f).word & FDPUT_FPUT) && (fput(fd_file(f)),0))
 
 extern struct file *fget(unsigned int fd);
 extern struct file *fget_raw(unsigned int fd);
-- 
2.39.5


