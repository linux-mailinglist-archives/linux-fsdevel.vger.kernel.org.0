Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 259B17B8BCF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Oct 2023 20:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244997AbjJDSzt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Oct 2023 14:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244909AbjJDSzR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Oct 2023 14:55:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76026CE;
        Wed,  4 Oct 2023 11:54:43 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81EBAC433C8;
        Wed,  4 Oct 2023 18:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696445683;
        bh=SZ6GtxYWFG+m2uoVVjthnxknAjsmUPNY0GAnxe0VeKA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KKugYXnikd3HwfhR6ajopt70yBFBNSfQlCCIN3HLz2BN3rTEAOBJXCh9w6FU8EukJ
         000cFbpFkl7BL0P63siq51N1YXXWrgyFul+D1l8VC2Km/qNTRPZRhLenka4PtFyl5M
         K8cko9eH8fIA2B3xrrSRs2nOJvHY9wwsIc+GNPlzs83mljqVaLvJ9EGJpc5sC0++8O
         YiWpzpBlNxqWygDdKVF+FW03ePk/fAeiN1wmtoKktIKYu3hU34yEsVDKQoVtZlMIKt
         twRTi5+WAaeGDL8gd8rmY/RwBEpMlJAACZ/RG36Gt7iwJLca+awDhwC+0zrj4Fy+DW
         zzdzA81Z6s6/Q==
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Dave Kleikamp <dave.kleikamp@oracle.com>,
        jfs-discussion@lists.sourceforge.net
Subject: [PATCH v2 48/89] jfs: convert to new timestamp accessors
Date:   Wed,  4 Oct 2023 14:52:33 -0400
Message-ID: <20231004185347.80880-46-jlayton@kernel.org>
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

Acked-by: Dave Kleikamp <dave.kleikamp@oracle.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/jfs/inode.c     |  2 +-
 fs/jfs/jfs_imap.c  | 20 ++++++++++----------
 fs/jfs/jfs_inode.c |  4 ++--
 fs/jfs/namei.c     | 20 +++++++++++---------
 fs/jfs/super.c     |  2 +-
 5 files changed, 25 insertions(+), 23 deletions(-)

diff --git a/fs/jfs/inode.c b/fs/jfs/inode.c
index 920d58a1566b..1a6b5921d17a 100644
--- a/fs/jfs/inode.c
+++ b/fs/jfs/inode.c
@@ -393,7 +393,7 @@ void jfs_truncate_nolock(struct inode *ip, loff_t length)
 			break;
 		}
 
-		ip->i_mtime = inode_set_ctime_current(ip);
+		inode_set_mtime_to_ts(ip, inode_set_ctime_current(ip));
 		mark_inode_dirty(ip);
 
 		txCommit(tid, 1, &ip, 0);
diff --git a/fs/jfs/jfs_imap.c b/fs/jfs/jfs_imap.c
index 923a58422c46..8e87264e56ce 100644
--- a/fs/jfs/jfs_imap.c
+++ b/fs/jfs/jfs_imap.c
@@ -3061,10 +3061,10 @@ static int copy_from_dinode(struct dinode * dip, struct inode *ip)
 	}
 
 	ip->i_size = le64_to_cpu(dip->di_size);
-	ip->i_atime.tv_sec = le32_to_cpu(dip->di_atime.tv_sec);
-	ip->i_atime.tv_nsec = le32_to_cpu(dip->di_atime.tv_nsec);
-	ip->i_mtime.tv_sec = le32_to_cpu(dip->di_mtime.tv_sec);
-	ip->i_mtime.tv_nsec = le32_to_cpu(dip->di_mtime.tv_nsec);
+	inode_set_atime(ip, le32_to_cpu(dip->di_atime.tv_sec),
+			le32_to_cpu(dip->di_atime.tv_nsec));
+	inode_set_mtime(ip, le32_to_cpu(dip->di_mtime.tv_sec),
+			le32_to_cpu(dip->di_mtime.tv_nsec));
 	inode_set_ctime(ip, le32_to_cpu(dip->di_ctime.tv_sec),
 			le32_to_cpu(dip->di_ctime.tv_nsec));
 	ip->i_blocks = LBLK2PBLK(ip->i_sb, le64_to_cpu(dip->di_nblocks));
@@ -3138,12 +3138,12 @@ static void copy_to_dinode(struct dinode * dip, struct inode *ip)
 	else /* Leave the original permissions alone */
 		dip->di_mode = cpu_to_le32(jfs_ip->mode2);
 
-	dip->di_atime.tv_sec = cpu_to_le32(ip->i_atime.tv_sec);
-	dip->di_atime.tv_nsec = cpu_to_le32(ip->i_atime.tv_nsec);
-	dip->di_ctime.tv_sec = cpu_to_le32(inode_get_ctime(ip).tv_sec);
-	dip->di_ctime.tv_nsec = cpu_to_le32(inode_get_ctime(ip).tv_nsec);
-	dip->di_mtime.tv_sec = cpu_to_le32(ip->i_mtime.tv_sec);
-	dip->di_mtime.tv_nsec = cpu_to_le32(ip->i_mtime.tv_nsec);
+	dip->di_atime.tv_sec = cpu_to_le32(inode_get_atime_sec(ip));
+	dip->di_atime.tv_nsec = cpu_to_le32(inode_get_atime_nsec(ip));
+	dip->di_ctime.tv_sec = cpu_to_le32(inode_get_ctime_sec(ip));
+	dip->di_ctime.tv_nsec = cpu_to_le32(inode_get_ctime_nsec(ip));
+	dip->di_mtime.tv_sec = cpu_to_le32(inode_get_mtime_sec(ip));
+	dip->di_mtime.tv_nsec = cpu_to_le32(inode_get_mtime_nsec(ip));
 	dip->di_ixpxd = jfs_ip->ixpxd;	/* in-memory pxd's are little-endian */
 	dip->di_acl = jfs_ip->acl;	/* as are dxd's */
 	dip->di_ea = jfs_ip->ea;
