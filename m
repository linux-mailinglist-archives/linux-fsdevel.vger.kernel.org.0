Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C673748D34
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jul 2023 21:08:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233179AbjGETIl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jul 2023 15:08:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233862AbjGETHa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jul 2023 15:07:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 322A430C8;
        Wed,  5 Jul 2023 12:04:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 11D2A616E4;
        Wed,  5 Jul 2023 19:04:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B07DBC433C8;
        Wed,  5 Jul 2023 19:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688583882;
        bh=TD9GkLzDkOcDiFx1eJWC4LXqiy+RzWR/SaTh92hyksw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NXY9G9vygbRkYbdWqM3+0nBYtzWPxm2QtDhw6ZpxZz+VaSI/TKA71Wwz0SwGCNSXF
         4Vu6GAe1SfSYm/fBbfDQbeR/QS2cyZoiPr5QZIobGG5n8m6ipSEmOCNJCZZE1Y/49e
         jC4D08Ee5TyAtbsSXu1plD5Qtcxp+J8GBCWJtDEP8uZ63zpOrK91XLaXYKA5umWnIZ
         n7ayKVk3tVgj14DWwCJ556ficgAKzUN4rd84iNvu80A+2JZm7NkVMpHK9PS0v2dyzj
         tb6HVAXhJBUIVSOXnKxDpKntm5TV7PpjtbaLP7c/gpihQfU+Wqcez/pEufYKl4mKNs
         Ay4t0frzUXPfw==
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>,
        Dave Kleikamp <shaggy@kernel.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dave Kleikamp <dave.kleikamp@oracle.com>,
        jfs-discussion@lists.sourceforge.net
Subject: [PATCH v2 55/92] jfs: convert to ctime accessor functions
Date:   Wed,  5 Jul 2023 15:01:20 -0400
Message-ID: <20230705190309.579783-53-jlayton@kernel.org>
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

Acked-by: Dave Kleikamp <dave.kleikamp@oracle.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/jfs/acl.c       |  2 +-
 fs/jfs/inode.c     |  2 +-
 fs/jfs/ioctl.c     |  2 +-
 fs/jfs/jfs_imap.c  |  8 ++++----
 fs/jfs/jfs_inode.c |  4 ++--
 fs/jfs/namei.c     | 24 ++++++++++++------------
 fs/jfs/super.c     |  2 +-
 fs/jfs/xattr.c     |  2 +-
 8 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/fs/jfs/acl.c b/fs/jfs/acl.c
index fb96f872d207..1de3602c98de 100644
--- a/fs/jfs/acl.c
+++ b/fs/jfs/acl.c
@@ -116,7 +116,7 @@ int jfs_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 	if (!rc) {
 		if (update_mode) {
 			inode->i_mode = mode;
-			inode->i_ctime = current_time(inode);
+			inode_set_ctime_current(inode);
 			mark_inode_dirty(inode);
 		}
 		rc = txCommit(tid, 1, &inode, 0);
diff --git a/fs/jfs/inode.c b/fs/jfs/inode.c
index 8ac10e396050..920d58a1566b 100644
--- a/fs/jfs/inode.c
+++ b/fs/jfs/inode.c
@@ -393,7 +393,7 @@ void jfs_truncate_nolock(struct inode *ip, loff_t length)
 			break;
 		}
 
-		ip->i_mtime = ip->i_ctime = current_time(ip);
+		ip->i_mtime = inode_set_ctime_current(ip);
 		mark_inode_dirty(ip);
 
 		txCommit(tid, 1, &ip, 0);
