Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E1FE6ED105
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Apr 2023 17:11:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232051AbjDXPLR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Apr 2023 11:11:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232029AbjDXPLN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Apr 2023 11:11:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 875EC1708;
        Mon, 24 Apr 2023 08:11:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1F3B0625E5;
        Mon, 24 Apr 2023 15:11:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39C69C4339C;
        Mon, 24 Apr 2023 15:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682349071;
        bh=LE5Eh9ovFKUm6KJZ5P5kcewXFLQQROg06eiUbScjjvk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RCcnsNKq9Vn2vd/wl6VSl9MN7DxhyK8G1mY+jWZnjnryRrlkS0rhMKHuTSC3ri9t9
         GQxDuTIz2MuB+V5MI3ipC9bH4+AGx2c73mWtBY3yRK/GVGUEa2PmUYLaTTj2lMw8SG
         j0jPJBWLWSDPqmUE3BOP/x7uSu+VcN1L+3xK3hRWQFrWYmXXhh3+oKPNOZKZLVgTIo
         xK2gVP60nWvtSHf9lcm4va0zxcLYoEm5MFZwe4cIDhVmMyyB85kQTwC+G9afH/AbHc
         PgGqDaBcW/XRkDUMVrLtsb2JXP2GhN+Gy7p1oLA2GH4Po1aVbgKCOcPtBY1C2nQ/nO
         C5bqLSvFz9HtQ==
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Chinner <david@fromorbit.com>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-nfs@vger.kernel.org
Subject: [PATCH v2 2/3] shmem: mark for high-res timestamps on next update after getattr
Date:   Mon, 24 Apr 2023 11:11:03 -0400
Message-Id: <20230424151104.175456-3-jlayton@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230424151104.175456-1-jlayton@kernel.org>
References: <20230424151104.175456-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Change the s_time_gran for tmpfs to 2, to make it eligible to use the
low order bit as a flag. Switch to the current_ctime helper instead
of current_time.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 mm/shmem.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 448f393d8ab2..497ffa29d172 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1039,7 +1039,7 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
 void shmem_truncate_range(struct inode *inode, loff_t lstart, loff_t lend)
 {
 	shmem_undo_range(inode, lstart, lend, false);
-	inode->i_ctime = inode->i_mtime = current_time(inode);
+	inode->i_ctime = inode->i_mtime = current_ctime(inode);
 	inode_inc_iversion(inode);
 }
 EXPORT_SYMBOL_GPL(shmem_truncate_range);
