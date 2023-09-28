Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DEC47B1A2D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Sep 2023 13:09:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232395AbjI1LJu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Sep 2023 07:09:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232444AbjI1LJI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Sep 2023 07:09:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BABC62118;
        Thu, 28 Sep 2023 04:05:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BFE8C433CC;
        Thu, 28 Sep 2023 11:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695899129;
        bh=3LzY1QRMSw8FwRd1+T82f5waDViGnmvRRNSI+fB1IAk=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=delfDE9loiqO3Ouk1TN+e5suQ+hlcuSQQ0rmXemqSdFicJYQTe0c1wAPsP83gGCgX
         lyHmBwDIU23TNtN4UJ1euEvBS/9BIf9YyxFejUXFzf7SM0iGjcxJLqr4A/SNij42LA
         cw6CcqzZXbpFF0GB3obLTFIUSTSMuNHa7JorJCn1B0E2EmsthztYg+BXlqbWwISLwy
         61G8rIzZmGBDRwf1y+vQFJ4gSbU2pNlH4fVdwiciZFeqaNOL5dfPht27Mnfhek6z/t
         MuXZLL63iBt9lXK1XF6/jrGjTAqCAljQ2dRNOEJxBRLN22p+22ixExJxxtLq0Cbza2
         OBjQE7MHfDhkw==
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 64/87] fs/ramfs: convert to new inode {a,m}time accessors
Date:   Thu, 28 Sep 2023 07:03:13 -0400
Message-ID: <20230928110413.33032-63-jlayton@kernel.org>
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
 fs/ramfs/inode.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/ramfs/inode.c b/fs/ramfs/inode.c
index 18e8387cab41..4ac05a9e25bc 100644
--- a/fs/ramfs/inode.c
+++ b/fs/ramfs/inode.c
@@ -65,7 +65,7 @@ struct inode *ramfs_get_inode(struct super_block *sb,
 		inode->i_mapping->a_ops = &ram_aops;
 		mapping_set_gfp_mask(inode->i_mapping, GFP_HIGHUSER);
 		mapping_set_unevictable(inode->i_mapping);
-		inode->i_atime = inode->i_mtime = inode_set_ctime_current(inode);
+		simple_inode_init_ts(inode);
 		switch (mode & S_IFMT) {
 		default:
 			init_special_inode(inode, mode, dev);
@@ -105,7 +105,7 @@ ramfs_mknod(struct mnt_idmap *idmap, struct inode *dir,
 		d_instantiate(dentry, inode);
 		dget(dentry);	/* Extra count - pin the dentry in core */
 		error = 0;
-		dir->i_mtime = inode_set_ctime_current(dir);
+		inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
 	}
 	return error;
 }
@@ -138,7 +138,8 @@ static int ramfs_symlink(struct mnt_idmap *idmap, struct inode *dir,
 		if (!error) {
 			d_instantiate(dentry, inode);
 			dget(dentry);
-			dir->i_mtime = inode_set_ctime_current(dir);
+			inode_set_mtime_to_ts(dir,
+					      inode_set_ctime_current(dir));
 		} else
 			iput(inode);
 	}
-- 
2.41.0

