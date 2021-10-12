Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F0B942AD35
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Oct 2021 21:23:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234143AbhJLTZa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Oct 2021 15:25:30 -0400
Received: from smtp-8faa.mail.infomaniak.ch ([83.166.143.170]:55523 "EHLO
        smtp-8faa.mail.infomaniak.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233467AbhJLTZ3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Oct 2021 15:25:29 -0400
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4HTQYn2L7nzMq62y;
        Tue, 12 Oct 2021 21:23:25 +0200 (CEST)
Received: from localhost (unknown [23.97.221.149])
        by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4HTQYm6Gw9zlhP4f;
        Tue, 12 Oct 2021 21:23:24 +0200 (CEST)
From:   =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christian Heimes <christian@python.org>,
        Deven Bowers <deven.desai@linux.microsoft.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Eric Chiang <ericchiang@google.com>,
        Florian Weimer <fweimer@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        James Morris <jmorris@namei.org>, Jan Kara <jack@suse.cz>,
        Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        "Madhavan T . Venkataraman" <madvenka@linux.microsoft.com>,
        Matthew Garrett <mjg59@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Paul Moore <paul@paul-moore.com>,
        =?UTF-8?q?Philippe=20Tr=C3=A9buchet?= 
        <philippe.trebuchet@ssi.gouv.fr>,
        Scott Shell <scottsh@microsoft.com>,
        Shuah Khan <shuah@kernel.org>,
        Steve Dower <steve.dower@python.org>,
        Steve Grubb <sgrubb@redhat.com>,
        Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>,
        Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@linux.microsoft.com>
Subject: [PATCH v15 2/3] arch: Wire up trusted_for(2)
Date:   Tue, 12 Oct 2021 21:24:09 +0200
Message-Id: <20211012192410.2356090-3-mic@digikod.net>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211012192410.2356090-1-mic@digikod.net>
References: <20211012192410.2356090-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Mickaël Salaün <mic@linux.microsoft.com>

Wire up trusted_for(2) for all architectures.

Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Kees Cook <keescook@chromium.org>
Signed-off-by: Mickaël Salaün <mic@linux.microsoft.com>
Reviewed-by: Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/r/20211012192410.2356090-3-mic@digikod.net
---

Changes since v13:
* Add Reviewed-by Kees Cook.

Changes since v12:
* Update syscall IDs to align with the new ones.

Changes since v11:
* Add Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
* Rebase and leave space for watch_mount(2) and epoll_pwait2(2) from
  -next.

Changes since v9:
* Rename introspect_access(2) to trusted_for(2).
* Increase syscall number to leave space for memfd_secret(2) in -next.

Changes since v7:
* New patch for the new syscall.
* Increase syscall numbers by 2 to leave space for new ones (in
  linux-next): watch_mount(2) and process_madvise(2).
---
 arch/alpha/kernel/syscalls/syscall.tbl      | 1 +
 arch/arm/tools/syscall.tbl                  | 1 +
 arch/arm64/include/asm/unistd.h             | 2 +-
 arch/arm64/include/asm/unistd32.h           | 2 ++
 arch/ia64/kernel/syscalls/syscall.tbl       | 1 +
 arch/m68k/kernel/syscalls/syscall.tbl       | 1 +
 arch/microblaze/kernel/syscalls/syscall.tbl | 1 +
 arch/mips/kernel/syscalls/syscall_n32.tbl   | 1 +
 arch/mips/kernel/syscalls/syscall_n64.tbl   | 1 +
 arch/mips/kernel/syscalls/syscall_o32.tbl   | 1 +
 arch/parisc/kernel/syscalls/syscall.tbl     | 1 +
 arch/powerpc/kernel/syscalls/syscall.tbl    | 1 +
 arch/s390/kernel/syscalls/syscall.tbl       | 1 +
 arch/sh/kernel/syscalls/syscall.tbl         | 1 +
 arch/sparc/kernel/syscalls/syscall.tbl      | 1 +
 arch/x86/entry/syscalls/syscall_32.tbl      | 1 +
 arch/x86/entry/syscalls/syscall_64.tbl      | 1 +
 arch/xtensa/kernel/syscalls/syscall.tbl     | 1 +
 include/uapi/asm-generic/unistd.h           | 4 +++-
 19 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/arch/alpha/kernel/syscalls/syscall.tbl b/arch/alpha/kernel/syscalls/syscall.tbl
index e4a041cd5715..ee33f1631f6d 100644
--- a/arch/alpha/kernel/syscalls/syscall.tbl
+++ b/arch/alpha/kernel/syscalls/syscall.tbl
@@ -488,3 +488,4 @@
 556	common	landlock_restrict_self		sys_landlock_restrict_self
 # 557 reserved for memfd_secret
 558	common	process_mrelease		sys_process_mrelease
+559	common	trusted_for			sys_trusted_for
diff --git a/arch/arm/tools/syscall.tbl b/arch/arm/tools/syscall.tbl
index e842209e135d..93edcdeda698 100644
--- a/arch/arm/tools/syscall.tbl
+++ b/arch/arm/tools/syscall.tbl
@@ -462,3 +462,4 @@
 446	common	landlock_restrict_self		sys_landlock_restrict_self
 # 447 reserved for memfd_secret
 448	common	process_mrelease		sys_process_mrelease
+449	common	trusted_for			sys_trusted_for
diff --git a/arch/arm64/include/asm/unistd.h b/arch/arm64/include/asm/unistd.h
index 3cb206aea3db..6bdb5f5db438 100644
--- a/arch/arm64/include/asm/unistd.h
+++ b/arch/arm64/include/asm/unistd.h
@@ -38,7 +38,7 @@
 #define __ARM_NR_compat_set_tls		(__ARM_NR_COMPAT_BASE + 5)
 #define __ARM_NR_COMPAT_END		(__ARM_NR_COMPAT_BASE + 0x800)
 
-#define __NR_compat_syscalls		449
+#define __NR_compat_syscalls		450
 #endif
 
 #define __ARCH_WANT_SYS_CLONE
diff --git a/arch/arm64/include/asm/unistd32.h b/arch/arm64/include/asm/unistd32.h
index 844f6ae58662..3cb7df3a441c 100644
--- a/arch/arm64/include/asm/unistd32.h
+++ b/arch/arm64/include/asm/unistd32.h
@@ -903,6 +903,8 @@ __SYSCALL(__NR_landlock_add_rule, sys_landlock_add_rule)
 __SYSCALL(__NR_landlock_restrict_self, sys_landlock_restrict_self)
 #define __NR_process_mrelease 448
 __SYSCALL(__NR_process_mrelease, sys_process_mrelease)
+#define __NR_trusted_for 449
+__SYSCALL(__NR_trusted_for, sys_trusted_for)
 
 /*
  * Please add new compat syscalls above this comment and update
diff --git a/arch/ia64/kernel/syscalls/syscall.tbl b/arch/ia64/kernel/syscalls/syscall.tbl
index 6fea1844fb95..50970d778005 100644
--- a/arch/ia64/kernel/syscalls/syscall.tbl
+++ b/arch/ia64/kernel/syscalls/syscall.tbl
@@ -369,3 +369,4 @@
 446	common	landlock_restrict_self		sys_landlock_restrict_self
 # 447 reserved for memfd_secret
 448	common	process_mrelease		sys_process_mrelease
+449	common	trusted_for			sys_trusted_for
diff --git a/arch/m68k/kernel/syscalls/syscall.tbl b/arch/m68k/kernel/syscalls/syscall.tbl
index 7976dff8f879..caee4759d9f4 100644
--- a/arch/m68k/kernel/syscalls/syscall.tbl
+++ b/arch/m68k/kernel/syscalls/syscall.tbl
@@ -448,3 +448,4 @@
 446	common	landlock_restrict_self		sys_landlock_restrict_self
 # 447 reserved for memfd_secret
 448	common	process_mrelease		sys_process_mrelease
+449	common	trusted_for			sys_trusted_for
diff --git a/arch/microblaze/kernel/syscalls/syscall.tbl b/arch/microblaze/kernel/syscalls/syscall.tbl
index 6b0e11362bd2..25761d27aa9e 100644
--- a/arch/microblaze/kernel/syscalls/syscall.tbl
+++ b/arch/microblaze/kernel/syscalls/syscall.tbl
@@ -454,3 +454,4 @@
 446	common	landlock_restrict_self		sys_landlock_restrict_self
 # 447 reserved for memfd_secret
 448	common	process_mrelease		sys_process_mrelease
+449	common	trusted_for			sys_trusted_for
diff --git a/arch/mips/kernel/syscalls/syscall_n32.tbl b/arch/mips/kernel/syscalls/syscall_n32.tbl
index 70e32de2bcaa..5e61c18fa3df 100644
--- a/arch/mips/kernel/syscalls/syscall_n32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n32.tbl
@@ -387,3 +387,4 @@
 446	n32	landlock_restrict_self		sys_landlock_restrict_self
 # 447 reserved for memfd_secret
 448	n32	process_mrelease		sys_process_mrelease
+449	n32	trusted_for			sys_trusted_for
diff --git a/arch/mips/kernel/syscalls/syscall_n64.tbl b/arch/mips/kernel/syscalls/syscall_n64.tbl
index 1ca7bc337932..9a4928032039 100644
--- a/arch/mips/kernel/syscalls/syscall_n64.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n64.tbl
@@ -363,3 +363,4 @@
 446	n64	landlock_restrict_self		sys_landlock_restrict_self
 # 447 reserved for memfd_secret
 448	n64	process_mrelease		sys_process_mrelease
+449	n64	trusted_for			sys_trusted_for
diff --git a/arch/mips/kernel/syscalls/syscall_o32.tbl b/arch/mips/kernel/syscalls/syscall_o32.tbl
index a61c35edaa74..7fd966e720c2 100644
--- a/arch/mips/kernel/syscalls/syscall_o32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_o32.tbl
@@ -436,3 +436,4 @@
 446	o32	landlock_restrict_self		sys_landlock_restrict_self
 # 447 reserved for memfd_secret
 448	o32	process_mrelease		sys_process_mrelease
+449	o32	trusted_for			sys_trusted_for
diff --git a/arch/parisc/kernel/syscalls/syscall.tbl b/arch/parisc/kernel/syscalls/syscall.tbl
index bf751e0732b7..b43fe303922c 100644
--- a/arch/parisc/kernel/syscalls/syscall.tbl
+++ b/arch/parisc/kernel/syscalls/syscall.tbl
@@ -446,3 +446,4 @@
 446	common	landlock_restrict_self		sys_landlock_restrict_self
 # 447 reserved for memfd_secret
 448	common	process_mrelease		sys_process_mrelease
+449	common	trusted_for			sys_trusted_for
diff --git a/arch/powerpc/kernel/syscalls/syscall.tbl b/arch/powerpc/kernel/syscalls/syscall.tbl
index 7bef917cc84e..0de4795a4f85 100644
--- a/arch/powerpc/kernel/syscalls/syscall.tbl
+++ b/arch/powerpc/kernel/syscalls/syscall.tbl
@@ -528,3 +528,4 @@
 446	common	landlock_restrict_self		sys_landlock_restrict_self
 # 447 reserved for memfd_secret
 448	common	process_mrelease		sys_process_mrelease
+449	common	trusted_for			sys_trusted_for
diff --git a/arch/s390/kernel/syscalls/syscall.tbl b/arch/s390/kernel/syscalls/syscall.tbl
index df5261e5cfe1..b524343bb67d 100644
--- a/arch/s390/kernel/syscalls/syscall.tbl
+++ b/arch/s390/kernel/syscalls/syscall.tbl
@@ -451,3 +451,4 @@
 446  common	landlock_restrict_self	sys_landlock_restrict_self	sys_landlock_restrict_self
 # 447 reserved for memfd_secret
 448  common	process_mrelease	sys_process_mrelease		sys_process_mrelease
+449  common	trusted_for		sys_trusted_for			sys_trusted_for
diff --git a/arch/sh/kernel/syscalls/syscall.tbl b/arch/sh/kernel/syscalls/syscall.tbl
index 208f131659c5..d4c925d83129 100644
--- a/arch/sh/kernel/syscalls/syscall.tbl
+++ b/arch/sh/kernel/syscalls/syscall.tbl
@@ -451,3 +451,4 @@
 446	common	landlock_restrict_self		sys_landlock_restrict_self
 # 447 reserved for memfd_secret
 448	common	process_mrelease		sys_process_mrelease
+449	common	trusted_for			sys_trusted_for
diff --git a/arch/sparc/kernel/syscalls/syscall.tbl b/arch/sparc/kernel/syscalls/syscall.tbl
index c37764dc764d..158bf1b028ac 100644
--- a/arch/sparc/kernel/syscalls/syscall.tbl
+++ b/arch/sparc/kernel/syscalls/syscall.tbl
@@ -494,3 +494,4 @@
 446	common	landlock_restrict_self		sys_landlock_restrict_self
 # 447 reserved for memfd_secret
 448	common	process_mrelease		sys_process_mrelease
+449	common	trusted_for			sys_trusted_for
diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index 960a021d543e..a9eda13c86cd 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -453,3 +453,4 @@
 446	i386	landlock_restrict_self	sys_landlock_restrict_self
 447	i386	memfd_secret		sys_memfd_secret
 448	i386	process_mrelease	sys_process_mrelease
+449	i386	trusted_for		sys_trusted_for
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index 18b5500ea8bf..c352f1b200ee 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -370,6 +370,7 @@
 446	common	landlock_restrict_self	sys_landlock_restrict_self
 447	common	memfd_secret		sys_memfd_secret
 448	common	process_mrelease	sys_process_mrelease
+449	common	trusted_for		sys_trusted_for
 
 #
 # Due to a historical design error, certain syscalls are numbered differently
diff --git a/arch/xtensa/kernel/syscalls/syscall.tbl b/arch/xtensa/kernel/syscalls/syscall.tbl
index 104b327f8ac9..f26a1313a055 100644
--- a/arch/xtensa/kernel/syscalls/syscall.tbl
+++ b/arch/xtensa/kernel/syscalls/syscall.tbl
@@ -419,3 +419,4 @@
 446	common	landlock_restrict_self		sys_landlock_restrict_self
 # 447 reserved for memfd_secret
 448	common	process_mrelease		sys_process_mrelease
+449	common	trusted_for			sys_trusted_for
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index 1c5fb86d455a..67b4bebe7c87 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -879,9 +879,11 @@ __SYSCALL(__NR_memfd_secret, sys_memfd_secret)
 #endif
 #define __NR_process_mrelease 448
 __SYSCALL(__NR_process_mrelease, sys_process_mrelease)
+#define __NR_trusted_for 449
+__SYSCALL(__NR_trusted_for, sys_trusted_for)
 
 #undef __NR_syscalls
-#define __NR_syscalls 449
+#define __NR_syscalls 450
 
 /*
  * 32 bit systems traditionally used different
-- 
2.32.0

