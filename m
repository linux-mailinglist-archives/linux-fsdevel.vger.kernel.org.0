Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 374AF68E830
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Feb 2023 07:21:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbjBHGVp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Feb 2023 01:21:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbjBHGVj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Feb 2023 01:21:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 580D341B78;
        Tue,  7 Feb 2023 22:21:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1703AB81C14;
        Wed,  8 Feb 2023 06:21:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 962A8C4339E;
        Wed,  8 Feb 2023 06:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675837295;
        bh=sQVJxIPMagQOo1HvXPpx7fyeR0XGhmDecu3YxyPB1CY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DbGtwnF4VnuwU4on1O7/cEfWfHUtx13gh7P3p8mGefvuSnr1Ike5IbZgNRonYmLak
         TlZiwaey1dosbaeUDX+gS6i63mlXqU+UUnqw3ObBCq5amvYOD+PdMoBuEbDHpWdTeE
         7Tf+IAkd9SNsWzJrexAGucM8cE6kuRJGukl+uiN49e23GgXqvpHO04TJjfHzI9VhdH
         dPlxSQ6u82GVy9gg6YzNeoUC8+osvpsuBem37izs+Vr7b9l0T48EplZNtLsVCjt7lB
         lBZpV3e3rS9HUxDLQYLa0e6DwSGUDLlMXwL7Bb8UZoX4o17JL+rQDuXZ73F7xtKhQq
         B0+C/uOTOfAog==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 3/5] f2fs: stop calling fscrypt_add_test_dummy_key()
Date:   Tue,  7 Feb 2023 22:21:05 -0800
Message-Id: <20230208062107.199831-4-ebiggers@kernel.org>
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
fscrypt_add_test_dummy_key().  Remove the call to it from f2fs.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/f2fs/super.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 1f812b9ce985b..64d3556d61a55 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -540,12 +540,6 @@ static int f2fs_set_test_dummy_encryption(struct super_block *sb,
 				  opt, err);
 		return -EINVAL;
 	}
-	err = fscrypt_add_test_dummy_key(sb, policy);
-	if (err) {
-		f2fs_warn(sbi, "Error adding test dummy encryption key [%d]",
-			  err);
-		return err;
-	}
 	f2fs_warn(sbi, "Test dummy encryption mode enabled");
 	return 0;
 }
-- 
2.39.1

