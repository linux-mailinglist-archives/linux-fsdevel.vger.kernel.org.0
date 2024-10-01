Return-Path: <linux-fsdevel+bounces-30592-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCAA398C8E9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 01:06:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3069CB238FD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 23:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8A411D0B85;
	Tue,  1 Oct 2024 23:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KqCfPYUW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D651CF5C9;
	Tue,  1 Oct 2024 23:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727823807; cv=none; b=a0JA6orm5cqEXzQ/Q1TVSLcnwZ3o+JJBfArO/RAt+AIFJI2ePeCmcrSIv7nqIWVatkSaen4PzSPG6svoKpHtr5CBmQLQDV1XXGeT8fkZHO8GlwUqGlKm6ycNcgVrCvBm9EANAG6gORkkMwYzjMNgJHFVcp41phWllkI8RWPaEQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727823807; c=relaxed/simple;
	bh=gMNU4N2r9J/DtCxCWsOgJ88QFKSaRk78Dab/E2WA3Cw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DO3qDTmXBKjnXeTmeD9aFq5VsVGZHa9a8khZAcPgFNkS05WqpB/G/6Zkxggb+ZS8JXRkZQWdocIq44t3h2DOSRTpkao43KMCosi2skyFAZHf1eH2rvEFH0jX4a+RNOBWNhUdWfE0VXQFwA1sFSapTUO+V0qTF1apjEVG0OvPr9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KqCfPYUW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7E7BC4AF09;
	Tue,  1 Oct 2024 23:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727823807;
	bh=gMNU4N2r9J/DtCxCWsOgJ88QFKSaRk78Dab/E2WA3Cw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=KqCfPYUW5zTqS/k4vJAO/lTJw2NGaBj73+Z6ckTKhj6zWABvPNxmswNeR/7oUe4hI
	 rr4R62lcBW5McUNQRyaNpq5CpA0fk9cs6m8DYft9pE8NrbZRhQHdIY9kKd4nO7IXFN
	 7g5dXbG8hXcPprDp2llw6ginwNm3qmNewWeqgt8tRw0JFNlJ6/jnQYuuYrvR4Tfyy0
	 krMaRLDwG67x8hAaiLw0bXhrQ/RINPPp09Z+OLRR2033N70ZrZ2oDWWoPXcVpfN/j8
	 Wb3UcF7CFxt5GIzYEcp2MBhO7R3/IjKnT/YGrcwXGtgaiGerHFs6MsOEtp44icNnXD
	 9HhQHjzYORtSg==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 01 Oct 2024 23:58:58 +0100
Subject: [PATCH v13 19/40] arm64/traps: Handle GCS exceptions
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241001-arm64-gcs-v13-19-222b78d87eee@kernel.org>
References: <20241001-arm64-gcs-v13-0-222b78d87eee@kernel.org>
In-Reply-To: <20241001-arm64-gcs-v13-0-222b78d87eee@kernel.org>
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
 Ross Burton <ross.burton@arm.com>, David Spickett <david.spickett@arm.com>, 
 Yury Khrustalev <yury.khrustalev@arm.com>, 
 Wilco Dijkstra <wilco.dijkstra@arm.com>, 
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
 kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-mm@kvack.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=openpgp-sha256; l=6161; i=broonie@kernel.org;
 h=from:subject:message-id; bh=gMNU4N2r9J/DtCxCWsOgJ88QFKSaRk78Dab/E2WA3Cw=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBm/H7SsPpp0sak4YBdEYHnTAxj5FmkgTt2Icjl0/+7
 aP9DIfqJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZvx+0gAKCRAk1otyXVSH0BcHB/
 4+ntAaj6fQXmq38J+L4bMK5w0PmGcCYD/npfDUTtoDOgb0mBbJH9vZ9bT0+B6mAwyIjP7zeu4VDTmj
 Aw4dYimJXbknHQ44l/CZAlILm/cfU8/s61fi2S4cExXqeWjLPyvyWHGMjOP66uhOyViuXcR9n+ljQC
 pq6fTS7qkc0Ng9hXD3xrqowwpQFnTgS2c1mzTBoV1htNVzU7EoI4FgJ04Sz146+B1jp3zyvviPFjCD
 yRwn0AP+28WccpNJyTCc8Tba2UIpUECViSga38G8EasrnRdu1iWGaYXo3AVHx+/tFWj2F03PhfCojw
 sasg+KKqCS3IvRQFxb63V156TJKIm0
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

