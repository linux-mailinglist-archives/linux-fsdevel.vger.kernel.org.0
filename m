Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07EC7182A21
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Mar 2020 09:03:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387999AbgCLIDA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Mar 2020 04:03:00 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:54434 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388081AbgCLIDA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Mar 2020 04:03:00 -0400
Received: by mail-pl1-f202.google.com with SMTP id s13so2823143plr.21
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Mar 2020 01:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=v1joZ4izP8owZ9YLQdq3b4mfjHHQGZhG3o81B8qw0i0=;
        b=uxrkbziPyemunsGXXn6BVfwSSwIJLZkMxQBkrJPC2722Q2JRo1BIrQCrtXN/Qt+mmD
         g62Jjmwki5oOEFVyoTlzwB1IAx2omEj4wMJZp6hJJFlQIkbxlUj/RoeFVGrZBWK6ah2d
         nG4u41clPOcJ0qO425BCxDhVQybFsKpTLMNyb8AFIw8Bwj3E00Cl/27Ign7TQal5/LIc
         T2uRgaw5W1ILQ/guHbyA36qU7Wd60y23xo+PF/byhZc8p2dhUqCyD41B5m3oqnpIzSH1
         RdZVjimaCuTHIdbGM2fyu6nRYvHu6XgELdNMdU56iIFvrQ0gcj5YDlxZ66x+Fv4gA6mH
         zwEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=v1joZ4izP8owZ9YLQdq3b4mfjHHQGZhG3o81B8qw0i0=;
        b=MLEcEFdOrAVaH3zs9eKT0u49daDVELYA+AJubsae8r84ahvotr2NiXw2SAU1N96wXe
         3tJy84nEw2ZYi4owNTayVsFR6LxfoPdn3vGYlom3IgSUH4BeGbwUQwZPaxxwtLcddbJl
         vZfRvDGjpXX0nbNjguvYYht2Emriaq5S7Y5Daa/JRerqKCxiAAK7leEeUn4T0srBpqR2
         FBST6Y4y3gBBwr9TJa2XH5EC7TMg5HOs8lUoqGUwG1UkxkLn2U+W01bOLRO8IfKXPo75
         SSQowAx1mimMHda/n00vPEURk6hufei6unaQ4meD5hhVrca/Nhg0RFjcE2nhAqfrFDYg
         iaDw==
X-Gm-Message-State: ANhLgQ1QjBDpvTK+9FmRVvVwJ1miYwX7uOATzmXi27XV1jDFrdsvDzNR
        CQlQXmC1n3cwFi0Ff8aZ4SMvXn/9x58=
X-Google-Smtp-Source: ADFU+vu8wFQIUpKNik9IYq35s/f4Al5Gs4y868LUeHwc7Minys2zPFVLd1heobq34UjTYcga3/cnVERYAjQ=
X-Received: by 2002:a17:90b:19ca:: with SMTP id nm10mr2744661pjb.161.1584000178705;
 Thu, 12 Mar 2020 01:02:58 -0700 (PDT)
Date:   Thu, 12 Mar 2020 01:02:42 -0700
Message-Id: <20200312080253.3667-1-satyat@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
Subject: [PATCH v8 00/11] Inline Encryption Support
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

Note that the patches in this series for the block layer (i.e. patches 1, 2,
3 and 4) can be applied independently of the subsequent patches in this
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

Patch 3 precludes inline encryption support in a device whenever it
supports blk-integrity, because there is currently no known hardware that
supports both features, and it is not completely straightfoward to support
both of them properly, and doing it improperly might result in leaks of
information about the plaintext.

Patch 4 introduces blk-crypto-fallback - a kernel crypto API fallback for
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

Patches 5-7 add support for inline encryption into the UFS driver according
to the JEDEC UFS HCI v2.1 specification. Inline encryption support for
other drivers (like eMMC) may be added in the same way - the device driver
should set up a Keyslot Manager in the device's request_queue (refer to
the UFS crypto additions in ufshcd-crypto.c and ufshcd.c for an example).

Patch 8 adds the SB_INLINECRYPT mount flag to the fs layer, which filesystems
must set to indicate that they want to use blk-crypto for en/decryption of
file contents.

Patch 9 adds support to fscrypt - to use inline encryption with fscrypt,
the filesystem must be mounted with '-o inlinecrypt' - when this option is
specified, the contents of any AES-256-XTS encrypted file will be
encrypted using blk-crypto.

Patches 10 and 11 add support to f2fs and ext4 respectively, so that we have
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

Satya Tangirala (10):
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
 Documentation/block/inline-encryption.rst | 195 +++++++
 Documentation/filesystems/f2fs.txt        |   6 +
 block/Kconfig                             |  17 +
 block/Makefile                            |   2 +
 block/bio-integrity.c                     |   5 +
 block/bio.c                               |   9 +-
 block/blk-core.c                          |  27 +-
 block/blk-crypto-fallback.c               | 662 ++++++++++++++++++++++
 block/blk-crypto-internal.h               | 168 ++++++
 block/blk-crypto.c                        | 429 ++++++++++++++
 block/blk-integrity.c                     |   7 +
 block/blk-map.c                           |   2 +
 block/blk-merge.c                         |  11 +
 block/blk-mq.c                            |  15 +
 block/blk.h                               |   5 +
 block/bounce.c                            |   3 +
 block/keyslot-manager.c                   | 397 +++++++++++++
 drivers/md/dm.c                           |   4 +
 drivers/scsi/ufs/Kconfig                  |   9 +
 drivers/scsi/ufs/Makefile                 |   1 +
 drivers/scsi/ufs/ufshcd-crypto.c          | 397 +++++++++++++
 drivers/scsi/ufs/ufshcd-crypto.h          |  68 +++
 drivers/scsi/ufs/ufshcd.c                 |  61 +-
 drivers/scsi/ufs/ufshcd.h                 |  27 +
 drivers/scsi/ufs/ufshci.h                 |  67 ++-
 fs/buffer.c                               |   7 +-
 fs/crypto/Kconfig                         |   6 +
 fs/crypto/Makefile                        |   1 +
 fs/crypto/bio.c                           |  51 ++
 fs/crypto/crypto.c                        |   2 +-
 fs/crypto/fname.c                         |   4 +-
 fs/crypto/fscrypt_private.h               | 120 +++-
 fs/crypto/inline_crypt.c                  | 328 +++++++++++
 fs/crypto/keyring.c                       |   4 +-
 fs/crypto/keysetup.c                      |  92 ++-
 fs/crypto/keysetup_v1.c                   |  16 +-
 fs/ext4/inode.c                           |   4 +-
 fs/ext4/page-io.c                         |   6 +-
 fs/ext4/readpage.c                        |  11 +-
 fs/ext4/super.c                           |   9 +
 fs/f2fs/compress.c                        |   2 +-
 fs/f2fs/data.c                            |  68 ++-
 fs/f2fs/f2fs.h                            |   3 +
 fs/f2fs/super.c                           |  33 ++
 fs/proc_namespace.c                       |   1 +
 include/linux/blk-crypto.h                | 130 +++++
 include/linux/blk_types.h                 |   6 +
 include/linux/blkdev.h                    |  41 ++
 include/linux/fs.h                        |   1 +
 include/linux/fscrypt.h                   |  57 ++
 include/linux/keyslot-manager.h           | 108 ++++
 53 files changed, 3622 insertions(+), 90 deletions(-)
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
2.25.1.481.gfbce0eb801-goog

