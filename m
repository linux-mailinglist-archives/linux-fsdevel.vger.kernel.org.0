Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A192E611DA7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Oct 2022 00:48:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbiJ1Wrx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Oct 2022 18:47:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbiJ1Wrt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Oct 2022 18:47:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CD231E1975;
        Fri, 28 Oct 2022 15:47:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CD66A62ACA;
        Fri, 28 Oct 2022 22:47:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 172DFC43140;
        Fri, 28 Oct 2022 22:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666997267;
        bh=TLSDtgBK8VwfTvMigEag46MpMj/1E/6Gz70hTRHuF58=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nL7PsiwDTtGmgJRb1Ml4ZRkAUzl+Hn3bfm/T0QY0nf+V+2s6Lx9cwZRmeec8RdnnT
         zwd9cZifwQnY0jQBYPGOoJHmnWUnRfYM/nr+n56j5/lB3wpWBX+o/1Taw+KkU9c+Ae
         MFdnQQBtHyumLYjJl/7OltHD/Cmg5KDUk4pvinxrIgG1dTwRVti2uT5mS1wsOH8/co
         f4is+iamKC+Lg6cGTQYgM52bmWLhNBlJza7rslc/b6yY45Yh8KV8fXTMk4j/+aiYCA
         uUKGlXNMteCmwTJijTox6n6z8DHJQymzTS6D/zt2pucmwZZ8GgV1NtTy+RamhQoJ2X
         91SGzr7N3zDHQ==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-btrfs@vger.kernel.org
Subject: [PATCH 6/6] ext4: allow verity with fs block size < PAGE_SIZE
Date:   Fri, 28 Oct 2022 15:45:39 -0700
Message-Id: <20221028224539.171818-7-ebiggers@kernel.org>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221028224539.171818-1-ebiggers@kernel.org>
References: <20221028224539.171818-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,SUSPICIOUS_RECIPS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Now that the needed changes have been made to fs/buffer.c, ext4 is ready
to support the verity feature when the filesystem block size is less
than the page size.  So remove the mount-time check that prevented this.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 Documentation/filesystems/fsverity.rst | 8 +++++---
 fs/ext4/super.c                        | 5 -----
 2 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/Documentation/filesystems/fsverity.rst b/Documentation/filesystems/fsverity.rst
index 4c202e0dee102..46c344eb41635 100644
--- a/Documentation/filesystems/fsverity.rst
+++ b/Documentation/filesystems/fsverity.rst
@@ -497,9 +497,11 @@ To create verity files on an ext4 filesystem, the filesystem must have
 been formatted with ``-O verity`` or had ``tune2fs -O verity`` run on
 it.  "verity" is an RO_COMPAT filesystem feature, so once set, old
 kernels will only be able to mount the filesystem readonly, and old
-versions of e2fsck will be unable to check the filesystem.  Moreover,
-currently ext4 only supports mounting a filesystem with the "verity"
-feature when its block size is equal to PAGE_SIZE (often 4096 bytes).
+versions of e2fsck will be unable to check the filesystem.
+
+Originally, an ext4 filesystem with the "verity" feature could only be
+mounted when its block size was equal to the system page size
+(typically 4096 bytes).  In Linux v6.2, this limitation was removed.
 
 ext4 sets the EXT4_VERITY_FL on-disk inode flag on verity files.  It
 can only be set by `FS_IOC_ENABLE_VERITY`_, and it cannot be cleared.
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 989365b878a67..3e6037a744585 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -5339,11 +5339,6 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 		}
 	}
 
-	if (ext4_has_feature_verity(sb) && sb->s_blocksize != PAGE_SIZE) {
-		ext4_msg(sb, KERN_ERR, "Unsupported blocksize for fs-verity");
-		goto failed_mount_wq;
-	}
-
 	/*
 	 * Get the # of file system overhead blocks from the
 	 * superblock if present.
-- 
2.38.0

