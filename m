Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB8CB45621B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Nov 2021 19:13:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234359AbhKRSQM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Nov 2021 13:16:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232139AbhKRSQL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Nov 2021 13:16:11 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B58C4C061574;
        Thu, 18 Nov 2021 10:13:10 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id g14so30909160edb.8;
        Thu, 18 Nov 2021 10:13:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u0pUmD4jWOzvAs6/gAYQctwzm0VBRN7dBAq+mxXqn/U=;
        b=jvVZln40C6eq14lrK7HQ3/bWLLpNitLeBEmxh0vLBRnRSbHUw62TMTP2gXK4THfg5L
         kK5jhwXL/3BtkJUA+a9Xs7X8HhPpKb9eQBtQo+33Fkty/9YktokPStzkfizxtB2j8Dtx
         Fm+Rxjrz5EjBev7iTqN7sVM/6ysSn35FutbPdaXSin2P32vR8MEXHt7N8b4LUxQ/yELJ
         BEa4BEqtN+GjF3qvL+JOkGI25L6sc8xO188TIWMQQOYxGFEurjSeTTtohwmL6be9zL8F
         yvX03i8PysLjxi0V32c3viTVAdd+7nMMhGlHRof+KV3DIQta9v96bgOQipYxiaSPqydF
         aOIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u0pUmD4jWOzvAs6/gAYQctwzm0VBRN7dBAq+mxXqn/U=;
        b=n8sEG6a/1z5aZF2L2BcYx5G6R5xmJkZ6yR+zCj4+f+sPbc9DKYIxryY44+z+rgALDU
         HB/jzN2IaINjkB1bMPwTixVQ2AUdzGYSK5FkNXLtwm3Zg71e2AitDBNVcZPp9TG/nXG7
         smKhyyZuV0gnN5YMet26Xl8J8Q652EmcubzlA+/yg18Nx4IZtG35PcukKB9i7+hbamkI
         EPQ1t28qGvE8ncrM7bCr6Tjw8hnwSuIUOXpMEwNY8a5JFM2uvHzntQuGwCvWXxmaplHP
         d5t5+Z9Oym0kBVPYmc2S+7Ylv0ZuHbVAaY6AxYbN1rB0j17RdM4fkj7qpmHIFImg50nu
         M7DA==
X-Gm-Message-State: AOAM530fCptuF8X986L2c68GnegHUCE3wW5/xEBHqE1Xh8HJhhg9O305
        kVY4nYHo81eFd1OelvvSwNoDV4F7Yu0=
X-Google-Smtp-Source: ABdhPJxTJ+523ewwapU5e2Kkc09iwwRIfyZSdzn/cSpiuT/+ru9rnvhKZC9B5cpMC2ZSAGHrgQngqQ==
X-Received: by 2002:a17:907:b17:: with SMTP id h23mr1492188ejl.80.1637259189050;
        Thu, 18 Nov 2021 10:13:09 -0800 (PST)
Received: from crow.. ([95.87.219.163])
        by smtp.gmail.com with ESMTPSA id d10sm224135eja.4.2021.11.18.10.13.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 10:13:08 -0800 (PST)
From:   "Yordan Karadzhov (VMware)" <y.karadz@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     viro@zeniv.linux.org.uk, ebiederm@xmission.com,
        rostedt@goodmis.org, mingo@redhat.com, hagen@jauu.net,
        rppt@kernel.org, James.Bottomley@HansenPartnership.com,
        akpm@linux-foundation.org, vvs@virtuozzo.com, shakeelb@google.com,
        christian.brauner@ubuntu.com, mkoutny@suse.com,
        "Yordan Karadzhov (VMware)" <y.karadz@gmail.com>
Subject: [RFC PATCH 1/4] namespacefs: Introduce 'namespacefs'
Date:   Thu, 18 Nov 2021 20:12:07 +0200
Message-Id: <20211118181210.281359-2-y.karadz@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211118181210.281359-1-y.karadz@gmail.com>
References: <20211118181210.281359-1-y.karadz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Introducing a simple read-only pseudo file system that aims to provide
direct mechanism for examining the existing hierarchy of namespaces on
the system. When fully functional, 'namespacefs' will allow the user to
see all namespaces that are active on the system and to easily retrieve
the specific data, managed by each namespace. For example the PIDs of
all tasks enclosed in each individual PID namespace.