A new exception code is defined for GCS specific faults other than
standard load/store faults, for example GCS token validation failures,
add handling for this. These faults are reported to userspace as
segfaults with code SEGV_CPERR (protection error), mirroring the
reporting for x86 shadow stack errors.

GCS faults due to memory load/store operations generate data aborts with
a flag set, these will be handled separately as part of the data abort
handling.

Since we do not currently enable GCS for EL1 we should not get any faults
there but while we're at it we wire things up there, treating any GCS
fault as fatal.

Reviewed-by: Thiago Jung Bauermann <thiago.bauermann@linaro.org>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/esr.h       | 28 +++++++++++++++++++++++++++-
 arch/arm64/include/asm/exception.h |  2 ++
 arch/arm64/kernel/entry-common.c   | 23 +++++++++++++++++++++++
 arch/arm64/kernel/traps.c          | 11 +++++++++++
 4 files changed, 63 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/esr.h b/arch/arm64/include/asm/esr.h
index da6d2c1c0b03..d1b1a33f9a8b 100644
--- a/arch/arm64/include/asm/esr.h
+++ b/arch/arm64/include/asm/esr.h
@@ -51,7 +51,8 @@
 #define ESR_ELx_EC_FP_EXC32	UL(0x28)
 /* Unallocated EC: 0x29 - 0x2B */
 #define ESR_ELx_EC_FP_EXC64	UL(0x2C)
-/* Unallocated EC: 0x2D - 0x2E */
+#define ESR_ELx_EC_GCS		UL(0x2D)
+/* Unallocated EC:  0x2E */
 #define ESR_ELx_EC_SERROR	UL(0x2F)
 #define ESR_ELx_EC_BREAKPT_LOW	UL(0x30)
 #define ESR_ELx_EC_BREAKPT_CUR	UL(0x31)
@@ -386,6 +387,31 @@
 #define ESR_ELx_MOPS_ISS_SRCREG(esr)	(((esr) & (UL(0x1f) << 5)) >> 5)
 #define ESR_ELx_MOPS_ISS_SIZEREG(esr)	(((esr) & (UL(0x1f) << 0)) >> 0)
 
+/* ISS field definitions for GCS */
+#define ESR_ELx_ExType_SHIFT	(20)
+#define ESR_ELx_ExType_MASK		GENMASK(23, 20)
+#define ESR_ELx_Raddr_SHIFT		(10)
+#define ESR_ELx_Raddr_MASK		GENMASK(14, 10)
+#define ESR_ELx_Rn_SHIFT		(5)
+#define ESR_ELx_Rn_MASK			GENMASK(9, 5)
+#define ESR_ELx_Rvalue_SHIFT		5
+#define ESR_ELx_Rvalue_MASK		GENMASK(9, 5)
+#define ESR_ELx_IT_SHIFT		(0)
+#define ESR_ELx_IT_MASK			GENMASK(4, 0)
+
+#define ESR_ELx_ExType_DATA_CHECK	0
+#define ESR_ELx_ExType_EXLOCK		1
+#define ESR_ELx_ExType_STR		2
+
+#define ESR_ELx_IT_RET			0
+#define ESR_ELx_IT_GCSPOPM		1
+#define ESR_ELx_IT_RET_KEYA		2
+#define ESR_ELx_IT_RET_KEYB		3
+#define ESR_ELx_IT_GCSSS1		4
+#define ESR_ELx_IT_GCSSS2		5
+#define ESR_ELx_IT_GCSPOPCX		6
+#define ESR_ELx_IT_GCSPOPX		7
+
 #ifndef __ASSEMBLY__
 #include <asm/types.h>
 
diff --git a/arch/arm64/include/asm/exception.h b/arch/arm64/include/asm/exception.h
index f296662590c7..674518464718 100644
--- a/arch/arm64/include/asm/exception.h
+++ b/arch/arm64/include/asm/exception.h
@@ -57,6 +57,8 @@ void do_el0_undef(struct pt_regs *regs, unsigned long esr);
 void do_el1_undef(struct pt_regs *regs, unsigned long esr);
 void do_el0_bti(struct pt_regs *regs);
 void do_el1_bti(struct pt_regs *regs, unsigned long esr);
