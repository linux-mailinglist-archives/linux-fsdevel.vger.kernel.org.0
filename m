Return-Path: <linux-fsdevel+bounces-10105-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F4B9847B3F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 22:06:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05845285A60
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 21:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBB1A136986;
	Fri,  2 Feb 2024 21:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="oLJLGT98"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC70681742;
	Fri,  2 Feb 2024 21:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706907635; cv=none; b=H8uW3Be0DzwQsfCs8mFoZlce59NXYvuL/+5i1/xxTYtfUSpccMzZsZpJWU7MsU7c1pqoEd1pUPKWf7vcJUHkK4+HiOiiCkAWXrey3KLFtoEg2dusQtJ8gz4l6YJovbVA2hMLmt8VUCirSBeOiaOAD+NBjK0KZQNR1OblmweI2bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706907635; c=relaxed/simple;
	bh=yhcYPD4d/Sk8n4rn3QR3NdUtoL+Ae4/2ZbOPQLO15Yg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iLzT+WQx08SQD7XYkeCeRibEEb2xGFRakJr86OHcSSFLaexR0RXKCJeVpeWzrhJgvAJxYX+naMWu1SYz5KfXGsBKkIqOAtqj7AQblwXgC0cmWu7CHqi2wmfHcx3eSDK10Lz01iwlWiATNolHAm9nhfg68wv++D+MClbKUdzSplQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=oLJLGT98; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1706907629;
	bh=yhcYPD4d/Sk8n4rn3QR3NdUtoL+Ae4/2ZbOPQLO15Yg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oLJLGT98D+lefR1KLWOWJYjFCixUI/BR29qaR8DetoIJoFAnfcPx6gT7zQ4YYlbvK
	 iepjTNUeSero6tm16G4R5obJYNlSwMK3/ZshDWqHB6q3Xdl6V9agtOCw5/pBb2jM7k
	 umEQ8qeEOdabTQrZwl7e8BIlnIZxYVFEddP4Y50xzbQqO5BuCFptfcdRlcQjpjmYtn
	 EwDOoJUGo3us5812NTgAfQig7Gksfuu4+IYhudmuVBF79NdwsS9ADA1IR+lkav85pl
	 2lMLw0DWryRxFDzT6q9i6a1rd1RosB4Y7cQYlNfW1ivkq0TG/GdZTlCGmRM4Il1b4W
	 0n9EWcK6xTxWQ==
Received: from thinkos.internal.efficios.com (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4TRSpj4YHqzX4V;
	Fri,  2 Feb 2024 16:00:29 -0500 (EST)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Dan Williams <dan.j.williams@intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Dave Chinner <david@fromorbit.com>
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Matthew Wilcox <willy@infradead.org>,
	Russell King <linux@armlinux.org.uk>,
	linux-arch@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-xfs@vger.kernel.org,
	dm-devel@lists.linux.dev,
	nvdimm@lists.linux.dev,
	linux-s390@vger.kernel.org
Subject: [RFC PATCH v4 07/12] Introduce cpu_dcache_is_aliasing() across all architectures
Date: Fri,  2 Feb 2024 16:00:14 -0500
Message-Id: <20240202210019.88022-8-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240202210019.88022-1-mathieu.desnoyers@efficios.com>
References: <20240202210019.88022-1-mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a generic way to query whether the data cache is virtually
aliased on all architectures. Its purpose is to ensure that subsystems
which are incompatible with virtually aliased data caches (e.g. FS_DAX)
can reliably query this.

For data cache aliasing, there are three scenarios dependending on the
architecture. Here is a breakdown based on my understanding:

A) The data cache is always aliasing:

* arc
* csky
* m68k (note: shared memory mappings are incoherent ? SHMLBA is missing there.)
* sh
* parisc

B) The data cache aliasing is statically known or depends on querying CPU
   state at runtime:

* arm (cache_is_vivt() || cache_is_vipt_aliasing())
* mips (cpu_has_dc_aliases)
* nios2 (NIOS2_DCACHE_SIZE > PAGE_SIZE)
* sparc32 (vac_cache_size > PAGE_SIZE)
* sparc64 (L1DCACHE_SIZE > PAGE_SIZE)
* xtensa (DCACHE_WAY_SIZE > PAGE_SIZE)

