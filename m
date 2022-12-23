Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A950765546D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Dec 2022 21:37:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233631AbiLWUhR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Dec 2022 15:37:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232428AbiLWUhB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Dec 2022 15:37:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4723F1DA66;
        Fri, 23 Dec 2022 12:37:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D720461F25;
        Fri, 23 Dec 2022 20:37:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11D60C433D2;
        Fri, 23 Dec 2022 20:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671827820;
        bh=qLoSGFi2QkFfE5PAtk38FT/yWSIKsO+TzvgyJfycJFQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XQdKCLLelfI4SoxzCMAnCUtgdS+h9/wA0ND1Sx878oRw5ipn2eXs8emLgIEWu7IIf
         JBsFNvEu/j58OSutvkMWLShj6wyhrUy37JNS2DnPwotL4+tmwysUERhVyhSs7ei+h9
         NKtBVyxLlMbc7C4ITMY+Kw7pVpPh7GXAnZFYIueqVWBYPwPpAXrpLLXbi8ujGYPUD5
         QFlSPCJd9Yuo0zOm5Dldc8Jq66Lwkia/3lxTXrKYU+xSn7wVnfBP2VDx3inq3A52bz
         ChvrTaw6ccDIJgTioKbE631T7CAD6ukJcDD2rq+lINmp6BCvnCVN2Uz2bCbYl+fKG8
         rgFvJqVI6oY7w==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-btrfs@vger.kernel.org, linux-xfs@vger.kernel.org,
        Andrey Albershteyn <aalbersh@redhat.com>
Subject: [PATCH v2 11/11] ext4: allow verity with fs block size < PAGE_SIZE
Date:   Fri, 23 Dec 2022 12:36:38 -0800
Message-Id: <20221223203638.41293-12-ebiggers@kernel.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221223203638.41293-1-ebiggers@kernel.org>
References: <20221223203638.41293-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
index 948d202545240..c0c8a25b41bb8 100644
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
+(typically 4096 bytes).  In Linux v6.3, this limitation was removed.
 
 ext4 sets the EXT4_VERITY_FL on-disk inode flag on verity files.  It
 can only be set by `FS_IOC_ENABLE_VERITY`_, and it cannot be cleared.
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 16a343e8047d4..798cb19e2258b 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -5336,11 +5336,6 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
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
2.39.0

