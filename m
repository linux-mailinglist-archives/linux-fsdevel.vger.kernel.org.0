Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6729F748D49
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jul 2023 21:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233934AbjGETI5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jul 2023 15:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234119AbjGETIZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jul 2023 15:08:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DA3135A9;
        Wed,  5 Jul 2023 12:05:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 89013616FC;
        Wed,  5 Jul 2023 19:04:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42780C433C7;
        Wed,  5 Jul 2023 19:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688583885;
        bh=S76cug60RSzGP9ZVr2iEwZrNFye2aOZN8lxss1+Dkoo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FvsH4gOWdStSRHxVaSQJqprl+vsEsLzdC13oQAQVuksSmu/v961cl9Dd70sDLKMMd
         8fVcZp1Lykja6g8L1JqaqVeAb+HhsyPoTBxB2gg19QcXCj5KwEii0ySQ5LcpOw7RX4
         +vGjEv4aM6CNLGCm1Z9H+7POs//4ULLtTnWpWfxc1iD7nlbAWoY/v+oAVBdCRsULug
         MspXmT+X3PpAPpwFeymV2pU3FF1pYAdWviW5ZUPyu1T2/RJGa/gg7Vg7CCGg4kamLG
         GNnAVnPqk9CsXHIk7GxJbCFvKGraTvvW5ChMdfbNl89u0xLKC2NyvFeEbUAntEuiMd
         xlzPCSHztkfHg==
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 56/92] kernfs: convert to ctime accessor functions
Date:   Wed,  5 Jul 2023 15:01:21 -0400
Message-ID: <20230705190309.579783-54-jlayton@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230705190309.579783-1-jlayton@kernel.org>
References: <20230705185755.579053-1-jlayton@kernel.org>
 <20230705190309.579783-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In later patches, we're going to change how the inode's ctime field is
used. Switch to using accessor functions instead of raw accesses of
inode->i_ctime.

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/kernfs/inode.c       |  5 ++---
 fs/libfs.c              | 19 ++++++++++---------
 fs/minix/bitmap.c       |  2 +-
 fs/minix/dir.c          |  6 +++---
 fs/minix/inode.c        | 10 +++++-----
 fs/minix/itree_common.c |  4 ++--
 fs/minix/namei.c        |  6 +++---
 7 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/fs/kernfs/inode.c b/fs/kernfs/inode.c
