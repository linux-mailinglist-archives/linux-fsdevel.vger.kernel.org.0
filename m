Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D8DA167C8A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2020 12:51:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728014AbgBULvB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Feb 2020 06:51:01 -0500
Received: from mail-pl1-f202.google.com ([209.85.214.202]:47582 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727145AbgBULvA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Feb 2020 06:51:00 -0500
Received: by mail-pl1-f202.google.com with SMTP id h3so994987plt.14
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Feb 2020 03:51:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=83O1O0BvqsRePhEwUFRS88T3IBjEFsHxRG5zUEpMUZc=;
        b=IzI7geu6QauHIgaZOH0d8gP9p62euFAE5r4FNQyFtJRBV5KPhWfOwSayx6ehQ8+IDt
         sRbX8I4n1X7u0LsCjYayq8sMP9uolcRiBzBRg54yYIUIiyuUmQ1QF8vxmRdQpYgRFOR+
         ala3yVUDuIn1R86rEBZOSA/Zfby95p/4u2fABlsnW+E9SNAthYnoC0Z+mgrbsAhZRF26
         Hgql7Vzl4xbPA3C59fBpLR79JS29aRcH7LdIP5YlCN6nOfw+v/spMHiEVczSj5ePCyPx
         zLf4swSBkxPwuRELPnzw+SCAT7icCTT/MTMTDlq8pmYtPCS/qGCGt11PJNNQUyLlyk/M
         HciA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=83O1O0BvqsRePhEwUFRS88T3IBjEFsHxRG5zUEpMUZc=;
        b=nXcYagrruAPhSSv0X4AkaH2QCp+ur+x2DdznlIYmRk5CulH8TlPHuA+J03S0yDQMZn
         I0DNj4cALcz+aF+pS+kBZJ7jjFxv3+H/jqQqJCLsjGfxMYYNu8lOnLItM7rYMTI0w500
         fsK6EzRoO25koypxDnKsND2/jJKTJcNioW3X5vd18j6LmNCguuJ2uBYlg0vtAWF/6thG
         M77GAYgylATNjv2lgR2fPdZlyLYr84LxwWoP3esguiz+PVq5x53r+jAqZcCjEIuYxAGX
         j0wtX6AP8+mv1tw+vy6jAA8RUscMkLGeczNcf+TLlhDnMqLkghD0EUDSjbCO90G9mu0e
         bCJw==
X-Gm-Message-State: APjAAAVUQ+wcv/fRQhfV3KfAaWUxqErecrW3hSkX30p8Xl3wEbyBUS4y
        gkQGcWFuI+4f34wh6h9dXW8cwgOfQkw=
X-Google-Smtp-Source: APXvYqzeaxHdgLjarCsHRj9mUcBTaosZGH9w+4w9f2csDk8BRlK0ENUH7Kdfn/C5IOuSnhQUOUs2N8fkmbQ=
X-Received: by 2002:a63:e65:: with SMTP id 37mr37521207pgo.171.1582285859938;
 Fri, 21 Feb 2020 03:50:59 -0800 (PST)
Date:   Fri, 21 Feb 2020 03:50:41 -0800
Message-Id: <20200221115050.238976-1-satyat@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH v7 0/9] Inline Encryption Support
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
UFS, fscrypt, f2fs and ext4.

Note that the patches in this series for the block layer (i.e. patches 1, 2
and 3) can be applied independently of the subsequent patches in this
series.

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

Patch 1 introduces a Keyslot Manager to efficiently manage keyslots.
The keyslot manager also functions as the interface that blk-crypto
(introduced in Patch 2), will use to program keys into inline encryption
hardware. For more information on the Keyslot Manager, refer to
documentation found in block/keyslot-manager.c and linux/keyslot-manager.h.

Patch 2 adds the block layer changes for inline encryption support. It
introduces struct bio_crypt_ctx, and a ptr to one in struct bio, which
allows struct bio to represent an encryption context that can be passed
down the storage stack from the filesystem layer to the storage driver.

Patch 3 introduces blk-crypto-fallback - a kernel crypto API fallback for
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

