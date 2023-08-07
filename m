Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E34A2773283
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Aug 2023 00:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231439AbjHGWGK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Aug 2023 18:06:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230459AbjHGWFc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Aug 2023 18:05:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDA1AE9;
        Mon,  7 Aug 2023 15:04:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8D0456229A;
        Mon,  7 Aug 2023 22:03:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ADF9C433C7;
        Mon,  7 Aug 2023 22:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691445830;
        bh=+dR3d0METG46G3YweIr21QD2wGwLVUhSq1WHDSBihIA=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=r7Zx62s9/BdpdeiI+jVH8waOJkH0wPGns9X9VgI4dpw2DNzFtQYWP5/uwkwZ8Qxxa
         2+Ia5cnx6TgoXq07xcOwv80wVt7suWb2ihgNk6MmRvvuK4pL3YzE4S6ZSTJ/r+TK82
         5f3jxt5/D3Mta6vkLCdAr21Cviq9uhFXrfs9/UBXaS//97NViE04L1JWwHYjQYam5M
         OS7hGYP7fiJvUr1g8gr2Ad05hVbUJm31EUYOgoFQgvgroV4xeEqKzusfdiOyHINBOY
         6jwSi6XbSKiHLu/ur6mMHq6jBeY5VxWetAmgmJ7Uo0FFptvhmeeCqARAVMOZnZgijI
         32DJfnjG9PYVg==
From:   Mark Brown <broonie@kernel.org>
Date:   Mon, 07 Aug 2023 23:00:27 +0100
Subject: [PATCH v4 22/36] arm64/signal: Set up and restore the GCS context
 for signal handlers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230807-arm64-gcs-v4-22-68cfa37f9069@kernel.org>
References: <20230807-arm64-gcs-v4-0-68cfa37f9069@kernel.org>
In-Reply-To: <20230807-arm64-gcs-v4-0-68cfa37f9069@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, Oleg Nesterov <oleg@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <shuah@kernel.org>,
        "Rick P. Edgecombe" <rick.p.edgecombe@intel.com>,
        Deepak Gupta <debug@rivosinc.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>
Cc:     "H.J. Lu" <hjl.tools@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-034f2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7272; i=broonie@kernel.org;
 h=from:subject:message-id; bh=+dR3d0METG46G3YweIr21QD2wGwLVUhSq1WHDSBihIA=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBk0WmpUwYmeJzgdumteUNjZwQFpEgiamfSrWV2l0Sg
 d7aXtwSJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZNFpqQAKCRAk1otyXVSH0LwIB/
 wMWDoKRhf2e9vEc+/CC2Y/8x8dZzJEbmHmubFJhEdLTcJQ4ymRlpc0WaeNBdAd01vWH6/lZnxnOptL
 ERapv1nCCZ4lLLDPMwzsP/IrbvaSF+kd7U4miHSgYsV/i36ZiRfslBRqJwql/yVhg2qL9ebEe3na27
 sUD6KsoUYCkdd5oWeSbECov7P2IdPUtmoLxmf5RaWVDLPdfr9ufO+VFmbBZO0FOPJyF91yEzK4GqzO
 Y4pgU7ovvKTGOqvLmptp/9PskULx/qVIPwfWC2BXIbbKnf6MeGNfUO17NVFIxAaH9X3cV5HkZKUbQv
 Ll++fsjw9qXN78jrRDLjZKLjeVCgo2
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

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
with the top bit set which we add on signal entry and validate and pop
off on signal return.  Since the top bit is set address validation for
the token will fail if an attempt is made to use it with the stack
switch instructions.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/gcs.h |   2 +
 arch/arm64/kernel/signal.c   | 130 +++++++++++++++++++++++++++++++++++++++++--
 arch/arm64/mm/gcs.c          |   1 +
 3 files changed, 128 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/include/asm/gcs.h b/arch/arm64/include/asm/gcs.h
