Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB5516AADD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2020 17:10:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727973AbgBXQKl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Feb 2020 11:10:41 -0500
Received: from smtp-sh.infomaniak.ch ([128.65.195.4]:51414 "EHLO
        smtp-sh.infomaniak.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727090AbgBXQKk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Feb 2020 11:10:40 -0500
X-Greylist: delayed 454 seconds by postgrey-1.27 at vger.kernel.org; Mon, 24 Feb 2020 11:10:31 EST
Received: from smtp-2-0000.mail.infomaniak.ch ([10.5.36.107])
        by smtp-sh.infomaniak.ch (8.14.5/8.14.5) with ESMTP id 01OG2Msv021682
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 24 Feb 2020 17:02:23 +0100
Received: from localhost (unknown [94.23.54.103])
        by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 48R6Js1QB9zlllCn;
        Mon, 24 Feb 2020 17:02:21 +0100 (CET)
From:   =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To:     linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@amacapital.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
Subject: [RFC PATCH v14 00/10] Landlock LSM
Date:   Mon, 24 Feb 2020 17:02:05 +0100
Message-Id: <20200224160215.4136-1-mic@digikod.net>
X-Mailer: git-send-email 2.25.1
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

This new version of Landlock is a major revamp of the previous series
[1], hence the RFC tag.  The three main changes are the replacement of
eBPF with a dedicated safe management of access rules, the replacement
of the use of seccomp(2) with a dedicated syscall, and the management of
filesystem access-control (back from the v10).

As discussed in [2], eBPF may be too powerful and dangerous to be put in
the hand of unprivileged and potentially malicious processes, especially
because of side-channel attacks against access-controls or other parts
of the kernel.

Thanks to this new implementation (1540 SLOC), designed from the ground
to be used by unprivileged processes, this series enables a process to
sandbox itself without requiring CAP_SYS_ADMIN, but only the
no_new_privs constraint (like seccomp).  Not relying on eBPF also
enables to improve performances, especially for stacked security
policies thanks to mergeable rulesets.

The compiled documentation is available here:
https://landlock.io/linux-doc/landlock-v14/security/landlock/index.html

This series can be applied on top of v5.6-rc3.  This can be tested with
CONFIG_SECURITY_LANDLOCK and CONFIG_SAMPLE_LANDLOCK.  This patch series
can be found in a Git repository here:
https://github.com/landlock-lsm/linux/commits/landlock-v14
I would really appreciate constructive comments on the design and the code.


# Landlock LSM

The goal of Landlock is to enable to restrict ambient rights (e.g.
global filesystem access) for a set of processes.  Because Landlock is a
stackable LSM [3], it makes possible to create safe security sandboxes
as new security layers in addition to the existing system-wide
access-controls. This kind of sandbox is expected to help mitigate the
security impact of bugs or unexpected/malicious behaviors in user-space
applications. Landlock empower any process, including unprivileged ones,
to securely restrict themselves.

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
supported, yet. This could be filled with a future extension first of
the LSM framework. The Landlock userspace ABI can handle such change
with new option (e.g. to the struct landlock_ruleset).

## UnionFS

An UnionFS super-block use a set of upper and lower directories. An
access request to a file in one of these hierarchy trigger a call to
ovl_path_real() which generate another access request according to the
matching hierarchy. Because such super-block is not aware of its current
mount point, OverlayFS can't create a dedicated mnt_parent for each of
the upper and lower directories mount clones. It is then not currently
possible to track the source of such indirect access-request, and then
not possible to identify a unified OverlayFS hierarchy.

## Syscall

Because it is only tested on x86_64, the syscall is only wired up for
this architecture.  The whole x86 family (and probably all the others)
will be supported in the next patch series.


## Memory limits

There is currently no limit on the memory usage.  Any idea to leverage
an existing mechanism (e.g. rlimit)?


# Changes since v13

* Revamp of the LSM: remove the need for eBPF and seccomp(2).
* Implement a full filesystem access-control.
* Take care of the backward compatibility issues, especially for
  this security features.

Previous version:
https://lore.kernel.org/lkml/20191104172146.30797-1-mic@digikod.net/

[1] https://lore.kernel.org/lkml/20191104172146.30797-1-mic@digikod.net/
[2] https://lore.kernel.org/lkml/a6b61f33-82dc-0c1c-7a6c-1926343ef63e@digikod.net/
[3] https://lore.kernel.org/lkml/50db058a-7dde-441b-a7f9-f6837fe8b69f@schaufler-ca.com/

Regards,

Mickaël Salaün (10):
  landlock: Add object and rule management
  landlock: Add ruleset and domain management
  landlock: Set up the security framework and manage credentials
  landlock: Add ptrace restrictions
  fs,landlock: Support filesystem access-control
  landlock: Add syscall implementation
  arch: Wire up landlock() syscall
  selftests/landlock: Add initial tests
  samples/landlock: Add a sandbox manager example
  landlock: Add user and kernel documentation

 Documentation/security/index.rst              |   1 +
 Documentation/security/landlock/index.rst     |  18 +
 Documentation/security/landlock/kernel.rst    |  44 ++
 Documentation/security/landlock/user.rst      | 233 +++++++
 MAINTAINERS                                   |  12 +
 arch/x86/entry/syscalls/syscall_64.tbl        |   1 +
 fs/super.c                                    |   2 +
 include/linux/landlock.h                      |  22 +
 include/linux/syscalls.h                      |   3 +
 include/uapi/asm-generic/unistd.h             |   4 +-
 include/uapi/linux/landlock.h                 | 315 +++++++++
 samples/Kconfig                               |   7 +
 samples/Makefile                              |   1 +
 samples/landlock/.gitignore                   |   1 +
 samples/landlock/Makefile                     |  15 +
 samples/landlock/sandboxer.c                  | 226 +++++++
 security/Kconfig                              |  11 +-
 security/Makefile                             |   2 +
 security/landlock/Kconfig                     |  16 +
 security/landlock/Makefile                    |   4 +
 security/landlock/cred.c                      |  47 ++
 security/landlock/cred.h                      |  55 ++
 security/landlock/fs.c                        | 591 +++++++++++++++++
 security/landlock/fs.h                        |  42 ++
 security/landlock/object.c                    | 341 ++++++++++
 security/landlock/object.h                    | 134 ++++
 security/landlock/ptrace.c                    | 118 ++++
 security/landlock/ptrace.h                    |  14 +
 security/landlock/ruleset.c                   | 463 +++++++++++++
 security/landlock/ruleset.h                   | 106 +++
 security/landlock/setup.c                     |  38 ++
 security/landlock/setup.h                     |  20 +
 security/landlock/syscall.c                   | 470 +++++++++++++
 tools/testing/selftests/Makefile              |   1 +
 tools/testing/selftests/landlock/.gitignore   |   3 +
 tools/testing/selftests/landlock/Makefile     |  13 +
 tools/testing/selftests/landlock/config       |   4 +
 tools/testing/selftests/landlock/test.h       |  40 ++
 tools/testing/selftests/landlock/test_base.c  |  80 +++
 tools/testing/selftests/landlock/test_fs.c    | 624 ++++++++++++++++++
 .../testing/selftests/landlock/test_ptrace.c  | 293 ++++++++
 41 files changed, 4429 insertions(+), 6 deletions(-)
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
 create mode 100644 tools/testing/selftests/landlock/config
 create mode 100644 tools/testing/selftests/landlock/test.h
 create mode 100644 tools/testing/selftests/landlock/test_base.c
 create mode 100644 tools/testing/selftests/landlock/test_fs.c
 create mode 100644 tools/testing/selftests/landlock/test_ptrace.c

-- 
2.25.0

