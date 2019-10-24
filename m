Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65003E3E92
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2019 23:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729773AbfJXV5J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Oct 2019 17:57:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:57122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726279AbfJXV5J (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Oct 2019 17:57:09 -0400
Received: from ebiggers-linuxstation.mtv.corp.google.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4995620578;
        Thu, 24 Oct 2019 21:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571954227;
        bh=HDbyy92ncxjP1dI6FxrpY5/nE4vCNb78sIDmKUaw/oA=;
        h=From:To:Cc:Subject:Date:From;
        b=tYsduxACwWAZcKMN50EsIXij5SWgunEH/IZT5C2so19z1/o5XTkDSDkgsUcfYdjGT
         cYMAHDf8Q8CG1ftEildMrnVdoOBdnctFicyjkPr72LbPTbeOJgZh0wEtry6JZY/j+I
         kCMv9S3xpWh1jvarxrgWjGDKupV8ex7ClSaq4Hg0=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org
Cc:     linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, Satya Tangirala <satyat@google.com>,
        Paul Crowley <paulcrowley@google.com>,
        Paul Lawrence <paullawrence@google.com>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH v2 0/3] fscrypt: support for IV_INO_LBLK_64 policies
Date:   Thu, 24 Oct 2019 14:54:35 -0700
Message-Id: <20191024215438.138489-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.24.0.rc0.303.g954a862665-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

In preparation for adding inline encryption support to fscrypt, this
patchset adds a new fscrypt policy flag which modifies the encryption to
be optimized for inline encryption hardware compliant with the UFS v2.1
standard or the upcoming version of the eMMC standard.

This means using per-mode keys instead of per-file keys, and in
compensation including the inode number in the IVs.  For ext4, this
precludes filesystem shrinking, so I've also added a compat feature
which will prevent the filesystem from being shrunk.

I've separated this from the full "Inline Encryption Support" patchset
(https://lkml.kernel.org/linux-fsdevel/20190821075714.65140-1-satyat@google.com/)
to avoid conflating an implementation (inline encryption) with a new
on-disk format (IV_INO_LBLK_64).  This patchset purely adds support for
IV_INO_LBLK_64 policies to fscrypt, but implements them using the
existing filesystem layer crypto.

We're planning to make the *implementation* (filesystem layer or inline
crypto) be controlled by a mount option '-o inlinecrypt'.

This patchset applies to fscrypt.git#master and can also be retrieved from
https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/linux.git/log/?h=inline-crypt-optimized-v2

I've written a ciphertext verification test for this new type of policy:
https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/xfstests-dev.git/log/?h=inline-encryption

Work-in-progress patches for the inline encryption implementation of
both IV_INO_LBLK_64 and regular policies can be found at
https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/linux.git/log/?h=inline-encryption-wip

Changes v1 => v2:

- Rename the flag from INLINE_CRYPT_OPTIMIZED to IV_INO_LBLK_64.

- Use the same key derivation and IV generation scheme for filenames
  encryption too.

- Improve the documentation and commit messages.

Eric Biggers (3):
  fscrypt: add support for IV_INO_LBLK_64 policies
  ext4: add support for IV_INO_LBLK_64 encryption policies
  f2fs: add support for IV_INO_LBLK_64 encryption policies

 Documentation/filesystems/fscrypt.rst | 63 +++++++++++++++++----------
 fs/crypto/crypto.c                    | 10 ++++-
 fs/crypto/fscrypt_private.h           | 16 +++++--
 fs/crypto/keyring.c                   |  6 ++-
 fs/crypto/keysetup.c                  | 45 ++++++++++++++-----
 fs/crypto/policy.c                    | 41 ++++++++++++++++-
 fs/ext4/ext4.h                        |  2 +
 fs/ext4/super.c                       | 14 ++++++
 fs/f2fs/super.c                       | 26 ++++++++---
 include/linux/fscrypt.h               |  3 ++
 include/uapi/linux/fscrypt.h          |  3 +-
 11 files changed, 182 insertions(+), 47 deletions(-)

-- 
2.24.0.rc0.303.g954a862665-goog

