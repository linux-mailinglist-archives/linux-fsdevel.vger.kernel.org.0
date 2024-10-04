Return-Path: <linux-fsdevel+bounces-31037-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F92299109C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 22:30:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A1EC1F269A5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 20:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC4481B4F15;
	Fri,  4 Oct 2024 20:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kPfnVwr8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3683B231C80;
	Fri,  4 Oct 2024 20:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728073771; cv=none; b=Kxfy9FhO/80UMzuz/n0pUI1IP7Zc7j1M3n0W7oZoXreRdTkDtnzW+FmMi/i7H0zlAcKOwuyKgcnwP17RG3Hy2kMA7kYqwGYTzgpZCZyYUp1jwVJTpMVuTT/YdVHFhz5HACSEARvByRwO/M5VOUPj2lUHnMPLVfvODeO1nMkq7J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728073771; c=relaxed/simple;
	bh=Q29JrkLZxdArYwY+rVpKpTkNxIyN30A+TtF5u4a+d1w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fz0QinmdQ422gKWIf7yHJMjurrp5Hs7e4TELNMvEzaGOYkI/A9RVqKPiukenZblMcEhFIsXm2CVVhAZ9QyKIiWb8h7C3W5uNwe14O8sgje2jMEKwFvITPU6kl3G2vZI6vh7T5nj/UgbvJyh2xF9uqY1BaLlI9e+ROgX8eL1lYxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kPfnVwr8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9738C4CECD;
	Fri,  4 Oct 2024 20:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728073770;
	bh=Q29JrkLZxdArYwY+rVpKpTkNxIyN30A+TtF5u4a+d1w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=kPfnVwr8SWBws2rU3nHv5pCJNfCkH6R5u4eQ6sEHY7b59UXTp/29XlR7QsZn9vLeY
	 WxIgMlZAJkzfbjX23C1S0RchYA9z7k4Mx1MP0RNEhoqER0TOP5/zXDAd70UkVyVxHV
	 BpmsVOnqD0ZsgItThc4CVUsNMAssHg/YGdBqsGcvUSkYp5Y1d5Hitf4F2Tx1QXnLFx
	 oV3YoL7FLZOHQECi6q89+XiFzeErqfXK7h5pHa9lSLUNSps7JTqqC10yOUrBRM0Uno
	 88hn/JpoqAeAZVNZulJ1piBT6ushRc5l8Crzi//csirZiLsV5XtSVEXa6Wy6Ld1Hqt
	 V3bUp2d9d7Vfg==
From: Mark Brown <broonie@kernel.org>
Date: Fri, 04 Oct 2024 21:26:30 +0100
Subject: [PATCH RFC v2 2/2] arm64: Support AT_HWCAP3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241004-arm64-elf-hwcap3-v2-2-799d1daad8b0@kernel.org>
References: <20241004-arm64-elf-hwcap3-v2-0-799d1daad8b0@kernel.org>
In-Reply-To: <20241004-arm64-elf-hwcap3-v2-0-799d1daad8b0@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, Yury Khrustalev <yury.khrustalev@arm.com>, 
 Wilco Dijkstra <wilco.dijkstra@arm.com>, 
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-9b746
X-Developer-Signature: v=1; a=openpgp-sha256; l=4678; i=broonie@kernel.org;
 h=from:subject:message-id; bh=Q29JrkLZxdArYwY+rVpKpTkNxIyN30A+TtF5u4a+d1w=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnAFAfn7BPFjo4XljvMQXJ1vgo1LJghNjRRFv/EHRJ
 dSaDGdWJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZwBQHwAKCRAk1otyXVSH0HXCB/
 sHPZyH0C3p8kpDx3xx/v8pAStV7iXI+CDLK+jDe+taJ/8wYG3EaQtVb3UfwJFVBhine4yNr8GKd5td
 NnTguPxISjp9da3eMg+/Ev+VRxbfRCzTlCboqTDAIF602zHJu0z516cRbb7gcrKXWQkyZNk9jWj+NY
 JKt7w8bnejgF0i8MEbTOyvq8JpW2FCdeGqzLs60Lm15nNnHnUzno0S05Yi5fhQAfJv7ia0XTf8iSim
 7FWdQhvTkjNAHa5BU2ro3B2dKdcr/Z3wKkaj4wlkWXdCuJIqCXpATbAiPSYX1GhNYCGtZA4QftstDo
 pX9bsUtoq7432pKjQDX0iVx2mJaUBA
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

We have filled all 64 bits of AT_HWCAP2 so in order to support discovery of
further features provide the framework to use the already defined AT_HWCAP3
for further CPU features.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/arch/arm64/elf_hwcaps.rst | 6 +++---
 arch/arm64/include/asm/cpufeature.h     | 3 ++-
 arch/arm64/include/asm/hwcap.h          | 6 +++++-
 arch/arm64/include/uapi/asm/hwcap.h     | 4 ++++
 arch/arm64/kernel/cpufeature.c          | 6 ++++++
 5 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/Documentation/arch/arm64/elf_hwcaps.rst b/Documentation/arch/arm64/elf_hwcaps.rst
