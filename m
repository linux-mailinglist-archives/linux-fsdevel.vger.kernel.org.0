Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1101D1EC3DF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jun 2020 22:42:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728386AbgFBUmg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Jun 2020 16:42:36 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:51370 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727860AbgFBUmg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Jun 2020 16:42:36 -0400
Received: from ip5f5af183.dynamic.kabel-deutschland.de ([95.90.241.131] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jgDk0-0001oi-Id; Tue, 02 Jun 2020 20:42:32 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        Kyle Evans <self@kyle-evans.net>,
        Victor Stinner <victor.stinner@gmail.com>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, fweimer@redhat.com, jannh@google.com,
        oleg@redhat.com, arnd@arndb.de, shuah@kernel.org,
        dhowells@redhat.com, ldv@altlinux.org,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH v5 0/3] close_range()
Date:   Tue,  2 Jun 2020 22:42:16 +0200
Message-Id: <20200602204219.186620-1-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hey everyone,

This is a resend of the close_range() syscall, as discussed in [1]. There weren't any outstanding
discussions anymore and this was in mergeable shape. I simply hadn't gotten around to moving this
into my for-next the last few cycles and then forgot about it. Thanks to Kyle and the Python people,
and others for consistenly reminding me before every merge window and mea culpa for not moving on
this sooner. I plan on moving this into for-next after v5.8-rc1 has been released and targeting the
v5.9 merge window.

As mentioned before, I was contacted by FreeBSD as they wanted to have the same close_range()
syscall as we proposed here. We've coordinated this and in the meantime, Kyle was fast enough to
merge close_range() into FreeBSD already in April:
https://reviews.freebsd.org/D21627
https://svnweb.freebsd.org/base?view=revision&revision=359836
and the current plan is to backport close_range() to FreeBSD 12.2 (cf. [2]) once its merged in
Linux too. Python is in the process of switching to close_range() on FreeBSD and they are waiting on
us to merge this to switch on Linux as well: https://bugs.python.org/issue38061

The missing close_range() syscall is also the reason why we still have that gap between 435 and 437
in the syscall tables as 436 was the syscall number reserved for close_range().

So again, sorry for the delay.

Thanks!
Christian

[1]: https://lore.kernel.org/lkml/20190516165021.GD17978@ZenIV.linux.org.uk/
[2]: https://twitter.com/kaevans91/status/1267907092406566912

Christian Brauner (3):
  open: add close_range()
  arch: wire-up close_range()
  tests: add close_range() tests

 arch/alpha/kernel/syscalls/syscall.tbl        |   1 +
 arch/arm/tools/syscall.tbl                    |   1 +
 arch/arm64/include/asm/unistd.h               |   2 +-
 arch/arm64/include/asm/unistd32.h             |   2 +
 arch/ia64/kernel/syscalls/syscall.tbl         |   1 +
 arch/m68k/kernel/syscalls/syscall.tbl         |   1 +
 arch/microblaze/kernel/syscalls/syscall.tbl   |   1 +
 arch/mips/kernel/syscalls/syscall_n32.tbl     |   1 +
 arch/mips/kernel/syscalls/syscall_n64.tbl     |   1 +
 arch/mips/kernel/syscalls/syscall_o32.tbl     |   1 +
 arch/parisc/kernel/syscalls/syscall.tbl       |   1 +
 arch/powerpc/kernel/syscalls/syscall.tbl      |   1 +
 arch/s390/kernel/syscalls/syscall.tbl         |   1 +
 arch/sh/kernel/syscalls/syscall.tbl           |   1 +
 arch/sparc/kernel/syscalls/syscall.tbl        |   1 +
 arch/x86/entry/syscalls/syscall_32.tbl        |   1 +
 arch/x86/entry/syscalls/syscall_64.tbl        |   1 +
 arch/xtensa/kernel/syscalls/syscall.tbl       |   1 +
 fs/file.c                                     |  62 +++++++-
 fs/open.c                                     |  20 +++
 include/linux/fdtable.h                       |   2 +
 include/linux/syscalls.h                      |   2 +
 include/uapi/asm-generic/unistd.h             |   4 +-
 tools/testing/selftests/Makefile              |   1 +
 tools/testing/selftests/core/.gitignore       |   1 +
 tools/testing/selftests/core/Makefile         |   7 +
 .../testing/selftests/core/close_range_test.c | 149 ++++++++++++++++++
 27 files changed, 258 insertions(+), 10 deletions(-)
 create mode 100644 tools/testing/selftests/core/.gitignore
 create mode 100644 tools/testing/selftests/core/Makefile
 create mode 100644 tools/testing/selftests/core/close_range_test.c


base-commit: 3d77e6a8804abcc0504c904bd6e5cdf3a5cf8162
-- 
2.26.2

