Return-Path: <linux-fsdevel+bounces-61183-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21689B55CF8
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Sep 2025 03:11:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 079781C87BCB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Sep 2025 01:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78C6B199FAB;
	Sat, 13 Sep 2025 01:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HiNoLN4M"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7278419B5B1
	for <linux-fsdevel@vger.kernel.org>; Sat, 13 Sep 2025 01:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757725847; cv=none; b=OsrWk1kllPzcHmzbuzZ36iP/YKsRyL/8N2ZlsXvSSaPHjUALtOcFMZtMSQ95r2lstXhsQvP0w0Ee4EqeoHF0GmW5E2RIi75jMjTrP4ph8I8oH+Jn+SN3ZX4BTS8JF9JyRRzuYHVLqFdMmngxL/4peP1iDMcXW9Pxf8w7yjqV+x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757725847; c=relaxed/simple;
	bh=Pv4efaO6aabAZeBZ+jULi9vYDoCWTo1D7LXT2Xhcg2I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Psqvox1MwZoJF8ULSFNJ6dy3JK+YAKityn3uddqrkE1wsce7T52DxMOEQlsfPfYoWoAy/CHnRMeZFKL+BfFsYWeGT69Mh0YlbO3Bbo8FXrzWbXtk+y4DC/MP1HFu5pxunytUrDHL//Lbtsp+hLso85DFViW3ePs+Y6fFi15Ln4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HiNoLN4M; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b04ba58a84fso347513766b.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Sep 2025 18:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757725838; x=1758330638; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j9ScdAsUp9yn/MNyBXHNdfOZ1Vzp3PkVTtF+LLcFMZY=;
        b=HiNoLN4MuauvJzCVUJmphaggNeiMRXAtGfF6zKugsEUlzr4cfOiW2lsNSl8e8/CzMM
         0Ly7pDjJMFoh6q+JgjF3x5A9LeBU3ai1pfZzkdEqv+T4PidM77bxmennuYuZcG9GEcIv
         ssiCHlub54BQGI43YZHhkqqID3m6H+awVsOjL4EQJ5My/zUio4pi1/r2ZirNbRm15Yvb
         MQDWZDRMmyHXCrXgFLUIVtkzSa3EQJSudzgRXUE03rQtLnSwJeHCu6iJTsjwyquMPVLl
         NKWBZntYZStCGjXHqZLy+QXtpeJlZATghV6VKozorLFj51PWOOaQw5Xp6s4q6FbAer2k
         1c5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757725838; x=1758330638;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j9ScdAsUp9yn/MNyBXHNdfOZ1Vzp3PkVTtF+LLcFMZY=;
        b=QAKnWpIiI33n7vjnNGgy7Z13E69z+QZxT00fCGp4an7IhfhJSb4t4P8ecfYfabOLcr
         6nrC8ktvqRWIYyNGjxkef5wipU4h1DYv7N+kOt3taS7sg5lobPhMrKJnO6P5Kq4zcYcC
         5G4gCYv/agDU1VChSWtFyC8Rlk4oFVjEPSxUTvX5tcFLIwDIcYwtDWlvBMuD8/DpmZrb
         Ppjg3/EwYTF8eMcAAPg+pKOVvq9vFXGkFTElz9CxcFlJ4y1IfnpzU5xtthqBqKMDTGQ9
         TOzqdacZnLRqTEHr8+l/tzhmvmoyubDLXAPtAiifNJlwq3EAteHyhOpzqnPuUP8Ol+zJ
         BSZA==
X-Gm-Message-State: AOJu0YzsIbgQFrQGG6GS68NFwGo/hbbmVZ2h39A2LJ33aGtHPOYbQ5cA
	StHvwDmaRNKMLwiiRyUHixqyu+OlDHw88ItRkEQ6UPBpEbJRPIfw4FSJEJ8pK7mF
X-Gm-Gg: ASbGncvInuDTngg4v/uFm9Q/YKOW5c/10xumW7Di4IxdTW9XXKOB2DcYpNdczZWugJe
	hDgElkTrRtkN2yDXPpwWqMHP26juonL1NEBkuLh8GSv35L91dvrZIRk1z3AIqYh5+6gUMVBdlAl
	sgoyRXJMDcY+OfulRm2UBvFs4NuKXyqMWVjiDvOiwc1AUuPcrrXzFfTAv1M1OJSQ6JeimrLqu7a
	EBLzTLrZqiiFGe2n9nLakH8jC3eLypbOrIJAd1MPvsVmyyAu98/+uQ8S3UJFHsIjPD/dt/+9OcP
	+yxHx+Whuk9Xewtx8+RdIg6ZdlFpaACqjSNx5jAeyMTSORGd20aMWJuetDAL35s0izE8oAOI15d
	g+c96QROvvRNdYCQmBi0=
X-Google-Smtp-Source: AGHT+IErcdJS++SkmdDFQub7kXyLrAwl0wUJgcAeUqGvMcuIJGTBmTSTKj7/pPWrytg0qmd7JyrHaQ==
X-Received: by 2002:a17:907:1c25:b0:b04:626e:f435 with SMTP id a640c23a62f3a-b07c357a185mr463393666b.22.1757725837265;
        Fri, 12 Sep 2025 18:10:37 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b07b30da310sm467430466b.20.2025.09.12.18.10.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 18:10:36 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Aleksa Sarai <cyphar@cyphar.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Julian Stecklina <julian.stecklina@cyberus-technology.de>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Art Nikpal <email2tema@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Eric Curtin <ecurtin@redhat.com>,
	Alexander Graf <graf@amazon.com>,
	Rob Landley <rob@landley.net>,
	Lennart Poettering <mzxreary@0pointer.de>,
	linux-arch@vger.kernel.org,
	linux-alpha@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org,
	linux-openrisc@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-um@lists.infradead.org,
	x86@kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	linux-block@vger.kernel.org,
	initramfs@vger.kernel.org,
	linux-api@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-efi@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	"Theodore Y . Ts'o" <tytso@mit.edu>,
	linux-acpi@vger.kernel.org,
	Michal Simek <monstr@monstr.eu>,
	devicetree@vger.kernel.org,
	Luis Chamberlain <mcgrof@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Heiko Carstens <hca@linux.ibm.com>,
	patches@lists.linux.dev
Subject: [PATCH RESEND 28/62] init: alpha, arc, arm, arm64, csky, m68k, microblaze, mips, nios2, openrisc, parisc, powerpc, s390, sh, sparc, um, x86, xtensa: rename initrd_{start,end} to virt_external_initramfs_{start,end}
Date: Sat, 13 Sep 2025 00:38:07 +0000
Message-ID: <20250913003842.41944-29-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250913003842.41944-1-safinaskar@gmail.com>
References: <20250913003842.41944-1-safinaskar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename initrd_start to virt_external_initramfs_start and
initrd_end to virt_external_initramfs_end.

They refer to initramfs, not to initrd

