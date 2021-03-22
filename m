Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D08113447F0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Mar 2021 15:50:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbhCVOtz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Mar 2021 10:49:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36211 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230010AbhCVOtY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Mar 2021 10:49:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616424563;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DXbEjcMCbvNU6S4qvMlPuf7lzew18iwJveqHO6cinQ8=;
        b=iuGbRwiVuMZqVFO8KvtAelilZ0Lp2QNaK18FlRPW97wkIVbAvhz3281OV2grCaSwEhKdtS
        fyRjr6GxFyrSnR24FFhatizfBI98f9yjjOktzWfvAyrCS/cz2DK5YfLIBnSMAbdisBcwlJ
        zINkN8YZdyDwQIM1m0RPRZ5Ob00PydM=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-337-MBUAili1OgejZDe4C3qmXA-1; Mon, 22 Mar 2021 10:49:21 -0400
X-MC-Unique: MBUAili1OgejZDe4C3qmXA-1
Received: by mail-ed1-f72.google.com with SMTP id n20so27700531edr.8
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Mar 2021 07:49:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DXbEjcMCbvNU6S4qvMlPuf7lzew18iwJveqHO6cinQ8=;
        b=cDpjPYkJOcPcNNwRc7K36F9s0LPjaZcBRFPlNi63WOUqDPv7aO2r7+CbILZXGs/az/
         ZQOIHz/zlHKx7OiJlwI7bT6lSJRNBb4xu34i81IzKYJBRzFFoO0uKbJifQlQGYgILMOH
         I/Y8hjESuHUxI8t6iu91Tmx7/OZP4rJccqrIV7M8jZYCKEZlrjMfUG/ElcxIhwN3hm1l
         RiYUkzhIfgibXluEZDaFCXkf9/P4/KqjZ83OA1/yFq9InejblNYwih+LnBcFlQVdYFmZ
         8FMZthlnqZP5Rax5XCtvEHd1n4qHGd1NNrBTZ0SmFv7mXTtzhYDrVHYb3HeQRqlSWMt4
         bltQ==
X-Gm-Message-State: AOAM533pj0Igck2JA9N4kTCTMpopLSTyYxK8YvQRz2+94wtf/H4f5cSr
        iALB0KDgRJ42GU4LicDsOMoBnYWaEaSM7eEKCS7atGdH11ixMLXZWa18Mv43rD+8qWlJILBkdV3
        rYbf48igr4d9ty0c7sSworACxVlRl96ZK2gOD722Urp8vPnFjMFA4bixuRHXSyfdckgC6Ble3ID
        C/LQ==
X-Received: by 2002:a17:906:5e50:: with SMTP id b16mr137488eju.272.1616424560048;
        Mon, 22 Mar 2021 07:49:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwjROlOrU01V2lgFg2EPOrwWkuY3keIINplQIYL/IKJvGLaz6DL9KnTEXfDw87ZCUnvFk7HqQ==
X-Received: by 2002:a17:906:5e50:: with SMTP id b16mr137457eju.272.1616424559679;
        Mon, 22 Mar 2021 07:49:19 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-86-101-169-67.catv.broadband.hu. [86.101.169.67])
        by smtp.gmail.com with ESMTPSA id r4sm9793117ejd.125.2021.03.22.07.49.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 07:49:19 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Al Viro <viro@ZenIV.linux.org.uk>, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 01/18] vfs: add miscattr ops
Date:   Mon, 22 Mar 2021 15:48:59 +0100
Message-Id: <20210322144916.137245-2-mszeredi@redhat.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210322144916.137245-1-mszeredi@redhat.com>
References: <20210322144916.137245-1-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There's a substantial amount of boilerplate in filesystems handling
FS_IOC_[GS]ETFLAGS/ FS_IOC_FS[GS]ETXATTR ioctls.

Also due to userspace buffers being involved in the ioctl API this is
difficult to stack, as shown by overlayfs issues related to these ioctls.

Introduce a new internal API named "miscattr" (fsxattr can be confused with
xattr, xflags is inappropriate, since this is more than just flags).

There's significant overlap between flags and xflags and this API handles
the conversions automatically, so filesystems may choose which one to use.

In ->miscattr_get() a hint is provided to the filesystem whether flags or
xattr are being requested by userspace, but in this series this hint is
ignored by all filesystems, since generating all the attributes is cheap.