@@ -1070,6 +1070,11 @@ static int shmem_getattr(struct mnt_idmap *idmap,
 	if (shmem_is_huge(inode, 0, false, NULL, 0))
 		stat->blksize = HPAGE_PMD_SIZE;
 
+	if (request_mask & (STATX_CTIME|STATX_MTIME))
+		generic_fill_multigrain_cmtime(inode, stat);
+	else
+		stat->result_mask &= ~(STATX_CTIME|STATX_MTIME);
+
 	if (request_mask & STATX_BTIME) {
 		stat->result_mask |= STATX_BTIME;
 		stat->btime.tv_sec = info->i_crtime.tv_sec;
@@ -1136,7 +1141,7 @@ static int shmem_setattr(struct mnt_idmap *idmap,
 	if (attr->ia_valid & ATTR_MODE)
 		error = posix_acl_chmod(idmap, dentry, inode->i_mode);
 	if (!error && update_ctime) {
-		inode->i_ctime = current_time(inode);
+		inode->i_ctime = current_ctime(inode);
 		if (update_mtime)
 			inode->i_mtime = inode->i_ctime;
 		inode_inc_iversion(inode);
@@ -2361,7 +2366,7 @@ static struct inode *shmem_get_inode(struct mnt_idmap *idmap, struct super_block
 		inode->i_ino = ino;
 		inode_init_owner(idmap, inode, dir, mode);
 		inode->i_blocks = 0;
-		inode->i_atime = inode->i_mtime = inode->i_ctime = current_time(inode);
+		inode->i_atime = inode->i_mtime = inode->i_ctime = current_ctime(inode);
 		inode->i_generation = get_random_u32();
 		info = SHMEM_I(inode);
 		memset(info, 0, (char *)inode - (char *)info);
@@ -2940,7 +2945,7 @@ shmem_mknod(struct mnt_idmap *idmap, struct inode *dir,
 
 		error = 0;
 		dir->i_size += BOGO_DIRENT_SIZE;
-		dir->i_ctime = dir->i_mtime = current_time(dir);
+		dir->i_ctime = dir->i_mtime = current_ctime(dir);
 		inode_inc_iversion(dir);
 		d_instantiate(dentry, inode);
 		dget(dentry); /* Extra count - pin the dentry in core */
@@ -3016,7 +3021,7 @@ static int shmem_link(struct dentry *old_dentry, struct inode *dir, struct dentr
 	}
 
 	dir->i_size += BOGO_DIRENT_SIZE;
-	inode->i_ctime = dir->i_ctime = dir->i_mtime = current_time(inode);
+	inode->i_ctime = dir->i_ctime = dir->i_mtime = current_ctime(inode);
 	inode_inc_iversion(dir);
 	inc_nlink(inode);
 	ihold(inode);	/* New dentry reference */
@@ -3034,7 +3039,7 @@ static int shmem_unlink(struct inode *dir, struct dentry *dentry)
 		shmem_free_inode(inode->i_sb);
 
 	dir->i_size -= BOGO_DIRENT_SIZE;
-	inode->i_ctime = dir->i_ctime = dir->i_mtime = current_time(inode);
+	inode->i_ctime = dir->i_ctime = dir->i_mtime = current_ctime(inode);
 	inode_inc_iversion(dir);
 	drop_nlink(inode);
 	dput(dentry);	/* Undo the count from "create" - this does all the work */
@@ -3124,7 +3129,7 @@ static int shmem_rename2(struct mnt_idmap *idmap,
 	new_dir->i_size += BOGO_DIRENT_SIZE;
 	old_dir->i_ctime = old_dir->i_mtime =
 	new_dir->i_ctime = new_dir->i_mtime =
-	inode->i_ctime = current_time(old_dir);
+	inode->i_ctime = current_ctime(old_dir);
 	inode_inc_iversion(old_dir);
 	inode_inc_iversion(new_dir);
 	return 0;
@@ -3178,7 +3183,7 @@ static int shmem_symlink(struct mnt_idmap *idmap, struct inode *dir,
 		folio_put(folio);
 	}
 	dir->i_size += BOGO_DIRENT_SIZE;
-	dir->i_ctime = dir->i_mtime = current_time(dir);
+	dir->i_ctime = dir->i_mtime = current_ctime(dir);
 	inode_inc_iversion(dir);
 	d_instantiate(dentry, inode);
 	dget(dentry);
@@ -3250,7 +3255,7 @@ static int shmem_fileattr_set(struct mnt_idmap *idmap,
 		(fa->flags & SHMEM_FL_USER_MODIFIABLE);
 
 	shmem_set_inode_flags(inode, info->fsflags);
-	inode->i_ctime = current_time(inode);
+	inode->i_ctime = current_ctime(inode);
 	inode_inc_iversion(inode);
 	return 0;
 }
@@ -3320,7 +3325,7 @@ static int shmem_xattr_handler_set(const struct xattr_handler *handler,
 	name = xattr_full_name(handler, name);
 	err = simple_xattr_set(&info->xattrs, name, value, size, flags, NULL);
 	if (!err) {
-		inode->i_ctime = current_time(inode);
+		inode->i_ctime = current_ctime(inode);
 		inode_inc_iversion(inode);
 	}
 	return err;
@@ -3786,7 +3791,7 @@ static int shmem_fill_super(struct super_block *sb, struct fs_context *fc)
 		sb->s_flags |= SB_NOUSER;
 	}
 	sb->s_export_op = &shmem_export_ops;
-	sb->s_flags |= SB_NOSEC | SB_I_VERSION;
+	sb->s_flags |= SB_NOSEC | SB_I_VERSION | SB_MULTIGRAIN_TS;
 #else
 	sb->s_flags |= SB_NOUSER;
 #endif
@@ -3816,7 +3821,7 @@ static int shmem_fill_super(struct super_block *sb, struct fs_context *fc)
 	sb->s_blocksize_bits = PAGE_SHIFT;
 	sb->s_magic = TMPFS_MAGIC;
 	sb->s_op = &shmem_ops;
-	sb->s_time_gran = 1;
+	sb->s_time_gran = 2;
 #ifdef CONFIG_TMPFS_XATTR
 	sb->s_xattr = shmem_xattr_handlers;
 #endif
-- 
2.40.0