C) The data cache is never aliasing:

* alpha
* arm64 (aarch64)
* hexagon
* loongarch (but with incoherent write buffers, which are disabled since
             commit d23b7795 ("LoongArch: Change SHMLBA from SZ_64K to PAGE_SIZE"))
* microblaze
* openrisc
* powerpc
* riscv
* s390
* um
* x86

Require architectures in A) and B) to select ARCH_HAS_CPU_CACHE_ALIASING and
implement "cpu_dcache_is_aliasing()".

Architectures in C) don't select ARCH_HAS_CPU_CACHE_ALIASING, and thus
cpu_dcache_is_aliasing() simply evaluates to "false".

Note that this leaves "cpu_icache_is_aliasing()" to be implemented as future
work. This would be useful to gate features like XIP on architectures
which have aliasing CPU dcache-icache but not CPU dcache-dcache.

Use "cpu_dcache" and "cpu_cache" rather than just "dcache" and "cache"
to clarify that we really mean "CPU data cache" and "CPU cache" to
eliminate any possible confusion with VFS "dentry cache" and "page
cache".

Link: https://lore.kernel.org/lkml/20030910210416.GA24258@mail.jlokier.co.uk/
Fixes: d92576f1167c ("dax: does not work correctly with virtual aliasing caches")
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Russell King <linux@armlinux.org.uk>
Cc: linux-arch@vger.kernel.org
Cc: linux-cxl@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: linux-xfs@vger.kernel.org
Cc: dm-devel@lists.linux.dev
Cc: nvdimm@lists.linux.dev
---
 arch/arc/Kconfig                    |  1 +
 arch/arc/include/asm/cachetype.h    |  9 +++++++++
 arch/arm/Kconfig                    |  1 +
 arch/arm/include/asm/cachetype.h    |  2 ++
 arch/csky/Kconfig                   |  1 +
 arch/csky/include/asm/cachetype.h   |  9 +++++++++
 arch/m68k/Kconfig                   |  1 +
 arch/m68k/include/asm/cachetype.h   |  9 +++++++++
 arch/mips/Kconfig                   |  1 +
 arch/mips/include/asm/cachetype.h   |  9 +++++++++
 arch/nios2/Kconfig                  |  1 +
 arch/nios2/include/asm/cachetype.h  | 10 ++++++++++
 arch/parisc/Kconfig                 |  1 +
 arch/parisc/include/asm/cachetype.h |  9 +++++++++
 arch/sh/Kconfig                     |  1 +
 arch/sh/include/asm/cachetype.h     |  9 +++++++++
 arch/sparc/Kconfig                  |  1 +
 arch/sparc/include/asm/cachetype.h  | 14 ++++++++++++++
 arch/xtensa/Kconfig                 |  1 +
 arch/xtensa/include/asm/cachetype.h | 10 ++++++++++
 include/linux/cacheinfo.h           |  6 ++++++
 mm/Kconfig                          |  6 ++++++
 22 files changed, 112 insertions(+)
 create mode 100644 arch/arc/include/asm/cachetype.h
 create mode 100644 arch/csky/include/asm/cachetype.h
 create mode 100644 arch/m68k/include/asm/cachetype.h
 create mode 100644 arch/mips/include/asm/cachetype.h
 create mode 100644 arch/nios2/include/asm/cachetype.h
 create mode 100644 arch/parisc/include/asm/cachetype.h
 create mode 100644 arch/sh/include/asm/cachetype.h
 create mode 100644 arch/sparc/include/asm/cachetype.h
 create mode 100644 arch/xtensa/include/asm/cachetype.h

diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
index 1b0483c51cc1..7d294a3242a4 100644
--- a/arch/arc/Kconfig
+++ b/arch/arc/Kconfig
@@ -6,6 +6,7 @@
 config ARC
 	def_bool y
 	select ARC_TIMERS
