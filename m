Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68EC82D92FC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Dec 2020 06:52:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389731AbgLNFvG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Dec 2020 00:51:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:35748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388095AbgLNFvC (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Dec 2020 00:51:02 -0500
Date:   Sun, 13 Dec 2020 21:50:19 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607925021;
        bh=26wjFmCwOjxbjwCPVnXE7SyqfSynEV7b+ddO/h17k4I=;
        h=From:To:Cc:Subject:From;
        b=n/muPa2CduuxaSl+0TEAyvxRjflWJBxicz+gMGJDNpvNXQogxADu7X/WVccGdAlqi
         xZmuIv3FwteKOr+Qlv5ddaktdmXQSJIeBxTQzP16O7fUFoPzMSDKpKdMu63zQ/rf4L
         nkHx5mxptVdfc2WBUpiRT71HanPgKK5fmug5mHDGtTbGZJ04bJI4hhRlBraAVBb4nv
         2cZYgMGX+sIph52A0SHSdKjUYTKcBWNBX29/dwftRvi2vV6JlukFQMNZnsxn+m7tOy
         ADB2dQgI4vwseN0mcDjFLUWzBh0NPkgsiv/xrwLG41ZNV1WkrtMPXaL3OR1Cb1vFdS
         nTBmup/vMTS6A==
From:   Eric Biggers <ebiggers@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [GIT PULL] fscrypt updates for 5.11
Message-ID: <X9b9G8p8AiRAzDwV@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The following changes since commit 09162bc32c880a791c6c0668ce0745cf7958f576:

  Linux 5.10-rc4 (2020-11-15 16:44:31 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git tags/fscrypt-for-linus

for you to fetch changes up to a14d0b6764917b21ee6fdfd2a8a4c2920fbefcce:

  fscrypt: allow deleting files with unsupported encryption policy (2020-12-02 18:25:01 -0800)

----------------------------------------------------------------

This release there are some fixes for longstanding problems, as well as
some cleanups:

- Fix a race condition where a duplicate filename could be created in an
  encrypted directory if a syscall that creates a new filename raced
  with the directory's encryption key being added.

- Allow deleting files that use an unsupported encryption policy.

- Simplify the locking for 'struct fscrypt_master_key'.

- Remove kernel-internal constants from the UAPI header.

As usual, all these patches have been in linux-next with no reported
issues, and I've tested them with xfstests.

----------------------------------------------------------------
Eric Biggers (16):
      fscrypt: remove kernel-internal constants from UAPI header
      fscrypt: add fscrypt_is_nokey_name()
      ext4: prevent creating duplicate encrypted filenames
      f2fs: prevent creating duplicate encrypted filenames
      ubifs: prevent creating duplicate encrypted filenames
      fscrypt: remove unnecessary calls to fscrypt_require_key()
      fscrypt: simplify master key locking
      ext4: remove ext4_dir_open()
      f2fs: remove f2fs_dir_open()
      ubifs: remove ubifs_dir_open()
      ext4: don't call fscrypt_get_encryption_info() from dx_show_leaf()
      fscrypt: introduce fscrypt_prepare_readdir()
      fscrypt: move body of fscrypt_prepare_setattr() out-of-line
      fscrypt: move fscrypt_require_key() to fscrypt_private.h
      fscrypt: unexport fscrypt_get_encryption_info()
      fscrypt: allow deleting files with unsupported encryption policy

 fs/crypto/fname.c            |   8 +++-
 fs/crypto/fscrypt_private.h  |  56 +++++++++++++++-------
 fs/crypto/hooks.c            |  55 +++++++++++----------
 fs/crypto/keyring.c          |  10 +---
 fs/crypto/keysetup.c         |  44 +++++++++++------
 fs/crypto/policy.c           |  27 +++++++----
 fs/ext4/dir.c                |  16 ++-----
 fs/ext4/namei.c              |  13 ++---
 fs/f2fs/dir.c                |  10 +---
 fs/f2fs/f2fs.h               |   2 +
 fs/ubifs/dir.c               |  28 +++++------
 include/linux/fscrypt.h      | 112 ++++++++++++++++++++++++++++---------------
 include/uapi/linux/fscrypt.h |   5 +-
 13 files changed, 227 insertions(+), 159 deletions(-)
