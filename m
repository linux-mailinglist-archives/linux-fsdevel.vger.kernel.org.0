Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 187A314CC64
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2020 15:27:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbgA2O1M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Jan 2020 09:27:12 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:38162 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbgA2O1L (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Jan 2020 09:27:11 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iwoJB-004KmP-I8; Wed, 29 Jan 2020 14:27:09 +0000
Date:   Wed, 29 Jan 2020 14:27:09 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [git pull] vfs.git openat2 series
Message-ID: <20200129142709.GX23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

	openat2() series; I'm afraid that the rest of namei stuff will
have to wait - it got zero review the last time I'd posted #work.namei,
and there had been a leak in the posted series I'd caught only last
weekend.  I was going to repost it on Monday, but the window opened
and the odds of getting any review during that...  Oh, well...

	Anyway, openat2 part should be ready; that _did_ get sane amount
of review and public testing, so here it comes.

The following changes since commit e42617b825f8073569da76dc4510bfa019b1c35a:

  Linux 5.5-rc1 (2019-12-08 14:57:55 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.openat2

for you to fetch changes up to b55eef872a96738ea9cb35774db5ce9a7d3a648f:

  Documentation: path-lookup: include new LOOKUP flags (2020-01-18 09:19:28 -0500)

----------------------------------------------------------------
Aleksa Sarai (13):
      namei: only return -ECHILD from follow_dotdot_rcu()
      nsfs: clean-up ns_get_path() signature to return int
      namei: allow nd_jump_link() to produce errors
      namei: allow set_root() to produce errors
      namei: LOOKUP_NO_SYMLINKS: block symlink resolution
      namei: LOOKUP_NO_MAGICLINKS: block magic-link resolution
      namei: LOOKUP_NO_XDEV: block mountpoint crossing
      namei: LOOKUP_BENEATH: O_BENEATH-like scoped resolution
      namei: LOOKUP_IN_ROOT: chroot-like scoped resolution
      namei: LOOKUP_{IN_ROOT,BENEATH}: permit limited ".." resolution
      open: introduce openat2(2) syscall
      selftests: add openat2(2) selftests
      Documentation: path-lookup: include new LOOKUP flags

 CREDITS                                            |   4 +-
 Documentation/filesystems/path-lookup.rst          |  68 ++-
 MAINTAINERS                                        |   1 +
 arch/alpha/kernel/syscalls/syscall.tbl             |   1 +
 arch/arm/tools/syscall.tbl                         |   1 +
 arch/arm64/include/asm/unistd.h                    |   2 +-
 arch/arm64/include/asm/unistd32.h                  |   2 +
 arch/ia64/kernel/syscalls/syscall.tbl              |   1 +
 arch/m68k/kernel/syscalls/syscall.tbl              |   1 +
 arch/microblaze/kernel/syscalls/syscall.tbl        |   1 +
 arch/mips/kernel/syscalls/syscall_n32.tbl          |   1 +
 arch/mips/kernel/syscalls/syscall_n64.tbl          |   1 +
 arch/mips/kernel/syscalls/syscall_o32.tbl          |   1 +
 arch/parisc/kernel/syscalls/syscall.tbl            |   1 +
 arch/powerpc/kernel/syscalls/syscall.tbl           |   1 +
 arch/s390/kernel/syscalls/syscall.tbl              |   1 +
 arch/sh/kernel/syscalls/syscall.tbl                |   1 +
 arch/sparc/kernel/syscalls/syscall.tbl             |   1 +
 arch/x86/entry/syscalls/syscall_32.tbl             |   1 +
 arch/x86/entry/syscalls/syscall_64.tbl             |   1 +
 arch/xtensa/kernel/syscalls/syscall.tbl            |   1 +
 fs/namei.c                                         | 199 ++++++--
 fs/nsfs.c                                          |  29 +-
 fs/open.c                                          | 147 ++++--
 fs/proc/base.c                                     |   3 +-
 fs/proc/namespaces.c                               |  20 +-
 include/linux/fcntl.h                              |  16 +-
 include/linux/namei.h                              |  12 +-
 include/linux/proc_ns.h                            |   4 +-
 include/linux/syscalls.h                           |   3 +
 include/uapi/asm-generic/unistd.h                  |   5 +-
 include/uapi/linux/fcntl.h                         |   2 +-
 include/uapi/linux/openat2.h                       |  39 ++
 kernel/bpf/offload.c                               |  12 +-
 kernel/events/core.c                               |   2 +-
 security/apparmor/apparmorfs.c                     |   6 +-
 tools/testing/selftests/Makefile                   |   1 +
 tools/testing/selftests/openat2/.gitignore         |   1 +
 tools/testing/selftests/openat2/Makefile           |   8 +
 tools/testing/selftests/openat2/helpers.c          | 109 +++++
 tools/testing/selftests/openat2/helpers.h          | 106 +++++
 tools/testing/selftests/openat2/openat2_test.c     | 312 ++++++++++++
 .../testing/selftests/openat2/rename_attack_test.c | 160 +++++++
 tools/testing/selftests/openat2/resolve_test.c     | 523 +++++++++++++++++++++
 44 files changed, 1696 insertions(+), 116 deletions(-)
 create mode 100644 include/uapi/linux/openat2.h
 create mode 100644 tools/testing/selftests/openat2/.gitignore
 create mode 100644 tools/testing/selftests/openat2/Makefile
 create mode 100644 tools/testing/selftests/openat2/helpers.c
 create mode 100644 tools/testing/selftests/openat2/helpers.h
 create mode 100644 tools/testing/selftests/openat2/openat2_test.c
 create mode 100644 tools/testing/selftests/openat2/rename_attack_test.c
 create mode 100644 tools/testing/selftests/openat2/resolve_test.c
