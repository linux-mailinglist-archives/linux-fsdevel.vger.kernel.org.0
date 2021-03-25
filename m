Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02A5E349A6D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Mar 2021 20:39:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbhCYTir (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Mar 2021 15:38:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22439 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230300AbhCYTiN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Mar 2021 15:38:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616701092;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KvQ6hg8cw/o9Hzb2c37SzBazdEvQR2a5OfSbD8lGIqk=;
        b=YbHJaB+6ZgPuFnK5UGef7AmBjOCJbTIs66qlOCGdqaOCciu5vy+X9Iq0YuWeNnZWxWc7XV
        p+JwYADZqsm57/Eizf3tftoQIpTz+Yq1opMqF+rLBqnb7fGWCI9SCXNMTtIPagMir3PZVS
        y5jlrb0L6tLmKbCiQx9zhVLBq8xHGtc=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-579-gBu1du7ZNkCDay1zXnXXoA-1; Thu, 25 Mar 2021 15:38:10 -0400
X-MC-Unique: gBu1du7ZNkCDay1zXnXXoA-1
Received: by mail-ed1-f70.google.com with SMTP id h2so3195515edw.10
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Mar 2021 12:38:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KvQ6hg8cw/o9Hzb2c37SzBazdEvQR2a5OfSbD8lGIqk=;
        b=THH47GQbtCuTEjMjMTYKPOFU/JmIG9Sys6pdkPC8TSLbO82aYtXGVCJ1BZrT0Vzk0T
         B+Iu8qE5gQ7jMsV5f6KCc/gdK5qcSdUKc+Bz56lZyK10ETj0bYvzMG7vgpAygiFEHwhb
         KXbiBWCHcHzhhZBpwUfIH5auO43BA8wUJ1I80hhoiR/sW409daLTg0O/43N6j3QMR/Wo
         AdM5QIIlWHi6Uam3HWC+cUaLluY5S9J0OKveAKbL3lI3MZzQo92hyWGrumBNkN5ZOkjk
         FCHzIIJHEbLdqOVbhaEiYMx+OoYpB4ddehcaABvfYzGtw8R33V+6UgjNYl3UXl41zu0e
         3Hmg==
X-Gm-Message-State: AOAM5302qlj17YdReijUuG1L7H0ogj0u/gZ0gcBrhhVcwB/VTlXZCjrf
        I4eDhbIGO8US2C4klPofSAQHyXTkFT9FUKPgUKUyl8n4ybTgg5sUoLSGjz/2tym8X1KJOk7bO/c
        jbliQErJieSkXtc129KB8CFkVuBRGVqCmikawow85SrSM8h8eGUcXPDSRLyE9btcI9WskM4XC8x
        Yagw==
X-Received: by 2002:a17:907:9858:: with SMTP id jj24mr11143973ejc.212.1616701088738;
        Thu, 25 Mar 2021 12:38:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwu8G8gK6nLcWZolT0u/YQbkqzEdoR3/HKDpap4A0coDdBJRGLh/e/w+89NXYiQp/VNgvmIng==
X-Received: by 2002:a17:907:9858:: with SMTP id jj24mr11143942ejc.212.1616701088360;
        Thu, 25 Mar 2021 12:38:08 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-86-101-169-67.catv.broadband.hu. [86.101.169.67])
        by smtp.gmail.com with ESMTPSA id si7sm2881996ejb.84.2021.03.25.12.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 12:38:07 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Al Viro <viro@ZenIV.linux.org.uk>, linux-kernel@vger.kernel.org,
        "Darrick J . Wong" <djwong@kernel.org>
Subject: [PATCH v3 10/18] xfs: convert to fileattr
Date:   Thu, 25 Mar 2021 20:37:47 +0100
Message-Id: <20210325193755.294925-11-mszeredi@redhat.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210325193755.294925-1-mszeredi@redhat.com>
References: <20210325193755.294925-1-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use the fileattr API to let the VFS handle locking, permission checking and
conversion.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Cc: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/libxfs/xfs_fs.h |   4 -
 fs/xfs/xfs_ioctl.c     | 252 +++++++++--------------------------------
 fs/xfs/xfs_ioctl.h     |  11 ++
 fs/xfs/xfs_ioctl32.c   |   2 -
 fs/xfs/xfs_ioctl32.h   |   2 -
 fs/xfs/xfs_iops.c      |   7 ++
 6 files changed, 74 insertions(+), 204 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_fs.h b/fs/xfs/libxfs/xfs_fs.h
