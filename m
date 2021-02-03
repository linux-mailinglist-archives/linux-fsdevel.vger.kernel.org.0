Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D01A630DA01
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Feb 2021 13:44:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbhBCMng (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Feb 2021 07:43:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:56959 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229736AbhBCMnF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Feb 2021 07:43:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612356097;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2izXYMi7WY+3DTzM0kO/qhwaorS42L5+to1kNWph40A=;
        b=RCVviehkWSpUa2bUlkyXDCHc/To1xzWP3oUC6AM8h/bb/C456mYBLVYtPcAcLlMV8aOg5U
        8kr7JvMmi4q27eTuCuJQgYi1e22nmquPzfnJMdgeBjjqO11zTBQqEm0jhLq6ESjGDAj7RI
        dl6keOJCoJ26WU+rv1vS8kGoUev5Yv4=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-348-j_QvC8CQNIiZ4EPZFbx27A-1; Wed, 03 Feb 2021 07:41:36 -0500
X-MC-Unique: j_QvC8CQNIiZ4EPZFbx27A-1
Received: by mail-ej1-f72.google.com with SMTP id hx26so5590143ejc.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Feb 2021 04:41:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2izXYMi7WY+3DTzM0kO/qhwaorS42L5+to1kNWph40A=;
        b=rMGiISBfNREH9tP9cJcSjDojcAzVm9//j4tByMjHnCY6ejN4gS7e/CeQa4xCQDYuvd
         mrv4AB4OswA8zmNi2CIJ/2etXAXlYXIKIMrb1ItCVFvWYWC/u+pwGGQU94HobPBZKWt3
         j6L1wTGo2Ld991s9Z6/0Yq0fpZPfaIrJMldZukKP85Qzctb/EBnaD9/PSCOhIfHlmj4h
         l3418neCNCGpQZO9MM6X2Y2umUsl6BCuqJ1xn/ikgGQ2Om3JvVYS3BR4CrVx8GecG+ui
         BEOEi5NGvkFNcKvtrzm6izR8jwY1OwAQ4AEu2Ptx7vMeMDRbBqLCkyrzJq/e+j9PrqUs
         8r/g==
X-Gm-Message-State: AOAM531xlTVmdJ0WG6IWWb/D8vzutY2jjAmkCC1k022eeltivZ63mxJf
        TQV/9smsGpmpArrD8HotSvySI2XVNOwHA5vhNGMhtyBv3UQgTnkwRPbFYnJ9bfCHwCJfQ3H1UFF
        aiVCkh7E1Xj7mU7WL2mxejsNHFwzksSwfL/l0mKvBQrl3lvEgt5m3OT2gBu+gX9Lm72wVQkeO9A
        LO9g==
X-Received: by 2002:aa7:cfc3:: with SMTP id r3mr2698590edy.125.1612356094814;
        Wed, 03 Feb 2021 04:41:34 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzBpJEVFNdSL1+Ll1DwHdcKFx9CndttVXr7lBdvFrASHr06Z3B+/7hzt20sIoA8KhIA3jMl1A==
X-Received: by 2002:aa7:cfc3:: with SMTP id r3mr2698545edy.125.1612356094416;
        Wed, 03 Feb 2021 04:41:34 -0800 (PST)
Received: from miu.piliscsaba.redhat.com (catv-86-101-169-67.catv.broadband.hu. [86.101.169.67])
        by smtp.gmail.com with ESMTPSA id u9sm953320ejc.57.2021.02.03.04.41.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 04:41:33 -0800 (PST)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Al Viro <viro@ZenIV.linux.org.uk>,
        Andreas Dilger <adilger@dilger.ca>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Dave Kleikamp <shaggy@kernel.org>,
        David Sterba <dsterba@suse.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Jan Kara <jack@suse.cz>,
        Joel Becker <jlbec@evilplan.org>,
        Matthew Garrett <matthew.garrett@nebula.com>,
        Mike Marshall <hubcap@omnibond.com>,
        Richard Weinberger <richard@nod.at>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        "Theodore Ts'o" <tytso@mit.edu>, Tyler Hicks <code@tyhicks.com>
Subject: [PATCH 01/18] vfs: add miscattr ops
Date:   Wed,  3 Feb 2021 13:40:55 +0100
Message-Id: <20210203124112.1182614-2-mszeredi@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210203124112.1182614-1-mszeredi@redhat.com>
References: <20210203124112.1182614-1-mszeredi@redhat.com>
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
 Documentation/filesystems/locking.rst |   4 +
 Documentation/filesystems/vfs.rst     |  14 ++
 fs/ioctl.c                            | 329 ++++++++++++++++++++++++++
 include/linux/fs.h                    |   3 +
 include/linux/miscattr.h              |  52 ++++
 5 files changed, 402 insertions(+)
 create mode 100644 include/linux/miscattr.h

diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
index c0f2c7586531..5c0a30dd8336 100644
--- a/Documentation/filesystems/locking.rst
+++ b/Documentation/filesystems/locking.rst
@@ -80,6 +80,8 @@ prototypes::
 				struct file *, unsigned open_flag,
 				umode_t create_mode);
 	int (*tmpfile) (struct inode *, struct dentry *, umode_t);
