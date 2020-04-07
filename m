Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 263541A13A2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Apr 2020 20:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbgDGSah (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Apr 2020 14:30:37 -0400
Received: from mga02.intel.com ([134.134.136.20]:42000 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726795AbgDGSaf (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Apr 2020 14:30:35 -0400
IronPort-SDR: fOtPLR3KxkZ7mH2BrtcPzlyBdJuDPT2jtULc5Zu0i9ELgOVUytzHOnQitItATNSJrOABYZvKlK
 g7kJZFGxVv9g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2020 11:30:32 -0700
IronPort-SDR: FXDrYDg+ZDGlqTiBRb1u1RvQYS+OkKAoxMO5j4g4Mhxub0XQwJ53GQTaVMFGcW361UyZEfZAY1
 U1y5ah+l8qdw==
X-IronPort-AV: E=Sophos;i="5.72,356,1580803200"; 
   d="scan'208";a="452554845"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2020 11:30:31 -0700
From:   ira.weiny@intel.com
To:     linux-kernel@vger.kernel.org
Cc:     Ira Weiny <ira.weiny@intel.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        Jeff Moyer <jmoyer@redhat.com>, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH V6 6/8] fs/xfs: Combine xfs_diflags_to_linux() and xfs_diflags_to_iflags()
Date:   Tue,  7 Apr 2020 11:29:56 -0700
Message-Id: <20200407182958.568475-7-ira.weiny@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200407182958.568475-1-ira.weiny@intel.com>
References: <20200407182958.568475-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

The functionality in xfs_diflags_to_linux() and xfs_diflags_to_iflags() are
nearly identical.  The only difference is that *_to_linux() is called after
inode setup and disallows changing the DAX flag.

Combining them can be done with a flag which indicates if this is the initial
setup to allow the DAX flag to be properly set only at init time.

So remove xfs_diflags_to_linux() and call the modified xfs_diflags_to_iflags()
directly.

While we are here simplify xfs_diflags_to_iflags() to take struct xfs_inode and
use xfs_ip2xflags() to ensure future diflags are included correctly.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes from V5:
	The functions are no longer identical so we can only combine
	them rather than deleting one completely.  This is reflected in
	the new init parameter.
---
 fs/xfs/xfs_inode.h |  1 +
 fs/xfs/xfs_ioctl.c | 33 +--------------------------------
 fs/xfs/xfs_iops.c  | 42 +++++++++++++++++++++++++++---------------
 3 files changed, 29 insertions(+), 47 deletions(-)

diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
index 492e53992fa9..e76ed9ca17f7 100644
--- a/fs/xfs/xfs_inode.h
+++ b/fs/xfs/xfs_inode.h
@@ -466,6 +466,7 @@ int	xfs_break_layouts(struct inode *inode, uint *iolock,
 /* from xfs_iops.c */
 extern void xfs_setup_inode(struct xfs_inode *ip);
 extern void xfs_setup_iops(struct xfs_inode *ip);
+extern void xfs_diflags_to_iflags(struct xfs_inode *ip, bool init);
 
 /*
  * When setting up a newly allocated inode, we need to call
diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
index d42de92cb283..c6cd92ef4a05 100644
--- a/fs/xfs/xfs_ioctl.c
+++ b/fs/xfs/xfs_ioctl.c
@@ -1100,37 +1100,6 @@ xfs_flags2diflags2(
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
-#if 0	/* disabled until the flag switching races are sorted out */
-	if (xflags & FS_XFLAG_DAX)
-		inode->i_flags |= S_DAX;
-	else
-		inode->i_flags &= ~S_DAX;
-#endif
-}
-
 static int
 xfs_ioctl_setattr_xflags(
 	struct xfs_trans	*tp,
@@ -1168,7 +1137,7 @@ xfs_ioctl_setattr_xflags(
 	ip->i_d.di_flags = xfs_flags2diflags(ip, fa->fsx_xflags);
 	ip->i_d.di_flags2 = di_flags2;
 
-	xfs_diflags_to_linux(ip);
+	xfs_diflags_to_iflags(ip, false);
 	xfs_trans_ichgtime(tp, ip, XFS_ICHGTIME_CHG);
 	xfs_trans_log_inode(tp, ip, XFS_ILOG_CORE);
 	XFS_STATS_INC(mp, xs_ig_attrchg);
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index e07f7b641226..a4ac8568c8c7 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -1259,7 +1259,7 @@ xfs_inode_supports_dax(
 	return xfs_inode_buftarg(ip)->bt_daxdev != NULL;
 }
 
-STATIC bool
+static bool
 xfs_inode_enable_dax(
 	struct xfs_inode *ip)
 {
@@ -1272,26 +1272,38 @@ xfs_inode_enable_dax(
 	return false;
 }
 
-STATIC void
+void
 xfs_diflags_to_iflags(
-	struct inode		*inode,
-	struct xfs_inode	*ip)
+	struct xfs_inode	*ip,
+	bool init)
 {
-	uint16_t		flags = ip->i_d.di_flags;
-
-	inode->i_flags &= ~(S_IMMUTABLE | S_APPEND | S_SYNC |
-			    S_NOATIME | S_DAX);
+	struct inode		*inode = VFS_I(ip);
+	uint			diflags = xfs_ip2xflags(ip);
 
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
-	if (xfs_inode_enable_dax(ip))
-		inode->i_flags |= S_DAX;
+	else
+		inode->i_flags &= ~S_NOATIME;
+
+	/* Only toggle the dax flag when initializing */
+	if (init) {
+		if (xfs_inode_enable_dax(ip))
+			inode->i_flags |= S_DAX;
+		else
+			inode->i_flags &= ~S_DAX;
+	}
 }
 
 /*
@@ -1320,7 +1332,7 @@ xfs_setup_inode(
 	inode->i_gid    = xfs_gid_to_kgid(ip->i_d.di_gid);
 
 	i_size_write(inode, ip->i_d.di_size);
-	xfs_diflags_to_iflags(inode, ip);
+	xfs_diflags_to_iflags(ip, true);
 
 	if (S_ISDIR(inode->i_mode)) {
 		/*
-- 
2.25.1