index b22b74d1a115..89a9b4dcf109 100644
--- a/fs/kernfs/inode.c
+++ b/fs/kernfs/inode.c
@@ -151,8 +151,7 @@ ssize_t kernfs_iop_listxattr(struct dentry *dentry, char *buf, size_t size)
 static inline void set_default_inode_attr(struct inode *inode, umode_t mode)
 {
 	inode->i_mode = mode;
-	inode->i_atime = inode->i_mtime =
-		inode->i_ctime = current_time(inode);
+	inode->i_atime = inode->i_mtime = inode_set_ctime_current(inode);
 }
 
 static inline void set_inode_attr(struct inode *inode,
@@ -162,7 +161,7 @@ static inline void set_inode_attr(struct inode *inode,
 	inode->i_gid = attrs->ia_gid;
 	inode->i_atime = attrs->ia_atime;
 	inode->i_mtime = attrs->ia_mtime;
-	inode->i_ctime = attrs->ia_ctime;
+	inode_set_ctime_to_ts(inode, attrs->ia_ctime);
 }
 
 static void kernfs_refresh_inode(struct kernfs_node *kn, struct inode *inode)
diff --git a/fs/libfs.c b/fs/libfs.c
index 9ee79668c909..befbef1b4b46 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -523,7 +523,7 @@ void simple_recursive_removal(struct dentry *dentry,
 		while ((child = find_next_child(this, victim)) == NULL) {
 			// kill and ascend
 			// update metadata while it's still locked
-			inode->i_ctime = current_time(inode);
+			inode_set_ctime_current(inode);
 			clear_nlink(inode);
 			inode_unlock(inode);
 			victim = this;
@@ -541,8 +541,7 @@ void simple_recursive_removal(struct dentry *dentry,
 				dput(victim);		// unpin it
 			}
 			if (victim == dentry) {
-				inode->i_ctime = inode->i_mtime =
-					current_time(inode);
+				inode->i_mtime = inode_set_ctime_current(inode);
 				if (d_is_dir(dentry))
 					drop_nlink(inode);
 				inode_unlock(inode);
@@ -583,7 +582,7 @@ static int pseudo_fs_fill_super(struct super_block *s, struct fs_context *fc)
 	 */
 	root->i_ino = 1;
 	root->i_mode = S_IFDIR | S_IRUSR | S_IWUSR;
-	root->i_atime = root->i_mtime = root->i_ctime = current_time(root);
+	root->i_atime = root->i_mtime = inode_set_ctime_current(root);
 	s->s_root = d_make_root(root);
 	if (!s->s_root)
 		return -ENOMEM;
@@ -639,7 +638,8 @@ int simple_link(struct dentry *old_dentry, struct inode *dir, struct dentry *den
 {
 	struct inode *inode = d_inode(old_dentry);
 
-	inode->i_ctime = dir->i_ctime = dir->i_mtime = current_time(inode);
+	dir->i_mtime = inode_set_ctime_to_ts(dir,
+					     inode_set_ctime_current(inode));
 	inc_nlink(inode);
 	ihold(inode);
 	dget(dentry);
@@ -673,7 +673,8 @@ int simple_unlink(struct inode *dir, struct dentry *dentry)
 {
 	struct inode *inode = d_inode(dentry);
 
-	inode->i_ctime = dir->i_ctime = dir->i_mtime = current_time(inode);
+	dir->i_mtime = inode_set_ctime_to_ts(dir,
+					     inode_set_ctime_current(inode));
 	drop_nlink(inode);
 	dput(dentry);
 	return 0;
@@ -925,7 +926,7 @@ int simple_fill_super(struct super_block *s, unsigned long magic,
 	 */
 	inode->i_ino = 1;
 	inode->i_mode = S_IFDIR | 0755;
-	inode->i_atime = inode->i_mtime = inode->i_ctime = current_time(inode);
+	inode->i_atime = inode->i_mtime = inode_set_ctime_current(inode);
 	inode->i_op = &simple_dir_inode_operations;
 	inode->i_fop = &simple_dir_operations;
 	set_nlink(inode, 2);
@@ -951,7 +952,7 @@ int simple_fill_super(struct super_block *s, unsigned long magic,
 			goto out;
 		}
 		inode->i_mode = S_IFREG | files->mode;
-		inode->i_atime = inode->i_mtime = inode->i_ctime = current_time(inode);
+		inode->i_atime = inode->i_mtime = inode_set_ctime_current(inode);
 		inode->i_fop = files->ops;
 		inode->i_ino = i;
 		d_add(dentry, inode);
@@ -1519,7 +1520,7 @@ struct inode *alloc_anon_inode(struct super_block *s)
 	inode->i_uid = current_fsuid();
 	inode->i_gid = current_fsgid();
 	inode->i_flags |= S_PRIVATE;
-	inode->i_atime = inode->i_mtime = inode->i_ctime = current_time(inode);
+	inode->i_atime = inode->i_mtime = inode_set_ctime_current(inode);
 	return inode;
 }
 EXPORT_SYMBOL(alloc_anon_inode);
diff --git a/fs/minix/bitmap.c b/fs/minix/bitmap.c
index 870207ba23f1..25c08fbfcb9d 100644
--- a/fs/minix/bitmap.c
+++ b/fs/minix/bitmap.c
@@ -251,7 +251,7 @@ struct inode *minix_new_inode(const struct inode *dir, umode_t mode)
 	}
 	inode_init_owner(&nop_mnt_idmap, inode, dir, mode);
 	inode->i_ino = j;
-	inode->i_mtime = inode->i_atime = inode->i_ctime = current_time(inode);
+	inode->i_mtime = inode->i_atime = inode_set_ctime_current(inode);
 	inode->i_blocks = 0;
 	memset(&minix_i(inode)->u, 0, sizeof(minix_i(inode)->u));
 	insert_inode_hash(inode);
diff --git a/fs/minix/dir.c b/fs/minix/dir.c
index bf9858f76b6a..20f23e6e58ad 100644
--- a/fs/minix/dir.c
+++ b/fs/minix/dir.c
@@ -281,7 +281,7 @@ int minix_add_link(struct dentry *dentry, struct inode *inode)
 		de->inode = inode->i_ino;
 	}
 	dir_commit_chunk(page, pos, sbi->s_dirsize);
-	dir->i_mtime = dir->i_ctime = current_time(dir);
+	dir->i_mtime = inode_set_ctime_current(dir);
 	mark_inode_dirty(dir);
 	err = minix_handle_dirsync(dir);
 out_put:
@@ -313,7 +313,7 @@ int minix_delete_entry(struct minix_dir_entry *de, struct page *page)
 	else
 		de->inode = 0;
 	dir_commit_chunk(page, pos, len);
-	inode->i_ctime = inode->i_mtime = current_time(inode);
+	inode->i_mtime = inode_set_ctime_current(inode);
 	mark_inode_dirty(inode);
 	return minix_handle_dirsync(inode);
 }
@@ -436,7 +436,7 @@ int minix_set_link(struct minix_dir_entry *de, struct page *page,
 	else
 		de->inode = inode->i_ino;
 	dir_commit_chunk(page, pos, sbi->s_dirsize);
-	dir->i_mtime = dir->i_ctime = current_time(dir);
+	dir->i_mtime = inode_set_ctime_current(dir);
 	mark_inode_dirty(dir);
 	return minix_handle_dirsync(dir);
 }
diff --git a/fs/minix/inode.c b/fs/minix/inode.c
index e9fbb5303a22..3715a3940bd4 100644
--- a/fs/minix/inode.c
+++ b/fs/minix/inode.c
@@ -501,10 +501,11 @@ static struct inode *V1_minix_iget(struct inode *inode)
 	i_gid_write(inode, raw_inode->i_gid);
 	set_nlink(inode, raw_inode->i_nlinks);
 	inode->i_size = raw_inode->i_size;
-	inode->i_mtime.tv_sec = inode->i_atime.tv_sec = inode->i_ctime.tv_sec = raw_inode->i_time;
+	inode->i_mtime.tv_sec = inode->i_atime.tv_sec = inode_set_ctime(inode,
+									raw_inode->i_time,
+									0).tv_sec;
 	inode->i_mtime.tv_nsec = 0;
 	inode->i_atime.tv_nsec = 0;
-	inode->i_ctime.tv_nsec = 0;
 	inode->i_blocks = 0;
 	for (i = 0; i < 9; i++)
 		minix_inode->u.i1_data[i] = raw_inode->i_zone[i];
@@ -543,10 +544,9 @@ static struct inode *V2_minix_iget(struct inode *inode)
 	inode->i_size = raw_inode->i_size;
 	inode->i_mtime.tv_sec = raw_inode->i_mtime;
 	inode->i_atime.tv_sec = raw_inode->i_atime;
-	inode->i_ctime.tv_sec = raw_inode->i_ctime;
+	inode_set_ctime(inode, raw_inode->i_ctime, 0);
 	inode->i_mtime.tv_nsec = 0;
 	inode->i_atime.tv_nsec = 0;
-	inode->i_ctime.tv_nsec = 0;
 	inode->i_blocks = 0;
 	for (i = 0; i < 10; i++)
 		minix_inode->u.i2_data[i] = raw_inode->i_zone[i];
@@ -622,7 +622,7 @@ static struct buffer_head * V2_minix_update_inode(struct inode * inode)
 	raw_inode->i_size = inode->i_size;
 	raw_inode->i_mtime = inode->i_mtime.tv_sec;
 	raw_inode->i_atime = inode->i_atime.tv_sec;
-	raw_inode->i_ctime = inode->i_ctime.tv_sec;
+	raw_inode->i_ctime = inode_get_ctime(inode).tv_sec;
 	if (S_ISCHR(inode->i_mode) || S_ISBLK(inode->i_mode))
 		raw_inode->i_zone[0] = old_encode_dev(inode->i_rdev);
 	else for (i = 0; i < 10; i++)
diff --git a/fs/minix/itree_common.c b/fs/minix/itree_common.c
index 446148792f41..ce18ae37c29d 100644
--- a/fs/minix/itree_common.c
+++ b/fs/minix/itree_common.c
@@ -131,7 +131,7 @@ static inline int splice_branch(struct inode *inode,
 
 	/* We are done with atomic stuff, now do the rest of housekeeping */
 
-	inode->i_ctime = current_time(inode);
+	inode_set_ctime_current(inode);
 
 	/* had we spliced it onto indirect block? */
 	if (where->bh)
@@ -350,7 +350,7 @@ static inline void truncate (struct inode * inode)
 		}
 		first_whole++;
 	}
-	inode->i_mtime = inode->i_ctime = current_time(inode);
+	inode->i_mtime = inode_set_ctime_current(inode);
 	mark_inode_dirty(inode);
 }
 
diff --git a/fs/minix/namei.c b/fs/minix/namei.c
index 956d5183828d..114084d5636a 100644
--- a/fs/minix/namei.c
+++ b/fs/minix/namei.c
@@ -98,7 +98,7 @@ static int minix_link(struct dentry * old_dentry, struct inode * dir,
 {
 	struct inode *inode = d_inode(old_dentry);
 
-	inode->i_ctime = current_time(inode);
+	inode_set_ctime_current(inode);
 	inode_inc_link_count(inode);
 	ihold(inode);
 	return add_nondir(dentry, inode);
@@ -154,7 +154,7 @@ static int minix_unlink(struct inode * dir, struct dentry *dentry)
 
 	if (err)
 		return err;
-	inode->i_ctime = dir->i_ctime;
+	inode_set_ctime_to_ts(inode, inode_get_ctime(dir));
 	inode_dec_link_count(inode);
 	return 0;
 }
@@ -218,7 +218,7 @@ static int minix_rename(struct mnt_idmap *idmap,
 		put_page(new_page);
 		if (err)
 			goto out_dir;
-		new_inode->i_ctime = current_time(new_inode);
+		inode_set_ctime_current(new_inode);
 		if (dir_de)
 			drop_nlink(new_inode);
 		inode_dec_link_count(new_inode);
-- 
2.41.0

