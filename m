Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F90739F541
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jun 2021 13:39:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231768AbhFHLld (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Jun 2021 07:41:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232137AbhFHLlc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Jun 2021 07:41:32 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07ABBC061574;
        Tue,  8 Jun 2021 04:39:40 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lqa4q-005ptB-8e; Tue, 08 Jun 2021 11:39:24 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] switch file_open_root() to struct path
Date:   Tue,  8 Jun 2021 11:39:21 +0000
Message-Id: <20210608113924.1391062-1-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <YL9WwAD547fY19EE@zeniv-ca.linux.org.uk>
References: <YL9WwAD547fY19EE@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

... and provide file_open_root_mnt(), using the root of given mount.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 Documentation/filesystems/porting.rst | 9 +++++++++
 arch/um/drivers/mconsole_kern.c       | 2 +-
 fs/coredump.c                         | 4 ++--
 fs/fhandle.c                          | 2 +-
 fs/internal.h                         | 2 +-
 fs/kernel_read_file.c                 | 2 +-
 fs/namei.c                            | 8 +++-----
 fs/open.c                             | 4 ++--
 fs/proc/proc_sysctl.c                 | 2 +-
 include/linux/fs.h                    | 8 +++++++-
 kernel/usermode_driver.c              | 2 +-
 11 files changed, 29 insertions(+), 16 deletions(-)

diff --git a/Documentation/filesystems/porting.rst b/Documentation/filesystems/porting.rst
index 0302035781be..9bb2b35f90bb 100644
--- a/Documentation/filesystems/porting.rst
+++ b/Documentation/filesystems/porting.rst
@@ -890,3 +890,12 @@ been called or returned with non -EIOCBQUEUED code.
 
 mnt_want_write_file() can now only be paired with mnt_drop_write_file(),
 whereas previously it could be paired with mnt_drop_write() as well.
+
+---
+
+**mandatory**
+
+Calling conventions for file_open_root() changed; now it takes struct path *
+instead of passing mount and dentry separately.  For callers that used to
+pass <mnt, mnt->mnt_root> pair (i.e. the root of given mount), a new helper
+is provided - file_open_root_mnt().  In-tree users adjusted.
diff --git a/arch/um/drivers/mconsole_kern.c b/arch/um/drivers/mconsole_kern.c
index 6d00af25ec6b..c42b10024e26 100644
--- a/arch/um/drivers/mconsole_kern.c
+++ b/arch/um/drivers/mconsole_kern.c
@@ -140,7 +140,7 @@ void mconsole_proc(struct mc_request *req)
 		mconsole_reply(req, "Proc not available", 1, 0);
 		goto out;
 	}
