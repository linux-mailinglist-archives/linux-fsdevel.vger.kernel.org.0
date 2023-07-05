Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BD5B748CC0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jul 2023 21:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233524AbjGETDl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jul 2023 15:03:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233476AbjGETD3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jul 2023 15:03:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2B6D1998;
        Wed,  5 Jul 2023 12:03:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6FAD0616F6;
        Wed,  5 Jul 2023 19:03:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06436C433C7;
        Wed,  5 Jul 2023 19:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688583800;
        bh=JfqF6OJj+HPavYNtUdzWAI51yxDXyrTo8JOXu9AcCz0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lkxHgeA4voFsFMFla2p6qkW8yPOEMKMKR0zZJ8jlO9Cyavlyb1ouSHm1QL8K8dTyj
         768qxlKoDk6ABTkxd3qI9e2MNWV4T56aGehv1rZY1odO9iIp9q/AsXKpqR5sLntxpD
         vl5P7suP5A/jX/WbdlAL+v7zDeN1JeuSYps8D7D6Beqf3VyYJrGCXNOHOUYLXtKJPN
         lGj5BnQpVh9DuE/c4zBuDNLub2DKH3IccPj8CzQMfSOSEe/NEVSNp+4h/sTPphs8JX
         /iUVvfIK14HHe4A/U8GxZzzHjBnpg1cuxyYGytJMYpkggFKudXin9FaEKZTFdMnELZ
         InQFpJ7+YeVgQ==
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org
Subject: [PATCH v2 09/92] btrfs: convert to simple_rename_timestamp
Date:   Wed,  5 Jul 2023 15:00:34 -0400
Message-ID: <20230705190309.579783-7-jlayton@kernel.org>
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

A rename potentially involves updating 4 different inode timestamps.
Convert to the new simple_rename_timestamp helper function.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/btrfs/inode.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 601fdc956484..521c08b8ad04 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8778,7 +8778,6 @@ static int btrfs_rename_exchange(struct inode *old_dir,
 	struct btrfs_root *dest = BTRFS_I(new_dir)->root;
 	struct inode *new_inode = new_dentry->d_inode;
 	struct inode *old_inode = old_dentry->d_inode;
-	struct timespec64 ctime = current_time(old_inode);
 	struct btrfs_rename_ctx old_rename_ctx;
 	struct btrfs_rename_ctx new_rename_ctx;
 	u64 old_ino = btrfs_ino(BTRFS_I(old_inode));
@@ -8909,12 +8908,7 @@ static int btrfs_rename_exchange(struct inode *old_dir,
 	inode_inc_iversion(new_dir);
 	inode_inc_iversion(old_inode);
 	inode_inc_iversion(new_inode);
-	old_dir->i_mtime = ctime;
-	old_dir->i_ctime = ctime;
-	new_dir->i_mtime = ctime;
-	new_dir->i_ctime = ctime;
-	old_inode->i_ctime = ctime;
-	new_inode->i_ctime = ctime;
+	simple_rename_timestamp(old_dir, old_dentry, new_dir, new_dentry);
 
 	if (old_dentry->d_parent != new_dentry->d_parent) {
 		btrfs_record_unlink_dir(trans, BTRFS_I(old_dir),
@@ -9178,11 +9172,7 @@ static int btrfs_rename(struct mnt_idmap *idmap,
 	inode_inc_iversion(old_dir);
 	inode_inc_iversion(new_dir);
 	inode_inc_iversion(old_inode);
-	old_dir->i_mtime = current_time(old_dir);
-	old_dir->i_ctime = old_dir->i_mtime;
-	new_dir->i_mtime = old_dir->i_mtime;
-	new_dir->i_ctime = old_dir->i_mtime;
-	old_inode->i_ctime = old_dir->i_mtime;
+	simple_rename_timestamp(old_dir, old_dentry, new_dir, new_dentry);
 
 	if (old_dentry->d_parent != new_dentry->d_parent)
 		btrfs_record_unlink_dir(trans, BTRFS_I(old_dir),
@@ -9204,7 +9194,6 @@ static int btrfs_rename(struct mnt_idmap *idmap,
 
 	if (new_inode) {
 		inode_inc_iversion(new_inode);
-		new_inode->i_ctime = current_time(new_inode);
 		if (unlikely(btrfs_ino(BTRFS_I(new_inode)) ==
 			     BTRFS_EMPTY_SUBVOL_DIR_OBJECTID)) {
 			ret = btrfs_unlink_subvol(trans, BTRFS_I(new_dir), new_dentry);
-- 
2.41.0

