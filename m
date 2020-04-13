Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DF6B1A629A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Apr 2020 07:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728981AbgDMFl1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Apr 2020 01:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:42664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728974AbgDMFl0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Apr 2020 01:41:26 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A53EBC008675;
        Sun, 12 Apr 2020 22:41:25 -0700 (PDT)
IronPort-SDR: +MzHVRby3pbGUIjNpBf9JNfPkUnLyXgNQxHKke/BLsNwC69ncUlthU2YJ+nYHcEDi4kAkQrgnu
 8twZ6FdJX3tQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2020 22:41:25 -0700
IronPort-SDR: o7EWjfV6nqBbvdw1rbYYURTtjAq5djiV8GM1NNGWNwZyd5h+1J0iU9Fj8BG9UaEfXm8PL45DV9
 Xr/w3aOAPh7A==
X-IronPort-AV: E=Sophos;i="5.72,377,1580803200"; 
   d="scan'208";a="241572490"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2020 22:41:24 -0700
From:   ira.weiny@intel.com
To:     linux-kernel@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        Jeff Moyer <jmoyer@redhat.com>, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH V7 6/9] fs/xfs: Combine xfs_diflags_to_linux() and xfs_diflags_to_iflags()
Date:   Sun, 12 Apr 2020 22:40:43 -0700
Message-Id: <20200413054046.1560106-7-ira.weiny@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200413054046.1560106-1-ira.weiny@intel.com>
References: <20200413054046.1560106-1-ira.weiny@intel.com>
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
 fs/xfs/xfs_iops.c  | 42 +++++++++++++++++++++++-------------------
 3 files changed, 25 insertions(+), 51 deletions(-)

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
index 37bd15b55878..856ad823e754 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -1284,26 +1284,30 @@ xfs_inode_enable_dax(
 #endif /* CONFIG_FS_DAX */
 
 
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
-	if (xfs_inode_enable_dax(ip))
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
+	if (init && xfs_inode_enable_dax(ip))
+		flags |= S_DAX;
+
+	inode->i_flags &= ~(S_IMMUTABLE | S_APPEND | S_SYNC | S_NOATIME);
+	inode->i_flags |= flags;
 }
 
 /*
@@ -1332,7 +1336,7 @@ xfs_setup_inode(
 	inode->i_gid    = xfs_gid_to_kgid(ip->i_d.di_gid);
 
 	i_size_write(inode, ip->i_d.di_size);
-	xfs_diflags_to_iflags(inode, ip);
+	xfs_diflags_to_iflags(ip, true);
 
 	if (S_ISDIR(inode->i_mode)) {
 		/*
-- 
2.25.1

