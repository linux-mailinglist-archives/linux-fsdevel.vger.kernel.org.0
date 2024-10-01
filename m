Return-Path: <linux-fsdevel+bounces-30598-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DCEE998C906
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 01:08:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58C131F216CF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 23:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F22921CF5DC;
	Tue,  1 Oct 2024 23:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TB0n3CPd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3871CF5DA;
	Tue,  1 Oct 2024 23:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727823878; cv=none; b=l7kg/qUKGzJ7v4RcxTqnGaT/Xb3ITUhtO4MQOEkFVUZio20V4mHc/NtDvuqT8YfYuarRQ0kdAzOUSEyVX4tfES1kz7oxQ4kbEHKi0EpFxTvdRx3LIvBsH6mp1JY+BKFpEPXqLMExHJPrWOxxPnmGFHEdT5eU7Idn4INkIKWculI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727823878; c=relaxed/simple;
	bh=M/Cko4L7ycF7EfuRgE9nFrYd9p9UbU51oKSukOYF/3Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SIKXLZ3taxN5R+T95vQ9iW0kbNXDCyr7tkv5IpJnczPRitR31WTj7HoDoVrqFSbp9MnVYgJXZ/yQRbVfbmlpBgfIG6FtypnBUGSIuTVfzW3c/vmwQ9BVf2onqQCvFzuh40c1rmufUzq1RZ4afI67vwMeXwyCZy8WeEqscRLqlzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TB0n3CPd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67207C4CEC6;
	Tue,  1 Oct 2024 23:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727823878;
	bh=M/Cko4L7ycF7EfuRgE9nFrYd9p9UbU51oKSukOYF/3Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=TB0n3CPdNHxlLWrrtuwMlV8tMuyagUCpSWBaTpoZK3gtGJcqFir6KLD+BmHv+cAUd
	 qM/4Gy+3Y18n74iUaE3rzufN3Rl/YESZyphxeSuMvNMijO55mx0tYJmieb9IHxvIqG
	 lKLPaKvylTHaCFcD3d2EQpZOZ+TUNT51nHrDD5Q/xrHnMKDfBv/rh5RPQozl9dCruQ
	 0REOF1upnxBvakxy2PWw5L7FCxb1vRcxVUKN6luHbJiTMdFqw5QxkIyTUrxpDEImd+
	 xjFKxq+oZ20wZuFdNCPOnXd9v4i+GcTRI+IXsg9I4FVuQivvGUdj6CHwInwp+0eTc9
	 t51dk4u8fx/Cg==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 01 Oct 2024 23:59:04 +0100
Subject: [PATCH v13 25/40] arm64/signal: Set up and restore the GCS context
 for signal handlers
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241001-arm64-gcs-v13-25-222b78d87eee@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6765; i=broonie@kernel.org;
 h=from:subject:message-id; bh=M/Cko4L7ycF7EfuRgE9nFrYd9p9UbU51oKSukOYF/3Y=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBm/H7XYlmqI4AVMLQuVzPpNgT/SyMCRjCiznsJGwH4
 G2vcFFCJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZvx+1wAKCRAk1otyXVSH0KouB/
 9Jw3HWKPOwR2aVOZ6u7wPXJwj9zBiar/DXFEbthlVQ/Dr8xLxWr9UILF4cDa6yLfc+rJkYXNX+5RK9
 BkjxhujnTpn05vvFfUCInty8LTLbn0sywBiP8f8X0Dn2rcVCUbs5Smk8agHmrxbSo76R4SwsFy498d
 AyoptghwLoECA+CFGXG7VMkZ9S7i+FfAd1v2VUB63hLD5sxJkIEubTmneUSSxYvFVT5b/J37eGA6+z
 13qjEBBQxnOjZ9MlEZ5LB/ybEnIQLz1wN87hLvtd7aIz5ZIpPZ8Azclkb+uVeaAc0nEsRgnOd/5R7F
 2+kSiCmA0iuGU82ZzrQ9jZqMMl63ti
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
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/gcs.h |   1 +
 arch/arm64/kernel/signal.c   | 118 +++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 114 insertions(+), 5 deletions(-)

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
index 561986947530..b5ab0e229a78 100644
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
@@ -34,6 +35,15 @@
 #include <asm/traps.h>
 #include <asm/vdso.h>
 
