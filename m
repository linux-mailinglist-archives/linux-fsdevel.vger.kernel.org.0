Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C202D5B3868
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Sep 2022 15:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231131AbiIINAl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Sep 2022 09:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbiIINAi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Sep 2022 09:00:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 749D87F13A;
        Fri,  9 Sep 2022 06:00:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D10DBB824EF;
        Fri,  9 Sep 2022 13:00:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7632C433D7;
        Fri,  9 Sep 2022 13:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662728433;
        bh=TEWPiApm1m17MjS+y0T4ct2AJ4Ym+z+ovyYjPm3aSB4=;
        h=From:To:Cc:Subject:Date:From;
        b=en/ao+AbVLosPNC01LLk//D/wY9IZlT9yzu6E6mlIM0l2gp6BJP18zCvpxsyBtEmO
         0QWT46F+x5t3wkF86QW7a0BsBJeYFcwRotOo+TFRyO1DSDuXyNmhh8W4CTVpnaS7w6
         FjWtZM44NaVHMoaUyS7aCwAryusJb21F/ePWZuDehJvmTmv1zoDI8YWIutsB1jtKF6
         i/krX9reHIfUaePNPsubCJhbS8vCC8dwgGs/CYoeOyb3vDZFfz10VYgsbukMo4A/1l
         P0r3G2b5wKTW/8PfM3Y0h2fibmQIQu4OeK/D2nic4jeqxXFd+BnFxMElGDyMffmjYJ
         F9oRmerLWZ5cw==
From:   Jeff Layton <jlayton@kernel.org>
To:     hughd@google.com
Cc:     viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-nfs@vger.kernel.org,
        Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH] tmpfs: add support for an i_version counter
Date:   Fri,  9 Sep 2022 09:00:31 -0400
Message-Id: <20220909130031.15477-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.37.3
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

NFSv4 mandates a change attribute to avoid problems with timestamp
granularity, which Linux implements using the i_version counter. This is
particularly important when the underlying filesystem is fast.

Give tmpfs an i_version counter. Since it doesn't have to be persistent,
we can just turn on SB_I_VERSION and sprinkle some inode_inc_iversion
calls in the right places.

Also, while there is no formal spec for xattrs, most implementations
update the ctime on setxattr. Fix shmem_xattr_handler_set to update the
ctime and bump the i_version appropriately.

Cc: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/posix_acl.c |  3 +++
 mm/shmem.c     | 31 ++++++++++++++++++++++++++++---
 2 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/fs/posix_acl.c b/fs/posix_acl.c
index 5af33800743e..efb88a5e59f9 100644
--- a/fs/posix_acl.c
+++ b/fs/posix_acl.c
@@ -24,6 +24,7 @@
 #include <linux/user_namespace.h>
 #include <linux/namei.h>
 #include <linux/mnt_idmapping.h>
+#include <linux/iversion.h>
 
 static struct posix_acl **acl_by_type(struct inode *inode, int type)
 {
@@ -1073,6 +1074,8 @@ int simple_set_acl(struct user_namespace *mnt_userns, struct inode *inode,
 	}
 
 	inode->i_ctime = current_time(inode);
+	if (IS_I_VERSION(inode))
+		inode_inc_iversion(inode);
 	set_cached_acl(inode, type, acl);
 	return 0;
 }
diff --git a/mm/shmem.c b/mm/shmem.c
index 42e5888bf84d..84c1b7bf47ec 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -38,6 +38,7 @@
 #include <linux/hugetlb.h>
 #include <linux/fs_parser.h>
 #include <linux/swapfile.h>
+#include <linux/iversion.h>
 #include "swap.h"
 
 static struct vfsmount *shm_mnt;
@@ -1043,6 +1044,7 @@ void shmem_truncate_range(struct inode *inode, loff_t lstart, loff_t lend)
 {
 	shmem_undo_range(inode, lstart, lend, false);
 	inode->i_ctime = inode->i_mtime = current_time(inode);
+	inode_inc_iversion(inode);
 }
 EXPORT_SYMBOL_GPL(shmem_truncate_range);
 
