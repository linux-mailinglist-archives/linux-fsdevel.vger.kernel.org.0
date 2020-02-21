Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7BA2166BC7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2020 01:42:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729651AbgBUAlr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Feb 2020 19:41:47 -0500
Received: from mga06.intel.com ([134.134.136.31]:33770 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729633AbgBUAlq (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Feb 2020 19:41:46 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Feb 2020 16:41:45 -0800
X-IronPort-AV: E=Sophos;i="5.70,466,1574150400"; 
   d="scan'208";a="229666999"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.157])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Feb 2020 16:41:44 -0800
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
Subject: [PATCH V4 12/13] fs/xfs: Remove xfs_diflags_to_linux()
Date:   Thu, 20 Feb 2020 16:41:33 -0800
Message-Id: <20200221004134.30599-13-ira.weiny@intel.com>
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

The functionality in xfs_diflags_to_linux() is now identical to
xfs_diflags_to_iflags().

Remove xfs_diflags_to_linux() and call xfs_diflags_to_iflags() directly.

While we are here simplify xfs_diflags_to_iflags() to take just struct
xfs_inode.

And use xfs_ip2xflags() to ensure future diflags are included correctly.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 fs/xfs/xfs_inode.h |  2 +-
 fs/xfs/xfs_ioctl.c | 32 +-------------------------------
 fs/xfs/xfs_iops.c  | 29 ++++++++++++++++++-----------
 3 files changed, 20 insertions(+), 43 deletions(-)

diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
index 12aa02461ee1..2644f8239633 100644
--- a/fs/xfs/xfs_inode.h
+++ b/fs/xfs/xfs_inode.h
@@ -470,7 +470,7 @@ int	xfs_break_layouts(struct inode *inode, uint *iolock,
 extern void xfs_setup_inode(struct xfs_inode *ip);
 extern void xfs_setup_iops(struct xfs_inode *ip);
 extern void xfs_setup_a_ops(struct xfs_inode *ip);
-extern bool xfs_inode_enable_dax(struct xfs_inode *ip);
+extern void xfs_diflags_to_iflags(struct xfs_inode *ip);
 
 /*
  * When setting up a newly allocated inode, we need to call
diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
index 42a1639c974f..3ac4ab94e21a 100644
--- a/fs/xfs/xfs_ioctl.c
+++ b/fs/xfs/xfs_ioctl.c
@@ -1100,36 +1100,6 @@ xfs_flags2diflags2(
 	return di_flags2;
 }
 
-STATIC void
-xfs_diflags_to_linux(
-	struct xfs_inode	*ip)
-{
-	struct inode		*inode = VFS_I(ip);
-	unsigned int		xflags = xfs_ip2xflags(ip);
-
-	if (xflags & FS_XFLAG_IMMUTABLE)
-		inode->i_flags |= S_IMMUTABLE;
-	else
-		inode->i_flags &= ~S_IMMUTABLE;
-	if (xflags & FS_XFLAG_APPEND)
-		inode->i_flags |= S_APPEND;
-	else
-		inode->i_flags &= ~S_APPEND;
-	if (xflags & FS_XFLAG_SYNC)
-		inode->i_flags |= S_SYNC;
-	else
-		inode->i_flags &= ~S_SYNC;
-	if (xflags & FS_XFLAG_NOATIME)
-		inode->i_flags |= S_NOATIME;
-	else
-		inode->i_flags &= ~S_NOATIME;
-
-	if (xfs_inode_enable_dax(ip))
-		inode->i_flags |= S_DAX;
-	else
-		inode->i_flags &= ~S_DAX;
-}
-
 static int
 xfs_ioctl_setattr_xflags(
 	struct xfs_trans	*tp,
@@ -1167,7 +1137,7 @@ xfs_ioctl_setattr_xflags(
 	ip->i_d.di_flags = xfs_flags2diflags(ip, fa->fsx_xflags);
 	ip->i_d.di_flags2 = di_flags2;
 
-	xfs_diflags_to_linux(ip);
+	xfs_diflags_to_iflags(ip);
 	xfs_trans_ichgtime(tp, ip, XFS_ICHGTIME_CHG);
 	xfs_trans_log_inode(tp, ip, XFS_ILOG_CORE);
 	XFS_STATS_INC(mp, xs_ig_attrchg);
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index 8f023be39705..c74a48f810f3 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -1273,26 +1273,33 @@ xfs_inode_enable_dax(
 	return false;
 }
 
-STATIC void
+void
 xfs_diflags_to_iflags(
-	struct inode		*inode,
 	struct xfs_inode	*ip)
 {
-	uint16_t		flags = ip->i_d.di_flags;
-
-	inode->i_flags &= ~(S_IMMUTABLE | S_APPEND | S_SYNC |
-			    S_NOATIME | S_DAX);
+	struct inode		*inode = VFS_I(ip);
+	uint16_t		diflags = xfs_ip2xflags(ip);
 
-	if (flags & XFS_DIFLAG_IMMUTABLE)
+	if (diflags & FS_XFLAG_IMMUTABLE)
 		inode->i_flags |= S_IMMUTABLE;
-	if (flags & XFS_DIFLAG_APPEND)
+	else
+		inode->i_flags &= ~S_IMMUTABLE;
+	if (diflags & FS_XFLAG_APPEND)
 		inode->i_flags |= S_APPEND;
-	if (flags & XFS_DIFLAG_SYNC)
+	else
+		inode->i_flags &= ~S_APPEND;
+	if (diflags & FS_XFLAG_SYNC)
 		inode->i_flags |= S_SYNC;
-	if (flags & XFS_DIFLAG_NOATIME)
+	else
+		inode->i_flags &= ~S_SYNC;
+	if (diflags & FS_XFLAG_NOATIME)
 		inode->i_flags |= S_NOATIME;
+	else
+		inode->i_flags &= ~S_NOATIME;
 	if (xfs_inode_enable_dax(ip))
 		inode->i_flags |= S_DAX;
+	else
+		inode->i_flags &= ~S_DAX;
 }
 
 /*
@@ -1321,7 +1328,7 @@ xfs_setup_inode(
 	inode->i_gid    = xfs_gid_to_kgid(ip->i_d.di_gid);
 
 	i_size_write(inode, ip->i_d.di_size);
-	xfs_diflags_to_iflags(inode, ip);
+	xfs_diflags_to_iflags(ip);
 
 	if (S_ISDIR(inode->i_mode)) {
 		/*
-- 
2.21.0

