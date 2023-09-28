Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 723A57B1A1C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Sep 2023 13:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232366AbjI1LJM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Sep 2023 07:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232262AbjI1LIT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Sep 2023 07:08:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12BC61BEC;
        Thu, 28 Sep 2023 04:05:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20441C433CB;
        Thu, 28 Sep 2023 11:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695899119;
        bh=WSxbBfZ4La8zxSFSiEDrnwuIa5wj+0GB96TWsh7xsFs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PQXF1xozdhY/h8eSJXMUq8LB+GkKUMnBMiWe7O4E+8O5mVYwV+gyW+szetR/8e5Zb
         oCseRLzuk1nSkceohEv13hqkGmVgHY9unZWMEHiky4raQbYSGfyQgQH4J/PpHW/iO0
         7FjzQME1v12qhYDKzEWYXot/eANiLZGx3DbjUN+fBDA5XGD+wsygSzO2j8edRosCED
         trvftiXj797ULaHkM7JxdE/RiADMM9ejwtuNLycfbh/rUOMK+LKUqxgKu1ay5B3DGX
         Vrworb+/UlVfmPzRZnU/lR9jvcPEEAMd3BbcytroBkmnYTFzcfMR4pos+nGJ/9Tt5Z
         2CYZcjIfiKNhQ==
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     ocfs2-devel@lists.linux.dev
Subject: [PATCH 55/87] fs/ocfs2: convert to new inode {a,m}time accessors
Date:   Thu, 28 Sep 2023 07:03:04 -0400
Message-ID: <20230928110413.33032-54-jlayton@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230928110413.33032-1-jlayton@kernel.org>
References: <20230928110300.32891-1-jlayton@kernel.org>
 <20230928110413.33032-1-jlayton@kernel.org>
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

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ocfs2/alloc.c        |  2 +-
 fs/ocfs2/aops.c         |  6 +++---
 fs/ocfs2/dir.c          |  5 +++--
 fs/ocfs2/dlmfs/dlmfs.c  |  4 ++--
 fs/ocfs2/dlmglue.c      | 29 ++++++++++++++---------------
 fs/ocfs2/file.c         | 26 ++++++++++++++------------
 fs/ocfs2/inode.c        | 24 ++++++++++++------------
 fs/ocfs2/namei.c        |  8 ++++----
 fs/ocfs2/refcounttree.c |  4 ++--
 9 files changed, 55 insertions(+), 53 deletions(-)

diff --git a/fs/ocfs2/alloc.c b/fs/ocfs2/alloc.c
index aef58f1395c8..40ed1c98fe82 100644
--- a/fs/ocfs2/alloc.c
+++ b/fs/ocfs2/alloc.c
@@ -7436,7 +7436,7 @@ int ocfs2_truncate_inline(struct inode *inode, struct buffer_head *di_bh,
 	}
 
 	inode->i_blocks = ocfs2_inode_sector_count(inode);
-	inode->i_mtime = inode_set_ctime_current(inode);
+	inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
 
 	di->i_ctime = di->i_mtime = cpu_to_le64(inode_get_ctime(inode).tv_sec);
 	di->i_ctime_nsec = di->i_mtime_nsec = cpu_to_le32(inode_get_ctime(inode).tv_nsec);
diff --git a/fs/ocfs2/aops.c b/fs/ocfs2/aops.c
index 0fdba30740ab..2793ee14eaaf 100644
--- a/fs/ocfs2/aops.c
+++ b/fs/ocfs2/aops.c
@@ -2048,9 +2048,9 @@ int ocfs2_write_end_nolock(struct address_space *mapping,
 		}
 		inode->i_blocks = ocfs2_inode_sector_count(inode);
 		di->i_size = cpu_to_le64((u64)i_size_read(inode));
-		inode->i_mtime = inode_set_ctime_current(inode);
-		di->i_mtime = di->i_ctime = cpu_to_le64(inode->i_mtime.tv_sec);
-		di->i_mtime_nsec = di->i_ctime_nsec = cpu_to_le32(inode->i_mtime.tv_nsec);
+		inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
+		di->i_mtime = di->i_ctime = cpu_to_le64(inode_get_mtime(inode).tv_sec);
+		di->i_mtime_nsec = di->i_ctime_nsec = cpu_to_le32(inode_get_mtime(inode).tv_nsec);
 		if (handle)
 			ocfs2_update_inode_fsync_trans(handle, inode, 1);
 	}
