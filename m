Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 533B63447FF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Mar 2021 15:50:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231403AbhCVOuK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Mar 2021 10:50:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:23192 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231199AbhCVOtf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Mar 2021 10:49:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616424574;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e98FGcmKFjpFS3LKlPLNjfDTHU79Xr3bXL5xeBp/qmo=;
        b=HpvQq5HiGYJj0Z6msNszOfe8IlXSAQV1LIrP1iCAgx3OLEp9NzEVuChoe4kGuTR5HHOwf2
        XOorDq7GTmNc3efy3oesvOVhFQrLpieYi1HBVI/8wYPF6SWq5B6eANr0M9X8Qmyie12T8n
        tuwXQfvM5FE0NlJSPAK7DJxybKEXo0s=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-508-sqWfk7lPO4GpPEutBlGwSw-1; Mon, 22 Mar 2021 10:49:32 -0400
X-MC-Unique: sqWfk7lPO4GpPEutBlGwSw-1
Received: by mail-ed1-f70.google.com with SMTP id k8so27505692edn.19
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Mar 2021 07:49:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e98FGcmKFjpFS3LKlPLNjfDTHU79Xr3bXL5xeBp/qmo=;
        b=JQJDNXH1kYp96hUExqoXyF/8zW+7WasyaILPo6WRlpUzSXd2KtIcUgkemFonNSCrNv
         E/TAr58qm2EHlluGwiM+f+mi8HYh8u121BDjbfVRW8qm7xJgInObcV86XwAKWIAg0Osp
         0yhhOpGdpEmHdaGEWmDyPbSR8lvzpMalvODKwTpKtObDpuYwflxeFaaYfVO4I2Gnsabt
         Oye3bbBc4bF0aOVaPCI86F74puP9lNJsLsNF2l8P084TsxOOFFgA54xTjRk2cJylN1g6
         gi/mlYKMb4mGcp1fJomqzEwL8WR1vQkUUM6P5p1UCRVxftcMYUOEWJ87cmn9B0Ecs6OY
         OlYg==
X-Gm-Message-State: AOAM532y3wOBBljKAmfeaDSUfNrgu7utAjU1RJM7bbQCqFVB/Bos13SS
        PcYqu2We0d3CYQEzsl3x8QZqJ0oY1cnktDqaG20QYm8xBQ/hDjwz55sA5j2ve7yuFEkDOMhYJps
        L2TPTLC80BRyg4U7C8i0Hvdeul7fdHTjhpIRfL0WPsPE66DgaBDhI4/xAQzdFjeeYjRcmwU1ON6
        P+yg==
X-Received: by 2002:a17:906:1986:: with SMTP id g6mr60919ejd.533.1616424571114;
        Mon, 22 Mar 2021 07:49:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwAXI2VYef2kxQ4lof5soxYVswOdOeBgIuCE2WrYOl3yCTDlpFpigNLdmfeRxNoSwRwCfixRQ==
X-Received: by 2002:a17:906:1986:: with SMTP id g6mr60893ejd.533.1616424570846;
        Mon, 22 Mar 2021 07:49:30 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-86-101-169-67.catv.broadband.hu. [86.101.169.67])
        by smtp.gmail.com with ESMTPSA id r4sm9793117ejd.125.2021.03.22.07.49.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 07:49:30 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Al Viro <viro@ZenIV.linux.org.uk>, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J . Wong" <djwong@kernel.org>
Subject: [PATCH v2 10/18] xfs: convert to miscattr
Date:   Mon, 22 Mar 2021 15:49:08 +0100
Message-Id: <20210322144916.137245-11-mszeredi@redhat.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210322144916.137245-1-mszeredi@redhat.com>
References: <20210322144916.137245-1-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use the miscattr API to let the VFS handle locking, permission checking and
conversion.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Cc: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/libxfs/xfs_fs.h |   4 -
 fs/xfs/xfs_ioctl.c     | 316 ++++++++++++-----------------------------
 fs/xfs/xfs_ioctl.h     |  11 ++
 fs/xfs/xfs_ioctl32.c   |   2 -
 fs/xfs/xfs_ioctl32.h   |   2 -
 fs/xfs/xfs_iops.c      |   7 +
 6 files changed, 107 insertions(+), 235 deletions(-)

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
index 99dfe89a8d08..e27e3ff9a651 100644
--- a/fs/xfs/xfs_ioctl.c
+++ b/fs/xfs/xfs_ioctl.c
@@ -40,6 +40,7 @@
 
 #include <linux/mount.h>
 #include <linux/namei.h>