diff --git a/fs/jfs/ioctl.c b/fs/jfs/ioctl.c
index ed7989bc2db1..f7bd7e8f5be4 100644
--- a/fs/jfs/ioctl.c
+++ b/fs/jfs/ioctl.c
@@ -96,7 +96,7 @@ int jfs_fileattr_set(struct mnt_idmap *idmap,
 	jfs_inode->mode2 = flags;
 
 	jfs_set_inode_flags(inode);
-	inode->i_ctime = current_time(inode);
+	inode_set_ctime_current(inode);
 	mark_inode_dirty(inode);
 
 	return 0;
diff --git a/fs/jfs/jfs_imap.c b/fs/jfs/jfs_imap.c
index 390cbfce391f..a40383aa6c84 100644
--- a/fs/jfs/jfs_imap.c
+++ b/fs/jfs/jfs_imap.c
@@ -3064,8 +3064,8 @@ static int copy_from_dinode(struct dinode * dip, struct inode *ip)
 	ip->i_atime.tv_nsec = le32_to_cpu(dip->di_atime.tv_nsec);
 	ip->i_mtime.tv_sec = le32_to_cpu(dip->di_mtime.tv_sec);
 	ip->i_mtime.tv_nsec = le32_to_cpu(dip->di_mtime.tv_nsec);
-	ip->i_ctime.tv_sec = le32_to_cpu(dip->di_ctime.tv_sec);
-	ip->i_ctime.tv_nsec = le32_to_cpu(dip->di_ctime.tv_nsec);
+	inode_set_ctime(ip, le32_to_cpu(dip->di_ctime.tv_sec),
+			le32_to_cpu(dip->di_ctime.tv_nsec));
 	ip->i_blocks = LBLK2PBLK(ip->i_sb, le64_to_cpu(dip->di_nblocks));
 	ip->i_generation = le32_to_cpu(dip->di_gen);
 
@@ -3139,8 +3139,8 @@ static void copy_to_dinode(struct dinode * dip, struct inode *ip)
 
 	dip->di_atime.tv_sec = cpu_to_le32(ip->i_atime.tv_sec);
 	dip->di_atime.tv_nsec = cpu_to_le32(ip->i_atime.tv_nsec);
-	dip->di_ctime.tv_sec = cpu_to_le32(ip->i_ctime.tv_sec);
-	dip->di_ctime.tv_nsec = cpu_to_le32(ip->i_ctime.tv_nsec);
+	dip->di_ctime.tv_sec = cpu_to_le32(inode_get_ctime(ip).tv_sec);
+	dip->di_ctime.tv_nsec = cpu_to_le32(inode_get_ctime(ip).tv_nsec);
 	dip->di_mtime.tv_sec = cpu_to_le32(ip->i_mtime.tv_sec);
 	dip->di_mtime.tv_nsec = cpu_to_le32(ip->i_mtime.tv_nsec);
 	dip->di_ixpxd = jfs_ip->ixpxd;	/* in-memory pxd's are little-endian */
diff --git a/fs/jfs/jfs_inode.c b/fs/jfs/jfs_inode.c
index 9e1f02767201..87594efa7f7c 100644
--- a/fs/jfs/jfs_inode.c
+++ b/fs/jfs/jfs_inode.c
@@ -97,8 +97,8 @@ struct inode *ialloc(struct inode *parent, umode_t mode)
 	jfs_inode->mode2 |= inode->i_mode;
 
 	inode->i_blocks = 0;
-	inode->i_mtime = inode->i_atime = inode->i_ctime = current_time(inode);
-	jfs_inode->otime = inode->i_ctime.tv_sec;
+	inode->i_mtime = inode->i_atime = inode_set_ctime_current(inode);
+	jfs_inode->otime = inode_get_ctime(inode).tv_sec;
 	inode->i_generation = JFS_SBI(sb)->gengen++;
 
 	jfs_inode->cflag = 0;
diff --git a/fs/jfs/namei.c b/fs/jfs/namei.c
index 9b030297aa64..541578126b1a 100644
--- a/fs/jfs/namei.c
+++ b/fs/jfs/namei.c
@@ -149,7 +149,7 @@ static int jfs_create(struct mnt_idmap *idmap, struct inode *dip,
 
 	mark_inode_dirty(ip);
 
-	dip->i_ctime = dip->i_mtime = current_time(dip);
+	dip->i_mtime = inode_set_ctime_current(dip);
 
 	mark_inode_dirty(dip);
 
@@ -284,7 +284,7 @@ static int jfs_mkdir(struct mnt_idmap *idmap, struct inode *dip,
 
 	/* update parent directory inode */
 	inc_nlink(dip);		/* for '..' from child directory */
-	dip->i_ctime = dip->i_mtime = current_time(dip);
+	dip->i_mtime = inode_set_ctime_current(dip);
 	mark_inode_dirty(dip);
 
 	rc = txCommit(tid, 2, &iplist[0], 0);
@@ -390,7 +390,7 @@ static int jfs_rmdir(struct inode *dip, struct dentry *dentry)
 	/* update parent directory's link count corresponding
 	 * to ".." entry of the target directory deleted
 	 */
-	dip->i_ctime = dip->i_mtime = current_time(dip);
+	dip->i_mtime = inode_set_ctime_current(dip);
 	inode_dec_link_count(dip);
 
 	/*
@@ -512,7 +512,7 @@ static int jfs_unlink(struct inode *dip, struct dentry *dentry)
 
 	ASSERT(ip->i_nlink);
 
-	ip->i_ctime = dip->i_ctime = dip->i_mtime = current_time(ip);
+	dip->i_mtime = inode_set_ctime_to_ts(dip, inode_set_ctime_current(ip));
 	mark_inode_dirty(dip);
 
 	/* update target's inode */
@@ -827,8 +827,8 @@ static int jfs_link(struct dentry *old_dentry,
 
 	/* update object inode */
 	inc_nlink(ip);		/* for new link */
-	ip->i_ctime = current_time(ip);
-	dir->i_ctime = dir->i_mtime = current_time(dir);
+	inode_set_ctime_current(ip);
+	dir->i_mtime = inode_set_ctime_current(dir);
 	mark_inode_dirty(dir);
 	ihold(ip);
 
@@ -1028,7 +1028,7 @@ static int jfs_symlink(struct mnt_idmap *idmap, struct inode *dip,
 
 	mark_inode_dirty(ip);
 
-	dip->i_ctime = dip->i_mtime = current_time(dip);
+	dip->i_mtime = inode_set_ctime_current(dip);
 	mark_inode_dirty(dip);
 	/*
 	 * commit update of parent directory and link object
@@ -1205,7 +1205,7 @@ static int jfs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 			tblk->xflag |= COMMIT_DELETE;
 			tblk->u.ip = new_ip;
 		} else {
-			new_ip->i_ctime = current_time(new_ip);
+			inode_set_ctime_current(new_ip);
 			mark_inode_dirty(new_ip);
 		}
 	} else {
@@ -1268,10 +1268,10 @@ static int jfs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 	/*
 	 * Update ctime on changed/moved inodes & mark dirty
 	 */
-	old_ip->i_ctime = current_time(old_ip);
+	inode_set_ctime_current(old_ip);
 	mark_inode_dirty(old_ip);
 
-	new_dir->i_ctime = new_dir->i_mtime = current_time(new_dir);
+	new_dir->i_mtime = inode_set_ctime_current(new_dir);
 	mark_inode_dirty(new_dir);
 
 	/* Build list of inodes modified by this transaction */
@@ -1283,7 +1283,7 @@ static int jfs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 
 	if (old_dir != new_dir) {
 		iplist[ipcount++] = new_dir;
-		old_dir->i_ctime = old_dir->i_mtime = current_time(old_dir);
+		old_dir->i_mtime = inode_set_ctime_current(old_dir);
 		mark_inode_dirty(old_dir);
 	}
 
@@ -1416,7 +1416,7 @@ static int jfs_mknod(struct mnt_idmap *idmap, struct inode *dir,
 
 	mark_inode_dirty(ip);
 
-	dir->i_ctime = dir->i_mtime = current_time(dir);
+	dir->i_mtime = inode_set_ctime_current(dir);
 
 	mark_inode_dirty(dir);
 
diff --git a/fs/jfs/super.c b/fs/jfs/super.c
index d2f82cb7db1b..2e2f7f6d36a0 100644
--- a/fs/jfs/super.c
+++ b/fs/jfs/super.c
@@ -818,7 +818,7 @@ static ssize_t jfs_quota_write(struct super_block *sb, int type,
 	}
 	if (inode->i_size < off+len-towrite)
 		i_size_write(inode, off+len-towrite);
-	inode->i_mtime = inode->i_ctime = current_time(inode);
+	inode->i_mtime = inode_set_ctime_current(inode);
 	mark_inode_dirty(inode);
 	inode_unlock(inode);
 	return len - towrite;
diff --git a/fs/jfs/xattr.c b/fs/jfs/xattr.c
index 931e50018f88..8577ad494e05 100644
--- a/fs/jfs/xattr.c
+++ b/fs/jfs/xattr.c
@@ -647,7 +647,7 @@ static int ea_put(tid_t tid, struct inode *inode, struct ea_buffer *ea_buf,
 	if (old_blocks)
 		dquot_free_block(inode, old_blocks);
 
-	inode->i_ctime = current_time(inode);
+	inode_set_ctime_current(inode);
 
 	return 0;
 }
-- 
2.41.0

