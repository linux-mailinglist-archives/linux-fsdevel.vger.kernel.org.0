Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06320748D1C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jul 2023 21:06:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233833AbjGETGt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jul 2023 15:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233754AbjGETFw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jul 2023 15:05:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7D542717;
        Wed,  5 Jul 2023 12:04:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B8159616E4;
        Wed,  5 Jul 2023 19:04:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1E3AC433C8;
        Wed,  5 Jul 2023 19:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688583844;
        bh=7AwQTcUroME8/Q2S/DjQYPGa2W9Q4X/zNBG/BMgjzBw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n4yowcdvobJkpXC5motsYtO5fZ7zHbDxk/T11hVCo1GfRv3qPbmOrDWqOjwwwV+O0
         dd2EPQzzfuzT1It+C6Qb52bHmpbA1rVu05HsS0mlWiTm80m9pe+XP7pAQIitGql12j
         +lNBq23AtztpNZXiKJ4YzMtrTKC5+54SbkMaMGDw3UGN+0xMGqD6eZKuCYNxjP88wC
         48N4W9BgQbgfrBV4R4ZEzJUI+RCp2DG8ZIA7R0RYnpF5GzLYNv6CxzRInEfmFPmbSM
         d0qy1bRZp0sskJXCMRP2JTTd1D+C8xCmWBrpLDpG8ofWxMqnE5eNpYh4TFaHs+PwN3
         NpiZwdUCWuRoA==
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 35/92] devpts: convert to ctime accessor functions
Date:   Wed,  5 Jul 2023 15:01:00 -0400
Message-ID: <20230705190309.579783-33-jlayton@kernel.org>
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

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/devpts/inode.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/devpts/inode.c b/fs/devpts/inode.c
index fe3db0eda8e4..5ede89880911 100644
--- a/fs/devpts/inode.c
+++ b/fs/devpts/inode.c
@@ -338,7 +338,7 @@ static int mknod_ptmx(struct super_block *sb)
 	}
 
 	inode->i_ino = 2;
-	inode->i_mtime = inode->i_atime = inode->i_ctime = current_time(inode);
+	inode->i_mtime = inode->i_atime = inode_set_ctime_current(inode);
 
 	mode = S_IFCHR|opts->ptmxmode;
 	init_special_inode(inode, mode, MKDEV(TTYAUX_MAJOR, 2));
@@ -451,7 +451,7 @@ devpts_fill_super(struct super_block *s, void *data, int silent)
 	if (!inode)
 		goto fail;
 	inode->i_ino = 1;
-	inode->i_mtime = inode->i_atime = inode->i_ctime = current_time(inode);
+	inode->i_mtime = inode->i_atime = inode_set_ctime_current(inode);
 	inode->i_mode = S_IFDIR | S_IRUGO | S_IXUGO | S_IWUSR;
 	inode->i_op = &simple_dir_inode_operations;
 	inode->i_fop = &simple_dir_operations;
@@ -560,7 +560,7 @@ struct dentry *devpts_pty_new(struct pts_fs_info *fsi, int index, void *priv)
 	inode->i_ino = index + 3;
 	inode->i_uid = opts->setuid ? opts->uid : current_fsuid();
 	inode->i_gid = opts->setgid ? opts->gid : current_fsgid();
-	inode->i_mtime = inode->i_atime = inode->i_ctime = current_time(inode);
+	inode->i_mtime = inode->i_atime = inode_set_ctime_current(inode);
 	init_special_inode(inode, S_IFCHR|opts->mode, MKDEV(UNIX98_PTY_SLAVE_MAJOR, index));
 
 	sprintf(s, "%d", index);
-- 
2.41.0