diff --git a/fs/ocfs2/dir.c b/fs/ocfs2/dir.c
index 8b123d543e6e..82605892e68d 100644
--- a/fs/ocfs2/dir.c
+++ b/fs/ocfs2/dir.c
@@ -1658,7 +1658,8 @@ int __ocfs2_add_entry(handle_t *handle,
 				offset, ocfs2_dir_trailer_blk_off(dir->i_sb));
 
 		if (ocfs2_dirent_would_fit(de, rec_len)) {
-			dir->i_mtime = inode_set_ctime_current(dir);
+			inode_set_mtime_to_ts(dir,
+					      inode_set_ctime_current(dir));
 			retval = ocfs2_mark_inode_dirty(handle, dir, parent_fe_bh);
 			if (retval < 0) {
 				mlog_errno(retval);
@@ -2962,7 +2963,7 @@ static int ocfs2_expand_inline_dir(struct inode *dir, struct buffer_head *di_bh,
 	ocfs2_dinode_new_extent_list(dir, di);
 
 	i_size_write(dir, sb->s_blocksize);
-	dir->i_mtime = inode_set_ctime_current(dir);
+	inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
 
 	di->i_size = cpu_to_le64(sb->s_blocksize);
 	di->i_ctime = di->i_mtime = cpu_to_le64(inode_get_ctime(dir).tv_sec);
diff --git a/fs/ocfs2/dlmfs/dlmfs.c b/fs/ocfs2/dlmfs/dlmfs.c
index 81265123ce6c..9b57d012fd5c 100644
--- a/fs/ocfs2/dlmfs/dlmfs.c
+++ b/fs/ocfs2/dlmfs/dlmfs.c
@@ -337,7 +337,7 @@ static struct inode *dlmfs_get_root_inode(struct super_block *sb)
 	if (inode) {
 		inode->i_ino = get_next_ino();
 		inode_init_owner(&nop_mnt_idmap, inode, NULL, mode);
-		inode->i_atime = inode->i_mtime = inode_set_ctime_current(inode);
+		simple_inode_init_ts(inode);
 		inc_nlink(inode);
 
 		inode->i_fop = &simple_dir_operations;
@@ -360,7 +360,7 @@ static struct inode *dlmfs_get_inode(struct inode *parent,
 
 	inode->i_ino = get_next_ino();
 	inode_init_owner(&nop_mnt_idmap, inode, parent, mode);
-	inode->i_atime = inode->i_mtime = inode_set_ctime_current(inode);
+	simple_inode_init_ts(inode);
 
 	ip = DLMFS_I(inode);
 	ip->ip_conn = DLMFS_I(parent)->ip_conn;
diff --git a/fs/ocfs2/dlmglue.c b/fs/ocfs2/dlmglue.c
index c3e2961ee5db..64a6ef638495 100644
--- a/fs/ocfs2/dlmglue.c
+++ b/fs/ocfs2/dlmglue.c
@@ -2162,7 +2162,7 @@ static void __ocfs2_stuff_meta_lvb(struct inode *inode)
 	struct ocfs2_inode_info *oi = OCFS2_I(inode);
 	struct ocfs2_lock_res *lockres = &oi->ip_inode_lockres;
 	struct ocfs2_meta_lvb *lvb;
-	struct timespec64 ctime = inode_get_ctime(inode);
+	struct timespec64 ts;
 
 	lvb = ocfs2_dlm_lvb(&lockres->l_lksb);
 
@@ -2183,12 +2183,12 @@ static void __ocfs2_stuff_meta_lvb(struct inode *inode)
 	lvb->lvb_igid      = cpu_to_be32(i_gid_read(inode));
 	lvb->lvb_imode     = cpu_to_be16(inode->i_mode);
 	lvb->lvb_inlink    = cpu_to_be16(inode->i_nlink);
-	lvb->lvb_iatime_packed  =
-		cpu_to_be64(ocfs2_pack_timespec(&inode->i_atime));
-	lvb->lvb_ictime_packed =
-		cpu_to_be64(ocfs2_pack_timespec(&ctime));
-	lvb->lvb_imtime_packed =
-		cpu_to_be64(ocfs2_pack_timespec(&inode->i_mtime));
+	ts = inode_get_atime(inode);
+	lvb->lvb_iatime_packed = cpu_to_be64(ocfs2_pack_timespec(&ts));
+	ts = inode_get_ctime(inode);
+	lvb->lvb_ictime_packed = cpu_to_be64(ocfs2_pack_timespec(&ts));
+	ts = inode_get_mtime(inode);
+	lvb->lvb_imtime_packed = cpu_to_be64(ocfs2_pack_timespec(&ts));
 	lvb->lvb_iattr    = cpu_to_be32(oi->ip_attr);
 	lvb->lvb_idynfeatures = cpu_to_be16(oi->ip_dyn_features);
 	lvb->lvb_igeneration = cpu_to_be32(inode->i_generation);
@@ -2209,7 +2209,7 @@ static int ocfs2_refresh_inode_from_lvb(struct inode *inode)
 	struct ocfs2_inode_info *oi = OCFS2_I(inode);
 	struct ocfs2_lock_res *lockres = &oi->ip_inode_lockres;
 	struct ocfs2_meta_lvb *lvb;
-	struct timespec64 ctime;
+	struct timespec64 ts;
 
 	mlog_meta_lvb(0, lockres);
 
@@ -2236,13 +2236,12 @@ static int ocfs2_refresh_inode_from_lvb(struct inode *inode)
 	i_gid_write(inode, be32_to_cpu(lvb->lvb_igid));
 	inode->i_mode    = be16_to_cpu(lvb->lvb_imode);
 	set_nlink(inode, be16_to_cpu(lvb->lvb_inlink));
-	ocfs2_unpack_timespec(&inode->i_atime,
-			      be64_to_cpu(lvb->lvb_iatime_packed));
-	ocfs2_unpack_timespec(&inode->i_mtime,
-			      be64_to_cpu(lvb->lvb_imtime_packed));
-	ocfs2_unpack_timespec(&ctime,
-			      be64_to_cpu(lvb->lvb_ictime_packed));
-	inode_set_ctime_to_ts(inode, ctime);
+	ocfs2_unpack_timespec(&ts, be64_to_cpu(lvb->lvb_iatime_packed));
+	inode_set_atime_to_ts(inode, ts);
+	ocfs2_unpack_timespec(&ts, be64_to_cpu(lvb->lvb_imtime_packed));
+	inode_set_mtime_to_ts(inode, ts);
+	ocfs2_unpack_timespec(&ts, be64_to_cpu(lvb->lvb_ictime_packed));
+	inode_set_ctime_to_ts(inode, ts);
 	spin_unlock(&oi->ip_lock);
 	return 0;
 }
diff --git a/fs/ocfs2/file.c b/fs/ocfs2/file.c
index c45596c25c66..75f13755aa9e 100644
--- a/fs/ocfs2/file.c
+++ b/fs/ocfs2/file.c
@@ -233,16 +233,18 @@ int ocfs2_should_update_atime(struct inode *inode,
 
 	if (vfsmnt->mnt_flags & MNT_RELATIME) {
 		struct timespec64 ctime = inode_get_ctime(inode);
+		struct timespec64 atime = inode_get_atime(inode);
+		struct timespec64 mtime = inode_get_mtime(inode);
 
-		if ((timespec64_compare(&inode->i_atime, &inode->i_mtime) <= 0) ||
-		    (timespec64_compare(&inode->i_atime, &ctime) <= 0))
+		if ((timespec64_compare(&atime, &mtime) <= 0) ||
+		    (timespec64_compare(&atime, &ctime) <= 0))
 			return 1;
 
 		return 0;
 	}
 
 	now = current_time(inode);
-	if ((now.tv_sec - inode->i_atime.tv_sec <= osb->s_atime_quantum))
+	if ((now.tv_sec - inode_get_atime(inode).tv_sec <= osb->s_atime_quantum))
 		return 0;
 	else
 		return 1;
@@ -275,9 +277,9 @@ int ocfs2_update_inode_atime(struct inode *inode,
 	 * have i_rwsem to guard against concurrent changes to other
 	 * inode fields.
 	 */
-	inode->i_atime = current_time(inode);
-	di->i_atime = cpu_to_le64(inode->i_atime.tv_sec);
-	di->i_atime_nsec = cpu_to_le32(inode->i_atime.tv_nsec);
+	inode_set_atime_to_ts(inode, current_time(inode));
+	di->i_atime = cpu_to_le64(inode_get_atime(inode).tv_sec);
+	di->i_atime_nsec = cpu_to_le32(inode_get_atime(inode).tv_nsec);
 	ocfs2_update_inode_fsync_trans(handle, inode, 0);
 	ocfs2_journal_dirty(handle, bh);
 
@@ -296,7 +298,7 @@ int ocfs2_set_inode_size(handle_t *handle,
 
 	i_size_write(inode, new_i_size);
 	inode->i_blocks = ocfs2_inode_sector_count(inode);
-	inode->i_mtime = inode_set_ctime_current(inode);
+	inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
 
 	status = ocfs2_mark_inode_dirty(handle, inode, fe_bh);
 	if (status < 0) {
@@ -417,7 +419,7 @@ static int ocfs2_orphan_for_truncate(struct ocfs2_super *osb,
 	}
 
 	i_size_write(inode, new_i_size);
-	inode->i_mtime = inode_set_ctime_current(inode);
+	inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
 
 	di = (struct ocfs2_dinode *) fe_bh->b_data;
 	di->i_size = cpu_to_le64(new_i_size);
@@ -821,9 +823,9 @@ static int ocfs2_write_zero_page(struct inode *inode, u64 abs_from,
 	i_size_write(inode, abs_to);
 	inode->i_blocks = ocfs2_inode_sector_count(inode);
 	di->i_size = cpu_to_le64((u64)i_size_read(inode));
-	inode->i_mtime = inode_set_ctime_current(inode);
-	di->i_mtime = di->i_ctime = cpu_to_le64(inode->i_mtime.tv_sec);
-	di->i_ctime_nsec = cpu_to_le32(inode->i_mtime.tv_nsec);
+	inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
+	di->i_mtime = di->i_ctime = cpu_to_le64(inode_get_mtime(inode).tv_sec);
+	di->i_ctime_nsec = cpu_to_le32(inode_get_mtime(inode).tv_nsec);
 	di->i_mtime_nsec = di->i_ctime_nsec;
 	if (handle) {
 		ocfs2_journal_dirty(handle, di_bh);
@@ -2040,7 +2042,7 @@ static int __ocfs2_change_file_space(struct file *file, struct inode *inode,
 		goto out_inode_unlock;
 	}
 
-	inode->i_mtime = inode_set_ctime_current(inode);
+	inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
 	ret = ocfs2_mark_inode_dirty(handle, inode, di_bh);
 	if (ret < 0)
 		mlog_errno(ret);
diff --git a/fs/ocfs2/inode.c b/fs/ocfs2/inode.c
index e8771600b930..4f5a88892178 100644
--- a/fs/ocfs2/inode.c
+++ b/fs/ocfs2/inode.c
@@ -302,10 +302,10 @@ void ocfs2_populate_inode(struct inode *inode, struct ocfs2_dinode *fe,
 		inode->i_blocks = ocfs2_inode_sector_count(inode);
 		inode->i_mapping->a_ops = &ocfs2_aops;
 	}
-	inode->i_atime.tv_sec = le64_to_cpu(fe->i_atime);
-	inode->i_atime.tv_nsec = le32_to_cpu(fe->i_atime_nsec);
-	inode->i_mtime.tv_sec = le64_to_cpu(fe->i_mtime);
-	inode->i_mtime.tv_nsec = le32_to_cpu(fe->i_mtime_nsec);
+	inode_set_atime(inode, le64_to_cpu(fe->i_atime),
+		        le32_to_cpu(fe->i_atime_nsec));
+	inode_set_mtime(inode, le64_to_cpu(fe->i_mtime),
+		        le32_to_cpu(fe->i_mtime_nsec));
 	inode_set_ctime(inode, le64_to_cpu(fe->i_ctime),
 		        le32_to_cpu(fe->i_ctime_nsec));
 
@@ -1312,12 +1312,12 @@ int ocfs2_mark_inode_dirty(handle_t *handle,
 	fe->i_uid = cpu_to_le32(i_uid_read(inode));
 	fe->i_gid = cpu_to_le32(i_gid_read(inode));
 	fe->i_mode = cpu_to_le16(inode->i_mode);
-	fe->i_atime = cpu_to_le64(inode->i_atime.tv_sec);
-	fe->i_atime_nsec = cpu_to_le32(inode->i_atime.tv_nsec);
+	fe->i_atime = cpu_to_le64(inode_get_atime(inode).tv_sec);
+	fe->i_atime_nsec = cpu_to_le32(inode_get_atime(inode).tv_nsec);
 	fe->i_ctime = cpu_to_le64(inode_get_ctime(inode).tv_sec);
 	fe->i_ctime_nsec = cpu_to_le32(inode_get_ctime(inode).tv_nsec);
-	fe->i_mtime = cpu_to_le64(inode->i_mtime.tv_sec);
-	fe->i_mtime_nsec = cpu_to_le32(inode->i_mtime.tv_nsec);
+	fe->i_mtime = cpu_to_le64(inode_get_mtime(inode).tv_sec);
+	fe->i_mtime_nsec = cpu_to_le32(inode_get_mtime(inode).tv_nsec);
 
 	ocfs2_journal_dirty(handle, bh);
 	ocfs2_update_inode_fsync_trans(handle, inode, 1);
@@ -1348,10 +1348,10 @@ void ocfs2_refresh_inode(struct inode *inode,
 		inode->i_blocks = 0;
 	else
 		inode->i_blocks = ocfs2_inode_sector_count(inode);
-	inode->i_atime.tv_sec = le64_to_cpu(fe->i_atime);
-	inode->i_atime.tv_nsec = le32_to_cpu(fe->i_atime_nsec);
-	inode->i_mtime.tv_sec = le64_to_cpu(fe->i_mtime);
-	inode->i_mtime.tv_nsec = le32_to_cpu(fe->i_mtime_nsec);
+	inode_set_atime(inode, le64_to_cpu(fe->i_atime),
+			le32_to_cpu(fe->i_atime_nsec));
+	inode_set_mtime(inode, le64_to_cpu(fe->i_mtime),
+			le32_to_cpu(fe->i_mtime_nsec));
 	inode_set_ctime(inode, le64_to_cpu(fe->i_ctime),
 			le32_to_cpu(fe->i_ctime_nsec));
 
diff --git a/fs/ocfs2/namei.c b/fs/ocfs2/namei.c
index 5cd6d7771cea..e3351ea8f689 100644
--- a/fs/ocfs2/namei.c
+++ b/fs/ocfs2/namei.c
@@ -995,7 +995,7 @@ static int ocfs2_unlink(struct inode *dir,
 	ocfs2_set_links_count(fe, inode->i_nlink);
 	ocfs2_journal_dirty(handle, fe_bh);
 
-	dir->i_mtime = inode_set_ctime_current(dir);
+	inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
 	if (S_ISDIR(inode->i_mode))
 		drop_nlink(dir);
 
@@ -1592,7 +1592,7 @@ static int ocfs2_rename(struct mnt_idmap *idmap,
 		drop_nlink(new_inode);
 		inode_set_ctime_current(new_inode);
 	}
-	old_dir->i_mtime = inode_set_ctime_current(old_dir);
+	inode_set_mtime_to_ts(old_dir, inode_set_ctime_current(old_dir));
 
 	if (update_dot_dot) {
 		status = ocfs2_update_entry(old_inode, handle,
@@ -1614,8 +1614,8 @@ static int ocfs2_rename(struct mnt_idmap *idmap,
 
 	if (old_dir != new_dir) {
 		/* Keep the same times on both directories.*/
-		new_dir->i_mtime = inode_set_ctime_to_ts(new_dir,
-							 inode_get_ctime(old_dir));
+		inode_set_mtime_to_ts(new_dir,
+				      inode_set_ctime_to_ts(new_dir, inode_get_ctime(old_dir)));
 
 		/*
 		 * This will also pick up the i_nlink change from the
diff --git a/fs/ocfs2/refcounttree.c b/fs/ocfs2/refcounttree.c
index 25c8ec3c8c3a..bbe6cd7a30f7 100644
--- a/fs/ocfs2/refcounttree.c
+++ b/fs/ocfs2/refcounttree.c
@@ -4078,7 +4078,7 @@ static int ocfs2_complete_reflink(struct inode *s_inode,
 		di->i_ctime = cpu_to_le64(inode_get_ctime(t_inode).tv_sec);
 		di->i_ctime_nsec = cpu_to_le32(inode_get_ctime(t_inode).tv_nsec);
 
-		t_inode->i_mtime = s_inode->i_mtime;
+		inode_set_mtime_to_ts(t_inode, inode_get_mtime(s_inode));
 		di->i_mtime = s_di->i_mtime;
 		di->i_mtime_nsec = s_di->i_mtime_nsec;
 	}
@@ -4456,7 +4456,7 @@ int ocfs2_reflink_update_dest(struct inode *dest,
 	if (newlen > i_size_read(dest))
 		i_size_write(dest, newlen);
 	spin_unlock(&OCFS2_I(dest)->ip_lock);
-	dest->i_mtime = inode_set_ctime_current(dest);
+	inode_set_mtime_to_ts(dest, inode_set_ctime_current(dest));
 
 	ret = ocfs2_mark_inode_dirty(handle, dest, d_bh);
 	if (ret) {
-- 
2.41.0

