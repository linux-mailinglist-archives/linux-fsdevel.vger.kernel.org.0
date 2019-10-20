Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3A05DDF53
	for <lists+linux-fsdevel@lfdr.de>; Sun, 20 Oct 2019 18:00:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbfJTQAA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 20 Oct 2019 12:00:00 -0400
Received: from mga01.intel.com ([192.55.52.88]:46720 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726647AbfJTP77 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 20 Oct 2019 11:59:59 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Oct 2019 08:59:59 -0700
X-IronPort-AV: E=Sophos;i="5.67,320,1566889200"; 
   d="scan'208";a="227073625"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.157])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Oct 2019 08:59:59 -0700
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
Subject: [PATCH 4/5] fs/xfs: Clean up DAX support check
Date:   Sun, 20 Oct 2019 08:59:34 -0700
Message-Id: <20191020155935.12297-5-ira.weiny@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191020155935.12297-1-ira.weiny@intel.com>
References: <20191020155935.12297-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

Rather than open coding xfs_inode_supports_dax() in
xfs_ioctl_setattr_dax_invalidate() export xfs_inode_supports_dax() and
call it in preparation for swapping dax flags.

This also means updating xfs_inode_supports_dax() to return true for a
directory.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 fs/xfs/xfs_ioctl.c | 17 +++--------------
 fs/xfs/xfs_iops.c  |  8 ++++++--
 fs/xfs/xfs_iops.h  |  2 ++
 3 files changed, 11 insertions(+), 16 deletions(-)

diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
index 0ea326290cca..d3a7340d3209 100644
--- a/fs/xfs/xfs_ioctl.c
+++ b/fs/xfs/xfs_ioctl.c
@@ -1299,24 +1299,13 @@ xfs_ioctl_setattr_dax_invalidate(
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
-		if (!(S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode)))
-			return -EINVAL;
-		if (!bdev_dax_supported(xfs_find_bdev_for_inode(VFS_I(ip)),
-				sb->s_blocksize))
-			return -EINVAL;
-	}
+	if ((fa->fsx_xflags & FS_XFLAG_DAX) == FS_XFLAG_DAX &&
+	    !xfs_inode_supports_dax(ip))
+		return -EINVAL;
 
 	/* If the DAX state is not changing, we have nothing to do here. */
 	if ((fa->fsx_xflags & FS_XFLAG_DAX) &&
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index 9e5c79aa1b54..535b87ffc135 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -1216,14 +1216,18 @@ xfs_inode_mount_is_dax(
 }
 
 /* Figure out if this file actually supports DAX. */
-static bool
+bool
 xfs_inode_supports_dax(
 	struct xfs_inode	*ip)
 {
 	struct xfs_mount	*mp = ip->i_mount;
 
 	/* Only supported on non-reflinked files. */
-	if (!S_ISREG(VFS_I(ip)->i_mode) || xfs_is_reflink_inode(ip))
+	if (xfs_is_reflink_inode(ip))
+		return false;
+
+	/* Only supported on regular files and directories. */
+	if (!(S_ISREG(VFS_I(ip)->i_mode) || S_ISDIR(VFS_I(ip)->i_mode)))
 		return false;
 
 	/* Block size must match page size */
diff --git a/fs/xfs/xfs_iops.h b/fs/xfs/xfs_iops.h
index 4d24ff309f59..f24fec8de1d6 100644
--- a/fs/xfs/xfs_iops.h
+++ b/fs/xfs/xfs_iops.h
@@ -24,4 +24,6 @@ extern int xfs_setattr_nonsize(struct xfs_inode *ip, struct iattr *vap,
 extern int xfs_vn_setattr_nonsize(struct dentry *dentry, struct iattr *vap);
 extern int xfs_vn_setattr_size(struct dentry *dentry, struct iattr *vap);
 
+extern bool xfs_inode_supports_dax(struct xfs_inode *ip);
+
 #endif /* __XFS_IOPS_H__ */
-- 
2.20.1

