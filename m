Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C52F748CFB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jul 2023 21:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233727AbjGETFj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jul 2023 15:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233356AbjGETE5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jul 2023 15:04:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9150C19BF;
        Wed,  5 Jul 2023 12:03:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DA8AF616EF;
        Wed,  5 Jul 2023 19:03:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C394C433C8;
        Wed,  5 Jul 2023 19:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688583827;
        bh=7amT9DrYu70ALB4f/8ioI9ChjNtEorP9RC8mHDJNfS0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Djy35r/JI60Pfe0ZiI+Z9tvfNL61rTokHFk5MxL+luQelNZiTKVK6XlUnKTqVOt7h
         10wc/pvErEgXyHf2RIUkXE4zE0UH3TK539DVcK0STS8UwkLmUkQlS66S3CcESJUIjC
         AC8Hr7c/iVK6xSwF3K4jPkjuBHYKz6BBOczAdB0F23f+G6uCV10RTaUgr2OaFK+Esr
         snFQPsZmnj2p9zcyrG0UVBJOmgvGgCgXp07gJ6a38nxOzeW5Fo4L/+ar/BjgcCow6L
         wwYrrso5LR4MSzSjySjM4N3yXTZyJ2qAk7DRfIiMn2vE3HwCBbk1wo4IFo95+y6M58
         6XAVG3Zw534ow==
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v2 25/92] fs: convert to ctime accessor functions
Date:   Wed,  5 Jul 2023 15:00:50 -0400
Message-ID: <20230705190309.579783-23-jlayton@kernel.org>
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

Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/attr.c        |  2 +-
 fs/bad_inode.c   |  3 +--
 fs/binfmt_misc.c |  3 +--
 fs/inode.c       | 10 +++++++---
 fs/nsfs.c        |  2 +-
 fs/pipe.c        |  2 +-
 fs/posix_acl.c   |  2 +-
 fs/stack.c       |  2 +-
 fs/stat.c        |  2 +-
 9 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/fs/attr.c b/fs/attr.c
