Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8790F7B8C61
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Oct 2023 21:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245228AbjJDS7S (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Oct 2023 14:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245197AbjJDS5d (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Oct 2023 14:57:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1777F19B2;
        Wed,  4 Oct 2023 11:55:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9110AC433CB;
        Wed,  4 Oct 2023 18:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696445704;
        bh=S8tAZxon6hXRz9ReTd0X25sPxDNyJENVPOCPLJigAL0=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=JwtjnuCALLzl4pVn8WtHZ5djoHE7zzymhuew+1h8c4iBqmCTd28c5lltf+jtzVG+A
         2kyoeduQxqL22Qt9yczA61L2BNNFop4j4jQTec2w+ey8xdfOdhT8/i5MlHXSCXVYBA
         inz/uO/ciYyK8U8aul62i+ozajX2HroX6ZGFer9SQ4YEjstfkjlCOZ9XQjuy5zPpXK
         C6GeihVxFm8GY6LyimSjAswIsfNUJMSWnoWWo06LnT1mf6Ct7KRgZviYWQyK2++BoJ
         6RqgfkFFwLgIckOYAsYWbtczKXrQ7gqBVZpOdmXrwwnWI9Q/6xeZNmUTJQiv8TO/+6
         eZkpzxRN4bFpw==
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 65/89] ramfs: convert to new timestamp accessors
Date:   Wed,  4 Oct 2023 14:52:50 -0400
Message-ID: <20231004185347.80880-63-jlayton@kernel.org>
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

