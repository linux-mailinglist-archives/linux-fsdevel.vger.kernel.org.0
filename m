Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FBB51D2849
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 May 2020 08:54:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbgENGxm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 May 2020 02:53:42 -0400
Received: from mga01.intel.com ([192.55.52.88]:15418 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726096AbgENGxY (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 May 2020 02:53:24 -0400
IronPort-SDR: ExV4tnhiDU8aDBuLdkEVDFXsySCFkTpoKg7kda+yER6dHHoRzA8HC1Kcaf0+5VbA6m1jRpl9Dn
 zdIl1D0kG8pg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2020 23:53:23 -0700
IronPort-SDR: Kybq8B7qokhtui/5MDtKmigHbXr5EgJUGPV4iL67SM6Ctiw8OBG7Wz47H396uLW48fQlA4mRPV
 IL9rZzhaE4JQ==
X-IronPort-AV: E=Sophos;i="5.73,390,1583222400"; 
   d="scan'208";a="437798102"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2020 23:53:22 -0700
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
Subject: [PATCH V1 6/9] fs/ext4: Only change S_DAX on inode load
Date:   Wed, 13 May 2020 23:53:12 -0700
Message-Id: <20200514065316.2500078-7-ira.weiny@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200514065316.2500078-1-ira.weiny@intel.com>
References: <20200514065316.2500078-1-ira.weiny@intel.com>
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
index 1a3daf2d18ef..86a0994332ce 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -2692,7 +2692,7 @@ extern int ext4_can_truncate(struct inode *inode);
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
index d3a4c2ed7a1c..23e42a223235 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -4419,11 +4419,13 @@ static bool ext4_should_enable_dax(struct inode *inode)
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
@@ -4434,8 +4436,13 @@ void ext4_set_inode_flags(struct inode *inode)
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
@@ -4649,7 +4656,7 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
 		 * not initialized on a new filesystem. */
 	}
 	ei->i_flags = le32_to_cpu(raw_inode->i_flags);
-	ext4_set_inode_flags(inode);
+	ext4_set_inode_flags(inode, true);
 	inode->i_blocks = ext4_inode_blocks(raw_inode, ei);
 	ei->i_file_acl = le32_to_cpu(raw_inode->i_file_acl_lo);
 	if (ext4_has_feature_64bit(sb))
diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index 5813e5e73eab..145083e8cd1e 100644
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
index d0434b513919..5ec900fdf73c 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1344,7 +1344,7 @@ static int ext4_set_context(struct inode *inode, const void *ctx, size_t len,
 			ext4_set_inode_flag(inode, EXT4_INODE_ENCRYPT);
 			ext4_clear_inode_state(inode,
 					EXT4_STATE_MAY_INLINE_DATA);
-			ext4_set_inode_flags(inode);
+			ext4_set_inode_flags(inode, false);
 		}
 		return res;
 	}
@@ -1367,7 +1367,7 @@ static int ext4_set_context(struct inode *inode, const void *ctx, size_t len,
 				    ctx, len, 0);
 	if (!res) {
 		ext4_set_inode_flag(inode, EXT4_INODE_ENCRYPT);
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

