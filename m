Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F0B2357163
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Apr 2021 18:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245674AbhDGQGG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Apr 2021 12:06:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343621AbhDGQGB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Apr 2021 12:06:01 -0400
Received: from smtp-42ab.mail.infomaniak.ch (smtp-42ab.mail.infomaniak.ch [IPv6:2001:1600:3:17::42ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8995BC061760
        for <linux-fsdevel@vger.kernel.org>; Wed,  7 Apr 2021 09:05:49 -0700 (PDT)
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4FFq4V2RY2zMqJGw;
        Wed,  7 Apr 2021 18:05:46 +0200 (CEST)
Received: from localhost (unknown [23.97.221.149])
        by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4FFq4R4xzQzlpq09;
        Wed,  7 Apr 2021 18:05:43 +0200 (CEST)
From:   =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To:     James Morris <jmorris@namei.org>, Jann Horn <jannh@google.com>,
        "Serge E . Hallyn" <serge@hallyn.com>
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Casey Schaufler <casey@schaufler-ca.com>,
        David Howells <dhowells@redhat.com>,
        Jeff Dike <jdike@addtoit.com>,
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
Subject: [PATCH v33 00/12] Landlock LSM
Date:   Wed,  7 Apr 2021 18:07:14 +0200
Message-Id: <20210407160726.542794-1-mic@digikod.net>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

This updated patch series relaxes landlock_add_rule(2) to accept file
descriptors opened without O_PATH.  Using O_PATH is encouraged (as well
as O_CLOEXEC) but it should not be mandatory.  Indeed, using already
opened FDs can be handy.

FYI, the COND_SYSCALL() fix is now in -next:
https://git.kernel.org/next/linux-next/c/7dfe553affd0d003c7535b7ba60d09193471ea9d

James, could you please update the -next tree?

The SLOC count is 1326 for security/landlock/ and 2589 for
tools/testing/selftest/landlock/ .
Test coverage for security/landlock/ is 93.6% of lines:
https://landlock.io/linux-lcov/landlock-v33/security/landlock/index.html
The code not covered only deals with internal kernel errors (e.g. memory
allocation), race conditions and safety checks that should not be
triggered.  This series is being fuzzed by syzkaller (covering internal
kernel errors) that now supports Landlock:
https://github.com/google/syzkaller/pull/2380
syzkaller coverage is about 72% (ci-upstream-linux-next-kasan-gce-root):
https://syzkaller.appspot.com/upstream

The HTML documentation is available here:
https://landlock.io/linux-doc/landlock-v33/userspace-api/landlock.html

This series can be applied on top of v5.12-rc3 .  This can be tested with
CONFIG_SECURITY_LANDLOCK, CONFIG_SAMPLE_LANDLOCK and by prepending
"landlock," to CONFIG_LSM.  This patch series can be found in a Git
repository here:
https://github.com/landlock-lsm/linux/commits/landlock-v33
This patch series seems ready for upstream and I would really appreciate
final reviews.

Landlock LSM
============

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

[1] https://lore.kernel.org/lkml/50db058a-7dde-441b-a7f9-f6837fe8b69f@schaufler-ca.com/
[2] https://lore.kernel.org/lkml/f646e1c7-33cf-333f-070c-0a40ad0468cd@digikod.net/

Previous versions:
v32: https://lore.kernel.org/lkml/20210401205208.2756565-1-mic@digikod.net/
v31: https://lore.kernel.org/lkml/20210324191520.125779-1-mic@digikod.net/
v30: https://lore.kernel.org/lkml/20210316204252.427806-1-mic@digikod.net/
v29: https://lore.kernel.org/lkml/20210225190614.2181147-1-mic@digikod.net/
v28: https://lore.kernel.org/lkml/20210202162710.657398-1-mic@digikod.net/
v27: https://lore.kernel.org/lkml/20210121205119.793296-1-mic@digikod.net/
v26: https://lore.kernel.org/lkml/20201209192839.1396820-1-mic@digikod.net/
v25: https://lore.kernel.org/lkml/20201201192322.213239-1-mic@digikod.net/
v24: https://lore.kernel.org/lkml/20201112205141.775752-1-mic@digikod.net/
v23: https://lore.kernel.org/lkml/20201103182109.1014179-1-mic@digikod.net/
v22: https://lore.kernel.org/lkml/20201027200358.557003-1-mic@digikod.net/
v21: https://lore.kernel.org/lkml/20201008153103.1155388-1-mic@digikod.net/
v20: https://lore.kernel.org/lkml/20200802215903.91936-1-mic@digikod.net/
v19: https://lore.kernel.org/lkml/20200707180955.53024-1-mic@digikod.net/
v18: https://lore.kernel.org/lkml/20200526205322.23465-1-mic@digikod.net/
v17: https://lore.kernel.org/lkml/20200511192156.1618284-1-mic@digikod.net/
v16: https://lore.kernel.org/lkml/20200416103955.145757-1-mic@digikod.net/
v15: https://lore.kernel.org/lkml/20200326202731.693608-1-mic@digikod.net/
v14: https://lore.kernel.org/lkml/20200224160215.4136-1-mic@digikod.net/
v13: https://lore.kernel.org/lkml/20191104172146.30797-1-mic@digikod.net/
v12: https://lore.kernel.org/lkml/20191031164445.29426-1-mic@digikod.net/
v11: https://lore.kernel.org/lkml/20191029171505.6650-1-mic@digikod.net/
v10: https://lore.kernel.org/lkml/20190721213116.23476-1-mic@digikod.net/
v9: https://lore.kernel.org/lkml/20190625215239.11136-1-mic@digikod.net/
v8: https://lore.kernel.org/lkml/20180227004121.3633-1-mic@digikod.net/
v7: https://lore.kernel.org/lkml/20170821000933.13024-1-mic@digikod.net/
v6: https://lore.kernel.org/lkml/20170328234650.19695-1-mic@digikod.net/
v5: https://lore.kernel.org/lkml/20170222012632.4196-1-mic@digikod.net/
v4: https://lore.kernel.org/lkml/20161026065654.19166-1-mic@digikod.net/
v3: https://lore.kernel.org/lkml/20160914072415.26021-1-mic@digikod.net/
v2: https://lore.kernel.org/lkml/1472121165-29071-1-git-send-email-mic@digikod.net/
v1: https://lore.kernel.org/kernel-hardening/1458784008-16277-1-git-send-email-mic@digikod.net/

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
 Documentation/security/landlock.rst           |   85 +
 Documentation/userspace-api/index.rst         |    1 +
 Documentation/userspace-api/landlock.rst      |  311 ++
 MAINTAINERS                                   |   15 +
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
 include/linux/lsm_hooks.h                     |    4 +
 include/linux/security.h                      |    4 +
 include/linux/syscalls.h                      |    7 +
 include/uapi/asm-generic/unistd.h             |    8 +-
 include/uapi/linux/landlock.h                 |  129 +
 kernel/sys_ni.c                               |    5 +
 samples/Kconfig                               |    7 +
 samples/Makefile                              |    1 +
 samples/landlock/.gitignore                   |    1 +
 samples/landlock/Makefile                     |   13 +
 samples/landlock/sandboxer.c                  |  238 ++
 security/Kconfig                              |   11 +-
 security/Makefile                             |    2 +
 security/landlock/Kconfig                     |   21 +
 security/landlock/Makefile                    |    4 +
 security/landlock/common.h                    |   20 +
 security/landlock/cred.c                      |   46 +
 security/landlock/cred.h                      |   58 +
 security/landlock/fs.c                        |  692 ++++
 security/landlock/fs.h                        |   70 +
 security/landlock/limits.h                    |   21 +
 security/landlock/object.c                    |   67 +
 security/landlock/object.h                    |   91 +
 security/landlock/ptrace.c                    |  120 +
 security/landlock/ptrace.h                    |   14 +
 security/landlock/ruleset.c                   |  473 +++
 security/landlock/ruleset.h                   |  165 +
 security/landlock/setup.c                     |   40 +
 security/landlock/setup.h                     |   18 +
 security/landlock/syscalls.c                  |  442 +++
 security/security.c                           |   51 +-
 security/selinux/hooks.c                      |   58 +-
 security/selinux/include/objsec.h             |    6 +
 security/selinux/ss/services.c                |    3 +-
 security/smack/smack.h                        |    6 +
 security/smack/smack_lsm.c                    |   35 +-
 tools/testing/selftests/Makefile              |    1 +
 tools/testing/selftests/landlock/.gitignore   |    2 +
 tools/testing/selftests/landlock/Makefile     |   24 +
 tools/testing/selftests/landlock/base_test.c  |  219 ++
 tools/testing/selftests/landlock/common.h     |  183 ++
 tools/testing/selftests/landlock/config       |    7 +
 tools/testing/selftests/landlock/fs_test.c    | 2791 +++++++++++++++++
 .../testing/selftests/landlock/ptrace_test.c  |  337 ++
 tools/testing/selftests/landlock/true.c       |    5 +
 72 files changed, 6922 insertions(+), 77 deletions(-)
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
 create mode 100644 security/landlock/limits.h
 create mode 100644 security/landlock/object.c
 create mode 100644 security/landlock/object.h
 create mode 100644 security/landlock/ptrace.c
 create mode 100644 security/landlock/ptrace.h
 create mode 100644 security/landlock/ruleset.c
 create mode 100644 security/landlock/ruleset.h
 create mode 100644 security/landlock/setup.c
 create mode 100644 security/landlock/setup.h
 create mode 100644 security/landlock/syscalls.c
 create mode 100644 tools/testing/selftests/landlock/.gitignore
 create mode 100644 tools/testing/selftests/landlock/Makefile
 create mode 100644 tools/testing/selftests/landlock/base_test.c
 create mode 100644 tools/testing/selftests/landlock/common.h
 create mode 100644 tools/testing/selftests/landlock/config
 create mode 100644 tools/testing/selftests/landlock/fs_test.c
 create mode 100644 tools/testing/selftests/landlock/ptrace_test.c
 create mode 100644 tools/testing/selftests/landlock/true.c


base-commit: 1e28eed17697bcf343c6743f0028cc3b5dd88bf0
-- 
2.30.2

