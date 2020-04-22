Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F2CA1B4F1E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Apr 2020 23:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbgDVVVi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Apr 2020 17:21:38 -0400
Received: from mga09.intel.com ([134.134.136.24]:54658 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726846AbgDVVVh (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Apr 2020 17:21:37 -0400
IronPort-SDR: ie16WaTaWCgIIZKUou7r779tZJdhTf/AlmgLRJkXSvwo5Tm9Srkv/iuBvXrMYnzlDA41z+PP2f
 7mrb1MkwIBHQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2020 14:21:37 -0700
IronPort-SDR: eXhfMtDxXJJti4vJubvOlUhmhCvl3eswh7LpEfZF+Eu6+9elO9fTiQyfAxsyzsk0dXzUJL2sTk
 Y47W5CnqmbIQ==
X-IronPort-AV: E=Sophos;i="5.73,304,1583222400"; 
   d="scan'208";a="457284253"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2020 14:21:36 -0700
From:   ira.weiny@intel.com
To:     linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, Al Viro <viro@zeniv.linux.org.uk>,
        Jan Kara <jack@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jeff Moyer <jmoyer@redhat.com>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: [PATCH V10 08/11] fs/xfs: Combine xfs_diflags_to_linux() and xfs_diflags_to_iflags()
Date:   Wed, 22 Apr 2020 14:20:59 -0700
Message-Id: <20200422212102.3757660-9-ira.weiny@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200422212102.3757660-1-ira.weiny@intel.com>
References: <20200422212102.3757660-1-ira.weiny@intel.com>
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

Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes from V7:
	Clarify with a comment the reason for leaving S_DAX out of the
	mask

Changes from V6:
	Move unrelated hunk to previous patch.
	Change logic for better code generation.

Changes from V5:
	The functions are no longer identical so we can only combine
	them rather than deleting one completely.  This is reflected in
	the new init parameter.
---
 fs/xfs/xfs_inode.h |  1 +
 fs/xfs/xfs_ioctl.c | 33 +--------------------------------
 fs/xfs/xfs_iops.c  | 46 +++++++++++++++++++++++++++-------------------
 3 files changed, 29 insertions(+), 51 deletions(-)

diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
index c6a63f6764a6..83073c883fbf 100644
--- a/fs/xfs/xfs_inode.h
+++ b/fs/xfs/xfs_inode.h
@@ -467,6 +467,7 @@ int	xfs_break_layouts(struct inode *inode, uint *iolock,
 /* from xfs_iops.c */
 extern void xfs_setup_inode(struct xfs_inode *ip);
 extern void xfs_setup_iops(struct xfs_inode *ip);
+extern void xfs_diflags_to_iflags(struct xfs_inode *ip, bool init);
 
 /*
  * When setting up a newly allocated inode, we need to call
diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
index 309958186d33..104495ac187c 100644
--- a/fs/xfs/xfs_ioctl.c
+++ b/fs/xfs/xfs_ioctl.c
@@ -1201,37 +1201,6 @@ xfs_flags2diflags2(
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
@@ -1269,7 +1238,7 @@ xfs_ioctl_setattr_xflags(
 	ip->i_d.di_flags = xfs_flags2diflags(ip, fa->fsx_xflags);
 	ip->i_d.di_flags2 = di_flags2;
 
-	xfs_diflags_to_linux(ip);
+	xfs_diflags_to_iflags(ip, false);
 	xfs_trans_ichgtime(tp, ip, XFS_ICHGTIME_CHG);
 	xfs_trans_log_inode(tp, ip, XFS_ILOG_CORE);
 	XFS_STATS_INC(mp, xs_ig_attrchg);
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index 1814f10e43d3..b70b735fe4a4 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -1276,26 +1276,34 @@ xfs_inode_should_enable_dax(
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
-
-	if (flags & XFS_DIFLAG_IMMUTABLE)
-		inode->i_flags |= S_IMMUTABLE;
-	if (flags & XFS_DIFLAG_APPEND)
-		inode->i_flags |= S_APPEND;
-	if (flags & XFS_DIFLAG_SYNC)
-		inode->i_flags |= S_SYNC;
-	if (flags & XFS_DIFLAG_NOATIME)
-		inode->i_flags |= S_NOATIME;
-	if (xfs_inode_should_enable_dax(ip))
-		inode->i_flags |= S_DAX;
+	struct inode            *inode = VFS_I(ip);
+	unsigned int            xflags = xfs_ip2xflags(ip);
+	unsigned int            flags = 0;
+
+	ASSERT(!(IS_DAX(inode) && init));
+
+	if (xflags & FS_XFLAG_IMMUTABLE)
+		flags |= S_IMMUTABLE;
+	if (xflags & FS_XFLAG_APPEND)
+		flags |= S_APPEND;
+	if (xflags & FS_XFLAG_SYNC)
+		flags |= S_SYNC;
+	if (xflags & FS_XFLAG_NOATIME)
+		flags |= S_NOATIME;
+	if (init && xfs_inode_should_enable_dax(ip))
+		flags |= S_DAX;
+
+	/*
+	 * S_DAX can only be set during inode initialization and is never set by
+	 * the VFS, so we cannot mask off S_DAX in i_flags.
+	 */
+	inode->i_flags &= ~(S_IMMUTABLE | S_APPEND | S_SYNC | S_NOATIME);
+	inode->i_flags |= flags;
 }
 
 /*
@@ -1321,7 +1329,7 @@ xfs_setup_inode(
 	inode_fake_hash(inode);
 
 	i_size_write(inode, ip->i_d.di_size);
-	xfs_diflags_to_iflags(inode, ip);
+	xfs_diflags_to_iflags(ip, true);
 
 	if (S_ISDIR(inode->i_mode)) {
 		/*
-- 
2.25.1