+#include <linux/miscattr.h>
 
 /*
  * xfs_find_handle maps from userspace xfs_fsop_handlereq structure to
@@ -1053,97 +1054,51 @@ xfs_ioc_ag_geometry(
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
 	bool			attr,
-	struct fsxattr		*fa)
+	struct miscattr		*ma)
 {
 	struct xfs_ifork	*ifp = attr ? ip->i_afp : &ip->i_df;
 
-	simple_fill_fsxattr(fa, xfs_ip2xflags(ip));
-	fa->fsx_extsize = ip->i_d.di_extsize << ip->i_mount->m_sb.sb_blocklog;
-	fa->fsx_cowextsize = ip->i_d.di_cowextsize <<
+	miscattr_fill_xflags(ma, xfs_ip2xflags(ip));
+	ma->flags &= ~FS_PROJINHERIT_FL; /* Accidental? */
+	ma->fsx_extsize = ip->i_d.di_extsize << ip->i_mount->m_sb.sb_blocklog;
+	ma->fsx_cowextsize = ip->i_d.di_cowextsize <<
 			ip->i_mount->m_sb.sb_blocklog;
-	fa->fsx_projid = ip->i_d.di_projid;
+	ma->fsx_projid = ip->i_d.di_projid;
 	if (ifp && (ifp->if_flags & XFS_IFEXTENTS))
-		fa->fsx_nextents = xfs_iext_count(ifp);
+		ma->fsx_nextents = xfs_iext_count(ifp);
 	else
-		fa->fsx_nextents = xfs_ifork_nextents(ifp);
+		ma->fsx_nextents = xfs_ifork_nextents(ifp);
 }
 
 STATIC int
-xfs_ioc_fsgetxattr(
+xfs_ioc_fsgetxattra(
 	xfs_inode_t		*ip,
-	int			attr,
 	void			__user *arg)
 {
-	struct fsxattr		fa;
+	struct miscattr		ma;
 
 	xfs_ilock(ip, XFS_ILOCK_SHARED);
-	xfs_fill_fsxattr(ip, attr, &fa);
+	xfs_fill_fsxattr(ip, true, &ma);
+	xfs_iunlock(ip, XFS_ILOCK_SHARED);
+
+	return fsxattr_copy_to_user(&ma, arg);
+}
+
+int
+xfs_miscattr_get(
+	struct dentry		*dentry,
+	struct miscattr		*ma)
+{
+	xfs_inode_t		*ip = XFS_I(d_inode(dentry));
+
+	xfs_ilock(ip, XFS_ILOCK_SHARED);
+	xfs_fill_fsxattr(ip, false, ma);
 	xfs_iunlock(ip, XFS_ILOCK_SHARED);
 
-	if (copy_to_user(arg, &fa, sizeof(fa)))
-		return -EFAULT;
 	return 0;
 }
 
@@ -1210,37 +1165,37 @@ static int
 xfs_ioctl_setattr_xflags(
 	struct xfs_trans	*tp,
 	struct xfs_inode	*ip,
-	struct fsxattr		*fa)
+	struct miscattr		*ma)
 {
 	struct xfs_mount	*mp = ip->i_mount;
 	uint64_t		di_flags2;
 
 	/* Can't change realtime flag if any extents are allocated. */
 	if ((ip->i_df.if_nextents || ip->i_delayed_blks) &&
-	    XFS_IS_REALTIME_INODE(ip) != (fa->fsx_xflags & FS_XFLAG_REALTIME))
+	    XFS_IS_REALTIME_INODE(ip) != (ma->fsx_xflags & FS_XFLAG_REALTIME))
 		return -EINVAL;
 
 	/* If realtime flag is set then must have realtime device */
