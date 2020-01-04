Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD37F130456
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Jan 2020 21:16:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbgADUQM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 4 Jan 2020 15:16:12 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:47738 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726118AbgADUQM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 4 Jan 2020 15:16:12 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id CAE2B8EE0CE;
        Sat,  4 Jan 2020 12:16:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1578168971;
        bh=5ilZ0u8D6hVsRE/M9ryLKPcDIwg5lv8XG1SIpD1mig4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=w42p7V64cTKNjlCG5wRdSLPPL3HxYFuL1zAQKw5Evr6KkKFA8alRx5Dm95j2d0x7l
         0LzhqJKCKz3qBg+1YqEhis+9MoLjZrLCB+O62eeG/yyNxEmvGDWGOevJzOp+n494iD
         rbztT9ZmXPrxRpW7tX3jWShMbzgG8H+EDKoxQ800=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id CbIV0zGKjwvw; Sat,  4 Jan 2020 12:16:11 -0800 (PST)
Received: from jarvis.int.hansenpartnership.com (jarvis.ext.hansenpartnership.com [153.66.160.226])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 532B98EE079;
        Sat,  4 Jan 2020 12:16:11 -0800 (PST)
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     David Howells <dhowells@redhat.com>,
        Christian Brauner <christian@brauner.io>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>
Subject: [PATCH v2 4/6] fs: implement fsconfig via configfd
Date:   Sat,  4 Jan 2020 12:14:30 -0800
Message-Id: <20200104201432.27320-5-James.Bottomley@HansenPartnership.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200104201432.27320-1-James.Bottomley@HansenPartnership.com>
References: <20200104201432.27320-1-James.Bottomley@HansenPartnership.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This changes the internal implementation of fsconfig, while keeping
all the external system calls.  However, it now becomes possible to
all the same operations via configfd instead of fsconfig.

For example a filesystem remount read-only can be done:

fd = configfd_open("mount", O_CLOEXEC, CONFIGFD_CMD_RECONFIGURE);
mntpnt = open("/path/to/mount", O_PATH);
configfd_action(fd, CONFIGFD_SET_FD, "pathfd", NULL, mntpnt);
configfd_action(fd, CONFIGFD_SET_FLAG, "ro", NULL, 0);
configfd_action(fd, CONFIGFD_CMD_RECONFIGURE, NULL, NULL, 0);

And mounting a tmpfs filesystem nodev,noexec:

fd = configfd_open("tmpfs", O_CLOEXEC, CONFIGFD_CMD_CREATE);
configfd_action(fd, CONFIGFD_SET_INT, "mount_attrs", NULL,
		MOUNT_ATTR_NODEV|MOUNT_ATTR_NOEXEC);
configfd_action(fd, CONFIGFD_CMD_CREATE, NULL, NULL, 0);
configfd_action(fd, CONFIGFD_GET_FD, "mountfd", &mfd, O_CLOEXEC);
mount_move("", mfd, AT_FDCWD, "/mountpoint", MOVE_MOUNT_F_EMPTY_PATH);

---
v2: fix a log oops

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
---
 fs/filesystems.c           |   8 +-
 fs/fs_context.c            | 124 ++---------
 fs/fsopen.c                | 535 ++++++++++++++++++++++-----------------------
 fs/internal.h              |   4 +
 fs/namespace.c             | 111 ++++------
 include/linux/fs.h         |   2 +
 include/linux/fs_context.h |  29 +--
 include/linux/fs_parser.h  |   2 +
 8 files changed, 348 insertions(+), 467 deletions(-)

diff --git a/fs/filesystems.c b/fs/filesystems.c
index 9135646e41ac..ceb6532754c1 100644
--- a/fs/filesystems.c
+++ b/fs/filesystems.c
@@ -7,6 +7,7 @@
  *  table of configured filesystems
  */
 
+#include <linux/configfd.h>
 #include <linux/syscalls.h>
 #include <linux/fs.h>
 #include <linux/proc_fs.h>
@@ -82,10 +83,12 @@ int register_filesystem(struct file_system_type * fs)
 		return -EBUSY;
 	write_lock(&file_systems_lock);
 	p = find_filesystem(fs->name, strlen(fs->name));
-	if (*p)
+	if (*p) {
 		res = -EBUSY;
-	else
+	} else {
 		*p = fs;
+		res = fs_context_register(fs);
+	}
 	write_unlock(&file_systems_lock);
 	return res;
 }
@@ -114,6 +117,7 @@ int unregister_filesystem(struct file_system_type * fs)
 		if (fs == *tmp) {
 			*tmp = fs->next;
 			fs->next = NULL;
+			fs_context_unregister(fs);
 			write_unlock(&file_systems_lock);
 			synchronize_rcu();
 			return 0;
diff --git a/fs/fs_context.c b/fs/fs_context.c
index 138b5b4d621d..59bd0aeb0723 100644
--- a/fs/fs_context.c
+++ b/fs/fs_context.c
@@ -235,6 +235,13 @@ int generic_parse_monolithic(struct fs_context *fc, void *data)
 }
 EXPORT_SYMBOL(generic_parse_monolithic);
 
