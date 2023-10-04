Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85EEC7B8C9B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Oct 2023 21:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233599AbjJDS5l (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Oct 2023 14:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244989AbjJDSzh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Oct 2023 14:55:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE2F61734;
        Wed,  4 Oct 2023 11:54:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1D6EC433C8;
        Wed,  4 Oct 2023 18:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696445696;
        bh=k6pPAtQL5fkGNB33LVt/CarhmNwpVtS+fZSlhEaLNnI=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Or0rayYFM3JfUWgcxwJF2tWv16MkHMWmzg4cGup+y3szkq7GAWd6+/luIrW5uLu86
         NnLVBI4bUXu3UZgPJXegtDCZW/TW2GUD9BD5P8SSNcHzshtk03hgMMgCkYFamHdYgR
         +vv+wOl6vo8WtAw+0kxdsg7xjN9KXu7HWGVCdGvUkIguYJhhD1w0milJmfyDbPJAje
         6vqEL0DJBTEHkcN9+IZ29W6cKyGt05kPwC69a2+KmEPjGwcW1hS6PrxczA8N930FqY
         N1vs6d7bETfjgngbzrPGVKfs/2e1mjWD2acA9rajZBSmOT9s5se25aNHGDJA3lq2cn
         bcmNf1cG0euaw==
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 58/89] openpromfs: convert to new timestamp accessors
Date:   Wed,  4 Oct 2023 14:52:43 -0400
Message-ID: <20231004185347.80880-56-jlayton@kernel.org>
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
 fs/openpromfs/inode.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/openpromfs/inode.c b/fs/openpromfs/inode.c
index b2457cb97fa0..c4b65a6d41cc 100644
--- a/fs/openpromfs/inode.c
+++ b/fs/openpromfs/inode.c
@@ -237,7 +237,7 @@ static struct dentry *openpromfs_lookup(struct inode *dir, struct dentry *dentry
 	if (IS_ERR(inode))
 		return ERR_CAST(inode);
 	if (inode->i_state & I_NEW) {
-		inode->i_mtime = inode->i_atime = inode_set_ctime_current(inode);
+		simple_inode_init_ts(inode);
 		ent_oi = OP_I(inode);
 		ent_oi->type = ent_type;
 		ent_oi->u = ent_data;
@@ -387,7 +387,7 @@ static int openprom_fill_super(struct super_block *s, struct fs_context *fc)
 		goto out_no_root;
 	}
 
-	root_inode->i_mtime = root_inode->i_atime = inode_set_ctime_current(root_inode);
+	simple_inode_init_ts(root_inode);
 	root_inode->i_op = &openprom_inode_operations;
 	root_inode->i_fop = &openprom_operations;
 	root_inode->i_mode = S_IFDIR | S_IRUGO | S_IXUGO;
-- 
2.41.0