-	if (fa->fsx_xflags & FS_XFLAG_REALTIME) {
+	if (ma->fsx_xflags & FS_XFLAG_REALTIME) {
 		if (mp->m_sb.sb_rblocks == 0 || mp->m_sb.sb_rextsize == 0 ||
 		    (ip->i_d.di_extsize % mp->m_sb.sb_rextsize))
 			return -EINVAL;
 	}
 
 	/* Clear reflink if we are actually able to set the rt flag. */
-	if ((fa->fsx_xflags & FS_XFLAG_REALTIME) && xfs_is_reflink_inode(ip))
+	if ((ma->fsx_xflags & FS_XFLAG_REALTIME) && xfs_is_reflink_inode(ip))
 		ip->i_d.di_flags2 &= ~XFS_DIFLAG2_REFLINK;
 
 	/* Don't allow us to set DAX mode for a reflinked file for now. */
-	if ((fa->fsx_xflags & FS_XFLAG_DAX) && xfs_is_reflink_inode(ip))
+	if ((ma->fsx_xflags & FS_XFLAG_DAX) && xfs_is_reflink_inode(ip))
 		return -EINVAL;
 
 	/* diflags2 only valid for v3 inodes. */
-	di_flags2 = xfs_flags2diflags2(ip, fa->fsx_xflags);
+	di_flags2 = xfs_flags2diflags2(ip, ma->fsx_xflags);
 	if (di_flags2 && !xfs_sb_version_has_v3inode(&mp->m_sb))
 		return -EINVAL;
 
-	ip->i_d.di_flags = xfs_flags2diflags(ip, fa->fsx_xflags);
+	ip->i_d.di_flags = xfs_flags2diflags(ip, ma->fsx_xflags);
 	ip->i_d.di_flags2 = di_flags2;
 
 	xfs_diflags_to_iflags(ip, false);
@@ -1253,7 +1208,7 @@ xfs_ioctl_setattr_xflags(
 static void
 xfs_ioctl_setattr_prepare_dax(
 	struct xfs_inode	*ip,
-	struct fsxattr		*fa)
+	struct miscattr		*ma)
 {
 	struct xfs_mount	*mp = ip->i_mount;
 	struct inode            *inode = VFS_I(ip);
@@ -1265,9 +1220,9 @@ xfs_ioctl_setattr_prepare_dax(
 	    (mp->m_flags & XFS_MOUNT_DAX_NEVER))
 		return;
 
-	if (((fa->fsx_xflags & FS_XFLAG_DAX) &&
+	if (((ma->fsx_xflags & FS_XFLAG_DAX) &&
 	    !(ip->i_d.di_flags2 & XFS_DIFLAG2_DAX)) ||
-	    (!(fa->fsx_xflags & FS_XFLAG_DAX) &&
+	    (!(ma->fsx_xflags & FS_XFLAG_DAX) &&
 	     (ip->i_d.di_flags2 & XFS_DIFLAG2_DAX)))
 		d_mark_dontcache(inode);
 }
@@ -1280,10 +1235,9 @@ xfs_ioctl_setattr_prepare_dax(
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
@@ -1299,24 +1253,11 @@ xfs_ioctl_setattr_get_trans(
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
@@ -1340,25 +1281,28 @@ xfs_ioctl_setattr_get_trans(
 static int
 xfs_ioctl_setattr_check_extsize(
 	struct xfs_inode	*ip,
-	struct fsxattr		*fa)
+	struct miscattr		*ma)
 {
 	struct xfs_mount	*mp = ip->i_mount;
 	xfs_extlen_t		size;
 	xfs_fsblock_t		extsize_fsb;
 
+	if (!ma->xattr_valid)
+		return 0;
+
 	if (S_ISREG(VFS_I(ip)->i_mode) && ip->i_df.if_nextents &&
-	    ((ip->i_d.di_extsize << mp->m_sb.sb_blocklog) != fa->fsx_extsize))
+	    ((ip->i_d.di_extsize << mp->m_sb.sb_blocklog) != ma->fsx_extsize))
 		return -EINVAL;
 
-	if (fa->fsx_extsize == 0)
+	if (ma->fsx_extsize == 0)
 		return 0;
 
-	extsize_fsb = XFS_B_TO_FSB(mp, fa->fsx_extsize);
+	extsize_fsb = XFS_B_TO_FSB(mp, ma->fsx_extsize);
 	if (extsize_fsb > MAXEXTLEN)
 		return -EINVAL;
 
 	if (XFS_IS_REALTIME_INODE(ip) ||
-	    (fa->fsx_xflags & FS_XFLAG_REALTIME)) {
+	    (ma->fsx_xflags & FS_XFLAG_REALTIME)) {
 		size = mp->m_sb.sb_rextsize << mp->m_sb.sb_blocklog;
 	} else {
 		size = mp->m_sb.sb_blocksize;
@@ -1366,7 +1310,7 @@ xfs_ioctl_setattr_check_extsize(
 			return -EINVAL;
 	}
 
-	if (fa->fsx_extsize % size)
+	if (ma->fsx_extsize % size)
 		return -EINVAL;
 
 	return 0;
@@ -1390,22 +1334,25 @@ xfs_ioctl_setattr_check_extsize(
 static int
 xfs_ioctl_setattr_check_cowextsize(
 	struct xfs_inode	*ip,
-	struct fsxattr		*fa)
+	struct miscattr		*ma)
 {
 	struct xfs_mount	*mp = ip->i_mount;
 	xfs_extlen_t		size;
 	xfs_fsblock_t		cowextsize_fsb;
 
-	if (!(fa->fsx_xflags & FS_XFLAG_COWEXTSIZE))
+	if (!ma->xattr_valid)
+		return 0;
+
+	if (!(ma->fsx_xflags & FS_XFLAG_COWEXTSIZE))
 		return 0;
 
 	if (!xfs_sb_version_hasreflink(&ip->i_mount->m_sb))
 		return -EINVAL;
 
-	if (fa->fsx_cowextsize == 0)
+	if (ma->fsx_cowextsize == 0)
 		return 0;
 
-	cowextsize_fsb = XFS_B_TO_FSB(mp, fa->fsx_cowextsize);
+	cowextsize_fsb = XFS_B_TO_FSB(mp, ma->fsx_cowextsize);
 	if (cowextsize_fsb > MAXEXTLEN)
 		return -EINVAL;
 
@@ -1413,7 +1360,7 @@ xfs_ioctl_setattr_check_cowextsize(
 	if (cowextsize_fsb > mp->m_sb.sb_agblocks / 2)
 		return -EINVAL;
 
-	if (fa->fsx_cowextsize % size)
+	if (ma->fsx_cowextsize % size)
 		return -EINVAL;
 
 	return 0;
@@ -1422,23 +1369,25 @@ xfs_ioctl_setattr_check_cowextsize(
 static int
 xfs_ioctl_setattr_check_projid(
 	struct xfs_inode	*ip,
-	struct fsxattr		*fa)
+	struct miscattr		*ma)
 {
+	if (!ma->xattr_valid)
+		return 0;
+
 	/* Disallow 32bit project ids if projid32bit feature is not enabled. */
-	if (fa->fsx_projid > (uint16_t)-1 &&
+	if (ma->fsx_projid > (uint16_t)-1 &&
 	    !xfs_sb_version_hasprojid32bit(&ip->i_mount->m_sb))
 		return -EINVAL;
 	return 0;
 }
 
-STATIC int
-xfs_ioctl_setattr(
-	struct file		*file,
-	struct fsxattr		*fa)
+int
+xfs_miscattr_set(
+	struct user_namespace	*mnt_userns,
+	struct dentry		*dentry,
+	struct miscattr		*ma)
 {
-	struct user_namespace	*mnt_userns = file_mnt_user_ns(file);
-	struct xfs_inode	*ip = XFS_I(file_inode(file));
-	struct fsxattr		old_fa;
+	xfs_inode_t		*ip = XFS_I(d_inode(dentry));
 	struct xfs_mount	*mp = ip->i_mount;
 	struct xfs_trans	*tp;
 	struct xfs_dquot	*pdqp = NULL;
@@ -1447,7 +1396,15 @@ xfs_ioctl_setattr(
 
 	trace_xfs_ioctl_setattr(ip);
 
-	error = xfs_ioctl_setattr_check_projid(ip, fa);
+	if (!ma->xattr_valid) {
+		/* FS_PROJINHERIT_FL not accepted, deliberate? */
+		if (ma->flags & ~(FS_IMMUTABLE_FL | FS_APPEND_FL |
+				  FS_NOATIME_FL | FS_NODUMP_FL |
+				  FS_SYNC_FL | FS_DAX_FL))
+			return -EOPNOTSUPP;
+	}
+
+	error = xfs_ioctl_setattr_check_projid(ip, ma);
 	if (error)
 		return error;
 
@@ -1459,39 +1416,36 @@ xfs_ioctl_setattr(
 	 * If the IDs do change before we take the ilock, we're covered
 	 * because the i_*dquot fields will get updated anyway.
 	 */
-	if (XFS_IS_QUOTA_ON(mp)) {
+	if (ma->xattr_valid && XFS_IS_QUOTA_ON(mp)) {
 		error = xfs_qm_vop_dqalloc(ip, VFS_I(ip)->i_uid,
-				VFS_I(ip)->i_gid, fa->fsx_projid,
+				VFS_I(ip)->i_gid, ma->fsx_projid,
 				XFS_QMOPT_PQUOTA, NULL, NULL, &pdqp);
 		if (error)
 			return error;
 	}
 
-	xfs_ioctl_setattr_prepare_dax(ip, fa);
+	xfs_ioctl_setattr_prepare_dax(ip, ma);
 
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
-	error = xfs_ioctl_setattr_check_extsize(ip, fa);
+	error = xfs_ioctl_setattr_check_extsize(ip, ma);
 	if (error)
 		goto error_trans_cancel;
 
-	error = xfs_ioctl_setattr_check_cowextsize(ip, fa);
+	error = xfs_ioctl_setattr_check_cowextsize(ip, ma);
 	if (error)
 		goto error_trans_cancel;
 
-	error = xfs_ioctl_setattr_xflags(tp, ip, fa);
+	error = xfs_ioctl_setattr_xflags(tp, ip, ma);
 	if (error)
 		goto error_trans_cancel;
 
+	if (!ma->xattr_valid)
+		goto skip_xattr;
 	/*
 	 * Change file ownership.  Must be the owner or privileged.  CAP_FSETID
 	 * overrides the following restrictions:
@@ -1505,12 +1459,12 @@ xfs_ioctl_setattr(
 		VFS_I(ip)->i_mode &= ~(S_ISUID|S_ISGID);
 
 	/* Change the ownerships and register project quota modifications */
-	if (ip->i_d.di_projid != fa->fsx_projid) {
+	if (ip->i_d.di_projid != ma->fsx_projid) {
 		if (XFS_IS_QUOTA_RUNNING(mp) && XFS_IS_PQUOTA_ON(mp)) {
 			olddquot = xfs_qm_vop_chown(tp, ip,
 						&ip->i_pdquot, pdqp);
 		}
-		ip->i_d.di_projid = fa->fsx_projid;
+		ip->i_d.di_projid = ma->fsx_projid;
 	}
 
 	/*
@@ -1519,16 +1473,17 @@ xfs_ioctl_setattr(
 	 * are set on the inode then unconditionally clear the extent size hint.
 	 */
 	if (ip->i_d.di_flags & (XFS_DIFLAG_EXTSIZE | XFS_DIFLAG_EXTSZINHERIT))
-		ip->i_d.di_extsize = fa->fsx_extsize >> mp->m_sb.sb_blocklog;
+		ip->i_d.di_extsize = ma->fsx_extsize >> mp->m_sb.sb_blocklog;
 	else
 		ip->i_d.di_extsize = 0;
 	if (xfs_sb_version_has_v3inode(&mp->m_sb) &&
 	    (ip->i_d.di_flags2 & XFS_DIFLAG2_COWEXTSIZE))
-		ip->i_d.di_cowextsize = fa->fsx_cowextsize >>
+		ip->i_d.di_cowextsize = ma->fsx_cowextsize >>
 				mp->m_sb.sb_blocklog;
 	else
 		ip->i_d.di_cowextsize = 0;
 
+skip_xattr:
 	error = xfs_trans_commit(tp);
 
 	/*
@@ -1546,91 +1501,6 @@ xfs_ioctl_setattr(
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
@@ -2137,16 +2007,8 @@ xfs_file_ioctl(
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
index bab6a5a92407..3cb4a9d8cde0 100644
--- a/fs/xfs/xfs_ioctl.h
+++ b/fs/xfs/xfs_ioctl.h
@@ -47,6 +47,17 @@ xfs_handle_to_dentry(
 	void __user		*uhandle,
 	u32			hlen);
 
+extern int
+xfs_miscattr_get(
+	struct dentry		*dentry,
+	struct miscattr		*ma);
+
+extern int
+xfs_miscattr_set(
+	struct user_namespace	*mnt_userns,
+	struct dentry		*dentry,
+	struct miscattr		*ma);
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
index 66ebccb5a6ff..124c6a9f3872 100644
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
+	.miscattr_get		= xfs_miscattr_get,
+	.miscattr_set		= xfs_miscattr_set,
 };
 
 static const struct inode_operations xfs_dir_inode_operations = {
@@ -1177,6 +1180,8 @@ static const struct inode_operations xfs_dir_inode_operations = {
 	.listxattr		= xfs_vn_listxattr,
 	.update_time		= xfs_vn_update_time,
 	.tmpfile		= xfs_vn_tmpfile,
+	.miscattr_get		= xfs_miscattr_get,
+	.miscattr_set		= xfs_miscattr_set,
 };
 
 static const struct inode_operations xfs_dir_ci_inode_operations = {
@@ -1202,6 +1207,8 @@ static const struct inode_operations xfs_dir_ci_inode_operations = {
 	.listxattr		= xfs_vn_listxattr,
 	.update_time		= xfs_vn_update_time,
 	.tmpfile		= xfs_vn_tmpfile,
+	.miscattr_get		= xfs_miscattr_get,
+	.miscattr_set		= xfs_miscattr_set,
 };
 
 static const struct inode_operations xfs_symlink_inode_operations = {
-- 
2.30.2

