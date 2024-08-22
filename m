Return-Path: <linux-fsdevel+bounces-26764-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A80C395B997
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 17:13:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 527081F239EB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 15:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B48611CCED0;
	Thu, 22 Aug 2024 15:12:26 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CB921CC89F;
	Thu, 22 Aug 2024 15:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724339546; cv=none; b=MOZiPvLSeMR7+uV2WUeD2JeduTXDA/af6vzt3yVbwW7E0a7913pIcGDz3fyu+MvgVk9dtgdZE254oR8BQHXeII8d4806gGpK42HTdm/tWNDDsA+IMzJec2ZYKMO6cf1OxeZdf9IQheHMd1+kThqHJMaFIjlOlLJHHQ1viHrydO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724339546; c=relaxed/simple;
	bh=oxK4apeB6PctHJDE2KoEn3Z2oS0U4qEcHZJWMtXLdiU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XY5/8qx7alzTdISivb4ZLLhmdFPQyZSWlCfrLSl3bEV7OxJvtgZ3pR9xm6E6Fb4xrEuxGpE1+NqfBxmH+x5YJXimkYjPQWd0wdnJIUCf93BUIEek7Hsaw79Szag3HGeTMZQatuUdPtU8GE4XSwUVVMqqMrsNLBSWXYPghA8TUFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D16131655;
	Thu, 22 Aug 2024 08:12:50 -0700 (PDT)
Received: from e124191.cambridge.arm.com (e124191.cambridge.arm.com [10.1.197.45])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B2D423F58B;
	Thu, 22 Aug 2024 08:12:20 -0700 (PDT)
From: Joey Gouly <joey.gouly@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: nd@arm.com,
	akpm@linux-foundation.org,
	aneesh.kumar@kernel.org,
	aneesh.kumar@linux.ibm.com,
	anshuman.khandual@arm.com,
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
	skhan@linuxfoundation.org,
	szabolcs.nagy@arm.com,
	tglx@linutronix.de,
	will@kernel.org,
	x86@kernel.org,
	kvmarm@lists.linux.dev,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v5 14/30] arm64: convert protection key into vm_flags and pgprot values
Date: Thu, 22 Aug 2024 16:10:57 +0100
Message-Id: <20240822151113.1479789-15-joey.gouly@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240822151113.1479789-1-joey.gouly@arm.com>
References: <20240822151113.1479789-1-joey.gouly@arm.com>
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
 arch/arm64/include/asm/mman.h | 10 +++++++++-
 arch/arm64/mm/mmap.c          | 11 +++++++++++
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git arch/arm64/include/asm/mman.h arch/arm64/include/asm/mman.h
index 5966ee4a6154..52791715f6e6 100644
--- arch/arm64/include/asm/mman.h
+++ arch/arm64/include/asm/mman.h
@@ -7,7 +7,7 @@
 #include <uapi/asm/mman.h>
 
 static inline unsigned long arch_calc_vm_prot_bits(unsigned long prot,
-	unsigned long pkey __always_unused)
+	unsigned long pkey)
 {
 	unsigned long ret = 0;
 
@@ -17,6 +17,14 @@ static inline unsigned long arch_calc_vm_prot_bits(unsigned long prot,
 	if (system_supports_mte() && (prot & PROT_MTE))
 		ret |= VM_MTE;
 
+#ifdef CONFIG_ARCH_HAS_PKEYS
+	if (system_supports_poe()) {
+		ret |= pkey & BIT(0) ? VM_PKEY_BIT0 : 0;
+		ret |= pkey & BIT(1) ? VM_PKEY_BIT1 : 0;
+		ret |= pkey & BIT(2) ? VM_PKEY_BIT2 : 0;
+	}
+#endif
+
 	return ret;
 }
 #define arch_calc_vm_prot_bits(prot, pkey) arch_calc_vm_prot_bits(prot, pkey)
diff --git arch/arm64/mm/mmap.c arch/arm64/mm/mmap.c
index 642bdf908b22..7e3ad97e27d8 100644
--- arch/arm64/mm/mmap.c
+++ arch/arm64/mm/mmap.c
@@ -102,6 +102,17 @@ pgprot_t vm_get_page_prot(unsigned long vm_flags)
 	if (vm_flags & VM_MTE)
 		prot |= PTE_ATTRINDX(MT_NORMAL_TAGGED);
 
+#ifdef CONFIG_ARCH_HAS_PKEYS
+	if (system_supports_poe()) {
+		if (vm_flags & VM_PKEY_BIT0)
+			prot |= PTE_PO_IDX_0;
+		if (vm_flags & VM_PKEY_BIT1)
+			prot |= PTE_PO_IDX_1;
+		if (vm_flags & VM_PKEY_BIT2)
+			prot |= PTE_PO_IDX_2;
+	}
+#endif
+
 	return __pgprot(prot);
 }
 EXPORT_SYMBOL(vm_get_page_prot);
-- 
2.25.1


