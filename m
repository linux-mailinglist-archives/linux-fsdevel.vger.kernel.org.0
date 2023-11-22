Return-Path: <linux-fsdevel+bounces-3378-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FB6A7F4239
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 10:45:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90A471C209D5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 09:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9E4F56449;
	Wed, 22 Nov 2023 09:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hzQJt+Qj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B65154F9A;
	Wed, 22 Nov 2023 09:45:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11890C433C9;
	Wed, 22 Nov 2023 09:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700646299;
	bh=aU3xh1nd0j/0DloWdWCWjw7vV0cVDgM+Blqu3VdYPtQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hzQJt+QjotGyzdW5aJXId+R762os1ez45wKIR4uvXUTtbTXvvCKCEaxjLQyE5+11O
	 K/3A3ODSi956zsBNcLEf8f9eLMdYm4TfOH9+z7tMTrIVtOdP9B4+I+wuRvMERobQ0h
	 JUCP4jebtXbiUqppMsA8G+rhZvXVKolcxtB4XUuTV/t0oWGtgR4VblnkO4cK75mYwx
	 9qI5OOQOQdgWtzvzwMesWgtsn9CBkG0LqBT1uOptR+3dcOUP2In7IV76hwF2BkIhlS
	 3YE7/eFIr9cmqTmfXYxf0PZPbAKrclY8V1Irgn/qaq2Sr3mVtzvKuhhfqIj/o2sm81
	 2gp9m8bABLqRQ==
From: Mark Brown <broonie@kernel.org>
Date: Wed, 22 Nov 2023 09:42:27 +0000
Subject: [PATCH v7 17/39] arm64/hwcap: Add hwcap for GCS
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231122-arm64-gcs-v7-17-201c483bd775@kernel.org>
References: <20231122-arm64-gcs-v7-0-201c483bd775@kernel.org>
In-Reply-To: <20231122-arm64-gcs-v7-0-201c483bd775@kernel.org>
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
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=2995; i=broonie@kernel.org;
 h=from:subject:message-id; bh=aU3xh1nd0j/0DloWdWCWjw7vV0cVDgM+Blqu3VdYPtQ=;
 b=owGbwMvMwMWocq27KDak/QLjabUkhtTYs8yBxYdLZ52e+l5Oe09GrZNLak6ww3nOF9bCn5eUz
 FSfv86zk9GYhYGRi0FWTJFl7bOMVenhElvnP5r/CmYQKxPIFAYuTgGYiBcP+z8LRdmId5Olin8b
 5BuLuhe2H8zc9ODU6aXpE8zOPVi9ocN05a+2aUysdeZfqnTPtFgnF7PO8Qh455/rUsuYdEXCoWZ
 e5IkWn8z3tRp6xy/cEp5xxCrjXWG54XKjD0tzVhQL8U0tviwncOXjLeGMSaYXTx7ZMyv5ZSe/z9
 KE6susi0KynUof7X5r/u7qHfdQVpVtXS8614fxdCQcYuox5Nz0pPapaL5lp2gH9/Zn+zrrWY6+C
 l5S0Cl4egfbyxm98Wl8aS1hDzNipDcaelg8K3/9QGndFfevh306TfLYk3wcJffkljH++LlJwvkP
 m6kTi1VGgv/ioufK5joTf4rHJIo9vjD7mFjODZHj5Qq/AA==
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Provide a hwcap to enable userspace to detect support for GCS.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/arch/arm64/elf_hwcaps.rst | 3 +++
 arch/arm64/include/asm/hwcap.h          | 1 +
 arch/arm64/include/uapi/asm/hwcap.h     | 1 +
 arch/arm64/kernel/cpufeature.c          | 3 +++
 arch/arm64/kernel/cpuinfo.c             | 1 +
 5 files changed, 9 insertions(+)

