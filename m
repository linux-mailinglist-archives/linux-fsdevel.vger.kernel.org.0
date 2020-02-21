Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38E60166BEF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2020 01:42:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729534AbgBUAml (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Feb 2020 19:42:41 -0500
Received: from mga11.intel.com ([192.55.52.93]:31906 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729584AbgBUAlm (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Feb 2020 19:41:42 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Feb 2020 16:41:42 -0800
X-IronPort-AV: E=Sophos;i="5.70,466,1574150400"; 
   d="scan'208";a="229063093"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.157])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Feb 2020 16:41:41 -0800
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
Subject: [PATCH V4 05/13] fs/xfs: Isolate the physical DAX flag from enabled
Date:   Thu, 20 Feb 2020 16:41:26 -0800
Message-Id: <20200221004134.30599-6-ira.weiny@intel.com>
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

xfs_ioctl_setattr_dax_invalidate() currently checks if the DAX flag is
changing as a quick check.

But the implementation mixes the physical (XFS_DIFLAG2_DAX) and
the enabled (S_DAX) DAX flags.

Remove the use of the enabled flag when determining if a change of the
physical flag is required.

Furthermore, we want the physical flag, XFS_DIFLAG2_DAX, to be changed
regardless of if the underlying storage can support DAX or not.

The enabled flag, IS_DAX(), will be set later IFF the inode supports
dax in a follow on patch.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes from V3:
	Remove the underlying storage support check
	Rework commit message
	Reorder patch
---
 fs/xfs/xfs_ioctl.c | 20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
index d42de92cb283..25e12ce85075 100644
--- a/fs/xfs/xfs_ioctl.c
+++ b/fs/xfs/xfs_ioctl.c
@@ -1190,28 +1190,16 @@ xfs_ioctl_setattr_dax_invalidate(
 	int			*join_flags)
 {
 	struct inode		*inode = VFS_I(ip);
-	struct super_block	*sb = inode->i_sb;
 	int			error;
 
 	*join_flags = 0;
 
-	/*
-	 * It is only valid to set the DAX flag on regular files and
-	 * directories on filesystems where the block size is equal to the page
-	 * size. On directories it serves as an inherited hint so we don't
-	 * have to check the device for dax support or flush pagecache.
-	 */
-	if (fa->fsx_xflags & FS_XFLAG_DAX) {
-		struct xfs_buftarg	*target = xfs_inode_buftarg(ip);
-
-		if (!bdev_dax_supported(target->bt_bdev, sb->s_blocksize))
-			return -EINVAL;
-	}
-
 	/* If the DAX state is not changing, we have nothing to do here. */
-	if ((fa->fsx_xflags & FS_XFLAG_DAX) && IS_DAX(inode))
+	if ((fa->fsx_xflags & FS_XFLAG_DAX) &&
+	    (ip->i_d.di_flags2 & XFS_DIFLAG2_DAX))
 		return 0;
-	if (!(fa->fsx_xflags & FS_XFLAG_DAX) && !IS_DAX(inode))
+	if (!(fa->fsx_xflags & FS_XFLAG_DAX) &&
+	    !(ip->i_d.di_flags2 & XFS_DIFLAG2_DAX))
 		return 0;
 
 	if (S_ISDIR(inode->i_mode))
-- 
2.21.0

