Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9CFA2119D5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jul 2020 03:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728022AbgGBB4M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Jul 2020 21:56:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726792AbgGBB4L (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Jul 2020 21:56:11 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 437AAC08C5DB
        for <linux-fsdevel@vger.kernel.org>; Wed,  1 Jul 2020 18:56:11 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id f16so28308409ybp.5
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Jul 2020 18:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=xAITaULtdMDEOzvw+l2Rasjf1QfU0QQ930xQ9EFFDhw=;
        b=mJr6dns1TdHPLaPk1l1nUCN4IUtvYtOpMd2odmYKWwr0/WbLXDSazaIVv1ciEv9fJ6
         SutKMg5RIy1dEiGwT8tnYEFpjFd9W3ngQvNkiALl+UdZ0ZpNdu4FjIE80wjAdsRl8PXr
         qpPoSKhwncdhK0vfriwJb2pRIZrTdVXv1cetv5y7HizWBttesdKay1ggMdGpx0GXDBNT
         5dmnOm8hmCDyzG+8x4qUxQgWyr8aQpbgx3O9tMQF8yy3S+D+8d8nHIzsCTwDEX5dtTE9
         viXRGOQoHfzNzEwu76bLCC0Nna/lluLtAlSJGwqypdkfxZWTZKMdIexOw/mnSePGmjfr
         uazg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=xAITaULtdMDEOzvw+l2Rasjf1QfU0QQ930xQ9EFFDhw=;
        b=arUxwVJwwgGAEPz26BzRbOCt5pWryH85Vhnms//Rb9e+4WKKkH847BM/pRscVGvIo9
         QURO5aNXsZwjK/eJM59LgWowB9WzmYQAaKIVQ0K+2khSU1A4HWMN7Jw41x9aVjXhJ3wD
         1VWAjyrjqTcIF/Kk/+CWF5bKyNiKYJ6C+m8CWTY4C4/EZEmxvZAT3Q4eTufQvO5x7TO4
         B7Rx9L8O/mZfnRDNfJ/Z7J6eCFb9/qqerw6igXLsesJnXtvjSwl4/aPrbDJQcCSsThJ8
         2i7b5Ik4q52Hjw0/V9isrg5C8L1fJ9ktSoxJs9hFo+e4hsXM+/9/rcjVylp1oliw6Ja2
         2faA==
X-Gm-Message-State: AOAM530GVbTp8OkPrdnXJxP+tCXPLbQr5W0dfVdBj5EaNR+y02cJ/cz0
        3kcOKjRgCKSd1ruTWzccVVtSrgBYYkU=
X-Google-Smtp-Source: ABdhPJwJQVRpteo2WlW4RD45U90u9w3Bir/5IPPjxXl6Q7riTU/fQWHTNswcF38H+KG41biaAsLKtQ7YqWM=
X-Received: by 2002:a25:3bca:: with SMTP id i193mr46883130yba.182.1593654970400;
 Wed, 01 Jul 2020 18:56:10 -0700 (PDT)
Date:   Thu,  2 Jul 2020 01:56:03 +0000
Message-Id: <20200702015607.1215430-1-satyat@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
Subject: [PATCH v4 0/4] Inline Encryption Support for fscrypt
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
the block layer, and has been rebased on v5.8-rc3. Note that Patches 1 and
2 can be applied independently of Patches 3 and 4 (and Patches 3 and 4 can
be applied independently of each other).

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

Changes v3 => v4
 - change the page_is_mergeable() check in add_ipu_page() to an f2fs_bug_on
   since the only caller of add_ipu_page() already checks page_is_mergeable
 - add reviewed by

Changes v2 => v3
 - Fix issue with inline encryption + IV_INO_LBLK_32 policy found by Eric
 - minor cleanup

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

 Documentation/admin-guide/ext4.rst    |   7 +
 Documentation/filesystems/f2fs.rst    |   7 +
 Documentation/filesystems/fscrypt.rst |   3 +
 fs/buffer.c                           |   7 +-
 fs/crypto/Kconfig                     |   6 +
 fs/crypto/Makefile                    |   1 +
 fs/crypto/bio.c                       |  51 ++++
 fs/crypto/crypto.c                    |   2 +-
 fs/crypto/fname.c                     |   4 +-
 fs/crypto/fscrypt_private.h           | 115 +++++++-
 fs/crypto/inline_crypt.c              | 364 ++++++++++++++++++++++++++
 fs/crypto/keyring.c                   |   6 +-
 fs/crypto/keysetup.c                  |  70 +++--
 fs/crypto/keysetup_v1.c               |  16 +-
 fs/ext4/inode.c                       |   4 +-
 fs/ext4/page-io.c                     |   6 +-
 fs/ext4/readpage.c                    |  11 +-
 fs/ext4/super.c                       |  12 +
 fs/f2fs/compress.c                    |   2 +-
 fs/f2fs/data.c                        |  79 +++++-
 fs/f2fs/super.c                       |  35 +++
 include/linux/fs.h                    |   1 +
 include/linux/fscrypt.h               |  82 ++++++
 23 files changed, 820 insertions(+), 71 deletions(-)
 create mode 100644 fs/crypto/inline_crypt.c

-- 
2.27.0.212.ge8ba1cc988-goog

