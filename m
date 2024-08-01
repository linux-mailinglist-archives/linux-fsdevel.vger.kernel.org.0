Return-Path: <linux-fsdevel+bounces-24772-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7AB4944C59
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 15:05:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A85DB28096
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 13:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C59C91A489B;
	Thu,  1 Aug 2024 12:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LOKxC2BE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267901A2C28;
	Thu,  1 Aug 2024 12:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722517197; cv=none; b=fIE63ohRdIg35GPC3T4RlKgQnX6ofmxrAT+5piGEQVfWtMiKWHlmfQgpeXVN58cNGcKHiQ0ZNZdXFLhLt2eFFq5jHSrG0yuwcNLZ/ep2T3kycqP001NqyjpKrglfnqIxReqrJovLJH8qqYW8pVhzrMtk9ggdMp057TPlBT3OP9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722517197; c=relaxed/simple;
	bh=spmcAZuGAEVkEAa67eKDQiXBrVNYqAUzr8CNYTcqBhY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OvfYLy/2kaK+V04fmTQpD/K+JNH/JoUlsoWXSpb0WXhgSCLYlnCpmTab2M0Lu5hjci25NbGda9N3yav0YWCBajSjT3oTfO5Sx6gSHShK4adKI5FQtRrtNVmVte0ukV/f5q09/D0uMUKt4S+ZOIA4fw412o4x1/5xUaZV9TMsKYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LOKxC2BE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DB4DC4AF10;
	Thu,  1 Aug 2024 12:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722517197;
	bh=spmcAZuGAEVkEAa67eKDQiXBrVNYqAUzr8CNYTcqBhY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=LOKxC2BEeYpWK9TNAcSxZylJbNNavaok4F0MVQF42q8Yo5nRUBk81Vc5hp7w8/t92
	 LsMDgWc+InmcMqTWZD6/69VxGqhn8WSc/jepxE26Xfnyufj0nXumjxFlUBsNs+QANO
	 wsGcFRMs/c40JG6FRb87QyriRPmvRVk4y2Ueek2ZXoweeHhDkcfCMIx6NCHhu+OnHD
	 YO1IoJd/zisL3Wcvob81CPlcsh03PkB3id0JEO9TBq9xv16rzrNf9kw01lIOzHrOlJ
	 BPOAOCgy24R5t6/RMkEItz3FZv8lRmR9ooY2c9yLuM8DFfv5iJv87hNem9uBs53/KE
	 +CzqmqoYAM82A==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 01 Aug 2024 13:06:50 +0100
Subject: [PATCH v10 23/40] arm64/signal: Set up and restore the GCS context
 for signal handlers
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240801-arm64-gcs-v10-23-699e2bd2190b@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7410; i=broonie@kernel.org;
 h=from:subject:message-id; bh=spmcAZuGAEVkEAa67eKDQiXBrVNYqAUzr8CNYTcqBhY=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBmq4YXZ0sZoZTGjIVJ72pSAZqpftvV6uf/BnLmr3c6
 L0bOK56JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZquGFwAKCRAk1otyXVSH0IjCB/
 0Z23quOTSlgLwveoWe21ZO693B3sCcrTDtGb3Hzg4WDqZ9uj/j5i/qrMK30dEijKL3tVwAWZetJbdC
 2WG7GAoVWlYz7NSgLF035utHXv7atop4YfEsC7gtLxA3fUFhs4nfAKdQ3QBa0T2W5eGma/lSl2Ca2G
 8SqGzsnLGC73oBvSORZGQIzSGU1pObqpdFs7BzC52aKp5o9M0CUN9tf8euB48ecU6cKYR/CE0ojMzE
 t7N1Q2iznMqMTGkqCNnAbigvxKWgEbj1tVQWHryOfxEqXcYnua5swm2P24nYFFDEJ/lQZOfaH6F9+S
 Q3xoDOzW11CtSxHYGrsPj4nh7AhDpR
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

When invoking a signal handler we use the GCS configuration and stack
for the current thread.

Since we implement signal return by calling the signal handler with a
return address set up pointing to a trampoline in the vDSO we need to
also configure any active GCS for this by pushing a frame for the
trampoline onto the GCS.  If we do not do this then signal return will
generate a GCS protection fault.

