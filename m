Return-Path: <linux-fsdevel+bounces-18627-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A72AD8BAD05
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 15:03:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2E84B22DE2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 13:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27E70152E17;
	Fri,  3 May 2024 13:02:51 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C916115381E
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 May 2024 13:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714741370; cv=none; b=Z6oqTQHUgiPt7aly7hBSdsCL5/o3vxpNbZ2nHzHSqF0WkFSv1PuozmC2nXWP6GYJhx5GxLmW70TxSviPMxwvpWf/JJLy23q7fkkS5uSjZMh1iaw3hFJ2zXJLOI+TYubUuDXtc52AI1tzTsW98+PiZOm4Zc7+NgBVvhvI6eFO+VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714741370; c=relaxed/simple;
	bh=5Gq4AOxEnwqxawnBzoFTTv6SA6kdFIGsOCIqOX2vtd4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pywOrFRO4o1ITJcOS7zUO17z766vqxfL6pMNMVScEV+8W3t7CkF6CeoQJ4/Ke308rGngP+QY5ON7MuWHUNY8rp6p/NaiH4N3A5yqHUzybqp5yVUXu76nv3RZyjXJzsZpX3CjY6T6vI4JQF/eknBXO+n1tFO3I8F31flmQliV0OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BE51016F3;
	Fri,  3 May 2024 06:03:13 -0700 (PDT)
Received: from e124191.cambridge.arm.com (e124191.cambridge.arm.com [10.1.197.45])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 69B1E3F73F;
	Fri,  3 May 2024 06:02:45 -0700 (PDT)
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
Subject: [PATCH v4 16/29] arm64: add pte_access_permitted_no_overlay()
Date: Fri,  3 May 2024 14:01:34 +0100
Message-Id: <20240503130147.1154804-17-joey.gouly@arm.com>
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

We do not want take POE into account when clearing the MTE tags.

Signed-off-by: Joey Gouly <joey.gouly@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
---
 arch/arm64/include/asm/pgtable.h | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 5c970a9cca67..2449e4e27ea6 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -160,8 +160,10 @@ static inline pteval_t __phys_to_pte_val(phys_addr_t phys)
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
@@ -348,10 +350,11 @@ static inline void __sync_cache_and_tags(pte_t pte, unsigned int nr_pages)
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


