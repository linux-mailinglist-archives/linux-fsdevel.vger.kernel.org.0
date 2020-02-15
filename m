Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C945D15FEFF
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Feb 2020 16:37:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726346AbgBOPhW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 15 Feb 2020 10:37:22 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:53036 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726233AbgBOPhW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 15 Feb 2020 10:37:22 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 00A8C8EE302;
        Sat, 15 Feb 2020 07:37:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1581781042;
        bh=79DNQJtOLsrjgopN00pLq0OrcdjMW6qBZk2QT7VtPZE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KPs3QwUKaPn1qc9mNJE+QOHktDoaSjwhcnh71y5HrJHvRJ51MAdm2LFOWX11EIzBa
         MlOX1w2tM+Lm5tyTJfQc8GqclHYHoIXTeU1doO6k/holNsXuv1yKk2bgXlxpwbIVTr
         mJO91K0NX9tvRQaOCNCpCufTlzNRGOyEwrWpWofg=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ijlHIV3axbNQ; Sat, 15 Feb 2020 07:37:21 -0800 (PST)
Received: from jarvis.lan (jarvis.ext.hansenpartnership.com [153.66.160.226])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 7101E8EE121;
        Sat, 15 Feb 2020 07:37:20 -0800 (PST)
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     David Howells <dhowells@redhat.com>,
        Christian Brauner <christian@brauner.io>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>
Subject: [PATCH v3 2/6] configfd: add generic file descriptor based configuration parser
Date:   Sat, 15 Feb 2020 10:36:05 -0500
Message-Id: <20200215153609.23797-3-James.Bottomley@HansenPartnership.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200215153609.23797-1-James.Bottomley@HansenPartnership.com>
References: <20200215153609.23797-1-James.Bottomley@HansenPartnership.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This code is based on the original filesystem context based
configuration parser by David Howells, but lifted up so it can apply
to anything rather than only filesystem contexts.

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>

---

v3: use prefix logger
---
 fs/Makefile                   |   3 +-
 fs/configfd.c                 | 451 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/configfd.h      |  61 ++++++
 include/uapi/linux/configfd.h |  20 ++
 4 files changed, 534 insertions(+), 1 deletion(-)
 create mode 100644 fs/configfd.c
 create mode 100644 include/linux/configfd.h
 create mode 100644 include/uapi/linux/configfd.h

diff --git a/fs/Makefile b/fs/Makefile
index 505e51166973..2c078355fdf5 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -13,7 +13,8 @@ obj-y :=	open.o read_write.o file_table.o super.o \
 		seq_file.o xattr.o libfs.o fs-writeback.o \
 		pnode.o splice.o sync.o utimes.o d_path.o \
 		stack.o fs_struct.o statfs.o fs_pin.o nsfs.o \
-		fs_types.o fs_context.o fs_parser.o fsopen.o
+		fs_types.o fs_context.o fs_parser.o fsopen.o \
+		configfd.o
 
 ifeq ($(CONFIG_BLOCK),y)
 obj-y +=	buffer.o block_dev.o direct-io.o mpage.o
