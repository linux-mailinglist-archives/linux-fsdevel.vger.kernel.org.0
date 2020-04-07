Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C11571A139D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Apr 2020 20:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbgDGSa2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Apr 2020 14:30:28 -0400
Received: from mga11.intel.com ([192.55.52.93]:8650 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726795AbgDGSa1 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Apr 2020 14:30:27 -0400
IronPort-SDR: qck6BURlFqzapQFD5iftJGTsul5RAKzKIgCZLq+teHzFSbPb9oezHAZHz7f+ZKOCvLcJQwyayR
 wWWN4eoSxWNA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2020 11:30:27 -0700
IronPort-SDR: Noh/rkR7Yv21PGGhDZOXGeI5KlGGbJmE1ipndbL6bIrPhYqtCgRF91iwfa5wM/dzoc2m+0JwIE
 JV4Q31n4LaUw==
X-IronPort-AV: E=Sophos;i="5.72,356,1580803200"; 
   d="scan'208";a="254546840"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2020 11:30:26 -0700
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
Subject: [PATCH V6 4/8] fs/xfs: Make DAX mount option a tri-state
Date:   Tue,  7 Apr 2020 11:29:54 -0700
Message-Id: <20200407182958.568475-5-ira.weiny@intel.com>
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

As agreed upon[1].  We make the dax mount option a tri-state.  '-o dax'
continues to operate the same.  We add 'always', 'never', and 'iflag'
(default).

[1] https://lore.kernel.org/lkml/20200405061945.GA94792@iweiny-DESK2.sc.intel.com/

Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes from v5:
	New Patch
---
 fs/xfs/xfs_iops.c  |  2 +-
 fs/xfs/xfs_mount.h | 26 +++++++++++++++++++++++++-
 fs/xfs/xfs_super.c | 34 +++++++++++++++++++++++++++++-----
 3 files changed, 55 insertions(+), 7 deletions(-)

diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index 81f2f93caec0..1ec4a36917bd 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -1248,7 +1248,7 @@ xfs_inode_supports_dax(
 		return false;
 
 	/* DAX mount option or DAX iflag must be set. */
-	if (!(mp->m_flags & XFS_MOUNT_DAX) &&
+	if (xfs_mount_dax_mode(mp) != XFS_DAX_ALWAYS &&
 	    !(ip->i_d.di_flags2 & XFS_DIFLAG2_DAX))
 		return false;
 
diff --git a/fs/xfs/xfs_mount.h b/fs/xfs/xfs_mount.h
index 88ab09ed29e7..ce027ee06692 100644
--- a/fs/xfs/xfs_mount.h
+++ b/fs/xfs/xfs_mount.h
@@ -233,7 +233,31 @@ typedef struct xfs_mount {
 						   allocator */
 #define XFS_MOUNT_NOATTR2	(1ULL << 25)	/* disable use of attr2 format */
 
-#define XFS_MOUNT_DAX		(1ULL << 62)	/* TEST ONLY! */
+/* DAX flag is a 2 bit field representing a tri-state for dax
+ *      iflag, always, never
+ * We reserve/document the 2 bits using dax field/field2
+ */
+#define XFS_DAX_FIELD_MASK 0x3ULL
+#define XFS_DAX_FIELD_SHIFT 62
+#define XFS_MOUNT_DAX_FIELD	(1ULL << 62)
+#define XFS_MOUNT_DAX_FIELD2	(1ULL << 63)
+
+enum {
+	XFS_DAX_IFLAG = 0,
+	XFS_DAX_ALWAYS = 1,
+	XFS_DAX_NEVER = 2,
+};
+
+static inline void xfs_mount_set_dax(struct xfs_mount *mp, u32 val)
+{
+	mp->m_flags &= ~(XFS_DAX_FIELD_MASK << XFS_DAX_FIELD_SHIFT);
+	mp->m_flags |= ((val & XFS_DAX_FIELD_MASK) << XFS_DAX_FIELD_SHIFT);
+}
+
+static inline u32 xfs_mount_dax_mode(struct xfs_mount *mp)
+{
+	return (mp->m_flags >> XFS_DAX_FIELD_SHIFT) & XFS_DAX_FIELD_MASK;
+}
 
 /*
  * Max and min values for mount-option defined I/O
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index 2094386af8ac..d2fd465eeed5 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -47,6 +47,13 @@ static struct kset *xfs_kset;		/* top-level xfs sysfs dir */
 static struct xfs_kobj xfs_dbg_kobj;	/* global debug sysfs attrs */
 #endif
 
+static const struct constant_table dax_param_enums[] = {
+	{"iflag",	XFS_DAX_IFLAG },
+	{"always",	XFS_DAX_ALWAYS },
+	{"never",	XFS_DAX_NEVER },
+	{}
+};
+
 /*
  * Table driven mount option parser.
  */
@@ -59,7 +66,7 @@ enum {
 	Opt_filestreams, Opt_quota, Opt_noquota, Opt_usrquota, Opt_grpquota,
 	Opt_prjquota, Opt_uquota, Opt_gquota, Opt_pquota,
 	Opt_uqnoenforce, Opt_gqnoenforce, Opt_pqnoenforce, Opt_qnoenforce,
-	Opt_discard, Opt_nodiscard, Opt_dax,
+	Opt_discard, Opt_nodiscard, Opt_dax, Opt_dax_enum,
 };
 
 static const struct fs_parameter_spec xfs_fs_parameters[] = {
@@ -103,6 +110,7 @@ static const struct fs_parameter_spec xfs_fs_parameters[] = {
 	fsparam_flag("discard",		Opt_discard),
 	fsparam_flag("nodiscard",	Opt_nodiscard),
 	fsparam_flag("dax",		Opt_dax),
+	fsparam_enum("dax",		Opt_dax_enum, dax_param_enums),
 	{}
 };
 
@@ -129,7 +137,6 @@ xfs_fs_show_options(
 		{ XFS_MOUNT_GRPID,		",grpid" },
 		{ XFS_MOUNT_DISCARD,		",discard" },
 		{ XFS_MOUNT_LARGEIO,		",largeio" },
-		{ XFS_MOUNT_DAX,		",dax" },
 		{ 0, NULL }
 	};
 	struct xfs_mount	*mp = XFS_M(root->d_sb);
@@ -185,6 +192,20 @@ xfs_fs_show_options(
 	if (!(mp->m_qflags & XFS_ALL_QUOTA_ACCT))
 		seq_puts(m, ",noquota");
 
+	switch (xfs_mount_dax_mode(mp)) {
+		case XFS_DAX_IFLAG:
+			seq_puts(m, ",dax=iflag");
+			break;
+		case XFS_DAX_ALWAYS:
+			seq_puts(m, ",dax=always");
+			break;
+		case XFS_DAX_NEVER:
+			seq_puts(m, ",dax=never");
+			break;
+		default:
+			break;
+	}
+
 	return 0;
 }
 
@@ -1244,7 +1265,10 @@ xfs_fc_parse_param(
 		return 0;
 #ifdef CONFIG_FS_DAX
 	case Opt_dax:
-		mp->m_flags |= XFS_MOUNT_DAX;
+		xfs_mount_set_dax(mp, XFS_DAX_ALWAYS);
+		return 0;
+	case Opt_dax_enum:
+		xfs_mount_set_dax(mp, result.uint_32);
 		return 0;
 #endif
 	default:
@@ -1437,7 +1461,7 @@ xfs_fc_fill_super(
 	if (XFS_SB_VERSION_NUM(&mp->m_sb) == XFS_SB_VERSION_5)
 		sb->s_flags |= SB_I_VERSION;
 
-	if (mp->m_flags & XFS_MOUNT_DAX) {
+	if (xfs_mount_dax_mode(mp) == XFS_DAX_ALWAYS) {
 		bool rtdev_is_dax = false, datadev_is_dax;
 
 		xfs_warn(mp,
@@ -1451,7 +1475,7 @@ xfs_fc_fill_super(
 		if (!rtdev_is_dax && !datadev_is_dax) {
 			xfs_alert(mp,
 			"DAX unsupported by block device. Turning off DAX.");
-			mp->m_flags &= ~XFS_MOUNT_DAX;
+			xfs_mount_set_dax(mp, XFS_DAX_NEVER);
 		}
 		if (xfs_sb_version_hasreflink(&mp->m_sb)) {
 			xfs_alert(mp,
-- 
2.25.1

