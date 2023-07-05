Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC1D748CD7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jul 2023 21:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233657AbjGETE1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jul 2023 15:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233553AbjGETDs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jul 2023 15:03:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09A1C1BDF;
        Wed,  5 Jul 2023 12:03:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C8ACD616FE;
        Wed,  5 Jul 2023 19:03:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28D97C433C7;
        Wed,  5 Jul 2023 19:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688583813;
        bh=iubgnQN1kMbfBpqCB1PL0fyQ97oUl4IwPzXS1yBOIxY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FQFU9umi3nbN6MUMUVCcV+vXKLeoDGFZO6/1+5pyWSD9eKk/+Onv7wQIfL8pnJWVw
         G8dM5ymyv0wyLuCISkwUYDVFnuE6F2lCY3gBOx2s5JU0x2+ICJo+HP5iTH6nxhGweL
         q92xirYuK3Q3dyo1ecVZrU6g6q62R7QvWHUQONJ5McfeSNtwvxvCvBcWmK746kLgAn
         e2802DpdrYiGtsdkSKhlFL4rKc2gDdB6/XMwXeOv3zv9UI95vpfbhBmbAF/gJ8O/7p
         Y/hBXXrb6yznVrGlB2jC36bM6ItuVvOCcqZBcW7HNSFPkHearOjr3+fWh7pj+4rlam
         nkZUV36QwcfuA==
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Carlos Llamas <cmllamas@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 17/92] binderfs: convert to ctime accessor functions
Date:   Wed,  5 Jul 2023 15:00:42 -0400
Message-ID: <20230705190309.579783-15-jlayton@kernel.org>
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

Reviewed-by: Jan Kara <jack@suse.cz>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 drivers/android/binderfs.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/android/binderfs.c b/drivers/android/binderfs.c
index 76e7d6676657..faebe9f5412a 100644
--- a/drivers/android/binderfs.c
+++ b/drivers/android/binderfs.c
@@ -153,7 +153,7 @@ static int binderfs_binder_device_create(struct inode *ref_inode,
 		goto err;
 
 	inode->i_ino = minor + INODE_OFFSET;
-	inode->i_mtime = inode->i_atime = inode->i_ctime = current_time(inode);
+	inode->i_mtime = inode->i_atime = inode_set_ctime_current(inode);
 	init_special_inode(inode, S_IFCHR | 0600,
 			   MKDEV(MAJOR(binderfs_dev), minor));
 	inode->i_fop = &binder_fops;
@@ -432,7 +432,7 @@ static int binderfs_binder_ctl_create(struct super_block *sb)
 	}
 
 	inode->i_ino = SECOND_INODE;
-	inode->i_mtime = inode->i_atime = inode->i_ctime = current_time(inode);
+	inode->i_mtime = inode->i_atime = inode_set_ctime_current(inode);
 	init_special_inode(inode, S_IFCHR | 0600,
 			   MKDEV(MAJOR(binderfs_dev), minor));
 	inode->i_fop = &binder_ctl_fops;
@@ -474,7 +474,7 @@ static struct inode *binderfs_make_inode(struct super_block *sb, int mode)
 	if (ret) {
 		ret->i_ino = iunique(sb, BINDERFS_MAX_MINOR + INODE_OFFSET);
 		ret->i_mode = mode;
-		ret->i_atime = ret->i_mtime = ret->i_ctime = current_time(ret);
+		ret->i_atime = ret->i_mtime = inode_set_ctime_current(ret);
 	}
 	return ret;
 }
@@ -703,7 +703,7 @@ static int binderfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	inode->i_ino = FIRST_INODE;
 	inode->i_fop = &simple_dir_operations;
 	inode->i_mode = S_IFDIR | 0755;
-	inode->i_mtime = inode->i_atime = inode->i_ctime = current_time(inode);
+	inode->i_mtime = inode->i_atime = inode_set_ctime_current(inode);
 	inode->i_op = &binderfs_dir_inode_operations;
 	set_nlink(inode, 2);
 
-- 
2.41.0

