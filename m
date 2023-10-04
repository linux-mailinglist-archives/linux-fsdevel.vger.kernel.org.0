Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 604477B8C15
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Oct 2023 20:56:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244600AbjJDSym (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Oct 2023 14:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244711AbjJDSya (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Oct 2023 14:54:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2EAA19B5;
        Wed,  4 Oct 2023 11:53:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C61DAC433C7;
        Wed,  4 Oct 2023 18:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696445632;
        bh=/xK/B6crc2QtnH34wiVJcFRPWuSlj5Mtmrs9i42Ixu4=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=m/jtbGes7U0TXtS0+fShctLS3xlbZ9Fvqpbgs2AifVk0qOF1YhfztR717yxqiazjw
         8t00zssO1041r/jaS4LsVO37nbDBU9cRac7pt9go6+V3+tuBK3crQn9gHMvKisTa4Q
         EISdA7I8TLOV6RtpnKzuxuUp4VRLpTwJzjm2DcwqPXUGd1yFCET/MO7vkp+2V6mZIx
         +QXvwIaKHpChBwOSCqrNqmpaRDKXqYypSBYG8gWmfrDgdsc+4LybyANF+mgU/wDQ20
         zU3U9MDqkufxCttdWBGHo91bgyNPJHhgTPS2VZgv5SO57CqFSjwhIPJYj/so6Xw2jk
         tAt5jtFE74bcg==
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 05/89] android: convert to new timestamp accessors
Date:   Wed,  4 Oct 2023 14:51:50 -0400
Message-ID: <20231004185347.80880-3-jlayton@kernel.org>
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
 drivers/android/binderfs.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/android/binderfs.c b/drivers/android/binderfs.c
index 81effec17b3d..420dc9cbf774 100644
--- a/drivers/android/binderfs.c
+++ b/drivers/android/binderfs.c
@@ -152,7 +152,7 @@ static int binderfs_binder_device_create(struct inode *ref_inode,
 		goto err;
 
 	inode->i_ino = minor + INODE_OFFSET;
-	inode->i_mtime = inode->i_atime = inode_set_ctime_current(inode);
+	simple_inode_init_ts(inode);
 	init_special_inode(inode, S_IFCHR | 0600,
 			   MKDEV(MAJOR(binderfs_dev), minor));
 	inode->i_fop = &binder_fops;
@@ -431,7 +431,7 @@ static int binderfs_binder_ctl_create(struct super_block *sb)
 	}
 
 	inode->i_ino = SECOND_INODE;
-	inode->i_mtime = inode->i_atime = inode_set_ctime_current(inode);
+	simple_inode_init_ts(inode);
 	init_special_inode(inode, S_IFCHR | 0600,
 			   MKDEV(MAJOR(binderfs_dev), minor));
 	inode->i_fop = &binder_ctl_fops;
@@ -473,7 +473,7 @@ static struct inode *binderfs_make_inode(struct super_block *sb, int mode)
 	if (ret) {
 		ret->i_ino = iunique(sb, BINDERFS_MAX_MINOR + INODE_OFFSET);
 		ret->i_mode = mode;
-		ret->i_atime = ret->i_mtime = inode_set_ctime_current(ret);
+		simple_inode_init_ts(ret);
 	}
 	return ret;
 }
@@ -702,7 +702,7 @@ static int binderfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	inode->i_ino = FIRST_INODE;
 	inode->i_fop = &simple_dir_operations;
 	inode->i_mode = S_IFDIR | 0755;
-	inode->i_mtime = inode->i_atime = inode_set_ctime_current(inode);
+	simple_inode_init_ts(inode);
 	inode->i_op = &binderfs_dir_inode_operations;
 	set_nlink(inode, 2);
 
-- 
2.41.0

