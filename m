Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BAFD348184
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Mar 2021 20:16:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237962AbhCXTPU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Mar 2021 15:15:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237898AbhCXTPB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Mar 2021 15:15:01 -0400
Received: from smtp-1908.mail.infomaniak.ch (smtp-1908.mail.infomaniak.ch [IPv6:2001:1600:4:17::1908])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0B82C0613DE
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Mar 2021 12:15:00 -0700 (PDT)
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4F5HxH0S6czMpyqT;
        Wed, 24 Mar 2021 20:14:59 +0100 (CET)
Received: from localhost (unknown [23.97.221.149])
        by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4F5HxG4Mpxzlh8TF;
        Wed, 24 Mar 2021 20:14:58 +0100 (CET)
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
        linux-security-module@vger.kernel.org, x86@kernel.org,
        =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@linux.microsoft.com>
Subject: [PATCH v31 09/12] arch: Wire up Landlock syscalls
Date:   Wed, 24 Mar 2021 20:15:17 +0100
Message-Id: <20210324191520.125779-10-mic@digikod.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210324191520.125779-1-mic@digikod.net>
References: <20210324191520.125779-1-mic@digikod.net>
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
* landlock_restrict_self(2)

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: James Morris <jmorris@namei.org>
Cc: Jann Horn <jannh@google.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Serge E. Hallyn <serge@hallyn.com>
Signed-off-by: Mickaël Salaün <mic@linux.microsoft.com>
Link: https://lore.kernel.org/r/20210324191520.125779-10-mic@digikod.net
---

Changes since v30:
* Increase syscall numbers to leave space for quotactl_path(2):
  synchronize with Landlock syscalls in -next.

Changes since v29:
* Rebase on v5.12-rc3 and fix trivial conflict with mount_setattr(2).
* Synchronize syscall numbers with -next, which are the same as for
  v5.12-rc3.

Changes since v27:
* Rename landlock_enforce_ruleset_self(2) to landlock_restrict_self(2).
* Cosmetic fix: align TBL enries.

Changes since v26:
* Rename landlock_enforce_ruleset_current(2) to
  landlock_enforce_ruleset_self(2).

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
index 02f0244e005c..4240f21b10b3 100644
--- a/arch/alpha/kernel/syscalls/syscall.tbl
+++ b/arch/alpha/kernel/syscalls/syscall.tbl
@@ -482,3 +482,6 @@
 550	common	process_madvise			sys_process_madvise
 551	common	epoll_pwait2			sys_epoll_pwait2
 552	common	mount_setattr			sys_mount_setattr
+554	common	landlock_create_ruleset		sys_landlock_create_ruleset
+555	common	landlock_add_rule		sys_landlock_add_rule
+556	common	landlock_restrict_self		sys_landlock_restrict_self
diff --git a/arch/arm/tools/syscall.tbl b/arch/arm/tools/syscall.tbl
index dcc1191291a2..161423a5d773 100644
--- a/arch/arm/tools/syscall.tbl
+++ b/arch/arm/tools/syscall.tbl
@@ -456,3 +456,6 @@
 440	common	process_madvise			sys_process_madvise
 441	common	epoll_pwait2			sys_epoll_pwait2
 442	common	mount_setattr			sys_mount_setattr
+444	common	landlock_create_ruleset		sys_landlock_create_ruleset
+445	common	landlock_add_rule		sys_landlock_add_rule
+446	common	landlock_restrict_self		sys_landlock_restrict_self
diff --git a/arch/arm64/include/asm/unistd.h b/arch/arm64/include/asm/unistd.h
index 949788f5ba40..727bfc3be99b 100644
--- a/arch/arm64/include/asm/unistd.h
+++ b/arch/arm64/include/asm/unistd.h
@@ -38,7 +38,7 @@
 #define __ARM_NR_compat_set_tls		(__ARM_NR_COMPAT_BASE + 5)
 #define __ARM_NR_COMPAT_END		(__ARM_NR_COMPAT_BASE + 0x800)
 
-#define __NR_compat_syscalls		443
+#define __NR_compat_syscalls		447
 #endif
 
 #define __ARCH_WANT_SYS_CLONE
