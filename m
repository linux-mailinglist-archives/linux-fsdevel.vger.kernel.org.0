Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41D96166BCA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2020 01:42:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729642AbgBUAlr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Feb 2020 19:41:47 -0500
Received: from mga03.intel.com ([134.134.136.65]:42432 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729631AbgBUAlq (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Feb 2020 19:41:46 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Feb 2020 16:41:44 -0800
X-IronPort-AV: E=Sophos;i="5.70,466,1574150400"; 
   d="scan'208";a="349277198"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.157])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Feb 2020 16:41:44 -0800
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
Subject: [PATCH V4 11/13] fs/xfs: Allow toggle of effective DAX flag
Date:   Thu, 20 Feb 2020 16:41:32 -0800
Message-Id: <20200221004134.30599-12-ira.weiny@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200221004134.30599-1-ira.weiny@intel.com>
References: <20200221004134.30599-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

Now that locking of the inode aops are in place we can allow a DAX state
change.

Also use the new xfs_inode_enable_dax() to set IS_DAX() as needed and
update the aops vector after the enabled state change.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes from V3:
	Remove static branch stuff.
	Fix bugs found by Jeff by using xfs_inode_enable_dax()
	Condition xfs_ioctl_setattr_dax_invalidate() on CONFIG_FS_DAX

Changes from V2:
	Add in lock_dax_state_static_key static branch enabling.
	Rebase updates
---
 fs/xfs/xfs_inode.h |  2 ++
 fs/xfs/xfs_ioctl.c | 24 ++++++++++++++++++++----
 fs/xfs/xfs_iops.c  | 17 ++++++++++++-----
 3 files changed, 34 insertions(+), 9 deletions(-)

diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
index 25fe20740bf7..12aa02461ee1 100644
--- a/fs/xfs/xfs_inode.h
+++ b/fs/xfs/xfs_inode.h
@@ -469,6 +469,8 @@ int	xfs_break_layouts(struct inode *inode, uint *iolock,
 /* from xfs_iops.c */
 extern void xfs_setup_inode(struct xfs_inode *ip);
 extern void xfs_setup_iops(struct xfs_inode *ip);
+extern void xfs_setup_a_ops(struct xfs_inode *ip);
+extern bool xfs_inode_enable_dax(struct xfs_inode *ip);
 
 /*
  * When setting up a newly allocated inode, we need to call
diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
index 321f7789b667..42a1639c974f 100644
--- a/fs/xfs/xfs_ioctl.c
+++ b/fs/xfs/xfs_ioctl.c
@@ -1123,12 +1123,11 @@ xfs_diflags_to_linux(
 		inode->i_flags |= S_NOATIME;
 	else
 		inode->i_flags &= ~S_NOATIME;
-#if 0	/* disabled until the flag switching races are sorted out */
-	if (xflags & FS_XFLAG_DAX)
+
+	if (xfs_inode_enable_dax(ip))
 		inode->i_flags |= S_DAX;
 	else
 		inode->i_flags &= ~S_DAX;
-#endif
 }
 
 static int
@@ -1183,6 +1182,7 @@ xfs_ioctl_setattr_xflags(
  * so that the cache invalidation is atomic with respect to the DAX flag
  * manipulation.
  */
+#if defined(CONFIG_FS_DAX)
 static int
 xfs_ioctl_setattr_dax_invalidate(
 	struct xfs_inode	*ip,
@@ -1205,7 +1205,7 @@ xfs_ioctl_setattr_dax_invalidate(
 	if (S_ISDIR(inode->i_mode))
 		return 0;
 
-	flags = XFS_MMAPLOCK_EXCL | XFS_IOLOCK_EXCL;
+	flags = XFS_MMAPLOCK_EXCL | XFS_IOLOCK_EXCL | XFS_DAX_EXCL;
 
 	/* lock, flush and invalidate mapping in preparation for flag change */
 	xfs_ilock(ip, flags);
@@ -1233,6 +1233,16 @@ xfs_ioctl_setattr_dax_invalidate(
 	return error;
 
 }
+#else /* !CONFIG_FS_DAX */
+static int
+xfs_ioctl_setattr_dax_invalidate(
+	struct xfs_inode	*ip,
+	struct fsxattr		*fa,
+	int			*join_flags)
+{
+	return 0;
+}
+#endif
 
 /*
  * Set up the transaction structure for the setattr operation, checking that we
@@ -1520,6 +1530,9 @@ xfs_ioctl_setattr(
 	else
 		ip->i_d.di_cowextsize = 0;
 
+	if (join_flags & XFS_DAX_EXCL)
+		xfs_setup_a_ops(ip);
+
 	code = xfs_trans_commit(tp);
 
 	/*
@@ -1629,6 +1642,9 @@ xfs_ioc_setxflags(
 		goto out_drop_write;
 	}
 
+	if (join_flags & XFS_DAX_EXCL)
+		xfs_setup_a_ops(ip);
+
 	error = xfs_trans_commit(tp);
 out_drop_write:
 	mnt_drop_write_file(filp);
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index ff711efc5247..8f023be39705 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -1259,7 +1259,7 @@ xfs_inode_supports_dax(
 	return xfs_inode_buftarg(ip)->bt_daxdev != NULL;
 }
 
-STATIC bool
+bool
 xfs_inode_enable_dax(
 	struct xfs_inode *ip)
 {
@@ -1355,6 +1355,16 @@ xfs_setup_inode(
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
@@ -1365,10 +1375,7 @@ xfs_setup_iops(
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
-- 
2.21.0

