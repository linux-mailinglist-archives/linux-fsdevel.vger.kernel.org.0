Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E890D22CDF7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jul 2020 20:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbgGXSpI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Jul 2020 14:45:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726493AbgGXSpH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Jul 2020 14:45:07 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1742C0619E4
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jul 2020 11:45:06 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id 75so6920893pfb.21
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jul 2020 11:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=lsSlCMXcrL561eOWGmFFIuL3TkBKEtn1RBBptVeIF5U=;
        b=Qg0up90J4SnyNR+ZP3m8Qvg7/DArL5ftn8TN8LfRiwq168u1P5eKlX77F5+Cf8umeo
         x8NQkxIEgNQAiroGdaws5+VVMVyLph4zgaNnQhL6kv1AFTlBMi21N3/gNQWtSC4t6wka
         XeDdlpKADSg2TLkM2w1VN66GgDqgab1oYrOk8ecyhdNovpeF0bdOQGMjsIETLwCEwXsj
         BdVNJpNiBmbiPCBsEoEu510sgysnga5/Ri/ss20QWq5Lcs3fZGGuFYvfidXQ+2tCE7Gg
         0FIvf5Efxgc/blFLi0/a0k0n0xPH9QYiNH39/nAD38DlF43ICn5uHyQ5gAJKLyb5v2g1
         5PnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=lsSlCMXcrL561eOWGmFFIuL3TkBKEtn1RBBptVeIF5U=;
        b=sS86Rp8lFJQW7QB3R76bC8KHvqExpFXt8bZX/z0p+gldAq7MFB3lTZLHEqJCmfxosh
         VOIPqTHBKDlyu2oZDtnAR2IeH41kSg/+4lilcLS96Sdt2UaVy2wBjiCqLT57h5O94q0W
         Emz5yrQAmfrOT59BPOFb5qmtit/wQ/5JfEqAbqGXt1l8MZIlkY9x1nZq5du3zvHeIPkV
         1kIWHRMLo4zTpj+/YGjb/agmS9ln8m90deTikxXOP9scOQn9pkDjhKz0IDA3IdTnkybJ
         4M0XDjgX84x/8JBTsZ8LglEVE2TCtJAiFuYeVvWHr3/+oyuGRXD0h2Tb4xGjrpv/XO3v
         zr7Q==
X-Gm-Message-State: AOAM53397WljsZ9f0morMe19+qPb0bJMD2+qDazDTu37ajvLPiNX7n31
        +O6TVVCHFpNl8WQ4tGxi7CR92WIoEoc=
X-Google-Smtp-Source: ABdhPJyGXJ1seF6nCvIFHEXKfsy1coxsncYfx+wOXBYkTBimaK5lPWApmoEQlte7Ys/66ppi4YAUPIe/CbY=
X-Received: by 2002:a17:90a:5208:: with SMTP id v8mr7061294pjh.29.1595616306258;
 Fri, 24 Jul 2020 11:45:06 -0700 (PDT)
Date:   Fri, 24 Jul 2020 18:44:54 +0000
Message-Id: <20200724184501.1651378-1-satyat@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.rc0.142.g3c755180ce-goog
Subject: [PATCH v6 0/7] add support for direct I/O with fscrypt using blk-crypto
From:   Satya Tangirala <satyat@google.com>
To:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org
Cc:     linux-xfs@vger.kernel.org, Satya Tangirala <satyat@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch series adds support for direct I/O with fscrypt using
blk-crypto. It has been rebased on fscrypt/master (i.e. the "master"
branch of the fscrypt tree at
https://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git)

Patch 1 adds two functions to fscrypt that need to be called to determine
if direct I/O is supported for a request.

Patches 2 and 3 modify direct-io and iomap respectively to set bio crypt
contexts on bios when appropriate by calling into fscrypt.

Patches 4 and 5 allow ext4 and f2fs direct I/O to support fscrypt without
falling back to buffered I/O.

Patches 6 and 7 update the fscrypt documentation for inline encryption
support and direct I/O. The documentation now notes the required conditions
for inline encryption and direct I/O on encrypted files.

This patch series was tested by running xfstests with test_dummy_encryption
with and without the 'inlinecrypt' mount option, and there were no
meaningful regressions. One regression was for generic/587 on ext4,
but that test isn't compatible with test_dummy_encryption in the first
place, and the test "incorrectly" passes without the 'inlinecrypt' mount
option - a patch will be sent out to exclude that test when
test_dummy_encryption is turned on with ext4 (like the other quota related
tests that use user visible quota files). The other regression was for
generic/252 on ext4, which does direct I/O with a buffer aligned to the
block device's blocksize, but not necessarily aligned to the filesystem's
block size, which direct I/O with fscrypt requires.

Changes v5 => v6:
 - fix bug with fscrypt_limit_io_blocks() and make it ready for 64 bit
   block numbers.
 - remove Reviewed-by for Patch 1 due to significant changes from when
   the Reviewed-by was given.

Changes v4 => v5:
 - replace fscrypt_limit_io_pages() with fscrypt_limit_io_block(), which
   is now called by individual filesystems (currently only ext4) instead
   of the iomap code. This new function serves the same end purpose as
   the one it replaces (ensuring that DUNs within a bio are contiguous)
   but operates purely with blocks instead of with pages.
 - make iomap_dio_zero() set bio_crypt_ctx's again, instead of just a
   WARN_ON() since some folks prefer that instead.
 - add Reviewed-by's

Changes v3 => v4:
 - Fix bug in iomap_dio_bio_actor() where fscrypt_limit_io_pages() was
   being called too early (thanks Eric!)
 - Improve comments and fix formatting in documentation
 - iomap_dio_zero() is only called to zero out partial blocks, but
   direct I/O is only supported on encrypted files when I/O is
   blocksize aligned, so it doesn't need to set encryption contexts on
   bios. Replace setting the encryption context with a WARN_ON(). (Eric)

Changes v2 => v3:
 - add changelog to coverletter

Changes v1 => v2:
 - Fix bug in f2fs caused by replacing f2fs_post_read_required() with
   !fscrypt_dio_supported() since the latter doesn't check for
   compressed inodes unlike the former.
 - Add patches 6 and 7 for fscrypt documentation
 - cleanups and comments

Eric Biggers (5):
  fscrypt: Add functions for direct I/O support
  direct-io: add support for fscrypt using blk-crypto
  iomap: support direct I/O with fscrypt using blk-crypto
  ext4: support direct I/O with fscrypt using blk-crypto
  f2fs: support direct I/O with fscrypt using blk-crypto

Satya Tangirala (2):
  fscrypt: document inline encryption support
  fscrypt: update documentation for direct I/O support

 Documentation/filesystems/fscrypt.rst | 36 +++++++++++--
 fs/crypto/crypto.c                    |  8 +++
 fs/crypto/inline_crypt.c              | 74 +++++++++++++++++++++++++++
 fs/direct-io.c                        | 15 +++++-
 fs/ext4/file.c                        | 10 ++--
 fs/ext4/inode.c                       |  7 +++
 fs/f2fs/f2fs.h                        |  6 ++-
 fs/iomap/direct-io.c                  |  6 +++
 include/linux/fscrypt.h               | 18 +++++++
 9 files changed, 171 insertions(+), 9 deletions(-)

-- 
2.28.0.rc0.142.g3c755180ce-goog

