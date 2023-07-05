Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDFD2748CF6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jul 2023 21:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233665AbjGETFT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jul 2023 15:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233563AbjGETE3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jul 2023 15:04:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9E322126;
        Wed,  5 Jul 2023 12:03:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7ADA4616F4;
        Wed,  5 Jul 2023 19:03:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51CF8C433C8;
        Wed,  5 Jul 2023 19:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688583822;
        bh=wSyYyxAOPkc4UMvoUTNmso9bOR6OW/Z0q8azn3XnLKk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o8AAPs+uOhNW5p5ZVDmLjOlmDWrSdbUEMj85BxAkCXEad3noFFCw+u2lAfB8+67xl
         EHH0Q7KmOJl5GFehxiCi9O/GivjvhQkrHYAKk1pc9+a8xeIJQGNFNL4ZKxdKCJdgW2
         wtdkcqQ9bPP74wogVJiwPcLAcwMhoSwW7nZt0ydyE+ozUdZQEg0fsiQp/lbc7RvwV9
         9GsRbywg0U0kF+WHw6AsFkEzPXDkYbDVFa0aiW05UINetBxnpPMEuGCSnuZqxtk0mg
         NHK4vqSjEnaKyqAZP1EYwlnJCnNxR1HVLQ8dgwldJ0ARxQyXNelaFKkBjZK3T2pnST
         WOKMcLaTKRpEQ==
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>,
        David Sterba <dsterba@suse.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 23/92] affs: convert to ctime accessor functions
Date:   Wed,  5 Jul 2023 15:00:48 -0400
Message-ID: <20230705190309.579783-21-jlayton@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230705190309.579783-1-jlayton@kernel.org>
References: <20230705185755.579053-1-jlayton@kernel.org>
 <20230705190309.579783-1-jlayton@kernel.org>
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

In later patches, we're going to change how the inode's ctime field is
used. Switch to using accessor functions instead of raw accesses of
inode->i_ctime.

Acked-by: David Sterba <dsterba@suse.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/affs/amigaffs.c |  6 +++---
 fs/affs/inode.c    | 16 ++++++++--------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/fs/affs/amigaffs.c b/fs/affs/amigaffs.c
index 29f11e10a7c7..7ba93efc1143 100644
--- a/fs/affs/amigaffs.c
+++ b/fs/affs/amigaffs.c
@@ -60,7 +60,7 @@ affs_insert_hash(struct inode *dir, struct buffer_head *bh)
 	mark_buffer_dirty_inode(dir_bh, dir);
 	affs_brelse(dir_bh);
 
-	dir->i_mtime = dir->i_ctime = current_time(dir);
+	dir->i_mtime = inode_set_ctime_current(dir);
 	inode_inc_iversion(dir);
 	mark_inode_dirty(dir);
 
@@ -114,7 +114,7 @@ affs_remove_hash(struct inode *dir, struct buffer_head *rem_bh)
 
 	affs_brelse(bh);
 
-	dir->i_mtime = dir->i_ctime = current_time(dir);
+	dir->i_mtime = inode_set_ctime_current(dir);
 	inode_inc_iversion(dir);
 	mark_inode_dirty(dir);
 
@@ -315,7 +315,7 @@ affs_remove_header(struct dentry *dentry)
 	else
 		clear_nlink(inode);
 	affs_unlock_link(inode);
-	inode->i_ctime = current_time(inode);
+	inode_set_ctime_current(inode);
 	mark_inode_dirty(inode);
 
 done:
diff --git a/fs/affs/inode.c b/fs/affs/inode.c
index 27f77a52c5c8..060746c63151 100644
--- a/fs/affs/inode.c
+++ b/fs/affs/inode.c
@@ -149,13 +149,13 @@ struct inode *affs_iget(struct super_block *sb, unsigned long ino)
 		break;
 	}
 
-	inode->i_mtime.tv_sec = inode->i_atime.tv_sec = inode->i_ctime.tv_sec
-		       = (be32_to_cpu(tail->change.days) * 86400LL +
-		         be32_to_cpu(tail->change.mins) * 60 +
-			 be32_to_cpu(tail->change.ticks) / 50 +
-			 AFFS_EPOCH_DELTA) +
-			 sys_tz.tz_minuteswest * 60;
-	inode->i_mtime.tv_nsec = inode->i_ctime.tv_nsec = inode->i_atime.tv_nsec = 0;
+	inode->i_mtime.tv_sec = inode->i_atime.tv_sec =
+		inode_set_ctime(inode,
+				(be32_to_cpu(tail->change.days) * 86400LL +
+				 be32_to_cpu(tail->change.mins) * 60 +
+				 be32_to_cpu(tail->change.ticks) / 50 + AFFS_EPOCH_DELTA)
+				+ sys_tz.tz_minuteswest * 60, 0).tv_sec;
+	inode->i_mtime.tv_nsec = inode->i_atime.tv_nsec = 0;
 	affs_brelse(bh);
 	unlock_new_inode(inode);
 	return inode;
@@ -314,7 +314,7 @@ affs_new_inode(struct inode *dir)
 	inode->i_gid     = current_fsgid();
 	inode->i_ino     = block;
 	set_nlink(inode, 1);
-	inode->i_mtime   = inode->i_atime = inode->i_ctime = current_time(inode);
+	inode->i_mtime   = inode->i_atime = inode_set_ctime_current(inode);
 	atomic_set(&AFFS_I(inode)->i_opencnt, 0);
 	AFFS_I(inode)->i_blkcnt = 0;
 	AFFS_I(inode)->i_lc = NULL;
-- 
2.41.0

