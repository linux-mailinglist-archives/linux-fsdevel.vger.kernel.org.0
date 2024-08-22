Return-Path: <linux-fsdevel+bounces-26755-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E14C95B970
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 17:11:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12C151F2375F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 15:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D473B1CC896;
	Thu, 22 Aug 2024 15:11:47 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 367781CBE89;
	Thu, 22 Aug 2024 15:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724339507; cv=none; b=dZ4wxRAp35GfP6iGsgBMJtIUfY/bPU0kyRldjrSiI60jlG26KaX33F0yPD6Uf/hJwS13L6zlsPjcgltMOK9BcwpsNkyeKMkmYLAFO40lY8NFHVP/L4+U6xoF2ET5cQRzRPb0saXW53Sdv5lks8+rS4WboPWl0P/eAVPGJu9ystU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724339507; c=relaxed/simple;
	bh=jftbSQQ2E5oI/AUSO3gM+0/ad0wIoFqF/GqONyapJaQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TYJy8tPJdsO+ahrSSqT0pwBLmuh3eahMCHXOoazXjZQ2lzQqyOZMj6y398GJ6QfpG9BRdjG0IilF/0kkixx/IM6ThG8vN95QLG0ZAXOt+3IYiRCxw+6DkzEJZxh1kD0Vx98KHCnhYh9tvTT7lYt9Fdok8H/uXsXjf6EqNjZg8nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EE16915A1;
	Thu, 22 Aug 2024 08:12:11 -0700 (PDT)
Received: from e124191.cambridge.arm.com (e124191.cambridge.arm.com [10.1.197.45])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CF9E83F58B;
	Thu, 22 Aug 2024 08:11:41 -0700 (PDT)
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
Subject: [PATCH v5 05/30] arm64: cpufeature: add Permission Overlay Extension cpucap
Date: Thu, 22 Aug 2024 16:10:48 +0100
Message-Id: <20240822151113.1479789-6-joey.gouly@arm.com>
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

This indicates if the system supports POE. This is a CPUCAP_BOOT_CPU_FEATURE
as the boot CPU will enable POE if it has it, so secondary CPUs must also
have this feature.

Signed-off-by: Joey Gouly <joey.gouly@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/kernel/cpufeature.c | 9 +++++++++
 arch/arm64/tools/cpucaps       | 1 +
 2 files changed, 10 insertions(+)

diff --git arch/arm64/kernel/cpufeature.c arch/arm64/kernel/cpufeature.c
index 646ecd3069fd..2daf5597cd65 100644
--- arch/arm64/kernel/cpufeature.c
+++ arch/arm64/kernel/cpufeature.c
@@ -2870,6 +2870,15 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.matches = has_nv1,
 		ARM64_CPUID_FIELDS_NEG(ID_AA64MMFR4_EL1, E2H0, NI_NV1)
 	},
+#ifdef CONFIG_ARM64_POE
+	{
+		.desc = "Stage-1 Permission Overlay Extension (S1POE)",
+		.capability = ARM64_HAS_S1POE,
+		.type = ARM64_CPUCAP_BOOT_CPU_FEATURE,
+		.matches = has_cpuid_feature,
+		ARM64_CPUID_FIELDS(ID_AA64MMFR3_EL1, S1POE, IMP)
+	},
+#endif
 	{},
 };
 
diff --git arch/arm64/tools/cpucaps arch/arm64/tools/cpucaps
index ac3429d892b9..eedb5acc21ed 100644
--- arch/arm64/tools/cpucaps
+++ arch/arm64/tools/cpucaps
@@ -45,6 +45,7 @@ HAS_MOPS
 HAS_NESTED_VIRT
 HAS_PAN
 HAS_S1PIE
+HAS_S1POE
 HAS_RAS_EXTN
 HAS_RNG
 HAS_SB
-- 
2.25.1


