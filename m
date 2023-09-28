Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22EA37B198A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Sep 2023 13:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232031AbjI1LEq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Sep 2023 07:04:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232013AbjI1LEU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Sep 2023 07:04:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15D9ACEA;
        Thu, 28 Sep 2023 04:04:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42E05C43391;
        Thu, 28 Sep 2023 11:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695899058;
        bh=IWRS0sv4F2GhgvX85r1nFL1OfwOp4/XyjcH6Y3xdgTE=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=b6A+2xaI6pgQN+3dsy2mCOD9PDx411S3Ydu90LNqns7K3ssWCUiNw8xy4j4adpra8
         qSn0vb75mY/qesopcA++AtWow4hoAv7r4LdYDurC7my3O18PkR0dtESNg4bTHET0Q4
         3Ahy6fdOdNesktoORpFHDvBl9hkL0DV1HfvCyFNArLgZNSbZBo5ySrlzwIAQbW8Q6O
         czYwD0UdpJlXyTr9j9AArkgt49zV/RBrtWDJSXGVoxKT0YduDTN9hm+fHLsube0FTH
         n7WYM8LxzBpT4EcUrzycR4IccopqT4Y70wKaa4bJg9KZ9cxI/TFpE0Hz0HAv5Aaczg
         L68gy8O03b8/Q==
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 05/87] drivers/android: convert to new inode {a,m}time accessors
Date:   Thu, 28 Sep 2023 07:02:14 -0400
Message-ID: <20230928110413.33032-4-jlayton@kernel.org>
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

