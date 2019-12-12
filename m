Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 955A611CF65
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2019 15:09:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729574AbfLLOJq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Dec 2019 09:09:46 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24116 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729392AbfLLOJp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Dec 2019 09:09:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576159779;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=haJ6QYrB2L9c9ox93aff//Gbh+3xdFJEWpmtfj0qwKA=;
        b=gQhqbERPoD7mRWhXsHXauRXZFef/nkNOjqgCem9vXEaVS5YliZumcueJFnyxNUWQRjy6ZL
        wx3wXVWGolJX/ppF2Zs7iUcTUdM44KQ1LfVJQhKn1q6MNpHdw9LkBfym8PkJ7ddaNcyhHf
        RhtNG+xj5OI7tY7TKHb45+xxB3OvZSw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-99-KSH8fOd8PxW8zzXn3ZzaAA-1; Thu, 12 Dec 2019 09:09:21 -0500
X-MC-Unique: KSH8fOd8PxW8zzXn3ZzaAA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C207518B9FC2;
        Thu, 12 Dec 2019 14:09:19 +0000 (UTC)
Received: from shalem.localdomain.com (unknown [10.36.118.3])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E2DEE5C1C3;
        Thu, 12 Dec 2019 14:09:17 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Howells <dhowells@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v19] fs: Add VirtualBox guest shared folder (vboxsf) support
Date:   Thu, 12 Dec 2019 15:09:14 +0100
Message-Id: <20191212140914.21908-2-hdegoede@redhat.com>
In-Reply-To: <20191212140914.21908-1-hdegoede@redhat.com>
References: <20191212140914.21908-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

VirtualBox hosts can share folders with guests, this commit adds a
VFS driver implementing the Linux-guest side of this, allowing folders
exported by the host to be mounted under Linux.

This driver depends on the guest <-> host IPC functions exported by
the vboxguest driver.

Acked-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v19:
- Misc. small code tweaks suggested by Al Viro (no functional changes)
- Do not increment dir_context->pos when dir_emit has returned false.
- Add a WARN_ON check for trying to access beyond the end of a
  vboxsf directory buffer, this uses WARN_ON as this means the host has
  given us corrupt data
- Catch the user passing the "nls" opt more then once

Changes in v18:
- Move back to fs/vboxsf for direct submission to Linus
- Squash in a few small fixes done during vboxsf's brief stint in staging
- Add handling of short copies to vboxsf_write_end
- Add a comment about our simple_write_begin usage (Suggested by David Ho=
well)

Changes in v17:
- Submit upstream through drivers/staging as this is not getting any
  traction on the fsdevel list
- Add TODO file
- vboxsf_free_inode uses sbi->idr, call rcu_barrier from put_super to mak=
e
  sure all delayed rcu free inodes are flushed

Changes in v16:
- Make vboxsf_parse_monolithic() static, reported-by: kbuild test robot

Changes in v15:
- Rebase on top of 5.4-rc1

Changes in v14
- Add a commment explaining possible read cache strategies and which one
  has been chosen
- Change pagecache-invalidation on open (inode_revalidate) to use
  invalidate_inode_pages2() so that mmap-ed pages are dropped from
  the cache too
- Add a comment to vboxsf_file_release explaining why the
  filemap_write_and_wait() call is done there
- Some minor code tweaks

Changes in v13
- Add SPDX tag to Makefile, use foo-y :=3D to set objectfile list
- Drop kerneldoc headers stating the obvious from vfs callbacks,
  to avoid them going stale
- Replace sf_ prefix of functions and data-types with vboxsf_
- Use more normal naming scheme for sbi and private inode data:
    struct vboxsf_sbi *sbi =3D VBOXSF_SBI(inode->i_sb);
    struct vboxsf_inode *sf_i =3D VBOXSF_I(inode);
- Refactor directory reading code
- Use goto based unwinding instead of nested if-s in a number of places
- Consolidate dir unlink and rmdir inode_operations into a single functio=
n
- Use the page-cache for regular reads/writes too
- Directly set super_operations.free_inode to what used to be our
  vboxsf_i_callback, instead of setting super_operations.destroy_inode
  to a function which just does: call_rcu(&inode->i_rcu, vboxsf_i_callbac=
k);
- Use spinlock_irqsafe for ino_idr_lock
  vboxsf_free_inode may be called from a RCU callback, and thus from
  softirq context, so we need to use spinlock_irqsafe vboxsf_new_inode.
  On alloc_inode failure vboxsf_free_inode may be called from process
  context, so it too needs to use spinlock_irqsafe.

Changes in v12:
- Move make_kuid / make_kgid calls to option parsing time and add
  uid_valid / gid_valid checks.
- In init_fs_context call current_uid_gid() to init uid and gid
- Validate dmode, fmode, dmask and fmask options during option parsing
- Use correct types for various mount option variables (kuid_t, kgid_t, u=
mode_t)
- Some small coding-style tweaks

Changes in v11:
- Convert to the new Documentation/filesystems/mount_api.txt mount API
- Fixed all the function kerneldoc comments to have things in the proper =
order
- Change type of d_type variable passed as type to dir_emit from int to
  unsigned int
- Replaced the fake-ino overflow test with the one suggested by David How=
ells
- Fixed various coding style issues

See cover-letter for full changelog including older versions
---
 MAINTAINERS                 |   6 +
 fs/Kconfig                  |   1 +
 fs/Makefile                 |   1 +
 fs/vboxsf/Kconfig           |  10 +
 fs/vboxsf/Makefile          |   5 +
 fs/vboxsf/dir.c             | 427 +++++++++++++++++
 fs/vboxsf/file.c            | 379 +++++++++++++++
 fs/vboxsf/shfl_hostintf.h   | 901 ++++++++++++++++++++++++++++++++++++
 fs/vboxsf/super.c           | 497 ++++++++++++++++++++
 fs/vboxsf/utils.c           | 551 ++++++++++++++++++++++
 fs/vboxsf/vboxsf_wrappers.c | 371 +++++++++++++++
 fs/vboxsf/vfsmod.h          | 137 ++++++
 12 files changed, 3286 insertions(+)
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
index 02d5278a4c9a..90302540b12d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17591,6 +17591,12 @@ F:	include/linux/vbox_utils.h
 F:	include/uapi/linux/vbox*.h
 F:	drivers/virt/vboxguest/
=20
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
index 7b623e9fc1b0..8493a3f0c4b1 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -264,6 +264,7 @@ source "fs/pstore/Kconfig"
 source "fs/sysv/Kconfig"
 source "fs/ufs/Kconfig"
 source "fs/erofs/Kconfig"
+source "fs/vboxsf/Kconfig"
=20
 endif # MISC_FILESYSTEMS
=20
diff --git a/fs/Makefile b/fs/Makefile
index 1148c555c4d3..b807cbff3790 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -133,3 +133,4 @@ obj-$(CONFIG_CEPH_FS)		+=3D ceph/
 obj-$(CONFIG_PSTORE)		+=3D pstore/
 obj-$(CONFIG_EFIVAR_FS)		+=3D efivarfs/
 obj-$(CONFIG_EROFS_FS)		+=3D erofs/
