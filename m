Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD40C1A939F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Apr 2020 08:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2635067AbgDOGsH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Apr 2020 02:48:07 -0400
Received: from mga01.intel.com ([192.55.52.88]:14277 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393637AbgDOGpi (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Apr 2020 02:45:38 -0400
IronPort-SDR: aBJ7x5zs02ro+yl1j3znZQeKnut/vQhVct8DXRigzisscmpUaAZB67gySislqdaA3deRPg8iJR
 /oQ51duRNKYw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2020 23:45:37 -0700
IronPort-SDR: /mQA8trEp4JWRxm37OaMEiPgNUAOEX1tin4upa7GLcH6w5rRnSU614Qw8fGzqOuWiufLwh0k76
 3N6Ctu7vvXmw==
X-IronPort-AV: E=Sophos;i="5.72,386,1580803200"; 
   d="scan'208";a="244025774"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2020 23:45:36 -0700
From:   ira.weiny@intel.com
To:     linux-kernel@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, Jan Kara <jack@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jeff Moyer <jmoyer@redhat.com>,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH V8 05/11] fs/xfs: Make DAX mount option a tri-state
Date:   Tue, 14 Apr 2020 23:45:17 -0700
Message-Id: <20200415064523.2244712-6-ira.weiny@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200415064523.2244712-1-ira.weiny@intel.com>
References: <20200415064523.2244712-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

As agreed upon[1].  We make the dax mount option a tri-state.  '-o dax'
continues to operate the same.  We add 'always', 'never', and 'inode'
(default).

[1] https://lore.kernel.org/lkml/20200405061945.GA94792@iweiny-DESK2.sc.intel.com/

Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes from v7:
	Change to XFS_MOUNT_DAX_NEVER

Changes from v6:
	Use 2 flag bits rather than a field.
	change iflag to inode

Changes from v5:
	New Patch
---
 fs/xfs/xfs_mount.h |  3 ++-
 fs/xfs/xfs_super.c | 44 ++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 42 insertions(+), 5 deletions(-)

diff --git a/fs/xfs/xfs_mount.h b/fs/xfs/xfs_mount.h
index 54bd74088936..2e88c30642e3 100644
--- a/fs/xfs/xfs_mount.h
+++ b/fs/xfs/xfs_mount.h
@@ -233,7 +233,8 @@ typedef struct xfs_mount {
 						   allocator */
 #define XFS_MOUNT_NOATTR2	(1ULL << 25)	/* disable use of attr2 format */
 
-#define XFS_MOUNT_DAX_ALWAYS	(1ULL << 62)	/* TEST ONLY! */
+#define XFS_MOUNT_DAX_ALWAYS	(1ULL << 62)
+#define XFS_MOUNT_DAX_NEVER	(1ULL << 63)
 
 /*
  * Max and min values for mount-option defined I/O
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index 3863f41757d2..142e5d03566f 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -47,6 +47,32 @@ static struct kset *xfs_kset;		/* top-level xfs sysfs dir */
 static struct xfs_kobj xfs_dbg_kobj;	/* global debug sysfs attrs */
 #endif
 
+enum {
+	XFS_DAX_INODE = 0,
+	XFS_DAX_ALWAYS = 1,
+	XFS_DAX_NEVER = 2,
+};
+
+static void xfs_mount_set_dax_mode(struct xfs_mount *mp, u32 val)
+{
+	if (val == XFS_DAX_INODE) {
+		mp->m_flags &= ~(XFS_MOUNT_DAX_ALWAYS | XFS_MOUNT_DAX_NEVER);
+	} else if (val == XFS_DAX_ALWAYS) {
+		mp->m_flags |= XFS_MOUNT_DAX_ALWAYS;
+		mp->m_flags &= ~XFS_MOUNT_DAX_NEVER;
+	} else if (val == XFS_DAX_NEVER) {
+		mp->m_flags |= XFS_MOUNT_DAX_NEVER;
+		mp->m_flags &= ~XFS_MOUNT_DAX_ALWAYS;
+	}
+}
+
+static const struct constant_table dax_param_enums[] = {
+	{"inode",	XFS_DAX_INODE },
+	{"always",	XFS_DAX_ALWAYS },
+	{"never",	XFS_DAX_NEVER },
+	{}
+};
+
 /*
  * Table driven mount option parser.
  */
@@ -59,7 +85,7 @@ enum {
 	Opt_filestreams, Opt_quota, Opt_noquota, Opt_usrquota, Opt_grpquota,
 	Opt_prjquota, Opt_uquota, Opt_gquota, Opt_pquota,
 	Opt_uqnoenforce, Opt_gqnoenforce, Opt_pqnoenforce, Opt_qnoenforce,
-	Opt_discard, Opt_nodiscard, Opt_dax,
+	Opt_discard, Opt_nodiscard, Opt_dax, Opt_dax_enum,
 };
 
 static const struct fs_parameter_spec xfs_fs_parameters[] = {
@@ -103,6 +129,7 @@ static const struct fs_parameter_spec xfs_fs_parameters[] = {
 	fsparam_flag("discard",		Opt_discard),
 	fsparam_flag("nodiscard",	Opt_nodiscard),
 	fsparam_flag("dax",		Opt_dax),
+	fsparam_enum("dax",		Opt_dax_enum, dax_param_enums),
 	{}
 };
 
@@ -129,7 +156,6 @@ xfs_fs_show_options(
 		{ XFS_MOUNT_GRPID,		",grpid" },
 		{ XFS_MOUNT_DISCARD,		",discard" },
 		{ XFS_MOUNT_LARGEIO,		",largeio" },
-		{ XFS_MOUNT_DAX_ALWAYS,		",dax" },
 		{ 0, NULL }
 	};
 	struct xfs_mount	*mp = XFS_M(root->d_sb);
@@ -185,6 +211,13 @@ xfs_fs_show_options(
 	if (!(mp->m_qflags & XFS_ALL_QUOTA_ACCT))
 		seq_puts(m, ",noquota");
 
+	if (mp->m_flags & XFS_MOUNT_DAX_ALWAYS)
+		seq_puts(m, ",dax=always");
+	else if (mp->m_flags & XFS_MOUNT_DAX_NEVER)
+		seq_puts(m, ",dax=never");
+	else
+		seq_puts(m, ",dax=inode");
+
 	return 0;
 }
 
@@ -1244,7 +1277,10 @@ xfs_fc_parse_param(
 		return 0;
 #ifdef CONFIG_FS_DAX
 	case Opt_dax:
-		mp->m_flags |= XFS_MOUNT_DAX_ALWAYS;
+		xfs_mount_set_dax_mode(mp, XFS_DAX_ALWAYS);
+		return 0;
+	case Opt_dax_enum:
+		xfs_mount_set_dax_mode(mp, result.uint_32);
 		return 0;
 #endif
 	default:
@@ -1451,7 +1487,7 @@ xfs_fc_fill_super(
 		if (!rtdev_is_dax && !datadev_is_dax) {
 			xfs_alert(mp,
 			"DAX unsupported by block device. Turning off DAX.");
-			mp->m_flags &= ~XFS_MOUNT_DAX_ALWAYS;
+			xfs_mount_set_dax_mode(mp, XFS_DAX_NEVER);
 		}
 		if (xfs_sb_version_hasreflink(&mp->m_sb)) {
 			xfs_alert(mp,
-- 
2.25.1

