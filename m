Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3882F7B19EF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Sep 2023 13:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231919AbjI1LHc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Sep 2023 07:07:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231851AbjI1LFh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Sep 2023 07:05:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 099A610FE;
        Thu, 28 Sep 2023 04:04:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FE21C433C8;
        Thu, 28 Sep 2023 11:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695899097;
        bh=LKLhIsUTFieq68OcX4ILSefLHySzq9aIRjDYBRwnayg=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=it9kxg8aa+2XWHa3Eb/OhbYUr/Et5qT+JxeCzVJ9ZE2GlFoXb9Cd/l9gdZwjxEies
         dxllCJ2pTJ+IbnaA/yk0qYNhq0DSHXBP7mIkYJVxpjXAZ2tm1+D6LEny9pHKonI4hV
         j5bEKsyAnNuF1KZ+DM5M5n6d2k1S7dNViLC/NdNQcX8VJdqs1q1KHR+1rMVZqOF5xS
         10g7ss/rckbaLCQjFm2wTfK06xoASWzcrDRNN2Dxj7uZtvKk9GPo6l91Q9GrcYMA4i
         UktliHZ2EMISMphafK8DSHBQqxfTAJEh2s83krJ8qR6iZhhOPRR3gUBZ8I+6Vf75T3
         mbOiM3cjC4hsA==
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 38/87] fs/fuse: convert to new inode {a,m}time accessors
Date:   Thu, 28 Sep 2023 07:02:47 -0400
Message-ID: <20230928110413.33032-37-jlayton@kernel.org>
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
 fs/fuse/control.c |  2 +-
 fs/fuse/dir.c     |  6 +++---
 fs/fuse/inode.c   | 25 ++++++++++++-------------
 fs/fuse/readdir.c |  6 ++++--
 4 files changed, 20 insertions(+), 19 deletions(-)

