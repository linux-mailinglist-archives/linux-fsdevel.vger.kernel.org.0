Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DB1D7B8CD8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Oct 2023 21:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245189AbjJDS7O (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Oct 2023 14:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245188AbjJDS5c (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Oct 2023 14:57:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4071F19A5;
        Wed,  4 Oct 2023 11:55:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C16CC4160E;
        Wed,  4 Oct 2023 18:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696445702;
        bh=CMGdYXPOxwLuV14GaP34l2MZRW5TD6XlHfy3cpYDZKI=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Zkuj6bKo0HwDupniG2ss2xEtuc0eyAJaM392Ev7OfmRTCEVD4WrK8IA3AUdNFTpnu
         MTOw+zNLYznrO8lpG9RSTRM3qchtnokzLXkd/Hp0fbv9i7pLPZs5hcscbFpvCO0SYv
         ay+vRxUvCwc8X7RZ62HRWclm4icmawFbJfccf6App8UpGYS4t5tHqMxMluyMrlcbKQ
         /sPPOYuNN2uqwK/C0ndwu/9WEMjQ1v8OIXVTZ1rvw3XjxZFa/CfPjSrI/hBxmAqxmr
         m7IVle42FOoX5AbOESPfrmGciskoED1lDXawTdj5adAdikULLxqMtLh6PRmBdnfOZd
         JNjC5JOmrOXIg==
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 63/89] qnx4: convert to new timestamp accessors
Date:   Wed,  4 Oct 2023 14:52:48 -0400
Message-ID: <20231004185347.80880-61-jlayton@kernel.org>
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
 fs/qnx4/inode.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/qnx4/inode.c b/fs/qnx4/inode.c
index a7171f5532a1..6eb9bb369b57 100644
--- a/fs/qnx4/inode.c
+++ b/fs/qnx4/inode.c
@@ -301,10 +301,8 @@ struct inode *qnx4_iget(struct super_block *sb, unsigned long ino)
 	i_gid_write(inode, (gid_t)le16_to_cpu(raw_inode->di_gid));
 	set_nlink(inode, le16_to_cpu(raw_inode->di_nlink));
 	inode->i_size    = le32_to_cpu(raw_inode->di_size);
-	inode->i_mtime.tv_sec   = le32_to_cpu(raw_inode->di_mtime);
-	inode->i_mtime.tv_nsec = 0;
-	inode->i_atime.tv_sec   = le32_to_cpu(raw_inode->di_atime);
-	inode->i_atime.tv_nsec = 0;
+	inode_set_mtime(inode, le32_to_cpu(raw_inode->di_mtime), 0);
+	inode_set_atime(inode, le32_to_cpu(raw_inode->di_atime), 0);
 	inode_set_ctime(inode, le32_to_cpu(raw_inode->di_ctime), 0);
 	inode->i_blocks  = le32_to_cpu(raw_inode->di_first_xtnt.xtnt_size);
 
-- 
2.41.0