If a filesystem doesn't implemement the miscattr API, just fall back to
f_op->ioctl().  When all filesystems are converted, the fallback can be
removed.

32bit compat ioctls are now handled by the generic code as well.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 Documentation/filesystems/locking.rst |   5 +
 Documentation/filesystems/vfs.rst     |  15 ++
 fs/ioctl.c                            | 329 ++++++++++++++++++++++++++
 include/linux/fs.h                    |   4 +
 include/linux/miscattr.h              |  53 +++++
 5 files changed, 406 insertions(+)
 create mode 100644 include/linux/miscattr.h

diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
index b7dcc86c92a4..a5aa2046d48f 100644
--- a/Documentation/filesystems/locking.rst
+++ b/Documentation/filesystems/locking.rst
@@ -80,6 +80,9 @@ prototypes::
 				struct file *, unsigned open_flag,
 				umode_t create_mode);
 	int (*tmpfile) (struct inode *, struct dentry *, umode_t);
+	int (*miscattr_set)(struct user_namespace *mnt_userns,
+			    struct dentry *dentry, struct miscattr *ma);
+	int (*miscattr_get)(struct dentry *dentry, struct miscattr *ma);
 
 locking rules:
 	all may block
@@ -107,6 +110,8 @@ fiemap:		no
 update_time:	no
 atomic_open:	shared (exclusive if O_CREAT is set in open flags)
 tmpfile:	no
+miscattr_get:	no or exclusive
+miscattr_set:	exclusive
 ============	=============================================
 
 
diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
index 2049bbf5e388..f125ce6c3b47 100644
--- a/Documentation/filesystems/vfs.rst
+++ b/Documentation/filesystems/vfs.rst
@@ -441,6 +441,9 @@ As of kernel 2.6.22, the following members are defined:
 				   unsigned open_flag, umode_t create_mode);
 		int (*tmpfile) (struct user_namespace *, struct inode *, struct dentry *, umode_t);
 	        int (*set_acl)(struct user_namespace *, struct inode *, struct posix_acl *, int);
+		int (*miscattr_set)(struct user_namespace *mnt_userns,
+				    struct dentry *dentry, struct miscattr *ma);
+		int (*miscattr_get)(struct dentry *dentry, struct miscattr *ma);
 	};
 
 Again, all methods are called without any locks being held, unless
@@ -588,6 +591,18 @@ otherwise noted.
 	atomically creating, opening and unlinking a file in given
 	directory.
 
+``miscattr_get``
+	called on ioctl(FS_IOC_GETFLAGS) and ioctl(FS_IOC_FSGETXATTR) to
+	retrieve miscellaneous filesystem flags and attributes.  Also
+	called before the relevant SET operation to check what is being
+	changed (in this case with i_rwsem locked exclusive).  If unset,
+	then fall back to f_op->ioctl().
+
+``miscattr_set``
+	called on ioctl(FS_IOC_SETFLAGS) and ioctl(FS_IOC_FSSETXATTR) to
+	change miscellaneous filesystem flags and attributes.  Callers hold
+	i_rwsem exclusive.  If unset, then fall back to f_op->ioctl().
+
 
 The Address Space Object
 ========================
diff --git a/fs/ioctl.c b/fs/ioctl.c
index 4e6cc0a7d69c..e5f3820809a4 100644
--- a/fs/ioctl.c
+++ b/fs/ioctl.c
@@ -19,6 +19,9 @@
 #include <linux/falloc.h>
 #include <linux/sched/signal.h>
 #include <linux/fiemap.h>
+#include <linux/mount.h>
+#include <linux/fscrypt.h>
+#include <linux/miscattr.h>
 
 #include "internal.h"
 
@@ -657,6 +660,311 @@ static int ioctl_file_dedupe_range(struct file *file,
 	return ret;
 }
 
