Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F3D5655452
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Dec 2022 21:37:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231584AbiLWUhG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Dec 2022 15:37:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232915AbiLWUg7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Dec 2022 15:36:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27B2D1DA51;
        Fri, 23 Dec 2022 12:36:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B8E7E61EF5;
        Fri, 23 Dec 2022 20:36:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 529BEC433F0;
        Fri, 23 Dec 2022 20:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671827817;
        bh=hUMxvtChJHIBiEf3QPm8r6dGOW77G56OuiC6WrUXTPs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oyXzMNc4twgXBPEgKTMYdpGLLF0S+W/JjUp0sjBRFNQ3R4P31+mrvxJ1ZdzEO/JJc
         2yKvKtQA9ldermdyYk7cM+zj2pjKPm0I75L/OXvjsuQE/OAGY837S/3OT0He6mjGqY
         3j3T4wKkte1o51XsKB+PHC1Izsf/oUC1bfVwiOg4gw7gjU0B9svWzFhfkBbDrPocAD
         1XMwZ/QDk5X9Rg0lKgwPpLFxyvZngASNHLl8b9jIRzfvRwbLUsillkGJn73NxFi93d
         fVFDCv4mQrgG9lGb015HN3LMPQmH2Ovw7RAizFoP6ZmdtiGTgHwaPIU7gmKvmC/rH7
         WO6RF5z584vmA==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-btrfs@vger.kernel.org, linux-xfs@vger.kernel.org,
        Andrey Albershteyn <aalbersh@redhat.com>
Subject: [PATCH v2 04/11] fsverity: use EFBIG for file too large to enable verity
Date:   Fri, 23 Dec 2022 12:36:31 -0800
Message-Id: <20221223203638.41293-5-ebiggers@kernel.org>
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

Currently, there is an implementation limit where files can't have more
than 8 Merkle tree levels.  With SHA-256 and 4K blocks, this limit is
never reached, since a file would need to be larger than 2**64 bytes to
need 9 levels.  However, with SHA-512, 9 levels are needed for files
larger than about 1.15 EB, which is possible on btrfs.  Therefore, this
limit technically became reachable when btrfs added fsverity support.

Meanwhile, support for merkle_tree_block_size < PAGE_SIZE will introduce
another implementation limit on file size, resulting from the use of an
in-memory bitmap to track which Merkle tree blocks have been verified.

In any case, currently FS_IOC_ENABLE_VERITY fails with EINVAL when the
file is too large.  This is undocumented, and also ambiguous since
EINVAL can mean other things too.  Let's change the error code to EFBIG,
which is much clearer, and document it.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 Documentation/filesystems/fsverity.rst | 1 +
 fs/verity/open.c                       | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/filesystems/fsverity.rst b/Documentation/filesystems/fsverity.rst
index cb8e7573882a1..66cdca30ff58b 100644
--- a/Documentation/filesystems/fsverity.rst
+++ b/Documentation/filesystems/fsverity.rst
@@ -161,6 +161,7 @@ FS_IOC_ENABLE_VERITY can fail with the following errors:
 - ``EBUSY``: this ioctl is already running on the file
 - ``EEXIST``: the file already has verity enabled
 - ``EFAULT``: the caller provided inaccessible memory
+- ``EFBIG``: the file is too large to enable verity on
 - ``EINTR``: the operation was interrupted by a fatal signal
 - ``EINVAL``: unsupported version, hash algorithm, or block size; or
   reserved bits are set; or the file descriptor refers to neither a
diff --git a/fs/verity/open.c b/fs/verity/open.c
index ca8de73e5a0b8..09512daa22db5 100644
--- a/fs/verity/open.c
+++ b/fs/verity/open.c
@@ -92,7 +92,7 @@ int fsverity_init_merkle_tree_params(struct merkle_tree_params *params,
 	while (blocks > 1) {
 		if (params->num_levels >= FS_VERITY_MAX_LEVELS) {
 			fsverity_err(inode, "Too many levels in Merkle tree");
-			err = -EINVAL;
+			err = -EFBIG;
 			goto out_err;
 		}
 		blocks = (blocks + params->hashes_per_block - 1) >>
-- 
2.39.0

