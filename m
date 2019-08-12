Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E54E08A39E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2019 18:43:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbfHLQnW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Aug 2019 12:43:22 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40803 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726982AbfHLQnW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Aug 2019 12:43:22 -0400
Received: by mail-wm1-f67.google.com with SMTP id v19so146359wmj.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Aug 2019 09:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=plexistor-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6qXEArXwucTucD4x/e+yJSNXw/ufPE2p660B4+xTnac=;
        b=CSVVCB48I5992APTROMYrxE8qNbQ9V+gKnXwhl4MaReA8jJb9rs+zm2pW5aMrj2V5O
         XHHV5jmOserzEZp9tBZ3s/ENjm7xGUBJhEj/UKYf3pSp+j1V4D3vF7EYJ4kIkDmuR1TH
         qSmS/EmokKTWdB51iMi3Zv7c8E3Ictqe50Ho6zDGZOAsHQ3LJu1rRLc+1FTb6ai+a41C
         60YxqUQIt4G5B00fAAjQA0Udz8uZ3aYrA5EkOjHpStAmao2ODWYc4lZ7ZewBc9dh3iKE
         D3E5UCFvmTHQGoCupLNeeCXd3i6R9BcgGcf6cV44Iac0i2KYmMsfGj+yTtNzXot+8d7i
         WFJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6qXEArXwucTucD4x/e+yJSNXw/ufPE2p660B4+xTnac=;
        b=RsXp8rhEDsF+CRN19r8jWVoZEnyjBHr/E2QZ0ubVfG39e8FilHvwu/NQSasIg7UGh7
         rD4nRneA5kXKzfj5AWC++kqWrnTaqMOJIhAxRZe6h+jScuCCO6TrmoYBUaSk961IuZww
         U89h4eomPRobfGxVKnAAG7d7mSu92b468UvjaDY9sxCM7W46PQug7ZzKeGdbw0u6CMCa
         joUw5iaZuKzUaaqg9Df+zIaLQIqFvav5+pxRPNoC5payg9rZw3KWa1dGJ3EplIP8RfQB
         vZ1HkDLLWiMeA9JzTBGFXFITWrRsN3J6/2LCNYfQC5JkqnbyuRAdKJLPkOcrKBXFb0F3
         tHTw==
X-Gm-Message-State: APjAAAVdGG01YK7t+bCrq5tfVM7kfb7gWuVJU6J6b/LSFYQuaG2JKxQj
        Rvp9qdC3UxvS+qKrmgWetfkYjA==
X-Google-Smtp-Source: APXvYqx9kx/hLCeEJPGWX+/TmTI75Motx+4I5S8I+Dz7EdHnkCD6HXFh/6bcQmdZc99wptQcRQmPIg==
X-Received: by 2002:a1c:20c3:: with SMTP id g186mr200684wmg.15.1565628199412;
        Mon, 12 Aug 2019 09:43:19 -0700 (PDT)
Received: from Bfire.plexistor.com ([217.70.211.18])
        by smtp.googlemail.com with ESMTPSA id x20sm95168wmc.1.2019.08.12.09.43.18
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 12 Aug 2019 09:43:18 -0700 (PDT)
From:   Boaz Harrosh <boaz@plexistor.com>
X-Google-Original-From: Boaz Harrosh <boazh@netapp.com>
To:     Boaz Harrosh <boaz@plexistor.com>,
        Boaz Harrosh <ooo@electrozaur.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Cc:     Boaz Harrosh <boazh@netapp.com>
Subject: [PATCH 14/16] zuf: ioctl implementation
Date:   Mon, 12 Aug 2019 19:42:42 +0300
Message-Id: <20190812164244.15580-15-boazh@netapp.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190812164244.15580-1-boazh@netapp.com>
References: <20190812164244.15580-1-boazh@netapp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

* support for some generic IOCTLs:
  FS_IOC_GETFLAGS, FS_IOC_SETFLAGS, FS_IOC_GETVERSION, FS_IOC_SETVERSION

* Simple support for zusFS defined IOCTLs
  We only support flat structures
  (no emmbedded pointers within the IOCTL structures)
  We try to deduce the size of the IOCTL from the _IOC_SIZE(cmd)
  If zusFS needs a bigger copy it will send a retry with the
  new size. So bad defined IOCTLs always do 2 trips to userland

* zusFS may also retry if it wants an fs_freeze to implement
  its IOCTL (TODO keep a map)

