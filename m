Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2519959F15
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2019 17:44:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbfF1Pn5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Jun 2019 11:43:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52125 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726657AbfF1Pn4 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Jun 2019 11:43:56 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F38CA3086215;
        Fri, 28 Jun 2019 15:43:50 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-219.rdu2.redhat.com [10.10.120.219])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 82BBD6062A;
        Fri, 28 Jun 2019 15:43:45 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 01/11] vfs: syscall: Add fsinfo() to query filesystem
 information [ver #15]
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, raven@themaw.net, mszeredi@redhat.com,
        christian@brauner.io, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 28 Jun 2019 16:43:45 +0100
Message-ID: <156173662509.14042.3867242748127323502.stgit@warthog.procyon.org.uk>
In-Reply-To: <156173661696.14042.17822154531324224780.stgit@warthog.procyon.org.uk>
References: <156173661696.14042.17822154531324224780.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Fri, 28 Jun 2019 15:43:56 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a system call to allow filesystem information to be queried.  A request
value can be given to indicate the desired attribute.  Support is provided
for enumerating multi-value attributes.

===============
NEW SYSTEM CALL
===============

The new system call looks like:

	int ret = fsinfo(int dfd,
			 const char *filename,
			 const struct fsinfo_params *params,
			 void *buffer,
			 size_t buf_size);

The params parameter optionally points to a block of parameters:

	struct fsinfo_params {
		__u32	at_flags;
		__u32	request;
		__u32	Nth;
		__u32	Mth;
		__u64	__reserved[3];
	};

If params is NULL, it is assumed params->request should be
fsinfo_attr_statfs, params->Nth should be 0, params->Mth should be 0 and
params->at_flags should be 0.

If params is given, all of params->__reserved[] must be 0.

dfd, filename and params->at_flags indicate the file to query.  There is no
equivalent of lstat() as that can be emulated with fsinfo() by setting
AT_SYMLINK_NOFOLLOW in params->at_flags.  There is also no equivalent of
fstat() as that can be emulated by passing a NULL filename to fsinfo() with
the fd of interest in dfd.  AT_NO_AUTOMOUNT can also be used to an allow
automount point to be queried without triggering it.

params->request indicates the attribute/attributes to be queried.  This can
be one of:

	FSINFO_ATTR_STATFS		- statfs-style info
	FSINFO_ATTR_FSINFO		- Information about fsinfo()
	FSINFO_ATTR_IDS			- Filesystem IDs
	FSINFO_ATTR_LIMITS		- Filesystem limits
	FSINFO_ATTR_SUPPORTS		- What's supported in statx(), IOC flags
	FSINFO_ATTR_CAPABILITIES	- Filesystem capabilities
	FSINFO_ATTR_TIMESTAMP_INFO	- Inode timestamp info
	FSINFO_ATTR_VOLUME_ID		- Volume ID (string)
	FSINFO_ATTR_VOLUME_UUID		- Volume UUID
	FSINFO_ATTR_VOLUME_NAME		- Volume name (string)
	FSINFO_ATTR_NAME_ENCODING	- Filename encoding (string)
	FSINFO_ATTR_NAME_CODEPAGE	- Filename codepage (string)

Some attributes (such as the servers backing a network filesystem) can have
multiple values.  These can be enumerated by setting params->Nth and
params->Mth to 0, 1, ... until ENODATA is returned.

buffer and buf_size point to the reply buffer.  The buffer is filled up to
the specified size, even if this means truncating the reply.  The full size
of the reply is returned.  In future versions, this will allow extra fields
to be tacked on to the end of the reply, but anyone not expecting them will
only get the subset they're expecting.  If either buffer of buf_size are 0,
no copy will take place and the data size will be returned.

At the moment, this will only work on x86_64 and i386 as it requires the
system call to be wired up.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-api@vger.kernel.org
---

 arch/x86/entry/syscalls/syscall_32.tbl |    1 
 arch/x86/entry/syscalls/syscall_64.tbl |    1 
 fs/Kconfig                             |    7 
 fs/Makefile                            |    1 
 fs/fsinfo.c                            |  545 ++++++++++++++++++++++++++++++++
 include/linux/fs.h                     |    5 
 include/linux/fsinfo.h                 |   65 ++++
 include/linux/syscalls.h               |    4 
 include/uapi/asm-generic/unistd.h      |    4 
 include/uapi/linux/fsinfo.h            |  219 +++++++++++++
 kernel/sys_ni.c                        |    1 
 samples/vfs/Makefile                   |    4 
 samples/vfs/test-fsinfo.c              |  551 ++++++++++++++++++++++++++++++++
 13 files changed, 1407 insertions(+), 1 deletion(-)
 create mode 100644 fs/fsinfo.c
 create mode 100644 include/linux/fsinfo.h
 create mode 100644 include/uapi/linux/fsinfo.h
 create mode 100644 samples/vfs/test-fsinfo.c

diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index ad968b7bac72..03decae51513 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -438,3 +438,4 @@
 431	i386	fsconfig		sys_fsconfig			__ia32_sys_fsconfig
 432	i386	fsmount			sys_fsmount			__ia32_sys_fsmount
 433	i386	fspick			sys_fspick			__ia32_sys_fspick
+434	i386	fsinfo			sys_fsinfo			__ia32_sys_fsinfo
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index b4e6f9e6204a..ea63df9a1020 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -355,6 +355,7 @@
 431	common	fsconfig		__x64_sys_fsconfig
 432	common	fsmount			__x64_sys_fsmount
 433	common	fspick			__x64_sys_fspick
+434	common	fsinfo			__x64_sys_fsinfo
 
 #
 # x32-specific system call numbers start at 512 to avoid cache impact
diff --git a/fs/Kconfig b/fs/Kconfig
index cbbffc8b9ef5..9e7d2f2c0111 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -15,6 +15,13 @@ config VALIDATE_FS_PARSER
 	  Enable this to perform validation of the parameter description for a
 	  filesystem when it is registered.
 
+config FSINFO
+	bool "Enable the fsinfo() system call"
+	help
+	  Enable the file system information querying system call to allow
+	  comprehensive information to be retrieved about a filesystem,
+	  superblock or mount object.
+
 if BLOCK
 
 config FS_IOMAP
diff --git a/fs/Makefile b/fs/Makefile
index c9aea23aba56..26eaeae4b9a1 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -53,6 +53,7 @@ obj-$(CONFIG_SYSCTL)		+= drop_caches.o
 
 obj-$(CONFIG_FHANDLE)		+= fhandle.o
 obj-$(CONFIG_FS_IOMAP)		+= iomap.o
+obj-$(CONFIG_FSINFO)		+= fsinfo.o
 
 obj-y				+= quota/
 
diff --git a/fs/fsinfo.c b/fs/fsinfo.c
new file mode 100644
index 000000000000..09e743b16235
--- /dev/null
+++ b/fs/fsinfo.c
@@ -0,0 +1,545 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Filesystem information query.
+ *
+ * Copyright (C) 2019 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+#include <linux/syscalls.h>
+#include <linux/fs.h>
+#include <linux/file.h>
+#include <linux/mount.h>
+#include <linux/namei.h>
+#include <linux/statfs.h>
+#include <linux/security.h>
+#include <linux/uaccess.h>
+#include <linux/fsinfo.h>
+#include <uapi/linux/mount.h>
+#include "internal.h"
+
+static u32 calc_mount_attrs(u32 mnt_flags)
+{
+	u32 attrs = 0;
+
+	if (mnt_flags & MNT_READONLY)
+		attrs |= MOUNT_ATTR_RDONLY;
+	if (mnt_flags & MNT_NOSUID)
+		attrs |= MOUNT_ATTR_NOSUID;
+	if (mnt_flags & MNT_NODEV)
+		attrs |= MOUNT_ATTR_NODEV;
+	if (mnt_flags & MNT_NOEXEC)
+		attrs |= MOUNT_ATTR_NOEXEC;
+	if (mnt_flags & MNT_NODIRATIME)
+		attrs |= MOUNT_ATTR_NODIRATIME;
+
+	if (mnt_flags & MNT_NOATIME)
+		attrs |= MOUNT_ATTR_NOATIME;
+	else if (mnt_flags & MNT_RELATIME)
+		attrs |= MOUNT_ATTR_RELATIME;
+	else
+		attrs |= MOUNT_ATTR_STRICTATIME;
+	return attrs;
+}
+
+/*
+ * Get basic filesystem stats from statfs.
+ */
+static int fsinfo_generic_statfs(struct path *path, struct fsinfo_statfs *p)
+{
+	struct kstatfs buf;
+	int ret;
+
+	ret = vfs_statfs(path, &buf);
+	if (ret < 0)
+		return ret;
+
+	p->f_blocks.hi	= 0;
+	p->f_blocks.lo	= buf.f_blocks;
+	p->f_bfree.hi	= 0;
+	p->f_bfree.lo	= buf.f_bfree;
+	p->f_bavail.hi	= 0;
+	p->f_bavail.lo	= buf.f_bavail;
+	p->f_files.hi	= 0;
+	p->f_files.lo	= buf.f_files;
+	p->f_ffree.hi	= 0;
+	p->f_ffree.lo	= buf.f_ffree;
+	p->f_favail.hi	= 0;
+	p->f_favail.lo	= buf.f_ffree;
+	p->f_bsize	= buf.f_bsize;
+	p->f_frsize	= buf.f_frsize;
+
+	p->mnt_attrs	= calc_mount_attrs(path->mnt->mnt_flags);
+	return sizeof(*p);
+}
+
+static int fsinfo_generic_ids(struct path *path, struct fsinfo_ids *p)
+{
+	struct super_block *sb;
+	struct kstatfs buf;
+	int ret;
+
+	ret = vfs_statfs(path, &buf);
+	if (ret < 0 && ret != -ENOSYS)
+		return ret;
+
+	sb = path->dentry->d_sb;
+	p->f_fstype	= sb->s_magic;
+	p->f_dev_major	= MAJOR(sb->s_dev);
+	p->f_dev_minor	= MINOR(sb->s_dev);
+
+	memcpy(&p->f_fsid, &buf.f_fsid, sizeof(p->f_fsid));
+	strlcpy(p->f_fs_name, path->dentry->d_sb->s_type->name,
+		sizeof(p->f_fs_name));
+	return sizeof(*p);
+}
+
+static int fsinfo_generic_limits(struct path *path, struct fsinfo_limits *lim)
+{
+	struct super_block *sb = path->dentry->d_sb;
+
+	lim->max_file_size.hi = 0;
+	lim->max_file_size.lo = sb->s_maxbytes;
+	lim->max_hard_links = sb->s_max_links;
+	lim->max_uid = UINT_MAX;
+	lim->max_gid = UINT_MAX;
+	lim->max_projid = UINT_MAX;
+	lim->max_filename_len = NAME_MAX;
+	lim->max_symlink_len = PAGE_SIZE;
+	lim->max_xattr_name_len = XATTR_NAME_MAX;
+	lim->max_xattr_body_len = XATTR_SIZE_MAX;
+	lim->max_dev_major = 0xffffff;
+	lim->max_dev_minor = 0xff;
+	return sizeof(*lim);
+}
+
+static int fsinfo_generic_supports(struct path *path, struct fsinfo_supports *c)
+{
+	struct super_block *sb = path->dentry->d_sb;
+
+	c->stx_mask = STATX_BASIC_STATS;
+	if (sb->s_d_op && sb->s_d_op->d_automount)
+		c->stx_attributes |= STATX_ATTR_AUTOMOUNT;
+	return sizeof(*c);
+}
+
+static int fsinfo_generic_capabilities(struct path *path,
+				       struct fsinfo_capabilities *c)
+{
+	struct super_block *sb = path->dentry->d_sb;
+
+	if (sb->s_mtd)
+		fsinfo_set_cap(c, FSINFO_CAP_IS_FLASH_FS);
+	else if (sb->s_bdev)
+		fsinfo_set_cap(c, FSINFO_CAP_IS_BLOCK_FS);
+
+	if (sb->s_quota_types & QTYPE_MASK_USR)
+		fsinfo_set_cap(c, FSINFO_CAP_USER_QUOTAS);
+	if (sb->s_quota_types & QTYPE_MASK_GRP)
+		fsinfo_set_cap(c, FSINFO_CAP_GROUP_QUOTAS);
+	if (sb->s_quota_types & QTYPE_MASK_PRJ)
+		fsinfo_set_cap(c, FSINFO_CAP_PROJECT_QUOTAS);
+	if (sb->s_d_op && sb->s_d_op->d_automount)
+		fsinfo_set_cap(c, FSINFO_CAP_AUTOMOUNTS);
+	if (sb->s_id[0])
+		fsinfo_set_cap(c, FSINFO_CAP_VOLUME_ID);
+
+	fsinfo_set_cap(c, FSINFO_CAP_HAS_ATIME);
+	fsinfo_set_cap(c, FSINFO_CAP_HAS_CTIME);
+	fsinfo_set_cap(c, FSINFO_CAP_HAS_MTIME);
+	return sizeof(*c);
+}
+
+static const struct fsinfo_timestamp_info fsinfo_default_timestamp_info = {
+	.atime = {
+		.minimum	= S64_MIN,
+		.maximum	= S64_MAX,
+		.gran_mantissa	= 1,
+		.gran_exponent	= 0,
+	},
+	.mtime = {
+		.minimum	= S64_MIN,
+		.maximum	= S64_MAX,
+		.gran_mantissa	= 1,
+		.gran_exponent	= 0,
+	},
+	.ctime = {
+		.minimum	= S64_MIN,
+		.maximum	= S64_MAX,
+		.gran_mantissa	= 1,
+		.gran_exponent	= 0,
+	},
+	.btime = {
+		.minimum	= S64_MIN,
+		.maximum	= S64_MAX,
+		.gran_mantissa	= 1,
+		.gran_exponent	= 0,
+	},
+};
+
+static int fsinfo_generic_timestamp_info(struct path *path,
+					 struct fsinfo_timestamp_info *ts)
+{
+	struct super_block *sb = path->dentry->d_sb;
+	s8 exponent;
+
+	*ts = fsinfo_default_timestamp_info;
+
+
+	if (sb->s_time_gran < 1000000000) {
+		if (sb->s_time_gran < 1000)
+			exponent = -9;
+		else if (sb->s_time_gran < 1000000)
+			exponent = -6;
+		else
+			exponent = -3;
+
+		ts->atime.gran_exponent = exponent;
+		ts->mtime.gran_exponent = exponent;
+		ts->ctime.gran_exponent = exponent;
+		ts->btime.gran_exponent = exponent;
+	}
+
+	return sizeof(*ts);
+}
+
+static int fsinfo_generic_volume_uuid(struct path *path,
+				      struct fsinfo_volume_uuid *vu)
+{
+	struct super_block *sb = path->dentry->d_sb;
+
+	memcpy(vu, &sb->s_uuid, sizeof(*vu));
+	return sizeof(*vu);
+}
+
+static int fsinfo_generic_volume_id(struct path *path, char *buf)
+{
+	struct super_block *sb = path->dentry->d_sb;
+	size_t len = strlen(sb->s_id);
+
+	memcpy(buf, sb->s_id, len + 1);
+	return len;
+}
+
+static int fsinfo_generic_name_encoding(struct path *path, char *buf)
+{
+	static const char encoding[] = "utf8";
+
+	memcpy(buf, encoding, sizeof(encoding) - 1);
+	return sizeof(encoding) - 1;
+}
+
+/*
+ * Implement some queries generically from stuff in the superblock.
+ */
+int generic_fsinfo(struct path *path, struct fsinfo_kparams *params)
+{
+#define _gen(X, Y) FSINFO_ATTR_##X: return fsinfo_generic_##Y(path, params->buffer)
+
+	switch (params->request) {
+	case _gen(STATFS,		statfs);
+	case _gen(IDS,			ids);
+	case _gen(LIMITS,		limits);
+	case _gen(SUPPORTS,		supports);
+	case _gen(CAPABILITIES,		capabilities);
+	case _gen(TIMESTAMP_INFO,	timestamp_info);
+	case _gen(VOLUME_UUID,		volume_uuid);
+	case _gen(VOLUME_ID,		volume_id);
+	case _gen(NAME_ENCODING,	name_encoding);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+EXPORT_SYMBOL(generic_fsinfo);
+
+/*
+ * Retrieve the filesystem info.  We make some stuff up if the operation is not
+ * supported.
+ */
+static int vfs_fsinfo(struct path *path, struct fsinfo_kparams *params)
+{
+	struct dentry *dentry = path->dentry;
+	int (*fsinfo)(struct path *, struct fsinfo_kparams *);
+	int ret;
+
+	if (params->request == FSINFO_ATTR_FSINFO) {
+		struct fsinfo_fsinfo *info = params->buffer;
+
+		info->max_attr	= FSINFO_ATTR__NR;
+		info->max_cap	= FSINFO_CAP__NR;
+		return sizeof(*info);
+	}
+
+	fsinfo = dentry->d_sb->s_op->fsinfo;
+	if (!fsinfo) {
+		if (!dentry->d_sb->s_op->statfs)
+			return -EOPNOTSUPP;
+		fsinfo = generic_fsinfo;
+	}
+
+	ret = security_sb_statfs(dentry);
+	if (ret)
+		return ret;
+
+	if (!params->overlarge)
+		return fsinfo(path, params);
+
+	while (!signal_pending(current)) {
+		params->usage = 0;
+		ret = fsinfo(path, params);
+		if (IS_ERR_VALUE((long)ret))
+			return ret; /* Error */
+		if ((unsigned int)ret <= params->buf_size)
+			return ret; /* It fitted */
+		kvfree(params->buffer);
+		params->buffer = NULL;
+		params->buf_size = roundup(ret, PAGE_SIZE);
+		if (params->buf_size > INT_MAX)
+			return -ETOOSMALL;
+		params->buffer = kvmalloc(params->buf_size, GFP_KERNEL);
+		if (!params->buffer)
+			return -ENOMEM;
+	}
+
+	return -ERESTARTSYS;
+}
+
+static int vfs_fsinfo_path(int dfd, const char __user *pathname,
+			   struct fsinfo_kparams *params)
+{
+	struct path path;
+	unsigned lookup_flags = LOOKUP_FOLLOW | LOOKUP_AUTOMOUNT;
+	int ret = -EINVAL;
+
+	if ((params->at_flags & ~(AT_SYMLINK_NOFOLLOW | AT_NO_AUTOMOUNT |
+				 AT_EMPTY_PATH)) != 0)
+		return -EINVAL;
+
+	if (params->at_flags & AT_SYMLINK_NOFOLLOW)
+		lookup_flags &= ~LOOKUP_FOLLOW;
+	if (params->at_flags & AT_NO_AUTOMOUNT)
+		lookup_flags &= ~LOOKUP_AUTOMOUNT;
+	if (params->at_flags & AT_EMPTY_PATH)
+		lookup_flags |= LOOKUP_EMPTY;
+
+retry:
+	ret = user_path_at(dfd, pathname, lookup_flags, &path);
+	if (ret)
+		goto out;
+
+	ret = vfs_fsinfo(&path, params);
+	path_put(&path);
+	if (retry_estale(ret, lookup_flags)) {
+		lookup_flags |= LOOKUP_REVAL;
+		goto retry;
+	}
+out:
+	return ret;
+}
+
+static int vfs_fsinfo_fd(unsigned int fd, struct fsinfo_kparams *params)
+{
+	struct fd f = fdget_raw(fd);
+	int ret = -EBADF;
+
+	if (f.file) {
+		ret = vfs_fsinfo(&f.file->f_path, params);
+		fdput(f);
+	}
+	return ret;
+}
+
+/*
+ * Return buffer information by requestable attribute.
+ *
+ * STRUCT	- a fixed-size structure with only one instance.
+ * STRUCT_N	- a sequence of STRUCTs, indexed by Nth
+ * STRUCT_NM	- a sequence of sequences of STRUCTs, indexed by Nth, Mth
+ * STRING	- a string with only one instance.
+ * STRING_N	- a sequence of STRING, indexed by Nth
+ * STRING_NM	- a sequence of sequences of STRING, indexed by Nth, Mth
+ * OPAQUE	- a blob that can be larger than 4K.
+ * STRUCT_ARRAY - an array of structs that can be larger than 4K
+ *
+ * If an entry is marked STRUCT, STRUCT_N or STRUCT_NM then if no buffer is
+ * supplied to sys_fsinfo(), sys_fsinfo() will handle returning the buffer size
+ * without calling vfs_fsinfo() and the filesystem.
+ *
+ * No struct may have more than 4K bytes.
+ */
+struct fsinfo_attr_info {
+	u8 type;
+	u8 flags;
+	u16 size;
+};
+
+#define __FSINFO_STRUCT		0
+#define __FSINFO_STRING		1
+#define __FSINFO_OPAQUE		2
+#define __FSINFO_STRUCT_ARRAY	3
+#define __FSINFO_0		0
+#define __FSINFO_N		0x0001
+#define __FSINFO_NM		0x0002
+
+#define _Z(T, F, S) { .type = __FSINFO_##T, .flags = __FSINFO_##F, .size = S }
+#define FSINFO_STRING(X)	 [FSINFO_ATTR_##X] = _Z(STRING, 0, 0)
+#define FSINFO_STRUCT(X,Y)	 [FSINFO_ATTR_##X] = _Z(STRUCT, 0, sizeof(struct fsinfo_##Y))
+#define FSINFO_STRING_N(X)	 [FSINFO_ATTR_##X] = _Z(STRING, N, 0)
+#define FSINFO_STRUCT_N(X,Y)	 [FSINFO_ATTR_##X] = _Z(STRUCT, N, sizeof(struct fsinfo_##Y))
+#define FSINFO_STRING_NM(X)	 [FSINFO_ATTR_##X] = _Z(STRING, NM, 0)
+#define FSINFO_STRUCT_NM(X,Y)	 [FSINFO_ATTR_##X] = _Z(STRUCT, NM, sizeof(struct fsinfo_##Y))
+#define FSINFO_OPAQUE(X)	 [FSINFO_ATTR_##X] = _Z(OPAQUE, 0, 0)
+#define FSINFO_STRUCT_ARRAY(X,Y) [FSINFO_ATTR_##X] = _Z(STRUCT_ARRAY, 0, sizeof(struct fsinfo_##Y))
+
+static const struct fsinfo_attr_info fsinfo_buffer_info[FSINFO_ATTR__NR] = {
+	FSINFO_STRUCT		(STATFS,		statfs),
+	FSINFO_STRUCT		(FSINFO,		fsinfo),
+	FSINFO_STRUCT		(IDS,			ids),
+	FSINFO_STRUCT		(LIMITS,		limits),
+	FSINFO_STRUCT		(CAPABILITIES,		capabilities),
+	FSINFO_STRUCT		(SUPPORTS,		supports),
+	FSINFO_STRUCT		(TIMESTAMP_INFO,	timestamp_info),
+	FSINFO_STRING		(VOLUME_ID),
+	FSINFO_STRUCT		(VOLUME_UUID,		volume_uuid),
+	FSINFO_STRING		(VOLUME_NAME),
+	FSINFO_STRING		(NAME_ENCODING),
+	FSINFO_STRING		(NAME_CODEPAGE),
+};
+
+/**
+ * sys_fsinfo - System call to get filesystem information
+ * @dfd: Base directory to pathwalk from or fd referring to filesystem.
+ * @pathname: Filesystem to query or NULL.
+ * @_params: Parameters to define request (or NULL for enhanced statfs).
+ * @user_buffer: Result buffer.
+ * @user_buf_size: Size of result buffer.
+ *
+ * Get information on a filesystem.  The filesystem attribute to be queried is
+ * indicated by @_params->request, and some of the attributes can have multiple
+ * values, indexed by @_params->Nth and @_params->Mth.  If @_params is NULL,
+ * then the 0th fsinfo_attr_statfs attribute is queried.  If an attribute does
+ * not exist, EOPNOTSUPP is returned; if the Nth,Mth value does not exist,
+ * ENODATA is returned.
+ *
+ * On success, the size of the attribute's value is returned.  If
+ * @user_buf_size is 0 or @user_buffer is NULL, only the size is returned.  If
+ * the size of the value is larger than @user_buf_size, it will be truncated by
+ * the copy.  If the size of the value is smaller than @user_buf_size then the
+ * excess buffer space will be cleared.  The full size of the value will be
+ * returned, irrespective of how much data is actually placed in the buffer.
+ */
+SYSCALL_DEFINE5(fsinfo,
+		int, dfd, const char __user *, pathname,
+		struct fsinfo_params __user *, params,
+		void __user *, user_buffer, size_t, user_buf_size)
+{
+	struct fsinfo_attr_info info;
+	struct fsinfo_params user_params;
+	struct fsinfo_kparams kparams;
+	unsigned int result_size;
+	int ret;
+
+	memset(&kparams, 0, sizeof(kparams));
+
+	if (params) {
+		if (copy_from_user(&user_params, params, sizeof(user_params)))
+			return -EFAULT;
+		if (user_params.__reserved[0] ||
+		    user_params.__reserved[1] ||
+		    user_params.__reserved[2])
+			return -EINVAL;
+		if (user_params.request >= FSINFO_ATTR__NR)
+			return -EOPNOTSUPP;
+		kparams.at_flags = user_params.at_flags;
+		kparams.request = user_params.request;
+		kparams.Nth = user_params.Nth;
+		kparams.Mth = user_params.Mth;
+	} else {
+		kparams.request = FSINFO_ATTR_STATFS;
+	}
+
+	if (!user_buffer || !user_buf_size) {
+		user_buf_size = 0;
+		user_buffer = NULL;
+	}
+
+	/* Allocate an appropriately-sized buffer.  We will truncate the
+	 * contents when we write the contents back to userspace.
+	 */
+	info = fsinfo_buffer_info[kparams.request];
+	if (kparams.Nth != 0 && !(info.flags & (__FSINFO_N | __FSINFO_NM)))
+		return -ENODATA;
+	if (kparams.Mth != 0 && !(info.flags & __FSINFO_NM))
+		return -ENODATA;
+
+	switch (info.type) {
+	case __FSINFO_STRUCT:
+		kparams.buf_size = info.size;
+		if (user_buf_size == 0)
+			return info.size; /* We know how big the buffer should be */
+		break;
+
+	case __FSINFO_STRING:
+		kparams.buf_size = FSINFO_NORMAL_ATTR_MAX_SIZE;
+		break;
+
+	case __FSINFO_OPAQUE:
+	case __FSINFO_STRUCT_ARRAY:
+		/* Opaque blob or array of struct elements.  We also create a
+		 * buffer that can be used for scratch space.
+		 */
+		ret = -ENOMEM;
+		kparams.scratch_buffer = kmalloc(FSINFO_SCRATCH_BUFFER_SIZE,
+						GFP_KERNEL);
+		if (!kparams.scratch_buffer)
+			goto error;
+		kparams.overlarge = true;
+		kparams.buf_size = FSINFO_NORMAL_ATTR_MAX_SIZE;
+		break;
+
+	default:
+		return -ENOBUFS;
+	}
+
+	/* We always allocate a buffer for a string, even if buf_size == 0 and
+	 * we're not going to return any data.  This means that the filesystem
+	 * code needn't care about whether the buffer actually exists or not.
+	 */
+	ret = -ENOMEM;
+	kparams.buffer = kvzalloc(kparams.buf_size, GFP_KERNEL);
+	if (!kparams.buffer)
+		goto error_scratch;
+
+	if (pathname)
+		ret = vfs_fsinfo_path(dfd, pathname, &kparams);
+	else
+		ret = vfs_fsinfo_fd(dfd, &kparams);
+	if (ret < 0)
+		goto error_buffer;
+
+	result_size = ret;
+	if (result_size > user_buf_size)
+		result_size = user_buf_size;
+
+	if (result_size > 0 &&
+	    copy_to_user(user_buffer, kparams.buffer, result_size) != 0) {
+		ret = -EFAULT;
+		goto error_buffer;
+	}
+
+	/* Clear any part of the buffer that we won't fill if we're putting a
+	 * struct in there.  Strings, opaque objects and arrays are expected to
+	 * be variable length.
+	 */
+	if (info.type == __FSINFO_STRUCT &&
+	    user_buf_size > result_size &&
+	    clear_user(user_buffer + result_size, user_buf_size - result_size) != 0) {
+		ret = -EFAULT;
+		goto error_buffer;
+	}
+
+error_buffer:
+	kvfree(kparams.buffer);
+error_scratch:
+	kfree(kparams.scratch_buffer);
+error:
+	return ret;
+}
diff --git a/include/linux/fs.h b/include/linux/fs.h
index f7fdfe93e25d..50f58eac3e1f 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -66,6 +66,8 @@ struct fscrypt_info;
 struct fscrypt_operations;
 struct fs_context;
 struct fs_parameter_description;
+struct fsinfo_kparams;
+enum fsinfo_attribute;
 
 extern void __init inode_init(void);
 extern void __init inode_init_early(void);
@@ -1922,6 +1924,9 @@ struct super_operations {
 	int (*thaw_super) (struct super_block *);
 	int (*unfreeze_fs) (struct super_block *);
 	int (*statfs) (struct dentry *, struct kstatfs *);
+#ifdef CONFIG_FSINFO
+	int (*fsinfo) (struct path *, struct fsinfo_kparams *);
+#endif
 	int (*remount_fs) (struct super_block *, int *, char *);
 	void (*umount_begin) (struct super_block *);
 
diff --git a/include/linux/fsinfo.h b/include/linux/fsinfo.h
new file mode 100644
index 000000000000..4c250136d693
--- /dev/null
+++ b/include/linux/fsinfo.h
@@ -0,0 +1,65 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Filesystem information query
+ *
+ * Copyright (C) 2019 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+
+#ifndef _LINUX_FSINFO_H
+#define _LINUX_FSINFO_H
+
+#ifdef CONFIG_FSINFO
+
+#include <uapi/linux/fsinfo.h>
+
+#define FSINFO_NORMAL_ATTR_MAX_SIZE 4096
+#define FSINFO_SCRATCH_BUFFER_SIZE 4096
+
+struct fsinfo_kparams {
+	__u32			at_flags;	/* AT_SYMLINK_NOFOLLOW and similar */
+	enum fsinfo_attribute	request;	/* What is being asking for */
+	__u32			Nth;		/* Instance of it (some may have multiple) */
+	__u32			Mth;		/* Subinstance */
+	bool			overlarge;	/* T if the buffer may be resized */
+	unsigned int		usage;		/* Amount of buffer used (if overlarge=T) */
+	unsigned int		buf_size;	/* Size of ->buffer[] */
+	void			*buffer;	/* Where to place the reply */
+	char			*scratch_buffer; /* 4K scratch buffer (if overlarge=T) */
+};
+
+extern int generic_fsinfo(struct path *, struct fsinfo_kparams *);
+
+static inline void fsinfo_set_cap(struct fsinfo_capabilities *c,
+				  enum fsinfo_capability cap)
+{
+	c->capabilities[cap / 8] |= 1 << (cap % 8);
+}
+
+static inline void fsinfo_clear_cap(struct fsinfo_capabilities *c,
+				    enum fsinfo_capability cap)
+{
+	c->capabilities[cap / 8] &= ~(1 << (cap % 8));
+}
+
+/**
+ * fsinfo_set_unix_caps - Set standard UNIX capabilities.
+ * @c: The capabilities mask to alter
+ */
+static inline void fsinfo_set_unix_caps(struct fsinfo_capabilities *caps)
+{
+	fsinfo_set_cap(caps, FSINFO_CAP_UIDS);
+	fsinfo_set_cap(caps, FSINFO_CAP_GIDS);
+	fsinfo_set_cap(caps, FSINFO_CAP_DIRECTORIES);
+	fsinfo_set_cap(caps, FSINFO_CAP_SYMLINKS);
+	fsinfo_set_cap(caps, FSINFO_CAP_HARD_LINKS);
+	fsinfo_set_cap(caps, FSINFO_CAP_DEVICE_FILES);
+	fsinfo_set_cap(caps, FSINFO_CAP_UNIX_SPECIALS);
+	fsinfo_set_cap(caps, FSINFO_CAP_SPARSE);
+	fsinfo_set_cap(caps, FSINFO_CAP_HAS_ATIME);
+	fsinfo_set_cap(caps, FSINFO_CAP_HAS_CTIME);
+	fsinfo_set_cap(caps, FSINFO_CAP_HAS_MTIME);
+}
+
+#endif /* CONFIG_FSINFO */
+
+#endif /* _LINUX_FSINFO_H */
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index e2870fe1be5b..958ac427ff37 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -50,6 +50,7 @@ struct stat64;
 struct statfs;
 struct statfs64;
 struct statx;
+struct fsinfo_params;
 struct __sysctl_args;
 struct sysinfo;
 struct timespec;
@@ -997,6 +998,9 @@ asmlinkage long sys_fspick(int dfd, const char __user *path, unsigned int flags)
 asmlinkage long sys_pidfd_send_signal(int pidfd, int sig,
 				       siginfo_t __user *info,
 				       unsigned int flags);
+asmlinkage long sys_fsinfo(int dfd, const char __user *pathname,
+			   struct fsinfo_params __user *params,
+			   void __user *buffer, size_t buf_size);
 
 /*
  * Architecture-specific system calls
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index a87904daf103..50ddf5f25122 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -844,9 +844,11 @@ __SYSCALL(__NR_fsconfig, sys_fsconfig)
 __SYSCALL(__NR_fsmount, sys_fsmount)
 #define __NR_fspick 433
 __SYSCALL(__NR_fspick, sys_fspick)
+#define __NR_fsinfo 434
+__SYSCALL(__NR_fsinfo, sys_fsinfo)
 
 #undef __NR_syscalls
-#define __NR_syscalls 434
+#define __NR_syscalls 435
 
 /*
  * 32 bit systems traditionally used different
diff --git a/include/uapi/linux/fsinfo.h b/include/uapi/linux/fsinfo.h
new file mode 100644
index 000000000000..cc7e13a9b95f
--- /dev/null
+++ b/include/uapi/linux/fsinfo.h
@@ -0,0 +1,219 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/* fsinfo() definitions.
+ *
+ * Copyright (C) 2019 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+#ifndef _UAPI_LINUX_FSINFO_H
+#define _UAPI_LINUX_FSINFO_H
+
+#include <linux/types.h>
+#include <linux/socket.h>
+
+/*
+ * The filesystem attributes that can be requested.  Note that some attributes
+ * may have multiple instances which can be switched in the parameter block.
+ */
+enum fsinfo_attribute {
+	FSINFO_ATTR_STATFS		= 0,	/* statfs()-style state */
+	FSINFO_ATTR_FSINFO		= 1,	/* Information about fsinfo() */
+	FSINFO_ATTR_IDS			= 2,	/* Filesystem IDs */
+	FSINFO_ATTR_LIMITS		= 3,	/* Filesystem limits */
+	FSINFO_ATTR_SUPPORTS		= 4,	/* What's supported in statx, iocflags, ... */
+	FSINFO_ATTR_CAPABILITIES	= 5,	/* Filesystem capabilities (bits) */
+	FSINFO_ATTR_TIMESTAMP_INFO	= 6,	/* Inode timestamp info */
+	FSINFO_ATTR_VOLUME_ID		= 7,	/* Volume ID (string) */
+	FSINFO_ATTR_VOLUME_UUID		= 8,	/* Volume UUID (LE uuid) */
+	FSINFO_ATTR_VOLUME_NAME		= 9,	/* Volume name (string) */
+	FSINFO_ATTR_NAME_ENCODING	= 10,	/* Filename encoding (string) */
+	FSINFO_ATTR_NAME_CODEPAGE	= 11,	/* Filename codepage (string) */
+	FSINFO_ATTR__NR
+};
+
+/*
+ * Optional fsinfo() parameter structure.
+ *
+ * If this is not given, it is assumed that fsinfo_attr_statfs instance 0,0 is
+ * desired.
+ */
+struct fsinfo_params {
+	__u32	at_flags;	/* AT_SYMLINK_NOFOLLOW and similar flags */
+	__u32	request;	/* What is being asking for (enum fsinfo_attribute) */
+	__u32	Nth;		/* Instance of it (some may have multiple) */
+	__u32	Mth;		/* Subinstance of Nth instance */
+	__u64	__reserved[3];	/* Reserved params; all must be 0 */
+};
+
+struct fsinfo_u128 {
+#if defined(__BYTE_ORDER) ? __BYTE_ORDER == __BIG_ENDIAN : defined(__BIG_ENDIAN)
+	__u64	hi;
+	__u64	lo;
+#elif defined(__BYTE_ORDER) ? __BYTE_ORDER == __LITTLE_ENDIAN : defined(__LITTLE_ENDIAN)
+	__u64	lo;
+	__u64	hi;
+#endif
+};
+
+/*
+ * Information struct for fsinfo(fsinfo_attr_statfs).
+ * - This gives extended filesystem information.
+ */
+struct fsinfo_statfs {
+	struct fsinfo_u128 f_blocks;	/* Total number of blocks in fs */
+	struct fsinfo_u128 f_bfree;	/* Total number of free blocks */
+	struct fsinfo_u128 f_bavail;	/* Number of free blocks available to ordinary user */
+	struct fsinfo_u128 f_files;	/* Total number of file nodes in fs */
+	struct fsinfo_u128 f_ffree;	/* Number of free file nodes */
+	struct fsinfo_u128 f_favail;	/* Number of file nodes available to ordinary user */
+	__u64	f_bsize;		/* Optimal block size */
+	__u64	f_frsize;		/* Fragment size */
+	__u64	mnt_attrs;		/* Mount attributes (MOUNT_ATTR_*) */
+};
+
+/*
+ * Information struct for fsinfo(fsinfo_attr_ids).
+ *
+ * List of basic identifiers as is normally found in statfs().
+ */
+struct fsinfo_ids {
+	char	f_fs_name[15 + 1];	/* Filesystem name */
+	__u64	f_fsid;			/* Short 64-bit Filesystem ID (as statfs) */
+	__u64	f_sb_id;		/* Internal superblock ID for sbnotify()/mntnotify() */
+	__u32	f_fstype;		/* Filesystem type from linux/magic.h [uncond] */
+	__u32	f_dev_major;		/* As st_dev_* from struct statx [uncond] */
+	__u32	f_dev_minor;
+	__u32	__reserved[1];
+};
+
+/*
+ * Information struct for fsinfo(fsinfo_attr_limits).
+ *
+ * List of supported filesystem limits.
+ */
+struct fsinfo_limits {
+	struct fsinfo_u128 max_file_size;	/* Maximum file size */
+	struct fsinfo_u128 max_ino;		/* Maximum inode number */
+	__u64	max_uid;			/* Maximum UID supported */
+	__u64	max_gid;			/* Maximum GID supported */
+	__u64	max_projid;			/* Maximum project ID supported */
+	__u64	max_hard_links;			/* Maximum number of hard links on a file */
+	__u64	max_xattr_body_len;		/* Maximum xattr content length */
+	__u32	max_xattr_name_len;		/* Maximum xattr name length */
+	__u32	max_filename_len;		/* Maximum filename length */
+	__u32	max_symlink_len;		/* Maximum symlink content length */
+	__u32	max_dev_major;			/* Maximum device major representable */
+	__u32	max_dev_minor;			/* Maximum device minor representable */
+	__u32	__reserved[1];
+};
+
+/*
+ * Information struct for fsinfo(fsinfo_attr_supports).
+ *
+ * What's supported in various masks, such as statx() attribute and mask bits
+ * and IOC flags.
+ */
+struct fsinfo_supports {
+	__u64	stx_attributes;		/* What statx::stx_attributes are supported */
+	__u32	stx_mask;		/* What statx::stx_mask bits are supported */
+	__u32	ioc_flags;		/* What FS_IOC_* flags are supported */
+	__u32	win_file_attrs;		/* What DOS/Windows FILE_* attributes are supported */
+	__u32	__reserved[1];
+};
+
+/*
+ * Information struct for fsinfo(fsinfo_attr_capabilities).
+ *
+ * Bitmask indicating filesystem capabilities where renderable as single bits.
+ */
+enum fsinfo_capability {
+	FSINFO_CAP_IS_KERNEL_FS		= 0,	/* fs is kernel-special filesystem */
+	FSINFO_CAP_IS_BLOCK_FS		= 1,	/* fs is block-based filesystem */
+	FSINFO_CAP_IS_FLASH_FS		= 2,	/* fs is flash filesystem */
+	FSINFO_CAP_IS_NETWORK_FS	= 3,	/* fs is network filesystem */
+	FSINFO_CAP_IS_AUTOMOUNTER_FS	= 4,	/* fs is automounter special filesystem */
+	FSINFO_CAP_IS_MEMORY_FS		= 5,	/* fs is memory-based filesystem */
+	FSINFO_CAP_AUTOMOUNTS		= 6,	/* fs supports automounts */
+	FSINFO_CAP_ADV_LOCKS		= 7,	/* fs supports advisory file locking */
+	FSINFO_CAP_MAND_LOCKS		= 8,	/* fs supports mandatory file locking */
+	FSINFO_CAP_LEASES		= 9,	/* fs supports file leases */
+	FSINFO_CAP_UIDS			= 10,	/* fs supports numeric uids */
+	FSINFO_CAP_GIDS			= 11,	/* fs supports numeric gids */
+	FSINFO_CAP_PROJIDS		= 12,	/* fs supports numeric project ids */
+	FSINFO_CAP_STRING_USER_IDS	= 13,	/* fs supports string user identifiers */
+	FSINFO_CAP_GUID_USER_IDS	= 14,	/* fs supports GUID user identifiers */
+	FSINFO_CAP_WINDOWS_ATTRS	= 15,	/* fs has windows attributes */
+	FSINFO_CAP_USER_QUOTAS		= 16,	/* fs has per-user quotas */
+	FSINFO_CAP_GROUP_QUOTAS		= 17,	/* fs has per-group quotas */
+	FSINFO_CAP_PROJECT_QUOTAS	= 18,	/* fs has per-project quotas */
+	FSINFO_CAP_XATTRS		= 19,	/* fs has xattrs */
+	FSINFO_CAP_JOURNAL		= 20,	/* fs has a journal */
+	FSINFO_CAP_DATA_IS_JOURNALLED	= 21,	/* fs is using data journalling */
+	FSINFO_CAP_O_SYNC		= 22,	/* fs supports O_SYNC */
+	FSINFO_CAP_O_DIRECT		= 23,	/* fs supports O_DIRECT */
+	FSINFO_CAP_VOLUME_ID		= 24,	/* fs has a volume ID */
+	FSINFO_CAP_VOLUME_UUID		= 25,	/* fs has a volume UUID */
+	FSINFO_CAP_VOLUME_NAME		= 26,	/* fs has a volume name */
+	FSINFO_CAP_VOLUME_FSID		= 27,	/* fs has a volume FSID */
+	FSINFO_CAP_IVER_ALL_CHANGE	= 28,	/* i_version represents data + meta changes */
+	FSINFO_CAP_IVER_DATA_CHANGE	= 29,	/* i_version represents data changes only */
+	FSINFO_CAP_IVER_MONO_INCR	= 30,	/* i_version incremented monotonically */
+	FSINFO_CAP_DIRECTORIES		= 31,	/* fs supports (sub)directories */
+	FSINFO_CAP_SYMLINKS		= 32,	/* fs supports symlinks */
+	FSINFO_CAP_HARD_LINKS		= 33,	/* fs supports hard links */
+	FSINFO_CAP_HARD_LINKS_1DIR	= 34,	/* fs supports hard links in same dir only */
+	FSINFO_CAP_DEVICE_FILES		= 35,	/* fs supports bdev, cdev */
+	FSINFO_CAP_UNIX_SPECIALS	= 36,	/* fs supports pipe, fifo, socket */
+	FSINFO_CAP_RESOURCE_FORKS	= 37,	/* fs supports resource forks/streams */
+	FSINFO_CAP_NAME_CASE_INDEP	= 38,	/* Filename case independence is mandatory */
+	FSINFO_CAP_NAME_NON_UTF8	= 39,	/* fs has non-utf8 names */
+	FSINFO_CAP_NAME_HAS_CODEPAGE	= 40,	/* fs has a filename codepage */
+	FSINFO_CAP_SPARSE		= 41,	/* fs supports sparse files */
+	FSINFO_CAP_NOT_PERSISTENT	= 42,	/* fs is not persistent */
+	FSINFO_CAP_NO_UNIX_MODE		= 43,	/* fs does not support unix mode bits */
+	FSINFO_CAP_HAS_ATIME		= 44,	/* fs supports access time */
+	FSINFO_CAP_HAS_BTIME		= 45,	/* fs supports birth/creation time */
+	FSINFO_CAP_HAS_CTIME		= 46,	/* fs supports change time */
+	FSINFO_CAP_HAS_MTIME		= 47,	/* fs supports modification time */
+	FSINFO_CAP__NR
+};
+
+struct fsinfo_capabilities {
+	__u8	capabilities[(FSINFO_CAP__NR + 7) / 8];
+};
+
+struct fsinfo_timestamp_one {
+	__s64	minimum;	/* Minimum timestamp value in seconds */
+	__u64	maximum;	/* Maximum timestamp value in seconds */
+	__u16	gran_mantissa;	/* Granularity(secs) = mant * 10^exp */
+	__s8	gran_exponent;
+	__u8	reserved[5];
+};
+
+/*
+ * Information struct for fsinfo(fsinfo_attr_timestamp_info).
+ */
+struct fsinfo_timestamp_info {
+	struct fsinfo_timestamp_one	atime;	/* Access time */
+	struct fsinfo_timestamp_one	mtime;	/* Modification time */
+	struct fsinfo_timestamp_one	ctime;	/* Change time */
+	struct fsinfo_timestamp_one	btime;	/* Birth/creation time */
+};
+
+/*
+ * Information struct for fsinfo(fsinfo_attr_volume_uuid).
+ */
+struct fsinfo_volume_uuid {
+	__u8	uuid[16];
+};
+
+/*
+ * Information struct for fsinfo(fsinfo_attr_fsinfo).
+ *
+ * This gives information about fsinfo() itself.
+ */
+struct fsinfo_fsinfo {
+	__u32	max_attr;	/* Number of supported attributes (fsinfo_attr__nr) */
+	__u32	max_cap;	/* Number of supported capabilities (fsinfo_cap__nr) */
+};
+
+#endif /* _UAPI_LINUX_FSINFO_H */
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index 4d9ae5ea6caf..93927072396c 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -51,6 +51,7 @@ COND_SYSCALL_COMPAT(io_pgetevents);
 COND_SYSCALL(io_uring_setup);
 COND_SYSCALL(io_uring_enter);
 COND_SYSCALL(io_uring_register);
+COND_SYSCALL(fsinfo);
 
 /* fs/xattr.c */
 
diff --git a/samples/vfs/Makefile b/samples/vfs/Makefile
index a3e4ffd4c773..d3cc8e9a4fd8 100644
--- a/samples/vfs/Makefile
+++ b/samples/vfs/Makefile
@@ -1,10 +1,14 @@
 # List of programs to build
 hostprogs-y := \
+	test-fsinfo \
 	test-fsmount \
 	test-statx
 
 # Tell kbuild to always build the programs
 always := $(hostprogs-y)
 
+HOSTCFLAGS_test-fsinfo.o += -I$(objtree)/usr/include
+HOSTLDLIBS_test-fsinfo += -lm
+
 HOSTCFLAGS_test-fsmount.o += -I$(objtree)/usr/include
 HOSTCFLAGS_test-statx.o += -I$(objtree)/usr/include
diff --git a/samples/vfs/test-fsinfo.c b/samples/vfs/test-fsinfo.c
new file mode 100644
index 000000000000..8cce1986df7e
--- /dev/null
+++ b/samples/vfs/test-fsinfo.c
@@ -0,0 +1,551 @@
+/* Test the fsinfo() system call
+ *
+ * Copyright (C) 2018 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public Licence
+ * as published by the Free Software Foundation; either version
+ * 2 of the Licence, or (at your option) any later version.
+ */
+
+#define _GNU_SOURCE
+#define _ATFILE_SOURCE
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <stdint.h>
+#include <string.h>
+#include <unistd.h>
+#include <ctype.h>
+#include <errno.h>
+#include <time.h>
+#include <math.h>
+#include <fcntl.h>
+#include <sys/syscall.h>
+#include <linux/fsinfo.h>
+#include <linux/socket.h>
+#include <sys/stat.h>
+#include <arpa/inet.h>
+
+#ifndef __NR_fsinfo
+#define __NR_fsinfo -1
+#endif
+
+static bool debug = 0;
+
+static __attribute__((unused))
+ssize_t fsinfo(int dfd, const char *filename, struct fsinfo_params *params,
+	       void *buffer, size_t buf_size)
+{
+	return syscall(__NR_fsinfo, dfd, filename, params, buffer, buf_size);
+}
+
+struct fsinfo_attr_info {
+	unsigned char	type;
+	unsigned char	flags;
+	unsigned short	size;
+};
+
+#define __FSINFO_STRUCT		0
+#define __FSINFO_STRING		1
+#define __FSINFO_OVER		2
+#define __FSINFO_STRUCT_ARRAY	3
+#define __FSINFO_0		0
+#define __FSINFO_N		0x0001
+#define __FSINFO_NM		0x0002
+
+#define _Z(T, F, S) { .type = __FSINFO_##T, .flags = __FSINFO_##F, .size = S }
+#define FSINFO_STRING(X,Y)	 [FSINFO_ATTR_##X] = _Z(STRING, 0, 0)
+#define FSINFO_STRUCT(X,Y)	 [FSINFO_ATTR_##X] = _Z(STRUCT, 0, sizeof(struct fsinfo_##Y))
+#define FSINFO_STRING_N(X,Y)	 [FSINFO_ATTR_##X] = _Z(STRING, N, 0)
+#define FSINFO_STRUCT_N(X,Y)	 [FSINFO_ATTR_##X] = _Z(STRUCT, N, sizeof(struct fsinfo_##Y))
+#define FSINFO_STRING_NM(X,Y)	 [FSINFO_ATTR_##X] = _Z(STRING, NM, 0)
+#define FSINFO_STRUCT_NM(X,Y)	 [FSINFO_ATTR_##X] = _Z(STRUCT, NM, sizeof(struct fsinfo_##Y))
+#define FSINFO_OVERLARGE(X,Y)	 [FSINFO_ATTR_##X] = _Z(OVER, 0, 0)
+#define FSINFO_STRUCT_ARRAY(X,Y) [FSINFO_ATTR_##X] = _Z(STRUCT_ARRAY, 0, sizeof(struct fsinfo_##Y))
+
+static const struct fsinfo_attr_info fsinfo_buffer_info[FSINFO_ATTR__NR] = {
+	FSINFO_STRUCT		(STATFS,		statfs),
+	FSINFO_STRUCT		(FSINFO,		fsinfo),
+	FSINFO_STRUCT		(IDS,			ids),
+	FSINFO_STRUCT		(LIMITS,		limits),
+	FSINFO_STRUCT		(CAPABILITIES,		capabilities),
+	FSINFO_STRUCT		(SUPPORTS,		supports),
+	FSINFO_STRUCT		(TIMESTAMP_INFO,	timestamp_info),
+	FSINFO_STRING		(VOLUME_ID,		volume_id),
+	FSINFO_STRUCT		(VOLUME_UUID,		volume_uuid),
+	FSINFO_STRING		(VOLUME_NAME,		volume_name),
+	FSINFO_STRING		(NAME_ENCODING,		name_encoding),
+	FSINFO_STRING		(NAME_CODEPAGE,		name_codepage),
+};
+
+#define FSINFO_NAME(X,Y) [FSINFO_ATTR_##X] = #Y
+static const char *fsinfo_attr_names[FSINFO_ATTR__NR] = {
+	FSINFO_NAME		(STATFS,		statfs),
+	FSINFO_NAME		(FSINFO,		fsinfo),
+	FSINFO_NAME		(IDS,			ids),
+	FSINFO_NAME		(LIMITS,		limits),
+	FSINFO_NAME		(CAPABILITIES,		capabilities),
+	FSINFO_NAME		(SUPPORTS,		supports),
+	FSINFO_NAME		(TIMESTAMP_INFO,	timestamp_info),
+	FSINFO_NAME		(VOLUME_ID,		volume_id),
+	FSINFO_NAME		(VOLUME_UUID,		volume_uuid),
+	FSINFO_NAME		(VOLUME_NAME,		volume_name),
+	FSINFO_NAME		(NAME_ENCODING,		name_encoding),
+	FSINFO_NAME		(NAME_CODEPAGE,		name_codepage),
+};
+
+union reply {
+	char buffer[4096];
+	struct fsinfo_statfs statfs;
+	struct fsinfo_fsinfo fsinfo;
+	struct fsinfo_ids ids;
+	struct fsinfo_limits limits;
+	struct fsinfo_supports supports;
+	struct fsinfo_capabilities caps;
+	struct fsinfo_timestamp_info timestamps;
+	struct fsinfo_volume_uuid uuid;
+};
+
+static void dump_hex(unsigned int *data, int from, int to)
+{
+	unsigned offset, print_offset = 1, col = 0;
+
+	from /= 4;
+	to = (to + 3) / 4;
+
+	for (offset = from; offset < to; offset++) {
+		if (print_offset) {
+			printf("%04x: ", offset * 8);
+			print_offset = 0;
+		}
+		printf("%08x", data[offset]);
+		col++;
+		if ((col & 3) == 0) {
+			printf("\n");
+			print_offset = 1;
+		} else {
+			printf(" ");
+		}
+	}
+
+	if (!print_offset)
+		printf("\n");
+}
+
+static void dump_attr_STATFS(union reply *r, int size)
+{
+	struct fsinfo_statfs *f = &r->statfs;
+
+	printf("\n");
+	printf("\tblocks: n=%llu fr=%llu av=%llu\n",
+	       (unsigned long long)f->f_blocks.lo,
+	       (unsigned long long)f->f_bfree.lo,
+	       (unsigned long long)f->f_bavail.lo);
+
+	printf("\tfiles : n=%llu fr=%llu av=%llu\n",
+	       (unsigned long long)f->f_files.lo,
+	       (unsigned long long)f->f_ffree.lo,
+	       (unsigned long long)f->f_favail.lo);
+	printf("\tbsize : %llu\n", f->f_bsize);
+	printf("\tfrsize: %llu\n", f->f_frsize);
+	printf("\tmntfl : %llx\n", (unsigned long long)f->mnt_attrs);
+}
+
+static void dump_attr_FSINFO(union reply *r, int size)
+{
+	struct fsinfo_fsinfo *f = &r->fsinfo;
+
+	printf("max_attr=%u max_cap=%u\n", f->max_attr, f->max_cap);
+}
+
+static void dump_attr_IDS(union reply *r, int size)
+{
+	struct fsinfo_ids *f = &r->ids;
+
+	printf("\n");
+	printf("\tdev   : %02x:%02x\n", f->f_dev_major, f->f_dev_minor);
+	printf("\tfs    : type=%x name=%s\n", f->f_fstype, f->f_fs_name);
+	printf("\tfsid  : %llx\n", (unsigned long long)f->f_fsid);
+}
+
+static void dump_attr_LIMITS(union reply *r, int size)
+{
+	struct fsinfo_limits *f = &r->limits;
+
+	printf("\n");
+	printf("\tmax file size: %llx%016llx\n",
+	       (unsigned long long)f->max_file_size.hi,
+	       (unsigned long long)f->max_file_size.lo);
+	printf("\tmax ino:       %llx%016llx\n",
+	       (unsigned long long)f->max_ino.hi,
+	       (unsigned long long)f->max_ino.lo);
+	printf("\tmax ids      : u=%llx g=%llx p=%llx\n",
+	       (unsigned long long)f->max_uid,
+	       (unsigned long long)f->max_gid,
+	       (unsigned long long)f->max_projid);
+	printf("\tmax dev      : maj=%x min=%x\n",
+	       f->max_dev_major, f->max_dev_minor);
+	printf("\tmax links    : %llx\n",
+	       (unsigned long long)f->max_hard_links);
+	printf("\tmax xattr    : n=%x b=%llx\n",
+	       f->max_xattr_name_len,
+	       (unsigned long long)f->max_xattr_body_len);
+	printf("\tmax len      : file=%x sym=%x\n",
+	       f->max_filename_len, f->max_symlink_len);
+}
+
+static void dump_attr_SUPPORTS(union reply *r, int size)
+{
+	struct fsinfo_supports *f = &r->supports;
+
+	printf("\n");
+	printf("\tstx_attr=%llx\n", (unsigned long long)f->stx_attributes);
+	printf("\tstx_mask=%x\n", f->stx_mask);
+	printf("\tioc_flags=%x\n", f->ioc_flags);
+	printf("\twin_fattrs=%x\n", f->win_file_attrs);
+}
+
+#define FSINFO_CAP_NAME(C) [FSINFO_CAP_##C] = #C
+static const char *fsinfo_cap_names[FSINFO_CAP__NR] = {
+	FSINFO_CAP_NAME(IS_KERNEL_FS),
+	FSINFO_CAP_NAME(IS_BLOCK_FS),
+	FSINFO_CAP_NAME(IS_FLASH_FS),
+	FSINFO_CAP_NAME(IS_NETWORK_FS),
+	FSINFO_CAP_NAME(IS_AUTOMOUNTER_FS),
+	FSINFO_CAP_NAME(IS_MEMORY_FS),
+	FSINFO_CAP_NAME(AUTOMOUNTS),
+	FSINFO_CAP_NAME(ADV_LOCKS),
+	FSINFO_CAP_NAME(MAND_LOCKS),
+	FSINFO_CAP_NAME(LEASES),
+	FSINFO_CAP_NAME(UIDS),
+	FSINFO_CAP_NAME(GIDS),
+	FSINFO_CAP_NAME(PROJIDS),
+	FSINFO_CAP_NAME(STRING_USER_IDS),
+	FSINFO_CAP_NAME(GUID_USER_IDS),
+	FSINFO_CAP_NAME(WINDOWS_ATTRS),
+	FSINFO_CAP_NAME(USER_QUOTAS),
+	FSINFO_CAP_NAME(GROUP_QUOTAS),
+	FSINFO_CAP_NAME(PROJECT_QUOTAS),
+	FSINFO_CAP_NAME(XATTRS),
+	FSINFO_CAP_NAME(JOURNAL),
+	FSINFO_CAP_NAME(DATA_IS_JOURNALLED),
+	FSINFO_CAP_NAME(O_SYNC),
+	FSINFO_CAP_NAME(O_DIRECT),
+	FSINFO_CAP_NAME(VOLUME_ID),
+	FSINFO_CAP_NAME(VOLUME_UUID),
+	FSINFO_CAP_NAME(VOLUME_NAME),
+	FSINFO_CAP_NAME(VOLUME_FSID),
+	FSINFO_CAP_NAME(IVER_ALL_CHANGE),
+	FSINFO_CAP_NAME(IVER_DATA_CHANGE),
+	FSINFO_CAP_NAME(IVER_MONO_INCR),
+	FSINFO_CAP_NAME(DIRECTORIES),
+	FSINFO_CAP_NAME(SYMLINKS),
+	FSINFO_CAP_NAME(HARD_LINKS),
+	FSINFO_CAP_NAME(HARD_LINKS_1DIR),
+	FSINFO_CAP_NAME(DEVICE_FILES),
+	FSINFO_CAP_NAME(UNIX_SPECIALS),
+	FSINFO_CAP_NAME(RESOURCE_FORKS),
+	FSINFO_CAP_NAME(NAME_CASE_INDEP),
+	FSINFO_CAP_NAME(NAME_NON_UTF8),
+	FSINFO_CAP_NAME(NAME_HAS_CODEPAGE),
+	FSINFO_CAP_NAME(SPARSE),
+	FSINFO_CAP_NAME(NOT_PERSISTENT),
+	FSINFO_CAP_NAME(NO_UNIX_MODE),
+	FSINFO_CAP_NAME(HAS_ATIME),
+	FSINFO_CAP_NAME(HAS_BTIME),
+	FSINFO_CAP_NAME(HAS_CTIME),
+	FSINFO_CAP_NAME(HAS_MTIME),
+};
+
+static void dump_attr_CAPABILITIES(union reply *r, int size)
+{
+	struct fsinfo_capabilities *f = &r->caps;
+	int i;
+
+	for (i = 0; i < sizeof(f->capabilities); i++)
+		printf("%02x", f->capabilities[i]);
+	printf("\n");
+	for (i = 0; i < FSINFO_CAP__NR; i++)
+		if (f->capabilities[i / 8] & (1 << (i % 8)))
+			printf("\t- %s\n", fsinfo_cap_names[i]);
+}
+
+static void print_time(struct fsinfo_timestamp_one *t, char stamp)
+{
+	printf("\t%ctime : gran=%gs range=%llx-%llx\n",
+	       stamp,
+	       t->gran_mantissa * pow(10., t->gran_exponent),
+	       (long long)t->minimum,
+	       (long long)t->maximum);
+}
+
+static void dump_attr_TIMESTAMP_INFO(union reply *r, int size)
+{
+	struct fsinfo_timestamp_info *f = &r->timestamps;
+
+	printf("\n");
+	print_time(&f->atime, 'a');
+	print_time(&f->mtime, 'm');
+	print_time(&f->ctime, 'c');
+	print_time(&f->btime, 'b');
+}
+
+static void dump_attr_VOLUME_UUID(union reply *r, int size)
+{
+	struct fsinfo_volume_uuid *f = &r->uuid;
+
+	printf("%02x%02x%02x%02x-%02x%02x-%02x%02x-%02x%02x"
+	       "-%02x%02x%02x%02x%02x%02x\n",
+	       f->uuid[ 0], f->uuid[ 1],
+	       f->uuid[ 2], f->uuid[ 3],
+	       f->uuid[ 4], f->uuid[ 5],
+	       f->uuid[ 6], f->uuid[ 7],
+	       f->uuid[ 8], f->uuid[ 9],
+	       f->uuid[10], f->uuid[11],
+	       f->uuid[12], f->uuid[13],
+	       f->uuid[14], f->uuid[15]);
+}
+
+/*
+ *
+ */
+typedef void (*dumper_t)(union reply *r, int size);
+
+#define FSINFO_DUMPER(N) [FSINFO_ATTR_##N] = dump_attr_##N
+static const dumper_t fsinfo_attr_dumper[FSINFO_ATTR__NR] = {
+	FSINFO_DUMPER(STATFS),
+	FSINFO_DUMPER(FSINFO),
+	FSINFO_DUMPER(IDS),
+	FSINFO_DUMPER(LIMITS),
+	FSINFO_DUMPER(SUPPORTS),
+	FSINFO_DUMPER(CAPABILITIES),
+	FSINFO_DUMPER(TIMESTAMP_INFO),
+	FSINFO_DUMPER(VOLUME_UUID),
+};
+
+static void dump_fsinfo(enum fsinfo_attribute attr,
+			struct fsinfo_attr_info about,
+			union reply *r, int size)
+{
+	dumper_t dumper = fsinfo_attr_dumper[attr];
+	unsigned int len;
+
+	if (!dumper) {
+		printf("<no dumper>\n");
+		return;
+	}
+
+	len = about.size;
+	if (about.type == __FSINFO_STRUCT && size < len) {
+		printf("<short data %u/%u>\n", size, len);
+		return;
+	}
+
+	dumper(r, size);
+}
+
+/*
+ * Try one subinstance of an attribute.
+ */
+static int try_one(const char *file, struct fsinfo_params *params, bool raw)
+{
+	struct fsinfo_attr_info about;
+	union reply *r;
+	size_t buf_size = 4096;
+	char *p;
+	int ret;
+
+	for (;;) {
+		r = malloc(buf_size);
+		if (!r) {
+			perror("malloc");
+			exit(1);
+		}
+		memset(r->buffer, 0xbd, buf_size);
+
+		errno = 0;
+		ret = fsinfo(AT_FDCWD, file, params, r->buffer, buf_size);
+		if (params->request >= FSINFO_ATTR__NR) {
+			if (ret == -1 && errno == EOPNOTSUPP)
+				exit(0);
+			fprintf(stderr, "Unexpected error for too-large command %u: %m\n",
+				params->request);
+			exit(1);
+		}
+		if (ret == -1)
+			break;
+
+		if (ret <= buf_size)
+			break;
+		buf_size = (ret + 4096 - 1) & ~(4096 - 1);
+	}
+
+	if (debug)
+		printf("fsinfo(%s,%s,%u,%u) = %d: %m\n",
+		       file, fsinfo_attr_names[params->request],
+		       params->Nth, params->Mth, ret);
+
+	about = fsinfo_buffer_info[params->request];
+	if (ret == -1) {
+		if (errno == ENODATA) {
+			if (!(about.flags & (__FSINFO_N | __FSINFO_NM)) &&
+			    params->Nth == 0 && params->Mth == 0) {
+				fprintf(stderr,
+					"Unexpected ENODATA (%u[%u][%u])\n",
+					params->request, params->Nth, params->Mth);
+				exit(1);
+			}
+			return (params->Mth == 0) ? 2 : 1;
+		}
+		if (errno == EOPNOTSUPP) {
+			if (params->Nth > 0 || params->Mth > 0) {
+				fprintf(stderr,
+					"Should return -ENODATA (%u[%u][%u])\n",
+					params->request, params->Nth, params->Mth);
+				exit(1);
+			}
+			//printf("\e[33m%s\e[m: <not supported>\n",
+			//       fsinfo_attr_names[attr]);
+			return 2;
+		}
+		perror(file);
+		exit(1);
+	}
+
+	if (raw) {
+		if (ret > 4096)
+			ret = 4096;
+		dump_hex((unsigned int *)r->buffer, 0, ret);
+		return 0;
+	}
+
+	switch (about.flags & (__FSINFO_N | __FSINFO_NM)) {
+	case 0:
+		printf("\e[33m%s\e[m: ",
+		       fsinfo_attr_names[params->request]);
+		break;
+	case __FSINFO_N:
+		printf("\e[33m%s[%u]\e[m: ",
+		       fsinfo_attr_names[params->request],
+		       params->Nth);
+		break;
+	case __FSINFO_NM:
+		printf("\e[33m%s[%u][%u]\e[m: ",
+		       fsinfo_attr_names[params->request],
+		       params->Nth, params->Mth);
+		break;
+	}
+
+	switch (about.type) {
+	case __FSINFO_STRUCT:
+		dump_fsinfo(params->request, about, r, ret);
+		return 0;
+
+	case __FSINFO_STRING:
+		if (ret >= 4096) {
+			ret = 4096;
+			r->buffer[4092] = '.';
+			r->buffer[4093] = '.';
+			r->buffer[4094] = '.';
+			r->buffer[4095] = 0;
+		} else {
+			r->buffer[ret] = 0;
+		}
+		for (p = r->buffer; *p; p++) {
+			if (!isprint(*p)) {
+				printf("<non-printable>\n");
+				continue;
+			}
+		}
+		printf("%s\n", r->buffer);
+		return 0;
+
+	case __FSINFO_OVER:
+		return 0;
+
+	case __FSINFO_STRUCT_ARRAY:
+		dump_fsinfo(params->request, about, r, ret);
+		return 0;
+
+	default:
+		fprintf(stderr, "Fishy about %u %u,%u,%u\n",
+			params->request, about.type, about.flags, about.size);
+		exit(1);
+	}
+}
+
+/*
+ *
+ */
+int main(int argc, char **argv)
+{
+	struct fsinfo_params params = {
+		.at_flags = AT_SYMLINK_NOFOLLOW,
+	};
+	unsigned int attr;
+	int raw = 0, opt, Nth, Mth;
+
+	while ((opt = getopt(argc, argv, "adlr"))) {
+		switch (opt) {
+		case 'a':
+			params.at_flags |= AT_NO_AUTOMOUNT;
+			continue;
+		case 'd':
+			debug = true;
+			continue;
+		case 'l':
+			params.at_flags &= ~AT_SYMLINK_NOFOLLOW;
+			continue;
+		case 'r':
+			raw = 1;
+			continue;
+		}
+		break;
+	}
+
+	argc -= optind;
+	argv += optind;
+
+	if (argc != 1) {
+		printf("Format: test-fsinfo [-alr] <file>\n");
+		exit(2);
+	}
+
+	for (attr = 0; attr <= FSINFO_ATTR__NR; attr++) {
+		Nth = 0;
+		do {
+			Mth = 0;
+			do {
+				params.request = attr;
+				params.Nth = Nth;
+				params.Mth = Mth;
+
+				switch (try_one(argv[0], &params, raw)) {
+				case 0:
+					continue;
+				case 1:
+					goto done_M;
+				case 2:
+					goto done_N;
+				}
+			} while (++Mth < 100);
+
+		done_M:
+			if (Mth >= 100) {
+				fprintf(stderr, "Fishy: Mth == %u\n", Mth);
+				break;
+			}
+
+		} while (++Nth < 100);
+
+	done_N:
+		if (Nth >= 100) {
+			fprintf(stderr, "Fishy: Nth == %u\n", Nth);
+			break;
+		}
+	}
+
+	return 0;
+}

