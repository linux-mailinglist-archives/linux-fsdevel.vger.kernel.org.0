Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B013B7B8CEC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Oct 2023 21:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245214AbjJDS5f (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Oct 2023 14:57:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244856AbjJDSzd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Oct 2023 14:55:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C5F91725;
        Wed,  4 Oct 2023 11:54:51 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D90DC433CC;
        Wed,  4 Oct 2023 18:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696445690;
        bh=vmHegbrB1oSokmePb7JoVPLdiAExigQLg7wn3ynfsJw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=INItqUqaI27NvvvE5+f2tZOATG7etmaMQ+tvY1oJvHuuW4o8Y2c87saqn55UH9C6A
         l59gMO03/odl8au7XqZQiOVHe+bDbIn+ysKo01RdRJCpfFdoxXMr2SdUUramm+2B5j
         JyYL5mEpRvzVvSP8Qp2ViY3eozbrGuEvkbSBiKP8oQRRLXX2V7RubNokI/9gZ0GvpJ
         ES7lzuheQGCSyr73HqNRYcFJrpW00+J+RTlHzy9rQSsWGmmlXpPZIlclvIL3aOOMxR
         s0tSNH7enRmElEjPevyv4/bLnPvO2QWgNQ8domQBbkelfvDma3qkGiWUzWnojgJjeH
         RAx1HYi9WE9Yw==
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Namjae Jeon <linkinjeon@kernel.org>,
        linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH v2 54/89] ntfs: convert to new timestamp accessors
Date:   Wed,  4 Oct 2023 14:52:39 -0400
Message-ID: <20231004185347.80880-52-jlayton@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231004185347.80880-1-jlayton@kernel.org>
References: <20231004185221.80802-1-jlayton@kernel.org>
 <20231004185347.80880-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Convert to using the new inode timestamp accessor functions.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ntfs/inode.c | 25 +++++++++++++------------
 fs/ntfs/mft.c   |  2 +-
 2 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/fs/ntfs/inode.c b/fs/ntfs/inode.c
index 99ac6ea277c4..aba1e22db4e9 100644
--- a/fs/ntfs/inode.c
+++ b/fs/ntfs/inode.c
@@ -648,7 +648,7 @@ static int ntfs_read_locked_inode(struct inode *vi)
 	 * mtime is the last change of the data within the file. Not changed
 	 * when only metadata is changed, e.g. a rename doesn't affect mtime.
 	 */
-	vi->i_mtime = ntfs2utc(si->last_data_change_time);
+	inode_set_mtime_to_ts(vi, ntfs2utc(si->last_data_change_time));
 	/*
 	 * ctime is the last change of the metadata of the file. This obviously
 	 * always changes, when mtime is changed. ctime can be changed on its
@@ -659,7 +659,7 @@ static int ntfs_read_locked_inode(struct inode *vi)
 	 * Last access to the data within the file. Not changed during a rename
 	 * for example but changed whenever the file is written to.
 	 */
-	vi->i_atime = ntfs2utc(si->last_access_time);
+	inode_set_atime_to_ts(vi, ntfs2utc(si->last_access_time));
 
 	/* Find the attribute list attribute if present. */
 	ntfs_attr_reinit_search_ctx(ctx);
@@ -1217,9 +1217,9 @@ static int ntfs_read_locked_attr_inode(struct inode *base_vi, struct inode *vi)
 	vi->i_uid	= base_vi->i_uid;
 	vi->i_gid	= base_vi->i_gid;
 	set_nlink(vi, base_vi->i_nlink);
-	vi->i_mtime	= base_vi->i_mtime;
+	inode_set_mtime_to_ts(vi, inode_get_mtime(base_vi));
 	inode_set_ctime_to_ts(vi, inode_get_ctime(base_vi));
-	vi->i_atime	= base_vi->i_atime;
+	inode_set_atime_to_ts(vi, inode_get_atime(base_vi));
 	vi->i_generation = ni->seq_no = base_ni->seq_no;
 
 	/* Set inode type to zero but preserve permissions. */
@@ -1483,9 +1483,9 @@ static int ntfs_read_locked_index_inode(struct inode *base_vi, struct inode *vi)
 	vi->i_uid	= base_vi->i_uid;
 	vi->i_gid	= base_vi->i_gid;
 	set_nlink(vi, base_vi->i_nlink);
