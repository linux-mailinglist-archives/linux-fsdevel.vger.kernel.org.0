Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 350C65B0306
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Sep 2022 13:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbiIGLdn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Sep 2022 07:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbiIGLd2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Sep 2022 07:33:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A465B6D07;
        Wed,  7 Sep 2022 04:33:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EB2126187C;
        Wed,  7 Sep 2022 11:33:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 665D1C433C1;
        Wed,  7 Sep 2022 11:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662550406;
        bh=4Wib3fNt64VOneA2MVI2ZHf68wx0/SLas54CS8oHEX4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kR4FlIC2bVhB59ohkJXJHMSaHuEENO23KM51TfJLa/UHZOu9XaF048K9xokSS3PW6
         vxsZZ8p3u3gtn2dBIzhuqmEZn509LePD7s5jidCjt1prOuXkVVrkyOUtqdeawQW/oM
         w+1yzHKjXvXbIFj1ToqWkcr6sLL+44fJZ89SZH8gQ7mLG0U06bJyy6w6wJksPs47oQ
         XSFiFI0jLSF5uHQl1v0OHdtsASy2aPcSUE3f4GJoMYZv/qo2S/dApKWuqUhODa5v8u
         KloD/it+0WifBNh1fv1GVHYd7WeqS6O3A5IEGEHBqtAOly10a+ypT1KqJ4Sgt1XVxf
         CeQH8ZNtRrv1Q==
From:   Jeff Layton <jlayton@kernel.org>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, djwong@kernel.org,
        david@fromorbit.com, trondmy@hammerspace.com, neilb@suse.de,
        viro@zeniv.linux.org.uk, zohar@linux.ibm.com, xiubli@redhat.com,
        chuck.lever@oracle.com, lczerner@redhat.com, jack@suse.cz,
        bfields@fieldses.org, brauner@kernel.org, fweimer@redhat.com
Cc:     linux-api@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ceph-devel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: [PATCH v4 2/6] ext4: fix i_version handling in ext4
Date:   Wed,  7 Sep 2022 07:33:14 -0400
Message-Id: <20220907113318.21810-3-jlayton@kernel.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220907113318.21810-1-jlayton@kernel.org>
References: <20220907113318.21810-1-jlayton@kernel.org>
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
invalidations with NFSv4 and unnecessary remeasurements for IMA.

The increment in ext4_mark_iloc_dirty is also problematic since it can
corrupt the i_version counter for ea_inodes. We aren't bumping the file
times in ext4_mark_iloc_dirty, so changing the i_version there seems
wrong, and is the cause of both problems.

Remove that callsite and add increments to the setattr, setxattr and
ioctl codepaths, at the same times that we update the ctime. The
i_version bump that already happens during timestamp updates should take
care of the rest.

In ext4_move_extents, increment the i_version on both inodes, and also
add in missing ctime updates.

Cc: Lukas Czerner <lczerner@redhat.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Christian Brauner (Microsoft) <brauner@kernel.org>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ext4/inode.c       | 15 +++++----------
 fs/ext4/ioctl.c       |  8 ++++++++
 fs/ext4/move_extent.c |  8 ++++++++
 fs/ext4/xattr.c       |  2 ++
 4 files changed, 23 insertions(+), 10 deletions(-)

Note that this patch is based on top of this patch from Lukas:

    ext4: don't increase iversion counter for ea_inodes

It won't apply cleanly to mainline without that.

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 2a220be34caa..aa37bce4c541 100644
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
@@ -5731,14 +5734,6 @@ int ext4_mark_iloc_dirty(handle_t *handle,
 	}
 	ext4_fc_track_inode(handle, inode);
 
-	/*
-	 * ea_inodes are using i_version for storing reference count, don't
-	 * mess with it
-	 */
-	if (IS_I_VERSION(inode) &&
-	    !(EXT4_I(inode)->i_flags & EXT4_EA_INODE_FL))
-		inode_inc_iversion(inode);
-
 	/* the do_update_inode consumes one bh->b_count */
 	get_bh(iloc->bh);
 
diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index 3cf3ec4b1c21..60e77ae9342d 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -452,6 +452,8 @@ static long swap_inode_boot_loader(struct super_block *sb,
 	swap_inode_data(inode, inode_bl);
 
 	inode->i_ctime = inode_bl->i_ctime = current_time(inode);
+	if (IS_I_VERSION(inode))
+		inode_inc_iversion(inode);
 
 	inode->i_generation = prandom_u32();
 	inode_bl->i_generation = prandom_u32();
@@ -665,6 +667,8 @@ static int ext4_ioctl_setflags(struct inode *inode,
 	ext4_set_inode_flags(inode, false);
 
 	inode->i_ctime = current_time(inode);
+	if (IS_I_VERSION(inode))
+		inode_inc_iversion(inode);
 
 	err = ext4_mark_iloc_dirty(handle, inode, &iloc);
 flags_err:
@@ -775,6 +779,8 @@ static int ext4_ioctl_setproject(struct inode *inode, __u32 projid)
 
 	EXT4_I(inode)->i_projid = kprojid;
 	inode->i_ctime = current_time(inode);
+	if (IS_I_VERSION(inode))
+		inode_inc_iversion(inode);
 out_dirty:
 	rc = ext4_mark_iloc_dirty(handle, inode, &iloc);
 	if (!err)
@@ -1257,6 +1263,8 @@ static long __ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		err = ext4_reserve_inode_write(handle, inode, &iloc);
 		if (err == 0) {
 			inode->i_ctime = current_time(inode);
+			if (IS_I_VERSION(inode))
+				inode_inc_iversion(inode);
 			inode->i_generation = generation;
 			err = ext4_mark_iloc_dirty(handle, inode, &iloc);
 		}
diff --git a/fs/ext4/move_extent.c b/fs/ext4/move_extent.c
index 701f1d6a217f..d73ab3153218 100644
--- a/fs/ext4/move_extent.c
+++ b/fs/ext4/move_extent.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/fs.h>
+#include <linux/iversion.h>
 #include <linux/quotaops.h>
 #include <linux/slab.h>
 #include <linux/sched/mm.h>
@@ -683,6 +684,13 @@ ext4_move_extents(struct file *o_filp, struct file *d_filp, __u64 orig_blk,
 			break;
 		o_start += cur_len;
 		d_start += cur_len;
+
+		orig_inode->i_ctime = current_time(orig_inode);
+		donor_inode->i_ctime = current_time(donor_inode);
+		if (IS_I_VERSION(orig_inode))
+			inode_inc_iversion(orig_inode);
+		if (IS_I_VERSION(donor_inode))
+			inode_inc_iversion(donor_inode);
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
2.37.3

