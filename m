Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C21E87B8C10
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Oct 2023 20:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244631AbjJDSzU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Oct 2023 14:55:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244739AbjJDSyp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Oct 2023 14:54:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F581BF1;
        Wed,  4 Oct 2023 11:54:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1C9FC433C9;
        Wed,  4 Oct 2023 18:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696445660;
        bh=YEqq5TbDW6Icj/FoFvAK1JpXcDhyI6Wo7wQqM+3TX2I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Bd8rjo0AWU8SX0B55IRMQTx0py0nMGADHJYF2r+l4nDxPRDpG5g0f8XP3zHEyuoab
         n/eE5y6XuC1klvpu1n3fY/4V1G3AY0UQOMxq7omLXgA83THjM/UYPYRGjGR4mHGjDt
         uaSp1Yj8pc0m5k1CT5f6QGqvqVbxGVDWemc1h6999KeoJHsR1DFO4DynyNTXdH6tb6
         PTTqYbZjgILcdVZf38aontmXCApzH12RxMdrrrIwy7e2ASWltaS4woF2s/zN2CgmD0
         /MxfjScR6BaDGVLUvX0iDdZGZ6xcLgYPC8WDszhsu7gGKDYZ2xP238NVZrI4efHpGg
         4Veq+mfxnz/Kg==
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linux-efi@vger.kernel.org
Subject: [PATCH v2 30/89] efivarfs: convert to new timestamp accessors
Date:   Wed,  4 Oct 2023 14:52:15 -0400
Message-ID: <20231004185347.80880-28-jlayton@kernel.org>
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
 fs/efivarfs/file.c  | 2 +-
 fs/efivarfs/inode.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/efivarfs/file.c b/fs/efivarfs/file.c
index 59b52718a3a2..7e9961639802 100644
--- a/fs/efivarfs/file.c
+++ b/fs/efivarfs/file.c
@@ -51,7 +51,7 @@ static ssize_t efivarfs_file_write(struct file *file,
 	} else {
 		inode_lock(inode);
 		i_size_write(inode, datasize + sizeof(attributes));
-		inode->i_mtime = inode_set_ctime_current(inode);
+		inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
 		inode_unlock(inode);
 	}
 
diff --git a/fs/efivarfs/inode.c b/fs/efivarfs/inode.c
index db9231f0e77b..76dd3c7295d9 100644
--- a/fs/efivarfs/inode.c
+++ b/fs/efivarfs/inode.c
@@ -25,7 +25,7 @@ struct inode *efivarfs_get_inode(struct super_block *sb,
 	if (inode) {
 		inode->i_ino = get_next_ino();
 		inode->i_mode = mode;
-		inode->i_atime = inode->i_mtime = inode_set_ctime_current(inode);
+		simple_inode_init_ts(inode);
 		inode->i_flags = is_removable ? 0 : S_IMMUTABLE;
 		switch (mode & S_IFMT) {
 		case S_IFREG:
-- 
2.41.0

