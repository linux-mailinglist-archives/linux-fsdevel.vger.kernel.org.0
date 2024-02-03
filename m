Return-Path: <linux-fsdevel+bounces-10161-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7460C8485CD
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Feb 2024 13:36:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F1A4285785
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Feb 2024 12:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74A3369975;
	Sat,  3 Feb 2024 12:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G3KODdyX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA02667C5F;
	Sat,  3 Feb 2024 12:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706963489; cv=none; b=uqvP6RrwTD/sbBVmYlVJw+jPLTY2rQfqbFUsB+jNeqJRSNG30GVKb8aa2HVAuRVSqX+pjWoHOmzhotxbQLhq7dNg2sEn5nHvdnNd7wsP8jAbVVvh1XXJKkZ6I/qO9oecteIBPKpPIZYNBdcynYaPDQiR84pC6geCeSd0VoMZAcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706963489; c=relaxed/simple;
	bh=2cZBAsyDen5t10YKJMqQqRacz55Ix1gmnVNOGcAdVHI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G84lgowekndlbWHgR4Ic5PZkhc3NzqajGsYg4Ie8aTB/P2JxmnZJw50pV7xNjeMiNz61ajriH63NzrrCYTcPHe5VyNb+Z91gBMnvxGUvdn1w9NeL2WIq2IvloHQFEFBcSRp6tfDYMz10CgFHhO1fibbtQGwtkLMLb3zRAcGNlzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G3KODdyX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23856C433C7;
	Sat,  3 Feb 2024 12:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706963489;
	bh=2cZBAsyDen5t10YKJMqQqRacz55Ix1gmnVNOGcAdVHI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=G3KODdyXV84zp1WCaszFTbVJ2uzuktodWs8f8wULYlN8w99KkxKz/+ezLneV0DugV
	 x/cwvGfsdUC3eW+YYRIwg6HU1tyRVrb7V4Ub/MdYDk6mE4D7XxqcwonHdr44Kp/bvw
	 b2g/KQS9cGH9Cl2Y2GuKcr7ecb32sw2ElksDnlhfkXP2DbnDikvM7MxJ8h8o+cOfkl
	 KvPtjaP0HwY9t6phffOTirc/ieuvAsz8aZwasX1XNp1Cv64JpuCsLj5fu7rvuPL6TP
	 hvuoAl/z3r0yWCjpqndfLm5YGAVsOPfdT2IgvmV9XZi0r9yPQS0W5hdeffXFKXMUnt
	 A9oqQY7azVtTQ==
From: Mark Brown <broonie@kernel.org>
Date: Sat, 03 Feb 2024 12:25:42 +0000
Subject: [PATCH v8 16/38] arm64/hwcap: Add hwcap for GCS
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240203-arm64-gcs-v8-16-c9fec77673ef@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2995; i=broonie@kernel.org;
 h=from:subject:message-id; bh=2cZBAsyDen5t10YKJMqQqRacz55Ix1gmnVNOGcAdVHI=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlvjDdArV5/f1ACfon5ADCHhNy9LNTvLl/uQOQRNL0
 1A2GhhGJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZb4w3QAKCRAk1otyXVSH0LMLB/
 94kl6jJs+ZdrvXxnmg2VS+Ldw/qKP/sR+00QxgbGMh/uXh1xYFxuDHzgUpcnXqnP08q9VHn3XI0q+9
 5SpUX6Qd3Fvtqy1KVotOyPSUoeE7dpPJntzXucH4HzayJCWZ1VbxUaon7nPT6rWirxCE4eqW1rispq
 HomupbnqiFm9Q5BSDH8gS76+j3FBtUB71bbwothoqHW1avAFYEY/AYeoWmbNMfEsuvtFv4PI5FJ+ZX
 G4TNA3Mkel4mGN+Y7fQe+nlszt8TNErQCFln4CSh+0S/qH4X75ZBaIvA0HKUTIWPBRrMBDHdpA/Uaq
 sZb3P7vZZGRDet9V9CpODyO7rtqWzM
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
index b606842ab8c1..1a92c4502a0b 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -2867,6 +2867,9 @@ static const struct arm64_cpu_capabilities arm64_elf_hwcaps[] = {
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
index 47043c0d95ec..b3ec0b89c9e0 100644
--- a/arch/arm64/kernel/cpuinfo.c
+++ b/arch/arm64/kernel/cpuinfo.c
@@ -128,6 +128,7 @@ static const char *const hwcap_str[] = {
 	[KERNEL_HWCAP_SVE_B16B16]	= "sveb16b16",
 	[KERNEL_HWCAP_LRCPC3]		= "lrcpc3",
 	[KERNEL_HWCAP_LSE128]		= "lse128",
+	[KERNEL_HWCAP_GCS]		= "gcs",
 };
 
 #ifdef CONFIG_COMPAT

-- 
2.30.2


