Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71FB0287747
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Oct 2020 17:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731192AbgJHPbs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Oct 2020 11:31:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731154AbgJHPbf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Oct 2020 11:31:35 -0400
Received: from smtp-190e.mail.infomaniak.ch (smtp-190e.mail.infomaniak.ch [IPv6:2001:1600:4:17::190e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7925C0613B4
        for <linux-fsdevel@vger.kernel.org>; Thu,  8 Oct 2020 08:31:28 -0700 (PDT)
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4C6ZtL4PJWzlhcX9;
        Thu,  8 Oct 2020 17:31:22 +0200 (CEST)
Received: from localhost (unknown [94.23.54.103])
        by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4C6ZtL2GKpzlh8gR;
        Thu,  8 Oct 2020 17:31:22 +0200 (CEST)
From:   =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To:     linux-kernel@vger.kernel.org, James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Richard Weinberger <richard@nod.at>
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Andy Lutomirski <luto@amacapital.net>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Jann Horn <jannh@google.com>, Jeff Dike <jdike@addtoit.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Vincent Dagonneau <vincent.dagonneau@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-security-module@vger.kernel.org, x86@kernel.org,
        =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@linux.microsoft.com>
Subject: [PATCH v21 09/12] arch: Wire up Landlock syscalls
Date:   Thu,  8 Oct 2020 17:31:00 +0200
Message-Id: <20201008153103.1155388-10-mic@digikod.net>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201008153103.1155388-1-mic@digikod.net>
References: <20201008153103.1155388-1-mic@digikod.net>
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
index ec8bed9e7b75..227027a0c6a8 100644
--- a/arch/alpha/kernel/syscalls/syscall.tbl
+++ b/arch/alpha/kernel/syscalls/syscall.tbl
@@ -479,3 +479,6 @@
 547	common	openat2				sys_openat2
 548	common	pidfd_getfd			sys_pidfd_getfd
 549	common	faccessat2			sys_faccessat2
+552	common	landlock_create_ruleset				sys_landlock_create_ruleset
+553	common	landlock_add_rule					sys_landlock_add_rule
+554	common	landlock_enforce_ruleset_current	sys_landlock_enforce_ruleset_current
diff --git a/arch/arm/tools/syscall.tbl b/arch/arm/tools/syscall.tbl
index 171077cbf419..fa06bad9b5c2 100644
--- a/arch/arm/tools/syscall.tbl
+++ b/arch/arm/tools/syscall.tbl
@@ -453,3 +453,6 @@
 437	common	openat2				sys_openat2
 438	common	pidfd_getfd			sys_pidfd_getfd
 439	common	faccessat2			sys_faccessat2
+442	common	landlock_create_ruleset				sys_landlock_create_ruleset
+443	common	landlock_add_rule					sys_landlock_add_rule
+444	common	landlock_enforce_ruleset_current	sys_landlock_enforce_ruleset_current
diff --git a/arch/arm64/include/asm/unistd.h b/arch/arm64/include/asm/unistd.h
index 3b859596840d..64ebdc1ec581 100644
--- a/arch/arm64/include/asm/unistd.h
+++ b/arch/arm64/include/asm/unistd.h
@@ -38,7 +38,7 @@
 #define __ARM_NR_compat_set_tls		(__ARM_NR_COMPAT_BASE + 5)
 #define __ARM_NR_COMPAT_END		(__ARM_NR_COMPAT_BASE + 0x800)
 
-#define __NR_compat_syscalls		440
+#define __NR_compat_syscalls		445
 #endif
 
 #define __ARCH_WANT_SYS_CLONE
diff --git a/arch/arm64/include/asm/unistd32.h b/arch/arm64/include/asm/unistd32.h
index 734860ac7cf9..77b4445ef502 100644
--- a/arch/arm64/include/asm/unistd32.h
+++ b/arch/arm64/include/asm/unistd32.h
@@ -887,6 +887,12 @@ __SYSCALL(__NR_openat2, sys_openat2)
 __SYSCALL(__NR_pidfd_getfd, sys_pidfd_getfd)
 #define __NR_faccessat2 439
 __SYSCALL(__NR_faccessat2, sys_faccessat2)
+#define __NR_landlock_create_ruleset 442
+__SYSCALL(__NR_landlock_create_ruleset, sys_landlock_create_ruleset)
+#define __NR_landlock_add_rule 443
+__SYSCALL(__NR_landlock_add_rule, sys_landlock_add_rule)
+#define __NR_landlock_enforce_ruleset_current 444
+__SYSCALL(__NR_landlock_enforce_ruleset_current, sys_landlock_enforce_ruleset_current)
 
 /*
  * Please add new compat syscalls above this comment and update
diff --git a/arch/ia64/kernel/syscalls/syscall.tbl b/arch/ia64/kernel/syscalls/syscall.tbl
index f52a41f4c340..d6b2a1352c54 100644
--- a/arch/ia64/kernel/syscalls/syscall.tbl
+++ b/arch/ia64/kernel/syscalls/syscall.tbl
@@ -360,3 +360,6 @@
 437	common	openat2				sys_openat2
 438	common	pidfd_getfd			sys_pidfd_getfd
 439	common	faccessat2			sys_faccessat2
+442	common	landlock_create_ruleset				sys_landlock_create_ruleset
+443	common	landlock_add_rule					sys_landlock_add_rule
+444	common	landlock_enforce_ruleset_current	sys_landlock_enforce_ruleset_current
diff --git a/arch/m68k/kernel/syscalls/syscall.tbl b/arch/m68k/kernel/syscalls/syscall.tbl
index 81fc799d8392..ee50b7897f2d 100644
--- a/arch/m68k/kernel/syscalls/syscall.tbl
+++ b/arch/m68k/kernel/syscalls/syscall.tbl
@@ -439,3 +439,6 @@
 437	common	openat2				sys_openat2
 438	common	pidfd_getfd			sys_pidfd_getfd
 439	common	faccessat2			sys_faccessat2
+442	common	landlock_create_ruleset				sys_landlock_create_ruleset
+443	common	landlock_add_rule					sys_landlock_add_rule
+444	common	landlock_enforce_ruleset_current	sys_landlock_enforce_ruleset_current
diff --git a/arch/microblaze/kernel/syscalls/syscall.tbl b/arch/microblaze/kernel/syscalls/syscall.tbl
index b4e263916f41..6f53689c1d75 100644
--- a/arch/microblaze/kernel/syscalls/syscall.tbl
+++ b/arch/microblaze/kernel/syscalls/syscall.tbl
@@ -445,3 +445,6 @@
 437	common	openat2				sys_openat2
 438	common	pidfd_getfd			sys_pidfd_getfd
 439	common	faccessat2			sys_faccessat2
+442	common	landlock_create_ruleset				sys_landlock_create_ruleset
+443	common	landlock_add_rule					sys_landlock_add_rule
+444	common	landlock_enforce_ruleset_current	sys_landlock_enforce_ruleset_current
diff --git a/arch/mips/kernel/syscalls/syscall_n32.tbl b/arch/mips/kernel/syscalls/syscall_n32.tbl
index f9df9edb67a4..4f27b6245dc6 100644
--- a/arch/mips/kernel/syscalls/syscall_n32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n32.tbl
@@ -378,3 +378,6 @@
 437	n32	openat2				sys_openat2
 438	n32	pidfd_getfd			sys_pidfd_getfd
 439	n32	faccessat2			sys_faccessat2
+442	n32	landlock_create_ruleset				sys_landlock_create_ruleset
+443	n32	landlock_add_rule					sys_landlock_add_rule
+444	n32	landlock_enforce_ruleset_current	sys_landlock_enforce_ruleset_current
diff --git a/arch/mips/kernel/syscalls/syscall_n64.tbl b/arch/mips/kernel/syscalls/syscall_n64.tbl
index 557f9954a2b9..faa708b1793a 100644
--- a/arch/mips/kernel/syscalls/syscall_n64.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n64.tbl
@@ -354,3 +354,6 @@
 437	n64	openat2				sys_openat2
 438	n64	pidfd_getfd			sys_pidfd_getfd
 439	n64	faccessat2			sys_faccessat2
+442	n64	landlock_create_ruleset				sys_landlock_create_ruleset
+443	n64	landlock_add_rule					sys_landlock_add_rule
+444	n64	landlock_enforce_ruleset_current	sys_landlock_enforce_ruleset_current
diff --git a/arch/mips/kernel/syscalls/syscall_o32.tbl b/arch/mips/kernel/syscalls/syscall_o32.tbl
index 195b43cf27c8..690733712a6b 100644
--- a/arch/mips/kernel/syscalls/syscall_o32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_o32.tbl
@@ -427,3 +427,6 @@
 437	o32	openat2				sys_openat2
 438	o32	pidfd_getfd			sys_pidfd_getfd
 439	o32	faccessat2			sys_faccessat2
+442	o32	landlock_create_ruleset				sys_landlock_create_ruleset
+443	o32	landlock_add_rule					sys_landlock_add_rule
+444	o32	landlock_enforce_ruleset_current	sys_landlock_enforce_ruleset_current
diff --git a/arch/parisc/kernel/syscalls/syscall.tbl b/arch/parisc/kernel/syscalls/syscall.tbl
index def64d221cd4..c94b6ae18db3 100644
--- a/arch/parisc/kernel/syscalls/syscall.tbl
+++ b/arch/parisc/kernel/syscalls/syscall.tbl
@@ -437,3 +437,6 @@
 437	common	openat2				sys_openat2
 438	common	pidfd_getfd			sys_pidfd_getfd
 439	common	faccessat2			sys_faccessat2
+442	common	landlock_create_ruleset				sys_landlock_create_ruleset
+443	common	landlock_add_rule					sys_landlock_add_rule
+444	common	landlock_enforce_ruleset_current	sys_landlock_enforce_ruleset_current
diff --git a/arch/powerpc/kernel/syscalls/syscall.tbl b/arch/powerpc/kernel/syscalls/syscall.tbl
index c2d737ff2e7b..d57acab56da2 100644
--- a/arch/powerpc/kernel/syscalls/syscall.tbl
+++ b/arch/powerpc/kernel/syscalls/syscall.tbl
@@ -529,3 +529,6 @@
 437	common	openat2				sys_openat2
 438	common	pidfd_getfd			sys_pidfd_getfd
 439	common	faccessat2			sys_faccessat2
+442	common	landlock_create_ruleset				sys_landlock_create_ruleset
+443	common	landlock_add_rule					sys_landlock_add_rule
+444	common	landlock_enforce_ruleset_current	sys_landlock_enforce_ruleset_current
diff --git a/arch/s390/kernel/syscalls/syscall.tbl b/arch/s390/kernel/syscalls/syscall.tbl
index 10456bc936fb..5fc8c88ff347 100644
--- a/arch/s390/kernel/syscalls/syscall.tbl
+++ b/arch/s390/kernel/syscalls/syscall.tbl
@@ -442,3 +442,6 @@
 437  common	openat2			sys_openat2			sys_openat2
 438  common	pidfd_getfd		sys_pidfd_getfd			sys_pidfd_getfd
 439  common	faccessat2		sys_faccessat2			sys_faccessat2
+442  common	landlock_create_ruleset				sys_landlock_create_ruleset				sys_landlock_create_ruleset
+443  common	landlock_add_rule					sys_landlock_add_rule					sys_landlock_add_rule
+444  common	landlock_enforce_ruleset_current	sys_landlock_enforce_ruleset_current	sys_landlock_enforce_ruleset_current
diff --git a/arch/sh/kernel/syscalls/syscall.tbl b/arch/sh/kernel/syscalls/syscall.tbl
index ae0a00beea5f..5e7416148dca 100644
--- a/arch/sh/kernel/syscalls/syscall.tbl
+++ b/arch/sh/kernel/syscalls/syscall.tbl
@@ -442,3 +442,6 @@
 437	common	openat2				sys_openat2
 438	common	pidfd_getfd			sys_pidfd_getfd
 439	common	faccessat2			sys_faccessat2
+442	common	landlock_create_ruleset				sys_landlock_create_ruleset
+443	common	landlock_add_rule					sys_landlock_add_rule
+444	common	landlock_enforce_ruleset_current	sys_landlock_enforce_ruleset_current
diff --git a/arch/sparc/kernel/syscalls/syscall.tbl b/arch/sparc/kernel/syscalls/syscall.tbl
index 4af114e84f20..b5c63d533374 100644
--- a/arch/sparc/kernel/syscalls/syscall.tbl
+++ b/arch/sparc/kernel/syscalls/syscall.tbl
@@ -485,3 +485,6 @@
 437	common	openat2			sys_openat2
 438	common	pidfd_getfd			sys_pidfd_getfd
 439	common	faccessat2			sys_faccessat2
+442	common	landlock_create_ruleset				sys_landlock_create_ruleset
+443	common	landlock_add_rule					sys_landlock_add_rule
+444	common	landlock_enforce_ruleset_current	sys_landlock_enforce_ruleset_current
diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index 9d1102873666..51ff6d351647 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -444,3 +444,6 @@
 437	i386	openat2			sys_openat2
 438	i386	pidfd_getfd		sys_pidfd_getfd
 439	i386	faccessat2		sys_faccessat2
+442	i386	landlock_create_ruleset				sys_landlock_create_ruleset
+443	i386	landlock_add_rule					sys_landlock_add_rule
+444	i386	landlock_enforce_ruleset_current	sys_landlock_enforce_ruleset_current
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index f30d6ae9a688..6726431ed37e 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -361,6 +361,9 @@
 437	common	openat2			sys_openat2
 438	common	pidfd_getfd		sys_pidfd_getfd
 439	common	faccessat2		sys_faccessat2
+442	common	landlock_create_ruleset				sys_landlock_create_ruleset
+443	common	landlock_add_rule					sys_landlock_add_rule
+444	common	landlock_enforce_ruleset_current	sys_landlock_enforce_ruleset_current
 
 #
 # x32-specific system call numbers start at 512 to avoid cache impact
diff --git a/arch/xtensa/kernel/syscalls/syscall.tbl b/arch/xtensa/kernel/syscalls/syscall.tbl
index 6276e3c2d3fc..b0f0a0397de2 100644
--- a/arch/xtensa/kernel/syscalls/syscall.tbl
+++ b/arch/xtensa/kernel/syscalls/syscall.tbl
@@ -410,3 +410,6 @@
 437	common	openat2				sys_openat2
 438	common	pidfd_getfd			sys_pidfd_getfd
 439	common	faccessat2			sys_faccessat2
+442	common	landlock_create_ruleset				sys_landlock_create_ruleset
+443	common	landlock_add_rule					sys_landlock_add_rule
+444	common	landlock_enforce_ruleset_current	sys_landlock_enforce_ruleset_current
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index 995b36c2ea7d..1fa9412677af 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -859,9 +859,15 @@ __SYSCALL(__NR_openat2, sys_openat2)
 __SYSCALL(__NR_pidfd_getfd, sys_pidfd_getfd)
 #define __NR_faccessat2 439
 __SYSCALL(__NR_faccessat2, sys_faccessat2)
+#define __NR_landlock_create_ruleset 442
+__SYSCALL(__NR_landlock_create_ruleset, sys_landlock_create_ruleset)
+#define __NR_landlock_add_rule 443
+__SYSCALL(__NR_landlock_add_rule, sys_landlock_add_rule)
+#define __NR_landlock_enforce_ruleset_current 444
+__SYSCALL(__NR_landlock_enforce_ruleset_current, sys_landlock_enforce_ruleset_current)
 
 #undef __NR_syscalls
-#define __NR_syscalls 440
+#define __NR_syscalls 445
 
 /*
  * 32 bit systems traditionally used different
-- 
2.28.0

