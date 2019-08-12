Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A87708A3AF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2019 18:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbfHLQsZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Aug 2019 12:48:25 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43124 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbfHLQsZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Aug 2019 12:48:25 -0400
Received: by mail-wr1-f65.google.com with SMTP id p13so30584466wru.10
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Aug 2019 09:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=plexistor-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F+3wPzIXs1yuVNeme2SsehvdfeLoZ6zOitzyEMwj7eA=;
        b=GDMXM01UchlO8SMI2SRRv7O7N+K408I8wQavNGIW6ZHyoHTOBg/Tk8TThkxDwv5BNE
         n36NuMlOjd7Jpof0ucoonHR8CEu+5Aora6Tx8V+YFqQn8clooFwIWw8r0P7v+7Q1xcsT
         hc7nU6VOQGaK1ZYanmCIM47n9abJO7sriBO3PwgJpHudrbOpGSWoY7HpzeV5tk5XluAD
         Wa5RyBYri5RbUD6TygLOcRUdsQ4Oj7KU0kSHQb9+NndgQKJXHzE1y19dI8+/rRrSlZYL
         I1siFU4pZivABOmBPZBy0wWjF3X+J3E6csQan5UXGI2TtocZXU+MLDc94Hujl5YrZGxT
         9Lkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F+3wPzIXs1yuVNeme2SsehvdfeLoZ6zOitzyEMwj7eA=;
        b=bnPF39VTE0UBZFV+bMH/wsoLQrlq6nqopgnNKLD3dSzWq4qoB4zh0MIerw7Ehf58c1
         j2RYYmBgTeUpfp8X/1mTezhOR0lkgEnmR9YPVP0sWNRchAb7b2jnlIvetzaAgBX3T1vS
         EPJq12fRdyOAXi8tvkCJR8i4WSGnjjjhEG6EkHhbeUevIx5lXoHWQVMzoSRq0UufI2No
         JY5fxNG2mLBWzTh+ihCEEJvetLuyrTBXIBlCT5HE3sgKN1rj4OUe7fc80xGptdnRAovT
         mf4iVtLVFWVXGC8omkpzESS5vkNfb0jGBscgWa0Q56yRojRozoIv8dErK0RyKeWjAstS
         weQw==
X-Gm-Message-State: APjAAAXnkiR7yGvYiSWtZYdmNucq0dp3xVfdUTlf/o1B84lJhetsnvAk
        +JJsXf9HMyFTsNpRP67tASOVPU2oKsU=
X-Google-Smtp-Source: APXvYqwQQG1FI+nyxd1ax35gYSvJL77jU28ONR+VHP9/JYQ3gXHnarr5f9lgpYNxGlgEtg/2JKZy9Q==
X-Received: by 2002:a5d:4b83:: with SMTP id b3mr36768053wrt.104.1565628500561;
        Mon, 12 Aug 2019 09:48:20 -0700 (PDT)
Received: from Bfire.plexistor.com ([217.70.211.18])
        by smtp.googlemail.com with ESMTPSA id b136sm200290wme.18.2019.08.12.09.48.18
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 12 Aug 2019 09:48:20 -0700 (PDT)
From:   Boaz Harrosh <boaz@plexistor.com>
X-Google-Original-From: Boaz Harrosh <boazh@netapp.com>
To:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Anna Schumaker <Anna.Schumaker@netapp.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Amit Golander <Amit.Golander@netapp.com>,
        Sagi Manole <sagim@netapp.com>,
        Matthew Wilcox <willy@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 04/16] zuf: zuf-rootfs
Date:   Mon, 12 Aug 2019 19:47:54 +0300
Message-Id: <20190812164806.15852-5-boazh@netapp.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190812164806.15852-1-boazh@netapp.com>
References: <20190812164806.15852-1-boazh@netapp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

zuf-root is a pseudo FS that the zusd Server communicates through,
registers new file-systems. receives new mount requests.

In this patch we have the bring up of that special FS.

The principal communication with zuf-rootfs is done through
tmep-files + io-ctls.
Caller does an open(O_TMPFILE) and invokes some IOCTL_XXX on
the file. The specific ioctl establishes one of zuf_special_file
types object and attaches the object to the file-ptr and by that
defining special behavior for that object.

Otherwise zuf-rootfs is not an FS at all. It has a few viewable
variable files, exposing state and info about the system. In this
patch we can see the "state" variable-file, that denotes to user-mode
when the Kernel is ready for new mounts. And the registered_fs which
exposes what zufFS(s) where registered with the Kernel.

