Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1E2568B7E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jul 2019 15:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731100AbfGONi5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Jul 2019 09:38:57 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54558 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731093AbfGONi4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Jul 2019 09:38:56 -0400
Received: by mail-wm1-f68.google.com with SMTP id p74so15202555wme.4;
        Mon, 15 Jul 2019 06:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HPhHF/lQPjKGTxk/EZNZdPyMjw4g0YbwWS5emanus/A=;
        b=tJLXH2yG9X1moHptDHwnB9QSP5mk0HVyr+WZUNn/5HKxli+RZD1T5IrlgyAcnQf29p
         w2sEnf6uFNQTKcMKrIlRzK6oCwBJ85hqayhSvcDvuUom74Gt/ODLr5j2b0GJgSUenzxI
         XsMYQO9n3LIsC8zeEXyPdbx30x9m+knvy3IBbMWtUEvJiCauPt/KNL6X/TN7sVvCx7c4
         kWh0kLSqYaTccTS97xQO7m0nVWZsL9wKo65vgKrSF6jjPltiN3FdWmD8mggDhBSBXYOm
         FXTTSTKFjjH7uRJvg44jxBlH6ZnEpZmmbYjAEQYdqBjDzbU3hjDqRLUb1I6+xcFkUSUy
         wUUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HPhHF/lQPjKGTxk/EZNZdPyMjw4g0YbwWS5emanus/A=;
        b=ddGLtUurBhh+rJgwoxWOIR7UYKlnxWQwt6mMx/aBW6hbE1BlvR5+BLRpThacdOlJz9
         EOqOtxc3oXJzK0Pit77bkqcjUeBmGjC347rr5myWEo3rawbIgaHyWsr3Li7ZOy3yKVxP
         wWVz/ka3LqP44Y+/cyWq6w0Yi4skIQq15W60TBTQAKVWLC2vD87KSe2k7NVY2EGTDJOq
         yiKVJIpJCqMKWaGPU8eED9KzIrv2LqZMmfwadem+nLBg1nxvA4QCqotuNBGdX4ptTCKe
         DoVN9tpA39xN9C8mrgskIbc4wHbCyQT9S2zz5yweUFsep/q3+RY6FtqVjrjH4QmjMTMA
         jwFA==
X-Gm-Message-State: APjAAAX7Mko4uHlRy9/+7Eac3LLlMOt9HEtGn5n4BFFClGWTle6uOJ5l
        PeQyXi94Tfum+K2zWUXqANQ=
X-Google-Smtp-Source: APXvYqwXHLWdx9MWf7q0ATx0HotmzO/7IH+isvTRp7E8JrfmNk4abvrN1rpFVn2dYDFtqGqbSFi+bg==
X-Received: by 2002:a1c:b706:: with SMTP id h6mr24122884wmf.119.1563197932896;
        Mon, 15 Jul 2019 06:38:52 -0700 (PDT)
Received: from amir-ThinkPad-T480.ctera.local (bzq-166-168-31-246.red.bezeqint.net. [31.168.166.246])
        by smtp.gmail.com with ESMTPSA id s15sm4058250wrw.21.2019.07.15.06.38.51
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 15 Jul 2019 06:38:52 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Vivek Goyal <vgoyal@redhat.com>, linux-fsdevel@vger.kernel.org,
        linux-unionfs@vger.kernel.org
Subject: [PATCH 3/4] ovl: add pre/post access hooks to underlying layers
Date:   Mon, 15 Jul 2019 16:38:38 +0300
Message-Id: <20190715133839.9878-4-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190715133839.9878-1-amir73il@gmail.com>
References: <20190715133839.9878-1-amir73il@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

write access to underlying layers is surrounded with ovl_want_write()/
ovl_drop_write() pair and error may be returned when write access
is denied.

read/lookup access to underlying layers is also surrounded with
ovl_override_creds()/revert_creds(), but access cannot be denied.

Change all call sites to use ovl_override_creds()/ovl_revert_creds()
pair and allow error to be returned when access to underlying layers
is denied.

