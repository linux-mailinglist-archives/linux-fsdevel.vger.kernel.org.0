Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74A7D22C08
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2019 08:26:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730645AbfETG0K (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 May 2019 02:26:10 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34653 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728634AbfETG0K (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 May 2019 02:26:10 -0400
Received: by mail-pg1-f196.google.com with SMTP id c13so6274662pgt.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 19 May 2019 23:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rVJpcNhgE4Hy0/VnpLR/iCaRtErnwDdJp1x5CO5Tj/Q=;
        b=hvzNi7p3MEQazpxQYFTrF5HxcNd8obSapGPXDQzS9hoBq8RrgqB64rPiYUzns7PHEz
         45fWtJlQA6f8guyMMsrHudNvLLYmuyIPFiBbx+m3qOUR3IPsKhkhIXg3zRBMRF/uDKFs
         sykUnEE1M773WgmJ5NhrDobm+5Z59pEcU87Fs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rVJpcNhgE4Hy0/VnpLR/iCaRtErnwDdJp1x5CO5Tj/Q=;
        b=Wg0kLXdsBheRjAfnFXOm1IRVpn5v1BajuANAcgtO3I6TOD5e+2N8mLG94Af9InOc8f
         u/MC2LTV4QSOaJT4Ta9Byoq5PKRkWuuhIUabAFGfpC39Hultd/SzP/Jk35BT0A2XQY8b
         O3gYeiLpnKJPvti2S5KWeMHgcw7rhECayeNhiCuyChMMfM1bDICcfQt/Auc7tqx+SM5O
         VfjI+65y3Z7BqG34hptD5Vs0gv5s1EoaprMJhUVehryUZc7TSEC73PXg5ur+NVc0F+DE
         Wz9/ijECUzdlqwHZEvtOYMKxqBPb1OalqDKAACc2WwnwYbMcLcBy0m1KY+HqcXjo3qIN
         FVTg==
X-Gm-Message-State: APjAAAUfc7deeFM6U/FeJRssdy+XjGgHBn/77E/W9aHJhfvW7nWIvnUs
        5DzykTsx9aRzZ8/FuJTdJlM2g5Bxr7k=
X-Google-Smtp-Source: APXvYqxxGqeFVD4GUyfyva3SOg4hD/FymGHEmKlsE2LkzdHSFVF+dx7E2rbeWYC0jdAKsbYQocgehQ==
X-Received: by 2002:a62:798b:: with SMTP id u133mr14387653pfc.210.1558333568888;
        Sun, 19 May 2019 23:26:08 -0700 (PDT)
Received: from localhost (ppp167-251-205.static.internode.on.net. [59.167.251.205])
        by smtp.gmail.com with ESMTPSA id s19sm16529605pfh.176.2019.05.19.23.26.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 19 May 2019 23:26:08 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     nayna@linux.ibm.com, cclaudio@linux.ibm.com,
        linux-fsdevel@vger.kernel.org, greg@kroah.com,
        linuxppc-dev@lists.ozlabs.org
Cc:     Daniel Axtens <dja@axtens.net>
Subject: [WIP RFC PATCH 2/6] fwvarfs: a generic firmware variable filesystem
Date:   Mon, 20 May 2019 16:25:49 +1000
Message-Id: <20190520062553.14947-3-dja@axtens.net>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190520062553.14947-1-dja@axtens.net>
References: <20190520062553.14947-1-dja@axtens.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Sometimes it is helpful to be able to access firmware variables as
file, like efivarfs, but not all firmware is EFI. Create a framework
that allows generic access to firmware variables exposed by a
implementations of a simple backend API.

Add a demonstration memory-based backend.

Signed-off-by: Daniel Axtens <dja@axtens.net>
---
 Documentation/filesystems/fwvarfs.txt | 146 +++++++++++++
 fs/Kconfig                            |   1 +
 fs/Makefile                           |   1 +
 fs/fwvarfs/Kconfig                    |  25 +++
 fs/fwvarfs/Makefile                   |   8 +
 fs/fwvarfs/fwvarfs.c                  | 289 ++++++++++++++++++++++++++
 fs/fwvarfs/fwvarfs.h                  | 116 +++++++++++
 fs/fwvarfs/mem.c                      | 113 ++++++++++
 fs/kernfs/dir.c                       |   1 -
 include/uapi/linux/magic.h            |   1 +
 10 files changed, 700 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/filesystems/fwvarfs.txt
 create mode 100644 fs/fwvarfs/Kconfig
 create mode 100644 fs/fwvarfs/Makefile
 create mode 100644 fs/fwvarfs/fwvarfs.c
 create mode 100644 fs/fwvarfs/fwvarfs.h
 create mode 100644 fs/fwvarfs/mem.c

diff --git a/Documentation/filesystems/fwvarfs.txt b/Documentation/filesystems/fwvarfs.txt
new file mode 100644
index 000000000000..bf1bccba6ab9
--- /dev/null
+++ b/Documentation/filesystems/fwvarfs.txt
@@ -0,0 +1,146 @@
+fwvarfs
+=======
+
+fwvarfs is a generic firmware variable file-system. A platform
+provides a backend implementing a few very simple callbacks, and
+fwvarfs handles all the details required to present the variables as a
+filesystem.
+
+The minimum functionality for a backend is the ability to enumerate
+existing variables. Backends can optionally also allow:
+ - reading of variables
+ - writing of variables
+ - creation of variables
+ - deletion of variables
+
+Key assumptions
+---------------
+
+ * Variables for each backend live in a single, flat directory -
+   there's no concept of subdirectories.
+
+ * Files are created with mode 600 if the backend provides a write
+   hook, and 400 otherwise, and are owned by root:root.
+
+ * The set of variables stored can be determined at boot time, and
+   nothing outside of fwvarfs creates new variables after boot.
+
+Supported backends
+------------------
+
+ * mem - a memory-backed example filesystem supporting all
+   operations. Files created persist across mount/unmount but as no
+   hardware is involved they do not persist across reboots.
+
+Usage
+-----
+
+mount -t fwvarfs <backend> <dir>
+
+For example:
+
+mount -t fwvarfs mem /fw/mem/
+
+API
+---
+
+A backend is installed by creating a fwvarfs_backend struct,
+containing the name of the backend and various callbacks. The backend
+must be registered by adding it to the list at the top of
+fs/fwvarfs/fwvarfs.c
+
+The fwvarfs infrastructure provides the following function to backends:
+
+  int fwvarfs_register_var(struct fwvarfs_backend *backend, const char *name, void *variable, size_t size);
+
+  Register a variable with fwvarfs to allow it to be seen by users.
+
+  backend: the backend to which to add this variable
+
+  name: the name of file representing the variable. Must be a valid
+        filename, so no nulls or slashes.
+
+  variable: data private to the backend representing the variable -
+            will be passed back to every callback
+
+  size: the initial size of the variable
+
+
+The backend must then provide the following functions:
+
+    int (*enumerate)(void);
+
+	Mandatory and called at init time, a backend must call
+	fwvarfs_register_var for all variables it wants to expose to
+	the user.
+
+    void (*destroy)(void *variable);
+
+	Mandatory if you provide a create or unlink hook, and may
+	become mandatory in the future for cleanup.
+
+	Free backend data associated with variable. It will not be
+	referenced after this point by fwvarfs.
+
+
+    ssize_t (*read)(void *variable, char *dest, size_t bytes, loff_t off);
+
+	Read from variable into the a kernel buffer. Similar semantics
+	to a usual read operation, except that off is not a pointer
+	(unlike the usual ppos).
+
+	variable: the variable to read
+	dest: kernel buffer to read into
+	bytes: maximum number of bytes to read
+	off: offset to read from
+
+	Returns the number of bytes read or an error.
+	If this hook is not provided, all reads will fail with -EPERM.
+
+    ssize_t (*write)(void *variable, const char *src, size_t bytes, loff_t off);
+
+	Write into the variable from the given kernel buffer.
+
+	variable: the variable to write
+	src: kernel buffer with contents
+	bytes: write at most this many bytes
+	off: offset into the file to write at.
+
+	Returns the number of bytes written or an error.
+	If this hook is not provided, all writes will fail with -EPERM.
+
+
+    void* (*create)(const char *name);
+
+	Create a variable with the supplied name, and return the
+	associated private data or an error pointer. Do not return
+	NULL on failure.
+
+	If the variable created cannot be registered for any reason,
+	destroy() will be called on the variable returned.
+
+	If the hook is not provided, all attempts to create a file will
+	fail with -EPERM.
+
+    int (*unlink)(void *variable);
+
+	Delete the variable supplied from the backing store. Do not
+	free it yet, if you return success destroy() will be called on
+	the variable.
+
+	If an error is returned, the unlink will be aborted and the file
+	will still be present in the filesystem.
+
+	If the hook is not provided, all attempts to unlink a file will
+	fail with -EPERM.
+
+TODOs
+-----
+
+Perhaps a different registration scheme?
+Currently size is not updated after write
+Should standardise on whether writes must cover the whole file if partial writes are supported.
+Various TODOs in the code
+Convert API documentation to kerndoc
+perhaps better cleanup/removal, although kernfs doesn't seem to provide anything for this so difficult to do with out leaking memory
+check error handling with kernfs create and O_EXCL
diff --git a/fs/Kconfig b/fs/Kconfig
index cbbffc8b9ef5..6fb6e6cbd7b6 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -219,6 +219,7 @@ config ARCH_HAS_GIGANTIC_PAGE
 
 source "fs/configfs/Kconfig"
 source "fs/efivarfs/Kconfig"
+source "fs/fwvarfs/Kconfig"
 
 endmenu
 
diff --git a/fs/Makefile b/fs/Makefile
index c9aea23aba56..2a0c593dfc0f 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -130,3 +130,4 @@ obj-$(CONFIG_F2FS_FS)		+= f2fs/
 obj-$(CONFIG_CEPH_FS)		+= ceph/
 obj-$(CONFIG_PSTORE)		+= pstore/
 obj-$(CONFIG_EFIVAR_FS)		+= efivarfs/
+obj-$(CONFIG_FWVAR_FS)		+= fwvarfs/
diff --git a/fs/fwvarfs/Kconfig b/fs/fwvarfs/Kconfig
new file mode 100644
index 000000000000..62a47cddd4b5
--- /dev/null
+++ b/fs/fwvarfs/Kconfig
@@ -0,0 +1,25 @@
+# SPDX-License-Identifier: GPL-2.0
+
+config FWVAR_FS
+	bool "Generic Firmware Variable Filesystem"
+	help
+	  fwvarfs is a generic file system for access to firmware
+	  variables.
+
+	  It is pluggable: you will need to select a backend below in
+	  order to actually access anything.
+
+	  This cannot currently be built as a module. (TODO: see if
+	  kernfs can be exported or if there are technical obstacles.)
+
+	  If unsure, say N.
+
+config FWVAR_FS_MEM_BACKEND
+	bool "In-memory testing backend"
+	depends on FWVAR_FS
+	help
+	  Include a backend where firmware variables are just
+	  elements of an in-memory list. This is helpful mostly as a
+	  demonstration of fwvarfs.
+
+	  You can safely say N here unless you're exploring fwvarfs.
diff --git a/fs/fwvarfs/Makefile b/fs/fwvarfs/Makefile
new file mode 100644
index 000000000000..f1585baccabe
--- /dev/null
+++ b/fs/fwvarfs/Makefile
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for the fwvarfs filesytem
+#
+
+obj-$(CONFIG_FWVAR_FS)		+= fwvarfs.o
+
+obj-$(CONFIG_FWVAR_FS_MEM_BACKEND)		+= mem.o
diff --git a/fs/fwvarfs/fwvarfs.c b/fs/fwvarfs/fwvarfs.c
new file mode 100644
index 000000000000..99b7f2fd0f14
--- /dev/null
+++ b/fs/fwvarfs/fwvarfs.c
@@ -0,0 +1,289 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2019 IBM Corporation
+ * Author: Daniel Axtens
+ *
+ * Thanks to efivarfs, rdt, and cgroupfs for the kernfs example.
+ */
+
+#include <linux/fs.h>
+#include <linux/fs_context.h>
+#include <linux/kernfs.h>
+#include <linux/module.h>
+#include <linux/list.h>
+#include <linux/slab.h>
+#include <linux/user_namespace.h>
+#include <uapi/linux/magic.h>
+#include "fwvarfs.h"
+
+#define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
+
+static struct fwvarfs_backend *fwvarfs_backends[] = {
+#if CONFIG_FWVAR_FS_MEM_BACKEND
+	&fwvarfs_mem_backend,
+#endif
+
+	NULL,
+};
+
+struct fwvarfs_file {
+	struct kernfs_node *kn;
+	struct fwvarfs_backend *backend;
+	void *backend_data;
+};
+
+static ssize_t fwvarfs_file_read(struct kernfs_open_file *of, char *buf,
+				 size_t bytes, loff_t off)
+{
+	struct fwvarfs_file *file_data = of->kn->priv;
+
+	if (file_data->backend->read)
+		return file_data->backend->read(file_data->backend_data, buf,
+						bytes, off);
+	else
+		return -EPERM;
+}
+
+static ssize_t fwvarfs_file_write(struct kernfs_open_file *of, char *buf,
+				  size_t bytes, loff_t off)
+{
+	struct fwvarfs_file *file_data = of->kn->priv;
+
+	if (file_data->backend->write)
+		return file_data->backend->write(file_data->backend_data, buf,
+						 bytes, off);
+	else
+		return -EPERM;
+}
+
+
+static struct kernfs_ops fwvarfs_kf_ops = {
+	.atomic_write_len	= PAGE_SIZE,
+	.read			= fwvarfs_file_read,
+	.write			= fwvarfs_file_write,
+};
+
+struct kernfs_node *fwvarfs_create(struct kernfs_node *parent,
+				   const char *name, umode_t mode)
+{
+	struct kernfs_node *kn;
+	struct fwvarfs_file *parent_file = parent->priv;
+	struct fwvarfs_file *file_data;
+	void *backend_data;
+
+	if (!parent_file->backend->create)
+		return ERR_PTR(-EPERM);
+
+	file_data = kzalloc(sizeof(struct fwvarfs_file), GFP_KERNEL);
+	if (!file_data)
+		return ERR_PTR(-ENOMEM);
+
+	file_data->backend = parent_file->backend;
+
+	backend_data = parent_file->backend->create(name);
+
+	if (IS_ERR(backend_data)) {
+		kfree(file_data);
+		return backend_data;
+	}
+
+	file_data->backend_data = backend_data;
+
+	kn = kernfs_create_file(parent, name,
+		(!!parent_file->backend->write ? 0600 : 0400), 0,
+		&fwvarfs_kf_ops, file_data);
+
+	if (IS_ERR(kn)) {
+		parent_file->backend->destroy(backend_data);
+		kfree(file_data);
+		return kn;
+	}
+
+	file_data->kn = kn;
+
+	return kn;
+}
+
+int fwvarfs_unlink(struct kernfs_node *kn)
+{
+
+	struct fwvarfs_file *file_data = kn->priv;
+	int ret;
+
+	if (!file_data->backend->unlink)
+		return -EPERM;
+
+	ret = file_data->backend->unlink(file_data->backend_data);
+
+	if (ret)
+		return ret;
+
+	kernfs_remove(file_data->kn);
+
+	file_data->backend->destroy(file_data->backend_data);
+
+	kfree(file_data);
+	return 0;
+}
+
+static struct kernfs_syscall_ops fwvarfs_scops = {
+	.create = fwvarfs_create,
+	.unlink = fwvarfs_unlink,
+};
+
+int fwvarfs_register_var(struct fwvarfs_backend *backend, const char *name,
+			 void *variable, size_t size)
+{
+	struct fwvarfs_file *file_data;
+	struct kernfs_node *kn;
+
+	file_data = kzalloc(sizeof(struct fwvarfs_file), GFP_KERNEL);
+	if (!file_data)
+		return -ENOMEM;
+
+	file_data->backend = backend;
+	file_data->backend_data = variable;
+
+	kn = kernfs_create_file(backend->kf_root->kn, name,
+		(!!backend->write ? 0600 : 0400), size,
+		&fwvarfs_kf_ops, file_data);
+
+	if (IS_ERR(kn)) {
+		kfree(file_data);
+		return PTR_ERR(kn);
+	}
+
+	file_data->kn = kn;
+
+	return 0;
+
+}
+
+static int fwvarfs_get_tree(struct fs_context *fc)
+{
+	int ret = -ENODEV;
+	struct fwvarfs_backend *backend;
+	struct kernfs_fs_context *kfc = fc->fs_private;
+	int i;
+
+	for (i = 0; (backend = fwvarfs_backends[i]); i++) {
+		if (!backend->is_active)
+			continue;
+
+		if (strcasecmp(fc->source, backend->name) == 0) {
+			kfc->root = backend->kf_root;
+			ret = 0;
+		}
+	}
+	if (ret)
+		return ret;
+
+	return kernfs_get_tree(fc);
+}
+
+static void fwvarfs_free_fs_context(struct fs_context *fc)
+{
+	kernfs_free_fs_context(fc);
+	kfree(fc->fs_private);
+}
+
+static const struct fs_context_operations fwvarfs_fs_context_ops = {
+	.get_tree	= fwvarfs_get_tree,
+	.free		= fwvarfs_free_fs_context,
+};
+
+static int fwvarfs_init_fs_context(struct fs_context *fc)
+{
+	struct kernfs_fs_context *ctx;
+
+	ctx = kzalloc(sizeof(struct kernfs_fs_context), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+
+	ctx->magic = FWVARFS_SUPER_MAGIC;
+	fc->fs_private = ctx;
+
+	fc->ops = &fwvarfs_fs_context_ops;
+	if (fc->user_ns)
+		put_user_ns(fc->user_ns);
+	fc->user_ns = get_user_ns(&init_user_ns);
+	fc->global = true;
+	return 0;
+}
+
+static struct file_system_type fwvarfs_type = {
+	.owner   = THIS_MODULE,
+	.name    = "fwvarfs",
+	.init_fs_context = fwvarfs_init_fs_context,
+	.kill_sb = kernfs_kill_sb,
+};
+
+static __init int fwvarfs_init(void)
+{
+	struct fwvarfs_backend *backend;
+	struct fwvarfs_file *file_data;
+	int ret, i;
+
+	for (i = 0; (backend = fwvarfs_backends[i]); i++) {
+		file_data = kzalloc(sizeof(struct fwvarfs_file), GFP_KERNEL);
+		if (!file_data)
+			return -ENOMEM;
+
+		file_data->backend = backend;
+
+		backend->kf_root = kernfs_create_root(&fwvarfs_scops,
+					KERNFS_ROOT_EXTRA_OPEN_PERM_CHECK,
+					file_data);
+
+		if (IS_ERR(backend->kf_root)) {
+			pr_err("kernfs_create_root failed for %s: %ld",
+				backend->name, PTR_ERR(backend->kf_root));
+			kfree(file_data);
+			continue;
+		}
+
+		file_data->kn = backend->kf_root->kn;
+
+		ret = backend->enumerate();
+		if (ret) {
+			pr_err("enumerate failed for %s: %d",
+			       backend->name, ret);
+
+			/*
+			 * TODO: we make no attempt to clean up partially
+			 * created files at this point
+			 */
+			kernfs_destroy_root(backend->kf_root);
+			kfree(file_data);
+			continue;
+		}
+
+		backend->is_active = true;
+	}
+
+	return register_filesystem(&fwvarfs_type);
+}
+
+
+/*
+ * kernfs doesn't support being called from a module atm
+ * and we also have no obvious way to remove all the created variables, so
+ * atm even if you did this you would leak memory. TODO
+ * static __exit void fwvarfs_exit(void)
+ * {
+ *	unregister_filesystem(&fwvarfs_type);
+ * }
+ */
+
+
+/*
+ * again, kernfs blocks module-ising this atm but it's still a neat way
+ * to handle initialisation
+ */
+MODULE_AUTHOR("Daniel Axtens");
+MODULE_DESCRIPTION("Generic Firmware Variable Filesystem");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS_FS("fwvarfs");
+
+module_init(fwvarfs_init);
+/* module_exit(fwvarfs_exit); */
diff --git a/fs/fwvarfs/fwvarfs.h b/fs/fwvarfs/fwvarfs.h
new file mode 100644
index 000000000000..b2944a3baaf7
--- /dev/null
+++ b/fs/fwvarfs/fwvarfs.h
@@ -0,0 +1,116 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2019 IBM Corporation
+ * Author: Daniel Axtens
+ */
+
+
+#ifndef FWVARFS_H
+#define FWVARFS_H
+
+#include <linux/kernfs.h>
+
+struct fwvarfs_backend {
+	/* name of backend */
+	const char *name;
+
+	/*
+	 * Mandatory and called at init time, a backend must call
+	 * fwvarfs_register_var for all variables it wants to expose to
+	 * the user.
+	 */
+	int (*enumerate)(void);
+
+	/*
+	 * Mandatory if you provide a create or unlink hook, and may
+	 * become mandatory in the future for cleanup.
+	 *
+	 * Free backend data associated with variable. It will not be
+	 * referenced after this point by fwvarfs.
+	 */
+	void (*destroy)(void *variable);
+
+	/*
+	 * Read from variable into the a kernel buffer. Similar semantics
+	 * to a usual read operation, except that off is not a pointer
+	 * (unlike the usual ppos).
+	 *
+	 * variable: the variable to read
+	 * dest: kernel buffer to read into
+	 * bytes: maximum number of bytes to read
+	 * off: offset to read from
+	 *
+	 * Returns the number of bytes read or an error.
+	 * If this hook is not provided, all reads will fail with -EPERM.
+	 */
+	ssize_t (*read)(void *variable, char *dest, size_t bytes, loff_t off);
+
+	/*
+	 * Write into the variable from the given kernel buffer.
+	 *
+	 * variable: the variable to write
+	 * src: kernel buffer with contents
+	 * bytes: write at most this many bytes
+	 * off: offset into the file to write at.
+	 *
+	 * Returns the number of bytes written or an error.
+	 * If this hook is not provided, all writes will fail with -EPERM.
+	 */
+	ssize_t (*write)(void *variable, const char *src, size_t bytes,
+			 loff_t off);
+
+	/*
+	 * Create a variable with the supplied name, and return the
+	 * associated private data or an error pointer. Do not return
+	 * NULL on failure.
+	 *
+	 * If the variable created cannot be registered for any reason,
+	 * destroy() will be called on the variable returned.
+	 *
+	 * If the hook is not provided, all attempts to create a file will
+	 * fail with -EPERM.
+	 */
+	void* (*create)(const char *name);
+
+	/*
+	 * Delete the variable supplied from the backing store. Do not
+	 * free it yet, if you return success destroy() will be called on
+	 * the variable.
+	 *
+	 * If an error is returned, the unlink will be aborted and the file
+	 * will still be present in the filesystem.
+	 *
+	 * If the hook is not provided, all attempts to unlink a file will
+	 * fail with -EPERM.
+	 */
+	int (*unlink)(void *variable);
+
+	/* private to fwvarfs generic code */
+	struct kernfs_root *kf_root;
+	/* did enumerate succeed? */
+	bool is_active;
+};
+
+/*
+ * Register a variable with fwvarfs to allow it to be seen by users.
+ *
+ * backend: the backend to which to add this variable
+ *
+ * name: the name of file representing the variable. Must be a valid
+ *       filename, so no nulls or slashes.
+ *
+ * variable: data private to the backend representing the variable -
+ *           will be passed back to every callback
+ *
+ * size: the initial size of the variable
+ */
+int fwvarfs_register_var(struct fwvarfs_backend *backend, const char *name,
+			 void *variable, size_t size);
+
+
+/* Backends go here */
+#if defined(CONFIG_FWVAR_FS_MEM_BACKEND)
+extern struct fwvarfs_backend fwvarfs_mem_backend;
+#endif
+
+#endif /* FWVARFS_H */
diff --git a/fs/fwvarfs/mem.c b/fs/fwvarfs/mem.c
new file mode 100644
index 000000000000..5c90ea856f8e
--- /dev/null
+++ b/fs/fwvarfs/mem.c
@@ -0,0 +1,113 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2019 IBM Corporation
+ * Author: Daniel Axtens
+ *
+ * Thanks to efivarfs, and cgroupfs for the kernfs example.
+ */
+
+#include <linux/fs.h>
+#include <linux/list.h>
+#include <linux/slab.h>
+#include "fwvarfs.h"
+
+static LIST_HEAD(mem_file_list);
+
+struct fwvarfs_mem_file {
+	size_t length;
+	char data[PAGE_SIZE];
+	struct list_head list;
+};
+
+static ssize_t fwvarfs_mem_file_read(void *var, char *buf, size_t bytes,
+				     loff_t off)
+{
+	struct fwvarfs_mem_file *file_data = var;
+	loff_t ppos = off;
+
+	return memory_read_from_buffer(buf, bytes, &ppos, file_data->data,
+				       file_data->length);
+}
+
+static ssize_t simple_write_to_kernel_buffer(void *to, size_t available,
+					     loff_t *ppos, const void *from,
+					     size_t count)
+{
+	loff_t pos = *ppos;
+
+	if (pos < 0)
+		return -EINVAL;
+	if (pos >= available)
+		return -ENOSPC;
+	if (!count)
+		return 0;
+	if (count > available - pos)
+		count = available - pos;
+	memcpy(to, from, count);
+	*ppos = pos + count;
+	return count;
+}
+
+static ssize_t fwvarfs_mem_file_write(void *var, const char *buf,
+				      size_t bytes, loff_t off)
+{
+	struct fwvarfs_mem_file *file_data = var;
+	loff_t ppos = off;
+	int rc;
+
+	// todo - update size of file
+	rc = simple_write_to_kernel_buffer(file_data->data, PAGE_SIZE, &ppos,
+					   buf, bytes);
+	if (rc)
+		file_data->length = ppos;
+	return rc;
+}
+
+
+static void *fwvarfs_mem_create(const char *name)
+{
+	struct fwvarfs_mem_file *file_data;
+
+	file_data = kzalloc(sizeof(struct fwvarfs_mem_file), GFP_KERNEL);
+	if (!file_data)
+		return ERR_PTR(-ENOMEM);
+
+	INIT_LIST_HEAD(&file_data->list);
+	list_add(&mem_file_list, &file_data->list);
+
+	return file_data;
+}
+
+static void fwvarfs_mem_destroy(void *var)
+{
+	struct fwvarfs_mem_file *file_data = var;
+
+	list_del(&file_data->list);
+	kfree(file_data);
+}
+
+static int fwvarfs_mem_unlink(void *var)
+{
+	/*
+	 * This always succeeds and there's nothing we need to do.
+	 * We free the memory in destroy() which is called after
+	 * this by fwvarfs.
+	 */
+	return 0;
+}
+
+static int fwvarfs_mem_enumerate(void)
+{
+	/* Nothing to do, we always start from a blank slate */
+	return 0;
+}
+
+struct fwvarfs_backend fwvarfs_mem_backend = {
+	.name = "mem",
+	.read = fwvarfs_mem_file_read,
+	.write = fwvarfs_mem_file_write,
+	.create = fwvarfs_mem_create,
+	.destroy = fwvarfs_mem_destroy,
+	.unlink = fwvarfs_mem_unlink,
+	.enumerate = fwvarfs_mem_enumerate,
+};
diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index 74fe51dbd027..211366ecf5a8 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -1201,7 +1201,6 @@ static int kernfs_iop_create(struct inode *dir, struct dentry *dentry,
 		return PTR_ERR(kn);
 
 	d_instantiate(dentry, kernfs_get_inode(dir->i_sb, kn));
-
 	return 0;
 }
 
diff --git a/include/uapi/linux/magic.h b/include/uapi/linux/magic.h
index f8c00045d537..61f2f5532366 100644
--- a/include/uapi/linux/magic.h
+++ b/include/uapi/linux/magic.h
@@ -34,6 +34,7 @@
 #define EFIVARFS_MAGIC		0xde5e81e4
 #define HOSTFS_SUPER_MAGIC	0x00c0ffee
 #define OVERLAYFS_SUPER_MAGIC	0x794c7630
+#define FWVARFS_SUPER_MAGIC	0x66777672	/* "fwvr" */
 
 #define MINIX_SUPER_MAGIC	0x137F		/* minix v1 fs, 14 char names */
 #define MINIX_SUPER_MAGIC2	0x138F		/* minix v1 fs, 30 char names */
-- 
2.19.1