There is a one-to-one relationship between a zuf-root SB and
a zusd Server. Each zusd Server can support multiple zusFS
plugins and register multiple filesystem-types.

The zuf-rootfs (mount -t zuf) is usually mounted on
/sys/fs/zuf. The /sys/fs/zuf directory is automatically created
when zuf.ko is loaded. If an admin wants to run more zusd server
applications she/he can mount a second instance of -t zuf on some
dir and point the new zusd Server to it. (zusd has an optional path
argument). Otherwise a second instance attempting to communicate
with a busy zuf-root will fail.

TODO: How to trigger a first mount on module_load. Currently
admin needs to manually "mount -t zuf none /sys/fs/zuf"

Signed-off-by: Boaz Harrosh <boazh@netapp.com>
---
 fs/zuf/Makefile   |   4 +
 fs/zuf/_extern.h  |  41 +++++
 fs/zuf/_pr.h      |  63 +++++++
 fs/zuf/super.c    |  53 ++++++
 fs/zuf/zuf-core.c |  69 ++++++++
 fs/zuf/zuf-root.c | 435 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/zuf/zuf.h      | 115 ++++++++++++
 fs/zuf/zus_api.h  |  36 ++++
 8 files changed, 816 insertions(+)
 create mode 100644 fs/zuf/_extern.h
 create mode 100644 fs/zuf/_pr.h
 create mode 100644 fs/zuf/super.c
 create mode 100644 fs/zuf/zuf-core.c
 create mode 100644 fs/zuf/zuf-root.c
 create mode 100644 fs/zuf/zuf.h

diff --git a/fs/zuf/Makefile b/fs/zuf/Makefile
index 452cec55f34d..b08c08e73faa 100644
--- a/fs/zuf/Makefile
+++ b/fs/zuf/Makefile
@@ -10,5 +10,9 @@
 
 obj-$(CONFIG_ZUFS_FS) += zuf.o
 
+# ZUF core
+zuf-y += zuf-core.o zuf-root.o
+
 # Main FS
+zuf-y += super.o
 zuf-y += module.o
