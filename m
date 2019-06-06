Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7832937202
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jun 2019 12:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbfFFKq2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jun 2019 06:46:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34962 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725784AbfFFKq1 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jun 2019 06:46:27 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BB806B2DD1;
        Thu,  6 Jun 2019 10:46:26 +0000 (UTC)
Received: from shalem.localdomain.com (ovpn-116-158.ams2.redhat.com [10.36.116.158])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 51CFC4DC47;
        Thu,  6 Jun 2019 10:46:23 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-fsdevel@vger.kernel.org
Subject: [PATCH v11] fs: Add VirtualBox guest shared folder (vboxsf) support
Date:   Thu,  6 Jun 2019 12:46:18 +0200
Message-Id: <20190606104618.28321-2-hdegoede@redhat.com>
In-Reply-To: <20190606104618.28321-1-hdegoede@redhat.com>
References: <20190606104618.28321-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Thu, 06 Jun 2019 10:46:26 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

VirtualBox hosts can share folders with guests, this commit adds a
VFS driver implementing the Linux-guest side of this, allowing folders
exported by the host to be mounted under Linux.

This driver depends on the guest <-> host IPC functions exported by
the vboxguest driver.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v11:
-Convert to the new Documentation/filesystems/mount_api.txt mount API
-Fixed all the function kerneldoc comments to have things in the proper order
-Change type of d_type variable passed as type to dir_emit from int to
 unsigned int
-Replaced the fake-ino overflow test with the one suggested by David Howells
-Fixed various coding style issues

Changes in v10:
-Code-style fixes and remove some unneeded checks as suggested by Al Viro
-Stop handle reuse between sf_create_aux and sf_reg_open, the code for this
 was racy and the re-use meant the O_APPEND was not passed to the host for
 newly created files with O_APPEND set
-Use idr to generate unique inode number, modelled after the kernfs code
-Only read and write the contents of the passed in offset pointer once in
 sf_reg_write
-Keep a list of refcounted open handles in the inode, so that writepage can
 get a writeable handle this way. This replaces the old very racy code which
 was just storing a pointer to the last opened struct file inside the inode.
 This is modelled after how the cifs and fuse code do this

Changes in v9:
-Change license from GPL-2.0 or CDDL-1.0 to MIT, following upstream's
 license change from: https://www.virtualbox.org/changeset/72627/vbox
 I've gotten permission by email from VirtualBox upstream to retro-actively
 apply the license-change to my "fork" of the vboxsf code
-Fix not being able to mount any shared-folders when built with gcc9
-Adjust for recent vboxguest changes
-Fix potential buffer overrun in vboxsf_nlscpy
-Fix build errors in some configs, caught by buildbot
-Fix 3 sparse warnings
-Some changes from upstream VirtualBox svn:
 -Use 0x786f4256 /* 'VBox' little endian */ as super-magic matching upstream
 -Implement AT_STATX_SYNC_TYPE support
 -Properly return -EPERM when symlink creation is not supported

Changes in v8:
-Fix broken error-handling / oops when the vboxsf_map_folder() call fails
-Fix umount using umount.nfs to umount vboxsf mounts
-Prefixed the modules init and exit function names with vboxsf_
-Delay connecting to the vbox hypervisor until the first mount, this fixes
 vboxsf not working when it is builtin (in which case it may be initialized
 before the vboxguest driver has bound to the guest communication PCI device)
-Fix sf_write_end return value, return the number of bytes written or 0 on error:
 https://github.com/jwrdegoede/vboxsf/issues/2
-Use an ida id in the name passed to super_setup_bdi_name so that the same
 shared-folder can be mounted twice without causing a
 "sysfs: cannot create duplicate filename" error
 https://github.com/jwrdegoede/vboxsf/issues/3

Changes in v7:
-Do not propagate sgid / suid bits between guest-host, note hosts with
 VirtualBox version 5.2.6 or newer will filter these out regardless of what
 we do
-Better error messages when we cannot connect to the VirtualBox guest PCI
 device, which may e.g. happen when trying to use vboxsf outside a vbox vm

Changes in v6:
-Address: https://www.virtualbox.org/ticket/819 which really is multiple bugs:
 1) Fix MAP_SHARED not being supported
 2) Fix changes done through regular read/write on the guest side not being
    seen by guest apps using mmap() access
 3) Fix any changes done on the host side not being seen by guest apps using
    mmap() access

Changes in v5:
-Honor CONFIG_NLS_DEFAULT (reported-by michael.thayer@oracle.com)

Changes in v4:
-Drop "name=..." mount option, instead use the dev_name argument to the
 mount syscall, to keep compatibility with existing fstab entries
-Fix "nls=%" match_table_t entry to "nls=%s"

Changes in v3:
-Use text only mount options, instead of a custom data struct
-Stop caching full path in inode data, if parents gets renamed it will change
-Fixed negative dentries handling
-Dropped the force_reread flag for dirs, not sure what it was actually for
 but it is no good, doing a re-read on unlink of a file will lead to
 another file being skipped if the caller has already iterated over the
 entry for the unlinked file.
-Use file_inode(), file_dentry() and d_inode() helpers
-Prefix any non object-private symbols with vboxsf_ so as to not pollute
 the global namespace when builtin
-Add MAINTAINERS entry
-Misc. cleanups

Changes in v2:
-Removed various unused wrapper functions
-Don't use i_private, instead defined alloc_inode and destroy_inode
 methods and use container_of.
-Drop obsolete comment referencing people to
 http://www.atnf.csiro.au/people/rgooch/linux/vfs.txt
-move the single symlink op of from lnkops.c to file.c
-Use SPDX license headers
-Replace SHFLROOT / SHFLHANDLE defines with normal types
-Removed unnecessary S_ISREG checks
-Got rid of bounce_buffer in regops, instead add a "user" flag to
 vboxsf_read / vboxsf_write, re-using the existing __user address support
 in the vboxguest module
-Make vboxsf_wrappers return regular linux errno values
-Use i_size_write to update size on writing
-Convert doxygen style comments to kerneldoc style comments
---
 MAINTAINERS                 |   6 +
 fs/Kconfig                  |   1 +
 fs/Makefile                 |   1 +
 fs/vboxsf/Kconfig           |  10 +
 fs/vboxsf/Makefile          |   3 +
 fs/vboxsf/dir.c             | 562 ++++++++++++++++++++++
 fs/vboxsf/file.c            | 452 ++++++++++++++++++
 fs/vboxsf/shfl_hostintf.h   | 901 ++++++++++++++++++++++++++++++++++++
 fs/vboxsf/super.c           | 482 +++++++++++++++++++
 fs/vboxsf/utils.c           | 568 +++++++++++++++++++++++
 fs/vboxsf/vboxsf_wrappers.c | 379 +++++++++++++++
 fs/vboxsf/vfsmod.h          | 138 ++++++
 12 files changed, 3503 insertions(+)
 create mode 100644 fs/vboxsf/Kconfig
 create mode 100644 fs/vboxsf/Makefile
 create mode 100644 fs/vboxsf/dir.c
 create mode 100644 fs/vboxsf/file.c
 create mode 100644 fs/vboxsf/shfl_hostintf.h
 create mode 100644 fs/vboxsf/super.c
 create mode 100644 fs/vboxsf/utils.c
 create mode 100644 fs/vboxsf/vboxsf_wrappers.c
 create mode 100644 fs/vboxsf/vfsmod.h

diff --git a/MAINTAINERS b/MAINTAINERS
index bd186c616b8b..1262a06d2358 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16823,6 +16823,12 @@ F:	include/linux/vbox_utils.h
 F:	include/uapi/linux/vbox*.h
 F:	drivers/virt/vboxguest/
 
