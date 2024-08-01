Return-Path: <linux-fsdevel+bounces-24766-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FE16944C37
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 15:03:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0EF31F21EA4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 13:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2576D1B0125;
	Thu,  1 Aug 2024 12:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PJZOHb/1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703FD1A3BCE;
	Thu,  1 Aug 2024 12:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722517156; cv=none; b=ePBJsXW1rzW+rfVrMZanz8F/HkmEtCVp8CIjqE21DyqCDsrJpo5tLR5ecuWqo2fEKJiLWea9et3Pu7pSQ6jitBaIAKfKgzCYZVYaU0SLoFICAVRcNhUC4LYeeYlLeJCLMiRYZHN3pjFc91NTMp9UQNO+/0MgQYLHC36+rJ5aEVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722517156; c=relaxed/simple;
	bh=e44VTA4PnVMnteUpPeHLUcAac2ATi0WZ4XE1rzWONBc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f//7ngSQaW2z7eU8hgG85rkHPJGpYYIJZfk6Cpk1NcRpTfFWVhxJtOItUnq1ZHhh1b+TN4C4dBnCuES86IFQePCcDG6TRiYSRSOdrSavt9I2xZO4IwWAFooIxDaAQvCS4JG7olXvzmdBVVkdLguyHJIOZZIg+mUDFFiKc2q0h/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PJZOHb/1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B45E3C4AF09;
	Thu,  1 Aug 2024 12:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722517156;
	bh=e44VTA4PnVMnteUpPeHLUcAac2ATi0WZ4XE1rzWONBc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=PJZOHb/1rk5ias0TkH1+lp9tf3RfEiXLHdimywGuaOsxW66xGBDCds/AKor2qBJyd
	 PQcezUzVUv7P2/GQm7SC7mMwfCK83I/sx578k8YF+msBXpBnY13USv19aAnVtUcmBl
	 PwprICHJrhoqtDukC/+4xSIsvXZyWUkxyj9uJ+iki+qthGnBa71Qz9S/YZlvaOI1+S
	 xjHKvUtKsZWcM9RKNPRr23s2+S1jpKV6HJPm7RJqVri/cXs8Vvngd6bi3k0GcovC9v
	 5qLQD7ZWtP+npQaL/OJmhqDbC3aE7/MEd/tcpwddaAqxazLzudrBrFIuPFnjWA9vUR
	 0an5eoTSPkoaA==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 01 Aug 2024 13:06:44 +0100
Subject: [PATCH v10 17/40] arm64/traps: Handle GCS exceptions
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240801-arm64-gcs-v10-17-699e2bd2190b@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6092; i=broonie@kernel.org;
 h=from:subject:message-id; bh=e44VTA4PnVMnteUpPeHLUcAac2ATi0WZ4XE1rzWONBc=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBmq4YTZ2OXDXa+2eEFmG18HUkUNJVoBLENhnowwk3M
 pJMAJNWJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZquGEwAKCRAk1otyXVSH0DreB/
 44rFE5NIa7f0ekSD7bRHP+YY3kusEJHC9heJwpjFUZcu7mWz7EonBz/XE5H/hcyn5jhA4RshRZKcht
 u+Nt1uMV9XbpmQr2MnxA/yNdMDjlxVeryhlOZwqacK7go6kRJX6rjm5I7HrnKjPb1pbM9OOkiDXdwc
 VRCZVNj+MEKUKh/li4SuomJ+oWeqRN0Apxke22a0HBHjQ9MsmTvNrOupwQsceU/RGRF2I18KLEWb2y
 ufroiycB/F5BZ9mrdqza3eoKtir+Qye7D53HE+FuwQ/6Gx+u4DAql60juOgfVdB5AoRMh7D9e+V/bV
 pSItS+emAaddmFbyM2oGNSwpSPuA0V
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
index 56c148890daf..0c231adf3867 100644
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
@@ -385,6 +386,31 @@
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
index 9e22683aa921..d410dcc12ed8 100644
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


