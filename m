Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91FE429C965
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Oct 2020 21:04:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1830636AbgJ0UEJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Oct 2020 16:04:09 -0400
Received: from smtp-bc0a.mail.infomaniak.ch ([45.157.188.10]:57339 "EHLO
        smtp-bc0a.mail.infomaniak.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2504042AbgJ0UEI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Oct 2020 16:04:08 -0400
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4CLN2D3JyWzlhDBh;
        Tue, 27 Oct 2020 21:04:04 +0100 (CET)
Received: from localhost (unknown [94.23.54.103])
        by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4CLN2C0G0vzlh8TF;
        Tue, 27 Oct 2020 21:04:02 +0100 (CET)
From:   =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To:     James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@amacapital.net>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Jann Horn <jannh@google.com>, Jeff Dike <jdike@addtoit.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Shuah Khan <shuah@kernel.org>,
        Vincent Dagonneau <vincent.dagonneau@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        linux-security-module@vger.kernel.org, x86@kernel.org
Subject: [PATCH v22 00/12] Landlock LSM
Date:   Tue, 27 Oct 2020 21:03:46 +0100
Message-Id: <20201027200358.557003-1-mic@digikod.net>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

Can you please consider to merge this into the tree?

This new patch series improves documentation, cleans up comments,
renames ARCH_EPHEMERAL_STATES to ARCH_EPHEMERAL_INODES and removes
LANDLOCK_ACCESS_FS_CHROOT.

The SLOC count is 1183 for security/landlock/ and 1657 for
tools/testing/selftest/landlock/ .  Test coverage for security/landlock/
is 95.2% of lines.  The code not covered only deals with internal kernel
errors (e.g. memory allocation) and race conditions.

The compiled documentation is available here:
https://landlock.io/linux-doc/landlock-v22/userspace-api/landlock.html

This series can be applied on top of v5.10-rc1 .  This can be tested with
CONFIG_SECURITY_LANDLOCK and CONFIG_SAMPLE_LANDLOCK.  This patch series
can be found in a Git repository here:
https://github.com/landlock-lsm/linux/commits/landlock-v22
I would really appreciate constructive comments on this patch series.


# Landlock LSM

The goal of Landlock is to enable to restrict ambient rights (e.g.
global filesystem access) for a set of processes.  Because Landlock is a
stackable LSM [1], it makes possible to create safe security sandboxes
as new security layers in addition to the existing system-wide
access-controls. This kind of sandbox is expected to help mitigate the
security impact of bugs or unexpected/malicious behaviors in user-space
applications. Landlock empowers any process, including unprivileged
ones, to securely restrict themselves.

Landlock is inspired by seccomp-bpf but instead of filtering syscalls
and their raw arguments, a Landlock rule can restrict the use of kernel
objects like file hierarchies, according to the kernel semantic.
Landlock also takes inspiration from other OS sandbox mechanisms: XNU
Sandbox, FreeBSD Capsicum or OpenBSD Pledge/Unveil.

In this current form, Landlock misses some access-control features.
This enables to minimize this patch series and ease review.  This series
still addresses multiple use cases, especially with the combined use of
seccomp-bpf: applications with built-in sandboxing, init systems,
security sandbox tools and security-oriented APIs [2].

Previous version:
https://lore.kernel.org/lkml/20201008153103.1155388-1-mic@digikod.net/

[1] https://lore.kernel.org/lkml/50db058a-7dde-441b-a7f9-f6837fe8b69f@schaufler-ca.com/
[2] https://lore.kernel.org/lkml/f646e1c7-33cf-333f-070c-0a40ad0468cd@digikod.net/


Casey Schaufler (1):
  LSM: Infrastructure management of the superblock

Mickaël Salaün (11):
  landlock: Add object management
  landlock: Add ruleset and domain management
  landlock: Set up the security framework and manage credentials
  landlock: Add ptrace restrictions
  fs,security: Add sb_delete hook
  landlock: Support filesystem access-control
  landlock: Add syscall implementations
  arch: Wire up Landlock syscalls
  selftests/landlock: Add user space tests
  samples/landlock: Add a sandbox manager example
  landlock: Add user and kernel documentation

 Documentation/security/index.rst              |    1 +
 Documentation/security/landlock.rst           |   79 +
 Documentation/userspace-api/index.rst         |    1 +
 Documentation/userspace-api/landlock.rst      |  259 +++
 MAINTAINERS                                   |   13 +
 arch/Kconfig                                  |    7 +
 arch/alpha/kernel/syscalls/syscall.tbl        |    3 +
 arch/arm/tools/syscall.tbl                    |    3 +
 arch/arm64/include/asm/unistd.h               |    2 +-
 arch/arm64/include/asm/unistd32.h             |    6 +
 arch/ia64/kernel/syscalls/syscall.tbl         |    3 +
 arch/m68k/kernel/syscalls/syscall.tbl         |    3 +
 arch/microblaze/kernel/syscalls/syscall.tbl   |    3 +
 arch/mips/kernel/syscalls/syscall_n32.tbl     |    3 +
 arch/mips/kernel/syscalls/syscall_n64.tbl     |    3 +
 arch/mips/kernel/syscalls/syscall_o32.tbl     |    3 +
 arch/parisc/kernel/syscalls/syscall.tbl       |    3 +
 arch/powerpc/kernel/syscalls/syscall.tbl      |    3 +
 arch/s390/kernel/syscalls/syscall.tbl         |    3 +
 arch/sh/kernel/syscalls/syscall.tbl           |    3 +
 arch/sparc/kernel/syscalls/syscall.tbl        |    3 +
 arch/um/Kconfig                               |    1 +
 arch/x86/entry/syscalls/syscall_32.tbl        |    3 +
 arch/x86/entry/syscalls/syscall_64.tbl        |    3 +
 arch/xtensa/kernel/syscalls/syscall.tbl       |    3 +
 fs/super.c                                    |    1 +
 include/linux/lsm_hook_defs.h                 |    1 +
 include/linux/lsm_hooks.h                     |    3 +
 include/linux/security.h                      |    4 +
 include/linux/syscalls.h                      |    7 +
 include/uapi/asm-generic/unistd.h             |    8 +-
 include/uapi/linux/landlock.h                 |  128 ++
 kernel/sys_ni.c                               |    5 +
 samples/Kconfig                               |    7 +
 samples/Makefile                              |    1 +
 samples/landlock/.gitignore                   |    1 +
 samples/landlock/Makefile                     |   15 +
 samples/landlock/sandboxer.c                  |  219 +++
 security/Kconfig                              |   11 +-
 security/Makefile                             |    2 +
 security/landlock/Kconfig                     |   19 +
 security/landlock/Makefile                    |    4 +
 security/landlock/common.h                    |   20 +
 security/landlock/cred.c                      |   46 +
 security/landlock/cred.h                      |   58 +
 security/landlock/fs.c                        |  604 ++++++
 security/landlock/fs.h                        |   60 +
 security/landlock/object.c                    |   66 +
 security/landlock/object.h                    |   91 +
 security/landlock/ptrace.c                    |  120 ++
 security/landlock/ptrace.h                    |   14 +
 security/landlock/ruleset.c                   |  350 ++++
 security/landlock/ruleset.h                   |  157 ++
 security/landlock/setup.c                     |   40 +
 security/landlock/setup.h                     |   18 +
 security/landlock/syscall.c                   |  427 +++++
 security/security.c                           |   51 +-
 security/selinux/hooks.c                      |   58 +-
 security/selinux/include/objsec.h             |    6 +
 security/selinux/ss/services.c                |    3 +-
 security/smack/smack.h                        |    6 +
 security/smack/smack_lsm.c                    |   35 +-
 tools/testing/selftests/Makefile              |    1 +
 tools/testing/selftests/landlock/.gitignore   |    2 +
 tools/testing/selftests/landlock/Makefile     |   24 +
 tools/testing/selftests/landlock/base_test.c  |  117 ++
 tools/testing/selftests/landlock/common.h     |  113 ++
 tools/testing/selftests/landlock/config       |    5 +
 tools/testing/selftests/landlock/fs_test.c    | 1675 +++++++++++++++++
 .../testing/selftests/landlock/ptrace_test.c  |  307 +++
 tools/testing/selftests/landlock/true.c       |    5 +
 71 files changed, 5255 insertions(+), 77 deletions(-)
 create mode 100644 Documentation/security/landlock.rst
 create mode 100644 Documentation/userspace-api/landlock.rst
 create mode 100644 include/uapi/linux/landlock.h
 create mode 100644 samples/landlock/.gitignore
 create mode 100644 samples/landlock/Makefile
 create mode 100644 samples/landlock/sandboxer.c
 create mode 100644 security/landlock/Kconfig
 create mode 100644 security/landlock/Makefile
 create mode 100644 security/landlock/common.h
 create mode 100644 security/landlock/cred.c
 create mode 100644 security/landlock/cred.h
 create mode 100644 security/landlock/fs.c
 create mode 100644 security/landlock/fs.h
 create mode 100644 security/landlock/object.c
 create mode 100644 security/landlock/object.h
 create mode 100644 security/landlock/ptrace.c
 create mode 100644 security/landlock/ptrace.h
 create mode 100644 security/landlock/ruleset.c
 create mode 100644 security/landlock/ruleset.h
 create mode 100644 security/landlock/setup.c
 create mode 100644 security/landlock/setup.h
 create mode 100644 security/landlock/syscall.c
 create mode 100644 tools/testing/selftests/landlock/.gitignore
 create mode 100644 tools/testing/selftests/landlock/Makefile
 create mode 100644 tools/testing/selftests/landlock/base_test.c
 create mode 100644 tools/testing/selftests/landlock/common.h
 create mode 100644 tools/testing/selftests/landlock/config
 create mode 100644 tools/testing/selftests/landlock/fs_test.c
 create mode 100644 tools/testing/selftests/landlock/ptrace_test.c
 create mode 100644 tools/testing/selftests/landlock/true.c


base-commit: 3650b228f83adda7e5ee532e2b90429c03f7b9ec
-- 
2.28.0