index c150e76869a1..65496103d462 100644
--- a/arch/arm64/include/asm/gcs.h
+++ b/arch/arm64/include/asm/gcs.h
@@ -8,6 +8,8 @@
 #include <asm/types.h>
 #include <asm/uaccess.h>
 
+struct ksignal;
+
 static inline void gcsb_dsync(void)
 {
 	asm volatile(".inst 0xd503227f" : : : "memory");
diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index 0df8cc295ea5..1c31be0f373e 100644
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
@@ -34,6 +35,36 @@
 #include <asm/traps.h>
 #include <asm/vdso.h>
 
+#ifdef CONFIG_ARM64_GCS
+/* Extra bit set in the address distinguishing a signal cap token. */
+#define GCS_SIGNAL_CAP_FLAG BIT(63)
+
+#define GCS_SIGNAL_CAP(addr) (GCS_CAP(addr) | GCS_SIGNAL_CAP_FLAG)
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
+	/* The cap must have the low bits set to a token value */
+	if (GCS_CAP_TOKEN(val) != GCS_CAP_VALID_TOKEN)
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
@@ -815,6 +846,45 @@ static int restore_sigframe(struct pt_regs *regs,
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
@@ -841,6 +911,9 @@ SYSCALL_DEFINE0(rt_sigreturn)
 	if (restore_altstack(&frame->uc.uc_stack))
 		goto badframe;
 
+	if (gcs_restore_signal())
+		goto badframe;
+
 	return regs->regs[0];
 
 badframe:
@@ -1071,7 +1144,52 @@ static int get_sigframe(struct rt_sigframe_user_layout *user,
 	return 0;
 }
 
-static void setup_return(struct pt_regs *regs, struct k_sigaction *ka,
+#ifdef CONFIG_ARM64_GCS
+
+static int gcs_signal_entry(__sigrestore_t sigtramp, struct ksignal *ksig)
+{
+	unsigned long __user *gcspr_el0;
+	unsigned long cap[2];
+	int ret;
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
+	cap[1] = GCS_SIGNAL_CAP(gcspr_el0 - 1);
+	cap[0] = (unsigned long)sigtramp;
+	ret = copy_to_user_gcs(gcspr_el0 - 2, cap, ARRAY_SIZE(cap));
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
@@ -1079,7 +1197,7 @@ static void setup_return(struct pt_regs *regs, struct k_sigaction *ka,
 	regs->regs[0] = usig;
 	regs->sp = (unsigned long)user->sigframe;
 	regs->regs[29] = (unsigned long)&user->next_frame->fp;
-	regs->pc = (unsigned long)ka->sa.sa_handler;
+	regs->pc = (unsigned long)ksig->ka.sa.sa_handler;
 
 	/*
 	 * Signal delivery is a (wacky) indirect function call in
@@ -1119,12 +1237,14 @@ static void setup_return(struct pt_regs *regs, struct k_sigaction *ka,
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
@@ -1147,7 +1267,7 @@ static int setup_rt_frame(int usig, struct ksignal *ksig, sigset_t *set,
 	err |= __save_altstack(&frame->uc.uc_stack, regs->sp);
 	err |= setup_sigframe(&user, regs, set);
 	if (err == 0) {
-		setup_return(regs, &ksig->ka, &user, usig);
+		err = setup_return(regs, ksig, &user, usig);
 		if (ksig->ka.sa.sa_flags & SA_SIGINFO) {
 			err |= copy_siginfo_to_user(&frame->info, &ksig->info);
 			regs->regs[1] = (unsigned long)&frame->info;
diff --git a/arch/arm64/mm/gcs.c b/arch/arm64/mm/gcs.c
index b41700d6695e..0034d5b12971 100644
--- a/arch/arm64/mm/gcs.c
+++ b/arch/arm64/mm/gcs.c
@@ -6,6 +6,7 @@
 #include <linux/types.h>
 
 #include <asm/cpufeature.h>
+#include <asm/gcs.h>
 #include <asm/page.h>
 
 static unsigned long alloc_gcs(unsigned long addr, unsigned long size,

-- 
2.30.2

