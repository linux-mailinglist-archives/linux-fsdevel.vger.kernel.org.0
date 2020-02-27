Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A41DC17106D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Feb 2020 06:33:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728592AbgB0FdY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Feb 2020 00:33:24 -0500
Received: from mga05.intel.com ([192.55.52.43]:37515 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728416AbgB0Fcp (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Feb 2020 00:32:45 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Feb 2020 21:32:45 -0800
X-IronPort-AV: E=Sophos;i="5.70,490,1574150400"; 
   d="scan'208";a="232052990"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.157])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Feb 2020 21:32:44 -0800
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
Subject: [PATCH V5 08/12] fs/xfs: Hold off aops users while changing DAX state
Date:   Wed, 26 Feb 2020 21:24:38 -0800
Message-Id: <20200227052442.22524-9-ira.weiny@intel.com>
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

XFS requires the use of the aops of an inode to be quiesced prior to
changing the aops vector to/from the DAX vector.

Take the aops write lock while changing DAX state.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes from v4:
	Open code the aops write lock
	Obsolete: Clean up lock name in comments
	Obsolete: Change #define: XFS_DAX_EXCL => XFS_AOPSLOCK_EXCL

Changes from v3:
	Change locking function names to reflect changes in previous
	patches.

Changes from V2:
	Change name of patch (WAS: fs/xfs: Add lock/unlock state to xfs)
	Remove the xfs specific lock and move to the vfs layer.
		We still use XFS_LOCK_DAX_EXCL to be able to pass this
		flag through to the transaction code.  But we no longer
		have a lock specific to xfs.  This removes a lot of code
		from the XFS layer, preps us for using this in ext4, and
		is actually more straight forward now that all the
		locking requirements are better known.

	Fix locking order comment
	Rework for new 'state' names
	(Other comments on the previous patch are not applicable with
	new patch as much of the code was removed in favor of the vfs
	level lock)
---
 fs/xfs/xfs_ioctl.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
index 498fae2ef9f6..6c4d4ea3b6b6 100644
--- a/fs/xfs/xfs_ioctl.c
+++ b/fs/xfs/xfs_ioctl.c
@@ -1444,7 +1444,11 @@ xfs_ioctl_setattr(
 	 * or cancel time, so need to be passed through to
 	 * xfs_ioctl_setattr_get_trans() so it can apply them to the join call
 	 * appropriately.
+	 *
+	 * Further we hold off aops users until we have completed any potential
+	 * changing of aops due to attribute changes.
 	 */
+	inode_aops_down_write(VFS_I(ip));
 	code = xfs_ioctl_setattr_dax_invalidate(ip, fa, &join_flags);
 	if (code)
 		goto error_free_dquots;
@@ -1527,6 +1531,7 @@ xfs_ioctl_setattr(
 	xfs_qm_dqrele(udqp);
 	xfs_qm_dqrele(pdqp);
 
+	inode_aops_up_write(VFS_I(ip));
 	return code;
 
 error_trans_cancel:
@@ -1534,6 +1539,7 @@ xfs_ioctl_setattr(
 error_free_dquots:
 	xfs_qm_dqrele(udqp);
 	xfs_qm_dqrele(pdqp);
+	inode_aops_up_write(VFS_I(ip));
 	return code;
 }
 
@@ -1603,7 +1609,11 @@ xfs_ioc_setxflags(
 	 * or cancel time, so need to be passed through to
 	 * xfs_ioctl_setattr_get_trans() so it can apply them to the join call
 	 * appropriately.
+	 *
+	 * Further we hold off aops users until we have completed any potential
+	 * changing of aops due to attribute changes.
 	 */
+	inode_aops_down_write(VFS_I(ip));
 	error = xfs_ioctl_setattr_dax_invalidate(ip, &fa, &join_flags);
 	if (error)
 		goto out_drop_write;
@@ -1630,6 +1640,7 @@ xfs_ioc_setxflags(
 	error = xfs_trans_commit(tp);
 out_drop_write:
 	mnt_drop_write_file(filp);
+	inode_aops_up_write(VFS_I(ip));
 	return error;
 }
 
-- 
2.21.0