diff --git a/Documentation/arch/arm64/elf_hwcaps.rst b/Documentation/arch/arm64/elf_hwcaps.rst
index ced7b335e2e0..86d4ace9c75c 100644
--- a/Documentation/arch/arm64/elf_hwcaps.rst
+++ b/Documentation/arch/arm64/elf_hwcaps.rst
@@ -317,6 +317,9 @@ HWCAP2_LRCPC3
 HWCAP2_LSE128
     Functionality implied by ID_AA64ISAR0_EL1.Atomic == 0b0011.
 
+HWCAP2_GCS
+    Functionality implied by ID_AA64PFR1_EL1.GCS == 0b1
+
 4. Unused AT_HWCAP bits
 -----------------------
 
diff --git a/arch/arm64/include/asm/hwcap.h b/arch/arm64/include/asm/hwcap.h
index cd71e09ea14d..e01e6b72a839 100644
--- a/arch/arm64/include/asm/hwcap.h
+++ b/arch/arm64/include/asm/hwcap.h
@@ -142,6 +142,7 @@
 #define KERNEL_HWCAP_SVE_B16B16		__khwcap2_feature(SVE_B16B16)
 #define KERNEL_HWCAP_LRCPC3		__khwcap2_feature(LRCPC3)
 #define KERNEL_HWCAP_LSE128		__khwcap2_feature(LSE128)
+#define KERNEL_HWCAP_GCS		__khwcap2_feature(GCS)
 
 /*
  * This yields a mask that user programs can use to figure out what
diff --git a/arch/arm64/include/uapi/asm/hwcap.h b/arch/arm64/include/uapi/asm/hwcap.h
index 5023599fa278..996b5b5d4c4e 100644
--- a/arch/arm64/include/uapi/asm/hwcap.h
+++ b/arch/arm64/include/uapi/asm/hwcap.h
@@ -107,5 +107,6 @@
 #define HWCAP2_SVE_B16B16	(1UL << 45)
 #define HWCAP2_LRCPC3		(1UL << 46)
 #define HWCAP2_LSE128		(1UL << 47)
+#define HWCAP2_GCS		(1UL << 48)
 
 #endif /* _UAPI__ASM_HWCAP_H */
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 5477451cefa1..dab80391543f 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -2859,6 +2859,9 @@ static const struct arm64_cpu_capabilities arm64_elf_hwcaps[] = {
 	HWCAP_CAP(ID_AA64ZFR0_EL1, I8MM, IMP, CAP_HWCAP, KERNEL_HWCAP_SVEI8MM),
 	HWCAP_CAP(ID_AA64ZFR0_EL1, F32MM, IMP, CAP_HWCAP, KERNEL_HWCAP_SVEF32MM),
 	HWCAP_CAP(ID_AA64ZFR0_EL1, F64MM, IMP, CAP_HWCAP, KERNEL_HWCAP_SVEF64MM),
+#endif
+#ifdef CONFIG_ARM64_GCS
+	HWCAP_CAP(ID_AA64PFR1_EL1, GCS, IMP, CAP_HWCAP, KERNEL_HWCAP_GCS),
 #endif
 	HWCAP_CAP(ID_AA64PFR1_EL1, SSBS, SSBS2, CAP_HWCAP, KERNEL_HWCAP_SSBS),
 #ifdef CONFIG_ARM64_BTI
diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
index a257da7b56fe..d557ee301464 100644
--- a/arch/arm64/kernel/cpuinfo.c
+++ b/arch/arm64/kernel/cpuinfo.c
@@ -130,6 +130,7 @@ static const char *const hwcap_str[] = {
 	[KERNEL_HWCAP_SVE_B16B16]	= "sveb16b16",
 	[KERNEL_HWCAP_LRCPC3]		= "lrcpc3",
 	[KERNEL_HWCAP_LSE128]		= "lse128",
+	[KERNEL_HWCAP_GCS]		= "gcs",
 };
 
 #ifdef CONFIG_COMPAT

-- 
2.39.2


