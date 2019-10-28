Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E35AFE6CE8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Oct 2019 08:20:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732702AbfJ1HUj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Oct 2019 03:20:39 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:43953 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729399AbfJ1HUi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Oct 2019 03:20:38 -0400
Received: by mail-pf1-f202.google.com with SMTP id i187so7894979pfc.10
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Oct 2019 00:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=8kmYTlsw2t8uqVQHy3hjWqwncfgaTXrr/brl20vQcnE=;
        b=d6uRgzSIVYSUN6Q4PBQzkUYWOciotNoa1eOq+lYLJ+qHtWSTwr4jPK0mljK7qbxjKh
         EK+0/sjiHTlf8d7MVyRQb0quHURUFqLTp40E9DmNua4A7GZo8ZrJBOa57YIZ0GNO8P6T
         n3qCfiEmL92uqb1qx+XM/vMPIu5gYrwNQ5lGabPLTJWLonjCsQPWpDc3T+YMugoZwttk
         LTMelmHqSxIb63rEH5t4rGjLb033enMkz9X/szYiBOpGE4UVdR0UL5j2AUQhPnh9wTs5
         zdcEi5Yk+Ky+7r7hdcPRWFCzhTBxqm0UzkmxI2ANC4s0PaQr3clDm+E2W25WZXDnKwr9
         /VgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=8kmYTlsw2t8uqVQHy3hjWqwncfgaTXrr/brl20vQcnE=;
        b=jerCKLJLH2lLl8GC6vh4qznAU/eLKUPvRg1BaMHEhYLqYpg1VO3sETAkgeWFkijJYZ
         EanGSyWiVLqWBEMV52iF47lho9hX7TTI5osOLbh/MtfqO5PPlB2QXJ3Yr56Rc4vPiSuh
         VmYPRHRtD9beX4SGKRQ25T2uoojJfWo2eqo1MLgsyq2HDDoT80fgecNFK9d0lH9n3ozF
         Kt+hmwe+3OfIxsp8JYMwGW8YsZBwdhuneg8QIfiuMZEHJuw8wmaWDanOilTgiB+Gcnqz
         qr7XII1DgAJfH498VQUNrvbzl1REzy61LYShn5iQzTqWTxM9uhc6ceXzt5ENurvctsUC
         gmAw==
X-Gm-Message-State: APjAAAWhlccoGagCQab4Us34J/L94KdSZTOAL0V3PDTG8yLMHYzbzeeP
        DvSVw21XYsYReaaSKxuCOJSB6c98az0=
X-Google-Smtp-Source: APXvYqzGoWEuWUo5LuR0LP+ddntICuUCcDvRp2KMGQ5a+PqGu4jL2F1naa/4tbHematPk1HSVrYtg6dlN5U=
X-Received: by 2002:a63:cf0b:: with SMTP id j11mr19081716pgg.240.1572247237715;
 Mon, 28 Oct 2019 00:20:37 -0700 (PDT)
Date:   Mon, 28 Oct 2019 00:20:23 -0700
Message-Id: <20191028072032.6911-1-satyat@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.0.rc0.303.g954a862665-goog
Subject: [PATCH v5 0/9] Inline Encryption Support
From:   Satya Tangirala <satyat@google.com>
To:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
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

This patchset applies to fscrypt.git#master with the additional patchset
"[PATCH 0/3] fscrypt: support for inline-encryption-optimized policies"
applied.  It can be retrieved from git at
https://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git/log/?h=inline-encryption-v5
Note however, that the patches for the block layer (i.e. patches 1, 2 and 3)
can be applied independently.

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
(introduced in Patch 3), will use to program keys into inline encryption
hardware. For more information on the Keyslot Manager, refer to
documentation found in block/keyslot-manager.c and linux/keyslot-manager.h.

Patch 2 introduces struct bio_crypt_ctx, and a ptr to one in struct bio,
which allows struct bio to represent an encryption context that can be
passed down the storage stack from the filesystem layer to the storage
driver.

