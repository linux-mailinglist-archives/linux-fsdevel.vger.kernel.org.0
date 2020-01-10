Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C29B2137725
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2020 20:31:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729036AbgAJTaR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Jan 2020 14:30:17 -0500
Received: from mga09.intel.com ([134.134.136.24]:22315 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728977AbgAJTaP (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Jan 2020 14:30:15 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jan 2020 11:30:15 -0800
X-IronPort-AV: E=Sophos;i="5.69,418,1571727600"; 
   d="scan'208";a="218160906"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.157])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jan 2020 11:30:14 -0800
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
Subject: [RFC PATCH V2 12/12] fs/xfs: Allow toggle of effective DAX flag
Date:   Fri, 10 Jan 2020 11:29:42 -0800
Message-Id: <20200110192942.25021-13-ira.weiny@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200110192942.25021-1-ira.weiny@intel.com>
References: <20200110192942.25021-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

Now that locking of the inode is in place we can allow a mode change
while under the new lock.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 fs/xfs/xfs_inode.h |  1 +
 fs/xfs/xfs_ioctl.c |  9 ++++++---
 fs/xfs/xfs_iops.c  | 15 +++++++++++----
 3 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
index 693ca66bd89b..b0d2e7da88c6 100644
--- a/fs/xfs/xfs_inode.h
+++ b/fs/xfs/xfs_inode.h
@@ -474,6 +474,7 @@ int	xfs_break_layouts(struct inode *inode, uint *iolock,
 /* from xfs_iops.c */
 extern void xfs_setup_inode(struct xfs_inode *ip);
 extern void xfs_setup_iops(struct xfs_inode *ip);
+extern void xfs_setup_a_ops(struct xfs_inode *ip);
 
 /*
  * When setting up a newly allocated inode, we need to call
diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
index 9a35bf83eaa1..e07559bf70a9 100644
--- a/fs/xfs/xfs_ioctl.c
+++ b/fs/xfs/xfs_ioctl.c
@@ -1109,12 +1109,11 @@ xfs_diflags_to_linux(
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
@@ -1191,7 +1190,7 @@ xfs_ioctl_setattr_dax_invalidate(
 	if (S_ISDIR(inode->i_mode))
 		return 0;
 
-	flags = XFS_MMAPLOCK_EXCL | XFS_IOLOCK_EXCL;
+	flags = XFS_MMAPLOCK_EXCL | XFS_IOLOCK_EXCL | XFS_DAX_EXCL;
 
 	/* lock, flush and invalidate mapping in preparation for flag change */
 	xfs_ilock(ip, flags);
@@ -1512,6 +1511,8 @@ xfs_ioctl_setattr(
 	else
 		ip->i_d.di_cowextsize = 0;
 
+	xfs_setup_a_ops(ip);
+
 	code = xfs_trans_commit(tp);
 
 	/*
@@ -1621,6 +1622,8 @@ xfs_ioc_setxflags(
 		goto out_drop_write;
 	}
 
+	xfs_setup_a_ops(ip);
+
 	error = xfs_trans_commit(tp);
 out_drop_write:
 	mnt_drop_write_file(filp);
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index a34b04e8ac9c..c70164a0df97 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -1386,6 +1386,16 @@ xfs_setup_inode(
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
@@ -1396,10 +1406,7 @@ xfs_setup_iops(
 	case S_IFREG:
 		inode->i_op = &xfs_reg_inode_operations;
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

