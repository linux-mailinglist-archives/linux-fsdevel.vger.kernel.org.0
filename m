Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51099349A62
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Mar 2021 20:39:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbhCYTij (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Mar 2021 15:38:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:59409 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230175AbhCYTiE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Mar 2021 15:38:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616701082;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jQmSH1vgv0FXEQYL2wHKP1TGBS3YWkKa7zIgB6zhZaQ=;
        b=QNyeGLnwoe4JR9eNnTSTgd8rULdFEhfZkTxcd8Jg2VZDWa9tlk/G5c/NL+q3PtoD7XEasx
        Wa4S9JiBWCcKB7ZtK3WhM6R2lCFSpbtNhRFlWKFkTjiJ6s4zTwBr23RO+yXQIGEFqH4Dtz
        Gjkpp1m9hFFEoNwzFW1QxclnZzuPAXE=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-48-pauYzrfnPDy1mNNDGyredQ-1; Thu, 25 Mar 2021 15:38:00 -0400
X-MC-Unique: pauYzrfnPDy1mNNDGyredQ-1
Received: by mail-ed1-f72.google.com with SMTP id bi17so3201727edb.6
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Mar 2021 12:38:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jQmSH1vgv0FXEQYL2wHKP1TGBS3YWkKa7zIgB6zhZaQ=;
        b=BD+J0rpS6JKNhXc1hZoPy7TCYOEcr3zMnFDwlwWwp3f9Qh1gtSqbqGx3xZd4mNfccZ
         a8VCzRVWJrA5zw4FA0R/iJ9VckOMuro8fZy5ZPYaTCmzMcCvTmA0vMmSNz6QxaLPEG44
         LyRlBey6OM8085CXR2ZDbnDxnMhwDWqhSQzH4LSF8mbulCs21r+itEzw6IMxRXMAUduL
         4CHxjDPOAjm2Jt5m01PVZzsk49e3Z2dzZGgA48krHAyUxo2YCF6X7k/qdlqYIO51KhvY
         d7OEPE4cgHGl9r/nTIPBknu8RbCTwTSuZQQpQXCMNibFrp/EXYwDlpt0J3OVseY+3YNV
         dj2g==
X-Gm-Message-State: AOAM530+H2wOH7ox420nAYfX8sEGQ7RMlmnzz+Anu+0Z+8FFKtgwhqDC
        8BX007D+uu3dQ0awJkG3S1XEVkuLLWw+tRbiuqFnV1jYpcHIpSqaRtqXSNHf2dc3/l0piRwFsRF
        k2q9RZ43tVppI/Bht6jPIAhOWXgBWg0o8HbusMDo3s+xZBTsQd7jQoOhu/N6Q4uzDN6jEW2NanB
        DntQ==
X-Received: by 2002:a17:906:5e4a:: with SMTP id b10mr11377009eju.116.1616701078916;
        Thu, 25 Mar 2021 12:37:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyfo/ZV6n+Mu+umln+b4bCiM6QikfVguoonxqmGRJwIDNwvnBFgVlQDmO1W/Dar9y+0EOk7Ww==
X-Received: by 2002:a17:906:5e4a:: with SMTP id b10mr11376978eju.116.1616701078561;
        Thu, 25 Mar 2021 12:37:58 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-86-101-169-67.catv.broadband.hu. [86.101.169.67])
        by smtp.gmail.com with ESMTPSA id si7sm2881996ejb.84.2021.03.25.12.37.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 12:37:58 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Al Viro <viro@ZenIV.linux.org.uk>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Amir Goldstein <amir73il@gmail.com>,
        David Sterba <dsterba@suse.cz>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Eric Biggers <ebiggers@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 01/18] vfs: add fileattr ops
Date:   Thu, 25 Mar 2021 20:37:38 +0100
Message-Id: <20210325193755.294925-2-mszeredi@redhat.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210325193755.294925-1-mszeredi@redhat.com>
References: <20210325193755.294925-1-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There's a substantial amount of boilerplate in filesystems handling
FS_IOC_[GS]ETFLAGS/ FS_IOC_FS[GS]ETXATTR ioctls.

