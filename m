Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA21137708
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2020 20:30:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728852AbgAJT37 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Jan 2020 14:29:59 -0500
Received: from mga05.intel.com ([192.55.52.43]:59396 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727709AbgAJT36 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Jan 2020 14:29:58 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jan 2020 11:29:58 -0800
X-IronPort-AV: E=Sophos;i="5.69,418,1571727600"; 
   d="scan'208";a="255125193"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.157])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jan 2020 11:29:58 -0800
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
Subject: [RFC PATCH V2 02/12] fs/xfs: Isolate the physical DAX flag from effective
Date:   Fri, 10 Jan 2020 11:29:32 -0800
Message-Id: <20200110192942.25021-3-ira.weiny@intel.com>
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

xfs_ioctl_setattr_dax_invalidate() currently checks if the DAX flag is
changing as a quick check.

But the implementation mixes the physical (XFS_DIFLAG2_DAX) and
effective (S_DAX) DAX flags.

Remove the use of the effective flag when determining if a change of the
physical flag is required.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 fs/xfs/xfs_ioctl.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
index 7b35d62ede9f..fe37708cea8f 100644
--- a/fs/xfs/xfs_ioctl.c
+++ b/fs/xfs/xfs_ioctl.c
@@ -1195,9 +1195,11 @@ xfs_ioctl_setattr_dax_invalidate(
 	}
 
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

