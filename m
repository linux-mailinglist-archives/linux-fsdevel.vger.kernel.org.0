Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DB4F1B301F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Apr 2020 21:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbgDUTSz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Apr 2020 15:18:55 -0400
Received: from mga05.intel.com ([192.55.52.43]:59462 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726389AbgDUTSP (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Apr 2020 15:18:15 -0400
IronPort-SDR: 2VrBZg3YsGpoPuY2e4ha4l7iDFxHrFko0Qo1L4PyjSw3w48v9gt7XS8PugHzn9Yofj2BJugiZr
 5O5XQ0jcnjYA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2020 12:18:15 -0700
IronPort-SDR: BY38aG1IpsxE4DTwk6ImkdNLOfNRE9D4dSXAL6UoulrmXSK7Qvp2nHQw4RDpYkfMKSltb57JuY
 uLuNRQ68kYLA==
X-IronPort-AV: E=Sophos;i="5.72,411,1580803200"; 
   d="scan'208";a="334376226"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2020 12:18:14 -0700
From:   ira.weiny@intel.com
To:     linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, Al Viro <viro@zeniv.linux.org.uk>,
        Jan Kara <jack@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jeff Moyer <jmoyer@redhat.com>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH V9 04/11] fs/xfs: Change XFS_MOUNT_DAX to XFS_MOUNT_DAX_ALWAYS
Date:   Tue, 21 Apr 2020 12:17:46 -0700
Message-Id: <20200421191754.3372370-5-ira.weiny@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200421191754.3372370-1-ira.weiny@intel.com>
References: <20200421191754.3372370-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

In prep for the new tri-state mount option which then introduces
XFS_MOUNT_DAX_NEVER.

Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes from v8
	Move bit to 26
---
 fs/xfs/xfs_iops.c  | 2 +-
 fs/xfs/xfs_mount.h | 3 +--
 fs/xfs/xfs_super.c | 8 ++++----
 3 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index f7a99b3bbcf7..462f89af479a 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -1248,7 +1248,7 @@ xfs_inode_supports_dax(
 		return false;
 
 	/* DAX mount option or DAX iflag must be set. */
-	if (!(mp->m_flags & XFS_MOUNT_DAX) &&
+	if (!(mp->m_flags & XFS_MOUNT_DAX_ALWAYS) &&
 	    !(ip->i_d.di_flags2 & XFS_DIFLAG2_DAX))
 		return false;
 
diff --git a/fs/xfs/xfs_mount.h b/fs/xfs/xfs_mount.h
index b2e4598fdf7d..f6123fb0113c 100644
--- a/fs/xfs/xfs_mount.h
+++ b/fs/xfs/xfs_mount.h
@@ -237,8 +237,7 @@ typedef struct xfs_mount {
 #define XFS_MOUNT_FILESTREAMS	(1ULL << 24)	/* enable the filestreams
 						   allocator */
 #define XFS_MOUNT_NOATTR2	(1ULL << 25)	/* disable use of attr2 format */
-
-#define XFS_MOUNT_DAX		(1ULL << 62)	/* TEST ONLY! */
+#define XFS_MOUNT_DAX_ALWAYS	(1ULL << 26)
 
 /*
  * Max and min values for mount-option defined I/O
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index 424bb9a2d532..ce169d1c7474 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -129,7 +129,7 @@ xfs_fs_show_options(
 		{ XFS_MOUNT_GRPID,		",grpid" },
 		{ XFS_MOUNT_DISCARD,		",discard" },
 		{ XFS_MOUNT_LARGEIO,		",largeio" },
-		{ XFS_MOUNT_DAX,		",dax" },
+		{ XFS_MOUNT_DAX_ALWAYS,		",dax" },
 		{ 0, NULL }
 	};
 	struct xfs_mount	*mp = XFS_M(root->d_sb);
@@ -1261,7 +1261,7 @@ xfs_fc_parse_param(
 		return 0;
 #ifdef CONFIG_FS_DAX
 	case Opt_dax:
-		mp->m_flags |= XFS_MOUNT_DAX;
+		mp->m_flags |= XFS_MOUNT_DAX_ALWAYS;
 		return 0;
 #endif
 	default:
@@ -1454,7 +1454,7 @@ xfs_fc_fill_super(
 	if (XFS_SB_VERSION_NUM(&mp->m_sb) == XFS_SB_VERSION_5)
 		sb->s_flags |= SB_I_VERSION;
 
-	if (mp->m_flags & XFS_MOUNT_DAX) {
+	if (mp->m_flags & XFS_MOUNT_DAX_ALWAYS) {
 		bool rtdev_is_dax = false, datadev_is_dax;
 
 		xfs_warn(mp,
@@ -1468,7 +1468,7 @@ xfs_fc_fill_super(
 		if (!rtdev_is_dax && !datadev_is_dax) {
 			xfs_alert(mp,
 			"DAX unsupported by block device. Turning off DAX.");
-			mp->m_flags &= ~XFS_MOUNT_DAX;
+			mp->m_flags &= ~XFS_MOUNT_DAX_ALWAYS;
 		}
 		if (xfs_sb_version_hasreflink(&mp->m_sb)) {
 			xfs_alert(mp,
-- 
2.25.1

