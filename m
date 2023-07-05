Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C732B748D22
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jul 2023 21:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233687AbjGETHS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jul 2023 15:07:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233375AbjGETGR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jul 2023 15:06:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0653273C;
        Wed,  5 Jul 2023 12:04:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CED1161701;
        Wed,  5 Jul 2023 19:04:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2D94C433C9;
        Wed,  5 Jul 2023 19:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688583862;
        bh=EE1pMrQ7eUtaCqd78aDEt+l5fcwyOfnOdSwd15ijX/A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gyAtYMycE2dNDYESwnLkyjwZ2jj7Wj2l2RbcnD8pGImfzoiHw4JLq17FhFfjhZ5rn
         u90N7i5SUOWEwsJpAps+KyFTPl+odwR5AisrTwBzk5DbwenAUVE0S+rDNwHcOVKNxz
         IpGRBrsFDqXdyP0EKogBhkafqbVs25wCr3f8fMyoAbHHB+9DedwZw10Tx+h8X2csQB
         OJoWI8Bd4LkN2W0nQO19G7pk8AHZxarXXs7P9yz5kI4QZ1HFYCxBwEyauVzd2t8nK+
         6fyvuk/SLiIsHo/n9uI5xYuef4rusM8rEzCo+Wpw+b3J6L9mqtZxl7OWv58wMAF5t3
         FKY7zkSWSWt6Q==
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 44/92] fat: convert to ctime accessor functions
Date:   Wed,  5 Jul 2023 15:01:09 -0400
Message-ID: <20230705190309.579783-42-jlayton@kernel.org>
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

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/fat/inode.c | 7 ++++---
 fs/fat/misc.c  | 3 ++-
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/fat/inode.c b/fs/fat/inode.c
index d99b8549ec8f..2be40ff8a74f 100644
--- a/fs/fat/inode.c
+++ b/fs/fat/inode.c
@@ -562,7 +562,7 @@ int fat_fill_inode(struct inode *inode, struct msdos_dir_entry *de)
 			   & ~((loff_t)sbi->cluster_size - 1)) >> 9;
 
 	fat_time_fat2unix(sbi, &inode->i_mtime, de->time, de->date, 0);
-	inode->i_ctime = inode->i_mtime;
+	inode_set_ctime_to_ts(inode, inode->i_mtime);
 	if (sbi->options.isvfat) {
 		fat_time_fat2unix(sbi, &inode->i_atime, 0, de->adate, 0);
 		fat_time_fat2unix(sbi, &MSDOS_I(inode)->i_crtime, de->ctime,
@@ -1407,8 +1407,9 @@ static int fat_read_root(struct inode *inode)
 	MSDOS_I(inode)->mmu_private = inode->i_size;
 
 	fat_save_attrs(inode, ATTR_DIR);
-	inode->i_mtime.tv_sec = inode->i_atime.tv_sec = inode->i_ctime.tv_sec = 0;
-	inode->i_mtime.tv_nsec = inode->i_atime.tv_nsec = inode->i_ctime.tv_nsec = 0;
+	inode->i_mtime.tv_sec = inode->i_atime.tv_sec = inode_set_ctime(inode,
+									0, 0).tv_sec;
+	inode->i_mtime.tv_nsec = inode->i_atime.tv_nsec = 0;
 	set_nlink(inode, fat_subdirs(inode)+2);
 
 	return 0;
diff --git a/fs/fat/misc.c b/fs/fat/misc.c
index 7e5d6ae305f2..67006ea08db6 100644
--- a/fs/fat/misc.c
+++ b/fs/fat/misc.c
@@ -332,7 +332,8 @@ int fat_truncate_time(struct inode *inode, struct timespec64 *now, int flags)
 	 * but ctime updates are ignored.
 	 */
 	if (flags & S_MTIME)
-		inode->i_mtime = inode->i_ctime = fat_truncate_mtime(sbi, now);
+		inode->i_mtime = inode_set_ctime_to_ts(inode,
+						       fat_truncate_mtime(sbi, now));
 
 	return 0;
 }
-- 
2.41.0

