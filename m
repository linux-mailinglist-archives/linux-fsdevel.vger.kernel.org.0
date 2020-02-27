Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00EBF171072
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Feb 2020 06:33:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728396AbgB0Fco (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Feb 2020 00:32:44 -0500
Received: from mga11.intel.com ([192.55.52.93]:58414 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727399AbgB0Fcn (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Feb 2020 00:32:43 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Feb 2020 21:32:42 -0800
X-IronPort-AV: E=Sophos;i="5.70,490,1574150400"; 
   d="scan'208";a="238289232"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.157])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Feb 2020 21:32:42 -0800
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
Subject: [PATCH V5 05/12] fs/xfs: Create function xfs_inode_enable_dax()
Date:   Wed, 26 Feb 2020 21:24:35 -0800
Message-Id: <20200227052442.22524-6-ira.weiny@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200227052442.22524-1-ira.weiny@intel.com>
References: <20200227052442.22524-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

xfs_inode_supports_dax() should reflect if the inode can support DAX not
that it is enabled for DAX.

Change the use of xfs_inode_supports_dax() to reflect only if the inode
and underlying storage support dax.

Add a new function xfs_inode_enable_dax() which reflects if the inode
should be enabled for DAX.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes from v3:
	Update functions and names to be more clear
	Update commit message
	Merge with
		'fs/xfs: Clean up DAX support check'
		don't allow IS_DAX() on a directory
		use STATIC macro for static
		make xfs_inode_supports_dax() static
---
 fs/xfs/xfs_iops.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index 81f2f93caec0..ff711efc5247 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -1237,19 +1237,18 @@ static const struct inode_operations xfs_inline_symlink_inode_operations = {
 };
 
 /* Figure out if this file actually supports DAX. */
-static bool
+STATIC bool
 xfs_inode_supports_dax(
 	struct xfs_inode	*ip)
 {
 	struct xfs_mount	*mp = ip->i_mount;
 
 	/* Only supported on non-reflinked files. */
-	if (!S_ISREG(VFS_I(ip)->i_mode) || xfs_is_reflink_inode(ip))
+	if (xfs_is_reflink_inode(ip))
 		return false;
 
-	/* DAX mount option or DAX iflag must be set. */
-	if (!(mp->m_flags & XFS_MOUNT_DAX) &&
-	    !(ip->i_d.di_flags2 & XFS_DIFLAG2_DAX))
+	/* Only supported on regular files. */
+	if (!S_ISREG(VFS_I(ip)->i_mode))
 		return false;
 
 	/* Block size must match page size */
@@ -1260,6 +1259,20 @@ xfs_inode_supports_dax(
 	return xfs_inode_buftarg(ip)->bt_daxdev != NULL;
 }
 
+STATIC bool
+xfs_inode_enable_dax(
+	struct xfs_inode *ip)
+{
+	if (!xfs_inode_supports_dax(ip))
+		return false;
+
+	if (ip->i_d.di_flags2 & XFS_DIFLAG2_DAX)
+		return true;
+	if (ip->i_mount->m_flags & XFS_MOUNT_DAX)
+		return true;
+	return false;
+}
+
 STATIC void
 xfs_diflags_to_iflags(
 	struct inode		*inode,
@@ -1278,7 +1291,7 @@ xfs_diflags_to_iflags(
 		inode->i_flags |= S_SYNC;
 	if (flags & XFS_DIFLAG_NOATIME)
 		inode->i_flags |= S_NOATIME;
-	if (xfs_inode_supports_dax(ip))
+	if (xfs_inode_enable_dax(ip))
 		inode->i_flags |= S_DAX;
 }
 
-- 
2.21.0

