Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDDF77387A7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jun 2023 16:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232237AbjFUOsc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jun 2023 10:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232165AbjFUOsE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jun 2023 10:48:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDF6C19B5;
        Wed, 21 Jun 2023 07:47:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 555B06158B;
        Wed, 21 Jun 2023 14:47:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2393CC433C8;
        Wed, 21 Jun 2023 14:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687358870;
        bh=zjL6z/vnFxpxtgI4/XfP4lAW/58HKOouZybNdXVfuiE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kAPwnqrXpALw4aQmCmtwf9RniMMfRQxvQCvKKS4/9gtuDGXdXkogQeHgWodP2vogM
         4xAX04jXo3HyFoUsvtgGU/lLzBuLA1NTOdB5Pz8R87fD1W2j/Am5/BxUMtwLSKs46A
         FFc4mJT08xYVd6Jr/bcC6uvSIy47aIP6Sj+anu+xYMLsoB8hv8Y8Pm8RctfCWzEGAt
         EYJ79yUzOVuh4j8y81TMAQsw1ii9ZybTQWp2+ldfotRgKwY5kUNy+vc03nkZsbUGKx
         a3Jj7TiPX+fY8z8cJD325QvH4YsufnzZnLqVPdmtzb05n4p7878NOXrTNZGRdhyE3z
         /oKX1lera6w5Q==
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>,
        David Sterba <dsterba@suse.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 10/79] affs: switch to new ctime accessors
Date:   Wed, 21 Jun 2023 10:45:23 -0400
Message-ID: <20230621144735.55953-9-jlayton@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230621144735.55953-1-jlayton@kernel.org>
References: <20230621144507.55591-1-jlayton@kernel.org>
 <20230621144735.55953-1-jlayton@kernel.org>
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

In later patches, we're going to change how the ctime.tv_nsec field is
utilized. Switch to using accessor functions instead of raw accesses of
inode->i_ctime.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/affs/amigaffs.c |  6 +++---
 fs/affs/inode.c    | 17 +++++++++--------
 2 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/fs/affs/amigaffs.c b/fs/affs/amigaffs.c
index 29f11e10a7c7..2b508aa6707e 100644
--- a/fs/affs/amigaffs.c
+++ b/fs/affs/amigaffs.c
@@ -60,7 +60,7 @@ affs_insert_hash(struct inode *dir, struct buffer_head *bh)
 	mark_buffer_dirty_inode(dir_bh, dir);
 	affs_brelse(dir_bh);
 
-	dir->i_mtime = dir->i_ctime = current_time(dir);
+	dir->i_mtime = inode_ctime_set_current(dir);
 	inode_inc_iversion(dir);
 	mark_inode_dirty(dir);
 
@@ -114,7 +114,7 @@ affs_remove_hash(struct inode *dir, struct buffer_head *rem_bh)
 
 	affs_brelse(bh);
 
-	dir->i_mtime = dir->i_ctime = current_time(dir);
+	dir->i_mtime = inode_ctime_set_current(dir);
 	inode_inc_iversion(dir);
 	mark_inode_dirty(dir);
 
@@ -315,7 +315,7 @@ affs_remove_header(struct dentry *dentry)
 	else
 		clear_nlink(inode);
 	affs_unlock_link(inode);
-	inode->i_ctime = current_time(inode);
+	inode_ctime_set_current(inode);
 	mark_inode_dirty(inode);
 
 done:
diff --git a/fs/affs/inode.c b/fs/affs/inode.c
index 27f77a52c5c8..177bac4def5e 100644
--- a/fs/affs/inode.c
+++ b/fs/affs/inode.c
@@ -19,6 +19,7 @@ struct inode *affs_iget(struct super_block *sb, unsigned long ino)
 {
 	struct affs_sb_info	*sbi = AFFS_SB(sb);
 	struct buffer_head	*bh;
+	struct timespec64	ctime;
 	struct affs_tail	*tail;
 	struct inode		*inode;
 	u32			 block;
@@ -149,13 +150,13 @@ struct inode *affs_iget(struct super_block *sb, unsigned long ino)
 		break;
 	}
 
-	inode->i_mtime.tv_sec = inode->i_atime.tv_sec = inode->i_ctime.tv_sec
-		       = (be32_to_cpu(tail->change.days) * 86400LL +
-		         be32_to_cpu(tail->change.mins) * 60 +
-			 be32_to_cpu(tail->change.ticks) / 50 +
-			 AFFS_EPOCH_DELTA) +
-			 sys_tz.tz_minuteswest * 60;
-	inode->i_mtime.tv_nsec = inode->i_ctime.tv_nsec = inode->i_atime.tv_nsec = 0;
+	ctime.tv_sec = (be32_to_cpu(tail->change.days) * 86400LL +
+		        be32_to_cpu(tail->change.mins) * 60 +
+			be32_to_cpu(tail->change.ticks) / 50 +
+			AFFS_EPOCH_DELTA) +
+			sys_tz.tz_minuteswest * 60;
+	ctime.tv_nsec = 0;
+	inode->i_atime = inode->i_mtime = inode_ctime_set(inode, ctime);
 	affs_brelse(bh);
 	unlock_new_inode(inode);
 	return inode;
@@ -314,7 +315,7 @@ affs_new_inode(struct inode *dir)
 	inode->i_gid     = current_fsgid();
 	inode->i_ino     = block;
 	set_nlink(inode, 1);
-	inode->i_mtime   = inode->i_atime = inode->i_ctime = current_time(inode);
+	inode->i_mtime   = inode->i_atime = inode_ctime_set_current(inode);
 	atomic_set(&AFFS_I(inode)->i_opencnt, 0);
 	AFFS_I(inode)->i_blkcnt = 0;
 	AFFS_I(inode)->i_lc = NULL;
-- 
2.41.0