Here we introduce only the basic definitions of the virtual filesystem
that are based off of 'fs/debugfs/inide.c' and 'fs/tracefs/inod.c'.
The actual coupling between the new filesystem and the namespaces and
all methods for adding/removing namespace directories and files will be
added later.

Signed-off-by: Yordan Karadzhov (VMware) <y.karadz@gmail.com>
---
 fs/Kconfig                  |   1 +
 fs/Makefile                 |   1 +
 fs/namespacefs/Kconfig      |   6 +
 fs/namespacefs/Makefile     |   4 +
 fs/namespacefs/inode.c      | 213 ++++++++++++++++++++++++++++++++++++
 include/linux/idr-seq.h     |   0
 include/linux/namespacefs.h |  47 ++++++++
 include/uapi/linux/magic.h  |   2 +
 8 files changed, 274 insertions(+)
 create mode 100644 fs/namespacefs/Kconfig
 create mode 100644 fs/namespacefs/Makefile
 create mode 100644 fs/namespacefs/inode.c
 create mode 100644 include/linux/idr-seq.h
 create mode 100644 include/linux/namespacefs.h

diff --git a/fs/Kconfig b/fs/Kconfig
index a6313a969bc5..84c220160615 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -268,6 +268,7 @@ config ARCH_HAS_GIGANTIC_PAGE
 
 source "fs/configfs/Kconfig"
 source "fs/efivarfs/Kconfig"
+source "fs/namespacefs/Kconfig"
 
 endmenu
 
diff --git a/fs/Makefile b/fs/Makefile
index 84c5e4cdfee5..5c850f6a7cb0 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -138,3 +138,4 @@ obj-$(CONFIG_EFIVAR_FS)		+= efivarfs/
 obj-$(CONFIG_EROFS_FS)		+= erofs/
 obj-$(CONFIG_VBOXSF_FS)		+= vboxsf/
 obj-$(CONFIG_ZONEFS_FS)		+= zonefs/
