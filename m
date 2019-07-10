Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A96164ED7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jul 2019 00:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727625AbfGJW4P (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Jul 2019 18:56:15 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:56806 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727516AbfGJW4P (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Jul 2019 18:56:15 -0400
Received: by mail-pl1-f201.google.com with SMTP id o6so2051749plk.23
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Jul 2019 15:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=32EvgBFnAv8ONpLqCSd3ioyTEVOAmc+wOjmDzUT8IVQ=;
        b=U98632Z82hYy5Krk4Woknk4M3J9Oxbj8OLfRcRkOhGhPsLAgvlQ8rL9cjAJhLQGT0e
         nCfY2aMLctKH69TtquMoZpasiCSaNu9WP3yBAzUUbRQV4pKQdoUmylbSx427Z6QJe+Zc
         XUyFaop39sDlqJv7rWzmRkcjpxyL+cehPcD3+KZr4BOSB2t4QIKV2J9aUANKGFF0b4RV
         SEPT/+e+lPQTrLb0lC8jN6riSephuN1tXaX5Jqeb9/n+hVCc1tFDWqp8O6PDklw8PheP
         TahcnXsLHuoRbvMEJGYz1WRDNelCbzAdlcE/6FLE+qvY21MZ2HRfX3yQtfzql02E8Qjb
         zszA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=32EvgBFnAv8ONpLqCSd3ioyTEVOAmc+wOjmDzUT8IVQ=;
        b=a5vbtNvmPvy07j44SFUkwXpBiLk6OunwzaH9f7E/u8KnyaZa5IvQWhpCqE6UMS238a
         QtDd+VVxdYPKPruOAqhWyZnzRKXlanIkq09laAYmdNTtWLVY3eCf3uylt4YhMwKJH7YT
         LuqrleLMBEu0+1ZkHo4BRmcsQ3Pjfsb7T+5z3kbE/qYzgGCc1dGTxkICAi2+Kd7Rye58
         dNoJUPMfCGyyOTaCylDpaVsu9RIdpxVd/C3pEFQDGAEoDdc/jj9ezLpI8vj8H53/L/lR
         UG2hRn9qnlVRaXczoiySGM/09NmvBYDp9hMeGvk2FRgbmcgs+z+xk5NYfsi6D97BTC4N
         YgLw==
X-Gm-Message-State: APjAAAXSWEZXTD5gy564VbItbytlHl+usGThobCU/5zO7nmDXNH5rrxt
        +grS1zaARMbLPW6DkVWZiPwmkHCoPu4=
X-Google-Smtp-Source: APXvYqzdWJGCD39Cu1PKryLNuGp95rnlt/uZL9RjQk8mERUDsK4hp6quJ1mm2cPMcmKqqfHIDneVHcjisAg=
X-Received: by 2002:a63:b904:: with SMTP id z4mr749685pge.388.1562799373417;
 Wed, 10 Jul 2019 15:56:13 -0700 (PDT)
Date:   Wed, 10 Jul 2019 15:56:01 -0700
Message-Id: <20190710225609.192252-1-satyat@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v3 0/8] Inline Encryption Support
From:   Satya Tangirala <satyat@google.com>
To:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Parshuram Raju Thombare <pthombar@cadence.com>,
        Ladvine D Almeida <ladvine.dalmeida@synopsys.com>,
        Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Satya Tangirala <satyat@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch series adds support for Inline Encryption to the block layer,
UFS, fscrypt and f2fs.

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
(introduced in Path 3), will use to program keys into inline encryption
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
to Documentation/block/blk-crypto.txt.

Patches 4-6 add support for inline encryption into the UFS driver according
to the JEDEC UFS HCI v2.1 specification. Inline encryption support for
other drivers (like eMMC) may be added in the same way - the device driver
should set up a Keyslot Manager in the device's request_queue (refer to
the UFS crypto additions in ufshcd-crypto.c and ufshcd.c for an example).

Patches 7 and 8 add support to fscrypt and f2fs, so that we have
a complete stack that can make use of inline encryption.

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

Changes v2 => v3:
 - Overhauled keyslot manager's get keyslot logic and optimized LRU.
 - Block crypto en/decryption fallback now supports data unit sizes
   that divide each of the bio's segment's lengths (instead of requiring
   each segment's length to be the same as the data unit size).
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

Satya Tangirala (8):
  block: Keyslot Manager for Inline Encryption
  block: Add encryption context to struct bio
  block: blk-crypto for Inline Encryption
  scsi: ufs: UFS driver v2.1 spec crypto additions
  scsi: ufs: UFS crypto API
  scsi: ufs: Add inline encryption support to UFS
  fscrypt: wire up fscrypt to use blk-crypto
  f2fs: Wire up f2fs to use inline encryption via fscrypt

 Documentation/block/inline-encryption.txt | 185 +++++++
 block/Kconfig                             |   8 +
 block/Makefile                            |   2 +
 block/bio-crypt-ctx.c                     | 122 +++++
 block/bio.c                               |  16 +-
 block/blk-core.c                          |  11 +-
 block/blk-crypto.c                        | 585 ++++++++++++++++++++++
 block/blk-merge.c                         |  34 +-
 block/bounce.c                            |   9 +-
 block/keyslot-manager.c                   | 314 ++++++++++++
 drivers/md/dm.c                           |  15 +-
 drivers/scsi/ufs/Kconfig                  |  10 +
 drivers/scsi/ufs/Makefile                 |   1 +
 drivers/scsi/ufs/ufshcd-crypto.c          | 435 ++++++++++++++++
 drivers/scsi/ufs/ufshcd-crypto.h          |  86 ++++
 drivers/scsi/ufs/ufshcd.c                 |  84 +++-
 drivers/scsi/ufs/ufshcd.h                 |  29 ++
 drivers/scsi/ufs/ufshci.h                 |  67 ++-
 fs/crypto/Kconfig                         |   6 +
 fs/crypto/bio.c                           | 138 ++++-
 fs/crypto/crypto.c                        |   4 +
 fs/crypto/fscrypt_private.h               |  11 +
 fs/crypto/keyinfo.c                       |  94 +++-
 fs/crypto/policy.c                        |  10 +
 fs/f2fs/data.c                            |  83 ++-
 fs/f2fs/super.c                           |  13 +-
 include/linux/bio.h                       | 208 ++++++++
 include/linux/blk-crypto.h                |  40 ++
 include/linux/blk_types.h                 |   7 +
 include/linux/blkdev.h                    |   6 +
 include/linux/fscrypt.h                   |  62 +++
 include/linux/keyslot-manager.h           |  75 +++
 include/uapi/linux/fs.h                   |   3 +-
 33 files changed, 2697 insertions(+), 76 deletions(-)
 create mode 100644 Documentation/block/inline-encryption.txt
 create mode 100644 block/bio-crypt-ctx.c
 create mode 100644 block/blk-crypto.c
 create mode 100644 block/keyslot-manager.c
 create mode 100644 drivers/scsi/ufs/ufshcd-crypto.c
 create mode 100644 drivers/scsi/ufs/ufshcd-crypto.h
 create mode 100644 include/linux/blk-crypto.h
 create mode 100644 include/linux/keyslot-manager.h

-- 
2.22.0.410.gd8fdbe21b5-goog

