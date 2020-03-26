Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8C5A19491F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Mar 2020 21:28:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728680AbgCZU1n (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Mar 2020 16:27:43 -0400
Received: from smtp-8faf.mail.infomaniak.ch ([83.166.143.175]:45297 "EHLO
        smtp-8faf.mail.infomaniak.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727851AbgCZU1m (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Mar 2020 16:27:42 -0400
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 48pGkh05xGzlh9HG;
        Thu, 26 Mar 2020 21:27:40 +0100 (CET)
Received: from localhost (unknown [94.23.54.103])
        by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 48pGkf3VgqzlkXXh;
        Thu, 26 Mar 2020 21:27:38 +0100 (CET)
From:   =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To:     linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@amacapital.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Casey Schaufler <casey@schaufler-ca.com>,
        James Morris <jmorris@namei.org>, Jann Horn <jann@thejh.net>,
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
Subject: [PATCH v15 00/10] Landlock LSM
Date:   Thu, 26 Mar 2020 21:27:21 +0100
Message-Id: <20200326202731.693608-1-mic@digikod.net>
X-Mailer: git-send-email 2.26.0.rc2
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

This new patch series brings improvements, fix some bugs but mainly
simplify the code.

The object, rule and ruleset management are simplified at the expense of
a less aggressive memory freeing (contributed by Jann Horn [1]).  There
is now less use of RCU for an improved readability.  Access checks that
can be reached by file-descriptor-based syscalls are removed for now
(truncate, getattr, lock, chmod, chown, chgrp, ioctl).  This will be
handle in a future evolution of Landlock, but right now the goal is to
lighten the code to ease review.  The SLOC count for security/landlock/
was 1542 with the previous patch series while the current series shrinks
it to 1273.

The other main improvement is the addition of rule layer levels to
ensure that a nested sandbox cannot bypass the access restrictions set
by its parents.

The syscall is now wired for all architectures and the tests passed for
x86_32 and x86_64.

The compiled documentation is available here:
https://landlock.io/linux-doc/landlock-v15/security/landlock/index.html

This series can be applied on top of v5.6-rc7.  This can be tested with
CONFIG_SECURITY_LANDLOCK and CONFIG_SAMPLE_LANDLOCK.  This patch series
can be found in a Git repository here:
https://github.com/landlock-lsm/linux/commits/landlock-v15
I would really appreciate constructive comments on the design and the code.


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


# Current limitations

## Path walk

Landlock need to use dentries to identify a file hierarchy, which is
needed for composable and unprivileged access-controls. This means that
path resolution/walking (handled with inode_permission()) is not
supported, yet. The same limitation also apply to readlink(2). This
could be filled with a future extension first of the LSM framework. The
Landlock userspace ABI can handle such change with new options (e.g. to
the struct landlock_ruleset).

## UnionFS

An UnionFS super-block use a set of upper and lower directories.  Access
request to a file in one of these hierarchy trigger a call to
ovl_path_real() which generate another access request according to the
matching hierarchy. Because such super-block is not aware of its current
mount point, OverlayFS can't create a dedicated mnt_parent for each of
the upper and lower directories mount clones. It is then not currently
possible to track the source of such indirect access-request, and then
not possible to identify a unified OverlayFS hierarchy.


## Memory limits

There is currently no limit on the memory usage.  Any idea to leverage
an existing mechanism (e.g. rlimit)?


# Changes since v14

* Simplify the object, rule and ruleset management at the expense of a
  less aggressive memory freeing.
* Remove access checks that may be required for FD-only requests:
  truncate, getattr, lock, chmod, chown, chgrp, ioctl.
* Add the notion of rule layer level to ensure that a nested sandbox
  cannot bypass the access restrictions set by its parent.
* Wire up the syscall for all architectures.
* Clean up the code and add more documentation.
* Some improvements and bug fixes.


# Changes since v13

* Revamp of the LSM: remove the need for eBPF and seccomp(2).
* Implement a full filesystem access-control.
* Take care of the backward compatibility issues, especially for
  security features, following a best-effort approach.

Previous version:
https://lore.kernel.org/lkml/20200224160215.4136-1-mic@digikod.net/


[1] https://lore.kernel.org/lkml/CAG48ez21bEn0wL1bbmTiiu8j9jP5iEWtHOwz4tURUJ+ki0ydYw@mail.gmail.com/
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
 Documentation/security/landlock/user.rst      |  227 +++
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
 include/uapi/linux/landlock.h                 |  311 ++++
 kernel/sys_ni.c                               |    3 +
 samples/Kconfig                               |    7 +
 samples/Makefile                              |    1 +
 samples/landlock/.gitignore                   |    1 +
 samples/landlock/Makefile                     |   15 +
 samples/landlock/sandboxer.c                  |  217 +++
 security/Kconfig                              |   11 +-
 security/Makefile                             |    2 +
 security/landlock/Kconfig                     |   18 +
 security/landlock/Makefile                    |    4 +
 security/landlock/common.h                    |   20 +
 security/landlock/cred.c                      |   46 +
 security/landlock/cred.h                      |   55 +
 security/landlock/fs.c                        |  561 ++++++++
 security/landlock/fs.h                        |   42 +
 security/landlock/object.c                    |   66 +
 security/landlock/object.h                    |   92 ++
 security/landlock/ptrace.c                    |  120 ++
 security/landlock/ptrace.h                    |   14 +
 security/landlock/ruleset.c                   |  352 +++++
 security/landlock/ruleset.h                   |  182 +++
 security/landlock/setup.c                     |   39 +
 security/landlock/setup.h                     |   18 +
 security/landlock/syscall.c                   |  521 +++++++
 tools/testing/selftests/Makefile              |    1 +
 tools/testing/selftests/landlock/.gitignore   |    4 +
 tools/testing/selftests/landlock/Makefile     |   26 +
 tools/testing/selftests/landlock/common.h     |   42 +
 tools/testing/selftests/landlock/config       |    5 +
 tools/testing/selftests/landlock/test_base.c  |  113 ++
 tools/testing/selftests/landlock/test_fs.c    | 1249 +++++++++++++++++
 .../testing/selftests/landlock/test_ptrace.c  |  294 ++++
 tools/testing/selftests/landlock/true.c       |    5 +
 62 files changed, 4833 insertions(+), 7 deletions(-)
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
2.26.0.rc2

