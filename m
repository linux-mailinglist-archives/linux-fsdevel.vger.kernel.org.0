Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD5EA260CE9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Sep 2020 10:03:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729591AbgIHICv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Sep 2020 04:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729993AbgIHIAc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Sep 2020 04:00:32 -0400
Received: from smtp-bc0b.mail.infomaniak.ch (smtp-bc0b.mail.infomaniak.ch [IPv6:2001:1600:3:17::bc0b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 552F6C061573
        for <linux-fsdevel@vger.kernel.org>; Tue,  8 Sep 2020 01:00:15 -0700 (PDT)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4BlyHN0cCBzlhR8K;
        Tue,  8 Sep 2020 10:00:00 +0200 (CEST)
Received: from localhost (unknown [94.23.54.103])
        by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4BlyHK4Ph5zlh8T9;
        Tue,  8 Sep 2020 09:59:57 +0200 (CEST)
From:   =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To:     linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christian Heimes <christian@python.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Deven Bowers <deven.desai@linux.microsoft.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Eric Chiang <ericchiang@google.com>,
        Florian Weimer <fweimer@redhat.com>,
        James Morris <jmorris@namei.org>, Jan Kara <jack@suse.cz>,
        Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Matthew Garrett <mjg59@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        =?UTF-8?q?Philippe=20Tr=C3=A9buchet?= 
        <philippe.trebuchet@ssi.gouv.fr>,
        Scott Shell <scottsh@microsoft.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Steve Dower <steve.dower@python.org>,
        Steve Grubb <sgrubb@redhat.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Thibaut Sautereau <thibaut.sautereau@clip-os.org>,
        Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH v8 0/3] Add support for AT_INTERPRETED (was O_MAYEXEC)
Date:   Tue,  8 Sep 2020 09:59:53 +0200
Message-Id: <20200908075956.1069018-1-mic@digikod.net>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

This height patch series rework the previous O_MAYEXEC series by not
adding a new flag to openat2(2) but to faccessat2(2) instead.  As
suggested, this enables to perform the access check on a file descriptor
instead of on a file path (while opening it).  This may require two
checks (one on open and then with faccessat2) but it is a more generic
approach [8].

The IMA patch is removed for now because the only LSM hook triggered by
faccessat2(2) is inode_permission() which takes a struct inode as
argument.  However, struct path and then struct file are still available
in this syscall, which enables to add a new hook to fit the needs of IMA
and other path-based LSMs.

We also removed the three patches from Kees Cook which are no longer
required for this new implementation.

Goal of AT_INTERPRETED
======================

The goal of this patch series is to enable to control script execution
with interpreters help.  A new AT_INTERPRETED flag, usable through
faccessat2(2), is added to enable userspace script interpreters to
delegate to the kernel (and thus the system security policy) the
permission to interpret/execute scripts or other files containing what
can be seen as commands.

A simple system-wide security policy can be enforced by the system
administrator through a sysctl configuration consistent with the mount
points or the file access rights.  The documentation patch explains the
prerequisites.

Furthermore, the security policy can also be delegated to an LSM, either
a MAC system or an integrity system.  For instance, the new kernel
MAY_INTERPRETED_EXEC flag is required to close a major IMA
measurement/appraisal interpreter integrity gap by bringing the ability
to check the use of scripts [1].  Other uses are expected, such as for
magic-links [2], SGX integration [3], bpffs [4] or IPE [5].

Possible extended usage
=======================

For now, only the X_OK mode is compatible with the AT_INTERPRETED flag.
This enables to restrict the addition of new control flows in a process.
Using R_OK or W_OK with AT_INTERPRETED returns -EINVAL.

Possible future use-cases for R_OK with AT_INTERPRETED may be to check
configuration files that may impact the behavior of applications (i.e.
influence critical part of the current control flow).  Those should then
be trusted as well.  The W_OK with AT_INTERPRETED could be used to check
that a file descriptor is allowed to receive sensitive data such as
debug logs.

Prerequisite of its use
=======================

Userspace needs to adapt to take advantage of this new feature.  For
example, the PEP 578 [6] (Runtime Audit Hooks) enables Python 3.8 to be
extended with policy enforcement points related to code interpretation,
which can be used to align with the PowerShell audit features.
Additional Python security improvements (e.g. a limited interpreter
without -c, stdin piping of code) are on their way [7].

Examples
========

The initial idea comes from CLIP OS 4 and the original implementation
has been used for more than 12 years:
https://github.com/clipos-archive/clipos4_doc
Chrome OS has a similar approach:
https://chromium.googlesource.com/chromiumos/docs/+/master/security/noexec_shell_scripts.md

Userland patches can be found here:
https://github.com/clipos-archive/clipos4_portage-overlay/search?q=O_MAYEXEC
Actually, there is more than the O_MAYEXEC changes (which matches this search)
e.g., to prevent Python interactive execution. There are patches for
Bash, Wine, Java (Icedtea), Busybox's ash, Perl and Python. There are
also some related patches which do not directly rely on O_MAYEXEC but
which restrict the use of browser plugins and extensions, which may be
seen as scripts too:
https://github.com/clipos-archive/clipos4_portage-overlay/tree/master/www-client

An introduction to O_MAYEXEC was given at the Linux Security Summit
Europe 2018 - Linux Kernel Security Contributions by ANSSI:
https://www.youtube.com/watch?v=chNjCRtPKQY&t=17m15s
The "write xor execute" principle was explained at Kernel Recipes 2018 -
CLIP OS: a defense-in-depth OS:
https://www.youtube.com/watch?v=PjRE0uBtkHU&t=11m14s
See also an overview article: https://lwn.net/Articles/820000/

This patch series can be applied on top of v5.9-rc4 .  This can be tested
with CONFIG_SYSCTL.  I would really appreciate constructive comments on
this patch series.

Previous version:
https://lore.kernel.org/lkml/20200723171227.446711-1-mic@digikod.net/

[1] https://lore.kernel.org/lkml/1544647356.4028.105.camel@linux.ibm.com/
[2] https://lore.kernel.org/lkml/20190904201933.10736-6-cyphar@cyphar.com/
[3] https://lore.kernel.org/lkml/CALCETrVovr8XNZSroey7pHF46O=kj_c5D9K8h=z2T_cNrpvMig@mail.gmail.com/
[4] https://lore.kernel.org/lkml/CALCETrVeZ0eufFXwfhtaG_j+AdvbzEWE0M3wjXMWVEO7pj+xkw@mail.gmail.com/
[5] https://lore.kernel.org/lkml/20200406221439.1469862-12-deven.desai@linux.microsoft.com/
[6] https://www.python.org/dev/peps/pep-0578/
[7] https://lore.kernel.org/lkml/0c70debd-e79e-d514-06c6-4cd1e021fa8b@python.org/
[8] https://lore.kernel.org/lkml/e7c1f99d7cdf706ca0867e5fb76ae4cb38bc83f5.camel@linux.ibm.com/

Regards,

Mickaël Salaün (3):
  fs: Introduce AT_INTERPRETED flag for faccessat2(2)
  fs,doc: Enable to configure exec checks for AT_INTERPRETED
  selftest/interpreter: Add tests for AT_INTERPRETED enforcing

 Documentation/admin-guide/sysctl/fs.rst       |  54 +++
 fs/open.c                                     |  67 ++-
 include/linux/fs.h                            |   3 +
 include/uapi/linux/fcntl.h                    |  12 +-
 kernel/sysctl.c                               |  12 +-
 .../testing/selftests/interpreter/.gitignore  |   2 +
 tools/testing/selftests/interpreter/Makefile  |  18 +
 tools/testing/selftests/interpreter/config    |   1 +
 .../interpreter/interpreted_access_test.c     | 384 ++++++++++++++++++
 9 files changed, 548 insertions(+), 5 deletions(-)
 create mode 100644 tools/testing/selftests/interpreter/.gitignore
 create mode 100644 tools/testing/selftests/interpreter/Makefile
 create mode 100644 tools/testing/selftests/interpreter/config
 create mode 100644 tools/testing/selftests/interpreter/interpreted_access_test.c

-- 
2.28.0

