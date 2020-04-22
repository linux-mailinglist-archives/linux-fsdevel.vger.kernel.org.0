Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 835491B4F37
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Apr 2020 23:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbgDVVWE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Apr 2020 17:22:04 -0400
Received: from mga06.intel.com ([134.134.136.31]:17492 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726816AbgDVVVf (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Apr 2020 17:21:35 -0400
IronPort-SDR: 6K5NvpJU25PlwKeJYeWyd7eCSOEiMSpzzWY+6M6oyF1fCncsELj0WBQ/J5/r44pgbBVa/6j/eV
 On5rdNBVOi5Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2020 14:21:34 -0700
IronPort-SDR: VAst1//Lp1w6hVpQx5pqVv+zn/ESuWkyKOR196eROu0NQJ1roUBX7wKidJcqg8TlMyhMHgGvlv
 VCE79/xXFI/g==
X-IronPort-AV: E=Sophos;i="5.73,304,1583222400"; 
   d="scan'208";a="255775163"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2020 14:21:34 -0700
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
Subject: [PATCH V10 07/11] fs/xfs: Create function xfs_inode_should_enable_dax()
Date:   Wed, 22 Apr 2020 14:20:58 -0700
Message-Id: <20200422212102.3757660-8-ira.weiny@intel.com>
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

xfs_inode_supports_dax() should reflect if the inode can support DAX not
that it is enabled for DAX.

Change the use of xfs_inode_supports_dax() to reflect only if the inode
and underlying storage support dax.

Add a new function xfs_inode_should_enable_dax() which reflects if the
inode should be enabled for DAX.

Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes from V8
	Change to 'should enable' (feedback given by Jan in ext4 series)
		Darrick I've preserved your Reviewed-by for now LMK if
		that is an issue.

Changes from v7:
	Move S_ISREG check first
	use IS_ENABLED(CONFIG_FS_DAX) rather than duplicated function

Changes from v6:
	Change enable checks to be sequential logic.
	Update for 2 bit tri-state option.
	Make 'static' consistent.
	Don't set S_DAX if !CONFIG_FS_DAX

Changes from v5:
	Update to reflect the new tri-state mount option

Changes from v3:
	Update functions and names to be more clear
	Update commit message
	Merge with
		'fs/xfs: Clean up DAX support check'
		don't allow IS_DAX() on a directory
		use STATIC macro for static
		make xfs_inode_supports_dax() static
---
 fs/xfs/xfs_iops.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index 462f89af479a..1814f10e43d3 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -1243,13 +1243,12 @@ xfs_inode_supports_dax(
 {
 	struct xfs_mount	*mp = ip->i_mount;
 
-	/* Only supported on non-reflinked files. */
-	if (!S_ISREG(VFS_I(ip)->i_mode) || xfs_is_reflink_inode(ip))
+	/* Only supported on regular files. */
+	if (!S_ISREG(VFS_I(ip)->i_mode))
 		return false;
 
-	/* DAX mount option or DAX iflag must be set. */
-	if (!(mp->m_flags & XFS_MOUNT_DAX_ALWAYS) &&
-	    !(ip->i_d.di_flags2 & XFS_DIFLAG2_DAX))
+	/* Only supported on non-reflinked files. */
+	if (xfs_is_reflink_inode(ip))
 		return false;
 
 	/* Block size must match page size */
@@ -1260,6 +1259,23 @@ xfs_inode_supports_dax(
 	return xfs_inode_buftarg(ip)->bt_daxdev != NULL;
 }
 
+static bool
+xfs_inode_should_enable_dax(
+	struct xfs_inode *ip)
+{
+	if (!IS_ENABLED(CONFIG_FS_DAX))
+		return false;
+	if (ip->i_mount->m_flags & XFS_MOUNT_DAX_NEVER)
+		return false;
+	if (!xfs_inode_supports_dax(ip))
+		return false;
+	if (ip->i_mount->m_flags & XFS_MOUNT_DAX_ALWAYS)
+		return true;
+	if (ip->i_d.di_flags2 & XFS_DIFLAG2_DAX)
+		return true;
+	return false;
+}
+
 STATIC void
 xfs_diflags_to_iflags(
 	struct inode		*inode,
@@ -1278,7 +1294,7 @@ xfs_diflags_to_iflags(
 		inode->i_flags |= S_SYNC;
 	if (flags & XFS_DIFLAG_NOATIME)
 		inode->i_flags |= S_NOATIME;
-	if (xfs_inode_supports_dax(ip))
+	if (xfs_inode_should_enable_dax(ip))
 		inode->i_flags |= S_DAX;
 }
 
-- 
2.25.1

