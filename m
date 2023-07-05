Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4B32748D69
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jul 2023 21:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233827AbjGETK2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jul 2023 15:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233807AbjGETIn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jul 2023 15:08:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B0B71BC2;
        Wed,  5 Jul 2023 12:05:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 78E46616F5;
        Wed,  5 Jul 2023 19:05:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58D04C433C8;
        Wed,  5 Jul 2023 19:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688583900;
        bh=D4PXifJos2kbOsXU6nvjdH1kYQlJwGcy8WjsipEzEik=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mG3H3PEc9ZmdfSzPaWslswErvXr3CZmQQt1nL55o1yEsKIg/75QDN/TCflGiSJ3yP
         YQcG27mucubVIt/jUjX1Bc2cQnsjAV0mzeNzPjnwR4M8T+iq9Cw3Gn3pFUB5xthBjn
         N9dn1euzTJvXsTzhVo1w3B6xzqmfsoXbVZxvePl36H3HUZhSPagbmV4nRaBlxepKzK
         8MCE6pZxqiaUVzWS79/ra6Sn1uwLMxktV3gRNZ5F8IEZx34B5G2+4yR+cTwz08v6Md
         qJzgyxUb0mVNwj7tzllPbyR/QHqsjYTPECc314uITdBB4jkabli2dima6qJeLLFBG8
         W/zvi6zKCYYtA==
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 64/92] openpromfs: convert to ctime accessor functions
Date:   Wed,  5 Jul 2023 15:01:29 -0400
Message-ID: <20230705190309.579783-62-jlayton@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230705190309.579783-1-jlayton@kernel.org>
References: <20230705185755.579053-1-jlayton@kernel.org>
 <20230705190309.579783-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/openpromfs/inode.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/openpromfs/inode.c b/fs/openpromfs/inode.c
index f0b7f4d51a17..b2457cb97fa0 100644
--- a/fs/openpromfs/inode.c
+++ b/fs/openpromfs/inode.c
@@ -237,7 +237,7 @@ static struct dentry *openpromfs_lookup(struct inode *dir, struct dentry *dentry
 	if (IS_ERR(inode))
 		return ERR_CAST(inode);
 	if (inode->i_state & I_NEW) {
-		inode->i_mtime = inode->i_atime = inode->i_ctime = current_time(inode);
+		inode->i_mtime = inode->i_atime = inode_set_ctime_current(inode);
 		ent_oi = OP_I(inode);
 		ent_oi->type = ent_type;
 		ent_oi->u = ent_data;
@@ -387,8 +387,7 @@ static int openprom_fill_super(struct super_block *s, struct fs_context *fc)
 		goto out_no_root;
 	}
 
-	root_inode->i_mtime = root_inode->i_atime =
-		root_inode->i_ctime = current_time(root_inode);
+	root_inode->i_mtime = root_inode->i_atime = inode_set_ctime_current(root_inode);
 	root_inode->i_op = &openprom_inode_operations;
 	root_inode->i_fop = &openprom_operations;
 	root_inode->i_mode = S_IFDIR | S_IRUGO | S_IXUGO;
-- 
2.41.0

