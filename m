Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E3597387CC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jun 2023 16:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232405AbjFUOut (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jun 2023 10:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232631AbjFUOt7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jun 2023 10:49:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DDB41FE3;
        Wed, 21 Jun 2023 07:48:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6D9BD6157D;
        Wed, 21 Jun 2023 14:48:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 442ADC433C8;
        Wed, 21 Jun 2023 14:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687358911;
        bh=GO2Zpq+zEeHviRURrvBxPy0RDxVvHVMo8mIPU4EFgtg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U6V2naQbXigFIXeLsdIg+qFhnexPblANO1n1Qw09zr3ud+7tpbSov9FnBQ9mYnTXL
         lifWCy/aZRl1cp/LyGpUoFCLjh1TomzKwS5OCA1W2o9dyQ1zQdyi4sGCbpizOrepbZ
         jLsLII0Xj4zuH4jAQH3fA4URf0EgEhhpQAMTT2RoUxGxKS1nvmK6OV6bq/wmzkCi7n
         JOAX+Be7lojDWJKrukgrXTyHjQKzoHthsktNuaRdaVkoCnv0Qt2XZOrfayEkiO3l3L
         ea0TR+VWFKqktvcTnqkvok+YzvhlMBWzt8ntkhnNAWMTgawREke+taAklU3pBjGVvL
         C8qikFw+exckw==
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 33/79] fuse: switch to new ctime accessors
Date:   Wed, 21 Jun 2023 10:45:46 -0400
Message-ID: <20230621144735.55953-32-jlayton@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230621144735.55953-1-jlayton@kernel.org>
References: <20230621144507.55591-1-jlayton@kernel.org>
 <20230621144735.55953-1-jlayton@kernel.org>
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

In later patches, we're going to change how the ctime.tv_nsec field is
utilized. Switch to using accessor functions instead of raw accesses of
inode->i_ctime.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/fuse/control.c |  2 +-
 fs/fuse/dir.c     |  8 ++++----
 fs/fuse/inode.c   | 18 ++++++++++--------
 3 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/fs/fuse/control.c b/fs/fuse/control.c
index 247ef4f76761..b5df89d0c95a 100644
--- a/fs/fuse/control.c
+++ b/fs/fuse/control.c
@@ -235,7 +235,7 @@ static struct dentry *fuse_ctl_add_dentry(struct dentry *parent,
 	inode->i_mode = mode;
 	inode->i_uid = fc->user_id;
 	inode->i_gid = fc->group_id;
-	inode->i_atime = inode->i_mtime = inode->i_ctime = current_time(inode);
+	inode->i_atime = inode->i_mtime = inode_ctime_set_current(inode);
 	/* setting ->i_op to NULL is not allowed */
 	if (iop)
 		inode->i_op = iop;
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 5a4a7155cf1c..03fbb83b7127 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -933,7 +933,7 @@ void fuse_flush_time_update(struct inode *inode)
 static void fuse_update_ctime_in_cache(struct inode *inode)
 {
 	if (!IS_NOCMTIME(inode)) {
-		inode->i_ctime = current_time(inode);
+		inode_ctime_set_current(inode);
 		mark_inode_dirty_sync(inode);
 		fuse_flush_time_update(inode);
 	}
@@ -1715,8 +1715,8 @@ int fuse_flush_times(struct inode *inode, struct fuse_file *ff)
 	inarg.mtimensec = inode->i_mtime.tv_nsec;
 	if (fm->fc->minor >= 23) {
 		inarg.valid |= FATTR_CTIME;
-		inarg.ctime = inode->i_ctime.tv_sec;
-		inarg.ctimensec = inode->i_ctime.tv_nsec;
+		inarg.ctime = inode_ctime_peek(inode).tv_sec;
+		inarg.ctimensec = inode_ctime_peek(inode).tv_nsec;
 	}
 	if (ff) {
 		inarg.valid |= FATTR_FH;
@@ -1857,7 +1857,7 @@ int fuse_do_setattr(struct dentry *dentry, struct iattr *attr,
 		if (attr->ia_valid & ATTR_MTIME)
 			inode->i_mtime = attr->ia_mtime;
 		if (attr->ia_valid & ATTR_CTIME)
-			inode->i_ctime = attr->ia_ctime;
+			inode_ctime_set(inode, attr->ia_ctime);
 		/* FIXME: clear I_DIRTY_SYNC? */
 	}
 
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 660be31aaabc..54e06d3874e7 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -194,8 +194,8 @@ void fuse_change_attributes_common(struct inode *inode, struct fuse_attr *attr,
 		inode->i_mtime.tv_nsec  = attr->mtimensec;
 	}
 	if (!(cache_mask & STATX_CTIME)) {
-		inode->i_ctime.tv_sec   = attr->ctime;
-		inode->i_ctime.tv_nsec  = attr->ctimensec;
+		inode_ctime_set_sec(inode, attr->ctime);
+		inode_ctime_set_nsec(inode, attr->ctimensec);
 	}
 
 	if (attr->blksize != 0)
@@ -259,8 +259,8 @@ void fuse_change_attributes(struct inode *inode, struct fuse_attr *attr,
 		attr->mtimensec = inode->i_mtime.tv_nsec;
 	}
 	if (cache_mask & STATX_CTIME) {
-		attr->ctime = inode->i_ctime.tv_sec;
-		attr->ctimensec = inode->i_ctime.tv_nsec;
+		attr->ctime = inode_ctime_peek(inode).tv_sec;
+		attr->ctimensec = inode_ctime_peek(inode).tv_nsec;
 	}
 
 	if ((attr_version != 0 && fi->attr_version > attr_version) ||
@@ -318,8 +318,8 @@ static void fuse_init_inode(struct inode *inode, struct fuse_attr *attr,
 	inode->i_size = attr->size;
 	inode->i_mtime.tv_sec  = attr->mtime;
 	inode->i_mtime.tv_nsec = attr->mtimensec;
-	inode->i_ctime.tv_sec  = attr->ctime;
-	inode->i_ctime.tv_nsec = attr->ctimensec;
+	inode_ctime_set_sec(inode, attr->ctime);
+	inode_ctime_set_nsec(inode, attr->ctimensec);
 	if (S_ISREG(inode->i_mode)) {
 		fuse_init_common(inode);
 		fuse_init_file_inode(inode, attr->flags);
@@ -1398,16 +1398,18 @@ EXPORT_SYMBOL_GPL(fuse_dev_free);
 static void fuse_fill_attr_from_inode(struct fuse_attr *attr,
 				      const struct fuse_inode *fi)
 {
+	struct timespec64 ctime = inode_ctime_peek(&fi->inode);
+
 	*attr = (struct fuse_attr){
 		.ino		= fi->inode.i_ino,
 		.size		= fi->inode.i_size,
 		.blocks		= fi->inode.i_blocks,
 		.atime		= fi->inode.i_atime.tv_sec,
 		.mtime		= fi->inode.i_mtime.tv_sec,
-		.ctime		= fi->inode.i_ctime.tv_sec,
+		.ctime		= ctime.tv_sec,
 		.atimensec	= fi->inode.i_atime.tv_nsec,
 		.mtimensec	= fi->inode.i_mtime.tv_nsec,
-		.ctimensec	= fi->inode.i_ctime.tv_nsec,
+		.ctimensec	= ctime.tv_nsec,
 		.mode		= fi->inode.i_mode,
 		.nlink		= fi->inode.i_nlink,
 		.uid		= fi->inode.i_uid.val,
-- 
2.41.0

