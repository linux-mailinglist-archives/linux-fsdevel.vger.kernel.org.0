Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5452B68E839
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Feb 2023 07:22:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbjBHGWK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Feb 2023 01:22:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjBHGWI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Feb 2023 01:22:08 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79A5559E5;
        Tue,  7 Feb 2023 22:22:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 11F3061470;
        Wed,  8 Feb 2023 06:22:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46C26C4339B;
        Wed,  8 Feb 2023 06:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675837295;
        bh=kfr98bGzVCZ89v5RF0C39SP0fCvbpfqJYzf6QFQbhlc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vNp1UKHXj/Iwfo2wnOJu9HISJGFDp8Ak2VghNEydsMfUfm14hT+A1VvSuRDmI4/LA
         LqQ9bHnJnch8CTDA7s2xPU6WlgwbiMVvZMkX+2NytMXtsPa7nOAREhPr+2TwKTDNr1
         +U6RBTgwmam283E1xcZPMK8gMOHQOJjTUEYUoux7Y8DW+HVKvc2xqnri4n4kHiBInS
         UpuhbJObRfKNnaexU7Deca24KaeQf3c7O8szvMDNcM1A0r5+aw1hUTeXLwkmjs/h1l
         /ym4oDpYxxXjQQ9VqyNRpsPX1S1er6TsJ401l5ReYKH9DPPDcmzsimS7idcPDQDvjj
         IegFclMH9Bm8w==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 2/5] ext4: stop calling fscrypt_add_test_dummy_key()
Date:   Tue,  7 Feb 2023 22:21:04 -0800
Message-Id: <20230208062107.199831-3-ebiggers@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230208062107.199831-1-ebiggers@kernel.org>
References: <20230208062107.199831-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,SUSPICIOUS_RECIPS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Now that fs/crypto/ adds the test dummy encryption key on-demand when
it's needed, there's no need for individual filesystems to call
fscrypt_add_test_dummy_key().  Remove the call to it from ext4.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/ext4/super.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 260c1b3e3ef2c..260bbab25db38 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -2635,7 +2635,6 @@ static int ext4_check_test_dummy_encryption(const struct fs_context *fc,
 {
 	const struct ext4_fs_context *ctx = fc->fs_private;
 	const struct ext4_sb_info *sbi = EXT4_SB(sb);
-	int err;
 
 	if (!fscrypt_is_dummy_policy_set(&ctx->dummy_enc_policy))
 		return 0;
@@ -2668,17 +2667,7 @@ static int ext4_check_test_dummy_encryption(const struct fs_context *fc,
 			 "Conflicting test_dummy_encryption options");
 		return -EINVAL;
 	}
-	/*
-	 * fscrypt_add_test_dummy_key() technically changes the super_block, so
-	 * technically it should be delayed until ext4_apply_options() like the
-	 * other changes.  But since we never get here for remounts (see above),
-	 * and this is the last chance to report errors, we do it here.
-	 */
-	err = fscrypt_add_test_dummy_key(sb, &ctx->dummy_enc_policy);
-	if (err)
-		ext4_msg(NULL, KERN_WARNING,
-			 "Error adding test dummy encryption key [%d]", err);
-	return err;
+	return 0;
 }
 
 static void ext4_apply_test_dummy_encryption(struct ext4_fs_context *ctx,
-- 
2.39.1

