Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 309B55F27BD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Oct 2022 05:00:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbiJCDAJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 2 Oct 2022 23:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiJCDAI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 2 Oct 2022 23:00:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 680CA1D0F1;
        Sun,  2 Oct 2022 20:00:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D96F060F27;
        Mon,  3 Oct 2022 03:00:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D313FC433C1;
        Mon,  3 Oct 2022 03:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664766005;
        bh=JYBkVcaOXXe8vI72bVILJ80jmdMXI/PWcJhDdaOi1eo=;
        h=Date:From:To:Cc:Subject:From;
        b=Jf7WrTz0W2FFkAao26q5gpx54IiqqroOtfgzWpihbzU7Sq4Ta6O1quMFAwmrRyIJj
         7cjy6UwRwYaU/s4xNs06a8Bgoy0YgBC7oRpvR57AtYAhifsSmOisRXC/WDND8ahLCD
         DgF/CImCdGe0u7BATfHZ44SZOzj6V/J+Ot165m1K9dLdeIvWC2++wm8Vx+KkmP67UH
         Pchqhs/MIGYE6Uxe8C0KWfeXi5O/rQ7KUVYW4G5/kdo0ZI/SkDKNQVEoGdHb5D7eYt
         krVNBQc5Q5o6BNX9gOvyQzJUrQpps65LW/A1kUXqnk+Fo4wtwPN0u+aJFkjDXv2B2j
         Ccx4+R6MJsswA==
Date:   Sun, 2 Oct 2022 20:00:03 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: [GIT PULL] fscrypt updates for 6.1
Message-ID: <YzpQMx1FiZp/PsM3@quark>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The following changes since commit 1c23f9e627a7b412978b4e852793c5e3c3efc555:

  Linux 6.0-rc2 (2022-08-21 17:32:54 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git tags/fscrypt-for-linus

for you to fetch changes up to 0e91fc1e0f5c70ce575451103ec66c2ec21f1a6e:

  fscrypt: work on block_devices instead of request_queues (2022-09-21 20:33:06 -0700)

----------------------------------------------------------------

This release contains some implementation changes, but no new features:

- Rework the implementation of the fscrypt filesystem-level keyring to
  not be as tightly coupled to the keyrings subsystem.  This resolves
  several issues.

- Eliminate most direct uses of struct request_queue from fs/crypto/,
  since struct request_queue is considered to be a block layer
  implementation detail.

- Stop using the PG_error flag to track decryption failures.  This is a
  prerequisite for freeing up PG_error for other uses.

----------------------------------------------------------------
Christoph Hellwig (1):
      fscrypt: work on block_devices instead of request_queues

Eric Biggers (4):
      fscrypt: remove fscrypt_set_test_dummy_encryption()
      fscrypt: stop using PG_error to track error status
      fscrypt: stop using keyrings subsystem for fscrypt_master_key
      fscrypt: stop holding extra request_queue references

 fs/crypto/bio.c             |  16 +-
 fs/crypto/fscrypt_private.h |  82 +++++---
 fs/crypto/hooks.c           |  10 +-
 fs/crypto/inline_crypt.c    | 147 +++++++------
 fs/crypto/keyring.c         | 495 ++++++++++++++++++++++++--------------------
 fs/crypto/keysetup.c        |  89 ++++----
 fs/crypto/keysetup_v1.c     |   4 +-
 fs/crypto/policy.c          |  21 +-
 fs/ext4/readpage.c          |  10 +-
 fs/f2fs/data.c              |  18 +-
 fs/f2fs/super.c             |  24 +--
 fs/super.c                  |   2 +-
 include/linux/fs.h          |   2 +-
 include/linux/fscrypt.h     |  32 ++-
 14 files changed, 495 insertions(+), 457 deletions(-)
