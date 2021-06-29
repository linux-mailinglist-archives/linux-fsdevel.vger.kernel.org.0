Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 081FF3B7491
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jun 2021 16:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234481AbhF2Oqn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Jun 2021 10:46:43 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:39225 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234315AbhF2Oql (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Jun 2021 10:46:41 -0400
Received: from orion.localdomain ([95.114.16.105]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MXGzQ-1ljQKd3L9K-00YkZa; Tue, 29 Jun 2021 16:44:01 +0200
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     viro@zeniv.linux.org.uk, info@metux.net, keescook@chromium.org,
        anton@enomsg.org, ccross@android.com, tony.luck@intel.com,
        linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH 2/2] fs: srvfs: new pseudo-fs for publishing opened fd's in the filesystem
Date:   Tue, 29 Jun 2021 16:43:41 +0200
Message-Id: <20210629144341.14313-3-info@metux.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210629144341.14313-1-info@metux.net>
References: <20210629144341.14313-1-info@metux.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:WbMEo5tidgVQRH4J+/76wzK+iKUUMzA8yypyIPDBH3YpQjXfNlq
 b6/l86PnhXJghnbxPWvCS9CWfjrrZC+9+jcN8eMcP9wMBOTyLA6NaRCC2M5QqRaNbMCSjxJ
 Z3iRltGHNzdIsybQQfaJLepwUo9T6/aPfZl7EM+MqaA8mPXMUaFOlQ55vQvxWyFZ1t0EWO0
 sbm/ROWmSfAqvrs/92XSA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:eSX4puk+m5g=:6dq/KR9rmqjnyurMNYaGTE
 whMFKBQectERK2/2qGgqHIf+LeGMmRjBtZa4TB9FpIwaJLPXQQjmHbuccuJuZmXoWrafuysru
 fMxZvtGibksRJWw2zgDyBbDA6P+Cuuq4nuAkZlqUIVaNgAmNmGewWcg4MljCN5oMheDAODKv/
 Mhfb7dHkKmgv3t9vOVHB7KQrWDEwAeChcBG+pDEabH8Eqf6nY++1WaBgBf7LX/QyEcc/OjtTC
 6omvoMPsBp5urZy/8bTO6S0wIUhBuAS7S5uCy7ZrlpIx3PYJZ0OjC/SYUakfQ48+zLthL5DZ5
 +jTEdXgwMr35cumW3ifBq7WDG0bV82c7p1qPYn7thLZVXr5vg+L42pCYn5XFWGExp+1V+3h8R
 Jpoc3aOKAs3nK60SWVTAoMSIL+1OPEjEJgnrbKZXG23UWFZMFPhLnbHQygj7WUSjOrC5A3lTM
 3CtfEhrn4Y+0oGuVOGgiR4eSVx0L2cxkOT+Zxi0bcgVx9Qu/GyDBDvcc9hzO4fQthCsn/KzkZ
 7uvEPhWAVYA6/XcfS7+BTk=
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is an implementation of Plan9's /srv filesystem, which offers storing
already opened file descriptors into the fs: a process can store a open fd
by just creating an empty file and writing its fdnum into it. The associated
file struct will then be stored and next time that file is opened, the caller
gets back exactly that opened file, quite like it was dup()ed or passed via
some unix socket.

The rationale behind this: programs can prepare file descriptors (e.g. dial
network connections, set up devices, etc) and leave them for other programs
to pick up. This also works when opening or preparing the file needs special
privileges that the consumer does not have.

Another interesting use case is long running servers that want to temporarily
store their open files for a restart (possibly starting even restarting with
a different binary, e.g. after upgrade).

The semantics of this file system are quite simple:

* creating files produces empty entries that can be assigned to an active
  file descriptor (struct file) by writing the numerical fd value into it.
  (the corresponding file will be looked up in the writing process' fdtable)
* before that, no other operations (except unlink) are supported
* once an entry is assigned with file descriptor, subsequent open() calls
  will retrieve exactly the assigned file descriptor (but most likely some
  other numerical fd value) - additional O_* flags have no effect on that
  file descriptor
* the underlying file remains open, until references, including the srvfs
  entry are removed.
* the srvfs entry can be removed via unlink()
* multiple mounts of the file system are separated, they do not share entries
---
 MAINTAINERS        |   5 ++
 fs/Kconfig         |   1 +
 fs/Makefile        |   1 +
 fs/srvfs/Kconfig   |   9 ++++
 fs/srvfs/Makefile  |   7 +++
 fs/srvfs/file.c    | 115 ++++++++++++++++++++++++++++++++++++++++++
 fs/srvfs/fileref.c |  50 ++++++++++++++++++
 fs/srvfs/root.c    |  30 +++++++++++
 fs/srvfs/srvfs.h   |  39 ++++++++++++++
 fs/srvfs/super.c   | 123 +++++++++++++++++++++++++++++++++++++++++++++
 10 files changed, 380 insertions(+)
 create mode 100644 fs/srvfs/Kconfig
 create mode 100644 fs/srvfs/Makefile
 create mode 100644 fs/srvfs/file.c
 create mode 100644 fs/srvfs/fileref.c
 create mode 100644 fs/srvfs/root.c
 create mode 100644 fs/srvfs/srvfs.h
 create mode 100644 fs/srvfs/super.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 8ae6ea3b99fc..d563f989b742 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -239,6 +239,11 @@ F:	include/trace/events/9p.h
 F:	include/uapi/linux/virtio_9p.h
 F:	net/9p/
 
+SRV FILE SYSTEM:
+M:	Enrico Weigelt, metux IT consult <info@metux.net>
+S:	Maintained
+F:	fs/srvfs
+
 A8293 MEDIA DRIVER
 M:	Antti Palosaari <crope@iki.fi>
 L:	linux-media@vger.kernel.org
diff --git a/fs/Kconfig b/fs/Kconfig
index b8b7a77b656c..319da752d888 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -248,6 +248,7 @@ config ARCH_HAS_GIGANTIC_PAGE
 
 source "fs/configfs/Kconfig"
 source "fs/efivarfs/Kconfig"
+source "fs/srvfs/Kconfig"
 
 endmenu
 
diff --git a/fs/Makefile b/fs/Makefile
index 9c708e1fbe8f..bfc783c120dc 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -136,3 +136,4 @@ obj-$(CONFIG_EFIVAR_FS)		+= efivarfs/
 obj-$(CONFIG_EROFS_FS)		+= erofs/
 obj-$(CONFIG_VBOXSF_FS)		+= vboxsf/
 obj-$(CONFIG_ZONEFS_FS)		+= zonefs/
+obj-$(CONFIG_SRV_FS)		+= srvfs/
diff --git a/fs/srvfs/Kconfig b/fs/srvfs/Kconfig
new file mode 100644
index 000000000000..c399215cbbee
--- /dev/null
+++ b/fs/srvfs/Kconfig
@@ -0,0 +1,9 @@
+config SRV_FS
+	tristate "Plan9-like /srv filesystem"
+	select FS_BOXED_FILE
+	help
+	  If you don't know what this is about, say N.
+
+	  To compile this as a module, choose M here: the module will be called
+	  srv-fs.  Note that the file system of your root partition (the one
+	  containing the directory /) cannot be compiled as a module.
diff --git a/fs/srvfs/Makefile b/fs/srvfs/Makefile
new file mode 100644
index 000000000000..d5e0520efe6c
--- /dev/null
+++ b/fs/srvfs/Makefile
@@ -0,0 +1,7 @@
+obj-$(CONFIG_SRV_FS) := srvfs.o
+
+srvfs-objs := \
+	file.o \
+	super.o \
+	root.o \
+	fileref.o
diff --git a/fs/srvfs/file.c b/fs/srvfs/file.c
new file mode 100644
index 000000000000..f8de9f84c085
--- /dev/null
+++ b/fs/srvfs/file.c
@@ -0,0 +1,115 @@
+
+#include "srvfs.h"
+
+#include <asm/atomic.h>
+#include <linux/file.h>
+#include <linux/fs.h>
+#include <linux/kernel.h>
+#include <linux/slab.h>
+
+static int srvfs_file_open(struct inode *inode, struct file *file)
+{
+	struct srvfs_fileref *fileref = inode->i_private;
+	file->private_data = srvfs_fileref_get(fileref);
+
+	if (fileref->file) {
+		get_file_rcu(fileref->file);
+		file->boxed_file = fileref->file;
+	}
+
+	return 0;
+}
+
+static int srvfs_file_release(struct inode *inode, struct file *file)
+{
+	struct srvfs_fileref *fileref = file->private_data;
+	srvfs_fileref_put(fileref);
+	return 0;
+}
+
+static int do_switch(struct file *file, long fd)
+{
+	struct srvfs_fileref *fileref= file->private_data;
+	struct file *newfile = fget(fd);
+
+	if (!newfile)
+		goto setref;
+
+	if (newfile->f_inode == file->f_inode)
+		goto loop;
+
+	if (newfile->f_inode->i_sb == file->f_inode->i_sb)
+		goto loop;
+
+setref:
+	srvfs_fileref_set(fileref, newfile);
+	return 0;
+
+loop:
+	fput(newfile);
+	return -ELOOP;
+}
+
+static ssize_t srvfs_file_write(struct file *file, const char *buf,
+				size_t count, loff_t *offset)
+{
+	char tmp[20];
+	long fd;
+	int ret;
+
+	if ((*offset != 0) || (count >= sizeof(tmp)))
+		return -EINVAL;
+
+	memset(tmp, 0, sizeof(tmp));
+	if (copy_from_user(tmp, buf, count))
+		return -EFAULT;
+
+	fd = simple_strtol(tmp, NULL, 10);
+	ret = do_switch(file, fd);
+
+	if (ret)
+		return ret;
+
+	return count;
+}
+
+struct file_operations srvfs_file_ops = {
+	.owner		= THIS_MODULE,
+	.open		= srvfs_file_open,
+	.write		= srvfs_file_write,
+	.release	= srvfs_file_release,
+};
+
+int srvfs_insert_file(struct super_block *sb, struct dentry *dentry)
+{
+	struct inode *inode;
+	struct srvfs_fileref *fileref;
+	int mode = S_IFREG | S_IWUSR | S_IRUGO;
+
+	fileref = srvfs_fileref_new();
+	if (!fileref)
+		goto nomem;
+
+	inode = new_inode(sb);
+	if (!inode)
+		goto err_inode;
+
+	atomic_set(&fileref->counter, 0);
+
+	inode_init_owner(&init_user_ns, inode, sb->s_root->d_inode, mode);
+
+	inode->i_atime = inode->i_mtime = inode->i_ctime = current_time(inode);
+	inode->i_fop = &srvfs_file_ops;
+	inode->i_ino = srvfs_inode_id(inode->i_sb);
+	inode->i_private = fileref;
+
+	d_drop(dentry);
+	d_add(dentry, inode);
+	return 0;
+
+err_inode:
+	srvfs_fileref_put(fileref);
+
+nomem:
+	return -ENOMEM;
+}
diff --git a/fs/srvfs/fileref.c b/fs/srvfs/fileref.c
new file mode 100644
index 000000000000..cbe523927fb8
--- /dev/null
+++ b/fs/srvfs/fileref.c
@@ -0,0 +1,50 @@
+
+#include "srvfs.h"
+
+#include <linux/file.h>
+#include <linux/slab.h>
+
+struct srvfs_fileref *srvfs_fileref_new(void)
+{
+	struct srvfs_fileref *fileref;
+
+	fileref = kzalloc(sizeof(struct srvfs_fileref), GFP_KERNEL);
+	if (!fileref)
+		return NULL;
+
+	kref_init(&fileref->refcount);
+	return fileref;
+}
+
+struct srvfs_fileref *srvfs_fileref_get(struct srvfs_fileref *fileref)
+{
+	kref_get(&fileref->refcount);
+	return fileref;
+}
+
+void srvfs_fileref_destroy(struct kref *ref)
+{
+	struct srvfs_fileref *fileref =
+	    container_of(ref, struct srvfs_fileref, refcount);
+	if (fileref->file)
+		fput(fileref->file);
+	kfree(fileref);
+}
+
+void srvfs_fileref_put(struct srvfs_fileref *fileref)
+{
+	if (!fileref)
+		return;
+	kref_put(&fileref->refcount, srvfs_fileref_destroy);
+}
+
+void srvfs_fileref_set(struct srvfs_fileref *fileref, struct file *newfile)
+{
+	struct file *oldfile;
+
+	oldfile = fileref->file;
+	fileref->file = newfile;
+
+	if (oldfile)
+		fput(oldfile);
+}
diff --git a/fs/srvfs/root.c b/fs/srvfs/root.c
new file mode 100644
index 000000000000..b7be89b535a3
--- /dev/null
+++ b/fs/srvfs/root.c
@@ -0,0 +1,30 @@
+
+#include "srvfs.h"
+
+#include <linux/fs.h>
+
+static int srvfs_dir_unlink(struct inode *inode, struct dentry *dentry)
+{
+	struct srvfs_fileref *fileref = dentry->d_inode->i_private;
+
+	if (fileref == NULL)
+		return -EFAULT;
+
+	d_delete(dentry);
+	dput(dentry);
+
+	return 0;
+}
+
+static int srvfs_dir_create(struct user_namespace *mnt_userns,
+			    struct inode *inode, struct dentry *dentry,
+			    umode_t mode, bool excl)
+{
+	return srvfs_insert_file(inode->i_sb, dget(dentry));
+}
+
+const struct inode_operations srvfs_rootdir_inode_operations = {
+	.lookup		= simple_lookup,
+	.unlink		= srvfs_dir_unlink,
+	.create		= srvfs_dir_create,
+};
diff --git a/fs/srvfs/srvfs.h b/fs/srvfs/srvfs.h
new file mode 100644
index 000000000000..688933f12444
--- /dev/null
+++ b/fs/srvfs/srvfs.h
@@ -0,0 +1,39 @@
+#ifndef __LINUX_FS_SRVFS_H
+#define __LINUX_FS_SRVFS_H
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <asm/atomic.h>
+#include <linux/fs.h>
+#include <linux/kref.h>
+
+#define SRVFS_MAGIC 0x29980123
+
+struct srvfs_fileref {
+	atomic_t counter;
+	int mode;
+	struct file *file;
+	struct kref refcount;
+	struct file_operations f_ops;
+};
+
+struct srvfs_sb {
+	atomic_t inode_counter;
+};
+
+/* root.c */
+extern const struct inode_operations srvfs_rootdir_inode_operations;
+
+/* fileref.c */
+struct srvfs_fileref *srvfs_fileref_new(void);
+struct srvfs_fileref *srvfs_fileref_get(struct srvfs_fileref* fileref);
+void srvfs_fileref_put(struct srvfs_fileref* fileref);
+void srvfs_fileref_set(struct srvfs_fileref* fileref, struct file* newfile);
+
+/* super.c */
+int srvfs_inode_id (struct super_block *sb);
+
+/* file.c */
+int srvfs_insert_file (struct super_block *sb, struct dentry *dentry);
+
+#endif /* __LINUX_FS_SRVFS_H */
diff --git a/fs/srvfs/super.c b/fs/srvfs/super.c
new file mode 100644
index 000000000000..bcb55f85cb51
--- /dev/null
+++ b/fs/srvfs/super.c
@@ -0,0 +1,123 @@
+
+#include "srvfs.h"
+
+#include <asm/atomic.h>
+#include <linux/file.h>
+#include <linux/fs.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+
+static void srvfs_sb_evict_inode(struct inode *inode)
+{
+	struct srvfs_fileref *fileref = inode->i_private;
+
+	pr_info("srvfs_evict_inode(): %ld\n", inode->i_ino);
+	clear_inode(inode);
+	if (fileref)
+		srvfs_fileref_put(fileref);
+	else
+		pr_info("evicting root/dir inode\n");
+}
+
+static void srvfs_sb_put_super(struct super_block *sb)
+{
+	pr_info("srvfs: freeing superblock");
+	if (sb->s_fs_info) {
+		kfree(sb->s_fs_info);
+		sb->s_fs_info = NULL;
+	}
+}
+
+static const struct super_operations srvfs_super_operations = {
+	.statfs		= simple_statfs,
+	.evict_inode	= srvfs_sb_evict_inode,
+	.put_super	= srvfs_sb_put_super,
+};
+
+int srvfs_inode_id (struct super_block *sb)
+{
+	struct srvfs_sb *priv = sb->s_fs_info;
+	return atomic_inc_return(&priv->inode_counter);
+}
+
+static int srvfs_fill_super (struct super_block *sb, void *data, int silent)
+{
+	struct inode *inode;
+	struct dentry *root;
+	struct srvfs_sb* sbpriv;
+
+	sbpriv = kmalloc(sizeof(struct srvfs_sb), GFP_KERNEL);
+	if (sbpriv == NULL)
+		goto err_sbpriv;
+
+	atomic_set(&sbpriv->inode_counter, 1);
+
+	sb->s_blocksize = PAGE_SIZE;
+	sb->s_blocksize_bits = PAGE_SHIFT;
+	sb->s_magic = SRVFS_MAGIC;
+	sb->s_op = &srvfs_super_operations;
+	sb->s_time_gran = 1;
+	sb->s_fs_info = sbpriv;
+
+	inode = new_inode(sb);
+	if (!inode)
+		goto err_inode;
+
+	/*
+	 * because the root inode is 1, the files array must not contain an
+	 * entry at index 1
+	 */
+	inode->i_ino = srvfs_inode_id(sb);
+	inode->i_mode = S_IFDIR | 0755;
+	inode->i_atime = inode->i_mtime = inode->i_ctime = current_time(inode);
+	inode->i_op = &srvfs_rootdir_inode_operations;
+	inode->i_fop = &simple_dir_operations;
+	set_nlink(inode, 2);
+	root = d_make_root(inode);
+	if (!root)
+		goto err_root;
+
+	sb->s_root = root;
+
+	return 0;
+
+err_root:
+	iput(inode);
+
+err_inode:
+	kfree(sbpriv);
+
+err_sbpriv:
+	return -ENOMEM;
+}
+
+struct dentry *srvfs_mount(struct file_system_type *fs_type,
+			   int flags, const char *dev_name, void *data)
+{
+	return mount_nodev(fs_type, flags, data, srvfs_fill_super);
+}
+
+static struct file_system_type srvfs_type = {
+	.owner		= THIS_MODULE,
+	.name		= "srvfs",
+	.mount		= srvfs_mount,
+	.kill_sb	= kill_litter_super,
+};
+
+static int __init srvfs_init(void)
+{
+	return register_filesystem(&srvfs_type);
+}
+
+static void __exit srvfs_exit(void)
+{
+	unregister_filesystem(&srvfs_type);
+}
+
+module_init(srvfs_init);
+module_exit(srvfs_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Enrico Weigelt, metux IT consult <info@metux.net>");
-- 
2.20.1

