Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F51F124A36
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2019 15:52:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbfLROwV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Dec 2019 09:52:21 -0500
Received: from mail-yw1-f73.google.com ([209.85.161.73]:52568 "EHLO
        mail-yw1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726856AbfLROwU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Dec 2019 09:52:20 -0500
Received: by mail-yw1-f73.google.com with SMTP id r75so1424408ywg.19
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Dec 2019 06:52:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=8STCQLeFYfFH1MQLPq9DpdL6vmJhOc+CHo4Yv7nqaT8=;
        b=QfHBHMr+bADwCkP+k+BnbKSCG3L5/T+eQHsomyWoU9gwChEW+fony9ONDjYZokeK8U
         DQaLS9X6FCSZBont7Oe7qqWDhHkaV49l+O8rEmlVagTgIF1P0rY0N8qFWqv1IxIwibfJ
         abYd4ppG3eQ1cDUch3IiF9SfEQgkLLvxUuEQfExMTD51wpriW33xK1WYR7elDICGUOuq
         X2Vj9ugHjczCwTEgHZjkUt63bbIyn+iUBHGIutYsV8wSZZBCor/M7nX0pSsjst4x+QAM
         xQCfB5nzDcHr3jQuMlp0fbyDIC5NPwx9t9NNPICn7rzNmbzkn00u5bBlV8LPVggVuwKq
         8TDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=8STCQLeFYfFH1MQLPq9DpdL6vmJhOc+CHo4Yv7nqaT8=;
        b=ZByahNLS2nsKfu8xDqZ+g4E79H2s0W7dj4KVtntuN8CvOuQYXT45ZOOCMWVeJgxunT
         5ksG8K1P6L1f5FA8+SObTGGYOZVDedfDMPUZUHf5GPUMek19lo3VEKDNoSgmezfp842z
         Hd7i6FBfGHAe9VixJeTQSwXlznMT4icF8mcpe8UCvCcShUyqTGxd8MI3XMhVIMx0YRlb
         mow87qB2Qt25z3zEMt4Ky1RwbvwqS/mGu448a6FI7qRZvb3I8g9O4Y3dOM/xtp0Zp6if
         VhHraTtQwuXcO4y3JRzXHE9dIx1BWSIJvGGb8oFgicYNUswy+PUvFg7jWa18atEBLa/1
         KEkg==
X-Gm-Message-State: APjAAAXf0EwSO02t4+NLMRGbRBffATQHgfWav6YCwUazDkpL7Cc3QXJX
        6gbkTz14VA0uARbH2qIBJgXtGxmN6s0=
X-Google-Smtp-Source: APXvYqywUO/g1VSpSflkgFy68ztjZmb/pZBtvBq1T2PcLecZmsk5pah9fVqkmduzIySneFe2IK5O2DWEXoU=
X-Received: by 2002:a81:6c92:: with SMTP id h140mr2323545ywc.246.1576680739467;
 Wed, 18 Dec 2019 06:52:19 -0800 (PST)
Date:   Wed, 18 Dec 2019 06:51:27 -0800
Message-Id: <20191218145136.172774-1-satyat@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
Subject: [PATCH v6 0/9] Inline Encryption Support
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
hardware. Given that blk-crypto works as a software fallback, it may be
possible to remove file content en/decryption from fscrypt and simply use
blk-crypto in a future patch. For more details on blk-crypto, refer to
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

Satya Tangirala (9):
  block: Keyslot Manager for Inline Encryption
  block: Add encryption context to struct bio
  block: blk-crypto for Inline Encryption
  scsi: ufs: UFS driver v2.1 spec crypto additions
  scsi: ufs: UFS crypto API
  scsi: ufs: Add inline encryption support to UFS
  fscrypt: add inline encryption support
  f2fs: add inline encryption support
  ext4: add inline encryption support

 Documentation/block/index.rst             |   1 +
 Documentation/block/inline-encryption.rst | 183 ++++++
 block/Kconfig                             |  17 +
 block/Makefile                            |   3 +
 block/bio-crypt-ctx.c                     | 140 +++++
 block/bio.c                               |  21 +-
 block/blk-core.c                          |  16 +-
 block/blk-crypto-fallback.c               | 648 ++++++++++++++++++++++
 block/blk-crypto-internal.h               |  58 ++
 block/blk-crypto.c                        | 242 ++++++++
 block/blk-merge.c                         |  11 +
 block/bounce.c                            |  12 +-
 block/keyslot-manager.c                   | 426 ++++++++++++++
 drivers/md/dm.c                           |   3 +-
 drivers/scsi/ufs/Kconfig                  |   9 +
 drivers/scsi/ufs/Makefile                 |   1 +
 drivers/scsi/ufs/ufshcd-crypto.c          | 391 +++++++++++++
 drivers/scsi/ufs/ufshcd-crypto.h          | 107 ++++
 drivers/scsi/ufs/ufshcd.c                 |  56 +-
 drivers/scsi/ufs/ufshcd.h                 |  25 +
 drivers/scsi/ufs/ufshci.h                 |  67 ++-
 fs/buffer.c                               |   2 +
 fs/crypto/Kconfig                         |   6 +
 fs/crypto/Makefile                        |   1 +
 fs/crypto/bio.c                           |  28 +-
 fs/crypto/crypto.c                        |   2 +-
 fs/crypto/fname.c                         |   4 +-
 fs/crypto/fscrypt_private.h               | 122 +++-
 fs/crypto/inline_crypt.c                  | 319 +++++++++++
 fs/crypto/keyring.c                       |   4 +-
 fs/crypto/keysetup.c                      | 102 ++--
 fs/crypto/keysetup_v1.c                   |  16 +-
 fs/ext4/ext4.h                            |   1 +
 fs/ext4/inode.c                           |   4 +-
 fs/ext4/page-io.c                         |   6 +-
 fs/ext4/readpage.c                        |  11 +-
 fs/ext4/super.c                           |  13 +
 fs/f2fs/data.c                            |  65 ++-
 fs/f2fs/f2fs.h                            |   3 +
 fs/f2fs/super.c                           |  41 ++
 include/linux/bio-crypt-ctx.h             | 193 +++++++
 include/linux/bio.h                       |   1 +
 include/linux/blk-crypto.h                |  63 +++
 include/linux/blk_types.h                 |   6 +
 include/linux/blkdev.h                    |   6 +
 include/linux/fscrypt.h                   |  58 ++
 include/linux/keyslot-manager.h           |  60 ++
 47 files changed, 3462 insertions(+), 112 deletions(-)
 create mode 100644 Documentation/block/inline-encryption.rst
 create mode 100644 block/bio-crypt-ctx.c
 create mode 100644 block/blk-crypto-fallback.c
 create mode 100644 block/blk-crypto-internal.h
 create mode 100644 block/blk-crypto.c
 create mode 100644 block/keyslot-manager.c
 create mode 100644 drivers/scsi/ufs/ufshcd-crypto.c
 create mode 100644 drivers/scsi/ufs/ufshcd-crypto.h
 create mode 100644 fs/crypto/inline_crypt.c
 create mode 100644 include/linux/bio-crypt-ctx.h
 create mode 100644 include/linux/blk-crypto.h
 create mode 100644 include/linux/keyslot-manager.h

-- 
2.24.1.735.g03f4e72817-goog

