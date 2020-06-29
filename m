Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DBFD20E194
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jun 2020 23:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389997AbgF2U50 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Jun 2020 16:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731043AbgF2TNG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:13:06 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F830C0F26C5
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jun 2020 05:04:13 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id t7so2656149pjl.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jun 2020 05:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=OgrownsdciRkQfHLu2Mfy3btRxxtBKOX+y4E3Oqteos=;
        b=gBiZCVlEO4XDHJNS23BhAsQTP1jO1/1YSpaH/WgvMSS3FuMlqd+4vKZrSzJYaWnl/Y
         1n1gSdCt3z+pNV3CigPeOXG4eWXKbpivWBuPyrfPGp1RIgFeEDVv/cPemO6wV3JCho0e
         jtOIYCZIL5m5allS+ROBU+GL06J1VYIuxb9Z5y9RT3Zi8IiwzIYN+bmBk1wt2JfYac8c
         Ye2I8lshSh/FtnYECOI3yuRPOKNSi/QlD9zFMx5r0MsMNroQ3ZPLZjUGeLkHYYQ4sm3/
         3luLSZG+zTmBtBG1Ed7XTgsbFfmZSkITPVvXtYQ1D95XhQY/gcG72x8y0aBQeNDpQhaa
         CvEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=OgrownsdciRkQfHLu2Mfy3btRxxtBKOX+y4E3Oqteos=;
        b=IdvGWG7ELfb0TyE95HJbTJlRuivX9FozTzcXvdjz38HSISSd6PKCKqLFYG9q6eJ4/J
         Wzn+6m1KrmKVkPzeFA/DGM1VpM6u82J14Cu4shjTgFMSRN/QFFULop1lkxCQd/K6r3uF
         M02lMLnc2iy//E7/iou+hrj3Mu2uFo1rtstZj3jdlu9uTRHc0FBfuhY/mRNPj3Xws38/
         0cA6KuuwL7bi2CQAKqxogloedR1fEE3jBCuL16flt/qyRhS7H5qTBYE75Kg1p50bx+Xf
         eLrG0vedg1H8eeQAHWVm/NEA1QNQ2BgA0+REse9TzqrWvs5AfmMMkTjt3XZPLAaDFA5j
         3NeQ==
X-Gm-Message-State: AOAM530/HQ5smd9JsxkKhcItXq6O4Rfyl6vpR//jFnLc90a6OqAmisex
        7VD3WE8MJOcBh1NPPEc6RsndcHd4GF8=
X-Google-Smtp-Source: ABdhPJwYLTVSt9n1XjUVygrqIZ2mKYtW5G+8LSUlIBRmnIEmdQxeGLDbPT+he1blzav1wz1DLUaRqIPqKYM=
X-Received: by 2002:a17:902:c408:: with SMTP id k8mr13536731plk.279.1593432252439;
 Mon, 29 Jun 2020 05:04:12 -0700 (PDT)
Date:   Mon, 29 Jun 2020 12:04:01 +0000
Message-Id: <20200629120405.701023-1-satyat@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
Subject: [PATCH v2 0/4] Inline Encryption Support for fscrypt
From:   Satya Tangirala <satyat@google.com>
To:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org
Cc:     Satya Tangirala <satyat@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch series adds support for Inline Encryption to fscrypt, f2fs
and ext4. It builds on the inline encryption support now present in
the block layer, and has been rebased on v5.8-rc3.

This patch series previously went though a number of iterations as part
of the "Inline Encryption Support" patchset (last version was v13:
https://lkml.kernel.org/r/20200514003727.69001-1-satyat@google.com).

Patch 1 introduces the SB_INLINECRYPT sb options, which filesystems
should set if they want to use blk-crypto for file content en/decryption.

Patch 2 adds inline encryption support to fscrypt. To use inline
encryption with fscrypt, the filesystem must set the above mentioned
SB_INLINECRYPT sb option. When this option is set, the contents of
encrypted files will be en/decrypted using blk-crypto.

Patches 3 and 4 wire up f2fs and ext4 respectively to fscrypt support for
inline encryption, and e.g ensure that bios are submitted with blocks
that not only are contiguous, but also have continuous DUNs.

This patchset was tested by running xfstests with the "inlinecrypt" mount
option on ext4 and f2fs with test dummy encryption (the actual
en/decryption of file contents was handled by the blk-crypto-fallback). It
was also tested along with the UFS patches from the original series on some
Qualcomm and Mediatek chipsets with hardware inline encryption support
(refer to
https://lkml.kernel.org/linux-scsi/20200501045111.665881-1-ebiggers@kernel.org/
and
https://lkml.kernel.org/linux-scsi/20200304022101.14165-1-stanley.chu@mediatek.com/
for more details on those tests).

Changes v1 => v2
 - SB_INLINECRYPT mount option is shown by individual filesystems instead
   of by the common VFS code since the option is parsed by filesystem
   specific code, and is not a mount option applicable generically to
   all filesystems.
 - Make fscrypt_select_encryption_impl() return error code when it fails
   to allocate memory.
 - cleanups
 
Changes v13 in original patchset => v1
 - rename struct fscrypt_info::ci_key to ci_enc_key
 - set dun bytes more precisely in fscrypt
 - cleanups

Eric Biggers (1):
  ext4: add inline encryption support

Satya Tangirala (3):
  fs: introduce SB_INLINECRYPT
  fscrypt: add inline encryption support
  f2fs: add inline encryption support

 Documentation/admin-guide/ext4.rst    |   6 +
 Documentation/filesystems/f2fs.rst    |   7 +
 Documentation/filesystems/fscrypt.rst |   3 +
 fs/buffer.c                           |   7 +-
 fs/crypto/Kconfig                     |   6 +
 fs/crypto/Makefile                    |   1 +
 fs/crypto/bio.c                       |  50 ++++
 fs/crypto/crypto.c                    |   2 +-
 fs/crypto/fname.c                     |   4 +-
 fs/crypto/fscrypt_private.h           | 115 ++++++++-
 fs/crypto/inline_crypt.c              | 351 ++++++++++++++++++++++++++
 fs/crypto/keyring.c                   |   6 +-
 fs/crypto/keysetup.c                  |  70 +++--
 fs/crypto/keysetup_v1.c               |  16 +-
 fs/ext4/inode.c                       |   4 +-
 fs/ext4/page-io.c                     |   6 +-
 fs/ext4/readpage.c                    |  11 +-
 fs/ext4/super.c                       |  12 +
 fs/f2fs/compress.c                    |   2 +-
 fs/f2fs/data.c                        |  78 +++++-
 fs/f2fs/super.c                       |  35 +++
 include/linux/fs.h                    |   1 +
 include/linux/fscrypt.h               |  82 ++++++
 23 files changed, 804 insertions(+), 71 deletions(-)
 create mode 100644 fs/crypto/inline_crypt.c

-- 
2.27.0.212.ge8ba1cc988-goog

