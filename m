Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B16815676C
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Feb 2020 20:35:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727655AbgBHTez (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 8 Feb 2020 14:34:55 -0500
Received: from mga18.intel.com ([134.134.136.126]:56785 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727563AbgBHTex (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 8 Feb 2020 14:34:53 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Feb 2020 11:34:53 -0800
X-IronPort-AV: E=Sophos;i="5.70,418,1574150400"; 
   d="scan'208";a="225732414"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.157])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Feb 2020 11:34:52 -0800
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
Subject: [PATCH v3 11/12] fs/xfs: Clean up locking in dax invalidate
Date:   Sat,  8 Feb 2020 11:34:44 -0800
Message-Id: <20200208193445.27421-12-ira.weiny@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200208193445.27421-1-ira.weiny@intel.com>
References: <20200208193445.27421-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

Define a variable to hold the lock flags to ensure that the correct
locks are returned or released on error.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 fs/xfs/xfs_ioctl.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
index faba232b1f31..0134c9e65efb 100644
--- a/fs/xfs/xfs_ioctl.c
+++ b/fs/xfs/xfs_ioctl.c
@@ -1190,7 +1190,7 @@ xfs_ioctl_setattr_dax_invalidate(
 	int			*join_flags)
 {
 	struct inode		*inode = VFS_I(ip);
-	int			error;
+	int			error, flags;
 
 	*join_flags = 0;
 
@@ -1205,8 +1205,10 @@ xfs_ioctl_setattr_dax_invalidate(
 	if (S_ISDIR(inode->i_mode))
 		return 0;
 
+	flags = XFS_MMAPLOCK_EXCL | XFS_IOLOCK_EXCL;
+
 	/* lock, flush and invalidate mapping in preparation for flag change */
-	xfs_ilock(ip, XFS_MMAPLOCK_EXCL | XFS_IOLOCK_EXCL);
+	xfs_ilock(ip, flags);
 
 	if ((fa->fsx_xflags & FS_XFLAG_DAX) == FS_XFLAG_DAX &&
 	    !xfs_inode_supports_dax(ip)) {
@@ -1229,11 +1231,11 @@ xfs_ioctl_setattr_dax_invalidate(
 	if (error)
 		goto out_unlock;
 
-	*join_flags = XFS_MMAPLOCK_EXCL | XFS_IOLOCK_EXCL;
+	*join_flags = flags;
 	return 0;
 
 out_unlock:
-	xfs_iunlock(ip, XFS_MMAPLOCK_EXCL | XFS_IOLOCK_EXCL);
+	xfs_iunlock(ip, flags);
 	return error;
 
 }
-- 
2.21.0