+	select ARCH_HAS_CPU_CACHE_ALIASING
 	select ARCH_HAS_CACHE_LINE_SIZE
 	select ARCH_HAS_DEBUG_VM_PGTABLE
 	select ARCH_HAS_DMA_PREP_COHERENT
diff --git a/arch/arc/include/asm/cachetype.h b/arch/arc/include/asm/cachetype.h
new file mode 100644
index 000000000000..05fc7ed59712
--- /dev/null
+++ b/arch/arc/include/asm/cachetype.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_ARC_CACHETYPE_H
+#define __ASM_ARC_CACHETYPE_H
+
+#include <linux/types.h>
+
+#define cpu_dcache_is_aliasing()	true
+
+#endif
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index f8567e95f98b..cd13b1788973 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -5,6 +5,7 @@ config ARM
 	select ARCH_32BIT_OFF_T
 	select ARCH_CORRECT_STACKTRACE_ON_KRETPROBE if HAVE_KRETPROBES && FRAME_POINTER && !ARM_UNWIND
 	select ARCH_HAS_BINFMT_FLAT
+	select ARCH_HAS_CPU_CACHE_ALIASING
 	select ARCH_HAS_CPU_FINALIZE_INIT if MMU
 	select ARCH_HAS_CURRENT_STACK_POINTER
 	select ARCH_HAS_DEBUG_VIRTUAL if MMU
diff --git a/arch/arm/include/asm/cachetype.h b/arch/arm/include/asm/cachetype.h
index e8c30430be33..b9dbe1d4c8fe 100644
--- a/arch/arm/include/asm/cachetype.h
+++ b/arch/arm/include/asm/cachetype.h
@@ -20,6 +20,8 @@ extern unsigned int cacheid;
 #define icache_is_vipt_aliasing()	cacheid_is(CACHEID_VIPT_I_ALIASING)
 #define icache_is_pipt()		cacheid_is(CACHEID_PIPT)
 