-	file = file_open_root(mnt->mnt_root, mnt, ptr, O_RDONLY, 0);
+	file = file_open_root_mnt(mnt, ptr, O_RDONLY, 0);
 	if (IS_ERR(file)) {
 		mconsole_reply(req, "Failed to open file", 1, 0);
 		printk(KERN_ERR "open /proc/%s: %ld\n", ptr, PTR_ERR(file));
diff --git a/fs/coredump.c b/fs/coredump.c
index 1c0fdc1aa70b..087db444b06b 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -755,8 +755,8 @@ void do_coredump(const kernel_siginfo_t *siginfo)
 			task_lock(&init_task);
 			get_fs_root(init_task.fs, &root);
 			task_unlock(&init_task);
-			cprm.file = file_open_root(root.dentry, root.mnt,
-				cn.corename, open_flags, 0600);
+			cprm.file = file_open_root(&root, cn.corename,
+						   open_flags, 0600);
 			path_put(&root);
 		} else {
 			cprm.file = filp_open(cn.corename, open_flags, 0600);
diff --git a/fs/fhandle.c b/fs/fhandle.c
index ec6feeccc276..6630c69c23a2 100644
--- a/fs/fhandle.c
+++ b/fs/fhandle.c
@@ -229,7 +229,7 @@ static long do_handle_open(int mountdirfd, struct file_handle __user *ufh,
 		path_put(&path);
 		return fd;
 	}
-	file = file_open_root(path.dentry, path.mnt, "", open_flag, 0);
+	file = file_open_root(&path, "", open_flag, 0);
 	if (IS_ERR(file)) {
 		put_unused_fd(fd);
 		retval =  PTR_ERR(file);
diff --git a/fs/internal.h b/fs/internal.h
index 6aeae7ef3380..3ce8edbaa3ca 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -129,7 +129,7 @@ struct open_flags {
 };
 extern struct file *do_filp_open(int dfd, struct filename *pathname,
 		const struct open_flags *op);
-extern struct file *do_file_open_root(struct dentry *, struct vfsmount *,
+extern struct file *do_file_open_root(const struct path *,
 		const char *, const struct open_flags *);
 extern struct open_how build_open_how(int flags, umode_t mode);
 extern int build_open_flags(const struct open_how *how, struct open_flags *op);
diff --git a/fs/kernel_read_file.c b/fs/kernel_read_file.c
index 90d255fbdd9b..87aac4c72c37 100644
--- a/fs/kernel_read_file.c
+++ b/fs/kernel_read_file.c
@@ -160,7 +160,7 @@ int kernel_read_file_from_path_initns(const char *path, loff_t offset,
 	get_fs_root(init_task.fs, &root);
 	task_unlock(&init_task);
 
-	file = file_open_root(root.dentry, root.mnt, path, O_RDONLY, 0);
+	file = file_open_root(&root, path, O_RDONLY, 0);
 	path_put(&root);
 	if (IS_ERR(file))
 		return PTR_ERR(file);
diff --git a/fs/namei.c b/fs/namei.c
index 48a2f288e802..4b6cf4974dd7 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3533,7 +3533,7 @@ struct file *do_filp_open(int dfd, struct filename *pathname,
 	return filp;
 }
 
-struct file *do_file_open_root(struct dentry *dentry, struct vfsmount *mnt,
+struct file *do_file_open_root(const struct path *root,
 		const char *name, const struct open_flags *op)
 {
 	struct nameidata nd;
@@ -3541,16 +3541,14 @@ struct file *do_file_open_root(struct dentry *dentry, struct vfsmount *mnt,
 	struct filename *filename;
 	int flags = op->lookup_flags | LOOKUP_ROOT;
 
-	nd.root.mnt = mnt;
-	nd.root.dentry = dentry;
-
-	if (d_is_symlink(dentry) && op->intent & LOOKUP_OPEN)
+	if (d_is_symlink(root->dentry) && op->intent & LOOKUP_OPEN)
 		return ERR_PTR(-ELOOP);
 
 	filename = getname_kernel(name);
 	if (IS_ERR(filename))
 		return ERR_CAST(filename);
 
+	nd.root = *root;
 	set_nameidata(&nd, -1, filename);
 	file = path_openat(&nd, op, flags | LOOKUP_RCU);
 	if (unlikely(file == ERR_PTR(-ECHILD)))
diff --git a/fs/open.c b/fs/open.c
index e53af13b5835..b3c904e82e2a 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -1156,7 +1156,7 @@ struct file *filp_open(const char *filename, int flags, umode_t mode)
 }
 EXPORT_SYMBOL(filp_open);
 
-struct file *file_open_root(struct dentry *dentry, struct vfsmount *mnt,
+struct file *file_open_root(const struct path *root,
 			    const char *filename, int flags, umode_t mode)
 {
 	struct open_flags op;
@@ -1164,7 +1164,7 @@ struct file *file_open_root(struct dentry *dentry, struct vfsmount *mnt,
 	int err = build_open_flags(&how, &op);
 	if (err)
 		return ERR_PTR(err);
-	return do_file_open_root(dentry, mnt, filename, &op);
+	return do_file_open_root(root, filename, &op);
 }
 EXPORT_SYMBOL(file_open_root);
 
diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 984e42f8cb11..6606f21fc195 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -1806,7 +1806,7 @@ static int process_sysctl_arg(char *param, char *val,
 		panic("%s: Failed to allocate path for %s\n", __func__, param);
 	strreplace(path, '.', '/');
 
-	file = file_open_root((*proc_mnt)->mnt_root, *proc_mnt, path, O_WRONLY, 0);
+	file = file_open_root_mnt(*proc_mnt, path, O_WRONLY, 0);
 	if (IS_ERR(file)) {
 		err = PTR_ERR(file);
 		if (err == -ENOENT)
diff --git a/include/linux/fs.h b/include/linux/fs.h
index ec8f3ddf4a6a..1acea2bb9d60 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2632,8 +2632,14 @@ extern long do_sys_open(int dfd, const char __user *filename, int flags,
 			umode_t mode);
 extern struct file *file_open_name(struct filename *, int, umode_t);
 extern struct file *filp_open(const char *, int, umode_t);
-extern struct file *file_open_root(struct dentry *, struct vfsmount *,
+extern struct file *file_open_root(const struct path *,
 				   const char *, int, umode_t);
+static inline struct file *file_open_root_mnt(struct vfsmount *mnt,
+				   const char *name, int flags, umode_t mode)
+{
+	return file_open_root(&(struct path){.mnt = mnt, .dentry = mnt->mnt_root},
+			      name, flags, mode);
+}
 extern struct file * dentry_open(const struct path *, int, const struct cred *);
 extern struct file * open_with_fake_path(const struct path *, int,
 					 struct inode*, const struct cred *);
diff --git a/kernel/usermode_driver.c b/kernel/usermode_driver.c
index 0b35212ffc3d..78353cb73836 100644
--- a/kernel/usermode_driver.c
+++ b/kernel/usermode_driver.c
@@ -26,7 +26,7 @@ static struct vfsmount *blob_to_mnt(const void *data, size_t len, const char *na
 	if (IS_ERR(mnt))
 		return mnt;
 
-	file = file_open_root(mnt->mnt_root, mnt, name, O_CREAT | O_WRONLY, 0700);
+	file = file_open_root_mnt(mnt, name, O_CREAT | O_WRONLY, 0700);
 	if (IS_ERR(file)) {
 		mntput(mnt);
 		return ERR_CAST(file);
-- 
2.11.0

