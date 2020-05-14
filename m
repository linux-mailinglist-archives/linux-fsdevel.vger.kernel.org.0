Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD89A1D23BA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 May 2020 02:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733146AbgENAhg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 May 2020 20:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732970AbgENAhg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 May 2020 20:37:36 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC0EBC05BD43
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 May 2020 17:37:35 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id z5so1689966qtz.16
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 May 2020 17:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Y1TvKp65tsQMJNgm9HMaRO/OTRlalkrsXwsa1JM97tc=;
        b=ZAIRPf+oXWmjCxrysa3jnmus5IGwb5XwIiHrVByRxAvpfIiYD0ItqjkDiHZYWDO672
         N6ekiRkc2g/Uwy6OxSuTPl/jJsC3yfHMTGqr+kXgxIM1GV4xoOast3Baq4FyVQY8wkck
         XuUHl2oyXL+nBJJo71j5Aw3SQgmWnew7yHCKmU3YiBWlXl00JzZ7JHNUGPeMEmpLh2hL
         k5HCo+shfd2274Q38Cxm9cTV2VSSR22B+2IDwM8W2ULznysB/DsfvvHt30N6+uqW/5Kq
         DHJuckiUowmfqdW0OuXvIhO0M/9ZkJlk4A3Z2NAoQ6ct8QBRjvaWH5N735j7QujKWzkR
         7gaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Y1TvKp65tsQMJNgm9HMaRO/OTRlalkrsXwsa1JM97tc=;
        b=OJHX1Et+ZIfHrMTHzGYAeeHCFDV9qjlOu+7L70WAdJ4tvIIvoLl2FU1hQmCpT2eAmR
         5JpTXHPzPOIedct6+54UpqwdJiL3J+Hy+adSnRfZwCn5wzIeNDA1zW7y9AEKXNpTVT6N
         cWeIkz6uA4NsqPEtj9Z8B5tV7cNcHKrJAfu9jQcVY83uwK2XTHK+79ghZMjo33RWO/qV
         xjUQD2emUeCWQbL8ijE5SsdQS5kSkeNxEYMhJUfXSlHtk615dpMWeJgRg54mu/nGkZu5
         xYvlCJ73Cv52DU9zaduuSkhz8CUSp+arYMrvsadaflS4ON7AOLGLOk6D6gnrj70OzhUA
         X8JA==
X-Gm-Message-State: AOAM5317yKdo5ixtthX1QA1fP/io4EUZF49eHrGMtBrvziCembcHBrtC
        jBogWlnRnvc//shf6jMl7edDD5ByAjo=
X-Google-Smtp-Source: ABdhPJzXq3gY922W8GvJYKDCvdvkhTLMen1AnugqOEU+vcfl/4sIauHvla7GSVA5QizCia3rzhtcSzDwKjE=
X-Received: by 2002:a05:6214:1262:: with SMTP id r2mr2374687qvv.126.1589416654581;
 Wed, 13 May 2020 17:37:34 -0700 (PDT)
Date:   Thu, 14 May 2020 00:37:15 +0000
Message-Id: <20200514003727.69001-1-satyat@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.2.645.ge9eca65c58-goog
Subject: [PATCH v13 00/12] Inline Encryption Support
From:   Satya Tangirala <satyat@google.com>
To:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org
Cc:     Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        Kim Boojin <boojin.kim@samsung.com>,
        Satya Tangirala <satyat@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch series adds support for Inline Encryption to the block layer,
UFS, fscrypt, f2fs and ext4. It has been rebased onto linux-block/for-next.

Note that the patches in this series for the block layer (i.e. patches 1,
2, 3, 4 and 5) can be applied independently of the subsequent patches in
this series.

Inline Encryption hardware allows software to specify an encryption context
(an encryption key, crypto algorithm, data unit num, data unit size, etc.)
along with a data transfer request to a storage device, and the inline
encryption hardware will use that context to en/decrypt the data. The
inline encryption hardware is part of the storage device, and it
conceptually sits on the data path between system memory and the storage
device. Inline Encryption hardware has become increasingly common, and we
want to support it in the kernel.

Inline Encryption hardware implementations often function around the
concept of a limited number of "keyslots", which can hold an encryption
context each. The storage device can be directed to en/decrypt any
particular request with the encryption context stored in any particular
keyslot.

Patch 1 documents the whole series.