Signed-off-by: Boaz Harrosh <boazh@netapp.com>
---
 fs/zuf/Makefile    |   1 +
 fs/zuf/_extern.h   |   6 +
 fs/zuf/directory.c |   4 +
 fs/zuf/file.c      |   4 +
 fs/zuf/ioctl.c     | 313 +++++++++++++++++++++++++++++++++++++++++++++
 fs/zuf/zuf-core.c  |   1 +
 fs/zuf/zus_api.h   |  37 ++++++
 7 files changed, 366 insertions(+)
 create mode 100644 fs/zuf/ioctl.c

diff --git a/fs/zuf/Makefile b/fs/zuf/Makefile
index 02df1374a946..d3257bfc69ba 100644
--- a/fs/zuf/Makefile
+++ b/fs/zuf/Makefile
@@ -17,6 +17,7 @@ zuf-y += md.o t1.o t2.o
 zuf-y += zuf-core.o zuf-root.o
 
 # Main FS
+zuf-y += ioctl.o
 zuf-y += rw.o mmap.o
 zuf-y += super.o inode.o directory.o namei.o file.o symlink.o
 zuf-y += module.o
diff --git a/fs/zuf/_extern.h b/fs/zuf/_extern.h
index 34fde591cf92..ec9a8f1fdd16 100644
--- a/fs/zuf/_extern.h
+++ b/fs/zuf/_extern.h
@@ -127,6 +127,12 @@ int zuf_file_mmap(struct file *file, struct vm_area_struct *vma);
 /* t1.c */
 int zuf_pmem_mmap(struct file *file, struct vm_area_struct *vma);
 
+/* ioctl.c */
+long zuf_ioctl(struct file *filp, uint cmd, ulong arg);
+#ifdef CONFIG_COMPAT
+long zuf_compat_ioctl(struct file *file, uint cmd, ulong arg);
+#endif
+
 /*
  * Inode and files operations
  */
diff --git a/fs/zuf/directory.c b/fs/zuf/directory.c
index 645dd367fd8c..11fcbe0ba6ff 100644
--- a/fs/zuf/directory.c
+++ b/fs/zuf/directory.c
@@ -160,4 +160,8 @@ const struct file_operations zuf_dir_operations = {
 	.read		= generic_read_dir,
 	.iterate_shared	= zuf_readdir,
 	.fsync		= noop_fsync,
+	.unlocked_ioctl = zuf_ioctl,
+#ifdef CONFIG_COMPAT
+	.compat_ioctl	= zuf_compat_ioctl,
+#endif
 };
