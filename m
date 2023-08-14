Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E227077BFD6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Aug 2023 20:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231489AbjHNS3s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Aug 2023 14:29:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231667AbjHNS3i (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Aug 2023 14:29:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAA62B0;
        Mon, 14 Aug 2023 11:29:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3F17E65087;
        Mon, 14 Aug 2023 18:29:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76E89C433C9;
        Mon, 14 Aug 2023 18:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692037776;
        bh=54AzBJPDSBowvAHeFULqDhusG5VK0CfhD6wbQR4h6H4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e6rJHIFKhproYAmLhuYPDBbc5nzyCpv9IcUSKJu0kxa/OHMVAgqKO0HWMccoUpXpN
         axXETeuc8RhcWiz1X2llfkhH/nmVJuvMJznEn7wJxaXRKwTTe40LCVD7wYxTKBlXUj
         mAmYHkmNelqqA70ITo1Ec4//Zg/FqZDagJPjTH4ME6LO615eQAk5Hlx9qTKZCF7WG/
         03fS/e0G7XM+4gfoJQXakB8Iusv0dbAmUw3wbm7z7sQdNmrpbjTxe6hs3f8E1uAl01
         vN5t0+mzk8/B2Bryfneta+q7gT+8TMJ6gKTmiKdsb1CSUpskiW2KaWQONZn/OTxPa2
         Df7klZ3FbMZfw==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>
Cc:     linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        Gabriel Krisman Bertazi <krisman@suse.de>
Subject: [PATCH 1/3] ext4: reject casefold inode flag without casefold feature
Date:   Mon, 14 Aug 2023 11:29:01 -0700
Message-ID: <20230814182903.37267-2-ebiggers@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230814182903.37267-1-ebiggers@kernel.org>
References: <20230814182903.37267-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

It is invalid for the casefold inode flag to be set without the casefold
superblock feature flag also being set.  e2fsck already considers this
case to be invalid and handles it by offering to clear the casefold flag
on the inode.  __ext4_iget() also already considered this to be invalid,
sort of, but it only got so far as logging an error message; it didn't
actually reject the inode.  Make it reject the inode so that other code
doesn't have to handle this case.  This matches what f2fs does.

Note: we could check 's_encoding != NULL' instead of
ext4_has_feature_casefold().  This would make the check robust against
the casefold feature being enabled by userspace writing to the page
cache of the mounted block device.  However, it's unsolvable in general
for filesystems to be robust against concurrent writes to the page cache
of the mounted block device.  Though this very particular scenario
involving the casefold feature is solvable, we should not pretend that
we can support this model, so let's just check the casefold feature.
tune2fs already forbids enabling casefold on a mounted filesystem.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/ext4/inode.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 43775a6ca505..390dedbb7e8a 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -4940,9 +4940,12 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
 				 "iget: bogus i_mode (%o)", inode->i_mode);
 		goto bad_inode;
 	}
-	if (IS_CASEFOLDED(inode) && !ext4_has_feature_casefold(inode->i_sb))
+	if (IS_CASEFOLDED(inode) && !ext4_has_feature_casefold(inode->i_sb)) {
 		ext4_error_inode(inode, function, line, 0,
 				 "casefold flag without casefold feature");
+		ret = -EFSCORRUPTED;
+		goto bad_inode;
+	}
 	if ((err_str = check_igot_inode(inode, flags)) != NULL) {
 		ext4_error_inode(inode, function, line, 0, err_str);
 		ret = -EFSCORRUPTED;
-- 
2.41.0

