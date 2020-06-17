Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4F221FC7F7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jun 2020 09:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725964AbgFQH5i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Jun 2020 03:57:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbgFQH5i (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Jun 2020 03:57:38 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D766CC06174E
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Jun 2020 00:57:37 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id s7so1631354ybg.10
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Jun 2020 00:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=YrGLoue5k9cA5koD7/PO4iQoD6IjWXOUupBIS3VbDWk=;
        b=iFNqldV2E0w+7bBQ385IjyHcqfjU9mHdgYgoOylqrDwynqv0FkaVUtzHYnx9jORWBx
         nqLhO71PXhAxR/dettLy3H8elFoRNQ1xrwhbvwSjSMpTnH6Z3jQ1IJTsOZv7+sTTeATu
         ewCeVTcWVzetIlVH5/jaGuMBKUpHxMpGioqjOhAzRFBPHmVm36fnLoOaHDgjrTe4Vq5W
         WkrYAx7DiBNschMNjM2VxKdeL1pAKB/MwZJao3YSAovK798PHpRlhrY11GWKavUHDcr7
         aypJl1ncfu6qAqOj9ec3P89dwmhW89iV6fJz4PAYy3IWXtr9brGu8umUFOvmmF5C0398
         MWGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=YrGLoue5k9cA5koD7/PO4iQoD6IjWXOUupBIS3VbDWk=;
        b=lG7S0zMiBw7zsSVC0I8F1TqyYChmmo62MV/bl9A587qB7duURDy6UTYESPXC5GQkby
         N9tEeGcOkfHJ7xLSnOaH47sMynonmbvKNOCnE83MNUPrEp/p5FdKylBAWqBwwUFRvIDc
         SKyd8pC8FS7qiSdrZ7xg2GzjRJztakQe/nh2byAfagIMCY4Sw3zAfhiTy3vCK6ArdUGl
         wY/xDakWBY6XzPAmU4IS5/m2LcMQlyowzdRkXb959zvQ2KiCoxO5uKKtSffs6ewarQJJ
         uE5XIHT1lr+atA+WNvvkbex6b+YNRpYVUMZKuhltzzNkYiPRvpcx9fBae0AuDIL9NTUh
         /hsg==
X-Gm-Message-State: AOAM533bhpAOJdbdbTtBNR8IzJUX3RjKXvJqbVLPaGIYroFuMsmfB1kW
        BzmU7+UB0L7dJ3BwEuxLGNtS9s1qNhk=
X-Google-Smtp-Source: ABdhPJyi+r7Mo3g9hSD3snev85cZk7qSVEtvV2RBZ+GdzakmAaT064tsDCrF7yalJdTdipPDsMh0KpvnBYc=
X-Received: by 2002:a25:cbcc:: with SMTP id b195mr10932034ybg.91.1592380656942;
 Wed, 17 Jun 2020 00:57:36 -0700 (PDT)
Date:   Wed, 17 Jun 2020 07:57:28 +0000
Message-Id: <20200617075732.213198-1-satyat@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.290.gba653c62da-goog
Subject: [PATCH 0/4] Inline Encryption Support for fscrypt
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
the block layer, and has been rebased on v5.8-rc1.

Patch 1 introduces the SB_INLINECRYPT sb options, which filesystems
should set if they want to use blk-crypto for file content en/decryption.

Patch 2 adds inline encryption support to fscrypt. To use inline
encryption with fscrypt, the filesystem must set the above mentioned
SB_INLINECRYPT sb option. When this option is set, the contents of
encrypted files will be en/decrypted using blk-crypto.

Patches 3 and 4 wire up f2fs and ext4 respectively to fscrypt support for
inline encryption, and e.g ensure that bios are submitted with blocks
that not only are contiguous, but also have contiguous DUNs.

Eric Biggers (1):
  ext4: add inline encryption support

Satya Tangirala (3):
  fs: introduce SB_INLINECRYPT
  fscrypt: add inline encryption support
  f2fs: add inline encryption support

 Documentation/admin-guide/ext4.rst |   6 +
 Documentation/filesystems/f2fs.rst |   7 +-
 fs/buffer.c                        |   7 +-
 fs/crypto/Kconfig                  |   6 +
 fs/crypto/Makefile                 |   1 +
 fs/crypto/bio.c                    |  50 +++++
 fs/crypto/crypto.c                 |   2 +-
 fs/crypto/fname.c                  |   4 +-
 fs/crypto/fscrypt_private.h        | 118 +++++++++-
 fs/crypto/inline_crypt.c           | 349 +++++++++++++++++++++++++++++
 fs/crypto/keyring.c                |   6 +-
 fs/crypto/keysetup.c               |  68 ++++--
 fs/crypto/keysetup_v1.c            |  16 +-
 fs/ext4/inode.c                    |   4 +-
 fs/ext4/page-io.c                  |   6 +-
 fs/ext4/readpage.c                 |  11 +-
 fs/ext4/super.c                    |   9 +
 fs/f2fs/compress.c                 |   2 +-
 fs/f2fs/data.c                     |  81 +++++--
 fs/f2fs/super.c                    |  32 +++
 fs/proc_namespace.c                |   1 +
 include/linux/fs.h                 |   1 +
 include/linux/fscrypt.h            |  82 +++++++
 23 files changed, 794 insertions(+), 75 deletions(-)
 create mode 100644 fs/crypto/inline_crypt.c

-- 
2.27.0.290.gba653c62da-goog

