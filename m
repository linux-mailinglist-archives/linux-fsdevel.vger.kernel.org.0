Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 985FD137718
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2020 20:31:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728946AbgAJTaH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Jan 2020 14:30:07 -0500
Received: from mga18.intel.com ([134.134.136.126]:33892 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728924AbgAJTaG (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Jan 2020 14:30:06 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jan 2020 11:30:05 -0800
X-IronPort-AV: E=Sophos;i="5.69,418,1571727600"; 
   d="scan'208";a="396531775"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.157])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jan 2020 11:30:04 -0800
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
Subject: [RFC PATCH V2 06/12] fs/xfs: Check if the inode supports DAX under lock
Date:   Fri, 10 Jan 2020 11:29:36 -0800
Message-Id: <20200110192942.25021-7-ira.weiny@intel.com>
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

One of the checks for an inode supporting DAX is if the inode is
reflinked.  During a non-DAX to DAX mode change we could race with
the file being reflinked and end up with a reflinked file being in DAX
mode.

Prevent this race by checking for DAX support under the MMAP_LOCK.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 fs/xfs/xfs_ioctl.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
index b5e00b67c297..bc3654fe3b5d 100644
--- a/fs/xfs/xfs_ioctl.c
+++ b/fs/xfs/xfs_ioctl.c
@@ -1180,10 +1180,6 @@ xfs_ioctl_setattr_dax_invalidate(
 
 	*join_flags = 0;
 
-	if ((fa->fsx_xflags & FS_XFLAG_DAX) == FS_XFLAG_DAX &&
-	    !xfs_inode_supports_dax(ip))
-		return -EINVAL;
-
 	/* If the DAX state is not changing, we have nothing to do here. */
 	if ((fa->fsx_xflags & FS_XFLAG_DAX) &&
 	    (ip->i_d.di_flags2 & XFS_DIFLAG2_DAX))
@@ -1197,6 +1193,13 @@ xfs_ioctl_setattr_dax_invalidate(
 
 	/* lock, flush and invalidate mapping in preparation for flag change */
 	xfs_ilock(ip, XFS_MMAPLOCK_EXCL | XFS_IOLOCK_EXCL);
+
+	if ((fa->fsx_xflags & FS_XFLAG_DAX) == FS_XFLAG_DAX &&
+	    !xfs_inode_supports_dax(ip)) {
+		error = -EINVAL;
+		goto out_unlock;
+	}
+
 	error = filemap_write_and_wait(inode->i_mapping);
 	if (error)
 		goto out_unlock;
-- 
2.21.0