-	vi->i_mtime	= base_vi->i_mtime;
+	inode_set_mtime_to_ts(vi, inode_get_mtime(base_vi));
 	inode_set_ctime_to_ts(vi, inode_get_ctime(base_vi));
-	vi->i_atime	= base_vi->i_atime;
+	inode_set_atime_to_ts(vi, inode_get_atime(base_vi));
 	vi->i_generation = ni->seq_no = base_ni->seq_no;
 	/* Set inode type to zero but preserve permissions. */
 	vi->i_mode	= base_vi->i_mode & ~S_IFMT;
@@ -2805,13 +2805,14 @@ int ntfs_truncate(struct inode *vi)
 	if (!IS_NOCMTIME(VFS_I(base_ni)) && !IS_RDONLY(VFS_I(base_ni))) {
 		struct timespec64 now = current_time(VFS_I(base_ni));
 		struct timespec64 ctime = inode_get_ctime(VFS_I(base_ni));
+		struct timespec64 mtime = inode_get_mtime(VFS_I(base_ni));
 		int sync_it = 0;
 
-		if (!timespec64_equal(&VFS_I(base_ni)->i_mtime, &now) ||
+		if (!timespec64_equal(&mtime, &now) ||
 		    !timespec64_equal(&ctime, &now))
 			sync_it = 1;
 		inode_set_ctime_to_ts(VFS_I(base_ni), now);
-		VFS_I(base_ni)->i_mtime = now;
+		inode_set_mtime_to_ts(VFS_I(base_ni), now);
 
 		if (sync_it)
 			mark_inode_dirty_sync(VFS_I(base_ni));
@@ -2925,9 +2926,9 @@ int ntfs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		}
 	}
 	if (ia_valid & ATTR_ATIME)
-		vi->i_atime = attr->ia_atime;
+		inode_set_atime_to_ts(vi, attr->ia_atime);
 	if (ia_valid & ATTR_MTIME)
-		vi->i_mtime = attr->ia_mtime;
+		inode_set_mtime_to_ts(vi, attr->ia_mtime);
 	if (ia_valid & ATTR_CTIME)
 		inode_set_ctime_to_ts(vi, attr->ia_ctime);
 	mark_inode_dirty(vi);
@@ -2996,7 +2997,7 @@ int __ntfs_write_inode(struct inode *vi, int sync)
 	si = (STANDARD_INFORMATION*)((u8*)ctx->attr +
 			le16_to_cpu(ctx->attr->data.resident.value_offset));
 	/* Update the access times if they have changed. */
-	nt = utc2ntfs(vi->i_mtime);
+	nt = utc2ntfs(inode_get_mtime(vi));
 	if (si->last_data_change_time != nt) {
 		ntfs_debug("Updating mtime for inode 0x%lx: old = 0x%llx, "
 				"new = 0x%llx", vi->i_ino, (long long)
@@ -3014,7 +3015,7 @@ int __ntfs_write_inode(struct inode *vi, int sync)
 		si->last_mft_change_time = nt;
 		modified = true;
 	}
-	nt = utc2ntfs(vi->i_atime);
+	nt = utc2ntfs(inode_get_atime(vi));
 	if (si->last_access_time != nt) {
 		ntfs_debug("Updating atime for inode 0x%lx: old = 0x%llx, "
 				"new = 0x%llx", vi->i_ino,
diff --git a/fs/ntfs/mft.c b/fs/ntfs/mft.c
index ad1a8f72da22..6fd1dc4b08c8 100644
--- a/fs/ntfs/mft.c
+++ b/fs/ntfs/mft.c
@@ -2682,7 +2682,7 @@ ntfs_inode *ntfs_mft_record_alloc(ntfs_volume *vol, const int mode,
 			vi->i_mode &= ~S_IWUGO;
 
 		/* Set the inode times to the current time. */
-		vi->i_atime = vi->i_mtime = inode_set_ctime_current(vi);
+		simple_inode_init_ts(vi);
 		/*
 		 * Set the file size to 0, the ntfs inode sizes are set to 0 by
 		 * the call to ntfs_init_big_inode() below.
-- 
2.41.0

