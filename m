Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E479239C93
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Aug 2020 00:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728288AbgHBWAR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 2 Aug 2020 18:00:17 -0400
Received: from smtp-8fa8.mail.infomaniak.ch ([83.166.143.168]:58231 "EHLO
        smtp-8fa8.mail.infomaniak.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728051AbgHBV7k (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 2 Aug 2020 17:59:40 -0400
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4BKZgC1k2lzlhb5w;
        Sun,  2 Aug 2020 23:59:35 +0200 (CEST)
Received: from localhost (unknown [94.23.54.103])
        by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4BKZgB5sdmzlh8T4;
        Sun,  2 Aug 2020 23:59:34 +0200 (CEST)
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
Subject: [PATCH v20 09/12] arch: Wire up Landlock syscalls
Date:   Sun,  2 Aug 2020 23:59:00 +0200
Message-Id: <20200802215903.91936-10-mic@digikod.net>
X-Mailer: git-send-email 2.28.0.rc2
In-Reply-To: <20200802215903.91936-1-mic@digikod.net>
References: <20200802215903.91936-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Antivirus: Dr.Web (R) for Unix mail servers drweb plugin ver.6.0.2.8
X-Antivirus-Code: 0x100000
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Wire up the following system calls for all architectures:
* landlock_get_features(2)
* landlock_create_ruleset(2)
* landlock_add_rule(2)
* landlock_enforce_ruleset(2)

Signed-off-by: Mickaël Salaün <mic@digikod.net>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: James Morris <jmorris@namei.org>
Cc: Jann Horn <jannh@google.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Serge E. Hallyn <serge@hallyn.com>
---

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
 arch/alpha/kernel/syscalls/syscall.tbl      |  4 ++++
 arch/arm/tools/syscall.tbl                  |  4 ++++
 arch/arm64/include/asm/unistd.h             |  2 +-
 arch/arm64/include/asm/unistd32.h           |  8 ++++++++
 arch/ia64/kernel/syscalls/syscall.tbl       |  4 ++++
 arch/m68k/kernel/syscalls/syscall.tbl       |  4 ++++
 arch/microblaze/kernel/syscalls/syscall.tbl |  4 ++++
 arch/mips/kernel/syscalls/syscall_n32.tbl   |  4 ++++
 arch/mips/kernel/syscalls/syscall_n64.tbl   |  4 ++++
 arch/mips/kernel/syscalls/syscall_o32.tbl   |  4 ++++
 arch/parisc/kernel/syscalls/syscall.tbl     |  4 ++++
 arch/powerpc/kernel/syscalls/syscall.tbl    |  4 ++++
 arch/s390/kernel/syscalls/syscall.tbl       |  4 ++++
 arch/sh/kernel/syscalls/syscall.tbl         |  4 ++++
 arch/sparc/kernel/syscalls/syscall.tbl      |  4 ++++
 arch/x86/entry/syscalls/syscall_32.tbl      |  4 ++++
 arch/x86/entry/syscalls/syscall_64.tbl      |  4 ++++
 arch/xtensa/kernel/syscalls/syscall.tbl     |  4 ++++
 include/uapi/asm-generic/unistd.h           | 10 +++++++++-
 19 files changed, 82 insertions(+), 2 deletions(-)

diff --git a/arch/alpha/kernel/syscalls/syscall.tbl b/arch/alpha/kernel/syscalls/syscall.tbl
index 5ddd128d4b7a..d59664094690 100644
--- a/arch/alpha/kernel/syscalls/syscall.tbl
+++ b/arch/alpha/kernel/syscalls/syscall.tbl
@@ -478,3 +478,7 @@
 547	common	openat2				sys_openat2
 548	common	pidfd_getfd			sys_pidfd_getfd
 549	common	faccessat2			sys_faccessat2
+554	common	landlock_get_features		sys_landlock_get_features
+555	common	landlock_create_ruleset		sys_landlock_create_ruleset
+556	common	landlock_add_rule			sys_landlock_add_rule
+557	common	landlock_enforce_ruleset	sys_landlock_enforce_ruleset
diff --git a/arch/arm/tools/syscall.tbl b/arch/arm/tools/syscall.tbl
index d5cae5ffede0..9fe59a61fa75 100644
--- a/arch/arm/tools/syscall.tbl
+++ b/arch/arm/tools/syscall.tbl
@@ -452,3 +452,7 @@
 437	common	openat2				sys_openat2
 438	common	pidfd_getfd			sys_pidfd_getfd
 439	common	faccessat2			sys_faccessat2
+444	common	landlock_get_features		sys_landlock_get_features
+445	common	landlock_create_ruleset		sys_landlock_create_ruleset
+446	common	landlock_add_rule			sys_landlock_add_rule
+447	common	landlock_enforce_ruleset	sys_landlock_enforce_ruleset
diff --git a/arch/arm64/include/asm/unistd.h b/arch/arm64/include/asm/unistd.h
index 3b859596840d..fb7a0be2f3d9 100644
--- a/arch/arm64/include/asm/unistd.h
+++ b/arch/arm64/include/asm/unistd.h
@@ -38,7 +38,7 @@
 #define __ARM_NR_compat_set_tls		(__ARM_NR_COMPAT_BASE + 5)
 #define __ARM_NR_COMPAT_END		(__ARM_NR_COMPAT_BASE + 0x800)
 
-#define __NR_compat_syscalls		440
+#define __NR_compat_syscalls		448
 #endif
 
 #define __ARCH_WANT_SYS_CLONE
diff --git a/arch/arm64/include/asm/unistd32.h b/arch/arm64/include/asm/unistd32.h
index 6d95d0c8bf2f..d150396491e6 100644
--- a/arch/arm64/include/asm/unistd32.h
+++ b/arch/arm64/include/asm/unistd32.h
@@ -885,6 +885,14 @@ __SYSCALL(__NR_openat2, sys_openat2)
 __SYSCALL(__NR_pidfd_getfd, sys_pidfd_getfd)
 #define __NR_faccessat2 439
 __SYSCALL(__NR_faccessat2, sys_faccessat2)
+#define __NR_landlock_get_features 444
+__SYSCALL(__NR_landlock_get_features, sys_landlock_get_features)
+#define __NR_landlock_create_ruleset 445
+__SYSCALL(__NR_landlock_create_ruleset, sys_landlock_create_ruleset)
+#define __NR_landlock_add_rule 446
+__SYSCALL(__NR_landlock_add_rule, sys_landlock_add_rule)
+#define __NR_landlock_enforce_ruleset 447
+__SYSCALL(__NR_landlock_enforce_ruleset, sys_landloc_enforce_rulesetk)
 
 /*
  * Please add new compat syscalls above this comment and update
diff --git a/arch/ia64/kernel/syscalls/syscall.tbl b/arch/ia64/kernel/syscalls/syscall.tbl
index 49e325b604b3..84872f8daa42 100644
--- a/arch/ia64/kernel/syscalls/syscall.tbl
+++ b/arch/ia64/kernel/syscalls/syscall.tbl
@@ -359,3 +359,7 @@
 437	common	openat2				sys_openat2
 438	common	pidfd_getfd			sys_pidfd_getfd
 439	common	faccessat2			sys_faccessat2
+444	common	landlock_get_features		sys_landlock_get_features
+445	common	landlock_create_ruleset		sys_landlock_create_ruleset
+446	common	landlock_add_rule			sys_landlock_add_rule
+447	common	landlock_enforce_ruleset	sys_landlock_enforce_ruleset
diff --git a/arch/m68k/kernel/syscalls/syscall.tbl b/arch/m68k/kernel/syscalls/syscall.tbl
index f71b1bbcc198..a362b4b16d7b 100644
--- a/arch/m68k/kernel/syscalls/syscall.tbl
+++ b/arch/m68k/kernel/syscalls/syscall.tbl
@@ -438,3 +438,7 @@
 437	common	openat2				sys_openat2
 438	common	pidfd_getfd			sys_pidfd_getfd
 439	common	faccessat2			sys_faccessat2
+444	common	landlock_get_features		sys_landlock_get_features
+445	common	landlock_create_ruleset		sys_landlock_create_ruleset
+446	common	landlock_add_rule			sys_landlock_add_rule
+447	common	landlock_enforce_ruleset	sys_landlock_enforce_ruleset
diff --git a/arch/microblaze/kernel/syscalls/syscall.tbl b/arch/microblaze/kernel/syscalls/syscall.tbl
index edacc4561f2b..acc931725b43 100644
--- a/arch/microblaze/kernel/syscalls/syscall.tbl
+++ b/arch/microblaze/kernel/syscalls/syscall.tbl
@@ -444,3 +444,7 @@
 437	common	openat2				sys_openat2
 438	common	pidfd_getfd			sys_pidfd_getfd
 439	common	faccessat2			sys_faccessat2
+444	common	landlock_get_features		sys_landlock_get_features
+445	common	landlock_create_ruleset		sys_landlock_create_ruleset
+446	common	landlock_add_rule			sys_landlock_add_rule
+447	common	landlock_enforce_ruleset	sys_landlock_enforce_ruleset
diff --git a/arch/mips/kernel/syscalls/syscall_n32.tbl b/arch/mips/kernel/syscalls/syscall_n32.tbl
index f777141f5256..5e1d5bfced9d 100644
--- a/arch/mips/kernel/syscalls/syscall_n32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n32.tbl
@@ -377,3 +377,7 @@
 437	n32	openat2				sys_openat2
 438	n32	pidfd_getfd			sys_pidfd_getfd
 439	n32	faccessat2			sys_faccessat2
+444	n32	landlock_get_features		sys_landlock_get_features
+445	n32	landlock_create_ruleset		sys_landlock_create_ruleset
+446	n32	landlock_add_rule			sys_landlock_add_rule
+447	n32	landlock_enforce_ruleset	sys_landlock_enforce_ruleset
diff --git a/arch/mips/kernel/syscalls/syscall_n64.tbl b/arch/mips/kernel/syscalls/syscall_n64.tbl
index da8c76394e17..8d9b6175f4af 100644
--- a/arch/mips/kernel/syscalls/syscall_n64.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n64.tbl
@@ -353,3 +353,7 @@
 437	n64	openat2				sys_openat2
 438	n64	pidfd_getfd			sys_pidfd_getfd
 439	n64	faccessat2			sys_faccessat2
+444	n64	landlock_get_features		sys_landlock_get_features
+445	n64	landlock_create_ruleset		sys_landlock_create_ruleset
+446	n64	landlock_add_rule			sys_landlock_add_rule
+447	n64	landlock_enforce_ruleset	sys_landlock_enforce_ruleset
diff --git a/arch/mips/kernel/syscalls/syscall_o32.tbl b/arch/mips/kernel/syscalls/syscall_o32.tbl
index 13280625d312..66e58338772a 100644
--- a/arch/mips/kernel/syscalls/syscall_o32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_o32.tbl
@@ -426,3 +426,7 @@
 437	o32	openat2				sys_openat2
 438	o32	pidfd_getfd			sys_pidfd_getfd
 439	o32	faccessat2			sys_faccessat2
+444	o32	landlock_get_features		sys_landlock_get_features
+445	o32	landlock_create_ruleset		sys_landlock_create_ruleset
+446	o32	landlock_add_rule			sys_landlock_add_rule
+447	o32	landlock_enforce_ruleset	sys_landlock_enforce_ruleset
diff --git a/arch/parisc/kernel/syscalls/syscall.tbl b/arch/parisc/kernel/syscalls/syscall.tbl
index 5a758fa6ec52..70bdc7c43464 100644
--- a/arch/parisc/kernel/syscalls/syscall.tbl
+++ b/arch/parisc/kernel/syscalls/syscall.tbl
@@ -436,3 +436,7 @@
 437	common	openat2				sys_openat2
 438	common	pidfd_getfd			sys_pidfd_getfd
 439	common	faccessat2			sys_faccessat2
+444	common	landlock_get_features		sys_landlock_get_features
+445	common	landlock_create_ruleset		sys_landlock_create_ruleset
+446	common	landlock_add_rule			sys_landlock_add_rule
+447	common	landlock_enforce_ruleset	sys_landlock_enforce_ruleset
diff --git a/arch/powerpc/kernel/syscalls/syscall.tbl b/arch/powerpc/kernel/syscalls/syscall.tbl
index f833a3190822..3f1d2c12eb98 100644
--- a/arch/powerpc/kernel/syscalls/syscall.tbl
+++ b/arch/powerpc/kernel/syscalls/syscall.tbl
@@ -528,3 +528,7 @@
 437	common	openat2				sys_openat2
 438	common	pidfd_getfd			sys_pidfd_getfd
 439	common	faccessat2			sys_faccessat2
+444	common	landlock_get_features		sys_landlock_get_features
+445	common	landlock_create_ruleset		sys_landlock_create_ruleset
+446	common	landlock_add_rule			sys_landlock_add_rule
+447	common	landlock_enforce_ruleset	sys_landlock_enforce_ruleset
diff --git a/arch/s390/kernel/syscalls/syscall.tbl b/arch/s390/kernel/syscalls/syscall.tbl
index bfdcb7633957..577d590450e9 100644
--- a/arch/s390/kernel/syscalls/syscall.tbl
+++ b/arch/s390/kernel/syscalls/syscall.tbl
@@ -441,3 +441,7 @@
 437  common	openat2			sys_openat2			sys_openat2
 438  common	pidfd_getfd		sys_pidfd_getfd			sys_pidfd_getfd
 439  common	faccessat2		sys_faccessat2			sys_faccessat2
+444  common	landlock_get_features		sys_landlock_get_features		sys_landlock_get_features
+445  common	landlock_create_ruleset		sys_landlock_create_ruleset		sys_landlock_create_ruleset
+446  common	landlock_add_rule			sys_landlock_add_rule			sys_landlock_add_rule
+447  common	landlock_enforce_ruleset	sys_landlock_enforce_ruleset	sys_landlock_enforce_ruleset
diff --git a/arch/sh/kernel/syscalls/syscall.tbl b/arch/sh/kernel/syscalls/syscall.tbl
index acc35daa1b79..9202338a9e70 100644
--- a/arch/sh/kernel/syscalls/syscall.tbl
+++ b/arch/sh/kernel/syscalls/syscall.tbl
@@ -441,3 +441,7 @@
 437	common	openat2				sys_openat2
 438	common	pidfd_getfd			sys_pidfd_getfd
 439	common	faccessat2			sys_faccessat2
+444	common	landlock_get_features		sys_landlock_get_features
+445	common	landlock_create_ruleset		sys_landlock_create_ruleset
+446	common	landlock_add_rule			sys_landlock_add_rule
+447	common	landlock_enforce_ruleset	sys_landlock_enforce_ruleset
diff --git a/arch/sparc/kernel/syscalls/syscall.tbl b/arch/sparc/kernel/syscalls/syscall.tbl
index 8004a276cb74..b4c47eefda57 100644
--- a/arch/sparc/kernel/syscalls/syscall.tbl
+++ b/arch/sparc/kernel/syscalls/syscall.tbl
@@ -484,3 +484,7 @@
 437	common	openat2			sys_openat2
 438	common	pidfd_getfd			sys_pidfd_getfd
 439	common	faccessat2			sys_faccessat2
+444	common	landlock_get_features		sys_landlock_get_features
+445	common	landlock_create_ruleset		sys_landlock_create_ruleset
+446	common	landlock_add_rule			sys_landlock_add_rule
+447	common	landlock_enforce_ruleset	sys_landlock_enforce_ruleset
diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index d8f8a1a69ed1..26735df8c19e 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -443,3 +443,7 @@
 437	i386	openat2			sys_openat2
 438	i386	pidfd_getfd		sys_pidfd_getfd
 439	i386	faccessat2		sys_faccessat2
+444	i386	landlock_get_features		sys_landlock_get_features
+445	i386	landlock_create_ruleset		sys_landlock_create_ruleset
+446	i386	landlock_add_rule			sys_landlock_add_rule
+447	i386	landlock_enforce_ruleset	sys_landlock_enforce_ruleset
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index 78847b32e137..7e9c927b51fb 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -360,6 +360,10 @@
 437	common	openat2			sys_openat2
 438	common	pidfd_getfd		sys_pidfd_getfd
 439	common	faccessat2		sys_faccessat2
+444	common	landlock_get_features		sys_landlock_get_features
+445	common	landlock_create_ruleset		sys_landlock_create_ruleset
+446	common	landlock_add_rule			sys_landlock_add_rule
+447	common	landlock_enforce_ruleset	sys_landlock_enforce_ruleset
 
 #
 # x32-specific system call numbers start at 512 to avoid cache impact
diff --git a/arch/xtensa/kernel/syscalls/syscall.tbl b/arch/xtensa/kernel/syscalls/syscall.tbl
index 69d0d73876b3..c8b1a6218ee6 100644
--- a/arch/xtensa/kernel/syscalls/syscall.tbl
+++ b/arch/xtensa/kernel/syscalls/syscall.tbl
@@ -409,3 +409,7 @@
 437	common	openat2				sys_openat2
 438	common	pidfd_getfd			sys_pidfd_getfd
 439	common	faccessat2			sys_faccessat2
+444	common	landlock_get_features		sys_landlock_get_features
+445	common	landlock_create_ruleset		sys_landlock_create_ruleset
+446	common	landlock_add_rule			sys_landlock_add_rule
+447	common	landlock_enforce_ruleset	sys_landlock_enforce_ruleset
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index f4a01305d9a6..ff3afbf02b51 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -857,9 +857,17 @@ __SYSCALL(__NR_openat2, sys_openat2)
 __SYSCALL(__NR_pidfd_getfd, sys_pidfd_getfd)
 #define __NR_faccessat2 439
 __SYSCALL(__NR_faccessat2, sys_faccessat2)
+#define __NR_landlock_get_features 444
+__SYSCALL(__NR_landlock_get_features, sys_landlock_get_features)
+#define __NR_landlock_create_ruleset 445
+__SYSCALL(__NR_landlock_create_ruleset, sys_landlock_create_ruleset)
+#define __NR_landlock_add_rule 446
+__SYSCALL(__NR_landlock_add_rule, sys_landlock_add_rule)
+#define __NR_landlock_enforce_ruleset 447
+__SYSCALL(__NR_landlock_enforce_ruleset, sys_landloc_enforce_rulesetk)
 
 #undef __NR_syscalls
-#define __NR_syscalls 440
+#define __NR_syscalls 448
 
 /*
  * 32 bit systems traditionally used different
-- 
2.28.0.rc2

