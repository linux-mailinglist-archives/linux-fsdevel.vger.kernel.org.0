Return-Path: <linux-fsdevel+bounces-28801-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F9596E612
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2024 01:07:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8605C1F2468A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 23:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B6DF1BA86A;
	Thu,  5 Sep 2024 23:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GhPgpfKb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F9B1B9B4A;
	Thu,  5 Sep 2024 23:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725577620; cv=none; b=E+GX7Wa85CZlwY0Pbm75Xuws17p5JScmx3jeziOffMCz5waiygMrFQh4nEqt6DZXIdtrPs/BiDjuSENj/dAtXYCVw1i8McR9EZhLWOVrCNNuGacQB5XGnZltn3d7xR/46SqUijckWkEuDB9pmplA3vT8Bb2BSpcXoQ5liaRLasc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725577620; c=relaxed/simple;
	bh=A1MsCyDJgEsRX6kQKLK9eRLTDyJrgk7l7bzvGIADznQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sndAzn9dakoJ5EB9m7tPl/wWX7eQLhkBx2Z4a5+UWGr2BC6SVddJKVmTPJtUsQQ0kuWGN3cwybhFO+eFajFkcLM0/Tk9JlMf6KkPQPeB6L2PTxkxfLzxoCKpyQB3sDhaQQlXsTCLY0Q6S7IoWL8mkFJiT2HOLflh0UVC+zEM5cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GhPgpfKb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9469AC4CEC4;
	Thu,  5 Sep 2024 23:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725577619;
	bh=A1MsCyDJgEsRX6kQKLK9eRLTDyJrgk7l7bzvGIADznQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=GhPgpfKb5XecmsryPGqjtx250G+lHVlFC4InO3RdPZcoD042V6UNbwQvKhp8HWjDL
	 405lCJ2+pKEhgEgHItQ1CzvzdJHWrF9CsVVLAFVNP85qSJIYbACUW7jzLlhipJfysf
	 hOJhCzJVdm+YbUquMIwd54Q8dksbeZAzTajmvRbnEEfks54KIRg8aV//0dhV9U5ia2
	 0nRkbWhpSK0+pxVRqYvd6EDYK5UzMuJ7tI4JNElz7RIC3Tce4hcohkbBd+7y8ptcQ7
	 EQs6XiZCAbU4I9xSlfvO1v7RN35XZkI4hW6zafmkZ7pImt6ET/WcsmYUcG61emsXd4
	 hwop67+Fc4LBw==
From: Mark Brown <broonie@kernel.org>
Date: Fri, 06 Sep 2024 00:05:25 +0100
Subject: [PATCH RFC 2/2] arm64: Support AT_HWCAP3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240906-arm64-elf-hwcap3-v1-2-8df1a5e63508@kernel.org>
References: <20240906-arm64-elf-hwcap3-v1-0-8df1a5e63508@kernel.org>
In-Reply-To: <20240906-arm64-elf-hwcap3-v1-0-8df1a5e63508@kernel.org>
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
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=openpgp-sha256; l=4418; i=broonie@kernel.org;
 h=from:subject:message-id; bh=A1MsCyDJgEsRX6kQKLK9eRLTDyJrgk7l7bzvGIADznQ=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBm2jmIf3KlTF3HuICSRK2swFAoI5TkoKodbSQSwtH2
 eOden2uJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZto5iAAKCRAk1otyXVSH0JhuB/
 42nAbDepwuWS2bMb3uWSgS9OHa4Ly3xMqGKhQKJqXvqevtltxck+8dXjok7eAUJ+8xSKRPw72njBZq
 KA4OUWQragIfeidoQKApKZpih0twdUPs/d+yVmUHUHedClUN/jbIgyd/HUgUGr8pt34UT+KTaK/LYs
 d/bbD655MWElOWiowvYs/iXX8GOPWs0NnTa30pP9NvOp2SzkyqfPcbSk3d7q5ONRaZKjhZZUK4LmEY
 Ug2VjEvJ9l7KkbevX4lts5DLJsFwZqVLUnn/EN+mwW3hUvaCjqgOVM4xUKiR1uNjM4cv+tmBkP+G+J
 7l4k82NXS0/cr/as7YI3eLuqmQfYuq
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
index 448c1664879b..36530d613adb 100644
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
index 558434267271..0a999a45ce02 100644
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
index 4edd3b61df11..c1107456cb81 100644
--- a/arch/arm64/include/asm/hwcap.h
+++ b/arch/arm64/include/asm/hwcap.h
@@ -158,17 +158,21 @@
 #define KERNEL_HWCAP_SME_SF8DP4		__khwcap2_feature(SME_SF8DP4)
 #define KERNEL_HWCAP_SME_SF8DP2		__khwcap2_feature(SME_SF8DP2)
 
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
index 285610e626f5..170eac371991 100644
--- a/arch/arm64/include/uapi/asm/hwcap.h
+++ b/arch/arm64/include/uapi/asm/hwcap.h
@@ -123,4 +123,8 @@
 #define HWCAP2_SME_SF8DP4	(1UL << 61)
 #define HWCAP2_SME_SF8DP2	(1UL << 62)
 
+/*
+ * HWCAP3 flags - for AT_HWCAP3
+ */
+
 #endif /* _UAPI__ASM_HWCAP_H */
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 646ecd3069fd..77d6a84e27e5 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -103,6 +103,7 @@ static DECLARE_BITMAP(elf_hwcap, MAX_CPU_FEATURES) __read_mostly;
 				 COMPAT_HWCAP_LPAE)
 unsigned int compat_elf_hwcap __read_mostly = COMPAT_ELF_HWCAP_DEFAULT;
 unsigned int compat_elf_hwcap2 __read_mostly;
+unsigned int compat_elf_hwcap3 __read_mostly;
 #endif
 
 DECLARE_BITMAP(system_cpucaps, ARM64_NCAPS);
@@ -3476,6 +3477,11 @@ unsigned long cpu_get_elf_hwcap2(void)
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


