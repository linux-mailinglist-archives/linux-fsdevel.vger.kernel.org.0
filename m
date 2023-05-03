Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7DA16F59C8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 May 2023 16:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbjECOVD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 May 2023 10:21:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230241AbjECOUu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 May 2023 10:20:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7088C5FD9;
        Wed,  3 May 2023 07:20:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0B16F62DE7;
        Wed,  3 May 2023 14:20:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 639D7C433A1;
        Wed,  3 May 2023 14:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683123647;
        bh=woIUOU498nUTE5btDBpQ1yKRVkawRsDiB5Yp3W19NdI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Om8LVt4K3N9F7622+ejSixfyVUyOVVN6dY1egeJahkO7AzyqPpfLj75J1pHWJN8TO
         uGx0EIW9bi4lqI8I0geWzqdm30RQ4XN3f0DFx1Lyp2EpoV32o9/T9/ndRxDRBgC04x
         Pn6UVxX5s2T+EcX2TyeEn/TxgZ3z4V9TTHzOc5Ywt09oTCz+6ngFkqLKHF0ynFds9D
         blpr2OAwWV2CkXyHMAtN6SFCtVezRKhvJFPvncyGcXfFHvxge4l8rjK81QZ4MIuG5Q
         dyO6Yvyr5VQmzzCvvzMZYKzMenuOib53gQz2A0JUpJBgD2ixGqjrabRFpCDpAhG95U
         PQAuYPRQ5nD8w==
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Chinner <david@fromorbit.com>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Neil Brown <neilb@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Theodore T'so <tytso@mit.edu>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-mm@kvack.org, linux-nfs@vger.kernel.org
Subject: [PATCH v3 3/6] shmem: convert to multigrain timestamps
Date:   Wed,  3 May 2023 10:20:34 -0400
Message-Id: <20230503142037.153531-4-jlayton@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230503142037.153531-1-jlayton@kernel.org>
References: <20230503142037.153531-1-jlayton@kernel.org>
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

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 mm/shmem.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 448f393d8ab2..40c794a7baa8 100644
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
@@ -1066,6 +1066,7 @@ static int shmem_getattr(struct mnt_idmap *idmap,
 			STATX_ATTR_IMMUTABLE |
 			STATX_ATTR_NODUMP);
 	generic_fillattr(idmap, inode, stat);
+	generic_fill_multigrain_cmtime(request_mask, inode, stat);
 
 	if (shmem_is_huge(inode, 0, false, NULL, 0))
 		stat->blksize = HPAGE_PMD_SIZE;