Signed-off-by: Askar Safin <safinaskar@gmail.com>
---
 arch/alpha/kernel/core_irongate.c       |  6 ++--
 arch/alpha/kernel/setup.c               | 24 +++++++-------
 arch/arc/mm/init.c                      |  4 +--
 arch/arm/mm/init.c                      |  4 +--
 arch/arm64/mm/init.c                    |  4 +--
 arch/csky/kernel/setup.c                | 16 ++++-----
 arch/m68k/kernel/setup_mm.c             |  6 ++--
 arch/m68k/kernel/setup_no.c             |  6 ++--
 arch/m68k/kernel/uboot.c                |  6 ++--
 arch/microblaze/mm/init.c               |  6 ++--
 arch/mips/ath79/prom.c                  |  8 ++---
 arch/mips/kernel/setup.c                | 44 ++++++++++++-------------
 arch/mips/sibyte/common/cfe.c           | 22 ++++++-------
 arch/nios2/kernel/setup.c               | 10 +++---
 arch/openrisc/kernel/setup.c            | 14 ++++----
 arch/parisc/kernel/pdt.c                |  2 +-
 arch/parisc/kernel/setup.c              |  4 +--
 arch/parisc/mm/init.c                   | 24 +++++++-------
 arch/powerpc/kernel/prom.c              | 14 ++++----
 arch/powerpc/kernel/setup-common.c      | 14 ++++----
 arch/powerpc/platforms/powermac/setup.c |  2 +-
 arch/s390/kernel/setup.c                |  4 +--
 arch/sh/kernel/setup.c                  |  8 ++---
 arch/sparc/mm/init_32.c                 | 18 +++++-----
 arch/sparc/mm/init_64.c                 | 14 ++++----
 arch/um/kernel/initrd.c                 |  4 +--
 arch/x86/kernel/cpu/microcode/core.c    |  8 ++---
 arch/x86/kernel/setup.c                 | 12 +++----
 arch/xtensa/kernel/setup.c              | 14 ++++----
 drivers/acpi/tables.c                   |  4 +--
 drivers/of/fdt.c                        |  4 +--
 include/linux/initrd.h                  |  4 +--
 init/do_mounts_initrd.c                 |  2 +-
 init/initramfs.c                        | 40 +++++++++++-----------
 init/main.c                             | 18 +++++-----
 35 files changed, 197 insertions(+), 197 deletions(-)