diff --git a/arch/arm64/include/asm/unistd32.h b/arch/arm64/include/asm/unistd32.h
index 3d874f624056..fdfe06bae3fc 100644
--- a/arch/arm64/include/asm/unistd32.h
+++ b/arch/arm64/include/asm/unistd32.h
@@ -893,6 +893,12 @@ __SYSCALL(__NR_process_madvise, sys_process_madvise)
 __SYSCALL(__NR_epoll_pwait2, compat_sys_epoll_pwait2)
 #define __NR_mount_setattr 442
 __SYSCALL(__NR_mount_setattr, sys_mount_setattr)
+#define __NR_landlock_create_ruleset 444
+__SYSCALL(__NR_landlock_create_ruleset, sys_landlock_create_ruleset)
+#define __NR_landlock_add_rule 445
+__SYSCALL(__NR_landlock_add_rule, sys_landlock_add_rule)
+#define __NR_landlock_restrict_self 446
+__SYSCALL(__NR_landlock_restrict_self, sys_landlock_restrict_self)
 
 /*
  * Please add new compat syscalls above this comment and update
diff --git a/arch/ia64/kernel/syscalls/syscall.tbl b/arch/ia64/kernel/syscalls/syscall.tbl
index d89231166e19..48dbbc95a01f 100644
--- a/arch/ia64/kernel/syscalls/syscall.tbl
+++ b/arch/ia64/kernel/syscalls/syscall.tbl
@@ -363,3 +363,6 @@
 440	common	process_madvise			sys_process_madvise
 441	common	epoll_pwait2			sys_epoll_pwait2
 442	common	mount_setattr			sys_mount_setattr
+444	common	landlock_create_ruleset		sys_landlock_create_ruleset
+445	common	landlock_add_rule		sys_landlock_add_rule
+446	common	landlock_restrict_self		sys_landlock_restrict_self
diff --git a/arch/m68k/kernel/syscalls/syscall.tbl b/arch/m68k/kernel/syscalls/syscall.tbl
index 72bde6707dd3..595108bbbe42 100644
--- a/arch/m68k/kernel/syscalls/syscall.tbl
+++ b/arch/m68k/kernel/syscalls/syscall.tbl
@@ -442,3 +442,6 @@
 440	common	process_madvise			sys_process_madvise
 441	common	epoll_pwait2			sys_epoll_pwait2
 442	common	mount_setattr			sys_mount_setattr
+444	common	landlock_create_ruleset		sys_landlock_create_ruleset
+445	common	landlock_add_rule		sys_landlock_add_rule
+446	common	landlock_restrict_self		sys_landlock_restrict_self
diff --git a/arch/microblaze/kernel/syscalls/syscall.tbl b/arch/microblaze/kernel/syscalls/syscall.tbl
index d603a5ec9338..db23d65871f9 100644
--- a/arch/microblaze/kernel/syscalls/syscall.tbl
+++ b/arch/microblaze/kernel/syscalls/syscall.tbl
@@ -448,3 +448,6 @@
 440	common	process_madvise			sys_process_madvise
 441	common	epoll_pwait2			sys_epoll_pwait2
 442	common	mount_setattr			sys_mount_setattr
+444	common	landlock_create_ruleset		sys_landlock_create_ruleset
+445	common	landlock_add_rule		sys_landlock_add_rule
+446	common	landlock_restrict_self		sys_landlock_restrict_self
diff --git a/arch/mips/kernel/syscalls/syscall_n32.tbl b/arch/mips/kernel/syscalls/syscall_n32.tbl
index 8fd8c1790941..5028839225fa 100644
--- a/arch/mips/kernel/syscalls/syscall_n32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n32.tbl
@@ -381,3 +381,6 @@
 440	n32	process_madvise			sys_process_madvise
 441	n32	epoll_pwait2			compat_sys_epoll_pwait2
 442	n32	mount_setattr			sys_mount_setattr
+444	n32	landlock_create_ruleset		sys_landlock_create_ruleset
+445	n32	landlock_add_rule		sys_landlock_add_rule
+446	n32	landlock_restrict_self		sys_landlock_restrict_self
diff --git a/arch/mips/kernel/syscalls/syscall_n64.tbl b/arch/mips/kernel/syscalls/syscall_n64.tbl
index 169f21438065..ec9c68b75e23 100644
--- a/arch/mips/kernel/syscalls/syscall_n64.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n64.tbl
@@ -357,3 +357,6 @@
 440	n64	process_madvise			sys_process_madvise
 441	n64	epoll_pwait2			sys_epoll_pwait2
 442	n64	mount_setattr			sys_mount_setattr
+444	n64	landlock_create_ruleset		sys_landlock_create_ruleset
+445	n64	landlock_add_rule		sys_landlock_add_rule
+446	n64	landlock_restrict_self		sys_landlock_restrict_self
diff --git a/arch/mips/kernel/syscalls/syscall_o32.tbl b/arch/mips/kernel/syscalls/syscall_o32.tbl
index 090d29ca80ff..24afd33e3e49 100644
--- a/arch/mips/kernel/syscalls/syscall_o32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_o32.tbl
@@ -430,3 +430,6 @@
 440	o32	process_madvise			sys_process_madvise
 441	o32	epoll_pwait2			sys_epoll_pwait2		compat_sys_epoll_pwait2
 442	o32	mount_setattr			sys_mount_setattr
+444	o32	landlock_create_ruleset		sys_landlock_create_ruleset
+445	o32	landlock_add_rule		sys_landlock_add_rule
+446	o32	landlock_restrict_self		sys_landlock_restrict_self
diff --git a/arch/parisc/kernel/syscalls/syscall.tbl b/arch/parisc/kernel/syscalls/syscall.tbl
index 271a92519683..8ddd0b82d767 100644
--- a/arch/parisc/kernel/syscalls/syscall.tbl
+++ b/arch/parisc/kernel/syscalls/syscall.tbl
@@ -440,3 +440,6 @@
 440	common	process_madvise			sys_process_madvise
 441	common	epoll_pwait2			sys_epoll_pwait2		compat_sys_epoll_pwait2
 442	common	mount_setattr			sys_mount_setattr
+444	common	landlock_create_ruleset		sys_landlock_create_ruleset
+445	common	landlock_add_rule		sys_landlock_add_rule
+446	common	landlock_restrict_self		sys_landlock_restrict_self
diff --git a/arch/powerpc/kernel/syscalls/syscall.tbl b/arch/powerpc/kernel/syscalls/syscall.tbl
index 0b2480cf3e47..02150894b1cf 100644
--- a/arch/powerpc/kernel/syscalls/syscall.tbl
+++ b/arch/powerpc/kernel/syscalls/syscall.tbl
@@ -522,3 +522,6 @@
 440	common	process_madvise			sys_process_madvise
 441	common	epoll_pwait2			sys_epoll_pwait2		compat_sys_epoll_pwait2
 442	common	mount_setattr			sys_mount_setattr
+444	common	landlock_create_ruleset		sys_landlock_create_ruleset
+445	common	landlock_add_rule		sys_landlock_add_rule
+446	common	landlock_restrict_self		sys_landlock_restrict_self
diff --git a/arch/s390/kernel/syscalls/syscall.tbl b/arch/s390/kernel/syscalls/syscall.tbl
index 3abef2144dac..331663efd3e7 100644
--- a/arch/s390/kernel/syscalls/syscall.tbl
+++ b/arch/s390/kernel/syscalls/syscall.tbl
@@ -445,3 +445,6 @@
 440  common	process_madvise		sys_process_madvise		sys_process_madvise
 441  common	epoll_pwait2		sys_epoll_pwait2		compat_sys_epoll_pwait2
 442  common	mount_setattr		sys_mount_setattr		sys_mount_setattr
+444  common	landlock_create_ruleset	sys_landlock_create_ruleset	sys_landlock_create_ruleset
+445  common	landlock_add_rule	sys_landlock_add_rule		sys_landlock_add_rule
+446  common	landlock_restrict_self	sys_landlock_restrict_self	sys_landlock_restrict_self
diff --git a/arch/sh/kernel/syscalls/syscall.tbl b/arch/sh/kernel/syscalls/syscall.tbl
index d08eebad6b7f..6ada711f4b72 100644
--- a/arch/sh/kernel/syscalls/syscall.tbl
+++ b/arch/sh/kernel/syscalls/syscall.tbl
@@ -445,3 +445,6 @@
 440	common	process_madvise			sys_process_madvise
 441	common	epoll_pwait2			sys_epoll_pwait2
 442	common	mount_setattr			sys_mount_setattr
+444	common	landlock_create_ruleset		sys_landlock_create_ruleset
+445	common	landlock_add_rule		sys_landlock_add_rule
+446	common	landlock_restrict_self		sys_landlock_restrict_self
diff --git a/arch/sparc/kernel/syscalls/syscall.tbl b/arch/sparc/kernel/syscalls/syscall.tbl
index 84403a99039c..1dbe3239a638 100644
--- a/arch/sparc/kernel/syscalls/syscall.tbl
+++ b/arch/sparc/kernel/syscalls/syscall.tbl
@@ -488,3 +488,6 @@
 440	common	process_madvise			sys_process_madvise
 441	common	epoll_pwait2			sys_epoll_pwait2		compat_sys_epoll_pwait2
 442	common	mount_setattr			sys_mount_setattr
+444	common	landlock_create_ruleset		sys_landlock_create_ruleset
+445	common	landlock_add_rule		sys_landlock_add_rule
+446	common	landlock_restrict_self		sys_landlock_restrict_self
diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index a1c9f496fca6..782c310de1da 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -447,3 +447,6 @@
 440	i386	process_madvise		sys_process_madvise
 441	i386	epoll_pwait2		sys_epoll_pwait2		compat_sys_epoll_pwait2
 442	i386	mount_setattr		sys_mount_setattr
+444	i386	landlock_create_ruleset	sys_landlock_create_ruleset
+445	i386	landlock_add_rule	sys_landlock_add_rule
+446	i386	landlock_restrict_self	sys_landlock_restrict_self
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index 7bf01cbe582f..8604ee4bfff9 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -364,6 +364,9 @@
 440	common	process_madvise		sys_process_madvise
 441	common	epoll_pwait2		sys_epoll_pwait2
 442	common	mount_setattr		sys_mount_setattr
+444	common	landlock_create_ruleset	sys_landlock_create_ruleset
+445	common	landlock_add_rule	sys_landlock_add_rule
+446	common	landlock_restrict_self	sys_landlock_restrict_self
 
 #
 # Due to a historical design error, certain syscalls are numbered differently
diff --git a/arch/xtensa/kernel/syscalls/syscall.tbl b/arch/xtensa/kernel/syscalls/syscall.tbl
index 365a9b849224..2fad056a32e8 100644
--- a/arch/xtensa/kernel/syscalls/syscall.tbl
+++ b/arch/xtensa/kernel/syscalls/syscall.tbl
@@ -413,3 +413,6 @@
 440	common	process_madvise			sys_process_madvise
 441	common	epoll_pwait2			sys_epoll_pwait2
 442	common	mount_setattr			sys_mount_setattr
+444	common	landlock_create_ruleset		sys_landlock_create_ruleset
+445	common	landlock_add_rule		sys_landlock_add_rule
+446	common	landlock_restrict_self		sys_landlock_restrict_self
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index ce58cff99b66..300608b05226 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -863,9 +863,15 @@ __SYSCALL(__NR_process_madvise, sys_process_madvise)
 __SC_COMP(__NR_epoll_pwait2, sys_epoll_pwait2, compat_sys_epoll_pwait2)
 #define __NR_mount_setattr 442
 __SYSCALL(__NR_mount_setattr, sys_mount_setattr)
+#define __NR_landlock_create_ruleset 444
+__SYSCALL(__NR_landlock_create_ruleset, sys_landlock_create_ruleset)
+#define __NR_landlock_add_rule 445
+__SYSCALL(__NR_landlock_add_rule, sys_landlock_add_rule)
+#define __NR_landlock_restrict_self 446
+__SYSCALL(__NR_landlock_restrict_self, sys_landlock_restrict_self)
 
 #undef __NR_syscalls
-#define __NR_syscalls 443
+#define __NR_syscalls 447
 
 /*
  * 32 bit systems traditionally used different
-- 
2.30.2