+	int (*miscattr_set)(struct dentry *dentry, struct miscattr *ma);
+	int (*miscattr_get)(struct dentry *dentry, struct miscattr *ma);
 
 locking rules:
 	all may block
@@ -107,6 +109,8 @@ fiemap:		no
 update_time:	no
 atomic_open:	shared (exclusive if O_CREAT is set in open flags)
 tmpfile:	no
+miscattr_get:	no or exclusive
+miscattr_set:	exclusive
 ============	=============================================
 
 
diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
index ca52c82e5bb5..a0ee8fc85678 100644
--- a/Documentation/filesystems/vfs.rst
+++ b/Documentation/filesystems/vfs.rst
@@ -437,6 +437,8 @@ As of kernel 2.6.22, the following members are defined:
 		int (*atomic_open)(struct inode *, struct dentry *, struct file *,
 				   unsigned open_flag, umode_t create_mode);
 		int (*tmpfile) (struct inode *, struct dentry *, umode_t);
+		int (*miscattr_set)(struct dentry *dentry, struct miscattr *ma);
+		int (*miscattr_get)(struct dentry *dentry, struct miscattr *ma);
 	};
 
 Again, all methods are called without any locks being held, unless
@@ -584,6 +586,18 @@ otherwise noted.
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
index 4e6cc0a7d69c..f38f75c82e76 100644
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
+	memset(ma, 0, sizeof(*ma));
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
+int vfs_miscattr_set(struct dentry *dentry, struct miscattr *ma)
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
+	if (!inode_owner_or_capable(inode))
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
+			err = inode->i_op->miscattr_set(dentry, ma);
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
+		err = vfs_miscattr_set(file_dentry(file), &ma);
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
+			err = vfs_miscattr_set(file_dentry(file), &ma);
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
index fd47deea7c17..ca3bab7d5f6e 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -68,6 +68,7 @@ struct fsverity_info;
 struct fsverity_operations;
 struct fs_context;
 struct fs_parameter_spec;
+struct miscattr;
 
 extern void __init inode_init(void);
 extern void __init inode_init_early(void);
@@ -1887,6 +1888,8 @@ struct inode_operations {
 			   umode_t create_mode);
 	int (*tmpfile) (struct inode *, struct dentry *, umode_t);
 	int (*set_acl)(struct inode *, struct posix_acl *, int);
+	int (*miscattr_set)(struct dentry *dentry, struct miscattr *ma);
+	int (*miscattr_get)(struct dentry *dentry, struct miscattr *ma);
 } ____cacheline_aligned;
 
 static inline ssize_t call_read_iter(struct file *file, struct kiocb *kio,
diff --git a/include/linux/miscattr.h b/include/linux/miscattr.h
new file mode 100644
index 000000000000..1c531779dc9d
--- /dev/null
+++ b/include/linux/miscattr.h
@@ -0,0 +1,52 @@
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
+int vfs_miscattr_set(struct dentry *dentry, struct miscattr *ma);
+
+#endif /* _LINUX_MISCATTR_H */
-- 
2.26.2