+void fs_context_set_reconfigure(struct fs_context *fc, struct dentry *reference)
+{
+	atomic_inc(&reference->d_sb->s_active);
+	fc->user_ns = get_user_ns(reference->d_sb->s_user_ns);
+	fc->root = dget(reference);
+}
+
 /**
  * alloc_fs_context - Create a filesystem context.
  * @fs_type: The filesystem type.
@@ -279,9 +286,8 @@ static struct fs_context *alloc_fs_context(struct file_system_type *fs_type,
 		fc->user_ns = get_user_ns(reference->d_sb->s_user_ns);
 		break;
 	case FS_CONTEXT_FOR_RECONFIGURE:
-		atomic_inc(&reference->d_sb->s_active);
-		fc->user_ns = get_user_ns(reference->d_sb->s_user_ns);
-		fc->root = dget(reference);
+		if (reference)
+			fs_context_set_reconfigure(fc, reference);
 		break;
 	}
 
@@ -313,7 +319,11 @@ struct fs_context *fs_context_for_reconfigure(struct dentry *dentry,
 					unsigned int sb_flags,
 					unsigned int sb_flags_mask)
 {
-	return alloc_fs_context(dentry->d_sb->s_type, dentry, sb_flags,
+	struct file_system_type *fs_type = NULL;
+
+	if (dentry)
+		fs_type = dentry->d_sb->s_type;
+	return alloc_fs_context(fs_type, dentry, sb_flags,
 				sb_flags_mask, FS_CONTEXT_FOR_RECONFIGURE);
 }
 EXPORT_SYMBOL(fs_context_for_reconfigure);
@@ -361,8 +371,7 @@ struct fs_context *vfs_dup_fs_context(struct fs_context *src_fc)
 	get_net(fc->net_ns);
 	get_user_ns(fc->user_ns);
 	get_cred(fc->cred);
-	if (fc->log)
-		refcount_inc(&fc->log->usage);
+	logger_get(fc->cfc->log);
 
 	/* Can't call put until we've called ->dup */
 	ret = fc->ops->dup(fc, src_fc);
@@ -380,108 +389,6 @@ struct fs_context *vfs_dup_fs_context(struct fs_context *src_fc)
 }
 EXPORT_SYMBOL(vfs_dup_fs_context);
 
-/**
- * logfc - Log a message to a filesystem context
- * @fc: The filesystem context to log to.
- * @fmt: The format of the buffer.
- */
-void logfc(struct fs_context *fc, const char *fmt, ...)
-{
-	static const char store_failure[] = "OOM: Can't store error string";
-	struct fc_log *log = fc ? fc->log : NULL;
-	const char *p;
-	va_list va;
-	char *q;
-	u8 freeable;
-
-	va_start(va, fmt);
-	if (!strchr(fmt, '%')) {
-		p = fmt;
-		goto unformatted_string;
-	}
-	if (strcmp(fmt, "%s") == 0) {
-		p = va_arg(va, const char *);
-		goto unformatted_string;
-	}
-
-	q = kvasprintf(GFP_KERNEL, fmt, va);
-copied_string:
-	if (!q)
-		goto store_failure;
-	freeable = 1;
-	goto store_string;
-
-unformatted_string:
-	if ((unsigned long)p >= (unsigned long)__start_rodata &&
-	    (unsigned long)p <  (unsigned long)__end_rodata)
-		goto const_string;
-	if (log && within_module_core((unsigned long)p, log->owner))
-		goto const_string;
-	q = kstrdup(p, GFP_KERNEL);
-	goto copied_string;
-
-store_failure:
-	p = store_failure;
-const_string:
-	q = (char *)p;
-	freeable = 0;
-store_string:
-	if (!log) {
-		switch (fmt[0]) {
-		case 'w':
-			printk(KERN_WARNING "%s\n", q + 2);
-			break;
-		case 'e':
-			printk(KERN_ERR "%s\n", q + 2);
-			break;
-		default:
-			printk(KERN_NOTICE "%s\n", q + 2);
-			break;
-		}
-		if (freeable)
-			kfree(q);
-	} else {
-		unsigned int logsize = ARRAY_SIZE(log->buffer);
-		u8 index;
-
-		index = log->head & (logsize - 1);
-		BUILD_BUG_ON(sizeof(log->head) != sizeof(u8) ||
-			     sizeof(log->tail) != sizeof(u8));
-		if ((u8)(log->head - log->tail) == logsize) {
-			/* The buffer is full, discard the oldest message */
-			if (log->need_free & (1 << index))
-				kfree(log->buffer[index]);
-			log->tail++;
-		}
-
-		log->buffer[index] = q;
-		log->need_free &= ~(1 << index);
-		log->need_free |= freeable << index;
-		log->head++;
-	}
-	va_end(va);
-}
-EXPORT_SYMBOL(logfc);
-
-/*
- * Free a logging structure.
- */
-static void put_fc_log(struct fs_context *fc)
-{
-	struct fc_log *log = fc->log;
-	int i;
-
-	if (log) {
-		if (refcount_dec_and_test(&log->usage)) {
-			fc->log = NULL;
-			for (i = 0; i <= 7; i++)
-				if (log->need_free & (1 << i))
-					kfree(log->buffer[i]);
-			kfree(log);
-		}
-	}
-}
-
 /**
  * put_fs_context - Dispose of a superblock configuration context.
  * @fc: The context to dispose of.
@@ -504,7 +411,6 @@ void put_fs_context(struct fs_context *fc)
 	put_net(fc->net_ns);
 	put_user_ns(fc->user_ns);
 	put_cred(fc->cred);
-	put_fc_log(fc);
 	put_filesystem(fc->fs_type);
 	kfree(fc->source);
 	kfree(fc);
diff --git a/fs/fsopen.c b/fs/fsopen.c
index 043ffa8dc263..e83df6fc2b08 100644
--- a/fs/fsopen.c
+++ b/fs/fsopen.c
@@ -5,6 +5,7 @@
  * Written by David Howells (dhowells@redhat.com)
  */
 
