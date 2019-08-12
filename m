Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A7B58A399
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2019 18:43:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726972AbfHLQnL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Aug 2019 12:43:11 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55687 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726789AbfHLQnL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Aug 2019 12:43:11 -0400
Received: by mail-wm1-f67.google.com with SMTP id f72so146562wmf.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Aug 2019 09:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=plexistor-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BroGh2q7OE4CHVcDWVWYSOQmywIP14CNVLXimtG/kJU=;
        b=x3bPJxC1UCgQ0XUPYqPZ6xrmhJGqet2IKVneopY8wNQNjYXI62ktqRCSD8p831ps7j
         ThnKmXOnRUVuUo1CW7UhGbrhOg+CVF5Iiao5ey8+M2VgqzRtg72bLtA9bhbIQxqNVYZd
         xRoVjNCSr+u7YxOk6ZCSIoZzrLPDLomMDBhS1MpVlOEh+EyndqjuXiNrFkKpNfWfVERp
         whSUWbHafcteD+7eKIemijpz45WPZQC/UKaNA67sb4+4POvtaCbVyzrdtgX0nAC6DNco
         iuZomqvjUsZAQ3YlSKoEKvSEGGqYiTQUAefRfcMEuNd2yV6x5GpoXb0hq0eE5z41OV5f
         aHFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BroGh2q7OE4CHVcDWVWYSOQmywIP14CNVLXimtG/kJU=;
        b=OtnYmlWLd9W4OHGZmjpd24X1r4m6tjVwz+E1MvzlCW99MGUyU+pk6hakbH5EflxqbU
         OEKOCBaYmOKIZVRs8OGprpBAdwSifsDKn0/C9YOl3DYvAPNk1qXLy8PwJfZqCaZQFCW8
         8fHztgOyMrhkfBxPhOnHW9VH/WoDdkO5kqQEe8jCFSgsYQEbJFgPN9WOKPSicw44bCOO
         iiX+cKhlccr5SBkY7SgMMYAsrJ+YCqHcPK1Hg+ZCBt9jiyHZWn0l8FNB1dDBLSJmkN/V
         7i4J4hE4mqWjCowkxHY5pBotQWfYq7oQvOGppLdEP4onS2emAYxhWcRAFJY1F/ihk8Ba
         SaHw==
X-Gm-Message-State: APjAAAXW16b+9DPEdEvPjpLk9zGPJdRLyeaH+5txdhXmEOJzUbtUr5bs
        CeYu6kjxyU3Ja1p4SUg7y4uTsw==
X-Google-Smtp-Source: APXvYqygAiFe+x84ZBl2Iy25VYIhDUzULLP8xbxGbcSZHbGhy8cqY5MhAiNDiXb+kYFlrtSjMazSIQ==
X-Received: by 2002:a05:600c:228e:: with SMTP id 14mr182959wmf.101.1565628185723;
        Mon, 12 Aug 2019 09:43:05 -0700 (PDT)
Received: from Bfire.plexistor.com ([217.70.211.18])
        by smtp.googlemail.com with ESMTPSA id b2sm12378347wrf.94.2019.08.12.09.43.04
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 12 Aug 2019 09:43:05 -0700 (PDT)
From:   Boaz Harrosh <boaz@plexistor.com>
X-Google-Original-From: Boaz Harrosh <boazh@netapp.com>
To:     Boaz Harrosh <boaz@plexistor.com>,
        Boaz Harrosh <ooo@electrozaur.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Cc:     Boaz Harrosh <boazh@netapp.com>
Subject: [PATCH 08/16] zuf: Namei and directory operations
Date:   Mon, 12 Aug 2019 19:42:36 +0300
Message-Id: <20190812164244.15580-9-boazh@netapp.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190812164244.15580-1-boazh@netapp.com>
References: <20190812164244.15580-1-boazh@netapp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Introducing Creation/deletion of files
Directory add/remove
Other namei operations

This is all a very STD Kernel way of doing things.
Each VFS operation is packed and dispatched to Server.
After dispatch return, pushing results into Kernel
structures

NOTE: The use of a zufs_inode communication structure
that is returned as a zufs_dpp_t (Dual port pointer)
Both Kernel and Server can read/write to this object.
If Kernel modifies this object it is always before
the dispatch so server can persist the changes.
It is also used by Server to return new info to be updated
into the vfs_inode.
In a pmem system this object can be directly pointing
to storage.

Signed-off-by: Boaz Harrosh <boazh@netapp.com>
---
 fs/zuf/Makefile    |   2 +-
 fs/zuf/_extern.h   |  44 ++++
 fs/zuf/directory.c | 100 ++++++++
 fs/zuf/file.c      |  41 ++++
 fs/zuf/inode.c     | 563 ++++++++++++++++++++++++++++++++++++++++++++-
 fs/zuf/namei.c     | 402 ++++++++++++++++++++++++++++++++
 fs/zuf/super.c     |   2 +
 fs/zuf/zuf-core.c  |  10 +
 fs/zuf/zuf.h       |  63 +++++
 fs/zuf/zus_api.h   |  94 ++++++++
 10 files changed, 1319 insertions(+), 2 deletions(-)
 create mode 100644 fs/zuf/directory.c
 create mode 100644 fs/zuf/file.c
 create mode 100644 fs/zuf/namei.c

diff --git a/fs/zuf/Makefile b/fs/zuf/Makefile
index a5800cad73fd..2bfed45723e3 100644
--- a/fs/zuf/Makefile
+++ b/fs/zuf/Makefile
@@ -17,5 +17,5 @@ zuf-y += md.o t1.o t2.o
 zuf-y += zuf-core.o zuf-root.o
 
 # Main FS
-zuf-y += super.o inode.o
+zuf-y += super.o inode.o directory.o namei.o file.o
 zuf-y += module.o
diff --git a/fs/zuf/_extern.h b/fs/zuf/_extern.h
index ba6d11b509d5..bf4531ccb80e 100644
--- a/fs/zuf/_extern.h
+++ b/fs/zuf/_extern.h
@@ -61,10 +61,54 @@ int zuf_private_mount(struct zuf_root_info *zri, struct register_fs_info *rfi,
 		      struct zufs_mount_info *zmi, struct super_block **sb_out);
 int zuf_private_umount(struct zuf_root_info *zri, struct super_block *sb);
 
+/* file.c */
+int zuf_isync(struct inode *inode, loff_t start, loff_t end, int datasync);
+ssize_t zuf_write_iter(struct kiocb *kiocb, struct iov_iter *ii);
+ssize_t zuf_read_iter(struct kiocb *kiocb, struct iov_iter *ii);
+long __zuf_fallocate(struct inode *inode, int mode, loff_t offset, loff_t len);
+
+/* namei.c */
+void zuf_zii_sync(struct inode *inode, bool sync_nlink);
+
 /* inode.c */
+int zuf_evict_dispatch(struct super_block *sb, struct zus_inode_info *zus_ii,
+		       int operation, uint flags);
 struct inode *zuf_iget(struct super_block *sb, struct zus_inode_info *zus_ii,
 		       zu_dpp_t _zi, bool *exist);
+void zuf_evict_inode(struct inode *inode);
+struct inode *zuf_new_inode(struct inode *dir, umode_t mode,
+			    const struct qstr *qstr, const char *symname,
+			    ulong rdev_or_isize, bool tmpfile);
+int zuf_write_inode(struct inode *inode, struct writeback_control *wbc);
+int zuf_update_time(struct inode *inode, struct timespec64 *time, int flags);
+int zuf_setattr(struct dentry *dentry, struct iattr *attr);
+int zuf_getattr(const struct path *path, struct kstat *stat,
+		 u32 request_mask, unsigned int flags);
+void zuf_set_inode_flags(struct inode *inode, struct zus_inode *zi);
+
+/* directory.c */
+int zuf_add_dentry(struct inode *dir, struct qstr *str, struct inode *inode);
+int zuf_remove_dentry(struct inode *dir, struct qstr *str, struct inode *inode);
+
 /* t1.c */
 int zuf_pmem_mmap(struct file *file, struct vm_area_struct *vma);
 