index 6fad140d4c8e..6bf7d8b7d743 100644
--- a/fs/xfs/libxfs/xfs_fs.h
+++ b/fs/xfs/libxfs/xfs_fs.h
@@ -770,8 +770,6 @@ struct xfs_scrub_metadata {
 /*
  * ioctl commands that are used by Linux filesystems
  */
-#define XFS_IOC_GETXFLAGS	FS_IOC_GETFLAGS
-#define XFS_IOC_SETXFLAGS	FS_IOC_SETFLAGS
 #define XFS_IOC_GETVERSION	FS_IOC_GETVERSION
 
 /*
@@ -782,8 +780,6 @@ struct xfs_scrub_metadata {
 #define XFS_IOC_ALLOCSP		_IOW ('X', 10, struct xfs_flock64)
 #define XFS_IOC_FREESP		_IOW ('X', 11, struct xfs_flock64)
 #define XFS_IOC_DIOINFO		_IOR ('X', 30, struct dioattr)
-#define XFS_IOC_FSGETXATTR	FS_IOC_FSGETXATTR
-#define XFS_IOC_FSSETXATTR	FS_IOC_FSSETXATTR
 #define XFS_IOC_ALLOCSP64	_IOW ('X', 36, struct xfs_flock64)
 #define XFS_IOC_FREESP64	_IOW ('X', 37, struct xfs_flock64)
 #define XFS_IOC_GETBMAP		_IOWR('X', 38, struct getbmap)
diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
index 99dfe89a8d08..72e56d4e1297 100644
--- a/fs/xfs/xfs_ioctl.c
+++ b/fs/xfs/xfs_ioctl.c
@@ -40,6 +40,7 @@
 
 #include <linux/mount.h>
 #include <linux/namei.h>
+#include <linux/fileattr.h>
 
 /*
  * xfs_find_handle maps from userspace xfs_fsop_handlereq structure to
@@ -1053,73 +1054,15 @@ xfs_ioc_ag_geometry(
  * Linux extended inode flags interface.
  */
 
-STATIC unsigned int
-xfs_merge_ioc_xflags(
-	unsigned int	flags,
-	unsigned int	start)
-{
-	unsigned int	xflags = start;
-
-	if (flags & FS_IMMUTABLE_FL)
-		xflags |= FS_XFLAG_IMMUTABLE;
-	else
-		xflags &= ~FS_XFLAG_IMMUTABLE;
-	if (flags & FS_APPEND_FL)
-		xflags |= FS_XFLAG_APPEND;
-	else
-		xflags &= ~FS_XFLAG_APPEND;
-	if (flags & FS_SYNC_FL)
-		xflags |= FS_XFLAG_SYNC;
-	else
-		xflags &= ~FS_XFLAG_SYNC;
-	if (flags & FS_NOATIME_FL)
-		xflags |= FS_XFLAG_NOATIME;
-	else
-		xflags &= ~FS_XFLAG_NOATIME;
-	if (flags & FS_NODUMP_FL)
-		xflags |= FS_XFLAG_NODUMP;
-	else
-		xflags &= ~FS_XFLAG_NODUMP;
-	if (flags & FS_DAX_FL)
-		xflags |= FS_XFLAG_DAX;
-	else
-		xflags &= ~FS_XFLAG_DAX;
-
-	return xflags;
-}
-
-STATIC unsigned int
-xfs_di2lxflags(
-	uint16_t	di_flags,
-	uint64_t	di_flags2)
-{
-	unsigned int	flags = 0;
-
-	if (di_flags & XFS_DIFLAG_IMMUTABLE)
-		flags |= FS_IMMUTABLE_FL;
-	if (di_flags & XFS_DIFLAG_APPEND)
-		flags |= FS_APPEND_FL;
-	if (di_flags & XFS_DIFLAG_SYNC)
-		flags |= FS_SYNC_FL;
-	if (di_flags & XFS_DIFLAG_NOATIME)
-		flags |= FS_NOATIME_FL;
-	if (di_flags & XFS_DIFLAG_NODUMP)
-		flags |= FS_NODUMP_FL;
-	if (di_flags2 & XFS_DIFLAG2_DAX) {
-		flags |= FS_DAX_FL;
-	}
-	return flags;
-}
-
 static void
 xfs_fill_fsxattr(
 	struct xfs_inode	*ip,
-	bool			attr,
-	struct fsxattr		*fa)
+	int			whichfork,
+	struct fileattr		*fa)
 {
-	struct xfs_ifork	*ifp = attr ? ip->i_afp : &ip->i_df;
+	struct xfs_ifork	*ifp = XFS_IFORK_PTR(ip, whichfork);
 
-	simple_fill_fsxattr(fa, xfs_ip2xflags(ip));
+	fileattr_fill_xflags(fa, xfs_ip2xflags(ip));
 	fa->fsx_extsize = ip->i_d.di_extsize << ip->i_mount->m_sb.sb_blocklog;
 	fa->fsx_cowextsize = ip->i_d.di_cowextsize <<
 			ip->i_mount->m_sb.sb_blocklog;
@@ -1131,19 +1074,30 @@ xfs_fill_fsxattr(
 }
 
 STATIC int
-xfs_ioc_fsgetxattr(
+xfs_ioc_fsgetxattra(
 	xfs_inode_t		*ip,
-	int			attr,
 	void			__user *arg)
 {
-	struct fsxattr		fa;
+	struct fileattr		fa;
 
 	xfs_ilock(ip, XFS_ILOCK_SHARED);
-	xfs_fill_fsxattr(ip, attr, &fa);
+	xfs_fill_fsxattr(ip, XFS_ATTR_FORK, &fa);
+	xfs_iunlock(ip, XFS_ILOCK_SHARED);
+
+	return copy_fsxattr_to_user(&fa, arg);
+}
+
+int
+xfs_fileattr_get(
+	struct dentry		*dentry,
+	struct fileattr		*fa)
+{
+	struct xfs_inode	*ip = XFS_I(d_inode(dentry));
+
+	xfs_ilock(ip, XFS_ILOCK_SHARED);
+	xfs_fill_fsxattr(ip, XFS_DATA_FORK, fa);
 	xfs_iunlock(ip, XFS_ILOCK_SHARED);
 
-	if (copy_to_user(arg, &fa, sizeof(fa)))
-		return -EFAULT;
 	return 0;
 }
 
@@ -1210,7 +1164,7 @@ static int
 xfs_ioctl_setattr_xflags(
 	struct xfs_trans	*tp,
 	struct xfs_inode	*ip,
-	struct fsxattr		*fa)
+	struct fileattr		*fa)
 {
 	struct xfs_mount	*mp = ip->i_mount;
 	uint64_t		di_flags2;
@@ -1253,7 +1207,7 @@ xfs_ioctl_setattr_xflags(
 static void
 xfs_ioctl_setattr_prepare_dax(
 	struct xfs_inode	*ip,
-	struct fsxattr		*fa)
+	struct fileattr		*fa)
 {
 	struct xfs_mount	*mp = ip->i_mount;
 	struct inode            *inode = VFS_I(ip);
@@ -1280,10 +1234,9 @@ xfs_ioctl_setattr_prepare_dax(
  */
 static struct xfs_trans *
 xfs_ioctl_setattr_get_trans(
-	struct file		*file,
+	struct xfs_inode	*ip,
 	struct xfs_dquot	*pdqp)
 {
-	struct xfs_inode	*ip = XFS_I(file_inode(file));
 	struct xfs_mount	*mp = ip->i_mount;
 	struct xfs_trans	*tp;
 	int			error = -EROFS;
@@ -1299,24 +1252,11 @@ xfs_ioctl_setattr_get_trans(
 	if (error)
 		goto out_error;
 
-	/*
-	 * CAP_FOWNER overrides the following restrictions:
-	 *
-	 * The user ID of the calling process must be equal to the file owner
-	 * ID, except in cases where the CAP_FSETID capability is applicable.
-	 */
-	if (!inode_owner_or_capable(file_mnt_user_ns(file), VFS_I(ip))) {
-		error = -EPERM;
-		goto out_cancel;
-	}
-
 	if (mp->m_flags & XFS_MOUNT_WSYNC)
 		xfs_trans_set_sync(tp);
 
 	return tp;
 
-out_cancel:
-	xfs_trans_cancel(tp);
 out_error:
 	return ERR_PTR(error);
 }
@@ -1340,12 +1280,15 @@ xfs_ioctl_setattr_get_trans(
 static int
 xfs_ioctl_setattr_check_extsize(
 	struct xfs_inode	*ip,
-	struct fsxattr		*fa)
+	struct fileattr		*fa)
 {
 	struct xfs_mount	*mp = ip->i_mount;
 	xfs_extlen_t		size;
 	xfs_fsblock_t		extsize_fsb;
 
+	if (!fa->fsx_valid)
+		return 0;
+
 	if (S_ISREG(VFS_I(ip)->i_mode) && ip->i_df.if_nextents &&
 	    ((ip->i_d.di_extsize << mp->m_sb.sb_blocklog) != fa->fsx_extsize))
 		return -EINVAL;
@@ -1390,12 +1333,15 @@ xfs_ioctl_setattr_check_extsize(
 static int
 xfs_ioctl_setattr_check_cowextsize(
 	struct xfs_inode	*ip,
-	struct fsxattr		*fa)
+	struct fileattr		*fa)
 {
 	struct xfs_mount	*mp = ip->i_mount;
 	xfs_extlen_t		size;
 	xfs_fsblock_t		cowextsize_fsb;
 
+	if (!fa->fsx_valid)
+		return 0;
+
 	if (!(fa->fsx_xflags & FS_XFLAG_COWEXTSIZE))
 		return 0;
 
@@ -1422,8 +1368,11 @@ xfs_ioctl_setattr_check_cowextsize(
 static int
 xfs_ioctl_setattr_check_projid(
 	struct xfs_inode	*ip,
-	struct fsxattr		*fa)
+	struct fileattr		*fa)
 {
+	if (!fa->fsx_valid)
+		return 0;
+
 	/* Disallow 32bit project ids if projid32bit feature is not enabled. */
 	if (fa->fsx_projid > (uint16_t)-1 &&
 	    !xfs_sb_version_hasprojid32bit(&ip->i_mount->m_sb))
@@ -1431,14 +1380,13 @@ xfs_ioctl_setattr_check_projid(
 	return 0;
 }
 
-STATIC int
-xfs_ioctl_setattr(
-	struct file		*file,
-	struct fsxattr		*fa)
+int
+xfs_fileattr_set(
+	struct user_namespace	*mnt_userns,
+	struct dentry		*dentry,
+	struct fileattr		*fa)
 {
-	struct user_namespace	*mnt_userns = file_mnt_user_ns(file);
-	struct xfs_inode	*ip = XFS_I(file_inode(file));
-	struct fsxattr		old_fa;
+	struct xfs_inode	*ip = XFS_I(d_inode(dentry));
 	struct xfs_mount	*mp = ip->i_mount;
 	struct xfs_trans	*tp;
 	struct xfs_dquot	*pdqp = NULL;
@@ -1447,6 +1395,13 @@ xfs_ioctl_setattr(
 
 	trace_xfs_ioctl_setattr(ip);
 
+	if (!fa->fsx_valid) {
+		if (fa->flags & ~(FS_IMMUTABLE_FL | FS_APPEND_FL |
+				  FS_NOATIME_FL | FS_NODUMP_FL |
+				  FS_SYNC_FL | FS_DAX_FL | FS_PROJINHERIT_FL))
+			return -EOPNOTSUPP;
+	}
+
 	error = xfs_ioctl_setattr_check_projid(ip, fa);
 	if (error)
 		return error;
@@ -1459,7 +1414,7 @@ xfs_ioctl_setattr(
 	 * If the IDs do change before we take the ilock, we're covered
 	 * because the i_*dquot fields will get updated anyway.
 	 */
-	if (XFS_IS_QUOTA_ON(mp)) {
+	if (fa->fsx_valid && XFS_IS_QUOTA_ON(mp)) {
 		error = xfs_qm_vop_dqalloc(ip, VFS_I(ip)->i_uid,
 				VFS_I(ip)->i_gid, fa->fsx_projid,
 				XFS_QMOPT_PQUOTA, NULL, NULL, &pdqp);
@@ -1469,17 +1424,12 @@ xfs_ioctl_setattr(
 
 	xfs_ioctl_setattr_prepare_dax(ip, fa);
 
-	tp = xfs_ioctl_setattr_get_trans(file, pdqp);
+	tp = xfs_ioctl_setattr_get_trans(ip, pdqp);
 	if (IS_ERR(tp)) {
 		error = PTR_ERR(tp);
 		goto error_free_dquots;
 	}
 
-	xfs_fill_fsxattr(ip, false, &old_fa);
-	error = vfs_ioc_fssetxattr_check(VFS_I(ip), &old_fa, fa);
-	if (error)
-		goto error_trans_cancel;
-
 	error = xfs_ioctl_setattr_check_extsize(ip, fa);
 	if (error)
 		goto error_trans_cancel;
@@ -1492,6 +1442,8 @@ xfs_ioctl_setattr(
 	if (error)
 		goto error_trans_cancel;
 
+	if (!fa->fsx_valid)
+		goto skip_xattr;
 	/*
 	 * Change file ownership.  Must be the owner or privileged.  CAP_FSETID
 	 * overrides the following restrictions:
@@ -1529,6 +1481,7 @@ xfs_ioctl_setattr(
 	else
 		ip->i_d.di_cowextsize = 0;
 
+skip_xattr:
 	error = xfs_trans_commit(tp);
 
 	/*
@@ -1546,91 +1499,6 @@ xfs_ioctl_setattr(
 	return error;
 }
 
-STATIC int
-xfs_ioc_fssetxattr(
-	struct file		*filp,
-	void			__user *arg)
-{
-	struct fsxattr		fa;
-	int error;
-
-	if (copy_from_user(&fa, arg, sizeof(fa)))
-		return -EFAULT;
-
-	error = mnt_want_write_file(filp);
-	if (error)
-		return error;
-	error = xfs_ioctl_setattr(filp, &fa);
-	mnt_drop_write_file(filp);
-	return error;
-}
-
-STATIC int
-xfs_ioc_getxflags(
-	xfs_inode_t		*ip,
-	void			__user *arg)
-{
-	unsigned int		flags;
-
-	flags = xfs_di2lxflags(ip->i_d.di_flags, ip->i_d.di_flags2);
-	if (copy_to_user(arg, &flags, sizeof(flags)))
-		return -EFAULT;
-	return 0;
-}
-
-STATIC int
-xfs_ioc_setxflags(
-	struct xfs_inode	*ip,
-	struct file		*filp,
-	void			__user *arg)
-{
-	struct xfs_trans	*tp;
-	struct fsxattr		fa;
-	struct fsxattr		old_fa;
-	unsigned int		flags;
-	int			error;
-
-	if (copy_from_user(&flags, arg, sizeof(flags)))
-		return -EFAULT;
-
-	if (flags & ~(FS_IMMUTABLE_FL | FS_APPEND_FL | \
-		      FS_NOATIME_FL | FS_NODUMP_FL | \
-		      FS_SYNC_FL | FS_DAX_FL))
-		return -EOPNOTSUPP;
-
-	fa.fsx_xflags = xfs_merge_ioc_xflags(flags, xfs_ip2xflags(ip));
-
-	error = mnt_want_write_file(filp);
-	if (error)
-		return error;
-
-	xfs_ioctl_setattr_prepare_dax(ip, &fa);
-
-	tp = xfs_ioctl_setattr_get_trans(filp, NULL);
-	if (IS_ERR(tp)) {
-		error = PTR_ERR(tp);
-		goto out_drop_write;
-	}
-
-	xfs_fill_fsxattr(ip, false, &old_fa);
-	error = vfs_ioc_fssetxattr_check(VFS_I(ip), &old_fa, &fa);
-	if (error) {
-		xfs_trans_cancel(tp);
-		goto out_drop_write;
-	}
-
-	error = xfs_ioctl_setattr_xflags(tp, ip, &fa);
-	if (error) {
-		xfs_trans_cancel(tp);
-		goto out_drop_write;
-	}
-
-	error = xfs_trans_commit(tp);
-out_drop_write:
-	mnt_drop_write_file(filp);
-	return error;
-}
-
 static bool
 xfs_getbmap_format(
 	struct kgetbmap		*p,
@@ -2137,16 +2005,8 @@ xfs_file_ioctl(
 	case XFS_IOC_GETVERSION:
 		return put_user(inode->i_generation, (int __user *)arg);
 
-	case XFS_IOC_FSGETXATTR:
-		return xfs_ioc_fsgetxattr(ip, 0, arg);
 	case XFS_IOC_FSGETXATTRA:
-		return xfs_ioc_fsgetxattr(ip, 1, arg);
-	case XFS_IOC_FSSETXATTR:
-		return xfs_ioc_fssetxattr(filp, arg);
-	case XFS_IOC_GETXFLAGS:
-		return xfs_ioc_getxflags(ip, arg);
-	case XFS_IOC_SETXFLAGS:
-		return xfs_ioc_setxflags(ip, filp, arg);
+		return xfs_ioc_fsgetxattra(ip, arg);
 
 	case XFS_IOC_GETBMAP:
 	case XFS_IOC_GETBMAPA:
diff --git a/fs/xfs/xfs_ioctl.h b/fs/xfs/xfs_ioctl.h
index bab6a5a92407..28453a6d4461 100644
--- a/fs/xfs/xfs_ioctl.h
+++ b/fs/xfs/xfs_ioctl.h
@@ -47,6 +47,17 @@ xfs_handle_to_dentry(
 	void __user		*uhandle,
 	u32			hlen);
 
+extern int
+xfs_fileattr_get(
+	struct dentry		*dentry,
+	struct fileattr		*fa);
+
+extern int
+xfs_fileattr_set(
+	struct user_namespace	*mnt_userns,
+	struct dentry		*dentry,
+	struct fileattr		*fa);
+
 extern long
 xfs_file_ioctl(
 	struct file		*filp,
diff --git a/fs/xfs/xfs_ioctl32.c b/fs/xfs/xfs_ioctl32.c
index 33c09ec8e6c0..e6506773ba55 100644
--- a/fs/xfs/xfs_ioctl32.c
+++ b/fs/xfs/xfs_ioctl32.c
@@ -484,8 +484,6 @@ xfs_file_compat_ioctl(
 	}
 #endif
 	/* long changes size, but xfs only copiese out 32 bits */
-	case XFS_IOC_GETXFLAGS_32:
-	case XFS_IOC_SETXFLAGS_32:
 	case XFS_IOC_GETVERSION_32:
 		cmd = _NATIVE_IOC(cmd, long);
 		return xfs_file_ioctl(filp, cmd, p);
diff --git a/fs/xfs/xfs_ioctl32.h b/fs/xfs/xfs_ioctl32.h
index 053de7d894cd..9929482bf358 100644
--- a/fs/xfs/xfs_ioctl32.h
+++ b/fs/xfs/xfs_ioctl32.h
@@ -17,8 +17,6 @@
  */
 
 /* stock kernel-level ioctls we support */
-#define XFS_IOC_GETXFLAGS_32	FS_IOC32_GETFLAGS
-#define XFS_IOC_SETXFLAGS_32	FS_IOC32_SETFLAGS
 #define XFS_IOC_GETVERSION_32	FS_IOC32_GETVERSION
 
 /*
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index 66ebccb5a6ff..e1f749b711f8 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -21,6 +21,7 @@
 #include "xfs_dir2.h"
 #include "xfs_iomap.h"
 #include "xfs_error.h"
+#include "xfs_ioctl.h"
 
 #include <linux/posix_acl.h>
 #include <linux/security.h>
@@ -1152,6 +1153,8 @@ static const struct inode_operations xfs_inode_operations = {
 	.listxattr		= xfs_vn_listxattr,
 	.fiemap			= xfs_vn_fiemap,
 	.update_time		= xfs_vn_update_time,
+	.fileattr_get		= xfs_fileattr_get,
+	.fileattr_set		= xfs_fileattr_set,
 };
 
 static const struct inode_operations xfs_dir_inode_operations = {
@@ -1177,6 +1180,8 @@ static const struct inode_operations xfs_dir_inode_operations = {
 	.listxattr		= xfs_vn_listxattr,
 	.update_time		= xfs_vn_update_time,
 	.tmpfile		= xfs_vn_tmpfile,
+	.fileattr_get		= xfs_fileattr_get,
+	.fileattr_set		= xfs_fileattr_set,
 };
 
 static const struct inode_operations xfs_dir_ci_inode_operations = {
@@ -1202,6 +1207,8 @@ static const struct inode_operations xfs_dir_ci_inode_operations = {
 	.listxattr		= xfs_vn_listxattr,
 	.update_time		= xfs_vn_update_time,
 	.tmpfile		= xfs_vn_tmpfile,
+	.fileattr_get		= xfs_fileattr_get,
+	.fileattr_set		= xfs_fileattr_set,
 };
 
 static const struct inode_operations xfs_symlink_inode_operations = {
-- 
2.30.2

