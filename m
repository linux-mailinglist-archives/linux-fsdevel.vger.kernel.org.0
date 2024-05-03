Return-Path: <linux-fsdevel+bounces-18624-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 81C318BAD02
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 15:03:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2DA2B22761
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 13:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EE6815382B;
	Fri,  3 May 2024 13:02:40 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE6AD15382F
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 May 2024 13:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714741360; cv=none; b=p3Pt5E0KYs5+TZPP2s/XbbA0qiOodHgq21NcHd9YKRCtaCtqWATWi1VncMb1LPpqWoT616fgINY1yf03cxoDsxvxgbE97ZKdUvG+APYT19T2rNV47Glm5QtRjejSI3nW2faHJFnh7PdIeuoyRMqJxL3bAHtSCAkLu7The8UWyY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714741360; c=relaxed/simple;
	bh=PbgbqE/M8FHvpHDnxmceZ6k0ea5aW0fyPBh7vE6plRw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hZsXEi9HiJivU3Bi1hLGhGtdOHj5HEWSOcqU9Bl6/6ARClFJ0guKjqTjmdNdZfZWd5KNjHySGW2q+dOMXMVIU8M30/YPpncBuue3HQMyJhs2a1+GeDwJOdkw1kcAmB9NQ0RZ30nUG6yUDfJCCTSfgwu2ZwyYSk9H4iKJRfm0ht8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CAB99169C;
	Fri,  3 May 2024 06:03:03 -0700 (PDT)
Received: from e124191.cambridge.arm.com (e124191.cambridge.arm.com [10.1.197.45])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 797533F73F;
	Fri,  3 May 2024 06:02:35 -0700 (PDT)
From: Joey Gouly <joey.gouly@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: akpm@linux-foundation.org,
	aneesh.kumar@kernel.org,
	aneesh.kumar@linux.ibm.com,
	bp@alien8.de,
	broonie@kernel.org,
	catalin.marinas@arm.com,
	christophe.leroy@csgroup.eu,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	joey.gouly@arm.com,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org,
	maz@kernel.org,
	mingo@redhat.com,
	mpe@ellerman.id.au,
	naveen.n.rao@linux.ibm.com,
	npiggin@gmail.com,
	oliver.upton@linux.dev,
	shuah@kernel.org,
	szabolcs.nagy@arm.com,
	tglx@linutronix.de,
	will@kernel.org,
	x86@kernel.org,
	kvmarm@lists.linux.dev
Subject: [PATCH v4 13/29] arm64: convert protection key into vm_flags and pgprot values
Date: Fri,  3 May 2024 14:01:31 +0100
Message-Id: <20240503130147.1154804-14-joey.gouly@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240503130147.1154804-1-joey.gouly@arm.com>
References: <20240503130147.1154804-1-joey.gouly@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Modify arch_calc_vm_prot_bits() and vm_get_page_prot() such that the pkey
value is set in the vm_flags and then into the pgprot value.

Signed-off-by: Joey Gouly <joey.gouly@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
---
 arch/arm64/include/asm/mman.h | 8 +++++++-
 arch/arm64/mm/mmap.c          | 9 +++++++++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/mman.h b/arch/arm64/include/asm/mman.h
index 5966ee4a6154..ecb2d18dc4d7 100644
--- a/arch/arm64/include/asm/mman.h
+++ b/arch/arm64/include/asm/mman.h
@@ -7,7 +7,7 @@
 #include <uapi/asm/mman.h>
 
 static inline unsigned long arch_calc_vm_prot_bits(unsigned long prot,
-	unsigned long pkey __always_unused)
+	unsigned long pkey)
 {
 	unsigned long ret = 0;
 
@@ -17,6 +17,12 @@ static inline unsigned long arch_calc_vm_prot_bits(unsigned long prot,
 	if (system_supports_mte() && (prot & PROT_MTE))
 		ret |= VM_MTE;
 
+#if defined(CONFIG_ARCH_HAS_PKEYS)
+	ret |= pkey & 0x1 ? VM_PKEY_BIT0 : 0;
+	ret |= pkey & 0x2 ? VM_PKEY_BIT1 : 0;
+	ret |= pkey & 0x4 ? VM_PKEY_BIT2 : 0;
+#endif
+
 	return ret;
 }
 #define arch_calc_vm_prot_bits(prot, pkey) arch_calc_vm_prot_bits(prot, pkey)
diff --git a/arch/arm64/mm/mmap.c b/arch/arm64/mm/mmap.c
index 642bdf908b22..86eda6bc7893 100644
--- a/arch/arm64/mm/mmap.c
+++ b/arch/arm64/mm/mmap.c
@@ -102,6 +102,15 @@ pgprot_t vm_get_page_prot(unsigned long vm_flags)
 	if (vm_flags & VM_MTE)
 		prot |= PTE_ATTRINDX(MT_NORMAL_TAGGED);
 
+#ifdef CONFIG_ARCH_HAS_PKEYS
+	if (vm_flags & VM_PKEY_BIT0)
+		prot |= PTE_PO_IDX_0;
+	if (vm_flags & VM_PKEY_BIT1)
+		prot |= PTE_PO_IDX_1;
+	if (vm_flags & VM_PKEY_BIT2)
+		prot |= PTE_PO_IDX_2;
+#endif
+
 	return __pgprot(prot);
 }
 EXPORT_SYMBOL(vm_get_page_prot);
-- 
2.25.1