+/*
+ * Inode and files operations
+ */
+
+/* file.c */
+extern const struct inode_operations zuf_file_inode_operations;
+extern const struct file_operations zuf_file_operations;
+
+/* inode.c */
+extern const struct address_space_operations zuf_aops;
+
+/* namei.c */
+extern const struct inode_operations zuf_dir_inode_operations;
+extern const struct inode_operations zuf_special_inode_operations;
+
+/* dir.c */
+extern const struct file_operations zuf_dir_operations;
+
 #endif	/*ndef __ZUF_EXTERN_H__*/
diff --git a/fs/zuf/directory.c b/fs/zuf/directory.c
new file mode 100644
index 000000000000..5624e05f96e5
--- /dev/null
+++ b/fs/zuf/directory.c
@@ -0,0 +1,100 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * BRIEF DESCRIPTION
+ *
+ * File operations for directories.
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
+#include <linux/fs.h>
+#include <linux/vmalloc.h>
+#include "zuf.h"
+
+static int zuf_readdir(struct file *file, struct dir_context *ctx)
+{
+	return -ENOTSUPP;
+}
+
+/*
+ *FIXME comment to full git diff
+ */
+
+static int _dentry_dispatch(struct inode *dir, struct inode *inode,
+			    struct qstr *str, int operation)
+{
+	struct zufs_ioc_dentry ioc_dentry = {
+		.hdr.operation = operation,
+		.hdr.in_len = sizeof(ioc_dentry),
+		.hdr.out_len = sizeof(ioc_dentry),
+		.zus_ii = inode ? ZUII(inode)->zus_ii : NULL,
+		.zus_dir_ii = ZUII(dir)->zus_ii,
+		.str.len = str->len,
+	};
+	int err;
+
+	memcpy(&ioc_dentry.str.name, str->name, str->len);
+
+	err = zufc_dispatch(ZUF_ROOT(SBI(dir->i_sb)), &ioc_dentry.hdr, NULL, 0);
+	if (unlikely(err)) {
+		zuf_dbg_err("[%ld] op=%d zufc_dispatch failed => %d\n",
+			    dir->i_ino, operation, err);
+		return err;
+	}
+
+	return 0;
+}
+
+/* return pointer to added de on success, err-code on failure */
+int zuf_add_dentry(struct inode *dir, struct qstr *str, struct inode *inode)
+{
+	struct zuf_inode_info *zii = ZUII(dir);
+	int err;
+
+	if (!str->len || !zii->zi)
+		return -EINVAL;
+
+	zus_inode_cmtime_now(dir, zii->zi);
+	err = _dentry_dispatch(dir, inode, str, ZUFS_OP_ADD_DENTRY);
+	if (unlikely(err)) {
+		zuf_dbg_err("[%ld] _dentry_dispatch failed => %d\n",
+			    dir->i_ino, err);
+		return err;
+	}
+	zuf_zii_sync(dir, false);
+
+	return 0;
+}
+
+int zuf_remove_dentry(struct inode *dir, struct qstr *str, struct inode *inode)
+{
+	struct zuf_inode_info *zii = ZUII(dir);
+	int err;
+
+	if (!str->len)
+		return -EINVAL;
+
+	zus_inode_cmtime_now(dir, zii->zi);
+	err = _dentry_dispatch(dir, inode, str, ZUFS_OP_REMOVE_DENTRY);
+	if (unlikely(err)) {
+		zuf_dbg_err("[%ld] _dentry_dispatch failed => %d\n",
+			    dir->i_ino, err);
+		return err;
+	}
+	zuf_zii_sync(dir, false);
+
+	return 0;
+}
+
+const struct file_operations zuf_dir_operations = {
+	.llseek		= generic_file_llseek,
+	.read		= generic_read_dir,
+	.iterate_shared	= zuf_readdir,
+	.fsync		= noop_fsync,
+};
diff --git a/fs/zuf/file.c b/fs/zuf/file.c
new file mode 100644
index 000000000000..0581bb8bab2e
--- /dev/null
+++ b/fs/zuf/file.c
@@ -0,0 +1,41 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * BRIEF DESCRIPTION
+ *
+ * File operations for files.
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
+#include "zuf.h"
+
+long __zuf_fallocate(struct inode *inode, int mode, loff_t offset, loff_t len)
+{
+	return -ENOTSUPP;
+}
+
+ssize_t zuf_read_iter(struct kiocb *kiocb, struct iov_iter *ii)
+{
+	return -ENOTSUPP;
+}
+
+ssize_t zuf_write_iter(struct kiocb *kiocb, struct iov_iter *ii)
+{
+	return -ENOTSUPP;
+}
+
+const struct file_operations zuf_file_operations = {
+	.open			= generic_file_open,
+};
+
+const struct inode_operations zuf_file_inode_operations = {
+	.setattr	= zuf_setattr,
+	.getattr	= zuf_getattr,
+	.update_time	= zuf_update_time,
+};
diff --git a/fs/zuf/inode.c b/fs/zuf/inode.c
index a6115289dcda..0e6d835b4db5 100644
--- a/fs/zuf/inode.c
+++ b/fs/zuf/inode.c
@@ -13,11 +13,572 @@
  *	Sagi Manole <sagim@netapp.com>"
  */
 
+#include <linux/fs.h>
+#include <linux/aio.h>
+#include <linux/highuid.h>
+#include <linux/module.h>
+#include <linux/mpage.h>
+#include <linux/backing-dev.h>
+#include <linux/types.h>
+#include <linux/ratelimit.h>
+#include <linux/posix_acl_xattr.h>
+#include <linux/security.h>
+#include <linux/delay.h>
+#include <linux/falloc.h>
+#include <linux/swap.h>
+#include <linux/uio.h>
 #include "zuf.h"
 
