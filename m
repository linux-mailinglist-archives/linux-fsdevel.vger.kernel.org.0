Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E0007B1A98
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Sep 2023 13:19:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232201AbjI1LTj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Sep 2023 07:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232018AbjI1LTJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Sep 2023 07:19:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 221E52D6A;
        Thu, 28 Sep 2023 04:05:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EB49C433CB;
        Thu, 28 Sep 2023 11:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695899145;
        bh=kDD770rcYrkIWsan1bLDTDkXiPkbBnLU7OCnjmn7X9Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MFe0YWnhGqAih6g9LXYbcn84RWrbun1ZpctoHzGu+t+jXDKW5Ei8hWmm1+km0gawC
         SbtiopF5ZN8u51O+ayLfiMVh7dwUcF1e3a7vMJVKYyYY4X2ZuGn4+9AybUAPWkOZAI
         ntW5ad8Y02rmNiTc5C5iDXGBBc7D84Ua4mu2xGUJhoz4eW4UL9exkBIDnrv4xt9vA9
         S8hxN9G7zt8Tj+Tc01UjWm/5D7CiHCZD6M5f+89efatnHpbSLc6ieWkoyBO4BtD1yr
         NwUQHDib2Edxq+za2H1SP/Rc/t4gOJKRbJX05vQmdZ7WAwHzvSFItPm87lu7wm8NsJ
         OQYAQm/Z6Okfg==
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Johannes Thumshirn <jth@kernel.org>
Subject: [PATCH 77/87] fs/zonefs: convert to new inode {a,m}time accessors
Date:   Thu, 28 Sep 2023 07:03:26 -0400
Message-ID: <20230928110413.33032-76-jlayton@kernel.org>
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
 fs/zonefs/super.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index 9d1a9808fbbb..e6a75401677d 100644
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -658,8 +658,8 @@ static struct inode *zonefs_get_file_inode(struct inode *dir,
 
 	inode->i_ino = ino;
 	inode->i_mode = z->z_mode;
-	inode->i_mtime = inode->i_atime = inode_set_ctime_to_ts(inode,
-								inode_get_ctime(dir));
+	inode_set_mtime_to_ts(inode,
+			      inode_set_atime_to_ts(inode, inode_set_ctime_to_ts(inode, inode_get_ctime(dir))));
 	inode->i_uid = z->z_uid;
 	inode->i_gid = z->z_gid;
 	inode->i_size = z->z_wpoffset;
@@ -695,8 +695,8 @@ static struct inode *zonefs_get_zgroup_inode(struct super_block *sb,
 	inode->i_ino = ino;
 	inode_init_owner(&nop_mnt_idmap, inode, root, S_IFDIR | 0555);
 	inode->i_size = sbi->s_zgroup[ztype].g_nr_zones;
-	inode->i_mtime = inode->i_atime = inode_set_ctime_to_ts(inode,
-								inode_get_ctime(root));
+	inode_set_mtime_to_ts(inode,
+			      inode_set_atime_to_ts(inode, inode_set_ctime_to_ts(inode, inode_get_ctime(root))));
 	inode->i_private = &sbi->s_zgroup[ztype];
 	set_nlink(inode, 2);
 
@@ -1319,7 +1319,7 @@ static int zonefs_fill_super(struct super_block *sb, void *data, int silent)
 
 	inode->i_ino = bdev_nr_zones(sb->s_bdev);
 	inode->i_mode = S_IFDIR | 0555;
-	inode->i_mtime = inode->i_atime = inode_set_ctime_current(inode);
+	simple_inode_init_ts(inode);
 	inode->i_op = &zonefs_dir_inode_operations;
 	inode->i_fop = &zonefs_dir_operations;
 	inode->i_size = 2;
-- 
2.41.0

