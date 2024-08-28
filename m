Return-Path: <linux-fsdevel+bounces-27687-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE75B9635E6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 01:37:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84D832829D8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 23:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64F861B6520;
	Wed, 28 Aug 2024 23:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J7J9R1Hm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D081AD3F9;
	Wed, 28 Aug 2024 23:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724887889; cv=none; b=NE8kEAF+EGPpaDB8omItClj+QXWpNd9xO0M3OloMd2JRiG2m1YXIQbI9CNxf68IULZmMetwGbqKE0+vwoBllaptDPN04DqiHFHF32GHgTE6el9cgWlIUBSN/5Kh9Q7kmBfcftQ0ZP2Sk+OVHu/sRWMyqN1XZf0iDy82ivhTkVn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724887889; c=relaxed/simple;
	bh=+XJ8jXgS9Q/t0O/27yyohfB1kYxr9cR86IJPKVqMyuA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=itfu4efBZMEkMwPpGllXsCaxafYSxe+KdzqiXbqDXbJWaV861QRAkFjOB5tWfEHxCQ/MbhXOPuZ4tnKWDm/JIOn8N29xW98K2r8ANjcC7zG0sgxuS+nyIC7egWYx8I90flPwBAN9alr42bf8Th/wpzCVAtm8VP62gVL34lAbE6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J7J9R1Hm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5646C4CEC8;
	Wed, 28 Aug 2024 23:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724887889;
	bh=+XJ8jXgS9Q/t0O/27yyohfB1kYxr9cR86IJPKVqMyuA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=J7J9R1HmRK2uQJphZsFFrhZG8WoJb2PivA6h/tSdyXDveMEQt/3jG5mOBmHZq5Upb
	 JG0Nhibcq3a1Xme/CMBsl6LgeNy8kncdr44u8JjmJZ16bXOIR4c7BSb0HiUHv+54E3
	 r4tl3xASvp3Ya72gLMGs21/YKLh0F20b+cnF5sS83r/uqm58y9tonOwraIOKCpTlKk
	 nUCUummr9I5VXWwx5sNcGJzKZ+2GzO2JnNVlafginPT1jGBWygwaFbWn3uqZFoa47F
	 ce0ObWLdvndrBmm6LFjEJNOTjW5IQujs3YB04inwproW73VWt0DVB7zK3P04yRAkLQ
	 IpbMLwewoLZzg==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 29 Aug 2024 00:27:40 +0100
Subject: [PATCH v12 24/39] arm64/signal: Set up and restore the GCS context
 for signal handlers
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240829-arm64-gcs-v12-24-42fec947436a@kernel.org>
References: <20240829-arm64-gcs-v12-0-42fec947436a@kernel.org>
In-Reply-To: <20240829-arm64-gcs-v12-0-42fec947436a@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6711; i=broonie@kernel.org;
 h=from:subject:message-id; bh=+XJ8jXgS9Q/t0O/27yyohfB1kYxr9cR86IJPKVqMyuA=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBmz7KLj4E9jeS0/p1fUQxHTG2unNSC0YwBHSGzV7Vf
 XcxSsi6JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZs+yiwAKCRAk1otyXVSH0HSNB/
 49B0Lh7Royj2a3FVRBPmf7taMKXnKzRw0Z6Azuu1tSiQJPB20WNn+jqT+g50JZWs6yGK6+adSJwLFr
 Nq5QLjqJvtBAvQfiAyfvT18YeyyaSddtJIiKTb6KWmPOlcKIzEWYoL3xNOPBUX7frVvltUmIMq/emC
 7LA8YpLQQfgcWdwEfUBbAVknmxHPMCboK9oVPQC4NWhKOUtCxfhpYsih7cFbgm37/Es3kaT+nex9j3
 9I8/9VT81QVZxXRkr6D8NVBYK4w0ebnvDCMIINcK5DClNfdUmsLVs5M/kvD6hWaJ/vsLc0LVU95g4B
 DlHp01h49dZzRJaORURaSFvgJyprA0
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
index 4a77f4976e11..3f52ce11f791 100644
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
@@ -860,6 +870,58 @@ static int restore_sigframe(struct pt_regs *regs,
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
@@ -883,6 +945,9 @@ SYSCALL_DEFINE0(rt_sigreturn)
 	if (restore_sigframe(regs, frame))
 		goto badframe;
 
+	if (gcs_restore_signal())
+		goto badframe;
+
 	if (restore_altstack(&frame->uc.uc_stack))
 		goto badframe;
 
@@ -1130,7 +1195,48 @@ static int get_sigframe(struct rt_sigframe_user_layout *user,
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
@@ -1138,7 +1244,7 @@ static void setup_return(struct pt_regs *regs, struct k_sigaction *ka,
 	regs->regs[0] = usig;
 	regs->sp = (unsigned long)user->sigframe;
 	regs->regs[29] = (unsigned long)&user->next_frame->fp;
-	regs->pc = (unsigned long)ka->sa.sa_handler;
+	regs->pc = (unsigned long)ksig->ka.sa.sa_handler;
 
 	/*
 	 * Signal delivery is a (wacky) indirect function call in
@@ -1178,12 +1284,14 @@ static void setup_return(struct pt_regs *regs, struct k_sigaction *ka,
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
@@ -1206,7 +1314,7 @@ static int setup_rt_frame(int usig, struct ksignal *ksig, sigset_t *set,
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