+/* Flags that should be inherited by new inodes from their parent. */
+#define ZUFS_FL_INHERITED (S_SYNC | S_NOATIME | S_DIRSYNC)
+
+/* Flags that are appropriate for regular files (all but dir-specific ones). */
+#define ZUFS_FL_REG_MASK (~S_DIRSYNC)
+
+/* Flags that are appropriate for non-dir/non-regular files. */
+#define ZUFS_FL_OTHER_MASK (S_NOATIME)
+
+static bool _zi_valid(struct zus_inode *zi)
+{
+	if (!_zi_active(zi))
+		return false;
+
+	switch (le16_to_cpu(zi->i_mode) & S_IFMT) {
+	case S_IFREG:
+	case S_IFDIR:
+	case S_IFLNK:
+	case S_IFBLK:
+	case S_IFCHR:
+	case S_IFIFO:
+	case S_IFSOCK:
+		return true;
+	default:
+		zuf_err("unknown file type ino=%lld mode=%d\n", zi->i_ino,
+			  zi->i_mode);
+		return false;
+	}
+}
+
+static void _set_inode_from_zi(struct inode *inode, struct zus_inode *zi)
+{
+	inode->i_mode = le16_to_cpu(zi->i_mode);
+	inode->i_uid = KUIDT_INIT(le32_to_cpu(zi->i_uid));
+	inode->i_gid = KGIDT_INIT(le32_to_cpu(zi->i_gid));
+	set_nlink(inode, le16_to_cpu(zi->i_nlink));
+	inode->i_size = le64_to_cpu(zi->i_size);
+	inode->i_blocks = le64_to_cpu(zi->i_blocks);
+	mt_to_timespec(&inode->i_atime, &zi->i_atime);
+	mt_to_timespec(&inode->i_ctime, &zi->i_ctime);
+	mt_to_timespec(&inode->i_mtime, &zi->i_mtime);
+	inode->i_generation = le64_to_cpu(zi->i_generation);
+	zuf_set_inode_flags(inode, zi);
+
+	inode->i_blocks = le64_to_cpu(zi->i_blocks);
+	inode->i_mapping->a_ops = &zuf_aops;
+
+	switch (inode->i_mode & S_IFMT) {
+	case S_IFREG:
+		inode->i_op = &zuf_file_inode_operations;
+		inode->i_fop = &zuf_file_operations;
+		break;
+	case S_IFDIR:
+		inode->i_op = &zuf_dir_inode_operations;
+		inode->i_fop = &zuf_dir_operations;
+		break;
+	case S_IFBLK:
+	case S_IFCHR:
+	case S_IFIFO:
+	case S_IFSOCK:
+		inode->i_size = 0;
+		inode->i_op = &zuf_special_inode_operations;
+		init_special_inode(inode, inode->i_mode,
+				   le32_to_cpu(zi->i_rdev));
+		break;
+	default:
+		zuf_err("unknown file type ino=%lld mode=%d\n", zi->i_ino,
+			  zi->i_mode);
+		break;
+	}
+
+	inode->i_ino = le64_to_cpu(zi->i_ino);
+}
+
+/* Mask out flags that are inappropriate for the given type of inode. */
+static uint _calc_flags(umode_t mode, uint dir_flags, uint flags)
+{
+	uint zufs_flags = dir_flags & ZUFS_FL_INHERITED;
+
+	if (S_ISREG(mode))
+		zufs_flags &= ZUFS_FL_REG_MASK;
+	else if (!S_ISDIR(mode))
+		zufs_flags &= ZUFS_FL_OTHER_MASK;
+
+	return zufs_flags;
+}
+
+static int _set_zi_from_inode(struct inode *dir, struct zus_inode *zi,
+			      struct inode *inode)
+{
+	struct zus_inode *zidir = zus_zi(dir);
+
+	if (unlikely(!zidir))
+		return -EACCES;
+
+	zi->i_mode = cpu_to_le16(inode->i_mode);
+	zi->i_uid = cpu_to_le32(__kuid_val(inode->i_uid));
+	zi->i_gid = cpu_to_le32(__kgid_val(inode->i_gid));
+	/* NOTE: zus is boss of i_nlink (but let it know what we think) */
+	zi->i_nlink = cpu_to_le16(inode->i_nlink);
+	zi->i_size = cpu_to_le64(inode->i_size);
+	zi->i_blocks = cpu_to_le64(inode->i_blocks);
+	timespec_to_mt(&zi->i_atime, &inode->i_atime);
+	timespec_to_mt(&zi->i_mtime, &inode->i_mtime);
+	timespec_to_mt(&zi->i_ctime, &inode->i_ctime);
+	zi->i_generation = cpu_to_le32(inode->i_generation);
+
+	if (S_ISCHR(inode->i_mode) || S_ISBLK(inode->i_mode))
+		zi->i_rdev = cpu_to_le32(inode->i_rdev);
+
+	zi->i_flags = cpu_to_le16(_calc_flags(inode->i_mode,
+					      le16_to_cpu(zidir->i_flags),
+					      inode->i_flags));
+	return 0;
+}
+
+static bool _times_equal(struct timespec64 *t, __le64 *mt)
+{
+	__le64 time;
+
+	timespec_to_mt(&time, t);
+	return time == *mt;
+}
+
+/* This function checks if VFS's inode and zus_inode are in sync */
+static void _warn_inode_dirty(struct inode *inode, struct zus_inode *zi)
+{
+#define __MISMACH_INT(inode, X, Y)	\
+	if (X != Y)			\
+		zuf_warn("[%ld] " #X"=0x%lx " #Y"=0x%lx""\n",	\
+			  inode->i_ino, (ulong)(X), (ulong)(Y))
+#define __MISMACH_TIME(inode, X, Y)	\
+	if (!_times_equal(X, Y)) {	\
+		struct timespec64 t;	\
+		mt_to_timespec(&t, (Y));\
+		zuf_warn("[%ld] " #X"=%lld:%ld " #Y"=%lld:%ld""\n",	\
+			  inode->i_ino, (X)->tv_sec, (X)->tv_nsec,	\
+			  t.tv_sec, t.tv_nsec);		\
+	}
+
+	if (!_times_equal(&inode->i_ctime, &zi->i_ctime) ||
+	    !_times_equal(&inode->i_mtime, &zi->i_mtime) ||
+	    !_times_equal(&inode->i_atime, &zi->i_atime) ||
+	    inode->i_size != le64_to_cpu(zi->i_size) ||
+	    inode->i_mode != le16_to_cpu(zi->i_mode) ||
+	    __kuid_val(inode->i_uid) != le32_to_cpu(zi->i_uid) ||
+	    __kgid_val(inode->i_gid) != le32_to_cpu(zi->i_gid) ||
+	    inode->i_nlink != le16_to_cpu(zi->i_nlink) ||
+	    inode->i_ino != _zi_ino(zi) ||
+	    inode->i_blocks != le64_to_cpu(zi->i_blocks)) {
+		__MISMACH_TIME(inode, &inode->i_ctime, &zi->i_ctime);
+		__MISMACH_TIME(inode, &inode->i_mtime, &zi->i_mtime);
+		__MISMACH_TIME(inode, &inode->i_atime, &zi->i_atime);
+		__MISMACH_INT(inode, inode->i_size, le64_to_cpu(zi->i_size));
+		__MISMACH_INT(inode, inode->i_mode, le16_to_cpu(zi->i_mode));
+		__MISMACH_INT(inode, __kuid_val(inode->i_uid),
+			      le32_to_cpu(zi->i_uid));
+		__MISMACH_INT(inode, __kgid_val(inode->i_gid),
+			      le32_to_cpu(zi->i_gid));
+		__MISMACH_INT(inode, inode->i_nlink, le16_to_cpu(zi->i_nlink));
+		__MISMACH_INT(inode, inode->i_ino, _zi_ino(zi));
+		__MISMACH_INT(inode, inode->i_blocks,
+			      le64_to_cpu(zi->i_blocks));
+	}
+}
+
+static void _zii_connect(struct inode *inode, struct zus_inode *zi,
+			 struct zus_inode_info *zus_ii)
+{
+	struct zuf_inode_info *zii = ZUII(inode);
+
+	zii->zi = zi;
+	zii->zus_ii = zus_ii;
+}
+
 struct inode *zuf_iget(struct super_block *sb, struct zus_inode_info *zus_ii,
 		       zu_dpp_t _zi, bool *exist)
 {
-	return ERR_PTR(-ENOTSUPP);
+	struct zus_inode *zi = zuf_dpp_t_addr(sb, _zi);
+	struct inode *inode;
+
+	*exist = false;
+	if (unlikely(!zi)) {
+		/* Don't trust ZUS pointers */
+		zuf_err("Bad zus_inode 0x%llx\n", _zi);
+		return ERR_PTR(-EIO);
+	}
+	if (unlikely(!zus_ii)) {
+		zuf_err("zus_ii NULL\n");
+		return ERR_PTR(-EIO);
+	}
+
+	if (!_zi_valid(zi)) {
+		zuf_err("inactive node ino=%lld links=%d mode=%d\n", zi->i_ino,
+			  zi->i_nlink, zi->i_mode);
+		return ERR_PTR(-ESTALE);
+	}
+
+	zuf_dbg_zus("[%lld] size=0x%llx, blocks=0x%llx ct=0x%llx mt=0x%llx link=0x%x mode=0x%x xattr=0x%llx\n",
+		    zi->i_ino, zi->i_size, zi->i_blocks, zi->i_ctime,
+		    zi->i_mtime, zi->i_nlink, zi->i_mode, zi->i_xattr);
+
+	inode = iget_locked(sb, _zi_ino(zi));
+	if (unlikely(!inode))
+		return ERR_PTR(-ENOMEM);
+
+	if (!(inode->i_state & I_NEW)) {
+		*exist = true;
+		return inode;
+	}
+
+	_set_inode_from_zi(inode, zi);
+	_zii_connect(inode, zi, zus_ii);
+
+	unlock_new_inode(inode);
+	return inode;
+}
+
+int zuf_evict_dispatch(struct super_block *sb, struct zus_inode_info *zus_ii,
+		       int operation, uint flags)
+{
+	struct zufs_ioc_evict_inode ioc_evict_inode = {
+		.hdr.in_len = sizeof(ioc_evict_inode),
+		.hdr.out_len = sizeof(ioc_evict_inode),
+		.hdr.operation = operation,
+		.zus_ii = zus_ii,
+		.flags = flags,
+	};
+	int err;
+
+	err = zufc_dispatch(ZUF_ROOT(SBI(sb)), &ioc_evict_inode.hdr, NULL, 0);
+	if (unlikely(err && err != -EINTR))
+		zuf_err("zufc_dispatch failed op=%s => %d\n",
+			 zuf_op_name(operation), err);
+	return err;
+}
+
+void zuf_evict_inode(struct inode *inode)
+{
+	struct super_block *sb = inode->i_sb;
+	struct zuf_inode_info *zii = ZUII(inode);
+
+	if (!inode->i_nlink) {
+		if (unlikely(!zii->zi)) {
+			zuf_dbg_err("[%ld] inode without zi mode=0x%x size=0x%llx\n",
+				    inode->i_ino, inode->i_mode, inode->i_size);
+			goto out;
+		}
+
+		if (unlikely(is_bad_inode(inode)))
+			zuf_dbg_err("[%ld] inode is bad mode=0x%x zi=%p\n",
+				    inode->i_ino, inode->i_mode, zii->zi);
+		else
+			_warn_inode_dirty(inode, zii->zi);
+
+		zuf_w_lock(zii);
+
+		zuf_evict_dispatch(sb, zii->zus_ii, ZUFS_OP_FREE_INODE, 0);
+
+		inode->i_mtime = inode->i_ctime = current_time(inode);
+		inode->i_size = 0;
+
+		zuf_w_unlock(zii);
+	} else {
+		zuf_dbg_vfs("[%ld] inode is going down?\n", inode->i_ino);
+
+		zuf_smw_lock(zii);
+
+		zuf_evict_dispatch(sb, zii->zus_ii, ZUFS_OP_EVICT_INODE, 0);
+
+		zuf_smw_unlock(zii);
+	}
+
+out:
+	zii->zus_ii = NULL;
+	zii->zi = NULL;
+
+	clear_inode(inode);
+}
+
+/* @rdev_or_isize is i_size in the case of a symlink
+ * and rdev in the case of special-files
+ */
+struct inode *zuf_new_inode(struct inode *dir, umode_t mode,
+			    const struct qstr *qstr, const char *symname,
+			    ulong rdev_or_isize, bool tmpfile)
+{
+	struct super_block *sb = dir->i_sb;
+	struct zuf_sb_info *sbi = SBI(sb);
+	struct zufs_ioc_new_inode ioc_new_inode = {
+		.hdr.in_len = sizeof(ioc_new_inode),
+		.hdr.out_len = sizeof(ioc_new_inode),
+		.hdr.operation = ZUFS_OP_NEW_INODE,
+		.dir_ii = ZUII(dir)->zus_ii,
+		.flags = tmpfile ? ZI_TMPFILE : 0,
+		.str.len = qstr->len,
+	};
+	struct inode *inode;
+	struct zus_inode *zi = NULL;
+	struct page *pages[2];
+	uint nump = 0;
+	int err;
+
+	memcpy(&ioc_new_inode.str.name, qstr->name, qstr->len);
+
+	inode = new_inode(sb);
+	if (!inode)
+		return ERR_PTR(-ENOMEM);
+
+	inode_init_owner(inode, dir, mode);
+	inode->i_blocks = inode->i_size = 0;
+	inode->i_ctime = inode->i_mtime = current_time(dir);
+	inode->i_atime = inode->i_ctime;
+
+	zuf_dbg_verbose("inode=%p name=%s\n", inode, qstr->name);
+
+	zuf_set_inode_flags(inode, &ioc_new_inode.zi);
+
+	if (S_ISCHR(inode->i_mode) || S_ISBLK(inode->i_mode) ||
+	    S_ISFIFO(inode->i_mode) || S_ISSOCK(inode->i_mode)) {
+		init_special_inode(inode, mode, rdev_or_isize);
+	}
+
+	err = _set_zi_from_inode(dir, &ioc_new_inode.zi, inode);
+	if (unlikely(err))
+		goto fail;
+
+	zus_inode_cmtime_now(dir, zus_zi(dir));
+
+	err = zufc_dispatch(ZUF_ROOT(sbi), &ioc_new_inode.hdr, pages, nump);
+	if (unlikely(err)) {
+		zuf_dbg_err("zufc_dispatch failed => %d\n", err);
+		goto fail;
+	}
+	zi = zuf_dpp_t_addr(sb, ioc_new_inode._zi);
+
+	_zii_connect(inode, zi, ioc_new_inode.zus_ii);
+
+	/* update inode fields from filesystem inode */
+	inode->i_ino = le64_to_cpu(zi->i_ino);
+	inode->i_size = le64_to_cpu(zi->i_size);
+	inode->i_generation = le64_to_cpu(zi->i_generation);
+	inode->i_blocks = le64_to_cpu(zi->i_blocks);
+	set_nlink(inode, le16_to_cpu(zi->i_nlink));
+	zuf_zii_sync(dir, false);
+
+	zuf_dbg_zus("[%lld] size=0x%llx, blocks=0x%llx ct=0x%llx mt=0x%llx link=0x%x mode=0x%x xattr=0x%llx\n",
+		    zi->i_ino, zi->i_size, zi->i_blocks, zi->i_ctime,
+		    zi->i_mtime, zi->i_nlink, zi->i_mode, zi->i_xattr);
+
+	zuf_dbg_verbose("allocating inode %ld (zi=%p)\n", _zi_ino(zi), zi);
+
+	err = insert_inode_locked(inode);
+	if (unlikely(err)) {
+		zuf_dbg_err("[%ld:%s] generation=%lld insert_inode_locked => %d\n",
+			    inode->i_ino, qstr->name, zi->i_generation, err);
+		goto fail;
+	}
+
+	return inode;
+
+fail:
+	clear_nlink(inode);
+	if (zi)
+		zi->i_nlink = 0;
+	make_bad_inode(inode);
+	iput(inode);
+	return ERR_PTR(err);
+}
+
+int zuf_write_inode(struct inode *inode, struct writeback_control *wbc)
+{
+	/* write_inode should never be called because we always keep our inodes
+	 * clean. So let us know if write_inode ever gets called.
+	 */
+
+	/* d_tmpfile() does a mark_inode_dirty so only complain on regular files
+	 * TODO: How? Every thing off for now
+	 * WARN_ON(inode->i_nlink);
+	 */
+
+	return 0;
+}
+
+/*
+ * Mostly supporting file_accessed() for now. Which is the only one we use.
+ *
+ * But also file_update_time is used by fifo code.
+ */
+int zuf_update_time(struct inode *inode, struct timespec64 *time, int flags)
+{
+	struct zus_inode *zi = zus_zi(inode);
+
+	if (flags & S_ATIME) {
+		inode->i_atime = *time;
+		timespec_to_mt(&zi->i_atime, &inode->i_atime);
+		/* FIXME: Set a flag that zi needs flushing
+		 * for now every read needs zi-flushing.
+		 */
+	}
+
+	/* File_update_time() is not used by zuf.
+	 * FIXME: One exception is O_TMPFILE the vfs calls file_update_time
+	 * internally bypassing FS. So just do and silent.
+	 * The zus O_TMPFILE create protocol knows it needs flushing
+	 */
+	if ((flags & S_CTIME) || (flags & S_MTIME)) {
+		if (flags & S_CTIME) {
+			inode->i_ctime = *time;
+			timespec_to_mt(&zi->i_ctime, &inode->i_ctime);
+		}
+		if (flags & S_MTIME) {
+			inode->i_mtime = *time;
+			timespec_to_mt(&zi->i_mtime, &inode->i_mtime);
+		}
+		zuf_dbg_vfs("called for S_CTIME | S_MTIME 0x%x\n", flags);
+	}
+
+	if (flags & ~(S_CTIME | S_MTIME | S_ATIME))
+		zuf_err("called for 0x%x\n", flags);
+
+	return 0;
+}
+
+int zuf_getattr(const struct path *path, struct kstat *stat, u32 request_mask,
+		unsigned int flags)
+{
+	struct dentry *dentry = path->dentry;
+	struct inode *inode = d_inode(dentry);
+
+	if (inode->i_flags & S_APPEND)
+		stat->attributes |= STATX_ATTR_APPEND;
+	if (inode->i_flags & S_IMMUTABLE)
+		stat->attributes |= STATX_ATTR_IMMUTABLE;
+
+	stat->attributes_mask |= (STATX_ATTR_APPEND |
+				  STATX_ATTR_IMMUTABLE);
+	generic_fillattr(inode, stat);
+	/* stat->blocks should be the number of 512B blocks */
+	stat->blocks = inode->i_blocks << (inode->i_sb->s_blocksize_bits - 9);
+
+	return 0;
+}
+
+int zuf_setattr(struct dentry *dentry, struct iattr *attr)
+{
+	struct inode *inode = dentry->d_inode;
+	struct zuf_inode_info *zii = ZUII(inode);
+	struct zus_inode *zi = zii->zi;
+	struct zufs_ioc_attr ioc_attr = {
+		.hdr.in_len = sizeof(ioc_attr),
+		.hdr.out_len = sizeof(ioc_attr),
+		.hdr.operation = ZUFS_OP_SETATTR,
+		.zus_ii = zii->zus_ii,
+	};
+	int err;
+
+	if (!zi)
+		return -EACCES;
+
+	/* Truncate is implemented via  fallocate(punch_hole) which means we
+	 * are not atomic with the other ATTRs. I think someone said that
+	 * some Kernel FSs don't even support truncate to come together with
+	 * other ATTRs
+	 */
+	if ((attr->ia_valid & ATTR_SIZE)) {
+		ZUF_CHECK_I_W_LOCK(inode);
+		zuf_smw_lock(zii);
+		err = __zuf_fallocate(inode, ZUFS_FL_TRUNCATE, attr->ia_size,
+				      ~0ULL);
+		zuf_smw_unlock(zii);
+		if (unlikely(err))
+			return err;
+		attr->ia_valid &= ~ATTR_SIZE;
+	}
+
+	err = setattr_prepare(dentry, attr);
+	if (unlikely(err))
+		return err;
+
+	if (attr->ia_valid & ATTR_MODE) {
+		zuf_dbg_vfs("[%ld] ATTR_MODE=0x%x\n",
+			     inode->i_ino, attr->ia_mode);
+		ioc_attr.zuf_attr |= STATX_MODE;
+		inode->i_mode = attr->ia_mode;
+		zi->i_mode = cpu_to_le16(inode->i_mode);
+		if (test_opt(SBI(inode->i_sb), POSIXACL)) {
+			err = posix_acl_chmod(inode, inode->i_mode);
+			if (unlikely(err))
+				return err;
+		}
+	}
+
+	if (attr->ia_valid & ATTR_UID) {
+		zuf_dbg_vfs("[%ld] ATTR_UID=0x%x\n",
+			     inode->i_ino, __kuid_val(attr->ia_uid));
+		ioc_attr.zuf_attr |= STATX_UID;
+		inode->i_uid = attr->ia_uid;
+		zi->i_uid = cpu_to_le32(__kuid_val(inode->i_uid));
+	}
+	if (attr->ia_valid & ATTR_GID) {
+		zuf_dbg_vfs("[%ld] ATTR_GID=0x%x\n",
+			     inode->i_ino, __kgid_val(attr->ia_gid));
+		ioc_attr.zuf_attr |= STATX_GID;
+		inode->i_gid = attr->ia_gid;
+		zi->i_gid = cpu_to_le32(__kgid_val(inode->i_gid));
+	}
+
+	if (attr->ia_valid & ATTR_ATIME) {
+		ioc_attr.zuf_attr |= STATX_ATIME;
+		inode->i_atime = attr->ia_atime;
+		timespec_to_mt(&zi->i_atime, &inode->i_atime);
+		zuf_dbg_vfs("[%ld] ATTR_ATIME=0x%llx\n",
+			     inode->i_ino, zi->i_atime);
+	}
+	if (attr->ia_valid & ATTR_CTIME) {
+		ioc_attr.zuf_attr |= STATX_CTIME;
+		inode->i_ctime = attr->ia_ctime;
+		timespec_to_mt(&zi->i_ctime, &inode->i_ctime);
+		zuf_dbg_vfs("[%ld] ATTR_CTIME=0x%llx\n",
+			     inode->i_ino, zi->i_ctime);
+	}
+	if (attr->ia_valid & ATTR_MTIME) {
+		ioc_attr.zuf_attr |= STATX_MTIME;
+		inode->i_mtime = attr->ia_mtime;
+		timespec_to_mt(&zi->i_mtime, &inode->i_mtime);
+		zuf_dbg_vfs("[%ld] ATTR_MTIME=0x%llx\n",
+			     inode->i_ino, zi->i_mtime);
+	}
+
+	err = zufc_dispatch(ZUF_ROOT(SBI(inode->i_sb)), &ioc_attr.hdr, NULL, 0);
+	if (unlikely(err))
+		zuf_dbg_err("[%ld] set_attr=0x%x failed => %d\n",
+			    inode->i_ino, ioc_attr.zuf_attr, err);
+
+	return err;
+}
+
+void zuf_set_inode_flags(struct inode *inode, struct zus_inode *zi)
+{
+	unsigned int flags = le16_to_cpu(zi->i_flags) & ~ZUFS_S_IMMUTABLE;
+
+	inode->i_flags &=
+		~(S_SYNC | S_APPEND | S_IMMUTABLE | S_NOATIME | S_DIRSYNC);
+	inode->i_flags |= flags;
+	if (zi->i_flags & ZUFS_S_IMMUTABLE)
+		inode->i_flags |= S_IMMUTABLE | S_NOATIME;
+	if (!zi->i_xattr)
+		inode_has_no_xattr(inode);
 }
 