+#include <linux/configfd.h>
 #include <linux/fs_context.h>
 #include <linux/fs_parser.h>
 #include <linux/slab.h>
@@ -18,90 +19,41 @@
 #include "internal.h"
 #include "mount.h"
 
-/*
- * Allow the user to read back any error, warning or informational messages.
- */
-static ssize_t fscontext_read(struct file *file,
-			      char __user *_buf, size_t len, loff_t *pos)
+static void fsopen_cf_free(const struct configfd_context *cfc)
 {
-	struct fs_context *fc = file->private_data;
-	struct fc_log *log = fc->log;
-	unsigned int logsize = ARRAY_SIZE(log->buffer);
-	ssize_t ret;
-	char *p;
-	bool need_free;
-	int index, n;
-
-	ret = mutex_lock_interruptible(&fc->uapi_mutex);
-	if (ret < 0)
-		return ret;
+	struct fs_context *fc = cfc->data;
 
-	if (log->head == log->tail) {
-		mutex_unlock(&fc->uapi_mutex);
-		return -ENODATA;
-	}
-
-	index = log->tail & (logsize - 1);
-	p = log->buffer[index];
-	need_free = log->need_free & (1 << index);
-	log->buffer[index] = NULL;
-	log->need_free &= ~(1 << index);
-	log->tail++;
-	mutex_unlock(&fc->uapi_mutex);
-
-	ret = -EMSGSIZE;
-	n = strlen(p);
-	if (n > len)
-		goto err_free;
-	ret = -EFAULT;
-	if (copy_to_user(_buf, p, n) != 0)
-		goto err_free;
-	ret = n;
-
-err_free:
-	if (need_free)
-		kfree(p);
-	return ret;
+	put_fs_context(fc);
 }
 
-static int fscontext_release(struct inode *inode, struct file *file)
+static int fsopen_cf_alloc(struct configfd_context *cfc)
 {
-	struct fs_context *fc = file->private_data;
+	struct fs_context *fc;
+	struct file_system_type *fs_type;
 
-	if (fc) {
-		file->private_data = NULL;
-		put_fs_context(fc);
-	}
-	return 0;
-}
+	if (cfc->op != CONFIGFD_CMD_CREATE)
+		return -EINVAL;
 
-const struct file_operations fscontext_fops = {
-	.read		= fscontext_read,
-	.release	= fscontext_release,
-	.llseek		= no_llseek,
-};
+	fs_type = get_fs_type(cfc->cft->name);
+	if (WARN(!fs_type, "BUG: fs_type %s should exist if configfd type does",
+		 cfc->cft->name))
+		return -ENODEV;
 
-/*
- * Attach a filesystem context to a file and an fd.
- */
-static int fscontext_create_fd(struct fs_context *fc, unsigned int o_flags)
-{
-	int fd;
+	if (cfc->op == CONFIGFD_CMD_RECONFIGURE)
+		fc = fs_context_for_reconfigure(NULL, 0, 0);
+	else
+		fc = fs_context_for_mount(fs_type, 0);
+	put_filesystem(fs_type);
+	if (IS_ERR(fc))
+		return PTR_ERR(fc);
 
-	fd = anon_inode_getfd("[fscontext]", &fscontext_fops, fc,
-			      O_RDWR | o_flags);
-	if (fd < 0)
-		put_fs_context(fc);
-	return fd;
-}
+	if (cfc->op == CONFIGFD_CMD_RECONFIGURE)
+		fc->phase = FS_CONTEXT_RECONF_PARAMS;
+	else
+		fc->phase = FS_CONTEXT_CREATE_PARAMS;
+	cfc->data = fc;
+	fc->cfc = cfc;
 
-static int fscontext_alloc_log(struct fs_context *fc)
-{
-	fc->log = kzalloc(sizeof(*fc->log), GFP_KERNEL);
-	if (!fc->log)
-		return -ENOMEM;
-	refcount_set(&fc->log->usage, 1);
-	fc->log->owner = fc->fs_type->owner;
 	return 0;
 }
 