diff --git a/fs/zuf/file.c b/fs/zuf/file.c
index b7657e8c7e0a..bde5b95c911c 100644
--- a/fs/zuf/file.c
+++ b/fs/zuf/file.c
@@ -823,6 +823,10 @@ const struct file_operations zuf_file_operations = {
 	.copy_file_range	= zuf_copy_file_range,
 	.remap_file_range	= zuf_clone_file_range,
 	.fadvise		= zuf_fadvise,
+	.unlocked_ioctl		= zuf_ioctl,
+#ifdef CONFIG_COMPAT
+	.compat_ioctl		= zuf_compat_ioctl,
+#endif
 };
 
 const struct inode_operations zuf_file_inode_operations = {
diff --git a/fs/zuf/ioctl.c b/fs/zuf/ioctl.c
new file mode 100644
index 000000000000..9b777e42e654
--- /dev/null
+++ b/fs/zuf/ioctl.c
@@ -0,0 +1,313 @@
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
+ *	Sagi Manole <sagim@netapp.com>"
+ */
+
+#include <linux/capability.h>
+#include <linux/compat.h>
+
+#include "zuf.h"
+
+#define ZUFS_SUPPORTED_FS_FLAGS (FS_SYNC_FL | FS_APPEND_FL | FS_IMMUTABLE_FL | \
+				 FS_NOATIME_FL | FS_DIRTY_FL)
+
+#define ZUS_IOCTL_MAX_PAGES	8
+
+static int _ioctl_dispatch(struct inode *inode, uint cmd, ulong arg)
+{
+	struct _ioctl_info {
+		struct zufs_ioc_ioctl ctl;
+		char buf[900];
+	} ctl_alloc = {};
+	enum big_alloc_type bat;
+	struct zufs_ioc_ioctl *ioc_ioctl;
+	size_t ioc_size = _IOC_SIZE(cmd);
+	void __user *parg = (void __user *)arg;
+	struct timespec64 time = current_time(inode);
+	size_t size;
+	bool retry = false;
+	int err;
+	bool freeze = false;
+
+realloc:
+	size = sizeof(*ioc_ioctl) + ioc_size;
+
+	zuf_dbg_vfs("[%ld] cmd=0x%x arg=0x%lx size=0x%zx cap_admin=%u IOC(%d, %d, %zd)\n",
+		    inode->i_ino, cmd, arg, size, capable(CAP_SYS_ADMIN),
+		    _IOC_TYPE(cmd), _IOC_NR(cmd), ioc_size);
+
+	ioc_ioctl = big_alloc(size, sizeof(ctl_alloc), &ctl_alloc, GFP_KERNEL,
+			      &bat);
+	if (unlikely(!ioc_ioctl))
+		return -ENOMEM;
+
+	memset(ioc_ioctl, 0, sizeof(*ioc_ioctl));
+	ioc_ioctl->hdr.in_len = size;
+	ioc_ioctl->hdr.out_start = offsetof(struct zufs_ioc_ioctl, out_start);
+	ioc_ioctl->hdr.out_max = size;
+	ioc_ioctl->hdr.out_len = 0;
+	ioc_ioctl->hdr.operation = ZUFS_OP_IOCTL;
+	ioc_ioctl->zus_ii = ZUII(inode)->zus_ii;
+	ioc_ioctl->cmd = cmd;
+	ioc_ioctl->kflags = capable(CAP_SYS_ADMIN) ? ZUFS_IOC_CAP_ADMIN : 0;
+	timespec_to_mt(&ioc_ioctl->time, &time);
+
+dispatch:
+	if (arg && ioc_size) {
+		if (copy_from_user(ioc_ioctl->arg, parg, ioc_size)) {
+			err = -EFAULT;
+			goto out;
+		}
+	}
+
+	err = zufc_dispatch(ZUF_ROOT(SBI(inode->i_sb)), &ioc_ioctl->hdr,
+			    NULL, 0);
+
+	if (unlikely(err == -EZUFS_RETRY)) {
+		if (unlikely(retry)) {
+			zuf_err("Server => EZUFS_RETRY again uflags=%d\n",
+				ioc_ioctl->uflags);
+			err = -EBUSY;
+			goto out;
+		}
+		retry = true;
+		switch (ioc_ioctl->uflags) {
+		case ZUFS_IOC_REALLOC:
+			ioc_size = ioc_ioctl->new_size - sizeof(*ioc_ioctl);
+			big_free(ioc_ioctl, bat);
+			goto realloc;
+		case ZUFS_IOC_FREEZE_REQ:
+			err = freeze_super(inode->i_sb);
+			if (unlikely(err)) {
+				zuf_warn("unable to freeze fs err=%d\n", err);
+				goto out;
+			}
+			freeze = true;
+			ioc_ioctl->kflags |= ZUFS_IOC_FSFROZEN;
+			goto dispatch;
+		default:
+			zuf_err("unkonwn ZUFS retry type uflags=%d\n",
+				ioc_ioctl->uflags);
+			err = -EINVAL;
+			goto out;
+		}
+	}
+
+	if (unlikely(err)) {
+		zuf_dbg_err("zufc_dispatch failed => %d IOC(%d, %d, %zd)\n",
+			    err, _IOC_TYPE(cmd), _IOC_NR(cmd), ioc_size);
+		goto out;
+	}
+
+	if (ioc_ioctl->hdr.out_len) {
+		if (copy_to_user(parg, ioc_ioctl->arg,
+		    ioc_ioctl->hdr.out_len)) {
+			err = -EFAULT;
+			goto out;
+		}
+	}
+
+out:
+	if (freeze) {
+		int thaw_err = thaw_super(inode->i_sb);
+
+		if (unlikely(thaw_err))
+			zuf_err("post ioctl thaw file system failure err = %d\n",
+				 thaw_err);
+	}
+
+	big_free(ioc_ioctl, bat);
+
+	return err;
+}
+
+static uint _translate_to_ioc_flags(struct zus_inode *zi)
+{
+	uint zi_flags = le16_to_cpu(zi->i_flags);
+	uint ioc_flags = 0;
+
+	if (zi_flags & S_SYNC)
+		ioc_flags |= FS_SYNC_FL;
+	if (zi_flags & S_APPEND)
+		ioc_flags |= FS_APPEND_FL;
+	if (zi_flags & S_IMMUTABLE)
+		ioc_flags |= FS_IMMUTABLE_FL;
+	if (zi_flags & S_NOATIME)
+		ioc_flags |= FS_NOATIME_FL;
+	if (zi_flags & S_DIRSYNC)
+		ioc_flags |= FS_DIRSYNC_FL;
+
+	return ioc_flags;
+}
+
+static int _ioc_getflags(struct inode *inode, uint __user *parg)
+{
+	struct zus_inode *zi = zus_zi(inode);
+	uint flags = _translate_to_ioc_flags(zi);
+
+	return put_user(flags, parg);
+}
+
+static void _translate_to_zi_flags(struct zus_inode *zi, unsigned int flags)
+{
+	uint zi_flags = le16_to_cpu(zi->i_flags);
+
+	zi_flags &=
+		~(S_SYNC | S_APPEND | S_IMMUTABLE | S_NOATIME | S_DIRSYNC);
+
+	if (flags & FS_SYNC_FL)
+		zi_flags |= S_SYNC;
+	if (flags & FS_APPEND_FL)
+		zi_flags |= S_APPEND;
+	if (flags & FS_IMMUTABLE_FL)
+		zi_flags |= S_IMMUTABLE;
+	if (flags & FS_NOATIME_FL)
+		zi_flags |= S_NOATIME;
+	if (flags & FS_DIRSYNC_FL)
+		zi_flags |= S_DIRSYNC;
+
+	zi->i_flags = cpu_to_le16(zi_flags);
+}
+
+/* use statx ioc to flush zi changes to fs */
+static int __ioc_dispatch_zi_update(struct inode *inode, uint flags)
+{
+	struct zufs_ioc_attr ioc_attr = {
+		.hdr.in_len = sizeof(ioc_attr),
+		.hdr.out_len = sizeof(ioc_attr),
+		.hdr.operation = ZUFS_OP_SETATTR,
+		.zus_ii = ZUII(inode)->zus_ii,
+		.zuf_attr = flags,
+	};
+	int err;
+
+	err = zufc_dispatch(ZUF_ROOT(SBI(inode->i_sb)), &ioc_attr.hdr, NULL, 0);
+	if (unlikely(err && err != -EINTR))
+		zuf_err("zufc_dispatch failed => %d\n", err);
+
+	return err;
+}
+
+static int _ioc_setflags(struct inode *inode, uint __user *parg)
+{
+	struct zus_inode *zi = zus_zi(inode);
+	uint flags, oldflags;
+	int err;
+
+	if (!inode_owner_or_capable(inode))
+		return -EPERM;
+
+	if (get_user(flags, parg))
+		return -EFAULT;
+
+	if (flags & ~ZUFS_SUPPORTED_FS_FLAGS)
+		return -EOPNOTSUPP;
+
+	if (zi->i_flags & ZUFS_S_IMMUTABLE)
+		return -EPERM;
+
+	inode_lock(inode);
+
+	oldflags = le32_to_cpu(zi->i_flags);
+
+	if ((flags ^ oldflags) &
+		(FS_APPEND_FL | FS_IMMUTABLE_FL)) {
+		if (!capable(CAP_LINUX_IMMUTABLE)) {
+			inode_unlock(inode);
+			return -EPERM;
+		}
+	}
+
+	if (!S_ISDIR(inode->i_mode))
+		flags &= ~FS_DIRSYNC_FL;
+
+	flags = flags & FS_FL_USER_MODIFIABLE;
+	flags |= oldflags & ~FS_FL_USER_MODIFIABLE;
+	inode->i_ctime = current_time(inode);
+	timespec_to_mt(&zi->i_ctime, &inode->i_ctime);
+	_translate_to_zi_flags(zi, flags);
+	zuf_set_inode_flags(inode, zi);
+
+	err = __ioc_dispatch_zi_update(inode, ZUFS_STATX_FLAGS | STATX_CTIME);
+
+	inode_unlock(inode);
+	return err;
+}
+
+static int _ioc_setversion(struct inode *inode, uint __user *parg)
+{
+	struct zus_inode *zi = zus_zi(inode);
+	__u32 generation;
+	int err;
+
+	if (!inode_owner_or_capable(inode))
+		return -EPERM;
+
+	if (get_user(generation, parg))
+		return -EFAULT;
+
+	inode_lock(inode);
+
+	inode->i_ctime = current_time(inode);
+	inode->i_generation = generation;
+	timespec_to_mt(&zi->i_ctime, &inode->i_ctime);
+	zi->i_generation = cpu_to_le32(inode->i_generation);
+
+	err = __ioc_dispatch_zi_update(inode, ZUFS_STATX_VERSION | STATX_CTIME);
+
+	inode_unlock(inode);
+	return err;
+}
+
+long zuf_ioctl(struct file *filp, unsigned int cmd, ulong arg)
+{
+	struct inode *inode = filp->f_inode;
+	void __user *parg = (void __user *)arg;
+
+	switch (cmd) {
+	case FS_IOC_GETFLAGS:
+		return _ioc_getflags(inode, parg);
+	case FS_IOC_SETFLAGS:
+		return _ioc_setflags(inode, parg);
+	case FS_IOC_GETVERSION:
+		return put_user(inode->i_generation, (int __user *)arg);
+	case FS_IOC_SETVERSION:
+		return _ioc_setversion(inode, parg);
+	default:
+		return _ioctl_dispatch(inode, cmd, arg);
+	}
+}
+
+#ifdef CONFIG_COMPAT
+long zuf_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
+{
+	switch (cmd) {
+	case FS_IOC32_GETFLAGS:
+		cmd = FS_IOC_GETFLAGS;
+		break;
+	case FS_IOC32_SETFLAGS:
+		cmd = FS_IOC_SETFLAGS;
+		break;
+	case FS_IOC32_GETVERSION:
+		cmd = FS_IOC_GETVERSION;
+		break;
+	case FS_IOC32_SETVERSION:
+		cmd = FS_IOC_SETVERSION;
+		break;
+	default:
+		return -ENOIOCTLCMD;
+	}
+	return zuf_ioctl(file, cmd, (unsigned long)compat_ptr(arg));
+}
+#endif
+
diff --git a/fs/zuf/zuf-core.c b/fs/zuf/zuf-core.c
index 9f690142f479..b90c9efcb042 100644
--- a/fs/zuf/zuf-core.c
+++ b/fs/zuf/zuf-core.c
@@ -106,6 +106,7 @@ const char *zuf_op_name(enum e_zufs_operation op)
 		CASE_ENUM_NAME(ZUFS_OP_SYNC);
 		CASE_ENUM_NAME(ZUFS_OP_FALLOCATE);
 		CASE_ENUM_NAME(ZUFS_OP_LLSEEK);