Patches 4-6 add support for inline encryption into the UFS driver according
to the JEDEC UFS HCI v2.1 specification. Inline encryption support for
other drivers (like eMMC) may be added in the same way - the device driver
should set up a Keyslot Manager in the device's request_queue (refer to
the UFS crypto additions in ufshcd-crypto.c and ufshcd.c for an example).

Patch 7 adds support to fscrypt - to use inline encryption with fscrypt,
the filesystem must be mounted with '-o inlinecrypt' - when this option is
specified, the contents of any AES-256-XTS encrypted file will be
encrypted using blk-crypto.

Patches 8 and 9 add support to f2fs and ext4 respectively, so that we have
a complete stack that can make use of inline encryption.

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

Satya Tangirala (8):
  block: Keyslot Manager for Inline Encryption
  block: Inline encryption support for blk-mq
  block: blk-crypto-fallback for Inline Encryption
  scsi: ufs: UFS driver v2.1 spec crypto additions
  scsi: ufs: UFS crypto API
  scsi: ufs: Add inline encryption support to UFS
  fscrypt: add inline encryption support
  f2fs: add inline encryption support

 Documentation/admin-guide/ext4.rst        |   4 +
 Documentation/block/index.rst             |   1 +
 Documentation/block/inline-encryption.rst | 162 ++++++
 Documentation/filesystems/f2fs.txt        |   4 +
 block/Kconfig                             |  17 +
 block/Makefile                            |   2 +
 block/bio-integrity.c                     |   5 +
 block/bio.c                               |   7 +-
 block/blk-core.c                          |  16 +
 block/blk-crypto-fallback.c               | 673 ++++++++++++++++++++++
 block/blk-crypto-internal.h               |  51 ++
 block/blk-crypto.c                        | 441 ++++++++++++++
 block/blk-map.c                           |   1 +
 block/blk-merge.c                         |  11 +
 block/blk-mq.c                            |  16 +
 block/blk.h                               |   3 +
 block/bounce.c                            |   2 +
 block/keyslot-manager.c                   | 426 ++++++++++++++
 drivers/md/dm.c                           |   2 +
 drivers/scsi/ufs/Kconfig                  |   9 +
 drivers/scsi/ufs/Makefile                 |   1 +
 drivers/scsi/ufs/ufs-hisi.c               |   8 +
 drivers/scsi/ufs/ufs-qcom.c               |   7 +
 drivers/scsi/ufs/ufshcd-crypto.c          | 393 +++++++++++++
 drivers/scsi/ufs/ufshcd-crypto.h          |  68 +++
 drivers/scsi/ufs/ufshcd.c                 |  61 +-
 drivers/scsi/ufs/ufshcd.h                 |  33 ++
 drivers/scsi/ufs/ufshci.h                 |  67 ++-
 fs/buffer.c                               |   7 +-
 fs/crypto/Kconfig                         |   6 +
 fs/crypto/Makefile                        |   1 +
 fs/crypto/bio.c                           |  55 ++
 fs/crypto/crypto.c                        |   2 +-
 fs/crypto/fname.c                         |   4 +-
 fs/crypto/fscrypt_private.h               | 121 +++-
 fs/crypto/inline_crypt.c                  | 324 +++++++++++
 fs/crypto/keyring.c                       |   4 +-
 fs/crypto/keysetup.c                      |  95 ++-
 fs/crypto/keysetup_v1.c                   |  16 +-
 fs/ext4/ext4.h                            |   1 +
 fs/ext4/inode.c                           |   4 +-
 fs/ext4/page-io.c                         |   6 +-
 fs/ext4/readpage.c                        |  11 +-
 fs/ext4/super.c                           |  19 +
 fs/f2fs/compress.c                        |   2 +-
 fs/f2fs/data.c                            |  67 ++-
 fs/f2fs/f2fs.h                            |   3 +
 fs/f2fs/super.c                           |  35 ++
 include/linux/bio.h                       |   1 +
 include/linux/blk-crypto.h                | 271 +++++++++
 include/linux/blk_types.h                 |  12 +
 include/linux/blkdev.h                    |  16 +
 include/linux/fs.h                        |   1 +
 include/linux/fscrypt.h                   |  57 ++
 include/linux/keyslot-manager.h           | 108 ++++
 55 files changed, 3654 insertions(+), 86 deletions(-)
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
2.25.0.265.gbab2e86ba0-goog

