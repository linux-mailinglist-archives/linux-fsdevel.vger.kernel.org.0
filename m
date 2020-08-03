Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E5BE239FFC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Aug 2020 09:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725844AbgHCHFu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Aug 2020 03:05:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:34340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725826AbgHCHFu (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Aug 2020 03:05:50 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB12A206D7;
        Mon,  3 Aug 2020 07:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596438349;
        bh=1/YYBhx6gDgPn0W0PUaqgcbPBPyOY+oUseS5B1Y5aXs=;
        h=Date:From:To:Cc:Subject:From;
        b=zJFv3N8oSMbXQHLMge43sKxec8eqkF9HVvyR6GngT5yMahB7DlBsWaPzNqQKzte4+
         eCG0tD+mZ/WqVT7u/0+LsUeWT4cMeGecpf21MhCCWB13nNqebGh/SD7R5k87vU+IcZ
         41DHrflgqWuzyzYSdovDJh7xRxY5DiXqAVMLyU6w=
Date:   Mon, 3 Aug 2020 00:05:47 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Satya Tangirala <satyat@google.com>
Subject: [GIT PULL] fscrypt updates for 5.9
Message-ID: <20200803070547.GA24480@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The following changes since commit dcb7fd82c75ee2d6e6f9d8cc71c52519ed52e258:

  Linux 5.8-rc4 (2020-07-05 16:20:22 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git tags/fscrypt-for-linus

for you to fetch changes up to 55e32c54bbd5741cad462c9ee00c453c72fa74b9:

  fscrypt: don't load ->i_crypt_info before it's known to be valid (2020-07-30 14:21:50 -0700)

----------------------------------------------------------------

This release, we add support for inline encryption via the blk-crypto
framework which was added in 5.8.  Now when an ext4 or f2fs filesystem
is mounted with '-o inlinecrypt', the contents of encrypted files will
be encrypted/decrypted via blk-crypto, instead of directly using the
crypto API.  This model allows taking advantage of the inline encryption
hardware that is integrated into the UFS or eMMC host controllers on
most mobile SoCs.  Note that this is just an alternate implementation;
the ciphertext written to disk stays the same.

(This pull request does *not* include support for direct I/O on
encrypted files, which blk-crypto makes possible, since that part is
still being discussed.)

Besides the above feature update, there are also a few fixes and
cleanups, e.g. strengthening some memory barriers that may be too weak.

All these patches have been in linux-next with no reported issues.  I've
also tested them with the fscrypt xfstests, as usual.  It's also been
tested that the inline encryption support works with the support for
Qualcomm and Mediatek inline encryption hardware that will be in the
scsi pull request for 5.9.  Also, several SoC vendors are already using
a previous, functionally equivalent version of these patches.

----------------------------------------------------------------
Eric Biggers (9):
      ext4: add inline encryption support
      fscrypt: add comments that describe the HKDF info strings
      fscrypt: rename FS_KEY_DERIVATION_NONCE_SIZE
      fscrypt: restrict IV_INO_LBLK_* to AES-256-XTS
      fscrypt: switch fscrypt_do_sha256() to use the SHA-256 library
      fscrypt: use smp_load_acquire() for fscrypt_prepared_key
      fscrypt: use smp_load_acquire() for ->s_master_keys
      fscrypt: use smp_load_acquire() for ->i_crypt_info
      fscrypt: don't load ->i_crypt_info before it's known to be valid

Satya Tangirala (4):
      fs: introduce SB_INLINECRYPT
      fscrypt: add inline encryption support
      f2fs: add inline encryption support
      fscrypt: document inline encryption support

 Documentation/admin-guide/ext4.rst    |   7 +
 Documentation/filesystems/f2fs.rst    |   7 +
 Documentation/filesystems/fscrypt.rst |  25 ++-
 fs/buffer.c                           |   7 +-
 fs/crypto/Kconfig                     |   8 +-
 fs/crypto/Makefile                    |   1 +
 fs/crypto/bio.c                       |  51 +++++
 fs/crypto/crypto.c                    |   4 +-
 fs/crypto/fname.c                     |  45 ++---
 fs/crypto/fscrypt_private.h           | 144 ++++++++++---
 fs/crypto/inline_crypt.c              | 367 ++++++++++++++++++++++++++++++++++
 fs/crypto/keyring.c                   |  21 +-
 fs/crypto/keysetup.c                  |  91 ++++++---
 fs/crypto/keysetup_v1.c               |  20 +-
 fs/crypto/policy.c                    |  20 +-
 fs/ext4/inode.c                       |   4 +-
 fs/ext4/page-io.c                     |   6 +-
 fs/ext4/readpage.c                    |  11 +-
 fs/ext4/super.c                       |  12 ++
 fs/f2fs/compress.c                    |   2 +-
 fs/f2fs/data.c                        |  79 ++++++--
 fs/f2fs/super.c                       |  35 ++++
 include/linux/fs.h                    |   1 +
 include/linux/fscrypt.h               | 111 +++++++++-
 24 files changed, 940 insertions(+), 139 deletions(-)
 create mode 100644 fs/crypto/inline_crypt.c
