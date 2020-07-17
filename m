Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6B76223094
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jul 2020 03:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726547AbgGQBpq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Jul 2020 21:45:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726344AbgGQBpo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Jul 2020 21:45:44 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B3E5C08C5CE
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jul 2020 18:45:44 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id x1so5598216pla.10
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jul 2020 18:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=+7NEyAtngBQ+NtsVner/xkX+DqdKiAPFh6L75+tULz8=;
        b=J+mnXJRVYMafFS+o+P1bnt+16uWofUiyPCntsNg3XT8Ib1llpcyxPal6f8PIhCbEDg
         Bo3vrtVP+ewSO7mAdmr/5QJ9Q+8lznYArog6g6Yn/TfIOxtFnyBUbMMAwMzb387Hy+4n
         NQYc29hAipQB21eO+fNDCbt/nxbJdxHIpwdS6q5E+lrkLVzIPyKreakfHHlXU24OaGvS
         3sXbnd44eyIaABhMDfgRBS8/v+RMqJjd4+Y7VXgScSnrFKX+q5auEO7ITSrLsysG3q8i
         cwejZgsFGxkO262PT1lH8HbVFmp3uClJ+EgYMnzYiw35fV3DZjxG3i2PWmg+wIKT4XiR
         t2Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=+7NEyAtngBQ+NtsVner/xkX+DqdKiAPFh6L75+tULz8=;
        b=TmG81P3r9UvqnC3L6trDBJOIadMFslG6PjsX70o4WyB94/d28g2uwXKoaqucc95hCm
         vNWlnVXJ+lg4XytRE6m5+l9gVj/JJ0x4ZrceNFKKUylOb+j/L0pYD5IFMeN8SZbwp/yG
         JYdLRgozLtm/Pbpi4H1hLeBL7mmutjNikRmXtteqCVyufZviqdq7usKywi9vzzfJd917
         DUAsoErV6ld5dP/mQQhCAXuSwb3l7j1AYhesVH5Vaa1e/29un2d8ogJzpx4c3WMQkZ2X
         eli6DXDs/H4a9IDBXZhhKK9vN3dy/zXbW/V3vfDEZTbjnuN/3KgB95bGJGj1Ksb0PO0z
         h5vg==
X-Gm-Message-State: AOAM5315tX8FCjDgQbfn+1KLQmBfKb0gauv59hzyhYxPjvuT0wMo5j72
        amDjfHTuLk4dHFeGCvxRa0eM5ltpP6w=
X-Google-Smtp-Source: ABdhPJyaOqu4ad+t9uE7Zf0fPE6MJrUBppYirFS0r4ZA4lohiyuJAJadPtXvIAZN/YC0+AHkJyLwA8Dg4AI=
X-Received: by 2002:a17:902:ed13:: with SMTP id b19mr5756330pld.294.1594950343440;
 Thu, 16 Jul 2020 18:45:43 -0700 (PDT)
Date:   Fri, 17 Jul 2020 01:45:33 +0000
Message-Id: <20200717014540.71515-1-satyat@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.rc0.105.gf9edc3c819-goog
Subject: [PATCH v3 0/7] add support for direct I/O with fscrypt using blk-crypto
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
blk-crypto. It has been rebased on fscrypt/master.

Patch 1 adds two functions to fscrypt that need to be called to determine
if direct I/O is supported for a request.

Patches 2 and 3 wire up direct-io and iomap respectively with the functions
introduced in Patch 1 and set bio crypt contexts on bios when appropriate
by calling into fscrypt.

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

 Documentation/filesystems/fscrypt.rst | 36 +++++++++++-
 fs/crypto/crypto.c                    |  8 +++
 fs/crypto/inline_crypt.c              | 80 +++++++++++++++++++++++++++
 fs/direct-io.c                        | 15 ++++-
 fs/ext4/file.c                        | 10 ++--
 fs/f2fs/f2fs.h                        |  6 +-
 fs/iomap/direct-io.c                  |  8 +++
 include/linux/fscrypt.h               | 19 +++++++
 8 files changed, 173 insertions(+), 9 deletions(-)

-- 
2.28.0.rc0.105.gf9edc3c819-goog