Patch 2 introduces a Keyslot Manager to efficiently manage keyslots.
The keyslot manager also functions as the interface that blk-crypto
(introduced in Patch 3), will use to program keys into inline encryption
hardware. For more information on the Keyslot Manager, refer to
documentation found in block/keyslot-manager.c and linux/keyslot-manager.h.

Patch 3 adds the block layer changes for inline encryption support. It
introduces struct bio_crypt_ctx, and a ptr to one in struct bio, which
allows struct bio to represent an encryption context that can be passed
down the storage stack from the filesystem layer to the storage driver.

Patch 4 precludes inline encryption support in a device whenever it
supports blk-integrity, because there is currently no known hardware that
supports both features, and it is not completely straightfoward to support
both of them properly, and doing it improperly might result in leaks of
information about the plaintext.

Patch 5 introduces blk-crypto-fallback - a kernel crypto API fallback for
blk-crypto to use when inline encryption hardware isn't present. This
allows filesystems to specify encryption contexts for bios without
having to worry about whether the underlying hardware has inline
encryption support, and allows for testing without real hardware inline
encryption support. This fallback is separately configurable from
blk-crypto, and can be disabled if desired while keeping inline
encryption support. It may also be possible to remove file content
en/decryption from fscrypt and simply use blk-crypto-fallback in a future
patch. For more details on blk-crypto and the fallback, refer to
Documentation/block/inline-encryption.rst.

Patches 6-8 add support for inline encryption into the UFS driver according
to the JEDEC UFS HCI v2.1 specification. Inline encryption support for
other drivers (like eMMC) may be added in the same way - the device driver
should set up a Keyslot Manager in the device's request_queue (refer to
the UFS crypto additions in ufshcd-crypto.c and ufshcd.c for an example).

Patch 9 adds the SB_INLINECRYPT mount flag to the fs layer, which
filesystems must set to indicate that they want to use blk-crypto for
en/decryption of file contents.

Patch 10 adds support to fscrypt - to use inline encryption with fscrypt,
the filesystem must be mounted with '-o inlinecrypt' - when this option is
specified, the contents of any AES-256-XTS encrypted file will be
encrypted using blk-crypto.

Patches 11 and 12 add support to f2fs and ext4 respectively, so that we
have a complete stack that can make use of inline encryption.

The patches were tested running kvm-xfstests, by specifying the introduced
"inlinecrypt" mount option, so that en/decryption happens with the
blk-crypto fallback. The patches were also tested on a Pixel 4 with UFS
hardware that has support for inline encryption.

There have been a few patch sets addressing Inline Encryption Support in
the past. Briefly, this patch set differs from those as follows:

1) "crypto: qce: ice: Add support for Inline Crypto Engine"
is specific to certain hardware, while our patch set's Inline
Encryption support for UFS is implemented according to the JEDEC UFS
specification.

2) "scsi: ufs: UFS Host Controller crypto changes" registers inline
encryption support as a kernel crypto algorithm. Our patch views inline
encryption as being fundamentally different from a generic crypto
provider (in that inline encryption is tied to a device), and so does
not use the kernel crypto API to represent inline encryption hardware.

3) "scsi: ufs: add real time/inline crypto support to UFS HCD" requires
the device mapper to work - our patch does not.

Changes v12 => v13:
 - Updated docs
 - Minor cleanups
 - rebased onto linux-block/for-next

Changes v11 => v12:
 - Inlined some fscrypt functions
 - Minor cleanups and improved comments

Changes v10 => v11:
 - We now allocate a new bio_crypt_ctx for each request instead of
   pulling and reusing the one in the bio inserted into the request. The
   bio_crypt_ctx of a bio is freed after the bio is ended.
 - Make each blk_ksm_keyslot store a pointer to the blk_crypto_key
   instead of a copy of the blk_crypto_key, so that each blk_crypto_key
   will have its own keyslot. We also won't need to compute the siphash
   for a blk_crypto_key anymore.
 - Minor cleanups

Changes v9 => v10:
 - Incorporate Eric's fix for allowing en/decryption to happen as usual via
   fscrypt in the case that hardware doesn't support the desired crypto
   configuration, but blk-crypto-fallback is disabled. (Introduce
   struct blk_crypto_config and blk_crypto_config_supported for fscrypt
   to call, to check that either blk-crypto-fallback is enabled or the
   device supports the crypto configuration).
 - Update docs
 - Lots of cleanups

