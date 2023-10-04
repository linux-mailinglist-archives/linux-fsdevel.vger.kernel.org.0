Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 149BE7B8BF8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Oct 2023 20:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243857AbjJDSz0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Oct 2023 14:55:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244790AbjJDSyp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Oct 2023 14:54:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CF231BE9;
        Wed,  4 Oct 2023 11:54:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D974C433CA;
        Wed,  4 Oct 2023 18:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696445658;
        bh=v4JZ/Qz5VXfK/0x8Eh9nkHzGJciYxKKhvLE8zn0Xn7Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aDgeqyd0KqozhiZgYc9/omyN4u+x3TIH5SJxjs3IO+OzBZhBze4yTEFBHgDPaSEdZ
         BPDdamwaS9bAyTo7ZpZVD4Li0MD34J8MjaY8NPJzGrasb7pE+GX584STTE1q2aYTOk
         nr9Fe5XfVN9E88Sqj+v8kA3Qkf19LuRluTr5PHZufP2S+2pPTda5c/4XDo7W485IhW
         DLFMBb/SlkoGvcIjxIk78jLmdZ54O9vFDqmskvtUS9h4isYDQaeQq2sIgcZORiWc0u
         dUhgXOiMnUGjqe4UbEUBiQ6LRdyEMD1tvQn42JbxY1ZFvUGyngG1YdEzhAhd05ilvW
         A/datOwoFhEJQ==
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v2 28/89] debugfs: convert to new timestamp accessors
Date:   Wed,  4 Oct 2023 14:52:13 -0400
Message-ID: <20231004185347.80880-26-jlayton@kernel.org>
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
 fs/debugfs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
index 83e57e9f9fa0..5d41765e0c77 100644
--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -72,7 +72,7 @@ static struct inode *debugfs_get_inode(struct super_block *sb)
 	struct inode *inode = new_inode(sb);
 	if (inode) {
 		inode->i_ino = get_next_ino();
-		inode->i_atime = inode->i_mtime = inode_set_ctime_current(inode);
+		simple_inode_init_ts(inode);
 	}
 	return inode;
 }
-- 
2.41.0

