Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C48271A721F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Apr 2020 06:01:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726458AbgDNEBB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Apr 2020 00:01:01 -0400
Received: from mga06.intel.com ([134.134.136.31]:50669 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726330AbgDNEA6 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Apr 2020 00:00:58 -0400
IronPort-SDR: TzKqGIGIxIXWzYZdCOFzc6bllplW3QZaNnD/5QgdHI9gKbtMaxANFsgAi2GaVHhgaQiP39Ugds
 bvQPTyIFcmzA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2020 21:00:54 -0700
IronPort-SDR: 11MaLzUFtLlYlq1VFTGosvq+vPNuERq06CTUwZP98hldIDbBqsnJPLi59xFBdy33batTh3EPG4
 +itqV1eQwJeg==
X-IronPort-AV: E=Sophos;i="5.72,381,1580803200"; 
   d="scan'208";a="269266869"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2020 21:00:53 -0700
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
Subject: [PATCH RFC 7/8] fs/ext4: Only change S_DAX on inode load
Date:   Mon, 13 Apr 2020 21:00:29 -0700
Message-Id: <20200414040030.1802884-8-ira.weiny@intel.com>
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

To prevent complications with in memory inodes we only set S_DAX on
inode load.  FS_XFLAG_DAX can be changed at any time and S_DAX will
change after inode eviction and reload.

Add init bool to ext4_set_inode_flags() to indicate if the inode is
being newly initialized.

Assert that S_DAX is not set on an inode which is just being loaded.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 fs/ext4/ext4.h   | 2 +-
 fs/ext4/ialloc.c | 2 +-
 fs/ext4/inode.c  | 8 +++++---
 fs/ext4/ioctl.c  | 3 ++-
 fs/ext4/super.c  | 4 ++--
 fs/ext4/verity.c | 2 +-
 6 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index aadf33d5b37d..7f9234cce5b8 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -2699,7 +2699,7 @@ extern int ext4_can_truncate(struct inode *inode);
 extern int ext4_truncate(struct inode *);
 extern int ext4_break_layouts(struct inode *);
 extern int ext4_punch_hole(struct inode *inode, loff_t offset, loff_t length);
-extern void ext4_set_inode_flags(struct inode *);
+extern void ext4_set_inode_flags(struct inode *, bool init);
 extern int ext4_alloc_da_blocks(struct inode *inode);
 extern void ext4_set_aops(struct inode *inode);
 extern int ext4_writepage_trans_blocks(struct inode *);
diff --git a/fs/ext4/ialloc.c b/fs/ext4/ialloc.c
index f95ee99091e4..1519a4bf42fa 100644
--- a/fs/ext4/ialloc.c
+++ b/fs/ext4/ialloc.c
@@ -1104,7 +1104,7 @@ struct inode *__ext4_new_inode(handle_t *handle, struct inode *dir,
 	ei->i_block_group = group;
 	ei->i_last_alloc_group = ~0;
 
-	ext4_set_inode_flags(inode);
+	ext4_set_inode_flags(inode, true);
 	if (IS_DIRSYNC(inode))
 		ext4_handle_sync(handle);
 	if (insert_inode_locked(inode) < 0) {
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index e9d582e516bc..e9dfdfd6c698 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -4408,11 +4408,13 @@ static bool ext4_enable_dax(struct inode *inode)
 	return (flags & EXT4_DAX_FL) == EXT4_DAX_FL;
 }
 
-void ext4_set_inode_flags(struct inode *inode)
+void ext4_set_inode_flags(struct inode *inode, bool init)
 {
 	unsigned int flags = EXT4_I(inode)->i_flags;
 	unsigned int new_fl = 0;
 
+	J_ASSERT(!(IS_DAX(inode) && init));
+
 	if (flags & EXT4_SYNC_FL)
 		new_fl |= S_SYNC;
 	if (flags & EXT4_APPEND_FL)
@@ -4423,7 +4425,7 @@ void ext4_set_inode_flags(struct inode *inode)
 		new_fl |= S_NOATIME;
 	if (flags & EXT4_DIRSYNC_FL)
 		new_fl |= S_DIRSYNC;
-	if (ext4_enable_dax(inode))
+	if (init && ext4_enable_dax(inode))
 		new_fl |= S_DAX;
 	if (flags & EXT4_ENCRYPT_FL)
 		new_fl |= S_ENCRYPTED;
@@ -4639,7 +4641,7 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
 		 * not initialized on a new filesystem. */
 	}
 	ei->i_flags = le32_to_cpu(raw_inode->i_flags);
-	ext4_set_inode_flags(inode);
+	ext4_set_inode_flags(inode, true);
 	inode->i_blocks = ext4_inode_blocks(raw_inode, ei);
 	ei->i_file_acl = le32_to_cpu(raw_inode->i_file_acl_lo);
 	if (ext4_has_feature_64bit(sb))
diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index ca07d5086f03..efe41dcc8807 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -393,7 +393,8 @@ static int ext4_ioctl_setflags(struct inode *inode,
 			ext4_clear_inode_flag(inode, i);
 	}
 
-	ext4_set_inode_flags(inode);
+	ext4_set_inode_flags(inode, false);
+
 	inode->i_ctime = current_time(inode);
 
 	err = ext4_mark_iloc_dirty(handle, inode, &iloc);
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 0175fbfeb2ea..43cc52ea7918 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1349,7 +1349,7 @@ static int ext4_set_context(struct inode *inode, const void *ctx, size_t len,
 			ext4_set_inode_flag(inode, EXT4_INODE_ENCRYPT);
 			ext4_clear_inode_state(inode,
 					EXT4_STATE_MAY_INLINE_DATA);
-			ext4_set_inode_flags(inode);
+			ext4_set_inode_flags(inode, false);
 		}
 		return res;
 	}
@@ -1372,7 +1372,7 @@ static int ext4_set_context(struct inode *inode, const void *ctx, size_t len,
 				    ctx, len, 0);
 	if (!res) {
 		ext4_set_inode_flag(inode, EXT4_INODE_ENCRYPT);
-		ext4_set_inode_flags(inode);
+		ext4_set_inode_flags(inode, false);
 		res = ext4_mark_inode_dirty(handle, inode);
 		if (res)
 			EXT4_ERROR_INODE(inode, "Failed to mark inode dirty");
diff --git a/fs/ext4/verity.c b/fs/ext4/verity.c
index ce3f9a198d3b..4f7d780ff6da 100644
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

