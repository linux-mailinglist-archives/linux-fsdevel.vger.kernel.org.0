Return-Path: <linux-fsdevel+bounces-26771-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5832195B9AC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 17:13:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16898286DF3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 15:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CE691CCB53;
	Thu, 22 Aug 2024 15:12:57 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A497F1CCB4D;
	Thu, 22 Aug 2024 15:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724339576; cv=none; b=dOh5Nu4/AwOQgSKdBW9TivU4j8im0jv6a8vR0SxGVabjUJXLkx1dEar2+9wVjwxq2qyaqw1q/2sc2AbjRMCzblYHec9tq4YuhLrF8ijRguhwnwLm6KJxkPRenXBa6DHiCUGydktu/47LsB9fBz8VCGsn/2VPYFEMy8ktFyeTTec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724339576; c=relaxed/simple;
	bh=36jbklWViHxEkI9yGEewgF3mMMbuHF8HiNV0XHzXOGk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aCCDj5YoQFctkUg9YwKI3wMYTW3x4vAC9e9tq83ZKEnHOuZ+c48TeU5gZvGE7I7Ywsn5/UHv3+w5kMgG30IN+oAuDkLOT/wBOCL1Q3rK5vtfTNJoA3m1A40q5Q+S1LWUWBXhnVg8q9bSdH5P05SstGvRtibx1rB5bozd8osFMdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3AF6E1596;
	Thu, 22 Aug 2024 08:13:21 -0700 (PDT)
Received: from e124191.cambridge.arm.com (e124191.cambridge.arm.com [10.1.197.45])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1CD163F58B;
	Thu, 22 Aug 2024 08:12:50 -0700 (PDT)
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
Subject: [PATCH v5 21/30] arm64: enable POE and PIE to coexist
Date: Thu, 22 Aug 2024 16:11:04 +0100
Message-Id: <20240822151113.1479789-22-joey.gouly@arm.com>
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

Permission Indirection Extension and Permission Overlay Extension can be
enabled independently.

When PIE is disabled and POE is enabled, the permissions set by POR_EL0 will be
applied on top of the permissions set in the PTE.

When both PIE and POE are enabled, the permissions set by POR_EL0 will be
applied on top of the permissions set by the PIRE0_EL1 register.
However PIRE0_EL1 has encodings that specifically enable and disable the
overlay from applying.

For example:
	0001	Read, Overlay applied.
	1000	Read, Overlay not applied.

Switch to using the 'Overlay applied' encodings in PIRE0_EL1, so that PIE and
POE can coexist.

Signed-off-by: Joey Gouly <joey.gouly@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/include/asm/pgtable-prot.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git arch/arm64/include/asm/pgtable-prot.h arch/arm64/include/asm/pgtable-prot.h
index b11cfb9fdd37..2a11d0c10760 100644
--- arch/arm64/include/asm/pgtable-prot.h
+++ arch/arm64/include/asm/pgtable-prot.h
@@ -154,10 +154,10 @@ static inline bool __pure lpa2_is_enabled(void)
 
 #define PIE_E0	( \
 	PIRx_ELx_PERM(pte_pi_index(_PAGE_EXECONLY),      PIE_X_O) | \
-	PIRx_ELx_PERM(pte_pi_index(_PAGE_READONLY_EXEC), PIE_RX)  | \
-	PIRx_ELx_PERM(pte_pi_index(_PAGE_SHARED_EXEC),   PIE_RWX) | \
-	PIRx_ELx_PERM(pte_pi_index(_PAGE_READONLY),      PIE_R)   | \
-	PIRx_ELx_PERM(pte_pi_index(_PAGE_SHARED),        PIE_RW))
+	PIRx_ELx_PERM(pte_pi_index(_PAGE_READONLY_EXEC), PIE_RX_O)  | \
+	PIRx_ELx_PERM(pte_pi_index(_PAGE_SHARED_EXEC),   PIE_RWX_O) | \
+	PIRx_ELx_PERM(pte_pi_index(_PAGE_READONLY),      PIE_R_O)   | \
+	PIRx_ELx_PERM(pte_pi_index(_PAGE_SHARED),        PIE_RW_O))
 
 #define PIE_E1	( \
 	PIRx_ELx_PERM(pte_pi_index(_PAGE_EXECONLY),      PIE_NONE_O) | \
-- 
2.25.1