+#define cpu_dcache_is_aliasing()	(cache_is_vivt() || cache_is_vipt_aliasing())
+
 /*
  * __LINUX_ARM_ARCH__ is the minimum supported CPU architecture
  * Mask out support which will never be present on newer CPUs.
diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
index cf2a6fd7dff8..8a91eccf76dc 100644
--- a/arch/csky/Kconfig
+++ b/arch/csky/Kconfig
@@ -2,6 +2,7 @@
 config CSKY
 	def_bool y
 	select ARCH_32BIT_OFF_T
+	select ARCH_HAS_CPU_CACHE_ALIASING
 	select ARCH_HAS_DMA_PREP_COHERENT
 	select ARCH_HAS_GCOV_PROFILE_ALL
 	select ARCH_HAS_SYNC_DMA_FOR_CPU
diff --git a/arch/csky/include/asm/cachetype.h b/arch/csky/include/asm/cachetype.h
new file mode 100644
index 000000000000..98cbe3af662f
--- /dev/null
+++ b/arch/csky/include/asm/cachetype.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_CSKY_CACHETYPE_H
+#define __ASM_CSKY_CACHETYPE_H
+
+#include <linux/types.h>
+
+#define cpu_dcache_is_aliasing()	true
+
+#endif
diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
index 4b3e93cac723..a9c3e3de0c6d 100644
--- a/arch/m68k/Kconfig
+++ b/arch/m68k/Kconfig
@@ -3,6 +3,7 @@ config M68K
 	bool
 	default y
 	select ARCH_32BIT_OFF_T
+	select ARCH_HAS_CPU_CACHE_ALIASING
 	select ARCH_HAS_BINFMT_FLAT
 	select ARCH_HAS_CPU_FINALIZE_INIT if MMU
 	select ARCH_HAS_CURRENT_STACK_POINTER
diff --git a/arch/m68k/include/asm/cachetype.h b/arch/m68k/include/asm/cachetype.h
new file mode 100644
index 000000000000..7fad5d9ab8fe
--- /dev/null
+++ b/arch/m68k/include/asm/cachetype.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_M68K_CACHETYPE_H
+#define __ASM_M68K_CACHETYPE_H
+
+#include <linux/types.h>
+
+#define cpu_dcache_is_aliasing()	true
+
+#endif
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 797ae590ebdb..ab1c8bd96666 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -4,6 +4,7 @@ config MIPS
 	default y
 	select ARCH_32BIT_OFF_T if !64BIT
 	select ARCH_BINFMT_ELF_STATE if MIPS_FP_SUPPORT
+	select ARCH_HAS_CPU_CACHE_ALIASING
 	select ARCH_HAS_CPU_FINALIZE_INIT
 	select ARCH_HAS_CURRENT_STACK_POINTER if !CC_IS_CLANG || CLANG_VERSION >= 140000
 	select ARCH_HAS_DEBUG_VIRTUAL if !64BIT
diff --git a/arch/mips/include/asm/cachetype.h b/arch/mips/include/asm/cachetype.h
new file mode 100644
index 000000000000..9f4ba2fe1155
--- /dev/null
+++ b/arch/mips/include/asm/cachetype.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_MIPS_CACHETYPE_H
+#define __ASM_MIPS_CACHETYPE_H
+
+#include <asm/cpu-features.h>
+
+#define cpu_dcache_is_aliasing()	cpu_has_dc_aliases
+
+#endif
diff --git a/arch/nios2/Kconfig b/arch/nios2/Kconfig
index d54464021a61..760fb541ecd2 100644
--- a/arch/nios2/Kconfig
+++ b/arch/nios2/Kconfig
@@ -2,6 +2,7 @@
 config NIOS2
 	def_bool y
 	select ARCH_32BIT_OFF_T
+	select ARCH_HAS_CPU_CACHE_ALIASING
 	select ARCH_HAS_DMA_PREP_COHERENT
 	select ARCH_HAS_SYNC_DMA_FOR_CPU
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
diff --git a/arch/nios2/include/asm/cachetype.h b/arch/nios2/include/asm/cachetype.h
new file mode 100644
index 000000000000..eb9c416b8a1c
--- /dev/null
+++ b/arch/nios2/include/asm/cachetype.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_NIOS2_CACHETYPE_H
+#define __ASM_NIOS2_CACHETYPE_H
+
+#include <asm/page.h>
+#include <asm/cache.h>
+
+#define cpu_dcache_is_aliasing()	(NIOS2_DCACHE_SIZE > PAGE_SIZE)
+
+#endif
diff --git a/arch/parisc/Kconfig b/arch/parisc/Kconfig
index d14ccc948a29..0f25c227f74b 100644
--- a/arch/parisc/Kconfig
+++ b/arch/parisc/Kconfig
@@ -8,6 +8,7 @@ config PARISC
 	select HAVE_FUNCTION_GRAPH_TRACER
 	select HAVE_SYSCALL_TRACEPOINTS
 	select ARCH_WANT_FRAME_POINTERS
+	select ARCH_HAS_CPU_CACHE_ALIASING
 	select ARCH_HAS_DMA_ALLOC if PA11
 	select ARCH_HAS_ELF_RANDOMIZE
 	select ARCH_HAS_STRICT_KERNEL_RWX
diff --git a/arch/parisc/include/asm/cachetype.h b/arch/parisc/include/asm/cachetype.h
new file mode 100644
index 000000000000..e0868a1d3c47
--- /dev/null
+++ b/arch/parisc/include/asm/cachetype.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_PARISC_CACHETYPE_H
+#define __ASM_PARISC_CACHETYPE_H
+
+#include <linux/types.h>
+
+#define cpu_dcache_is_aliasing()	true
+
+#endif
diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index 7500521b2b98..2ad3e29f0ebe 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -2,6 +2,7 @@
 config SUPERH
 	def_bool y
 	select ARCH_32BIT_OFF_T
+	select ARCH_HAS_CPU_CACHE_ALIASING
 	select ARCH_ENABLE_MEMORY_HOTPLUG if SPARSEMEM && MMU
 	select ARCH_ENABLE_MEMORY_HOTREMOVE if SPARSEMEM && MMU
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG if (GUSA_RB || CPU_SH4A)
diff --git a/arch/sh/include/asm/cachetype.h b/arch/sh/include/asm/cachetype.h
new file mode 100644
index 000000000000..a5fffe536068
--- /dev/null
+++ b/arch/sh/include/asm/cachetype.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_SH_CACHETYPE_H
+#define __ASM_SH_CACHETYPE_H
+
+#include <linux/types.h>
+
+#define cpu_dcache_is_aliasing()	true
+
+#endif
diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 49849790e66d..5ba627da15d7 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -13,6 +13,7 @@ config 64BIT
 config SPARC
 	bool
 	default y
+	select ARCH_HAS_CPU_CACHE_ALIASING
 	select ARCH_MIGHT_HAVE_PC_PARPORT if SPARC64 && PCI
 	select ARCH_MIGHT_HAVE_PC_SERIO
 	select DMA_OPS
diff --git a/arch/sparc/include/asm/cachetype.h b/arch/sparc/include/asm/cachetype.h
new file mode 100644
index 000000000000..caf1c0045892
--- /dev/null
+++ b/arch/sparc/include/asm/cachetype.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_SPARC_CACHETYPE_H
+#define __ASM_SPARC_CACHETYPE_H
+
+#include <asm/page.h>
+
+#ifdef CONFIG_SPARC32
+extern int vac_cache_size;
+#define cpu_dcache_is_aliasing()	(vac_cache_size > PAGE_SIZE)
+#else
+#define cpu_dcache_is_aliasing()	(L1DCACHE_SIZE > PAGE_SIZE)
+#endif
+
+#endif
diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
index 7d792077e5fd..2dfde54d1a84 100644
--- a/arch/xtensa/Kconfig
+++ b/arch/xtensa/Kconfig
@@ -2,6 +2,7 @@
 config XTENSA
 	def_bool y
 	select ARCH_32BIT_OFF_T
+	select ARCH_HAS_CPU_CACHE_ALIASING
 	select ARCH_HAS_BINFMT_FLAT if !MMU
 	select ARCH_HAS_CURRENT_STACK_POINTER
 	select ARCH_HAS_DEBUG_VM_PGTABLE
diff --git a/arch/xtensa/include/asm/cachetype.h b/arch/xtensa/include/asm/cachetype.h
new file mode 100644
index 000000000000..51bd49e2a1c5
--- /dev/null
+++ b/arch/xtensa/include/asm/cachetype.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_XTENSA_CACHETYPE_H
+#define __ASM_XTENSA_CACHETYPE_H
+
+#include <asm/cache.h>
+#include <asm/page.h>
+
+#define cpu_dcache_is_aliasing()	(DCACHE_WAY_SIZE > PAGE_SIZE)
+
+#endif
diff --git a/include/linux/cacheinfo.h b/include/linux/cacheinfo.h
index d504eb4b49ab..2cb15fe4fe12 100644
--- a/include/linux/cacheinfo.h
+++ b/include/linux/cacheinfo.h
@@ -138,4 +138,10 @@ static inline int get_cpu_cacheinfo_id(int cpu, int level)
 #define use_arch_cache_info()	(false)
 #endif
 
+#ifndef CONFIG_ARCH_HAS_CPU_CACHE_ALIASING
+#define cpu_dcache_is_aliasing()	false
+#else
+#include <asm/cachetype.h>
+#endif
+
 #endif /* _LINUX_CACHEINFO_H */
diff --git a/mm/Kconfig b/mm/Kconfig
index 57cd378c73d6..db09c9ad15c9 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -1016,6 +1016,12 @@ config IDLE_PAGE_TRACKING
 	  See Documentation/admin-guide/mm/idle_page_tracking.rst for
 	  more details.
 
+# Architectures which implement cpu_dcache_is_aliasing() to query
+# whether the data caches are aliased (VIVT or VIPT with dcache
+# aliasing) need to select this.
+config ARCH_HAS_CPU_CACHE_ALIASING
+	bool
+
 config ARCH_HAS_CACHE_LINE_SIZE
 	bool
 
-- 
2.39.2


