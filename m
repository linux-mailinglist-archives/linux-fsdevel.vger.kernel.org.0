Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C69601A722F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Apr 2020 06:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405009AbgDNEBh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Apr 2020 00:01:37 -0400
Received: from mga09.intel.com ([134.134.136.24]:28534 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726161AbgDNEAv (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Apr 2020 00:00:51 -0400
IronPort-SDR: e4rkJAwdg3ZInutHoJh53ZH7Iw3N5W8T0h//4fzqo17vBhKxDpFJzfCWVLl1VQ3PLfnY9G2MYh
 Oti6t8ntROOA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2020 21:00:50 -0700
IronPort-SDR: 2H6ZBl4aJBt3r1iHe+xnzTEJdzxLwhuBNnKFF2QrVz6sHR/HpS0UCmTvd086rot3zvUMlz0L6A
 cQ8/Slv4nwvQ==
X-IronPort-AV: E=Sophos;i="5.72,381,1580803200"; 
   d="scan'208";a="243709788"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2020 21:00:49 -0700
From:   ira.weiny@intel.com
To:     linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jeff Moyer <jmoyer@redhat.com>,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH RFC 5/8] fs/ext4: Make DAX mount option a tri-state
Date:   Mon, 13 Apr 2020 21:00:27 -0700
Message-Id: <20200414040030.1802884-6-ira.weiny@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200414040030.1802884-1-ira.weiny@intel.com>
References: <20200414040030.1802884-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

We add 'always', 'never', and 'inode' (default).  '-o dax' continue to
operate the same.

Specifically we introduce a 2nd DAX mount flag EXT4_MOUNT_NODAX and set
it and EXT4_MOUNT_DAX appropriately.

We also force EXT4_MOUNT_NODAX if !CONFIG_FS_DAX.

https://lore.kernel.org/lkml/20200405061945.GA94792@iweiny-DESK2.sc.intel.com/

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 fs/ext4/ext4.h  |  1 +
 fs/ext4/super.c | 43 +++++++++++++++++++++++++++++++++++++++----
 2 files changed, 40 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 434021fcec88..aadf33d5b37d 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1174,6 +1174,7 @@ struct ext4_inode_info {
 						      blocks */
 #define EXT4_MOUNT2_HURD_COMPAT		0x00000004 /* Support HURD-castrated
 						      file systems */
+#define EXT4_MOUNT2_NODAX		0x00000008 /* Do not allow Direct Access */
 
 #define EXT4_MOUNT2_EXPLICIT_JOURNAL_CHECKSUM	0x00000008 /* User explicitly
 						specified journal checksum */
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index b14863058115..0175fbfeb2ea 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1510,6 +1510,7 @@ enum {
 	Opt_jqfmt_vfsold, Opt_jqfmt_vfsv0, Opt_jqfmt_vfsv1, Opt_quota,
 	Opt_noquota, Opt_barrier, Opt_nobarrier, Opt_err,
 	Opt_usrquota, Opt_grpquota, Opt_prjquota, Opt_i_version, Opt_dax,
+	Opt_dax_str,
 	Opt_stripe, Opt_delalloc, Opt_nodelalloc, Opt_warn_on_error,
 	Opt_nowarn_on_error, Opt_mblk_io_submit,
 	Opt_lazytime, Opt_nolazytime, Opt_debug_want_extra_isize,
@@ -1575,6 +1576,7 @@ static const match_table_t tokens = {
 	{Opt_barrier, "barrier"},
 	{Opt_nobarrier, "nobarrier"},
 	{Opt_i_version, "i_version"},
+	{Opt_dax_str, "dax=%s"},
 	{Opt_dax, "dax"},
 	{Opt_stripe, "stripe=%u"},
 	{Opt_delalloc, "delalloc"},
@@ -1772,6 +1774,7 @@ static const struct mount_opts {
 	{Opt_min_batch_time, 0, MOPT_GTE0},
 	{Opt_inode_readahead_blks, 0, MOPT_GTE0},
 	{Opt_init_itable, 0, MOPT_GTE0},
+	{Opt_dax_str, 0, MOPT_STRING},
 	{Opt_dax, EXT4_MOUNT_DAX, MOPT_SET},
 	{Opt_stripe, 0, MOPT_GTE0},
 	{Opt_resuid, 0, MOPT_GTE0},
@@ -2081,13 +2084,32 @@ static int handle_mount_opt(struct super_block *sb, char *opt, int token,
 		}
 		sbi->s_jquota_fmt = m->mount_opt;
 #endif
-	} else if (token == Opt_dax) {
+	} else if (token == Opt_dax || token == Opt_dax_str) {
 #ifdef CONFIG_FS_DAX
-		ext4_msg(sb, KERN_WARNING,
-		"DAX enabled. Warning: EXPERIMENTAL, use at your own risk");
-		sbi->s_mount_opt |= m->mount_opt;
+		char *tmp = match_strdup(&args[0]);
+
+		if (!tmp || !strcmp(tmp, "always")) {
+			ext4_msg(sb, KERN_WARNING,
+				"DAX enabled. Warning: EXPERIMENTAL, use at your own risk");
+			sbi->s_mount_opt |= EXT4_MOUNT_DAX;
+			sbi->s_mount_opt2 &= ~EXT4_MOUNT2_NODAX;
+		} else if (!strcmp(tmp, "never")) {
+			sbi->s_mount_opt2 |= EXT4_MOUNT2_NODAX;
+			sbi->s_mount_opt &= ~EXT4_MOUNT_DAX;
+		} else if (!strcmp(tmp, "inode")) {
+			sbi->s_mount_opt &= ~EXT4_MOUNT_DAX;
+			sbi->s_mount_opt2 &= ~EXT4_MOUNT2_NODAX;
+		} else {
+			ext4_msg(sb, KERN_WARNING, "DAX invalid option.");
+			kfree(tmp);
+			return -1;
+		}
+
+		kfree(tmp);
 #else
 		ext4_msg(sb, KERN_INFO, "dax option not supported");
+		sbi->s_mount_opt2 |= EXT4_MOUNT2_NODAX;
+		sbi->s_mount_opt &= ~EXT4_MOUNT_DAX;
 		return -1;
 #endif
 	} else if (token == Opt_data_err_abort) {
@@ -2303,6 +2325,13 @@ static int _ext4_show_options(struct seq_file *seq, struct super_block *sb,
 	if (DUMMY_ENCRYPTION_ENABLED(sbi))
 		SEQ_OPTS_PUTS("test_dummy_encryption");
 
+	if (test_opt2(sb, NODAX))
+		SEQ_OPTS_PUTS("dax=never");
+	else if (test_opt(sb, DAX))
+		SEQ_OPTS_PUTS("dax=always");
+	else
+		SEQ_OPTS_PUTS("dax=inode");
+
 	ext4_show_quota_options(seq, sb);
 	return 0;
 }
@@ -5424,6 +5453,12 @@ static int ext4_remount(struct super_block *sb, int *flags, char *data)
 		sbi->s_mount_opt ^= EXT4_MOUNT_DAX;
 	}
 
+	if ((sbi->s_mount_opt2 ^ old_opts.s_mount_opt2) & EXT4_MOUNT2_NODAX) {
+		ext4_msg(sb, KERN_WARNING, "warning: refusing change of "
+			"non-dax flag with busy inodes while remounting");
+		sbi->s_mount_opt2 ^= EXT4_MOUNT2_NODAX;
+	}
+
 	if (sbi->s_mount_flags & EXT4_MF_FS_ABORTED)
 		ext4_abort(sb, "Abort forced by user");
 
-- 
2.25.1

