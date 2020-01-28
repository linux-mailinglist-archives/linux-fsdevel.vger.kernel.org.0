Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24AFD14ADB7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2020 02:47:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726191AbgA1Bq4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Jan 2020 20:46:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:55540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726099AbgA1Bq4 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Jan 2020 20:46:56 -0500
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B6233214AF;
        Tue, 28 Jan 2020 01:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580176015;
        bh=lr1TtkPAw46qDf+d4N/SnYvTgRxlT3N0rKG9IJ6qTbA=;
        h=Date:From:To:Cc:Subject:From;
        b=cqYd7QKXvUceC5PzgPSZ/bE2097stte3DG4D2oPME66YdL+7ulDNPgc2DupoZg8cb
         2xo7bClv8D0TskJO5zx3lNoQTU+xAk0kLYPI/Dn41ItM/+egz25uOG3zMUXG+lS7jX
         c/2mes651GtPNlOmgecueJBMSymiMQY8ZbJAHV1s=
Date:   Mon, 27 Jan 2020 17:46:53 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Daniel Rosenberg <drosen@google.com>
Subject: [GIT PULL] fscrypt updates for 5.6
Message-ID: <20200128014653.GA960@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The following changes since commit fd6988496e79a6a4bdb514a4655d2920209eb85d:

  Linux 5.5-rc4 (2019-12-29 15:29:16 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git tags/fscrypt-for-linus

for you to fetch changes up to edc440e3d27fb31e6f9663cf413fad97d714c060:

  fscrypt: improve format of no-key names (2020-01-22 14:50:03 -0800)

----------------------------------------------------------------

- Extend the FS_IOC_ADD_ENCRYPTION_KEY ioctl to allow the raw key to be
  provided via a keyring key.

- Prepare for the new dirhash method (SipHash of plaintext name) that
  will be used by directories that are both encrypted and casefolded.

- Switch to a new format for "no-key names" that prepares for the new
  dirhash method, and also fixes a longstanding bug where multiple
  filenames could map to the same no-key name.

- Allow the crypto algorithms used by fscrypt to be built as loadable
  modules when the fscrypt-capable filesystems are.

- Optimize fscrypt_zeroout_range().

- Various cleanups.

----------------------------------------------------------------
Daniel Rosenberg (3):
      fscrypt: don't allow v1 policies with casefolding
      fscrypt: derive dirhash key for casefolded directories
      fscrypt: improve format of no-key names

Eric Biggers (22):
      fscrypt: support passing a keyring key to FS_IOC_ADD_ENCRYPTION_KEY
      fscrypt: use crypto_skcipher_driver_name()
      fscrypt: verify that the crypto_skcipher has the correct ivsize
      fscrypt: constify struct fscrypt_hkdf parameter to fscrypt_hkdf_expand()
      fscrypt: constify inode parameter to filename encryption functions
      fscrypt: move fscrypt_d_revalidate() to fname.c
      fscrypt: introduce fscrypt_needs_contents_encryption()
      fscrypt: split up fscrypt_supported_policy() by policy version
      fscrypt: check for appropriate use of DIRECT_KEY flag earlier
      fscrypt: move fscrypt_valid_enc_modes() to policy.c
      fscrypt: remove fscrypt_is_direct_key_policy()
      fscrypt: don't check for ENOKEY from fscrypt_get_encryption_info()
      fscrypt: include <linux/ioctl.h> in UAPI header
      fscrypt: remove redundant bi_status check
      fscrypt: optimize fscrypt_zeroout_range()
      fscrypt: document gfp_flags for bounce page allocation
      ubifs: use IS_ENCRYPTED() instead of ubifs_crypt_is_encrypted()
      fscrypt: don't print name of busy file when removing key
      fscrypt: add "fscrypt_" prefix to fname_encrypt()
      fscrypt: clarify what is meant by a per-file key
      ubifs: don't trigger assertion on invalid no-key filename
      ubifs: allow both hash and disk name to be provided in no-key names

Herbert Xu (1):
      fscrypt: Allow modular crypto algorithms

 Documentation/filesystems/fscrypt.rst |  75 ++++++--
 fs/crypto/Kconfig                     |  22 ++-
 fs/crypto/bio.c                       | 114 ++++++++----
 fs/crypto/crypto.c                    |  57 +-----
 fs/crypto/fname.c                     | 316 +++++++++++++++++++++++++++-------
 fs/crypto/fscrypt_private.h           |  58 +++----
 fs/crypto/hkdf.c                      |   2 +-
 fs/crypto/hooks.c                     |  47 ++++-
 fs/crypto/keyring.c                   | 147 +++++++++++++---
 fs/crypto/keysetup.c                  | 102 ++++++-----
 fs/crypto/keysetup_v1.c               |  19 +-
 fs/crypto/policy.c                    | 170 ++++++++++++------
 fs/ext4/Kconfig                       |   1 +
 fs/ext4/dir.c                         |   2 +-
 fs/f2fs/Kconfig                       |   1 +
 fs/f2fs/dir.c                         |   2 +-
 fs/inode.c                            |   3 +-
 fs/ubifs/Kconfig                      |   1 +
 fs/ubifs/dir.c                        |  16 +-
 fs/ubifs/file.c                       |   4 +-
 fs/ubifs/journal.c                    |  10 +-
 fs/ubifs/key.h                        |   1 -
 fs/ubifs/ubifs.h                      |   7 -
 include/linux/fscrypt.h               | 122 +++++--------
 include/uapi/linux/fscrypt.h          |  14 +-
 25 files changed, 864 insertions(+), 449 deletions(-)
