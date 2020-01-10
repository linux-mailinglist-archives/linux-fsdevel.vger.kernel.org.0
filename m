Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FB83137737
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2020 20:31:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728719AbgAJTbC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Jan 2020 14:31:02 -0500
Received: from mga01.intel.com ([192.55.52.88]:21831 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728860AbgAJTaA (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Jan 2020 14:30:00 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jan 2020 11:30:00 -0800
X-IronPort-AV: E=Sophos;i="5.69,418,1571727600"; 
   d="scan'208";a="216772415"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.157])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jan 2020 11:29:59 -0800
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
Subject: [RFC PATCH V2 03/12] fs/xfs: Separate functionality of xfs_inode_supports_dax()
Date:   Fri, 10 Jan 2020 11:29:33 -0800
Message-Id: <20200110192942.25021-4-ira.weiny@intel.com>
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

xfs_inode_supports_dax() should reflect if the inode can support DAX not
that it is enabled for DAX.  Leave that to other helper functions.

Change the caller of xfs_inode_supports_dax() to call
xfs_inode_use_dax() which reflects new logic to override the effective
DAX flag with either the mount option or the physical DAX flag.

To make the logic clear create 2 helper functions for the mount and
physical flag.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 fs/xfs/xfs_iops.c | 32 ++++++++++++++++++++++++++------
 1 file changed, 26 insertions(+), 6 deletions(-)

diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index 8afe69ca188b..0a0ea90259e9 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -1234,6 +1234,15 @@ static const struct inode_operations xfs_inline_symlink_inode_operations = {
 	.update_time		= xfs_vn_update_time,
 };
 
+static bool
+xfs_inode_mount_is_dax(
+	struct xfs_inode *ip)
+{
+	struct xfs_mount	*mp = ip->i_mount;
+
+	return (mp->m_flags & XFS_MOUNT_DAX) == XFS_MOUNT_DAX;
+}
+
 /* Figure out if this file actually supports DAX. */
 static bool
 xfs_inode_supports_dax(
@@ -1245,11 +1254,6 @@ xfs_inode_supports_dax(
 	if (!S_ISREG(VFS_I(ip)->i_mode) || xfs_is_reflink_inode(ip))
 		return false;
 
-	/* DAX mount option or DAX iflag must be set. */
-	if (!(mp->m_flags & XFS_MOUNT_DAX) &&
-	    !(ip->i_d.di_flags2 & XFS_DIFLAG2_DAX))
-		return false;
-
 	/* Block size must match page size */
 	if (mp->m_sb.sb_blocksize != PAGE_SIZE)
 		return false;
@@ -1258,6 +1262,22 @@ xfs_inode_supports_dax(
 	return xfs_inode_buftarg(ip)->bt_daxdev != NULL;
 }
 
+static bool
+xfs_inode_is_dax(
+	struct xfs_inode *ip)
+{
+	return (ip->i_d.di_flags2 & XFS_DIFLAG2_DAX) == XFS_DIFLAG2_DAX;
+}
+
+static bool
+xfs_inode_use_dax(
+	struct xfs_inode *ip)
+{
+	return xfs_inode_supports_dax(ip) &&
+		(xfs_inode_mount_is_dax(ip) ||
+		 xfs_inode_is_dax(ip));
+}
+
 STATIC void
 xfs_diflags_to_iflags(
 	struct inode		*inode,
@@ -1276,7 +1296,7 @@ xfs_diflags_to_iflags(
 		inode->i_flags |= S_SYNC;
 	if (flags & XFS_DIFLAG_NOATIME)
 		inode->i_flags |= S_NOATIME;
-	if (xfs_inode_supports_dax(ip))
+	if (xfs_inode_use_dax(ip))
 		inode->i_flags |= S_DAX;
 }
 
-- 
2.21.0