+VIRTUAL BOX SHARED FOLDER VFS DRIVER:
+M:	Hans de Goede <hdegoede@redhat.com>
+L:	linux-fsdevel@vger.kernel.org
+S:	Maintained
+F:	fs/vboxsf/*
+
 VIRTUAL SERIO DEVICE DRIVER
 M:	Stephen Chandler Paul <thatslyude@gmail.com>
 S:	Maintained
diff --git a/fs/Kconfig b/fs/Kconfig
index f1046cf6ad85..b05dafd4db0f 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -262,6 +262,7 @@ source "fs/romfs/Kconfig"
 source "fs/pstore/Kconfig"
 source "fs/sysv/Kconfig"
 source "fs/ufs/Kconfig"
+source "fs/vboxsf/Kconfig"
 
 endif # MISC_FILESYSTEMS
 
diff --git a/fs/Makefile b/fs/Makefile
index c9aea23aba56..76bcde11a689 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -130,3 +130,4 @@ obj-$(CONFIG_F2FS_FS)		+= f2fs/
 obj-$(CONFIG_CEPH_FS)		+= ceph/
 obj-$(CONFIG_PSTORE)		+= pstore/
 obj-$(CONFIG_EFIVAR_FS)		+= efivarfs/
+obj-$(CONFIG_VBOXSF_FS)		+= vboxsf/
diff --git a/fs/vboxsf/Kconfig b/fs/vboxsf/Kconfig
new file mode 100644
index 000000000000..b84586ae08b3
--- /dev/null
+++ b/fs/vboxsf/Kconfig
@@ -0,0 +1,10 @@
+config VBOXSF_FS
+	tristate "VirtualBox guest shared folder (vboxsf) support"
+	depends on X86 && VBOXGUEST
+	select NLS
+	help
+	  VirtualBox hosts can share folders with guests, this driver
+	  implements the Linux-guest side of this allowing folders exported
+	  by the host to be mounted under Linux.
+
+	  If you want to use shared folders in VirtualBox guests, answer Y or M.
diff --git a/fs/vboxsf/Makefile b/fs/vboxsf/Makefile
new file mode 100644
index 000000000000..fcbd488f9eec
--- /dev/null
+++ b/fs/vboxsf/Makefile
@@ -0,0 +1,3 @@
+obj-$(CONFIG_VBOXSF_FS) += vboxsf.o
+
+vboxsf-objs := dir.o file.o utils.o vboxsf_wrappers.o super.o
diff --git a/fs/vboxsf/dir.c b/fs/vboxsf/dir.c
new file mode 100644
index 000000000000..83aae6a06958
--- /dev/null
+++ b/fs/vboxsf/dir.c
@@ -0,0 +1,562 @@
+// SPDX-License-Identifier: MIT
+/*
+ * VirtualBox Guest Shared Folders support: Directory inode and file operations
+ *
+ * Copyright (C) 2006-2018 Oracle Corporation
+ */
+
+#include <linux/namei.h>
+#include <linux/vbox_utils.h>
+#include "vfsmod.h"
+
+/**
+ * sf_dir_open - Open a directory
+ * @inode:	inode
+ * @file:	file
+ *
+ * Open a directory. Read the complete content into a buffer.
+ *
+ * Returns:
+ * 0 or negative errno value.
+ */
+static int sf_dir_open(struct inode *inode, struct file *file)
+{
+	struct sf_glob_info *sf_g = GET_GLOB_INFO(inode->i_sb);
+	struct shfl_createparms params = {};
+	struct sf_dir_info *sf_d;
+	int err;
+
+	sf_d = vboxsf_dir_info_alloc();
+	if (!sf_d)
+		return -ENOMEM;
+
+	params.handle = SHFL_HANDLE_NIL;
+	params.create_flags = SHFL_CF_DIRECTORY | SHFL_CF_ACT_OPEN_IF_EXISTS |
+			      SHFL_CF_ACT_FAIL_IF_NEW | SHFL_CF_ACCESS_READ;
+
+	err = vboxsf_create_at_dentry(file_dentry(file), &params);
+	if (err == 0) {
+		if (params.result == SHFL_FILE_EXISTS) {
+			err = vboxsf_dir_read_all(sf_g, sf_d, params.handle);
+			if (!err)
+				file->private_data = sf_d;
+		} else
+			err = -ENOENT;
+
+		vboxsf_close(sf_g->root, params.handle);
+	}
+
+	if (err)
+		vboxsf_dir_info_free(sf_d);
+
+	return err;
+}
+
+/**
+ * sf_dir_release - Directory file release method
+ * @inode:	inode
+ * @file:	file
+ *
+ * This is called when reference count of [file] goes to zero. Notify
+ * the host that it can free whatever is associated with this directory
+ * and deallocate our own internal buffers
+ *
+ * Returns:
+ * 0 or negative errno value.
+ */
+static int sf_dir_release(struct inode *inode, struct file *file)
+{
+	if (file->private_data)
+		vboxsf_dir_info_free(file->private_data);
+
+	return 0;
+}
+
+/**
+ * sf_get_d_type - Translate RTFMODE into DT_xxx
+ * @mode:	file mode
+ *
+ * Returns:
+ * d_type
+ */
+static unsigned int sf_get_d_type(u32 mode)
+{
+	unsigned int d_type;
+
+	switch (mode & SHFL_TYPE_MASK) {
+	case SHFL_TYPE_FIFO:
+		d_type = DT_FIFO;
+		break;
+	case SHFL_TYPE_DEV_CHAR:
+		d_type = DT_CHR;
+		break;
+	case SHFL_TYPE_DIRECTORY:
+		d_type = DT_DIR;
+		break;
+	case SHFL_TYPE_DEV_BLOCK:
+		d_type = DT_BLK;
+		break;
+	case SHFL_TYPE_FILE:
+		d_type = DT_REG;
+		break;
+	case SHFL_TYPE_SYMLINK:
+		d_type = DT_LNK;
+		break;
+	case SHFL_TYPE_SOCKET:
+		d_type = DT_SOCK;
+		break;
+	case SHFL_TYPE_WHITEOUT:
+		d_type = DT_WHT;
+		break;
+	default:
+		d_type = DT_UNKNOWN;
+		break;
+	}
+	return d_type;
+}
+
+/**
+ * sf_getdent - Get name and type of directory-entry
+ * @dir:	Directory to get element at f_pos from
+ * @d_name:	Buffer in which to return element name
+ * @d_type:	Buffer in which to return element file-type
+ *
+ * Extract element (@dir->f_pos) from the directory @dir into @d_name
+ * and @d_type.
+ *
+ * Returns:
+ * 0 on success, 1 when the end of the dir is reached, or a negative errno
+ * value on error.
+ */
+static int sf_getdent(struct file *dir, loff_t pos,
+		      char d_name[NAME_MAX], unsigned int *d_type)
+{
+	struct sf_glob_info *sf_g = GET_GLOB_INFO(file_inode(dir)->i_sb);
+	struct sf_dir_info *sf_d = dir->private_data;
+	struct shfl_dirinfo *info;
+	struct sf_dir_buf *b;
+	loff_t i, cur = 0;
+
+	list_for_each_entry(b, &sf_d->info_list, head) {
+		if (pos >= cur + b->entries) {
+			cur += b->entries;
+			continue;
+		}
+
+		/*
+		 * Note the sf_dir_info objects we are iterating over here
+		 * are variable sized, so the info pointer may end up being
+		 * unaligned. This is how we get the data from the host.
+		 * Since vboxsf is only supported on x86 machines this is not
+		 * a problem.
+		 */
+		for (i = 0, info = b->buf; i < pos - cur; ++i) {
+			size_t size;
+
+			size = offsetof(struct shfl_dirinfo, name.string) +
+			       info->name.size;
+			info = (struct shfl_dirinfo *)((uintptr_t) info + size);
+		}
+
+		*d_type = sf_get_d_type(info->info.attr.mode);
+
+		return vboxsf_nlscpy(sf_g, d_name, NAME_MAX,
+				     info->name.string.utf8, info->name.length);
+	}
+
+	return 1;
+}
+
+/**
+ * sf_dir_iterate - Iterate over directory entries
+ * @dir:	Directory to read
+ * @ctx:	Directory context in which to store read elements
+ *
+ * This is called when vfs wants to populate internal buffers with
+ * the directory's contents.
+ *
+ * Extract elements from the directory listing (incrementing @ctx->pos
+ * along the way) and emit them using dir_emit until:
+ *
+ * a. there are no more entries (sf_getdent returns 1)
+ * b. failure to compute fake inode number
+ * c. dir_emit() returns false
+ *
+ * Returns:
+ * 0 or negative errno value.
+ */
+static int sf_dir_iterate(struct file *dir, struct dir_context *ctx)
+{
+	char d_name[NAME_MAX];
+	unsigned int d_type;
+	ino_t fake_ino;
+	int err;
+
+	for (;;) {
+		err = sf_getdent(dir, ctx->pos, d_name, &d_type);
+		if (unlikely(err)) { /* EOF or an error */
+			if (err == 1)
+				return 0;
+			/* skip erroneous entry and proceed */
+			ctx->pos += 1;
+			continue;
+		}
+
+		/*
+		 * On 32 bit systems pos is 64 signed, while ino is 32 bit
+		 * unsigned so fake_ino may overflow, check for this.
+		 */
+		if ((ino_t)(ctx->pos + 1) != (u64)(ctx->pos + 1)) {
+			vbg_err("vboxsf: can not compute ino\n");
+			return -EINVAL;
+		}
+		fake_ino = ctx->pos + 1;
+
+		if (!dir_emit(ctx, d_name, strlen(d_name), fake_ino, d_type))
+			return 0;
+
+		ctx->pos += 1;
+	}
+}
+
+const struct file_operations vboxsf_dir_fops = {
+	.open = sf_dir_open,
+	.iterate = sf_dir_iterate,
+	.release = sf_dir_release,
+	.read = generic_read_dir,
+	.llseek = generic_file_llseek,
+};
+
+/*
+ * This is called during name resolution/lookup to check if the @dentry in
+ * the cache is still valid. the job is handled by vboxsf_inode_revalidate.
+ */
+static int sf_dentry_revalidate(struct dentry *dentry, unsigned int flags)
+{
+	if (flags & LOOKUP_RCU)
+		return -ECHILD;
+
+	if (d_really_is_positive(dentry))
+		return vboxsf_inode_revalidate(dentry) == 0;
+	else
+		return vboxsf_stat_dentry(dentry, NULL) == -ENOENT;
+}
+
+const struct dentry_operations vboxsf_dentry_ops = {
+	.d_revalidate = sf_dentry_revalidate
+};
+
+/* iops */
+
+/**
+ * sf_lookup - lookup a directory entry
+ * @parent:	inode of the parent directory
+ * @dentry:	dentry to populate
+ * @flags:	flags
+ *
+ * This is called when vfs failed to locate dentry in the cache. The
+ * job of this function is to allocate inode and link it to dentry.
+ * [dentry] contains the name to be looked in the [parent] directory.
+ * Failure to locate the name is not a "hard" error, in this case NULL
+ * inode is added to [dentry] and vfs should proceed trying to create
+ * the entry via other means.
+ *
+ * Returns:
+ * NULL on success, ERR_PTR on failure.
+ */
+static struct dentry *sf_lookup(struct inode *parent, struct dentry *dentry,
+				unsigned int flags)
+{
+	struct sf_glob_info *sf_g = GET_GLOB_INFO(parent->i_sb);
+	struct shfl_fsobjinfo fsinfo;
+	struct inode *inode;
+	int err;
+
+	dentry->d_time = jiffies;
+
+	err = vboxsf_stat_dentry(dentry, &fsinfo);
+	if (err) {
+		inode = (err == -ENOENT) ? NULL : ERR_PTR(err);
+	} else {
+		inode = vboxsf_new_inode(parent->i_sb);
+		if (!IS_ERR(inode))
+			vboxsf_init_inode(sf_g, inode, &fsinfo);
+	}
+
+	return d_splice_alias(inode, dentry);
+}
+
+/**
+ * sf_instantiate - Instantiate inode for dentry
+ * @parent:	inode of the parent directory
+ * @dentry:	directory entry
+ * @info:	file information
+ *
+ * Create a new inode, initialize it with info from @info and instantiate.
+ *
+ * Returns:
+ * 0 or negative errno value.
+ */
+static int sf_instantiate(struct inode *parent, struct dentry *dentry,
+			  struct shfl_fsobjinfo *info)
+{
+	struct sf_glob_info *sf_g = GET_GLOB_INFO(parent->i_sb);
+	struct sf_inode_info *sf_i;
+	struct inode *inode;
+
+	inode = vboxsf_new_inode(parent->i_sb);
+	if (IS_ERR(inode))
+		return PTR_ERR(inode);
+
+	sf_i = GET_INODE_INFO(inode);
+	/* The host may have given us different attr then requested */
+	sf_i->force_restat = 1;
+	vboxsf_init_inode(sf_g, inode, info);
+
+	d_instantiate(dentry, inode);
+
+	return 0;
+}
+
+/**
+ * sf_create_aux - Create a new regular file / directory
+ * @parent:	inode of the parent directory
+ * @dentry:	directory entry
+ * @mode:	file mode
+ * @is_dir:	true if directory, false otherwise
+ *
+ * Returns:
+ * 0 or negative errno value.
+ */
+static int sf_create_aux(struct inode *parent, struct dentry *dentry,
+			 umode_t mode, int is_dir)
+{
+	struct sf_inode_info *sf_parent_i = GET_INODE_INFO(parent);
+	struct sf_glob_info *sf_g = GET_GLOB_INFO(parent->i_sb);
+	struct shfl_createparms params = {};
+	int err;
+
+	params.handle = SHFL_HANDLE_NIL;
+	params.create_flags = SHFL_CF_ACT_CREATE_IF_NEW |
+			      SHFL_CF_ACT_FAIL_IF_EXISTS |
+			      SHFL_CF_ACCESS_READWRITE |
+			      (is_dir ? SHFL_CF_DIRECTORY : 0);
+	params.info.attr.mode = (mode & 0777) |
+				(is_dir ? SHFL_TYPE_DIRECTORY : SHFL_TYPE_FILE);
+	params.info.attr.additional = SHFLFSOBJATTRADD_NOTHING;
+
+	err = vboxsf_create_at_dentry(dentry, &params);
+	if (err)
+		return err;
+
+	if (params.result != SHFL_FILE_CREATED)
+		return -EPERM;
+
+	vboxsf_close(sf_g->root, params.handle);
+
+	err = sf_instantiate(parent, dentry, &params.info);
+	if (err)
+		return err;
+
+	/* parent directory access/change time changed */
+	sf_parent_i->force_restat = 1;
+
+	return 0;
+}
+
+/**
+ * sf_create - Create a new regular file
+ * @parent:	inode of the parent directory
+ * @dentry:	directory entry
+ * @mode:	file mode
+ * @excl:	Possible O_EXCL...
+ *
+ * Returns:
+ * 0 or negative errno value.
+ */
+static int sf_create(struct inode *parent, struct dentry *dentry, umode_t mode,
+		     bool excl)
+{
+	return sf_create_aux(parent, dentry, mode, 0);
+}
+
+/**
+ * sf_mkdir - Create a new regular directory
+ * @parent:	inode of the parent directory
+ * @dentry:	directory entry
+ * @mode:	file mode
+ * @excl:	Possible O_EXCL...
+ *
+ * Returns:
+ * 0 or negative errno value.
+ */
+static int sf_mkdir(struct inode *parent, struct dentry *dentry, umode_t mode)
+{
+	return sf_create_aux(parent, dentry, mode, 1);
+}
+
+/**
+ * sf_unlink_aux - Remove a regular file / directory.
+ * @parent:	inode of the parent directory
+ * @dentry:	directory entry
+ * @is_dir:	true if directory, false otherwise
+ *
+ * Returns:
+ * 0 or negative errno value.
+ */
+static int sf_unlink_aux(struct inode *parent, struct dentry *dentry,
+			 int is_dir)
+{
+	struct sf_glob_info *sf_g = GET_GLOB_INFO(parent->i_sb);
+	struct sf_inode_info *sf_parent_i = GET_INODE_INFO(parent);
+	struct inode *inode = d_inode(dentry);
+	struct shfl_string *path;
+	uint32_t flags;
+	int err;
+
+	flags = is_dir ? SHFL_REMOVE_DIR : SHFL_REMOVE_FILE;
+	if ((inode->i_mode & S_IFLNK) == S_IFLNK)
+		flags |= SHFL_REMOVE_SYMLINK;
+
+	path = vboxsf_path_from_dentry(sf_g, dentry);
+	if (IS_ERR(path))
+		return PTR_ERR(path);
+
+	err = vboxsf_remove(sf_g->root, path, flags);
+	__putname(path);
+	if (err)
+		return err;
+
+	/* parent directory access/change time changed */
+	sf_parent_i->force_restat = 1;
+
+	return 0;
+}
+
+/**
+ * sf_unlink_aux - Remove a regular file
+ * @parent:	inode of the parent directory
+ * @dentry:	directory entry
+ *
+ * Returns:
+ * 0 or negative errno value.
+ */
+static int sf_unlink(struct inode *parent, struct dentry *dentry)
+{
+	return sf_unlink_aux(parent, dentry, 0);
+}
+
+/**
+ * sf_rmdir - Remove a directory
+ * @parent:	inode of the parent directory
+ * @dentry:	directory entry
+ *
+ * Returns:
+ * 0 or negative errno value.
+ */
+static int sf_rmdir(struct inode *parent, struct dentry *dentry)
+{
+	return sf_unlink_aux(parent, dentry, 1);
+}
+
+/**
+ * sf_rename - Rename a regular file or directory
+ * @old_parent:  inode of the old parent directory
+ * @old_dentry:  old directory entry
+ * @new_parent:  inode of the new parent directory
+ * @new_dentry:  new directory entry
+ * @flags:       flags
+ *
+ * Returns:
+ * 0 or negative errno value.
+ */
+static int sf_rename(struct inode *old_parent, struct dentry *old_dentry,
+		     struct inode *new_parent, struct dentry *new_dentry,
+		     unsigned int flags)
+{
+	struct sf_glob_info *sf_g = GET_GLOB_INFO(old_parent->i_sb);
+	struct sf_inode_info *sf_old_parent_i = GET_INODE_INFO(old_parent);
+	struct sf_inode_info *sf_new_parent_i = GET_INODE_INFO(new_parent);
+	u32 shfl_flags = SHFL_RENAME_FILE | SHFL_RENAME_REPLACE_IF_EXISTS;
+	struct shfl_string *old_path, *new_path;
+	int err;
+
+	if (flags)
+		return -EINVAL;
+
+	old_path = vboxsf_path_from_dentry(sf_g, old_dentry);
+	if (IS_ERR(old_path))
+		return PTR_ERR(old_path);
+
+	new_path = vboxsf_path_from_dentry(sf_g, new_dentry);
+	if (IS_ERR(new_path)) {
+		__putname(old_path);
+		return PTR_ERR(new_path);
+	}
+
+	if (d_inode(old_dentry)->i_mode & S_IFDIR)
+		shfl_flags = 0;
+
+	err = vboxsf_rename(sf_g->root, old_path, new_path, shfl_flags);
+	if (err == 0) {
+		/* parent directories access/change time changed */
+		sf_new_parent_i->force_restat = 1;
+		sf_old_parent_i->force_restat = 1;
+	}
+
+	__putname(new_path);
+	__putname(old_path);
+	return err;
+}
+
+static int sf_symlink(struct inode *parent, struct dentry *dentry,
+		      const char *symname)
+{
+	struct sf_inode_info *sf_parent_i = GET_INODE_INFO(parent);
+	struct sf_glob_info *sf_g = GET_GLOB_INFO(parent->i_sb);
+	int symname_size = strlen(symname) + 1;
+	struct shfl_string *path, *ssymname;
+	struct shfl_fsobjinfo info;
+	int err;
+
+	path = vboxsf_path_from_dentry(sf_g, dentry);
+	if (IS_ERR(path))
+		return PTR_ERR(path);
+
+	ssymname = kmalloc(SHFLSTRING_HEADER_SIZE + symname_size, GFP_KERNEL);
+	if (!ssymname) {
+		__putname(path);
+		return -ENOMEM;
+	}
+	ssymname->length = symname_size - 1;
+	ssymname->size = symname_size;
+	memcpy(ssymname->string.utf8, symname, symname_size);
+
+	err = vboxsf_symlink(sf_g->root, path, ssymname, &info);
+	kfree(ssymname);
+	__putname(path);
+	if (err) {
+		/* -EROFS means symlinks are note support -> -EPERM */
+		return (err == -EROFS) ? -EPERM : err;
+	}
+
+	err = sf_instantiate(parent, dentry, &info);
+	if (err)
+		return err;
+
+	/* parent directory access/change time changed */
+	sf_parent_i->force_restat = 1;
+	return 0;
+}
+
+const struct inode_operations vboxsf_dir_iops = {
+	.lookup = sf_lookup,
+	.create = sf_create,
+	.mkdir = sf_mkdir,
+	.rmdir = sf_rmdir,
+	.unlink = sf_unlink,
+	.rename = sf_rename,
+	.getattr = vboxsf_getattr,
+	.setattr = vboxsf_setattr,
+	.symlink = sf_symlink
+};
diff --git a/fs/vboxsf/file.c b/fs/vboxsf/file.c
new file mode 100644
index 000000000000..60fa7ef6d797
--- /dev/null
+++ b/fs/vboxsf/file.c
@@ -0,0 +1,452 @@
+// SPDX-License-Identifier: MIT
+/*
+ * VirtualBox Guest Shared Folders support: Regular file inode and file ops.
+ *
+ * Copyright (C) 2006-2018 Oracle Corporation
+ */
+
+#include <linux/mm.h>
+#include <linux/page-flags.h>
+#include <linux/pagemap.h>
+#include <linux/highmem.h>
+#include <linux/sizes.h>
+#include "vfsmod.h"
+
+struct sf_handle {
+	u64 handle;
+	u32 root;
+	u32 access_flags;
+	struct kref refcount;
+	struct list_head head;
+};
+
+/**
+ * Read from a regular file.
+ * Return: The number of bytes read on success, negative errno value otherwise
+ * @file	the file
+ * @buf		the buffer
+ * @size	length of the buffer
+ * @off		offset within the file
+ */
+static ssize_t sf_reg_read(struct file *file, char __user *buf, size_t size,
+			   loff_t *off)
+{
+	struct sf_handle *sf_handle = file->private_data;
+	u64 pos = *off;
+	u32 nread;
+	int err;
+
+	if (!size)
+		return 0;
+
+	if (size > SHFL_MAX_RW_COUNT)
+		nread = SHFL_MAX_RW_COUNT;
+	else
+		nread = size;
+
+	err = vboxsf_read(sf_handle->root, sf_handle->handle, pos, &nread,
+			  (uintptr_t)buf, true);
+	if (err)
+		return err;
+
+	*off += nread;
+	return nread;
+}
+
+/**
+ * Write to a regular file.
+ * Return: The number of bytes written on success, negative errno val otherwise
+ * @file	the file
+ * @buf		the buffer
+ * @size	length of the buffer
+ * @off		offset within the file
+ */
+static ssize_t sf_reg_write(struct file *file, const char __user *buf,
+			    size_t size, loff_t *off)
+{
+	struct inode *inode = file_inode(file);
+	struct sf_inode_info *sf_i = GET_INODE_INFO(inode);
+	struct sf_handle *sf_handle = file->private_data;
+	u32 nwritten;
+	u64 pos;
+	int err;
+
+	if (file->f_flags & O_APPEND)
+		pos = i_size_read(inode);
+	else
+		pos = *off;
+
+	if (!size)
+		return 0;
+
+	if (size > SHFL_MAX_RW_COUNT)
+		nwritten = SHFL_MAX_RW_COUNT;
+	else
+		nwritten = size;
+
+	/* Make sure any pending writes done through mmap are flushed */
+	err = filemap_fdatawait_range(inode->i_mapping, pos, pos + nwritten);
+	if (err)
+		return err;
+
+	err = vboxsf_write(sf_handle->root, sf_handle->handle, pos, &nwritten,
+			   (uintptr_t)buf, true);
+	if (err)
+		return err;
+
+	if (pos + nwritten > i_size_read(inode))
+		i_size_write(inode, pos + nwritten);
+
+	/* Invalidate page-cache so that mmap using apps see the changes too */
+	invalidate_mapping_pages(inode->i_mapping, pos >> PAGE_SHIFT,
+				 (pos + nwritten) >> PAGE_SHIFT);
+
+	/* mtime changed */
+	sf_i->force_restat = 1;
+
+	*off = pos + nwritten;
+	return nwritten;
+}
+
+/**
+ * Open a regular file.
+ * Return: 0 or negative errno value.
+ * @inode	inode
+ * @file	file
+ */
+static int sf_reg_open(struct inode *inode, struct file *file)
+{
+	struct sf_inode_info *sf_i = GET_INODE_INFO(inode);
+	struct shfl_createparms params = {};
+	struct sf_handle *sf_handle;
+	u32 access_flags = 0;
+	int err;
+
+	sf_handle = kmalloc(sizeof(*sf_handle), GFP_KERNEL);
+	if (!sf_handle)
+		return -ENOMEM;
+
+	/*
+	 * We check the value of params.handle afterwards to find out if
+	 * the call succeeded or failed, as the API does not seem to cleanly
+	 * distinguish error and informational messages.
+	 *
+	 * Furthermore, we must set params.handle to SHFL_HANDLE_NIL to
+	 * make the shared folders host service use our mode parameter.
+	 */
+	params.handle = SHFL_HANDLE_NIL;
+	if (file->f_flags & O_CREAT) {
+		params.create_flags |= SHFL_CF_ACT_CREATE_IF_NEW;
+		/*
+		 * We ignore O_EXCL, as the Linux kernel seems to call create
+		 * beforehand itself, so O_EXCL should always fail.
+		 */
+		if (file->f_flags & O_TRUNC)
+			params.create_flags |= SHFL_CF_ACT_OVERWRITE_IF_EXISTS;
+		else
+			params.create_flags |= SHFL_CF_ACT_OPEN_IF_EXISTS;
+	} else {
+		params.create_flags |= SHFL_CF_ACT_FAIL_IF_NEW;
+		if (file->f_flags & O_TRUNC)
+			params.create_flags |= SHFL_CF_ACT_OVERWRITE_IF_EXISTS;
+	}
+
+	switch (file->f_flags & O_ACCMODE) {
+	case O_RDONLY:
+		access_flags |= SHFL_CF_ACCESS_READ;
+		break;
+
+	case O_WRONLY:
+		access_flags |= SHFL_CF_ACCESS_WRITE;
+		break;
+
+	case O_RDWR:
+		access_flags |= SHFL_CF_ACCESS_READWRITE;
+		break;
+
+	default:
+		WARN_ON(1);
+	}
+
+	if (file->f_flags & O_APPEND)
+		access_flags |= SHFL_CF_ACCESS_APPEND;
+
+	params.create_flags |= access_flags;
+	params.info.attr.mode = inode->i_mode;
+
+	err = vboxsf_create_at_dentry(file_dentry(file), &params);
+	if (err == 0 && params.handle == SHFL_HANDLE_NIL)
+		err = (params.result == SHFL_FILE_EXISTS) ? -EEXIST : -ENOENT;
+	if (err) {
+		kfree(sf_handle);
+		return err;
+	}
+
+	/* the host may have given us different attr then requested */
+	sf_i->force_restat = 1;
+
+	/* init our handle struct and add it to the inode's handles list */
+	sf_handle->handle = params.handle;
+	sf_handle->root = GET_GLOB_INFO(inode->i_sb)->root;
+	sf_handle->access_flags = access_flags;
+	kref_init(&sf_handle->refcount);
+
+	mutex_lock(&sf_i->handle_list_mutex);
+	list_add(&sf_handle->head, &sf_i->handle_list);
+	mutex_unlock(&sf_i->handle_list_mutex);
+
+	file->private_data = sf_handle;
+	return 0;
+}
+
+static void sf_handle_release(struct kref *refcount)
+{
+	struct sf_handle *sf_handle = container_of(refcount, struct sf_handle,
+						   refcount);
+
+	vboxsf_close(sf_handle->root, sf_handle->handle);
+	kfree(sf_handle);
+}
+
+/**
+ * Close a regular file.
+ * Return: 0 or negative errno value.
+ * @inode	inode
+ * @file	file
+ */
+static int sf_reg_release(struct inode *inode, struct file *file)
+{
+	struct sf_inode_info *sf_i = GET_INODE_INFO(inode);
+	struct sf_handle *sf_handle = file->private_data;
+
+	filemap_write_and_wait(inode->i_mapping);
+
+	mutex_lock(&sf_i->handle_list_mutex);
+	list_del(&sf_handle->head);
+	mutex_unlock(&sf_i->handle_list_mutex);
+
+	kref_put(&sf_handle->refcount, sf_handle_release);
+	file->private_data = NULL;
+	return 0;
+}
+
+/*
+ * Write back dirty pages now, because there may not be any suitable
+ * open files later
+ */
+static void sf_vma_close(struct vm_area_struct *vma)
+{
+	filemap_write_and_wait(vma->vm_file->f_mapping);
+}
+
+static vm_fault_t sf_page_mkwrite(struct vm_fault *vmf)
+{
+	struct page *page = vmf->page;
+	struct inode *inode = file_inode(vmf->vma->vm_file);
+
+	lock_page(page);
+	if (page->mapping != inode->i_mapping) {
+		unlock_page(page);
+		return VM_FAULT_NOPAGE;
+	}
+
+	return VM_FAULT_LOCKED;
+}
+
+static const struct vm_operations_struct sf_file_vm_ops = {
+	.close		= sf_vma_close,
+	.fault		= filemap_fault,
+	.map_pages	= filemap_map_pages,
+	.page_mkwrite	= sf_page_mkwrite,
+};
+
+static int sf_reg_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	int err;
+
+	err = generic_file_mmap(file, vma);
+	if (!err)
+		vma->vm_ops = &sf_file_vm_ops;
+
+	return err;
+}
+
+const struct file_operations vboxsf_reg_fops = {
+	.read = sf_reg_read,
+	.open = sf_reg_open,
+	.write = sf_reg_write,
+	.release = sf_reg_release,
+	.mmap = sf_reg_mmap,
+	.splice_read = generic_file_splice_read,
+	.read_iter = generic_file_read_iter,
+	.write_iter = generic_file_write_iter,
+	.fsync = noop_fsync,
+	.llseek = generic_file_llseek,
+};
+
+const struct inode_operations vboxsf_reg_iops = {
+	.getattr = vboxsf_getattr,
+	.setattr = vboxsf_setattr
+};
+
+static int sf_readpage(struct file *file, struct page *page)
+{
+	struct sf_handle *sf_handle = file->private_data;
+	loff_t off = page_offset(page);
+	u32 nread = PAGE_SIZE;
+	u8 *buf;
+	int err;
+
+	buf = kmap(page);
+
+	err = vboxsf_read(sf_handle->root, sf_handle->handle, off, &nread,
+			  (uintptr_t)buf, false);
+	if (err == 0) {
+		memset(&buf[nread], 0, PAGE_SIZE - nread);
+		flush_dcache_page(page);
+		SetPageUptodate(page);
+	} else {
+		SetPageError(page);
+	}
+
+	kunmap(page);
+	unlock_page(page);
+	return err;
+}
+
+static struct sf_handle *sf_get_writeable_handle(struct sf_inode_info *sf_i)
+{
+	struct sf_handle *h, *sf_handle = NULL;
+
+	mutex_lock(&sf_i->handle_list_mutex);
+	list_for_each_entry(h, &sf_i->handle_list, head) {
+		if (h->access_flags == SHFL_CF_ACCESS_WRITE ||
+		    h->access_flags == SHFL_CF_ACCESS_READWRITE) {
+			kref_get(&h->refcount);
+			sf_handle = h;
+			break;
+		}
+	}
+	mutex_unlock(&sf_i->handle_list_mutex);
+
+	return sf_handle;
+}
+
+static int sf_writepage(struct page *page, struct writeback_control *wbc)
+{
+	struct inode *inode = page->mapping->host;
+	struct sf_inode_info *sf_i = GET_INODE_INFO(inode);
+	struct sf_handle *sf_handle;
+	loff_t off = page_offset(page);
+	loff_t size = i_size_read(inode);
+	u32 nwrite = PAGE_SIZE;
+	u8 *buf;
+	int err;
+
+	if (off + PAGE_SIZE > size)
+		nwrite = size & ~PAGE_MASK;
+
+	sf_handle = sf_get_writeable_handle(sf_i);
+	if (!sf_handle)
+		return -EBADF;
+
+	buf = kmap(page);
+	err = vboxsf_write(sf_handle->root, sf_handle->handle, off, &nwrite,
+			   (uintptr_t)buf, false);
+	kunmap(page);
+
+	kref_put(&sf_handle->refcount, sf_handle_release);
+
+	if (err == 0) {
+		ClearPageError(page);
+		/* mtime changed */
+		sf_i->force_restat = 1;
+	} else {
+		ClearPageUptodate(page);
+	}
+
+	unlock_page(page);
+	return err;
+}
+
+static int sf_write_end(struct file *file, struct address_space *mapping,
+			loff_t pos, unsigned int len, unsigned int copied,
+			struct page *page, void *fsdata)
+{
+	struct inode *inode = mapping->host;
+	struct sf_handle *sf_handle = file->private_data;
+	unsigned int from = pos & ~PAGE_MASK;
+	u32 nwritten = len;
+	u8 *buf;
+	int err;
+
+	buf = kmap(page);
+	err = vboxsf_write(sf_handle->root, sf_handle->handle, pos, &nwritten,
+			   (uintptr_t)buf + from, false);
+	kunmap(page);
+
+	if (err) {
+		nwritten = 0;
+		goto out;
+	}
+
+	/* mtime changed */
+	GET_INODE_INFO(inode)->force_restat = 1;
+
+	if (!PageUptodate(page) && nwritten == PAGE_SIZE)
+		SetPageUptodate(page);
+
+	pos += nwritten;
+	if (pos > inode->i_size)
+		i_size_write(inode, pos);
+
+out:
+	unlock_page(page);
+	put_page(page);
+
+	return nwritten;
+}
+
+const struct address_space_operations vboxsf_reg_aops = {
+	.readpage = sf_readpage,
+	.writepage = sf_writepage,
+	.set_page_dirty = __set_page_dirty_nobuffers,
+	.write_begin = simple_write_begin,
+	.write_end = sf_write_end,
+};
+
+static const char *sf_get_link(struct dentry *dentry, struct inode *inode,
+			       struct delayed_call *done)
+{
+	struct sf_glob_info *sf_g = GET_GLOB_INFO(inode->i_sb);
+	struct shfl_string *path;
+	char *link;
+	int err;
+
+	if (!dentry)
+		return ERR_PTR(-ECHILD);
+
+	path = vboxsf_path_from_dentry(sf_g, dentry);
+	if (IS_ERR(path))
+		return (char *)path;
+
+	link = kzalloc(PATH_MAX, GFP_KERNEL);
+	if (!link) {
+		__putname(path);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	err = vboxsf_readlink(sf_g->root, path, PATH_MAX, link);
+	__putname(path);
+	if (err) {
+		kfree(link);
+		return ERR_PTR(err);
+	}
+
+	set_delayed_call(done, kfree_link, link);
+	return link;
+}
+
+const struct inode_operations vboxsf_lnk_iops = {
+	.get_link = sf_get_link
+};
diff --git a/fs/vboxsf/shfl_hostintf.h b/fs/vboxsf/shfl_hostintf.h
new file mode 100644
index 000000000000..09531260a5f1
--- /dev/null
+++ b/fs/vboxsf/shfl_hostintf.h
@@ -0,0 +1,901 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * VirtualBox Shared Folders: host interface definition.
+ *
+ * Copyright (C) 2006-2018 Oracle Corporation
+ */
+
+#ifndef SHFL_HOSTINTF_H
+#define SHFL_HOSTINTF_H
+
+#include <linux/vbox_vmmdev_types.h>
+
+/* The max in/out buffer size for a FN_READ or FN_WRITE call */
+#define SHFL_MAX_RW_COUNT           (16 * SZ_1M)
+
+/*
+ * Structures shared between guest and the service
+ * can be relocated and use offsets to point to variable
+ * length parts.
+ *
+ * Shared folders protocol works with handles.
+ * Before doing any action on a file system object,
+ * one have to obtain the object handle via a SHFL_FN_CREATE
+ * request. A handle must be closed with SHFL_FN_CLOSE.
+ */
+
+enum {
+	SHFL_FN_QUERY_MAPPINGS = 1,	/* Query mappings changes. */
+	SHFL_FN_QUERY_MAP_NAME,		/* Query map name. */
+	SHFL_FN_CREATE,			/* Open/create object. */
+	SHFL_FN_CLOSE,			/* Close object handle. */
+	SHFL_FN_READ,			/* Read object content. */
+	SHFL_FN_WRITE,			/* Write new object content. */
+	SHFL_FN_LOCK,			/* Lock/unlock a range in the object. */
+	SHFL_FN_LIST,			/* List object content. */
+	SHFL_FN_INFORMATION,		/* Query/set object information. */
+	/* Note function number 10 is not used! */
+	SHFL_FN_REMOVE = 11,		/* Remove object */
+	SHFL_FN_MAP_FOLDER_OLD,		/* Map folder (legacy) */
+	SHFL_FN_UNMAP_FOLDER,		/* Unmap folder */
+	SHFL_FN_RENAME,			/* Rename object */
+	SHFL_FN_FLUSH,			/* Flush file */
+	SHFL_FN_SET_UTF8,		/* Select UTF8 filename encoding */
+	SHFL_FN_MAP_FOLDER,		/* Map folder */
+	SHFL_FN_READLINK,		/* Read symlink dest (as of VBox 4.0) */
+	SHFL_FN_SYMLINK,		/* Create symlink (as of VBox 4.0) */
+	SHFL_FN_SET_SYMLINKS,		/* Ask host to show symlinks (as of 4.0) */
+};
+
+/* Root handles for a mapping are of type u32, Root handles are unique. */
+#define SHFL_ROOT_NIL		UINT_MAX
+
+/* Shared folders handle for an opened object are of type u64. */
+#define SHFL_HANDLE_NIL		ULLONG_MAX
+
+/* Hardcoded maximum length (in chars) of a shared folder name. */
+#define SHFL_MAX_LEN         (256)
+/* Hardcoded maximum number of shared folder mapping available to the guest. */
+#define SHFL_MAX_MAPPINGS    (64)
+
+/** Shared folder string buffer structure. */
+struct shfl_string {
+	/** Allocated size of the string member in bytes. */
+	u16 size;
+
+	/** Length of string without trailing nul in bytes. */
+	u16 length;
+
+	/** UTF-8 or UTF-16 string. Nul terminated. */
+	union {
+		u8 utf8[2];
+		u16 utf16[1];
+		u16 ucs2[1]; /* misnomer, use utf16. */
+	} string;
+};
+VMMDEV_ASSERT_SIZE(shfl_string, 6);
+
+/* The size of shfl_string w/o the string part. */
+#define SHFLSTRING_HEADER_SIZE  4
+
+/* Calculate size of the string. */
+static inline u32 shfl_string_buf_size(const struct shfl_string *string)
+{
+	return string ? SHFLSTRING_HEADER_SIZE + string->size : 0;
+}
+
+/* Set user id on execution (S_ISUID). */
+#define SHFL_UNIX_ISUID             0004000U
+/* Set group id on execution (S_ISGID). */
+#define SHFL_UNIX_ISGID             0002000U
+/* Sticky bit (S_ISVTX / S_ISTXT). */
+#define SHFL_UNIX_ISTXT             0001000U
+
+/* Owner readable (S_IRUSR). */
+#define SHFL_UNIX_IRUSR             0000400U
+/* Owner writable (S_IWUSR). */
+#define SHFL_UNIX_IWUSR             0000200U
+/* Owner executable (S_IXUSR). */
+#define SHFL_UNIX_IXUSR             0000100U
+
+/* Group readable (S_IRGRP). */
+#define SHFL_UNIX_IRGRP             0000040U
+/* Group writable (S_IWGRP). */
+#define SHFL_UNIX_IWGRP             0000020U
+/* Group executable (S_IXGRP). */
+#define SHFL_UNIX_IXGRP             0000010U
+
+/* Other readable (S_IROTH). */
+#define SHFL_UNIX_IROTH             0000004U
+/* Other writable (S_IWOTH). */
+#define SHFL_UNIX_IWOTH             0000002U
+/* Other executable (S_IXOTH). */
+#define SHFL_UNIX_IXOTH             0000001U
+
+/* Named pipe (fifo) (S_IFIFO). */
+#define SHFL_TYPE_FIFO              0010000U
+/* Character device (S_IFCHR). */
+#define SHFL_TYPE_DEV_CHAR          0020000U
+/* Directory (S_IFDIR). */
+#define SHFL_TYPE_DIRECTORY         0040000U
+/* Block device (S_IFBLK). */
+#define SHFL_TYPE_DEV_BLOCK         0060000U
+/* Regular file (S_IFREG). */
+#define SHFL_TYPE_FILE              0100000U
+/* Symbolic link (S_IFLNK). */
+#define SHFL_TYPE_SYMLINK           0120000U
+/* Socket (S_IFSOCK). */
+#define SHFL_TYPE_SOCKET            0140000U
+/* Whiteout (S_IFWHT). */
+#define SHFL_TYPE_WHITEOUT          0160000U
+/* Type mask (S_IFMT). */
+#define SHFL_TYPE_MASK              0170000U
+
+/* Checks the mode flags indicate a directory (S_ISDIR). */
+#define SHFL_IS_DIRECTORY(m)   (((m) & SHFL_TYPE_MASK) == SHFL_TYPE_DIRECTORY)
+/* Checks the mode flags indicate a symbolic link (S_ISLNK). */
+#define SHFL_IS_SYMLINK(m)     (((m) & SHFL_TYPE_MASK) == SHFL_TYPE_SYMLINK)
+
+/** The available additional information in a shfl_fsobjattr object. */
+enum shfl_fsobjattr_add {
+	/** No additional information is available / requested. */
+	SHFLFSOBJATTRADD_NOTHING = 1,
+	/**
+	 * The additional unix attributes (shfl_fsobjattr::u::unix_attr) are
+	 *  available / requested.
+	 */
+	SHFLFSOBJATTRADD_UNIX,
+	/**
+	 * The additional extended attribute size (shfl_fsobjattr::u::size) is
+	 *  available / requested.
+	 */
+	SHFLFSOBJATTRADD_EASIZE,
+	/**
+	 * The last valid item (inclusive).
+	 * The valid range is SHFLFSOBJATTRADD_NOTHING thru
+	 * SHFLFSOBJATTRADD_LAST.
+	 */
+	SHFLFSOBJATTRADD_LAST = SHFLFSOBJATTRADD_EASIZE,
+
+	/** The usual 32-bit hack. */
+	SHFLFSOBJATTRADD_32BIT_SIZE_HACK = 0x7fffffff
+};
+
+/**
+ * Additional unix Attributes, these are available when
+ * shfl_fsobjattr.additional == SHFLFSOBJATTRADD_UNIX.
+ */
+struct shfl_fsobjattr_unix {
+	/**
+	 * The user owning the filesystem object (st_uid).
+	 * This field is ~0U if not supported.
+	 */
+	u32 uid;
+
+	/**
+	 * The group the filesystem object is assigned (st_gid).
+	 * This field is ~0U if not supported.
+	 */
+	u32 gid;
+
+	/**
+	 * Number of hard links to this filesystem object (st_nlink).
+	 * This field is 1 if the filesystem doesn't support hardlinking or
+	 * the information isn't available.
+	 */
+	u32 hardlinks;
+
+	/**
+	 * The device number of the device which this filesystem object resides
+	 * on (st_dev). This field is 0 if this information is not available.
+	 */
+	u32 inode_id_device;
+
+	/**
+	 * The unique identifier (within the filesystem) of this filesystem
+	 * object (st_ino). Together with inode_id_device, this field can be
+	 * used as a OS wide unique id, when both their values are not 0.
+	 * This field is 0 if the information is not available.
+	 */
+	u64 inode_id;
+
+	/**
+	 * User flags (st_flags).
+	 * This field is 0 if this information is not available.
+	 */
+	u32 flags;
+
+	/**
+	 * The current generation number (st_gen).
+	 * This field is 0 if this information is not available.
+	 */
+	u32 generation_id;
+
+	/**
+	 * The device number of a char. or block device type object (st_rdev).
+	 * This field is 0 if the file isn't a char. or block device or when
+	 * the OS doesn't use the major+minor device idenfication scheme.
+	 */
+	u32 device;
+} __packed;
+
+/** Extended attribute size. */
+struct shfl_fsobjattr_easize {
+	/** Size of EAs. */
+	s64 cb;
+} __packed;
+
+/** Shared folder filesystem object attributes. */
+struct shfl_fsobjattr {
+	/** Mode flags (st_mode). SHFL_UNIX_*, SHFL_TYPE_*, and SHFL_DOS_*. */
+	u32 mode;
+
+	/** The additional attributes available. */
+	enum shfl_fsobjattr_add additional;
+
+	/**
+	 * Additional attributes.
+	 *
+	 * Unless explicitly specified to an API, the API can provide additional
+	 * data as it is provided by the underlying OS.
+	 */
+	union {
+		struct shfl_fsobjattr_unix unix_attr;
+		struct shfl_fsobjattr_easize size;
+	} __packed u;
+} __packed;
+VMMDEV_ASSERT_SIZE(shfl_fsobjattr, 44);
+
+struct shfl_timespec {
+	s64 ns_relative_to_unix_epoch;
+};
+
+/** Filesystem object information structure. */
+struct shfl_fsobjinfo {
+	/**
+	 * Logical size (st_size).
+	 * For normal files this is the size of the file.
+	 * For symbolic links, this is the length of the path name contained
+	 * in the symbolic link.
+	 * For other objects this fields needs to be specified.
+	 */
+	s64 size;
+
+	/** Disk allocation size (st_blocks * DEV_BSIZE). */
+	s64 allocated;
+
+	/** Time of last access (st_atime). */
+	struct shfl_timespec access_time;
+
+	/** Time of last data modification (st_mtime). */
+	struct shfl_timespec modification_time;
+
+	/**
+	 * Time of last status change (st_ctime).
+	 * If not available this is set to modification_time.
+	 */
+	struct shfl_timespec change_time;
+
+	/**
+	 * Time of file birth (st_birthtime).
+	 * If not available this is set to change_time.
+	 */
+	struct shfl_timespec birth_time;
+
+	/** Attributes. */
+	struct shfl_fsobjattr attr;
+
+} __packed;
+VMMDEV_ASSERT_SIZE(shfl_fsobjinfo, 92);
+
+/**
+ * result of an open/create request.
+ * Along with handle value the result code
+ * identifies what has happened while
+ * trying to open the object.
+ */
+enum shfl_create_result {
+	SHFL_NO_RESULT,
+	/** Specified path does not exist. */
+	SHFL_PATH_NOT_FOUND,
+	/** Path to file exists, but the last component does not. */
+	SHFL_FILE_NOT_FOUND,
+	/** File already exists and either has been opened or not. */
+	SHFL_FILE_EXISTS,
+	/** New file was created. */
+	SHFL_FILE_CREATED,
+	/** Existing file was replaced or overwritten. */
+	SHFL_FILE_REPLACED
+};
+
+/* No flags. Initialization value. */
+#define SHFL_CF_NONE                  (0x00000000)
+
+/*
+ * Only lookup the object, do not return a handle. When this is set all other
+ * flags are ignored.
+ */
+#define SHFL_CF_LOOKUP                (0x00000001)
+
+/*
+ * Open parent directory of specified object.
+ * Useful for the corresponding Windows FSD flag
+ * and for opening paths like \\dir\\*.* to search the 'dir'.
+ */
+#define SHFL_CF_OPEN_TARGET_DIRECTORY (0x00000002)
+
+/* Create/open a directory. */
+#define SHFL_CF_DIRECTORY             (0x00000004)
+
+/*
+ *  Open/create action to do if object exists
+ *  and if the object does not exists.
+ *  REPLACE file means atomically DELETE and CREATE.
+ *  OVERWRITE file means truncating the file to 0 and
+ *  setting new size.
+ *  When opening an existing directory REPLACE and OVERWRITE
+ *  actions are considered invalid, and cause returning
+ *  FILE_EXISTS with NIL handle.
+ */
+#define SHFL_CF_ACT_MASK_IF_EXISTS      (0x000000f0)
+#define SHFL_CF_ACT_MASK_IF_NEW         (0x00000f00)
+
+/* What to do if object exists. */
+#define SHFL_CF_ACT_OPEN_IF_EXISTS      (0x00000000)
+#define SHFL_CF_ACT_FAIL_IF_EXISTS      (0x00000010)
+#define SHFL_CF_ACT_REPLACE_IF_EXISTS   (0x00000020)
+#define SHFL_CF_ACT_OVERWRITE_IF_EXISTS (0x00000030)
+
+/* What to do if object does not exist. */
+#define SHFL_CF_ACT_CREATE_IF_NEW       (0x00000000)
+#define SHFL_CF_ACT_FAIL_IF_NEW         (0x00000100)
+
+/* Read/write requested access for the object. */
+#define SHFL_CF_ACCESS_MASK_RW          (0x00003000)
+
+/* No access requested. */
+#define SHFL_CF_ACCESS_NONE             (0x00000000)
+/* Read access requested. */
+#define SHFL_CF_ACCESS_READ             (0x00001000)
+/* Write access requested. */
+#define SHFL_CF_ACCESS_WRITE            (0x00002000)
+/* Read/Write access requested. */
+#define SHFL_CF_ACCESS_READWRITE	(0x00003000)
+
+/* Requested share access for the object. */
+#define SHFL_CF_ACCESS_MASK_DENY        (0x0000c000)
+
+/* Allow any access. */
+#define SHFL_CF_ACCESS_DENYNONE         (0x00000000)
+/* Do not allow read. */
+#define SHFL_CF_ACCESS_DENYREAD         (0x00004000)
+/* Do not allow write. */
+#define SHFL_CF_ACCESS_DENYWRITE        (0x00008000)
+/* Do not allow access. */
+#define SHFL_CF_ACCESS_DENYALL          (0x0000c000)
+
+/* Requested access to attributes of the object. */
+#define SHFL_CF_ACCESS_MASK_ATTR        (0x00030000)
+
+/* No access requested. */
+#define SHFL_CF_ACCESS_ATTR_NONE        (0x00000000)
+/* Read access requested. */
+#define SHFL_CF_ACCESS_ATTR_READ        (0x00010000)
+/* Write access requested. */
+#define SHFL_CF_ACCESS_ATTR_WRITE       (0x00020000)
+/* Read/Write access requested. */
+#define SHFL_CF_ACCESS_ATTR_READWRITE   (0x00030000)
+
+/*
+ * The file is opened in append mode.
+ * Ignored if SHFL_CF_ACCESS_WRITE is not set.
+ */
+#define SHFL_CF_ACCESS_APPEND           (0x00040000)
+
+/** Create parameters buffer struct for SHFL_FN_CREATE call */
+struct shfl_createparms {
+	/** Returned handle of opened object. */
+	u64 handle;
+
+	/** Returned result of the operation */
+	enum shfl_create_result result;
+
+	/** SHFL_CF_* */
+	u32 create_flags;
+
+	/**
+	 * Attributes of object to create and
+	 * returned actual attributes of opened/created object.
+	 */
+	struct shfl_fsobjinfo info;
+} __packed;
+
+/** Shared Folder directory information */
+struct shfl_dirinfo {
+	/** Full information about the object. */
+	struct shfl_fsobjinfo info;
+	/**
+	 * The length of the short field (number of UTF16 chars).
+	 * It is 16-bit for reasons of alignment.
+	 */
+	u16 short_name_len;
+	/**
+	 * The short name for 8.3 compatibility.
+	 * Empty string if not available.
+	 */
+	u16 short_name[14];
+	struct shfl_string name;
+};
+
+/** Shared folder filesystem properties. */
+struct shfl_fsproperties {
+	/**
+	 * The maximum size of a filesystem object name.
+	 * This does not include the '\\0'.
+	 */
+	u32 max_component_len;
+
+	/**
+	 * True if the filesystem is remote.
+	 * False if the filesystem is local.
+	 */
+	bool remote;
+
+	/**
+	 * True if the filesystem is case sensitive.
+	 * False if the filesystem is case insensitive.
+	 */
+	bool case_sensitive;
+
+	/**
+	 * True if the filesystem is mounted read only.
+	 * False if the filesystem is mounted read write.
+	 */
+	bool read_only;
+
+	/**
+	 * True if the filesystem can encode unicode object names.
+	 * False if it can't.
+	 */
+	bool supports_unicode;
+
+	/**
+	 * True if the filesystem is compresses.
+	 * False if it isn't or we don't know.
+	 */
+	bool compressed;
+
+	/**
+	 * True if the filesystem compresses of individual files.
+	 * False if it doesn't or we don't know.
+	 */
+	bool file_compression;
+};
+VMMDEV_ASSERT_SIZE(shfl_fsproperties, 12);
+
+struct shfl_volinfo {
+	s64 total_allocation_bytes;
+	s64 available_allocation_bytes;
+	u32 bytes_per_allocation_unit;
+	u32 bytes_per_sector;
+	u32 serial;
+	struct shfl_fsproperties properties;
+};
+
+
+/** SHFL_FN_MAP_FOLDER Parameters structure. */
+struct shfl_map_folder {
+	/**
+	 * pointer, in:
+	 * Points to struct shfl_string buffer.
+	 */
+	struct vmmdev_hgcm_function_parameter path;
+
+	/**
+	 * pointer, out: SHFLROOT (u32)
+	 * Root handle of the mapping which name is queried.
+	 */
+	struct vmmdev_hgcm_function_parameter root;
+
+	/**
+	 * pointer, in: UTF16
+	 * Path delimiter
+	 */
+	struct vmmdev_hgcm_function_parameter delimiter;
+
+	/**
+	 * pointer, in: SHFLROOT (u32)
+	 * Case senstive flag
+	 */
+	struct vmmdev_hgcm_function_parameter case_sensitive;
+
+};
+
+/* Number of parameters */
+#define SHFL_CPARMS_MAP_FOLDER (4)
+
+
+/** SHFL_FN_UNMAP_FOLDER Parameters structure. */
+struct shfl_unmap_folder {
+	/**
+	 * pointer, in: SHFLROOT (u32)
+	 * Root handle of the mapping which name is queried.
+	 */
+	struct vmmdev_hgcm_function_parameter root;
+
+};
+
+/* Number of parameters */
+#define SHFL_CPARMS_UNMAP_FOLDER (1)
+
+
+/** SHFL_FN_CREATE Parameters structure. */
+struct shfl_create {
+	/**
+	 * pointer, in: SHFLROOT (u32)
+	 * Root handle of the mapping which name is queried.
+	 */
+	struct vmmdev_hgcm_function_parameter root;
+
+	/**
+	 * pointer, in:
+	 * Points to struct shfl_string buffer.
+	 */
+	struct vmmdev_hgcm_function_parameter path;
+
+	/**
+	 * pointer, in/out:
+	 * Points to struct shfl_createparms buffer.
+	 */
+	struct vmmdev_hgcm_function_parameter parms;
+
+};
+
+/* Number of parameters */
+#define SHFL_CPARMS_CREATE (3)
+
+
+/** SHFL_FN_CLOSE Parameters structure. */
+struct shfl_close {
+	/**
+	 * pointer, in: SHFLROOT (u32)
+	 * Root handle of the mapping which name is queried.
+	 */
+	struct vmmdev_hgcm_function_parameter root;
+
+	/**
+	 * value64, in:
+	 * SHFLHANDLE (u64) of object to close.
+	 */
+	struct vmmdev_hgcm_function_parameter handle;
+
+};
+
+/* Number of parameters */
+#define SHFL_CPARMS_CLOSE (2)
+
+
+/** SHFL_FN_READ Parameters structure. */
+struct shfl_read {
+	/**
+	 * pointer, in: SHFLROOT (u32)
+	 * Root handle of the mapping which name is queried.
+	 */
+	struct vmmdev_hgcm_function_parameter root;
+
+	/**
+	 * value64, in:
+	 * SHFLHANDLE (u64) of object to read from.
+	 */
+	struct vmmdev_hgcm_function_parameter handle;
+
+	/**
+	 * value64, in:
+	 * Offset to read from.
+	 */
+	struct vmmdev_hgcm_function_parameter offset;
+
+	/**
+	 * value64, in/out:
+	 * Bytes to read/How many were read.
+	 */
+	struct vmmdev_hgcm_function_parameter cb;
+
+	/**
+	 * pointer, out:
+	 * Buffer to place data to.
+	 */
+	struct vmmdev_hgcm_function_parameter buffer;
+
+};
+
+/* Number of parameters */
+#define SHFL_CPARMS_READ (5)
+
+
+/** SHFL_FN_WRITE Parameters structure. */
+struct shfl_write {
+	/**
+	 * pointer, in: SHFLROOT (u32)
+	 * Root handle of the mapping which name is queried.
+	 */
+	struct vmmdev_hgcm_function_parameter root;
+
+	/**
+	 * value64, in:
+	 * SHFLHANDLE (u64) of object to write to.
+	 */
+	struct vmmdev_hgcm_function_parameter handle;
+
+	/**
+	 * value64, in:
+	 * Offset to write to.
+	 */
+	struct vmmdev_hgcm_function_parameter offset;
+
+	/**
+	 * value64, in/out:
+	 * Bytes to write/How many were written.
+	 */
+	struct vmmdev_hgcm_function_parameter cb;
+
+	/**
+	 * pointer, in:
+	 * Data to write.
+	 */
+	struct vmmdev_hgcm_function_parameter buffer;
+
+};
+
+/* Number of parameters */
+#define SHFL_CPARMS_WRITE (5)
+
+
+/*
+ * SHFL_FN_LIST
+ * Listing information includes variable length RTDIRENTRY[EX] structures.
+ */
+
+#define SHFL_LIST_NONE			0
+#define SHFL_LIST_RETURN_ONE		1
+
+/** SHFL_FN_LIST Parameters structure. */
+struct shfl_list {
+	/**
+	 * pointer, in: SHFLROOT (u32)
+	 * Root handle of the mapping which name is queried.
+	 */
+	struct vmmdev_hgcm_function_parameter root;
+
+	/**
+	 * value64, in:
+	 * SHFLHANDLE (u64) of object to be listed.
+	 */
+	struct vmmdev_hgcm_function_parameter handle;
+
+	/**
+	 * value32, in:
+	 * List flags SHFL_LIST_*.
+	 */
+	struct vmmdev_hgcm_function_parameter flags;
+
+	/**
+	 * value32, in/out:
+	 * Bytes to be used for listing information/How many bytes were used.
+	 */
+	struct vmmdev_hgcm_function_parameter cb;
+
+	/**
+	 * pointer, in/optional
+	 * Points to struct shfl_string buffer that specifies a search path.
+	 */
+	struct vmmdev_hgcm_function_parameter path;
+
+	/**
+	 * pointer, out:
+	 * Buffer to place listing information to. (struct shfl_dirinfo)
+	 */
+	struct vmmdev_hgcm_function_parameter buffer;
+
+	/**
+	 * value32, in/out:
+	 * Indicates a key where the listing must be resumed.
+	 * in: 0 means start from begin of object.
+	 * out: 0 means listing completed.
+	 */
+	struct vmmdev_hgcm_function_parameter resume_point;
+
+	/**
+	 * pointer, out:
+	 * Number of files returned
+	 */
+	struct vmmdev_hgcm_function_parameter file_count;
+};
+
+/* Number of parameters */
+#define SHFL_CPARMS_LIST (8)
+
+
+/** SHFL_FN_READLINK Parameters structure. */
+struct shfl_readLink {
+	/**
+	 * pointer, in: SHFLROOT (u32)
+	 * Root handle of the mapping which name is queried.
+	 */
+	struct vmmdev_hgcm_function_parameter root;
+
+	/**
+	 * pointer, in:
+	 * Points to struct shfl_string buffer.
+	 */
+	struct vmmdev_hgcm_function_parameter path;
+
+	/**
+	 * pointer, out:
+	 * Buffer to place data to.
+	 */
+	struct vmmdev_hgcm_function_parameter buffer;
+
+};
+
+/* Number of parameters */
+#define SHFL_CPARMS_READLINK (3)
+
+
+/* SHFL_FN_INFORMATION */
+
+/* Mask of Set/Get bit. */
+#define SHFL_INFO_MODE_MASK    (0x1)
+/* Get information */
+#define SHFL_INFO_GET          (0x0)
+/* Set information */
+#define SHFL_INFO_SET          (0x1)
+
+/* Get name of the object. */
+#define SHFL_INFO_NAME         (0x2)
+/* Set size of object (extend/trucate); only applies to file objects */
+#define SHFL_INFO_SIZE         (0x4)
+/* Get/Set file object info. */
+#define SHFL_INFO_FILE         (0x8)
+/* Get volume information. */
+#define SHFL_INFO_VOLUME       (0x10)
+
+/** SHFL_FN_INFORMATION Parameters structure. */
+struct shfl_information {
+	/**
+	 * pointer, in: SHFLROOT (u32)
+	 * Root handle of the mapping which name is queried.
+	 */
+	struct vmmdev_hgcm_function_parameter root;
+
+	/**
+	 * value64, in:
+	 * SHFLHANDLE (u64) of object to be listed.
+	 */
+	struct vmmdev_hgcm_function_parameter handle;
+
+	/**
+	 * value32, in:
+	 * SHFL_INFO_*
+	 */
+	struct vmmdev_hgcm_function_parameter flags;
+
+	/**
+	 * value32, in/out:
+	 * Bytes to be used for information/How many bytes were used.
+	 */
+	struct vmmdev_hgcm_function_parameter cb;
+
+	/**
+	 * pointer, in/out:
+	 * Information to be set/get (shfl_fsobjinfo or shfl_string). Do not
+	 * forget to set the shfl_fsobjinfo::attr::additional for a get
+	 * operation as well.
+	 */
+	struct vmmdev_hgcm_function_parameter info;
+
+};
+
+/* Number of parameters */
+#define SHFL_CPARMS_INFORMATION (5)
+
+
+/* SHFL_FN_REMOVE */
+
+#define SHFL_REMOVE_FILE        (0x1)
+#define SHFL_REMOVE_DIR         (0x2)
+#define SHFL_REMOVE_SYMLINK     (0x4)
+
+/** SHFL_FN_REMOVE Parameters structure. */
+struct shfl_remove {
+	/**
+	 * pointer, in: SHFLROOT (u32)
+	 * Root handle of the mapping which name is queried.
+	 */
+	struct vmmdev_hgcm_function_parameter root;
+
+	/**
+	 * pointer, in:
+	 * Points to struct shfl_string buffer.
+	 */
+	struct vmmdev_hgcm_function_parameter path;
+
+	/**
+	 * value32, in:
+	 * remove flags (file/directory)
+	 */
+	struct vmmdev_hgcm_function_parameter flags;
+
+};
+
+#define SHFL_CPARMS_REMOVE  (3)
+
+
+/* SHFL_FN_RENAME */
+
+#define SHFL_RENAME_FILE                (0x1)
+#define SHFL_RENAME_DIR                 (0x2)
+#define SHFL_RENAME_REPLACE_IF_EXISTS   (0x4)
+
+/** SHFL_FN_RENAME Parameters structure. */
+struct shfl_rename {
+	/**
+	 * pointer, in: SHFLROOT (u32)
+	 * Root handle of the mapping which name is queried.
+	 */
+	struct vmmdev_hgcm_function_parameter root;
+
+	/**
+	 * pointer, in:
+	 * Points to struct shfl_string src.
+	 */
+	struct vmmdev_hgcm_function_parameter src;
+
+	/**
+	 * pointer, in:
+	 * Points to struct shfl_string dest.
+	 */
+	struct vmmdev_hgcm_function_parameter dest;
+
+	/**
+	 * value32, in:
+	 * rename flags (file/directory)
+	 */
+	struct vmmdev_hgcm_function_parameter flags;
+
+};
+
+#define SHFL_CPARMS_RENAME  (4)
+
+
+/** SHFL_FN_SYMLINK Parameters structure. */
+struct shfl_symlink {
+	/**
+	 * pointer, in: SHFLROOT (u32)
+	 * Root handle of the mapping which name is queried.
+	 */
+	struct vmmdev_hgcm_function_parameter root;
+
+	/**
+	 * pointer, in:
+	 * Points to struct shfl_string of path for the new symlink.
+	 */
+	struct vmmdev_hgcm_function_parameter new_path;
+
+	/**
+	 * pointer, in:
+	 * Points to struct shfl_string of destination for symlink.
+	 */
+	struct vmmdev_hgcm_function_parameter old_path;
+
+	/**
+	 * pointer, out:
+	 * Information about created symlink.
+	 */
+	struct vmmdev_hgcm_function_parameter info;
+
+};
+
+#define SHFL_CPARMS_SYMLINK  (4)
+
+#endif
diff --git a/fs/vboxsf/super.c b/fs/vboxsf/super.c
new file mode 100644
index 000000000000..76d1a2184077
--- /dev/null
+++ b/fs/vboxsf/super.c
@@ -0,0 +1,482 @@
+// SPDX-License-Identifier: MIT
+/*
+ * VirtualBox Guest Shared Folders support: Virtual File System.
+ *
+ * Module initialization/finalization
+ * File system registration/deregistration
+ * Superblock reading
+ * Few utility functions
+ *
+ * Copyright (C) 2006-2018 Oracle Corporation
+ */
+
+#include <linux/idr.h>
+#include <linux/fs_parser.h>
+#include <linux/magic.h>
+#include <linux/module.h>
+#include <linux/nls.h>
+#include <linux/statfs.h>
+#include <linux/vbox_utils.h>
+#include "vfsmod.h"
+
+#define VBOXSF_SUPER_MAGIC 0x786f4256 /* 'VBox' little endian */
+
+#define VBSF_MOUNT_SIGNATURE_BYTE_0 ('\000')
+#define VBSF_MOUNT_SIGNATURE_BYTE_1 ('\377')
+#define VBSF_MOUNT_SIGNATURE_BYTE_2 ('\376')
+#define VBSF_MOUNT_SIGNATURE_BYTE_3 ('\375')
+
+static int follow_symlinks;
+module_param(follow_symlinks, int, 0444);
+MODULE_PARM_DESC(follow_symlinks,
+		 "Let host resolve symlinks rather than showing them");
+
+static DEFINE_IDA(vboxsf_bdi_ida);
+static DEFINE_MUTEX(vboxsf_setup_mutex);
+static bool vboxsf_setup_done;
+static struct super_operations vboxsf_super_ops; /* forward declaration */
+static struct kmem_cache *sf_inode_cachep;
+
+static char * const vboxsf_default_nls = CONFIG_NLS_DEFAULT;
+
+enum  { opt_nls, opt_uid, opt_gid, opt_ttl, opt_dmode, opt_fmode,
+	opt_dmask, opt_fmask };
+
+static const struct fs_parameter_spec vboxsf_param_specs[] = {
+	fsparam_string("nls", opt_nls),
+	fsparam_u32("uid", opt_uid),
+	fsparam_u32("gid", opt_gid),
+	fsparam_u32("ttl", opt_ttl),
+	fsparam_u32oct("dmode", opt_dmode),
+	fsparam_u32oct("fmode", opt_fmode),
+	fsparam_u32oct("dmask", opt_dmask),
+	fsparam_u32oct("fmask", opt_fmask),
+	{}
+};
+
+static const struct fs_parameter_description vboxsf_fs_parameters = {
+	.name  = "vboxsf",
+	.specs  = vboxsf_param_specs,
+};
+
+static int vboxsf_parse_param(struct fs_context *fc, struct fs_parameter *param)
+{
+	struct vboxsf_fs_context *ctx = fc->fs_private;
+	struct fs_parse_result result;
+	int opt;
+
+	opt = fs_parse(fc, &vboxsf_fs_parameters, param, &result);
+	if (opt < 0)
+		return opt;
+
+	switch (opt) {
+	case opt_nls:
+		if (fc->purpose != FS_CONTEXT_FOR_MOUNT) {
+			vbg_err("vboxsf: Cannot reconfigure nls option\n");
+			return -EINVAL;
+		}
+		ctx->nls_name = param->string;
+		param->string = NULL;
+		break;
+	case opt_uid:
+		ctx->o.uid = result.uint_32;
+		break;
+	case opt_gid:
+		ctx->o.gid = result.uint_32;
+		break;
+	case opt_ttl:
+		ctx->o.ttl = msecs_to_jiffies(result.uint_32);
+		break;
+	case opt_dmode:
+		ctx->o.dmode = result.uint_32;
+		break;
+	case opt_fmode:
+		ctx->o.fmode = result.uint_32;
+		break;
+	case opt_dmask:
+		ctx->o.dmask = result.uint_32;
+		break;
+	case opt_fmask:
+		ctx->o.fmask = result.uint_32;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int vboxsf_fill_super(struct super_block *sb, struct fs_context *fc)
+{
+	struct vboxsf_fs_context *ctx = fc->fs_private;
+	struct shfl_string *folder_name, root_path;
+	struct sf_glob_info *sf_g;
+	struct dentry *droot;
+	struct inode *iroot;
+	char *nls_name;
+	size_t size;
+	int err;
+
+	if (!fc->source)
+		return -EINVAL;
+
+	sf_g = kzalloc(sizeof(*sf_g), GFP_KERNEL);
+	if (!sf_g)
+		return -ENOMEM;
+
+	sf_g->o = ctx->o;
+	idr_init(&sf_g->ino_idr);
+	spin_lock_init(&sf_g->ino_idr_lock);
+	sf_g->next_generation = 1;
+	sf_g->bdi_id = -1;
+
+ 	/* Load nls if not utf8 */
+	nls_name = ctx->nls_name ? ctx->nls_name : vboxsf_default_nls;
+	if (strcmp(nls_name, "utf8") != 0) {
+		if (nls_name == vboxsf_default_nls)
+			sf_g->nls = load_nls_default();
+		else
+			sf_g->nls = load_nls(nls_name);
+
+		if (!sf_g->nls) {
+			vbg_err("vboxsf: Count not load '%s' nls\n", nls_name);
+			err = -EINVAL;
+			goto fail_free;
+		}
+	}
+
+	sf_g->bdi_id = ida_simple_get(&vboxsf_bdi_ida, 0, 0, GFP_KERNEL);
+	if (sf_g->bdi_id < 0) {
+		err = sf_g->bdi_id;
+		goto fail_free;
+	}
+
+	err = super_setup_bdi_name(sb, "vboxsf-%s.%d", fc->source,
+				   sf_g->bdi_id);
+	if (err)
+		goto fail_free;
+
+	/* Turn source into a shfl_string and map the folder */
+	size = strlen(fc->source) + 1;
+	folder_name = kmalloc(SHFLSTRING_HEADER_SIZE + size, GFP_KERNEL);
+	if (!folder_name)
+		goto fail_free;
+	folder_name->size = size;
+	folder_name->length = size - 1;
+	strlcpy(folder_name->string.utf8, fc->source, size);
+	err = vboxsf_map_folder(folder_name, &sf_g->root);
+	kfree(folder_name);
+	if (err) {
+		vbg_err("vboxsf: Host rejected mount of '%s' with error %d\n",
+			fc->source, err);
+		goto fail_free;
+	}
+
+	root_path.length = 1;
+	root_path.size = 2;
+	root_path.string.utf8[0] = '/';
+	root_path.string.utf8[1] = 0;
+	err = vboxsf_stat(sf_g, &root_path, &sf_g->root_info);
+	if (err)
+		goto fail_unmap;
+
+	sb->s_magic = VBOXSF_SUPER_MAGIC;
+	sb->s_blocksize = 1024;
+	sb->s_maxbytes = MAX_LFS_FILESIZE;
+	sb->s_op = &vboxsf_super_ops;
+	sb->s_d_op = &vboxsf_dentry_ops;
+
+	iroot = iget_locked(sb, 0);
+	if (!iroot) {
+		err = -ENOMEM;
+		goto fail_unmap;
+	}
+	vboxsf_init_inode(sf_g, iroot, &sf_g->root_info);
+	unlock_new_inode(iroot);
+
+	droot = d_make_root(iroot);
+	if (!droot) {
+		err = -ENOMEM;
+		goto fail_unmap;
+	}
+
+	sb->s_root = droot;
+	SET_GLOB_INFO(sb, sf_g);
+	return 0;
+
+fail_unmap:
+	vboxsf_unmap_folder(sf_g->root);
+fail_free:
+	if (sf_g->bdi_id >= 0)
+		ida_simple_remove(&vboxsf_bdi_ida, sf_g->bdi_id);
+	if (sf_g->nls)
+		unload_nls(sf_g->nls);
+	idr_destroy(&sf_g->ino_idr);
+	kfree(sf_g);
+	return err;
+}
+
+static void sf_inode_init_once(void *data)
+{
+	struct sf_inode_info *sf_i = (struct sf_inode_info *)data;
+
+	mutex_init(&sf_i->handle_list_mutex);
+	inode_init_once(&sf_i->vfs_inode);
+}
+
+static struct inode *sf_alloc_inode(struct super_block *sb)
+{
+	struct sf_inode_info *sf_i;
+
+	sf_i = kmem_cache_alloc(sf_inode_cachep, GFP_NOFS);
+	if (!sf_i)
+		return NULL;
+
+	sf_i->force_restat = 0;
+	INIT_LIST_HEAD(&sf_i->handle_list);
+
+	return &sf_i->vfs_inode;
+}
+
+static void sf_i_callback(struct rcu_head *head)
+{
+	struct inode *inode = container_of(head, struct inode, i_rcu);
+	struct sf_glob_info *sf_g = GET_GLOB_INFO(inode->i_sb);
+
+	spin_lock(&sf_g->ino_idr_lock);
+	idr_remove(&sf_g->ino_idr, inode->i_ino);
+	spin_unlock(&sf_g->ino_idr_lock);
+	kmem_cache_free(sf_inode_cachep, GET_INODE_INFO(inode));
+}
+
+static void sf_destroy_inode(struct inode *inode)
+{
+	call_rcu(&inode->i_rcu, sf_i_callback);
+}
+
+static void sf_put_super(struct super_block *sb)
+{
+	struct sf_glob_info *sf_g = GET_GLOB_INFO(sb);
+
+	vboxsf_unmap_folder(sf_g->root);
+	if (sf_g->bdi_id >= 0)
+		ida_simple_remove(&vboxsf_bdi_ida, sf_g->bdi_id);
+	if (sf_g->nls)
+		unload_nls(sf_g->nls);
+	idr_destroy(&sf_g->ino_idr);
+	kfree(sf_g);
+}
+
+static int sf_statfs(struct dentry *dentry, struct kstatfs *stat)
+{
+	struct super_block *sb = dentry->d_sb;
+	struct shfl_volinfo SHFLVolumeInfo;
+	struct sf_glob_info *sf_g;
+	u32 buf_len;
+	int err;
+
+	sf_g = GET_GLOB_INFO(sb);
+	buf_len = sizeof(SHFLVolumeInfo);
+	err = vboxsf_fsinfo(sf_g->root, 0, SHFL_INFO_GET | SHFL_INFO_VOLUME,
+			    &buf_len, &SHFLVolumeInfo);
+	if (err)
+		return err;
+
+	stat->f_type = VBOXSF_SUPER_MAGIC;
+	stat->f_bsize = SHFLVolumeInfo.bytes_per_allocation_unit;
+
+	do_div(SHFLVolumeInfo.total_allocation_bytes,
+	       SHFLVolumeInfo.bytes_per_allocation_unit);
+	stat->f_blocks = SHFLVolumeInfo.total_allocation_bytes;
+
+	do_div(SHFLVolumeInfo.available_allocation_bytes,
+	       SHFLVolumeInfo.bytes_per_allocation_unit);
+	stat->f_bfree  = SHFLVolumeInfo.available_allocation_bytes;
+	stat->f_bavail = SHFLVolumeInfo.available_allocation_bytes;
+
+	stat->f_files = 1000;
+	/*
+	 * Don't return 0 here since the guest may then think that it is not
+	 * possible to create any more files.
+	 */
+	stat->f_ffree = 1000000;
+	stat->f_fsid.val[0] = 0;
+	stat->f_fsid.val[1] = 0;
+	stat->f_namelen = 255;
+	return 0;
+}
+
+static struct super_operations vboxsf_super_ops = {
+	.alloc_inode	= sf_alloc_inode,
+	.destroy_inode	= sf_destroy_inode,
+	.put_super	= sf_put_super,
+	.statfs		= sf_statfs,
+};
+
+static int vboxsf_setup(void)
+{
+	int err;
+
+	mutex_lock(&vboxsf_setup_mutex);
+
+	if (vboxsf_setup_done)
+		goto success;
+
+	sf_inode_cachep = kmem_cache_create("vboxsf_inode_cache",
+					     sizeof(struct sf_inode_info),
+					     0, (SLAB_RECLAIM_ACCOUNT|
+						SLAB_MEM_SPREAD|SLAB_ACCOUNT),
+					     sf_inode_init_once);
+	if (sf_inode_cachep == NULL) {
+		err = -ENOMEM;
+		goto fail_nomem;
+	}
+
+	err = vboxsf_connect();
+	if (err) {
+		vbg_err("vboxsf: err %d connecting to guest PCI-device\n", err);
+		vbg_err("vboxsf: make sure you are inside a VirtualBox VM\n");
+		vbg_err("vboxsf: and check dmesg for vboxguest errors\n");
+		goto fail_free_cache;
+	}
+
+	err = vboxsf_set_utf8();
+	if (err) {
+		vbg_err("vboxsf_setutf8 error %d\n", err);
+		goto fail_disconnect;
+	}
+
+	if (!follow_symlinks) {
+		err = vboxsf_set_symlinks();
+		if (err)
+			vbg_warn("vboxsf: Unable to show symlinks: %d\n", err);
+	}
+
+	vboxsf_setup_done = true;
+success:
+	mutex_unlock(&vboxsf_setup_mutex);
+	return 0;
+
+fail_disconnect:
+	vboxsf_disconnect();
+fail_free_cache:
+	kmem_cache_destroy(sf_inode_cachep);
+fail_nomem:
+	mutex_unlock(&vboxsf_setup_mutex);
+	return err;
+}
+
+int vboxsf_parse_monolithic(struct fs_context *fc, void *data)
+{
+	char *options = data;
+
+	if (options && options[0] == VBSF_MOUNT_SIGNATURE_BYTE_0 &&
+		       options[1] == VBSF_MOUNT_SIGNATURE_BYTE_1 &&
+		       options[2] == VBSF_MOUNT_SIGNATURE_BYTE_2 &&
+		       options[3] == VBSF_MOUNT_SIGNATURE_BYTE_3) {
+		vbg_err("vboxsf: Old binary mount data not supported, remove obsolete mount.vboxsf and/or update your VBoxService.\n");
+		return -EINVAL;
+	}
+
+	return generic_parse_monolithic(fc, data);
+}
+
+static int vboxsf_get_tree(struct fs_context *fc)
+{
+	int err;
+
+	err = vboxsf_setup();
+	if (err)
+		return err;
+
+	return vfs_get_super(fc, vfs_get_independent_super, vboxsf_fill_super);
+}
+
+static int vboxsf_reconfigure(struct fs_context *fc)
+{
+	struct sf_glob_info *sf_g = GET_GLOB_INFO(fc->root->d_sb);
+	struct vboxsf_fs_context *ctx = fc->fs_private;
+	struct inode *iroot;
+
+	iroot = ilookup(fc->root->d_sb, 0);
+	if (!iroot)
+		return -ENOENT;
+
+	/* Apply changed options to the root inode */
+	sf_g->o = ctx->o;
+	vboxsf_init_inode(sf_g, iroot, &sf_g->root_info);
+
+	return 0;
+}
+
+static void vboxsf_free_fc(struct fs_context *fc)
+{
+	struct vboxsf_fs_context *ctx = fc->fs_private;
+
+	kfree(ctx->nls_name);
+	kfree(ctx);
+}
+
+static const struct fs_context_operations vboxsf_context_ops = {
+	.free			= vboxsf_free_fc,
+	.parse_param		= vboxsf_parse_param,
+	.parse_monolithic	= vboxsf_parse_monolithic,
+	.get_tree		= vboxsf_get_tree,
+	.reconfigure		= vboxsf_reconfigure,
+};
+
+static int vboxsf_init_fs_context(struct fs_context *fc)
+{
+	struct vboxsf_fs_context *ctx;
+
+	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+
+	/* ~0 means use whatever the host gives as mode info */
+	ctx->o.dmode = ~0;
+	ctx->o.fmode = ~0;
+
+	fc->fs_private = ctx;
+	fc->ops = &vboxsf_context_ops;
+	return 0;
+}
+
+static struct file_system_type vboxsf_fs_type = {
+	.owner			= THIS_MODULE,
+	.name			= "vboxsf",
+	.init_fs_context	= vboxsf_init_fs_context,
+	.parameters		= &vboxsf_fs_parameters,
+	.kill_sb		= kill_anon_super
+};
+
+/* Module initialization/finalization handlers */
+static int __init vboxsf_init(void)
+{
+	return register_filesystem(&vboxsf_fs_type);
+}
+
+static void __exit vboxsf_fini(void)
+{
+	unregister_filesystem(&vboxsf_fs_type);
+
+	mutex_lock(&vboxsf_setup_mutex);
+	if (vboxsf_setup_done) {
+		vboxsf_disconnect();
+		/*
+		 * Make sure all delayed rcu free inodes are flushed
+		 * before we destroy the cache.
+		 */
+		rcu_barrier();
+		kmem_cache_destroy(sf_inode_cachep);
+	}
+	mutex_unlock(&vboxsf_setup_mutex);
+}
+
+module_init(vboxsf_init);
+module_exit(vboxsf_fini);
+
+MODULE_DESCRIPTION("Oracle VM VirtualBox Module for Host File System Access");
+MODULE_AUTHOR("Oracle Corporation");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS_FS("vboxsf");
diff --git a/fs/vboxsf/utils.c b/fs/vboxsf/utils.c
new file mode 100644
index 000000000000..2d42b5836fa9
--- /dev/null
+++ b/fs/vboxsf/utils.c
@@ -0,0 +1,568 @@
+// SPDX-License-Identifier: MIT
+/*
+ * VirtualBox Guest Shared Folders support: Utility functions.
+ * Mainly conversion from/to VirtualBox/Linux data structures.
+ *
+ * Copyright (C) 2006-2018 Oracle Corporation
+ */
+
+#include <linux/namei.h>
+#include <linux/nls.h>
+#include <linux/sizes.h>
+#include <linux/vfs.h>
+#include "vfsmod.h"
+
+struct inode *vboxsf_new_inode(struct super_block *sb)
+{
+	struct sf_glob_info *sf_g = GET_GLOB_INFO(sb);
+	struct inode *inode;
+	int cursor, ret;
+	u32 gen;
+
+	inode = new_inode(sb);
+	if (!inode)
+		return ERR_PTR(-ENOMEM);
+
+	idr_preload(GFP_KERNEL);
+	spin_lock(&sf_g->ino_idr_lock);
+	cursor = idr_get_cursor(&sf_g->ino_idr);
+	ret = idr_alloc_cyclic(&sf_g->ino_idr, inode, 1, 0, GFP_ATOMIC);
+	if (ret >= 0 && ret < cursor)
+		sf_g->next_generation++;
+	gen = sf_g->next_generation;
+	spin_unlock(&sf_g->ino_idr_lock);
+	idr_preload_end();
+
+	if (ret < 0) {
+		iput(inode);
+		return ERR_PTR(ret);
+	}
+
+	inode->i_ino = ret;
+	inode->i_generation = gen;
+	return inode;
+}
+
+/* set [inode] attributes based on [info], uid/gid based on [sf_g] */
+void vboxsf_init_inode(struct sf_glob_info *sf_g, struct inode *inode,
+		       const struct shfl_fsobjinfo *info)
+{
+	const struct shfl_fsobjattr *attr;
+	s64 allocated;
+	int mode;
+
+	attr = &info->attr;
+
+#define mode_set(r) ((attr->mode & (SHFL_UNIX_##r)) ? (S_##r) : 0)
+
+	mode = mode_set(IRUSR);
+	mode |= mode_set(IWUSR);
+	mode |= mode_set(IXUSR);
+
+	mode |= mode_set(IRGRP);
+	mode |= mode_set(IWGRP);
+	mode |= mode_set(IXGRP);
+
+	mode |= mode_set(IROTH);
+	mode |= mode_set(IWOTH);
+	mode |= mode_set(IXOTH);
+
+#undef mode_set
+
+	/* We use the host-side values for these */
+	inode->i_flags |= S_NOATIME | S_NOCMTIME;
+	inode->i_mapping->a_ops = &vboxsf_reg_aops;
+
+	if (SHFL_IS_DIRECTORY(attr->mode)) {
+		inode->i_mode =
+			sf_g->o.dmode != ~0 ? (sf_g->o.dmode & 0777) : mode;
+		inode->i_mode &= ~sf_g->o.dmask;
+		inode->i_mode |= S_IFDIR;
+		inode->i_op = &vboxsf_dir_iops;
+		inode->i_fop = &vboxsf_dir_fops;
+		/*
+		 * XXX: this probably should be set to the number of entries
+		 * in the directory plus two (. ..)
+		 */
+		set_nlink(inode, 1);
+	} else if (SHFL_IS_SYMLINK(attr->mode)) {
+		inode->i_mode =
+			sf_g->o.fmode != ~0 ? (sf_g->o.fmode & 0777) : mode;
+		inode->i_mode &= ~sf_g->o.fmask;
+		inode->i_mode |= S_IFLNK;
+		inode->i_op = &vboxsf_lnk_iops;
+		set_nlink(inode, 1);
+	} else {
+		inode->i_mode =
+			sf_g->o.fmode != ~0 ? (sf_g->o.fmode & 0777) : mode;
+		inode->i_mode &= ~sf_g->o.fmask;
+		inode->i_mode |= S_IFREG;
+		inode->i_op = &vboxsf_reg_iops;
+		inode->i_fop = &vboxsf_reg_fops;
+		set_nlink(inode, 1);
+	}
+
+	inode->i_uid = make_kuid(current_user_ns(), sf_g->o.uid);
+	inode->i_gid = make_kgid(current_user_ns(), sf_g->o.gid);
+
+	inode->i_size = info->size;
+	inode->i_blkbits = 12;
+	/* i_blocks always in units of 512 bytes! */
+	allocated = info->allocated + 511;
+	do_div(allocated, 512);
+	inode->i_blocks = allocated;
+
+	inode->i_atime = ns_to_timespec64(
+				 info->access_time.ns_relative_to_unix_epoch);
+	inode->i_ctime = ns_to_timespec64(
+				 info->change_time.ns_relative_to_unix_epoch);
+	inode->i_mtime = ns_to_timespec64(
+			   info->modification_time.ns_relative_to_unix_epoch);
+}
+
+int vboxsf_create_at_dentry(struct dentry *dentry,
+			    struct shfl_createparms *params)
+{
+	struct sf_glob_info *sf_g = GET_GLOB_INFO(dentry->d_sb);
+	struct shfl_string *path;
+	int err;
+
+	path = vboxsf_path_from_dentry(sf_g, dentry);
+	if (IS_ERR(path))
+		return PTR_ERR(path);
+
+	err = vboxsf_create(sf_g->root, path, params);
+	__putname(path);
+
+	return err;
+}
+
+int vboxsf_stat(struct sf_glob_info *sf_g, struct shfl_string *path,
+		struct shfl_fsobjinfo *info)
+{
+	struct shfl_createparms params = {};
+	int err;
+
+	params.handle = SHFL_HANDLE_NIL;
+	params.create_flags = SHFL_CF_LOOKUP | SHFL_CF_ACT_FAIL_IF_NEW;
+
+	err = vboxsf_create(sf_g->root, path, &params);
+	if (err)
+		return err;
+
+	if (params.result != SHFL_FILE_EXISTS)
+		return -ENOENT;
+
+	if (info)
+		*info = params.info;
+
+	return 0;
+}
+
+int vboxsf_stat_dentry(struct dentry *dentry, struct shfl_fsobjinfo *info)
+{
+	struct sf_glob_info *sf_g = GET_GLOB_INFO(dentry->d_sb);
+	struct shfl_string *path;
+	int err;
+
+	path = vboxsf_path_from_dentry(sf_g, dentry);
+	if (IS_ERR(path))
+		return PTR_ERR(path);
+
+	err = vboxsf_stat(sf_g, path, info);
+	__putname(path);
+	return err;
+}
+
+int vboxsf_inode_revalidate(struct dentry *dentry)
+{
+	struct sf_glob_info *sf_g = GET_GLOB_INFO(dentry->d_sb);
+	struct sf_inode_info *sf_i;
+	struct shfl_fsobjinfo info;
+	struct timespec64 prev_mtime;
+	struct inode *inode;
+	int err;
+
+	if (!dentry || !d_really_is_positive(dentry))
+		return -EINVAL;
+
+	inode = d_inode(dentry);
+	prev_mtime = inode->i_mtime;
+	sf_i = GET_INODE_INFO(inode);
+	if (!sf_i->force_restat) {
+		if (time_before(jiffies, dentry->d_time + sf_g->o.ttl))
+			return 0;
+	}
+
+	err = vboxsf_stat_dentry(dentry, &info);
+	if (err)
+		return err;
+
+	dentry->d_time = jiffies;
+	sf_i->force_restat = 0;
+	vboxsf_init_inode(sf_g, inode, &info);
+
+	/*
+	 * mmap()-ed files use the page-cache, if the file was changed on the
+	 * host side we need to invalidate the page-cache for it.  Note this
+	 * also gets triggered by our own writes, this is unavoidable.
+	 */
+	if (timespec64_compare(&inode->i_mtime, &prev_mtime) > 0)
+		invalidate_mapping_pages(inode->i_mapping, 0, -1);
+
+	return 0;
+}
+
+int vboxsf_getattr(const struct path *path, struct kstat *kstat,
+		   u32 request_mask, unsigned int flags)
+{
+	int err;
+	struct dentry *dentry = path->dentry;
+	struct inode *inode = d_inode(dentry);
+	struct sf_inode_info *sf_i = GET_INODE_INFO(inode);
+
+	switch (flags & AT_STATX_SYNC_TYPE) {
+	case AT_STATX_DONT_SYNC:
+		err = 0;
+		break;
+	case AT_STATX_FORCE_SYNC:
+		sf_i->force_restat = 1;
+		/* fall-through */
+	default:
+		err = vboxsf_inode_revalidate(dentry);
+	}
+	if (err)
+		return err;
+
+	generic_fillattr(d_inode(dentry), kstat);
+	return 0;
+}
+
+int vboxsf_setattr(struct dentry *dentry, struct iattr *iattr)
+{
+	struct sf_inode_info *sf_i = GET_INODE_INFO(d_inode(dentry));
+	struct sf_glob_info *sf_g = GET_GLOB_INFO(dentry->d_sb);
+	struct shfl_createparms params = {};
+	struct shfl_fsobjinfo info = {};
+	uint32_t buf_len;
+	int err;
+
+	params.handle = SHFL_HANDLE_NIL;
+	params.create_flags = SHFL_CF_ACT_OPEN_IF_EXISTS |
+			      SHFL_CF_ACT_FAIL_IF_NEW |
+			      SHFL_CF_ACCESS_ATTR_WRITE;
+
+	/* this is at least required for Posix hosts */
+	if (iattr->ia_valid & ATTR_SIZE)
+		params.create_flags |= SHFL_CF_ACCESS_WRITE;
+
+	err = vboxsf_create_at_dentry(dentry, &params);
+	if (err || params.result != SHFL_FILE_EXISTS)
+		return err ? err : -ENOENT;
+
+#define mode_set(r) ((iattr->ia_mode & (S_##r)) ? SHFL_UNIX_##r : 0)
+
+	/*
+	 * Setting the file size and setting the other attributes has to
+	 * be handled separately.
+	 */
+	if (iattr->ia_valid & (ATTR_MODE | ATTR_ATIME | ATTR_MTIME)) {
+		if (iattr->ia_valid & ATTR_MODE) {
+			info.attr.mode = mode_set(IRUSR);
+			info.attr.mode |= mode_set(IWUSR);
+			info.attr.mode |= mode_set(IXUSR);
+			info.attr.mode |= mode_set(IRGRP);
+			info.attr.mode |= mode_set(IWGRP);
+			info.attr.mode |= mode_set(IXGRP);
+			info.attr.mode |= mode_set(IROTH);
+			info.attr.mode |= mode_set(IWOTH);
+			info.attr.mode |= mode_set(IXOTH);
+
+			if (iattr->ia_mode & S_IFDIR)
+				info.attr.mode |= SHFL_TYPE_DIRECTORY;
+			else
+				info.attr.mode |= SHFL_TYPE_FILE;
+		}
+
+		if (iattr->ia_valid & ATTR_ATIME)
+			info.access_time.ns_relative_to_unix_epoch =
+					    timespec64_to_ns(&iattr->ia_atime);
+
+		if (iattr->ia_valid & ATTR_MTIME)
+			info.modification_time.ns_relative_to_unix_epoch =
+					    timespec64_to_ns(&iattr->ia_mtime);
+
+		/*
+		 * Ignore ctime (inode change time) as it can't be set
+		 * from userland anyway.
+		 */
+
+		buf_len = sizeof(info);
+		err = vboxsf_fsinfo(sf_g->root, params.handle,
+				   SHFL_INFO_SET | SHFL_INFO_FILE, &buf_len,
+				   &info);
+		if (err) {
+			vboxsf_close(sf_g->root, params.handle);
+			return err;
+		}
+
+		/* the host may have given us different attr then requested */
+		sf_i->force_restat = 1;
+	}
+
+#undef mode_set
+
+	if (iattr->ia_valid & ATTR_SIZE) {
+		memset(&info, 0, sizeof(info));
+		info.size = iattr->ia_size;
+		buf_len = sizeof(info);
+		err = vboxsf_fsinfo(sf_g->root, params.handle,
+				   SHFL_INFO_SET | SHFL_INFO_SIZE, &buf_len,
+				   &info);
+		if (err) {
+			vboxsf_close(sf_g->root, params.handle);
+			return err;
+		}
+
+		/* the host may have given us different attr then requested */
+		sf_i->force_restat = 1;
+	}
+
+	vboxsf_close(sf_g->root, params.handle);
+
+	/* Update the inode with what the host has actually given us. */
+	if (sf_i->force_restat)
+		vboxsf_inode_revalidate(dentry);
+
+	return 0;
+}
+
+/*
+ * [dentry] contains string encoded in coding system that corresponds
+ * to [sf_g]->nls, we must convert it to UTF8 here.
+ * Returns a shfl_string allocated through __getname (must be freed using
+ * __putname), or an ERR_PTR on error.
+ */
+struct shfl_string *vboxsf_path_from_dentry(struct sf_glob_info *sf_g,
+					    struct dentry *dentry)
+{
+	struct shfl_string *shfl_path;
+	int path_len, out_len, nb;
+	char *buf, *path;
+	wchar_t uni;
+	u8 *out;
+
+	buf = __getname();
+	if (!buf)
+		return ERR_PTR(-ENOMEM);
+
+	path = dentry_path_raw(dentry, buf, PATH_MAX);
+	if (IS_ERR(path)) {
+		__putname(buf);
+		return (struct shfl_string *)path;
+	}
+	path_len = strlen(path);
+
+	if (sf_g->nls) {
+		shfl_path = __getname();
+		if (!shfl_path) {
+			__putname(buf);
+			return ERR_PTR(-ENOMEM);
+		}
+
+		out = shfl_path->string.utf8;
+		out_len = PATH_MAX - SHFLSTRING_HEADER_SIZE - 1;
+
+		while (path_len) {
+			nb = sf_g->nls->char2uni(path, path_len, &uni);
+			if (nb < 0) {
+				__putname(shfl_path);
+				__putname(buf);
+				return ERR_PTR(-EINVAL);
+			}
+			path += nb;
+			path_len -= nb;
+
+			nb = utf32_to_utf8(uni, out, out_len);
+			if (nb < 0) {
+				__putname(shfl_path);
+				__putname(buf);
+				return ERR_PTR(-ENAMETOOLONG);
+			}
+			out += nb;
+			out_len -= nb;
+		}
+		*out = 0;
+		shfl_path->length = out - shfl_path->string.utf8;
+		shfl_path->size = shfl_path->length + 1;
+		__putname(buf);
+	} else {
+		if ((SHFLSTRING_HEADER_SIZE + path_len + 1) > PATH_MAX) {
+			__putname(buf);
+			return ERR_PTR(-ENAMETOOLONG);
+		}
+		/*
+		 * dentry_path stores the name at the end of buf, but the
+		 * shfl_string string we return must be properly aligned.
+		 */
+		shfl_path = (struct shfl_string *)buf;
+		memmove(shfl_path->string.utf8, path, path_len);
+		shfl_path->string.utf8[path_len] = 0;
+		shfl_path->length = path_len;
+		shfl_path->size = path_len + 1;
+	}
+
+	return shfl_path;
+}
+
+int vboxsf_nlscpy(struct sf_glob_info *sf_g, char *name, size_t name_bound_len,
+		  const unsigned char *utf8_name, size_t utf8_len)
+{
+	if (sf_g->nls) {
+		const char *in;
+		char *out;
+		size_t out_len;
+		size_t out_bound_len;
+		size_t in_bound_len;
+
+		in = utf8_name;
+		in_bound_len = utf8_len;
+
+		out = name;
+		out_len = 0;
+		/* Reserve space for terminating 0 */
+		out_bound_len = name_bound_len - 1;
+
+		while (in_bound_len) {
+			int nb;
+			unicode_t uni;
+
+			nb = utf8_to_utf32(in, in_bound_len, &uni);
+			if (nb < 0)
+				return -EINVAL;
+
+			in += nb;
+			in_bound_len -= nb;
+
+			nb = sf_g->nls->uni2char(uni, out, out_bound_len);
+			if (nb < 0)
+				return nb;
+
+			out += nb;
+			out_bound_len -= nb;
+			out_len += nb;
+		}
+
+		*out = 0;
+	} else {
+		if (utf8_len + 1 > name_bound_len)
+			return -ENAMETOOLONG;
+
+		memcpy(name, utf8_name, utf8_len + 1);
+	}
+	return 0;
+}
+
+static struct sf_dir_buf *sf_dir_buf_alloc(struct list_head *list)
+{
+	struct sf_dir_buf *b;
+
+	b = kmalloc(sizeof(*b), GFP_KERNEL);
+	if (!b)
+		return NULL;
+
+	b->buf = kmalloc(DIR_BUFFER_SIZE, GFP_KERNEL);
+	if (!b->buf) {
+		kfree(b);
+		return NULL;
+	}
+
+	b->entries = 0;
+	b->used = 0;
+	b->free = DIR_BUFFER_SIZE;
+	list_add(&b->head, list);
+
+	return b;
+}
+
+static void sf_dir_buf_free(struct sf_dir_buf *b)
+{
+	list_del(&b->head);
+	kfree(b->buf);
+	kfree(b);
+}
+
+/**
+ * vboxsf_dir_info_alloc - Create a new directory buffer descriptor
+ *
+ * Returns:
+ * Created sf_dir_info buffer, or NULL when malloc fails
+ */
+struct sf_dir_info *vboxsf_dir_info_alloc(void)
+{
+	struct sf_dir_info *p;
+
+	p = kmalloc(sizeof(*p), GFP_KERNEL);
+	if (!p)
+		return NULL;
+
+	INIT_LIST_HEAD(&p->info_list);
+	return p;
+}
+
+/**
+ * vboxsf_dir_info_free - Free the directory buffer
+ * @p:		sf_dir_info buffer to free
+ */
+void vboxsf_dir_info_free(struct sf_dir_info *p)
+{
+	struct list_head *list, *pos, *tmp;
+
+	list = &p->info_list;
+	list_for_each_safe(pos, tmp, list) {
+		struct sf_dir_buf *b;
+
+		b = list_entry(pos, struct sf_dir_buf, head);
+		sf_dir_buf_free(b);
+	}
+	kfree(p);
+}
+
+int vboxsf_dir_read_all(struct sf_glob_info *sf_g, struct sf_dir_info *sf_d,
+			u64 handle)
+{
+	struct sf_dir_buf *b;
+	u32 entries, size;
+	int err = 0;
+	void *buf;
+
+	/* vboxsf_dirinfo returns 1 on end of dir */
+	while (err == 0) {
+		b = sf_dir_buf_alloc(&sf_d->info_list);
+		if (!b) {
+			err = -ENOMEM;
+			break;
+		}
+
+		buf = b->buf;
+		size = b->free;
+
+		err = vboxsf_dirinfo(sf_g->root, handle, NULL, 0, 0,
+				     &size, buf, &entries);
+		if (err < 0)
+			break;
+
+		b->entries += entries;
+		b->free -= size;
+		b->used += size;
+	}
+
+	if (b && b->used == 0)
+		sf_dir_buf_free(b);
+
+	/* -EILSEQ means the host could not translate a filename, ignore */
+	if (err > 0 || err == -EILSEQ)
+		err = 0;
+
+	return err;
+}
diff --git a/fs/vboxsf/vboxsf_wrappers.c b/fs/vboxsf/vboxsf_wrappers.c
new file mode 100644
index 000000000000..fb13b894c8b4
--- /dev/null
+++ b/fs/vboxsf/vboxsf_wrappers.c
@@ -0,0 +1,379 @@
+// SPDX-License-Identifier: MIT
+/*
+ * Wrapper functions for the shfl host calls.
+ *
+ * Copyright (C) 2006-2018 Oracle Corporation
+ */
+
+#include <linux/mm.h>
+#include <linux/slab.h>
+#include <linux/vbox_err.h>
+#include <linux/vbox_utils.h>
+#include "vfsmod.h"
+
+#define SHFL_REQUEST \
+	(VMMDEV_REQUESTOR_KERNEL | VMMDEV_REQUESTOR_USR_DRV_OTHER | \
+	 VMMDEV_REQUESTOR_CON_DONT_KNOW | VMMDEV_REQUESTOR_TRUST_NOT_GIVEN)
+
+static u32 vboxsf_client_id;
+
+int vboxsf_connect(void)
+{
+	struct vbg_dev *gdev;
+	struct vmmdev_hgcm_service_location loc;
+	int err, vbox_status;
+
+	loc.type = VMMDEV_HGCM_LOC_LOCALHOST_EXISTING;
+	strcpy(loc.u.localhost.service_name, "VBoxSharedFolders");
+
+	gdev = vbg_get_gdev();
+	if (IS_ERR(gdev))
+		return -ENODEV;	/* No guest-device */
+
+	err = vbg_hgcm_connect(gdev, SHFL_REQUEST, &loc,
+			       &vboxsf_client_id, &vbox_status);
+	vbg_put_gdev(gdev);
+
+	return err ? err : vbg_status_code_to_errno(vbox_status);
+}
+
+void vboxsf_disconnect(void)
+{
+	struct vbg_dev *gdev;
+	int vbox_status;
+
+	gdev = vbg_get_gdev();
+	if (IS_ERR(gdev))
+		return;   /* guest-device is gone, already disconnected */
+
+	vbg_hgcm_disconnect(gdev, SHFL_REQUEST, vboxsf_client_id, &vbox_status);
+	vbg_put_gdev(gdev);
+}
+
+static int vboxsf_call(u32 function, void *parms, u32 parm_count, int *status)
+{
+	struct vbg_dev *gdev;
+	int err, vbox_status;
+
+	gdev = vbg_get_gdev();
+	if (IS_ERR(gdev))
+		return -ESHUTDOWN; /* guest-dev removed underneath us */
+
+	err = vbg_hgcm_call(gdev, SHFL_REQUEST, vboxsf_client_id, function,
+			    U32_MAX, parms, parm_count, &vbox_status);
+	vbg_put_gdev(gdev);
+
+	if (err < 0)
+		return err;
+
+	if (status)
+		*status = vbox_status;
+
+	return vbg_status_code_to_errno(vbox_status);
+}
+
+int vboxsf_map_folder(struct shfl_string *folder_name, u32 *root)
+{
+	struct shfl_map_folder parms;
+	int err, status;
+
+	parms.path.type = VMMDEV_HGCM_PARM_TYPE_LINADDR_KERNEL;
+	parms.path.u.pointer.size = shfl_string_buf_size(folder_name);
+	parms.path.u.pointer.u.linear_addr = (uintptr_t)folder_name;
+
+	parms.root.type = VMMDEV_HGCM_PARM_TYPE_32BIT;
+	parms.root.u.value32 = 0;
+
+	parms.delimiter.type = VMMDEV_HGCM_PARM_TYPE_32BIT;
+	parms.delimiter.u.value32 = '/';
+
+	parms.case_sensitive.type = VMMDEV_HGCM_PARM_TYPE_32BIT;
+	parms.case_sensitive.u.value32 = 1;
+
+	err = vboxsf_call(SHFL_FN_MAP_FOLDER, &parms, SHFL_CPARMS_MAP_FOLDER,
+			  &status);
+	if (err == -ENOSYS && status == VERR_NOT_IMPLEMENTED)
+		vbg_err("%s: Error host is too old\n", __func__);
+
+	*root = parms.root.u.value32;
+	return err;
+}
+
+int vboxsf_unmap_folder(u32 root)
+{
+	struct shfl_unmap_folder parms;
+
+	parms.root.type = VMMDEV_HGCM_PARM_TYPE_32BIT;
+	parms.root.u.value32 = root;
+
+	return vboxsf_call(SHFL_FN_UNMAP_FOLDER, &parms,
+			   SHFL_CPARMS_UNMAP_FOLDER, NULL);
+}
+
+/**
+ * vboxsf_create - Create a new file or folder
+ * @root:         Root of the shared folder in which to create the file
+ * @parsed_path:  The path of the file or folder relative to the shared folder
+ * @param:        create_parms Parameters for file/folder creation.
+ *
+ * Create a new file or folder or open an existing one in a shared folder.
+ * Note this function always returns 0 / success unless an exceptional condition
+ * occurs - out of memory, invalid arguments, etc. If the file or folder could
+ * not be opened or created, create_parms->handle will be set to
+ * SHFL_HANDLE_NIL on return.  In this case the value in create_parms->result
+ * provides information as to why (e.g. SHFL_FILE_EXISTS), create_parms->result
+ * is also set on success as additional information.
+ *
+ * Returns:
+ * 0 or negative errno value.
+ */
+int vboxsf_create(u32 root, struct shfl_string *parsed_path,
+		  struct shfl_createparms *create_parms)
+{
+	struct shfl_create parms;
+
+	parms.root.type = VMMDEV_HGCM_PARM_TYPE_32BIT;
+	parms.root.u.value32 = root;
+
+	parms.path.type = VMMDEV_HGCM_PARM_TYPE_LINADDR_KERNEL;
+	parms.path.u.pointer.size = shfl_string_buf_size(parsed_path);
+	parms.path.u.pointer.u.linear_addr = (uintptr_t)parsed_path;
+
+	parms.parms.type = VMMDEV_HGCM_PARM_TYPE_LINADDR_KERNEL;
+	parms.parms.u.pointer.size = sizeof(struct shfl_createparms);
+	parms.parms.u.pointer.u.linear_addr = (uintptr_t)create_parms;
+
+	return vboxsf_call(SHFL_FN_CREATE, &parms, SHFL_CPARMS_CREATE, NULL);
+}
+
+int vboxsf_close(u32 root, u64 handle)
+{
+	struct shfl_close parms;
+
+	parms.root.type = VMMDEV_HGCM_PARM_TYPE_32BIT;
+	parms.root.u.value32 = root;
+
+	parms.handle.type = VMMDEV_HGCM_PARM_TYPE_64BIT;
+	parms.handle.u.value64 = handle;
+
+	return vboxsf_call(SHFL_FN_CLOSE, &parms, SHFL_CPARMS_CLOSE, NULL);
+}
+
+int vboxsf_remove(u32 root, struct shfl_string *parsed_path, u32 flags)
+{
+	struct shfl_remove parms;
+
+	parms.root.type = VMMDEV_HGCM_PARM_TYPE_32BIT;
+	parms.root.u.value32 = root;
+
+	parms.path.type = VMMDEV_HGCM_PARM_TYPE_LINADDR_KERNEL_IN;
+	parms.path.u.pointer.size = shfl_string_buf_size(parsed_path);
+	parms.path.u.pointer.u.linear_addr = (uintptr_t)parsed_path;
+
+	parms.flags.type = VMMDEV_HGCM_PARM_TYPE_32BIT;
+	parms.flags.u.value32 = flags;
+
+	return vboxsf_call(SHFL_FN_REMOVE, &parms, SHFL_CPARMS_REMOVE, NULL);
+}
+
+int vboxsf_rename(u32 root, struct shfl_string *src_path,
+		  struct shfl_string *dest_path, u32 flags)
+{
+	struct shfl_rename parms;
+
+	parms.root.type = VMMDEV_HGCM_PARM_TYPE_32BIT;
+	parms.root.u.value32 = root;
+
+	parms.src.type = VMMDEV_HGCM_PARM_TYPE_LINADDR_KERNEL_IN;
+	parms.src.u.pointer.size = shfl_string_buf_size(src_path);
+	parms.src.u.pointer.u.linear_addr = (uintptr_t)src_path;
+
+	parms.dest.type = VMMDEV_HGCM_PARM_TYPE_LINADDR_KERNEL_IN;
+	parms.dest.u.pointer.size = shfl_string_buf_size(dest_path);
+	parms.dest.u.pointer.u.linear_addr = (uintptr_t)dest_path;
+
+	parms.flags.type = VMMDEV_HGCM_PARM_TYPE_32BIT;
+	parms.flags.u.value32 = flags;
+
+	return vboxsf_call(SHFL_FN_RENAME, &parms, SHFL_CPARMS_RENAME, NULL);
+}
+
+int vboxsf_read(u32 root, u64 handle, u64 offset,
+		u32 *buf_len, uintptr_t buf, bool user)
+{
+	struct shfl_read parms;
+	int err;
+
+	parms.root.type = VMMDEV_HGCM_PARM_TYPE_32BIT;
+	parms.root.u.value32 = root;
+
+	parms.handle.type = VMMDEV_HGCM_PARM_TYPE_64BIT;
+	parms.handle.u.value64 = handle;
+	parms.offset.type = VMMDEV_HGCM_PARM_TYPE_64BIT;
+	parms.offset.u.value64 = offset;
+	parms.cb.type = VMMDEV_HGCM_PARM_TYPE_32BIT;
+	parms.cb.u.value32 = *buf_len;
+	if (user)
+		parms.buffer.type = VMMDEV_HGCM_PARM_TYPE_LINADDR_OUT;
+	else
+		parms.buffer.type = VMMDEV_HGCM_PARM_TYPE_LINADDR_KERNEL_OUT;
+	parms.buffer.u.pointer.size = *buf_len;
+	parms.buffer.u.pointer.u.linear_addr = buf;
+
+	err = vboxsf_call(SHFL_FN_READ, &parms, SHFL_CPARMS_READ, NULL);
+
+	*buf_len = parms.cb.u.value32;
+	return err;
+}
+
+int vboxsf_write(u32 root, u64 handle, u64 offset,
+		 u32 *buf_len, uintptr_t buf, bool user)
+{
+	struct shfl_write parms;
+	int err;
+
+	parms.root.type = VMMDEV_HGCM_PARM_TYPE_32BIT;
+	parms.root.u.value32 = root;
+
+	parms.handle.type = VMMDEV_HGCM_PARM_TYPE_64BIT;
+	parms.handle.u.value64 = handle;
+	parms.offset.type = VMMDEV_HGCM_PARM_TYPE_64BIT;
+	parms.offset.u.value64 = offset;
+	parms.cb.type = VMMDEV_HGCM_PARM_TYPE_32BIT;
+	parms.cb.u.value32 = *buf_len;
+	if (user)
+		parms.buffer.type = VMMDEV_HGCM_PARM_TYPE_LINADDR_IN;
+	else
+		parms.buffer.type = VMMDEV_HGCM_PARM_TYPE_LINADDR_KERNEL_IN;
+	parms.buffer.u.pointer.size = *buf_len;
+	parms.buffer.u.pointer.u.linear_addr = buf;
+
+	err = vboxsf_call(SHFL_FN_WRITE, &parms, SHFL_CPARMS_WRITE, NULL);
+
+	*buf_len = parms.cb.u.value32;
+	return err;
+}
+
+/* Returns 0 on success, 1 on end-of-dir, negative errno otherwise */
+int vboxsf_dirinfo(u32 root, u64 handle,
+		   struct shfl_string *parsed_path, u32 flags, u32 index,
+		   u32 *buf_len, struct shfl_dirinfo *buf, u32 *file_count)
+{
+	struct shfl_list parms;
+	int err, status;
+
+	parms.root.type = VMMDEV_HGCM_PARM_TYPE_32BIT;
+	parms.root.u.value32 = root;
+
+	parms.handle.type = VMMDEV_HGCM_PARM_TYPE_64BIT;
+	parms.handle.u.value64 = handle;
+	parms.flags.type = VMMDEV_HGCM_PARM_TYPE_32BIT;
+	parms.flags.u.value32 = flags;
+	parms.cb.type = VMMDEV_HGCM_PARM_TYPE_32BIT;
+	parms.cb.u.value32 = *buf_len;
+	if (parsed_path) {
+		parms.path.type = VMMDEV_HGCM_PARM_TYPE_LINADDR_KERNEL_IN;
+		parms.path.u.pointer.size = shfl_string_buf_size(parsed_path);
+		parms.path.u.pointer.u.linear_addr = (uintptr_t)parsed_path;
+	} else {
+		parms.path.type = VMMDEV_HGCM_PARM_TYPE_LINADDR_IN;
+		parms.path.u.pointer.size = 0;
+		parms.path.u.pointer.u.linear_addr = 0;
+	}
+
+	parms.buffer.type = VMMDEV_HGCM_PARM_TYPE_LINADDR_KERNEL_OUT;
+	parms.buffer.u.pointer.size = *buf_len;
+	parms.buffer.u.pointer.u.linear_addr = (uintptr_t)buf;
+
+	parms.resume_point.type = VMMDEV_HGCM_PARM_TYPE_32BIT;
+	parms.resume_point.u.value32 = index;
+	parms.file_count.type = VMMDEV_HGCM_PARM_TYPE_32BIT;
+	parms.file_count.u.value32 = 0;	/* out parameter only */
+
+	err = vboxsf_call(SHFL_FN_LIST, &parms, SHFL_CPARMS_LIST, &status);
+	if (err == -ENODATA && status == VERR_NO_MORE_FILES)
+		err = 1;
+
+	*buf_len = parms.cb.u.value32;
+	*file_count = parms.file_count.u.value32;
+	return err;
+}
+
+int vboxsf_fsinfo(u32 root, u64 handle, u32 flags,
+		  u32 *buf_len, void *buf)
+{
+	struct shfl_information parms;
+	int err;
+
+	parms.root.type = VMMDEV_HGCM_PARM_TYPE_32BIT;
+	parms.root.u.value32 = root;
+
+	parms.handle.type = VMMDEV_HGCM_PARM_TYPE_64BIT;
+	parms.handle.u.value64 = handle;
+	parms.flags.type = VMMDEV_HGCM_PARM_TYPE_32BIT;
+	parms.flags.u.value32 = flags;
+	parms.cb.type = VMMDEV_HGCM_PARM_TYPE_32BIT;
+	parms.cb.u.value32 = *buf_len;
+	parms.info.type = VMMDEV_HGCM_PARM_TYPE_LINADDR_KERNEL;
+	parms.info.u.pointer.size = *buf_len;
+	parms.info.u.pointer.u.linear_addr = (uintptr_t)buf;
+
+	err = vboxsf_call(SHFL_FN_INFORMATION, &parms, SHFL_CPARMS_INFORMATION,
+			  NULL);
+
+	*buf_len = parms.cb.u.value32;
+	return err;
+}
+
+int vboxsf_readlink(u32 root, struct shfl_string *parsed_path,
+		    u32 buf_len, u8 *buf)
+{
+	struct shfl_readLink parms;
+
+	parms.root.type = VMMDEV_HGCM_PARM_TYPE_32BIT;
+	parms.root.u.value32 = root;
+
+	parms.path.type = VMMDEV_HGCM_PARM_TYPE_LINADDR_KERNEL_IN;
+	parms.path.u.pointer.size = shfl_string_buf_size(parsed_path);
+	parms.path.u.pointer.u.linear_addr = (uintptr_t)parsed_path;
+
+	parms.buffer.type = VMMDEV_HGCM_PARM_TYPE_LINADDR_KERNEL_OUT;
+	parms.buffer.u.pointer.size = buf_len;
+	parms.buffer.u.pointer.u.linear_addr = (uintptr_t)buf;
+
+	return vboxsf_call(SHFL_FN_READLINK, &parms, SHFL_CPARMS_READLINK,
+			   NULL);
+}
+
+int vboxsf_symlink(u32 root, struct shfl_string *new_path,
+		   struct shfl_string *old_path, struct shfl_fsobjinfo *buf)
+{
+	struct shfl_symlink parms;
+
+	parms.root.type = VMMDEV_HGCM_PARM_TYPE_32BIT;
+	parms.root.u.value32 = root;
+
+	parms.new_path.type = VMMDEV_HGCM_PARM_TYPE_LINADDR_KERNEL_IN;
+	parms.new_path.u.pointer.size = shfl_string_buf_size(new_path);
+	parms.new_path.u.pointer.u.linear_addr = (uintptr_t)new_path;
+
+	parms.old_path.type = VMMDEV_HGCM_PARM_TYPE_LINADDR_KERNEL_IN;
+	parms.old_path.u.pointer.size = shfl_string_buf_size(old_path);
+	parms.old_path.u.pointer.u.linear_addr = (uintptr_t)old_path;
+
+	parms.info.type = VMMDEV_HGCM_PARM_TYPE_LINADDR_KERNEL_OUT;
+	parms.info.u.pointer.size = sizeof(struct shfl_fsobjinfo);
+	parms.info.u.pointer.u.linear_addr = (uintptr_t)buf;
+
+	return vboxsf_call(SHFL_FN_SYMLINK, &parms, SHFL_CPARMS_SYMLINK, NULL);
+}
+
+int vboxsf_set_utf8(void)
+{
+	return vboxsf_call(SHFL_FN_SET_UTF8, NULL, 0, NULL);
+}
+
+int vboxsf_set_symlinks(void)
+{
+	return vboxsf_call(SHFL_FN_SET_SYMLINKS, NULL, 0, NULL);
+}
diff --git a/fs/vboxsf/vfsmod.h b/fs/vboxsf/vfsmod.h
new file mode 100644
index 000000000000..23a6e5deac4c
--- /dev/null
+++ b/fs/vboxsf/vfsmod.h
@@ -0,0 +1,138 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * VirtualBox Guest Shared Folders support: module header.
+ *
+ * Copyright (C) 2006-2018 Oracle Corporation
+ */
+
+#ifndef VFSMOD_H
+#define VFSMOD_H
+
+#include <linux/backing-dev.h>
+#include <linux/idr.h>
+#include <linux/version.h>
+#include "shfl_hostintf.h"
+
+#define DIR_BUFFER_SIZE SZ_16K
+
+/* The cast is to prevent assignment of void * to pointers of arbitrary type */
+#define GET_GLOB_INFO(sb)       ((struct sf_glob_info *)(sb)->s_fs_info)
+#define SET_GLOB_INFO(sb, sf_g) ((sb)->s_fs_info = (sf_g))
+#define GET_INODE_INFO(i)       container_of(i, struct sf_inode_info, vfs_inode)
+
+struct vboxsf_options {
+	int ttl;
+	int uid;
+	int gid;
+	int dmode;
+	int fmode;
+	int dmask;
+	int fmask;
+};
+
+struct vboxsf_fs_context {
+	struct vboxsf_options o;
+	char *nls_name;
+};
+
+/* per-shared folder information */
+struct sf_glob_info {
+	struct vboxsf_options o;
+	struct shfl_fsobjinfo root_info;
+	struct idr ino_idr;
+	spinlock_t ino_idr_lock;
+	struct nls_table *nls;
+	u32 next_generation;
+	u32 root;
+	int bdi_id;
+};
+
+/* per-inode information */
+struct sf_inode_info {
+	/* some information was changed, update data on next revalidate */
+	int force_restat;
+	/* list of open handles for this inode + lock protecting it */
+	struct list_head handle_list;
+	struct mutex handle_list_mutex;
+	/* The VFS inode struct */
+	struct inode vfs_inode;
+};
+
+struct sf_dir_info {
+	struct list_head info_list;
+};
+
+struct sf_dir_buf {
+	size_t entries;
+	size_t free;
+	size_t used;
+	void *buf;
+	struct list_head head;
+};
+
+/* globals */
+extern const struct inode_operations vboxsf_dir_iops;
+extern const struct inode_operations vboxsf_lnk_iops;
+extern const struct inode_operations vboxsf_reg_iops;
+extern const struct file_operations vboxsf_dir_fops;
+extern const struct file_operations vboxsf_reg_fops;
+extern const struct address_space_operations vboxsf_reg_aops;
+extern const struct dentry_operations vboxsf_dentry_ops;
+
+/* from utils.c */
+struct inode *vboxsf_new_inode(struct super_block *sb);
+void vboxsf_init_inode(struct sf_glob_info *sf_g, struct inode *inode,
+		       const struct shfl_fsobjinfo *info);
+int vboxsf_create_at_dentry(struct dentry *dentry,
+			    struct shfl_createparms *params);
+int vboxsf_stat(struct sf_glob_info *sf_g, struct shfl_string *path,
+		struct shfl_fsobjinfo *info);
+int vboxsf_stat_dentry(struct dentry *dentry, struct shfl_fsobjinfo *info);
+int vboxsf_inode_revalidate(struct dentry *dentry);
+int vboxsf_getattr(const struct path *path, struct kstat *kstat,
+		   u32 request_mask, unsigned int query_flags);
+int vboxsf_setattr(struct dentry *dentry, struct iattr *iattr);
+struct shfl_string *vboxsf_path_from_dentry(struct sf_glob_info *sf_g,
+					    struct dentry *dentry);
+int vboxsf_nlscpy(struct sf_glob_info *sf_g, char *name, size_t name_bound_len,
+		  const unsigned char *utf8_name, size_t utf8_len);
+struct sf_dir_info *vboxsf_dir_info_alloc(void);
+void vboxsf_dir_info_free(struct sf_dir_info *p);
+int vboxsf_dir_read_all(struct sf_glob_info *sf_g, struct sf_dir_info *sf_d,
+			u64 handle);
+
+/* from vboxsf_wrappers.c */
+int vboxsf_connect(void);
+void vboxsf_disconnect(void);
+
+int vboxsf_create(u32 root, struct shfl_string *parsed_path,
+		  struct shfl_createparms *create_parms);
+
+int vboxsf_close(u32 root, u64 handle);
+int vboxsf_remove(u32 root, struct shfl_string *parsed_path, u32 flags);
+int vboxsf_rename(u32 root, struct shfl_string *src_path,
+		  struct shfl_string *dest_path, u32 flags);
+
+int vboxsf_read(u32 root, u64 handle, u64 offset,
+		u32 *buf_len, uintptr_t buf, bool user);
+int vboxsf_write(u32 root, u64 handle, u64 offset,
+		 u32 *buf_len, uintptr_t buf, bool user);
+
+int vboxsf_dirinfo(u32 root, u64 handle,
+		   struct shfl_string *parsed_path, u32 flags, u32 index,
+		   u32 *buf_len, struct shfl_dirinfo *buf, u32 *file_count);
+int vboxsf_fsinfo(u32 root, u64 handle, u32 flags,
+		  u32 *buf_len, void *buf);
+
+int vboxsf_map_folder(struct shfl_string *folder_name, u32 *root);
+int vboxsf_unmap_folder(u32 root);
+
+int vboxsf_readlink(u32 root, struct shfl_string *parsed_path,
+		    u32 buf_len, u8 *buf);
+int vboxsf_symlink(u32 root, struct shfl_string *new_path,
+		   struct shfl_string *old_path, struct shfl_fsobjinfo *buf);
+
+int vboxsf_set_utf8(void);
+int vboxsf_set_symlinks(void);
+
+#endif
-- 
2.21.0