diff --git a/fs/configfd.c b/fs/configfd.c
new file mode 100644
index 000000000000..50421ddbef11
--- /dev/null
+++ b/fs/configfd.c
@@ -0,0 +1,451 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Generic configuration file descriptor handling
+ *
+ * Copyright (C) 2019 James.Bottomley@HansenPartnership.com
+ */
+
+#include <linux/anon_inodes.h>
+#include <linux/configfd.h>
+#include <linux/namei.h>
+#include <linux/slab.h>
+#include <linux/syscalls.h>
+#include <linux/rwlock.h>
+#include <linux/uaccess.h>
+
+
+static struct configfd_type *configfds;
+static DEFINE_RWLOCK(configfds_lock);
+
+static ssize_t configfd_read(struct file *file,
+			     char __user *buf, size_t len, loff_t *pos)
+{
+	struct configfd_context *cfc = file->private_data;
+
+	return logger_read(cfc->log.log, buf, len);
+}
+
+static void configfd_type_put(const struct configfd_type *cft)
+{
+	module_put(cft->owner);
+}
+
+static void configfd_context_free(struct configfd_context *cfc)
+{
+	if (cfc->cft->ops->free)
+		cfc->cft->ops->free(cfc);
+	logger_put(&cfc->log.log);
+	configfd_type_put(cfc->cft);
+	kfree(cfc);
+}
+
+static int configfd_release(struct inode *inode, struct file *file)
+{
+	struct configfd_context *cfc = file->private_data;
+
+	if (cfc) {
+		file->private_data = NULL;
+		configfd_context_free(cfc);
+	}
+	return 0;
+}
+
+const struct file_operations configfd_context_fops = {
+	.read		= configfd_read,
+	.release	= configfd_release,
+	.llseek		= no_llseek,
+};
+
+static int configfd_create_fd(struct configfd_context *cfc,
+			      unsigned int flags)
+{
+	int fd;
+
+	fd = anon_inode_getfd("[configfd]", &configfd_context_fops, cfc,
+			      O_RDWR | flags);
+	if (fd < 0)
+		configfd_context_free(cfc);
+	return fd;
+}
+
+static struct configfd_type **configfd_type_find(const char *name)
+{
+	struct configfd_type **c;
+
+	for (c = &configfds; *c; c = &(*c)->next) {
+		if (strcmp((*c)->name, name) == 0)
+			break;
+	}
+
+	return c;
+}
+
+static struct configfd_type *configfd_type_get(const char *name)
+{
+	struct configfd_type *cft;
+
+	read_lock(&configfds_lock);
+	cft = *(configfd_type_find(name));
+	if (cft && !try_module_get(cft->owner))
+		cft = NULL;
+	read_unlock(&configfds_lock);
+
+	return cft;
+}
+
+struct configfd_context *configfd_context_alloc(const struct configfd_type *cft,
+						unsigned int op)
+{
+	struct configfd_context *cfc;
+	struct logger *log;
+	int ret;
+
+	cfc = kzalloc(sizeof(*cfc) + cft->data_size, GFP_KERNEL);
+	if (!cfc)
+		return ERR_PTR(-ENOMEM);
+
+	if (cft->data_size)
+		cfc->data = &cfc[1];
+
+	cfc->cft = cft;
+	cfc->op = op;
+	log = logger_alloc(cft->owner);
+	if (IS_ERR(log)) {
+		ret = PTR_ERR(log);
+		goto out_free;
+	}
+
+	cfc->log.log = log;
+	cfc->log.prefix = NULL;
+	if (cft->ops->alloc) {
+		ret = cft->ops->alloc(cfc);
+		if (ret)
+			goto out_put;
+	}
+
+	return cfc;
+ out_put:
+	logger_put(&cfc->log.log);
+ out_free:
+	kfree(cfc);
+	return ERR_PTR(ret);
+}
+
+int kern_configfd_open(const char *config_name, unsigned int flags,
+			unsigned int op)
+{
+	const struct configfd_type *cft;
+	struct configfd_context *cfc;
+
+	if (flags & ~O_CLOEXEC)
+		return -EINVAL;
+	if (op != CONFIGFD_CMD_CREATE && op != CONFIGFD_CMD_RECONFIGURE)
+		return -EINVAL;
+
+	cft = configfd_type_get(config_name);
+	if (!cft)
+		return -ENODEV;
+	cfc = configfd_context_alloc(cft, op);
+	if (IS_ERR(cfc)) {
+		configfd_type_put(cft);
+		return PTR_ERR(cfc);
+	}
+
+	return configfd_create_fd(cfc, flags);
+}
+
+long ksys_configfd_open(const char __user *_config_name, unsigned int flags,
+			unsigned int op)
+{
+	const char *config_name = strndup_user(_config_name, PAGE_SIZE);
+	int ret;
+
+	if (IS_ERR(config_name))
+		return PTR_ERR(config_name);
+	ret = kern_configfd_open(config_name, flags, op);
+	kfree(config_name);
+
+	return ret;
+}
+
+SYSCALL_DEFINE3(configfd_open,
+		const char __user *, _config_name,
+		unsigned int, flags,
+		unsigned int, op)
+{
+	return ksys_configfd_open(_config_name, flags, op);
+}
+
+int kern_configfd_action(int fd, struct configfd_param *p)
+{
+	struct fd f = fdget(fd);
+	struct configfd_context *cfc;
+	const struct configfd_ops *ops;
+	int ret = -EINVAL;
+	/* upper 24 bits are available to consumers */
+	u8 our_cmd = p->cmd & 0xff;
+
+	if (!f.file)
+		return -EBADF;
+	if (f.file->f_op != &configfd_context_fops)
+		goto out_f;
+	cfc = f.file->private_data;
+
+	ops = cfc->cft->ops;
+
+	/* check allowability */
+	ret = -EOPNOTSUPP;
+	switch (our_cmd) {
+	case CONFIGFD_SET_FLAG:
+	case CONFIGFD_SET_STRING:
+	case CONFIGFD_SET_BINARY:
+	case CONFIGFD_SET_PATH:
+	case CONFIGFD_SET_PATH_EMPTY:
+	case CONFIGFD_SET_INT:
+		if (!ops->set)
+			goto out_f;
+		break;
+	case CONFIGFD_GET_FD:
+		if (!ops->get)
+			goto out_f;
+		break;
+	case CONFIGFD_CMD_CREATE:
+	case CONFIGFD_CMD_RECONFIGURE:
+		if (our_cmd != cfc->op) {
+			plogger_err(&cfc->log, "Wrong operation, we were opened for %d", cfc->op);
+			goto out_f;
+		}
+		if (!ops->act)
+			goto out_f;
+		break;
+	default:
+		break;
+	}
+
+	/*
+	 * Execute
+	 */
+	switch (our_cmd) {
+	case CONFIGFD_SET_STRING:
+	case CONFIGFD_SET_BINARY:
+	case CONFIGFD_SET_PATH:
+	case CONFIGFD_SET_PATH_EMPTY:
+	case CONFIGFD_SET_FD:
+	case CONFIGFD_SET_FLAG:
+	case CONFIGFD_SET_INT:
+		ret = ops->set(cfc, p);
+		break;
+	case CONFIGFD_GET_FD:
+		ret = ops->get(cfc, p);
+		if (ret == 0) {
+			int fd;
+
+			fd = get_unused_fd_flags(p->aux & O_CLOEXEC);
+			if (fd < 0) {
+				ret = fd;
+				break;
+			}
+			fd_install(fd, p->file);
+			p->file = NULL; /* consume the file */
+			p->aux = fd;
+		}
+		break;
+	case CONFIGFD_CMD_RECONFIGURE:
+	case CONFIGFD_CMD_CREATE:
+		ret = ops->act(cfc, p->cmd);
+		break;
+	default:
+		break;
+	}
+out_f:
+	fdput(f);
+	return ret;
+}
+
+long ksys_configfd_action(int fd, unsigned int cmd, const char __user *_key,
+			  void __user *_value, int aux)
+{
+	struct configfd_param param = {
+		.cmd = cmd,
+	};
+	u8 our_cmd = cmd & 0xff;
+	int ret;
+
+	/* check parameters required for action */
+	switch (our_cmd) {
+	case CONFIGFD_SET_FLAG:
+		if (!_key || _value || aux)
+			return -EINVAL;
+		break;
+	case CONFIGFD_SET_STRING:
+	case CONFIGFD_GET_FD:
+		if (!_key || !_value)
+			return -EINVAL;
+		break;
+	case CONFIGFD_SET_BINARY:
+		if (!_key || !_value || aux <= 0 || aux > 1024 * 1024)
+			return -EINVAL;
+		break;
+	case CONFIGFD_SET_PATH:
+	case CONFIGFD_SET_PATH_EMPTY:
+		if (!_key || !_value || (aux != AT_FDCWD && aux < 0))
+			return -EINVAL;
+		break;
+	case CONFIGFD_SET_FD:
+		if (!_key || _value || aux < 0)
+			return -EINVAL;
+		break;
+	case CONFIGFD_SET_INT:
+		if (!_key)
+			return -EINVAL;
+		break;
+	case CONFIGFD_CMD_CREATE:
+	case CONFIGFD_CMD_RECONFIGURE:
+		if (_key || _value || aux)
+			return -EINVAL;
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	if (_key) {
+		param.key = strndup_user(_key, 256);
+		if (IS_ERR(param.key))
+			return PTR_ERR(param.key);
+	}
+
+	/* now pull the parameters into the kernel */
+	switch (our_cmd) {
+	case CONFIGFD_SET_STRING:
+		param.string = strndup_user(_value, 256);
+		if (IS_ERR(param.string)) {
+			ret = PTR_ERR(param.string);
+			goto out_key;
+		}
+		param.size = strlen(param.string);
+		break;
+	case CONFIGFD_SET_BINARY:
+		param.size = aux;
+		param.blob = memdup_user_nul(_value, aux);
+		if (IS_ERR(param.blob)) {
+			ret = PTR_ERR(param.blob);
+			goto out_key;
+		}
+		break;
+	case CONFIGFD_SET_PATH:
+		param.name = getname_flags(_value, 0, NULL);
+		if (IS_ERR(param.name)) {
+			ret = PTR_ERR(param.name);
+			goto out_key;
+		}
+		param.aux = aux;
+		param.size = strlen(param.name->name);
+		break;
+	case CONFIGFD_SET_PATH_EMPTY:
+		param.name = getname_flags(_value, LOOKUP_EMPTY, NULL);
+		if (IS_ERR(param.name)) {
+			ret = PTR_ERR(param.name);
+			goto out_key;
+		}
+		param.aux = aux;
+		param.size = strlen(param.name->name);
+		break;
+	case CONFIGFD_SET_FD:
+		ret = -EBADF;
+		param.file = fget_raw(aux);
+		if (!param.file)
+			goto out_key;
+		break;
+	case CONFIGFD_SET_INT:
+		param.aux = aux;
+		break;
+	default:
+		break;
+	}
+	ret = kern_configfd_action(fd, &param);
+	/* clean up unconsumed parameters */
+	switch (our_cmd) {
+	case CONFIGFD_SET_STRING:
+	case CONFIGFD_SET_BINARY:
+		kfree(param.string);
+		break;
+	case CONFIGFD_SET_PATH:
+	case CONFIGFD_SET_PATH_EMPTY:
+		if (param.name)
+			putname(param.name);
+		break;
+	case CONFIGFD_GET_FD:
+		if (!ret)
+			ret = put_user(param.aux, (int __user *)_value);
+		/* FALL THROUGH */
+	case CONFIGFD_SET_FD:
+		if (param.file)
+			fput(param.file);
+		break;
+	default:
+		break;
+	}
+ out_key:
+	kfree(param.key);
+
+	return ret;
+}
+
+
+SYSCALL_DEFINE5(configfd_action,
+		int, fd, unsigned int, cmd,
+		const char __user *, _key,
+		void __user *, _value,
+		int, aux)
+{
+	return ksys_configfd_action(fd, cmd, _key, _value, aux);
+}
+
+int configfd_type_register(struct configfd_type *cft)
+{
+	int ret = 0;
+	struct configfd_type **c;
+
+	if (WARN(cft->next,
+		 "BUG: registering already registered configfd_type: %s",
+		 cft->name))
+		return -EBUSY;
+
+	if (WARN(cft->ops == NULL,
+		 "BUG: configfd_type has no ops set: %s", cft->name))
+		return -EINVAL;
+
+	if (WARN(cft->ops->alloc && (!cft->ops->free),
+		 "BUG: if configfd ops alloc is set, free must also be"))
+		return -EINVAL;
+
+	if (WARN(cft->name == NULL || cft->name[0] == '\0',
+		 "BUG: configfd_type has no name"))
+		return -EINVAL;
+
+	write_lock(&configfds_lock);
+	c = configfd_type_find(cft->name);
+	if (WARN(*c, "BUG: configfd_type name already exists: %s",
+		 cft->name))
+		ret = -EBUSY;
+	else
+		*c = cft;
+	write_unlock(&configfds_lock);
+
+	return ret;
+}
+
+void configfd_type_unregister(struct configfd_type *cft)
+{
+	struct configfd_type **c;
+
+	write_lock(&configfds_lock);
+	c = configfd_type_find(cft->name);
+	if (WARN(*c != cft, "BUG: trying to register %s from wrong structure",
+		 cft->name))
+		goto out;
+	*c = cft->next;
+	cft->next = NULL;
+ out:
+	write_unlock(&configfds_lock);
+}
diff --git a/include/linux/configfd.h b/include/linux/configfd.h
new file mode 100644
index 000000000000..7ef31f3da916
--- /dev/null
+++ b/include/linux/configfd.h
@@ -0,0 +1,61 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#ifndef _LINUX_CONFIGFD_H
+#define _LINUX_CONFIGFD_H
+
+#include <linux/logger.h>
+
+#include <uapi/linux/configfd.h>
+
+struct configfd_context;
+
+struct configfd_param {
+	const char			*key;
+	union {
+		char			*string;
+		void			*blob;
+		struct filename		*name;
+		struct file		*file;
+	};
+	int				aux;
+	unsigned int			cmd;
+	size_t				size;
+};
+
+struct configfd_ops {
+	int (*alloc)(struct configfd_context *cfc);
+	void (*free)(const struct configfd_context *cfc);
+	int (*set)(const struct configfd_context *cfc,
+		   struct configfd_param *p);
+	int (*get)(const struct configfd_context *cfc,
+		   struct configfd_param *p);
+	int (*act)(const struct configfd_context *cfc, unsigned int cmd);
+};
+
+struct configfd_type {
+	const char		*name;
+	size_t			data_size;
+	struct module		*owner;
+	struct configfd_ops	*ops;
+	struct configfd_type	*next;
+};
+
+struct configfd_context {
+	const struct configfd_type	*cft;
+	struct plogger			log;
+	void				*data;
+	unsigned int			op;
+};
+
+int configfd_type_register(struct configfd_type *cft);
+void configfd_type_unregister(struct configfd_type *cft);
+
+long ksys_configfd_open(const char __user *config_name, unsigned int flags,
+			unsigned int op);
+long ksys_configfd_action(int fd, unsigned int cmd, const char __user *key,
+			  void __user *value, int aux);
+int kern_configfd_action(int fd, struct configfd_param *p);
+int kern_configfd_open(const char *name, unsigned int flags,
+		       unsigned int op);
+
+#endif
diff --git a/include/uapi/linux/configfd.h b/include/uapi/linux/configfd.h
new file mode 100644
index 000000000000..3e54cfef0182
--- /dev/null
+++ b/include/uapi/linux/configfd.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later WITH Linux-syscall-note */
+
+#ifndef _UAPI_LINUX_CONFIGFD_H
+#define _UAPI_LINUX_CONFIGFD_H
+
+enum configfd_cmd {
+	CONFIGFD_SET_FLAG		= 0,
+	CONFIGFD_SET_STRING		= 1,
+	CONFIGFD_SET_BINARY		= 2,
+	CONFIGFD_SET_PATH		= 3,
+	CONFIGFD_SET_PATH_EMPTY		= 4,
+	CONFIGFD_SET_FD			= 5,
+	CONFIGFD_CMD_CREATE		= 6,
+	CONFIGFD_CMD_RECONFIGURE	= 7,
+	/* gap for 30 other commands */
+	CONFIGFD_SET_INT		= 38,
+	CONFIGFD_GET_FD			= 39,
+};
+
+#endif
-- 
2.16.4

