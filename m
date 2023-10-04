Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 937357B8BEA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Oct 2023 20:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244929AbjJDSzS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Oct 2023 14:55:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244792AbjJDSyp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Oct 2023 14:54:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E9961BEB;
        Wed,  4 Oct 2023 11:54:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3E3DC433C8;
        Wed,  4 Oct 2023 18:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696445659;
        bh=/XcvuMaQVt7b8rn6Ny+0hmNYyYpeJbw5vaphsCvLG8U=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=LPs5Jbn4EOPxDrbp0SNjKvpqQsZ5PFGs4lKBNa9P6plZ09G3Gqexa1ItjwwxZQKel
         Ncp/CqTEZUqC1CVQMdpb5OD8q5u7rYJtn73MvEQLNNPIpBHIIqYmSgDAGOehKtG2aX
         D3wGq0P+TkBjCkRTD/f5i87zHfas8n0VW0oGN0o6MBs5xeeRa8tJ8DPMaJfQr2gbYs
         0aZwnnDDey/pUSa7+3XK4gbsQ1gwqyzLzRAH1YwmnAtM3Cuu3XHUCiguEaELNbM9WK
         1Yuk7LKHlEhRXt9sgJKIQVtQAdvXDNBMmYHJUoZAQ/0jvhIOo/gEJaHooEhl9f4M2e
         Y4D+ZguTsqMOg==
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 29/89] devpts: convert to new timestamp accessors
Date:   Wed,  4 Oct 2023 14:52:14 -0400
Message-ID: <20231004185347.80880-27-jlayton@kernel.org>
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
 fs/devpts/inode.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/devpts/inode.c b/fs/devpts/inode.c
index 299c295a27a0..c830261aa883 100644
--- a/fs/devpts/inode.c
+++ b/fs/devpts/inode.c
@@ -338,7 +338,7 @@ static int mknod_ptmx(struct super_block *sb)
 	}
 
 	inode->i_ino = 2;
-	inode->i_mtime = inode->i_atime = inode_set_ctime_current(inode);
+	simple_inode_init_ts(inode);
 
 	mode = S_IFCHR|opts->ptmxmode;
 	init_special_inode(inode, mode, MKDEV(TTYAUX_MAJOR, 2));
@@ -451,7 +451,7 @@ devpts_fill_super(struct super_block *s, void *data, int silent)
 	if (!inode)
 		goto fail;
 	inode->i_ino = 1;
-	inode->i_mtime = inode->i_atime = inode_set_ctime_current(inode);
+	simple_inode_init_ts(inode);
 	inode->i_mode = S_IFDIR | S_IRUGO | S_IXUGO | S_IWUSR;
 	inode->i_op = &simple_dir_inode_operations;
 	inode->i_fop = &simple_dir_operations;
@@ -560,7 +560,7 @@ struct dentry *devpts_pty_new(struct pts_fs_info *fsi, int index, void *priv)
 	inode->i_ino = index + 3;
 	inode->i_uid = opts->setuid ? opts->uid : current_fsuid();
 	inode->i_gid = opts->setgid ? opts->gid : current_fsgid();
-	inode->i_mtime = inode->i_atime = inode_set_ctime_current(inode);
+	simple_inode_init_ts(inode);
 	init_special_inode(inode, S_IFCHR|opts->mode, MKDEV(UNIX98_PTY_SLAVE_MAJOR, index));
 
 	sprintf(s, "%d", index);
-- 
2.41.0