diff --git a/fs/fuse/control.c b/fs/fuse/control.c
index ab62e4624256..284a35006462 100644
--- a/fs/fuse/control.c
+++ b/fs/fuse/control.c
@@ -235,7 +235,7 @@ static struct dentry *fuse_ctl_add_dentry(struct dentry *parent,
 	inode->i_mode = mode;
 	inode->i_uid = fc->user_id;
 	inode->i_gid = fc->group_id;
-	inode->i_atime = inode->i_mtime = inode_set_ctime_current(inode);
+	simple_inode_init_ts(inode);
 	/* setting ->i_op to NULL is not allowed */
 	if (iop)
 		inode->i_op = iop;
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index d707e6987da9..bc2e2ee7eb20 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1812,8 +1812,8 @@ int fuse_flush_times(struct inode *inode, struct fuse_file *ff)
 	memset(&outarg, 0, sizeof(outarg));
 
 	inarg.valid = FATTR_MTIME;
-	inarg.mtime = inode->i_mtime.tv_sec;
-	inarg.mtimensec = inode->i_mtime.tv_nsec;
+	inarg.mtime = inode_get_mtime(inode).tv_sec;
+	inarg.mtimensec = inode_get_mtime(inode).tv_nsec;
 	if (fm->fc->minor >= 23) {
 		inarg.valid |= FATTR_CTIME;
 		inarg.ctime = inode_get_ctime(inode).tv_sec;
@@ -1956,7 +1956,7 @@ int fuse_do_setattr(struct dentry *dentry, struct iattr *attr,
 	/* the kernel maintains i_mtime locally */
 	if (trust_local_cmtime) {
 		if (attr->ia_valid & ATTR_MTIME)
-			inode->i_mtime = attr->ia_mtime;
+			inode_set_mtime_to_ts(inode, attr->ia_mtime);
 		if (attr->ia_valid & ATTR_CTIME)
 			inode_set_ctime_to_ts(inode, attr->ia_ctime);
 		/* FIXME: clear I_DIRTY_SYNC? */
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 2e4eb7cf26fb..ab70dc3f00fa 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -188,12 +188,10 @@ void fuse_change_attributes_common(struct inode *inode, struct fuse_attr *attr,
 	attr->mtimensec = min_t(u32, attr->mtimensec, NSEC_PER_SEC - 1);
 	attr->ctimensec = min_t(u32, attr->ctimensec, NSEC_PER_SEC - 1);
 
-	inode->i_atime.tv_sec   = attr->atime;
-	inode->i_atime.tv_nsec  = attr->atimensec;
+	inode_set_atime(inode, attr->atime, attr->atimensec);
 	/* mtime from server may be stale due to local buffered write */
 	if (!(cache_mask & STATX_MTIME)) {
-		inode->i_mtime.tv_sec   = attr->mtime;
-		inode->i_mtime.tv_nsec  = attr->mtimensec;
+		inode_set_mtime(inode, attr->mtime, attr->mtimensec);
 	}
 	if (!(cache_mask & STATX_CTIME)) {
 		inode_set_ctime(inode, attr->ctime, attr->ctimensec);
@@ -276,8 +274,8 @@ void fuse_change_attributes(struct inode *inode, struct fuse_attr *attr,
 		attr->size = i_size_read(inode);
 
 	if (cache_mask & STATX_MTIME) {
-		attr->mtime = inode->i_mtime.tv_sec;
-		attr->mtimensec = inode->i_mtime.tv_nsec;
+		attr->mtime = inode_get_mtime(inode).tv_sec;
+		attr->mtimensec = inode_get_mtime(inode).tv_nsec;
 	}
 	if (cache_mask & STATX_CTIME) {
 		attr->ctime = inode_get_ctime(inode).tv_sec;
@@ -290,7 +288,7 @@ void fuse_change_attributes(struct inode *inode, struct fuse_attr *attr,
 		return;
 	}
 
-	old_mtime = inode->i_mtime;
+	old_mtime = inode_get_mtime(inode);
 	fuse_change_attributes_common(inode, attr, sx, attr_valid, cache_mask);
 
 	oldsize = inode->i_size;
@@ -337,8 +335,7 @@ static void fuse_init_inode(struct inode *inode, struct fuse_attr *attr,
 {
 	inode->i_mode = attr->mode & S_IFMT;
 	inode->i_size = attr->size;
-	inode->i_mtime.tv_sec  = attr->mtime;
-	inode->i_mtime.tv_nsec = attr->mtimensec;
+	inode_set_mtime(inode, attr->mtime, attr->mtimensec);
 	inode_set_ctime(inode, attr->ctime, attr->ctimensec);
 	if (S_ISREG(inode->i_mode)) {
 		fuse_init_common(inode);
@@ -1423,17 +1420,19 @@ EXPORT_SYMBOL_GPL(fuse_dev_free);
 static void fuse_fill_attr_from_inode(struct fuse_attr *attr,
 				      const struct fuse_inode *fi)
 {
+	struct timespec64 atime = inode_get_atime(&fi->inode);
+	struct timespec64 mtime = inode_get_mtime(&fi->inode);
 	struct timespec64 ctime = inode_get_ctime(&fi->inode);
 
 	*attr = (struct fuse_attr){
 		.ino		= fi->inode.i_ino,
 		.size		= fi->inode.i_size,
 		.blocks		= fi->inode.i_blocks,
-		.atime		= fi->inode.i_atime.tv_sec,
-		.mtime		= fi->inode.i_mtime.tv_sec,
+		.atime		= atime.tv_sec,
+		.mtime		= mtime.tv_sec,
 		.ctime		= ctime.tv_sec,
-		.atimensec	= fi->inode.i_atime.tv_nsec,
-		.mtimensec	= fi->inode.i_mtime.tv_nsec,
+		.atimensec	= atime.tv_nsec,
+		.mtimensec	= mtime.tv_nsec,
 		.ctimensec	= ctime.tv_nsec,
 		.mode		= fi->inode.i_mode,
 		.nlink		= fi->inode.i_nlink,
diff --git a/fs/fuse/readdir.c b/fs/fuse/readdir.c
index 9e6d587b3e67..c66a54d6c7d3 100644
--- a/fs/fuse/readdir.c
+++ b/fs/fuse/readdir.c
@@ -476,7 +476,7 @@ static int fuse_readdir_cached(struct file *file, struct dir_context *ctx)
 	if (!fi->rdc.cached) {
 		/* Starting cache? Set cache mtime. */
 		if (!ctx->pos && !fi->rdc.size) {
-			fi->rdc.mtime = inode->i_mtime;
+			fi->rdc.mtime = inode_get_mtime(inode);
 			fi->rdc.iversion = inode_query_iversion(inode);
 		}
 		spin_unlock(&fi->rdc.lock);
@@ -488,8 +488,10 @@ static int fuse_readdir_cached(struct file *file, struct dir_context *ctx)
 	 * changed, and reset the cache if so.
 	 */
 	if (!ctx->pos) {
+		struct timespec64 mtime = inode_get_mtime(inode);
+
 		if (inode_peek_iversion(inode) != fi->rdc.iversion ||
-		    !timespec64_equal(&fi->rdc.mtime, &inode->i_mtime)) {
+		    !timespec64_equal(&fi->rdc.mtime, &mtime)) {
 			fuse_rdc_reset(inode);
 			goto retry_locked;
 		}
-- 
2.41.0

