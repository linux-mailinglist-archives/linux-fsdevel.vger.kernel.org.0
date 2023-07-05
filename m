Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B86B748D60
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jul 2023 21:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234055AbjGETJ4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jul 2023 15:09:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234238AbjGETIj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jul 2023 15:08:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A28E3A9A;
        Wed,  5 Jul 2023 12:05:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 328E1616E4;
        Wed,  5 Jul 2023 19:05:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4BEFC433C9;
        Wed,  5 Jul 2023 19:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688583899;
        bh=JAvhSQ39mq266aIrwqMbso8j9j8kS0A2nuJOE+YNoPw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iGyVesnYPolO+I26oFXGQS0HFfyLSnyKHr0IztOkcR37+k04gEYGhfLV5iXWbRzUb
         EObq2VlxILLQJwNu6v40Vw44mKIR/hEv7r12FxATyp+fCsjMdDpE0sJFCVA4/Uc8jR
         pN57YUcYfoRHHDZhRKvJLBjhf0JfE3TzTVXVb4mkufQmeoj4i9Oc3f7BwJrVnxwcbY
         PK6IV5XHVTCd/DXK6HdeyC4G7JL6Q7TCWgCtpA3Snu0BM4ejCHtnfKglypX1Fq6CNy
         54j3+ODltMqFWVJ/dby/A8lzOQWxNhnRprW4AI4HYD/2TaeQq3/oK5h+aXHpt0gCmT
         3N3286UmPeCAg==
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>,
        Bob Copeland <me@bobcopeland.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-karma-devel@lists.sourceforge.net
Subject: [PATCH v2 63/92] omfs: convert to ctime accessor functions
Date:   Wed,  5 Jul 2023 15:01:28 -0400
Message-ID: <20230705190309.579783-61-jlayton@kernel.org>
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

Acked-by: Bob Copeland <me@bobcopeland.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/omfs/dir.c   | 4 ++--
 fs/omfs/inode.c | 9 ++++-----
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/fs/omfs/dir.c b/fs/omfs/dir.c
index 82cf7e9a665f..6bda275826d6 100644
--- a/fs/omfs/dir.c
+++ b/fs/omfs/dir.c
@@ -143,7 +143,7 @@ static int omfs_add_link(struct dentry *dentry, struct inode *inode)
 	mark_buffer_dirty(bh);
 	brelse(bh);
 
-	dir->i_ctime = current_time(dir);
+	inode_set_ctime_current(dir);
 
 	/* mark affected inodes dirty to rebuild checksums */
 	mark_inode_dirty(dir);
@@ -399,7 +399,7 @@ static int omfs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 	if (err)
 		goto out;
 
-	old_inode->i_ctime = current_time(old_inode);
+	inode_set_ctime_current(old_inode);
 	mark_inode_dirty(old_inode);
 out:
 	return err;
diff --git a/fs/omfs/inode.c b/fs/omfs/inode.c
index c4c79e07efc7..2f8c1882f45c 100644
--- a/fs/omfs/inode.c
+++ b/fs/omfs/inode.c
@@ -51,7 +51,7 @@ struct inode *omfs_new_inode(struct inode *dir, umode_t mode)
 	inode_init_owner(&nop_mnt_idmap, inode, NULL, mode);
 	inode->i_mapping->a_ops = &omfs_aops;
 
-	inode->i_atime = inode->i_mtime = inode->i_ctime = current_time(inode);
+	inode->i_atime = inode->i_mtime = inode_set_ctime_current(inode);
 	switch (mode & S_IFMT) {
 	case S_IFDIR:
 		inode->i_op = &omfs_dir_inops;
@@ -134,8 +134,8 @@ static int __omfs_write_inode(struct inode *inode, int wait)
 	oi->i_head.h_magic = OMFS_IMAGIC;
 	oi->i_size = cpu_to_be64(inode->i_size);
 
-	ctime = inode->i_ctime.tv_sec * 1000LL +
-		((inode->i_ctime.tv_nsec + 999)/1000);
+	ctime = inode_get_ctime(inode).tv_sec * 1000LL +
+		((inode_get_ctime(inode).tv_nsec + 999)/1000);
 	oi->i_ctime = cpu_to_be64(ctime);
 
 	omfs_update_checksums(oi);
@@ -232,10 +232,9 @@ struct inode *omfs_iget(struct super_block *sb, ino_t ino)
 
 	inode->i_atime.tv_sec = ctime;
 	inode->i_mtime.tv_sec = ctime;
-	inode->i_ctime.tv_sec = ctime;
+	inode_set_ctime(inode, ctime, nsecs);
 	inode->i_atime.tv_nsec = nsecs;
 	inode->i_mtime.tv_nsec = nsecs;
-	inode->i_ctime.tv_nsec = nsecs;
 
 	inode->i_mapping->a_ops = &omfs_aops;
 
-- 
2.41.0