Changes v8 => v9:
 - Don't open code bio_has_crypt_ctx into callers of blk-crypto functions.
 - Lots of cleanups

Changes v7 => v8:
 - Pass a struct blk_ksm_keyslot * around instead of slot numbers which
   simplifies some functions and passes around arguments with better types
 - Make bios with no encryption context avoid making calls into blk-crypto
   by checking for the presence of bi_crypt_context before making the call
 - Make blk-integrity preclude inline encryption support at probe time
 - Many many cleanups

Changes v6 => v7:
 - Keyslot management is now done on a per-request basis rather than a
   per-bio basis.
 - Storage drivers can now specify the maximum number of bytes they
   can accept for the data unit number (DUN) for each crypto algorithm,
   and upper layers can specify the minimum number of bytes of DUN they
   want with the blk_crypto_key they send with the bio - a driver is
   only considered to support a blk_crypto_key if the driver supports at
   least as many DUN bytes as the upper layer wants. This is necessary
   because storage drivers may not support as many bytes as the
   algorithm specification dictates (for e.g. UFS only supports 8 byte
   DUNs for AES-256-XTS, even though the algorithm specification
   says DUNs are 16 bytes long).
 - Introduce SB_INLINECRYPT to keep track of whether inline encryption
   is enabled for a filesystem (instead of using an fscrypt_operation).
 - Expose keyslot manager declaration and embed it within ufs_hba to
   clean up code.
 - Make blk-crypto preclude blk-integrity.
 - Some bug fixes
 - Introduce UFSHCD_QUIRK_BROKEN_CRYPTO for UFS drivers that don't
   support inline encryption (yet)

Changes v5 => v6:
 - Blk-crypto's kernel crypto API fallback is no longer restricted to
   8-byte DUNs. It's also now separately configurable from blk-crypto, and
   can be disabled entirely, while still allowing the kernel to use inline
   encryption hardware. Further, struct bio_crypt_ctx takes up less space,
   and no longer contains the information needed by the crypto API
   fallback - the fallback allocates the required memory when necessary.
 - Blk-crypto now supports all file content encryption modes supported by
   fscrypt.
 - Fixed bio merging logic in blk-merge.c
 - Fscrypt now supports inline encryption with the direct key policy, since
   blk-crypto now has support for larger DUNs.
 - Keyslot manager now uses a hashtable to lookup which keyslot contains
   any particular key (thanks Eric!)
 - Fscrypt support for inline encryption now handles filesystems with
   multiple underlying block devices (thanks Eric!)
 - Numerous cleanups

Changes v4 => v5:
 - The fscrypt patch has been separated into 2. The first adds support
   for the IV_INO_LBLK_64 policy (which was called INLINE_CRYPT_OPTIMIZED
   in past versions of this series). This policy is now purely an on disk
   format, and doesn't dictate whether blk-crypto is used for file content
   encryption or not. Instead, this is now decided based on the
   "inlinecrypt" mount option.
 - Inline crypto key eviction is now handled by blk-crypto instead of
   fscrypt.
 - More refactoring.

Changes v3 => v4:
 - Fixed the issue with allocating crypto_skcipher in
   blk_crypto_keyslot_program.
 - bio_crypto_alloc_ctx is now mempool backed.
 - In f2fs, a bio's bi_crypt_context is now set up when the
   bio is allocated, rather than just before the bio is
   submitted - this fixes bugs in certain cases, like when an
   encrypted block is being moved without decryption.
 - Lots of refactoring and cleanup of blk-crypto - thanks Eric!

Changes v2 => v3:
 - Overhauled keyslot manager's get keyslot logic and optimized LRU.
 - Block crypto en/decryption fallback now supports data unit sizes
   that divide the bvec length (instead of requiring each bvec's length
   to be the same as the data unit size).
 - fscrypt master key is now keyed additionally by super_block and
   ci_ctfm != NULL.
 - all references of "hw encryption" are replaced by inline encryption.
 - address various other review comments from Eric.

Changes v1 => v2:
 - Block layer and UFS changes are split into 3 patches each.
 - We now only have a ptr to a struct bio_crypt_ctx in struct bio, instead
   of the struct itself.
 - struct bio_crypt_ctx no longer has flags.
 - blk-crypto now correctly handles the case when it fails to init
   (because of insufficient memory), but kernel continues to boot.
 - ufshcd-crypto now works on big endian cpus.
 - Many cleanups.