Also due to userspace buffers being involved in the ioctl API this is
difficult to stack, as shown by overlayfs issues related to these ioctls.

Introduce a new internal API named "fileattr" (fsxattr can be confused with
xattr, xflags is inappropriate, since this is more than just flags).

There's significant overlap between flags and xflags and this API handles
the conversions automatically, so filesystems may choose which one to use.

In ->fileattr_get() a hint is provided to the filesystem whether flags or
xattr are being requested by userspace, but in this series this hint is
ignored by all filesystems, since generating all the attributes is cheap.

If a filesystem doesn't implemement the fileattr API, just fall back to
f_op->ioctl().  When all filesystems are converted, the fallback can be
removed.

32bit compat ioctls are now handled by the generic code as well.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 Documentation/filesystems/locking.rst |   5 +
 Documentation/filesystems/vfs.rst     |  15 ++
 fs/ioctl.c                            | 331 ++++++++++++++++++++++++++
 include/linux/fileattr.h              |  59 +++++
 include/linux/fs.h                    |   4 +
 5 files changed, 414 insertions(+)
 create mode 100644 include/linux/fileattr.h

diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
index b7dcc86c92a4..7b9b307bedfc 100644
--- a/Documentation/filesystems/locking.rst
+++ b/Documentation/filesystems/locking.rst
@@ -80,6 +80,9 @@ prototypes::
 				struct file *, unsigned open_flag,
 				umode_t create_mode);
 	int (*tmpfile) (struct inode *, struct dentry *, umode_t);
+	int (*fileattr_set)(struct user_namespace *mnt_userns,
+			    struct dentry *dentry, struct fileattr *fa);
+	int (*fileattr_get)(struct dentry *dentry, struct fileattr *fa);
 
 locking rules:
 	all may block
@@ -107,6 +110,8 @@ fiemap:		no
 update_time:	no
 atomic_open:	shared (exclusive if O_CREAT is set in open flags)
 tmpfile:	no
+fileattr_get:	no or exclusive
+fileattr_set:	exclusive
 ============	=============================================
 
 
diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
index 2049bbf5e388..14c31eced416 100644
--- a/Documentation/filesystems/vfs.rst
+++ b/Documentation/filesystems/vfs.rst
@@ -441,6 +441,9 @@ As of kernel 2.6.22, the following members are defined:
 				   unsigned open_flag, umode_t create_mode);
 		int (*tmpfile) (struct user_namespace *, struct inode *, struct dentry *, umode_t);
 	        int (*set_acl)(struct user_namespace *, struct inode *, struct posix_acl *, int);
+		int (*fileattr_set)(struct user_namespace *mnt_userns,
+				    struct dentry *dentry, struct fileattr *fa);
+		int (*fileattr_get)(struct dentry *dentry, struct fileattr *fa);
 	};
 
 Again, all methods are called without any locks being held, unless
@@ -588,6 +591,18 @@ otherwise noted.
 	atomically creating, opening and unlinking a file in given
 	directory.
 
+``fileattr_get``
+	called on ioctl(FS_IOC_GETFLAGS) and ioctl(FS_IOC_FSGETXATTR) to
+	retrieve miscellaneous file flags and attributes.  Also called
+	before the relevant SET operation to check what is being changed
+	(in this case with i_rwsem locked exclusive).  If unset, then
+	fall back to f_op->ioctl().
+
+``fileattr_set``
+	called on ioctl(FS_IOC_SETFLAGS) and ioctl(FS_IOC_FSSETXATTR) to
+	change miscellaneous file flags and attributes.  Callers hold
+	i_rwsem exclusive.  If unset, then fall back to f_op->ioctl().
+
 
 The Address Space Object
 ========================
diff --git a/fs/ioctl.c b/fs/ioctl.c
index 4e6cc0a7d69c..b27b5316b30c 100644
--- a/fs/ioctl.c
+++ b/fs/ioctl.c
@@ -19,6 +19,9 @@
 #include <linux/falloc.h>
 #include <linux/sched/signal.h>
 #include <linux/fiemap.h>
