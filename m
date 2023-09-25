Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC0FA7ACFB5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Sep 2023 07:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232124AbjIYF7T (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Sep 2023 01:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232065AbjIYF7K (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Sep 2023 01:59:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB6E2DA;
        Sun, 24 Sep 2023 22:58:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E30AC433C7;
        Mon, 25 Sep 2023 05:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695621538;
        bh=tCCLwxvLEvFpLMK/KOG8gn3XG5X7DHq/Kv/q5swH83k=;
        h=From:To:Cc:Subject:Date:From;
        b=USnS67doJkAOwCvzzO4pxVWEqjaMKotK5QoJyyt8fjA0gw+S+R4xPcvpw24VnFDEF
         Ypg5ZAKGGE8kNlKVbBPl3VnLafVGwWh/V+sM3pAu1SOtB6b94Pv7m6R79glQrSo7AK
         9uvSZ0D6WCG1KR5dg+osBg4eDjkele/x3wGQO1HLWtjhs8ujnUtGRT9rFGVqZD1hOj
         IEYdXeCFex9RhZAoUvWTKKIr9BO7UHh/psJRUf+GzYK59rDq+33qVcTyKjZzzNkivS
         LTsx6CM+KNv5HHMxwe1olIcqIGIWpv2Uq96r8JhuKOVx7sP9iOVNuCz6b7G5cwotJS
         QCpKAf1h09yow==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-btrfs@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH v3 0/5] fscrypt: add support for data_unit_size < fs_block_size
Date:   Sun, 24 Sep 2023 22:54:46 -0700
Message-ID: <20230925055451.59499-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patchset adds support for configuring the granularity of file
contents encryption (a.k.a. the "crypto data unit size") to be less than
the filesystem block size on ext4 and f2fs.  The main use case for this
is to support inline crypto hardware that only supports a data unit size
that is less than the FS block size being used.  Another possible use
case is to support direct I/O on encrypted files without the FS block
alignment restriction.  Note that decreasing the crypto data unit size
decreases efficiency, so this feature should only be used when needed.

For full details, see patch 5 which adds the actual feature.  Patches
1-4 are preparatory patches.

I've written an xfstest that verifies that when a sub-block data unit
size is selected, the data on-disk is encrypted correctly with that data
unit size.  I'll be sending that out separately.  Other testing of this
patchset with xfstests has gone well, though it turns out that some
additional changes will be needed for a sub-block data unit size to work
with the IV_INO_LBLK_* encryption settings.  See patch 5 for details.
This patchset focuses on basic sub-block data unit size support first.

This patchset will cause some conflicts in the extent-based encryption
patches that the btrfs folks are working on, as both are touching file
contents encryption, but logically they are orthogonal features.

This patchset is based on v6.6-rc3.

Changed in v3:
  - Shortened 'legacy_key_prefix_for_backcompat' to 'legacy_key_prefix'
  - Other miscellaneous cleanups
  - Rebased onto v6.6-rc3

Changed in v2:
  - Rebased onto v6.6-rc1 and took into account CephFS's recent addition
    of support for fscrypt
  - Narrowed the focus somewhat by dropping the attempted support for
    IV_INO_LBLK_32 and clearly documenting what is considered out of
    scope for now
  - Other cleanups

Eric Biggers (5):
  fscrypt: make it clearer that key_prefix is deprecated
  fscrypt: make the bounce page pool opt-in instead of opt-out
  fscrypt: compute max_lblk_bits from s_maxbytes and block size
  fscrypt: replace get_ino_and_lblk_bits with just has_32bit_inodes
  fscrypt: support crypto data unit size less than filesystem block size

 Documentation/filesystems/fscrypt.rst | 117 ++++++++++++++------
 fs/ceph/crypto.c                      |   1 +
 fs/crypto/bio.c                       |  39 ++++---
 fs/crypto/crypto.c                    | 148 +++++++++++++++-----------
 fs/crypto/fscrypt_private.h           |  58 ++++++++--
 fs/crypto/inline_crypt.c              |  19 ++--
 fs/crypto/keysetup.c                  |   5 +
 fs/crypto/keysetup_v1.c               |   5 +-
 fs/crypto/policy.c                    |  73 +++++++++----
 fs/ext4/crypto.c                      |  13 +--
 fs/f2fs/super.c                       |  13 +--
 fs/ubifs/crypto.c                     |   3 +-
 include/linux/fscrypt.h               |  72 ++++++++-----
 include/uapi/linux/fscrypt.h          |   3 +-
 14 files changed, 364 insertions(+), 205 deletions(-)


base-commit: 6465e260f48790807eef06b583b38ca9789b6072
-- 
2.42.0

