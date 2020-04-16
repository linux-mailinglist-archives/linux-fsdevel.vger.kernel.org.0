Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F12D51ABEC1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Apr 2020 13:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506118AbgDPLHI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Apr 2020 07:07:08 -0400
Received: from smtp-190c.mail.infomaniak.ch ([185.125.25.12]:43633 "EHLO
        smtp-190c.mail.infomaniak.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2506088AbgDPLGv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Apr 2020 07:06:51 -0400
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 492wjD5wZMzlhp7r;
        Thu, 16 Apr 2020 12:40:16 +0200 (CEST)
Received: from localhost (unknown [94.23.54.103])
        by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 492wj65WSQzlhFd8;
        Thu, 16 Apr 2020 12:40:10 +0200 (CEST)
From:   =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To:     linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@amacapital.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Casey Schaufler <casey@schaufler-ca.com>,
        James Morris <jmorris@namei.org>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mickael.salaun@ssi.gouv.fr>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Shuah Khan <shuah@kernel.org>,
        Vincent Dagonneau <vincent.dagonneau@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-security-module@vger.kernel.org, x86@kernel.org
Subject: [PATCH v16 00/10] Landlock LSM
Date:   Thu, 16 Apr 2020 12:39:45 +0200
Message-Id: <20200416103955.145757-1-mic@digikod.net>
X-Mailer: git-send-email 2.26.1
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

This new patch series brings some improvements while simplifying the
code, fixes some bugs and adds more tests:

Use a bitfield of layers to properly manage superset and subset of
access rights, whatever their order in the stack of layers [1].

Allow to open pipes and similar special files through /proc/self/fd, as
well as internal filesystems such as nsfs through /proc/self/ns, because
disconnected path cannot be evaluated.  Such special filesystems could
be handled with a future evolution.

For the sake of simplicity, forbid reparenting when linking or renaming
to protect against possible privilege escalation.  This could happen by
changing the hierarchy of a file or directory in relation to an enforced
access policy (from the set of layers).  This will be relaxed in the
future with more complex code.

Rename the unlink and rmdir access rights to a more generic ones:
remove_dir and remove_file.  Indeed it makes sense to also use them for
the action of renaming a file or a directory, which may lead to the
removal of the source file or directory.  Replace the link_to,
rename_from and rename_to access rights with remove_file, remove_dir and
make_* .

Add multiple tests to check semantic, and improve test coverage for
security/landlock to 94.1% of lines (best possible with deterministic
user space tests).

Add current limitations to documentation: file renaming and linking,
OverlayFS and special filesystems (e.g. nsfs).

The previously identified memory accounting limitation can already be
solved with the (kernel) Memory Resource Controller from cgroup.

The SLOC count is 1267 for security/landlock/ and 1643 for
tools/testing/selftest/landlock/ .

The compiled documentation is available here:
https://landlock.io/linux-doc/landlock-v16/security/landlock/index.html

This series can be applied on top of v5.7-rc1.  This can be tested with
CONFIG_SECURITY_LANDLOCK and CONFIG_SAMPLE_LANDLOCK.  This patch series
can be found in a Git repository here:
https://github.com/landlock-lsm/linux/commits/landlock-v16
I would really appreciate constructive comments on this patch series.


# Landlock LSM

The goal of Landlock is to enable to restrict ambient rights (e.g.
global filesystem access) for a set of processes.  Because Landlock is a
stackable LSM [2], it makes possible to create safe security sandboxes
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


Previous version:
https://lore.kernel.org/lkml/20200326202731.693608-1-mic@digikod.net/


[1] https://lore.kernel.org/lkml/e07fe473-1801-01cc-12ae-b3167f95250e@digikod.net/
[2] https://lore.kernel.org/lkml/50db058a-7dde-441b-a7f9-f6837fe8b69f@schaufler-ca.com/

Regards,

Mickaël Salaün (10):
  landlock: Add object management
  landlock: Add ruleset and domain management
  landlock: Set up the security framework and manage credentials
  landlock: Add ptrace restrictions
  fs,landlock: Support filesystem access-control
  landlock: Add syscall implementation
  arch: Wire up landlock() syscall
  selftests/landlock: Add initial tests
  samples/landlock: Add a sandbox manager example
  landlock: Add user and kernel documentation

 Documentation/security/index.rst              |    1 +
 Documentation/security/landlock/index.rst     |   18 +
 Documentation/security/landlock/kernel.rst    |   69 +
 Documentation/security/landlock/user.rst      |  268 +++
 MAINTAINERS                                   |   12 +
 arch/alpha/kernel/syscalls/syscall.tbl        |    1 +
 arch/arm/tools/syscall.tbl                    |    1 +
 arch/arm64/include/asm/unistd.h               |    2 +-
 arch/arm64/include/asm/unistd32.h             |    2 +
 arch/ia64/kernel/syscalls/syscall.tbl         |    1 +
 arch/m68k/kernel/syscalls/syscall.tbl         |    1 +
 arch/microblaze/kernel/syscalls/syscall.tbl   |    1 +
 arch/mips/kernel/syscalls/syscall_n32.tbl     |    1 +
 arch/mips/kernel/syscalls/syscall_n64.tbl     |    1 +
 arch/mips/kernel/syscalls/syscall_o32.tbl     |    1 +
 arch/parisc/kernel/syscalls/syscall.tbl       |    1 +
 arch/powerpc/kernel/syscalls/syscall.tbl      |    1 +
 arch/s390/kernel/syscalls/syscall.tbl         |    1 +
 arch/sh/kernel/syscalls/syscall.tbl           |    1 +
 arch/sparc/kernel/syscalls/syscall.tbl        |    1 +
 arch/x86/entry/syscalls/syscall_32.tbl        |    1 +
 arch/x86/entry/syscalls/syscall_64.tbl        |    1 +
 arch/xtensa/kernel/syscalls/syscall.tbl       |    1 +
 fs/super.c                                    |    2 +
 include/linux/fs.h                            |    5 +
 include/linux/landlock.h                      |   22 +
 include/linux/syscalls.h                      |    3 +
 include/uapi/asm-generic/unistd.h             |    4 +-
 include/uapi/linux/landlock.h                 |  296 +++
 kernel/sys_ni.c                               |    3 +
 samples/Kconfig                               |    7 +
 samples/Makefile                              |    1 +
 samples/landlock/.gitignore                   |    1 +
 samples/landlock/Makefile                     |   15 +
 samples/landlock/sandboxer.c                  |  228 +++
 security/Kconfig                              |   11 +-
 security/Makefile                             |    2 +
 security/landlock/Kconfig                     |   18 +
 security/landlock/Makefile                    |    4 +
 security/landlock/common.h                    |   20 +
 security/landlock/cred.c                      |   46 +
 security/landlock/cred.h                      |   58 +
 security/landlock/fs.c                        |  601 ++++++
 security/landlock/fs.h                        |   42 +
 security/landlock/object.c                    |   66 +
 security/landlock/object.h                    |   91 +
 security/landlock/ptrace.c                    |  120 ++
 security/landlock/ptrace.h                    |   14 +
 security/landlock/ruleset.c                   |  344 ++++
 security/landlock/ruleset.h                   |  161 ++
 security/landlock/setup.c                     |   39 +
 security/landlock/setup.h                     |   18 +
 security/landlock/syscall.c                   |  501 +++++
 tools/testing/selftests/Makefile              |    1 +
 tools/testing/selftests/landlock/.gitignore   |    4 +
 tools/testing/selftests/landlock/Makefile     |   29 +
 tools/testing/selftests/landlock/common.h     |   42 +
 tools/testing/selftests/landlock/config       |    5 +
 tools/testing/selftests/landlock/test_base.c  |  156 ++
 tools/testing/selftests/landlock/test_fs.c    | 1696 +++++++++++++++++
 .../testing/selftests/landlock/test_ptrace.c  |  291 +++
 tools/testing/selftests/landlock/true.c       |    5 +
 62 files changed, 5353 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/security/landlock/index.rst
 create mode 100644 Documentation/security/landlock/kernel.rst
 create mode 100644 Documentation/security/landlock/user.rst
 create mode 100644 include/linux/landlock.h
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
 create mode 100644 tools/testing/selftests/landlock/common.h
 create mode 100644 tools/testing/selftests/landlock/config
 create mode 100644 tools/testing/selftests/landlock/test_base.c
 create mode 100644 tools/testing/selftests/landlock/test_fs.c
 create mode 100644 tools/testing/selftests/landlock/test_ptrace.c
 create mode 100644 tools/testing/selftests/landlock/true.c

-- 
2.26.1

