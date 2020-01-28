Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4887614C37B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2020 00:19:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbgA1XTQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jan 2020 18:19:16 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36059 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726439AbgA1XTQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jan 2020 18:19:16 -0500
Received: by mail-pf1-f196.google.com with SMTP id 185so3669321pfv.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jan 2020 15:19:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QEhUOiucewZ5GQPDg2VC31rwEWJkdyQIK+x5OmF4ABA=;
        b=ChgTa9tMkENLfeWhuFIqVjAhUfsGJclGDAk7SAapPHLudFUWVUxCzibrSRTpDWUNdZ
         4vqEH1q/h8oaJCoiRhHyYGp0cp/ixWChuRukF/hkbp1RMOPnCINbZllNi56S+I+wvW2I
         Of4F5hsmPgg9bRzPN4op/oLDTQHSoV/uMic9DmiBXC/I4PCC/b47eZLPjzbeVtTrhV4A
         2zkjUAYWZEj1tx+ic09K0UKROSeH6xoMEAas52NjFvpb1yc4QrSjp8PV7LbfUgIvOP+G
         2L3MSMX4NLBsau5ecjSVQOfj1M6hpDA9vueom58B4ACRa6jPa3JWNAOMcaFw+NK2FGag
         1HIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QEhUOiucewZ5GQPDg2VC31rwEWJkdyQIK+x5OmF4ABA=;
        b=pYJgmb3IQfPfj4FdULd+VD6OsD54e/rw7Fx2hr1oq8CZErI7O+kFPFc+MDA1ByS9av
         1sx1dQ4myy+4j4wMEt6NN6kzQV6lr0G/z+1HhyGeU8cfpGKpe2qhyV2e7sCvzKbGR4Cy
         WM68JJoWmi7E2/fQ7qDAODgP+fcJoh5LouyxX5Dt6gTUGlqjugWjgen9igEFBMBbgdFg
         C7VBJNoR4soGQn4pZdhGM3xWbkHypv52jJ+FjcvCU9loElbYi5cqYrJIb9fHS6hhveCn
         olxfa6I50cWEvErx+8ZCATr0RWOURAqK+IC5tQxd0Fu5lxKMG8pihvrAASxz30mrRMDM
         rxGw==
X-Gm-Message-State: APjAAAWiaYPC7MhDkE9K981Yi/5LuBzZMA0XtScKgcgTlSGn7tFEkWdE
        kfl2G3XkpvUcpoScgGajzP7m0jewD7M=
X-Google-Smtp-Source: APXvYqzqJT68xGiYk8v5m9JQoqlkAJSWQxbXsj2R4LmuG5RKBrT5T6muPzUw4Zy/0ujSPYTWhY/Wig==
X-Received: by 2002:a63:5ce:: with SMTP id 197mr27406985pgf.114.1580253555343;
        Tue, 28 Jan 2020 15:19:15 -0800 (PST)
Received: from vader.thefacebook.com ([2620:10d:c090:200::43a7])
        by smtp.gmail.com with ESMTPSA id p24sm156353pgk.19.2020.01.28.15.19.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2020 15:19:14 -0800 (PST)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>
Cc:     kernel-team@fb.com, Xi Wang <xi@cs.washington.edu>
Subject: [RFC PATCH v4 2/4] fs: add AT_LINK_REPLACE flag for linkat() which replaces the target
Date:   Tue, 28 Jan 2020 15:19:01 -0800
Message-Id: <1f5a197a2fdb0668f6dce8b9a4403481bc957a7c.1580251857.git.osandov@fb.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <cover.1580251857.git.osandov@fb.com>
References: <cover.1580251857.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

One of the most common uses of temporary files is the classic atomic
replacement pattern, i.e.,

- write temporary file
- fsync temporary file
- rename temporary file over real file
- fsync parent directory

Now, we have O_TMPFILE, which gives us a much better way to create
temporary files, but it's not possible to use it for this pattern.

This patch introduces an AT_LINK_REPLACE flag which allows linkat() to
replace the target file. Now, the temporary file in the pattern above
can be a proper O_TMPFILE. Even without O_TMPFILE, this is a new
primitive which might be useful in other contexts.

