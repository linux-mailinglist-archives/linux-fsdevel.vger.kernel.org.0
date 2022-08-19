Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4632599B3B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Aug 2022 13:44:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348039AbiHSLg3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Aug 2022 07:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347810AbiHSLg1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Aug 2022 07:36:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55B6BFBA44;
        Fri, 19 Aug 2022 04:36:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9B7E1617A5;
        Fri, 19 Aug 2022 11:36:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26045C433D6;
        Fri, 19 Aug 2022 11:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660908983;
        bh=61pC1LZYV2wv2vRQkL0OkPWqt2TK2A8MryhxdAKSASA=;
        h=From:To:Cc:Subject:Date:From;
        b=A4xAOx2avmL5yMb6/QRrjqEzKVxqz2Wfhla/kPFrVikOgaAFHPw3c64JxoR31lBg7
         L6FSAC+dghOkIkQQiUeVBIeUt6XnG6IIKDYy2/WLvuP3CCGnrr+31xQw5bQd/8pbG8
         KoPmeDU2TcKqFWVzQVmFs08qvG+T0fG1oef0zqPV/LVnHAcwUfRlo5wPuXA8JfqBdU
         K5vbPxj5fEnxiNCFMEWBgprlvROry0vs1AWweIO1wD15MSJ8YetnpWdCjPQzCypX8N
         Q9MP+a5Xhl03aY9OqqW8U0fWovskKxFW1gnpFxG7ghwVNqqP9t9DjppPBsLA2sR+q4
         k39i2XZdY2dpQ==
From:   Jeff Layton <jlayton@kernel.org>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-integrity@vger.kernel.org,
        Lukas Czerner <lczerner@redhat.com>, Jan Kara <jack@suse.cz>,
        Christian Brauner <brauner@kernel.org>
Subject: [PATCH] ext4: fix i_version handling in ext4
Date:   Fri, 19 Aug 2022 07:36:20 -0400
Message-Id: <20220819113620.12048-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

ext4 currently updates the i_version counter when the atime is updated
during a read. This is less than ideal as it can cause unnecessary cache
invalidations with NFSv4 and unnecessary remeasurements for IMA. The
increment in ext4_mark_iloc_dirty is also problematic since it can also
corrupt the i_version counter for ea_inodes. We aren't bumping the file
times in ext4_mark_iloc_dirty, so changing the i_version there seems
wrong, and is the cause of both problems.

Remove that callsite and add increments to the setattr, setxattr and
ioctl codepaths (at the same time that we update the ctime). The
i_version bump that already happens during timestamp updates should take
care of the rest.

In ext4_move_extents, increment the i_version on both inodes, and also
add in missing ctime updates.

Cc: Lukas Czerner <lczerner@redhat.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Christian Brauner (Microsoft) <brauner@kernel.org>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ext4/inode.c       | 10 +++++-----
 fs/ext4/ioctl.c       |  4 ++++
 fs/ext4/move_extent.c |  6 ++++++
 fs/ext4/xattr.c       |  2 ++
 4 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 601214453c3a..aa37bce4c541 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5342,6 +5342,7 @@ int ext4_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 	int error, rc = 0;
 	int orphan = 0;
 	const unsigned int ia_valid = attr->ia_valid;
+	bool inc_ivers = IS_I_VERSION(inode);
 
 	if (unlikely(ext4_forced_shutdown(EXT4_SB(inode->i_sb))))
 		return -EIO;
@@ -5425,8 +5426,8 @@ int ext4_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 			return -EINVAL;
 		}
 
-		if (IS_I_VERSION(inode) && attr->ia_size != inode->i_size)
-			inode_inc_iversion(inode);
+		if (attr->ia_size == inode->i_size)
+			inc_ivers = false;
 
 		if (shrink) {
 			if (ext4_should_order_data(inode)) {
@@ -5528,6 +5529,8 @@ int ext4_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 	}
 
 	if (!error) {
+		if (inc_ivers)
+			inode_inc_iversion(inode);
 		setattr_copy(mnt_userns, inode, attr);
 		mark_inode_dirty(inode);
 	}
@@ -5731,9 +5734,6 @@ int ext4_mark_iloc_dirty(handle_t *handle,
 	}
 	ext4_fc_track_inode(handle, inode);
 
-	if (IS_I_VERSION(inode))
-		inode_inc_iversion(inode);
-
 	/* the do_update_inode consumes one bh->b_count */
 	get_bh(iloc->bh);
 
diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index 3cf3ec4b1c21..ad3a294a88eb 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -452,6 +452,7 @@ static long swap_inode_boot_loader(struct super_block *sb,
 	swap_inode_data(inode, inode_bl);
 
 	inode->i_ctime = inode_bl->i_ctime = current_time(inode);
+	inode_inc_iversion(inode);
 
 	inode->i_generation = prandom_u32();
 	inode_bl->i_generation = prandom_u32();
@@ -665,6 +666,7 @@ static int ext4_ioctl_setflags(struct inode *inode,
 	ext4_set_inode_flags(inode, false);
 
 	inode->i_ctime = current_time(inode);
+	inode_inc_iversion(inode);
 
 	err = ext4_mark_iloc_dirty(handle, inode, &iloc);
 flags_err:
@@ -775,6 +777,7 @@ static int ext4_ioctl_setproject(struct inode *inode, __u32 projid)
 
 	EXT4_I(inode)->i_projid = kprojid;
 	inode->i_ctime = current_time(inode);
+	inode_inc_iversion(inode);
 out_dirty:
 	rc = ext4_mark_iloc_dirty(handle, inode, &iloc);
 	if (!err)
@@ -1257,6 +1260,7 @@ static long __ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		err = ext4_reserve_inode_write(handle, inode, &iloc);
 		if (err == 0) {
 			inode->i_ctime = current_time(inode);
+			inode_inc_iversion(inode);
 			inode->i_generation = generation;
 			err = ext4_mark_iloc_dirty(handle, inode, &iloc);
 		}
diff --git a/fs/ext4/move_extent.c b/fs/ext4/move_extent.c
index 701f1d6a217f..285700b00d38 100644
--- a/fs/ext4/move_extent.c
+++ b/fs/ext4/move_extent.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/fs.h>
+#include <linux/iversion.h>
 #include <linux/quotaops.h>
 #include <linux/slab.h>
 #include <linux/sched/mm.h>
@@ -683,6 +684,11 @@ ext4_move_extents(struct file *o_filp, struct file *d_filp, __u64 orig_blk,
 			break;
 		o_start += cur_len;
 		d_start += cur_len;
+
+		orig_inode->i_ctime = current_time(orig_inode);
+		donor_inode->i_ctime = current_time(donor_inode);
+		inode_inc_iversion(orig_inode);
+		inode_inc_iversion(donor_inode);
 	}
 	*moved_len = o_start - orig_blk;
 	if (*moved_len > len)
diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index 533216e80fa2..e975442e4ab2 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -2412,6 +2412,8 @@ ext4_xattr_set_handle(handle_t *handle, struct inode *inode, int name_index,
 	if (!error) {
 		ext4_xattr_update_super_block(handle, inode->i_sb);
 		inode->i_ctime = current_time(inode);
+		if (IS_I_VERSION(inode))
+			inode_inc_iversion(inode);
 		if (!value)
 			no_expand = 0;
 		error = ext4_mark_iloc_dirty(handle, inode, &is.iloc);
-- 
2.37.2

