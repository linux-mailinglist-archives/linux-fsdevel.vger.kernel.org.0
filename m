Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF7966D0176
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Mar 2023 12:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbjC3Klx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Mar 2023 06:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjC3Klv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Mar 2023 06:41:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07E6E83FC;
        Thu, 30 Mar 2023 03:41:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8E8A4B82761;
        Thu, 30 Mar 2023 10:41:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA350C433EF;
        Thu, 30 Mar 2023 10:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680172907;
        bh=xbkcH3z5FERTunIMLkCwebfkN7aRmZeu7yuUR3+B4d4=;
        h=From:To:Cc:Subject:Date:From;
        b=n1XIdtVxMHmSTRrgkn/rALXQTyYMIl/jH9+CoGRRp+bZe6wQ7+sqGlLDLca8L67Ou
         UZj0GsUDJw3mRpzIkImt71YEux6mS4XItoC2y0ZfvdtFhAt6/zNnjtTIxsabW7zqBP
         YRSiS0zsV2nbQYostyrOXpx6pwnl5fTOJfyVinA5bCiNOjutnZC1Q0VbvY5O5OPg9d
         73tahkLP4LYXk+bXr4mmk04xBTRTh+YvMhJeCeylUctMxIE2GCgtne1oCQMyyAiT3w
         ItaNvzmAWYj48Aln6964DOTawaeIZtH/X1W7FhnZo2u3DCcl1FpclEXv/cWTwrzqys
         yinIDlNnGt7sw==
From:   Jeff Layton <jlayton@kernel.org>
To:     Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Joel Becker <jlbec@evilplan.org>,
        Christoph Hellwig <hch@lst.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Cc:     v9fs-developer@lists.sourceforge.net,
        Chuck Lever <chuck.lever@oracle.com>,
        Phillip Potter <phil@philpotter.co.uk>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH] fs: consolidate duplicate dt_type helpers
Date:   Thu, 30 Mar 2023 06:41:43 -0400
Message-Id: <20230330104144.75547-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There are three copies of the same dt_type helper sprinkled around the
tree. Convert them to use the common fs_umode_to_dtype function instead,
which has the added advantage of properly returning DT_UNKNOWN when
given a mode that contains an unrecognized type.

Cc: Chuck Lever <chuck.lever@oracle.com>
Cc: Phillip Potter <phil@philpotter.co.uk>
Suggested-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/configfs/dir.c | 9 ++-------
 fs/kernfs/dir.c   | 8 +-------
 fs/libfs.c        | 9 ++-------
 3 files changed, 5 insertions(+), 21 deletions(-)

v2: consolidate S_DT helper as well
v3: switch existing dt_type helpers to use fs_umode_to_dtype
    drop v9fs hunks since they're no longer needed

diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
index 4afcbbe63e68..18677cd4e62f 100644
--- a/fs/configfs/dir.c
+++ b/fs/configfs/dir.c
@@ -1599,12 +1599,6 @@ static int configfs_dir_close(struct inode *inode, struct file *file)
 	return 0;
 }
 
-/* Relationship between s_mode and the DT_xxx types */
-static inline unsigned char dt_type(struct configfs_dirent *sd)
-{
-	return (sd->s_mode >> 12) & 15;
-}
-
 static int configfs_readdir(struct file *file, struct dir_context *ctx)
 {
 	struct dentry *dentry = file->f_path.dentry;
@@ -1654,7 +1648,8 @@ static int configfs_readdir(struct file *file, struct dir_context *ctx)
 		name = configfs_get_name(next);
 		len = strlen(name);
 
-		if (!dir_emit(ctx, name, len, ino, dt_type(next)))
+		if (!dir_emit(ctx, name, len, ino,
+			      fs_umode_to_dtype(next->s_mode)))
 			return 0;
 
 		spin_lock(&configfs_dirent_lock);
diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index ef00b5fe8cee..90de0e498371 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -1748,12 +1748,6 @@ int kernfs_rename_ns(struct kernfs_node *kn, struct kernfs_node *new_parent,
 	return error;
 }
 
-/* Relationship between mode and the DT_xxx types */
-static inline unsigned char dt_type(struct kernfs_node *kn)
-{
-	return (kn->mode >> 12) & 15;
-}
-
 static int kernfs_dir_fop_release(struct inode *inode, struct file *filp)
 {
 	kernfs_put(filp->private_data);
@@ -1831,7 +1825,7 @@ static int kernfs_fop_readdir(struct file *file, struct dir_context *ctx)
 	     pos;
 	     pos = kernfs_dir_next_pos(ns, parent, ctx->pos, pos)) {
 		const char *name = pos->name;
-		unsigned int type = dt_type(pos);
+		unsigned int type = fs_umode_to_dtype(pos->mode);
 		int len = strlen(name);
 		ino_t ino = kernfs_ino(pos);
 
diff --git a/fs/libfs.c b/fs/libfs.c
index 4eda519c3002..89cf614a3271 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -174,12 +174,6 @@ loff_t dcache_dir_lseek(struct file *file, loff_t offset, int whence)
 }
 EXPORT_SYMBOL(dcache_dir_lseek);
 
-/* Relationship between i_mode and the DT_xxx types */
-static inline unsigned char dt_type(struct inode *inode)
-{
-	return (inode->i_mode >> 12) & 15;
-}
-
 /*
  * Directory is locked and all positive dentries in it are safe, since
  * for ramfs-type trees they can't go away without unlink() or rmdir(),
@@ -206,7 +200,8 @@ int dcache_readdir(struct file *file, struct dir_context *ctx)
 
 	while ((next = scan_positives(cursor, p, 1, next)) != NULL) {
 		if (!dir_emit(ctx, next->d_name.name, next->d_name.len,
-			      d_inode(next)->i_ino, dt_type(d_inode(next))))
+			      d_inode(next)->i_ino,
+			      fs_umode_to_dtype(d_inode(next)->i_mode)))
 			break;
 		ctx->pos++;
 		p = &next->d_child;
-- 
2.39.2

