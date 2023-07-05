Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5AB2748CC8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jul 2023 21:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233587AbjGETDy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jul 2023 15:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233439AbjGETDb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jul 2023 15:03:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91B3C1BCD;
        Wed,  5 Jul 2023 12:03:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2FE6E616EC;
        Wed,  5 Jul 2023 19:03:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E482BC433C7;
        Wed,  5 Jul 2023 19:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688583806;
        bh=TY45/qxVQy5GwD4MUK0nAW9hU9YuqFqdo4bjfCKVLWk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q5YkT3oKssEYp1IZYAITd8OOV6yhElw19ZJxTOnXqApHyge3ImKYjoVO8TWQXVC7K
         c7wz+wwOGez5xi0rfzV5yW9ruvCLO1a86FBTYITX2YVrOGLZnpoH0TkpQ7YurobODP
         bMTyuKQVK1s0qZw7kBgqW4Msb5FnjM3IQp+IISwpBukKE2R6WN4zMwumL77K6gCc72
         UvPHm3P6xYVpn7jS6rRwjHfbkX0oXETbH8Gliu+IZOO0lfvgkjFwDnJ9CoijLClhlW
         ecPkniQJCMr8yRDa5h8zbn2zqJzqzmHC+AezI9URr1qmySlFInP+u9RjTSrQE5jBun
         I4KkezId9Jn6A==
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ntfs3@lists.linux.dev
Subject: [PATCH v2 13/92] ntfs3: convert to simple_rename_timestamp
Date:   Wed,  5 Jul 2023 15:00:38 -0400
Message-ID: <20230705190309.579783-11-jlayton@kernel.org>
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

A rename potentially involves updating 4 different inode timestamps.
Convert to the new simple_rename_timestamp helper function.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ntfs3/namei.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/ntfs3/namei.c b/fs/ntfs3/namei.c
index 70f8c859e0ad..bfd986699f9e 100644
--- a/fs/ntfs3/namei.c
+++ b/fs/ntfs3/namei.c
@@ -324,14 +324,11 @@ static int ntfs_rename(struct mnt_idmap *idmap, struct inode *dir,
 		/* Restore after failed rename failed too. */
 		_ntfs_bad_inode(inode);
 	} else if (!err) {
-		inode->i_ctime = dir->i_ctime = dir->i_mtime =
-			current_time(dir);
+		simple_rename_timestamp(dir, dentry, new_dir, new_dentry);
 		mark_inode_dirty(inode);
 		mark_inode_dirty(dir);
-		if (dir != new_dir) {
-			new_dir->i_mtime = new_dir->i_ctime = dir->i_ctime;
+		if (dir != new_dir)
 			mark_inode_dirty(new_dir);
-		}
 
 		if (IS_DIRSYNC(dir))
 			ntfs_sync_inode(dir);
-- 
2.41.0

