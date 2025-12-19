Return-Path: <linux-fsdevel+bounces-71758-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 497AECD1137
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Dec 2025 18:12:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D1B243038142
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Dec 2025 17:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73D4135F8AC;
	Fri, 19 Dec 2025 16:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A7OuTvnR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0DCB35028C
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Dec 2025 16:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766161004; cv=none; b=IZFpWqUDQK6Gz62mGp/AnWsl9op2BjptZH5SJ/YldklYZZDkktLbwaKCVIFNCdRjs4L30ywKsLLo0DvEhHM15AX+qrPS15UKoeFSQ7dPG+z+CTU3GGjUpE5xo80Z9wwIhT69vQQSBsluVjqaZ2xxYuxIqGRurE4ltM8EmqsSVbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766161004; c=relaxed/simple;
	bh=y2TDenBgzz1JkKgbnUspPJnIA+uv4gCj0emzILOiwVI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mgnGO3sVRlnZRp9dLgWnPgo1di+Sy1pBOpq3Zg80CqE47A1uZyMFRPE+2P/R+2mhAR8/uGBTFY0mhxk5oh/51IBpqjQUEVw5+JVZ4Ou7iPyt0DbWefaw+CEcLbr6EI+TTWpKLH75B8x1Fvs2iYMKJLnS0DVvVhMUPL9taPvWDvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A7OuTvnR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D04DC116C6;
	Fri, 19 Dec 2025 16:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766161004;
	bh=y2TDenBgzz1JkKgbnUspPJnIA+uv4gCj0emzILOiwVI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A7OuTvnReFS3MrkYNOIEGgcs+Z7OvkKsMu+2esQMRsv5WMHjDb/+jWEumFggTQn/d
	 B0pvYTi1xGaHAXqrORU8GPSt7G0P9gXQEx22QhpdaCI+L0odetlWwgex5eThtMzOBm
	 m+575wBeBX44bLofNLR5SKMGWOUw/kNt7bdJzsQvyYsLsjDlbOh9XD+C9jsmsdLv8J
	 ptzbgKHGftEuZ558Q8PVqSJumz+sKt1yDXVl1mvy/LdLVUpswhbb9EjCTQe7hbrNrR
	 LSWSiuClawxuVXmfiTbHnpW3geR2gowerapXT2cS5IT8zMeJY65QrQeSNpWoM6bx1R
	 wvkfS3AQV7a7Q==
From: Arnd Bergmann <arnd@kernel.org>
To: linux-mm@kvack.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andreas Larsson <andreas@gaisler.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Matthew Wilcox <willy@infradead.org>,
	Richard Weinberger <richard@nod.at>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	x86@kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Michal Simek <monstr@monstr.eu>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Nishanth Menon <nm@ti.com>,
	Lucas Stach <l.stach@pengutronix.de>