+void do_el0_gcs(struct pt_regs *regs, unsigned long esr);
+void do_el1_gcs(struct pt_regs *regs, unsigned long esr);
 void do_debug_exception(unsigned long addr_if_watchpoint, unsigned long esr,
 			struct pt_regs *regs);
 void do_fpsimd_acc(unsigned long esr, struct pt_regs *regs);
diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
index 3fcd9d080bf2..fe74813009bd 100644
--- a/arch/arm64/kernel/entry-common.c
+++ b/arch/arm64/kernel/entry-common.c
@@ -463,6 +463,15 @@ static void noinstr el1_bti(struct pt_regs *regs, unsigned long esr)
 	exit_to_kernel_mode(regs);
 }
 
+static void noinstr el1_gcs(struct pt_regs *regs, unsigned long esr)
+{
+	enter_from_kernel_mode(regs);
+	local_daif_inherit(regs);
+	do_el1_gcs(regs, esr);
+	local_daif_mask();
+	exit_to_kernel_mode(regs);
+}
+
 static void noinstr el1_dbg(struct pt_regs *regs, unsigned long esr)
 {
 	unsigned long far = read_sysreg(far_el1);
@@ -505,6 +514,9 @@ asmlinkage void noinstr el1h_64_sync_handler(struct pt_regs *regs)
 	case ESR_ELx_EC_BTI:
 		el1_bti(regs, esr);
 		break;
+	case ESR_ELx_EC_GCS:
+		el1_gcs(regs, esr);
+		break;
 	case ESR_ELx_EC_BREAKPT_CUR:
 	case ESR_ELx_EC_SOFTSTP_CUR:
 	case ESR_ELx_EC_WATCHPT_CUR:
@@ -684,6 +696,14 @@ static void noinstr el0_mops(struct pt_regs *regs, unsigned long esr)
 	exit_to_user_mode(regs);
 }
 
+static void noinstr el0_gcs(struct pt_regs *regs, unsigned long esr)
+{
+	enter_from_user_mode(regs);
+	local_daif_restore(DAIF_PROCCTX);
+	do_el0_gcs(regs, esr);
+	exit_to_user_mode(regs);
+}
+
 static void noinstr el0_inv(struct pt_regs *regs, unsigned long esr)
 {
 	enter_from_user_mode(regs);
@@ -766,6 +786,9 @@ asmlinkage void noinstr el0t_64_sync_handler(struct pt_regs *regs)
 	case ESR_ELx_EC_MOPS:
 		el0_mops(regs, esr);
 		break;
+	case ESR_ELx_EC_GCS:
+		el0_gcs(regs, esr);
+		break;
 	case ESR_ELx_EC_BREAKPT_LOW:
 	case ESR_ELx_EC_SOFTSTP_LOW:
 	case ESR_ELx_EC_WATCHPT_LOW:
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index 563cbce11126..fdbcf047108c 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -506,6 +506,16 @@ void do_el1_bti(struct pt_regs *regs, unsigned long esr)
 	die("Oops - BTI", regs, esr);
 }
 
+void do_el0_gcs(struct pt_regs *regs, unsigned long esr)
+{
+	force_signal_inject(SIGSEGV, SEGV_CPERR, regs->pc, 0);
+}
+
+void do_el1_gcs(struct pt_regs *regs, unsigned long esr)
+{
+	die("Oops - GCS", regs, esr);
+}
+
 void do_el0_fpac(struct pt_regs *regs, unsigned long esr)
 {
 	force_signal_inject(SIGILL, ILL_ILLOPN, regs->pc, esr);
@@ -852,6 +862,7 @@ static const char *esr_class_str[] = {
 	[ESR_ELx_EC_MOPS]		= "MOPS",
 	[ESR_ELx_EC_FP_EXC32]		= "FP (AArch32)",
 	[ESR_ELx_EC_FP_EXC64]		= "FP (AArch64)",
+	[ESR_ELx_EC_GCS]		= "Guarded Control Stack",
 	[ESR_ELx_EC_SERROR]		= "SError",
 	[ESR_ELx_EC_BREAKPT_LOW]	= "Breakpoint (lower EL)",
 	[ESR_ELx_EC_BREAKPT_CUR]	= "Breakpoint (current EL)",

-- 
2.39.2