@@ -114,42 +66,14 @@ static int fscontext_alloc_log(struct fs_context *fc)
  */
 SYSCALL_DEFINE2(fsopen, const char __user *, _fs_name, unsigned int, flags)
 {
-	struct file_system_type *fs_type;
-	struct fs_context *fc;
-	const char *fs_name;
-	int ret;
-
 	if (!ns_capable(current->nsproxy->mnt_ns->user_ns, CAP_SYS_ADMIN))
 		return -EPERM;
 
 	if (flags & ~FSOPEN_CLOEXEC)
 		return -EINVAL;
 
-	fs_name = strndup_user(_fs_name, PAGE_SIZE);
-	if (IS_ERR(fs_name))
-		return PTR_ERR(fs_name);
-
-	fs_type = get_fs_type(fs_name);
-	kfree(fs_name);
-	if (!fs_type)
-		return -ENODEV;
-
-	fc = fs_context_for_mount(fs_type, 0);
-	put_filesystem(fs_type);
-	if (IS_ERR(fc))
-		return PTR_ERR(fc);
-
-	fc->phase = FS_CONTEXT_CREATE_PARAMS;
-
-	ret = fscontext_alloc_log(fc);
-	if (ret < 0)
-		goto err_fc;
-
-	return fscontext_create_fd(fc, flags & FSOPEN_CLOEXEC ? O_CLOEXEC : 0);
-
-err_fc:
-	put_fs_context(fc);
-	return ret;
+	return  ksys_configfd_open(_fs_name, flags ? O_CLOEXEC : 0,
+				   CONFIGFD_CMD_CREATE);
 }
 
 /*
@@ -157,10 +81,14 @@ SYSCALL_DEFINE2(fsopen, const char __user *, _fs_name, unsigned int, flags)
  */
 SYSCALL_DEFINE3(fspick, int, dfd, const char __user *, path, unsigned int, flags)
 {
-	struct fs_context *fc;
-	struct path target;
+	struct path *target;
 	unsigned int lookup_flags;
 	int ret;
+	int fd;
+	struct configfd_param cp;
+	struct open_flags of;
+	struct filename *name;
+	struct file *file;
 
 	if (!ns_capable(current->nsproxy->mnt_ns->user_ns, CAP_SYS_ADMIN))
 		return -EPERM;
@@ -178,34 +106,49 @@ SYSCALL_DEFINE3(fspick, int, dfd, const char __user *, path, unsigned int, flags
 		lookup_flags &= ~LOOKUP_AUTOMOUNT;
 	if (flags & FSPICK_EMPTY_PATH)
 		lookup_flags |= LOOKUP_EMPTY;
-	ret = user_path_at(dfd, path, lookup_flags, &target);
-	if (ret < 0)
-		goto err;
 
-	ret = -EINVAL;
-	if (target.mnt->mnt_root != target.dentry)
-		goto err_path;
+	of.lookup_flags = lookup_flags;
+	of.intent = LOOKUP_OPEN;
+	of.acc_mode = 0;
+	of.mode = 0;
+	of.open_flag = O_PATH;
 
-	fc = fs_context_for_reconfigure(target.dentry, 0, 0);
-	if (IS_ERR(fc)) {
-		ret = PTR_ERR(fc);
-		goto err_path;
-	}
+	name = getname_kernel(path);
+	if (IS_ERR(name))
+		return PTR_ERR(name);
 
-	fc->phase = FS_CONTEXT_RECONF_PARAMS;
+	file = do_filp_open(dfd, name, &of);
+	putname(name);
+	if (IS_ERR(file))
+		return PTR_ERR(file);
 
-	ret = fscontext_alloc_log(fc);
-	if (ret < 0)
-		goto err_fc;
+	target = &file->f_path;
+	ret = -EINVAL;
+	if (target->mnt->mnt_root != target->dentry)
+		goto err_file;
 
-	path_put(&target);
-	return fscontext_create_fd(fc, flags & FSPICK_CLOEXEC ? O_CLOEXEC : 0);
+	ret = fd = kern_configfd_open("mount",
+				      flags & FSPICK_CLOEXEC ? O_CLOEXEC : 0,
+				      CONFIGFD_CMD_RECONFIGURE);
+	if (ret < 0)
+		goto err_file;
+	cp = (struct configfd_param) {
+		.key = "pathfd",
+		.file = file,
+		.cmd = CONFIGFD_SET_FD,
+	};
+	ret = kern_configfd_action(fd, &cp);
+	/* file gets NULL'd if successfully installed otherwise we put */
+	if (cp.file)
+		fput(file);
+	if (ret < 0)
+		goto err_close;
+	return fd;
 
-err_fc:
-	put_fs_context(fc);
-err_path:
-	path_put(&target);
-err:
+ err_close:
+	ksys_close(fd);
+ err_file:
+	fput(file);
 	return ret;
 }
 
@@ -268,6 +211,161 @@ static int vfs_fsconfig_locked(struct fs_context *fc, int cmd,
 	return ret;
 }
 
+static int fsopen_cf_mount_set(const struct configfd_context *icfc,
+			       struct configfd_param *p)
+{
+	struct fs_context *fc;
+	struct path *path;
+	/* cheat: we're going to mutate the context so drop the const */
+	struct configfd_context *cfc = (struct configfd_context *)icfc;
+
+	if (strcmp(p->key, "pathfd") != 0 || p->cmd != CONFIGFD_SET_FD) {
+		logger_err(cfc->log, "must set pathfd before any other parameter");
+		return -EINVAL;
+	}
+	if (cfc->op != CONFIGFD_CMD_RECONFIGURE) {
+		logger_err(cfc->log, "may only be opened for reconfigure");
+		return -EINVAL;
+	}
+
+	path = &p->file->f_path;
+	if (path->mnt->mnt_root != path->dentry) {
+		logger_err(cfc->log, "pathfd must identify a mount point");
+		return -EINVAL;
+	}
+	fc = fs_context_for_reconfigure(path->dentry, 0, 0);
+	if (IS_ERR(fc))
+		return PTR_ERR(fc);
+	fc->phase = FS_CONTEXT_RECONF_PARAMS;
+	/* hacky: reconfigure the cfc so all ops now pass to the
+	 * correct filesystem type */
+	cfc->cft = &path->dentry->d_sb->s_type->cft;
+	/* more hackery: mount type is built in so no module ref, but
+	 * filesystem may be modular, so acquire a reference to the
+	 * module for configfd_free to put later */
+	try_module_get(cfc->cft->owner);
+	cfc->data = fc;
+	fc->cfc = cfc;
+
+	return 0;
+}
+
+static int fsopen_cf_set(const struct configfd_context *cfc,
+			 struct configfd_param *p)
+{
+	struct fs_context *fc = cfc->data;
+	int ret;
+
+	struct fs_parameter param = {
+		.type	= fs_value_is_undefined,
+		.key	= p->key,
+	};
+
+	/* parameter we intercept */
+	if (strcmp(p->key, "mount_attrs") == 0 &&
+		   p->cmd == CONFIGFD_SET_INT) {
+		fc->mnt_flags = 0;
+		if (p->aux & ~(MOUNT_ATTR_RDONLY |
+			       MOUNT_ATTR_NOSUID |
+			       MOUNT_ATTR_NODEV |
+			       MOUNT_ATTR_NOEXEC |
+			       MOUNT_ATTR__ATIME |
+			       MOUNT_ATTR_NODIRATIME))
+			return -EINVAL;
+
+		if (p->aux & MOUNT_ATTR_RDONLY)
+			fc->mnt_flags |= MNT_READONLY;
+		if (p->aux & MOUNT_ATTR_NOSUID)
+			fc->mnt_flags |= MNT_NOSUID;
+		if (p->aux & MOUNT_ATTR_NODEV)
+			fc->mnt_flags |= MNT_NODEV;
+		if (p->aux & MOUNT_ATTR_NOEXEC)
+			fc->mnt_flags |= MNT_NOEXEC;
+		if (p->aux & MOUNT_ATTR_NODIRATIME)
+			fc->mnt_flags |= MNT_NODIRATIME;
+
+		switch (p->aux & MOUNT_ATTR__ATIME) {
+		case MOUNT_ATTR_STRICTATIME:
+			break;
+		case MOUNT_ATTR_NOATIME:
+			fc->mnt_flags |= MNT_NOATIME;
+			break;
+		case MOUNT_ATTR_RELATIME:
+			fc->mnt_flags |= MNT_RELATIME;
+			break;
+		default:
+			return -EINVAL;
+		}
+
+		return 0;
+	}
+
+	if (fc->ops == &legacy_fs_context_ops) {
+		switch (p->cmd) {
+		case FSCONFIG_SET_BINARY:
+		case FSCONFIG_SET_PATH:
+		case FSCONFIG_SET_PATH_EMPTY:
+		case FSCONFIG_SET_FD:
+			return -EOPNOTSUPP;
+		default:
+			break;
+		}
+	}
+	switch (p->cmd) {
+	case FSCONFIG_SET_FLAG:
+		param.type = fs_value_is_flag;
+		break;
+	case FSCONFIG_SET_STRING:
+		param.type = fs_value_is_string;
+		param.string = p->string;
+		param.size = p->size;
+		break;
+	case FSCONFIG_SET_BINARY:
+		param.type = fs_value_is_blob;
+		param.size = p->size;
+		param.blob = p->blob;
+		break;
+	case FSCONFIG_SET_PATH:
+		param.type = fs_value_is_filename;
+		param.name = p->name;
+		param.dirfd = p->aux;
+		param.size = p->size;
+		break;
+	case FSCONFIG_SET_PATH_EMPTY:
+		param.type = fs_value_is_filename_empty;
+		param.name = p->name;
+		param.dirfd = p->aux;
+		param.size = p->size;
+		break;
+	case FSCONFIG_SET_FD:
+		param.type = fs_value_is_file;
+		param.file = p->file;
+		break;
+	default:
+		break;
+	}
+
+	ret = mutex_lock_interruptible(&fc->uapi_mutex);
+	if (ret == 0) {
+		ret = vfs_fsconfig_locked(fc, p->cmd, &param);
+		mutex_unlock(&fc->uapi_mutex);
+	}
+	return ret;
+}
+
+static int fsopen_cf_act(const struct configfd_context *cfc,
+			 unsigned int cmd)
+{
+	struct fs_context *fc = cfc->data;
+	int ret = mutex_lock_interruptible(&fc->uapi_mutex);
+
+	if (ret == 0) {
+		ret = vfs_fsconfig_locked(fc, cmd, NULL);
+		mutex_unlock(&fc->uapi_mutex);
+	}
+	return ret;
+}
+
 /**
  * sys_fsconfig - Set parameters and trigger actions on a context
  * @fd: The filesystem context to act upon
@@ -315,161 +413,50 @@ SYSCALL_DEFINE5(fsconfig,
 		int, fd,
 		unsigned int, cmd,
 		const char __user *, _key,
-		const void __user *, _value,
+		void __user *, _value,
 		int, aux)
 {
-	struct fs_context *fc;
-	struct fd f;
-	int ret;
+	return ksys_configfd_action(fd, cmd, _key, _value, aux);
+}
 
-	struct fs_parameter param = {
-		.type	= fs_value_is_undefined,
-	};
+static struct configfd_ops fsopen_cf_ops = {
+	.alloc = fsopen_cf_alloc,
+	.free = fsopen_cf_free,
+	.set = fsopen_cf_set,
+	.act = fsopen_cf_act,
+	.get = fsopen_cf_get,
+};
 
-	if (fd < 0)
-		return -EINVAL;
+static struct configfd_ops fsopen_cf_mount_ops = {
+	.set = fsopen_cf_mount_set,
+};
 
-	switch (cmd) {
-	case FSCONFIG_SET_FLAG:
-		if (!_key || _value || aux)
-			return -EINVAL;
-		break;
-	case FSCONFIG_SET_STRING:
-		if (!_key || !_value || aux)
-			return -EINVAL;
-		break;
-	case FSCONFIG_SET_BINARY:
-		if (!_key || !_value || aux <= 0 || aux > 1024 * 1024)
-			return -EINVAL;
-		break;
-	case FSCONFIG_SET_PATH:
-	case FSCONFIG_SET_PATH_EMPTY:
-		if (!_key || !_value || (aux != AT_FDCWD && aux < 0))
-			return -EINVAL;
-		break;
-	case FSCONFIG_SET_FD:
-		if (!_key || _value || aux < 0)
-			return -EINVAL;
-		break;
-	case FSCONFIG_CMD_CREATE:
-	case FSCONFIG_CMD_RECONFIGURE:
-		if (_key || _value || aux)
-			return -EINVAL;
-		break;
-	default:
-		return -EOPNOTSUPP;
-	}
+static struct configfd_type fsopen_mount_type = {
+	.name = "mount",
+	.ops = &fsopen_cf_mount_ops,
+};
 
-	f = fdget(fd);
-	if (!f.file)
-		return -EBADF;
-	ret = -EINVAL;
-	if (f.file->f_op != &fscontext_fops)
-		goto out_f;
+int fs_context_register(struct file_system_type *fs)
+{
+	int res;
 
-	fc = f.file->private_data;
-	if (fc->ops == &legacy_fs_context_ops) {
-		switch (cmd) {
-		case FSCONFIG_SET_BINARY:
-		case FSCONFIG_SET_PATH:
-		case FSCONFIG_SET_PATH_EMPTY:
-		case FSCONFIG_SET_FD:
-			ret = -EOPNOTSUPP;
-			goto out_f;
-		}
-	}
+	fs->cft.name = fs->name;
+	fs->cft.ops = &fsopen_cf_ops;
+	fs->cft.owner = fs->owner;
+	res = configfd_type_register(&(fs->cft));
 
-	if (_key) {
-		param.key = strndup_user(_key, 256);
-		if (IS_ERR(param.key)) {
-			ret = PTR_ERR(param.key);
-			goto out_f;
-		}
-	}
+	return res;
+}
 
-	switch (cmd) {
-	case FSCONFIG_SET_FLAG:
-		param.type = fs_value_is_flag;
-		break;
-	case FSCONFIG_SET_STRING:
-		param.type = fs_value_is_string;
-		param.string = strndup_user(_value, 256);
-		if (IS_ERR(param.string)) {
-			ret = PTR_ERR(param.string);
-			goto out_key;
-		}
-		param.size = strlen(param.string);
-		break;
-	case FSCONFIG_SET_BINARY:
-		param.type = fs_value_is_blob;
-		param.size = aux;
-		param.blob = memdup_user_nul(_value, aux);
-		if (IS_ERR(param.blob)) {
-			ret = PTR_ERR(param.blob);
-			goto out_key;
-		}
-		break;
-	case FSCONFIG_SET_PATH:
-		param.type = fs_value_is_filename;
-		param.name = getname_flags(_value, 0, NULL);
-		if (IS_ERR(param.name)) {
-			ret = PTR_ERR(param.name);
-			goto out_key;
-		}
-		param.dirfd = aux;
-		param.size = strlen(param.name->name);
-		break;
-	case FSCONFIG_SET_PATH_EMPTY:
-		param.type = fs_value_is_filename_empty;
-		param.name = getname_flags(_value, LOOKUP_EMPTY, NULL);
-		if (IS_ERR(param.name)) {
-			ret = PTR_ERR(param.name);
-			goto out_key;
-		}
-		param.dirfd = aux;
-		param.size = strlen(param.name->name);
-		break;
-	case FSCONFIG_SET_FD:
-		param.type = fs_value_is_file;
-		ret = -EBADF;
-		param.file = fget(aux);
-		if (!param.file)
-			goto out_key;
-		break;
-	default:
-		break;
-	}
+void fs_context_unregister(struct file_system_type *fs)
+{
+	configfd_type_unregister(&(fs->cft));
+}
 
-	ret = mutex_lock_interruptible(&fc->uapi_mutex);
-	if (ret == 0) {
-		ret = vfs_fsconfig_locked(fc, cmd, &param);
-		mutex_unlock(&fc->uapi_mutex);
-	}
+static int __init fsopen_init(void)
+{
+	configfd_type_register(&fsopen_mount_type);
 
-	/* Clean up the our record of any value that we obtained from
-	 * userspace.  Note that the value may have been stolen by the LSM or
-	 * filesystem, in which case the value pointer will have been cleared.
-	 */
-	switch (cmd) {
-	case FSCONFIG_SET_STRING:
-	case FSCONFIG_SET_BINARY:
-		kfree(param.string);
-		break;
-	case FSCONFIG_SET_PATH:
-	case FSCONFIG_SET_PATH_EMPTY:
-		if (param.name)
-			putname(param.name);
-		break;
-	case FSCONFIG_SET_FD:
-		if (param.file)
-			fput(param.file);
-		break;
-	default:
-		break;
-	}
-out_key:
-	kfree(param.key);
-out_f:
-	fdput(f);
-	return ret;
+	return 0;
 }
