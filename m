Return-Path: <linux-fsdevel+bounces-24762-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6071944C20
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 15:02:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BE191F21B36
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 13:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7CC41A71E1;
	Thu,  1 Aug 2024 12:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dyQayV0f"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31BA91A721D;
	Thu,  1 Aug 2024 12:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722517129; cv=none; b=pXvD64hBDa2Xz7mQxz/LwpNmTXVPf+fSyoIFgiQZ71sJd8+FrDGCGgen1/MWOXoDy1X//EQ0EvPIE1l4GtMqHXMJjW8lHVobi0U0JQLdS9SQUCDIULhHSvOacdHu1IMbTXz1Trzu99XmDPTlNJAMdnGFnNk58dj9uAm+ib25ZI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722517129; c=relaxed/simple;
	bh=iKC2Iasck77jV+Uk+oAXshC4xI2+EzWFpjmjkamUboo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OPf6moYe9zX/WRfXG1Ke4wwjHfebFfVrwtzBV/m/GcOx+y9sRq2FuNrBH0e29jxeTbAIFUlqSA07ojm4mY3Wa4lTpoPr3JAbhEd97rnz5J/uU8/EgQ+y37Vekoq9nHWol9Z/V2JmvsUCSfDSG73y4nAyRDscy4HD3WiSRGRStVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dyQayV0f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CF41C4AF0B;
	Thu,  1 Aug 2024 12:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722517128;
	bh=iKC2Iasck77jV+Uk+oAXshC4xI2+EzWFpjmjkamUboo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=dyQayV0fQPSZH8iBt3r920gWMR8PRqUKHxVxDgPQjyeJut555M3l4cDwsz+/L5qQS
	 As1Fxhi/6bCXuwjr9NdjvBX6wDqf/Fxi3a8wGAE/qWUiZL5LYBhtTcPbxCWz/QML29
	 60npbjduYtAn0JzFHAUE8zwm6Q1kOxEoiKce7sC4wvjTflnDQ0DF9MalXGTrLYgS8F
	 gXhhRz+nBXf6sqzaCfAlsMkL7do3RzBVthp97yDax4qvCcZ3OHQ8g2VY2PSqMAZLNd
	 IxRDzjVoRVEX+F42dHQhDdgLvph86KDdI1LnkW1mniZkz3+zak2yx9Ro6Xt7xlGQRb
	 XzXuKvipxoNHQ==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 01 Aug 2024 13:06:40 +0100
Subject: [PATCH v10 13/40] arm64/mm: Map pages for guarded control stack
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240801-arm64-gcs-v10-13-699e2bd2190b@kernel.org>
References: <20240801-arm64-gcs-v10-0-699e2bd2190b@kernel.org>
In-Reply-To: <20240801-arm64-gcs-v10-0-699e2bd2190b@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Andrew Morton <akpm@linux-foundation.org>, Marc Zyngier <maz@kernel.org>, 
 Oliver Upton <oliver.upton@linux.dev>, James Morse <james.morse@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Arnd Bergmann <arnd@arndb.de>, 
 Oleg Nesterov <oleg@redhat.com>, Eric Biederman <ebiederm@xmission.com>, 
 Shuah Khan <shuah@kernel.org>, 
 "Rick P. Edgecombe" <rick.p.edgecombe@intel.com>, 
 Deepak Gupta <debug@rivosinc.com>, Ard Biesheuvel <ardb@kernel.org>, 
 Szabolcs Nagy <Szabolcs.Nagy@arm.com>, Kees Cook <kees@kernel.org>
Cc: "H.J. Lu" <hjl.tools@gmail.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Florian Weimer <fweimer@redhat.com>, Christian Brauner <brauner@kernel.org>, 
 Thiago Jung Bauermann <thiago.bauermann@linaro.org>, 
 Ross Burton <ross.burton@arm.com>, linux-arm-kernel@lists.infradead.org, 
 linux-doc@vger.kernel.org, kvmarm@lists.linux.dev, 
 linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=openpgp-sha256; l=1838; i=broonie@kernel.org;
 h=from:subject:message-id; bh=iKC2Iasck77jV+Uk+oAXshC4xI2+EzWFpjmjkamUboo=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBmq4YQi3D2wTTUJjuQQY3F7F1CBBVgw8rRNdzwjqNE
 tB9JpyaJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZquGEAAKCRAk1otyXVSH0LglB/
 9TWv0MHUp/MwJEjSWgKUaa9AI9T9ei3Yo/iBGwhTkm2lo8TZTWMdtH0ztI+7/sV7Bv2+cOXKDxO8Wn
 xdLbDBsr/gw3zkkssfqjmj3brMAAxPZsleH+Lznr+NV+/0NRHmSZxbVAVa0JsJVu2db+gWre42Wu2T
 lPKPmT9WC8gLVXsjaY6dzYqMNV662wcZ41nyv8oPea28bIjpwZZNSJspMdUGqpSQdGnjZp/yxu68w5
 Y//Qbhz9rxsr1xOKKwh14tKc+nbFMdl2zKPVWbv5yGUS5EZEVUxqENG9eNNKup/HT0n8dZcq3Yep9V
 Z6RDFNJfx4fCy4UAAQiNxjCf+kO5rX
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Map pages flagged as being part of a GCS as such rather than using the
full set of generic VM flags.

This is done using a conditional rather than extending the size of
protection_map since that would make for a very sparse array.

Reviewed-by: Thiago Jung Bauermann <thiago.bauermann@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/mman.h |  9 +++++++++
 arch/arm64/mm/mmap.c          | 10 +++++++++-
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/mman.h b/arch/arm64/include/asm/mman.h
index c21849ffdd88..6d3fe6433a62 100644
--- a/arch/arm64/include/asm/mman.h
+++ b/arch/arm64/include/asm/mman.h
@@ -61,6 +61,15 @@ static inline bool arch_validate_flags(unsigned long vm_flags)
 			return false;
 	}
 
+	if (system_supports_gcs() && (vm_flags & VM_SHADOW_STACK)) {
+		/*
+		 * An executable GCS isn't a good idea, and the mm
+		 * core can't cope with a shared GCS.
+		 */
+		if (vm_flags & (VM_EXEC | VM_ARM64_BTI | VM_SHARED))
+			return false;
+	}
+
 	return true;
 
 }
diff --git a/arch/arm64/mm/mmap.c b/arch/arm64/mm/mmap.c
index 642bdf908b22..3ed63fc8cd0a 100644
--- a/arch/arm64/mm/mmap.c
+++ b/arch/arm64/mm/mmap.c
@@ -83,9 +83,17 @@ arch_initcall(adjust_protection_map);
 
 pgprot_t vm_get_page_prot(unsigned long vm_flags)
 {
-	pteval_t prot = pgprot_val(protection_map[vm_flags &
+	pteval_t prot;
+
+	/* Short circuit GCS to avoid bloating the table. */
+	if (system_supports_gcs() && (vm_flags & VM_SHADOW_STACK)) {
+		prot = _PAGE_GCS_RO;
+	} else {
+		prot = pgprot_val(protection_map[vm_flags &
 				   (VM_READ|VM_WRITE|VM_EXEC|VM_SHARED)]);
+	}
 
+	/* VM_ARM64_BTI on a GCS is rejected in arch_validate_flags() */
 	if (vm_flags & VM_ARM64_BTI)
 		prot |= PTE_GP;
 

-- 
2.39.2


