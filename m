Return-Path: <linux-fsdevel+bounces-1399-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CAA97D9F82
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 20:09:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD7791C210F2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 18:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F1CF3C082;
	Fri, 27 Oct 2023 18:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275A93C094
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Oct 2023 18:09:33 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4D81010A;
	Fri, 27 Oct 2023 11:09:31 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A1C3B153B;
	Fri, 27 Oct 2023 11:10:12 -0700 (PDT)
Received: from e124191.cambridge.arm.com (e124191.cambridge.arm.com [10.1.197.45])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D3E853F64C;
	Fri, 27 Oct 2023 11:09:28 -0700 (PDT)
From: Joey Gouly <joey.gouly@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: akpm@linux-foundation.org,
	aneesh.kumar@linux.ibm.com,
	broonie@kernel.org,
	catalin.marinas@arm.com,
	dave.hansen@linux.intel.com,
	joey.gouly@arm.com,
	maz@kernel.org,
	oliver.upton@linux.dev,
	shuah@kernel.org,
	will@kernel.org,
	kvmarm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>
Subject: [PATCH v2 11/24] arm64: enable ARCH_HAS_PKEYS on arm64
Date: Fri, 27 Oct 2023 19:08:37 +0100
Message-Id: <20231027180850.1068089-12-joey.gouly@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231027180850.1068089-1-joey.gouly@arm.com>
References: <20231027180850.1068089-1-joey.gouly@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable the ARCH_HAS_PKEYS config, but provide dummy
functions for the entire interface.

Signed-off-by: Joey Gouly <joey.gouly@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
---
 arch/arm64/Kconfig             |  2 ++
 arch/arm64/include/asm/pkeys.h | 54 ++++++++++++++++++++++++++++++++++
 arch/arm64/mm/mmu.c            |  7 +++++
 3 files changed, 63 insertions(+)
 create mode 100644 arch/arm64/include/asm/pkeys.h

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 1f1a12e28c3f..68cfcbd95c8e 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -2064,6 +2064,8 @@ menu "ARMv8.9 architectural features"
 config ARM64_POE
 	prompt "Permission Overlay Extension"
 	def_bool y
+	select ARCH_USES_HIGH_VMA_FLAGS
+	select ARCH_HAS_PKEYS
 	help
 	  The Permission Overlay Extension is used to implement Memory
 	  Protection Keys. Memory Protection Keys provides a mechanism for
diff --git a/arch/arm64/include/asm/pkeys.h b/arch/arm64/include/asm/pkeys.h
new file mode 100644
index 000000000000..5761fb48fd53
--- /dev/null
+++ b/arch/arm64/include/asm/pkeys.h
@@ -0,0 +1,54 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2023 Arm Ltd.
+ *
+ * Based on arch/x86/include/asm/pkeys.h
+*/
+
+#ifndef _ASM_ARM64_PKEYS_H
+#define _ASM_ARM64_PKEYS_H
+
+#define ARCH_VM_PKEY_FLAGS (VM_PKEY_BIT0 | VM_PKEY_BIT1 | VM_PKEY_BIT2)
+
+#define arch_max_pkey() 0
+
+int arch_set_user_pkey_access(struct task_struct *tsk, int pkey,
+		unsigned long init_val);
+
+static inline bool arch_pkeys_enabled(void)
+{
+	return false;
+}
+
+static inline int vma_pkey(struct vm_area_struct *vma)
+{
+	return -1;
+}
+
+static inline int arch_override_mprotect_pkey(struct vm_area_struct *vma,
+		int prot, int pkey)
+{
+	return -1;
+}
+
+static inline int execute_only_pkey(struct mm_struct *mm)
+{
+	return -1;
+}
+
+static inline bool mm_pkey_is_allocated(struct mm_struct *mm, int pkey)
+{
+	return false;
+}
+
+static inline int mm_pkey_alloc(struct mm_struct *mm)
+{
+	return -1;
+}
+
+static inline int mm_pkey_free(struct mm_struct *mm, int pkey)
+{
+	return -EINVAL;
+}
+
+#endif /* _ASM_ARM64_PKEYS_H */
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 47781bec6171..11765791b880 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -1487,3 +1487,10 @@ void ptep_modify_prot_commit(struct vm_area_struct *vma, unsigned long addr, pte
 {
 	set_pte_at(vma->vm_mm, addr, ptep, pte);
 }
+
+#ifdef CONFIG_ARCH_HAS_PKEYS
+int arch_set_user_pkey_access(struct task_struct *tsk, int pkey, unsigned long init_val)
+{
+	return -ENOSPC;
+}
+#endif
-- 
2.25.1


