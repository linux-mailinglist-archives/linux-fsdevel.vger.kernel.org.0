Return-Path: <linux-fsdevel+bounces-22388-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88F3D916BF0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 17:08:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7D501C2578C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 15:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61BFE17F386;
	Tue, 25 Jun 2024 15:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uaJHgVXr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B455216F8EC;
	Tue, 25 Jun 2024 15:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719327760; cv=none; b=G4OdIHDq9PSaB8dGkwYC8qdlcktF5yHB9gTguwmgaNa2QOzL+sdVd0MqORvKPM4OXALFN2r1UmoAyJhHlO6V5FSmoaOOOAHEOEDXPlA2CoCn79T0PI3xC0rbg+GbxifmgudVuzPdX2ugfsB2cXNClmQgV+wpaL/dDxuzkzgYgPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719327760; c=relaxed/simple;
	bh=ZeJUfmWUn8AhdqTBGWmAGgYG/PSKOzanuQ1mPl6a5Is=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r4vAmkYGomzY4KXHUB6vSiQX4p8Lw77qe1MM+HseWSeMZIDt/i36cyhwiDBHqRQGRMi5IKYYQ/KMXgENgcl4h8ypD1Vb5Pho1oU7Vqx7igdJRGl0hKM9akUlPGcFejmrDDN9hNG1UsneBfRaOjhOOMZHvQT20aTNOkpe0q99UOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uaJHgVXr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 181DCC4AF0A;
	Tue, 25 Jun 2024 15:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719327760;
	bh=ZeJUfmWUn8AhdqTBGWmAGgYG/PSKOzanuQ1mPl6a5Is=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=uaJHgVXrkcH4sdRnMs8G/LDMZbXUtEOLUHL2g1WCsRYwRI4fgHnVQCVfs4Ex7YZUG
	 NIGSjpc9y54xeC3gXKPoFrd3vMW/Az8VShYWBY2kSxP0BJaWdGt/BuygKG2zEkc5Fz
	 KtQkJfzmHSXNInOqTujzlK1SkGo7hvhtH2GQNHZMZOOT0tl9usun+YjpzxBZbiO3Gj
	 bGY6V+i4Lcla073iGhB7xY0O5j3D5yQ3jHXvgpYxzDDE1RIGaHn5+7YJiRJ6sUptBC
	 4kQ63sWOSNholdlAuqeJRPyCzzjXcwHjJu6/8PWLuGwUK8yMp4mO6UuyfvFvi9h8Z4
	 GoUMLVBKNcIxQ==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 25 Jun 2024 15:57:45 +0100
Subject: [PATCH v9 17/39] arm64/traps: Handle GCS exceptions
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240625-arm64-gcs-v9-17-0f634469b8f0@kernel.org>
References: <20240625-arm64-gcs-v9-0-0f634469b8f0@kernel.org>
In-Reply-To: <20240625-arm64-gcs-v9-0-0f634469b8f0@kernel.org>
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
X-Mailer: b4 0.14-dev-d4707
X-Developer-Signature: v=1; a=openpgp-sha256; l=6092; i=broonie@kernel.org;
 h=from:subject:message-id; bh=ZeJUfmWUn8AhdqTBGWmAGgYG/PSKOzanuQ1mPl6a5Is=;
 b=owGbwMvMwMWocq27KDak/QLjabUkhrSq2/ULNGV9prPvXuwbXKxpa8OhMf+0b8LmTseWiZev5k/r
 Ny3pZDRmYWDkYpAVU2RZ+yxjVXq4xNb5j+a/ghnEygQyhYGLUwAmMnc3+z/tjiq1XTO/Rl8XPtxYLm
 10mqdwnvl2OZ7Ci0KOLEGsGc3s1Vt3ld80KNtzRV8w0Ir/nrlp2LZVsf0ezmtXuvq0b7/jbP/0u9eN
 +fdTgmrcluVMehk1j2vez3v3rz0LvG+t4CE9TS5ux9kVanedorZI9QT7em7wm+Tv1yQdYDdV0cpP9d
 WDa3dbdHNSH3nV/edLkjjW2C50+1jt51f3u/ZrNYWa6FWZVGQmc/jdPqxyMFjNiinA4fE8v3A1Q6Y1
 VTzODmsrIk1ulwmbJtivOtHuJKH55c+F2RZ+/49x9IpEm3312/Bg7rXgpfH1eyJOeTV7FX/f581rPG
 2Bf/fEPXvvry/QCF56qNad59RtAA==
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
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/esr.h       | 28 +++++++++++++++++++++++++++-
 arch/arm64/include/asm/exception.h |  2 ++
 arch/arm64/kernel/entry-common.c   | 23 +++++++++++++++++++++++
 arch/arm64/kernel/traps.c          | 11 +++++++++++
 4 files changed, 63 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/esr.h b/arch/arm64/include/asm/esr.h
index 7abf09df7033..8982b4ab297f 100644
--- a/arch/arm64/include/asm/esr.h
+++ b/arch/arm64/include/asm/esr.h
@@ -51,7 +51,8 @@
 #define ESR_ELx_EC_FP_EXC32	(0x28)
 /* Unallocated EC: 0x29 - 0x2B */
 #define ESR_ELx_EC_FP_EXC64	(0x2C)
-/* Unallocated EC: 0x2D - 0x2E */
+#define ESR_ELx_EC_GCS		(0x2D)
+/* Unallocated EC: 0x2E */
 #define ESR_ELx_EC_SERROR	(0x2F)
 #define ESR_ELx_EC_BREAKPT_LOW	(0x30)
 #define ESR_ELx_EC_BREAKPT_CUR	(0x31)
@@ -376,6 +377,31 @@
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
index b77a15955f28..54f2d16d82f4 100644
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
index 215e6d7f2df8..fb867c6526a6 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -500,6 +500,16 @@ void do_el1_bti(struct pt_regs *regs, unsigned long esr)
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
@@ -838,6 +848,7 @@ static const char *esr_class_str[] = {
 	[ESR_ELx_EC_MOPS]		= "MOPS",
 	[ESR_ELx_EC_FP_EXC32]		= "FP (AArch32)",
 	[ESR_ELx_EC_FP_EXC64]		= "FP (AArch64)",
+	[ESR_ELx_EC_GCS]		= "Guarded Control Stack",
 	[ESR_ELx_EC_SERROR]		= "SError",
 	[ESR_ELx_EC_BREAKPT_LOW]	= "Breakpoint (lower EL)",
 	[ESR_ELx_EC_BREAKPT_CUR]	= "Breakpoint (current EL)",

-- 
2.39.2


