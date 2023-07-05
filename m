Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47298748D3F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jul 2023 21:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233887AbjGETIt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jul 2023 15:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234129AbjGETI0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jul 2023 15:08:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F28735AD;
        Wed,  5 Jul 2023 12:05:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7012D6171C;
        Wed,  5 Jul 2023 19:05:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56A1FC433C8;
        Wed,  5 Jul 2023 19:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688583911;
        bh=qsxxMPleHFd6x6U4R0KWNNZQhuduOrWIl5HygaPVEtU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CTwy+iQw453Xf5IWZcFxXpMjMeR+Lwc3Uo7IoFH4CYQYjUOkXg9KtOul0MlwgaZI5
         pf7T5nolArwiZFkOVj9mZ6YVhQSysfvPqZalQKpD7AsYa1Fxub3Yna3/QLT6uIXVaz
         fy/mH7prd8fK6mmyCQRkR7IVBr+qdUkH4w6HTOCG9XzgKCIv9KiFe5H0F1ZNp+nLZv
         riM+PeCgqlpDBazEhrOP8++uBvi5YSzNNqmiRtzWkitdbnMtB2dVhXuA+VnrPwzNvK
         20fac+OEf7df/k4Av1fDFj9JlpG2m06LSGouqqkXzoc0Xd4wnv6ywIKlFmaHMUHE2f
         amM7rAuIYrx8Q==
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 71/92] ramfs: convert to ctime accessor functions
Date:   Wed,  5 Jul 2023 15:01:36 -0400
Message-ID: <20230705190309.579783-69-jlayton@kernel.org>
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

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ramfs/inode.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/ramfs/inode.c b/fs/ramfs/inode.c
index fef477c78107..18e8387cab41 100644
--- a/fs/ramfs/inode.c
+++ b/fs/ramfs/inode.c
@@ -65,7 +65,7 @@ struct inode *ramfs_get_inode(struct super_block *sb,
 		inode->i_mapping->a_ops = &ram_aops;
 		mapping_set_gfp_mask(inode->i_mapping, GFP_HIGHUSER);
 		mapping_set_unevictable(inode->i_mapping);
-		inode->i_atime = inode->i_mtime = inode->i_ctime = current_time(inode);
+		inode->i_atime = inode->i_mtime = inode_set_ctime_current(inode);
 		switch (mode & S_IFMT) {
 		default:
 			init_special_inode(inode, mode, dev);
@@ -105,7 +105,7 @@ ramfs_mknod(struct mnt_idmap *idmap, struct inode *dir,
 		d_instantiate(dentry, inode);
 		dget(dentry);	/* Extra count - pin the dentry in core */
 		error = 0;
-		dir->i_mtime = dir->i_ctime = current_time(dir);
+		dir->i_mtime = inode_set_ctime_current(dir);
 	}
 	return error;
 }
@@ -138,7 +138,7 @@ static int ramfs_symlink(struct mnt_idmap *idmap, struct inode *dir,
 		if (!error) {
 			d_instantiate(dentry, inode);
 			dget(dentry);
-			dir->i_mtime = dir->i_ctime = current_time(dir);
+			dir->i_mtime = inode_set_ctime_current(dir);
 		} else
 			iput(inode);
 	}
-- 
2.41.0