diff --git a/arch/alpha/kernel/core_irongate.c b/arch/alpha/kernel/core_irongate.c
index 3411564144ae..5519bb8fc6f2 100644
--- a/arch/alpha/kernel/core_irongate.c
+++ b/arch/alpha/kernel/core_irongate.c
@@ -226,11 +226,11 @@ albacore_init_arch(void)
 	if (memtop > pci_mem) {
 #ifdef CONFIG_BLK_DEV_INITRD
 		/* Move the initrd out of the way. */
-		if (initrd_end && __pa(initrd_end) > pci_mem) {
+		if (virt_external_initramfs_end && __pa(virt_external_initramfs_end) > pci_mem) {
 			unsigned long size;
 
-			size = initrd_end - initrd_start;
-			memblock_free((void *)initrd_start, PAGE_ALIGN(size));
+			size = virt_external_initramfs_end - virt_external_initramfs_start;
+			memblock_free((void *)virt_external_initramfs_start, PAGE_ALIGN(size));
 			if (!move_initrd(pci_mem))
 				printk("irongate_init_arch: initrd too big "
 				       "(%ldK)\ndisabling initrd\n",
diff --git a/arch/alpha/kernel/setup.c b/arch/alpha/kernel/setup.c
index bebdffafaee8..a344e71b2d2a 100644
--- a/arch/alpha/kernel/setup.c
+++ b/arch/alpha/kernel/setup.c
@@ -268,15 +268,15 @@ move_initrd(unsigned long mem_limit)
 	void *start;
 	unsigned long size;
 
-	size = initrd_end - initrd_start;
+	size = virt_external_initramfs_end - virt_external_initramfs_start;
 	start = memblock_alloc(PAGE_ALIGN(size), PAGE_SIZE);
 	if (!start || __pa(start) + size > mem_limit) {
-		initrd_start = initrd_end = 0;
+		virt_external_initramfs_start = virt_external_initramfs_end = 0;
 		return NULL;
 	}
-	memmove(start, (void *)initrd_start, size);
-	initrd_start = (unsigned long)start;
-	initrd_end = initrd_start + size;
+	memmove(start, (void *)virt_external_initramfs_start, size);
+	virt_external_initramfs_start = (unsigned long)start;
+	virt_external_initramfs_end = virt_external_initramfs_start + size;
 	printk("initrd moved to %p\n", start);
 	return start;
 }
@@ -347,20 +347,20 @@ setup_memory(void *kernel_end)
 	memblock_reserve(KERNEL_START_PHYS, kernel_size);
 
 #ifdef CONFIG_BLK_DEV_INITRD
-	initrd_start = INITRD_START;
-	if (initrd_start) {
-		initrd_end = initrd_start+INITRD_SIZE;
+	virt_external_initramfs_start = INITRD_START;
+	if (virt_external_initramfs_start) {
+		virt_external_initramfs_end = virt_external_initramfs_start+INITRD_SIZE;
 		printk("Initial ramdisk at: 0x%p (%lu bytes)\n",
-		       (void *) initrd_start, INITRD_SIZE);
+		       (void *) virt_external_initramfs_start, INITRD_SIZE);
 
-		if ((void *)initrd_end > phys_to_virt(PFN_PHYS(max_low_pfn))) {
+		if ((void *)virt_external_initramfs_end > phys_to_virt(PFN_PHYS(max_low_pfn))) {
 			if (!move_initrd(PFN_PHYS(max_low_pfn)))
 				printk("initrd extends beyond end of memory "
 				       "(0x%08lx > 0x%p)\ndisabling initrd\n",
-				       initrd_end,
+				       virt_external_initramfs_end,
 				       phys_to_virt(PFN_PHYS(max_low_pfn)));
 		} else {
-			memblock_reserve(virt_to_phys((void *)initrd_start),
+			memblock_reserve(virt_to_phys((void *)virt_external_initramfs_start),
 					INITRD_SIZE);
 		}
 	}
diff --git a/arch/arc/mm/init.c b/arch/arc/mm/init.c
index eb8a616a63c6..1e098d7fc6af 100644
--- a/arch/arc/mm/init.c
+++ b/arch/arc/mm/init.c
@@ -112,8 +112,8 @@ void __init setup_arch_memory(void)
 #ifdef CONFIG_BLK_DEV_INITRD
 	if (phys_external_initramfs_size) {
 		memblock_reserve(phys_external_initramfs_start, phys_external_initramfs_size);
-		initrd_start = (unsigned long)__va(phys_external_initramfs_start);
-		initrd_end = initrd_start + phys_external_initramfs_size;
+		virt_external_initramfs_start = (unsigned long)__va(phys_external_initramfs_start);
+		virt_external_initramfs_end = virt_external_initramfs_start + phys_external_initramfs_size;
 	}
 #endif
 
diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index 93f8010b9115..4faeec51c522 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -439,9 +439,9 @@ void free_initmem(void)
 #ifdef CONFIG_BLK_DEV_INITRD
 void free_initrd_mem(unsigned long start, unsigned long end)
 {
-	if (start == initrd_start)
+	if (start == virt_external_initramfs_start)
 		start = round_down(start, PAGE_SIZE);
-	if (end == initrd_end)
+	if (end == virt_external_initramfs_end)
 		end = round_up(end, PAGE_SIZE);
 
 	poison_init_mem((void *)start, PAGE_ALIGN(end) - start);
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index da517edcf824..3414e48c8c82 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -283,8 +283,8 @@ void __init arm64_memblock_init(void)
 	memblock_reserve(__pa_symbol(_stext), _end - _stext);
 	if (IS_ENABLED(CONFIG_BLK_DEV_INITRD) && phys_external_initramfs_size) {
 		/* the generic initrd code expects virtual addresses */
-		initrd_start = __phys_to_virt(phys_external_initramfs_start);
-		initrd_end = initrd_start + phys_external_initramfs_size;
+		virt_external_initramfs_start = __phys_to_virt(phys_external_initramfs_start);
+		virt_external_initramfs_end = virt_external_initramfs_start + phys_external_initramfs_size;
 	}
 
 	early_init_fdt_scan_reserved_mem();
diff --git a/arch/csky/kernel/setup.c b/arch/csky/kernel/setup.c
index e0d6ca86ea8c..ce128888462e 100644
--- a/arch/csky/kernel/setup.c
+++ b/arch/csky/kernel/setup.c
@@ -17,35 +17,35 @@ static void __init setup_initrd(void)
 {
 	unsigned long size;
 
-	if (initrd_start >= initrd_end) {
+	if (virt_external_initramfs_start >= virt_external_initramfs_end) {
 		pr_err("initrd not found or empty");
 		goto disable;
 	}
 
-	if (__pa(initrd_end) > PFN_PHYS(max_low_pfn)) {
+	if (__pa(virt_external_initramfs_end) > PFN_PHYS(max_low_pfn)) {
 		pr_err("initrd extends beyond end of memory");
 		goto disable;
 	}
 
-	size = initrd_end - initrd_start;
+	size = virt_external_initramfs_end - virt_external_initramfs_start;
 
-	if (memblock_is_region_reserved(__pa(initrd_start), size)) {
+	if (memblock_is_region_reserved(__pa(virt_external_initramfs_start), size)) {
 		pr_err("INITRD: 0x%08lx+0x%08lx overlaps in-use memory region",
-		       __pa(initrd_start), size);
+		       __pa(virt_external_initramfs_start), size);
 		goto disable;
 	}
 
-	memblock_reserve(__pa(initrd_start), size);
+	memblock_reserve(__pa(virt_external_initramfs_start), size);
 
 	pr_info("Initial ramdisk at: 0x%p (%lu bytes)\n",
-		(void *)(initrd_start), size);
+		(void *)(virt_external_initramfs_start), size);
 
 	initrd_below_start_ok = 1;
 
 	return;
 
 disable:
-	initrd_start = initrd_end = 0;
+	virt_external_initramfs_start = virt_external_initramfs_end = 0;
 
 	pr_err(" - disabling initrd\n");
 }
diff --git a/arch/m68k/kernel/setup_mm.c b/arch/m68k/kernel/setup_mm.c
index c7e8de0d34bb..80f0544c1041 100644
--- a/arch/m68k/kernel/setup_mm.c
+++ b/arch/m68k/kernel/setup_mm.c
@@ -333,9 +333,9 @@ void __init setup_arch(char **cmdline_p)
 	paging_init();
 
 	if (IS_ENABLED(CONFIG_BLK_DEV_INITRD) && m68k_ramdisk.size) {
-		initrd_start = (unsigned long)phys_to_virt(m68k_ramdisk.addr);
-		initrd_end = initrd_start + m68k_ramdisk.size;
-		pr_info("initrd: %08lx - %08lx\n", initrd_start, initrd_end);
+		virt_external_initramfs_start = (unsigned long)phys_to_virt(m68k_ramdisk.addr);
+		virt_external_initramfs_end = virt_external_initramfs_start + m68k_ramdisk.size;
+		pr_info("initrd: %08lx - %08lx\n", virt_external_initramfs_start, virt_external_initramfs_end);
 	}
 
 #ifdef CONFIG_NATFEAT
diff --git a/arch/m68k/kernel/setup_no.c b/arch/m68k/kernel/setup_no.c
index f724875b15cc..4d98e0063725 100644
--- a/arch/m68k/kernel/setup_no.c
+++ b/arch/m68k/kernel/setup_no.c
@@ -155,9 +155,9 @@ void __init setup_arch(char **cmdline_p)
 	max_pfn = max_low_pfn = PFN_DOWN(memory_end);
 
 #if defined(CONFIG_UBOOT) && defined(CONFIG_BLK_DEV_INITRD)
-	if ((initrd_start > 0) && (initrd_start < initrd_end) &&
-			(initrd_end < memory_end))
-		memblock_reserve(initrd_start, initrd_end - initrd_start);
+	if ((virt_external_initramfs_start > 0) && (virt_external_initramfs_start < virt_external_initramfs_end) &&
+			(virt_external_initramfs_end < memory_end))
+		memblock_reserve(virt_external_initramfs_start, virt_external_initramfs_end - virt_external_initramfs_start);
 #endif /* if defined(CONFIG_BLK_DEV_INITRD) */
 
 	/*
diff --git a/arch/m68k/kernel/uboot.c b/arch/m68k/kernel/uboot.c
index d278060a250c..5fc831a0794a 100644
--- a/arch/m68k/kernel/uboot.c
+++ b/arch/m68k/kernel/uboot.c
@@ -81,9 +81,9 @@ static void __init parse_uboot_commandline(char *commandp, int size)
 
 	if (uboot_initrd_start && uboot_initrd_end &&
 	    (uboot_initrd_end > uboot_initrd_start)) {
-		initrd_start = uboot_initrd_start;
-		initrd_end = uboot_initrd_end;
-		pr_info("initrd at 0x%lx:0x%lx\n", initrd_start, initrd_end);
+		virt_external_initramfs_start = uboot_initrd_start;
+		virt_external_initramfs_end = uboot_initrd_end;
+		pr_info("initrd at 0x%lx:0x%lx\n", virt_external_initramfs_start, virt_external_initramfs_end);
 	}
 #endif /* if defined(CONFIG_BLK_DEV_INITRD) */
 }
diff --git a/arch/microblaze/mm/init.c b/arch/microblaze/mm/init.c
index 31d475cdb1c5..fabeca49c2c6 100644
--- a/arch/microblaze/mm/init.c
+++ b/arch/microblaze/mm/init.c
@@ -202,10 +202,10 @@ asmlinkage void __init mmu_init(void)
 
 #if defined(CONFIG_BLK_DEV_INITRD)
 	/* Remove the init RAM disk from the available memory. */
-	if (initrd_start) {
+	if (virt_external_initramfs_start) {
 		unsigned long size;
-		size = initrd_end - initrd_start;
-		memblock_reserve(__virt_to_phys(initrd_start), size);
+		size = virt_external_initramfs_end - virt_external_initramfs_start;
+		memblock_reserve(__virt_to_phys(virt_external_initramfs_start), size);
 	}
 #endif /* CONFIG_BLK_DEV_INITRD */
 
diff --git a/arch/mips/ath79/prom.c b/arch/mips/ath79/prom.c
index cc6dc5600677..506dcada711b 100644
--- a/arch/mips/ath79/prom.c
+++ b/arch/mips/ath79/prom.c
@@ -25,10 +25,10 @@ void __init prom_init(void)
 
 #ifdef CONFIG_BLK_DEV_INITRD
 	/* Read the initrd address from the firmware environment */
-	initrd_start = fw_getenvl("initrd_start");
-	if (initrd_start) {
-		initrd_start = KSEG0ADDR(initrd_start);
-		initrd_end = initrd_start + fw_getenvl("initrd_size");
+	virt_external_initramfs_start = fw_getenvl("initrd_start");
+	if (virt_external_initramfs_start) {
+		virt_external_initramfs_start = KSEG0ADDR(virt_external_initramfs_start);
+		virt_external_initramfs_end = virt_external_initramfs_start + fw_getenvl("initrd_size");
 	}
 #endif
 }
diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index a78e24873231..da11ae875539 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -126,15 +126,15 @@ static int __init rd_start_early(char *p)
 	if (start < XKPHYS)
 		start = (int)start;
 #endif
-	initrd_start = start;
-	initrd_end += start;
+	virt_external_initramfs_start = start;
+	virt_external_initramfs_end += start;
 	return 0;
 }
 early_param("rd_start", rd_start_early);
 
 static int __init rd_size_early(char *p)
 {
-	initrd_end += memparse(p, &p);
+	virt_external_initramfs_end += memparse(p, &p);
 	return 0;
 }
 early_param("rd_size", rd_size_early);
@@ -146,13 +146,13 @@ static unsigned long __init init_initrd(void)
 
 	/*
 	 * Board specific code or command line parser should have
-	 * already set up initrd_start and initrd_end. In these cases
+	 * already set up virt_external_initramfs_start and virt_external_initramfs_end. In these cases
 	 * perform sanity checks and use them if all looks good.
 	 */
-	if (!initrd_start || initrd_end <= initrd_start)
+	if (!virt_external_initramfs_start || virt_external_initramfs_end <= virt_external_initramfs_start)
 		goto disable;
 
-	if (initrd_start & ~PAGE_MASK) {
+	if (virt_external_initramfs_start & ~PAGE_MASK) {
 		pr_err("initrd start must be page aligned\n");
 		goto disable;
 	}
@@ -164,19 +164,19 @@ static unsigned long __init init_initrd(void)
 	 * 32-bit. We need also to switch from KSEG0 to XKPHYS
 	 * addresses now, so the code can now safely use __pa().
 	 */
-	end = __pa(initrd_end);
-	initrd_end = (unsigned long)__va(end);
-	initrd_start = (unsigned long)__va(__pa(initrd_start));
+	end = __pa(virt_external_initramfs_end);
+	virt_external_initramfs_end = (unsigned long)__va(end);
+	virt_external_initramfs_start = (unsigned long)__va(__pa(virt_external_initramfs_start));
 
-	if (initrd_start < PAGE_OFFSET) {
+	if (virt_external_initramfs_start < PAGE_OFFSET) {
 		pr_err("initrd start < PAGE_OFFSET\n");
 		goto disable;
 	}
 
 	return PFN_UP(end);
 disable:
-	initrd_start = 0;
-	initrd_end = 0;
+	virt_external_initramfs_start = 0;
+	virt_external_initramfs_end = 0;
 	return 0;
 }
 
@@ -189,21 +189,21 @@ static void __init maybe_bswap_initrd(void)
 	u64 buf;
 
 	/* Check for CPIO signature */
-	if (!memcmp((void *)initrd_start, "070701", 6))
+	if (!memcmp((void *)virt_external_initramfs_start, "070701", 6))
 		return;
 
 	/* Check for compressed initrd */
-	if (decompress_method((unsigned char *)initrd_start, 8, NULL))
+	if (decompress_method((unsigned char *)virt_external_initramfs_start, 8, NULL))
 		return;
 
 	/* Try again with a byte swapped header */
-	buf = swab64p((u64 *)initrd_start);
+	buf = swab64p((u64 *)virt_external_initramfs_start);
 	if (!memcmp(&buf, "070701", 6) ||
 	    decompress_method((unsigned char *)(&buf), 8, NULL)) {
 		unsigned long i;
 
 		pr_info("Byteswapped initrd detected\n");
-		for (i = initrd_start; i < ALIGN(initrd_end, 8); i += 8)
+		for (i = virt_external_initramfs_start; i < ALIGN(virt_external_initramfs_end, 8); i += 8)
 			swab64s((u64 *)i);
 	}
 #endif
@@ -211,29 +211,29 @@ static void __init maybe_bswap_initrd(void)
 
 static void __init finalize_initrd(void)
 {
-	unsigned long size = initrd_end - initrd_start;
+	unsigned long size = virt_external_initramfs_end - virt_external_initramfs_start;
 
 	if (size == 0) {
 		printk(KERN_INFO "Initrd not found or empty");
 		goto disable;
 	}
-	if (__pa(initrd_end) > PFN_PHYS(max_low_pfn)) {
+	if (__pa(virt_external_initramfs_end) > PFN_PHYS(max_low_pfn)) {
 		printk(KERN_ERR "Initrd extends beyond end of memory");
 		goto disable;
 	}
 
 	maybe_bswap_initrd();
 
-	memblock_reserve(__pa(initrd_start), size);
+	memblock_reserve(__pa(virt_external_initramfs_start), size);
 	initrd_below_start_ok = 1;
 
 	pr_info("Initial ramdisk at: 0x%lx (%lu bytes)\n",
-		initrd_start, size);
+		virt_external_initramfs_start, size);
 	return;
 disable:
 	printk(KERN_CONT " - disabling initrd\n");
-	initrd_start = 0;
-	initrd_end = 0;
+	virt_external_initramfs_start = 0;
+	virt_external_initramfs_end = 0;
 }
 
 #else  /* !CONFIG_BLK_DEV_INITRD */
diff --git a/arch/mips/sibyte/common/cfe.c b/arch/mips/sibyte/common/cfe.c
index 2cb90dbbe843..642b7d615594 100644
--- a/arch/mips/sibyte/common/cfe.c
+++ b/arch/mips/sibyte/common/cfe.c
@@ -38,7 +38,7 @@
 int cfe_cons_handle;
 
 #ifdef CONFIG_BLK_DEV_INITRD
-extern unsigned long initrd_start, initrd_end;
+extern unsigned long virt_external_initramfs_start, virt_external_initramfs_end;
 #endif
 
 static void __noreturn cfe_linux_exit(void *arg)
@@ -86,9 +86,9 @@ static __init void prom_meminit(void)
 	unsigned long initrd_pstart;
 	unsigned long initrd_pend;
 
-	initrd_pstart = CPHYSADDR(initrd_start);
-	initrd_pend = CPHYSADDR(initrd_end);
-	if (initrd_start &&
+	initrd_pstart = CPHYSADDR(virt_external_initramfs_start);
+	initrd_pend = CPHYSADDR(virt_external_initramfs_end);
+	if (virt_external_initramfs_start &&
 	    ((initrd_pstart > MAX_RAM_SIZE)
 	     || (initrd_pend > MAX_RAM_SIZE))) {
 		panic("initrd out of addressable memory");
@@ -105,7 +105,7 @@ static __init void prom_meminit(void)
 			 * ramdisk
 			 */
 #ifdef CONFIG_BLK_DEV_INITRD
-			if (initrd_start) {
+			if (virt_external_initramfs_start) {
 				if ((initrd_pstart > addr) &&
 				    (initrd_pstart < (addr + size))) {
 					memblock_add(addr,
@@ -139,7 +139,7 @@ static __init void prom_meminit(void)
 		}
 	}
 #ifdef CONFIG_BLK_DEV_INITRD
-	if (initrd_start) {
+	if (virt_external_initramfs_start) {
 		memblock_add(initrd_pstart, initrd_pend - initrd_pstart);
 		memblock_reserve(initrd_pstart, initrd_pend - initrd_pstart);
 	}
@@ -183,17 +183,17 @@ static int __init initrd_setup(char *str)
 		goto fail;
 	}
 	*(tmp-1) = '@';
-	initrd_start = simple_strtoul(tmp, &endptr, 16);
+	virt_external_initramfs_start = simple_strtoul(tmp, &endptr, 16);
 	if (*endptr) {
 		goto fail;
 	}
-	initrd_end = initrd_start + initrd_size;
-	printk("Found initrd of %lx@%lx\n", initrd_size, initrd_start);
+	virt_external_initramfs_end = virt_external_initramfs_start + initrd_size;
+	printk("Found initrd of %lx@%lx\n", initrd_size, virt_external_initramfs_start);
 	return 1;
  fail:
 	printk("Bad initrd argument.  Disabling initrd\n");
-	initrd_start = 0;
-	initrd_end = 0;
+	virt_external_initramfs_start = 0;
+	virt_external_initramfs_end = 0;
 	return 1;
 }
 
diff --git a/arch/nios2/kernel/setup.c b/arch/nios2/kernel/setup.c
index 2a40150142c3..3cc44fa4931c 100644
--- a/arch/nios2/kernel/setup.c
+++ b/arch/nios2/kernel/setup.c
@@ -109,8 +109,8 @@ asmlinkage void __init nios2_boot_init(unsigned r4, unsigned r5, unsigned r6,
 	if (r4 == 0x534f494e) { /* r4 is magic NIOS */
 #if defined(CONFIG_BLK_DEV_INITRD)
 		if (r5) { /* initramfs */
-			initrd_start = r5;
-			initrd_end = r6;
+			virt_external_initramfs_start = r5;
+			virt_external_initramfs_end = r6;
 		}
 #endif /* CONFIG_BLK_DEV_INITRD */
 		dtb_passed = r6;
@@ -161,9 +161,9 @@ void __init setup_arch(char **cmdline_p)
 
 	memblock_reserve(__pa_symbol(_stext), _end - _stext);
 #ifdef CONFIG_BLK_DEV_INITRD
-	if (initrd_start) {
-		memblock_reserve(virt_to_phys((void *)initrd_start),
-				initrd_end - initrd_start);
+	if (virt_external_initramfs_start) {
+		memblock_reserve(virt_to_phys((void *)virt_external_initramfs_start),
+				virt_external_initramfs_end - virt_external_initramfs_start);
 	}
 #endif /* CONFIG_BLK_DEV_INITRD */
 
diff --git a/arch/openrisc/kernel/setup.c b/arch/openrisc/kernel/setup.c
index a9fb9cc6779e..f387dc57ec35 100644
--- a/arch/openrisc/kernel/setup.c
+++ b/arch/openrisc/kernel/setup.c
@@ -77,9 +77,9 @@ static void __init setup_memory(void)
 
 #ifdef CONFIG_BLK_DEV_INITRD
 	/* Then reserve the initrd, if any */
-	if (initrd_start && (initrd_end > initrd_start)) {
-		unsigned long aligned_start = ALIGN_DOWN(initrd_start, PAGE_SIZE);
-		unsigned long aligned_end = ALIGN(initrd_end, PAGE_SIZE);
+	if (virt_external_initramfs_start && (virt_external_initramfs_end > virt_external_initramfs_start)) {
+		unsigned long aligned_start = ALIGN_DOWN(virt_external_initramfs_start, PAGE_SIZE);
+		unsigned long aligned_end = ALIGN(virt_external_initramfs_end, PAGE_SIZE);
 
 		memblock_reserve(__pa(aligned_start), aligned_end - aligned_start);
 	}
@@ -239,13 +239,13 @@ void __init setup_arch(char **cmdline_p)
 	setup_initial_init_mm(_stext, _etext, _edata, _end);
 
 #ifdef CONFIG_BLK_DEV_INITRD
-	if (initrd_start == initrd_end) {
+	if (virt_external_initramfs_start == virt_external_initramfs_end) {
 		printk(KERN_INFO "Initial ramdisk not found\n");
-		initrd_start = 0;
-		initrd_end = 0;
+		virt_external_initramfs_start = 0;
+		virt_external_initramfs_end = 0;
 	} else {
 		printk(KERN_INFO "Initial ramdisk at: 0x%p (%lu bytes)\n",
-		       (void *)(initrd_start), initrd_end - initrd_start);
+		       (void *)(virt_external_initramfs_start), virt_external_initramfs_end - virt_external_initramfs_start);
 		initrd_below_start_ok = 1;
 	}
 #endif
diff --git a/arch/parisc/kernel/pdt.c b/arch/parisc/kernel/pdt.c
index b70b67adb855..3715a3b088a7 100644
--- a/arch/parisc/kernel/pdt.c
+++ b/arch/parisc/kernel/pdt.c
@@ -229,7 +229,7 @@ void __init pdc_pdt_init(void)
 
 		addr = pdt_entry[i] & PDT_ADDR_PHYS_MASK;
 		if (IS_ENABLED(CONFIG_BLK_DEV_INITRD) &&
-			addr >= initrd_start && addr < initrd_end)
+			addr >= virt_external_initramfs_start && addr < virt_external_initramfs_end)
 			pr_crit("CRITICAL: initrd possibly broken "
 				"due to bad memory!\n");
 
diff --git a/arch/parisc/kernel/setup.c b/arch/parisc/kernel/setup.c
index ace483b6f19a..41f45fa177d0 100644
--- a/arch/parisc/kernel/setup.c
+++ b/arch/parisc/kernel/setup.c
@@ -71,8 +71,8 @@ static void __init setup_cmdline(char **cmdline_p)
 #ifdef CONFIG_BLK_DEV_INITRD
 	/* did palo pass us a ramdisk? */
 	if (boot_args[2] != 0) {
-		initrd_start = (unsigned long)__va(boot_args[2]);
-		initrd_end = (unsigned long)__va(boot_args[3]);
+		virt_external_initramfs_start = (unsigned long)__va(boot_args[2]);
+		virt_external_initramfs_end = (unsigned long)__va(boot_args[3]);
 	}
 #endif
 
diff --git a/arch/parisc/mm/init.c b/arch/parisc/mm/init.c
index 14270715d754..74bfe9797589 100644
--- a/arch/parisc/mm/init.c
+++ b/arch/parisc/mm/init.c
@@ -298,20 +298,20 @@ static void __init setup_bootmem(void)
 #endif
 
 #ifdef CONFIG_BLK_DEV_INITRD
-	if (initrd_start) {
-		printk(KERN_INFO "initrd: %08lx-%08lx\n", initrd_start, initrd_end);
-		if (__pa(initrd_start) < mem_max) {
+	if (virt_external_initramfs_start) {
+		printk(KERN_INFO "initrd: %08lx-%08lx\n", virt_external_initramfs_start, virt_external_initramfs_end);
+		if (__pa(virt_external_initramfs_start) < mem_max) {
 			unsigned long initrd_reserve;
 
-			if (__pa(initrd_end) > mem_max) {
-				initrd_reserve = mem_max - __pa(initrd_start);
+			if (__pa(virt_external_initramfs_end) > mem_max) {
+				initrd_reserve = mem_max - __pa(virt_external_initramfs_start);
 			} else {
-				initrd_reserve = initrd_end - initrd_start;
+				initrd_reserve = virt_external_initramfs_end - virt_external_initramfs_start;
 			}
 			initrd_below_start_ok = 1;
-			printk(KERN_INFO "initrd: reserving %08lx-%08lx (mem_max %08lx)\n", __pa(initrd_start), __pa(initrd_start) + initrd_reserve, mem_max);
+			printk(KERN_INFO "initrd: reserving %08lx-%08lx (mem_max %08lx)\n", __pa(virt_external_initramfs_start), __pa(virt_external_initramfs_start) + initrd_reserve, mem_max);
 
-			memblock_reserve(__pa(initrd_start), initrd_reserve);
+			memblock_reserve(__pa(virt_external_initramfs_start), initrd_reserve);
 		}
 	}
 #endif
@@ -633,10 +633,10 @@ static void __init pagetable_init(void)
 	}
 
 #ifdef CONFIG_BLK_DEV_INITRD
-	if (initrd_end && initrd_end > mem_limit) {
-		printk(KERN_INFO "initrd: mapping %08lx-%08lx\n", initrd_start, initrd_end);
-		map_pages(initrd_start, __pa(initrd_start),
-			  initrd_end - initrd_start, PAGE_KERNEL, 0);
+	if (virt_external_initramfs_end && virt_external_initramfs_end > mem_limit) {
+		printk(KERN_INFO "initrd: mapping %08lx-%08lx\n", virt_external_initramfs_start, virt_external_initramfs_end);
+		map_pages(virt_external_initramfs_start, __pa(virt_external_initramfs_start),
+			  virt_external_initramfs_end - virt_external_initramfs_start, PAGE_KERNEL, 0);
 	}
 #endif
 
diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 9ed9dde7d231..b7858b0bd697 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -97,11 +97,11 @@ early_param("mem", early_parse_mem);
 static inline int overlaps_initrd(unsigned long start, unsigned long size)
 {
 #ifdef CONFIG_BLK_DEV_INITRD
-	if (!initrd_start)
+	if (!virt_external_initramfs_start)
 		return 0;
 
-	return	(start + size) > ALIGN_DOWN(initrd_start, PAGE_SIZE) &&
-			start <= ALIGN(initrd_end, PAGE_SIZE);
+	return	(start + size) > ALIGN_DOWN(virt_external_initramfs_start, PAGE_SIZE) &&
+			start <= ALIGN(virt_external_initramfs_end, PAGE_SIZE);
 #else
 	return 0;
 #endif
@@ -686,10 +686,10 @@ static void __init early_reserve_mem(void)
 
 #ifdef CONFIG_BLK_DEV_INITRD
 	/* Then reserve the initrd, if any */
-	if (initrd_start && (initrd_end > initrd_start)) {
-		memblock_reserve(ALIGN_DOWN(__pa(initrd_start), PAGE_SIZE),
-			ALIGN(initrd_end, PAGE_SIZE) -
-			ALIGN_DOWN(initrd_start, PAGE_SIZE));
+	if (virt_external_initramfs_start && (virt_external_initramfs_end > virt_external_initramfs_start)) {
+		memblock_reserve(ALIGN_DOWN(__pa(virt_external_initramfs_start), PAGE_SIZE),
+			ALIGN(virt_external_initramfs_end, PAGE_SIZE) -
+			ALIGN_DOWN(virt_external_initramfs_start, PAGE_SIZE));
 	}
 #endif /* CONFIG_BLK_DEV_INITRD */
 
diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index 97d330f3b8f1..eff369cba0e5 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -360,17 +360,17 @@ const struct seq_operations cpuinfo_op = {
 void __init check_for_initrd(void)
 {
 #ifdef CONFIG_BLK_DEV_INITRD
-	DBG(" -> check_for_initrd()  initrd_start=0x%lx  initrd_end=0x%lx\n",
-	    initrd_start, initrd_end);
+	DBG(" -> check_for_initrd()  virt_external_initramfs_start=0x%lx  virt_external_initramfs_end=0x%lx\n",
+	    virt_external_initramfs_start, virt_external_initramfs_end);
 
 	/* If we were not passed an sensible initramfs, clear initramfs reference.
 	 */
-	if (!(is_kernel_addr(initrd_start) && is_kernel_addr(initrd_end) &&
-	    initrd_end > initrd_start))
-		initrd_start = initrd_end = 0;
+	if (!(is_kernel_addr(virt_external_initramfs_start) && is_kernel_addr(virt_external_initramfs_end) &&
+	    virt_external_initramfs_end > virt_external_initramfs_start))
+		virt_external_initramfs_start = virt_external_initramfs_end = 0;
 
-	if (initrd_start)
-		pr_info("Found initramfs at 0x%lx:0x%lx\n", initrd_start, initrd_end);
+	if (virt_external_initramfs_start)
+		pr_info("Found initramfs at 0x%lx:0x%lx\n", virt_external_initramfs_start, virt_external_initramfs_end);
 
 	DBG(" <- check_for_initrd()\n");
 #endif /* CONFIG_BLK_DEV_INITRD */
diff --git a/arch/powerpc/platforms/powermac/setup.c b/arch/powerpc/platforms/powermac/setup.c
index 237d8386a3f4..4c3b9ed5428d 100644
--- a/arch/powerpc/platforms/powermac/setup.c
+++ b/arch/powerpc/platforms/powermac/setup.c
@@ -296,7 +296,7 @@ static void __init pmac_setup_arch(void)
 #endif
 #ifdef CONFIG_PPC32
 #ifdef CONFIG_BLK_DEV_INITRD
-	if (!initrd_start)
+	if (!virt_external_initramfs_start)
 #endif
 		ROOT_DEV = DEFAULT_ROOT_DEVICE;
 #endif
diff --git a/arch/s390/kernel/setup.c b/arch/s390/kernel/setup.c
index a4ce721b7fe8..9bdb6f6b893e 100644
--- a/arch/s390/kernel/setup.c
+++ b/arch/s390/kernel/setup.c
@@ -672,8 +672,8 @@ static void __init reserve_initrd(void)
 
 	if (!IS_ENABLED(CONFIG_BLK_DEV_INITRD) || !get_physmem_reserved(RR_INITRD, &addr, &size))
 		return;
-	initrd_start = (unsigned long)__va(addr);
-	initrd_end = initrd_start + size;
+	virt_external_initramfs_start = (unsigned long)__va(addr);
+	virt_external_initramfs_end = virt_external_initramfs_start + size;
 	memblock_reserve(addr, size);
 }
 
diff --git a/arch/sh/kernel/setup.c b/arch/sh/kernel/setup.c
index c4312ee13db9..9ce9dc5b9e56 100644
--- a/arch/sh/kernel/setup.c
+++ b/arch/sh/kernel/setup.c
@@ -153,16 +153,16 @@ void __init check_for_initrd(void)
 	/*
 	 * Address sanitization
 	 */
-	initrd_start = (unsigned long)__va(start);
-	initrd_end = initrd_start + INITRD_SIZE;
+	virt_external_initramfs_start = (unsigned long)__va(start);
+	virt_external_initramfs_end = virt_external_initramfs_start + INITRD_SIZE;
 
-	memblock_reserve(__pa(initrd_start), INITRD_SIZE);
+	memblock_reserve(__pa(virt_external_initramfs_start), INITRD_SIZE);
 
 	return;
 
 disable:
 	pr_info("initrd disabled\n");
-	initrd_start = initrd_end = 0;
+	virt_external_initramfs_start = virt_external_initramfs_end = 0;
 #endif
 }
 
diff --git a/arch/sparc/mm/init_32.c b/arch/sparc/mm/init_32.c
index fdc93dd12c3e..7b7722ff5232 100644
--- a/arch/sparc/mm/init_32.c
+++ b/arch/sparc/mm/init_32.c
@@ -109,20 +109,20 @@ static void __init find_ramdisk(unsigned long end_of_phys_memory)
 	if (sparc_ramdisk_image) {
 		if (sparc_ramdisk_image >= (unsigned long)&_end - 2 * PAGE_SIZE)
 			sparc_ramdisk_image -= KERNBASE;
-		initrd_start = sparc_ramdisk_image + phys_base;
-		initrd_end = initrd_start + sparc_ramdisk_size;
-		if (initrd_end > end_of_phys_memory) {
+		virt_external_initramfs_start = sparc_ramdisk_image + phys_base;
+		virt_external_initramfs_end = virt_external_initramfs_start + sparc_ramdisk_size;
+		if (virt_external_initramfs_end > end_of_phys_memory) {
 			printk(KERN_CRIT "initrd extends beyond end of memory "
 			       "(0x%016lx > 0x%016lx)\ndisabling initrd\n",
-			       initrd_end, end_of_phys_memory);
-			initrd_start = 0;
+			       virt_external_initramfs_end, end_of_phys_memory);
+			virt_external_initramfs_start = 0;
 		} else {
 			/* Reserve the initrd image area. */
-			size = initrd_end - initrd_start;
-			memblock_reserve(initrd_start, size);
+			size = virt_external_initramfs_end - virt_external_initramfs_start;
+			memblock_reserve(virt_external_initramfs_start, size);
 
-			initrd_start = (initrd_start - phys_base) + PAGE_OFFSET;
-			initrd_end = (initrd_end - phys_base) + PAGE_OFFSET;
+			virt_external_initramfs_start = (virt_external_initramfs_start - phys_base) + PAGE_OFFSET;
+			virt_external_initramfs_end = (virt_external_initramfs_end - phys_base) + PAGE_OFFSET;
 		}
 	}
 #endif
diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index 7ed58bf3aaca..af249a654e79 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -901,13 +901,13 @@ static void __init find_ramdisk(unsigned long phys_base)
 		numadbg("Found ramdisk at physical address 0x%lx, size %u\n",
 			ramdisk_image, sparc_ramdisk_size);
 
-		initrd_start = ramdisk_image;
-		initrd_end = ramdisk_image + sparc_ramdisk_size;
+		virt_external_initramfs_start = ramdisk_image;
+		virt_external_initramfs_end = ramdisk_image + sparc_ramdisk_size;
 
-		memblock_reserve(initrd_start, sparc_ramdisk_size);
+		memblock_reserve(virt_external_initramfs_start, sparc_ramdisk_size);
 
-		initrd_start += PAGE_OFFSET;
-		initrd_end += PAGE_OFFSET;
+		virt_external_initramfs_start += PAGE_OFFSET;
+		virt_external_initramfs_end += PAGE_OFFSET;
 	}
 #endif
 }
@@ -2485,8 +2485,8 @@ int page_in_phys_avail(unsigned long paddr)
 	if (paddr >= kern_base && paddr < (kern_base + kern_size))
 		return 1;
 #ifdef CONFIG_BLK_DEV_INITRD
-	if (paddr >= __pa(initrd_start) &&
-	    paddr < __pa(PAGE_ALIGN(initrd_end)))
+	if (paddr >= __pa(virt_external_initramfs_start) &&
+	    paddr < __pa(PAGE_ALIGN(virt_external_initramfs_end)))
 		return 1;
 #endif
 
diff --git a/arch/um/kernel/initrd.c b/arch/um/kernel/initrd.c
index 99dba827461c..e6113192a6b6 100644
--- a/arch/um/kernel/initrd.c
+++ b/arch/um/kernel/initrd.c
@@ -27,8 +27,8 @@ int __init read_initrd(void)
 	if (!area)
 		return 0;
 
-	initrd_start = (unsigned long) area;
-	initrd_end = initrd_start + size;
+	virt_external_initramfs_start = (unsigned long) area;
+	virt_external_initramfs_end = virt_external_initramfs_start + size;
 	return 0;
 }
 
diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index b92e09a87c69..b8169f14d175 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -213,13 +213,13 @@ struct cpio_data __init find_microcode_in_initrd(const char *path)
 #endif
 
 	/*
-	 * Fixup the start address: after reserve_initrd() runs, initrd_start
+	 * Fixup the start address: after reserve_initrd() runs, virt_external_initramfs_start
 	 * has the virtual address of the beginning of the initrd. It also
-	 * possibly relocates the ramdisk. In either case, initrd_start contains
+	 * possibly relocates the ramdisk. In either case, virt_external_initramfs_start contains
 	 * the updated address so use that instead.
 	 */
-	if (initrd_start)
-		start = initrd_start;
+	if (virt_external_initramfs_start)
+		start = virt_external_initramfs_start;
 
 	return find_cpio_data(path, (void *)start, size, NULL);
 #else /* !CONFIG_BLK_DEV_INITRD */
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index e727c7a7f648..167b9ef12ebb 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -328,12 +328,12 @@ static void __init relocate_initrd(void)
 		panic("Cannot find place for new RAMDISK of size %lld\n",
 		      ramdisk_size);
 
-	initrd_start = relocated_ramdisk + PAGE_OFFSET;
-	initrd_end   = initrd_start + ramdisk_size;
+	virt_external_initramfs_start = relocated_ramdisk + PAGE_OFFSET;
+	virt_external_initramfs_end   = virt_external_initramfs_start + ramdisk_size;
 	printk(KERN_INFO "Allocated new RAMDISK: [mem %#010llx-%#010llx]\n",
 	       relocated_ramdisk, relocated_ramdisk + ramdisk_size - 1);
 
-	ret = copy_from_early_mem((void *)initrd_start, ramdisk_image, ramdisk_size);
+	ret = copy_from_early_mem((void *)virt_external_initramfs_start, ramdisk_image, ramdisk_size);
 	if (ret)
 		panic("Copy RAMDISK failed\n");
 
@@ -368,7 +368,7 @@ static void __init reserve_initrd(void)
 	    !ramdisk_image || !ramdisk_size)
 		return;		/* No initrd provided by bootloader */
 
-	initrd_start = 0;
+	virt_external_initramfs_start = 0;
 
 	printk(KERN_INFO "RAMDISK: [mem %#010llx-%#010llx]\n", ramdisk_image,
 			ramdisk_end - 1);
@@ -376,8 +376,8 @@ static void __init reserve_initrd(void)
 	if (pfn_range_is_mapped(PFN_DOWN(ramdisk_image),
 				PFN_DOWN(ramdisk_end))) {
 		/* All are mapped, easy case */
-		initrd_start = ramdisk_image + PAGE_OFFSET;
-		initrd_end = initrd_start + ramdisk_size;
+		virt_external_initramfs_start = ramdisk_image + PAGE_OFFSET;
+		virt_external_initramfs_end = virt_external_initramfs_start + ramdisk_size;
 		return;
 	}
 
diff --git a/arch/xtensa/kernel/setup.c b/arch/xtensa/kernel/setup.c
index f72e280363be..2e9003be3e8c 100644
--- a/arch/xtensa/kernel/setup.c
+++ b/arch/xtensa/kernel/setup.c
@@ -49,8 +49,8 @@
 #include <asm/traps.h>
 
 #ifdef CONFIG_BLK_DEV_INITRD
-extern unsigned long initrd_start;
-extern unsigned long initrd_end;
+extern unsigned long virt_external_initramfs_start;
+extern unsigned long virt_external_initramfs_end;
 extern int initrd_below_start_ok;
 #endif
 
@@ -106,8 +106,8 @@ static int __init parse_tag_initrd(const bp_tag_t* tag)
 {
 	struct bp_meminfo *mi = (struct bp_meminfo *)(tag->data);
 
-	initrd_start = (unsigned long)__va(mi->start);
-	initrd_end = (unsigned long)__va(mi->end);
+	virt_external_initramfs_start = (unsigned long)__va(mi->start);
+	virt_external_initramfs_end = (unsigned long)__va(mi->end);
 
 	return 0;
 }
@@ -290,11 +290,11 @@ void __init setup_arch(char **cmdline_p)
 	/* Reserve some memory regions */
 
 #ifdef CONFIG_BLK_DEV_INITRD
-	if (initrd_start < initrd_end &&
-	    !mem_reserve(__pa(initrd_start), __pa(initrd_end)))
+	if (virt_external_initramfs_start < virt_external_initramfs_end &&
+	    !mem_reserve(__pa(virt_external_initramfs_start), __pa(virt_external_initramfs_end)))
 		initrd_below_start_ok = 1;
 	else
-		initrd_start = 0;
+		virt_external_initramfs_start = 0;
 #endif
 
 	mem_reserve(__pa(_stext), __pa(_end));
diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index 3160cb7dca00..37ad99c10ac4 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -432,8 +432,8 @@ void __init acpi_table_upgrade(void)
 		data = __builtin_initramfs_start;
 		size = __builtin_initramfs_size;
 	} else {
-		data = (void *)initrd_start;
-		size = initrd_end - initrd_start;
+		data = (void *)virt_external_initramfs_start;
+		size = virt_external_initramfs_end - virt_external_initramfs_start;
 	}
 
 	if (data == NULL || size == 0)
diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 9c4c9be948c5..baf8347e0314 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -765,8 +765,8 @@ static void __early_init_dt_declare_initrd(unsigned long start,
 	 */
 	if (!IS_ENABLED(CONFIG_ARM64) &&
 	    !(IS_ENABLED(CONFIG_RISCV) && IS_ENABLED(CONFIG_64BIT))) {
-		initrd_start = (unsigned long)__va(start);
-		initrd_end = (unsigned long)__va(end);
+		virt_external_initramfs_start = (unsigned long)__va(start);
+		virt_external_initramfs_end = (unsigned long)__va(end);
 		initrd_below_start_ok = 1;
 	}
 }
diff --git a/include/linux/initrd.h b/include/linux/initrd.h
index 23c08e88234c..f19efebe8221 100644
--- a/include/linux/initrd.h
+++ b/include/linux/initrd.h
@@ -3,10 +3,10 @@
 #ifndef __LINUX_INITRD_H
 #define __LINUX_INITRD_H
 
-/* 1 if it is not an error if initrd_start < memory_start */
+/* 1 if it is not an error if virt_external_initramfs_start < memory_start */
 extern int initrd_below_start_ok;
 
-extern unsigned long initrd_start, initrd_end;
+extern unsigned long virt_external_initramfs_start, virt_external_initramfs_end;
 extern void free_initrd_mem(unsigned long, unsigned long);
 
 #ifdef CONFIG_BLK_DEV_INITRD
diff --git a/init/do_mounts_initrd.c b/init/do_mounts_initrd.c
index 06be76aa602c..8bdeb205a0cd 100644
--- a/init/do_mounts_initrd.c
+++ b/init/do_mounts_initrd.c
@@ -12,7 +12,7 @@
 
 #include "do_mounts.h"
 
-unsigned long initrd_start, initrd_end;
+unsigned long virt_external_initramfs_start, virt_external_initramfs_end;
 int initrd_below_start_ok;
 
 static int __init early_initrdmem(char *p)
diff --git a/init/initramfs.c b/init/initramfs.c
index 5242d851e839..9a221c713c60 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -611,7 +611,7 @@ void __init reserve_initrd_mem(void)
 	unsigned long size;
 
 	/* Ignore the virtul address computed during device tree parsing */
-	initrd_start = initrd_end = 0;
+	virt_external_initramfs_start = virt_external_initramfs_end = 0;
 
 	if (!phys_external_initramfs_size)
 		return;
@@ -639,15 +639,15 @@ void __init reserve_initrd_mem(void)
 
 	memblock_reserve(start, size);
 	/* Now convert initrd to virtual addresses */
-	initrd_start = (unsigned long)__va(phys_external_initramfs_start);
-	initrd_end = initrd_start + phys_external_initramfs_size;
+	virt_external_initramfs_start = (unsigned long)__va(phys_external_initramfs_start);
+	virt_external_initramfs_end = virt_external_initramfs_start + phys_external_initramfs_size;
 	initrd_below_start_ok = 1;
 
 	return;
 disable:
 	pr_cont(" - disabling initrd\n");
-	initrd_start = 0;
-	initrd_end = 0;
+	virt_external_initramfs_start = 0;
+	virt_external_initramfs_end = 0;
 }
 
 void __weak __init free_initrd_mem(unsigned long start, unsigned long end)
@@ -673,17 +673,17 @@ static bool __init kexec_free_initrd(void)
 	 * If the initrd region is overlapped with crashkernel reserved region,
 	 * free only memory that is not part of crashkernel region.
 	 */
-	if (initrd_start >= crashk_end || initrd_end <= crashk_start)
+	if (virt_external_initramfs_start >= crashk_end || virt_external_initramfs_end <= crashk_start)
 		return false;
 
 	/*
 	 * Initialize initrd memory region since the kexec boot does not do.
 	 */
-	memset((void *)initrd_start, 0, initrd_end - initrd_start);
-	if (initrd_start < crashk_start)
-		free_initrd_mem(initrd_start, crashk_start);
-	if (initrd_end > crashk_end)
-		free_initrd_mem(crashk_end, initrd_end);
+	memset((void *)virt_external_initramfs_start, 0, virt_external_initramfs_end - virt_external_initramfs_start);
+	if (virt_external_initramfs_start < crashk_start)
+		free_initrd_mem(virt_external_initramfs_start, crashk_start);
+	if (virt_external_initramfs_end > crashk_end)
+		free_initrd_mem(crashk_end, virt_external_initramfs_end);
 	return true;
 }
 #else
@@ -700,12 +700,12 @@ static void __init do_populate_rootfs(void *unused, async_cookie_t cookie)
 	if (err)
 		panic_show_mem("%s", err); /* Failed to decompress INTERNAL initramfs */
 
-	if (!initrd_start || IS_ENABLED(CONFIG_INITRAMFS_FORCE))
+	if (!virt_external_initramfs_start || IS_ENABLED(CONFIG_INITRAMFS_FORCE))
 		goto done;
 
 	printk(KERN_INFO "Unpacking initramfs...\n");
 
-	err = unpack_to_rootfs((char *)initrd_start, initrd_end - initrd_start);
+	err = unpack_to_rootfs((char *)virt_external_initramfs_start, virt_external_initramfs_end - virt_external_initramfs_start);
 	if (err) {
 		printk(KERN_EMERG "Initramfs unpacking failed: %s\n", err);
 	}
@@ -717,16 +717,16 @@ static void __init do_populate_rootfs(void *unused, async_cookie_t cookie)
 	 * If the initrd region is overlapped with crashkernel reserved region,
 	 * free only memory that is not part of crashkernel region.
 	 */
-	if (!do_retain_initrd && initrd_start && !kexec_free_initrd()) {
-		free_initrd_mem(initrd_start, initrd_end);
-	} else if (do_retain_initrd && initrd_start) {
-		bin_attr_initrd.size = initrd_end - initrd_start;
-		bin_attr_initrd.private = (void *)initrd_start;
+	if (!do_retain_initrd && virt_external_initramfs_start && !kexec_free_initrd()) {
+		free_initrd_mem(virt_external_initramfs_start, virt_external_initramfs_end);
+	} else if (do_retain_initrd && virt_external_initramfs_start) {
+		bin_attr_initrd.size = virt_external_initramfs_end - virt_external_initramfs_start;
+		bin_attr_initrd.private = (void *)virt_external_initramfs_start;
 		if (sysfs_create_bin_file(firmware_kobj, &bin_attr_initrd))
 			pr_err("Failed to create initrd sysfs file");
 	}
-	initrd_start = 0;
-	initrd_end = 0;
+	virt_external_initramfs_start = 0;
+	virt_external_initramfs_end = 0;
 
 	init_flush_fput();
 }
diff --git a/init/main.c b/init/main.c
index 0ee0ee7b7c2c..5f4d860ab72a 100644
--- a/init/main.c
+++ b/init/main.c
@@ -271,10 +271,10 @@ static void * __init get_boot_config_from_initrd(size_t *_size)
 	u32 *hdr;
 	int i;
 
-	if (!initrd_end)
+	if (!virt_external_initramfs_end)
 		return NULL;
 
-	data = (char *)initrd_end - BOOTCONFIG_MAGIC_LEN;
+	data = (char *)virt_external_initramfs_end - BOOTCONFIG_MAGIC_LEN;
 	/*
 	 * Since Grub may align the size of initrd to 4, we must
 	 * check the preceding 3 bytes as well.
@@ -292,9 +292,9 @@ static void * __init get_boot_config_from_initrd(size_t *_size)
 	csum = le32_to_cpu(hdr[1]);
 
 	data = ((void *)hdr) - size;
-	if ((unsigned long)data < initrd_start) {
+	if ((unsigned long)data < virt_external_initramfs_start) {
 		pr_err("bootconfig size %d is greater than initrd size %ld\n",
-			size, initrd_end - initrd_start);
+			size, virt_external_initramfs_end - virt_external_initramfs_start);
 		return NULL;
 	}
 
@@ -304,7 +304,7 @@ static void * __init get_boot_config_from_initrd(size_t *_size)
 	}
 
 	/* Remove bootconfig from initramfs/initrd */
-	initrd_end = (unsigned long)data;
+	virt_external_initramfs_end = (unsigned long)data;
 	if (_size)
 		*_size = size;
 
@@ -1047,12 +1047,12 @@ void start_kernel(void)
 	locking_selftest();
 
 #ifdef CONFIG_BLK_DEV_INITRD
-	if (initrd_start && !initrd_below_start_ok &&
-	    page_to_pfn(virt_to_page((void *)initrd_start)) < min_low_pfn) {
+	if (virt_external_initramfs_start && !initrd_below_start_ok &&
+	    page_to_pfn(virt_to_page((void *)virt_external_initramfs_start)) < min_low_pfn) {
 		pr_crit("initrd overwritten (0x%08lx < 0x%08lx) - disabling it.\n",
-		    page_to_pfn(virt_to_page((void *)initrd_start)),
+		    page_to_pfn(virt_to_page((void *)virt_external_initramfs_start)),
 		    min_low_pfn);
-		initrd_start = 0;
+		virt_external_initramfs_start = 0;
 	}
 #endif
 	setup_per_cpu_pageset();
-- 
2.47.2


