Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73F335A3812
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Aug 2022 16:11:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233352AbiH0OJt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 27 Aug 2022 10:09:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233346AbiH0OJs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 27 Aug 2022 10:09:48 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F7764D173;
        Sat, 27 Aug 2022 07:09:43 -0700 (PDT)
Received: from hednb3.intra.ispras.ru (unknown [109.252.119.247])
        by mail.ispras.ru (Postfix) with ESMTPSA id B6E7B40737C1;
        Sat, 27 Aug 2022 14:09:39 +0000 (UTC)
From:   Alexey Khoroshilov <khoroshilov@ispras.ru>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Rustam Subkhankulov <subkhankulov@ispras.ru>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        ldv-project@linuxtesting.org
Subject: [PATCH] fs/inode.c: change the order of initialization in inode_init_always()
Date:   Sat, 27 Aug 2022 17:09:26 +0300
Message-Id: <1661609366-26144-1-git-send-email-khoroshilov@ispras.ru>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Rustam Subkhankulov <subkhankulov@ispras.ru>

If function 'security_inode_alloc()' returns a nonzero value at
[fs/inode.c: 195] due to an error (e.g. fail to allocate memory),
then some of the fields, including 'i_private', will not be
initialized.

After that, if the fs-specfic free_inode function is called in
'i_callback', the nonzero value of 'i_private' field can be interpreted
as initialized. As a result, this can cause dereferencing of random
value pointer (e.g. nilfs2).

In earlier versions, a similar situation could occur with the 'u' union
in 'inode' structure.

Found by Linux Verification Center (linuxtesting.org) with syzkaller.

Signed-off-by: Rustam Subkhankulov <subkhankulov@ispras.ru>
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
---
 fs/inode.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index bd4da9c5207e..08d093737e8c 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -192,8 +192,6 @@ int inode_init_always(struct super_block *sb, struct inode *inode)
 	inode->i_wb_frn_history = 0;
 #endif
 
-	if (security_inode_alloc(inode))
-		goto out;
 	spin_lock_init(&inode->i_lock);
 	lockdep_set_class(&inode->i_lock, &sb->s_type->i_lock_key);
 
@@ -230,9 +228,10 @@ int inode_init_always(struct super_block *sb, struct inode *inode)
 	inode->i_flctx = NULL;
 	this_cpu_inc(nr_inodes);
 
+	if (security_inode_alloc(inode))
+		return -ENOMEM;
+
 	return 0;
-out:
-	return -ENOMEM;
 }
 EXPORT_SYMBOL(inode_init_always);
 
-- 
2.34.1