diff --git a/fs/jfs/jfs_inode.c b/fs/jfs/jfs_inode.c
index 87594efa7f7c..f10f295d1502 100644
--- a/fs/jfs/jfs_inode.c
+++ b/fs/jfs/jfs_inode.c
@@ -97,8 +97,8 @@ struct inode *ialloc(struct inode *parent, umode_t mode)
 	jfs_inode->mode2 |= inode->i_mode;
 
 	inode->i_blocks = 0;
-	inode->i_mtime = inode->i_atime = inode_set_ctime_current(inode);
-	jfs_inode->otime = inode_get_ctime(inode).tv_sec;
+	simple_inode_init_ts(inode);
+	jfs_inode->otime = inode_get_ctime_sec(inode);
 	inode->i_generation = JFS_SBI(sb)->gengen++;
 
 	jfs_inode->cflag = 0;
diff --git a/fs/jfs/namei.c b/fs/jfs/namei.c
index 57d7a4300210..d68a4e6ac345 100644
--- a/fs/jfs/namei.c
+++ b/fs/jfs/namei.c
@@ -149,7 +149,7 @@ static int jfs_create(struct mnt_idmap *idmap, struct inode *dip,
 
 	mark_inode_dirty(ip);
 
-	dip->i_mtime = inode_set_ctime_current(dip);
+	inode_set_mtime_to_ts(dip, inode_set_ctime_current(dip));
 
 	mark_inode_dirty(dip);
 
@@ -284,7 +284,7 @@ static int jfs_mkdir(struct mnt_idmap *idmap, struct inode *dip,
 
 	/* update parent directory inode */
 	inc_nlink(dip);		/* for '..' from child directory */
-	dip->i_mtime = inode_set_ctime_current(dip);
+	inode_set_mtime_to_ts(dip, inode_set_ctime_current(dip));
 	mark_inode_dirty(dip);
 
 	rc = txCommit(tid, 2, &iplist[0], 0);
@@ -390,7 +390,7 @@ static int jfs_rmdir(struct inode *dip, struct dentry *dentry)
 	/* update parent directory's link count corresponding
 	 * to ".." entry of the target directory deleted
 	 */
-	dip->i_mtime = inode_set_ctime_current(dip);
+	inode_set_mtime_to_ts(dip, inode_set_ctime_current(dip));
 	inode_dec_link_count(dip);
 
 	/*
@@ -512,7 +512,8 @@ static int jfs_unlink(struct inode *dip, struct dentry *dentry)
 
 	ASSERT(ip->i_nlink);
 
-	dip->i_mtime = inode_set_ctime_to_ts(dip, inode_set_ctime_current(ip));
+	inode_set_mtime_to_ts(dip,
+			      inode_set_ctime_to_ts(dip, inode_set_ctime_current(ip)));
 	mark_inode_dirty(dip);
 
 	/* update target's inode */
@@ -828,7 +829,7 @@ static int jfs_link(struct dentry *old_dentry,
 	/* update object inode */
 	inc_nlink(ip);		/* for new link */
 	inode_set_ctime_current(ip);
-	dir->i_mtime = inode_set_ctime_current(dir);
+	inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
 	mark_inode_dirty(dir);
 	ihold(ip);
 
@@ -1028,7 +1029,7 @@ static int jfs_symlink(struct mnt_idmap *idmap, struct inode *dip,
 
 	mark_inode_dirty(ip);
 
-	dip->i_mtime = inode_set_ctime_current(dip);
+	inode_set_mtime_to_ts(dip, inode_set_ctime_current(dip));
 	mark_inode_dirty(dip);
 	/*
 	 * commit update of parent directory and link object
@@ -1271,7 +1272,7 @@ static int jfs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 	inode_set_ctime_current(old_ip);
 	mark_inode_dirty(old_ip);
 
-	new_dir->i_mtime = inode_set_ctime_current(new_dir);
+	inode_set_mtime_to_ts(new_dir, inode_set_ctime_current(new_dir));
 	mark_inode_dirty(new_dir);
 
 	/* Build list of inodes modified by this transaction */
@@ -1283,7 +1284,8 @@ static int jfs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 
 	if (old_dir != new_dir) {
 		iplist[ipcount++] = new_dir;
-		old_dir->i_mtime = inode_set_ctime_current(old_dir);
+		inode_set_mtime_to_ts(old_dir,
+				      inode_set_ctime_current(old_dir));
 		mark_inode_dirty(old_dir);
 	}
 
@@ -1416,7 +1418,7 @@ static int jfs_mknod(struct mnt_idmap *idmap, struct inode *dir,
 
 	mark_inode_dirty(ip);
 
-	dir->i_mtime = inode_set_ctime_current(dir);
+	inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
 
 	mark_inode_dirty(dir);
 
diff --git a/fs/jfs/super.c b/fs/jfs/super.c
index 2e2f7f6d36a0..966826c394ee 100644
--- a/fs/jfs/super.c
+++ b/fs/jfs/super.c
@@ -818,7 +818,7 @@ static ssize_t jfs_quota_write(struct super_block *sb, int type,
 	}
 	if (inode->i_size < off+len-towrite)
 		i_size_write(inode, off+len-towrite);
-	inode->i_mtime = inode_set_ctime_current(inode);
+	inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
 	mark_inode_dirty(inode);
 	inode_unlock(inode);
 	return len - towrite;
-- 
2.41.0

