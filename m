Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E06E5738804
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jun 2023 16:54:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232663AbjFUOyS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jun 2023 10:54:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232713AbjFUOxY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jun 2023 10:53:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 002B930F5;
        Wed, 21 Jun 2023 07:49:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1502B615B9;
        Wed, 21 Jun 2023 14:49:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B365BC433C8;
        Wed, 21 Jun 2023 14:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687358979;
        bh=DSeTksfqnRw4FPVrRQ9ashItXalQw8m2rHVJuaKZBs4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c/Kn/XvvVsITo8FQUfTG+bY74x6zwNwFkqyhsvhEA1OTNe00SnnVIep87P4pGse12
         fhelK49W869TtAV6JGbsapApb8i2ZcNUZ7goPFtvhOEej5uUpRxCe+LVI6tQER46g9
         NbihuwRsHvso4Qas5urVBeYh/aOWEBWzsl+EnbJuGot8oolfmboWUwM+zGAVFwx2Py
         Ss711xinjZrvbBC1s2qJ6PNWq1WX3jzlsg1Z9Te0Kx2iYn+ry/pGXN7gZMgsMdQ5Hz
         YpFDwc6ycBJxSsp5zocIXQyw8Ec8Ssk1TFWtmUUK7MNvbZ1yqcQtCBkVG/eKdEyMxt
         BBnxPy+p12uQg==
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <jth@kernel.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 71/79] zonefs: switch to new ctime accessors
Date:   Wed, 21 Jun 2023 10:46:24 -0400
Message-ID: <20230621144735.55953-70-jlayton@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230621144735.55953-1-jlayton@kernel.org>
References: <20230621144507.55591-1-jlayton@kernel.org>
 <20230621144735.55953-1-jlayton@kernel.org>
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

In later patches, we're going to change how the ctime.tv_nsec field is
utilized. Switch to using accessor functions instead of raw accesses of
inode->i_ctime.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/zonefs/super.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index bbe44a26a8e5..75be0e039ccf 100644
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -658,7 +658,8 @@ static struct inode *zonefs_get_file_inode(struct inode *dir,
 
 	inode->i_ino = ino;
 	inode->i_mode = z->z_mode;
-	inode->i_ctime = inode->i_mtime = inode->i_atime = dir->i_ctime;
+	inode->i_mtime = inode->i_atime = inode_ctime_peek(dir);
+	inode_ctime_set(inode, inode->i_mtime);
 	inode->i_uid = z->z_uid;
 	inode->i_gid = z->z_gid;
 	inode->i_size = z->z_wpoffset;
@@ -694,7 +695,8 @@ static struct inode *zonefs_get_zgroup_inode(struct super_block *sb,
 	inode->i_ino = ino;
 	inode_init_owner(&nop_mnt_idmap, inode, root, S_IFDIR | 0555);
 	inode->i_size = sbi->s_zgroup[ztype].g_nr_zones;
-	inode->i_ctime = inode->i_mtime = inode->i_atime = root->i_ctime;
+	inode->i_mtime = inode->i_atime = inode_ctime_peek(root);
+	inode_ctime_set(inode, inode->i_mtime);
 	inode->i_private = &sbi->s_zgroup[ztype];
 	set_nlink(inode, 2);
 
@@ -1317,7 +1319,7 @@ static int zonefs_fill_super(struct super_block *sb, void *data, int silent)
 
 	inode->i_ino = bdev_nr_zones(sb->s_bdev);
 	inode->i_mode = S_IFDIR | 0555;
-	inode->i_ctime = inode->i_mtime = inode->i_atime = current_time(inode);
+	inode->i_atime = inode->i_mtime = inode_ctime_set_current(inode);
 	inode->i_op = &zonefs_dir_inode_operations;
 	inode->i_fop = &zonefs_dir_operations;
 	inode->i_size = 2;
-- 
2.41.0