In order to guard against attempts to bypass GCS protections via signal
return we only allow returning with GCSPR_EL0 pointing to an address
where it was previously preempted by a signal.  We do this by pushing a
cap onto the GCS, this takes the form of an architectural GCS cap token
with the top bit set and token type of 0 which we add on signal entry
and validate and pop off on signal return.  The combination of the top
bit being set and the token type mean that this can't be interpreted as
a valid token or address.

Reviewed-by: Thiago Jung Bauermann <thiago.bauermann@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/gcs.h |   1 +
 arch/arm64/kernel/signal.c   | 134 +++++++++++++++++++++++++++++++++++++++++--
 arch/arm64/mm/gcs.c          |   1 +
 3 files changed, 131 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/include/asm/gcs.h b/arch/arm64/include/asm/gcs.h
index 48c97e63e56a..f50660603ecf 100644
--- a/arch/arm64/include/asm/gcs.h
+++ b/arch/arm64/include/asm/gcs.h
@@ -9,6 +9,7 @@
 #include <asm/uaccess.h>
 
 struct kernel_clone_args;
+struct ksignal;
 
 static inline void gcsb_dsync(void)
 {
diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index 4a77f4976e11..a1e0aa38bff9 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -25,6 +25,7 @@
 #include <asm/elf.h>
 #include <asm/exception.h>
 #include <asm/cacheflush.h>
+#include <asm/gcs.h>
 #include <asm/ucontext.h>
 #include <asm/unistd.h>
 #include <asm/fpsimd.h>
@@ -34,6 +35,37 @@
 #include <asm/traps.h>
 #include <asm/vdso.h>
 
+#ifdef CONFIG_ARM64_GCS
+/* Extra bit set in the address distinguishing a signal cap token. */
+#define GCS_SIGNAL_CAP_FLAG BIT(63)
+
+#define GCS_SIGNAL_CAP(addr) ((((unsigned long)addr) & GCS_CAP_ADDR_MASK) | \
+			      GCS_SIGNAL_CAP_FLAG)
+
+static bool gcs_signal_cap_valid(u64 addr, u64 val)
+{
+	/*
+	 * The top bit should be set, this is an invalid address for
+	 * EL0 and will only be set for caps created by signals.
+	 */
+	if (!(val & GCS_SIGNAL_CAP_FLAG))
+		return false;
+
+	/* The rest should be a standard architectural cap token. */
+	val &= ~GCS_SIGNAL_CAP_FLAG;
+
+	/* The cap must not have a token set */
+	if (GCS_CAP_TOKEN(val) != 0)
+		return false;
+
+	/* The cap must store the VA the cap was stored at */
+	if (GCS_CAP_ADDR(addr) != GCS_CAP_ADDR(val))
+		return false;
+
+	return true;
+}
+#endif
+
 /*
  * Do a signal return; undo the signal stack. These are aligned to 128-bit.
  */
@@ -860,6 +892,50 @@ static int restore_sigframe(struct pt_regs *regs,
 	return err;
 }
 