+#include <linux/mount.h>
+#include <linux/fscrypt.h>
+#include <linux/fileattr.h>
 
 #include "internal.h"
 
@@ -657,6 +660,313 @@ static int ioctl_file_dedupe_range(struct file *file,
 	return ret;
 }
 
+/**
+ * fileattr_fill_xflags - initialize fileattr with xflags
+ * @fa:		fileattr pointer
+ * @xflags:	FS_XFLAG_* flags
+ *
+ * Set ->fsx_xflags, ->fsx_valid and ->flags (translated xflags).  All
+ * other fields are zeroed.
+ */
+void fileattr_fill_xflags(struct fileattr *fa, u32 xflags)
+{
+	memset(fa, 0, sizeof(*fa));
+	fa->fsx_valid = true;
+	fa->fsx_xflags = xflags;
+	if (fa->fsx_xflags & FS_XFLAG_IMMUTABLE)
+		fa->flags |= FS_IMMUTABLE_FL;
+	if (fa->fsx_xflags & FS_XFLAG_APPEND)
+		fa->flags |= FS_APPEND_FL;
+	if (fa->fsx_xflags & FS_XFLAG_SYNC)
+		fa->flags |= FS_SYNC_FL;
+	if (fa->fsx_xflags & FS_XFLAG_NOATIME)
+		fa->flags |= FS_NOATIME_FL;
+	if (fa->fsx_xflags & FS_XFLAG_NODUMP)
+		fa->flags |= FS_NODUMP_FL;
+	if (fa->fsx_xflags & FS_XFLAG_DAX)
+		fa->flags |= FS_DAX_FL;
+	if (fa->fsx_xflags & FS_XFLAG_PROJINHERIT)
+		fa->flags |= FS_PROJINHERIT_FL;
+}
+EXPORT_SYMBOL(fileattr_fill_xflags);
+
+/**
+ * fileattr_fill_flags - initialize fileattr with flags
+ * @fa:		fileattr pointer
+ * @flags:	FS_*_FL flags
+ *
+ * Set ->flags, ->flags_valid and ->fsx_xflags (translated flags).
+ * All other fields are zeroed.
+ */
+void fileattr_fill_flags(struct fileattr *fa, u32 flags)
+{
+	memset(fa, 0, sizeof(*fa));
+	fa->flags_valid = true;
+	fa->flags = flags;
+	if (fa->flags & FS_SYNC_FL)
+		fa->fsx_xflags |= FS_XFLAG_SYNC;
+	if (fa->flags & FS_IMMUTABLE_FL)
+		fa->fsx_xflags |= FS_XFLAG_IMMUTABLE;
+	if (fa->flags & FS_APPEND_FL)
+		fa->fsx_xflags |= FS_XFLAG_APPEND;
+	if (fa->flags & FS_NODUMP_FL)
+		fa->fsx_xflags |= FS_XFLAG_NODUMP;
+	if (fa->flags & FS_NOATIME_FL)
+		fa->fsx_xflags |= FS_XFLAG_NOATIME;
+	if (fa->flags & FS_DAX_FL)
+		fa->fsx_xflags |= FS_XFLAG_DAX;
+	if (fa->flags & FS_PROJINHERIT_FL)
+		fa->fsx_xflags |= FS_XFLAG_PROJINHERIT;
+}
+EXPORT_SYMBOL(fileattr_fill_flags);
+
+/**
+ * vfs_fileattr_get - retrieve miscellaneous file attributes
+ * @dentry:	the object to retrieve from
+ * @fa:		fileattr pointer
+ *
+ * Call i_op->fileattr_get() callback, if exists.
+ *
+ * Return: 0 on success, or a negative error on failure.
+ */
+int vfs_fileattr_get(struct dentry *dentry, struct fileattr *fa)
+{
+	struct inode *inode = d_inode(dentry);
+
+	if (d_is_special(dentry))
+		return -ENOTTY;
+
+	if (!inode->i_op->fileattr_get)
+		return -ENOIOCTLCMD;
+
+	return inode->i_op->fileattr_get(dentry, fa);
+}
+EXPORT_SYMBOL(vfs_fileattr_get);
+
+/**
+ * copy_fsxattr_to_user - copy fsxattr to userspace.
+ * @fa:		fileattr pointer
+ * @ufa:	fsxattr user pointer
+ *
+ * Return: 0 on success, or -EFAULT on failure.
+ */
+int copy_fsxattr_to_user(const struct fileattr *fa, struct fsxattr __user *ufa)
+{
+	struct fsxattr xfa;
+
+	memset(&xfa, 0, sizeof(xfa));
+	xfa.fsx_xflags = fa->fsx_xflags;
+	xfa.fsx_extsize = fa->fsx_extsize;
+	xfa.fsx_nextents = fa->fsx_nextents;
+	xfa.fsx_projid = fa->fsx_projid;
+	xfa.fsx_cowextsize = fa->fsx_cowextsize;
+
+	if (copy_to_user(ufa, &xfa, sizeof(xfa)))
+		return -EFAULT;
+
+	return 0;
+}
+EXPORT_SYMBOL(copy_fsxattr_to_user);
+
+static int copy_fsxattr_from_user(struct fileattr *fa,
+				  struct fsxattr __user *ufa)
+{
+	struct fsxattr xfa;
+
+	if (copy_from_user(&xfa, ufa, sizeof(xfa)))
+		return -EFAULT;
+
+	fileattr_fill_xflags(fa, xfa.fsx_xflags);
+	fa->fsx_extsize = xfa.fsx_extsize;
+	fa->fsx_nextents = xfa.fsx_nextents;
+	fa->fsx_projid = xfa.fsx_projid;
+	fa->fsx_cowextsize = xfa.fsx_cowextsize;
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
+static int fileattr_set_prepare(struct inode *inode,
+			      const struct fileattr *old_ma,
+			      struct fileattr *fa)
+{
+	int err;
+
+	/*
+	 * The IMMUTABLE and APPEND_ONLY flags can only be changed by
+	 * the relevant capability.
+	 */
+	if ((fa->flags ^ old_ma->flags) & (FS_APPEND_FL | FS_IMMUTABLE_FL) &&
+	    !capable(CAP_LINUX_IMMUTABLE))
+		return -EPERM;
+
+	err = fscrypt_prepare_setflags(inode, old_ma->flags, fa->flags);
+	if (err)
+		return err;
+
+	/*
+	 * Project Quota ID state is only allowed to change from within the init
+	 * namespace. Enforce that restriction only if we are trying to change
+	 * the quota ID state. Everything else is allowed in user namespaces.
+	 */
+	if (current_user_ns() != &init_user_ns) {
+		if (old_ma->fsx_projid != fa->fsx_projid)
+			return -EINVAL;
+		if ((old_ma->fsx_xflags ^ fa->fsx_xflags) &
+				FS_XFLAG_PROJINHERIT)
+			return -EINVAL;
+	}
+
+	/* Check extent size hints. */
+	if ((fa->fsx_xflags & FS_XFLAG_EXTSIZE) && !S_ISREG(inode->i_mode))
+		return -EINVAL;
+
+	if ((fa->fsx_xflags & FS_XFLAG_EXTSZINHERIT) &&
+			!S_ISDIR(inode->i_mode))
+		return -EINVAL;
+
+	if ((fa->fsx_xflags & FS_XFLAG_COWEXTSIZE) &&
+	    !S_ISREG(inode->i_mode) && !S_ISDIR(inode->i_mode))
+		return -EINVAL;
+
+	/*
+	 * It is only valid to set the DAX flag on regular files and
+	 * directories on filesystems.
+	 */
+	if ((fa->fsx_xflags & FS_XFLAG_DAX) &&
+	    !(S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode)))
+		return -EINVAL;
+
+	/* Extent size hints of zero turn off the flags. */
+	if (fa->fsx_extsize == 0)
+		fa->fsx_xflags &= ~(FS_XFLAG_EXTSIZE | FS_XFLAG_EXTSZINHERIT);
+	if (fa->fsx_cowextsize == 0)
+		fa->fsx_xflags &= ~FS_XFLAG_COWEXTSIZE;
+
+	return 0;
+}
+
+/**
+ * vfs_fileattr_set - change miscellaneous file attributes
+ * @mnt_userns:	user namespace of the mount
+ * @dentry:	the object to change
+ * @fa:		fileattr pointer
+ *
+ * After verifying permissions, call i_op->fileattr_set() callback, if
+ * exists.
+ *
+ * Verifying attributes involves retrieving current attributes with
+ * i_op->fileattr_get(), this also allows initializing attributes that have
+ * not been set by the caller to current values.  Inode lock is held
+ * thoughout to prevent racing with another instance.
+ *
+ * Return: 0 on success, or a negative error on failure.
+ */
+int vfs_fileattr_set(struct user_namespace *mnt_userns, struct dentry *dentry,
+		     struct fileattr *fa)
+{
+	struct inode *inode = d_inode(dentry);
+	struct fileattr old_ma = {};
+	int err;
+
+	if (d_is_special(dentry))
+		return -ENOTTY;
+
+	if (!inode->i_op->fileattr_set)
+		return -ENOIOCTLCMD;
+
+	if (!inode_owner_or_capable(mnt_userns, inode))
+		return -EPERM;
+
+	inode_lock(inode);
+	err = vfs_fileattr_get(dentry, &old_ma);
+	if (!err) {
+		/* initialize missing bits from old_ma */
+		if (fa->flags_valid) {
+			fa->fsx_xflags |= old_ma.fsx_xflags & ~FS_XFLAG_COMMON;
+			fa->fsx_extsize = old_ma.fsx_extsize;
+			fa->fsx_nextents = old_ma.fsx_nextents;
+			fa->fsx_projid = old_ma.fsx_projid;
+			fa->fsx_cowextsize = old_ma.fsx_cowextsize;
+		} else {
+			fa->flags |= old_ma.flags & ~FS_COMMON_FL;
+		}
+		err = fileattr_set_prepare(inode, &old_ma, fa);
+		if (!err)
+			err = inode->i_op->fileattr_set(mnt_userns, dentry, fa);
+	}
+	inode_unlock(inode);
+
+	return err;
+}
+EXPORT_SYMBOL(vfs_fileattr_set);
+
+static int ioctl_getflags(struct file *file, void __user *argp)
+{
+	struct fileattr fa = { .flags_valid = true }; /* hint only */
+	unsigned int flags;
+	int err;
+
+	err = vfs_fileattr_get(file->f_path.dentry, &fa);
+	if (!err) {
+		flags = fa.flags;
+		if (copy_to_user(argp, &flags, sizeof(flags)))
+			err = -EFAULT;
+	}
+	return err;
+}
+
+static int ioctl_setflags(struct file *file, void __user *argp)
+{
+	struct fileattr fa;
+	unsigned int flags;
+	int err;
+
+	if (copy_from_user(&flags, argp, sizeof(flags)))
+		return -EFAULT;
+
+	err = mnt_want_write_file(file);
+	if (!err) {
+		fileattr_fill_flags(&fa, flags);
+		err = vfs_fileattr_set(file_mnt_user_ns(file), file_dentry(file), &fa);
+		mnt_drop_write_file(file);
+	}
+	return err;
+}
+
+static int ioctl_fsgetxattr(struct file *file, void __user *argp)
+{
+	struct fileattr fa = { .fsx_valid = true }; /* hint only */
+	int err;
+
+	err = vfs_fileattr_get(file_dentry(file), &fa);
+	if (!err)
+		err = copy_fsxattr_to_user(&fa, argp);
+
+	return err;
+}
+
+static int ioctl_fssetxattr(struct file *file, void __user *argp)
+{
+	struct fileattr fa;
+	int err;
+
+	err = copy_fsxattr_from_user(&fa, argp);
+	if (!err) {
+		err = mnt_want_write_file(file);
+		if (!err) {
+			err = vfs_fileattr_set(file_mnt_user_ns(file), file_dentry(file), &fa);
+			mnt_drop_write_file(file);
+		}
+	}
+	return err;
+}
+
 /*
  * do_vfs_ioctl() is not for drivers and not intended to be EXPORT_SYMBOL()'d.
  * It's just a simple helper for sys_ioctl and compat_sys_ioctl.
@@ -727,6 +1037,18 @@ static int do_vfs_ioctl(struct file *filp, unsigned int fd,
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
@@ -827,6 +1149,15 @@ COMPAT_SYSCALL_DEFINE3(ioctl, unsigned int, fd, unsigned int, cmd,
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
diff --git a/include/linux/fileattr.h b/include/linux/fileattr.h
new file mode 100644
index 000000000000..9e37e063ac69
--- /dev/null
+++ b/include/linux/fileattr.h
@@ -0,0 +1,59 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _LINUX_FILEATTR_H
+#define _LINUX_FILEATTR_H
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
+/*
+ * Merged interface for miscellaneous file attributes.  'flags' originates from
+ * ext* and 'fsx_flags' from xfs.  There's some overlap between the two, which
+ * is handled by the VFS helpers, so filesystems are free to implement just one
+ * or both of these sub-interfaces.
+ */
+struct fileattr {
+	u32	flags;		/* flags (FS_IOC_GETFLAGS/FS_IOC_SETFLAGS) */
+	/* struct fsxattr: */
+	u32	fsx_xflags;	/* xflags field value (get/set) */
+	u32	fsx_extsize;	/* extsize field value (get/set)*/
+	u32	fsx_nextents;	/* nextents field value (get)	*/
+	u32	fsx_projid;	/* project identifier (get/set) */
+	u32	fsx_cowextsize;	/* CoW extsize field value (get/set)*/
+	/* selectors: */
+	bool	flags_valid:1;
+	bool	fsx_valid:1;
+};
+
+int copy_fsxattr_to_user(const struct fileattr *fa, struct fsxattr __user *ufa);
+
+void fileattr_fill_xflags(struct fileattr *fa, u32 xflags);
+void fileattr_fill_flags(struct fileattr *fa, u32 flags);
+
+/**
+ * fileattr_has_fsx - check for extended flags/attributes
+ * @fa:		fileattr pointer
+ *
+ * Return: true if any attributes are present that are not represented in
+ * ->flags.
+ */
+static inline bool fileattr_has_fsx(const struct fileattr *fa)
+{
+	return fa->fsx_valid &&
+		((fa->fsx_xflags & ~FS_XFLAG_COMMON) || fa->fsx_extsize != 0 ||
+		 fa->fsx_projid != 0 ||	fa->fsx_cowextsize != 0);
+}
+
+int vfs_fileattr_get(struct dentry *dentry, struct fileattr *fa);
+int vfs_fileattr_set(struct user_namespace *mnt_userns, struct dentry *dentry,
+		     struct fileattr *fa);
+
+#endif /* _LINUX_FILEATTR_H */
diff --git a/include/linux/fs.h b/include/linux/fs.h
index ec8f3ddf4a6a..156b78f42a28 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -70,6 +70,7 @@ struct fsverity_info;
 struct fsverity_operations;
 struct fs_context;
 struct fs_parameter_spec;
+struct fileattr;
 
 extern void __init inode_init(void);
 extern void __init inode_init_early(void);
@@ -1963,6 +1964,9 @@ struct inode_operations {
 			struct dentry *, umode_t);
 	int (*set_acl)(struct user_namespace *, struct inode *,
 		       struct posix_acl *, int);
+	int (*fileattr_set)(struct user_namespace *mnt_userns,
+			    struct dentry *dentry, struct fileattr *fa);
+	int (*fileattr_get)(struct dentry *dentry, struct fileattr *fa);
 } ____cacheline_aligned;
 
 static inline ssize_t call_read_iter(struct file *file, struct kiocb *kio,
-- 
2.30.2

