Return-Path: <linux-fsdevel+bounces-26616-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B20A95A9C0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 03:21:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5076E1C2098E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 01:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 610752745D;
	Thu, 22 Aug 2024 01:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DwFM/rF8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A930D433B9;
	Thu, 22 Aug 2024 01:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724289573; cv=none; b=LPT1lk9iXfJW3TvUKu0kSeo0Do1/DPa5w+GZiHP150gN2FLJGdwfVzGkl9gI6kIl+jrONxUiOXEIQYAnl+GguEZn8yBkgmmvIR6HfbLilfdQk/WVO3XRn/l4qMTsNkB2qwkJCoRltbNbkhu8Buo8iakPDVqTRAsO75OAT4YoLHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724289573; c=relaxed/simple;
	bh=p+k0jTbaEA99trdr4pz3NzAF7Yf9BBO+B19MeJlSzs4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JVhyENZ/ulwGqCZijhnCuXCcQdFJwqj8Lh6+Psw97mlSCI9AzHCHiYH421GWficNfk6KaG6HvXMXe37CsFGeE/UfoPOGyrBrCVqbhq374T5avz2tVZGIfs3UKJpmEeFbbKScAYmPB1COJqgnQW66jxfa91YV3AyMWeSr8CrTslQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DwFM/rF8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FA7EC32782;
	Thu, 22 Aug 2024 01:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724289573;
	bh=p+k0jTbaEA99trdr4pz3NzAF7Yf9BBO+B19MeJlSzs4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=DwFM/rF8dbxF5iAiJQBkNcyl4MpQCNPo/7h0ijDZEC2DQwX6P9MCQJsdLQmYTo3w4
	 kN4XMcgPS2+Nspg04WpyMwQwYWuchJLA1u1F9LpbzcJyk4SC/i/91VJTbuWn3rtzAt
	 VpyNFub3O4QF2XvVSbLUSDsC9s2WN1aGQDuRu0kbT6dN8Y8pNyKsAikEC/usnkkjoq
	 oYOW1xC4zVRaLJoVH1YEwGK9uwA7iEDdO/7V5k+wsLwg3MbJLU8s9XwWsvX19Q49Yc
	 vW0VQAElmyecYsp8uUWzpK8uNtNd5HA9mIXI4uZxTEQmHL5tLYrAUkMW5KpB5drC8e
	 OCmI3NfA5JKKg==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 22 Aug 2024 02:15:20 +0100
Subject: [PATCH v11 17/39] arm64/hwcap: Add hwcap for GCS
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240822-arm64-gcs-v11-17-41b81947ecb5@kernel.org>
References: <20240822-arm64-gcs-v11-0-41b81947ecb5@kernel.org>
In-Reply-To: <20240822-arm64-gcs-v11-0-41b81947ecb5@kernel.org>
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
 Ross Burton <ross.burton@arm.com>, 
 Yury Khrustalev <yury.khrustalev@arm.com>, 
 Wilco Dijkstra <wilco.dijkstra@arm.com>, 
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
 kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-mm@kvack.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=openpgp-sha256; l=3096; i=broonie@kernel.org;
 h=from:subject:message-id; bh=p+k0jTbaEA99trdr4pz3NzAF7Yf9BBO+B19MeJlSzs4=;
 b=owGbwMvMwMWocq27KDak/QLjabUkhrRjEw1DBY8JsZhfUkz7zMLPotW9MILVab/efK+acqsQxtNf
 nsp0MhqzMDByMciKKbKsfZaxKj1cYuv8R/NfwQxiZQKZwsDFKQAT8Upl/yuzWbS/+865EpdD2g498z
 w3P/6+U/jpagZd/3Lfla+CD88SiPb2SjaTYyl4HuGy3VWd4Z77x2pO0yk2u93KX2TNWZvNnHVgPUfc
 g/2Oh7JPOj0tMYzcy5q2RWum69L4Hdz2e5qFCw9z/IxuDv56fAZL3YGCuiKb2aIltw/yvpmoLjFr4V
 6RCA9d9aV/rheX/57psfC3DM/klQLzpLbaWSruccnP3rqR9Yva9sdJqoVq89ryFSIy22MlImVtfZ7U
 V2//v+Zualed3eN8E7W66XEz5Xqm7lgwxeTN/tInxs+vsZbnze+rZj/lcWPT2mrDqSfjVAU7OMxbmD
 SKRU89ip8QE6tRGrlg/qnWXx0XAQ==
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Provide a hwcap to enable userspace to detect support for GCS.