+obj-$(CONFIG_VBOXSF_FS)		+=3D vboxsf/
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
+	  If you want to use shared folders in VirtualBox guests, answer Y or M=
.
diff --git a/fs/vboxsf/Makefile b/fs/vboxsf/Makefile
new file mode 100644
index 000000000000..9e4328e79623
--- /dev/null
+++ b/fs/vboxsf/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: MIT
+
+obj-$(CONFIG_VBOXSF_FS) +=3D vboxsf.o
+
+vboxsf-y :=3D dir.o file.o utils.o vboxsf_wrappers.o super.o
diff --git a/fs/vboxsf/dir.c b/fs/vboxsf/dir.c
new file mode 100644
index 000000000000..dd147b490982
--- /dev/null
+++ b/fs/vboxsf/dir.c
@@ -0,0 +1,427 @@
+// SPDX-License-Identifier: MIT
+/*
+ * VirtualBox Guest Shared Folders support: Directory inode and file ope=
rations
+ *
+ * Copyright (C) 2006-2018 Oracle Corporation
+ */
+
+#include <linux/namei.h>
+#include <linux/vbox_utils.h>
+#include "vfsmod.h"
+
+static int vboxsf_dir_open(struct inode *inode, struct file *file)
+{
+	struct vboxsf_sbi *sbi =3D VBOXSF_SBI(inode->i_sb);
+	struct shfl_createparms params =3D {};
+	struct vboxsf_dir_info *sf_d;
+	int err;
+
+	sf_d =3D vboxsf_dir_info_alloc();
+	if (!sf_d)
+		return -ENOMEM;
+
+	params.handle =3D SHFL_HANDLE_NIL;
+	params.create_flags =3D SHFL_CF_DIRECTORY | SHFL_CF_ACT_OPEN_IF_EXISTS =
|
+			      SHFL_CF_ACT_FAIL_IF_NEW | SHFL_CF_ACCESS_READ;
+
+	err =3D vboxsf_create_at_dentry(file_dentry(file), &params);
+	if (err)
+		goto err_free_dir_info;
+
+	if (params.result !=3D SHFL_FILE_EXISTS) {
+		err =3D -ENOENT;
+		goto err_close;
+	}
+
+	err =3D vboxsf_dir_read_all(sbi, sf_d, params.handle);
+	if (err)
+		goto err_close;
+
+	vboxsf_close(sbi->root, params.handle);
+	file->private_data =3D sf_d;
+	return 0;
+
+err_close:
+	vboxsf_close(sbi->root, params.handle);
+err_free_dir_info:
+	vboxsf_dir_info_free(sf_d);
+	return err;
+}
+
+static int vboxsf_dir_release(struct inode *inode, struct file *file)
+{
+	if (file->private_data)
+		vboxsf_dir_info_free(file->private_data);
+
+	return 0;
+}
+
+static unsigned int vboxsf_get_d_type(u32 mode)
+{
+	unsigned int d_type;
+
+	switch (mode & SHFL_TYPE_MASK) {
+	case SHFL_TYPE_FIFO:
+		d_type =3D DT_FIFO;
+		break;
+	case SHFL_TYPE_DEV_CHAR:
+		d_type =3D DT_CHR;
+		break;
+	case SHFL_TYPE_DIRECTORY:
+		d_type =3D DT_DIR;
+		break;
+	case SHFL_TYPE_DEV_BLOCK:
+		d_type =3D DT_BLK;
+		break;
+	case SHFL_TYPE_FILE:
+		d_type =3D DT_REG;
+		break;
+	case SHFL_TYPE_SYMLINK:
+		d_type =3D DT_LNK;
+		break;
+	case SHFL_TYPE_SOCKET:
+		d_type =3D DT_SOCK;
+		break;
+	case SHFL_TYPE_WHITEOUT:
+		d_type =3D DT_WHT;
+		break;
+	default:
+		d_type =3D DT_UNKNOWN;
+		break;
+	}
+	return d_type;
+}
+
+static bool vboxsf_dir_emit(struct file *dir, struct dir_context *ctx)
+{
+	struct vboxsf_sbi *sbi =3D VBOXSF_SBI(file_inode(dir)->i_sb);
+	struct vboxsf_dir_info *sf_d =3D dir->private_data;
+	struct shfl_dirinfo *info;
+	struct vboxsf_dir_buf *b;
+	unsigned int d_type;
+	loff_t i, cur =3D 0;
+	ino_t fake_ino;
+	void *end;
+	int err;
+
+	list_for_each_entry(b, &sf_d->info_list, head) {
+try_next_entry:
+		if (ctx->pos >=3D cur + b->entries) {
+			cur +=3D b->entries;
+			continue;
+		}
+
+		/*
+		 * Note the vboxsf_dir_info objects we are iterating over here
+		 * are variable sized, so the info pointer may end up being
+		 * unaligned. This is how we get the data from the host.
+		 * Since vboxsf is only supported on x86 machines this is not
+		 * a problem.
+		 */
+		for (i =3D 0, info =3D b->buf; i < ctx->pos - cur; i++) {
+			end =3D &info->name.string.utf8[info->name.size];
+			/* Only happens if the host gives us corrupt data */
+			if (WARN_ON(end > (b->buf + b->used)))
+				return false;
+			info =3D end;
+		}
+
+		end =3D &info->name.string.utf8[info->name.size];
+		if (WARN_ON(end > (b->buf + b->used)))
+			return false;
+
+		/* Info now points to the right entry, emit it. */
+		d_type =3D vboxsf_get_d_type(info->info.attr.mode);
+
+		/*
+		 * On 32 bit systems pos is 64 signed, while ino is 32 bit
+		 * unsigned so fake_ino may overflow, check for this.
+		 */
+		if ((ino_t)(ctx->pos + 1) !=3D (u64)(ctx->pos + 1)) {
+			vbg_err("vboxsf: fake ino overflow, truncating dir\n");
+			return false;
+		}
+		fake_ino =3D ctx->pos + 1;
+
+		if (sbi->nls) {
+			char d_name[NAME_MAX];
+
+			err =3D vboxsf_nlscpy(sbi, d_name, NAME_MAX,
+					    info->name.string.utf8,
+					    info->name.length);
+			if (err) {
+				/* skip erroneous entry and proceed */
+				ctx->pos +=3D 1;
+				goto try_next_entry;
+			}
+
+			return dir_emit(ctx, d_name, strlen(d_name),
+					fake_ino, d_type);
+		}
+
+		return dir_emit(ctx, info->name.string.utf8, info->name.length,
+				fake_ino, d_type);
+	}
+
+	return false;
+}
+
+static int vboxsf_dir_iterate(struct file *dir, struct dir_context *ctx)
+{
+	bool emitted;
+
+	do {
+		emitted =3D vboxsf_dir_emit(dir, ctx);
+		if (emitted)
+			ctx->pos +=3D 1;
+	} while (emitted);
+
+	return 0;
+}
+
+const struct file_operations vboxsf_dir_fops =3D {
+	.open =3D vboxsf_dir_open,
+	.iterate =3D vboxsf_dir_iterate,
+	.release =3D vboxsf_dir_release,
+	.read =3D generic_read_dir,
+	.llseek =3D generic_file_llseek,
+};
+
+/*
+ * This is called during name resolution/lookup to check if the @dentry =
in
+ * the cache is still valid. the job is handled by vboxsf_inode_revalida=
te.
+ */
+static int vboxsf_dentry_revalidate(struct dentry *dentry, unsigned int =
flags)
+{
+	if (flags & LOOKUP_RCU)
+		return -ECHILD;
+
+	if (d_really_is_positive(dentry))
+		return vboxsf_inode_revalidate(dentry) =3D=3D 0;
+	else
+		return vboxsf_stat_dentry(dentry, NULL) =3D=3D -ENOENT;
+}
+
+const struct dentry_operations vboxsf_dentry_ops =3D {
+	.d_revalidate =3D vboxsf_dentry_revalidate
+};
+
+/* iops */
+
+static struct dentry *vboxsf_dir_lookup(struct inode *parent,
+					struct dentry *dentry,
+					unsigned int flags)
+{
+	struct vboxsf_sbi *sbi =3D VBOXSF_SBI(parent->i_sb);
+	struct shfl_fsobjinfo fsinfo;
+	struct inode *inode;
+	int err;
+
+	dentry->d_time =3D jiffies;
+
+	err =3D vboxsf_stat_dentry(dentry, &fsinfo);
+	if (err) {
+		inode =3D (err =3D=3D -ENOENT) ? NULL : ERR_PTR(err);
+	} else {
+		inode =3D vboxsf_new_inode(parent->i_sb);
+		if (!IS_ERR(inode))
+			vboxsf_init_inode(sbi, inode, &fsinfo);
+	}
+
+	return d_splice_alias(inode, dentry);
+}
+
+static int vboxsf_dir_instantiate(struct inode *parent, struct dentry *d=
entry,
+				  struct shfl_fsobjinfo *info)
+{
+	struct vboxsf_sbi *sbi =3D VBOXSF_SBI(parent->i_sb);
+	struct vboxsf_inode *sf_i;
+	struct inode *inode;
+
+	inode =3D vboxsf_new_inode(parent->i_sb);
+	if (IS_ERR(inode))
+		return PTR_ERR(inode);
+
+	sf_i =3D VBOXSF_I(inode);
+	/* The host may have given us different attr then requested */
+	sf_i->force_restat =3D 1;
+	vboxsf_init_inode(sbi, inode, info);
+
+	d_instantiate(dentry, inode);
+
+	return 0;
+}
+
+static int vboxsf_dir_create(struct inode *parent, struct dentry *dentry=
,
+			     umode_t mode, int is_dir)
+{
+	struct vboxsf_inode *sf_parent_i =3D VBOXSF_I(parent);
+	struct vboxsf_sbi *sbi =3D VBOXSF_SBI(parent->i_sb);
+	struct shfl_createparms params =3D {};
+	int err;
+
+	params.handle =3D SHFL_HANDLE_NIL;
+	params.create_flags =3D SHFL_CF_ACT_CREATE_IF_NEW |
+			      SHFL_CF_ACT_FAIL_IF_EXISTS |
+			      SHFL_CF_ACCESS_READWRITE |
+			      (is_dir ? SHFL_CF_DIRECTORY : 0);
+	params.info.attr.mode =3D (mode & 0777) |
+				(is_dir ? SHFL_TYPE_DIRECTORY : SHFL_TYPE_FILE);
+	params.info.attr.additional =3D SHFLFSOBJATTRADD_NOTHING;
+
+	err =3D vboxsf_create_at_dentry(dentry, &params);
+	if (err)
+		return err;
+
+	if (params.result !=3D SHFL_FILE_CREATED)
+		return -EPERM;
+
+	vboxsf_close(sbi->root, params.handle);
+
+	err =3D vboxsf_dir_instantiate(parent, dentry, &params.info);
+	if (err)
+		return err;
+
+	/* parent directory access/change time changed */
+	sf_parent_i->force_restat =3D 1;
+
+	return 0;
+}
+
+static int vboxsf_dir_mkfile(struct inode *parent, struct dentry *dentry=
,
+			     umode_t mode, bool excl)
+{
+	return vboxsf_dir_create(parent, dentry, mode, 0);
+}
+
+static int vboxsf_dir_mkdir(struct inode *parent, struct dentry *dentry,
+			    umode_t mode)
+{
+	return vboxsf_dir_create(parent, dentry, mode, 1);
+}
+
+static int vboxsf_dir_unlink(struct inode *parent, struct dentry *dentry=
)
+{
+	struct vboxsf_sbi *sbi =3D VBOXSF_SBI(parent->i_sb);
+	struct vboxsf_inode *sf_parent_i =3D VBOXSF_I(parent);
+	struct inode *inode =3D d_inode(dentry);
+	struct shfl_string *path;
+	u32 flags;
+	int err;
+
+	if (S_ISDIR(inode->i_mode))
+		flags =3D SHFL_REMOVE_DIR;
+	else
+		flags =3D SHFL_REMOVE_FILE;
+
+	if (S_ISLNK(inode->i_mode))
+		flags |=3D SHFL_REMOVE_SYMLINK;
+
+	path =3D vboxsf_path_from_dentry(sbi, dentry);
+	if (IS_ERR(path))
+		return PTR_ERR(path);
+
+	err =3D vboxsf_remove(sbi->root, path, flags);
+	__putname(path);
+	if (err)
+		return err;
+
+	/* parent directory access/change time changed */
+	sf_parent_i->force_restat =3D 1;
+
+	return 0;
+}
+
+static int vboxsf_dir_rename(struct inode *old_parent,
+			     struct dentry *old_dentry,
+			     struct inode *new_parent,
+			     struct dentry *new_dentry,
+			     unsigned int flags)
+{
+	struct vboxsf_sbi *sbi =3D VBOXSF_SBI(old_parent->i_sb);
+	struct vboxsf_inode *sf_old_parent_i =3D VBOXSF_I(old_parent);
+	struct vboxsf_inode *sf_new_parent_i =3D VBOXSF_I(new_parent);
+	u32 shfl_flags =3D SHFL_RENAME_FILE | SHFL_RENAME_REPLACE_IF_EXISTS;
+	struct shfl_string *old_path, *new_path;
+	int err;
+
+	if (flags)
+		return -EINVAL;
+
+	old_path =3D vboxsf_path_from_dentry(sbi, old_dentry);
+	if (IS_ERR(old_path))
+		return PTR_ERR(old_path);
+
+	new_path =3D vboxsf_path_from_dentry(sbi, new_dentry);
+	if (IS_ERR(new_path)) {
+		err =3D PTR_ERR(new_path);
+		goto err_put_old_path;
+	}
+
+	if (d_inode(old_dentry)->i_mode & S_IFDIR)
+		shfl_flags =3D 0;
+
+	err =3D vboxsf_rename(sbi->root, old_path, new_path, shfl_flags);
+	if (err =3D=3D 0) {
+		/* parent directories access/change time changed */
+		sf_new_parent_i->force_restat =3D 1;
+		sf_old_parent_i->force_restat =3D 1;
+	}
+
+	__putname(new_path);
+err_put_old_path:
+	__putname(old_path);
+	return err;
+}
+
+static int vboxsf_dir_symlink(struct inode *parent, struct dentry *dentr=
y,
+			      const char *symname)
+{
+	struct vboxsf_inode *sf_parent_i =3D VBOXSF_I(parent);
+	struct vboxsf_sbi *sbi =3D VBOXSF_SBI(parent->i_sb);
+	int symname_size =3D strlen(symname) + 1;
+	struct shfl_string *path, *ssymname;
+	struct shfl_fsobjinfo info;
+	int err;
+
+	path =3D vboxsf_path_from_dentry(sbi, dentry);
+	if (IS_ERR(path))
+		return PTR_ERR(path);
+
+	ssymname =3D kmalloc(SHFLSTRING_HEADER_SIZE + symname_size, GFP_KERNEL)=
;
+	if (!ssymname) {
+		__putname(path);
+		return -ENOMEM;
+	}
+	ssymname->length =3D symname_size - 1;
+	ssymname->size =3D symname_size;
+	memcpy(ssymname->string.utf8, symname, symname_size);
+
+	err =3D vboxsf_symlink(sbi->root, path, ssymname, &info);
+	kfree(ssymname);
+	__putname(path);
+	if (err) {
+		/* -EROFS means symlinks are note support -> -EPERM */
+		return (err =3D=3D -EROFS) ? -EPERM : err;
+	}
+
+	err =3D vboxsf_dir_instantiate(parent, dentry, &info);
+	if (err)
+		return err;
+
+	/* parent directory access/change time changed */
+	sf_parent_i->force_restat =3D 1;
+	return 0;
+}
+
+const struct inode_operations vboxsf_dir_iops =3D {
+	.lookup  =3D vboxsf_dir_lookup,
+	.create  =3D vboxsf_dir_mkfile,
+	.mkdir   =3D vboxsf_dir_mkdir,
+	.rmdir   =3D vboxsf_dir_unlink,
+	.unlink  =3D vboxsf_dir_unlink,
+	.rename  =3D vboxsf_dir_rename,
+	.symlink =3D vboxsf_dir_symlink,
+	.getattr =3D vboxsf_getattr,
+	.setattr =3D vboxsf_setattr,
+};
diff --git a/fs/vboxsf/file.c b/fs/vboxsf/file.c
new file mode 100644
index 000000000000..c4ab5996d97a
--- /dev/null
+++ b/fs/vboxsf/file.c
@@ -0,0 +1,379 @@
+// SPDX-License-Identifier: MIT
+/*
+ * VirtualBox Guest Shared Folders support: Regular file inode and file =
ops.
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
+struct vboxsf_handle {
+	u64 handle;
+	u32 root;
+	u32 access_flags;
+	struct kref refcount;
+	struct list_head head;
+};
+
+static int vboxsf_file_open(struct inode *inode, struct file *file)
+{
+	struct vboxsf_inode *sf_i =3D VBOXSF_I(inode);
+	struct shfl_createparms params =3D {};
+	struct vboxsf_handle *sf_handle;
+	u32 access_flags =3D 0;
+	int err;
+
+	sf_handle =3D kmalloc(sizeof(*sf_handle), GFP_KERNEL);
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
+	params.handle =3D SHFL_HANDLE_NIL;
+	if (file->f_flags & O_CREAT) {
+		params.create_flags |=3D SHFL_CF_ACT_CREATE_IF_NEW;
+		/*
+		 * We ignore O_EXCL, as the Linux kernel seems to call create
+		 * beforehand itself, so O_EXCL should always fail.
+		 */
+		if (file->f_flags & O_TRUNC)
+			params.create_flags |=3D SHFL_CF_ACT_OVERWRITE_IF_EXISTS;
+		else
+			params.create_flags |=3D SHFL_CF_ACT_OPEN_IF_EXISTS;
+	} else {
+		params.create_flags |=3D SHFL_CF_ACT_FAIL_IF_NEW;
+		if (file->f_flags & O_TRUNC)
+			params.create_flags |=3D SHFL_CF_ACT_OVERWRITE_IF_EXISTS;
+	}
+
+	switch (file->f_flags & O_ACCMODE) {
+	case O_RDONLY:
+		access_flags |=3D SHFL_CF_ACCESS_READ;
+		break;
+
+	case O_WRONLY:
+		access_flags |=3D SHFL_CF_ACCESS_WRITE;
+		break;
+
+	case O_RDWR:
+		access_flags |=3D SHFL_CF_ACCESS_READWRITE;
+		break;
+
+	default:
+		WARN_ON(1);
+	}
+
+	if (file->f_flags & O_APPEND)
+		access_flags |=3D SHFL_CF_ACCESS_APPEND;
+
+	params.create_flags |=3D access_flags;
+	params.info.attr.mode =3D inode->i_mode;
+
+	err =3D vboxsf_create_at_dentry(file_dentry(file), &params);
+	if (err =3D=3D 0 && params.handle =3D=3D SHFL_HANDLE_NIL)
+		err =3D (params.result =3D=3D SHFL_FILE_EXISTS) ? -EEXIST : -ENOENT;
+	if (err) {
+		kfree(sf_handle);
+		return err;
+	}
+
+	/* the host may have given us different attr then requested */
+	sf_i->force_restat =3D 1;
+
+	/* init our handle struct and add it to the inode's handles list */
+	sf_handle->handle =3D params.handle;
+	sf_handle->root =3D VBOXSF_SBI(inode->i_sb)->root;
+	sf_handle->access_flags =3D access_flags;
+	kref_init(&sf_handle->refcount);
+
+	mutex_lock(&sf_i->handle_list_mutex);
+	list_add(&sf_handle->head, &sf_i->handle_list);
+	mutex_unlock(&sf_i->handle_list_mutex);
+
+	file->private_data =3D sf_handle;
+	return 0;
+}
+
+static void vboxsf_handle_release(struct kref *refcount)
+{
+	struct vboxsf_handle *sf_handle =3D
+		container_of(refcount, struct vboxsf_handle, refcount);
+
+	vboxsf_close(sf_handle->root, sf_handle->handle);
+	kfree(sf_handle);
+}
+
+static int vboxsf_file_release(struct inode *inode, struct file *file)
+{
+	struct vboxsf_inode *sf_i =3D VBOXSF_I(inode);
+	struct vboxsf_handle *sf_handle =3D file->private_data;
+
+	/*
+	 * When a file is closed on our (the guest) side, we want any subsequen=
t
+	 * accesses done on the host side to see all changes done from our side=
.
+	 */
+	filemap_write_and_wait(inode->i_mapping);
+
+	mutex_lock(&sf_i->handle_list_mutex);
+	list_del(&sf_handle->head);
+	mutex_unlock(&sf_i->handle_list_mutex);
+
+	kref_put(&sf_handle->refcount, vboxsf_handle_release);
+	return 0;
+}
+
+/*
+ * Write back dirty pages now, because there may not be any suitable
+ * open files later
+ */
+static void vboxsf_vma_close(struct vm_area_struct *vma)
+{
+	filemap_write_and_wait(vma->vm_file->f_mapping);
+}
+
+static const struct vm_operations_struct vboxsf_file_vm_ops =3D {
+	.close		=3D vboxsf_vma_close,
+	.fault		=3D filemap_fault,
+	.map_pages	=3D filemap_map_pages,
+};
+
+static int vboxsf_file_mmap(struct file *file, struct vm_area_struct *vm=
a)
+{
+	int err;
+
+	err =3D generic_file_mmap(file, vma);
+	if (!err)
+		vma->vm_ops =3D &vboxsf_file_vm_ops;
+
+	return err;
+}
+
+/*
+ * Note that since we are accessing files on the host's filesystem, file=
s
+ * may always be changed underneath us by the host!
+ *
+ * The vboxsf API between the guest and the host does not offer any func=
tions
+ * to deal with this. There is no inode-generation to check for changes,=
 no
+ * events / callback on changes and no way to lock files.
+ *
+ * To avoid returning stale data when a file gets *opened* on our (the g=
uest)
+ * side, we do a "stat" on the host side, then compare the mtime with th=
e
+ * last known mtime and invalidate the page-cache if they differ.
+ * This is done from vboxsf_inode_revalidate().
+ *
+ * When reads are done through the read_iter fop, it is possible to do
+ * further cache revalidation then, there are 3 options to deal with thi=
s:
+ *
+ * 1)  Rely solely on the revalidation done at open time
+ * 2)  Do another "stat" and compare mtime again. Unfortunately the vbox=
sf
+ *     host API does not allow stat on handles, so we would need to use
+ *     file->f_path.dentry and the stat will then fail if the file was u=
nlinked
+ *     or renamed (and there is no thing like NFS' silly-rename). So we =
get:
+ * 2a) "stat" and compare mtime, on stat failure invalidate the cache
+ * 2b) "stat" and compare mtime, on stat failure do nothing
+ * 3)  Simply always call invalidate_inode_pages2_range on the range of =
the read
+ *
+ * Currently we are keeping things KISS and using option 1. this allows
+ * directly using generic_file_read_iter without wrapping it.
+ *
+ * This means that only data written on the host side before open() on
+ * the guest side is guaranteed to be seen by the guest. If necessary
+ * we may provide other read-cache strategies in the future and make thi=
s
+ * configurable through a mount option.
+ */
+const struct file_operations vboxsf_reg_fops =3D {
+	.llseek =3D generic_file_llseek,
+	.read_iter =3D generic_file_read_iter,
+	.write_iter =3D generic_file_write_iter,
+	.mmap =3D vboxsf_file_mmap,
+	.open =3D vboxsf_file_open,
+	.release =3D vboxsf_file_release,
+	.fsync =3D noop_fsync,
+	.splice_read =3D generic_file_splice_read,
+};
+
+const struct inode_operations vboxsf_reg_iops =3D {
+	.getattr =3D vboxsf_getattr,
+	.setattr =3D vboxsf_setattr
+};
+
+static int vboxsf_readpage(struct file *file, struct page *page)
+{
+	struct vboxsf_handle *sf_handle =3D file->private_data;
+	loff_t off =3D page_offset(page);
+	u32 nread =3D PAGE_SIZE;
+	u8 *buf;
+	int err;
+
+	buf =3D kmap(page);
+
+	err =3D vboxsf_read(sf_handle->root, sf_handle->handle, off, &nread, bu=
f);
+	if (err =3D=3D 0) {
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
+static struct vboxsf_handle *vboxsf_get_write_handle(struct vboxsf_inode=
 *sf_i)
+{
+	struct vboxsf_handle *h, *sf_handle =3D NULL;
+
+	mutex_lock(&sf_i->handle_list_mutex);
+	list_for_each_entry(h, &sf_i->handle_list, head) {
+		if (h->access_flags =3D=3D SHFL_CF_ACCESS_WRITE ||
+		    h->access_flags =3D=3D SHFL_CF_ACCESS_READWRITE) {
+			kref_get(&h->refcount);
+			sf_handle =3D h;
+			break;
+		}
+	}
+	mutex_unlock(&sf_i->handle_list_mutex);
+
+	return sf_handle;
+}
+
+static int vboxsf_writepage(struct page *page, struct writeback_control =
*wbc)
+{
+	struct inode *inode =3D page->mapping->host;
+	struct vboxsf_inode *sf_i =3D VBOXSF_I(inode);
+	struct vboxsf_handle *sf_handle;
+	loff_t off =3D page_offset(page);
+	loff_t size =3D i_size_read(inode);
+	u32 nwrite =3D PAGE_SIZE;
+	u8 *buf;
+	int err;
+
+	if (off + PAGE_SIZE > size)
+		nwrite =3D size & ~PAGE_MASK;
+
+	sf_handle =3D vboxsf_get_write_handle(sf_i);
+	if (!sf_handle)
+		return -EBADF;
+
+	buf =3D kmap(page);
+	err =3D vboxsf_write(sf_handle->root, sf_handle->handle,
+			   off, &nwrite, buf);
+	kunmap(page);
+
+	kref_put(&sf_handle->refcount, vboxsf_handle_release);
+
+	if (err =3D=3D 0) {
+		ClearPageError(page);
+		/* mtime changed */
+		sf_i->force_restat =3D 1;
+	} else {
+		ClearPageUptodate(page);
+	}
+
+	unlock_page(page);
+	return err;
+}
+
+static int vboxsf_write_end(struct file *file, struct address_space *map=
ping,
+			    loff_t pos, unsigned int len, unsigned int copied,
+			    struct page *page, void *fsdata)
+{
+	struct inode *inode =3D mapping->host;
+	struct vboxsf_handle *sf_handle =3D file->private_data;
+	unsigned int from =3D pos & ~PAGE_MASK;
+	u32 nwritten =3D len;
+	u8 *buf;
+	int err;
+
+	/* zero the stale part of the page if we did a short copy */
+	if (!PageUptodate(page) && copied < len)
+		zero_user(page, from + copied, len - copied);
+
+	buf =3D kmap(page);
+	err =3D vboxsf_write(sf_handle->root, sf_handle->handle,
+			   pos, &nwritten, buf + from);
+	kunmap(page);
+
+	if (err) {
+		nwritten =3D 0;
+		goto out;
+	}
+
+	/* mtime changed */
+	VBOXSF_I(inode)->force_restat =3D 1;
+
+	if (!PageUptodate(page) && nwritten =3D=3D PAGE_SIZE)
+		SetPageUptodate(page);
+
+	pos +=3D nwritten;
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
+/*
+ * Note simple_write_begin does not read the page from disk on partial w=
rites
+ * this is ok since vboxsf_write_end only writes the written parts of th=
e
+ * page and it does not call SetPageUptodate for partial writes.
+ */
+const struct address_space_operations vboxsf_reg_aops =3D {
+	.readpage =3D vboxsf_readpage,
+	.writepage =3D vboxsf_writepage,
+	.set_page_dirty =3D __set_page_dirty_nobuffers,
+	.write_begin =3D simple_write_begin,
+	.write_end =3D vboxsf_write_end,
+};
+
+static const char *vboxsf_get_link(struct dentry *dentry, struct inode *=
inode,
+				   struct delayed_call *done)
+{
+	struct vboxsf_sbi *sbi =3D VBOXSF_SBI(inode->i_sb);
+	struct shfl_string *path;
+	char *link;
+	int err;
+
+	if (!dentry)
+		return ERR_PTR(-ECHILD);
+
+	path =3D vboxsf_path_from_dentry(sbi, dentry);
+	if (IS_ERR(path))
+		return ERR_CAST(path);
+
+	link =3D kzalloc(PATH_MAX, GFP_KERNEL);
+	if (!link) {
+		__putname(path);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	err =3D vboxsf_readlink(sbi->root, path, PATH_MAX, link);
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
+const struct inode_operations vboxsf_lnk_iops =3D {
+	.get_link =3D vboxsf_get_link
+};
diff --git a/fs/vboxsf/shfl_hostintf.h b/fs/vboxsf/shfl_hostintf.h
new file mode 100644
index 000000000000..aca829062c12
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
+	SHFL_FN_QUERY_MAPPINGS =3D 1,	/* Query mappings changes. */
+	SHFL_FN_QUERY_MAP_NAME =3D 2,	/* Query map name. */
+	SHFL_FN_CREATE =3D 3,		/* Open/create object. */
+	SHFL_FN_CLOSE =3D 4,		/* Close object handle. */
+	SHFL_FN_READ =3D 5,		/* Read object content. */
+	SHFL_FN_WRITE =3D 6,		/* Write new object content. */
+	SHFL_FN_LOCK =3D 7,		/* Lock/unlock a range in the object. */
+	SHFL_FN_LIST =3D 8,		/* List object content. */
+	SHFL_FN_INFORMATION =3D 9,	/* Query/set object information. */
+	/* Note function number 10 is not used! */
+	SHFL_FN_REMOVE =3D 11,		/* Remove object */
+	SHFL_FN_MAP_FOLDER_OLD =3D 12,	/* Map folder (legacy) */
+	SHFL_FN_UNMAP_FOLDER =3D 13,	/* Unmap folder */
+	SHFL_FN_RENAME =3D 14,		/* Rename object */
+	SHFL_FN_FLUSH =3D 15,		/* Flush file */
+	SHFL_FN_SET_UTF8 =3D 16,		/* Select UTF8 filename encoding */
+	SHFL_FN_MAP_FOLDER =3D 17,	/* Map folder */
+	SHFL_FN_READLINK =3D 18,		/* Read symlink dest (as of VBox 4.0) */
+	SHFL_FN_SYMLINK =3D 19,		/* Create symlink (as of VBox 4.0) */
+	SHFL_FN_SET_SYMLINKS =3D 20,	/* Ask host to show symlinks (4.0+) */
+};
+
+/* Root handles for a mapping are of type u32, Root handles are unique. =
*/
+#define SHFL_ROOT_NIL		UINT_MAX
+
+/* Shared folders handle for an opened object are of type u64. */
+#define SHFL_HANDLE_NIL		ULLONG_MAX
+
+/* Hardcoded maximum length (in chars) of a shared folder name. */
+#define SHFL_MAX_LEN         (256)
+/* Hardcoded maximum number of shared folder mapping available to the gu=
est. */
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
+#define SHFL_IS_DIRECTORY(m)   (((m) & SHFL_TYPE_MASK) =3D=3D SHFL_TYPE_=
DIRECTORY)
+/* Checks the mode flags indicate a symbolic link (S_ISLNK). */
+#define SHFL_IS_SYMLINK(m)     (((m) & SHFL_TYPE_MASK) =3D=3D SHFL_TYPE_=
SYMLINK)
+
+/** The available additional information in a shfl_fsobjattr object. */
+enum shfl_fsobjattr_add {
+	/** No additional information is available / requested. */
+	SHFLFSOBJATTRADD_NOTHING =3D 1,
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
+	SHFLFSOBJATTRADD_LAST =3D SHFLFSOBJATTRADD_EASIZE,
+
+	/** The usual 32-bit hack. */
+	SHFLFSOBJATTRADD_32BIT_SIZE_HACK =3D 0x7fffffff
+};
+
+/**
+ * Additional unix Attributes, these are available when
+ * shfl_fsobjattr.additional =3D=3D SHFLFSOBJATTRADD_UNIX.
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
+	 * Unless explicitly specified to an API, the API can provide additiona=
l
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
+ * Only lookup the object, do not return a handle. When this is set all =
other
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
+ * Listing information includes variable length RTDIRENTRY[EX] structure=
s.
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
index 000000000000..b14ecd2948f4
--- /dev/null
+++ b/fs/vboxsf/super.c
@@ -0,0 +1,497 @@
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
+static struct super_operations vboxsf_super_ops; /* forward declaration =
*/
+static struct kmem_cache *vboxsf_inode_cachep;
+
+static char * const vboxsf_default_nls =3D CONFIG_NLS_DEFAULT;
+
+enum  { opt_nls, opt_uid, opt_gid, opt_ttl, opt_dmode, opt_fmode,
+	opt_dmask, opt_fmask };
+
+static const struct fs_parameter_spec vboxsf_param_specs[] =3D {
+	fsparam_string	("nls",		opt_nls),
+	fsparam_u32	("uid",		opt_uid),
+	fsparam_u32	("gid",		opt_gid),
+	fsparam_u32	("ttl",		opt_ttl),
+	fsparam_u32oct	("dmode",	opt_dmode),
+	fsparam_u32oct	("fmode",	opt_fmode),
+	fsparam_u32oct	("dmask",	opt_dmask),
+	fsparam_u32oct	("fmask",	opt_fmask),
+	{}
+};
+
+static const struct fs_parameter_description vboxsf_fs_parameters =3D {
+	.name  =3D "vboxsf",
+	.specs  =3D vboxsf_param_specs,
+};
+
+static int vboxsf_parse_param(struct fs_context *fc, struct fs_parameter=
 *param)
+{
+	struct vboxsf_fs_context *ctx =3D fc->fs_private;
+	struct fs_parse_result result;
+	kuid_t uid;
+	kgid_t gid;
+	int opt;
+
+	opt =3D fs_parse(fc, &vboxsf_fs_parameters, param, &result);
+	if (opt < 0)
+		return opt;
+
+	switch (opt) {
+	case opt_nls:
+		if (ctx->nls_name || fc->purpose !=3D FS_CONTEXT_FOR_MOUNT) {
+			vbg_err("vboxsf: Cannot reconfigure nls option\n");
+			return -EINVAL;
+		}
+		ctx->nls_name =3D param->string;
+		param->string =3D NULL;
+		break;
+	case opt_uid:
+		uid =3D make_kuid(current_user_ns(), result.uint_32);
+		if (!uid_valid(uid))
+			return -EINVAL;
+		ctx->o.uid =3D uid;
+		break;
+	case opt_gid:
+		gid =3D make_kgid(current_user_ns(), result.uint_32);
+		if (!gid_valid(gid))
+			return -EINVAL;
+		ctx->o.gid =3D gid;
+		break;
+	case opt_ttl:
+		ctx->o.ttl =3D msecs_to_jiffies(result.uint_32);
+		break;
+	case opt_dmode:
+		if (result.uint_32 & ~0777)
+			return -EINVAL;
+		ctx->o.dmode =3D result.uint_32;
+		ctx->o.dmode_set =3D true;
+		break;
+	case opt_fmode:
+		if (result.uint_32 & ~0777)
+			return -EINVAL;
+		ctx->o.fmode =3D result.uint_32;
+		ctx->o.fmode_set =3D true;
+		break;
+	case opt_dmask:
+		if (result.uint_32 & ~07777)
+			return -EINVAL;
+		ctx->o.dmask =3D result.uint_32;
+		break;
+	case opt_fmask:
+		if (result.uint_32 & ~07777)
+			return -EINVAL;
+		ctx->o.fmask =3D result.uint_32;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int vboxsf_fill_super(struct super_block *sb, struct fs_context *=
fc)
+{
+	struct vboxsf_fs_context *ctx =3D fc->fs_private;
+	struct shfl_string *folder_name, root_path;
+	struct vboxsf_sbi *sbi;
+	struct dentry *droot;
+	struct inode *iroot;
+	char *nls_name;
+	size_t size;
+	int err;
+
+	if (!fc->source)
+		return -EINVAL;
+
+	sbi =3D kzalloc(sizeof(*sbi), GFP_KERNEL);
+	if (!sbi)
+		return -ENOMEM;
+
+	sbi->o =3D ctx->o;
+	idr_init(&sbi->ino_idr);
+	spin_lock_init(&sbi->ino_idr_lock);
+	sbi->next_generation =3D 1;
+	sbi->bdi_id =3D -1;
+
+	/* Load nls if not utf8 */
+	nls_name =3D ctx->nls_name ? ctx->nls_name : vboxsf_default_nls;
+	if (strcmp(nls_name, "utf8") !=3D 0) {
+		if (nls_name =3D=3D vboxsf_default_nls)
+			sbi->nls =3D load_nls_default();
+		else
+			sbi->nls =3D load_nls(nls_name);
+
+		if (!sbi->nls) {
+			vbg_err("vboxsf: Count not load '%s' nls\n", nls_name);
+			err =3D -EINVAL;
+			goto fail_free;
+		}
+	}
+
+	sbi->bdi_id =3D ida_simple_get(&vboxsf_bdi_ida, 0, 0, GFP_KERNEL);
+	if (sbi->bdi_id < 0) {
+		err =3D sbi->bdi_id;
+		goto fail_free;
+	}
+
+	err =3D super_setup_bdi_name(sb, "vboxsf-%s.%d", fc->source, sbi->bdi_i=
d);
+	if (err)
+		goto fail_free;
+
+	/* Turn source into a shfl_string and map the folder */
+	size =3D strlen(fc->source) + 1;
+	folder_name =3D kmalloc(SHFLSTRING_HEADER_SIZE + size, GFP_KERNEL);
+	if (!folder_name) {
+		err =3D -ENOMEM;
+		goto fail_free;
+	}
+	folder_name->size =3D size;
+	folder_name->length =3D size - 1;
+	strlcpy(folder_name->string.utf8, fc->source, size);
+	err =3D vboxsf_map_folder(folder_name, &sbi->root);
+	kfree(folder_name);
+	if (err) {
+		vbg_err("vboxsf: Host rejected mount of '%s' with error %d\n",
+			fc->source, err);
+		goto fail_free;
+	}
+
+	root_path.length =3D 1;
+	root_path.size =3D 2;
+	root_path.string.utf8[0] =3D '/';
+	root_path.string.utf8[1] =3D 0;
+	err =3D vboxsf_stat(sbi, &root_path, &sbi->root_info);
+	if (err)
+		goto fail_unmap;
+
+	sb->s_magic =3D VBOXSF_SUPER_MAGIC;
+	sb->s_blocksize =3D 1024;
+	sb->s_maxbytes =3D MAX_LFS_FILESIZE;
+	sb->s_op =3D &vboxsf_super_ops;
+	sb->s_d_op =3D &vboxsf_dentry_ops;
+
+	iroot =3D iget_locked(sb, 0);
+	if (!iroot) {
+		err =3D -ENOMEM;
+		goto fail_unmap;
+	}
+	vboxsf_init_inode(sbi, iroot, &sbi->root_info);
+	unlock_new_inode(iroot);
+
+	droot =3D d_make_root(iroot);
+	if (!droot) {
+		err =3D -ENOMEM;
+		goto fail_unmap;
+	}
+
+	sb->s_root =3D droot;
+	sb->s_fs_info =3D sbi;
+	return 0;
+
+fail_unmap:
+	vboxsf_unmap_folder(sbi->root);
+fail_free:
+	if (sbi->bdi_id >=3D 0)
+		ida_simple_remove(&vboxsf_bdi_ida, sbi->bdi_id);
+	if (sbi->nls)
+		unload_nls(sbi->nls);
+	idr_destroy(&sbi->ino_idr);
+	kfree(sbi);
+	return err;
+}
+
+static void vboxsf_inode_init_once(void *data)
+{
+	struct vboxsf_inode *sf_i =3D data;
+
+	mutex_init(&sf_i->handle_list_mutex);
+	inode_init_once(&sf_i->vfs_inode);
+}
+
+static struct inode *vboxsf_alloc_inode(struct super_block *sb)
+{
+	struct vboxsf_inode *sf_i;
+
+	sf_i =3D kmem_cache_alloc(vboxsf_inode_cachep, GFP_NOFS);
+	if (!sf_i)
+		return NULL;
+
+	sf_i->force_restat =3D 0;
+	INIT_LIST_HEAD(&sf_i->handle_list);
+
+	return &sf_i->vfs_inode;
+}
+
+static void vboxsf_free_inode(struct inode *inode)
+{
+	struct vboxsf_sbi *sbi =3D VBOXSF_SBI(inode->i_sb);
+	unsigned long flags;
+
+	spin_lock_irqsave(&sbi->ino_idr_lock, flags);
+	idr_remove(&sbi->ino_idr, inode->i_ino);
+	spin_unlock_irqrestore(&sbi->ino_idr_lock, flags);
+	kmem_cache_free(vboxsf_inode_cachep, VBOXSF_I(inode));
+}
+
+static void vboxsf_put_super(struct super_block *sb)
+{
+	struct vboxsf_sbi *sbi =3D VBOXSF_SBI(sb);
+
+	vboxsf_unmap_folder(sbi->root);
+	if (sbi->bdi_id >=3D 0)
+		ida_simple_remove(&vboxsf_bdi_ida, sbi->bdi_id);
+	if (sbi->nls)
+		unload_nls(sbi->nls);
+
+	/*
+	 * vboxsf_free_inode uses the idr, make sure all delayed rcu free
+	 * inodes are flushed.
+	 */
+	rcu_barrier();
+	idr_destroy(&sbi->ino_idr);
+	kfree(sbi);
+}
+
+static int vboxsf_statfs(struct dentry *dentry, struct kstatfs *stat)
+{
+	struct super_block *sb =3D dentry->d_sb;
+	struct shfl_volinfo shfl_volinfo;
+	struct vboxsf_sbi *sbi;
+	u32 buf_len;
+	int err;
+
+	sbi =3D VBOXSF_SBI(sb);
+	buf_len =3D sizeof(shfl_volinfo);
+	err =3D vboxsf_fsinfo(sbi->root, 0, SHFL_INFO_GET | SHFL_INFO_VOLUME,
+			    &buf_len, &shfl_volinfo);
+	if (err)
+		return err;
+
+	stat->f_type =3D VBOXSF_SUPER_MAGIC;
+	stat->f_bsize =3D shfl_volinfo.bytes_per_allocation_unit;
+
+	do_div(shfl_volinfo.total_allocation_bytes,
+	       shfl_volinfo.bytes_per_allocation_unit);
+	stat->f_blocks =3D shfl_volinfo.total_allocation_bytes;
+
+	do_div(shfl_volinfo.available_allocation_bytes,
+	       shfl_volinfo.bytes_per_allocation_unit);
+	stat->f_bfree  =3D shfl_volinfo.available_allocation_bytes;
+	stat->f_bavail =3D shfl_volinfo.available_allocation_bytes;
+
+	stat->f_files =3D 1000;
+	/*
+	 * Don't return 0 here since the guest may then think that it is not
+	 * possible to create any more files.
+	 */
+	stat->f_ffree =3D 1000000;
+	stat->f_fsid.val[0] =3D 0;
+	stat->f_fsid.val[1] =3D 0;
+	stat->f_namelen =3D 255;
+	return 0;
+}
+
+static struct super_operations vboxsf_super_ops =3D {
+	.alloc_inode	=3D vboxsf_alloc_inode,
+	.free_inode	=3D vboxsf_free_inode,
+	.put_super	=3D vboxsf_put_super,
+	.statfs		=3D vboxsf_statfs,
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
+	vboxsf_inode_cachep =3D
+		kmem_cache_create("vboxsf_inode_cache",
+				  sizeof(struct vboxsf_inode), 0,
+				  (SLAB_RECLAIM_ACCOUNT | SLAB_MEM_SPREAD |
+				   SLAB_ACCOUNT),
+				  vboxsf_inode_init_once);
+	if (!vboxsf_inode_cachep) {
+		err =3D -ENOMEM;
+		goto fail_nomem;
+	}
+
+	err =3D vboxsf_connect();
+	if (err) {
+		vbg_err("vboxsf: err %d connecting to guest PCI-device\n", err);
+		vbg_err("vboxsf: make sure you are inside a VirtualBox VM\n");
+		vbg_err("vboxsf: and check dmesg for vboxguest errors\n");
+		goto fail_free_cache;
+	}
+
+	err =3D vboxsf_set_utf8();
+	if (err) {
+		vbg_err("vboxsf_setutf8 error %d\n", err);
+		goto fail_disconnect;
+	}
+
+	if (!follow_symlinks) {
+		err =3D vboxsf_set_symlinks();
+		if (err)
+			vbg_warn("vboxsf: Unable to show symlinks: %d\n", err);
+	}
+
+	vboxsf_setup_done =3D true;
+success:
+	mutex_unlock(&vboxsf_setup_mutex);
+	return 0;
+
+fail_disconnect:
+	vboxsf_disconnect();
+fail_free_cache:
+	kmem_cache_destroy(vboxsf_inode_cachep);
+fail_nomem:
+	mutex_unlock(&vboxsf_setup_mutex);
+	return err;
+}
+
+static int vboxsf_parse_monolithic(struct fs_context *fc, void *data)
+{
+	char *options =3D data;
+
+	if (options && options[0] =3D=3D VBSF_MOUNT_SIGNATURE_BYTE_0 &&
+		       options[1] =3D=3D VBSF_MOUNT_SIGNATURE_BYTE_1 &&
+		       options[2] =3D=3D VBSF_MOUNT_SIGNATURE_BYTE_2 &&
+		       options[3] =3D=3D VBSF_MOUNT_SIGNATURE_BYTE_3) {
+		vbg_err("vboxsf: Old binary mount data not supported, remove obsolete =
mount.vboxsf and/or update your VBoxService.\n");
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
+	err =3D vboxsf_setup();
+	if (err)
+		return err;
+
+	return get_tree_nodev(fc, vboxsf_fill_super);
+}
+
+static int vboxsf_reconfigure(struct fs_context *fc)
+{
+	struct vboxsf_sbi *sbi =3D VBOXSF_SBI(fc->root->d_sb);
+	struct vboxsf_fs_context *ctx =3D fc->fs_private;
+	struct inode *iroot =3D fc->root->d_sb->s_root->d_inode;
+
+	/* Apply changed options to the root inode */
+	sbi->o =3D ctx->o;
+	vboxsf_init_inode(sbi, iroot, &sbi->root_info);
+
+	return 0;
+}
+
+static void vboxsf_free_fc(struct fs_context *fc)
+{
+	struct vboxsf_fs_context *ctx =3D fc->fs_private;
+
+	kfree(ctx->nls_name);
+	kfree(ctx);
+}
+
+static const struct fs_context_operations vboxsf_context_ops =3D {
+	.free			=3D vboxsf_free_fc,
+	.parse_param		=3D vboxsf_parse_param,
+	.parse_monolithic	=3D vboxsf_parse_monolithic,
+	.get_tree		=3D vboxsf_get_tree,
+	.reconfigure		=3D vboxsf_reconfigure,
+};
+
+static int vboxsf_init_fs_context(struct fs_context *fc)
+{
+	struct vboxsf_fs_context *ctx;
+
+	ctx =3D kzalloc(sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+
+	current_uid_gid(&ctx->o.uid, &ctx->o.gid);
+
+	fc->fs_private =3D ctx;
+	fc->ops =3D &vboxsf_context_ops;
+	return 0;
+}
+
+static struct file_system_type vboxsf_fs_type =3D {
+	.owner			=3D THIS_MODULE,
+	.name			=3D "vboxsf",
+	.init_fs_context	=3D vboxsf_init_fs_context,
+	.parameters		=3D &vboxsf_fs_parameters,
+	.kill_sb		=3D kill_anon_super
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
+		kmem_cache_destroy(vboxsf_inode_cachep);
+	}
+	mutex_unlock(&vboxsf_setup_mutex);
+}
+
+module_init(vboxsf_init);
+module_exit(vboxsf_fini);
+
+MODULE_DESCRIPTION("Oracle VM VirtualBox Module for Host File System Acc=
ess");
+MODULE_AUTHOR("Oracle Corporation");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS_FS("vboxsf");
diff --git a/fs/vboxsf/utils.c b/fs/vboxsf/utils.c
new file mode 100644
index 000000000000..96bd160da48b
--- /dev/null
+++ b/fs/vboxsf/utils.c
@@ -0,0 +1,551 @@
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
+	struct vboxsf_sbi *sbi =3D VBOXSF_SBI(sb);
+	struct inode *inode;
+	unsigned long flags;
+	int cursor, ret;
+	u32 gen;
+
+	inode =3D new_inode(sb);
+	if (!inode)
+		return ERR_PTR(-ENOMEM);
+
+	idr_preload(GFP_KERNEL);
+	spin_lock_irqsave(&sbi->ino_idr_lock, flags);
+	cursor =3D idr_get_cursor(&sbi->ino_idr);
+	ret =3D idr_alloc_cyclic(&sbi->ino_idr, inode, 1, 0, GFP_ATOMIC);
+	if (ret >=3D 0 && ret < cursor)
+		sbi->next_generation++;
+	gen =3D sbi->next_generation;
+	spin_unlock_irqrestore(&sbi->ino_idr_lock, flags);
+	idr_preload_end();
+
+	if (ret < 0) {
+		iput(inode);
+		return ERR_PTR(ret);
+	}
+
+	inode->i_ino =3D ret;
+	inode->i_generation =3D gen;
+	return inode;
+}
+
+/* set [inode] attributes based on [info], uid/gid based on [sbi] */
+void vboxsf_init_inode(struct vboxsf_sbi *sbi, struct inode *inode,
+		       const struct shfl_fsobjinfo *info)
+{
+	const struct shfl_fsobjattr *attr;
+	s64 allocated;
+	int mode;
+
+	attr =3D &info->attr;
+
+#define mode_set(r) ((attr->mode & (SHFL_UNIX_##r)) ? (S_##r) : 0)
+
+	mode =3D mode_set(IRUSR);
+	mode |=3D mode_set(IWUSR);
+	mode |=3D mode_set(IXUSR);
+
+	mode |=3D mode_set(IRGRP);
+	mode |=3D mode_set(IWGRP);
+	mode |=3D mode_set(IXGRP);
+
+	mode |=3D mode_set(IROTH);
+	mode |=3D mode_set(IWOTH);
+	mode |=3D mode_set(IXOTH);
+
+#undef mode_set
+
+	/* We use the host-side values for these */
+	inode->i_flags |=3D S_NOATIME | S_NOCMTIME;
+	inode->i_mapping->a_ops =3D &vboxsf_reg_aops;
+
+	if (SHFL_IS_DIRECTORY(attr->mode)) {
+		inode->i_mode =3D sbi->o.dmode_set ? sbi->o.dmode : mode;
+		inode->i_mode &=3D ~sbi->o.dmask;
+		inode->i_mode |=3D S_IFDIR;
+		inode->i_op =3D &vboxsf_dir_iops;
+		inode->i_fop =3D &vboxsf_dir_fops;
+		/*
+		 * XXX: this probably should be set to the number of entries
+		 * in the directory plus two (. ..)
+		 */
+		set_nlink(inode, 1);
+	} else if (SHFL_IS_SYMLINK(attr->mode)) {
+		inode->i_mode =3D sbi->o.fmode_set ? sbi->o.fmode : mode;
+		inode->i_mode &=3D ~sbi->o.fmask;
+		inode->i_mode |=3D S_IFLNK;
+		inode->i_op =3D &vboxsf_lnk_iops;
+		set_nlink(inode, 1);
+	} else {
+		inode->i_mode =3D sbi->o.fmode_set ? sbi->o.fmode : mode;
+		inode->i_mode &=3D ~sbi->o.fmask;
+		inode->i_mode |=3D S_IFREG;
+		inode->i_op =3D &vboxsf_reg_iops;
+		inode->i_fop =3D &vboxsf_reg_fops;
+		set_nlink(inode, 1);
+	}
+
+	inode->i_uid =3D sbi->o.uid;
+	inode->i_gid =3D sbi->o.gid;
+
+	inode->i_size =3D info->size;
+	inode->i_blkbits =3D 12;
+	/* i_blocks always in units of 512 bytes! */
+	allocated =3D info->allocated + 511;
+	do_div(allocated, 512);
+	inode->i_blocks =3D allocated;
+
+	inode->i_atime =3D ns_to_timespec64(
+				 info->access_time.ns_relative_to_unix_epoch);
+	inode->i_ctime =3D ns_to_timespec64(
+				 info->change_time.ns_relative_to_unix_epoch);
+	inode->i_mtime =3D ns_to_timespec64(
+			   info->modification_time.ns_relative_to_unix_epoch);
+}
+
+int vboxsf_create_at_dentry(struct dentry *dentry,
+			    struct shfl_createparms *params)
+{
+	struct vboxsf_sbi *sbi =3D VBOXSF_SBI(dentry->d_sb);
+	struct shfl_string *path;
+	int err;
+
+	path =3D vboxsf_path_from_dentry(sbi, dentry);
+	if (IS_ERR(path))
+		return PTR_ERR(path);
+
+	err =3D vboxsf_create(sbi->root, path, params);
+	__putname(path);
+
+	return err;
+}
+
+int vboxsf_stat(struct vboxsf_sbi *sbi, struct shfl_string *path,
+		struct shfl_fsobjinfo *info)
+{
+	struct shfl_createparms params =3D {};
+	int err;
+
+	params.handle =3D SHFL_HANDLE_NIL;
+	params.create_flags =3D SHFL_CF_LOOKUP | SHFL_CF_ACT_FAIL_IF_NEW;
+
+	err =3D vboxsf_create(sbi->root, path, &params);
+	if (err)
+		return err;
+
+	if (params.result !=3D SHFL_FILE_EXISTS)
+		return -ENOENT;
+
+	if (info)
+		*info =3D params.info;
+
+	return 0;
+}
+
+int vboxsf_stat_dentry(struct dentry *dentry, struct shfl_fsobjinfo *inf=
o)
+{
+	struct vboxsf_sbi *sbi =3D VBOXSF_SBI(dentry->d_sb);
+	struct shfl_string *path;
+	int err;
+
+	path =3D vboxsf_path_from_dentry(sbi, dentry);
+	if (IS_ERR(path))
+		return PTR_ERR(path);
+
+	err =3D vboxsf_stat(sbi, path, info);
+	__putname(path);
+	return err;
+}
+
+int vboxsf_inode_revalidate(struct dentry *dentry)
+{
+	struct vboxsf_sbi *sbi;
+	struct vboxsf_inode *sf_i;
+	struct shfl_fsobjinfo info;
+	struct timespec64 prev_mtime;
+	struct inode *inode;
+	int err;
+
+	if (!dentry || !d_really_is_positive(dentry))
+		return -EINVAL;
+
+	inode =3D d_inode(dentry);
+	prev_mtime =3D inode->i_mtime;
+	sf_i =3D VBOXSF_I(inode);
+	sbi =3D VBOXSF_SBI(dentry->d_sb);
+	if (!sf_i->force_restat) {
+		if (time_before(jiffies, dentry->d_time + sbi->o.ttl))
+			return 0;
+	}
+
+	err =3D vboxsf_stat_dentry(dentry, &info);
+	if (err)
+		return err;
+
+	dentry->d_time =3D jiffies;
+	sf_i->force_restat =3D 0;
+	vboxsf_init_inode(sbi, inode, &info);
+
+	/*
+	 * If the file was changed on the host side we need to invalidate the
+	 * page-cache for it.  Note this also gets triggered by our own writes,
+	 * this is unavoidable.
+	 */
+	if (timespec64_compare(&inode->i_mtime, &prev_mtime) > 0)
+		invalidate_inode_pages2(inode->i_mapping);
+
+	return 0;
+}
+
+int vboxsf_getattr(const struct path *path, struct kstat *kstat,
+		   u32 request_mask, unsigned int flags)
+{
+	int err;
+	struct dentry *dentry =3D path->dentry;
+	struct inode *inode =3D d_inode(dentry);
+	struct vboxsf_inode *sf_i =3D VBOXSF_I(inode);
+
+	switch (flags & AT_STATX_SYNC_TYPE) {
+	case AT_STATX_DONT_SYNC:
+		err =3D 0;
+		break;
+	case AT_STATX_FORCE_SYNC:
+		sf_i->force_restat =3D 1;
+		/* fall-through */
+	default:
+		err =3D vboxsf_inode_revalidate(dentry);
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
+	struct vboxsf_inode *sf_i =3D VBOXSF_I(d_inode(dentry));
+	struct vboxsf_sbi *sbi =3D VBOXSF_SBI(dentry->d_sb);
+	struct shfl_createparms params =3D {};
+	struct shfl_fsobjinfo info =3D {};
+	u32 buf_len;
+	int err;
+
+	params.handle =3D SHFL_HANDLE_NIL;
+	params.create_flags =3D SHFL_CF_ACT_OPEN_IF_EXISTS |
+			      SHFL_CF_ACT_FAIL_IF_NEW |
+			      SHFL_CF_ACCESS_ATTR_WRITE;
+
+	/* this is at least required for Posix hosts */
+	if (iattr->ia_valid & ATTR_SIZE)
+		params.create_flags |=3D SHFL_CF_ACCESS_WRITE;
+
+	err =3D vboxsf_create_at_dentry(dentry, &params);
+	if (err || params.result !=3D SHFL_FILE_EXISTS)
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
+			info.attr.mode =3D mode_set(IRUSR);
+			info.attr.mode |=3D mode_set(IWUSR);
+			info.attr.mode |=3D mode_set(IXUSR);
+			info.attr.mode |=3D mode_set(IRGRP);
+			info.attr.mode |=3D mode_set(IWGRP);
+			info.attr.mode |=3D mode_set(IXGRP);
+			info.attr.mode |=3D mode_set(IROTH);
+			info.attr.mode |=3D mode_set(IWOTH);
+			info.attr.mode |=3D mode_set(IXOTH);
+
+			if (iattr->ia_mode & S_IFDIR)
+				info.attr.mode |=3D SHFL_TYPE_DIRECTORY;
+			else
+				info.attr.mode |=3D SHFL_TYPE_FILE;
+		}
+
+		if (iattr->ia_valid & ATTR_ATIME)
+			info.access_time.ns_relative_to_unix_epoch =3D
+					    timespec64_to_ns(&iattr->ia_atime);
+
+		if (iattr->ia_valid & ATTR_MTIME)
+			info.modification_time.ns_relative_to_unix_epoch =3D
+					    timespec64_to_ns(&iattr->ia_mtime);
+
+		/*
+		 * Ignore ctime (inode change time) as it can't be set
+		 * from userland anyway.
+		 */
+
+		buf_len =3D sizeof(info);
+		err =3D vboxsf_fsinfo(sbi->root, params.handle,
+				    SHFL_INFO_SET | SHFL_INFO_FILE, &buf_len,
+				    &info);
+		if (err) {
+			vboxsf_close(sbi->root, params.handle);
+			return err;
+		}
+
+		/* the host may have given us different attr then requested */
+		sf_i->force_restat =3D 1;
+	}
+
+#undef mode_set
+
+	if (iattr->ia_valid & ATTR_SIZE) {
+		memset(&info, 0, sizeof(info));
+		info.size =3D iattr->ia_size;
+		buf_len =3D sizeof(info);
+		err =3D vboxsf_fsinfo(sbi->root, params.handle,
+				    SHFL_INFO_SET | SHFL_INFO_SIZE, &buf_len,
+				    &info);
+		if (err) {
+			vboxsf_close(sbi->root, params.handle);
+			return err;
+		}
+
+		/* the host may have given us different attr then requested */
+		sf_i->force_restat =3D 1;
+	}
+
+	vboxsf_close(sbi->root, params.handle);
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
+ * to [sbi]->nls, we must convert it to UTF8 here.
+ * Returns a shfl_string allocated through __getname (must be freed usin=
g
+ * __putname), or an ERR_PTR on error.
+ */
+struct shfl_string *vboxsf_path_from_dentry(struct vboxsf_sbi *sbi,
+					    struct dentry *dentry)
+{
+	struct shfl_string *shfl_path;
+	int path_len, out_len, nb;
+	char *buf, *path;
+	wchar_t uni;
+	u8 *out;
+
+	buf =3D __getname();
+	if (!buf)
+		return ERR_PTR(-ENOMEM);
+
+	path =3D dentry_path_raw(dentry, buf, PATH_MAX);
+	if (IS_ERR(path)) {
+		__putname(buf);
+		return ERR_CAST(path);
+	}
+	path_len =3D strlen(path);
+
+	if (sbi->nls) {
+		shfl_path =3D __getname();
+		if (!shfl_path) {
+			__putname(buf);
+			return ERR_PTR(-ENOMEM);
+		}
+
+		out =3D shfl_path->string.utf8;
+		out_len =3D PATH_MAX - SHFLSTRING_HEADER_SIZE - 1;
+
+		while (path_len) {
+			nb =3D sbi->nls->char2uni(path, path_len, &uni);
+			if (nb < 0) {
+				__putname(shfl_path);
+				__putname(buf);
+				return ERR_PTR(-EINVAL);
+			}
+			path +=3D nb;
+			path_len -=3D nb;
+
+			nb =3D utf32_to_utf8(uni, out, out_len);
+			if (nb < 0) {
+				__putname(shfl_path);
+				__putname(buf);
+				return ERR_PTR(-ENAMETOOLONG);
+			}
+			out +=3D nb;
+			out_len -=3D nb;
+		}
+		*out =3D 0;
+		shfl_path->length =3D out - shfl_path->string.utf8;
+		shfl_path->size =3D shfl_path->length + 1;
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
+		shfl_path =3D (struct shfl_string *)buf;
+		memmove(shfl_path->string.utf8, path, path_len);
+		shfl_path->string.utf8[path_len] =3D 0;
+		shfl_path->length =3D path_len;
+		shfl_path->size =3D path_len + 1;
+	}
+
+	return shfl_path;
+}
+
+int vboxsf_nlscpy(struct vboxsf_sbi *sbi, char *name, size_t name_bound_=
len,
+		  const unsigned char *utf8_name, size_t utf8_len)
+{
+	const char *in;
+	char *out;
+	size_t out_len;
+	size_t out_bound_len;
+	size_t in_bound_len;
+
+	in =3D utf8_name;
+	in_bound_len =3D utf8_len;
+
+	out =3D name;
+	out_len =3D 0;
+	/* Reserve space for terminating 0 */
+	out_bound_len =3D name_bound_len - 1;
+
+	while (in_bound_len) {
+		int nb;
+		unicode_t uni;
+
+		nb =3D utf8_to_utf32(in, in_bound_len, &uni);
+		if (nb < 0)
+			return -EINVAL;
+
+		in +=3D nb;
+		in_bound_len -=3D nb;
+
+		nb =3D sbi->nls->uni2char(uni, out, out_bound_len);
+		if (nb < 0)
+			return nb;
+
+		out +=3D nb;
+		out_bound_len -=3D nb;
+		out_len +=3D nb;
+	}
+
+	*out =3D 0;
+
+	return 0;
+}
+
+static struct vboxsf_dir_buf *vboxsf_dir_buf_alloc(struct list_head *lis=
t)
+{
+	struct vboxsf_dir_buf *b;
+
+	b =3D kmalloc(sizeof(*b), GFP_KERNEL);
+	if (!b)
+		return NULL;
+
+	b->buf =3D kmalloc(DIR_BUFFER_SIZE, GFP_KERNEL);
+	if (!b->buf) {
+		kfree(b);
+		return NULL;
+	}
+
+	b->entries =3D 0;
+	b->used =3D 0;
+	b->free =3D DIR_BUFFER_SIZE;
+	list_add(&b->head, list);
+
+	return b;
+}
+
+static void vboxsf_dir_buf_free(struct vboxsf_dir_buf *b)
+{
+	list_del(&b->head);
+	kfree(b->buf);
+	kfree(b);
+}
+
+struct vboxsf_dir_info *vboxsf_dir_info_alloc(void)
+{
+	struct vboxsf_dir_info *p;
+
+	p =3D kmalloc(sizeof(*p), GFP_KERNEL);
+	if (!p)
+		return NULL;
+
+	INIT_LIST_HEAD(&p->info_list);
+	return p;
+}
+
+void vboxsf_dir_info_free(struct vboxsf_dir_info *p)
+{
+	struct list_head *list, *pos, *tmp;
+
+	list =3D &p->info_list;
+	list_for_each_safe(pos, tmp, list) {
+		struct vboxsf_dir_buf *b;
+
+		b =3D list_entry(pos, struct vboxsf_dir_buf, head);
+		vboxsf_dir_buf_free(b);
+	}
+	kfree(p);
+}
+
+int vboxsf_dir_read_all(struct vboxsf_sbi *sbi, struct vboxsf_dir_info *=
sf_d,
+			u64 handle)
+{
+	struct vboxsf_dir_buf *b;
+	u32 entries, size;
+	int err =3D 0;
+	void *buf;
+
+	/* vboxsf_dirinfo returns 1 on end of dir */
+	while (err =3D=3D 0) {
+		b =3D vboxsf_dir_buf_alloc(&sf_d->info_list);
+		if (!b) {
+			err =3D -ENOMEM;
+			break;
+		}
+
+		buf =3D b->buf;
+		size =3D b->free;
+
+		err =3D vboxsf_dirinfo(sbi->root, handle, NULL, 0, 0,
+				     &size, buf, &entries);
+		if (err < 0)
+			break;
+
+		b->entries +=3D entries;
+		b->free -=3D size;
+		b->used +=3D size;
+	}
+
+	if (b && b->used =3D=3D 0)
+		vboxsf_dir_buf_free(b);
+
+	/* -EILSEQ means the host could not translate a filename, ignore */
+	if (err > 0 || err =3D=3D -EILSEQ)
+		err =3D 0;
+
+	return err;
+}
diff --git a/fs/vboxsf/vboxsf_wrappers.c b/fs/vboxsf/vboxsf_wrappers.c
new file mode 100644
index 000000000000..bfc78a097dae
--- /dev/null
+++ b/fs/vboxsf/vboxsf_wrappers.c
@@ -0,0 +1,371 @@
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
+	loc.type =3D VMMDEV_HGCM_LOC_LOCALHOST_EXISTING;
+	strcpy(loc.u.localhost.service_name, "VBoxSharedFolders");
+
+	gdev =3D vbg_get_gdev();
+	if (IS_ERR(gdev))
+		return -ENODEV;	/* No guest-device */
+
+	err =3D vbg_hgcm_connect(gdev, SHFL_REQUEST, &loc,
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
+	gdev =3D vbg_get_gdev();
+	if (IS_ERR(gdev))
+		return;   /* guest-device is gone, already disconnected */
+
+	vbg_hgcm_disconnect(gdev, SHFL_REQUEST, vboxsf_client_id, &vbox_status)=
;
+	vbg_put_gdev(gdev);
+}
+
+static int vboxsf_call(u32 function, void *parms, u32 parm_count, int *s=
tatus)
+{
+	struct vbg_dev *gdev;
+	int err, vbox_status;
+
+	gdev =3D vbg_get_gdev();
+	if (IS_ERR(gdev))
+		return -ESHUTDOWN; /* guest-dev removed underneath us */
+
+	err =3D vbg_hgcm_call(gdev, SHFL_REQUEST, vboxsf_client_id, function,
+			    U32_MAX, parms, parm_count, &vbox_status);
+	vbg_put_gdev(gdev);
+
+	if (err < 0)
+		return err;
+
+	if (status)
+		*status =3D vbox_status;
+
+	return vbg_status_code_to_errno(vbox_status);
+}
+
+int vboxsf_map_folder(struct shfl_string *folder_name, u32 *root)
+{
+	struct shfl_map_folder parms;
+	int err, status;
+
+	parms.path.type =3D VMMDEV_HGCM_PARM_TYPE_LINADDR_KERNEL;
+	parms.path.u.pointer.size =3D shfl_string_buf_size(folder_name);
+	parms.path.u.pointer.u.linear_addr =3D (uintptr_t)folder_name;
+
+	parms.root.type =3D VMMDEV_HGCM_PARM_TYPE_32BIT;
+	parms.root.u.value32 =3D 0;
+
+	parms.delimiter.type =3D VMMDEV_HGCM_PARM_TYPE_32BIT;
+	parms.delimiter.u.value32 =3D '/';
+
+	parms.case_sensitive.type =3D VMMDEV_HGCM_PARM_TYPE_32BIT;
+	parms.case_sensitive.u.value32 =3D 1;
+
+	err =3D vboxsf_call(SHFL_FN_MAP_FOLDER, &parms, SHFL_CPARMS_MAP_FOLDER,
+			  &status);
+	if (err =3D=3D -ENOSYS && status =3D=3D VERR_NOT_IMPLEMENTED)
+		vbg_err("%s: Error host is too old\n", __func__);
+
+	*root =3D parms.root.u.value32;
+	return err;
+}
+
+int vboxsf_unmap_folder(u32 root)
+{
+	struct shfl_unmap_folder parms;
+
+	parms.root.type =3D VMMDEV_HGCM_PARM_TYPE_32BIT;
+	parms.root.u.value32 =3D root;
+
+	return vboxsf_call(SHFL_FN_UNMAP_FOLDER, &parms,
+			   SHFL_CPARMS_UNMAP_FOLDER, NULL);
+}
+
+/**
+ * vboxsf_create - Create a new file or folder
+ * @root:         Root of the shared folder in which to create the file
+ * @parsed_path:  The path of the file or folder relative to the shared =
folder
+ * @param:        create_parms Parameters for file/folder creation.
+ *
+ * Create a new file or folder or open an existing one in a shared folde=
r.
+ * Note this function always returns 0 / success unless an exceptional c=
ondition
+ * occurs - out of memory, invalid arguments, etc. If the file or folder=
 could
+ * not be opened or created, create_parms->handle will be set to
+ * SHFL_HANDLE_NIL on return.  In this case the value in create_parms->r=
esult
+ * provides information as to why (e.g. SHFL_FILE_EXISTS), create_parms-=
>result
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
+	parms.root.type =3D VMMDEV_HGCM_PARM_TYPE_32BIT;
+	parms.root.u.value32 =3D root;
+
+	parms.path.type =3D VMMDEV_HGCM_PARM_TYPE_LINADDR_KERNEL;
+	parms.path.u.pointer.size =3D shfl_string_buf_size(parsed_path);
+	parms.path.u.pointer.u.linear_addr =3D (uintptr_t)parsed_path;
+
+	parms.parms.type =3D VMMDEV_HGCM_PARM_TYPE_LINADDR_KERNEL;
+	parms.parms.u.pointer.size =3D sizeof(struct shfl_createparms);
+	parms.parms.u.pointer.u.linear_addr =3D (uintptr_t)create_parms;
+
+	return vboxsf_call(SHFL_FN_CREATE, &parms, SHFL_CPARMS_CREATE, NULL);
+}
+
+int vboxsf_close(u32 root, u64 handle)
+{
+	struct shfl_close parms;
+
+	parms.root.type =3D VMMDEV_HGCM_PARM_TYPE_32BIT;
+	parms.root.u.value32 =3D root;
+
+	parms.handle.type =3D VMMDEV_HGCM_PARM_TYPE_64BIT;
+	parms.handle.u.value64 =3D handle;
+
+	return vboxsf_call(SHFL_FN_CLOSE, &parms, SHFL_CPARMS_CLOSE, NULL);
+}
+
+int vboxsf_remove(u32 root, struct shfl_string *parsed_path, u32 flags)
+{
+	struct shfl_remove parms;
+
+	parms.root.type =3D VMMDEV_HGCM_PARM_TYPE_32BIT;
+	parms.root.u.value32 =3D root;
+
+	parms.path.type =3D VMMDEV_HGCM_PARM_TYPE_LINADDR_KERNEL_IN;
+	parms.path.u.pointer.size =3D shfl_string_buf_size(parsed_path);
+	parms.path.u.pointer.u.linear_addr =3D (uintptr_t)parsed_path;
+
+	parms.flags.type =3D VMMDEV_HGCM_PARM_TYPE_32BIT;
+	parms.flags.u.value32 =3D flags;
+
+	return vboxsf_call(SHFL_FN_REMOVE, &parms, SHFL_CPARMS_REMOVE, NULL);
+}
+
+int vboxsf_rename(u32 root, struct shfl_string *src_path,
+		  struct shfl_string *dest_path, u32 flags)
+{
+	struct shfl_rename parms;
+
+	parms.root.type =3D VMMDEV_HGCM_PARM_TYPE_32BIT;
+	parms.root.u.value32 =3D root;
+
+	parms.src.type =3D VMMDEV_HGCM_PARM_TYPE_LINADDR_KERNEL_IN;
+	parms.src.u.pointer.size =3D shfl_string_buf_size(src_path);
+	parms.src.u.pointer.u.linear_addr =3D (uintptr_t)src_path;
+
+	parms.dest.type =3D VMMDEV_HGCM_PARM_TYPE_LINADDR_KERNEL_IN;
+	parms.dest.u.pointer.size =3D shfl_string_buf_size(dest_path);
+	parms.dest.u.pointer.u.linear_addr =3D (uintptr_t)dest_path;
+
+	parms.flags.type =3D VMMDEV_HGCM_PARM_TYPE_32BIT;
+	parms.flags.u.value32 =3D flags;
+
+	return vboxsf_call(SHFL_FN_RENAME, &parms, SHFL_CPARMS_RENAME, NULL);
+}
+
+int vboxsf_read(u32 root, u64 handle, u64 offset, u32 *buf_len, u8 *buf)
+{
+	struct shfl_read parms;
+	int err;
+
+	parms.root.type =3D VMMDEV_HGCM_PARM_TYPE_32BIT;
+	parms.root.u.value32 =3D root;
+
+	parms.handle.type =3D VMMDEV_HGCM_PARM_TYPE_64BIT;
+	parms.handle.u.value64 =3D handle;
+	parms.offset.type =3D VMMDEV_HGCM_PARM_TYPE_64BIT;
+	parms.offset.u.value64 =3D offset;
+	parms.cb.type =3D VMMDEV_HGCM_PARM_TYPE_32BIT;
+	parms.cb.u.value32 =3D *buf_len;
+	parms.buffer.type =3D VMMDEV_HGCM_PARM_TYPE_LINADDR_KERNEL_OUT;
+	parms.buffer.u.pointer.size =3D *buf_len;
+	parms.buffer.u.pointer.u.linear_addr =3D (uintptr_t)buf;
+
+	err =3D vboxsf_call(SHFL_FN_READ, &parms, SHFL_CPARMS_READ, NULL);
+
+	*buf_len =3D parms.cb.u.value32;
+	return err;
+}
+
+int vboxsf_write(u32 root, u64 handle, u64 offset, u32 *buf_len, u8 *buf=
)
+{
+	struct shfl_write parms;
+	int err;
+
+	parms.root.type =3D VMMDEV_HGCM_PARM_TYPE_32BIT;
+	parms.root.u.value32 =3D root;
+
+	parms.handle.type =3D VMMDEV_HGCM_PARM_TYPE_64BIT;
+	parms.handle.u.value64 =3D handle;
+	parms.offset.type =3D VMMDEV_HGCM_PARM_TYPE_64BIT;
+	parms.offset.u.value64 =3D offset;
+	parms.cb.type =3D VMMDEV_HGCM_PARM_TYPE_32BIT;
+	parms.cb.u.value32 =3D *buf_len;
+	parms.buffer.type =3D VMMDEV_HGCM_PARM_TYPE_LINADDR_KERNEL_IN;
+	parms.buffer.u.pointer.size =3D *buf_len;
+	parms.buffer.u.pointer.u.linear_addr =3D (uintptr_t)buf;
+
+	err =3D vboxsf_call(SHFL_FN_WRITE, &parms, SHFL_CPARMS_WRITE, NULL);
+
+	*buf_len =3D parms.cb.u.value32;
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
+	parms.root.type =3D VMMDEV_HGCM_PARM_TYPE_32BIT;
+	parms.root.u.value32 =3D root;
+
+	parms.handle.type =3D VMMDEV_HGCM_PARM_TYPE_64BIT;
+	parms.handle.u.value64 =3D handle;
+	parms.flags.type =3D VMMDEV_HGCM_PARM_TYPE_32BIT;
+	parms.flags.u.value32 =3D flags;
+	parms.cb.type =3D VMMDEV_HGCM_PARM_TYPE_32BIT;
+	parms.cb.u.value32 =3D *buf_len;
+	if (parsed_path) {
+		parms.path.type =3D VMMDEV_HGCM_PARM_TYPE_LINADDR_KERNEL_IN;
+		parms.path.u.pointer.size =3D shfl_string_buf_size(parsed_path);
+		parms.path.u.pointer.u.linear_addr =3D (uintptr_t)parsed_path;
+	} else {
+		parms.path.type =3D VMMDEV_HGCM_PARM_TYPE_LINADDR_IN;
+		parms.path.u.pointer.size =3D 0;
+		parms.path.u.pointer.u.linear_addr =3D 0;
+	}
+
+	parms.buffer.type =3D VMMDEV_HGCM_PARM_TYPE_LINADDR_KERNEL_OUT;
+	parms.buffer.u.pointer.size =3D *buf_len;
+	parms.buffer.u.pointer.u.linear_addr =3D (uintptr_t)buf;
+
+	parms.resume_point.type =3D VMMDEV_HGCM_PARM_TYPE_32BIT;
+	parms.resume_point.u.value32 =3D index;
+	parms.file_count.type =3D VMMDEV_HGCM_PARM_TYPE_32BIT;
+	parms.file_count.u.value32 =3D 0;	/* out parameter only */
+
+	err =3D vboxsf_call(SHFL_FN_LIST, &parms, SHFL_CPARMS_LIST, &status);
+	if (err =3D=3D -ENODATA && status =3D=3D VERR_NO_MORE_FILES)
+		err =3D 1;
+
+	*buf_len =3D parms.cb.u.value32;
+	*file_count =3D parms.file_count.u.value32;
+	return err;
+}
+
+int vboxsf_fsinfo(u32 root, u64 handle, u32 flags,
+		  u32 *buf_len, void *buf)
+{
+	struct shfl_information parms;
+	int err;
+
+	parms.root.type =3D VMMDEV_HGCM_PARM_TYPE_32BIT;
+	parms.root.u.value32 =3D root;
+
+	parms.handle.type =3D VMMDEV_HGCM_PARM_TYPE_64BIT;
+	parms.handle.u.value64 =3D handle;
+	parms.flags.type =3D VMMDEV_HGCM_PARM_TYPE_32BIT;
+	parms.flags.u.value32 =3D flags;
+	parms.cb.type =3D VMMDEV_HGCM_PARM_TYPE_32BIT;
+	parms.cb.u.value32 =3D *buf_len;
+	parms.info.type =3D VMMDEV_HGCM_PARM_TYPE_LINADDR_KERNEL;
+	parms.info.u.pointer.size =3D *buf_len;
+	parms.info.u.pointer.u.linear_addr =3D (uintptr_t)buf;
+
+	err =3D vboxsf_call(SHFL_FN_INFORMATION, &parms, SHFL_CPARMS_INFORMATIO=
N,
+			  NULL);
+
+	*buf_len =3D parms.cb.u.value32;
+	return err;
+}
+
+int vboxsf_readlink(u32 root, struct shfl_string *parsed_path,
+		    u32 buf_len, u8 *buf)
+{
+	struct shfl_readLink parms;
+
+	parms.root.type =3D VMMDEV_HGCM_PARM_TYPE_32BIT;
+	parms.root.u.value32 =3D root;
+
+	parms.path.type =3D VMMDEV_HGCM_PARM_TYPE_LINADDR_KERNEL_IN;
+	parms.path.u.pointer.size =3D shfl_string_buf_size(parsed_path);
+	parms.path.u.pointer.u.linear_addr =3D (uintptr_t)parsed_path;
+
+	parms.buffer.type =3D VMMDEV_HGCM_PARM_TYPE_LINADDR_KERNEL_OUT;
+	parms.buffer.u.pointer.size =3D buf_len;
+	parms.buffer.u.pointer.u.linear_addr =3D (uintptr_t)buf;
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
+	parms.root.type =3D VMMDEV_HGCM_PARM_TYPE_32BIT;
+	parms.root.u.value32 =3D root;
+
+	parms.new_path.type =3D VMMDEV_HGCM_PARM_TYPE_LINADDR_KERNEL_IN;
+	parms.new_path.u.pointer.size =3D shfl_string_buf_size(new_path);
+	parms.new_path.u.pointer.u.linear_addr =3D (uintptr_t)new_path;
+
+	parms.old_path.type =3D VMMDEV_HGCM_PARM_TYPE_LINADDR_KERNEL_IN;
+	parms.old_path.u.pointer.size =3D shfl_string_buf_size(old_path);
+	parms.old_path.u.pointer.u.linear_addr =3D (uintptr_t)old_path;
+
+	parms.info.type =3D VMMDEV_HGCM_PARM_TYPE_LINADDR_KERNEL_OUT;
+	parms.info.u.pointer.size =3D sizeof(struct shfl_fsobjinfo);
+	parms.info.u.pointer.u.linear_addr =3D (uintptr_t)buf;
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
index 000000000000..18f95b00fc33
--- /dev/null
+++ b/fs/vboxsf/vfsmod.h
@@ -0,0 +1,137 @@
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
+#include "shfl_hostintf.h"
+
+#define DIR_BUFFER_SIZE SZ_16K
+
+/* The cast is to prevent assignment of void * to pointers of arbitrary =
type */
+#define VBOXSF_SBI(sb)	((struct vboxsf_sbi *)(sb)->s_fs_info)
+#define VBOXSF_I(i)	container_of(i, struct vboxsf_inode, vfs_inode)
+
+struct vboxsf_options {
+	unsigned long ttl;
+	kuid_t uid;
+	kgid_t gid;
+	bool dmode_set;
+	bool fmode_set;
+	umode_t dmode;
+	umode_t fmode;
+	umode_t dmask;
+	umode_t fmask;
+};
+
+struct vboxsf_fs_context {
+	struct vboxsf_options o;
+	char *nls_name;
+};
+
+/* per-shared folder information */
+struct vboxsf_sbi {
+	struct vboxsf_options o;
+	struct shfl_fsobjinfo root_info;
+	struct idr ino_idr;
+	spinlock_t ino_idr_lock; /* This protects ino_idr */
+	struct nls_table *nls;
+	u32 next_generation;
+	u32 root;
+	int bdi_id;
+};
+
+/* per-inode information */
+struct vboxsf_inode {
+	/* some information was changed, update data on next revalidate */
+	int force_restat;
+	/* list of open handles for this inode + lock protecting it */
+	struct list_head handle_list;
+	/* This mutex protects handle_list accesses */
+	struct mutex handle_list_mutex;
+	/* The VFS inode struct */
+	struct inode vfs_inode;
+};
+
+struct vboxsf_dir_info {
+	struct list_head info_list;
+};
+
+struct vboxsf_dir_buf {
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
+void vboxsf_init_inode(struct vboxsf_sbi *sbi, struct inode *inode,
+		       const struct shfl_fsobjinfo *info);
+int vboxsf_create_at_dentry(struct dentry *dentry,
+			    struct shfl_createparms *params);
+int vboxsf_stat(struct vboxsf_sbi *sbi, struct shfl_string *path,
+		struct shfl_fsobjinfo *info);
+int vboxsf_stat_dentry(struct dentry *dentry, struct shfl_fsobjinfo *inf=
o);
+int vboxsf_inode_revalidate(struct dentry *dentry);
+int vboxsf_getattr(const struct path *path, struct kstat *kstat,
+		   u32 request_mask, unsigned int query_flags);
+int vboxsf_setattr(struct dentry *dentry, struct iattr *iattr);
+struct shfl_string *vboxsf_path_from_dentry(struct vboxsf_sbi *sbi,
+					    struct dentry *dentry);
+int vboxsf_nlscpy(struct vboxsf_sbi *sbi, char *name, size_t name_bound_=
len,
+		  const unsigned char *utf8_name, size_t utf8_len);
+struct vboxsf_dir_info *vboxsf_dir_info_alloc(void);
+void vboxsf_dir_info_free(struct vboxsf_dir_info *p);
+int vboxsf_dir_read_all(struct vboxsf_sbi *sbi, struct vboxsf_dir_info *=
sf_d,
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
+int vboxsf_read(u32 root, u64 handle, u64 offset, u32 *buf_len, u8 *buf)=
;
+int vboxsf_write(u32 root, u64 handle, u64 offset, u32 *buf_len, u8 *buf=
);
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
--=20
2.23.0

