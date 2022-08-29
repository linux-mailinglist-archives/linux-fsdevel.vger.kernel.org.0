Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD9995A5484
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Aug 2022 21:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbiH2T0H (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Aug 2022 15:26:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbiH2T0G (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Aug 2022 15:26:06 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCDBA8B2C9;
        Mon, 29 Aug 2022 12:26:01 -0700 (PDT)
Received: from rustam-GF63-Thin-9RCX.. (unknown [93.175.1.130])
        by mail.ispras.ru (Postfix) with ESMTPSA id 52C7B40D403E;
        Mon, 29 Aug 2022 19:25:58 +0000 (UTC)
From:   Rustam Subkhankulov <subkhankulov@ispras.ru>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Rustam Subkhankulov <subkhankulov@ispras.ru>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        ldv-project@linuxtesting.org
Subject: [PATCH v2] fs/inode.c: change the order of initialization in inode_init_always()
Date:   Mon, 29 Aug 2022 22:25:21 +0300
Message-Id: <20220829192521.694631-1-subkhankulov@ispras.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220829141517.bcjbdk5zb74mrhgu@wittgenstein>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If function security_inode_alloc() returns a nonzero value due to an
error (e.g. fail to allocate memory), then some of the fields, including
'i_private', will not be initialized.

After that, if the fs-specfic free_inode function is called in
i_callback(), the nonzero value of 'i_private' field can be interpreted
as initialized. As a result, this can cause dereferencing of random
value pointer (e.g. nilfs2).

In earlier versions, a similar situation could occur with the 'u' union
in 'inode' structure.

Found by Linux Verification Center (linuxtesting.org) with syzkaller.

Signed-off-by: Rustam Subkhankulov <subkhankulov@ispras.ru>
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
---
 fs/inode.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index ba1de23c13c1..a2892d85993d 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -192,8 +192,6 @@ int inode_init_always(struct super_block *sb, struct inode *inode)
 	inode->i_wb_frn_history = 0;
 #endif
 
-	if (security_inode_alloc(inode))
-		goto out;
 	spin_lock_init(&inode->i_lock);
 	lockdep_set_class(&inode->i_lock, &sb->s_type->i_lock_key);
 
@@ -228,6 +226,10 @@ int inode_init_always(struct super_block *sb, struct inode *inode)
 	inode->i_fsnotify_mask = 0;
 #endif
 	inode->i_flctx = NULL;
+
+	if (security_inode_alloc(inode))
+		goto out;
+
 	this_cpu_inc(nr_inodes);
 
 	return 0;
-- 
2.34.1

