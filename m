Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 221FF141762
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Jan 2020 13:08:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728596AbgARMIY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Jan 2020 07:08:24 -0500
Received: from mout-p-202.mailbox.org ([80.241.56.172]:8772 "EHLO
        mout-p-202.mailbox.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727118AbgARMIY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Jan 2020 07:08:24 -0500
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 480Gsx0gfnzQlC0;
        Sat, 18 Jan 2020 13:08:21 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter02.heinlein-hosting.de (spamfilter02.heinlein-hosting.de [80.241.56.116]) (amavisd-new, port 10030)
        with ESMTP id nGUXfNiBnQgK; Sat, 18 Jan 2020 13:08:17 +0100 (CET)
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     Aleksa Sarai <cyphar@cyphar.com>,
        Florian Weimer <fweimer@redhat.com>,
        David Laight <david.laight@aculab.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        quae@daurnimator.com, dev@opencontainers.org,
        containers@lists.linux-foundation.org, libc-alpha@sourceware.org,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH v3 0/2] openat2: minor uapi cleanups
Date:   Sat, 18 Jan 2020 23:07:58 +1100
Message-Id: <20200118120800.16358-1-cyphar@cyphar.com>
In-Reply-To: <20200115144831.GJ8904@ZenIV.linux.org.uk>
References: <20200115144831.GJ8904@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Patch changelog:
  v3:
   * Merge changes into the original patches to make Al's life easier.
     [Al Viro]
  v2:
   * Add include <linux/types.h> to openat2.h. [Florian Weimer]
   * Move OPEN_HOW_SIZE_* constants out of UAPI. [Florian Weimer]
   * Switch from __aligned_u64 to __u64 since it isn't necessary.
     [David Laight]
  v1: <https://lore.kernel.org/lkml/20191219105533.12508-1-cyphar@cyphar.com/>

While openat2(2) is still not yet in Linus's tree, we can take this
opportunity to iron out some small warts that weren't noticed earlier:

  * A fix was suggested by Florian Weimer, to separate the openat2
    definitions so glibc can use the header directly. I've put the
    maintainership under VFS but let me know if you'd prefer it belong
    ot the fcntl folks.

  * Having heterogenous field sizes in an extensible struct results in
    "padding hole" problems when adding new fields (in addition the
    correct error to use for non-zero padding isn't entirely clear ).
    The simplest solution is to just copy clone(3)'s model -- always use
    u64s. It will waste a little more space in the struct, but it
    removes a possible future headache.

This patch is intended to replace the corresponding patches in Al's
#work.openat2 tree (and *will not* apply on Linus' tree).

@Al: I will send some additional patches later, but they will require
     proper design review since they're ABI-related features (namely,
	 adding a way to check what features a syscall supports as I
	 outlined in my talk here[1]).

[1]: https://youtu.be/ggD-eb3yPVs

Aleksa Sarai (2):
  open: introduce openat2(2) syscall
  selftests: add openat2(2) selftests

 CREDITS                                       |   4 +-
 MAINTAINERS                                   |   1 +
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
 fs/open.c                                     | 147 +++--
 include/linux/fcntl.h                         |  16 +-
 include/linux/syscalls.h                      |   3 +
 include/uapi/asm-generic/unistd.h             |   5 +-
 include/uapi/linux/fcntl.h                    |   2 +-
 include/uapi/linux/openat2.h                  |  39 ++
 tools/testing/selftests/Makefile              |   1 +
 tools/testing/selftests/openat2/.gitignore    |   1 +
 tools/testing/selftests/openat2/Makefile      |   8 +
 tools/testing/selftests/openat2/helpers.c     | 109 ++++
 tools/testing/selftests/openat2/helpers.h     | 106 ++++
 .../testing/selftests/openat2/openat2_test.c  | 312 +++++++++++
 .../selftests/openat2/rename_attack_test.c    | 160 ++++++
 .../testing/selftests/openat2/resolve_test.c  | 523 ++++++++++++++++++
 34 files changed, 1418 insertions(+), 39 deletions(-)
 create mode 100644 include/uapi/linux/openat2.h
 create mode 100644 tools/testing/selftests/openat2/.gitignore
 create mode 100644 tools/testing/selftests/openat2/Makefile
 create mode 100644 tools/testing/selftests/openat2/helpers.c
 create mode 100644 tools/testing/selftests/openat2/helpers.h
 create mode 100644 tools/testing/selftests/openat2/openat2_test.c
 create mode 100644 tools/testing/selftests/openat2/rename_attack_test.c
 create mode 100644 tools/testing/selftests/openat2/resolve_test.c

-- 
2.24.1

