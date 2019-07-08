Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2625262564
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jul 2019 17:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387799AbfGHPxi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Jul 2019 11:53:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:50818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731329AbfGHPxi (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Jul 2019 11:53:38 -0400
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE924216F4;
        Mon,  8 Jul 2019 15:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562601217;
        bh=VvyiDwXEdgFH6Y2FBTkFjaSans0W0KzuUuKrug84y58=;
        h=Date:From:To:Cc:Subject:From;
        b=Mlh6mIb2akdrOv0AfqfJolS9MsYUylanOcc85zuIB0hq7IzRqzaoQ/rQudsHKDlss
         uCZD00SWjL5j+qehnDClmPsgaH1qpjI4CbciBoIAg3zUNmfIW+N0GGvPfJuj1wn+Bm
         58bQ+y0xzZ4cN7OldQhFwkkjNUbRcadS41x+TBbY=
Date:   Mon, 8 Jul 2019 08:53:33 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, "Theodore Y. Ts'o" <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [GIT PULL] fscrypt updates for v5.3
Message-ID: <20190708155333.GA722@sol.localdomain>
Mail-Followup-To: Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, "Theodore Y. Ts'o" <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The following changes since commit cd6c84d8f0cdc911df435bb075ba22ce3c605b07:

  Linux 5.2-rc2 (2019-05-26 16:49:19 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git tags/fscrypt-for-linus

for you to fetch changes up to 0564336329f0b03a78221ddf51e52af3665e5720:

  fscrypt: document testing with xfstests (2019-06-27 10:29:46 -0700)

----------------------------------------------------------------
fscrypt updates for v5.3

- Preparations for supporting encryption on ext4 filesystems where the
  filesystem block size is smaller than PAGE_SIZE.

- Don't allow setting encryption policies on dead directories.

- Various cleanups.

----------------------------------------------------------------
Chandan Rajendra (3):
      ext4: clear BH_Uptodate flag on decryption error
      ext4: decrypt only the needed blocks in ext4_block_write_begin()
      ext4: decrypt only the needed block in __ext4_block_zero_page_range()

Eric Biggers (14):
      fscrypt: simplify bounce page handling
      fscrypt: remove the "write" part of struct fscrypt_ctx
      fscrypt: rename fscrypt_do_page_crypto() to fscrypt_crypt_block()
      fscrypt: clean up some BUG_ON()s in block encryption/decryption
      fscrypt: introduce fscrypt_encrypt_block_inplace()
      fscrypt: support encrypting multiple filesystem blocks per page
      fscrypt: handle blocksize < PAGE_SIZE in fscrypt_zeroout_range()
      fscrypt: introduce fscrypt_decrypt_block_inplace()
      fscrypt: support decrypting multiple filesystem blocks per page
      fscrypt: decrypt only the needed blocks in __fscrypt_decrypt_bio()
      ext4: encrypt only up to last block in ext4_bio_write_page()
      fscrypt: remove unnecessary includes of ratelimit.h
      fscrypt: remove selection of CONFIG_CRYPTO_SHA256
      fscrypt: document testing with xfstests

Hongjie Fang (1):
      fscrypt: don't set policy for a dead directory

 Documentation/filesystems/fscrypt.rst |  43 ++++-
 fs/crypto/Kconfig                     |   1 -
 fs/crypto/bio.c                       |  73 +++------
 fs/crypto/crypto.c                    | 299 +++++++++++++++++++---------------
 fs/crypto/fname.c                     |   1 -
 fs/crypto/fscrypt_private.h           |  15 +-
 fs/crypto/hooks.c                     |   1 -
 fs/crypto/keyinfo.c                   |   1 -
 fs/crypto/policy.c                    |   2 +
 fs/ext4/inode.c                       |  37 +++--
 fs/ext4/page-io.c                     |  44 +++--
 fs/f2fs/data.c                        |  17 +-
 fs/ubifs/crypto.c                     |  19 ++-
 include/linux/fscrypt.h               |  96 +++++++----
 14 files changed, 363 insertions(+), 286 deletions(-)