+fs_initcall(fsopen_init);
diff --git a/fs/internal.h b/fs/internal.h
index 4a7da1df573d..95be145569ec 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -91,6 +91,10 @@ extern int __mnt_want_write_file(struct file *);
 extern void __mnt_drop_write_file(struct file *);
 
 extern void dissolve_on_fput(struct vfsmount *);
+
+int fsopen_cf_get(const struct configfd_context *cfc,
+		  struct configfd_param *p);
+
 /*
  * fs_struct.c
  */
diff --git a/fs/namespace.c b/fs/namespace.c
index be601d3a8008..0acceadef1ff 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -30,6 +30,7 @@
 #include <uapi/linux/mount.h>
 #include <linux/fs_context.h>
 #include <linux/shmem_fs.h>
+#include <linux/configfd.h>
 
 #include "pnode.h"
 #include "internal.h"
@@ -3359,70 +3360,19 @@ SYSCALL_DEFINE5(mount, char __user *, dev_name, char __user *, dir_name,
 	return ret;
 }
 
-/*
- * Create a kernel mount representation for a new, prepared superblock
- * (specified by fs_fd) and attach to an open_tree-like file descriptor.
- */
-SYSCALL_DEFINE3(fsmount, int, fs_fd, unsigned int, flags,
-		unsigned int, attr_flags)
+int fsopen_cf_get(const struct configfd_context *cfc,
+			 struct configfd_param *p)
 {
 	struct mnt_namespace *ns;
-	struct fs_context *fc;
+	struct fs_context *fc = cfc->data;
 	struct file *file;
 	struct path newmount;
 	struct mount *mnt;
-	struct fd f;
-	unsigned int mnt_flags = 0;
 	long ret;
 
-	if (!may_mount())
-		return -EPERM;
-
-	if ((flags & ~(FSMOUNT_CLOEXEC)) != 0)
+	if (strcmp(p->key, "mountfd") != 0 || p->cmd != CONFIGFD_GET_FD)
 		return -EINVAL;
 
-	if (attr_flags & ~(MOUNT_ATTR_RDONLY |
-			   MOUNT_ATTR_NOSUID |
-			   MOUNT_ATTR_NODEV |
-			   MOUNT_ATTR_NOEXEC |
-			   MOUNT_ATTR__ATIME |
-			   MOUNT_ATTR_NODIRATIME))
-		return -EINVAL;
-
-	if (attr_flags & MOUNT_ATTR_RDONLY)
-		mnt_flags |= MNT_READONLY;
-	if (attr_flags & MOUNT_ATTR_NOSUID)
-		mnt_flags |= MNT_NOSUID;
-	if (attr_flags & MOUNT_ATTR_NODEV)
-		mnt_flags |= MNT_NODEV;
-	if (attr_flags & MOUNT_ATTR_NOEXEC)
-		mnt_flags |= MNT_NOEXEC;
-	if (attr_flags & MOUNT_ATTR_NODIRATIME)
-		mnt_flags |= MNT_NODIRATIME;
-
-	switch (attr_flags & MOUNT_ATTR__ATIME) {
-	case MOUNT_ATTR_STRICTATIME:
-		break;
-	case MOUNT_ATTR_NOATIME:
-		mnt_flags |= MNT_NOATIME;
-		break;
-	case MOUNT_ATTR_RELATIME:
-		mnt_flags |= MNT_RELATIME;
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	f = fdget(fs_fd);
-	if (!f.file)
-		return -EBADF;
-
-	ret = -EINVAL;
-	if (f.file->f_op != &fscontext_fops)
-		goto err_fsfd;
-
-	fc = f.file->private_data;
-
 	ret = mutex_lock_interruptible(&fc->uapi_mutex);
 	if (ret < 0)
 		goto err_fsfd;
@@ -3433,7 +3383,7 @@ SYSCALL_DEFINE3(fsmount, int, fs_fd, unsigned int, flags,
 		goto err_unlock;
 
 	ret = -EPERM;
-	if (mount_too_revealing(fc->root->d_sb, &mnt_flags)) {
+	if (mount_too_revealing(fc->root->d_sb, &fc->mnt_flags)) {
 		pr_warn("VFS: Mount too revealing\n");
 		goto err_unlock;
 	}
@@ -3452,7 +3402,7 @@ SYSCALL_DEFINE3(fsmount, int, fs_fd, unsigned int, flags,
 		goto err_unlock;
 	}
 	newmount.dentry = dget(fc->root);
-	newmount.mnt->mnt_flags = mnt_flags;
+	newmount.mnt->mnt_flags = fc->mnt_flags;
 
 	/* We've done the mount bit - now move the file context into more or
 	 * less the same state as if we'd done an fspick().  We don't want to
@@ -3482,23 +3432,56 @@ SYSCALL_DEFINE3(fsmount, int, fs_fd, unsigned int, flags,
 		ret = PTR_ERR(file);
 		goto err_path;
 	}
+	ret = 0;
 	file->f_mode |= FMODE_NEED_UNMOUNT;
-
-	ret = get_unused_fd_flags((flags & FSMOUNT_CLOEXEC) ? O_CLOEXEC : 0);
-	if (ret >= 0)
-		fd_install(ret, file);
-	else
-		fput(file);
+	p->file = file;
 
 err_path:
 	path_put(&newmount);
 err_unlock:
 	mutex_unlock(&fc->uapi_mutex);
 err_fsfd:
-	fdput(f);
+
 	return ret;
 }
 
+/*
+ * Create a kernel mount representation for a new, prepared superblock
+ * (specified by fs_fd) and attach to an open_tree-like file descriptor.
+ */
+SYSCALL_DEFINE3(fsmount, int, fs_fd, unsigned int, flags,
+		unsigned int, attr_flags)
+{
+	int ret;
+	int oflags;
+	struct configfd_param p = {
+		.key = "mount_attrs",
+		.cmd = CONFIGFD_SET_INT,
+		.aux = attr_flags,
+	};
+
+	if (!may_mount())
+		return -EPERM;
+
+	if ((flags & ~(FSMOUNT_CLOEXEC)) != 0)
+		return -EINVAL;
+
+	oflags = (flags & ~(FSMOUNT_CLOEXEC)) ? O_CLOEXEC : 0;
+
+	ret = kern_configfd_action(fs_fd, &p);
+	if (ret < 0)
+		return ret;
+	p = (struct configfd_param) {
+		.key = "mountfd",
+		.cmd = CONFIGFD_GET_FD,
+		.aux = oflags,
+	};
+	ret = kern_configfd_action(fs_fd, &p);
+	if (ret < 0)
+		return ret;
+	return p.aux;
+}
+
 /*
  * Move a mount from one place to another.  In combination with
  * fsopen()/fsmount() this is used to install a new mount and in combination
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 98e0349adb52..70eb6255680d 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2,6 +2,7 @@
 #ifndef _LINUX_FS_H
 #define _LINUX_FS_H
 
+#include <linux/configfd.h>
 #include <linux/linkage.h>
 #include <linux/wait_bit.h>
 #include <linux/kdev_t.h>
@@ -2240,6 +2241,7 @@ struct file_system_type {
 	struct lock_class_key i_lock_key;
 	struct lock_class_key i_mutex_key;
 	struct lock_class_key i_mutex_dir_key;
+	struct configfd_type cft;
 };
 
 #define MODULE_ALIAS_FS(NAME) MODULE_ALIAS("fs-" NAME)
diff --git a/include/linux/fs_context.h b/include/linux/fs_context.h
index e5c14e2c53d3..094a9fb80e89 100644
--- a/include/linux/fs_context.h
+++ b/include/linux/fs_context.h
@@ -97,10 +97,12 @@ struct fs_context {
 	const char		*source;	/* The source name (eg. dev path) */
 	void			*security;	/* Linux S&M options */
 	void			*s_fs_info;	/* Proposed s_fs_info */
+	struct configfd_context	*cfc;
 	unsigned int		sb_flags;	/* Proposed superblock flags (SB_*) */
 	unsigned int		sb_flags_mask;	/* Superblock flags that were changed */
 	unsigned int		s_iflags;	/* OR'd with sb->s_iflags */
 	unsigned int		lsm_flags;	/* Information flags from the fs to the LSM */
+	unsigned int		mnt_flags;	/* mnt flags translated from MOUNT_ATTRS */
 	enum fs_context_purpose	purpose:8;
 	enum fs_context_phase	phase:8;	/* The phase the context is in */
 	bool			need_free:1;	/* Need to call ops->free() */
@@ -134,6 +136,8 @@ extern int vfs_parse_fs_string(struct fs_context *fc, const char *key,
 extern int generic_parse_monolithic(struct fs_context *fc, void *data);
 extern int vfs_get_tree(struct fs_context *fc);
 extern void put_fs_context(struct fs_context *fc);
+extern void fs_context_set_reconfigure(struct fs_context *fc,
+				       struct dentry *reference);
 
 /*
  * sget() wrappers to be called from the ->get_tree() op.
@@ -166,24 +170,13 @@ extern int get_tree_keyed(struct fs_context *fc,
 extern int get_tree_bdev(struct fs_context *fc,
 			       int (*fill_super)(struct super_block *sb,
 						 struct fs_context *fc));
-
-extern const struct file_operations fscontext_fops;
-
-/*
- * Mount error, warning and informational message logging.  This structure is
- * shareable between a mount and a subordinate mount.
- */
-struct fc_log {
-	refcount_t	usage;
-	u8		head;		/* Insertion index in buffer[] */
-	u8		tail;		/* Removal index in buffer[] */
-	u8		need_free;	/* Mask of kfree'able items in buffer[] */
-	struct module	*owner;		/* Owner module for strings that don't then need freeing */
-	char		*buffer[8];
-};
-
-extern __attribute__((format(printf, 2, 3)))
-void logfc(struct fs_context *fc, const char *fmt, ...);
+#define logfc(fc, fmt, ...) ({					\
+			struct fs_context *fsc = (fc);		\
+			struct logger *log = NULL;		\
+			if (fsc)				\
+				log = fsc->cfc->log;		\
+			logger_log(log, fmt, ## __VA_ARGS__);	\
+})
 
 /**
  * infof - Store supplementary informational message
diff --git a/include/linux/fs_parser.h b/include/linux/fs_parser.h
index dee140db6240..c41af1b51af6 100644
--- a/include/linux/fs_parser.h
+++ b/include/linux/fs_parser.h
@@ -143,5 +143,7 @@ static inline bool fs_validate_description(const struct fs_parameter_description
 #define fsparam_path(NAME, OPT)	__fsparam(fs_param_is_path, NAME, OPT, 0)
 #define fsparam_fd(NAME, OPT)	__fsparam(fs_param_is_fd, NAME, OPT, 0)
 
+int fs_context_register(struct file_system_type *fs);
+void fs_context_unregister(struct file_system_type *fs);
 
 #endif /* _LINUX_FS_PARSER_H */
-- 
2.16.4