diff --git a/fs/zuf/_extern.h b/fs/zuf/_extern.h
new file mode 100644
index 000000000000..0e8aa52f1259
--- /dev/null
+++ b/fs/zuf/_extern.h
@@ -0,0 +1,41 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2018 NetApp Inc. All rights reserved.
+ *
+ * ZUFS-License: GPL-2.0. See module.c for LICENSE details.
+ *
+ * Authors:
+ *	Boaz Harrosh <boazh@netapp.com>
+ *	Sagi Manole <sagim@netapp.com>"
+ */
+
+#ifndef __ZUF_EXTERN_H__
+#define __ZUF_EXTERN_H__
+/*
+ * DO NOT INCLUDE this file directly, it is included by zuf.h
+ * It is here because zuf.h got to big
+ */
+
+/*
+ * extern functions declarations
+ */
+
+/* zuf-core.c */
+int zufc_zts_init(struct zuf_root_info *zri); /* Some private types in core */
+void zufc_zts_fini(struct zuf_root_info *zri);
+
+long zufc_ioctl(struct file *filp, unsigned int cmd, ulong arg);
+int zufc_release(struct inode *inode, struct file *file);
+int zufc_mmap(struct file *file, struct vm_area_struct *vma);
+
+/* zuf-root.c */
+int zufr_register_fs(struct super_block *sb, struct zufs_ioc_register_fs *rfs);
+
+/* super.c */
+int zuf_init_inodecache(void);
+void zuf_destroy_inodecache(void);
+
+struct dentry *zuf_mount(struct file_system_type *fs_type, int flags,
+			 const char *dev_name, void *data);
+
+#endif	/*ndef __ZUF_EXTERN_H__*/
diff --git a/fs/zuf/_pr.h b/fs/zuf/_pr.h
new file mode 100644
index 000000000000..51924b6bd2a5
--- /dev/null
+++ b/fs/zuf/_pr.h
@@ -0,0 +1,63 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2018 NetApp Inc. All rights reserved.
+ *
+ * ZUFS-License: GPL-2.0. See module.c for LICENSE details.
+ *
+ * Authors:
+ *	Boaz Harrosh <boazh@netapp.com>
+ *	Sagi Manole <sagim@netapp.com>"
+ */
+
+#ifndef __ZUF_PR_H__
+#define __ZUF_PR_H__
+
+#ifdef pr_fmt
+#undef pr_fmt
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+#endif
+
+/*
+ * Debug code
+ */
+#define zuf_err(s, args ...)		pr_err("[%s:%d] " s, __func__, \
+							__LINE__, ## args)
+#define zuf_err_cnd(silent, s, args ...) \
+	do {if (!silent) \
+		pr_err("[%s:%d] " s, __func__, __LINE__, ## args); \
+	} while (0)
+#define zuf_warn(s, args ...)		pr_warn("[%s:%d] " s, __func__, \
+							__LINE__, ## args)
+#define zuf_warn_cnd(silent, s, args ...) \
+	do {if (!silent) \
+		pr_warn("[%s:%d] " s, __func__, __LINE__, ## args); \
+	} while (0)
+#define zuf_info(s, args ...)          pr_info("~info~ " s, ## args)
+
+#define zuf_chan_debug(c, s, args...)	pr_debug(c " [%s:%d] " s, __func__, \
+							__LINE__, ## args)
+
+/* ~~~ channel prints ~~~ */
+#define zuf_dbg_perf(s, args ...)	zuf_chan_debug("perfo", s, ##args)
+#define zuf_dbg_err(s, args ...)	zuf_chan_debug("error", s, ##args)
+#define zuf_dbg_vfs(s, args ...)	zuf_chan_debug("vfs  ", s, ##args)
+#define zuf_dbg_rw(s, args ...)		zuf_chan_debug("rw   ", s, ##args)
+#define zuf_dbg_t1(s, args ...)		zuf_chan_debug("t1   ", s, ##args)
+#define zuf_dbg_xattr(s, args ...)	zuf_chan_debug("xattr", s, ##args)
+#define zuf_dbg_acl(s, args ...)	zuf_chan_debug("acl  ", s, ##args)
+#define zuf_dbg_t2(s, args ...)		zuf_chan_debug("t2dbg", s, ##args)
+#define zuf_dbg_t2_rw(s, args ...)	zuf_chan_debug("t2grw", s, ##args)
+#define zuf_dbg_core(s, args ...)	zuf_chan_debug("core ", s, ##args)
+#define zuf_dbg_mmap(s, args ...)	zuf_chan_debug("mmap ", s, ##args)
+#define zuf_dbg_zus(s, args ...)	zuf_chan_debug("zusdg", s, ##args)
+#define zuf_dbg_verbose(s, args ...)	zuf_chan_debug("d-oto", s, ##args)
+
+#define md_err		zuf_err
+#define md_warn		zuf_warn
+#define md_err_cnd	zuf_err_cnd
+#define md_warn_cnd	zuf_warn_cnd
+#define md_dbg_err	zuf_dbg_err
+#define md_dbg_verbose	zuf_dbg_verbose
+
+
+#endif /* define __ZUF_PR_H__ */
diff --git a/fs/zuf/super.c b/fs/zuf/super.c
new file mode 100644
index 000000000000..f7f7798425a9
--- /dev/null
+++ b/fs/zuf/super.c
@@ -0,0 +1,53 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Super block operations.
+ *
+ * Copyright (c) 2018 NetApp Inc. All rights reserved.
+ *
+ * ZUFS-License: GPL-2.0. See module.c for LICENSE details.
+ *
+ * Authors:
+ *	Boaz Harrosh <boazh@netapp.com>
+ *	Sagi Manole <sagim@netapp.com>
+ */
+
+#include <linux/types.h>
+#include <linux/parser.h>
+#include <linux/statfs.h>
+#include <linux/backing-dev.h>
+
+#include "zuf.h"
+
+static struct kmem_cache *zuf_inode_cachep;
+
+static void _init_once(void *foo)
+{
+	struct zuf_inode_info *zii = foo;
+
+	inode_init_once(&zii->vfs_inode);
+}
+
+int __init zuf_init_inodecache(void)
+{
+	zuf_inode_cachep = kmem_cache_create("zuf_inode_cache",
+					       sizeof(struct zuf_inode_info),
+					       0,
+					       (SLAB_RECLAIM_ACCOUNT |
+						SLAB_MEM_SPREAD |
+						SLAB_TYPESAFE_BY_RCU),
+					       _init_once);
+	if (zuf_inode_cachep == NULL)
+		return -ENOMEM;
+	return 0;
+}
+
+void zuf_destroy_inodecache(void)
+{
+	kmem_cache_destroy(zuf_inode_cachep);
+}
+
+struct dentry *zuf_mount(struct file_system_type *fs_type, int flags,
+			 const char *dev_name, void *data)
+{
+	return ERR_PTR(-ENOTSUPP);
+}
diff --git a/fs/zuf/zuf-core.c b/fs/zuf/zuf-core.c
new file mode 100644
index 000000000000..c9bb31f75bed
--- /dev/null
+++ b/fs/zuf/zuf-core.c
@@ -0,0 +1,69 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * BRIEF DESCRIPTION
+ *
+ * Ioctl operations.
+ *
+ * Copyright (c) 2018 NetApp Inc. All rights reserved.
+ *
+ * ZUFS-License: GPL-2.0. See module.c for LICENSE details.
+ *
+ * Authors:
+ *	Boaz Harrosh <boazh@netapp.com>
+ */
+
+#include <linux/types.h>
+#include <linux/mm.h>
+#include <linux/mm_types.h>
+#include <linux/delay.h>
+#include <linux/pfn_t.h>
+#include <linux/sched/signal.h>
+
+#include "zuf.h"
+
+int zufc_zts_init(struct zuf_root_info *zri)
+{
+	return 0;
+}
+
+void zufc_zts_fini(struct zuf_root_info *zri)
+{
+}
+
+long zufc_ioctl(struct file *file, unsigned int cmd, ulong arg)
+{
+	switch (cmd) {
+	default:
+		zuf_err("%d\n", cmd);
+		return -ENOTTY;
+	}
+}
+
+int zufc_release(struct inode *inode, struct file *file)
+{
+	struct zuf_special_file *zsf = file->private_data;
+
+	if (!zsf)
+		return 0;
+
+	switch (zsf->type) {
+	default:
+		return 0;
+	}
+}
+
+int zufc_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	struct zuf_special_file *zsf = file->private_data;
+
+	if (unlikely(!zsf)) {
+		zuf_err("Which mmap is that !!!!\n");
+		return -ENOTTY;
+	}
+
+	switch (zsf->type) {
+	default:
+		zuf_err("type=%d\n", zsf->type);
+		return -ENOTTY;
+	}
+}
diff --git a/fs/zuf/zuf-root.c b/fs/zuf/zuf-root.c
new file mode 100644
index 000000000000..1f5f886997f7
--- /dev/null
+++ b/fs/zuf/zuf-root.c
@@ -0,0 +1,435 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * ZUF Root filesystem.
+ *
+ * Copyright (c) 2018 NetApp Inc. All rights reserved.
+ *
+ * ZUS-ZUF interaction is done via a small specialized FS that
+ * provides the communication with the mount-thread, ZTs, pmem devices,
+ * and so on ...
+ * Subsequently all FS super_blocks are children of this root, and point
+ * to it. All sharing the same zuf communication channels.
+ *
+ * Authors:
+ *	Boaz Harrosh <boazh@netapp.com>
+ */
+
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/module.h>
+#include <linux/fs.h>
+#include <linux/magic.h>
+#include <asm-generic/mman.h>
+
+#include "zuf.h"
+
+/* ~~~~ Register/Unregister FS-types ~~~~ */
+#ifdef CONFIG_LOCKDEP
+
+/*
+ * NOTE: When CONFIG_LOCKDEP is on. register_filesystem() complains when
+ * the fstype object is from a kmalloc. Because of some lockdep_keys not
+ * being const_obj something.
+ *
+ * So in this case we have maximum of 16 fstypes system wide
+ * (Total for all mounted zuf_root(s)). This way we can have them
+ * in const_obj memory below at g_fs_array
+ */
+
+enum { MAX_LOCKDEP_FSs = 16 };
+static uint g_fs_next;
+static struct zuf_fs_type g_fs_array[MAX_LOCKDEP_FSs];
+
+static struct zuf_fs_type *_fs_type_alloc(void)
+{
+	struct zuf_fs_type *ret;
+
+	if (MAX_LOCKDEP_FSs <= g_fs_next)
+		return NULL;
+
+	ret = &g_fs_array[g_fs_next++];
+	memset(ret, 0, sizeof(*ret));
+	return ret;
+}
+
+static void _fs_type_free(struct zuf_fs_type *zft)
+{
+	if (zft == &g_fs_array[0])
+		g_fs_next = 0;
+}
+
+#else /* !CONFIG_LOCKDEP*/
+static struct zuf_fs_type *_fs_type_alloc(void)
+{
+	return kcalloc(1, sizeof(struct zuf_fs_type), GFP_KERNEL);
+}
+
+static void _fs_type_free(struct zuf_fs_type *zft)
+{
+	kfree(zft);
+}
+#endif /*CONFIG_LOCKDEP*/
+
+
+static ssize_t _state_read(struct file *file, char __user *buf, size_t len,
+			   loff_t *ppos)
+{
+	struct zuf_root_info *zri = ZRI(file->f_inode->i_sb);
+	const char *msg;
+
+	if (*ppos > 0)
+		return 0;
+
+	switch (zri->state) {
+	case ZUF_ROOT_INITIALIZING:
+		msg = "initializing\n";
+		break;
+	case ZUF_ROOT_REGISTERING_FS:
+		msg = "registering_fs\n";
+		break;
+	case ZUF_ROOT_MOUNT_READY:
+		msg = "mount_ready\n";
+		break;
+	default:
+		msg = "UNKNOWN\n";
+		break;
+	}
+
+	return simple_read_from_buffer(buf, len, ppos, msg, strlen(msg));
+}
+
+static const struct file_operations _state_ops = {
+	.open = nonseekable_open,
+	.read = _state_read,
+	.llseek = no_llseek,
+};
+
+static ssize_t _registered_fs_read(struct file *file, char __user *buf,
+				   size_t len, loff_t *ppos)
+{
+	struct zuf_root_info *zri = ZRI(file->f_inode->i_sb);
+	size_t buff_len = 0;
+	struct zuf_fs_type *zft;
+	char *fs_buff, *p;
+	ssize_t ret;
+	size_t name_len;
+
+	list_for_each_entry(zft, &zri->fst_list, list)
+		buff_len += strlen(zft->rfi.fsname) + 1;
+
+	if (unlikely(*ppos > buff_len))
+		return -EINVAL;
+	if (*ppos == buff_len)
+		return 0;
+
+	fs_buff = kzalloc(buff_len + 1, GFP_KERNEL);
+	if (unlikely(!fs_buff))
+		return -ENOMEM;
+
+	p = fs_buff;
+	list_for_each_entry(zft, &zri->fst_list, list) {
+		if (p != fs_buff) {
+			*p = ' ';
+			++p;
+		}
+		name_len = strlen(zft->rfi.fsname);
+		memcpy(p, zft->rfi.fsname, name_len);
+		p += name_len;
+	}
+
+	p = fs_buff + *ppos;
+	buff_len = buff_len - *ppos;
+	ret = simple_read_from_buffer(buf, len, ppos, p, buff_len);
+	kfree(fs_buff);
+
+	return ret;
+}
+
+static const struct file_operations _registered_fs_ops = {
+	.open = nonseekable_open,
+	.read = _registered_fs_read,
+	.llseek = no_llseek,
+};
+
+
+int zufr_register_fs(struct super_block *sb, struct zufs_ioc_register_fs *rfs)
+{
+	struct zuf_fs_type *zft = _fs_type_alloc();
+	struct zuf_root_info *zri = ZRI(sb);
+
+	if (unlikely(!zft))
+		return -ENOMEM;
+
+	if (zri->state == ZUF_ROOT_INITIALIZING)
+		zri->state = ZUF_ROOT_REGISTERING_FS;
+
+	/* Original vfs file type */
+	zft->vfs_fst.owner	= THIS_MODULE;
+	zft->vfs_fst.name	= kstrdup(rfs->rfi.fsname, GFP_KERNEL);
+	zft->vfs_fst.mount	= zuf_mount;
+	zft->vfs_fst.kill_sb	= kill_block_super;
+
+	/* ZUS info about this FS */
+	zft->rfi		= rfs->rfi;
+	zft->zus_zfi		= rfs->zus_zfi;
+	INIT_LIST_HEAD(&zft->list);
+	/* Back pointer to our communication channels */
+	zft->zri		= ZRI(sb);
+
+	zuf_add_fs_type(zft->zri, zft);
+	zuf_info("register_filesystem [%s]\n", zft->vfs_fst.name);
+	return register_filesystem(&zft->vfs_fst);
+}
+
+static void _unregister_all_fses(struct zuf_root_info *zri)
+{
+	struct zuf_fs_type *zft, *n;
+
+	list_for_each_entry_safe_reverse(zft, n, &zri->fst_list, list) {
+		unregister_filesystem(&zft->vfs_fst);
+		list_del_init(&zft->list);
+		_fs_type_free(zft);
+	}
+}
+
+static int zufr_unlink(struct inode *dir, struct dentry *dentry)
+{
+	struct inode *inode = dentry->d_inode;
+
+	drop_nlink(inode);
+	return 0;
+}
+
+/* Force alignment of 2M for all vma(s)
+ *
+ * This belongs to t1.c and what it does for mmap. But we do not mind
+ * that both our mmaps (grab_pmem or ZTs) will be 2M aligned so keep
+ * it here. And zus mappings just all match perfectly with no need for
+ * holes.
+ * FIXME: This is copy/paste from dax-device. It can be very much simplified
+ * for what we need.
+ */
+static unsigned long zufr_get_unmapped_area(struct file *filp,
+		unsigned long addr, unsigned long len, unsigned long pgoff,
+		unsigned long flags)
+{
+	unsigned long off, off_end, off_align, len_align, addr_align;
+	unsigned long align = PMD_SIZE;
+
+	if (addr)
+		goto out;
+
+	off = pgoff << PAGE_SHIFT;
+	off_end = off + len;
+	off_align = round_up(off, align);
+
+	if ((off_end <= off_align) || ((off_end - off_align) < align))
+		goto out;
+
+	len_align = len + align;
+	if ((off + len_align) < off)
+		goto out;
+
+	addr_align = current->mm->get_unmapped_area(filp, addr, len_align,
+			pgoff, flags);
+	if (!IS_ERR_VALUE(addr_align)) {
+		addr_align += (off - addr_align) & (align - 1);
+		return addr_align;
+	}
+ out:
+	return current->mm->get_unmapped_area(filp, addr, len, pgoff, flags);
+}
+
+static const struct inode_operations zufr_inode_operations;
+static const struct file_operations zufr_file_dir_operations = {
+	.open		= dcache_dir_open,
+	.release	= dcache_dir_close,
+	.llseek		= dcache_dir_lseek,
+	.read		= generic_read_dir,
+	.iterate_shared	= dcache_readdir,
+	.fsync		= noop_fsync,
+	.unlocked_ioctl = zufc_ioctl,
+};
+static const struct file_operations zufr_file_reg_operations = {
+	.fsync			= noop_fsync,
+	.unlocked_ioctl		= zufc_ioctl,
+	.get_unmapped_area	= zufr_get_unmapped_area,
+	.mmap			= zufc_mmap,
+	.release		= zufc_release,
+};
+
+static int zufr_tmpfile(struct inode *dir, struct dentry *dentry, umode_t mode)
+{
+	struct zuf_root_info *zri = ZRI(dir->i_sb);
+	struct inode *inode;
+	int err;
+
+	inode = new_inode(dir->i_sb);
+	if (!inode)
+		return -ENOMEM;
+
+	/* We need to impersonate device-dax (S_DAX + S_IFCHR) in order to get
+	 * the PMD (huge) page faults and allow RDMA memory access via GUP
+	 * (get_user_pages_longterm).
+	 */
+	inode->i_flags = S_DAX;
+	mode = (mode & ~S_IFREG) | S_IFCHR; /* change file type to char */
+
+	inode->i_ino = ++zri->next_ino; /* none atomic only one mount thread */
+	inode->i_blocks = inode->i_size = 0;
+	inode->i_ctime = inode->i_mtime = current_time(inode);
+	inode->i_atime = inode->i_ctime;
+	inode_init_owner(inode, dir, mode);
+
+	inode->i_op = &zufr_inode_operations;
+	inode->i_fop = &zufr_file_reg_operations;
+
+	err = insert_inode_locked(inode);
+	if (unlikely(err)) {
+		zuf_err("[%ld] insert_inode_locked => %d\n", inode->i_ino, err);
+		goto fail;
+	}
+	d_tmpfile(dentry, inode);
+	unlock_new_inode(inode);
+	return 0;
+
+fail:
+	clear_nlink(inode);
+	make_bad_inode(inode);
+	iput(inode);
+	return err;
+}
+
+static void zufr_put_super(struct super_block *sb)
+{
+	struct zuf_root_info *zri = ZRI(sb);
+
+	zufc_zts_fini(zri);
+	_unregister_all_fses(zri);
+
+	zuf_info("zuf_root umount\n");
+}
+
+static void zufr_evict_inode(struct inode *inode)
+{
+	clear_inode(inode);
+}
+
+static const struct inode_operations zufr_inode_operations = {
+	.lookup		= simple_lookup,
+
+	.tmpfile	= zufr_tmpfile,
+	.unlink		= zufr_unlink,
+};
+static const struct super_operations zufr_super_operations = {
+	.statfs		= simple_statfs,
+
+	.evict_inode	= zufr_evict_inode,
+	.put_super	= zufr_put_super,
+};
+
+#define ZUFR_SUPER_MAGIC 0x1717
+
+static int zufr_fill_super(struct super_block *sb, void *data, int silent)
+{
+	static struct tree_descr zufr_files[] = {
+		[2] = {"state", &_state_ops, S_IFREG | 0400},
+		[3] = {"registered_fs", &_registered_fs_ops, S_IFREG | 0400},
+		{""},
+	};
+	struct zuf_root_info *zri;
+	struct inode *root_i;
+	int err;
+
+	zri = kzalloc(sizeof(*zri), GFP_KERNEL);
+	if (!zri) {
+		zuf_err_cnd(silent,
+			    "Not enough memory to allocate zuf_root_info\n");
+		return -ENOMEM;
+	}
+
+	err = simple_fill_super(sb, ZUFR_SUPER_MAGIC, zufr_files);
+	if (unlikely(err)) {
+		kfree(zri);
+		return err;
+	}
+
+	sb->s_op = &zufr_super_operations;
+	sb->s_fs_info = zri;
+	zri->sb = sb;
+
+	root_i = sb->s_root->d_inode;
+	root_i->i_fop = &zufr_file_dir_operations;
+	root_i->i_op = &zufr_inode_operations;
+
+	mutex_init(&zri->sbl_lock);
+	INIT_LIST_HEAD(&zri->fst_list);
+
+	err = zufc_zts_init(zri);
+	if (unlikely(err))
+		return err; /* put will be called we have a root */
+
+	return 0;
+}
+
+static struct dentry *zufr_mount(struct file_system_type *fs_type,
+				  int flags, const char *dev_name,
+				  void *data)
+{
+	struct dentry *ret = mount_nodev(fs_type, flags, data, zufr_fill_super);
+
+	if (IS_ERR_OR_NULL(ret)) {
+		zuf_dbg_err("mount_nodev(%s, %s) => %ld\n", dev_name,
+			    (char *)data, PTR_ERR(ret));
+		return ret;
+	}
+
+	zuf_info("zuf_root mount [%s]\n", dev_name);
+	return ret;
+}
+
+static struct file_system_type zufr_type = {
+	.owner =	THIS_MODULE,
+	.name =		"zuf",
+	.mount =	zufr_mount,
+	.kill_sb	= kill_litter_super,
+};
+
+/* Create an /sys/fs/zuf/ directory. to mount on */
+static struct kset *zufr_kset;
+
+int __init zuf_root_init(void)
+{
+	int err = zuf_init_inodecache();
+
+	if (unlikely(err))
+		return err;
+
+	zufr_kset = kset_create_and_add("zuf", NULL, fs_kobj);
+	if (!zufr_kset) {
+		err = -ENOMEM;
+		goto un_inodecache;
+	}
+
+	err = register_filesystem(&zufr_type);
+	if (unlikely(err))
+		goto un_kset;
+
+	return 0;
+
+un_kset:
+	kset_unregister(zufr_kset);
+un_inodecache:
+	zuf_destroy_inodecache();
+	return err;
+}
+
+static void __exit zuf_root_exit(void)
+{
+	unregister_filesystem(&zufr_type);
+	kset_unregister(zufr_kset);
+	zuf_destroy_inodecache();
+}
+
+module_init(zuf_root_init)
+module_exit(zuf_root_exit)
diff --git a/fs/zuf/zuf.h b/fs/zuf/zuf.h
new file mode 100644
index 000000000000..3062f78c72d4
--- /dev/null
+++ b/fs/zuf/zuf.h
@@ -0,0 +1,115 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * BRIEF DESCRIPTION
+ *
+ * Definitions for the ZUF filesystem.
+ *
+ * Copyright (c) 2018 NetApp Inc. All rights reserved.
+ *
+ * ZUFS-License: GPL-2.0. See module.c for LICENSE details.
+ *
+ * Authors:
+ *	Boaz Harrosh <boazh@netapp.com>
+ *	Sagi Manole <sagim@netapp.com>"
+ */
+
+#ifndef __ZUF_H
+#define __ZUF_H
+
+#include <linux/sched.h>
+#include <linux/fs.h>
+#include <linux/list.h>
+#include <linux/types.h>
+#include <linux/xattr.h>
+#include <linux/exportfs.h>
+#include <linux/page_ref.h>
+#include <linux/mm.h>
+
+#include "zus_api.h"
+
+#include "_pr.h"
+
+enum zlfs_e_special_file {
+	zlfs_e_zt = 1,
+	zlfs_e_mout_thread,
+	zlfs_e_pmem,
+	zlfs_e_dpp_buff,
+	zlfs_e_private_mount,
+};
+
+struct zuf_special_file {
+	enum zlfs_e_special_file type;
+	struct file *file;
+};
+
+struct zuf_private_mount_info {
+	struct zuf_special_file zsf;
+	struct super_block *sb;
+};
+
+enum {
+	ZUF_ROOT_INITIALIZING = 0,
+	ZUF_ROOT_REGISTERING_FS = 1,
+	ZUF_ROOT_MOUNT_READY = 2,
+};
+
+/* This is the zuf-root.c mini filesystem */
+struct zuf_root_info {
+	#define SBL_INC 64
+	struct sb_is_list {
+		uint num;
+		uint max;
+		struct super_block **array;
+	} sbl;
+	struct mutex sbl_lock;
+
+	ulong next_ino;
+
+	/* The definition of _ztp is private to zuf-core.c */
+	struct zuf_threads_pool *_ztp;
+
+	struct super_block *sb;
+	struct list_head fst_list;
+	int state;
+};
+
+static inline struct zuf_root_info *ZRI(struct super_block *sb)
+{
+	struct zuf_root_info *zri = sb->s_fs_info;
+
+	WARN_ON(zri->sb != sb);
+	return zri;
+}
+
+struct zuf_fs_type {
+	struct file_system_type vfs_fst;
+	struct zus_fs_info	*zus_zfi;
+	struct register_fs_info rfi;
+	struct zuf_root_info *zri;
+
+	struct list_head list;
+};
+
+static inline void zuf_add_fs_type(struct zuf_root_info *zri,
+				   struct zuf_fs_type *zft)
+{
+	/* Unlocked for now only one mount-thread with zus */
+	list_add(&zft->list, &zri->fst_list);
+}
+
+/*
+ * ZUF per-inode data in memory
+ */
+struct zuf_inode_info {
+	struct inode		vfs_inode;
+};
+
+static inline struct zuf_inode_info *ZUII(struct inode *inode)
+{
+	return container_of(inode, struct zuf_inode_info, vfs_inode);
+}
+
+/* Keep this include last thing in file */
+#include "_extern.h"
+
+#endif /* __ZUF_H */
diff --git a/fs/zuf/zus_api.h b/fs/zuf/zus_api.h
index 4b1816e5dfd8..181805052ec0 100644
--- a/fs/zuf/zus_api.h
+++ b/fs/zuf/zus_api.h
@@ -97,4 +97,40 @@
 
 #endif /*  ndef __KERNEL__ */
 
+struct zufs_ioc_hdr {
+	__s32 err;	/* IN/OUT must be first */
+	__u16 in_len;	/* How much to be copied *to* zus */
+	__u16 out_max;	/* Max receive buffer at dispatch caller */
+	__u16 out_start;/* Start of output parameters (to caller) */
+	__u16 out_len;	/* How much to be copied *from* zus to caller */
+			/* can be modified by zus */
+	__u16 operation;/* One of e_zufs_operation */
+	__u16 flags;	/* e_zufs_hdr_flags bit flags */
+	__u32 offset;	/* Start of user buffer in ZT mmap */
+	__u32 len;	/* Len of user buffer in ZT mmap */
+};
+
+struct register_fs_info {
+	char fsname[16];	/* Only 4 chars and a NUL please      */
+	__u32 FS_magic;         /* This is the FS's version && magic  */
+	__u32 FS_ver_major;	/* on disk, not the zuf-to-zus version*/
+	__u32 FS_ver_minor;	/* (See also struct md_dev_table)   */
+	__u32 notused;
+
+	__u64 dt_offset;
+	__u64 s_maxbytes;
+	__u32 s_time_gran;
+	__u32 def_mode;
+};
+
+/* Register FS */
+/* A cookie from user-mode given in register_fs_info */
+struct zus_fs_info;
+struct zufs_ioc_register_fs {
+	struct zufs_ioc_hdr hdr;
+	struct zus_fs_info *zus_zfi;
+	struct register_fs_info rfi;
+};
+#define ZU_IOC_REGISTER_FS	_IOWR('Z', 10, struct zufs_ioc_register_fs)
+
 #endif /* _LINUX_ZUFS_API_H */
-- 
2.20.1

