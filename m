Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91D9E367F6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jun 2019 01:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbfFEX2m (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jun 2019 19:28:42 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:54788 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726561AbfFEX2l (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jun 2019 19:28:41 -0400
Received: by mail-pg1-f201.google.com with SMTP id c4so213972pgm.21
        for <linux-fsdevel@vger.kernel.org>; Wed, 05 Jun 2019 16:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=gRO0aIkjYMBsNBc7+DIoU7JX9NOgY+kGQd5/xewYXlk=;
        b=UjUsYqhMfjCSgtwICU9RcqL+xxeWNLvzgYi4TAJ5I4+IMVG8sbSlWkpZQSp+j4nuQq
         97fA9gvCpbvVs5BjpH/06h+5CHQfsMA0GeR3A9KlwdxUpYZFJVu6I3oKcNzlXEuRPpwh
         HQYx91WCnQG84EuhE0DYB9w5B3XQlJ1mN4lKjtPqmOF1IXGgoq06Z6vYhwctzUT6GNcz
         NL71raZfKYlyZ/oTRi6rtLIOLmWxdVntpcjynPpC8JZRh0QJ+MQpzecIaSF8TamuwwJX
         Ss8ZvCG8BLDIfrxxjZ8LYkSt5b90qIAHMKhVUYm5Nlyo1YBeMiXm1L3zPtKfBJMUwuk6
         sNNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=gRO0aIkjYMBsNBc7+DIoU7JX9NOgY+kGQd5/xewYXlk=;
        b=Sdr3H0yk3+ONhR9DEIxuf4wsjr2n50nD7feSQpTgU9Ycm8p3XXyVi/atmgJqf05w5q
         P/7CSvcQB2NpOebIPD06+ZiLbrM1QaAamfL5zsfn6liaGcgmjy8J9VJvwYK/d3yzInLe
         NLKLARaLXJUjZmSwpqXkImMF5qUgfYvRZIqUTP4dZyZDS+BBTLMvSWGThk6+q1romsE2
         LeN7zX2X25vwk2DJ6NbjEoOaqaQy/EkmpNFlHGl8qBSBeIItginwpbooli5/cuTWwnDE
         /BOlYH4dG4XXlyT76tejr7sVakSWIvrXYUCrdieFubnWdax8Iju0hOCcSO9KXcFMk7TT
         koaQ==
X-Gm-Message-State: APjAAAVQChbADK5p67SjrzEQ2zDLeWIfZaw0chzTmZ3r228WW7gwKi//
        KJzK5eK39NgOJTac0ysqWy3rP/0do8Q=
X-Google-Smtp-Source: APXvYqzXuluP1xJXv83KQJmBTl6O5tQhTtSaDuikoPQNfY1VHAjaLmhSxTETZknHp6ujJjRDlasl8HLD5Ew=
X-Received: by 2002:a63:1663:: with SMTP id 35mr363300pgw.253.1559777320468;
 Wed, 05 Jun 2019 16:28:40 -0700 (PDT)
Date:   Wed,  5 Jun 2019 16:28:29 -0700
Message-Id: <20190605232837.31545-1-satyat@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.rc1.311.g5d7573a151-goog
Subject: [RFC PATCH v2 0/8] Inline Encryption Support
From:   Satya Tangirala <satyat@google.com>
To:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Parshuram Raju Thombare <pthombar@cadence.com>,
        Ladvine D Almeida <ladvine.dalmeida@synopsys.com>,
        Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
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

 Documentation/block/blk-crypto.txt | 185 ++++++++++
 block/Kconfig                      |   8 +
 block/Makefile                     |   2 +
 block/bio.c                        |  17 +-
 block/blk-core.c                   |  11 +-
 block/blk-crypt-ctx.c              |  90 +++++
 block/blk-crypto.c                 | 557 +++++++++++++++++++++++++++++
 block/blk-merge.c                  |  34 +-
 block/bounce.c                     |   9 +-
 block/keyslot-manager.c            | 315 ++++++++++++++++
 drivers/md/dm.c                    |  15 +-
 drivers/scsi/ufs/Kconfig           |  10 +
 drivers/scsi/ufs/Makefile          |   1 +
 drivers/scsi/ufs/ufshcd-crypto.c   | 438 +++++++++++++++++++++++
 drivers/scsi/ufs/ufshcd-crypto.h   |  69 ++++
 drivers/scsi/ufs/ufshcd.c          |  84 ++++-
 drivers/scsi/ufs/ufshcd.h          |  23 ++
 drivers/scsi/ufs/ufshci.h          |  67 +++-
 fs/crypto/Kconfig                  |   7 +
 fs/crypto/bio.c                    | 159 ++++++--
 fs/crypto/crypto.c                 |   9 +
 fs/crypto/fscrypt_private.h        |  10 +
 fs/crypto/keyinfo.c                |  69 ++--
 fs/crypto/policy.c                 |  10 +
 fs/f2fs/data.c                     |  77 +++-
 fs/f2fs/super.c                    |   1 +
 include/linux/bio.h                | 180 ++++++++++
 include/linux/blk-crypto.h         |  40 +++
 include/linux/blk_types.h          |  39 ++
 include/linux/blkdev.h             |   9 +
 include/linux/fscrypt.h            |  64 ++++
 include/linux/keyslot-manager.h    | 116 ++++++
 include/uapi/linux/fs.h            |  12 +-
 33 files changed, 2668 insertions(+), 69 deletions(-)
 create mode 100644 Documentation/block/blk-crypto.txt
 create mode 100644 block/blk-crypt-ctx.c
 create mode 100644 block/blk-crypto.c
 create mode 100644 block/keyslot-manager.c
 create mode 100644 drivers/scsi/ufs/ufshcd-crypto.c
 create mode 100644 drivers/scsi/ufs/ufshcd-crypto.h
 create mode 100644 include/linux/blk-crypto.h
 create mode 100644 include/linux/keyslot-manager.h

-- 
2.22.0.rc1.311.g5d7573a151-goog

