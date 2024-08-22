Return-Path: <linux-fsdevel+bounces-26767-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15CE795B9A1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 17:13:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 445131C219DE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 15:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A8E1CCB2F;
	Thu, 22 Aug 2024 15:12:40 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19ADB1CCB25;
	Thu, 22 Aug 2024 15:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724339560; cv=none; b=odGTSRTu6vM9qMojGs4YeNWcQmZGXlmUw+zYATxyjs5ttrGSkjAbFCVTO33L8QLe+WjvHpVQkRmrL0MqMQXqs6hxzjB/B6IeG0OVLR2nkBotchp2LzQb6pIpDjN+lfWrZlUoOuFgVUR0ngO6xLSQArVcj0k5rc5g6xLtL2k4510=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724339560; c=relaxed/simple;
	bh=ikami3y/jqw/xyFi4Ssl3e7xl+pEF4hs6m+fVwXhjtA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=n4kf3NCr7kkllSgO31s0G+6UYsxSkf4eF0SOJy+ZX0xB7YNIETvNGR4nZ9ZJDzJuX2YZ0WfDI0aNZEmGCUwDE/8iTd5qoVercPMRRq2H6m4opVivTHPHHTdpDS8OPABvCqsMRcJ0ixaHEvEsphr0B0AQt9+HBTxav3qrXeh6MOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C8794DA7;
	Thu, 22 Aug 2024 08:13:03 -0700 (PDT)
Received: from e124191.cambridge.arm.com (e124191.cambridge.arm.com [10.1.197.45])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A9C703F58B;
	Thu, 22 Aug 2024 08:12:33 -0700 (PDT)
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
Subject: [PATCH v5 17/30] arm64: add pte_access_permitted_no_overlay()
Date: Thu, 22 Aug 2024 16:11:00 +0100
Message-Id: <20240822151113.1479789-18-joey.gouly@arm.com>
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

We do not want take POE into account when clearing the MTE tags.

Signed-off-by: Joey Gouly <joey.gouly@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/include/asm/pgtable.h | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git arch/arm64/include/asm/pgtable.h arch/arm64/include/asm/pgtable.h
index 1d0f18d30e1e..61a674942a6b 100644
--- arch/arm64/include/asm/pgtable.h
+++ arch/arm64/include/asm/pgtable.h
@@ -156,8 +156,10 @@ static inline pteval_t __phys_to_pte_val(phys_addr_t phys)
  * not set) must return false. PROT_NONE mappings do not have the
  * PTE_VALID bit set.
  */
-#define pte_access_permitted(pte, write) \
+#define pte_access_permitted_no_overlay(pte, write) \
 	(((pte_val(pte) & (PTE_VALID | PTE_USER)) == (PTE_VALID | PTE_USER)) && (!(write) || pte_write(pte)))
+#define pte_access_permitted(pte, write) \
+	pte_access_permitted_no_overlay(pte, write)
 #define pmd_access_permitted(pmd, write) \
 	(pte_access_permitted(pmd_pte(pmd), (write)))
 #define pud_access_permitted(pud, write) \
@@ -373,10 +375,11 @@ static inline void __sync_cache_and_tags(pte_t pte, unsigned int nr_pages)
 	/*
 	 * If the PTE would provide user space access to the tags associated
 	 * with it then ensure that the MTE tags are synchronised.  Although
-	 * pte_access_permitted() returns false for exec only mappings, they
-	 * don't expose tags (instruction fetches don't check tags).
+	 * pte_access_permitted_no_overlay() returns false for exec only
+	 * mappings, they don't expose tags (instruction fetches don't check
+	 * tags).
 	 */
-	if (system_supports_mte() && pte_access_permitted(pte, false) &&
+	if (system_supports_mte() && pte_access_permitted_no_overlay(pte, false) &&
 	    !pte_special(pte) && pte_tagged(pte))
 		mte_sync_tags(pte, nr_pages);
 }
-- 
2.25.1


