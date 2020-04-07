Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FD3A1A13A7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Apr 2020 20:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726909AbgDGSaf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Apr 2020 14:30:35 -0400
Received: from mga07.intel.com ([134.134.136.100]:13103 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726701AbgDGSae (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Apr 2020 14:30:34 -0400
IronPort-SDR: 9V/u24v+XGk/EX7rBCTZ9M1DVSIvBJnPXSobd40UGxGDvVIlTgTOTN44q1m7kfdDc92//Tt/kd
 C0z6OCYGZ7uw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2020 11:30:29 -0700
IronPort-SDR: pIX3NWUkK88MU5yvjdKKwgZ21HeS8G8o7F+gVRB8itTFCBmwbqumvGb1eexC1dg7LT5Ladr2kt
 bYUQe9q0C7QQ==
X-IronPort-AV: E=Sophos;i="5.72,356,1580803200"; 
   d="scan'208";a="251316765"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2020 11:30:29 -0700
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
Subject: [PATCH V6 5/8] fs/xfs: Create function xfs_inode_enable_dax()
Date:   Tue,  7 Apr 2020 11:29:55 -0700
Message-Id: <20200407182958.568475-6-ira.weiny@intel.com>
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

xfs_inode_supports_dax() should reflect if the inode can support DAX not
that it is enabled for DAX.

Change the use of xfs_inode_supports_dax() to reflect only if the inode
and underlying storage support dax.

Add a new function xfs_inode_enable_dax() which reflects if the inode
should be enabled for DAX.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
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
 fs/xfs/xfs_iops.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index 1ec4a36917bd..e07f7b641226 100644
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
-	if (xfs_mount_dax_mode(mp) != XFS_DAX_ALWAYS &&
-	    !(ip->i_d.di_flags2 & XFS_DIFLAG2_DAX))
+	/* Only supported on regular files. */
+	if (!S_ISREG(VFS_I(ip)->i_mode))
 		return false;
 
 	/* Block size must match page size */
@@ -1260,6 +1259,19 @@ xfs_inode_supports_dax(
 	return xfs_inode_buftarg(ip)->bt_daxdev != NULL;
 }
 
+STATIC bool
+xfs_inode_enable_dax(
+	struct xfs_inode *ip)
+{
+	u32 dax_mode = xfs_mount_dax_mode(ip->i_mount);
+
+	if (dax_mode == XFS_DAX_NEVER || !xfs_inode_supports_dax(ip))
+		return false;
+	if (dax_mode == XFS_DAX_ALWAYS || ip->i_d.di_flags2 & XFS_DIFLAG2_DAX)
+		return true;
+	return false;
+}
+
 STATIC void
 xfs_diflags_to_iflags(
 	struct inode		*inode,
@@ -1278,7 +1290,7 @@ xfs_diflags_to_iflags(
 		inode->i_flags |= S_SYNC;
 	if (flags & XFS_DIFLAG_NOATIME)
 		inode->i_flags |= S_NOATIME;
-	if (xfs_inode_supports_dax(ip))
+	if (xfs_inode_enable_dax(ip))
 		inode->i_flags |= S_DAX;
 }
 
-- 
2.25.1