+#ifdef CONFIG_ARM64_GCS
+#define GCS_SIGNAL_CAP(addr) (((unsigned long)addr) & GCS_CAP_ADDR_MASK)
+
+static bool gcs_signal_cap_valid(u64 addr, u64 val)
+{
+	return val == GCS_SIGNAL_CAP(addr);
+}
+#endif
+
 /*
  * Do a signal return; undo the signal stack. These are aligned to 128-bit.
  */
@@ -904,6 +914,58 @@ static int restore_sigframe(struct pt_regs *regs,
 	return err;
 }
 
+#ifdef CONFIG_ARM64_GCS
+static int gcs_restore_signal(void)
+{
+	unsigned long __user *gcspr_el0;
+	u64 cap;
+	int ret;
+
+	if (!system_supports_gcs())
+		return 0;
+
+	if (!(current->thread.gcs_el0_mode & PR_SHADOW_STACK_ENABLE))
+		return 0;
+
+	gcspr_el0 = (unsigned long __user *)read_sysreg_s(SYS_GCSPR_EL0);
+
+	/*
+	 * Ensure that any changes to the GCS done via GCS operations
+	 * are visible to the normal reads we do to validate the
+	 * token.
+	 */
+	gcsb_dsync();
+
+	/*
+	 * GCSPR_EL0 should be pointing at a capped GCS, read the cap.
+	 * We don't enforce that this is in a GCS page, if it is not
+	 * then faults will be generated on GCS operations - the main
+	 * concern is to protect GCS pages.
+	 */
+	ret = copy_from_user(&cap, gcspr_el0, sizeof(cap));
+	if (ret)
+		return -EFAULT;
+
+	/*
+	 * Check that the cap is the actual GCS before replacing it.
+	 */
+	if (!gcs_signal_cap_valid((u64)gcspr_el0, cap))
+		return -EINVAL;
+
+	/* Invalidate the token to prevent reuse */
+	put_user_gcs(0, (__user void*)gcspr_el0, &ret);
+	if (ret != 0)
+		return -EFAULT;
+
+	write_sysreg_s(gcspr_el0 + 1, SYS_GCSPR_EL0);
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
@@ -927,6 +989,9 @@ SYSCALL_DEFINE0(rt_sigreturn)
 	if (restore_sigframe(regs, frame))
 		goto badframe;
 
+	if (gcs_restore_signal())
+		goto badframe;
+
 	if (restore_altstack(&frame->uc.uc_stack))
 		goto badframe;
 
@@ -1189,7 +1254,48 @@ static int get_sigframe(struct rt_sigframe_user_layout *user,
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
@@ -1197,7 +1303,7 @@ static void setup_return(struct pt_regs *regs, struct k_sigaction *ka,
 	regs->regs[0] = usig;
 	regs->sp = (unsigned long)user->sigframe;
 	regs->regs[29] = (unsigned long)&user->next_frame->fp;
-	regs->pc = (unsigned long)ka->sa.sa_handler;
+	regs->pc = (unsigned long)ksig->ka.sa.sa_handler;
 
 	/*
 	 * Signal delivery is a (wacky) indirect function call in
@@ -1240,12 +1346,14 @@ static void setup_return(struct pt_regs *regs, struct k_sigaction *ka,
 	if (system_supports_poe())
 		write_sysreg_s(POR_EL0_INIT, SYS_POR_EL0);
 
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
@@ -1268,7 +1376,7 @@ static int setup_rt_frame(int usig, struct ksignal *ksig, sigset_t *set,
 	err |= __save_altstack(&frame->uc.uc_stack, regs->sp);
 	err |= setup_sigframe(&user, regs, set);
 	if (err == 0) {
-		setup_return(regs, &ksig->ka, &user, usig);
+		err = setup_return(regs, ksig, &user, usig);
 		if (ksig->ka.sa.sa_flags & SA_SIGINFO) {
 			err |= copy_siginfo_to_user(&frame->info, &ksig->info);
 			regs->regs[1] = (unsigned long)&frame->info;

-- 
2.39.2


