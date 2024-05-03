Return-Path: <linux-fsdevel+bounces-18631-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 615588BAD09
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 15:03:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9039A1C219AA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 13:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 063CF153BE7;
	Fri,  3 May 2024 13:03:04 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BE39153835
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 May 2024 13:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714741383; cv=none; b=uSR+w5aG0q5jmbK72AYxZwXUoyc7jrHbmGLUtyfn4Iz1iqg7e/vehyM2lfucLPhDvdHwRATGz/RZPnpFWVv1LmcVPGc5nGTiGne3wj5E164GR71AikAGSJO1RjyKx8B4QfZptYL2x2zCJ3Tx2DGgH8K2lDuO+RaZZkJTuQvMXmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714741383; c=relaxed/simple;
	bh=ZpE14skV26Sx1XGSYYYs/T9Uy2wINBvFiZ+1ezD8Bb0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pr3spara/UFQOg3SkHFCoNaauVEjHNil6qXhDv/8X7WwNkenUyZH2uSl7xFnTi3dnC/vTzzEwqh3C+HLXWJ6YgHCq2EoWTY06Rc/SJtFfuqwhMLzRtNL724KSbfwNbdRUV5yoz9XznDB5H/N9JQ9ckYmcBDNMttK5+QuMfs1VHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2499E1758;
	Fri,  3 May 2024 06:03:27 -0700 (PDT)
Received: from e124191.cambridge.arm.com (e124191.cambridge.arm.com [10.1.197.45])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C7F013F73F;
	Fri,  3 May 2024 06:02:58 -0700 (PDT)
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
Subject: [PATCH v4 20/29] arm64: enable POE and PIE to coexist
Date: Fri,  3 May 2024 14:01:38 +0100
Message-Id: <20240503130147.1154804-21-joey.gouly@arm.com>
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

Set the EL0/userspace indirection encodings to be the overlay enabled
variants of the permissions.

Signed-off-by: Joey Gouly <joey.gouly@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
---
 arch/arm64/include/asm/pgtable-prot.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable-prot.h b/arch/arm64/include/asm/pgtable-prot.h
index dd9ee67d1d87..4f9f85437d3d 100644
--- a/arch/arm64/include/asm/pgtable-prot.h
+++ b/arch/arm64/include/asm/pgtable-prot.h
@@ -147,10 +147,10 @@ static inline bool __pure lpa2_is_enabled(void)
 
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