+obj-$(CONFIG_NAMESPACE_FS)	+= namespacefs/
diff --git a/fs/namespacefs/Kconfig b/fs/namespacefs/Kconfig
new file mode 100644
index 000000000000..f26bc62376d4
--- /dev/null
+++ b/fs/namespacefs/Kconfig
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0-only
+config NAMESPACE_FS
+	bool "NameSpace Filesystem support"
+	help
+	  This option enables support for namespacefs - a pseudo filesystem
+	  that allows to examine the hierarchy of namespaces.
diff --git a/fs/namespacefs/Makefile b/fs/namespacefs/Makefile
new file mode 100644
index 000000000000..23628d3207e3
--- /dev/null
+++ b/fs/namespacefs/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+namespacefs-objs	:= inode.o
+obj-$(CONFIG_NAMESPACE_FS)	+= namespacefs.o
diff --git a/fs/namespacefs/inode.c b/fs/namespacefs/inode.c
new file mode 100644
index 000000000000..0f6293b0877d
--- /dev/null
+++ b/fs/namespacefs/inode.c
@@ -0,0 +1,213 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * inode.c - part of namespacefs, pseudo filesystem for examining namespaces.
+ *
+ * Copyright 2021 VMware Inc, Yordan Karadzhov (VMware) <y.karadz@gmail.com>
+ */
+
+#include <linux/fs.h>
+#include <linux/sysfs.h>
+#include <linux/namei.h>
+#include <linux/fsnotify.h>
+#include <linux/magic.h>
+
+static struct vfsmount *namespacefs_mount;
+static int namespacefs_mount_count;
+
+static const struct super_operations namespacefs_super_operations = {
+	.statfs		= simple_statfs,
+};
+
+#define S_IRALL (S_IRUSR | S_IRGRP | S_IROTH)
+#define S_IXALL (S_IXUSR | S_IXGRP | S_IXOTH)
+
+static int fill_super(struct super_block *sb, void *data, int silent)
+{
+	static const struct tree_descr files[] = {{""}};
+	int err;
+
+	err = simple_fill_super(sb, NAMESPACEFS_MAGIC, files);
+	if (err)
+		return err;
+
+	sb->s_op = &namespacefs_super_operations;
+	sb->s_root->d_inode->i_mode |= S_IRALL;
+
+	return 0;
+}
+
+static struct dentry *ns_mount(struct file_system_type *fs_type,
+			    int flags, const char *dev_name,
+			    void *data)
+{
+	return mount_single(fs_type, flags, data, fill_super);
+}
+
+static struct file_system_type namespacefs_fs_type = {
+	.name		= "namespacefs",
+	.mount		= ns_mount,
+	.kill_sb	= kill_litter_super,
+	.fs_flags	= FS_USERNS_MOUNT,
+};
+
+static inline void release_namespacefs(void)
+{
+	simple_release_fs(&namespacefs_mount, &namespacefs_mount_count);
+}
+
+static inline struct inode *parent_inode(struct dentry *dentry)
+{
+	return dentry->d_parent->d_inode;
+}
+
+static struct inode *get_inode(struct super_block *sb)
+{
+	struct inode *inode = new_inode(sb);
+	if (inode) {
+		inode->i_ino = get_next_ino();
+		inode->i_atime = inode->i_mtime = inode->i_ctime = current_time(inode);
+	}
+	return inode;
+}
+
+static inline void set_file_inode(struct inode *inode,
+				   const struct file_operations *fops,
+				   void *data)
+{
+	inode->i_fop = fops;
+	inode->i_private = data;
+	inode->i_mode = S_IFREG | S_IRUSR | S_IRGRP;
+}
+
+static inline void set_dir_inode(struct inode *inode)
+{
+	inode->i_op = &simple_dir_inode_operations;
+	inode->i_fop = &simple_dir_operations;
+	inode->i_mode = S_IFDIR | S_IXALL | S_IRALL;
+}
+
+static inline int pin_fs(void)
+{
+	return simple_pin_fs(&namespacefs_fs_type,
+			     &namespacefs_mount,
+			     &namespacefs_mount_count);
+}
+
+static struct dentry *create(const char *name, struct dentry *parent,
+			     const struct user_namespace *user_ns,
+			     const struct file_operations *fops,
+			     void *data)
+{
+	struct dentry *dentry = NULL;
+	struct inode *inode;
+
+	if (pin_fs())
+		return ERR_PTR(-ESTALE);
+
+	/*
+	 * If the parent is not specified, we create it in the root.
+	 * We need the root dentry to do this, which is in the super
+	 * block. A pointer to that is in the struct vfsmount that we
+	 * have around.
+	 */
+	if (!parent)
+		parent = namespacefs_mount->mnt_root;
+
+	inode_lock(parent->d_inode);
+	if (unlikely(IS_DEADDIR(parent->d_inode)))
+		return ERR_PTR(-ESTALE);
+
+	dentry = lookup_one_len(name, parent, strlen(name));
+	if (IS_ERR(dentry) || (!IS_ERR(dentry) && dentry->d_inode))
+		goto fail;
+
+	inode = get_inode(dentry->d_sb);
+	if (unlikely(!inode))
+		goto fail;
+
+	inode->i_uid = user_ns->owner;
+	inode->i_gid = user_ns->group;
+
+	if (fops) {
+		/* Create a file. */
+		set_file_inode(inode, fops, data);
+		d_instantiate(dentry, inode);
+		fsnotify_create(parent_inode(dentry), dentry);
+	} else {
+		/* Create a directory. */
+		set_dir_inode(inode);
+		d_instantiate(dentry, inode);
+		set_nlink(inode, 2);
+		inc_nlink(parent_inode(dentry));
+		fsnotify_mkdir(parent_inode(dentry), dentry);
+	}
+
+	inode_unlock(parent_inode(dentry));
+	return dentry;
+
+ fail:
+	if(!IS_ERR_OR_NULL(dentry))
+		dput(dentry);
+
+	inode_unlock(parent->d_inode);
+	release_namespacefs();
+
+	return ERR_PTR(-ESTALE);
+}
+
+struct dentry *
+namespacefs_create_file(const char *name, struct dentry *parent,
+			const struct user_namespace *user_ns,
+			const struct file_operations *fops,
+			void *data)
+{
+	return create(name, parent, user_ns, fops, data);
+}
+
+struct dentry *
+namespacefs_create_dir(const char *name, struct dentry *parent,
+		       const struct user_namespace *user_ns)
+{
+	return create(name, parent, user_ns, NULL, NULL);
+}
+
+static void remove_one(struct dentry *d)
+{
+	release_namespacefs();
+}
+
+void namespacefs_remove_dir(struct dentry *dentry)
+{
+	if (IS_ERR_OR_NULL(dentry))
+		return;
+
+	if (pin_fs())
+		return;
+
+	simple_recursive_removal(dentry, remove_one);
+	release_namespacefs();
+}
+
+#define _NS_MOUNT_DIR	"namespaces"
+
+static int __init namespacefs_init(void)
+{
+	int err;
+
+	err = sysfs_create_mount_point(fs_kobj, _NS_MOUNT_DIR);
+	if (err)
+		goto fail;
+
+	err = register_filesystem(&namespacefs_fs_type);
+	if (err)
+		goto rm_mount;
+
+	return 0;
+
+ rm_mount:
+	sysfs_remove_mount_point(fs_kobj, _NS_MOUNT_DIR);
+ fail:
+	return err;
+}
+
+fs_initcall(namespacefs_init);
diff --git a/include/linux/idr-seq.h b/include/linux/idr-seq.h
new file mode 100644
index 000000000000..e69de29bb2d1
diff --git a/include/linux/namespacefs.h b/include/linux/namespacefs.h
new file mode 100644
index 000000000000..44a760080df7
--- /dev/null
+++ b/include/linux/namespacefs.h
@@ -0,0 +1,47 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * namespacefs.h - a pseudo file system for examining namespaces.
+ */
+
+#ifndef _NAMESPACEFS_H_
+#define _NAMESPACEFS_H_
+
+#ifdef CONFIG_NAMESPACE_FS
+
+#include <linux/fs.h>
+
+struct dentry *
+namespacefs_create_file(const char *name, struct dentry *parent,
+			const struct user_namespace *user_ns,
+			const struct file_operations *fops,
+			void *data);
+struct dentry *
+namespacefs_create_dir(const char *name, struct dentry *parent,
+		       const struct user_namespace *user_ns);
+void namespacefs_remove_dir(struct dentry *dentry);
+
+#else
+
+static inline struct dentry *
+namespacefs_create_file(const char *name, struct dentry *parent,
+			const struct user_namespace *user_ns,
+			const struct file_operations *fops,
+			void *data)
+{
+	return NULL;
+}
+
+static inline struct dentry *
+namespacefs_create_dir(const char *name, struct dentry *parent,
+		       const struct user_namespace *user_ns)
+{
+	return NULL;
+}
+
+static inline void namespacefs_remove_dir(struct dentry *dentry)
+{
+}
+
+#endif /* CONFIG_NAMESPACE_FS */
+
+#endif
diff --git a/include/uapi/linux/magic.h b/include/uapi/linux/magic.h
index 35687dcb1a42..36b432be0d22 100644
--- a/include/uapi/linux/magic.h
+++ b/include/uapi/linux/magic.h
@@ -62,6 +62,8 @@
 #define CGROUP_SUPER_MAGIC	0x27e0eb
 #define CGROUP2_SUPER_MAGIC	0x63677270
 
+#define NAMESPACEFS_MAGIC	0x458728fa
+
 #define RDTGROUP_SUPER_MAGIC	0x7655821
 
 #define STACK_END_MAGIC		0x57AC6E9D
-- 
2.33.1

