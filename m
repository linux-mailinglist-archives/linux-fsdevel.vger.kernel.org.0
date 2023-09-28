Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68EA27B19BE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Sep 2023 13:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232126AbjI1LFx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Sep 2023 07:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232120AbjI1LEr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Sep 2023 07:04:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15DB3CCA;
        Thu, 28 Sep 2023 04:04:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 217B6C433CA;
        Thu, 28 Sep 2023 11:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695899084;
        bh=v9z0/wIA3lMrPUrVgPV8jMRrEFIBVBwkDnpYB974b6U=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=uS/q0iCZHBe6IGy23Du0wVWD8QQsRkuTG7RxzFktFhu7pgdsbnwuQYvKVarlvP6Ts
         nMjmSm5UqJFJgoT8y3VPUhcXNWRc2oBK+FIsZmplwzeC7CT9bhts4cqBayR7abovdR
         c7AbIPtVInwXUk3DS6abCJB0kG3e5ObBy0LITQBc218iMDkucusNYfZFH+4w/vkTju
         G51nThxSmxgwVJAmFVSRp9TcxYqjOyYYgdwsj630geIfo4Oyzd+DdhQfX+axVp/S3a
         tiFxBp/eorY+k4XZ6mW9Ba2Mge1b3zeVQ8NiD/v59G3fkivQZ8ya9VeCCrYY9BuOc4
         hRdX9y75iKghw==
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 28/87] fs/devpts: convert to new inode {a,m}time accessors
Date:   Thu, 28 Sep 2023 07:02:37 -0400
Message-ID: <20230928110413.33032-27-jlayton@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230928110413.33032-1-jlayton@kernel.org>
References: <20230928110300.32891-1-jlayton@kernel.org>
 <20230928110413.33032-1-jlayton@kernel.org>
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