The implementation on the VFS side mimics sys_renameat2().

Cc: Xi Wang <xi@cs.washington.edu>
Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/ecryptfs/inode.c        |   2 +-
 fs/namei.c                 | 166 +++++++++++++++++++++++++++++--------
 fs/nfsd/vfs.c              |   2 +-
 fs/overlayfs/overlayfs.h   |   2 +-
 include/linux/fs.h         |   2 +-
 include/uapi/linux/fcntl.h |   1 +
 6 files changed, 135 insertions(+), 40 deletions(-)

diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index eeb351b220b2..2f36b7a61a2f 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -440,7 +440,7 @@ static int ecryptfs_link(struct dentry *old_dentry, struct inode *dir,
 	dget(lower_new_dentry);
 	lower_dir_dentry = lock_parent(lower_new_dentry);
 	rc = vfs_link(lower_old_dentry, d_inode(lower_dir_dentry),
-		      lower_new_dentry, NULL);
+		      lower_new_dentry, NULL, 0);
 	if (rc || d_really_is_negative(lower_new_dentry))
 		goto out_lock;
 	rc = ecryptfs_interpose(lower_new_dentry, new_dentry, dir->i_sb);
diff --git a/fs/namei.c b/fs/namei.c
index 9d690df17aed..78d364e99dca 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4122,6 +4122,7 @@ SYSCALL_DEFINE2(symlink, const char __user *, oldname, const char __user *, newn
  * @dir:	new parent
  * @new_dentry:	where to create the new link
  * @delegated_inode: returns inode needing a delegation break
+ * @flags:      link flags
  *
  * The caller must hold dir->i_mutex
  *
@@ -4135,16 +4136,25 @@ SYSCALL_DEFINE2(symlink, const char __user *, oldname, const char __user *, newn
  * be appropriate for callers that expect the underlying filesystem not
  * to be NFS exported.
  */
-int vfs_link(struct dentry *old_dentry, struct inode *dir, struct dentry *new_dentry, struct inode **delegated_inode)
+int vfs_link(struct dentry *old_dentry, struct inode *dir,
+	     struct dentry *new_dentry, struct inode **delegated_inode,
+	     int flags)
 {
 	struct inode *inode = old_dentry->d_inode;
+	struct inode *target = new_dentry->d_inode;
 	unsigned max_links = dir->i_sb->s_max_links;
 	int error;
 
 	if (!inode)
 		return -ENOENT;
 
-	error = may_create(dir, new_dentry);
+	if (target) {
+		if (inode == target)
+			return 0;
+		error = may_delete(dir, new_dentry, false);
+	} else {
+		error = may_create(dir, new_dentry);
+	}
 	if (error)
 		return error;
 
@@ -4172,26 +4182,55 @@ int vfs_link(struct dentry *old_dentry, struct inode *dir, struct dentry *new_de
 	if (error)
 		return error;
 
-	inode_lock(inode);
+	dget(new_dentry);
+	lock_two_nondirectories(inode, target);
+
+	if (is_local_mountpoint(new_dentry)) {
+		error = -EBUSY;
+		goto out;
+	}
+
 	/* Make sure we don't allow creating hardlink to an unlinked file */
-	if (inode->i_nlink == 0 && !(inode->i_state & I_LINKABLE))
+	if (inode->i_nlink == 0 && !(inode->i_state & I_LINKABLE)) {
 		error =  -ENOENT;
-	else if (max_links && inode->i_nlink >= max_links)
+		goto out;
+	}
+	if (max_links && inode->i_nlink >= max_links) {
 		error = -EMLINK;
-	else {
-		error = try_break_deleg(inode, delegated_inode);
-		if (!error)
-			error = dir->i_op->link(old_dentry, dir, new_dentry, 0);
+		goto out;
+	}
+
+	error = try_break_deleg(inode, delegated_inode);
+	if (error)
+		goto out;
+	if (target) {
+		error = try_break_deleg(target, delegated_inode);
+		if (error)
+			goto out;
+	}
+
+	error = dir->i_op->link(old_dentry, dir, new_dentry, flags);
+	if (error)
+		goto out;
+
+	if (target) {
+		dont_mount(new_dentry);
+		detach_mounts(new_dentry);
 	}
 
-	if (!error && (inode->i_state & I_LINKABLE)) {
+	if (inode->i_state & I_LINKABLE) {
 		spin_lock(&inode->i_lock);
 		inode->i_state &= ~I_LINKABLE;
 		spin_unlock(&inode->i_lock);
 	}
-	inode_unlock(inode);
-	if (!error)
+out:
+	unlock_two_nondirectories(inode, target);
+	dput(new_dentry);
+	if (!error) {
+		if (target)
+			fsnotify_link_count(target);
 		fsnotify_link(dir, inode, new_dentry);
+	}
 	return error;
 }
 EXPORT_SYMBOL(vfs_link);
@@ -4210,11 +4249,16 @@ int do_linkat(int olddfd, const char __user *oldname, int newdfd,
 {
 	struct dentry *new_dentry;
 	struct path old_path, new_path;
+	struct qstr new_last;
+	int new_type;
 	struct inode *delegated_inode = NULL;
-	int how = 0;
+	struct filename *to;
+	unsigned int how = 0, target_flags;
+	bool should_retry = false;
 	int error;
 
-	if ((flags & ~(AT_SYMLINK_FOLLOW | AT_EMPTY_PATH)) != 0)
+	if ((flags & ~(AT_SYMLINK_FOLLOW | AT_EMPTY_PATH |
+		       AT_LINK_REPLACE)) != 0)
 		return -EINVAL;
 	/*
 	 * To use null names we require CAP_DAC_READ_SEARCH
@@ -4229,44 +4273,94 @@ int do_linkat(int olddfd, const char __user *oldname, int newdfd,
 
 	if (flags & AT_SYMLINK_FOLLOW)
 		how |= LOOKUP_FOLLOW;
+
+	if (flags & AT_LINK_REPLACE)
+		target_flags = LOOKUP_RENAME_TARGET;
+	else
+		target_flags = LOOKUP_CREATE | LOOKUP_EXCL;
 retry:
 	error = user_path_at(olddfd, oldname, how, &old_path);
 	if (error)
 		return error;
 
-	new_dentry = user_path_create(newdfd, newname, &new_path,
-					(how & LOOKUP_REVAL));
-	error = PTR_ERR(new_dentry);
-	if (IS_ERR(new_dentry))
-		goto out;
+	to = filename_parentat(newdfd, getname(newname), how & LOOKUP_REVAL,
+			       &new_path, &new_last, &new_type);
+	if (IS_ERR(to)) {
+		error = PTR_ERR(to);
+		goto exit1;
+	}
+
+	if (old_path.mnt != new_path.mnt) {
+		error = -EXDEV;
+		goto exit2;
+	}
+
+	if (new_type != LAST_NORM) {
+		if (flags & AT_LINK_REPLACE)
+			error = -EISDIR;
+		else
+			error = -EEXIST;
+		goto exit2;
+	}
+
+	error = mnt_want_write(old_path.mnt);
+	if (error)
+		goto exit2;
+
+retry_deleg:
+	inode_lock_nested(new_path.dentry->d_inode, I_MUTEX_PARENT);
+
+	new_dentry = __lookup_hash(&new_last, new_path.dentry,
+				   (how & LOOKUP_REVAL) | target_flags);
+	if (IS_ERR(new_dentry)) {
+		error = PTR_ERR(new_dentry);
+		goto exit3;
+	}
+	if (!(flags & AT_LINK_REPLACE) && d_is_positive(new_dentry)) {
+		error = -EEXIST;
+		goto exit4;
+	}
+	if (new_last.name[new_last.len]) {
+		if (d_is_negative(new_dentry)) {
+			error = -ENOENT;
+			goto exit4;
+		}
+		if (!d_is_dir(old_path.dentry)) {
+			error = -ENOTDIR;
+			goto exit4;
+		}
+	}
 
-	error = -EXDEV;
-	if (old_path.mnt != new_path.mnt)
-		goto out_dput;
 	error = may_linkat(&old_path);
 	if (unlikely(error))
-		goto out_dput;
+		goto exit4;
 	error = security_path_link(old_path.dentry, &new_path, new_dentry);
 	if (error)
-		goto out_dput;
-	error = vfs_link(old_path.dentry, new_path.dentry->d_inode, new_dentry, &delegated_inode);
-out_dput:
-	done_path_create(&new_path, new_dentry);
+		goto exit4;
+	error = vfs_link(old_path.dentry, new_path.dentry->d_inode, new_dentry,
+			 &delegated_inode, flags & AT_LINK_REPLACE);
+exit4:
+	dput(new_dentry);
+exit3:
+	inode_unlock(new_path.dentry->d_inode);
 	if (delegated_inode) {
 		error = break_deleg_wait(&delegated_inode);
-		if (!error) {
-			path_put(&old_path);
-			goto retry;
-		}
+		if (!error)
+			goto retry_deleg;
 	}
-	if (retry_estale(error, how)) {
-		path_put(&old_path);
+	mnt_drop_write(old_path.mnt);
+exit2:
+	if (retry_estale(error, how))
+		should_retry = true;
+	path_put(&new_path);
+	putname(to);
+exit1:
+	path_put(&old_path);
+	if (should_retry) {
+		should_retry = false;
 		how |= LOOKUP_REVAL;
 		goto retry;
 	}
-out:
-	path_put(&old_path);
-
 	return error;
 }
 
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index c0dc491537a6..3f9291e76b99 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1598,7 +1598,7 @@ nfsd_link(struct svc_rqst *rqstp, struct svc_fh *ffhp,
 	err = nfserr_noent;
 	if (d_really_is_negative(dold))
 		goto out_dput;
-	host_err = vfs_link(dold, dirp, dnew, NULL);
+	host_err = vfs_link(dold, dirp, dnew, NULL, 0);
 	if (!host_err) {
 		err = nfserrno(commit_metadata(ffhp));
 		if (!err)
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index f283b1d69a9e..b199fc03c891 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -120,7 +120,7 @@ static inline int ovl_do_unlink(struct inode *dir, struct dentry *dentry)
 static inline int ovl_do_link(struct dentry *old_dentry, struct inode *dir,
 			      struct dentry *new_dentry)
 {
-	int err = vfs_link(old_dentry, dir, new_dentry, NULL);
+	int err = vfs_link(old_dentry, dir, new_dentry, NULL, 0);
 
 	pr_debug("link(%pd2, %pd2) = %i\n", old_dentry, new_dentry, err);
 	return err;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 3bdb71c97e8f..93eb90eb1fdb 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1712,7 +1712,7 @@ extern int vfs_create(struct inode *, struct dentry *, umode_t, bool);
 extern int vfs_mkdir(struct inode *, struct dentry *, umode_t);
 extern int vfs_mknod(struct inode *, struct dentry *, umode_t, dev_t);
 extern int vfs_symlink(struct inode *, struct dentry *, const char *);
-extern int vfs_link(struct dentry *, struct inode *, struct dentry *, struct inode **);
+extern int vfs_link(struct dentry *, struct inode *, struct dentry *, struct inode **, int);
 extern int vfs_rmdir(struct inode *, struct dentry *);
 extern int vfs_unlink(struct inode *, struct dentry *, struct inode **);
 extern int vfs_rename(struct inode *, struct dentry *, struct inode *, struct dentry *, struct inode **, unsigned int);
diff --git a/include/uapi/linux/fcntl.h b/include/uapi/linux/fcntl.h
index 1f97b33c840e..3704793cd5ab 100644
--- a/include/uapi/linux/fcntl.h
+++ b/include/uapi/linux/fcntl.h
@@ -99,6 +99,7 @@
 #define AT_STATX_DONT_SYNC	0x4000	/* - Don't sync attributes with the server */
 
 #define AT_RECURSIVE		0x8000	/* Apply to the entire subtree */
+#define AT_LINK_REPLACE		0x10000	/* Replace link() target */
 
 
 #endif /* _UAPI_LINUX_FCNTL_H */
-- 
2.25.0

