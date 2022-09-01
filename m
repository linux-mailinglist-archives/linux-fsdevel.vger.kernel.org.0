Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74A9F5AA005
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Sep 2022 21:33:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234177AbiIATdP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Sep 2022 15:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234042AbiIATdO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Sep 2022 15:33:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D43A38982F;
        Thu,  1 Sep 2022 12:33:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 70ECA61DEF;
        Thu,  1 Sep 2022 19:33:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0971C433D6;
        Thu,  1 Sep 2022 19:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662060792;
        bh=Pl43GYt6Xsc/ANMGGsY4FRqWrbIBaTw6SVq8MHkVlFs=;
        h=From:To:Cc:Subject:Date:From;
        b=ZlWrYLUtM87oJ66958+byIVSwRs09ENVP/W42o9oocn7HaYiu/XKLb8X6wcrXrlVy
         nv/MTQpOkpOWC/2y6gyhxXTE3it53EuluzxehIX2libyt1KBRpauiHEAkBpwZawOvw
         vrCoZ2lwJQ5UJvD50/ysEQIxUsdYQRqrBitNcXv0dbb7NKmZnkAHTjsbxzdCX1AUdu
         ylgeC81ZRHuDK0HbZcFCPl4qIE9hpF8PVhOu2KI0qeSjrXgSnmh9a5YehgcLpvP4CZ
         /1rF0hYQ5b/e/ZhHFAzoss4RgKZM5vbyPh8+NBBVBrqUCrO7pJv6BVP/XeUlFihoUb
         j/GFuNHHOFbZg==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v4 0/3] fscrypt: rework keyring and stop using request_queue
Date:   Thu,  1 Sep 2022 12:32:05 -0700
Message-Id: <20220901193208.138056-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,SUSPICIOUS_RECIPS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Patch 1 of this series reworks the fscrypt filesystem-level keyring to
not use the keyrings subsystem as part of its internal implementation
(except for ->mk_users, which remains unchanged for now).  This fixes
several issues, described in the patch itself.  This is also a
prerequisite for eliminating the direct use of struct request_queue from
filesystem code, as discussed at
https://lore.kernel.org/linux-fscrypt/20220721125929.1866403-1-hch@lst.de/T/#u

Patches 2-3 eliminate the direct uses of struct request_queue from
fs/crypto/ that don't require block layer changes.  (The remaining uses
will be eliminated later by changing some of the blk-crypto functions.)

Changed in v4:
    - Restored a NULL check in fscrypt_destroy_inline_crypt_key() that
      I had accidentally dropped.
    - Tweaked patches 2 and 3 slightly so that patch 2 no longer makes
      as many changes that patch 3 then undoes.

Changed in v3:
    - Added patch "fscrypt: work on block_devices instead of request_queues"

Changed in v2:
    - Don't compare uninitialized bytes of struct fscrypt_key_specifier
    - Don't use refcount_dec_and_lock() unnecessarily
    - Other minor cleanups

Christoph Hellwig (1):
  fscrypt: work on block_devices instead of request_queues

Eric Biggers (2):
  fscrypt: stop using keyrings subsystem for fscrypt_master_key
  fscrypt: stop holding extra request_queue references

 fs/crypto/fscrypt_private.h |  74 ++++--
 fs/crypto/hooks.c           |  10 +-
 fs/crypto/inline_crypt.c    | 147 ++++++-----
 fs/crypto/keyring.c         | 495 +++++++++++++++++++-----------------
 fs/crypto/keysetup.c        |  89 +++----
 fs/crypto/keysetup_v1.c     |   4 +-
 fs/crypto/policy.c          |   8 +-
 fs/f2fs/super.c             |  24 +-
 fs/super.c                  |   2 +-
 include/linux/fs.h          |   2 +-
 include/linux/fscrypt.h     |  25 +-
 11 files changed, 462 insertions(+), 418 deletions(-)


base-commit: 1c23f9e627a7b412978b4e852793c5e3c3efc555
-- 
2.37.2