+		CASE_ENUM_NAME(ZUFS_OP_IOCTL);
 		CASE_ENUM_NAME(ZUFS_OP_FIEMAP);
 
 		CASE_ENUM_NAME(ZUFS_OP_GET_MULTY);
diff --git a/fs/zuf/zus_api.h b/fs/zuf/zus_api.h
index 1a7b53157192..ce5ae0150b22 100644
--- a/fs/zuf/zus_api.h
+++ b/fs/zuf/zus_api.h
@@ -470,6 +470,7 @@ enum e_zufs_operation {
 	ZUFS_OP_SYNC		= 20,
 	ZUFS_OP_FALLOCATE	= 21,
 	ZUFS_OP_LLSEEK		= 22,
+	ZUFS_OP_IOCTL		= 23,
 	ZUFS_OP_FIEMAP		= 28,
 
 	ZUFS_OP_GET_MULTY	= 29,
@@ -712,6 +713,42 @@ struct zufs_ioc_seek {
 	__u64 offset_out;
 };
 
+/* ZUFS_OP_IOCTL */
+/* Flags for zufs_ioc_ioctl->kflags */
+enum e_ZUFS_IOCTL_KFLAGS {
+	ZUFS_IOC_FSFROZEN	= 0x1,	/* Tell Server we froze the FS	  */
+	ZUFS_IOC_CAP_ADMIN	= 0x2,	/* The ioctl caller had CAP_ADMIN */
+};
+
+/* received for zus on zufs_ioc_ioctl->uflags */
+enum e_ZUFS_IOCTL_UFLAGS {
+	ZUFS_IOC_REALLOC	= 0x1,	/*_IOC_SIZE(cmd) was not it and Server
+					 * needs a deeper copy
+					 */
+	ZUFS_IOC_FREEZE_REQ	= 0x2,	/* Server needs a freeze and a recall */
+};
+
+struct zufs_ioc_ioctl {
+	struct zufs_ioc_hdr hdr;
+	/* IN */
+	struct zus_inode_info *zus_ii;
+	__u64 time;
+	__u32 cmd;
+	__u32 kflags; /* zuf/kernel state and flags*/
+
+	/* OUT */
+	/* This is just a zero-size marker for the start of output */
+	char out_start[0];
+	union {
+		struct { /* If return was -EZUFS_RETRY */
+			__u32 uflags; /* flags returned from zus */
+			__u32 new_size;
+		};
+
+		char arg[0];
+	};
+};
+
 /* ZUFS_OP_FIEMAP */
 struct zufs_ioc_fiemap {
 	struct zufs_ioc_hdr hdr;
-- 
2.20.1

