Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80FE97B8B92
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Oct 2023 20:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244654AbjJDSyu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Oct 2023 14:54:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244643AbjJDSyh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Oct 2023 14:54:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48380F0;
        Wed,  4 Oct 2023 11:54:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5224C433CD;
        Wed,  4 Oct 2023 18:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696445644;
        bh=lkQRDWuiKfo61lxiPSSdPh1VV4GeCOeWNFYSDC9osaQ=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=EoRc2VFXlKLQGXRZD+Vd/0/PU5CU5y3IK6WGe0dX5u4REbeSleQ0CPdB889hIX76Y
         kj1y+UCbEOmeA5+KpTf3BcUCHz62hGo5MyONxCwGdrpoU5g7UULnNao/X+OfryAisM
         Xjj3TaZIZvJ+xkSvZO7NjgQ9cvzHuUA6jM/LsL2/UXUtSeAZcYtkQgPB89ECg20WvB
         ZVOMaBm2tAZ9KnUgZoIaPaWA+Pc2LmPFCun3oE3JceALTGHu3CRcNwKqzNF6CvOCsM
         OAj86LIOFrI5iQltOklnTXCjJTyx8yWBZL+3+jDZn4RCQNh1lEHGBBfR+NNSCAF7RZ
         b7PTk90PaEOkg==
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 16/89] adfs: convert to new timestamp accessors
Date:   Wed,  4 Oct 2023 14:52:01 -0400
Message-ID: <20231004185347.80880-14-jlayton@kernel.org>
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
 fs/adfs/inode.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/fs/adfs/inode.c b/fs/adfs/inode.c
index 20963002578a..3081edb09e46 100644
--- a/fs/adfs/inode.c
+++ b/fs/adfs/inode.c
@@ -242,6 +242,7 @@ struct inode *
 adfs_iget(struct super_block *sb, struct object_info *obj)
 {
 	struct inode *inode;
+	struct timespec64 ts;
 
 	inode = new_inode(sb);
 	if (!inode)
@@ -268,9 +269,10 @@ adfs_iget(struct super_block *sb, struct object_info *obj)
 	ADFS_I(inode)->attr      = obj->attr;
 
 	inode->i_mode	 = adfs_atts2mode(sb, inode);
-	adfs_adfs2unix_time(&inode->i_mtime, inode);
-	inode->i_atime = inode->i_mtime;
-	inode_set_ctime_to_ts(inode, inode->i_mtime);
+	adfs_adfs2unix_time(&ts, inode);
+	inode_set_atime_to_ts(inode, ts);
+	inode_set_mtime_to_ts(inode, ts);
+	inode_set_ctime_to_ts(inode, ts);
 
 	if (S_ISDIR(inode->i_mode)) {
 		inode->i_op	= &adfs_dir_inode_operations;
@@ -321,7 +323,8 @@ adfs_notify_change(struct mnt_idmap *idmap, struct dentry *dentry,
 
 	if (ia_valid & ATTR_MTIME && adfs_inode_is_stamped(inode)) {
 		adfs_unix2adfs_time(inode, &attr->ia_mtime);
-		adfs_adfs2unix_time(&inode->i_mtime, inode);
+		adfs_adfs2unix_time(&attr->ia_mtime, inode);
+		inode_set_mtime_to_ts(inode, attr->ia_mtime);
 	}
 
 	/*
@@ -329,7 +332,7 @@ adfs_notify_change(struct mnt_idmap *idmap, struct dentry *dentry,
 	 * have the ability to represent them in our filesystem?
 	 */
 	if (ia_valid & ATTR_ATIME)
-		inode->i_atime = attr->ia_atime;
+		inode_set_atime_to_ts(inode, attr->ia_atime);
 	if (ia_valid & ATTR_CTIME)
 		inode_set_ctime_to_ts(inode, attr->ia_ctime);
 	if (ia_valid & ATTR_MODE) {
-- 
2.41.0

