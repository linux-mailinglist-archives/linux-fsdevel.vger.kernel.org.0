Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A74287924E3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Sep 2023 18:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbjIEQAK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Sep 2023 12:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243921AbjIEBEd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Sep 2023 21:04:33 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 078E81B8;
        Mon,  4 Sep 2023 18:04:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 335DFCE0220;
        Tue,  5 Sep 2023 01:04:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17F2EC433C7;
        Tue,  5 Sep 2023 01:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693875866;
        bh=22KQJh++JdcILQbZl12E7tGyAtMvtw7vw8AFr0hHnnY=;
        h=From:To:Cc:Subject:Date:From;
        b=GWIzNOUiEAtOu+wFjqcn0IqP8smNxOh6FpGxSPeJe5GJp1EIm92geCeXV2OOQRX2v
         A6kONLiIwSrZw8ibpttCuP1p4WFIi0xzdub0XztvVwrJOzY2HQyNgG84DwrO+Claz7
         IbUtrTrxONyYe41ZtvEHQxjeQQcCD52pinHNEQ+dAdOfw3sMr+NIVq3aOWhMZKdg1u
         2AAvveu7BS8kwkSUCuqu2yDwZB+rzjalOPGndECxnL5WMkBnJ/G8PntUy5WzJ5kqKh
         Otioqez2Flk0Q+vcdBfnskrC3jk4hnkfg0+tI8ahglB5vusDwMew5/svqxY0Zz36rt
         ROYuuoWDyg01w==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-btrfs@vger.kernel.org
Subject: [PATCH 0/5] fscrypt: add support for data_unit_size < fs_block_size
Date:   Mon,  4 Sep 2023 17:58:25 -0700
Message-ID: <20230905005830.365985-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,SUSPICIOUS_RECIPS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Until now, fscrypt has always used the filesystem block size as the
granularity of file contents encryption.  Two scenarios have come up
where a sub-block granularity of contents encryption would be useful:

1. Inline encryption hardware that only supports a crypto data unit size
   that is less than the filesystem block size.

2. Support for direct I/O at a granularity less than the filesystem
   block size, for example at the block device's logical block size in
   order to match the traditional direct I/O alignment requirement.

(1) first came up with older eMMC inline crypto hardware that only
supports a crypto data unit size of 512 bytes.  That specific case
ultimately went away because all systems with that hardware continued
using out of tree code and never actually upgraded to the upstream
inline crypto framework.  But, now it's coming back in a new way: some
current UFS controllers only support a data unit size of 4096 bytes, and
there is a proposal to increase the filesystem block size to 16K.

(2) was discussed as a "nice to have" feature, though not essential,
when support for direct I/O on encrypted files was being upstreamed.

Still, the fact that this feature has come up several times does suggest
it would be wise to have available.  Therefore, this patchset implements
it by using one of the reserved bytes in fscrypt_policy_v2 to allow
users to select a sub-block data unit size.  Supported values are powers
of 2 between 512 bytes and the filesystem block size, inclusively.

Patch 1-4 are preparatory patches.  Patch 5 is the actual feature.

Testing and userspace support are still in progress; there may be bugs
in this patchset.  I just wanted to get this out early in case anyone
has feedback on the feature itself and its likely implementation.

Note: this is unrelated to the work on extent based encryption that is
ongoing by the btrfs folks.  This is basically an orthogonal feature.

This patchset is based on mainline commit 708283abf896dd48

Eric Biggers (5):
  fscrypt: make it extra clear that key_prefix is deprecated
  fscrypt: make the bounce page pool opt-in instead of opt-out
  fscrypt: use s_maxbytes instead of filesystem lblk_bits
  fscrypt: replace get_ino_and_lblk_bits with just has_32bit_inodes
  fscrypt: support crypto data unit size less than filesystem block size

 Documentation/filesystems/fscrypt.rst | 115 ++++++++++++++------
 fs/crypto/bio.c                       |  39 ++++---
 fs/crypto/crypto.c                    | 148 +++++++++++++++-----------
 fs/crypto/fscrypt_private.h           |  51 +++++++--
 fs/crypto/inline_crypt.c              |  46 ++++++--
 fs/crypto/keysetup.c                  |  21 +++-
 fs/crypto/keysetup_v1.c               |   5 +-
 fs/crypto/policy.c                    |  69 +++++++-----
 fs/ext4/crypto.c                      |  13 +--
 fs/f2fs/super.c                       |  13 +--
 fs/ubifs/crypto.c                     |   3 +-
 include/linux/fscrypt.h               |  71 +++++++-----
 include/uapi/linux/fscrypt.h          |   3 +-
 13 files changed, 385 insertions(+), 212 deletions(-)


base-commit: 708283abf896dd4853e673cc8cba70acaf9bf4ea
-- 
2.42.0

