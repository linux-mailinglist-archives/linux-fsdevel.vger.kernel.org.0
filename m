Return-Path: <linux-fsdevel+bounces-10157-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA9B8485B9
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Feb 2024 13:35:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2311F1F22B19
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Feb 2024 12:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9684362A1B;
	Sat,  3 Feb 2024 12:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cXOJ77sc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7DD15E5B5;
	Sat,  3 Feb 2024 12:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706963462; cv=none; b=nCrG6Vm0Ko9TjB+2IiIHI7X+dvT2Ei8ZFAkTTENIMuLtpv9rZaVAWmqj72mgdFBdZPpZCUVtgKnSkprVMo6eiTZOceEBxT6miW791YMmuJ+BLiZaK984C4wV6lfw0KOdfAA/f8c6xv4c2m4XtvZVfQ6Pd/Nm/uQg1cFZ6Q7afQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706963462; c=relaxed/simple;
	bh=s6bCn957vl7MWPN5faZZH74vr8xHhA9oW4MYYSSC+7I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J08+BL8Qg/G8JvQnD12caSqrxT+w7T51OxCQxJrXgEGzhw3L7Od9xNsDHSEENJZ9XQUSPJwM8JMYXAeAoEpsQAvBwkoiwcgUUrZiQXcHW7gRp8STAsLk1gDMkHIqtk/1RJRTK2Ga9ocXIAHJHYmHix25VaEMvY7UDduBaYgNksE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cXOJ77sc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F7B3C43390;
	Sat,  3 Feb 2024 12:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706963461;
	bh=s6bCn957vl7MWPN5faZZH74vr8xHhA9oW4MYYSSC+7I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=cXOJ77sc3cQAIYTgI4yLYEpIC37f03fcaibYvuInwn8di/O4yIt+bHnqL//pUPxDo
	 hYEsFtkP6kQ89PQKm8oK7Wa9WxYQxdLqg+otrN5iczV2csW4rN1aMx8vigCUbn8kDd
	 bmsybYB2hCWtaAxNkqcsA7w7EhpTS+iu98v+OGoXKYYdspFjQn6SR05CQaI5eZRZfT
	 4Yfc+cN/cWZF8hS+rJhDfqi8J7ujnzpTykA1gdfYbQTXJmJLh9EySsLIC7gaxOoXOc
	 Fc1D2QtP4kY4lu1FgkM5ScscVf9rbilxymkFNDtZTdM+1+0v+4XyIa1x9LC7C0S0sP
	 GlrafKo2iJ7Bg==
From: Mark Brown <broonie@kernel.org>
Date: Sat, 03 Feb 2024 12:25:38 +0000
Subject: [PATCH v8 12/38] arm64/mm: Map pages for guarded control stack
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240203-arm64-gcs-v8-12-c9fec77673ef@kernel.org>
References: <20240203-arm64-gcs-v8-0-c9fec77673ef@kernel.org>
In-Reply-To: <20240203-arm64-gcs-v8-0-c9fec77673ef@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Andrew Morton <akpm@linux-foundation.org>, Marc Zyngier <maz@kernel.org>, 
 Oliver Upton <oliver.upton@linux.dev>, James Morse <james.morse@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Arnd Bergmann <arnd@arndb.de>, 
 Oleg Nesterov <oleg@redhat.com>, Eric Biederman <ebiederm@xmission.com>, 
 Kees Cook <keescook@chromium.org>, Shuah Khan <shuah@kernel.org>, 
 "Rick P. Edgecombe" <rick.p.edgecombe@intel.com>, 
 Deepak Gupta <debug@rivosinc.com>, Ard Biesheuvel <ardb@kernel.org>, 
 Szabolcs Nagy <Szabolcs.Nagy@arm.com>
Cc: "H.J. Lu" <hjl.tools@gmail.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Florian Weimer <fweimer@redhat.com>, Christian Brauner <brauner@kernel.org>, 
 Thiago Jung Bauermann <thiago.bauermann@linaro.org>, 
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
 kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-mm@kvack.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-a684c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1837; i=broonie@kernel.org;
 h=from:subject:message-id; bh=s6bCn957vl7MWPN5faZZH74vr8xHhA9oW4MYYSSC+7I=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlvjDaHwr5wrOWEW/xel9E3S7jsHXGClztspo/AIxO
 WVUvGMiJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZb4w2gAKCRAk1otyXVSH0DmCB/
 95KF+JXdMxHAx9xnGeVA7yTyp0+fMAu3TeB7kS7DtuBsLE4OtsXKtaSYZVp0Hm5moimwKXZTN8sLaR
 TkcMryVwyRFPeF/KBSacACnQi7Bt9HFPmo9H0eBNRCZuAv9vxu1NFrua3FD7vN0xbAuzCYRC+d53+k
 61m3z2A9musH8F9maMwFmrdAW1+mROuXbvvK/LNIGA8xEkvqwNMm7hXoiXIRNdFzWTDBENITY28+dB
 RAddUPCMDR3nm/ogfYadyteOSUiumCbk85Ejb+ZT+4B6IyxeUQasBjqo+/eSMQVa6Ke6EvIKHHrOQY
 mUUz2tdyO/wb4T5iv2uYIYRZSrxs8I
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Map pages flagged as being part of a GCS as such rather than using the
full set of generic VM flags.

This is done using a conditional rather than extending the size of
protection_map since that would make for a very sparse array.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/mman.h |  9 +++++++++
 arch/arm64/mm/mmap.c          | 13 ++++++++++++-
 2 files changed, 21 insertions(+), 1 deletion(-)

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
index 645fe60d000f..e44ce6fcfad9 100644
--- a/arch/arm64/mm/mmap.c
+++ b/arch/arm64/mm/mmap.c
@@ -79,9 +79,20 @@ arch_initcall(adjust_protection_map);
 
 pgprot_t vm_get_page_prot(unsigned long vm_flags)
 {
-	pteval_t prot = pgprot_val(protection_map[vm_flags &
+	pteval_t prot;
+
+	/* If this is a GCS then only interpret VM_WRITE. */
+	if (system_supports_gcs() && (vm_flags & VM_SHADOW_STACK)) {
+		if (vm_flags & VM_WRITE)
+			prot = _PAGE_GCS;
+		else
+			prot = _PAGE_GCS_RO;
+	} else {
+		prot = pgprot_val(protection_map[vm_flags &
 				   (VM_READ|VM_WRITE|VM_EXEC|VM_SHARED)]);
+	}
 
+	/* VM_ARM64_BTI on a GCS is rejected in arch_validate_flags() */
 	if (vm_flags & VM_ARM64_BTI)
 		prot |= PTE_GP;
 

-- 
2.30.2