index d60dc1edb526..599f6d14c0ed 100644
--- a/fs/attr.c
+++ b/fs/attr.c
@@ -312,7 +312,7 @@ void setattr_copy(struct mnt_idmap *idmap, struct inode *inode,
 	if (ia_valid & ATTR_MTIME)
 		inode->i_mtime = attr->ia_mtime;
 	if (ia_valid & ATTR_CTIME)
-		inode->i_ctime = attr->ia_ctime;
+		inode_set_ctime_to_ts(inode, attr->ia_ctime);
 	if (ia_valid & ATTR_MODE) {
 		umode_t mode = attr->ia_mode;
 		if (!in_group_or_capable(idmap, inode,
diff --git a/fs/bad_inode.c b/fs/bad_inode.c
index db649487d58c..6e21f7412a85 100644
--- a/fs/bad_inode.c
+++ b/fs/bad_inode.c
@@ -209,8 +209,7 @@ void make_bad_inode(struct inode *inode)
 	remove_inode_hash(inode);
 
 	inode->i_mode = S_IFREG;
-	inode->i_atime = inode->i_mtime = inode->i_ctime =
-		current_time(inode);
+	inode->i_atime = inode->i_mtime = inode_set_ctime_current(inode);
 	inode->i_op = &bad_inode_ops;	
 	inode->i_opflags &= ~IOP_XATTR;
 	inode->i_fop = &bad_file_ops;	
diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
index bb202ad369d5..e0108d17b085 100644
--- a/fs/binfmt_misc.c
+++ b/fs/binfmt_misc.c
@@ -547,8 +547,7 @@ static struct inode *bm_get_inode(struct super_block *sb, int mode)
 	if (inode) {
 		inode->i_ino = get_next_ino();
 		inode->i_mode = mode;
-		inode->i_atime = inode->i_mtime = inode->i_ctime =
-			current_time(inode);
+		inode->i_atime = inode->i_mtime = inode_set_ctime_current(inode);
 	}
 	return inode;
 }
diff --git a/fs/inode.c b/fs/inode.c
index 21b026d95b51..32e08c3fa9ff 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1851,6 +1851,7 @@ EXPORT_SYMBOL(bmap);
 static int relatime_need_update(struct vfsmount *mnt, struct inode *inode,
 			     struct timespec64 now)
 {
+	struct timespec64 ctime;
 
 	if (!(mnt->mnt_flags & MNT_RELATIME))
 		return 1;
@@ -1862,7 +1863,8 @@ static int relatime_need_update(struct vfsmount *mnt, struct inode *inode,
 	/*
 	 * Is ctime younger than or equal to atime? If yes, update atime:
 	 */
-	if (timespec64_compare(&inode->i_ctime, &inode->i_atime) >= 0)
+	ctime = inode_get_ctime(inode);
+	if (timespec64_compare(&ctime, &inode->i_atime) >= 0)
 		return 1;
 
 	/*
@@ -1885,7 +1887,7 @@ int generic_update_time(struct inode *inode, struct timespec64 *time, int flags)
 		if (flags & S_ATIME)
 			inode->i_atime = *time;
 		if (flags & S_CTIME)
-			inode->i_ctime = *time;
+			inode_set_ctime_to_ts(inode, *time);
 		if (flags & S_MTIME)
 			inode->i_mtime = *time;
 
@@ -2071,6 +2073,7 @@ EXPORT_SYMBOL(file_remove_privs);
 static int inode_needs_update_time(struct inode *inode, struct timespec64 *now)
 {
 	int sync_it = 0;
+	struct timespec64 ctime;
 
 	/* First try to exhaust all avenues to not sync */
 	if (IS_NOCMTIME(inode))
@@ -2079,7 +2082,8 @@ static int inode_needs_update_time(struct inode *inode, struct timespec64 *now)
 	if (!timespec64_equal(&inode->i_mtime, now))
 		sync_it = S_MTIME;
 
-	if (!timespec64_equal(&inode->i_ctime, now))
+	ctime = inode_get_ctime(inode);
+	if (!timespec64_equal(&ctime, now))
 		sync_it |= S_CTIME;
 
 	if (IS_I_VERSION(inode) && inode_iversion_need_inc(inode))
diff --git a/fs/nsfs.c b/fs/nsfs.c
index f602a96a1afe..647a22433bd8 100644
--- a/fs/nsfs.c
+++ b/fs/nsfs.c
@@ -84,7 +84,7 @@ static int __ns_get_path(struct path *path, struct ns_common *ns)
 		return -ENOMEM;
 	}
 	inode->i_ino = ns->inum;
-	inode->i_mtime = inode->i_atime = inode->i_ctime = current_time(inode);
+	inode->i_mtime = inode->i_atime = inode_set_ctime_current(inode);
 	inode->i_flags |= S_IMMUTABLE;
 	inode->i_mode = S_IFREG | S_IRUGO;
 	inode->i_fop = &ns_file_operations;
diff --git a/fs/pipe.c b/fs/pipe.c
index 2d88f73f585a..174682103669 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -899,7 +899,7 @@ static struct inode * get_pipe_inode(void)
 	inode->i_mode = S_IFIFO | S_IRUSR | S_IWUSR;
 	inode->i_uid = current_fsuid();
 	inode->i_gid = current_fsgid();
-	inode->i_atime = inode->i_mtime = inode->i_ctime = current_time(inode);
+	inode->i_atime = inode->i_mtime = inode_set_ctime_current(inode);
 
 	return inode;
 
diff --git a/fs/posix_acl.c b/fs/posix_acl.c
index 7fa1b738bbab..a05fe94970ce 100644
--- a/fs/posix_acl.c
+++ b/fs/posix_acl.c
@@ -1027,7 +1027,7 @@ int simple_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 			return error;
 	}
 
-	inode->i_ctime = current_time(inode);
+	inode_set_ctime_current(inode);
 	if (IS_I_VERSION(inode))
 		inode_inc_iversion(inode);
 	set_cached_acl(inode, type, acl);
diff --git a/fs/stack.c b/fs/stack.c
index c9830924eb12..b5e01bdb5f5f 100644
--- a/fs/stack.c
+++ b/fs/stack.c
@@ -68,7 +68,7 @@ void fsstack_copy_attr_all(struct inode *dest, const struct inode *src)
 	dest->i_rdev = src->i_rdev;
 	dest->i_atime = src->i_atime;
 	dest->i_mtime = src->i_mtime;
-	dest->i_ctime = src->i_ctime;
+	inode_set_ctime_to_ts(dest, inode_get_ctime(src));
 	dest->i_blkbits = src->i_blkbits;
 	dest->i_flags = src->i_flags;
 	set_nlink(dest, src->i_nlink);
diff --git a/fs/stat.c b/fs/stat.c
index 7c238da22ef0..8c2b30af19f5 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -58,7 +58,7 @@ void generic_fillattr(struct mnt_idmap *idmap, struct inode *inode,
 	stat->size = i_size_read(inode);
 	stat->atime = inode->i_atime;
 	stat->mtime = inode->i_mtime;
-	stat->ctime = inode->i_ctime;
+	stat->ctime = inode_get_ctime(inode);
 	stat->blksize = i_blocksize(inode);
 	stat->blocks = inode->i_blocks;
 }
-- 
2.41.0