+/**
+ * miscattr_fill_xflags - initialize miscattr with xflags
+ * @ma:		miscattr pointer
+ * @xflags:	FS_XFLAG_* flags
+ *
+ * Set ->fsx_xflags, ->xattr_valid and ->flags (translated xflags).  All
+ * other fields are zeroed.
+ */
+void miscattr_fill_xflags(struct miscattr *ma, u32 xflags)
+{
+	memset(ma, 0, sizeof(*ma));
+	ma->xattr_valid = true;
+	ma->fsx_xflags = xflags;
+	if (ma->fsx_xflags & FS_XFLAG_IMMUTABLE)
+		ma->flags |= FS_IMMUTABLE_FL;
+	if (ma->fsx_xflags & FS_XFLAG_APPEND)
+		ma->flags |= FS_APPEND_FL;
+	if (ma->fsx_xflags & FS_XFLAG_SYNC)
+		ma->flags |= FS_SYNC_FL;
+	if (ma->fsx_xflags & FS_XFLAG_NOATIME)
+		ma->flags |= FS_NOATIME_FL;
+	if (ma->fsx_xflags & FS_XFLAG_NODUMP)
+		ma->flags |= FS_NODUMP_FL;
+	if (ma->fsx_xflags & FS_XFLAG_DAX)
+		ma->flags |= FS_DAX_FL;
+	if (ma->fsx_xflags & FS_XFLAG_PROJINHERIT)
+		ma->flags |= FS_PROJINHERIT_FL;
+}
+EXPORT_SYMBOL(miscattr_fill_xflags);
+
+/**
+ * miscattr_fill_flags - initialize miscattr with flags
+ * @ma:		miscattr pointer
+ * @flags:	FS_*_FL flags
+ *
+ * Set ->flags, ->flags_valid and ->fsx_xflags (translated flags).
+ * All other fields are zeroed.
+ */
+void miscattr_fill_flags(struct miscattr *ma, u32 flags)
+{
+	memset(ma, 0, sizeof(*ma));
+	ma->flags_valid = true;
+	ma->flags = flags;
+	if (ma->flags & FS_SYNC_FL)
+		ma->fsx_xflags |= FS_XFLAG_SYNC;
+	if (ma->flags & FS_IMMUTABLE_FL)
+		ma->fsx_xflags |= FS_XFLAG_IMMUTABLE;
+	if (ma->flags & FS_APPEND_FL)
+		ma->fsx_xflags |= FS_XFLAG_APPEND;
+	if (ma->flags & FS_NODUMP_FL)
+		ma->fsx_xflags |= FS_XFLAG_NODUMP;
+	if (ma->flags & FS_NOATIME_FL)
+		ma->fsx_xflags |= FS_XFLAG_NOATIME;
+	if (ma->flags & FS_DAX_FL)
+		ma->fsx_xflags |= FS_XFLAG_DAX;
+	if (ma->flags & FS_PROJINHERIT_FL)
+		ma->fsx_xflags |= FS_XFLAG_PROJINHERIT;
+}
+EXPORT_SYMBOL(miscattr_fill_flags);
+
+/**
+ * vfs_miscattr_get - retrieve miscellaneous inode attributes
+ * @dentry:	the object to retrieve from
+ * @ma:		miscattr pointer
+ *
+ * Call i_op->miscattr_get() callback, if exists.
+ *
+ * Returns 0 on success, or a negative error on failure.
+ */
+int vfs_miscattr_get(struct dentry *dentry, struct miscattr *ma)
+{
+	struct inode *inode = d_inode(dentry);
+
+	if (d_is_special(dentry))
+		return -ENOTTY;
+
+	if (!inode->i_op->miscattr_get)
+		return -ENOIOCTLCMD;
+
+	return inode->i_op->miscattr_get(dentry, ma);
+}
+EXPORT_SYMBOL(vfs_miscattr_get);
+
+/**
+ * fsxattr_copy_to_user - copy fsxattr to userspace.
+ * @ma:		miscattr pointer
+ * @ufa:	fsxattr user pointer
+ *
+ * Returns 0 on success, or -EFAULT on failure.
+ */
+int fsxattr_copy_to_user(const struct miscattr *ma, struct fsxattr __user *ufa)
+{
+	struct fsxattr fa = {
+		.fsx_xflags	= ma->fsx_xflags,
+		.fsx_extsize	= ma->fsx_extsize,
+		.fsx_nextents	= ma->fsx_nextents,
+		.fsx_projid	= ma->fsx_projid,
+		.fsx_cowextsize	= ma->fsx_cowextsize,
+	};
+
+	if (copy_to_user(ufa, &fa, sizeof(fa)))
+		return -EFAULT;
+
+	return 0;
+}
+EXPORT_SYMBOL(fsxattr_copy_to_user);
+
+static int fsxattr_copy_from_user(struct miscattr *ma,
+				  struct fsxattr __user *ufa)
+{
+	struct fsxattr fa;
+
+	if (copy_from_user(&fa, ufa, sizeof(fa)))
+		return -EFAULT;
+
+	miscattr_fill_xflags(ma, fa.fsx_xflags);
+	ma->fsx_extsize = fa.fsx_extsize;
+	ma->fsx_nextents = fa.fsx_nextents;
+	ma->fsx_projid = fa.fsx_projid;
+	ma->fsx_cowextsize = fa.fsx_cowextsize;
+
+	return 0;
+}
+
+/*
+ * Generic function to check FS_IOC_FSSETXATTR/FS_IOC_SETFLAGS values and reject
+ * any invalid configurations.
+ *
+ * Note: must be called with inode lock held.
+ */
+static int miscattr_set_prepare(struct inode *inode,
+			      const struct miscattr *old_ma,
+			      struct miscattr *ma)
+{
+	int err;
+
+	/*
+	 * The IMMUTABLE and APPEND_ONLY flags can only be changed by
+	 * the relevant capability.
+	 */
+	if ((ma->flags ^ old_ma->flags) & (FS_APPEND_FL | FS_IMMUTABLE_FL) &&
+	    !capable(CAP_LINUX_IMMUTABLE))
+		return -EPERM;
+
+	err = fscrypt_prepare_setflags(inode, old_ma->flags, ma->flags);
+	if (err)
+		return err;
+
+	/*
+	 * Project Quota ID state is only allowed to change from within the init
+	 * namespace. Enforce that restriction only if we are trying to change
+	 * the quota ID state. Everything else is allowed in user namespaces.
+	 */
+	if (current_user_ns() != &init_user_ns) {
+		if (old_ma->fsx_projid != ma->fsx_projid)
+			return -EINVAL;
+		if ((old_ma->fsx_xflags ^ ma->fsx_xflags) &
+				FS_XFLAG_PROJINHERIT)
+			return -EINVAL;
+	}
+
+	/* Check extent size hints. */
+	if ((ma->fsx_xflags & FS_XFLAG_EXTSIZE) && !S_ISREG(inode->i_mode))
+		return -EINVAL;
+
+	if ((ma->fsx_xflags & FS_XFLAG_EXTSZINHERIT) &&
+			!S_ISDIR(inode->i_mode))
+		return -EINVAL;
+
+	if ((ma->fsx_xflags & FS_XFLAG_COWEXTSIZE) &&
+	    !S_ISREG(inode->i_mode) && !S_ISDIR(inode->i_mode))
+		return -EINVAL;
+
+	/*
+	 * It is only valid to set the DAX flag on regular files and
+	 * directories on filesystems.
+	 */
+	if ((ma->fsx_xflags & FS_XFLAG_DAX) &&
+	    !(S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode)))
+		return -EINVAL;
+
+	/* Extent size hints of zero turn off the flags. */
+	if (ma->fsx_extsize == 0)
+		ma->fsx_xflags &= ~(FS_XFLAG_EXTSIZE | FS_XFLAG_EXTSZINHERIT);
+	if (ma->fsx_cowextsize == 0)
+		ma->fsx_xflags &= ~FS_XFLAG_COWEXTSIZE;
+
+	return 0;
+}
+
+/**
+ * vfs_miscattr_set - change miscellaneous inode attributes
+ * @dentry:	the object to change
+ * @ma:		miscattr pointer
+ *
+ * After verifying permissions, call i_op->miscattr_set() callback, if
+ * exists.
+ *
+ * Verifying attributes involves retrieving current attributes with
+ * i_op->miscattr_get(), this also allows initilaizing attributes that have
+ * not been set by the caller to current values.  Inode lock is held
+ * thoughout to prevent racing with another instance.
+ *
+ * Returns 0 on success, or a negative error on failure.
+ */
+int vfs_miscattr_set(struct user_namespace *mnt_userns, struct dentry *dentry,
+		     struct miscattr *ma)
+{
+	struct inode *inode = d_inode(dentry);
+	struct miscattr old_ma = {};
+	int err;
+
+	if (d_is_special(dentry))
+		return -ENOTTY;
+
+	if (!inode->i_op->miscattr_set)
+		return -ENOIOCTLCMD;
+
+	if (!inode_owner_or_capable(mnt_userns, inode))
+		return -EPERM;
+
+	inode_lock(inode);
+	err = vfs_miscattr_get(dentry, &old_ma);
+	if (!err) {
+		/* initialize missing bits from old_ma */
+		if (ma->flags_valid) {
+			ma->fsx_xflags |= old_ma.fsx_xflags & ~FS_XFLAG_COMMON;
+			ma->fsx_extsize = old_ma.fsx_extsize;
+			ma->fsx_nextents = old_ma.fsx_nextents;
+			ma->fsx_projid = old_ma.fsx_projid;
+			ma->fsx_cowextsize = old_ma.fsx_cowextsize;
+		} else {
+			ma->flags |= old_ma.flags & ~FS_COMMON_FL;
+		}
+		err = miscattr_set_prepare(inode, &old_ma, ma);
+		if (!err)
+			err = inode->i_op->miscattr_set(mnt_userns, dentry, ma);
+	}
+	inode_unlock(inode);
+
+	return err;
+}
+EXPORT_SYMBOL(vfs_miscattr_set);
+
+static int ioctl_getflags(struct file *file, void __user *argp)
+{
+	struct miscattr ma = { .flags_valid = true }; /* hint only */
+	unsigned int flags;
+	int err;
+
+	err = vfs_miscattr_get(file_dentry(file), &ma);
+	if (!err) {
+		flags = ma.flags;
+		if (copy_to_user(argp, &flags, sizeof(flags)))
+			err = -EFAULT;
+	}
+	return err;
+}
+
+static int ioctl_setflags(struct file *file, void __user *argp)
+{
+	struct miscattr ma;
+	unsigned int flags;
+	int err;
+
+	if (copy_from_user(&flags, argp, sizeof(flags)))
+		return -EFAULT;
+
+	err = mnt_want_write_file(file);
+	if (!err) {
+		miscattr_fill_flags(&ma, flags);
+		err = vfs_miscattr_set(file_mnt_user_ns(file), file_dentry(file), &ma);
+		mnt_drop_write_file(file);
+	}
+	return err;
+}
+
+static int ioctl_fsgetxattr(struct file *file, void __user *argp)
+{
+	struct miscattr ma = { .xattr_valid = true }; /* hint only */
+	int err;
+
+	err = vfs_miscattr_get(file_dentry(file), &ma);
+	if (!err)
+		err = fsxattr_copy_to_user(&ma, argp);
+
+	return err;
+}
+
+static int ioctl_fssetxattr(struct file *file, void __user *argp)
+{
+	struct miscattr ma;
+	int err;
+
+	err = fsxattr_copy_from_user(&ma, argp);
+	if (!err) {
+		err = mnt_want_write_file(file);
+		if (!err) {
+			err = vfs_miscattr_set(file_mnt_user_ns(file), file_dentry(file), &ma);
+			mnt_drop_write_file(file);
+		}
+	}
+	return err;
+}
+
 /*
  * do_vfs_ioctl() is not for drivers and not intended to be EXPORT_SYMBOL()'d.
  * It's just a simple helper for sys_ioctl and compat_sys_ioctl.
@@ -727,6 +1035,18 @@ static int do_vfs_ioctl(struct file *filp, unsigned int fd,
 		return put_user(i_size_read(inode) - filp->f_pos,
 				(int __user *)argp);
 
+	case FS_IOC_GETFLAGS:
+		return ioctl_getflags(filp, argp);
+
+	case FS_IOC_SETFLAGS:
+		return ioctl_setflags(filp, argp);
+
+	case FS_IOC_FSGETXATTR:
+		return ioctl_fsgetxattr(filp, argp);
+
+	case FS_IOC_FSSETXATTR:
+		return ioctl_fssetxattr(filp, argp);
+
 	default:
 		if (S_ISREG(inode->i_mode))
 			return file_ioctl(filp, cmd, argp);
@@ -827,6 +1147,15 @@ COMPAT_SYSCALL_DEFINE3(ioctl, unsigned int, fd, unsigned int, cmd,
 		break;
 #endif
 
+	/*
+	 * These access 32-bit values anyway so no further handling is
+	 * necessary.
+	 */
+	case FS_IOC32_GETFLAGS:
+	case FS_IOC32_SETFLAGS:
+		cmd = (cmd == FS_IOC32_GETFLAGS) ?
+			FS_IOC_GETFLAGS : FS_IOC_SETFLAGS;
+		fallthrough;
 	/*
 	 * everything else in do_vfs_ioctl() takes either a compatible
 	 * pointer argument or no argument -- call it with a modified
diff --git a/include/linux/fs.h b/include/linux/fs.h
index ec8f3ddf4a6a..9e7f6a592a70 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -70,6 +70,7 @@ struct fsverity_info;
 struct fsverity_operations;
 struct fs_context;
 struct fs_parameter_spec;
+struct miscattr;
 
 extern void __init inode_init(void);
 extern void __init inode_init_early(void);
@@ -1963,6 +1964,9 @@ struct inode_operations {
 			struct dentry *, umode_t);
 	int (*set_acl)(struct user_namespace *, struct inode *,
 		       struct posix_acl *, int);
+	int (*miscattr_set)(struct user_namespace *mnt_userns,
+			    struct dentry *dentry, struct miscattr *ma);
+	int (*miscattr_get)(struct dentry *dentry, struct miscattr *ma);
 } ____cacheline_aligned;
 
 static inline ssize_t call_read_iter(struct file *file, struct kiocb *kio,
diff --git a/include/linux/miscattr.h b/include/linux/miscattr.h
new file mode 100644
index 000000000000..13683eb6ac78
--- /dev/null
+++ b/include/linux/miscattr.h
@@ -0,0 +1,53 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _LINUX_MISCATTR_H
+#define _LINUX_MISCATTR_H
+
+/* Flags shared betwen flags/xflags */
+#define FS_COMMON_FL \
+	(FS_SYNC_FL | FS_IMMUTABLE_FL | FS_APPEND_FL | \
+	 FS_NODUMP_FL |	FS_NOATIME_FL | FS_DAX_FL | \
+	 FS_PROJINHERIT_FL)
+
+#define FS_XFLAG_COMMON \
+	(FS_XFLAG_SYNC | FS_XFLAG_IMMUTABLE | FS_XFLAG_APPEND | \
+	 FS_XFLAG_NODUMP | FS_XFLAG_NOATIME | FS_XFLAG_DAX | \
+	 FS_XFLAG_PROJINHERIT)
+
+struct miscattr {
+	u32	flags;		/* flags (FS_IOC_GETFLAGS/FS_IOC_SETFLAGS) */
+	/* struct fsxattr: */
+	u32	fsx_xflags;	/* xflags field value (get/set) */
+	u32	fsx_extsize;	/* extsize field value (get/set)*/
+	u32	fsx_nextents;	/* nextents field value (get)	*/
+	u32	fsx_projid;	/* project identifier (get/set) */
+	u32	fsx_cowextsize;	/* CoW extsize field value (get/set)*/
+	/* selectors: */
+	bool	flags_valid:1;
+	bool	xattr_valid:1;
+};
+
+int fsxattr_copy_to_user(const struct miscattr *ma, struct fsxattr __user *ufa);
+
+void miscattr_fill_xflags(struct miscattr *ma, u32 xflags);
+void miscattr_fill_flags(struct miscattr *ma, u32 flags);
+
+/**
+ * miscattr_has_xattr - check for extentended flags/attributes
+ * @ma:		miscattr pointer
+ *
+ * Returns true if any attributes are present that are not represented in
+ * ->flags.
+ */
+static inline bool miscattr_has_xattr(const struct miscattr *ma)
+{
+	return ma->xattr_valid &&
+		((ma->fsx_xflags & ~FS_XFLAG_COMMON) || ma->fsx_extsize != 0 ||
+		 ma->fsx_projid != 0 ||	ma->fsx_cowextsize != 0);
+}
+
+int vfs_miscattr_get(struct dentry *dentry, struct miscattr *ma);
+int vfs_miscattr_set(struct user_namespace *mnt_userns, struct dentry *dentry,
+		     struct miscattr *ma);
+
+#endif /* _LINUX_MISCATTR_H */
-- 
2.30.2

