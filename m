Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B82D0748D12
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jul 2023 21:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233798AbjGETG3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jul 2023 15:06:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233372AbjGETFk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jul 2023 15:05:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE80E198E;
        Wed,  5 Jul 2023 12:04:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DA4D9616EE;
        Wed,  5 Jul 2023 19:04:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 847C8C433C8;
        Wed,  5 Jul 2023 19:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688583847;
        bh=Quk2EFrPq5vmfbKVzBbf5WGVzDjIaHl3AZ/HhYZtAs4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CnOQJEmx1tn4tJvxJ+WakjK4eFv5cuangho52AJ5dDXyahBF1yE+GGMP0bN9GD0TY
         neLYHX58Y7GTijY9fR27/Fe0OITplMow1xNOkAtTiTcxGVYiDJ+WOewKAET4QgUZzF
         CBjt8HwANSkamwTDF1eCsLsdoaiZhoXm6gsg2EchyzZqXao5rfeWA0nKMAtznp6aR+
         8bC7aGmzJgMAHnzGgQV1Lvx+iZBxNCNC507pbyV2uEC4hSqVFBWhrOMsaSiVcCeONi
         oQWjX0azc0u6/t2HWBsIweHk3TJL/u8HVwka/7guxYNn/ymjiJr/zvqA9k1s5QS8Vn
         Kn7ljESIHHRLQ==
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>,
        Jeremy Kerr <jk@ozlabs.org>, Ard Biesheuvel <ardb@kernel.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org
Subject: [PATCH v2 37/92] efivarfs: convert to ctime accessor functions
Date:   Wed,  5 Jul 2023 15:01:02 -0400
Message-ID: <20230705190309.579783-35-jlayton@kernel.org>
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

In later patches, we're going to change how the inode's ctime field is
used. Switch to using accessor functions instead of raw accesses of
inode->i_ctime.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/efivarfs/file.c  | 2 +-
 fs/efivarfs/inode.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/efivarfs/file.c b/fs/efivarfs/file.c
index 375576111dc3..59b52718a3a2 100644
--- a/fs/efivarfs/file.c
+++ b/fs/efivarfs/file.c
@@ -51,7 +51,7 @@ static ssize_t efivarfs_file_write(struct file *file,
 	} else {
 		inode_lock(inode);
 		i_size_write(inode, datasize + sizeof(attributes));
-		inode->i_mtime = inode->i_ctime = current_time(inode);
+		inode->i_mtime = inode_set_ctime_current(inode);
 		inode_unlock(inode);
 	}
 
diff --git a/fs/efivarfs/inode.c b/fs/efivarfs/inode.c
index b973a2c03dde..db9231f0e77b 100644
--- a/fs/efivarfs/inode.c
+++ b/fs/efivarfs/inode.c
@@ -25,7 +25,7 @@ struct inode *efivarfs_get_inode(struct super_block *sb,
 	if (inode) {
 		inode->i_ino = get_next_ino();
 		inode->i_mode = mode;
-		inode->i_atime = inode->i_mtime = inode->i_ctime = current_time(inode);
+		inode->i_atime = inode->i_mtime = inode_set_ctime_current(inode);
 		inode->i_flags = is_removable ? 0 : S_IMMUTABLE;
 		switch (mode & S_IFMT) {
 		case S_IFREG:
-- 
2.41.0

