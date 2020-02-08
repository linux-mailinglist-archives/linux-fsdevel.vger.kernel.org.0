Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6609715676E
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Feb 2020 20:35:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727692AbgBHTe7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 8 Feb 2020 14:34:59 -0500
Received: from mga03.intel.com ([134.134.136.65]:60930 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727597AbgBHTez (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 8 Feb 2020 14:34:55 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Feb 2020 11:34:54 -0800
X-IronPort-AV: E=Sophos;i="5.70,418,1574150400"; 
   d="scan'208";a="221147459"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.157])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Feb 2020 11:34:53 -0800
From:   ira.weiny@intel.com
To:     linux-kernel@vger.kernel.org
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 12/12] fs/xfs: Allow toggle of effective DAX flag
Date:   Sat,  8 Feb 2020 11:34:45 -0800
Message-Id: <20200208193445.27421-13-ira.weiny@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200208193445.27421-1-ira.weiny@intel.com>
References: <20200208193445.27421-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

Now that locking of the inode is in place we can allow a DAX state
change while under the new lock.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes from V2:
	Add in lock_dax_state_static_key static branch enabling.

 fs/xfs/xfs_inode.h |  1 +
 fs/xfs/xfs_ioctl.c | 15 ++++++++++++---
 fs/xfs/xfs_iops.c  | 15 +++++++++++----
 fs/xfs/xfs_super.c | 16 +++++++++-------
 4 files changed, 33 insertions(+), 14 deletions(-)

diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
index 25fe20740bf7..0064f8eef41d 100644
--- a/fs/xfs/xfs_inode.h
+++ b/fs/xfs/xfs_inode.h
@@ -469,6 +469,7 @@ int	xfs_break_layouts(struct inode *inode, uint *iolock,
 /* from xfs_iops.c */
 extern void xfs_setup_inode(struct xfs_inode *ip);
 extern void xfs_setup_iops(struct xfs_inode *ip);
+extern void xfs_setup_a_ops(struct xfs_inode *ip);
 
 /*
  * When setting up a newly allocated inode, we need to call
diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
index 0134c9e65efb..0736cf45223d 100644
--- a/fs/xfs/xfs_ioctl.c
+++ b/fs/xfs/xfs_ioctl.c
@@ -1123,12 +1123,11 @@ xfs_diflags_to_linux(
 		inode->i_flags |= S_NOATIME;
 	else
 		inode->i_flags &= ~S_NOATIME;
-#if 0	/* disabled until the flag switching races are sorted out */
 	if (xflags & FS_XFLAG_DAX)
 		inode->i_flags |= S_DAX;
 	else
 		inode->i_flags &= ~S_DAX;
-#endif
+
 }
 
 static int
@@ -1194,6 +1193,10 @@ xfs_ioctl_setattr_dax_invalidate(
 
 	*join_flags = 0;
 
+#if !defined(CONFIG_FS_DAX)
+	return -EINVAL;
+#endif
+
 	/* If the DAX state is not changing, we have nothing to do here. */
 	if ((fa->fsx_xflags & FS_XFLAG_DAX) &&
 	    (ip->i_d.di_flags2 & XFS_DIFLAG2_DAX))
@@ -1205,7 +1208,7 @@ xfs_ioctl_setattr_dax_invalidate(
 	if (S_ISDIR(inode->i_mode))
 		return 0;
 
-	flags = XFS_MMAPLOCK_EXCL | XFS_IOLOCK_EXCL;
+	flags = XFS_MMAPLOCK_EXCL | XFS_IOLOCK_EXCL | XFS_DAX_EXCL;
 
 	/* lock, flush and invalidate mapping in preparation for flag change */
 	xfs_ilock(ip, flags);
@@ -1526,6 +1529,9 @@ xfs_ioctl_setattr(
 	else
 		ip->i_d.di_cowextsize = 0;
 
+	if (join_flags & XFS_DAX_EXCL)
+		xfs_setup_a_ops(ip);
+
 	code = xfs_trans_commit(tp);
 
 	/*
@@ -1635,6 +1641,9 @@ xfs_ioc_setxflags(
 		goto out_drop_write;
 	}
 
+	if (join_flags & XFS_DAX_EXCL)
+		xfs_setup_a_ops(ip);
+
 	error = xfs_trans_commit(tp);
 out_drop_write:
 	mnt_drop_write_file(filp);
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index eebec159d873..15ef51c7f0b3 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -1366,6 +1366,16 @@ xfs_setup_inode(
 	}
 }
 
+void xfs_setup_a_ops(struct xfs_inode *ip)
+{
+	struct inode		*inode = &ip->i_vnode;
+
+	if (IS_DAX(inode))
+		inode->i_mapping->a_ops = &xfs_dax_aops;
+	else
+		inode->i_mapping->a_ops = &xfs_address_space_operations;
+}
+
 void
 xfs_setup_iops(
 	struct xfs_inode	*ip)
@@ -1376,10 +1386,7 @@ xfs_setup_iops(
 	case S_IFREG:
 		inode->i_op = &xfs_inode_operations;
 		inode->i_fop = &xfs_file_operations;
-		if (IS_DAX(inode))
-			inode->i_mapping->a_ops = &xfs_dax_aops;
-		else
-			inode->i_mapping->a_ops = &xfs_address_space_operations;
+		xfs_setup_a_ops(ip);
 		break;
 	case S_IFDIR:
 		if (xfs_sb_version_hasasciici(&XFS_M(inode->i_sb)->m_sb))
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index 2094386af8ac..af57fe07b56d 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -1332,6 +1332,7 @@ xfs_fc_fill_super(
 	struct xfs_mount	*mp = sb->s_fs_info;
 	struct inode		*root;
 	int			flags = 0, error;
+	bool                    rtdev_is_dax = false, datadev_is_dax;
 
 	mp->m_super = sb;
 
@@ -1437,17 +1438,18 @@ xfs_fc_fill_super(
 	if (XFS_SB_VERSION_NUM(&mp->m_sb) == XFS_SB_VERSION_5)
 		sb->s_flags |= SB_I_VERSION;
 
-	if (mp->m_flags & XFS_MOUNT_DAX) {
-		bool rtdev_is_dax = false, datadev_is_dax;
+	datadev_is_dax = bdev_dax_supported(mp->m_ddev_targp->bt_bdev,
+					    sb->s_blocksize);
+	if (mp->m_rtdev_targp)
+		rtdev_is_dax = bdev_dax_supported(mp->m_rtdev_targp->bt_bdev,
+						  sb->s_blocksize);
+	if (rtdev_is_dax || datadev_is_dax)
+		enable_dax_state_static_branch();
 
+	if (mp->m_flags & XFS_MOUNT_DAX) {
 		xfs_warn(mp,
 		"DAX enabled. Warning: EXPERIMENTAL, use at your own risk");
 
-		datadev_is_dax = bdev_dax_supported(mp->m_ddev_targp->bt_bdev,
-			sb->s_blocksize);
-		if (mp->m_rtdev_targp)
-			rtdev_is_dax = bdev_dax_supported(
-				mp->m_rtdev_targp->bt_bdev, sb->s_blocksize);
 		if (!rtdev_is_dax && !datadev_is_dax) {
 			xfs_alert(mp,
 			"DAX unsupported by block device. Turning off DAX.");
-- 
2.21.0

