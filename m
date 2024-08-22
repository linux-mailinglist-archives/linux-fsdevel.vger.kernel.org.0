Return-Path: <linux-fsdevel+bounces-26758-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B3395B97A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 17:12:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E8FA284508
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 15:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D65541CC8AA;
	Thu, 22 Aug 2024 15:12:00 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 322A41C9EBB;
	Thu, 22 Aug 2024 15:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724339520; cv=none; b=ZLx3QlraKZCItR7hOKolpUxa2eaZK55IdNqgFJ9Cn2IrEEJBBzRGsK5nKKU3E01TJM3zvliqrc2ejUciYIUSQypXJPvjN5EohMrcyjQ6gJNQHyrgKyPBzaa2GVF+Zqfv623T0L+0uWNSMsSJORXHQsmZRIh3njvyGpvDC+r+E20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724339520; c=relaxed/simple;
	bh=SljGn0BhDOHRA1J1myxu6JFj8lk6yJGkb8iCq37gEh8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TQTScGHgrGJ1KyeXeP6HL78GSucl56/4lyjdKIHy/QwHA9Rb6OfW+64TBesNX3bT5ujbjqXajHhYQCFlVvYFYl8bOp7Knw3zgwfinKFqTxBOBmZ/wIdNDitu8hpM2IBvru+O+ABCojLxRra2fHP7KnYUlpj71z9lk3u4yU9NONk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E3E751650;
	Thu, 22 Aug 2024 08:12:24 -0700 (PDT)
Received: from e124191.cambridge.arm.com (e124191.cambridge.arm.com [10.1.197.45])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C53D43F58B;
	Thu, 22 Aug 2024 08:11:54 -0700 (PDT)
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
Subject: [PATCH v5 08/30] KVM: arm64: make kvm_at() take an OP_AT_*
Date: Thu, 22 Aug 2024 16:10:51 +0100
Message-Id: <20240822151113.1479789-9-joey.gouly@arm.com>
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

To allow using newer instructions that current assemblers don't know about,
replace the `at` instruction with the underlying SYS instruction.

Signed-off-by: Joey Gouly <joey.gouly@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Oliver Upton <oliver.upton@linux.dev>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Reviewed-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/include/asm/kvm_asm.h       | 3 ++-
 arch/arm64/kvm/hyp/include/hyp/fault.h | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git arch/arm64/include/asm/kvm_asm.h arch/arm64/include/asm/kvm_asm.h
index 2181a11b9d92..38d7bfa3966a 100644
--- arch/arm64/include/asm/kvm_asm.h
+++ arch/arm64/include/asm/kvm_asm.h
@@ -9,6 +9,7 @@
 
 #include <asm/hyp_image.h>
 #include <asm/insn.h>
+#include <asm/sysreg.h>
 #include <asm/virt.h>
 
 #define ARM_EXIT_WITH_SERROR_BIT  31
@@ -259,7 +260,7 @@ extern u64 __kvm_get_mdcr_el2(void);
 	asm volatile(							\
 	"	mrs	%1, spsr_el2\n"					\
 	"	mrs	%2, elr_el2\n"					\
-	"1:	at	"at_op", %3\n"					\
+	"1:	" __msr_s(at_op, "%3") "\n"				\
 	"	isb\n"							\
 	"	b	9f\n"						\
 	"2:	msr	spsr_el2, %1\n"					\
diff --git arch/arm64/kvm/hyp/include/hyp/fault.h arch/arm64/kvm/hyp/include/hyp/fault.h
index 9e13c1bc2ad5..487c06099d6f 100644
--- arch/arm64/kvm/hyp/include/hyp/fault.h
+++ arch/arm64/kvm/hyp/include/hyp/fault.h
@@ -27,7 +27,7 @@ static inline bool __translate_far_to_hpfar(u64 far, u64 *hpfar)
 	 * saved the guest context yet, and we may return early...
 	 */
 	par = read_sysreg_par();
-	if (!__kvm_at("s1e1r", far))
+	if (!__kvm_at(OP_AT_S1E1R, far))
 		tmp = read_sysreg_par();
 	else
 		tmp = SYS_PAR_EL1_F; /* back to the guest */
-- 
2.25.1