+const struct address_space_operations zuf_aops = {
+};
diff --git a/fs/zuf/namei.c b/fs/zuf/namei.c
new file mode 100644
index 000000000000..299134ca7c07
--- /dev/null
+++ b/fs/zuf/namei.c
@@ -0,0 +1,402 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * BRIEF DESCRIPTION
+ *
+ * Inode operations for directories.
+ *
+ * Copyright (c) 2018 NetApp Inc. All rights reserved.
+ *
+ * ZUFS-License: GPL-2.0. See module.c for LICENSE details.
+ *
+ * Authors:
+ *	Boaz Harrosh <boazh@netapp.com>
+ *	Sagi Manole <sagim@netapp.com>"
+ */
+#include <linux/fs.h>
+#include "zuf.h"
+
+
+static struct inode *d_parent(struct dentry *dentry)
+{
+	return dentry->d_parent->d_inode;
+}
+
+static void _set_nlink(struct inode *inode, struct zus_inode *zi)
+{
+	set_nlink(inode, le32_to_cpu(zi->i_nlink));
+}
+
+void zuf_zii_sync(struct inode *inode, bool sync_nlink)
+{
+	struct zus_inode *zi = zus_zi(inode);
+
+	if (inode->i_size != le64_to_cpu(zi->i_size) ||
+	    inode->i_blocks != le64_to_cpu(zi->i_blocks)) {
+		i_size_write(inode, le64_to_cpu(zi->i_size));
+		inode->i_blocks = le64_to_cpu(zi->i_blocks);
+	}
+
+	if (sync_nlink)
+		_set_nlink(inode, zi);
+}
+
+static void _instantiate_unlock(struct dentry *dentry, struct inode *inode)
+{
+	d_instantiate(dentry, inode);
+	unlock_new_inode(inode);
+}
+
+static struct dentry *zuf_lookup(struct inode *dir, struct dentry *dentry,
+				 uint flags)
+{
+	struct super_block *sb = dir->i_sb;
+	struct qstr *str = &dentry->d_name;
+	uint in_len = offsetof(struct zufs_ioc_lookup, _zi);
+	struct zufs_ioc_lookup ioc_lu = {
+		.hdr.in_len = in_len,
+		.hdr.out_start = in_len,
+		.hdr.out_len = sizeof(ioc_lu) - in_len,
+		.hdr.operation = ZUFS_OP_LOOKUP,
+		.dir_ii = ZUII(dir)->zus_ii,
+		.str.len = str->len,
+	};
+	struct inode *inode = NULL;
+	bool exist;
+	int err;
+
+	zuf_dbg_vfs("[%ld] dentry-name=%s\n", dir->i_ino, dentry->d_name.name);
+
+	if (dentry->d_name.len > ZUFS_NAME_LEN)
+		return ERR_PTR(-ENAMETOOLONG);
+
+	memcpy(&ioc_lu.str.name, str->name, str->len);
+
+	err = zufc_dispatch(ZUF_ROOT(SBI(sb)), &ioc_lu.hdr, NULL, 0);
+	if (unlikely(err)) {
+		zuf_dbg_err("zufc_dispatch failed => %d\n", err);
+		goto out;
+	}
+
+	inode = zuf_iget(dir->i_sb, ioc_lu.zus_ii, ioc_lu._zi, &exist);
+	if (exist) {
+		zuf_dbg_err("race in lookup\n");
+		zuf_evict_dispatch(sb, ioc_lu.zus_ii, ZUFS_OP_EVICT_INODE,
+				   ZI_LOOKUP_RACE);
+	}
+
+out:
+	return d_splice_alias(inode, dentry);
+}
+
+/*
+ * By the time this is called, we already have created
+ * the directory cache entry for the new file, but it
+ * is so far negative - it has no inode.
+ *
+ * If the create succeeds, we fill in the inode information
+ * with d_instantiate().
+ */
+static int zuf_create(struct inode *dir, struct dentry *dentry, umode_t mode,
+		      bool excl)
+{
+	struct inode *inode;
+
+	zuf_dbg_vfs("[%ld] dentry-name=%s mode=0x%x\n",
+		     dir->i_ino, dentry->d_name.name, mode);
+
+	inode = zuf_new_inode(dir, mode, &dentry->d_name, NULL, 0, false);
+	if (IS_ERR(inode))
+		return PTR_ERR(inode);
+
+	inode->i_op = &zuf_file_inode_operations;
+	inode->i_mapping->a_ops = &zuf_aops;
+	inode->i_fop = &zuf_file_operations;
+
+	_instantiate_unlock(dentry, inode);
+
+	return 0;
+}
+
+static int zuf_mknod(struct inode *dir, struct dentry *dentry, umode_t mode,
+		     dev_t rdev)
+{
+	struct inode *inode;
+
+	zuf_dbg_vfs("[%ld] mode=0x%x rdev=0x%x\n", dir->i_ino, mode, rdev);
+
+	inode = zuf_new_inode(dir, mode, &dentry->d_name, NULL, rdev, false);
+	if (IS_ERR(inode))
+		return PTR_ERR(inode);
+
+	inode->i_op = &zuf_special_inode_operations;
+
+	_instantiate_unlock(dentry, inode);
+
+	return 0;
+}
+
+static int zuf_tmpfile(struct inode *dir, struct dentry *dentry, umode_t mode)
+{
+	struct inode *inode;
+
+	inode = zuf_new_inode(dir, mode, &dentry->d_name, NULL, 0, true);
+	if (IS_ERR(inode))
+		return PTR_ERR(inode);
+
+	/* TODO: See about more ephemeral operations on this file, around
+	 * mmap and such.
+	 * Must see about that tmpfile mode that is later link_at
+	 * (probably the !O_EXCL flag)
+	 */
+	inode->i_op = &zuf_file_inode_operations;
+	inode->i_mapping->a_ops = &zuf_aops;
+	inode->i_fop = &zuf_file_operations;
+
+	set_nlink(inode, 1); /* user_mode knows nothing */
+	d_tmpfile(dentry, inode);
+	/* tmpfile operate on nlink=0. Since this is a tmp file we do not care
+	 * about cl_flushing. If later this file will be linked to a dir. the
+	 * add_dentry will flush the zi.
+	 */
+	zus_zi(inode)->i_nlink = inode->i_nlink;
+
+	unlock_new_inode(inode);
+	return 0;
+}
+
+static int zuf_link(struct dentry *dest_dentry, struct inode *dir,
+		    struct dentry *dentry)
+{
+	struct inode *inode = dest_dentry->d_inode;
+	int err;
+
+	zuf_dbg_vfs("[%ld] dentry-ino=%ld dentry-name=%s dentry-parent=%ld dest_d-ino=%ld dest_d-name=%s\n",
+		     dir->i_ino, inode->i_ino, dentry->d_name.name,
+		     d_parent(dentry)->i_ino,
+		     dest_dentry->d_inode->i_ino, dest_dentry->d_name.name);
+
+	if (inode->i_nlink >= ZUFS_LINK_MAX)
+		return -EMLINK;
+
+	ihold(inode);
+
+	zus_inode_cmtime_now(dir, zus_zi(dir));
+	zus_inode_ctime_now(inode, zus_zi(inode));
+
+	err = zuf_add_dentry(dir, &dentry->d_name, inode);
+	if (unlikely(err)) {
+		iput(inode);
+		return err;
+	}
+
+	_set_nlink(inode, zus_zi(inode));
+
+	d_instantiate(dentry, inode);
+
+	return 0;
+}
+
+static int zuf_unlink(struct inode *dir, struct dentry *dentry)
+{
+	struct inode *inode = dentry->d_inode;
+	int err;
+
+	zuf_dbg_vfs("[%ld] dentry-ino=%ld dentry-name=%s dentry-parent=%ld\n",
+		     dir->i_ino, inode->i_ino, dentry->d_name.name,
+		     d_parent(dentry)->i_ino);
+
+	inode->i_ctime = dir->i_ctime;
+	timespec_to_mt(&zus_zi(inode)->i_ctime, &inode->i_ctime);
+
+	err = zuf_remove_dentry(dir, &dentry->d_name, inode);
+	if (unlikely(err))
+		return err;
+
+	zuf_zii_sync(inode, true);
+	zuf_zii_sync(dir, true);
+
+	return 0;
+}
+
+static int zuf_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
+{
+	struct inode *inode;
+
+	zuf_dbg_vfs("[%ld] dentry-name=%s dentry-parent=%ld mode=0x%x\n",
+		     dir->i_ino, dentry->d_name.name, d_parent(dentry)->i_ino,
+		     mode);
+
+	if (dir->i_nlink >= ZUFS_LINK_MAX)
+		return -EMLINK;
+
+	inode = zuf_new_inode(dir, S_IFDIR | mode, &dentry->d_name, NULL, 0,
+			      false);
+	if (IS_ERR(inode))
+		return PTR_ERR(inode);
+
+	inode->i_op = &zuf_dir_inode_operations;
+	inode->i_fop = &zuf_dir_operations;
+	inode->i_mapping->a_ops = &zuf_aops;
+
+	zuf_zii_sync(dir, true);
+
+	_instantiate_unlock(dentry, inode);
+
+	return 0;
+}
+
+static bool _empty_dir(struct inode *dir)
+{
+	if (dir->i_nlink != 2) {
+		zuf_dbg_verbose("[%ld] directory has nlink(%d) != 2\n",
+				dir->i_ino, dir->i_nlink);
+		return false;
+	}
+	/* NOTE: Above is not the only -ENOTEMPTY the zus-fs will need to check
+	 * for the "only-files" no subdirs case. And return -ENOTEMPTY below
+	 */
+	return true;
+}
+
+static int zuf_rmdir(struct inode *dir, struct dentry *dentry)
+{
+	struct inode *inode = dentry->d_inode;
+	int err;
+
+	zuf_dbg_vfs("[%ld] dentry-ino=%ld dentry-name=%s dentry-parent=%ld\n",
+		     dir->i_ino, inode->i_ino, dentry->d_name.name,
+		     d_parent(dentry)->i_ino);
+
+	if (!inode)
+		return -ENOENT;
+
+	if (!_empty_dir(inode))
+		return -ENOTEMPTY;
+
+	zus_inode_cmtime_now(dir, zus_zi(dir));
+	inode->i_ctime = dir->i_ctime;
+	timespec_to_mt(&zus_zi(inode)->i_ctime, &inode->i_ctime);
+
+	err = zuf_remove_dentry(dir, &dentry->d_name, inode);
+	if (unlikely(err))
+		return err;
+
+	zuf_zii_sync(inode, true);
+	zuf_zii_sync(dir, true);
+
+	return 0;
+}
+
+/* Structure of a directory element; */
+struct zuf_dir_element {
+	__le64  ino;
+	char name[254];
+};
+
+static int zuf_rename(struct inode *old_dir, struct dentry *old_dentry,
+		      struct inode *new_dir, struct dentry *new_dentry,
+		      uint flags)
+{
+	struct inode *old_inode = d_inode(old_dentry);
+	struct inode *new_inode = d_inode(new_dentry);
+	struct zuf_sb_info *sbi = SBI(old_inode->i_sb);
+	struct zufs_ioc_rename ioc_rename = {
+		.hdr.in_len = sizeof(ioc_rename),
+		.hdr.out_len = sizeof(ioc_rename),
+		.hdr.operation = ZUFS_OP_RENAME,
+		.old_dir_ii = ZUII(old_dir)->zus_ii,
+		.new_dir_ii = ZUII(new_dir)->zus_ii,
+		.old_zus_ii = ZUII(old_inode)->zus_ii,
+		.new_zus_ii = new_inode ? ZUII(new_inode)->zus_ii : NULL,
+		.old_d_str.len = old_dentry->d_name.len,
+		.new_d_str.len = new_dentry->d_name.len,
+		.flags = flags,
+	};
+	struct timespec64 time = current_time(old_dir);
+	int err;
+
+	zuf_dbg_vfs(
+		"old_inode=%ld new_inode=%ld old_name=%s new_name=%s f=0x%x\n",
+		old_inode->i_ino, new_inode ? new_inode->i_ino : 0,
+		old_dentry->d_name.name, new_dentry->d_name.name, flags);
+
+	if (flags & ~(RENAME_NOREPLACE | RENAME_EXCHANGE /*| RENAME_WHITEOUT*/))
+		return -EINVAL;
+
+	if (flags & RENAME_EXCHANGE) {
+		/* A subdir holds a ref on parent, see if we need to
+		 * exchange refs
+		 */
+		if (unlikely(!new_inode))
+			return -EINVAL;
+
+		if ((S_ISDIR(old_inode->i_mode) != S_ISDIR(new_inode->i_mode))
+		    && (old_dir != new_dir)) {
+			if (S_ISDIR(old_inode->i_mode)) {
+				if (ZUFS_LINK_MAX <= new_dir->i_nlink)
+					return -EMLINK;
+			} else {
+				if (ZUFS_LINK_MAX <= old_dir->i_nlink)
+					return -EMLINK;
+			}
+		}
+	} else if (S_ISDIR(old_inode->i_mode)) {
+		if (new_inode) {
+			if (!_empty_dir(new_inode))
+				return -ENOTEMPTY;
+		} else if (ZUFS_LINK_MAX <= new_dir->i_nlink) {
+			return -EMLINK;
+		}
+	}
+
+	memcpy(&ioc_rename.old_d_str.name, old_dentry->d_name.name,
+		old_dentry->d_name.len);
+	memcpy(&ioc_rename.new_d_str.name, new_dentry->d_name.name,
+		new_dentry->d_name.len);
+	timespec_to_mt(&ioc_rename.time, &time);
+
+	zus_inode_cmtime_now(old_dir, zus_zi(old_dir));
+	if (old_dir != new_dir)
+		zus_inode_cmtime_now(new_dir, zus_zi(new_dir));
+
+	if (new_inode)
+		zus_inode_ctime_now(new_inode, zus_zi(new_inode));
+	else
+		zus_inode_ctime_now(old_inode, zus_zi(old_inode));
+
+	err = zufc_dispatch(ZUF_ROOT(sbi), &ioc_rename.hdr, NULL, 0);
+
+	zuf_zii_sync(old_dir, true);
+	zuf_zii_sync(new_dir, true);
+
+	if (unlikely(err)) {
+		zuf_dbg_err("zufc_dispatch failed => %d\n", err);
+		return err;
+	}
+
+	if (new_inode)
+		_set_nlink(new_inode, zus_zi(new_inode));
+
+	return 0;
+}
+
+const struct inode_operations zuf_dir_inode_operations = {
+	.create		= zuf_create,
+	.lookup		= zuf_lookup,
+	.link		= zuf_link,
+	.unlink		= zuf_unlink,
+	.mkdir		= zuf_mkdir,
+	.rmdir		= zuf_rmdir,
+	.mknod		= zuf_mknod,
+	.tmpfile	= zuf_tmpfile,
+	.rename		= zuf_rename,
+	.setattr	= zuf_setattr,
+	.getattr	= zuf_getattr,
+	.update_time	= zuf_update_time,
+};
+
+const struct inode_operations zuf_special_inode_operations = {
+	.setattr	= zuf_setattr,
+	.getattr	= zuf_getattr,
+	.update_time	= zuf_update_time,
+};
diff --git a/fs/zuf/super.c b/fs/zuf/super.c
index 859d4e3884ec..49f2c62e22b7 100644
--- a/fs/zuf/super.c
+++ b/fs/zuf/super.c
@@ -781,6 +781,8 @@ void zuf_destroy_inodecache(void)
 static struct super_operations zuf_sops = {
 	.alloc_inode	= zuf_alloc_inode,
 	.destroy_inode	= zuf_destroy_inode,
+	.write_inode	= zuf_write_inode,
+	.evict_inode	= zuf_evict_inode,
 	.put_super	= zuf_put_super,
 	.freeze_fs	= zuf_update_s_wtime,
 	.unfreeze_fs	= zuf_update_s_wtime,
diff --git a/fs/zuf/zuf-core.c b/fs/zuf/zuf-core.c
index 301cf5058231..d2a2cd28b5e3 100644
--- a/fs/zuf/zuf-core.c
+++ b/fs/zuf/zuf-core.c
@@ -65,6 +65,16 @@ const char *zuf_op_name(enum e_zufs_operation op)
 		CASE_ENUM_NAME(ZUFS_OP_BREAK);
 		CASE_ENUM_NAME(ZUFS_OP_STATFS);
 		CASE_ENUM_NAME(ZUFS_OP_SHOW_OPTIONS);
+
+		CASE_ENUM_NAME(ZUFS_OP_NEW_INODE);
+		CASE_ENUM_NAME(ZUFS_OP_FREE_INODE);
+		CASE_ENUM_NAME(ZUFS_OP_EVICT_INODE);
+
+		CASE_ENUM_NAME(ZUFS_OP_LOOKUP);
+		CASE_ENUM_NAME(ZUFS_OP_ADD_DENTRY);
+		CASE_ENUM_NAME(ZUFS_OP_REMOVE_DENTRY);
+		CASE_ENUM_NAME(ZUFS_OP_RENAME);
+		CASE_ENUM_NAME(ZUFS_OP_SETATTR);
 	case ZUFS_OP_MAX_OPT:
 	default:
 		return "UNKNOWN";
diff --git a/fs/zuf/zuf.h b/fs/zuf/zuf.h
index 0192645ad49d..cc9a26b17e8e 100644
--- a/fs/zuf/zuf.h
+++ b/fs/zuf/zuf.h
@@ -129,6 +129,9 @@ enum {
 struct zuf_inode_info {
 	struct inode		vfs_inode;
 
+	/* Stuff for mmap write */
+	struct rw_semaphore	in_sync;
+
 	/* cookies from Server */
 	struct zus_inode	*zi;
 	struct zus_inode_info	*zus_ii;
@@ -247,6 +250,66 @@ static inline void *zuf_dpp_t_addr(struct super_block *sb, zu_dpp_t v)
 	return md_addr_verify(SBI(sb)->md, zu_dpp_t_val(v));
 }
 
+/* ~~~~ inode locking ~~~~ */
+static inline void zuf_r_lock(struct zuf_inode_info *zii)
+{
+	inode_lock_shared(&zii->vfs_inode);
+}
+static inline void zuf_r_unlock(struct zuf_inode_info *zii)
+{
+	inode_unlock_shared(&zii->vfs_inode);
+}
+
+static inline void zuf_smr_lock(struct zuf_inode_info *zii)
+{
+	down_read_nested(&zii->in_sync, 1);
+}
+static inline void zuf_smr_lock_pagefault(struct zuf_inode_info *zii)
+{
+	down_read_nested(&zii->in_sync, 2);
+}
+static inline void zuf_smr_unlock(struct zuf_inode_info *zii)
+{
+	up_read(&zii->in_sync);
+}
+
+static inline void zuf_smw_lock(struct zuf_inode_info *zii)
+{
+	down_write(&zii->in_sync);
+}
+static inline void zuf_smw_lock_nested(struct zuf_inode_info *zii)
+{
+	down_write_nested(&zii->in_sync, 1);
+}
+static inline void zuf_smw_unlock(struct zuf_inode_info *zii)
+{
+	up_write(&zii->in_sync);
+}
+
+static inline void zuf_w_lock(struct zuf_inode_info *zii)
+{
+	inode_lock(&zii->vfs_inode);
+	zuf_smw_lock(zii);
+}
+static inline void zuf_w_lock_nested(struct zuf_inode_info *zii)
+{
+	inode_lock_nested(&zii->vfs_inode, 2);
+	zuf_smw_lock_nested(zii);
+}
+static inline void zuf_w_unlock(struct zuf_inode_info *zii)
+{
+	zuf_smw_unlock(zii);
+	inode_unlock(&zii->vfs_inode);
+}
+
+static inline void ZUF_CHECK_I_W_LOCK(struct inode *inode)
+{
+#ifdef CONFIG_ZUF_DEBUG
+	if (WARN_ON(down_write_trylock(&inode->i_rwsem)))
+		up_write(&inode->i_rwsem);
+#endif
+}
+
 enum big_alloc_type { ba_stack, ba_kmalloc, ba_vmalloc };
 
 static inline
diff --git a/fs/zuf/zus_api.h b/fs/zuf/zus_api.h
index c7681c53700c..fe92471f7765 100644
--- a/fs/zuf/zus_api.h
+++ b/fs/zuf/zus_api.h
@@ -450,6 +450,17 @@ enum e_zufs_operation {
 	ZUFS_OP_STATFS		= 2,
 	ZUFS_OP_SHOW_OPTIONS	= 3,
 
+	ZUFS_OP_NEW_INODE	= 4,
+	ZUFS_OP_FREE_INODE	= 5,
+	ZUFS_OP_EVICT_INODE	= 6,
+
+	ZUFS_OP_LOOKUP		= 7,
+	ZUFS_OP_ADD_DENTRY	= 8,
+	ZUFS_OP_REMOVE_DENTRY	= 9,
+	ZUFS_OP_RENAME		= 10,
+
+	ZUFS_OP_SETATTR		= 19,
+
 	ZUFS_OP_MAX_OPT,
 };
 
@@ -474,4 +485,87 @@ struct zufs_ioc_statfs {
 	struct statfs64 statfs_out;
 };
 
+/* zufs_ioc_new_inode flags: */
+enum zi_flags {
+	ZI_TMPFILE = 1,		/* for new_inode */
+	ZI_LOOKUP_RACE = 1,	/* for evict */
+};
+
+struct zufs_str {
+	__u8 len;
+	char name[ZUFS_NAME_LEN];
+};
+
+/* ZUFS_OP_NEW_INODE */
+struct zufs_ioc_new_inode {
+	struct zufs_ioc_hdr hdr;
+	 /* IN */
+	struct zus_inode zi;
+	struct zus_inode_info *dir_ii; /* If mktmp this is the root */
+	struct zufs_str str;
+	__u64 flags;
+
+	 /* OUT */
+	zu_dpp_t _zi;
+	struct zus_inode_info *zus_ii;
+};
+
+/* ZUFS_OP_FREE_INODE, ZUFS_OP_EVICT_INODE */
+struct zufs_ioc_evict_inode {
+	struct zufs_ioc_hdr hdr;
+	/* IN */
+	struct zus_inode_info *zus_ii;
+	__u64 flags;
+};
+
+/* ZUFS_OP_LOOKUP */
+struct zufs_ioc_lookup {
+	struct zufs_ioc_hdr hdr;
+	/* IN */
+	struct zus_inode_info *dir_ii;
+	struct zufs_str str;
+
+	 /* OUT */
+	zu_dpp_t _zi;
+	struct zus_inode_info *zus_ii;
+};
+
+/* ZUFS_OP_ADD_DENTRY, ZUFS_OP_REMOVE_DENTRY */
+struct zufs_ioc_dentry {
+	struct zufs_ioc_hdr hdr;
+	struct zus_inode_info *zus_ii; /* IN */
+	struct zus_inode_info *zus_dir_ii; /* IN */
+	struct zufs_str str; /* IN */
+	__u64 ino; /* OUT - only for lookup */
+};
+
+/* ZUFS_OP_RENAME */
+struct zufs_ioc_rename {
+	struct zufs_ioc_hdr hdr;
+	/* IN */
+	struct zus_inode_info *old_dir_ii;
+	struct zus_inode_info *new_dir_ii;
+	struct zus_inode_info *old_zus_ii;
+	struct zus_inode_info *new_zus_ii;
+	struct zufs_str old_d_str;
+	struct zufs_str new_d_str;
+	__u64 time;
+	__u64 flags;
+};
+
+/* ZUFS_OP_SETATTR */
+struct zufs_ioc_attr {
+	struct zufs_ioc_hdr hdr;
+	/* IN */
+	struct zus_inode_info *zus_ii;
+	__u32 zuf_attr;
+	__u32 pad;
+};
+
+/* Special flag for ZUFS_OP_FALLOCATE to specify a setattr(SIZE)
+ * IE. same as punch hole but set_i_size to be @filepos. In this
+ * case @last_pos == ~0ULL
+ */
+#define ZUFS_FL_TRUNCATE 0x80000000
+
 #endif /* _LINUX_ZUFS_API_H */
-- 
2.20.1

