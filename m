Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A48A71D069C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 May 2020 07:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729327AbgEMFoC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 May 2020 01:44:02 -0400
Received: from mga17.intel.com ([192.55.52.151]:48154 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729097AbgEMFnc (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 May 2020 01:43:32 -0400
IronPort-SDR: RIqRFfQKH6MI8jL2EbxKASLZ7d/ut6frXCUVs3a8utZj50A687I8nehyIfW5xyMC3oifJIBRZF
 EWA6FbG4eApw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2020 22:43:31 -0700
IronPort-SDR: 0FNEDahFUAytvHTHYrpqkBTtxMkgm/U0POFMu9f/Au0SdcATw7m3q0zmQ5VD6YswL8BLxpIBQ8
 htJs+4AkHMKA==
X-IronPort-AV: E=Sophos;i="5.73,386,1583222400"; 
   d="scan'208";a="251134852"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2020 22:43:30 -0700
From:   ira.weiny@intel.com
To:     linux-ext4@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>
Cc:     Ira Weiny <ira.weiny@intel.com>, Al Viro <viro@zeniv.linux.org.uk>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>, Jeff Moyer <jmoyer@redhat.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/9] fs/ext4: Change EXT4_MOUNT_DAX to EXT4_MOUNT_DAX_ALWAYS
Date:   Tue, 12 May 2020 22:43:19 -0700
Message-Id: <20200513054324.2138483-5-ira.weiny@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200513054324.2138483-1-ira.weiny@intel.com>
References: <20200513054324.2138483-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

In prep for the new tri-state mount option which then introduces
EXT4_MOUNT_DAX_NEVER.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes:
	New patch
---
 fs/ext4/ext4.h  |  4 ++--
 fs/ext4/inode.c |  2 +-
 fs/ext4/super.c | 12 ++++++------
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 91eb4381cae5..1a3daf2d18ef 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1123,9 +1123,9 @@ struct ext4_inode_info {
 #define EXT4_MOUNT_MINIX_DF		0x00080	/* Mimics the Minix statfs */
 #define EXT4_MOUNT_NOLOAD		0x00100	/* Don't use existing journal*/
 #ifdef CONFIG_FS_DAX
-#define EXT4_MOUNT_DAX			0x00200	/* Direct Access */
+#define EXT4_MOUNT_DAX_ALWAYS		0x00200	/* Direct Access */
 #else
-#define EXT4_MOUNT_DAX			0
+#define EXT4_MOUNT_DAX_ALWAYS		0
 #endif
 #define EXT4_MOUNT_DATA_FLAGS		0x00C00	/* Mode for data writes: */
 #define EXT4_MOUNT_JOURNAL_DATA		0x00400	/* Write data to journal */
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 2a4aae6acdcb..a10ff12194db 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -4400,7 +4400,7 @@ int ext4_get_inode_loc(struct inode *inode, struct ext4_iloc *iloc)
 
 static bool ext4_should_use_dax(struct inode *inode)
 {
-	if (!test_opt(inode->i_sb, DAX))
+	if (!test_opt(inode->i_sb, DAX_ALWAYS))
 		return false;
 	if (!S_ISREG(inode->i_mode))
 		return false;
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 9873ab27e3fa..d0434b513919 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1767,7 +1767,7 @@ static const struct mount_opts {
 	{Opt_min_batch_time, 0, MOPT_GTE0},
 	{Opt_inode_readahead_blks, 0, MOPT_GTE0},
 	{Opt_init_itable, 0, MOPT_GTE0},
-	{Opt_dax, EXT4_MOUNT_DAX, MOPT_SET},
+	{Opt_dax, EXT4_MOUNT_DAX_ALWAYS, MOPT_SET},
 	{Opt_stripe, 0, MOPT_GTE0},
 	{Opt_resuid, 0, MOPT_GTE0},
 	{Opt_resgid, 0, MOPT_GTE0},
@@ -3974,7 +3974,7 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 				 "both data=journal and dioread_nolock");
 			goto failed_mount;
 		}
-		if (test_opt(sb, DAX)) {
+		if (test_opt(sb, DAX_ALWAYS)) {
 			ext4_msg(sb, KERN_ERR, "can't mount with "
 				 "both data=journal and dax");
 			goto failed_mount;
@@ -4084,7 +4084,7 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 		goto failed_mount;
 	}
 
-	if (sbi->s_mount_opt & EXT4_MOUNT_DAX) {
+	if (sbi->s_mount_opt & EXT4_MOUNT_DAX_ALWAYS) {
 		if (ext4_has_feature_inline_data(sb)) {
 			ext4_msg(sb, KERN_ERR, "Cannot use DAX on a filesystem"
 					" that may contain inline data");
@@ -5404,7 +5404,7 @@ static int ext4_remount(struct super_block *sb, int *flags, char *data)
 			err = -EINVAL;
 			goto restore_opts;
 		}
-		if (test_opt(sb, DAX)) {
+		if (test_opt(sb, DAX_ALWAYS)) {
 			ext4_msg(sb, KERN_ERR, "can't mount with "
 				 "both data=journal and dax");
 			err = -EINVAL;
@@ -5425,10 +5425,10 @@ static int ext4_remount(struct super_block *sb, int *flags, char *data)
 		goto restore_opts;
 	}
 
-	if ((sbi->s_mount_opt ^ old_opts.s_mount_opt) & EXT4_MOUNT_DAX) {
+	if ((sbi->s_mount_opt ^ old_opts.s_mount_opt) & EXT4_MOUNT_DAX_ALWAYS) {
 		ext4_msg(sb, KERN_WARNING, "warning: refusing change of "
 			"dax flag with busy inodes while remounting");
-		sbi->s_mount_opt ^= EXT4_MOUNT_DAX;
+		sbi->s_mount_opt ^= EXT4_MOUNT_DAX_ALWAYS;
 	}
 
 	if (sbi->s_mount_flags & EXT4_MF_FS_ABORTED)
-- 
2.25.1

