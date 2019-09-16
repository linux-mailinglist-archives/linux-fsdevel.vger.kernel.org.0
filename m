Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F05BEB342F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2019 06:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727598AbfIPEnC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Sep 2019 00:43:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:38750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726128AbfIPEnB (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Sep 2019 00:43:01 -0400
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D88620890;
        Mon, 16 Sep 2019 04:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568608980;
        bh=4rcJxzMiJ0kL3oeus61W237iMC+QN9KmUsm6KcuW2AA=;
        h=Date:From:To:Cc:Subject:From;
        b=EItaKWWwDdHY7poFsEpOeWckCdHgsaI3vWZd4OCM3mleS03tMJhUdEYSwGS+PAS4p
         GDkifSKew/NoF+THgcrJKY5owHOMwO/r+844m3Z8yLIlzsYpuF5wWT/X/wBF/Fo727
         7NYwTHUjLWQrcF82nqF6ZMrY+MGvy/sxSg2hceeM=
Date:   Sun, 15 Sep 2019 21:42:58 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, "Theodore Y. Ts'o" <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [GIT PULL] fscrypt updates for 5.4
Message-ID: <20190916044258.GA8269@sol.localdomain>
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

The following changes since commit e21a712a9685488f5ce80495b37b9fdbe96c230d:

  Linux 5.3-rc3 (2019-08-04 18:40:12 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git tags/fscrypt-for-linus

for you to fetch changes up to 0642ea2409f3bfa105570e12854b8e2628db6835:

  ext4 crypto: fix to check feature status before get policy (2019-08-31 10:00:29 -0500)

----------------------------------------------------------------

Hi Linus,

This is a large update to fs/crypto/ which includes:

- Add ioctls that add/remove encryption keys to/from a filesystem-level
  keyring.  These fix user-reported issues where e.g. an encrypted home
  directory can break NetworkManager, sshd, Docker, etc. because they
  don't get access to the needed keyring.  These ioctls also provide a
  way to lock encrypted directories that doesn't use the vm.drop_caches
  sysctl, so is faster, more reliable, and doesn't always need root.

- Add a new encryption policy version ("v2") which switches to a more
  standard, secure, and flexible key derivation function, and starts
  verifying that the correct key was supplied before using it.  The key
  derivation improvement is needed for its own sake as well as for
  ongoing feature work for which the current way is too inflexible.

Work is in progress to update both Android and the 'fscrypt' userspace
tool to use both these features.  (Working patches are available and
just need to be reviewed+merged.)  Chrome OS will likely use them too.

This has also been tested on ext4, f2fs, and ubifs with xfstests -- both
the existing encryption tests, and the new tests for this.  This has
also been in linux-next since Aug 16 with no reported issues.  I'm also
using an fscrypt v2-encrypted home directory on my personal desktop.


There will be a trivial merge conflict with the ext4 tree, due to both
branches adding new ioctls.  Please keep the fscrypt ioctls grouped
together in the list (see linux-next).

There's also a conflict with the key ACLs patchset.  If you merge that
patchset again, the resolution is to:

1. Add NULL argument to request_key() in fs/crypto/keysetup_v1.c,
   instead of in the deleted file fs/crypto/keyinfo.c.

2. Translate the key permissions to ACLs in fs/crypto/keyring.c.
   See linux-next for my recommended resolution, which avoids making any
   behavior changes (note that some of the old permissions map to
   multiple new permissions).

----------------------------------------------------------------
Chao Yu (1):
      ext4 crypto: fix to check feature status before get policy

Eric Biggers (26):
      fscrypt: remove loadable module related code
      fscrypt: clean up base64 encoding/decoding
      fscrypt: make fscrypt_msg() take inode instead of super_block
      fscrypt: improve warning messages for unsupported encryption contexts
      fscrypt: improve warnings for missing crypto API support
      fscrypt: use ENOPKG when crypto API support missing
      fs, fscrypt: move uapi definitions to new header <linux/fscrypt.h>
      fscrypt: use FSCRYPT_ prefix for uapi constants
      fscrypt: use FSCRYPT_* definitions, not FS_*
      fscrypt: add ->ci_inode to fscrypt_info
      fscrypt: rename fscrypt_master_key to fscrypt_direct_key
      fscrypt: refactor key setup code in preparation for v2 policies
      fscrypt: move v1 policy key setup to keysetup_v1.c
      fscrypt: rename keyinfo.c to keysetup.c
      fscrypt: add FS_IOC_ADD_ENCRYPTION_KEY ioctl
      fscrypt: add FS_IOC_REMOVE_ENCRYPTION_KEY ioctl
      fscrypt: add FS_IOC_GET_ENCRYPTION_KEY_STATUS ioctl
      fscrypt: add an HKDF-SHA512 implementation
      fscrypt: v2 encryption policy support
      fscrypt: allow unprivileged users to add/remove keys for v2 policies
      fscrypt: add FS_IOC_REMOVE_ENCRYPTION_KEY_ALL_USERS ioctl
      fscrypt: require that key be added when setting a v2 encryption policy
      ext4: wire up new fscrypt ioctls
      f2fs: wire up new fscrypt ioctls
      ubifs: wire up new fscrypt ioctls
      fscrypt: document the new ioctls and policy version

 Documentation/filesystems/fscrypt.rst | 758 +++++++++++++++++++++-----
 MAINTAINERS                           |   1 +
 fs/crypto/Kconfig                     |   2 +
 fs/crypto/Makefile                    |  10 +-
 fs/crypto/crypto.c                    |  45 +-
 fs/crypto/fname.c                     |  47 +-
 fs/crypto/fscrypt_private.h           | 399 ++++++++++++--
 fs/crypto/hkdf.c                      | 181 +++++++
 fs/crypto/hooks.c                     |   6 +-
 fs/crypto/keyinfo.c                   | 611 ---------------------
 fs/crypto/keyring.c                   | 984 ++++++++++++++++++++++++++++++++++
 fs/crypto/keysetup.c                  | 591 ++++++++++++++++++++
 fs/crypto/keysetup_v1.c               | 340 ++++++++++++
 fs/crypto/policy.c                    | 434 +++++++++++----
 fs/ext4/ioctl.c                       |  32 ++
 fs/ext4/super.c                       |   3 +
 fs/f2fs/file.c                        |  58 ++
 fs/f2fs/super.c                       |   2 +
 fs/super.c                            |   2 +
 fs/ubifs/ioctl.c                      |  20 +
 fs/ubifs/super.c                      |  11 +
 include/linux/fs.h                    |   1 +
 include/linux/fscrypt.h               |  55 +-
 include/uapi/linux/fs.h               |  54 +-
 include/uapi/linux/fscrypt.h          | 181 +++++++
 25 files changed, 3827 insertions(+), 1001 deletions(-)
 create mode 100644 fs/crypto/hkdf.c
 delete mode 100644 fs/crypto/keyinfo.c
 create mode 100644 fs/crypto/keyring.c
 create mode 100644 fs/crypto/keysetup.c
 create mode 100644 fs/crypto/keysetup_v1.c
 create mode 100644 include/uapi/linux/fscrypt.h
