Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D52041E6529
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 May 2020 17:01:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404037AbgE1PAU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 May 2020 11:00:20 -0400
Received: from mga09.intel.com ([134.134.136.24]:7520 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404022AbgE1PAO (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 May 2020 11:00:14 -0400
IronPort-SDR: 4lV4agil5GtLim3Y439XlfjHz5F7j3Z0LWBMf3tWQn7QGF48VplY3f0ItkdZWlQc40NbRR7CIX
 WW91jjZ/Nvyg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2020 08:00:09 -0700
IronPort-SDR: pM4wjcuPZRQ5vwDho/yQiEyZonBjz3nKr5g1cDiMgTK9IFSqR6p66oTovWoO44rBrFz2zvNI00
 RmIB6JvYOCVA==
X-IronPort-AV: E=Sophos;i="5.73,445,1583222400"; 
   d="scan'208";a="285191585"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2020 08:00:08 -0700
From:   ira.weiny@intel.com
To:     linux-ext4@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        Eric Biggers <ebiggers@kernel.org>
Cc:     Ira Weiny <ira.weiny@intel.com>, Al Viro <viro@zeniv.linux.org.uk>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>, Jeff Moyer <jmoyer@redhat.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V5 5/9] fs/ext4: Only change S_DAX on inode load
Date:   Thu, 28 May 2020 07:59:59 -0700
Message-Id: <20200528150003.828793-6-ira.weiny@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200528150003.828793-1-ira.weiny@intel.com>
References: <20200528150003.828793-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

To prevent complications with in memory inodes we only set S_DAX on
inode load.  FS_XFLAG_DAX can be changed at any time and S_DAX will
change after inode eviction and reload.

Add init bool to ext4_set_inode_flags() to indicate if the inode is
being newly initialized.

Assert that S_DAX is not set on an inode which is just being loaded.

Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes from V2:
	Rework based on moving the encryption patch to the end.

Changes from RFC:
	Change J_ASSERT() to WARN_ON_ONCE()
	Fix bug which would clear S_DAX incorrectly
---
 fs/ext4/ext4.h   |  2 +-
 fs/ext4/ialloc.c |  2 +-
 fs/ext4/inode.c  | 13 ++++++++++---
 fs/ext4/ioctl.c  |  3 ++-
 fs/ext4/super.c  |  4 ++--
 fs/ext4/verity.c |  2 +-
 6 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 3fdd044304a0..94e213e6d8ca 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -2693,7 +2693,7 @@ extern int ext4_can_truncate(struct inode *inode);
 extern int ext4_truncate(struct inode *);
 extern int ext4_break_layouts(struct inode *);
 extern int ext4_punch_hole(struct inode *inode, loff_t offset, loff_t length);
-extern void ext4_set_inode_flags(struct inode *);
+extern void ext4_set_inode_flags(struct inode *, bool init);
 extern int ext4_alloc_da_blocks(struct inode *inode);
 extern void ext4_set_aops(struct inode *inode);
 extern int ext4_writepage_trans_blocks(struct inode *);
diff --git a/fs/ext4/ialloc.c b/fs/ext4/ialloc.c
index 4b8c9a9bdf0c..7941c140723f 100644
--- a/fs/ext4/ialloc.c
+++ b/fs/ext4/ialloc.c
@@ -1116,7 +1116,7 @@ struct inode *__ext4_new_inode(handle_t *handle, struct inode *dir,
 	ei->i_block_group = group;
 	ei->i_last_alloc_group = ~0;
 
-	ext4_set_inode_flags(inode);
+	ext4_set_inode_flags(inode, true);
 	if (IS_DIRSYNC(inode))
 		ext4_handle_sync(handle);
 	if (insert_inode_locked(inode) < 0) {
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 6532870f6a0b..01636cf5f322 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -4420,11 +4420,13 @@ static bool ext4_should_enable_dax(struct inode *inode)
 	return false;
 }
 
-void ext4_set_inode_flags(struct inode *inode)
+void ext4_set_inode_flags(struct inode *inode, bool init)
 {
 	unsigned int flags = EXT4_I(inode)->i_flags;
 	unsigned int new_fl = 0;
 
+	WARN_ON_ONCE(IS_DAX(inode) && init);
+
 	if (flags & EXT4_SYNC_FL)
 		new_fl |= S_SYNC;
 	if (flags & EXT4_APPEND_FL)
@@ -4435,8 +4437,13 @@ void ext4_set_inode_flags(struct inode *inode)
 		new_fl |= S_NOATIME;
 	if (flags & EXT4_DIRSYNC_FL)
 		new_fl |= S_DIRSYNC;
-	if (ext4_should_enable_dax(inode))
+
+	/* Because of the way inode_set_flags() works we must preserve S_DAX
+	 * here if already set. */
+	new_fl |= (inode->i_flags & S_DAX);
+	if (init && ext4_should_enable_dax(inode))
 		new_fl |= S_DAX;
+
 	if (flags & EXT4_ENCRYPT_FL)
 		new_fl |= S_ENCRYPTED;
 	if (flags & EXT4_CASEFOLD_FL)
@@ -4650,7 +4657,7 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
 		 * not initialized on a new filesystem. */
 	}
 	ei->i_flags = le32_to_cpu(raw_inode->i_flags);
-	ext4_set_inode_flags(inode);
+	ext4_set_inode_flags(inode, true);
 	inode->i_blocks = ext4_inode_blocks(raw_inode, ei);
 	ei->i_file_acl = le32_to_cpu(raw_inode->i_file_acl_lo);
 	if (ext4_has_feature_64bit(sb))
diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index f23168387deb..7ccf20b1488b 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -381,7 +381,8 @@ static int ext4_ioctl_setflags(struct inode *inode,
 			ext4_clear_inode_flag(inode, i);
 	}
 
-	ext4_set_inode_flags(inode);
+	ext4_set_inode_flags(inode, false);
+
 	inode->i_ctime = current_time(inode);
 
 	err = ext4_mark_iloc_dirty(handle, inode, &iloc);
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index f7d76dcaedfe..80eb814c47eb 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1348,7 +1348,7 @@ static int ext4_set_context(struct inode *inode, const void *ctx, size_t len,
 			 * Update inode->i_flags - S_ENCRYPTED will be enabled,
 			 * S_DAX may be disabled
 			 */
-			ext4_set_inode_flags(inode);
+			ext4_set_inode_flags(inode, false);
 		}
 		return res;
 	}
@@ -1375,7 +1375,7 @@ static int ext4_set_context(struct inode *inode, const void *ctx, size_t len,
 		 * Update inode->i_flags - S_ENCRYPTED will be enabled,
 		 * S_DAX may be disabled
 		 */
-		ext4_set_inode_flags(inode);
+		ext4_set_inode_flags(inode, false);
 		res = ext4_mark_inode_dirty(handle, inode);
 		if (res)
 			EXT4_ERROR_INODE(inode, "Failed to mark inode dirty");
diff --git a/fs/ext4/verity.c b/fs/ext4/verity.c
index f05a09fb2ae4..89a155ece323 100644
--- a/fs/ext4/verity.c
+++ b/fs/ext4/verity.c
@@ -244,7 +244,7 @@ static int ext4_end_enable_verity(struct file *filp, const void *desc,
 		if (err)
 			goto out_stop;
 		ext4_set_inode_flag(inode, EXT4_INODE_VERITY);
-		ext4_set_inode_flags(inode);
+		ext4_set_inode_flags(inode, false);
 		err = ext4_mark_iloc_dirty(handle, inode, &iloc);
 	}
 out_stop:
-- 
2.25.1

