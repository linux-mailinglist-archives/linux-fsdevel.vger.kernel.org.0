Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05B84530A36
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 May 2022 10:00:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbiEWHY3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 May 2022 03:24:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbiEWHYN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 May 2022 03:24:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D85083B003;
        Mon, 23 May 2022 00:18:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CE450611BC;
        Mon, 23 May 2022 07:07:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4775C385A9;
        Mon, 23 May 2022 07:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653289673;
        bh=hdwEg4ZhM324vxQXS0bV+GABy7LdsT+hi9juPKa4LYM=;
        h=Date:From:To:Cc:Subject:From;
        b=Hv1ZewV5rrt82CTBH3ka/CyAsOJFk2s7vSWR+pYA5dTCAr3bgcPvRT+ysVO4Y3wqm
         sPAznzO3uOWGDrxGeH0y34f2P0RwqZRPfuoriNxhfbmLFAioSzIRBPb9Ug//48eukM
         YgQvVSqHWznxnJONdWqSGk9Pza3YnxcTxOa5DX3ID5Ke2zHQq9Qha3RiFUCAqGoaI1
         w78SHOPmTRb2000Gbqj5LaM6h8oAsc5Drdl+k4+PfYj4vrVTMxJMM36NEmVRgEKuFu
         EpPlgFj+KX+U0lJOBbq/cbS4qPbzfD2PABa1IOY4GZ0Vvxf6k80y7GjEa2YIFj20iw
         wi6Xf9R1rsyrQ==
Date:   Mon, 23 May 2022 00:07:51 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [GIT PULL] fscrypt updates for 5.19
Message-ID: <Yosyx2FYZOIOWs9g@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The following changes since commit ce522ba9ef7e2d9fb22a39eb3371c0c64e2a433e:

  Linux 5.18-rc2 (2022-04-10 14:21:36 -1000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git tags/fscrypt-for-linus

for you to fetch changes up to 218d921b581eadf312c8ef0e09113b111f104eeb:

  fscrypt: add new helper functions for test_dummy_encryption (2022-05-09 16:18:54 -0700)

----------------------------------------------------------------

Some cleanups for fs/crypto/:

- Split up the misleadingly-named FS_CRYPTO_BLOCK_SIZE constant.

- Consistently report the encryption implementation that is being used.

- Add helper functions for the test_dummy_encryption mount option that
  work properly with the new mount API.  ext4 and f2fs will use these.

----------------------------------------------------------------
Eric Biggers (4):
      fscrypt: split up FS_CRYPTO_BLOCK_SIZE
      fscrypt: log when starting to use inline encryption
      fscrypt: factor out fscrypt_policy_to_key_spec()
      fscrypt: add new helper functions for test_dummy_encryption

 fs/crypto/crypto.c          |  10 ++--
 fs/crypto/fname.c           |  11 +++-
 fs/crypto/fscrypt_private.h |  10 +++-
 fs/crypto/inline_crypt.c    |  33 ++++++++++-
 fs/crypto/keyring.c         |  64 +++++++++++++++++----
 fs/crypto/keysetup.c        |  22 ++------
 fs/crypto/policy.c          | 132 ++++++++++++++++++++++++++------------------
 fs/ubifs/ubifs.h            |   2 +-
 include/linux/fscrypt.h     |  51 ++++++++++++++++-
 9 files changed, 238 insertions(+), 97 deletions(-)
