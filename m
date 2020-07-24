Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D580D22C4C0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jul 2020 14:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726835AbgGXML7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Jul 2020 08:11:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726258AbgGXMLu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Jul 2020 08:11:50 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FBA4C0619D3
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jul 2020 05:11:50 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id fr7so5876999pjb.4
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jul 2020 05:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=iD4FUEMenVr5lbrZY3MfjlLwUfP0+0if0gfZ+EqYyLI=;
        b=LU3Hl6Xb+kMb570dums3X91bS1lNWjAd6VAivVVwirnidnc44D39+JcML+BJHAGiYb
         /hLd0zQi1FE3LxsnU7ZCOiHAwNYFdEQm0Bw4lVG08rIUvLsp792e/7XMSZZKpfCuj9Wi
         Mc8RxN2om8nGrDd3CaWoXZVr6lkr8/IILg3NAUhby99DW4FbyIdip+AGS2zLfcAtbz/F
         O9L2jZzffcKwr1Nl0ZHrIcY6HnWsZBa3k0OuPKOQb9xFpTMvj12C/tW6+hn7DR9DEsn4
         VKLlFLHhKUhRXgHCiOcqBzkEP20Hlp9PqlgiscGHlUoNdDb1QOOHybUTJiChgSWV7ZW+
         1eeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=iD4FUEMenVr5lbrZY3MfjlLwUfP0+0if0gfZ+EqYyLI=;
        b=XrFJV5Nj7egevz146XmKT16c9w8oUNZ1eOX9AWSTlbCPDSkuJAR5bw8I4yFXpM0fvZ
         T0vNS4BSkUh64uNoWIwBUy/+DUVorAff9ow621GQBw9ErylzyAte5r4F+kqd23bLD+J9
         56qgrYcSrqp96+q6WqKk0K9Nb3YhZI/r4+jKblmZNxQAbyDnAkl/J4R6mUH4cGlj8QLF
         zJD92hJ5WsWm5Pz3ViuafsRZlEtDSeJkZ08Vd7OV24UOrTQEhn1JOkx2viwXMA8nAgIi
         WNOjb34HUuW7u8/D2y49ebdo5nzRqFFtW6O36a7Jvfb8NzQ0qzoP/f2dxLdnSoHuZNRe
         btDQ==
X-Gm-Message-State: AOAM532hde/Y/3fyh54ESU5iIePeTj76PMjv6gMRfwDbtQNeZVGvUSiO
        SY2Qot4KCL9BKUHonwrMHj4emZ9Wrwk=
X-Google-Smtp-Source: ABdhPJyWpT2NfcWEy4aLcDx08oXPKDl45eq2YPnQvm8sfH2moUaX/HTt1lJWyIEHpqxaEqJ3QKBmMRx778Y=
X-Received: by 2002:a63:4b44:: with SMTP id k4mr2076411pgl.305.1595592709047;
 Fri, 24 Jul 2020 05:11:49 -0700 (PDT)
Date:   Fri, 24 Jul 2020 12:11:36 +0000
Message-Id: <20200724121143.1589121-1-satyat@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.rc0.142.g3c755180ce-goog
Subject: [PATCH v5 0/7] add support for direct I/O with fscrypt using blk-crypto
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
 fs/crypto/inline_crypt.c              | 75 +++++++++++++++++++++++++++
 fs/direct-io.c                        | 15 +++++-
 fs/ext4/file.c                        | 10 ++--
 fs/ext4/inode.c                       |  7 +++
 fs/f2fs/f2fs.h                        |  6 ++-
 fs/iomap/direct-io.c                  |  6 +++
 include/linux/fscrypt.h               | 19 +++++++
 9 files changed, 173 insertions(+), 9 deletions(-)

-- 
2.28.0.rc0.142.g3c755180ce-goog

