Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B334433084B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Mar 2021 07:42:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234961AbhCHGmQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Mar 2021 01:42:16 -0500
Received: from foss.arm.com ([217.140.110.172]:60386 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234991AbhCHGlz (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Mar 2021 01:41:55 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E029811D4;
        Sun,  7 Mar 2021 22:41:54 -0800 (PST)
Received: from p8cg001049571a15.arm.com (unknown [10.163.67.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E3FCA3F73C;
        Sun,  7 Mar 2021 22:41:45 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>, x86@kernel.org,
        linux-ia64@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-sh@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 3/6] mm: Generalize ARCH_ENABLE_MEMORY_[HOTPLUG|HOTREMOVE]
Date:   Mon,  8 Mar 2021 12:11:42 +0530
Message-Id: <1615185706-24342-4-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1615185706-24342-1-git-send-email-anshuman.khandual@arm.com>
References: <1615185706-24342-1-git-send-email-anshuman.khandual@arm.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

ARCH_ENABLE_MEMORY_[HOTPLUG|HOTREMOVE] configs have duplicate definitions
on platforms that subscribe them. Instead, just make them generic options
which can be selected on applicable platforms.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-ia64@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-s390@vger.kernel.org
Cc: linux-sh@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/Kconfig   |  8 ++------
 arch/ia64/Kconfig    |  8 ++------
 arch/powerpc/Kconfig |  8 ++------
 arch/s390/Kconfig    |  8 ++------
 arch/sh/Kconfig      |  2 ++
 arch/sh/mm/Kconfig   |  8 --------
 arch/x86/Kconfig     | 10 ++--------
 mm/Kconfig           |  6 ++++++
 8 files changed, 18 insertions(+), 40 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 68fe3b5bf17a..67e904b0f32a 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -11,6 +11,8 @@ config ARM64
 	select ACPI_PPTT if ACPI
 	select ARCH_HAS_DEBUG_WX
 	select ARCH_BINFMT_ELF_STATE
+	select ARCH_ENABLE_MEMORY_HOTPLUG
+	select ARCH_ENABLE_MEMORY_HOTREMOVE
 	select ARCH_HAS_CACHE_LINE_SIZE
 	select ARCH_HAS_DEBUG_VIRTUAL
 	select ARCH_HAS_DEBUG_VM_PGTABLE
@@ -305,12 +307,6 @@ config ZONE_DMA32
 	bool "Support DMA32 zone" if EXPERT
 	default y
 
-config ARCH_ENABLE_MEMORY_HOTPLUG
-	def_bool y
-
-config ARCH_ENABLE_MEMORY_HOTREMOVE
-	def_bool y
-
 config SMP
 	def_bool y
 
diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
index 2ad7a8d29fcc..96ce53ad5c9d 100644
--- a/arch/ia64/Kconfig
+++ b/arch/ia64/Kconfig
@@ -13,6 +13,8 @@ config IA64
 	select ARCH_MIGHT_HAVE_PC_SERIO
 	select ACPI
 	select ACPI_NUMA if NUMA
+	select ARCH_ENABLE_MEMORY_HOTPLUG
+	select ARCH_ENABLE_MEMORY_HOTREMOVE
 	select ARCH_SUPPORTS_ACPI
 	select ACPI_SYSTEM_POWER_STATES_SUPPORT if ACPI
 	select ARCH_MIGHT_HAVE_ACPI_PDC if ACPI
@@ -250,12 +252,6 @@ config HOTPLUG_CPU
 	  can be controlled through /sys/devices/system/cpu/cpu#.
 	  Say N if you want to disable CPU hotplug.
 
-config ARCH_ENABLE_MEMORY_HOTPLUG
-	def_bool y
-
-config ARCH_ENABLE_MEMORY_HOTREMOVE
-	def_bool y
-
 config SCHED_SMT
 	bool "SMT scheduler support"
 	depends on SMP
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index a74c211e55b1..02a05a24659d 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -118,6 +118,8 @@ config PPC
 	# Please keep this list sorted alphabetically.
 	#
 	select ARCH_32BIT_OFF_T if PPC32
+	select ARCH_ENABLE_MEMORY_HOTPLUG
+	select ARCH_ENABLE_MEMORY_HOTREMOVE
 	select ARCH_HAS_DEBUG_VIRTUAL
 	select ARCH_HAS_DEVMEM_IS_ALLOWED
 	select ARCH_HAS_ELF_RANDOMIZE
@@ -515,12 +517,6 @@ config ARCH_CPU_PROBE_RELEASE
 	def_bool y
 	depends on HOTPLUG_CPU
 
-config ARCH_ENABLE_MEMORY_HOTPLUG
-	def_bool y
-
-config ARCH_ENABLE_MEMORY_HOTREMOVE
-	def_bool y
-
 config PPC64_SUPPORTS_MEMORY_FAILURE
 	bool "Add support for memory hwpoison"
 	depends on PPC_BOOK3S_64
diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index c1ff874e6c2e..f8b356550daa 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -60,6 +60,8 @@ config S390
 	imply IMA_SECURE_AND_OR_TRUSTED_BOOT
 	select ARCH_32BIT_USTAT_F_TINODE
 	select ARCH_BINFMT_ELF_STATE
+	select ARCH_ENABLE_MEMORY_HOTPLUG if SPARSEMEM
+	select ARCH_ENABLE_MEMORY_HOTREMOVE
 	select ARCH_HAS_DEBUG_VM_PGTABLE
 	select ARCH_HAS_DEBUG_WX
 	select ARCH_HAS_DEVMEM_IS_ALLOWED
@@ -626,12 +628,6 @@ config ARCH_SPARSEMEM_ENABLE
 config ARCH_SPARSEMEM_DEFAULT
 	def_bool y
 
-config ARCH_ENABLE_MEMORY_HOTPLUG
-	def_bool y if SPARSEMEM
-
-config ARCH_ENABLE_MEMORY_HOTREMOVE
-	def_bool y
-
 config ARCH_ENABLE_SPLIT_PMD_PTLOCK
 	def_bool y
 
diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index a54b0c5de37b..68129537e350 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -2,6 +2,8 @@
 config SUPERH
 	def_bool y
 	select ARCH_32BIT_OFF_T
+	select ARCH_ENABLE_MEMORY_HOTPLUG if SPARSEMEM && MMU
+	select ARCH_ENABLE_MEMORY_HOTREMOVE if SPARSEMEM && MMU
 	select ARCH_HAVE_CUSTOM_GPIO_H
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG if (GUSA_RB || CPU_SH4A)
 	select ARCH_HAS_BINFMT_FLAT if !MMU
diff --git a/arch/sh/mm/Kconfig b/arch/sh/mm/Kconfig
index 77aa2f802d8d..d551a9cac41e 100644
--- a/arch/sh/mm/Kconfig
+++ b/arch/sh/mm/Kconfig
@@ -136,14 +136,6 @@ config ARCH_SPARSEMEM_DEFAULT
 config ARCH_SELECT_MEMORY_MODEL
 	def_bool y
 
-config ARCH_ENABLE_MEMORY_HOTPLUG
-	def_bool y
-	depends on SPARSEMEM && MMU
-
-config ARCH_ENABLE_MEMORY_HOTREMOVE
-	def_bool y
-	depends on SPARSEMEM && MMU
-
 config ARCH_MEMORY_PROBE
 	def_bool y
 	depends on MEMORY_HOTPLUG
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 51d171abb57a..503d8b2e8676 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -60,6 +60,8 @@ config X86
 	select ACPI_SYSTEM_POWER_STATES_SUPPORT	if ACPI
 	select ARCH_32BIT_OFF_T			if X86_32
 	select ARCH_CLOCKSOURCE_INIT
+	select ARCH_ENABLE_MEMORY_HOTPLUG if X86_64 || (X86_32 && HIGHMEM)
+	select ARCH_ENABLE_MEMORY_HOTREMOVE if MEMORY_HOTPLUG
 	select ARCH_HAS_ACPI_TABLE_UPGRADE	if ACPI
 	select ARCH_HAS_CACHE_LINE_SIZE
 	select ARCH_HAS_DEBUG_VIRTUAL
@@ -2423,14 +2425,6 @@ config ARCH_HAS_ADD_PAGES
 	def_bool y
 	depends on X86_64 && ARCH_ENABLE_MEMORY_HOTPLUG
 
-config ARCH_ENABLE_MEMORY_HOTPLUG
-	def_bool y
-	depends on X86_64 || (X86_32 && HIGHMEM)
-
-config ARCH_ENABLE_MEMORY_HOTREMOVE
-	def_bool y
-	depends on MEMORY_HOTPLUG
-
 config USE_PERCPU_NUMA_NODE_ID
 	def_bool y
 	depends on NUMA
diff --git a/mm/Kconfig b/mm/Kconfig
index 1c9a37fc651a..9b58fa08847d 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -149,6 +149,9 @@ config MEMORY_ISOLATION
 config HAVE_BOOTMEM_INFO_NODE
 	def_bool n
 
+config ARCH_ENABLE_MEMORY_HOTPLUG
+	bool
+
 # eventually, we can have this option just 'select SPARSEMEM'
 config MEMORY_HOTPLUG
 	bool "Allow for memory hot-add"
@@ -177,6 +180,9 @@ config MEMORY_HOTPLUG_DEFAULT_ONLINE
 	  Say N here if you want the default policy to keep all hot-plugged
 	  memory blocks in 'offline' state.
 
+config ARCH_ENABLE_MEMORY_HOTREMOVE
+	bool
+
 config MEMORY_HOTREMOVE
 	bool "Allow for memory hot remove"
 	select HAVE_BOOTMEM_INFO_NODE if (X86_64 || PPC64)
-- 
2.20.1