+#ifdef CONFIG_ARM64_GCS
+static int gcs_restore_signal(void)
+{
+	u64 gcspr_el0, cap;
+	int ret;
+
+	if (!system_supports_gcs())
+		return 0;
+
+	if (!(current->thread.gcs_el0_mode & PR_SHADOW_STACK_ENABLE))
+		return 0;
+
+	gcspr_el0 = read_sysreg_s(SYS_GCSPR_EL0);
+
+	/*
+	 * GCSPR_EL0 should be pointing at a capped GCS, read the cap...
+	 */
+	gcsb_dsync();
+	ret = copy_from_user(&cap, (__user void*)gcspr_el0, sizeof(cap));
+	if (ret)
+		return -EFAULT;
+
+	/*
+	 * ...then check that the cap is the actual GCS before
+	 * restoring it.
+	 */
+	if (!gcs_signal_cap_valid(gcspr_el0, cap))
+		return -EINVAL;
+
+	/* Invalidate the token to prevent reuse */
+	put_user_gcs(0, (__user void*)gcspr_el0, &ret);
+	if (ret != 0)
+		return -EFAULT;
+
+	current->thread.gcspr_el0 = gcspr_el0 + sizeof(cap);
+	write_sysreg_s(current->thread.gcspr_el0, SYS_GCSPR_EL0);
+
+	return 0;
+}
+
+#else
+static int gcs_restore_signal(void) { return 0; }
+#endif
+
 SYSCALL_DEFINE0(rt_sigreturn)
 {
 	struct pt_regs *regs = current_pt_regs();
@@ -886,6 +962,9 @@ SYSCALL_DEFINE0(rt_sigreturn)
 	if (restore_altstack(&frame->uc.uc_stack))
 		goto badframe;
 
+	if (gcs_restore_signal())
+		goto badframe;
+
 	return regs->regs[0];
 
 badframe:
@@ -1130,7 +1209,50 @@ static int get_sigframe(struct rt_sigframe_user_layout *user,
 	return 0;
 }
 
-static void setup_return(struct pt_regs *regs, struct k_sigaction *ka,
+#ifdef CONFIG_ARM64_GCS
+
+static int gcs_signal_entry(__sigrestore_t sigtramp, struct ksignal *ksig)
+{
+	unsigned long __user *gcspr_el0;
+	int ret = 0;
+
+	if (!system_supports_gcs())
+		return 0;
+
+	if (!task_gcs_el0_enabled(current))
+		return 0;
+
+	/*
+	 * We are entering a signal handler, current register state is
+	 * active.
+	 */
+	gcspr_el0 = (unsigned long __user *)read_sysreg_s(SYS_GCSPR_EL0);
+
+	/*
+	 * Push a cap and the GCS entry for the trampoline onto the GCS.
+	 */
+	put_user_gcs((unsigned long)sigtramp, gcspr_el0 - 2, &ret);
+	put_user_gcs(GCS_SIGNAL_CAP(gcspr_el0 - 1), gcspr_el0 - 1, &ret);
+	if (ret != 0)
+		return ret;
+
+	gcsb_dsync();
+
+	gcspr_el0 -= 2;
+	write_sysreg_s((unsigned long)gcspr_el0, SYS_GCSPR_EL0);
+
+	return 0;
+}
+#else
+
+static int gcs_signal_entry(__sigrestore_t sigtramp, struct ksignal *ksig)
+{
+	return 0;
+}
+
+#endif
+
+static int setup_return(struct pt_regs *regs, struct ksignal *ksig,
 			 struct rt_sigframe_user_layout *user, int usig)
 {
 	__sigrestore_t sigtramp;
@@ -1138,7 +1260,7 @@ static void setup_return(struct pt_regs *regs, struct k_sigaction *ka,
 	regs->regs[0] = usig;
 	regs->sp = (unsigned long)user->sigframe;
 	regs->regs[29] = (unsigned long)&user->next_frame->fp;
-	regs->pc = (unsigned long)ka->sa.sa_handler;
+	regs->pc = (unsigned long)ksig->ka.sa.sa_handler;
 
 	/*
 	 * Signal delivery is a (wacky) indirect function call in
@@ -1178,12 +1300,14 @@ static void setup_return(struct pt_regs *regs, struct k_sigaction *ka,
 		sme_smstop();
 	}
 
-	if (ka->sa.sa_flags & SA_RESTORER)
-		sigtramp = ka->sa.sa_restorer;
+	if (ksig->ka.sa.sa_flags & SA_RESTORER)
+		sigtramp = ksig->ka.sa.sa_restorer;
 	else
 		sigtramp = VDSO_SYMBOL(current->mm->context.vdso, sigtramp);
 
 	regs->regs[30] = (unsigned long)sigtramp;
+
+	return gcs_signal_entry(sigtramp, ksig);
 }
 
 static int setup_rt_frame(int usig, struct ksignal *ksig, sigset_t *set,
@@ -1206,7 +1330,7 @@ static int setup_rt_frame(int usig, struct ksignal *ksig, sigset_t *set,
 	err |= __save_altstack(&frame->uc.uc_stack, regs->sp);
 	err |= setup_sigframe(&user, regs, set);
 	if (err == 0) {
-		setup_return(regs, &ksig->ka, &user, usig);
+		err = setup_return(regs, ksig, &user, usig);
 		if (ksig->ka.sa.sa_flags & SA_SIGINFO) {
 			err |= copy_siginfo_to_user(&frame->info, &ksig->info);
 			regs->regs[1] = (unsigned long)&frame->info;
diff --git a/arch/arm64/mm/gcs.c b/arch/arm64/mm/gcs.c
index 6703c70581a4..30614f4ad164 100644
--- a/arch/arm64/mm/gcs.c
+++ b/arch/arm64/mm/gcs.c
@@ -6,6 +6,7 @@
 #include <linux/types.h>
 
 #include <asm/cpufeature.h>
+#include <asm/gcs.h>
 #include <asm/page.h>
 
 static unsigned long alloc_gcs(unsigned long addr, unsigned long size)

-- 
2.39.2


