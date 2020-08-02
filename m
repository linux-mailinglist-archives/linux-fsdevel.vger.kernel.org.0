Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA548239C7A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Aug 2020 00:00:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728200AbgHBV7x (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 2 Aug 2020 17:59:53 -0400
Received: from smtp-bc0a.mail.infomaniak.ch ([45.157.188.10]:41703 "EHLO
        smtp-bc0a.mail.infomaniak.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727987AbgHBV7w (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 2 Aug 2020 17:59:52 -0400
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4BKZfv5XWpzlhZrs;
        Sun,  2 Aug 2020 23:59:19 +0200 (CEST)
Received: from localhost (unknown [94.23.54.103])
        by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4BKZfs71x8zlh8T5;
        Sun,  2 Aug 2020 23:59:17 +0200 (CEST)
From:   =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To:     linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@amacapital.net>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Casey Schaufler <casey@schaufler-ca.com>,
        James Morris <jmorris@namei.org>, Jann Horn <jannh@google.com>,
        Jeff Dike <jdike@addtoit.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Shuah Khan <shuah@kernel.org>,
        Vincent Dagonneau <vincent.dagonneau@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-security-module@vger.kernel.org, x86@kernel.org
Subject: [PATCH v20 00/12] Landlock LSM
Date:   Sun,  2 Aug 2020 23:58:51 +0200
Message-Id: <20200802215903.91936-1-mic@digikod.net>
X-Mailer: git-send-email 2.28.0.rc2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Antivirus: Dr.Web (R) for Unix mail servers drweb plugin ver.6.0.2.8
X-Antivirus-Code: 0x100000
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

This new patch series mainly replace the landlock(2) command multiplexor
with 4 new dedicated syscalls:
* landlock_get_features(2)
* landlock_create_ruleset(2)
* landlock_add_rule(2)
* landlock_enforce_ruleset(2)

The SLOC count is 1264 for security/landlock/ and 1712 for
tools/testing/selftest/landlock/ .  Test coverage for security/landlock/
is 93.6% of lines.  The code not covered only deals with internal kernel
errors (e.g. memory allocation) and race conditions.

The compiled documentation is available here:
https://landlock.io/linux-doc/landlock-v20/security/landlock/index.html

This series can be applied on top of v5.8-rc4 .  This can be tested with
CONFIG_SECURITY_LANDLOCK and CONFIG_SAMPLE_LANDLOCK.  This patch series
can be found in a Git repository here:
https://github.com/landlock-lsm/linux/commits/landlock-v20
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
https://lore.kernel.org/lkml/20200707180955.53024-1-mic@digikod.net/

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
  selftests/landlock: Add initial tests
  samples/landlock: Add a sandbox manager example
  landlock: Add user and kernel documentation

 Documentation/security/index.rst              |    1 +
 Documentation/security/landlock/index.rst     |   18 +
 Documentation/security/landlock/kernel.rst    |   69 +
 Documentation/security/landlock/user.rst      |  271 +++
 MAINTAINERS                                   |   11 +
 arch/Kconfig                                  |    7 +
 arch/alpha/kernel/syscalls/syscall.tbl        |    4 +
 arch/arm/tools/syscall.tbl                    |    4 +
 arch/arm64/include/asm/unistd.h               |    2 +-
 arch/arm64/include/asm/unistd32.h             |    8 +
 arch/ia64/kernel/syscalls/syscall.tbl         |    4 +
 arch/m68k/kernel/syscalls/syscall.tbl         |    4 +
 arch/microblaze/kernel/syscalls/syscall.tbl   |    4 +
 arch/mips/kernel/syscalls/syscall_n32.tbl     |    4 +
 arch/mips/kernel/syscalls/syscall_n64.tbl     |    4 +
 arch/mips/kernel/syscalls/syscall_o32.tbl     |    4 +
 arch/parisc/kernel/syscalls/syscall.tbl       |    4 +
 arch/powerpc/kernel/syscalls/syscall.tbl      |    4 +
 arch/s390/kernel/syscalls/syscall.tbl         |    4 +
 arch/sh/kernel/syscalls/syscall.tbl           |    4 +
 arch/sparc/kernel/syscalls/syscall.tbl        |    4 +
 arch/um/Kconfig                               |    1 +
 arch/x86/entry/syscalls/syscall_32.tbl        |    4 +
 arch/x86/entry/syscalls/syscall_64.tbl        |    4 +
 arch/xtensa/kernel/syscalls/syscall.tbl       |    4 +
 fs/super.c                                    |    1 +
 include/linux/lsm_hook_defs.h                 |    1 +
 include/linux/lsm_hooks.h                     |    3 +
 include/linux/security.h                      |    4 +
 include/linux/syscalls.h                      |    8 +
 include/uapi/asm-generic/unistd.h             |   10 +-
 include/uapi/linux/landlock.h                 |  209 ++
 kernel/sys_ni.c                               |    6 +
 samples/Kconfig                               |    7 +
 samples/Makefile                              |    1 +
 samples/landlock/.gitignore                   |    1 +
 samples/landlock/Makefile                     |   15 +
 samples/landlock/sandboxer.c                  |  248 +++
 security/Kconfig                              |   11 +-
 security/Makefile                             |    2 +
 security/landlock/Kconfig                     |   18 +
 security/landlock/Makefile                    |    4 +
 security/landlock/common.h                    |   20 +
 security/landlock/cred.c                      |   46 +
 security/landlock/cred.h                      |   58 +
 security/landlock/fs.c                        |  609 ++++++
 security/landlock/fs.h                        |   60 +
 security/landlock/object.c                    |   66 +
 security/landlock/object.h                    |   91 +
 security/landlock/ptrace.c                    |  120 ++
 security/landlock/ptrace.h                    |   14 +
 security/landlock/ruleset.c                   |  342 ++++
 security/landlock/ruleset.h                   |  157 ++
 security/landlock/setup.c                     |   40 +
 security/landlock/setup.h                     |   18 +
 security/landlock/syscall.c                   |  571 ++++++
 security/security.c                           |   51 +-
 security/selinux/hooks.c                      |   58 +-
 security/selinux/include/objsec.h             |    6 +
 security/selinux/ss/services.c                |    3 +-
 security/smack/smack.h                        |    6 +
 security/smack/smack_lsm.c                    |   35 +-
 tools/testing/selftests/Makefile              |    1 +
 tools/testing/selftests/landlock/.gitignore   |    2 +
 tools/testing/selftests/landlock/Makefile     |   29 +
 tools/testing/selftests/landlock/base_test.c  |  154 ++
 tools/testing/selftests/landlock/common.h     |  122 ++
 tools/testing/selftests/landlock/config       |    5 +
 tools/testing/selftests/landlock/fs_test.c    | 1698 +++++++++++++++++
 .../testing/selftests/landlock/ptrace_test.c  |  310 +++
 tools/testing/selftests/landlock/true.c       |    5 +
 71 files changed, 5621 insertions(+), 77 deletions(-)
 create mode 100644 Documentation/security/landlock/index.rst
 create mode 100644 Documentation/security/landlock/kernel.rst
 create mode 100644 Documentation/security/landlock/user.rst
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

-- 
2.28.0.rc2

