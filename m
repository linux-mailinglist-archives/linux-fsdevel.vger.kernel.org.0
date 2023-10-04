Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EE617B8CCA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Oct 2023 21:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244791AbjJDTIP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Oct 2023 15:08:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245515AbjJDTIC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Oct 2023 15:08:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9451E1FC9;
        Wed,  4 Oct 2023 11:55:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDDB1C433C9;
        Wed,  4 Oct 2023 18:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696445720;
        bh=DgEQfKZJzVRlGstT1xAqKNQO563GSXEO2vDTLGHo+yw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C2OsC/RxcQr0BRZI/QLa1FUKzOqS8R6jL95JBqmAGXw2/a9/YQayqFFcyb+CIngJc
         rvBnyxd93Mhbt/eBfItE82kVUi84VCNV0+VGpl0ZBUxyg4undkJfgsehP6FT3QESat
         lEDZqCTTlf82pLO8msBiD9gJhrH2dFIACqxSSnKWekRNKKLqwW5K52AoQ3hVJBW52v
         u6wFJdDhT1kkPg+m7voxfnr1CgEGEvWVJVODxOcB966qb3FFgR1S5uJTVl2pCI/OuL
         jnQlakb0gAvF90i3icw0CTd+/mjWTk+C+W57VUG9h6QCiPAOQyq5gZx3gFMQ+jBYEh
         KAO+9XFnyV6TQ==
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Johannes Thumshirn <jth@kernel.org>
Subject: [PATCH v2 78/89] zonefs: convert to new timestamp accessors
Date:   Wed,  4 Oct 2023 14:53:03 -0400
Message-ID: <20231004185347.80880-76-jlayton@kernel.org>
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