@@ -1087,6 +1089,8 @@ static int shmem_setattr(struct user_namespace *mnt_userns,
 	struct inode *inode = d_inode(dentry);
 	struct shmem_inode_info *info = SHMEM_I(inode);
 	int error;
+	bool update_mtime = false;
+	bool update_ctime = true;
 
 	error = setattr_prepare(&init_user_ns, dentry, attr);
 	if (error)
@@ -1107,7 +1111,9 @@ static int shmem_setattr(struct user_namespace *mnt_userns,
 			if (error)
 				return error;
 			i_size_write(inode, newsize);
-			inode->i_ctime = inode->i_mtime = current_time(inode);
+			update_mtime = true;
+		} else {
+			update_ctime = false;
 		}
 		if (newsize <= oldsize) {
 			loff_t holebegin = round_up(newsize, PAGE_SIZE);
@@ -1127,6 +1133,12 @@ static int shmem_setattr(struct user_namespace *mnt_userns,
 	setattr_copy(&init_user_ns, inode, attr);
 	if (attr->ia_valid & ATTR_MODE)
 		error = posix_acl_chmod(&init_user_ns, inode, inode->i_mode);
+	if (!error && update_ctime) {
+		inode->i_ctime = current_time(inode);
+		if (update_mtime)
+			inode->i_mtime = inode->i_ctime;
+		inode_inc_iversion(inode);
+	}
 	return error;
 }
 
@@ -2901,6 +2913,7 @@ shmem_mknod(struct user_namespace *mnt_userns, struct inode *dir,
 		error = 0;
 		dir->i_size += BOGO_DIRENT_SIZE;
 		dir->i_ctime = dir->i_mtime = current_time(dir);
+		inode_inc_iversion(dir);
 		d_instantiate(dentry, inode);
 		dget(dentry); /* Extra count - pin the dentry in core */
 	}
@@ -2976,6 +2989,7 @@ static int shmem_link(struct dentry *old_dentry, struct inode *dir, struct dentr
 
 	dir->i_size += BOGO_DIRENT_SIZE;
 	inode->i_ctime = dir->i_ctime = dir->i_mtime = current_time(inode);
+	inode_inc_iversion(dir);
 	inc_nlink(inode);
 	ihold(inode);	/* New dentry reference */
 	dget(dentry);		/* Extra pinning count for the created dentry */
@@ -2993,6 +3007,7 @@ static int shmem_unlink(struct inode *dir, struct dentry *dentry)
 
 	dir->i_size -= BOGO_DIRENT_SIZE;
 	inode->i_ctime = dir->i_ctime = dir->i_mtime = current_time(inode);
+	inode_inc_iversion(dir);
 	drop_nlink(inode);
 	dput(dentry);	/* Undo the count from "create" - this does all the work */
 	return 0;
@@ -3082,6 +3097,8 @@ static int shmem_rename2(struct user_namespace *mnt_userns,
 	old_dir->i_ctime = old_dir->i_mtime =
 	new_dir->i_ctime = new_dir->i_mtime =
 	inode->i_ctime = current_time(old_dir);
+	inode_inc_iversion(old_dir);
+	inode_inc_iversion(new_dir);
 	return 0;
 }
 
@@ -3134,6 +3151,7 @@ static int shmem_symlink(struct user_namespace *mnt_userns, struct inode *dir,
 	}
 	dir->i_size += BOGO_DIRENT_SIZE;
 	dir->i_ctime = dir->i_mtime = current_time(dir);
+	inode_inc_iversion(dir);
 	d_instantiate(dentry, inode);
 	dget(dentry);
 	return 0;
@@ -3204,6 +3222,7 @@ static int shmem_fileattr_set(struct user_namespace *mnt_userns,
 
 	shmem_set_inode_flags(inode, info->fsflags);
 	inode->i_ctime = current_time(inode);
+	inode_inc_iversion(inode);
 	return 0;
 }
 
@@ -3267,9 +3286,15 @@ static int shmem_xattr_handler_set(const struct xattr_handler *handler,
 				   size_t size, int flags)
 {
 	struct shmem_inode_info *info = SHMEM_I(inode);
+	int err;
 
 	name = xattr_full_name(handler, name);
-	return simple_xattr_set(&info->xattrs, name, value, size, flags, NULL);
+	err = simple_xattr_set(&info->xattrs, name, value, size, flags, NULL);
+	if (!err) {
+		inode->i_ctime = current_time(inode);
+		inode_inc_iversion(inode);
+	}
+	return err;
 }
 
 static const struct xattr_handler shmem_security_xattr_handler = {
@@ -3732,7 +3757,7 @@ static int shmem_fill_super(struct super_block *sb, struct fs_context *fc)
 		sb->s_flags |= SB_NOUSER;
 	}
 	sb->s_export_op = &shmem_export_ops;
-	sb->s_flags |= SB_NOSEC;
+	sb->s_flags |= SB_NOSEC | SB_I_VERSION;
 #else
 	sb->s_flags |= SB_NOUSER;
 #endif
-- 
2.37.3

