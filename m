Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B998C1BC729
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Apr 2020 19:52:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728526AbgD1Rvn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Apr 2020 13:51:43 -0400
Received: from smtp-8fab.mail.infomaniak.ch ([83.166.143.171]:53995 "EHLO
        smtp-8fab.mail.infomaniak.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727827AbgD1Rvm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Apr 2020 13:51:42 -0400
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 49BTjS0sy2zlh9G9;
        Tue, 28 Apr 2020 19:51:40 +0200 (CEST)
Received: from localhost (unknown [94.23.54.103])
        by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 49BTjP5dXczmVZjD;
        Tue, 28 Apr 2020 19:51:37 +0200 (CEST)
From:   =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To:     linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Heimes <christian@python.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Deven Bowers <deven.desai@linux.microsoft.com>,
        Eric Chiang <ericchiang@google.com>,
        Florian Weimer <fweimer@redhat.com>,
        James Morris <jmorris@namei.org>, Jan Kara <jack@suse.cz>,
        Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Matthew Garrett <mjg59@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mickael.salaun@ssi.gouv.fr>,
        Mimi Zohar <zohar@linux.ibm.com>,
        =?UTF-8?q?Philippe=20Tr=C3=A9buchet?= 
        <philippe.trebuchet@ssi.gouv.fr>,
        Scott Shell <scottsh@microsoft.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Steve Dower <steve.dower@python.org>,
        Steve Grubb <sgrubb@redhat.com>,
        Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>,
        Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 0/5] Add support for RESOLVE_MAYEXEC
Date:   Tue, 28 Apr 2020 19:51:24 +0200
Message-Id: <20200428175129.634352-1-mic@digikod.net>
X-Mailer: git-send-email 2.26.2
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

The goal of this patch series is to enable to control script execution
with interpreters help.  A new RESOLVE_MAYEXEC flag, usable through
openat2(2), is added to enable userspace script interpreter to delegate
to the kernel (and thus the system security policy) the permission to
interpret/execute scripts or other files containing what can be seen as
commands.

This third patch series mainly differ from the previous one by relying
on the new openat2(2) system call to get rid of the undefined behavior
of the open(2) flags.  Thus, the previous O_MAYEXEC flag is now replaced
with the new RESOLVE_MAYEXEC flag and benefits from the openat2(2)
strict check of this kind of flags.

A simple system-wide security policy can be enforced by the system
administrator through a sysctl configuration consistent with the mount
points or the file access rights.  The documentation patch explains the
prerequisites.

Furthermore, the security policy can also be delegated to an LSM, either
a MAC system or an integrity system.  For instance, the new kernel
MAY_OPENEXEC flag closes a major IMA measurement/appraisal interpreter
integrity gap by bringing the ability to check the use of scripts [1].
Other uses are expected, such as for openat2(2) [2], SGX integration
[3], bpffs [4] or IPE [5].

Userspace needs to adapt to take advantage of this new feature.  For
example, the PEP 578 [6] (Runtime Audit Hooks) enables Python 3.8 to be
extended with policy enforcement points related to code interpretation,
which can be used to align with the PowerShell audit features.
Additional Python security improvements (e.g. a limited interpreter
withou -c, stdin piping of code) are on their way.

The initial idea come from CLIP OS 4 and the original implementation has
been used for more than 11 years:
https://github.com/clipos-archive/clipos4_doc

An introduction to O_MAYEXEC (original name of RESOLVE_MAYEXEC) was
given at the Linux Security Summit Europe 2018 - Linux Kernel Security
Contributions by ANSSI:
https://www.youtube.com/watch?v=chNjCRtPKQY&t=17m15s
The "write xor execute" principle was explained at Kernel Recipes 2018 -
CLIP OS: a defense-in-depth OS:
https://www.youtube.com/watch?v=PjRE0uBtkHU&t=11m14s

This patch series can be applied on top of v5.7-rc3.  This can be tested
with CONFIG_SYSCTL.  I would really appreciate constructive comments on
this patch series.

Previous version:
https://lore.kernel.org/lkml/20190906152455.22757-1-mic@digikod.net/


[1] https://lore.kernel.org/lkml/1544647356.4028.105.camel@linux.ibm.com/
[2] https://lore.kernel.org/lkml/20190904201933.10736-6-cyphar@cyphar.com/
[3] https://lore.kernel.org/lkml/CALCETrVovr8XNZSroey7pHF46O=kj_c5D9K8h=z2T_cNrpvMig@mail.gmail.com/
[4] https://lore.kernel.org/lkml/CALCETrVeZ0eufFXwfhtaG_j+AdvbzEWE0M3wjXMWVEO7pj+xkw@mail.gmail.com/
[5] https://lore.kernel.org/lkml/20200406221439.1469862-12-deven.desai@linux.microsoft.com/
[6] https://www.python.org/dev/peps/pep-0578/

Regards,

Mickaël Salaün (5):
  fs: Add support for a RESOLVE_MAYEXEC flag on openat2(2)
  fs: Add a MAY_EXECMOUNT flag to infer the noexec mount property
  fs: Enable to enforce noexec mounts or file exec through
    RESOLVE_MAYEXEC
  selftest/openat2: Add tests for RESOLVE_MAYEXEC enforcing
  doc: Add documentation for the fs.open_mayexec_enforce sysctl

 Documentation/admin-guide/sysctl/fs.rst       |  43 +++
 fs/namei.c                                    |  74 +++-
 fs/open.c                                     |   6 +
 include/linux/fcntl.h                         |   2 +-
 include/linux/fs.h                            |   7 +
 include/uapi/linux/openat2.h                  |   6 +
 kernel/sysctl.c                               |   7 +
 tools/testing/selftests/kselftest_harness.h   |   3 +
 tools/testing/selftests/openat2/Makefile      |   3 +-
 tools/testing/selftests/openat2/config        |   1 +
 tools/testing/selftests/openat2/helpers.h     |   3 +
 .../testing/selftests/openat2/omayexec_test.c | 315 ++++++++++++++++++
 12 files changed, 467 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/openat2/config
 create mode 100644 tools/testing/selftests/openat2/omayexec_test.c

-- 
2.26.2

