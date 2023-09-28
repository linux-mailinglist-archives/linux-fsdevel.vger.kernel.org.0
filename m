Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E9E87B1A1E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Sep 2023 13:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232432AbjI1LJR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Sep 2023 07:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232455AbjI1LIT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Sep 2023 07:08:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DC201FC3;
        Thu, 28 Sep 2023 04:05:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4384FC433C9;
        Thu, 28 Sep 2023 11:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695899121;
        bh=8+8AJF3AhKrl93BeuM8E72hFW1YYn21QPzzOHsiMUnM=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=GrTVxkomxmLgo+dtPFi5YzqlMf7W+QIjQYPYS6norJp1U0ZjX1hpXMEMGU3t56qpP
         4n2vmVnzWD5uLmO8zA+rdMpTOe8NsJkFgaSylhwPXV0oGcPP7RL9gmlKuSNI1SqH/m
         XhmE5NjBoB07BoGDT63+7N9STzkv4IBTFOAubfzLadNMbHDFjXV1Uw85qBka6ZTrMM
         bRazIX+ZxtrcyG/kyHKUzXK4/s6DleQ6BpXhmyfZz3zrMhzZGlxw5Bcan74BSIPDrs
         heUhdGvigKuRAPhVhM1WZzry2WJ88a/bJKG1Z3rYYInU/x4yMgYO1AoS5MkZ++CPxA
         tO2MzhrilBA0Q==
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 57/87] fs/openpromfs: convert to new inode {a,m}time accessors
Date:   Thu, 28 Sep 2023 07:03:06 -0400
Message-ID: <20230928110413.33032-56-jlayton@kernel.org>
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

