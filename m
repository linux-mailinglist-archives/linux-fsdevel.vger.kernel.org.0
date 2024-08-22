Return-Path: <linux-fsdevel+bounces-26765-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E4F95B999
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 17:13:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE3E11F23279
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 15:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 197891CCEDD;
	Thu, 22 Aug 2024 15:12:31 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C5FE1CC89F;
	Thu, 22 Aug 2024 15:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724339550; cv=none; b=g3xgOSDDc75Xt3vWBRMlIMc9IvxsgooIGUCwQhNsevdBeb4NfTObCm1YOG3bOc7cvZzsZSqZwDmSNVn9D5I3LA31OmzSq4SDATAZQ8F+g2QG+6dMSgKan4JNjOa8XcubUGEBYeU8B0JNU01bqSuOIBD9tfzXbAom9Rmf3EWKoXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724339550; c=relaxed/simple;
	bh=/c3k4C1is0IuwG6677l57cmGkQeKR6l0P5ICqyBxdrQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VqkKkSGIk3yJBpOsaT2ofjskmFe5JR3237ZgB0ovuf886ODRizXGwfUEEPAXp3FQNMy/z/2ls5/f7SUqgtOyF9wo2RhnA67EokgLsZs+PNoopLAGGUB+8rxFRHL/NRnxbmKX8MZM2MH9SJYSS/SxWjnQxYw12DnQBsTknCBzq4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2BF8D165C;
	Thu, 22 Aug 2024 08:12:55 -0700 (PDT)
Received: from e124191.cambridge.arm.com (e124191.cambridge.arm.com [10.1.197.45])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0D3BE3F58B;
	Thu, 22 Aug 2024 08:12:24 -0700 (PDT)
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
Subject: [PATCH v5 15/30] arm64: mask out POIndex when modifying a PTE
Date: Thu, 22 Aug 2024 16:10:58 +0100
Message-Id: <20240822151113.1479789-16-joey.gouly@arm.com>
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

When a PTE is modified, the POIndex must be masked off so that it can be modified.

Signed-off-by: Joey Gouly <joey.gouly@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/include/asm/pgtable.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git arch/arm64/include/asm/pgtable.h arch/arm64/include/asm/pgtable.h
index 7a4f5604be3f..1d0f18d30e1e 100644
--- arch/arm64/include/asm/pgtable.h
+++ arch/arm64/include/asm/pgtable.h
@@ -1103,7 +1103,8 @@ static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 	 */
 	const pteval_t mask = PTE_USER | PTE_PXN | PTE_UXN | PTE_RDONLY |
 			      PTE_PRESENT_INVALID | PTE_VALID | PTE_WRITE |
-			      PTE_GP | PTE_ATTRINDX_MASK;
+			      PTE_GP | PTE_ATTRINDX_MASK | PTE_PO_IDX_MASK;
+
 	/* preserve the hardware dirty information */
 	if (pte_hw_dirty(pte))
 		pte = set_pte_bit(pte, __pgprot(PTE_DIRTY));
-- 
2.25.1


