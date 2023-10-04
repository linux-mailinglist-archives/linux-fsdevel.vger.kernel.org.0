Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78E2C7B8BC6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Oct 2023 20:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244978AbjJDSzf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Oct 2023 14:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244859AbjJDSy5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Oct 2023 14:54:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F98210F5;
        Wed,  4 Oct 2023 11:54:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C4ECC433CB;
        Wed,  4 Oct 2023 18:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696445672;
        bh=mIt3xm5fBtB7C7o3BbmHBu2+jSh68YUaxybdY+RBNwY=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=ababVVuAbuOD6AO5ssN4gmtB7Avu/tbCZyAkXwH0mfhhFmPYlpcLe3zqnXompBmle
         CXcRsiew5TNt+LGI2SUhbj4SKXijN5mZtMtKPeE/gSD/ZqfTAOnKVuwp5xdTWhi6mQ
         OrooJsatvOv6KGjnrGI81YS6GUGRlyjbdymB36M+6uzy6ZJJHS4QKopBcho3ncUuZT
         a2FJPJ/YGRYeXqSfhafpAywEWASpk1J5on036lqXFsTpzlrq3hY8m3n2PvDZeL8CvU
         0PtBdNZiEYW/ytu/R5mRlpxy30mzb5UrChGPKLryYjvHIIgXUTOjdRw6/VoQrE5E4Q
         ZB7WVcJuKe5Bg==
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 39/89] fuse: convert to new timestamp accessors
Date:   Wed,  4 Oct 2023 14:52:24 -0400
Message-ID: <20231004185347.80880-37-jlayton@kernel.org>
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
 fs/fuse/control.c |  2 +-
 fs/fuse/dir.c     | 10 +++++-----
 fs/fuse/inode.c   | 29 ++++++++++++++---------------
 fs/fuse/readdir.c |  6 ++++--
 4 files changed, 24 insertions(+), 23 deletions(-)

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
index d707e6987da9..d19cbf34c634 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1812,12 +1812,12 @@ int fuse_flush_times(struct inode *inode, struct fuse_file *ff)
 	memset(&outarg, 0, sizeof(outarg));
 
 	inarg.valid = FATTR_MTIME;
-	inarg.mtime = inode->i_mtime.tv_sec;
-	inarg.mtimensec = inode->i_mtime.tv_nsec;
+	inarg.mtime = inode_get_mtime_sec(inode);
+	inarg.mtimensec = inode_get_mtime_nsec(inode);
 	if (fm->fc->minor >= 23) {
 		inarg.valid |= FATTR_CTIME;
-		inarg.ctime = inode_get_ctime(inode).tv_sec;
-		inarg.ctimensec = inode_get_ctime(inode).tv_nsec;
+		inarg.ctime = inode_get_ctime_sec(inode);
+		inarg.ctimensec = inode_get_ctime_nsec(inode);
 	}
 	if (ff) {
 		inarg.valid |= FATTR_FH;
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
index 444418e240c8..f78fbf33f8a0 100644
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
@@ -276,12 +274,12 @@ void fuse_change_attributes(struct inode *inode, struct fuse_attr *attr,
 		attr->size = i_size_read(inode);
 
 	if (cache_mask & STATX_MTIME) {
-		attr->mtime = inode->i_mtime.tv_sec;
-		attr->mtimensec = inode->i_mtime.tv_nsec;
+		attr->mtime = inode_get_mtime_sec(inode);
+		attr->mtimensec = inode_get_mtime_nsec(inode);
 	}
 	if (cache_mask & STATX_CTIME) {
-		attr->ctime = inode_get_ctime(inode).tv_sec;
-		attr->ctimensec = inode_get_ctime(inode).tv_nsec;
+		attr->ctime = inode_get_ctime_sec(inode);
+		attr->ctimensec = inode_get_ctime_nsec(inode);
 	}
 
 	if ((attr_version != 0 && fi->attr_version > attr_version) ||
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

