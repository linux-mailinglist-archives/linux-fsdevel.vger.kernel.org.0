Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C101A3B722F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jun 2021 14:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233787AbhF2MiJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Jun 2021 08:38:09 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:37377 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233626AbhF2MiG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Jun 2021 08:38:06 -0400
Received: from ip5f5bf01b.dynamic.kabel-deutschland.de ([95.91.240.27] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1lyCxm-0008Bi-25; Tue, 29 Jun 2021 12:35:38 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] openat2 fixes
Date:   Tue, 29 Jun 2021 14:35:33 +0200
Message-Id: <20210629123533.1191246-1-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

/* Summary */
- Remove the unused VALID_UPGRADE_FLAGS define we carried from an extension to
  openat2() that we haven't merged. Aleksa might be getting back to it at some
  point but just not right now.

- openat2() used to accidently ignore unknown flag values in the upper 32 bits.

  The new openat2() syscall verifies that no unknown O-flag values are set and
  returns an error to userspace if they are while the older open syscalls like
  open() and openat() simply ignore unknown flag values:

    #define O_FLAG_CURRENTLY_INVALID (1 << 31)
    struct open_how how = {
            .flags = O_RDONLY | O_FLAG_CURRENTLY_INVALID,
            .resolve = 0,
    };
   
    /* fails */
    fd = openat2(-EBADF, "/dev/null", &how, sizeof(how));
   
    /* succeeds */
    fd = openat(-EBADF, "/dev/null", O_RDONLY | O_FLAG_CURRENTLY_INVALID);
  
  However, openat2() silently truncates the upper 32 bits meaning:
  
    #define O_FLAG_CURRENTLY_INVALID_LOWER32 (1 << 31)
    #define O_FLAG_CURRENTLY_INVALID_UPPER32 (1 << 40)
  
    struct open_how how_lowe32 = {
            .flags = O_RDONLY | O_FLAG_CURRENTLY_INVALID_LOWER32,
    };
  
    struct open_how how_upper32 = {
            .flags = O_RDONLY | O_FLAG_CURRENTLY_INVALID_UPPER32,
    };
  
    /* fails */
    fd = openat2(-EBADF, "/dev/null", &how_lower32, sizeof(how_lower32));
  
    /* succeeds */
    fd = openat2(-EBADF, "/dev/null", &how_upper32, sizeof(how_upper32));
  
  Fix this by preventing the immediate truncation in build_open_flags() and add a
  compile-time check to catch when we add flags in the upper 32 bit range.

/* Testing */
All patches are based on v5.13-rc3 and have been sitting in linux-next. No
build failures or warnings were observed. All old and new tests are passing.

/* Conflicts */
At the time of creating this PR no merge conflicts were reported from
linux-next and no merge conflicts showed up doing a test-merge with current
mainline.

The following changes since commit c4681547bcce777daf576925a966ffa824edd09d:

  Linux 5.13-rc3 (2021-05-23 11:42:48 -1000)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/fs.openat2.unknown_flags.v5.14

for you to fetch changes up to 15845cbcd12a571869c6703892427f9e5839d5fb:

  test: add openat2() test for invalid upper 32 bit flag value (2021-05-28 17:44:37 +0200)

Please consider pulling these changes from the signed fs.openat2.unknown_flags.v5.14 tag.

Thanks!
Christian

----------------------------------------------------------------
fs.openat2.unknown_flags.v5.14

----------------------------------------------------------------
Christian Brauner (3):
      fcntl: remove unused VALID_UPGRADE_FLAGS
      open: don't silently ignore unknown O-flags in openat2()
      test: add openat2() test for invalid upper 32 bit flag value

 fs/open.c                                      | 14 +++++++++++---
 include/linux/fcntl.h                          |  4 ----
 tools/testing/selftests/openat2/openat2_test.c |  7 ++++++-
 3 files changed, 17 insertions(+), 8 deletions(-)
