Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9E7B68E824
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Feb 2023 07:21:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbjBHGVj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Feb 2023 01:21:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjBHGVi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Feb 2023 01:21:38 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8265F40BFB;
        Tue,  7 Feb 2023 22:21:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 297F7B81AB4;
        Wed,  8 Feb 2023 06:21:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D596C433EF;
        Wed,  8 Feb 2023 06:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675837294;
        bh=5/jCW9hCuDP1bPRnmDpSkCHU7uopSOqd4DhFBilNJRU=;
        h=From:To:Cc:Subject:Date:From;
        b=I8/gHZ3fzWa+jyUy6KyNSxroGCmJEfpCWfi01Wrqimo7Oqt3gpGOv01fKFG6/kLoJ
         1Rnd09J0j1RgQK9Le3OI12MScPZM4cbR3ftqtHaEfDcMkLvKaQMul+jEP0FH2INKn+
         58jvH9LKmqZ6J9YGH8BoYV+Y+h4mRNbPvf+UiMnBgotr85EPqODtNnXa4p8uCK8Fwy
         VkX8XeauE4V1sE8uVb15qARkYw7T84Se2mRDCv3hlgFDM6Jy1pdSW3ynrEPoZ3eWuw
         v3dMHo+r18cyKs9JCn04GN4PGAYMDiH4PzDGWz8aacPgzoNjtfGNYtcLTT+/t6ZhBX
         7isGFDAXEfaRg==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 0/5] Add the test_dummy_encryption key on-demand
Date:   Tue,  7 Feb 2023 22:21:02 -0800
Message-Id: <20230208062107.199831-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.39.1
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

This series eliminates the call to fscrypt_destroy_keyring() from
__put_super(), which is causing confusion because it looks like (but
actually isn't) a sleep-in-atomic bug.  See the thread "block: sleeping
in atomic warnings", i.e.
https://lore.kernel.org/linux-fsdevel/CAHk-=wg6ohuyrmLJYTfEpDbp2Jwnef54gkcpZ3-BYgy4C6UxRQ@mail.gmail.com
and its responses.

To do this, this series makes it so that the key associated with the
"test_dummy_encryption" mount option is added on-demand when files are
accessed, instead of immediately when the filesystem is mounted.

I was going back and forth between this solution and instead having ext4
and f2fs call fscrypt_destroy_keyring() on ->fill_super failure.  (Or
using Linus's suggestion of adding the test dummy key as the very last
step of ->fill_super.)  It does seem ideal to add the key at mount time,
but I ended up going with this solution instead because it reduces the
number of things the individual filesystems have to handle.

Eric Biggers (5):
  fscrypt: add the test dummy encryption key on-demand
  ext4: stop calling fscrypt_add_test_dummy_key()
  f2fs: stop calling fscrypt_add_test_dummy_key()
  fs/super.c: stop calling fscrypt_destroy_keyring() from __put_super()
  fscrypt: clean up fscrypt_add_test_dummy_key()

 fs/crypto/fscrypt_private.h |  4 ++++
 fs/crypto/keyring.c         | 26 +++++++-------------------
 fs/crypto/keysetup.c        | 23 +++++++++++++++++++++--
 fs/crypto/policy.c          |  3 +--
 fs/ext4/super.c             | 13 +------------
 fs/f2fs/super.c             |  6 ------
 fs/super.c                  |  1 -
 include/linux/fscrypt.h     |  9 ---------
 8 files changed, 34 insertions(+), 51 deletions(-)


base-commit: 6d796c50f84ca79f1722bb131799e5a5710c4700
-- 
2.39.1

