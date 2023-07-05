Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55267748D66
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jul 2023 21:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234086AbjGETK0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jul 2023 15:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233740AbjGETIm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jul 2023 15:08:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F338819A2;
        Wed,  5 Jul 2023 12:05:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 568E161702;
        Wed,  5 Jul 2023 19:05:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0063AC433C7;
        Wed,  5 Jul 2023 19:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688583934;
        bh=3sp7OmcXVbe5zYzTxLB6I6YtUeT1soXk8Hp0RuH3SJI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CXrkzL2spbbappNHiT8iNIbL27Oyus1z08ocp1va0NyNPq9oRvpQ1kcmrnZeJJVkI
         F1v3lmptBoZi+Vc1Z0Ka9bpXjSDJdH1cjnhi87SQoeY5txF4eqSPlZf6aedJPdA3YI
         6pV7JPX0/E8KkUivWlWkhH+qlm/XNCJo3IQcO5VFLRxClc1upAmSDdpZa+Zs3iwFrQ
         4tfC78X0lU4Fh7+ArU2+Smf3jXdwJgPhcKFnmJz/t8i9ASJXMabyfeV4vdVf2Da0d0
         iUzyljBH7cYr+75eftkoVsj8LLe/26Mg6zn63dRkqLwloGqFSa7MycG/KQ4Zy8FVfa
         95WGghGW5aAOA==
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <jth@kernel.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 83/92] zonefs: convert to ctime accessor functions
Date:   Wed,  5 Jul 2023 15:01:48 -0400
Message-ID: <20230705190309.579783-81-jlayton@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230705190309.579783-1-jlayton@kernel.org>
References: <20230705185755.579053-1-jlayton@kernel.org>
 <20230705190309.579783-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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

Acked-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/zonefs/super.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index bbe44a26a8e5..eaaa23cf6d93 100644
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -658,7 +658,8 @@ static struct inode *zonefs_get_file_inode(struct inode *dir,
 
 	inode->i_ino = ino;
 	inode->i_mode = z->z_mode;
-	inode->i_ctime = inode->i_mtime = inode->i_atime = dir->i_ctime;
+	inode->i_mtime = inode->i_atime = inode_set_ctime_to_ts(inode,
+								inode_get_ctime(dir));
 	inode->i_uid = z->z_uid;
 	inode->i_gid = z->z_gid;
 	inode->i_size = z->z_wpoffset;
@@ -694,7 +695,8 @@ static struct inode *zonefs_get_zgroup_inode(struct super_block *sb,
 	inode->i_ino = ino;
 	inode_init_owner(&nop_mnt_idmap, inode, root, S_IFDIR | 0555);
 	inode->i_size = sbi->s_zgroup[ztype].g_nr_zones;
-	inode->i_ctime = inode->i_mtime = inode->i_atime = root->i_ctime;
+	inode->i_mtime = inode->i_atime = inode_set_ctime_to_ts(inode,
+								inode_get_ctime(root));
 	inode->i_private = &sbi->s_zgroup[ztype];
 	set_nlink(inode, 2);
 
@@ -1317,7 +1319,7 @@ static int zonefs_fill_super(struct super_block *sb, void *data, int silent)
 
 	inode->i_ino = bdev_nr_zones(sb->s_bdev);
 	inode->i_mode = S_IFDIR | 0555;
-	inode->i_ctime = inode->i_mtime = inode->i_atime = current_time(inode);
+	inode->i_mtime = inode->i_atime = inode_set_ctime_current(inode);
 	inode->i_op = &zonefs_dir_inode_operations;
 	inode->i_fop = &zonefs_dir_operations;
 	inode->i_size = 2;
-- 
2.41.0

