Return-Path: <linux-fsdevel+bounces-10162-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10E8C8485D2
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Feb 2024 13:37:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 358C31C21750
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Feb 2024 12:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4091A6DD1A;
	Sat,  3 Feb 2024 12:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Azso4+Yy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9637B6E2A6;
	Sat,  3 Feb 2024 12:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706963496; cv=none; b=cmVD1Ud0p+2CR3N/DO4dJdAGzEMBun0BO+a6ckNHTdCCtwkbKINw1gUoxMBjN4dbzWqvnzd6LFu0Q3h/8NytUo/+TtDudzqU0rzsb2OwDrYjvaDdkgy6jdcfZSX63MWWbMX1p62jMzbakrs5BZhrdBRQ0Ve5PktbTAy1GDcnfF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706963496; c=relaxed/simple;
	bh=HRCdw6MJRS/rCWztQtxmtqhkYbOj0W+kgtlVYf4SbO0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HVAqy411hK5eDCWfqm31/jrYetkYJjF55JvbkFEX+pkdBPJ/MiTPIxej9+QPTLDBJnQODox+dzXIeBvtD1Je9nbdQOwl1RmB0Y8JSLgspYwMrd6qDT5lcyMw432JrUvnZR23G477uBNuyjR3n4ArLSXN89xathdWVcE4+p92Z4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Azso4+Yy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEDD7C43390;
	Sat,  3 Feb 2024 12:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706963496;
	bh=HRCdw6MJRS/rCWztQtxmtqhkYbOj0W+kgtlVYf4SbO0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Azso4+YyAzl6+yIFDUNUmT4mFK2oE6rFzieOpcEAd31dy44KjhRbM0MikMRMmH/bt
	 IDJwkyVqV4M9xRtQ7a6uFV+rRQ7jcOki77rkaLxessdsVjowAeul8LYofuitczB+7k
	 uxjexhTTl7YqK+IA6T9pv3KcnMIzu0W6KQ0SvNXHFD57hEB/SjtQkZExvIxwW5ea4N
	 YG+6juBGYl5PnRUrlmsTBDg9FGSZPOItMGzj8iuTun1R2FF7H8L6mxW9vmOsYxZLE9
	 rWwCcyQY+UHVxCR28wuKmMuR5+NnlznZ8CUJETnLCKJ7XqQP+UixCgNKk89noK4GHx
	 rlSUg+0roOT0Q==
From: Mark Brown <broonie@kernel.org>
Date: Sat, 03 Feb 2024 12:25:43 +0000
Subject: [PATCH v8 17/38] arm64/traps: Handle GCS exceptions
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240203-arm64-gcs-v8-17-c9fec77673ef@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6026; i=broonie@kernel.org;
 h=from:subject:message-id; bh=HRCdw6MJRS/rCWztQtxmtqhkYbOj0W+kgtlVYf4SbO0=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlvjDeDD8ANoqqbGdDnd/OGuhwpX6BzrLQ36MB5ZLR
 OGQPZxqJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZb4w3gAKCRAk1otyXVSH0ElXB/
 0cl9F8HCY4OiJaE0HDANmcmaQEbfXcFcXzKfY1VHC6GJR9gFQIpnme9dKTs+LrtwiE3gDY+6xW2Ajw
 szauDIVoauSS/Ab1v5E1K+om+qvbeYzD8T5V6eucJjrG4sVeIPBaDGOJfivUnZoOp+kuAY8zNpUEvI
 Q8oPJFZpRy82alEPzkVS5obR8LWL+DGUX17VRoLQUkdAmERuEdoSOvWJtuEgn+bC1gCHX9vMHTnqDQ
 pjIJXHogMzIZdzuOwZxQMCqeO3lA36Kxb+WtHfxDkpwbEdMJULrJHppQahPmitB7VoNl84uXARwqWD
 +mZ4SFE///Rh3kh0fH3sZu6xPnK2c0
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

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/esr.h       | 28 +++++++++++++++++++++++++++-
 arch/arm64/include/asm/exception.h |  2 ++
 arch/arm64/kernel/entry-common.c   | 23 +++++++++++++++++++++++
 arch/arm64/kernel/traps.c          | 11 +++++++++++
 4 files changed, 63 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/esr.h b/arch/arm64/include/asm/esr.h
index 353fe08546cf..20ee9f531864 100644
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
@@ -382,6 +383,31 @@
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
index ad688e157c9b..99caff458e20 100644
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
index 0fc94207e69a..52d78ce63a4e 100644
--- a/arch/arm64/kernel/entry-common.c
+++ b/arch/arm64/kernel/entry-common.c
@@ -429,6 +429,15 @@ static void noinstr el1_bti(struct pt_regs *regs, unsigned long esr)
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
@@ -471,6 +480,9 @@ asmlinkage void noinstr el1h_64_sync_handler(struct pt_regs *regs)
 	case ESR_ELx_EC_BTI:
 		el1_bti(regs, esr);
 		break;
+	case ESR_ELx_EC_GCS:
+		el1_gcs(regs, esr);
+		break;
 	case ESR_ELx_EC_BREAKPT_CUR:
 	case ESR_ELx_EC_SOFTSTP_CUR:
 	case ESR_ELx_EC_WATCHPT_CUR:
@@ -650,6 +662,14 @@ static void noinstr el0_mops(struct pt_regs *regs, unsigned long esr)
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
@@ -732,6 +752,9 @@ asmlinkage void noinstr el0t_64_sync_handler(struct pt_regs *regs)
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
2.30.2