Subject: [PATCH 1/4] arch/*: increase lowmem size to avoid highmem use
Date: Fri, 19 Dec 2025 17:15:56 +0100
Message-Id: <20251219161559.556737-2-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251219161559.556737-1-arnd@kernel.org>
References: <20251219161559.556737-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

Most of the common 32-bit architectures (x86, arm, powerpc) all use the
default virtual memory layout that was already in place for i386 systems
in the 1990s, using exactly 3GiB of user TASK_SIZE, with the upper 1GiB
of addresses split between (at most 896MiB) lowmem and vmalloc.

Linux-2.3 introduced CONFIG_HIGHMEM for large x86 server machines that
had 4GiB of RAM or more, with the VMSPLIT_3G/2G/1G options added in
v2.6.16 for machines that had one or two gigabytes of memory but wanted
to avoid the overhead from managing highmem. Over time, similar options
appeared on other 32-bit architectures.

Twenty years later, it makes sense to reconsider the default settings,
as the tradeoffs have changed a bit:

 - Configurations with more than 2GiB have become extremely rare,
   as any users with large memory have moved on to 64-bit systems.
   There were only ever a few Laptop models in this category: Apple
   Powerbook G4 (2005), Macbook (2006), IBM Thinkpad X60 (2006), Arm
   Chromebooks based on Exynos 5800 (2014), Tegra K1 (2014) and RK3288
   (2015), and manufacturer support for all of these has ended in 2020
   or (much) earlier.
   Embedded systems with more than 2GiB use additional SoCs of a
   similar vintage: Intel Atom Z5xx (2008), Freescale QorIQ (2008),
   Marvell Armada XP (2010), Freescale i.MX6Q (2011), LSI Axxia (2013),
   TI Keystone2 (2014), Renesas RZ/G1M (2015). Most boards based on
   these have stopped receiving kernel upgrades. Newer 32-bit chips
   only support smaller memory configurations, though in particular the
   i.MX6Q and Keystone2 families have expected support cycles past 2035.
   While 32-bit server installations used to support even larger memory,
   none of those seem to still be used in production on any architecture.

 - While general-purpose distributes for 32-bit targets were common,
   it was rather risky to change the CONFIG_VMSPLIT setting because
   there is always a possibility of running into device driver bugs or
   applications that need a large virtual memory size. Presumably
   a lot of these issues have been resolved now, so most setups should
   be fine using a custom vmsplit instead of highmem now.

 - As fewer users test highmem, the expectation is that it will
   increasingly break in the future, so getting users to change the
   vmsplit means that even if there is a bug to fix initially,
   it improves the situation in the long run.

 - Highmem will ultimately need to be removed, at least for the page
   cache and most other code using it today. In a previous discussion, I
   had suggested doing this as early as 2029, but based on the discussions
   since ELC, the plan is now to leave highmem-enabled page cache as an
   option until at least 2029, at which point remaining users will have
   the choice between no longer updating kernels or using a combination of
   a custom vmsplit and zram/zswap. Changing the defaults now should both
   speed up the highmem deprecation and make it less painful for users.

 - The most VM space intensive applications tend to be web browsers,
   specifcally Chrome/ChromeOS and Firefox. Both have now stopped
   providing binary updates, but Firefox can still be built from source.
   Testing various combinations on Debian/armhf, I found that Firefox 140
   can still show complex websites with VMSPLIT_2G_OPT with and without
   HIGHMEM, though it failed for me both with the small address space
   of VMSPLIT_1G and the small lowmem of VMSPLIT_3G_OPT when HIGHMEM
   is disabled.
   This is likely to get worse with future versions, so embedded users
   may still be forced to migrate to specialized browsers like WPE Webkit
   when HIGHMEM pagecache is finally removed.

Based on the above observations and the discussion at the kernel summit,
change the defaults to the most appropriate values: use 1GiB of lowmem on
non-highmem configurations, and either 2GiB or 1.75GiB of lowmem on highmem
builds, depending on what is available on the architecture.  As ARM_LPAE
and X86_PAE builds both require a gigabyte-aligned vmsplit, those get
to use VMSPLIT_2G. The result is that the majority of previous highmem
users now only need lowmem. For platform specific defconfig files that
are known to only support up to 1GiB of RAM, drop the CONFIG_HIGHMEM line
as well as a simplification.

On PowerPC and Microblaze, the options have somewhat different names but
should have the same effect. MIPS and Xtensa cannot support a larger
than 512MB of lowmem but are limited to small DDR2 memory in most
implementations, with MT7621 being a notable exception. ARC and C-Sky
could support a configurable vmsplit in theory, but it's not clear
if anyone still cares.
SPARC is currently limited to 192MB of lowmem and should get patched
to behave either like arm/x86 or powerpc/microblaze to support 2GiB
of lowmem.

There are likely going to be regressions from the changed defaults,
in particular when hitting previously hidden device driver bugs
that fail to set the correct DMA mask, or from applications that
need a large virtual address space.
Ideally the in-kernel problems should all be fixable, but the previous
behavior is still selectable as a fallback with CONFIG_EXPERT=y

Cc: Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: Michal Simek <monstr@monstr.eu>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@kernel.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Liam R. Howlett <Liam.Howlett@oracle.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: linux-mm@kvack.org
Cc: Richard Weinberger <richard@nod.at>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Nishanth Menon <nm@ti.com>
Cc: Andreas Larsson <andreas@gaisler.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/Kconfig                            |  5 ++++-
 arch/arm/configs/aspeed_g5_defconfig        |  1 -
 arch/arm/configs/dove_defconfig             |  2 --
 arch/arm/configs/mv78xx0_defconfig          |  2 --
 arch/arm/configs/u8500_defconfig            |  1 -
 arch/arm/configs/vt8500_v6_v7_defconfig     |  3 ---
 arch/arm/mach-omap2/Kconfig                 |  1 -
 arch/microblaze/Kconfig                     |  9 ++++++---
 arch/microblaze/configs/mmu_defconfig       |  1 -
 arch/powerpc/Kconfig                        | 17 +++++++++++------
 arch/powerpc/configs/44x/akebono_defconfig  |  1 -
 arch/powerpc/configs/85xx/ksi8560_defconfig |  1 -
 arch/powerpc/configs/85xx/stx_gp3_defconfig |  1 -
 arch/x86/Kconfig                            |  4 +++-
 14 files changed, 24 insertions(+), 25 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index fa83c040ee2d..7c0ac017e086 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1009,7 +1009,8 @@ config BL_SWITCHER_DUMMY_IF
 choice
 	prompt "Memory split"
 	depends on MMU
-	default VMSPLIT_3G
+	default VMSPLIT_2G if HIGHMEM || ARM_LPAE
+	default VMSPLIT_3G_OPT
 	help
 	  Select the desired split between kernel and user memory.
 
@@ -1018,8 +1019,10 @@ choice
 
 	config VMSPLIT_3G
 		bool "3G/1G user/kernel split"
+		depends on !HIGHMEM || EXPERT
 	config VMSPLIT_3G_OPT
 		depends on !ARM_LPAE
+		depends on !HIGHMEM || EXPERT
 		bool "3G/1G user/kernel split (for full 1G low memory)"
 	config VMSPLIT_2G
 		bool "2G/2G user/kernel split"
diff --git a/arch/arm/configs/aspeed_g5_defconfig b/arch/arm/configs/aspeed_g5_defconfig
index 2e6ea13c1e9b..be5ea1775b3f 100644
--- a/arch/arm/configs/aspeed_g5_defconfig
+++ b/arch/arm/configs/aspeed_g5_defconfig
@@ -27,7 +27,6 @@ CONFIG_SMP=y
 # CONFIG_ARM_CPU_TOPOLOGY is not set
 CONFIG_VMSPLIT_2G=y
 CONFIG_NR_CPUS=2
-CONFIG_HIGHMEM=y
 CONFIG_UACCESS_WITH_MEMCPY=y
 # CONFIG_ATAGS is not set
 CONFIG_VFP=y
diff --git a/arch/arm/configs/dove_defconfig b/arch/arm/configs/dove_defconfig
index e98c35df675e..75c67678c4ba 100644
--- a/arch/arm/configs/dove_defconfig
+++ b/arch/arm/configs/dove_defconfig
@@ -7,8 +7,6 @@ CONFIG_EXPERT=y
 CONFIG_ARCH_MULTI_V7=y
 CONFIG_ARCH_DOVE=y
 CONFIG_MACH_CM_A510=y
-CONFIG_AEABI=y
-CONFIG_HIGHMEM=y
 CONFIG_ARM_APPENDED_DTB=y
 CONFIG_ARM_ATAG_DTB_COMPAT=y
 CONFIG_VFP=y
diff --git a/arch/arm/configs/mv78xx0_defconfig b/arch/arm/configs/mv78xx0_defconfig
index d3a26efe766c..cbd47155eca9 100644
--- a/arch/arm/configs/mv78xx0_defconfig
+++ b/arch/arm/configs/mv78xx0_defconfig
@@ -11,7 +11,6 @@ CONFIG_ARCH_MULTI_V5=y
 CONFIG_ARCH_MV78XX0=y
 CONFIG_MACH_TERASTATION_WXL=y
 CONFIG_AEABI=y
-CONFIG_HIGHMEM=y
 CONFIG_FPE_NWFPE=y
 CONFIG_VFP=y
 CONFIG_KPROBES=y
diff --git a/arch/arm/configs/u8500_defconfig b/arch/arm/configs/u8500_defconfig
index e88533b78327..a53269cbe475 100644
--- a/arch/arm/configs/u8500_defconfig
+++ b/arch/arm/configs/u8500_defconfig
@@ -6,7 +6,6 @@ CONFIG_KALLSYMS_ALL=y
 CONFIG_ARCH_U8500=y
 CONFIG_SMP=y
 CONFIG_NR_CPUS=2
-CONFIG_HIGHMEM=y
 CONFIG_ARM_APPENDED_DTB=y
 CONFIG_ARM_ATAG_DTB_COMPAT=y
 CONFIG_CMDLINE="root=/dev/ram0 console=ttyAMA2,115200n8"
diff --git a/arch/arm/configs/vt8500_v6_v7_defconfig b/arch/arm/configs/vt8500_v6_v7_defconfig
index 41607a84abc8..1f6dca21d569 100644
--- a/arch/arm/configs/vt8500_v6_v7_defconfig
+++ b/arch/arm/configs/vt8500_v6_v7_defconfig
@@ -8,8 +8,6 @@ CONFIG_ARM_ERRATA_720789=y
 CONFIG_ARM_ERRATA_775420=y
 CONFIG_HAVE_ARM_ARCH_TIMER=y
 CONFIG_AEABI=y
-CONFIG_HIGHMEM=y
-CONFIG_HIGHPTE=y
 CONFIG_ARM_APPENDED_DTB=y
 CONFIG_ARM_ATAG_DTB_COMPAT=y
 CONFIG_VFP=y
diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 821727eefd5a..4a2591985ff3 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -135,7 +135,6 @@ config ARCH_OMAP2PLUS_TYPICAL
 	bool "Typical OMAP configuration"
 	default y
 	select AEABI
-	select HIGHMEM
 	select I2C
 	select I2C_OMAP
 	select MENELAUS if ARCH_OMAP2
diff --git a/arch/microblaze/Kconfig b/arch/microblaze/Kconfig
index 484ebb3baedf..c25b8185bbbd 100644
--- a/arch/microblaze/Kconfig
+++ b/arch/microblaze/Kconfig
@@ -163,7 +163,8 @@ config LOWMEM_SIZE_BOOL
 
 config LOWMEM_SIZE
 	hex "Maximum low memory size (in bytes)" if LOWMEM_SIZE_BOOL
-	default "0x30000000"
+	default "0x80000000" if HIGHMEM
+	default "0x40000000"
 
 config MANUAL_RESET_VECTOR
 	hex "Microblaze reset vector address setup"
@@ -189,7 +190,8 @@ config KERNEL_START_BOOL
 
 config KERNEL_START
 	hex "Virtual address of kernel base" if KERNEL_START_BOOL
-	default "0xc0000000"
+	default "0x70000000" if HIGHMEM
+	default "0xb0000000"
 
 config TASK_SIZE_BOOL
 	bool "Set custom user task size"
@@ -203,7 +205,8 @@ config TASK_SIZE_BOOL
 
 config TASK_SIZE
 	hex "Size of user task space" if TASK_SIZE_BOOL
-	default "0x80000000"
+	default "0x70000000" if HIGHMEM
+	default "0xb0000000"
 
 config MB_MANAGER
 	bool "Support for Microblaze Manager"
diff --git a/arch/microblaze/configs/mmu_defconfig b/arch/microblaze/configs/mmu_defconfig
index fbbdcb394ca2..255fa7b69117 100644
--- a/arch/microblaze/configs/mmu_defconfig
+++ b/arch/microblaze/configs/mmu_defconfig
@@ -15,7 +15,6 @@ CONFIG_XILINX_MICROBLAZE0_USE_FPU=2
 CONFIG_HZ_100=y
 CONFIG_CMDLINE_BOOL=y
 CONFIG_CMDLINE_FORCE=y
-CONFIG_HIGHMEM=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 CONFIG_PARTITION_ADVANCED=y
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 9537a61ebae0..1fa92ed8f28c 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -490,6 +490,7 @@ menu "Kernel options"
 config HIGHMEM
 	bool "High memory support"
 	depends on PPC32
+	depends on PPC_BOOK3S_32 || PPC_85xx || 44x
 	select KMAP_LOCAL
 
 source "kernel/Kconfig.hz"
@@ -1190,7 +1191,8 @@ config LOWMEM_SIZE_BOOL
 
 config LOWMEM_SIZE
 	hex "Maximum low memory size (in bytes)" if LOWMEM_SIZE_BOOL
-	default "0x30000000"
+	default "0x80000000" if HIGHMEM
+	default "0x40000000"
 
 config LOWMEM_CAM_NUM_BOOL
 	bool "Set number of CAMs to use to map low memory"
@@ -1242,7 +1244,8 @@ config PAGE_OFFSET_BOOL
 
 config PAGE_OFFSET
 	hex "Virtual address of memory base" if PAGE_OFFSET_BOOL
-	default "0xc0000000"
+	default "0x70000000" if HIGHMEM
+	default "0xb0000000"
 
 config KERNEL_START_BOOL
 	bool "Set custom kernel base address"
@@ -1258,8 +1261,9 @@ config KERNEL_START_BOOL
 config KERNEL_START
 	hex "Virtual address of kernel base" if KERNEL_START_BOOL
 	default PAGE_OFFSET if PAGE_OFFSET_BOOL
-	default "0xc2000000" if CRASH_DUMP && !NONSTATIC_KERNEL
-	default "0xc0000000"
+	default "0x72000000" if HIGHMEM && CRASH_DUMP && !NONSTATIC_KERNEL
+	default "0xb2000000" if CRASH_DUMP && !NONSTATIC_KERNEL
+	default PAGE_OFFSET
 
 config PHYSICAL_START_BOOL
 	bool "Set physical address where the kernel is loaded"
@@ -1295,8 +1299,9 @@ config TASK_SIZE_BOOL
 config TASK_SIZE
 	hex "Size of user task space" if TASK_SIZE_BOOL
 	default "0x80000000" if PPC_8xx
-	default "0xb0000000" if PPC_BOOK3S_32 && EXECMEM
-	default "0xc0000000"
+	default "0x60000000" if PPC_BOOK3S_32 && EXECMEM && HIGHMEM
+	default "0xa0000000" if PPC_BOOK3S_32 && EXECMEM
+	default PAGE_OFFSET
 
 config MODULES_SIZE_BOOL
 	bool "Set custom size for modules/execmem area"
diff --git a/arch/powerpc/configs/44x/akebono_defconfig b/arch/powerpc/configs/44x/akebono_defconfig
index 02e88648a2e6..992db368848f 100644
--- a/arch/powerpc/configs/44x/akebono_defconfig
+++ b/arch/powerpc/configs/44x/akebono_defconfig
@@ -14,7 +14,6 @@ CONFIG_MODULE_UNLOAD=y
 CONFIG_PPC_47x=y
 # CONFIG_EBONY is not set
 CONFIG_AKEBONO=y
-CONFIG_HIGHMEM=y
 CONFIG_HZ_100=y
 CONFIG_IRQ_ALL_CPUS=y
 # CONFIG_COMPACTION is not set
diff --git a/arch/powerpc/configs/85xx/ksi8560_defconfig b/arch/powerpc/configs/85xx/ksi8560_defconfig
index 9cb211fb6d1e..f2ac1fc41303 100644
--- a/arch/powerpc/configs/85xx/ksi8560_defconfig
+++ b/arch/powerpc/configs/85xx/ksi8560_defconfig
@@ -9,7 +9,6 @@ CONFIG_PARTITION_ADVANCED=y
 CONFIG_KSI8560=y
 CONFIG_CPM2=y
 CONFIG_GEN_RTC=y
-CONFIG_HIGHMEM=y
 CONFIG_BINFMT_MISC=y
 CONFIG_MATH_EMULATION=y
 # CONFIG_SECCOMP is not set
diff --git a/arch/powerpc/configs/85xx/stx_gp3_defconfig b/arch/powerpc/configs/85xx/stx_gp3_defconfig
index 0a42072fa23c..1033977711d6 100644
--- a/arch/powerpc/configs/85xx/stx_gp3_defconfig
+++ b/arch/powerpc/configs/85xx/stx_gp3_defconfig
@@ -7,7 +7,6 @@ CONFIG_MODULES=y
 CONFIG_MODVERSIONS=y
 # CONFIG_BLK_DEV_BSG is not set
 CONFIG_STX_GP3=y
-CONFIG_HIGHMEM=y
 CONFIG_BINFMT_MISC=m
 CONFIG_MATH_EMULATION=y
 CONFIG_PCI=y
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 80527299f859..b40c8fd6cac1 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1416,7 +1416,9 @@ config HIGHMEM4G
 
 choice
 	prompt "Memory split" if EXPERT
-	default VMSPLIT_3G
+	default VMSPLIT_2G_OPT if HIGHMEM && !X86_PAE
+	default VMSPLIT_2G if X86_PAE
+	default VMSPLIT_3G_OPT
 	depends on X86_32
 	help
 	  Select the desired split between kernel and user memory.
-- 
2.39.5


