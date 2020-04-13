Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 016ED1A62A1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Apr 2020 07:42:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728222AbgDMFlz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Apr 2020 01:41:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:42658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728959AbgDMFlY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Apr 2020 01:41:24 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDE62C008675;
        Sun, 12 Apr 2020 22:41:23 -0700 (PDT)
IronPort-SDR: NtVqXWVbaOWU1Sey6v5WS+G4xBRUEcXZtlzHLrDURbSLgOB6DDreyFH8vTqmC0fJEZmRYC1CK1
 oEV0nA3i8z7Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2020 22:41:23 -0700
IronPort-SDR: BT1E+ILAe2C4ptsLWsGonCojt8RaCm6AtKnYMF3NgLn4kqcZKs6ePQJ/47mD+vd1Q/2gKr59ph
 jCJ5H3E/V+SA==
X-IronPort-AV: E=Sophos;i="5.72,377,1580803200"; 
   d="scan'208";a="298328580"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2020 22:41:23 -0700
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
Subject: [PATCH V7 5/9] fs/xfs: Create function xfs_inode_enable_dax()
Date:   Sun, 12 Apr 2020 22:40:42 -0700
Message-Id: <20200413054046.1560106-6-ira.weiny@intel.com>
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

xfs_inode_supports_dax() should reflect if the inode can support DAX not
that it is enabled for DAX.

Change the use of xfs_inode_supports_dax() to reflect only if the inode
and underlying storage support dax.

Add a new function xfs_inode_enable_dax() which reflects if the inode
should be enabled for DAX.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
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
 fs/xfs/xfs_iops.c | 34 +++++++++++++++++++++++++++++-----
 1 file changed, 29 insertions(+), 5 deletions(-)

diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index 81f2f93caec0..37bd15b55878 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -1244,12 +1244,11 @@ xfs_inode_supports_dax(
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
@@ -1260,6 +1259,31 @@ xfs_inode_supports_dax(
 	return xfs_inode_buftarg(ip)->bt_daxdev != NULL;
 }
 
+#ifdef CONFIG_FS_DAX
+static bool
+xfs_inode_enable_dax(
+	struct xfs_inode *ip)
+{
+	if (ip->i_mount->m_flags & XFS_MOUNT_NODAX)
+		return false;
+	if (!xfs_inode_supports_dax(ip))
+		return false;
+	if (ip->i_mount->m_flags & XFS_MOUNT_DAX)
+		return true;
+	if (ip->i_d.di_flags2 & XFS_DIFLAG2_DAX)
+		return true;
+	return false;
+}
+#else /* !CONFIG_FS_DAX */
+static bool
+xfs_inode_enable_dax(
+	struct xfs_inode *ip)
+{
+	return false;
+}
+#endif /* CONFIG_FS_DAX */
+
+
 STATIC void
 xfs_diflags_to_iflags(
 	struct inode		*inode,
@@ -1278,7 +1302,7 @@ xfs_diflags_to_iflags(
 		inode->i_flags |= S_SYNC;
 	if (flags & XFS_DIFLAG_NOATIME)
 		inode->i_flags |= S_NOATIME;
-	if (xfs_inode_supports_dax(ip))
+	if (xfs_inode_enable_dax(ip))
 		inode->i_flags |= S_DAX;
 }
 
-- 
2.25.1

