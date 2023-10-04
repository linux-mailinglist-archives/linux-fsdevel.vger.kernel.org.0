Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A50F07B8BD6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Oct 2023 20:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244673AbjJDSyy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Oct 2023 14:54:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244722AbjJDSyb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Oct 2023 14:54:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEB7F19BF;
        Wed,  4 Oct 2023 11:53:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8165C433CD;
        Wed,  4 Oct 2023 18:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696445634;
        bh=OjZRsVOhL4N5a68/cSqDR7Hd40kPAU0k6mob5huCQzM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iDoGTPkzLTFKZF8o1zfAcpwFb/FP2eM4KayhXfGi5bZJ4aSlAByMBCv9bO3VjAJlf
         oRMBMYMieY7ATM/k9oYCRgsW6qaTBMh9/efAuFZmcPed+iV0t9zyxjRCKDi61nJx+x
         bLcE8B1TFNkvKtLc8ULX/epWt2tLFMB9T9k1uSiEKOG+tkiLYxfQYrBmMD62wjaot3
         f0xQ1Ly1ezhNVE6B/h2veLzjfNCBIwNCrAUwgqrbbUtV78u8LYk654MS2cX5njkdKq
         mG61M3GDiD6bsmdkkVo7f0bk5q8v0id5DA5E5dsVkoI7ObiAgZoCa4I0NiR37Jpsr4
         snR3sjNF9vt6Q==
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH v2 07/89] qib: convert to new timestamp accessors
Date:   Wed,  4 Oct 2023 14:51:52 -0400
Message-ID: <20231004185347.80880-5-jlayton@kernel.org>
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
 drivers/infiniband/hw/qib/qib_fs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/qib/qib_fs.c b/drivers/infiniband/hw/qib/qib_fs.c
index ed7d4b02f45a..455e966eeff3 100644
--- a/drivers/infiniband/hw/qib/qib_fs.c
+++ b/drivers/infiniband/hw/qib/qib_fs.c
@@ -64,8 +64,8 @@ static int qibfs_mknod(struct inode *dir, struct dentry *dentry,
 	inode->i_uid = GLOBAL_ROOT_UID;
 	inode->i_gid = GLOBAL_ROOT_GID;
 	inode->i_blocks = 0;
-	inode->i_atime = inode_set_ctime_current(inode);
-	inode->i_mtime = inode->i_atime;
+	simple_inode_init_ts(inode);
+	
 	inode->i_private = data;
 	if (S_ISDIR(mode)) {
 		inode->i_op = &simple_dir_inode_operations;
-- 
2.41.0