Reviewed-by: Thiago Jung Bauermann <thiago.bauermann@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/arch/arm64/elf_hwcaps.rst | 2 ++
 arch/arm64/include/asm/hwcap.h          | 1 +
 arch/arm64/include/uapi/asm/hwcap.h     | 1 +
 arch/arm64/kernel/cpufeature.c          | 3 +++
 arch/arm64/kernel/cpuinfo.c             | 1 +
 5 files changed, 8 insertions(+)

diff --git a/Documentation/arch/arm64/elf_hwcaps.rst b/Documentation/arch/arm64/elf_hwcaps.rst
index 448c1664879b..cf87be078f33 100644
--- a/Documentation/arch/arm64/elf_hwcaps.rst
+++ b/Documentation/arch/arm64/elf_hwcaps.rst
@@ -365,6 +365,8 @@ HWCAP2_SME_SF8DP2
 HWCAP2_SME_SF8DP4
     Functionality implied by ID_AA64SMFR0_EL1.SF8DP4 == 0b1.
 
+HWCAP2_GCS
+    Functionality implied by ID_AA64PFR1_EL1.GCS == 0b1
 
 4. Unused AT_HWCAP bits
 -----------------------
diff --git a/arch/arm64/include/asm/hwcap.h b/arch/arm64/include/asm/hwcap.h
index 4edd3b61df11..fd7e162e7e39 100644
--- a/arch/arm64/include/asm/hwcap.h
+++ b/arch/arm64/include/asm/hwcap.h
@@ -157,6 +157,7 @@
 #define KERNEL_HWCAP_SME_SF8FMA		__khwcap2_feature(SME_SF8FMA)
 #define KERNEL_HWCAP_SME_SF8DP4		__khwcap2_feature(SME_SF8DP4)
 #define KERNEL_HWCAP_SME_SF8DP2		__khwcap2_feature(SME_SF8DP2)
+#define KERNEL_HWCAP_GCS		__khwcap2_feature(GCS)
 
 /*
  * This yields a mask that user programs can use to figure out what
diff --git a/arch/arm64/include/uapi/asm/hwcap.h b/arch/arm64/include/uapi/asm/hwcap.h
index 285610e626f5..328fb7843e2f 100644
--- a/arch/arm64/include/uapi/asm/hwcap.h
+++ b/arch/arm64/include/uapi/asm/hwcap.h
@@ -122,5 +122,6 @@
 #define HWCAP2_SME_SF8FMA	(1UL << 60)
 #define HWCAP2_SME_SF8DP4	(1UL << 61)
 #define HWCAP2_SME_SF8DP2	(1UL << 62)
+#define HWCAP2_GCS		(1UL << 63)
 
 #endif /* _UAPI__ASM_HWCAP_H */
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 315bd7be1106..e3e8290a4447 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -2994,6 +2994,9 @@ static const struct arm64_cpu_capabilities arm64_elf_hwcaps[] = {
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
index 09eeaa24d456..2f539e3101ee 100644
--- a/arch/arm64/kernel/cpuinfo.c
+++ b/arch/arm64/kernel/cpuinfo.c
@@ -143,6 +143,7 @@ static const char *const hwcap_str[] = {
 	[KERNEL_HWCAP_SME_SF8FMA]	= "smesf8fma",
 	[KERNEL_HWCAP_SME_SF8DP4]	= "smesf8dp4",
 	[KERNEL_HWCAP_SME_SF8DP2]	= "smesf8dp2",
+	[KERNEL_HWCAP_GCS]		= "gcs",
 };
 
 #ifdef CONFIG_COMPAT

-- 
2.39.2