Eric Biggers (1):
  ext4: add inline encryption support

Satya Tangirala (11):
  Documentation: Document the blk-crypto framework
  block: Keyslot Manager for Inline Encryption
  block: Inline encryption support for blk-mq
  block: Make blk-integrity preclude hardware inline encryption
  block: blk-crypto-fallback for Inline Encryption
  scsi: ufs: UFS driver v2.1 spec crypto additions
  scsi: ufs: UFS crypto API
  scsi: ufs: Add inline encryption support to UFS
  fs: introduce SB_INLINECRYPT
  fscrypt: add inline encryption support
  f2fs: add inline encryption support

 Documentation/admin-guide/ext4.rst        |   6 +
 Documentation/block/index.rst             |   1 +
 Documentation/block/inline-encryption.rst | 263 +++++++++
 Documentation/filesystems/f2fs.rst        |   7 +-
 block/Kconfig                             |  17 +
 block/Makefile                            |   2 +
 block/bio-integrity.c                     |   3 +
 block/bio.c                               |   6 +
 block/blk-core.c                          |  27 +-
 block/blk-crypto-fallback.c               | 657 ++++++++++++++++++++++
 block/blk-crypto-internal.h               | 201 +++++++
 block/blk-crypto.c                        | 404 +++++++++++++
 block/blk-integrity.c                     |   7 +
 block/blk-map.c                           |   1 +
 block/blk-merge.c                         |  11 +
 block/blk-mq.c                            |  13 +
 block/blk.h                               |   2 +
 block/bounce.c                            |   2 +
 block/keyslot-manager.c                   | 397 +++++++++++++
 drivers/md/dm.c                           |   3 +
 drivers/scsi/ufs/Kconfig                  |   9 +
 drivers/scsi/ufs/Makefile                 |   1 +
 drivers/scsi/ufs/ufshcd-crypto.c          | 226 ++++++++
 drivers/scsi/ufs/ufshcd-crypto.h          |  60 ++
 drivers/scsi/ufs/ufshcd.c                 |  46 +-
 drivers/scsi/ufs/ufshcd.h                 |  24 +
 drivers/scsi/ufs/ufshci.h                 |  67 ++-
 fs/buffer.c                               |   7 +-
 fs/crypto/Kconfig                         |   6 +
 fs/crypto/Makefile                        |   1 +
 fs/crypto/bio.c                           |  50 ++
 fs/crypto/crypto.c                        |   2 +-
 fs/crypto/fname.c                         |   4 +-
 fs/crypto/fscrypt_private.h               | 120 +++-
 fs/crypto/inline_crypt.c                  | 339 +++++++++++
 fs/crypto/keyring.c                       |   4 +-
 fs/crypto/keysetup.c                      |  92 ++-
 fs/crypto/keysetup_v1.c                   |  16 +-
 fs/ext4/inode.c                           |   4 +-
 fs/ext4/page-io.c                         |   6 +-
 fs/ext4/readpage.c                        |  11 +-
 fs/ext4/super.c                           |   9 +
 fs/f2fs/compress.c                        |   2 +-
 fs/f2fs/data.c                            |  68 ++-
 fs/f2fs/super.c                           |  32 ++
 fs/proc_namespace.c                       |   1 +
 include/linux/blk-crypto.h                | 123 ++++
 include/linux/blk_types.h                 |   6 +
 include/linux/blkdev.h                    |  41 ++
 include/linux/fs.h                        |   1 +
 include/linux/fscrypt.h                   |  82 +++
 include/linux/keyslot-manager.h           | 106 ++++
 52 files changed, 3504 insertions(+), 92 deletions(-)
 create mode 100644 Documentation/block/inline-encryption.rst
 create mode 100644 block/blk-crypto-fallback.c
 create mode 100644 block/blk-crypto-internal.h
 create mode 100644 block/blk-crypto.c
 create mode 100644 block/keyslot-manager.c
 create mode 100644 drivers/scsi/ufs/ufshcd-crypto.c
 create mode 100644 drivers/scsi/ufs/ufshcd-crypto.h
 create mode 100644 fs/crypto/inline_crypt.c
 create mode 100644 include/linux/blk-crypto.h
 create mode 100644 include/linux/keyslot-manager.h

-- 
2.26.2.645.ge9eca65c58-goog

