Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB806EDB97
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Apr 2023 08:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233401AbjDYGY7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Apr 2023 02:24:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232430AbjDYGY6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Apr 2023 02:24:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12577B453;
        Mon, 24 Apr 2023 23:24:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A186462266;
        Tue, 25 Apr 2023 06:24:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0C10C433EF;
        Tue, 25 Apr 2023 06:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682403893;
        bh=Mi+ZKZMKXNwM0BSVBqcBzXImZhMGe19r2+9wf6AKP00=;
        h=Date:From:To:Cc:Subject:From;
        b=qd2YARxdhCnp9zDPfkwAGEymJRl22vpunNo7D6Kf94aHzlXEpuO/4SdSqZG5QocUE
         zICDdZyivpfrjT+bffR2bdluSh0nNof8xll2IDnACD8iFk729k9ehWHZxa8ioMbNCS
         UalK0uZzNzc7SpK7FyIaPXlXv0yb9nAwVbn9mcvcc6zXf6u/ieEpH7X4q3nCpy4N3Q
         qwxtd66nDEN8HBjvkcbNiYc/rWsLaNQ5oVz4mM5Q7h2KPOirEKUN7S/BiCj/3sSpmH
         ahP1Zl5I8NR4FQ0rYzSZ7YbNntPm18d1w9r7FTck3rMg+Al5j0f4HKOL8DR3Vr2uI8
         ykujtVvntBHcg==
Date:   Mon, 24 Apr 2023 23:24:51 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [GIT PULL] fscrypt updates for 6.4
Message-ID: <20230425062451.GA77408@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The following changes since commit 197b6b60ae7bc51dd0814953c562833143b292aa:

  Linux 6.3-rc4 (2023-03-26 14:40:20 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/fs/fscrypt/linux.git tags/fscrypt-for-linus

for you to fetch changes up to 83e57e47906ce0e99bd61c70fae514e69960d274:

  fscrypt: optimize fscrypt_initialize() (2023-04-06 11:16:39 -0700)

----------------------------------------------------------------

A few cleanups for fs/crypto/, and another patch to prepare for the
upcoming CephFS encryption support.

----------------------------------------------------------------
Eric Biggers (3):
      fs/buffer.c: use b_folio for fscrypt work
      fscrypt: use WARN_ON_ONCE instead of WARN_ON
      fscrypt: optimize fscrypt_initialize()

Luís Henriques (1):
      fscrypt: new helper function - fscrypt_prepare_lookup_partial()

 fs/buffer.c                 |  4 ++--
 fs/crypto/bio.c             |  6 +++---
 fs/crypto/crypto.c          | 19 ++++++++++++-------
 fs/crypto/fname.c           |  4 ++--
 fs/crypto/fscrypt_private.h |  6 +++---
 fs/crypto/hkdf.c            |  4 ++--
 fs/crypto/hooks.c           | 32 +++++++++++++++++++++++++++++++-
 fs/crypto/keyring.c         | 14 +++++++-------
 fs/crypto/keysetup.c        | 14 +++++++-------
 fs/crypto/policy.c          |  4 ++--
 include/linux/fscrypt.h     |  7 +++++++
 11 files changed, 78 insertions(+), 36 deletions(-)
