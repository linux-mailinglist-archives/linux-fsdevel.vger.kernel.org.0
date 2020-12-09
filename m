Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 202A22D4A62
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Dec 2020 20:35:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387645AbgLITa3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Dec 2020 14:30:29 -0500
Received: from smtp-190e.mail.infomaniak.ch ([185.125.25.14]:39205 "EHLO
        smtp-190e.mail.infomaniak.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387654AbgLITaY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Dec 2020 14:30:24 -0500
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4CrnCw4W2lzlhPVZ;
        Wed,  9 Dec 2020 20:29:00 +0100 (CET)
Received: from localhost (unknown [23.97.221.149])
        by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4CrnCw1zYDzlppyf;
        Wed,  9 Dec 2020 20:29:00 +0100 (CET)
From:   =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To:     James Morris <jmorris@namei.org>, Jann Horn <jannh@google.com>,
        "Serge E . Hallyn" <serge@hallyn.com>
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@amacapital.net>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Casey Schaufler <casey@schaufler-ca.com>,
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
        linux-security-module@vger.kernel.org, x86@kernel.org,
        =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@linux.microsoft.com>
Subject: [PATCH v26 09/12] arch: Wire up Landlock syscalls
Date:   Wed,  9 Dec 2020 20:28:36 +0100
Message-Id: <20201209192839.1396820-10-mic@digikod.net>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201209192839.1396820-1-mic@digikod.net>
References: <20201209192839.1396820-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Mickaël Salaün <mic@linux.microsoft.com>

Wire up the following system calls for all architectures:
* landlock_create_ruleset(2)
* landlock_add_rule(2)
* landlock_enforce_ruleset_current(2)

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: James Morris <jmorris@namei.org>
Cc: Jann Horn <jannh@google.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Serge E. Hallyn <serge@hallyn.com>
Signed-off-by: Mickaël Salaün <mic@linux.microsoft.com>
---

Changes since v25:
* Rebase and leave space for the new epoll_pwait2(2) and memfd_secret(2)
  from -next.

Changes since v21:
* Rebase and leave space for watch_mount(2) from -next.

Changes since v20:
* Remove landlock_get_features(2).
* Decrease syscall numbers to stick to process_madvise(2) in -next.
* Rename landlock_enforce_ruleset(2) to
  landlock_enforce_ruleset_current(2).

Changes since v19:
* Increase syscall numbers by 4 to leave space for new ones (in
  linux-next): watch_mount(2), watch_sb(2), fsinfo(2) and
  process_madvise(2) (requested by Arnd Bergmann).
* Replace the previous multiplexor landlock(2) with 4 syscalls:
  landlock_get_features(2), landlock_create_ruleset(2),
  landlock_add_rule(2) and landlock_enforce_ruleset(2).

Changes since v18:
* Increase the syscall number because of the new faccessat2(2).

Changes since v14:
* Add all architectures.

Changes since v13:
* New implementation.
---
 arch/alpha/kernel/syscalls/syscall.tbl      | 3 +++
 arch/arm/tools/syscall.tbl                  | 3 +++
 arch/arm64/include/asm/unistd.h             | 2 +-
 arch/arm64/include/asm/unistd32.h           | 6 ++++++
 arch/ia64/kernel/syscalls/syscall.tbl       | 3 +++
 arch/m68k/kernel/syscalls/syscall.tbl       | 3 +++
 arch/microblaze/kernel/syscalls/syscall.tbl | 3 +++
 arch/mips/kernel/syscalls/syscall_n32.tbl   | 3 +++
 arch/mips/kernel/syscalls/syscall_n64.tbl   | 3 +++
 arch/mips/kernel/syscalls/syscall_o32.tbl   | 3 +++
 arch/parisc/kernel/syscalls/syscall.tbl     | 3 +++
 arch/powerpc/kernel/syscalls/syscall.tbl    | 3 +++
 arch/s390/kernel/syscalls/syscall.tbl       | 3 +++
 arch/sh/kernel/syscalls/syscall.tbl         | 3 +++
 arch/sparc/kernel/syscalls/syscall.tbl      | 3 +++
 arch/x86/entry/syscalls/syscall_32.tbl      | 3 +++
 arch/x86/entry/syscalls/syscall_64.tbl      | 3 +++
 arch/xtensa/kernel/syscalls/syscall.tbl     | 3 +++
 include/uapi/asm-generic/unistd.h           | 8 +++++++-
 19 files changed, 62 insertions(+), 2 deletions(-)

diff --git a/arch/alpha/kernel/syscalls/syscall.tbl b/arch/alpha/kernel/syscalls/syscall.tbl
index ee7b01bb7346..80cd3f9be707 100644
--- a/arch/alpha/kernel/syscalls/syscall.tbl
+++ b/arch/alpha/kernel/syscalls/syscall.tbl
@@ -480,3 +480,6 @@
 548	common	pidfd_getfd			sys_pidfd_getfd
 549	common	faccessat2			sys_faccessat2
 550	common	process_madvise			sys_process_madvise
+554	common	landlock_create_ruleset				sys_landlock_create_ruleset
+555	common	landlock_add_rule					sys_landlock_add_rule
+556	common	landlock_enforce_ruleset_current	sys_landlock_enforce_ruleset_current
diff --git a/arch/arm/tools/syscall.tbl b/arch/arm/tools/syscall.tbl
index d056a548358e..e0a342365810 100644
--- a/arch/arm/tools/syscall.tbl
+++ b/arch/arm/tools/syscall.tbl
@@ -454,3 +454,6 @@
 438	common	pidfd_getfd			sys_pidfd_getfd
 439	common	faccessat2			sys_faccessat2
 440	common	process_madvise			sys_process_madvise
+444	common	landlock_create_ruleset				sys_landlock_create_ruleset
+445	common	landlock_add_rule					sys_landlock_add_rule
+446	common	landlock_enforce_ruleset_current	sys_landlock_enforce_ruleset_current
diff --git a/arch/arm64/include/asm/unistd.h b/arch/arm64/include/asm/unistd.h
index b3b2019f8d16..727bfc3be99b 100644
--- a/arch/arm64/include/asm/unistd.h
+++ b/arch/arm64/include/asm/unistd.h
@@ -38,7 +38,7 @@
 #define __ARM_NR_compat_set_tls		(__ARM_NR_COMPAT_BASE + 5)
 #define __ARM_NR_COMPAT_END		(__ARM_NR_COMPAT_BASE + 0x800)
 
-#define __NR_compat_syscalls		441
+#define __NR_compat_syscalls		447
 #endif
 
 #define __ARCH_WANT_SYS_CLONE
diff --git a/arch/arm64/include/asm/unistd32.h b/arch/arm64/include/asm/unistd32.h
index 107f08e03b9f..948c94b81bf4 100644
--- a/arch/arm64/include/asm/unistd32.h
+++ b/arch/arm64/include/asm/unistd32.h
@@ -889,6 +889,12 @@ __SYSCALL(__NR_pidfd_getfd, sys_pidfd_getfd)
 __SYSCALL(__NR_faccessat2, sys_faccessat2)
 #define __NR_process_madvise 440
 __SYSCALL(__NR_process_madvise, sys_process_madvise)
+#define __NR_landlock_create_ruleset 444
+__SYSCALL(__NR_landlock_create_ruleset, sys_landlock_create_ruleset)
+#define __NR_landlock_add_rule 445
+__SYSCALL(__NR_landlock_add_rule, sys_landlock_add_rule)
+#define __NR_landlock_enforce_ruleset_current 446
+__SYSCALL(__NR_landlock_enforce_ruleset_current, sys_landlock_enforce_ruleset_current)
 
 /*
  * Please add new compat syscalls above this comment and update
diff --git a/arch/ia64/kernel/syscalls/syscall.tbl b/arch/ia64/kernel/syscalls/syscall.tbl
index b96ed8b8a508..6b4d8dc22521 100644
--- a/arch/ia64/kernel/syscalls/syscall.tbl
+++ b/arch/ia64/kernel/syscalls/syscall.tbl
@@ -361,3 +361,6 @@
 438	common	pidfd_getfd			sys_pidfd_getfd
 439	common	faccessat2			sys_faccessat2
 440	common	process_madvise			sys_process_madvise
+444	common	landlock_create_ruleset				sys_landlock_create_ruleset
+445	common	landlock_add_rule					sys_landlock_add_rule
+446	common	landlock_enforce_ruleset_current	sys_landlock_enforce_ruleset_current
diff --git a/arch/m68k/kernel/syscalls/syscall.tbl b/arch/m68k/kernel/syscalls/syscall.tbl
index 625fb6d32842..d3eeced3b67e 100644
--- a/arch/m68k/kernel/syscalls/syscall.tbl
+++ b/arch/m68k/kernel/syscalls/syscall.tbl
@@ -440,3 +440,6 @@
 438	common	pidfd_getfd			sys_pidfd_getfd
 439	common	faccessat2			sys_faccessat2
 440	common	process_madvise			sys_process_madvise
+444	common	landlock_create_ruleset				sys_landlock_create_ruleset
+445	common	landlock_add_rule					sys_landlock_add_rule
+446	common	landlock_enforce_ruleset_current	sys_landlock_enforce_ruleset_current
diff --git a/arch/microblaze/kernel/syscalls/syscall.tbl b/arch/microblaze/kernel/syscalls/syscall.tbl
index aae729c95cf9..a49c0969a008 100644
--- a/arch/microblaze/kernel/syscalls/syscall.tbl
+++ b/arch/microblaze/kernel/syscalls/syscall.tbl
@@ -446,3 +446,6 @@
 438	common	pidfd_getfd			sys_pidfd_getfd
 439	common	faccessat2			sys_faccessat2
 440	common	process_madvise			sys_process_madvise
+444	common	landlock_create_ruleset				sys_landlock_create_ruleset
+445	common	landlock_add_rule					sys_landlock_add_rule
+446	common	landlock_enforce_ruleset_current	sys_landlock_enforce_ruleset_current
diff --git a/arch/mips/kernel/syscalls/syscall_n32.tbl b/arch/mips/kernel/syscalls/syscall_n32.tbl
index 32817c954435..ebc2cce814aa 100644
--- a/arch/mips/kernel/syscalls/syscall_n32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n32.tbl
@@ -379,3 +379,6 @@
 438	n32	pidfd_getfd			sys_pidfd_getfd
 439	n32	faccessat2			sys_faccessat2
 440	n32	process_madvise			sys_process_madvise
+444	n32	landlock_create_ruleset				sys_landlock_create_ruleset
+445	n32	landlock_add_rule					sys_landlock_add_rule
+446	n32	landlock_enforce_ruleset_current	sys_landlock_enforce_ruleset_current
diff --git a/arch/mips/kernel/syscalls/syscall_n64.tbl b/arch/mips/kernel/syscalls/syscall_n64.tbl
index 9e4ea3c31b1c..90aca7ec78f9 100644
--- a/arch/mips/kernel/syscalls/syscall_n64.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n64.tbl
@@ -355,3 +355,6 @@
 438	n64	pidfd_getfd			sys_pidfd_getfd
 439	n64	faccessat2			sys_faccessat2
 440	n64	process_madvise			sys_process_madvise
+444	n64	landlock_create_ruleset				sys_landlock_create_ruleset
+445	n64	landlock_add_rule					sys_landlock_add_rule
+446	n64	landlock_enforce_ruleset_current	sys_landlock_enforce_ruleset_current
diff --git a/arch/mips/kernel/syscalls/syscall_o32.tbl b/arch/mips/kernel/syscalls/syscall_o32.tbl
index 29f5f28cf5ce..27baa95ca36c 100644
--- a/arch/mips/kernel/syscalls/syscall_o32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_o32.tbl
@@ -428,3 +428,6 @@
 438	o32	pidfd_getfd			sys_pidfd_getfd
 439	o32	faccessat2			sys_faccessat2
 440	o32	process_madvise			sys_process_madvise
+444	o32	landlock_create_ruleset				sys_landlock_create_ruleset
+445	o32	landlock_add_rule					sys_landlock_add_rule
+446	o32	landlock_enforce_ruleset_current	sys_landlock_enforce_ruleset_current
diff --git a/arch/parisc/kernel/syscalls/syscall.tbl b/arch/parisc/kernel/syscalls/syscall.tbl
index f375ea528e59..2d3c89792030 100644
--- a/arch/parisc/kernel/syscalls/syscall.tbl
+++ b/arch/parisc/kernel/syscalls/syscall.tbl
@@ -438,3 +438,6 @@
 438	common	pidfd_getfd			sys_pidfd_getfd
 439	common	faccessat2			sys_faccessat2
 440	common	process_madvise			sys_process_madvise
+444	common	landlock_create_ruleset				sys_landlock_create_ruleset
+445	common	landlock_add_rule					sys_landlock_add_rule
+446	common	landlock_enforce_ruleset_current	sys_landlock_enforce_ruleset_current
diff --git a/arch/powerpc/kernel/syscalls/syscall.tbl b/arch/powerpc/kernel/syscalls/syscall.tbl
index 1275daec7fec..1afaaddb5219 100644
--- a/arch/powerpc/kernel/syscalls/syscall.tbl
+++ b/arch/powerpc/kernel/syscalls/syscall.tbl
@@ -530,3 +530,6 @@
 438	common	pidfd_getfd			sys_pidfd_getfd
 439	common	faccessat2			sys_faccessat2
 440	common	process_madvise			sys_process_madvise
+444	common	landlock_create_ruleset				sys_landlock_create_ruleset
+445	common	landlock_add_rule					sys_landlock_add_rule
+446	common	landlock_enforce_ruleset_current	sys_landlock_enforce_ruleset_current
diff --git a/arch/s390/kernel/syscalls/syscall.tbl b/arch/s390/kernel/syscalls/syscall.tbl
index 28c168000483..af540c39ef1f 100644
--- a/arch/s390/kernel/syscalls/syscall.tbl
+++ b/arch/s390/kernel/syscalls/syscall.tbl
@@ -443,3 +443,6 @@
 438  common	pidfd_getfd		sys_pidfd_getfd			sys_pidfd_getfd
 439  common	faccessat2		sys_faccessat2			sys_faccessat2
 440  common	process_madvise		sys_process_madvise		sys_process_madvise
+444  common	landlock_create_ruleset				sys_landlock_create_ruleset				sys_landlock_create_ruleset
+445  common	landlock_add_rule					sys_landlock_add_rule					sys_landlock_add_rule
+446  common	landlock_enforce_ruleset_current	sys_landlock_enforce_ruleset_current	sys_landlock_enforce_ruleset_current
diff --git a/arch/sh/kernel/syscalls/syscall.tbl b/arch/sh/kernel/syscalls/syscall.tbl
index 783738448ff5..9439eeb42846 100644
--- a/arch/sh/kernel/syscalls/syscall.tbl
+++ b/arch/sh/kernel/syscalls/syscall.tbl
@@ -443,3 +443,6 @@
 438	common	pidfd_getfd			sys_pidfd_getfd
 439	common	faccessat2			sys_faccessat2
 440	common	process_madvise			sys_process_madvise
+444	common	landlock_create_ruleset				sys_landlock_create_ruleset
+445	common	landlock_add_rule					sys_landlock_add_rule
+446	common	landlock_enforce_ruleset_current	sys_landlock_enforce_ruleset_current
diff --git a/arch/sparc/kernel/syscalls/syscall.tbl b/arch/sparc/kernel/syscalls/syscall.tbl
index 78160260991b..b08e8d30b40f 100644
--- a/arch/sparc/kernel/syscalls/syscall.tbl
+++ b/arch/sparc/kernel/syscalls/syscall.tbl
@@ -486,3 +486,6 @@
 438	common	pidfd_getfd			sys_pidfd_getfd
 439	common	faccessat2			sys_faccessat2
 440	common	process_madvise			sys_process_madvise
+444	common	landlock_create_ruleset				sys_landlock_create_ruleset
+445	common	landlock_add_rule					sys_landlock_add_rule
+446	common	landlock_enforce_ruleset_current	sys_landlock_enforce_ruleset_current
diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index 0d0667a9fbd7..e54a032affe2 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -445,3 +445,6 @@
 438	i386	pidfd_getfd		sys_pidfd_getfd
 439	i386	faccessat2		sys_faccessat2
 440	i386	process_madvise		sys_process_madvise
+444	i386	landlock_create_ruleset				sys_landlock_create_ruleset
+445	i386	landlock_add_rule					sys_landlock_add_rule
+446	i386	landlock_enforce_ruleset_current	sys_landlock_enforce_ruleset_current
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index 379819244b91..3b1998c9e37b 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -362,6 +362,9 @@
 438	common	pidfd_getfd		sys_pidfd_getfd
 439	common	faccessat2		sys_faccessat2
 440	common	process_madvise		sys_process_madvise
+444	common	landlock_create_ruleset				sys_landlock_create_ruleset
+445	common	landlock_add_rule					sys_landlock_add_rule
+446	common	landlock_enforce_ruleset_current	sys_landlock_enforce_ruleset_current
 
 #
 # Due to a historical design error, certain syscalls are numbered differently
diff --git a/arch/xtensa/kernel/syscalls/syscall.tbl b/arch/xtensa/kernel/syscalls/syscall.tbl
index b070f272995d..626ff97c677d 100644
--- a/arch/xtensa/kernel/syscalls/syscall.tbl
+++ b/arch/xtensa/kernel/syscalls/syscall.tbl
@@ -411,3 +411,6 @@
 438	common	pidfd_getfd			sys_pidfd_getfd
 439	common	faccessat2			sys_faccessat2
 440	common	process_madvise			sys_process_madvise
+444	common	landlock_create_ruleset				sys_landlock_create_ruleset
+445	common	landlock_add_rule					sys_landlock_add_rule
+446	common	landlock_enforce_ruleset_current	sys_landlock_enforce_ruleset_current
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index 2056318988f7..7c37ff4c3c03 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -859,9 +859,15 @@ __SYSCALL(__NR_pidfd_getfd, sys_pidfd_getfd)
 __SYSCALL(__NR_faccessat2, sys_faccessat2)
 #define __NR_process_madvise 440
 __SYSCALL(__NR_process_madvise, sys_process_madvise)
+#define __NR_landlock_create_ruleset 444
+__SYSCALL(__NR_landlock_create_ruleset, sys_landlock_create_ruleset)
+#define __NR_landlock_add_rule 445
+__SYSCALL(__NR_landlock_add_rule, sys_landlock_add_rule)
+#define __NR_landlock_enforce_ruleset_current 446
+__SYSCALL(__NR_landlock_enforce_ruleset_current, sys_landlock_enforce_ruleset_current)
 
 #undef __NR_syscalls
-#define __NR_syscalls 441
+#define __NR_syscalls 447
 
 /*
  * 32 bit systems traditionally used different
-- 
2.29.2