Patch 3 introduces blk-crypto. Blk-crypto delegates crypto operations to
inline encryption hardware when available, and also contains a software
fallback to the kernel crypto API. Blk-crypto also makes it possible for
layered devices like device mapper to make use of inline encryption
hardware. Given that blk-crypto works as a software fallback, we are
considering removing file content en/decryption from fscrypt and simply
using blk-crypto in a future patch. For more details on blk-crypto, refer
to Documentation/block/inline-encryption.rst.

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
"inlinecrypt" mount option, so that encryption happens in blk-crypto.

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
  block: Add encryption context to struct bio
  block: blk-crypto for Inline Encryption
  scsi: ufs: UFS driver v2.1 spec crypto additions
  scsi: ufs: UFS crypto API
  scsi: ufs: Add inline encryption support to UFS
  fscrypt: add inline encryption support
  f2fs: add inline encryption support

 Documentation/block/index.rst             |   1 +
 Documentation/block/inline-encryption.rst | 183 +++++
 block/Kconfig                             |  10 +
 block/Makefile                            |   2 +
 block/bio-crypt-ctx.c                     | 142 ++++
 block/bio.c                               |  23 +-
 block/blk-core.c                          |  14 +-
 block/blk-crypto.c                        | 798 ++++++++++++++++++++++
 block/blk-merge.c                         |  35 +-
 block/bounce.c                            |  15 +-
 block/keyslot-manager.c                   | 352 ++++++++++
 drivers/md/dm.c                           |  15 +-
 drivers/scsi/ufs/Kconfig                  |   9 +
 drivers/scsi/ufs/Makefile                 |   1 +
 drivers/scsi/ufs/ufshcd-crypto.c          | 391 +++++++++++
 drivers/scsi/ufs/ufshcd-crypto.h          |  86 +++
 drivers/scsi/ufs/ufshcd.c                 |  85 ++-
 drivers/scsi/ufs/ufshcd.h                 |  25 +
 drivers/scsi/ufs/ufshci.h                 |  67 +-
 fs/buffer.c                               |   3 +
 fs/crypto/Kconfig                         |   6 +
 fs/crypto/Makefile                        |   1 +
 fs/crypto/bio.c                           |  31 +-
 fs/crypto/fscrypt_private.h               |  72 ++
 fs/crypto/inline_crypt.c                  | 390 +++++++++++
 fs/crypto/keyring.c                       |   2 +
 fs/crypto/keysetup.c                      |  18 +-
 fs/ext4/ext4.h                            |   1 +
 fs/ext4/inode.c                           |   4 +-
 fs/ext4/page-io.c                         |  11 +-
 fs/ext4/readpage.c                        |  15 +-
 fs/ext4/super.c                           |  13 +
 fs/f2fs/data.c                            |  76 ++-
 fs/f2fs/f2fs.h                            |   3 +
 fs/f2fs/super.c                           |  20 +
 include/linux/bio-crypt-ctx.h             | 226 ++++++
 include/linux/bio.h                       |   1 +
 include/linux/blk-crypto.h                |  62 ++
 include/linux/blk_types.h                 |   6 +
 include/linux/blkdev.h                    |   6 +
 include/linux/fscrypt.h                   |  60 ++
 include/linux/keyslot-manager.h           |  98 +++
 42 files changed, 3318 insertions(+), 61 deletions(-)
 create mode 100644 Documentation/block/inline-encryption.rst
 create mode 100644 block/bio-crypt-ctx.c
 create mode 100644 block/blk-crypto.c
 create mode 100644 block/keyslot-manager.c
 create mode 100644 drivers/scsi/ufs/ufshcd-crypto.c
 create mode 100644 drivers/scsi/ufs/ufshcd-crypto.h
 create mode 100644 fs/crypto/inline_crypt.c
 create mode 100644 include/linux/bio-crypt-ctx.h
 create mode 100644 include/linux/blk-crypto.h
 create mode 100644 include/linux/keyslot-manager.h

-- 
2.24.0.rc0.303.g954a862665-goog

