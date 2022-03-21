Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4E3D4E2DAA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Mar 2022 17:15:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350963AbiCUQQd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Mar 2022 12:16:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350949AbiCUQQb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Mar 2022 12:16:31 -0400
Received: from smtp-190a.mail.infomaniak.ch (smtp-190a.mail.infomaniak.ch [IPv6:2001:1600:4:17::190a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A2376371;
        Mon, 21 Mar 2022 09:15:05 -0700 (PDT)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4KMfpY1xlxzMptNy;
        Mon, 21 Mar 2022 17:15:01 +0100 (CET)
Received: from localhost (unknown [23.97.221.149])
        by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4KMfpV5pNCzlhRVJ;
        Mon, 21 Mar 2022 17:14:58 +0100 (CET)
From:   =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Heimes <christian@python.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Paul Moore <paul@paul-moore.com>,
        =?UTF-8?q?Philippe=20Tr=C3=A9buchet?= 
        <philippe.trebuchet@ssi.gouv.fr>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Steve Dower <steve.dower@python.org>,
        Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>,
        Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
        linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: [GIT PULL] Add trusted_for(2) (was O_MAYEXEC)
Date:   Mon, 21 Mar 2022 17:15:57 +0100
Message-Id: <20220321161557.495388-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

This patch series adds a new syscall named trusted_for.  It enables user
space to ask the kernel: is this file descriptor's content trusted to be
used for this purpose?  The set of usage currently only contains
execution, but other may follow (e.g. configuration, sensitive data).
If the kernel identifies the file descriptor as trustworthy for this
usage, user space should then take this information into account.  The
"execution" usage means that the content of the file descriptor is
trusted according to the system policy to be executed by user space,
which means that it interprets the content or (try to) maps it as
executable memory.

A simple system-wide security policy can be set by the system
administrator through a sysctl configuration consistent with the mount
points or the file access rights.  The documentation explains the
prerequisites.

It is important to note that this can only enable to extend access
control managed by the kernel.  Hence it enables current access control
mechanism to be extended and become a superset of what they can
currently control.  Indeed, the security policy could also be delegated
to an LSM, either a MAC system or an integrity system.  For instance,
this is required to close a major IMA measurement/appraisal interpreter
integrity gap by bringing the ability to check the use of scripts.
Other uses are expected as well.

For further details, please see the latest cover letter:
https://lore.kernel.org/r/20220104155024.48023-1-mic@digikod.net

Commit dae71698b6c5 ("printk: Move back proc_dointvec_minmax_sysadmin()
to sysctl.c") was recently added due to the sysctl refactoring.

Commit e674341a90b9 ("selftests/interpreter: fix separate directory
build") will fix some test build cases as explained here:
https://lore.kernel.org/r/20220119101531.2850400-1-usama.anjum@collabora.com
Merging this commit without the new KHDR_INCLUDES is not an issue.
The upcoming kselftest pull request is ready:
https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/log/?h=next

This patch series has been open for review for more than three years and
got a lot of feedbacks (and bikeshedding) which were all considered.
Since I heard no objection, please consider to pull this code for
v5.18-rc1 .  These five patches have been successfully tested in the
latest linux-next releases for several weeks.

Regards,
 Mickaël

--
The following changes since commit dcb85f85fa6f142aae1fe86f399d4503d49f2b60:

  gcc-plugins/stackleak: Use noinstr in favor of notrace (2022-02-03 17:02:21 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git tags/trusted-for-v18

for you to fetch changes up to e674341a90b95c3458d684ae25e6891afc3e03ad:

  selftests/interpreter: fix separate directory build (2022-03-04 10:56:25 +0100)

----------------------------------------------------------------
Add the trusted_for system call (v18)

The final goal of this patch series is to enable the kernel to be a
global policy manager by entrusting processes with access control at
their level.  To reach this goal, two complementary parts are required:
* user space needs to be able to know if it can trust some file
  descriptor content for a specific usage;
* and the kernel needs to make available some part of the policy
  configured by the system administrator.

In a nutshell, this is a required building block to control script
execution.

For further details see the latest cover letter:
https://lore.kernel.org/r/20220104155024.48023-1-mic@digikod.net

----------------------------------------------------------------
Mickaël Salaün (4):
      printk: Move back proc_dointvec_minmax_sysadmin() to sysctl.c
      fs: Add trusted_for(2) syscall implementation and related sysctl
      arch: Wire up trusted_for(2)
      selftest/interpreter: Add tests for trusted_for(2) policies

Muhammad Usama Anjum (1):
      selftests/interpreter: fix separate directory build

 Documentation/admin-guide/sysctl/fs.rst            |  50 +++
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
 fs/open.c                                          | 133 ++++++++
 fs/proc/proc_sysctl.c                              |   2 +-
 include/linux/syscalls.h                           |   1 +
 include/linux/sysctl.h                             |   3 +
 include/uapi/asm-generic/unistd.h                  |   5 +-
 include/uapi/linux/trusted-for.h                   |  18 +
 kernel/printk/sysctl.c                             |   9 -
 kernel/sysctl.c                                    |   9 +
 tools/testing/selftests/Makefile                   |   1 +
 tools/testing/selftests/interpreter/.gitignore     |   2 +
 tools/testing/selftests/interpreter/Makefile       |  21 ++
 tools/testing/selftests/interpreter/config         |   1 +
 .../selftests/interpreter/trust_policy_test.c      | 362 +++++++++++++++++++++
 32 files changed, 625 insertions(+), 12 deletions(-)
 create mode 100644 include/uapi/linux/trusted-for.h
 create mode 100644 tools/testing/selftests/interpreter/.gitignore
 create mode 100644 tools/testing/selftests/interpreter/Makefile
 create mode 100644 tools/testing/selftests/interpreter/config
 create mode 100644 tools/testing/selftests/interpreter/trust_policy_test.c
