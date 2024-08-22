Return-Path: <linux-fsdevel+bounces-26763-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 88FA995B9E7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 17:17:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9FA2CB2BCA8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 15:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 620371CCED8;
	Thu, 22 Aug 2024 15:12:22 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2B161CCED0;
	Thu, 22 Aug 2024 15:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724339542; cv=none; b=CxuzWrAuluchAe6Y5PGVFSuSDOZiMquE7hVq0sgUOmeyCEtTtmX2ftpv8E96hdpNxa9tcsCZEZ8Vs3NPA1jHDO3nMMF0I4UHQuDNkXnTO63G4/6EU0q8/o1AIY0vh4VKxO2oBV/E3Vk5e1kSKN39qrAawov1Yfyl87WW5C/s/tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724339542; c=relaxed/simple;
	bh=d5EDjmoqzjrfByMJNskHdKnb1OZVMl/nmgNSyNFXk/A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bYku/DHM3h55tkSUMset6IQwmcGwB2fcldOD6izGKGIyQ3KsFJ/U9DPm9XAy6dMjcxQVeqk5MRzNOKU4vR+DMJzAlk7Cn4CCxZs09WboI2Opdyusdlh+dOFWRNEIxTphpuNG37geFJrA4F+/kp9revnlUUx99WNz2exQnhAOd/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 830E21596;
	Thu, 22 Aug 2024 08:12:46 -0700 (PDT)
Received: from e124191.cambridge.arm.com (e124191.cambridge.arm.com [10.1.197.45])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 64D793F58B;
	Thu, 22 Aug 2024 08:12:16 -0700 (PDT)
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
Subject: [PATCH v5 13/30] arm64: add POIndex defines
Date: Thu, 22 Aug 2024 16:10:56 +0100
Message-Id: <20240822151113.1479789-14-joey.gouly@arm.com>
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

The 3-bit POIndex is stored in the PTE at bits 60..62.

Signed-off-by: Joey Gouly <joey.gouly@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/include/asm/pgtable-hwdef.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git arch/arm64/include/asm/pgtable-hwdef.h arch/arm64/include/asm/pgtable-hwdef.h
index 1f60aa1bc750..3f0c3f5c5cef 100644
--- arch/arm64/include/asm/pgtable-hwdef.h
+++ arch/arm64/include/asm/pgtable-hwdef.h
@@ -199,6 +199,16 @@
 #define PTE_PI_IDX_2	53	/* PXN */
 #define PTE_PI_IDX_3	54	/* UXN */
 
+/*
+ * POIndex[2:0] encoding (Permission Overlay Extension)
+ */
+#define PTE_PO_IDX_0	(_AT(pteval_t, 1) << 60)
+#define PTE_PO_IDX_1	(_AT(pteval_t, 1) << 61)
+#define PTE_PO_IDX_2	(_AT(pteval_t, 1) << 62)
+
+#define PTE_PO_IDX_MASK		GENMASK_ULL(62, 60)
+
+
 /*
  * Memory Attribute override for Stage-2 (MemAttr[3:0])
  */
-- 
2.25.1


