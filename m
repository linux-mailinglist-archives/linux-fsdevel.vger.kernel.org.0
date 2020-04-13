Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF6EF1A627F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Apr 2020 07:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728965AbgDMFlY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Apr 2020 01:41:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:42652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728937AbgDMFlX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Apr 2020 01:41:23 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B65FBC008675;
        Sun, 12 Apr 2020 22:41:22 -0700 (PDT)
IronPort-SDR: ahUkUDZrEuG/JLqhltsZOBHLYg/wG4xtPjnbsfL1dXkrwlBJV8005yrCVf4+qWCmjOUpYcppn+
 du/aHv82SbHQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2020 22:41:22 -0700
IronPort-SDR: wEBpDRPRWyCAj4NDCtjdos6QylEJUxIrU/jmF80eOnAiZ4bYm4gzg3owB27RvNPo+Nlfe64/3O
 ninQAMFKnTHg==
X-IronPort-AV: E=Sophos;i="5.72,377,1580803200"; 
   d="scan'208";a="454109300"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2020 22:41:22 -0700
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
Subject: [PATCH V7 4/9] fs/xfs: Make DAX mount option a tri-state
Date:   Sun, 12 Apr 2020 22:40:41 -0700
Message-Id: <20200413054046.1560106-5-ira.weiny@intel.com>
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

As agreed upon[1].  We make the dax mount option a tri-state.  '-o dax'
continues to operate the same.  We add 'always', 'never', and 'inode'
(default).

[1] https://lore.kernel.org/lkml/20200405061945.GA94792@iweiny-DESK2.sc.intel.com/

Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
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
index 88ab09ed29e7..d581b990e59a 100644
--- a/fs/xfs/xfs_mount.h
+++ b/fs/xfs/xfs_mount.h
@@ -233,7 +233,8 @@ typedef struct xfs_mount {
 						   allocator */
 #define XFS_MOUNT_NOATTR2	(1ULL << 25)	/* disable use of attr2 format */
 
-#define XFS_MOUNT_DAX		(1ULL << 62)	/* TEST ONLY! */
+#define XFS_MOUNT_DAX		(1ULL << 62)
+#define XFS_MOUNT_NODAX		(1ULL << 63)
 
 /*
  * Max and min values for mount-option defined I/O
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index 2094386af8ac..d7bd8f5e00c9 100644
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
+		mp->m_flags &= ~(XFS_MOUNT_DAX | XFS_MOUNT_NODAX);
+	} else if (val == XFS_DAX_ALWAYS) {
+		mp->m_flags &= ~XFS_MOUNT_NODAX;
+		mp->m_flags |= XFS_MOUNT_DAX;
+	} else if (val == XFS_DAX_NEVER) {
+		mp->m_flags &= ~XFS_MOUNT_DAX;
+		mp->m_flags |= XFS_MOUNT_NODAX;
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
-		{ XFS_MOUNT_DAX,		",dax" },
 		{ 0, NULL }
 	};
 	struct xfs_mount	*mp = XFS_M(root->d_sb);
@@ -185,6 +211,13 @@ xfs_fs_show_options(
 	if (!(mp->m_qflags & XFS_ALL_QUOTA_ACCT))
 		seq_puts(m, ",noquota");
 
+	if (mp->m_flags & XFS_MOUNT_DAX)
+		seq_puts(m, ",dax=always");
+	else if (mp->m_flags & XFS_MOUNT_NODAX)
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
-		mp->m_flags |= XFS_MOUNT_DAX;
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
-			mp->m_flags &= ~XFS_MOUNT_DAX;
+			xfs_mount_set_dax_mode(mp, XFS_DAX_NEVER);
 		}
 		if (xfs_sb_version_hasreflink(&mp->m_sb)) {
 			xfs_alert(mp,
-- 
2.25.1