This is a prep patch for adding SHUTDOWN ioctl support.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/overlayfs/copy_up.c   | 10 +++--
 fs/overlayfs/dir.c       | 26 +++++++----
 fs/overlayfs/file.c      | 94 +++++++++++++++++++++++++++-------------
 fs/overlayfs/inode.c     | 64 +++++++++++++++++++--------
 fs/overlayfs/namei.c     | 15 ++++---
 fs/overlayfs/overlayfs.h |  3 +-
 fs/overlayfs/readdir.c   | 13 ++++--
 fs/overlayfs/util.c      | 26 ++++++++---
 8 files changed, 174 insertions(+), 77 deletions(-)

diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index b801c6353100..47a924973b32 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -850,10 +850,14 @@ static int ovl_copy_up_one(struct dentry *parent, struct dentry *dentry,
 
 int ovl_copy_up_flags(struct dentry *dentry, int flags)
 {
-	int err = 0;
-	const struct cred *old_cred = ovl_override_creds(dentry->d_sb);
+	int err;
+	const struct cred *old_cred;
 	bool disconnected = (dentry->d_flags & DCACHE_DISCONNECTED);
 
+	err = ovl_override_creds(dentry->d_sb, &old_cred);
+	if (err)
+		return err;
+
 	/*
 	 * With NFS export, copy up can get called for a disconnected non-dir.
 	 * In this case, we will copy up lower inode to index dir without
@@ -886,7 +890,7 @@ int ovl_copy_up_flags(struct dentry *dentry, int flags)
 		dput(parent);
 		dput(next);
 	}
-	revert_creds(old_cred);
+	ovl_revert_creds(dentry->d_sb, old_cred);
 
 	return err;
 }
diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index 702aa63f6774..cb43064a6b4e 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -544,7 +544,9 @@ static int ovl_create_or_link(struct dentry *dentry, struct inode *inode,
 	if (err)
 		return err;
 
-	old_cred = ovl_override_creds(dentry->d_sb);
+	err = ovl_override_creds(dentry->d_sb, &old_cred);
+	if (err)
+		return err;
 
 	/*
 	 * When linking a file with copy up origin into a new parent, mark the
@@ -579,7 +581,7 @@ static int ovl_create_or_link(struct dentry *dentry, struct inode *inode,
 			err = ovl_create_over_whiteout(dentry, inode, attr);
 	}
 out_revert_creds:
-	revert_creds(old_cred);
+	ovl_revert_creds(dentry->d_sb, old_cred);
 	return err;
 }
 
@@ -653,9 +655,12 @@ static int ovl_set_link_redirect(struct dentry *dentry)
 	const struct cred *old_cred;
 	int err;
 
-	old_cred = ovl_override_creds(dentry->d_sb);
+	err = ovl_override_creds(dentry->d_sb, &old_cred);
+	if (err)
+		return err;
+
 	err = ovl_set_redirect(dentry, false);
-	revert_creds(old_cred);
+	ovl_revert_creds(dentry->d_sb, old_cred);
 
 	return err;
 }
@@ -846,12 +851,15 @@ static int ovl_do_remove(struct dentry *dentry, bool is_dir)
 	if (err)
 		goto out_drop_write;
 
-	old_cred = ovl_override_creds(dentry->d_sb);
+	err = ovl_override_creds(dentry->d_sb, &old_cred);
+	if (err)
+		goto out_drop_write;
+
 	if (!lower_positive)
 		err = ovl_remove_upper(dentry, is_dir, &list);
 	else
 		err = ovl_remove_and_whiteout(dentry, &list);
-	revert_creds(old_cred);
+	ovl_revert_creds(dentry->d_sb, old_cred);
 	if (!err) {
 		if (is_dir)
 			clear_nlink(dentry->d_inode);
@@ -1096,7 +1104,9 @@ static int ovl_rename(struct inode *olddir, struct dentry *old,
 		update_nlink = true;
 	}
 
-	old_cred = ovl_override_creds(old->d_sb);
+	err = ovl_override_creds(old->d_sb, &old_cred);
+	if (err)
+		goto out_drop_write;
 
 	if (!list_empty(&list)) {
 		opaquedir = ovl_clear_empty(new, &list);
@@ -1221,7 +1231,7 @@ static int ovl_rename(struct inode *olddir, struct dentry *old,
 out_unlock:
 	unlock_rename(new_upperdir, old_upperdir);
 out_revert_creds:
-	revert_creds(old_cred);
+	ovl_revert_creds(old->d_sb, old_cred);
 	if (update_nlink)
 		ovl_nlink_end(new);
 out_drop_write:
diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index 1ba40845fba0..dbcf7549068d 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -28,11 +28,15 @@ static struct file *ovl_open_realfile(const struct file *file,
 	struct file *realfile;
 	const struct cred *old_cred;
 	int flags = file->f_flags | O_NOATIME | FMODE_NONOTIFY;
+	int err;
+
+	err = ovl_override_creds(inode->i_sb, &old_cred);
+	if (err)
+		return ERR_PTR(err);
 
-	old_cred = ovl_override_creds(inode->i_sb);
 	realfile = open_with_fake_path(&file->f_path, flags, realinode,
 				       current_cred());
-	revert_creds(old_cred);
+	ovl_revert_creds(inode->i_sb, old_cred);
 
 	pr_debug("open(%p[%pD2/%c], 0%o) -> (%p, 0%o)\n",
 		 file, file, ovl_whatisit(inode, realinode), file->f_flags,
@@ -174,9 +178,11 @@ static loff_t ovl_llseek(struct file *file, loff_t offset, int whence)
 	inode_lock(inode);
 	real.file->f_pos = file->f_pos;
 
-	old_cred = ovl_override_creds(inode->i_sb);
-	ret = vfs_llseek(real.file, offset, whence);
-	revert_creds(old_cred);
+	ret = ovl_override_creds(inode->i_sb, &old_cred);
+	if (!ret) {
+		ret = vfs_llseek(real.file, offset, whence);
+		ovl_revert_creds(inode->i_sb, old_cred);
+	}
 
 	file->f_pos = real.file->f_pos;
 	inode_unlock(inode);
@@ -228,6 +234,7 @@ static rwf_t ovl_iocb_to_rwf(struct kiocb *iocb)
 static ssize_t ovl_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 {
 	struct file *file = iocb->ki_filp;
+	struct inode *inode = file_inode(file);
 	struct fd real;
 	const struct cred *old_cred;
 	ssize_t ret;
@@ -239,13 +246,17 @@ static ssize_t ovl_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 	if (ret)
 		return ret;
 
-	old_cred = ovl_override_creds(file_inode(file)->i_sb);
+	ret = ovl_override_creds(inode->i_sb, &old_cred);
+	if (ret)
+		goto out_fdput;
+
 	ret = vfs_iter_read(real.file, iter, &iocb->ki_pos,
 			    ovl_iocb_to_rwf(iocb));
-	revert_creds(old_cred);
+	ovl_revert_creds(inode->i_sb, old_cred);
 
 	ovl_file_accessed(file);
 
+out_fdput:
 	fdput(real);
 
 	return ret;
@@ -273,16 +284,20 @@ static ssize_t ovl_write_iter(struct kiocb *iocb, struct iov_iter *iter)
 	if (ret)
 		goto out_unlock;
 
-	old_cred = ovl_override_creds(file_inode(file)->i_sb);
+	ret = ovl_override_creds(inode->i_sb, &old_cred);
+	if (ret)
+		goto out_fdput;
+
 	file_start_write(real.file);
 	ret = vfs_iter_write(real.file, iter, &iocb->ki_pos,
 			     ovl_iocb_to_rwf(iocb));
 	file_end_write(real.file);
-	revert_creds(old_cred);
+	ovl_revert_creds(inode->i_sb, old_cred);
 
 	/* Update size */
 	ovl_copyattr(ovl_inode_real(inode), inode);
 
+out_fdput:
 	fdput(real);
 
 out_unlock:
@@ -293,6 +308,7 @@ static ssize_t ovl_write_iter(struct kiocb *iocb, struct iov_iter *iter)
 
 static int ovl_fsync(struct file *file, loff_t start, loff_t end, int datasync)
 {
+	struct inode *inode = file_inode(file);
 	struct fd real;
 	const struct cred *old_cred;
 	int ret;
@@ -302,10 +318,12 @@ static int ovl_fsync(struct file *file, loff_t start, loff_t end, int datasync)
 		return ret;
 
 	/* Don't sync lower file for fear of receiving EROFS error */
-	if (file_inode(real.file) == ovl_inode_upper(file_inode(file))) {
-		old_cred = ovl_override_creds(file_inode(file)->i_sb);
-		ret = vfs_fsync_range(real.file, start, end, datasync);
-		revert_creds(old_cred);
+	if (file_inode(real.file) == ovl_inode_upper(inode)) {
+		ret = ovl_override_creds(inode->i_sb, &old_cred);
+		if (!ret) {
+			ret = vfs_fsync_range(real.file, start, end, datasync);
+			ovl_revert_creds(inode->i_sb, old_cred);
+		}
 	}
 
 	fdput(real);
@@ -316,6 +334,7 @@ static int ovl_fsync(struct file *file, loff_t start, loff_t end, int datasync)
 static int ovl_mmap(struct file *file, struct vm_area_struct *vma)
 {
 	struct file *realfile = file->private_data;
+	struct inode *inode = file_inode(file);
 	const struct cred *old_cred;
 	int ret;
 
@@ -327,24 +346,25 @@ static int ovl_mmap(struct file *file, struct vm_area_struct *vma)
 
 	vma->vm_file = get_file(realfile);
 
-	old_cred = ovl_override_creds(file_inode(file)->i_sb);
-	ret = call_mmap(vma->vm_file, vma);
-	revert_creds(old_cred);
-
+	ret = ovl_override_creds(inode->i_sb, &old_cred);
+	if (!ret) {
+		ret = call_mmap(vma->vm_file, vma);
+		ovl_revert_creds(inode->i_sb, old_cred);
+	}
 	if (ret) {
 		/* Drop reference count from new vm_file value */
 		fput(realfile);
 	} else {
 		/* Drop reference count from previous vm_file value */
 		fput(file);
+		ovl_file_accessed(file);
 	}
 
-	ovl_file_accessed(file);
-
 	return ret;
 }
 
-static long ovl_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
+static long ovl_fallocate(struct file *file, int mode, loff_t offset,
+			  loff_t len)
 {
 	struct inode *inode = file_inode(file);
 	struct fd real;
@@ -355,13 +375,17 @@ static long ovl_fallocate(struct file *file, int mode, loff_t offset, loff_t len
 	if (ret)
 		return ret;
 
-	old_cred = ovl_override_creds(file_inode(file)->i_sb);
+	ret = ovl_override_creds(inode->i_sb, &old_cred);
+	if (ret)
+		goto out_fdput;
+
 	ret = vfs_fallocate(real.file, mode, offset, len);
-	revert_creds(old_cred);
+	ovl_revert_creds(inode->i_sb, old_cred);
 
 	/* Update size */
 	ovl_copyattr(ovl_inode_real(inode), inode);
 
+out_fdput:
 	fdput(real);
 
 	return ret;
@@ -369,6 +393,7 @@ static long ovl_fallocate(struct file *file, int mode, loff_t offset, loff_t len
 
 static int ovl_fadvise(struct file *file, loff_t offset, loff_t len, int advice)
 {
+	struct inode *inode = file_inode(file);
 	struct fd real;
 	const struct cred *old_cred;
 	int ret;
@@ -377,9 +402,11 @@ static int ovl_fadvise(struct file *file, loff_t offset, loff_t len, int advice)
 	if (ret)
 		return ret;
 
-	old_cred = ovl_override_creds(file_inode(file)->i_sb);
-	ret = vfs_fadvise(real.file, offset, len, advice);
-	revert_creds(old_cred);
+	ret = ovl_override_creds(inode->i_sb, &old_cred);
+	if (!ret) {
+		ret = vfs_fadvise(real.file, offset, len, advice);
+		ovl_revert_creds(inode->i_sb, old_cred);
+	}
 
 	fdput(real);
 
@@ -389,6 +416,7 @@ static int ovl_fadvise(struct file *file, loff_t offset, loff_t len, int advice)
 static long ovl_real_ioctl(struct file *file, unsigned int cmd,
 			   unsigned long arg)
 {
+	struct inode *inode = file_inode(file);
 	struct fd real;
 	const struct cred *old_cred;
 	long ret;
@@ -397,9 +425,11 @@ static long ovl_real_ioctl(struct file *file, unsigned int cmd,
 	if (ret)
 		return ret;
 
-	old_cred = ovl_override_creds(file_inode(file)->i_sb);
-	ret = vfs_ioctl(real.file, cmd, arg);
-	revert_creds(old_cred);
+	ret = ovl_override_creds(inode->i_sb, &old_cred);
+	if (!ret) {
+		ret = vfs_ioctl(real.file, cmd, arg);
+		ovl_revert_creds(inode->i_sb, old_cred);
+	}
 
 	fdput(real);
 
@@ -570,7 +600,10 @@ static loff_t ovl_copyfile(struct file *file_in, loff_t pos_in,
 		return ret;
 	}
 
-	old_cred = ovl_override_creds(file_inode(file_out)->i_sb);
+	ret = ovl_override_creds(inode_out->i_sb, &old_cred);
+	if (ret)
+		goto out_fdput;
+
 	switch (op) {
 	case OVL_COPY:
 		ret = vfs_copy_file_range(real_in.file, pos_in,
@@ -588,11 +621,12 @@ static loff_t ovl_copyfile(struct file *file_in, loff_t pos_in,
 						flags);
 		break;
 	}
-	revert_creds(old_cred);
+	ovl_revert_creds(inode_out->i_sb, old_cred);
 
 	/* Update size */
 	ovl_copyattr(ovl_inode_real(inode_out), inode_out);
 
+out_fdput:
 	fdput(real_in);
 	fdput(real_out);
 
diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index 7663aeb85fa3..f99833161e2b 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -59,9 +59,11 @@ int ovl_setattr(struct dentry *dentry, struct iattr *attr)
 			attr->ia_valid &= ~ATTR_MODE;
 
 		inode_lock(upperdentry->d_inode);
-		old_cred = ovl_override_creds(dentry->d_sb);
-		err = notify_change(upperdentry, attr, NULL);
-		revert_creds(old_cred);
+		err = ovl_override_creds(dentry->d_sb, &old_cred);
+		if (!err) {
+			err = notify_change(upperdentry, attr, NULL);
+			ovl_revert_creds(dentry->d_sb, old_cred);
+		}
 		if (!err)
 			ovl_copyattr(upperdentry->d_inode, dentry->d_inode);
 		inode_unlock(upperdentry->d_inode);
@@ -154,7 +156,10 @@ int ovl_getattr(const struct path *path, struct kstat *stat,
 	metacopy_blocks = ovl_is_metacopy_dentry(dentry);
 
 	type = ovl_path_real(dentry, &realpath);
-	old_cred = ovl_override_creds(dentry->d_sb);
+	err = ovl_override_creds(dentry->d_sb, &old_cred);
+	if (err)
+		return err;
+
 	err = vfs_getattr(&realpath, stat, request_mask, flags);
 	if (err)
 		goto out;
@@ -257,7 +262,7 @@ int ovl_getattr(const struct path *path, struct kstat *stat,
 		stat->nlink = dentry->d_inode->i_nlink;
 
 out:
-	revert_creds(old_cred);
+	ovl_revert_creds(dentry->d_sb, old_cred);
 
 	return err;
 }
@@ -283,7 +288,10 @@ int ovl_permission(struct inode *inode, int mask)
 	if (err)
 		return err;
 
-	old_cred = ovl_override_creds(inode->i_sb);
+	err = ovl_override_creds(inode->i_sb, &old_cred);
+	if (err)
+		return err;
+
 	if (!upperinode &&
 	    !special_file(realinode->i_mode) && mask & MAY_WRITE) {
 		mask &= ~(MAY_WRITE | MAY_APPEND);
@@ -291,7 +299,7 @@ int ovl_permission(struct inode *inode, int mask)
 		mask |= MAY_READ;
 	}
 	err = inode_permission(realinode, mask);
-	revert_creds(old_cred);
+	ovl_revert_creds(inode->i_sb, old_cred);
 
 	return err;
 }
@@ -302,13 +310,17 @@ static const char *ovl_get_link(struct dentry *dentry,
 {
 	const struct cred *old_cred;
 	const char *p;
+	int err;
 
 	if (!dentry)
 		return ERR_PTR(-ECHILD);
 
-	old_cred = ovl_override_creds(dentry->d_sb);
+	err = ovl_override_creds(dentry->d_sb, &old_cred);
+	if (err)
+		return ERR_PTR(err);
+
 	p = vfs_get_link(ovl_dentry_real(dentry), done);
-	revert_creds(old_cred);
+	ovl_revert_creds(dentry->d_sb, old_cred);
 	return p;
 }
 
@@ -344,14 +356,17 @@ int ovl_xattr_set(struct dentry *dentry, struct inode *inode, const char *name,
 		realdentry = ovl_dentry_upper(dentry);
 	}
 
-	old_cred = ovl_override_creds(dentry->d_sb);
+	err = ovl_override_creds(dentry->d_sb, &old_cred);
+	if (err)
+		goto out_drop_write;
+
 	if (value)
 		err = vfs_setxattr(realdentry, name, value, size, flags);
 	else {
 		WARN_ON(flags != XATTR_REPLACE);
 		err = vfs_removexattr(realdentry, name);
 	}
-	revert_creds(old_cred);
+	ovl_revert_creds(dentry->d_sb, old_cred);
 
 	/* copy c/mtime */
 	ovl_copyattr(d_inode(realdentry), inode);
@@ -370,9 +385,12 @@ int ovl_xattr_get(struct dentry *dentry, struct inode *inode, const char *name,
 	struct dentry *realdentry =
 		ovl_i_dentry_upper(inode) ?: ovl_dentry_lower(dentry);
 
-	old_cred = ovl_override_creds(dentry->d_sb);
+	res = ovl_override_creds(dentry->d_sb, &old_cred);
+	if (res)
+		return res;
+
 	res = vfs_getxattr(realdentry, name, value, size);
-	revert_creds(old_cred);
+	ovl_revert_creds(dentry->d_sb, old_cred);
 	return res;
 }
 
@@ -394,9 +412,13 @@ ssize_t ovl_listxattr(struct dentry *dentry, char *list, size_t size)
 	char *s;
 	const struct cred *old_cred;
 
-	old_cred = ovl_override_creds(dentry->d_sb);
+	res = ovl_override_creds(dentry->d_sb, &old_cred);
+	if (res)
+		return res;
+
 	res = vfs_listxattr(realdentry, list, size);
-	revert_creds(old_cred);
+	ovl_revert_creds(dentry->d_sb, old_cred);
+
 	if (res <= 0 || size == 0)
 		return res;
 
@@ -429,9 +451,11 @@ struct posix_acl *ovl_get_acl(struct inode *inode, int type)
 	if (!IS_ENABLED(CONFIG_FS_POSIX_ACL) || !IS_POSIXACL(realinode))
 		return NULL;
 
-	old_cred = ovl_override_creds(inode->i_sb);
+	if (ovl_override_creds(inode->i_sb, &old_cred))
+		return NULL;
+
 	acl = get_acl(realinode, type);
-	revert_creds(old_cred);
+	ovl_revert_creds(inode->i_sb, old_cred);
 
 	return acl;
 }
@@ -463,13 +487,15 @@ static int ovl_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 	if (!realinode->i_op->fiemap)
 		return -EOPNOTSUPP;
 
-	old_cred = ovl_override_creds(inode->i_sb);
+	err = ovl_override_creds(inode->i_sb, &old_cred);
+	if (err)
+		return err;
 
 	if (fieinfo->fi_flags & FIEMAP_FLAG_SYNC)
 		filemap_write_and_wait(realinode->i_mapping);
 
 	err = realinode->i_op->fiemap(realinode, fieinfo, start, len);
-	revert_creds(old_cred);
+	ovl_revert_creds(inode->i_sb, old_cred);
 
 	return err;
 }
diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
index e9717c2f7d45..5aa448ca0bb5 100644
--- a/fs/overlayfs/namei.c
+++ b/fs/overlayfs/namei.c
@@ -836,7 +836,10 @@ struct dentry *ovl_lookup(struct inode *dir, struct dentry *dentry,
 	if (dentry->d_name.len > ofs->namelen)
 		return ERR_PTR(-ENAMETOOLONG);
 
-	old_cred = ovl_override_creds(dentry->d_sb);
+	err = ovl_override_creds(dentry->d_sb, &old_cred);
+	if (err)
+		return ERR_PTR(err);
+
 	upperdir = ovl_dentry_upper(dentry->d_parent);
 	if (upperdir) {
 		err = ovl_lookup_layer(upperdir, &d, &upperdentry);
@@ -1074,7 +1077,7 @@ struct dentry *ovl_lookup(struct inode *dir, struct dentry *dentry,
 			goto out_free_oe;
 	}
 
-	revert_creds(old_cred);
+	ovl_revert_creds(dentry->d_sb, old_cred);
 	if (origin_path) {
 		dput(origin_path->dentry);
 		kfree(origin_path);
@@ -1101,7 +1104,7 @@ struct dentry *ovl_lookup(struct inode *dir, struct dentry *dentry,
 	kfree(upperredirect);
 out:
 	kfree(d.redirect);
-	revert_creds(old_cred);
+	ovl_revert_creds(dentry->d_sb, old_cred);
 	return ERR_PTR(err);
 }
 
@@ -1125,7 +1128,9 @@ bool ovl_lower_positive(struct dentry *dentry)
 	if (!ovl_dentry_upper(dentry))
 		return true;
 
-	old_cred = ovl_override_creds(dentry->d_sb);
+	if (ovl_override_creds(dentry->d_sb, &old_cred))
+		return false;
+
 	/* Positive upper -> have to look up lower to see whether it exists */
 	for (i = 0; !done && !positive && i < poe->numlower; i++) {
 		struct dentry *this;
@@ -1155,7 +1160,7 @@ bool ovl_lower_positive(struct dentry *dentry)
 			dput(this);
 		}
 	}
-	revert_creds(old_cred);
+	ovl_revert_creds(dentry->d_sb, old_cred);
 
 	return positive;
 }
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index 7c94cc3521cb..72f0d84d2d4b 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -204,7 +204,8 @@ static inline bool ovl_open_flags_need_copy_up(int flags)
 int ovl_want_write(struct dentry *dentry);
 void ovl_drop_write(struct dentry *dentry);
 struct dentry *ovl_workdir(struct dentry *dentry);
-const struct cred *ovl_override_creds(struct super_block *sb);
+int ovl_override_creds(struct super_block *sb, const struct cred **old_cred);
+void ovl_revert_creds(struct super_block *sb, const struct cred *old_cred);
 struct super_block *ovl_same_sb(struct super_block *sb);
 int ovl_can_decode_fh(struct super_block *sb);
 struct dentry *ovl_indexdir(struct super_block *sb);
diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
index eff8fbfccc7c..b13f4e983784 100644
--- a/fs/overlayfs/readdir.c
+++ b/fs/overlayfs/readdir.c
@@ -271,7 +271,9 @@ static int ovl_check_whiteouts(struct dentry *dir, struct ovl_readdir_data *rdd)
 	struct dentry *dentry;
 	const struct cred *old_cred;
 
-	old_cred = ovl_override_creds(rdd->dentry->d_sb);
+	err = ovl_override_creds(rdd->dentry->d_sb, &old_cred);
+	if (err)
+		return err;
 
 	err = down_write_killable(&dir->d_inode->i_rwsem);
 	if (!err) {
@@ -286,7 +288,7 @@ static int ovl_check_whiteouts(struct dentry *dir, struct ovl_readdir_data *rdd)
 		}
 		inode_unlock(dir->d_inode);
 	}
-	revert_creds(old_cred);
+	ovl_revert_creds(rdd->dentry->d_sb, old_cred);
 
 	return err;
 }
@@ -920,9 +922,12 @@ int ovl_check_empty_dir(struct dentry *dentry, struct list_head *list)
 	struct rb_root root = RB_ROOT;
 	const struct cred *old_cred;
 
-	old_cred = ovl_override_creds(dentry->d_sb);
+	err = ovl_override_creds(dentry->d_sb, &old_cred);
+	if (err)
+		return err;
+
 	err = ovl_dir_read_merged(dentry, list, &root);
-	revert_creds(old_cred);
+	ovl_revert_creds(dentry->d_sb, old_cred);
 	if (err)
 		return err;
 
diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
index f5678a3f8350..146b351a0d84 100644
--- a/fs/overlayfs/util.c
+++ b/fs/overlayfs/util.c
@@ -33,11 +33,17 @@ struct dentry *ovl_workdir(struct dentry *dentry)
 	return ofs->workdir;
 }
 
-const struct cred *ovl_override_creds(struct super_block *sb)
+int ovl_override_creds(struct super_block *sb, const struct cred **old_cred)
 {
 	struct ovl_fs *ofs = sb->s_fs_info;
 
-	return override_creds(ofs->creator_cred);
+	*old_cred = override_creds(ofs->creator_cred);
+	return 0;
+}
+
+void ovl_revert_creds(struct super_block *sb, const struct cred *old_cred)
+{
+	revert_creds(old_cred);
 }
 
 struct super_block *ovl_same_sb(struct super_block *sb)
@@ -783,7 +789,10 @@ int ovl_nlink_start(struct dentry *dentry)
 	if (d_is_dir(dentry) || !ovl_test_flag(OVL_INDEX, inode))
 		goto out;
 
-	old_cred = ovl_override_creds(dentry->d_sb);
+	err = ovl_override_creds(dentry->d_sb, &old_cred);
+	if (err)
+		goto out;
+
 	/*
 	 * The overlay inode nlink should be incremented/decremented IFF the
 	 * upper operation succeeds, along with nlink change of upper inode.
@@ -791,7 +800,7 @@ int ovl_nlink_start(struct dentry *dentry)
 	 * value relative to the upper inode nlink in an upper inode xattr.
 	 */
 	err = ovl_set_nlink_upper(dentry);
-	revert_creds(old_cred);
+	ovl_revert_creds(dentry->d_sb, old_cred);
 
 out:
 	if (err)
@@ -806,10 +815,13 @@ void ovl_nlink_end(struct dentry *dentry)
 
 	if (ovl_test_flag(OVL_INDEX, inode) && inode->i_nlink == 0) {
 		const struct cred *old_cred;
+		int err;
 
-		old_cred = ovl_override_creds(dentry->d_sb);
-		ovl_cleanup_index(dentry);
-		revert_creds(old_cred);
+		err = ovl_override_creds(dentry->d_sb, &old_cred);
+		if (!err) {
+			ovl_cleanup_index(dentry);
+			ovl_revert_creds(dentry->d_sb, old_cred);
+		}
 	}
 
 	ovl_inode_unlock(inode);
-- 
2.17.1

