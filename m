Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1371D28BE16
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Oct 2020 18:35:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403822AbgJLQfq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Oct 2020 12:35:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:36238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390442AbgJLQfp (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Oct 2020 12:35:45 -0400
Received: from sol.localdomain (172-10-235-113.lightspeed.sntcca.sbcglobal.net [172.10.235.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A743C2087E;
        Mon, 12 Oct 2020 16:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602520545;
        bh=YcQkpt6LAikAkB8QxaNKH7LeylYY9QtLEPxQqeO6Opc=;
        h=Date:From:To:Cc:Subject:From;
        b=h3CNKfqwIHPV7BZ9hlGFurPVOoV3tPc0rsL8zhSQ3bYNeva/1gL1LMR6EgvNgZ1ky
         Iue96vWauoxpSjbJ0nTKmHeG1rslzfbYWaB/Mq5x5OWvhn/dOTTQ8G9m+BlO9Y3Tp0
         Y7SUutsnxm/64ZLRdP9PVhAzUFjaKyM+162FzfvU=
Date:   Mon, 12 Oct 2020 09:35:43 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Daniel Rosenberg <drosen@google.com>
Subject: [GIT PULL] fscrypt updates for 5.10
Message-ID: <20201012163543.GB858@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The following changes since commit f4d51dffc6c01a9e94650d95ce0104964f8ae822:

  Linux 5.9-rc4 (2020-09-06 17:11:40 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git tags/fscrypt-for-linus

for you to fetch changes up to 5b2a828b98ec1872799b1b4d82113c76a12d594f:

  fscrypt: export fscrypt_d_revalidate() (2020-09-28 14:44:51 -0700)

----------------------------------------------------------------

This release, we rework the implementation of creating new encrypted
files in order to fix some deadlocks and prepare for adding fscrypt
support to CephFS, which Jeff Layton is working on.

We also export a symbol in preparation for the above-mentioned CephFS
support and also for ext4/f2fs encrypt+casefold support.

Finally, there are a few other small cleanups.

As usual, all these patches have been in linux-next with no reported
issues, and I've tested them with xfstests.

----------------------------------------------------------------
Eric Biggers (18):
      fscrypt: restrict IV_INO_LBLK_32 to ino_bits <= 32
      fscrypt: add fscrypt_prepare_new_inode() and fscrypt_set_context()
      ext4: factor out ext4_xattr_credits_for_new_inode()
      ext4: use fscrypt_prepare_new_inode() and fscrypt_set_context()
      f2fs: use fscrypt_prepare_new_inode() and fscrypt_set_context()
      ubifs: use fscrypt_prepare_new_inode() and fscrypt_set_context()
      fscrypt: adjust logging for in-creation inodes
      fscrypt: remove fscrypt_inherit_context()
      fscrypt: require that fscrypt_encrypt_symlink() already has key
      fscrypt: stop pretending that key setup is nofs-safe
      fscrypt: make "#define fscrypt_policy" user-only
      fscrypt: move fscrypt_prepare_symlink() out-of-line
      fscrypt: handle test_dummy_encryption in more logical way
      fscrypt: make fscrypt_set_test_dummy_encryption() take a 'const char *'
      fscrypt: use sha256() instead of open coding
      fscrypt: don't call no-key names "ciphertext names"
      fscrypt: rename DCACHE_ENCRYPTED_NAME to DCACHE_NOKEY_NAME
      fscrypt: export fscrypt_d_revalidate()

Jeff Layton (1):
      fscrypt: drop unused inode argument from fscrypt_fname_alloc_buffer

 fs/crypto/crypto.c           |   4 +-
 fs/crypto/fname.c            |  60 ++++++-------
 fs/crypto/fscrypt_private.h  |  10 ++-
 fs/crypto/hooks.c            |  80 +++++++++++------
 fs/crypto/inline_crypt.c     |   7 +-
 fs/crypto/keyring.c          |   9 +-
 fs/crypto/keysetup.c         | 182 +++++++++++++++++++++++++++----------
 fs/crypto/keysetup_v1.c      |   8 +-
 fs/crypto/policy.c           | 209 ++++++++++++++++++++++++-------------------
 fs/ext4/dir.c                |   2 +-
 fs/ext4/ext4.h               |   6 +-
 fs/ext4/ialloc.c             | 119 ++++++++++++------------
 fs/ext4/namei.c              |   7 +-
 fs/ext4/super.c              |  16 ++--
 fs/f2fs/dir.c                |   6 +-
 fs/f2fs/f2fs.h               |  25 +-----
 fs/f2fs/namei.c              |   7 +-
 fs/f2fs/super.c              |  15 ++--
 fs/ubifs/dir.c               |  40 ++++-----
 include/linux/dcache.h       |   2 +-
 include/linux/fscrypt.h      | 159 +++++++++++++-------------------
 include/uapi/linux/fscrypt.h |   6 +-
 22 files changed, 535 insertions(+), 444 deletions(-)
