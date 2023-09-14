Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8999179FE02
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Sep 2023 10:14:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236325AbjINIOy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Sep 2023 04:14:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235969AbjINIOx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Sep 2023 04:14:53 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F22D0CD8;
        Thu, 14 Sep 2023 01:14:49 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65E8AC433C7;
        Thu, 14 Sep 2023 08:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694679289;
        bh=O/fQUB0thzVERyyDJ+e34tB6NXJCmxw8lXP18CaGKeo=;
        h=From:To:Cc:Subject:Date:From;
        b=XXUmuSFI3jaRP/IM3nQ4JnvyjNh2qAOhASwCfGN1IJc6eJjrXLpDuCg/3ZRK0XZIj
         PFpUjNSLaAuzaHdHX3KqjtWOGoOw1pqq7H1hX2lo3clUMJ3Hq5Q+RZY621FubejTSP
         Dh2Z62Cf+OwrRofnkyC/mnCGfrVcW82/pgXrN5vRE9sZCwRAPBDRIgbVnSW1AscKx0
         qnVUR+TBx4/yQhJ4uusXzvx8wg1uyXcrRP8jIXgrEbf3eBb2dChUkeuEIJ3i44gnGV
         dn/WYBhiU/WVI/fHFm4KWMQ+n7wCAX7LZDacnTqVfOvr354VtPtV1r2ZSb96qVxwNz
         efUYIl8JOfimg==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-btrfs@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>
Subject: [PATCH v2 0/5] fscrypt: add support for data_unit_size < fs_block_size
Date:   Thu, 14 Sep 2023 01:12:50 -0700
Message-ID: <20230914081255.193502-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patchset adds support for configuring the granularity of file
contents encryption (a.k.a. the "crypto data unit size") to be less than
the filesystem block size.  The main use case for this is to support
inline crypto hardware that only supports a data unit size that is less
than the FS block size being used.  Another possible use case is to
support direct I/O on encrypted files without the FS block alignment
restriction.  Note that decreasing the crypto data unit size decreases
efficiency, so this feature should only be used when necessary.

For full details, see patch 5 which adds the actual feature.  Patches
1-4 are preparatory patches.

I've written an xfstest that verifies that when a sub-block data unit
size is selected, the data on-disk is encrypted correctly with that data
unit size.  I'll be sending that out separately.  Other testing of this
patchset with xfstests has gone well, though it turns out a sub-block
data unit size doesn't really work with IV_INO_LBLK_* yet (see patch 5).

This patchset will cause some conflicts in the extent-based encryption
patches that the btrfs folks are working on, as both are touching file
contents encryption, but logically they are orthogonal features.

This patchset is based on v6.6-rc1.

Changed in v2:
  - Rebased onto v6.6-rc1 and took into account CephFS's recent addition
    of support for fscrypt
  - Narrowed the focus somewhat by dropping the attempted support for
    IV_INO_LBLK_32 and clearly documenting what is considered out of
    scope for now
  - Other cleanups

Eric Biggers (5):
  fscrypt: make it extra clear that key_prefix is deprecated
  fscrypt: make the bounce page pool opt-in instead of opt-out
  fscrypt: use s_maxbytes instead of filesystem lblk_bits
  fscrypt: replace get_ino_and_lblk_bits with just has_32bit_inodes
  fscrypt: support crypto data unit size less than filesystem block size

 Documentation/filesystems/fscrypt.rst | 116 ++++++++++++++------
 fs/ceph/crypto.c                      |   1 +
 fs/crypto/bio.c                       |  39 ++++---
 fs/crypto/crypto.c                    | 148 +++++++++++++++-----------
 fs/crypto/fscrypt_private.h           |  55 ++++++++--
 fs/crypto/inline_crypt.c              |  25 +++--
 fs/crypto/keysetup.c                  |   3 +
 fs/crypto/keysetup_v1.c               |   5 +-
 fs/crypto/policy.c                    |  75 ++++++++-----
 fs/ext4/crypto.c                      |  13 +--
 fs/f2fs/super.c                       |  13 +--
 fs/ubifs/crypto.c                     |   3 +-
 include/linux/fscrypt.h               |  71 +++++++-----
 include/uapi/linux/fscrypt.h          |   3 +-
 14 files changed, 364 insertions(+), 206 deletions(-)


base-commit: 0bb80ecc33a8fb5a682236443c1e740d5c917d1d
-- 
2.42.0