@@ -1136,7 +1137,7 @@ static int shmem_setattr(struct mnt_idmap *idmap,
 	if (attr->ia_valid & ATTR_MODE)
 		error = posix_acl_chmod(idmap, dentry, inode->i_mode);
 	if (!error && update_ctime) {
-		inode->i_ctime = current_time(inode);
+		inode->i_ctime = current_ctime(inode);
 		if (update_mtime)
 			inode->i_mtime = inode->i_ctime;
 		inode_inc_iversion(inode);
@@ -2361,7 +2362,7 @@ static struct inode *shmem_get_inode(struct mnt_idmap *idmap, struct super_block
 		inode->i_ino = ino;
 		inode_init_owner(idmap, inode, dir, mode);
 		inode->i_blocks = 0;
-		inode->i_atime = inode->i_mtime = inode->i_ctime = current_time(inode);
+		inode->i_atime = inode->i_mtime = inode->i_ctime = current_ctime(inode);
 		inode->i_generation = get_random_u32();
 		info = SHMEM_I(inode);
 		memset(info, 0, (char *)inode - (char *)info);
@@ -2940,7 +2941,7 @@ shmem_mknod(struct mnt_idmap *idmap, struct inode *dir,
 
 		error = 0;
 		dir->i_size += BOGO_DIRENT_SIZE;
-		dir->i_ctime = dir->i_mtime = current_time(dir);
+		dir->i_ctime = dir->i_mtime = current_ctime(dir);
 		inode_inc_iversion(dir);
 		d_instantiate(dentry, inode);
 		dget(dentry); /* Extra count - pin the dentry in core */
@@ -3016,7 +3017,7 @@ static int shmem_link(struct dentry *old_dentry, struct inode *dir, struct dentr
 	}
 
 	dir->i_size += BOGO_DIRENT_SIZE;
-	inode->i_ctime = dir->i_ctime = dir->i_mtime = current_time(inode);
+	inode->i_ctime = dir->i_ctime = dir->i_mtime = current_ctime(inode);
 	inode_inc_iversion(dir);
 	inc_nlink(inode);
 	ihold(inode);	/* New dentry reference */
@@ -3034,7 +3035,7 @@ static int shmem_unlink(struct inode *dir, struct dentry *dentry)
 		shmem_free_inode(inode->i_sb);
 
 	dir->i_size -= BOGO_DIRENT_SIZE;
-	inode->i_ctime = dir->i_ctime = dir->i_mtime = current_time(inode);
+	inode->i_ctime = dir->i_ctime = dir->i_mtime = current_ctime(inode);
 	inode_inc_iversion(dir);
 	drop_nlink(inode);
 	dput(dentry);	/* Undo the count from "create" - this does all the work */
@@ -3124,7 +3125,7 @@ static int shmem_rename2(struct mnt_idmap *idmap,
 	new_dir->i_size += BOGO_DIRENT_SIZE;
 	old_dir->i_ctime = old_dir->i_mtime =
 	new_dir->i_ctime = new_dir->i_mtime =
-	inode->i_ctime = current_time(old_dir);
+	inode->i_ctime = current_ctime(old_dir);
 	inode_inc_iversion(old_dir);
 	inode_inc_iversion(new_dir);
 	return 0;
@@ -3178,7 +3179,7 @@ static int shmem_symlink(struct mnt_idmap *idmap, struct inode *dir,
 		folio_put(folio);
 	}
 	dir->i_size += BOGO_DIRENT_SIZE;
-	dir->i_ctime = dir->i_mtime = current_time(dir);
+	dir->i_ctime = dir->i_mtime = current_ctime(dir);
 	inode_inc_iversion(dir);
 	d_instantiate(dentry, inode);
 	dget(dentry);
@@ -3250,7 +3251,7 @@ static int shmem_fileattr_set(struct mnt_idmap *idmap,
 		(fa->flags & SHMEM_FL_USER_MODIFIABLE);
 
 	shmem_set_inode_flags(inode, info->fsflags);
-	inode->i_ctime = current_time(inode);
+	inode->i_ctime = current_ctime(inode);
 	inode_inc_iversion(inode);
 	return 0;
 }
@@ -3320,7 +3321,7 @@ static int shmem_xattr_handler_set(const struct xattr_handler *handler,
 	name = xattr_full_name(handler, name);
 	err = simple_xattr_set(&info->xattrs, name, value, size, flags, NULL);
 	if (!err) {
-		inode->i_ctime = current_time(inode);
+		inode->i_ctime = current_ctime(inode);
 		inode_inc_iversion(inode);
 	}
 	return err;
@@ -4052,9 +4053,9 @@ static struct file_system_type shmem_fs_type = {
 #endif
 	.kill_sb	= kill_litter_super,
 #ifdef CONFIG_SHMEM
-	.fs_flags	= FS_USERNS_MOUNT | FS_ALLOW_IDMAP,
+	.fs_flags	= FS_USERNS_MOUNT | FS_ALLOW_IDMAP | FS_MULTIGRAIN_TS
 #else
-	.fs_flags	= FS_USERNS_MOUNT,
+	.fs_flags	= FS_USERNS_MOUNT | FS_MULTIGRAIN_TS,
 #endif
 };
 
-- 
2.40.1

