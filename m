Return-Path: <linux-fsdevel+bounces-54613-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95FDAB019C9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 12:29:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59A393A33AC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 10:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15542283CB0;
	Fri, 11 Jul 2025 10:29:46 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A92481C84D9;
	Fri, 11 Jul 2025 10:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752229785; cv=none; b=NgjVVvsTXreOPF68R0oovFEYFU6dFZ03z5Kv80sGowtFRTg3hTk6mVsxV9F9DKJR1Ejr3pU5DQ7Pdff4W9pB1ll16CWIPlN6458WGPDq6JvKUNKujiwDhTmULesK+H22cLM3Tc83+vpwjBEetKp7cF0wkN61+7Q7QtHIlCHzDww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752229785; c=relaxed/simple;
	bh=nzBByqRPRCsMsrvtXex+8bHjnmxE6PYCfebpjrSUVg0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EG3xly/D6UmGiB1C1HR2t02/pQ5NrHcYhjmiFBOeL26Sa5EPVF45cK5P2FDVuEuuNep11bQv8qH52n3PCAP2xYf3a97BK96zCnO4zbOY5J9LsCsTcbPRE5+ULmKvjDBevfkLCpRJFxRX4H8q5i9X7k18Yao44kxUrXKzhlbpHNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4ED8616F2;
	Fri, 11 Jul 2025 03:29:32 -0700 (PDT)
Received: from a076716.blr.arm.com (a076716.blr.arm.com [10.164.21.47])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E8BD73F738;
	Fri, 11 Jul 2025 03:29:39 -0700 (PDT)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-mm@kvack.org,
	akpm@linux-foundation.org
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	"David S. Miller" <davem@davemloft.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	x86@kernel.org,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH] fs/Kconfig: Enable HUGETLBFS only if ARCH_SUPPORTS_HUGETLBFS
Date: Fri, 11 Jul 2025 15:59:34 +0530
Message-Id: <20250711102934.2399533-1-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable HUGETLBFS only when platform subscrbes via ARCH_SUPPORTS_HUGETLBFS.
Hence select ARCH_SUPPORTS_HUGETLBFS on existing x86 and sparc for their
continuing HUGETLBFS support. While here also just drop existing 'BROKEN'
dependency.

Cc: "David S. Miller" <davem@davemloft.net>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: x86@kernel.org
Cc: sparclinux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-mm@kvack.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/sparc/Kconfig | 1 +
 arch/x86/Kconfig   | 1 +
 fs/Kconfig         | 2 +-
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 0f88123925a4..68549eedfe6d 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -97,6 +97,7 @@ config SPARC64
 	select HAVE_ARCH_AUDITSYSCALL
 	select ARCH_SUPPORTS_ATOMIC_RMW
 	select ARCH_SUPPORTS_DEBUG_PAGEALLOC
+	select ARCH_SUPPORTS_HUGETLBFS
 	select HAVE_NMI
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select ARCH_USE_QUEUED_RWLOCKS
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 71019b3b54ea..9630e5e1336b 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -126,6 +126,7 @@ config X86
 	select ARCH_SUPPORTS_ACPI
 	select ARCH_SUPPORTS_ATOMIC_RMW
 	select ARCH_SUPPORTS_DEBUG_PAGEALLOC
+	select ARCH_SUPPORTS_HUGETLBFS
 	select ARCH_SUPPORTS_PAGE_TABLE_CHECK	if X86_64
 	select ARCH_SUPPORTS_NUMA_BALANCING	if X86_64
 	select ARCH_SUPPORTS_KMAP_LOCAL_FORCE_MAP	if NR_CPUS <= 4096
diff --git a/fs/Kconfig b/fs/Kconfig
index 44b6cdd36dc1..86a00a972442 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -256,7 +256,7 @@ config ARCH_SUPPORTS_HUGETLBFS
 
 menuconfig HUGETLBFS
 	bool "HugeTLB file system support"
-	depends on X86 || SPARC64 || ARCH_SUPPORTS_HUGETLBFS || BROKEN
+	depends on ARCH_SUPPORTS_HUGETLBFS
 	depends on (SYSFS || SYSCTL)
 	select MEMFD_CREATE
 	select PADATA if SMP
-- 
2.25.1


