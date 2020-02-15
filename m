Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DAAB615FF01
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Feb 2020 16:38:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726346AbgBOPiV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 15 Feb 2020 10:38:21 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:53090 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726291AbgBOPiV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 15 Feb 2020 10:38:21 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id B79378EE302;
        Sat, 15 Feb 2020 07:38:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1581781100;
        bh=YkoAJehBTGOwfLZ8o9ktyLnPWwrYcxdOVRvOAgl20XA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CXQ6r7phfKk20I3RK3rUYFUNDpnXit1tT7H79m4OYWP+pp5mVpGTv755BCMJBPj0x
         k09ktrdB9VNLgwp+eatVDDziIxJgZUzD5o6240uvPzX7e+3yzt8komvlw7CQiCLhwZ
         JH6t7CzB9pgG0r5kI/SrGzxdQm9oDm/VKqPivlxE=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id oc81nOfb5SHa; Sat, 15 Feb 2020 07:38:20 -0800 (PST)
Received: from jarvis.lan (jarvis.ext.hansenpartnership.com [153.66.160.226])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id B79EF8EE121;
        Sat, 15 Feb 2020 07:38:19 -0800 (PST)
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     David Howells <dhowells@redhat.com>,
        Christian Brauner <christian@brauner.io>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>
Subject: [PATCH v3 4/6] fs: implement fsconfig via configfd
Date:   Sat, 15 Feb 2020 10:36:07 -0500
Message-Id: <20200215153609.23797-5-James.Bottomley@HansenPartnership.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200215153609.23797-1-James.Bottomley@HansenPartnership.com>
References: <20200215153609.23797-1-James.Bottomley@HansenPartnership.com>
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
v3: sweep up ceph/rdb p_log

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
---
 drivers/block/rbd.c          |   2 +-
 fs/ceph/super.c              |   4 +-
 fs/filesystems.c             |   8 +-
 fs/fs_context.c              |  97 ++------
 fs/fs_parser.c               |  24 +-
 fs/fsopen.c                  | 529 +++++++++++++++++++++----------------------
 fs/internal.h                |   4 +
 fs/namespace.c               | 111 ++++-----
 include/linux/ceph/libceph.h |   5 +-
 include/linux/fs.h           |   2 +
 include/linux/fs_context.h   |  58 +++--
 include/linux/fs_parser.h    |   9 +-
 net/ceph/ceph_common.c       |  26 +--
 13 files changed, 400 insertions(+), 479 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 6343402c09e6..629fc9f1f6cc 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -6348,7 +6348,7 @@ static int rbd_parse_param(struct fs_parameter *param,
 {
 	struct rbd_options *opt = pctx->opts;
 	struct fs_parse_result result;
-	struct p_log log = {.prefix = "rbd"};
+	struct plogger log = {.prefix = "rbd"};
 	int token, ret;
 
 	ret = ceph_parse_param(param, pctx->copts, NULL);
diff --git a/fs/ceph/super.c b/fs/ceph/super.c
index 1d9f083b8a11..052750ae897f 100644
--- a/fs/ceph/super.c
+++ b/fs/ceph/super.c
@@ -246,7 +246,7 @@ static int ceph_parse_source(struct fs_parameter *param, struct fs_context *fc)
 		dout("server path '%s'\n", fsopt->server_path);
 
 	ret = ceph_parse_mon_ips(param->string, dev_name_end - dev_name,
-				 pctx->copts, fc->log.log);
+				 pctx->copts, &fc->cfc->log);
 	if (ret)
 		return ret;
 
@@ -264,7 +264,7 @@ static int ceph_parse_mount_param(struct fs_context *fc,
 	unsigned int mode;
 	int token, ret;
 
-	ret = ceph_parse_param(param, pctx->copts, fc->log.log);
+	ret = ceph_parse_param(param, pctx->copts, &fc->cfc->log);
 	if (ret != -ENOPARAM)
 		return ret;
 
diff --git a/fs/filesystems.c b/fs/filesystems.c
index 77bf5f95362d..d68e8a415c01 100644
--- a/fs/filesystems.c
+++ b/fs/filesystems.c
@@ -7,6 +7,7 @@
  *  table of configured filesystems
  */
 
+#include <linux/configfd.h>
 #include <linux/syscalls.h>
 #include <linux/fs.h>
 #include <linux/proc_fs.h>
@@ -83,10 +84,12 @@ int register_filesystem(struct file_system_type * fs)
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
@@ -115,6 +118,7 @@ int unregister_filesystem(struct file_system_type * fs)
 		if (fs == *tmp) {
 			*tmp = fs->next;
 			fs->next = NULL;
+			fs_context_unregister(fs);
 			write_unlock(&file_systems_lock);
 			synchronize_rcu();
 			return 0;
diff --git a/fs/fs_context.c b/fs/fs_context.c
index fc9f6ef93b55..518e9a010616 100644
--- a/fs/fs_context.c
+++ b/fs/fs_context.c
@@ -238,6 +238,13 @@ int generic_parse_monolithic(struct fs_context *fc, void *data)
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
@@ -271,7 +278,7 @@ static struct fs_context *alloc_fs_context(struct file_system_type *fs_type,
 	fc->fs_type	= get_filesystem(fs_type);
 	fc->cred	= get_current_cred();
 	fc->net_ns	= get_net(current->nsproxy->net_ns);
-	fc->log.prefix	= fs_type->name;
+	fc->cfc->log.prefix	= fs_type->name;
 
 	mutex_init(&fc->uapi_mutex);
 
@@ -283,9 +290,8 @@ static struct fs_context *alloc_fs_context(struct file_system_type *fs_type,
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
 
@@ -317,7 +323,11 @@ struct fs_context *fs_context_for_reconfigure(struct dentry *dentry,
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
@@ -365,8 +375,7 @@ struct fs_context *vfs_dup_fs_context(struct fs_context *src_fc)
 	get_net(fc->net_ns);
 	get_user_ns(fc->user_ns);
 	get_cred(fc->cred);
-	if (fc->log.log)
-		refcount_inc(&fc->log.log->usage);
+	logger_get(fc->cfc->log.log);
 
 	/* Can't call put until we've called ->dup */
 	ret = fc->ops->dup(fc, src_fc);
@@ -384,79 +393,6 @@ struct fs_context *vfs_dup_fs_context(struct fs_context *src_fc)
 }
 EXPORT_SYMBOL(vfs_dup_fs_context);
 
-/**
- * logfc - Log a message to a filesystem context
- * @fc: The filesystem context to log to.
- * @fmt: The format of the buffer.
- */
-void logfc(struct fc_log *log, const char *prefix, char level, const char *fmt, ...)
-{
-	va_list va;
-	struct va_format vaf = {.fmt = fmt, .va = &va};
-
-	va_start(va, fmt);
-	if (!log) {
-		switch (level) {
-		case 'w':
-			printk(KERN_WARNING "%s%s%pV\n", prefix ? prefix : "",
-						prefix ? ": " : "", &vaf);
-			break;
-		case 'e':
-			printk(KERN_ERR "%s%s%pV\n", prefix ? prefix : "",
-						prefix ? ": " : "", &vaf);
-			break;
-		default:
-			printk(KERN_NOTICE "%s%s%pV\n", prefix ? prefix : "",
-						prefix ? ": " : "", &vaf);
-			break;
-		}
-	} else {
-		unsigned int logsize = ARRAY_SIZE(log->buffer);
-		u8 index;
-		char *q = kasprintf(GFP_KERNEL, "%c %s%s%pV\n", level,
-						prefix ? prefix : "",
-						prefix ? ": " : "", &vaf);
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
-		log->buffer[index] = q ? q : "OOM: Can't store error string";
-		if (q)
-			log->need_free |= 1 << index;
-		else
-			log->need_free &= ~(1 << index);
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
-	struct fc_log *log = fc->log.log;
-	int i;
-
-	if (log) {
-		if (refcount_dec_and_test(&log->usage)) {
-			fc->log.log = NULL;
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
@@ -479,7 +415,6 @@ void put_fs_context(struct fs_context *fc)
 	put_net(fc->net_ns);
 	put_user_ns(fc->user_ns);
 	put_cred(fc->cred);
-	put_fc_log(fc);
 	put_filesystem(fc->fs_type);
 	kfree(fc->source);
 	kfree(fc);
diff --git a/fs/fs_parser.c b/fs/fs_parser.c
index 7e6fb43f9541..609f7e1ea506 100644
--- a/fs/fs_parser.c
+++ b/fs/fs_parser.c
@@ -100,7 +100,7 @@ static const struct fs_parameter_spec *fs_lookup_key(
  * unknown parameters are okay and -EINVAL if there was a conversion issue or
  * the parameter wasn't recognised and unknowns aren't okay.
  */
-int __fs_parse(struct p_log *log,
+int __fs_parse(struct plogger *log,
 	     const struct fs_parameter_spec *desc,
 	     struct fs_parameter *param,
 	     struct fs_parse_result *result)
@@ -189,12 +189,12 @@ int fs_lookup_param(struct fs_context *fc,
 }
 EXPORT_SYMBOL(fs_lookup_param);
 
-int fs_param_bad_value(struct p_log *log, struct fs_parameter *param)
+int fs_param_bad_value(struct plogger *log, struct fs_parameter *param)
 {
 	return inval_plog(log, "Bad value for '%s'", param->key);
 }
 
-int fs_param_is_bool(struct p_log *log, const struct fs_parameter_spec *p,
+int fs_param_is_bool(struct plogger *log, const struct fs_parameter_spec *p,
 		     struct fs_parameter *param, struct fs_parse_result *result)
 {
 	int b;
@@ -208,7 +208,7 @@ int fs_param_is_bool(struct p_log *log, const struct fs_parameter_spec *p,
 }
 EXPORT_SYMBOL(fs_param_is_bool);
 
-int fs_param_is_u32(struct p_log *log, const struct fs_parameter_spec *p,
+int fs_param_is_u32(struct plogger *log, const struct fs_parameter_spec *p,
 		    struct fs_parameter *param, struct fs_parse_result *result)
 {
 	int base = (unsigned long)p->data;
@@ -219,7 +219,7 @@ int fs_param_is_u32(struct p_log *log, const struct fs_parameter_spec *p,
 }
 EXPORT_SYMBOL(fs_param_is_u32);
 
-int fs_param_is_s32(struct p_log *log, const struct fs_parameter_spec *p,
+int fs_param_is_s32(struct plogger *log, const struct fs_parameter_spec *p,
 		    struct fs_parameter *param, struct fs_parse_result *result)
 {
 	if (param->type != fs_value_is_string ||
@@ -229,7 +229,7 @@ int fs_param_is_s32(struct p_log *log, const struct fs_parameter_spec *p,
 }
 EXPORT_SYMBOL(fs_param_is_s32);
 
-int fs_param_is_u64(struct p_log *log, const struct fs_parameter_spec *p,
+int fs_param_is_u64(struct plogger *log, const struct fs_parameter_spec *p,
 		    struct fs_parameter *param, struct fs_parse_result *result)
 {
 	if (param->type != fs_value_is_string ||
@@ -239,7 +239,7 @@ int fs_param_is_u64(struct p_log *log, const struct fs_parameter_spec *p,
 }
 EXPORT_SYMBOL(fs_param_is_u64);
 
-int fs_param_is_enum(struct p_log *log, const struct fs_parameter_spec *p,
+int fs_param_is_enum(struct plogger *log, const struct fs_parameter_spec *p,
 		     struct fs_parameter *param, struct fs_parse_result *result)
 {
 	const struct constant_table *c;
@@ -253,7 +253,7 @@ int fs_param_is_enum(struct p_log *log, const struct fs_parameter_spec *p,
 }
 EXPORT_SYMBOL(fs_param_is_enum);
 
-int fs_param_is_string(struct p_log *log, const struct fs_parameter_spec *p,
+int fs_param_is_string(struct plogger *log, const struct fs_parameter_spec *p,
 		       struct fs_parameter *param, struct fs_parse_result *result)
 {
 	if (param->type != fs_value_is_string || !*param->string)
@@ -262,7 +262,7 @@ int fs_param_is_string(struct p_log *log, const struct fs_parameter_spec *p,
 }
 EXPORT_SYMBOL(fs_param_is_string);
 
-int fs_param_is_blob(struct p_log *log, const struct fs_parameter_spec *p,
+int fs_param_is_blob(struct plogger *log, const struct fs_parameter_spec *p,
 		     struct fs_parameter *param, struct fs_parse_result *result)
 {
 	if (param->type != fs_value_is_blob)
@@ -271,7 +271,7 @@ int fs_param_is_blob(struct p_log *log, const struct fs_parameter_spec *p,
 }
 EXPORT_SYMBOL(fs_param_is_blob);
 
-int fs_param_is_fd(struct p_log *log, const struct fs_parameter_spec *p,
+int fs_param_is_fd(struct plogger *log, const struct fs_parameter_spec *p,
 		  struct fs_parameter *param, struct fs_parse_result *result)
 {
 	switch (param->type) {
@@ -293,14 +293,14 @@ int fs_param_is_fd(struct p_log *log, const struct fs_parameter_spec *p,
 }
 EXPORT_SYMBOL(fs_param_is_fd);
 
-int fs_param_is_blockdev(struct p_log *log, const struct fs_parameter_spec *p,
+int fs_param_is_blockdev(struct plogger *log, const struct fs_parameter_spec *p,
 		  struct fs_parameter *param, struct fs_parse_result *result)
 {
 	return 0;
 }
 EXPORT_SYMBOL(fs_param_is_blockdev);
 
-int fs_param_is_path(struct p_log *log, const struct fs_parameter_spec *p,
+int fs_param_is_path(struct plogger *log, const struct fs_parameter_spec *p,
 		     struct fs_parameter *param, struct fs_parse_result *result)
 {
 	return 0;
diff --git a/fs/fsopen.c b/fs/fsopen.c
index 2fa3f241b762..b898623e4682 100644
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
-	struct fc_log *log = fc->log.log;
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
-	fc->log.log = kzalloc(sizeof(*fc->log.log), GFP_KERNEL);
-	if (!fc->log.log)
-		return -ENOMEM;
-	refcount_set(&fc->log.log->usage, 1);
-	fc->log.log->owner = fc->fs_type->owner;
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
+		plogger_err(&cfc->log, "must set pathfd before any other parameter");
+		return -EINVAL;
+	}
+	if (cfc->op != CONFIGFD_CMD_RECONFIGURE) {
+		plogger_err(&cfc->log, "may only be opened for reconfigure");
+		return -EINVAL;
+	}
+
+	path = &p->file->f_path;
+	if (path->mnt->mnt_root != path->dentry) {
+		plogger_err(&cfc->log, "pathfd must identify a mount point");
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
+		param.type = fs_value_is_filename;
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
@@ -315,155 +413,50 @@ SYSCALL_DEFINE5(fsconfig,
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
-	int lookup_flags = 0;
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
-	case FSCONFIG_SET_PATH_EMPTY:
-		lookup_flags = LOOKUP_EMPTY;
-		/* fallthru */
-	case FSCONFIG_SET_PATH:
-		param.type = fs_value_is_filename;
-		param.name = getname_flags(_value, lookup_flags, NULL);
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
index f3f280b952a3..507d59e9a540 100644
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
index 85b5f7bea82e..09b3220d9437 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -30,6 +30,7 @@
 #include <uapi/linux/mount.h>
 #include <linux/fs_context.h>
 #include <linux/shmem_fs.h>
+#include <linux/configfd.h>
 
 #include "pnode.h"
 #include "internal.h"
@@ -3324,70 +3325,19 @@ SYSCALL_DEFINE5(mount, char __user *, dev_name, char __user *, dir_name,
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
@@ -3398,7 +3348,7 @@ SYSCALL_DEFINE3(fsmount, int, fs_fd, unsigned int, flags,
 		goto err_unlock;
 
 	ret = -EPERM;
-	if (mount_too_revealing(fc->root->d_sb, &mnt_flags)) {
+	if (mount_too_revealing(fc->root->d_sb, &fc->mnt_flags)) {
 		pr_warn("VFS: Mount too revealing\n");
 		goto err_unlock;
 	}
@@ -3417,7 +3367,7 @@ SYSCALL_DEFINE3(fsmount, int, fs_fd, unsigned int, flags,
 		goto err_unlock;
 	}
 	newmount.dentry = dget(fc->root);
-	newmount.mnt->mnt_flags = mnt_flags;
+	newmount.mnt->mnt_flags = fc->mnt_flags;
 
 	/* We've done the mount bit - now move the file context into more or
 	 * less the same state as if we'd done an fspick().  We don't want to
@@ -3447,23 +3397,56 @@ SYSCALL_DEFINE3(fsmount, int, fs_fd, unsigned int, flags,
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
diff --git a/include/linux/ceph/libceph.h b/include/linux/ceph/libceph.h
index ec73ebc4827d..64b97014c388 100644
--- a/include/linux/ceph/libceph.h
+++ b/include/linux/ceph/libceph.h
@@ -281,12 +281,11 @@ extern int ceph_check_fsid(struct ceph_client *client, struct ceph_fsid *fsid);
 extern void *ceph_kvmalloc(size_t size, gfp_t flags);
 
 struct fs_parameter;
-struct fc_log;
 struct ceph_options *ceph_alloc_options(void);
 int ceph_parse_mon_ips(const char *buf, size_t len, struct ceph_options *opt,
-		       struct fc_log *l);
+		       struct plogger *l);
 int ceph_parse_param(struct fs_parameter *param, struct ceph_options *opt,
-		     struct fc_log *l);
+		     struct plogger *l);
 int ceph_print_client_options(struct seq_file *m, struct ceph_client *client,
 			      bool show_all);
 extern void ceph_destroy_options(struct ceph_options *opt);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 3cd4fe6b845e..4dc62a697817 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2,6 +2,7 @@
 #ifndef _LINUX_FS_H
 #define _LINUX_FS_H
 
+#include <linux/configfd.h>
 #include <linux/linkage.h>
 #include <linux/wait_bit.h>
 #include <linux/kdev_t.h>
@@ -2251,6 +2252,7 @@ struct file_system_type {
 	struct lock_class_key i_lock_key;
 	struct lock_class_key i_mutex_key;
 	struct lock_class_key i_mutex_dir_key;
+	struct configfd_type cft;
 };
 
 #define MODULE_ALIAS_FS(NAME) MODULE_ALIAS("fs-" NAME)
diff --git a/include/linux/fs_context.h b/include/linux/fs_context.h
index e6c3e4c61dad..da422d99cf8a 100644
--- a/include/linux/fs_context.h
+++ b/include/linux/fs_context.h
@@ -73,11 +73,6 @@ struct fs_parameter {
 	int	dirfd;
 };
 
-struct p_log {
-	const char *prefix;
-	struct fc_log *log;
-};
-
 /*
  * Filesystem context for holding the parameters used in the creation or
  * reconfiguration of a superblock.
@@ -97,14 +92,15 @@ struct fs_context {
 	struct user_namespace	*user_ns;	/* The user namespace for this mount */
 	struct net		*net_ns;	/* The network namespace for this mount */
 	const struct cred	*cred;		/* The mounter's credentials */
-	struct p_log		log;		/* Logging buffer */
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
@@ -138,6 +134,8 @@ extern int vfs_parse_fs_string(struct fs_context *fc, const char *key,
 extern int generic_parse_monolithic(struct fs_context *fc, void *data);
 extern int vfs_get_tree(struct fs_context *fc);
 extern void put_fs_context(struct fs_context *fc);
+extern void fs_context_set_reconfigure(struct fs_context *fc,
+				       struct dentry *reference);
 
 /*
  * sget() wrappers to be called from the ->get_tree() op.
@@ -170,28 +168,28 @@ extern int get_tree_keyed(struct fs_context *fc,
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
-extern __attribute__((format(printf, 4, 5)))
-void logfc(struct fc_log *log, const char *prefix, char level, const char *fmt, ...);
-
-#define __logfc(fc, l, fmt, ...) logfc((fc)->log.log, NULL, \
+#define logfc(fc, p, l, fmt, ...) ({			\
+			struct fs_context *fsc = (fc);		\
+			struct logger *log = NULL;		\
+			if (fsc)				\
+				log = fsc->cfc->log.log;	\
+			logger_log(log, p, l, fmt, ## __VA_ARGS__);	\
+})
+
+#define plogfc(fc, l, fmt, ...) ({			\
+			struct fs_context *fsc = (fc);		\
+			struct plogger *log = NULL;		\
+			const char *p = NULL;			\
+			if (fsc) {				\
+				log = &fsc->cfc->log;		\
+				p = log->prefix;		\
+			}					\
+			logger_log(log->log, p, l, fmt, ## __VA_ARGS__);	\
+})
+
+#define __logfc(fc, l, fmt, ...) logfc(fc, NULL, \
 					l, fmt, ## __VA_ARGS__)
-#define __plog(p, l, fmt, ...) logfc((p)->log, (p)->prefix, \
+#define __plog(p, l, fmt, ...) logger_log((p)->log, (p)->prefix,	\
 					l, fmt, ## __VA_ARGS__)
 /**
  * infof - Store supplementary informational message
@@ -203,7 +201,7 @@ void logfc(struct fc_log *log, const char *prefix, char level, const char *fmt,
  */
 #define infof(fc, fmt, ...) __logfc(fc, 'i', fmt, ## __VA_ARGS__)
 #define info_plog(p, fmt, ...) __plog(p, 'i', fmt, ## __VA_ARGS__)
-#define infofc(p, fmt, ...) __plog((&(fc)->log), 'i', fmt, ## __VA_ARGS__)
+#define infofc(p, fmt, ...) plogfc(fc, 'i', fmt, ## __VA_ARGS__)
 
 /**
  * warnf - Store supplementary warning message
@@ -215,7 +213,7 @@ void logfc(struct fc_log *log, const char *prefix, char level, const char *fmt,
  */
 #define warnf(fc, fmt, ...) __logfc(fc, 'w', fmt, ## __VA_ARGS__)
 #define warn_plog(p, fmt, ...) __plog(p, 'w', fmt, ## __VA_ARGS__)
-#define warnfc(fc, fmt, ...) __plog((&(fc)->log), 'w', fmt, ## __VA_ARGS__)
+#define warnfc(fc, fmt, ...) plogfc(fc, 'w', fmt, ## __VA_ARGS__)
 
 /**
  * errorf - Store supplementary error message
@@ -227,7 +225,7 @@ void logfc(struct fc_log *log, const char *prefix, char level, const char *fmt,
  */
 #define errorf(fc, fmt, ...) __logfc(fc, 'e', fmt, ## __VA_ARGS__)
 #define error_plog(p, fmt, ...) __plog(p, 'e', fmt, ## __VA_ARGS__)
-#define errorfc(fc, fmt, ...) __plog((&(fc)->log), 'e', fmt, ## __VA_ARGS__)
+#define errorfc(fc, fmt, ...) plogfc(fc, 'e', fmt, ## __VA_ARGS__)
 
 /**
  * invalf - Store supplementary invalid argument error message
diff --git a/include/linux/fs_parser.h b/include/linux/fs_parser.h
index 2eab6d5f6736..7a7302341b56 100644
--- a/include/linux/fs_parser.h
+++ b/include/linux/fs_parser.h
@@ -19,7 +19,7 @@ struct constant_table {
 
 struct fs_parameter_spec;
 struct fs_parse_result;
-typedef int fs_param_type(struct p_log *,
+typedef int fs_param_type(struct plogger *,
 			  const struct fs_parameter_spec *,
 			  struct fs_parameter *,
 			  struct fs_parse_result *);
@@ -60,7 +60,7 @@ struct fs_parse_result {
 	};
 };
 
-extern int __fs_parse(struct p_log *log,
+extern int __fs_parse(struct plogger *log,
 		    const struct fs_parameter_spec *desc,
 		    struct fs_parameter *value,
 		    struct fs_parse_result *result);
@@ -70,7 +70,7 @@ static inline int fs_parse(struct fs_context *fc,
 	     struct fs_parameter *param,
 	     struct fs_parse_result *result)
 {
-	return __fs_parse(&fc->log, desc, param, result);
+	return __fs_parse(&fc->cfc->log, desc, param, result);
 }
 
 extern int fs_lookup_param(struct fs_context *fc,
@@ -131,4 +131,7 @@ static inline bool fs_validate_description(const char *name,
 #define fsparam_path(NAME, OPT)	__fsparam(fs_param_is_path, NAME, OPT, 0, NULL)
 #define fsparam_fd(NAME, OPT)	__fsparam(fs_param_is_fd, NAME, OPT, 0, NULL)
 
+int fs_context_register(struct file_system_type *fs);
+void fs_context_unregister(struct file_system_type *fs);
+
 #endif /* _LINUX_FS_PARSER_H */
diff --git a/net/ceph/ceph_common.c b/net/ceph/ceph_common.c
index a0e97f6c1072..f7112d36e4a2 100644
--- a/net/ceph/ceph_common.c
+++ b/net/ceph/ceph_common.c
@@ -332,7 +332,7 @@ EXPORT_SYMBOL(ceph_destroy_options);
 
 /* get secret from key store */
 static int get_secret(struct ceph_crypto_key *dst, const char *name,
-		      struct p_log *log)
+		      struct plogger *log)
 {
 	struct key *ukey;
 	int key_err;
@@ -378,16 +378,16 @@ static int get_secret(struct ceph_crypto_key *dst, const char *name,
 }
 
 int ceph_parse_mon_ips(const char *buf, size_t len, struct ceph_options *opt,
-		       struct fc_log *l)
+		       struct plogger *l)
 {
-	struct p_log log = {.prefix = "libceph", .log = l};
 	int ret;
 
+	l->prefix = "libceph";
 	/* ip1[:port1][,ip2[:port2]...] */
 	ret = ceph_parse_ips(buf, buf + len, opt->mon_addr, CEPH_MAX_MON,
 			     &opt->num_mon);
 	if (ret) {
-		error_plog(&log, "Failed to parse monitor IPs: %d", ret);
+		error_plog(l, "Failed to parse monitor IPs: %d", ret);
 		return ret;
 	}
 
@@ -396,13 +396,13 @@ int ceph_parse_mon_ips(const char *buf, size_t len, struct ceph_options *opt,
 EXPORT_SYMBOL(ceph_parse_mon_ips);
 
 int ceph_parse_param(struct fs_parameter *param, struct ceph_options *opt,
-		     struct fc_log *l)
+		     struct plogger *l)
 {
 	struct fs_parse_result result;
 	int token, err;
-	struct p_log log = {.prefix = "libceph", .log = l};
 
-	token = __fs_parse(&log, ceph_parameters, param, &result);
+	l->prefix = "libceph";
+	token = __fs_parse(l, ceph_parameters, param, &result);
 	dout("%s fs_parse '%s' token %d\n", __func__, param->key, token);
 	if (token < 0)
 		return token;
@@ -414,7 +414,7 @@ int ceph_parse_param(struct fs_parameter *param, struct ceph_options *opt,
 				     &opt->my_addr,
 				     1, NULL);
 		if (err) {
-			error_plog(&log, "Failed to parse ip: %d", err);
+			error_plog(l, "Failed to parse ip: %d", err);
 			return err;
 		}
 		opt->flags |= CEPH_OPT_MYIP;
@@ -423,7 +423,7 @@ int ceph_parse_param(struct fs_parameter *param, struct ceph_options *opt,
 	case Opt_fsid:
 		err = parse_fsid(param->string, &opt->fsid);
 		if (err) {
-			error_plog(&log, "Failed to parse fsid: %d", err);
+			error_plog(l, "Failed to parse fsid: %d", err);
 			return err;
 		}
 		opt->flags |= CEPH_OPT_FSID;
@@ -442,7 +442,7 @@ int ceph_parse_param(struct fs_parameter *param, struct ceph_options *opt,
 			return -ENOMEM;
 		err = ceph_crypto_key_unarmor(opt->key, param->string);
 		if (err) {
-			error_plog(&log, "Failed to parse secret: %d", err);
+			error_plog(l, "Failed to parse secret: %d", err);
 			return err;
 		}
 		break;
@@ -453,10 +453,10 @@ int ceph_parse_param(struct fs_parameter *param, struct ceph_options *opt,
 		opt->key = kzalloc(sizeof(*opt->key), GFP_KERNEL);
 		if (!opt->key)
 			return -ENOMEM;
-		return get_secret(opt->key, param->string, &log);
+		return get_secret(opt->key, param->string, l);
 
 	case Opt_osdtimeout:
-		warn_plog(&log, "Ignoring osdtimeout");
+		warn_plog(l, "Ignoring osdtimeout");
 		break;
 	case Opt_osdkeepalivetimeout:
 		/* 0 isn't well defined right now, reject it */
@@ -527,7 +527,7 @@ int ceph_parse_param(struct fs_parameter *param, struct ceph_options *opt,
 	return 0;
 
 out_of_range:
-	return inval_plog(&log, "%s out of range", param->key);
+	return inval_plog(l, "%s out of range", param->key);
 }
 EXPORT_SYMBOL(ceph_parse_param);
 
-- 
2.16.4