index 694f67fa07d196816b1292e896ebe6a1b599c125..dc1b11d6d1122bba928b054cd1874aad5073e05c 100644
--- a/Documentation/arch/arm64/elf_hwcaps.rst
+++ b/Documentation/arch/arm64/elf_hwcaps.rst
@@ -16,9 +16,9 @@ architected discovery mechanism available to userspace code at EL0. The
 kernel exposes the presence of these features to userspace through a set
 of flags called hwcaps, exposed in the auxiliary vector.
 
-Userspace software can test for features by acquiring the AT_HWCAP or
-AT_HWCAP2 entry of the auxiliary vector, and testing whether the relevant
-flags are set, e.g.::
+Userspace software can test for features by acquiring the AT_HWCAP,
+AT_HWCAP2 or AT_HWCAP3 entry of the auxiliary vector, and testing
+whether the relevant flags are set, e.g.::
 
 	bool floating_point_is_present(void)
 	{
diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index 3d261cc123c1e22ac7bc9cfcde463624c76b2084..38e7d1a44ea38ab0a06a6f22824ae023b128721b 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -12,7 +12,7 @@
 #include <asm/hwcap.h>
 #include <asm/sysreg.h>
 
-#define MAX_CPU_FEATURES	128
+#define MAX_CPU_FEATURES	192
 #define cpu_feature(x)		KERNEL_HWCAP_ ## x
 
 #define ARM64_SW_FEATURE_OVERRIDE_NOKASLR	0
@@ -438,6 +438,7 @@ void cpu_set_feature(unsigned int num);
 bool cpu_have_feature(unsigned int num);
 unsigned long cpu_get_elf_hwcap(void);
 unsigned long cpu_get_elf_hwcap2(void);
+unsigned long cpu_get_elf_hwcap3(void);
 
 #define cpu_set_named_feature(name) cpu_set_feature(cpu_feature(name))
 #define cpu_have_named_feature(name) cpu_have_feature(cpu_feature(name))
diff --git a/arch/arm64/include/asm/hwcap.h b/arch/arm64/include/asm/hwcap.h
index a775adddecf25633e87d58fb9ac9e6293beac1b3..3b5c50df419ee94193a4d9e3a47516eb0739e89a 100644
--- a/arch/arm64/include/asm/hwcap.h
+++ b/arch/arm64/include/asm/hwcap.h
@@ -159,17 +159,21 @@
 #define KERNEL_HWCAP_SME_SF8DP2		__khwcap2_feature(SME_SF8DP2)
 #define KERNEL_HWCAP_POE		__khwcap2_feature(POE)
 
+#define __khwcap3_feature(x)		(const_ilog2(HWCAP3_ ## x) + 128)
+
 /*
  * This yields a mask that user programs can use to figure out what
  * instruction set this cpu supports.
  */
 #define ELF_HWCAP		cpu_get_elf_hwcap()
 #define ELF_HWCAP2		cpu_get_elf_hwcap2()
+#define ELF_HWCAP3		cpu_get_elf_hwcap3()
 
 #ifdef CONFIG_COMPAT
 #define COMPAT_ELF_HWCAP	(compat_elf_hwcap)
 #define COMPAT_ELF_HWCAP2	(compat_elf_hwcap2)
-extern unsigned int compat_elf_hwcap, compat_elf_hwcap2;
+#define COMPAT_ELF_HWCAP3	(compat_elf_hwcap3)
+extern unsigned int compat_elf_hwcap, compat_elf_hwcap2, compat_elf_hwcap3;
 #endif
 
 enum {
diff --git a/arch/arm64/include/uapi/asm/hwcap.h b/arch/arm64/include/uapi/asm/hwcap.h
index 055381b2c61595361c2d57d38be936c2dfeaa195..3dd4a53a438a14bfb41882b2ab15bdd7ce617475 100644
--- a/arch/arm64/include/uapi/asm/hwcap.h
+++ b/arch/arm64/include/uapi/asm/hwcap.h
@@ -124,4 +124,8 @@
 #define HWCAP2_SME_SF8DP2	(1UL << 62)
 #define HWCAP2_POE		(1UL << 63)
 
+/*
+ * HWCAP3 flags - for AT_HWCAP3
+ */
+
 #endif /* _UAPI__ASM_HWCAP_H */
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 718728a85430fad5151b73fa213a510efac3f834..7221636b790709b153b49126e00246cc3032a7bc 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -103,6 +103,7 @@ static DECLARE_BITMAP(elf_hwcap, MAX_CPU_FEATURES) __read_mostly;
 				 COMPAT_HWCAP_LPAE)
 unsigned int compat_elf_hwcap __read_mostly = COMPAT_ELF_HWCAP_DEFAULT;
 unsigned int compat_elf_hwcap2 __read_mostly;
+unsigned int compat_elf_hwcap3 __read_mostly;
 #endif
 
 DECLARE_BITMAP(system_cpucaps, ARM64_NCAPS);
@@ -3499,6 +3500,11 @@ unsigned long cpu_get_elf_hwcap2(void)
 	return elf_hwcap[1];
 }
 
+unsigned long cpu_get_elf_hwcap3(void)
+{
+	return elf_hwcap[2];
+}
+
 static void __init setup_boot_cpu_capabilities(void)
 {
 	/*

-- 
2.39.2


