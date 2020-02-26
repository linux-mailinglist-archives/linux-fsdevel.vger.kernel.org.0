Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7924A170362
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2020 16:57:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728880AbgBZP5o (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Feb 2020 10:57:44 -0500
Received: from foss.arm.com ([217.140.110.172]:38138 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728865AbgBZP5l (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Feb 2020 10:57:41 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3D09A31B;
        Wed, 26 Feb 2020 07:57:41 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7D3003F819;
        Wed, 26 Feb 2020 07:57:40 -0800 (PST)
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Paul Elliott <paul.elliott@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Amit Kachhap <amit.kachhap@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        "H . J . Lu " <hjl.tools@gmail.com>,
        Andrew Jones <drjones@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        =?UTF-8?q?Kristina=20Mart=C5=A1enko?= <kristina.martsenko@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Florian Weimer <fweimer@redhat.com>,
        Sudakshina Das <sudi.das@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Dave Martin <Dave.Martin@arm.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v7 08/11] arm64: traps: Shuffle code to eliminate forward declarations
Date:   Wed, 26 Feb 2020 15:57:11 +0000
Message-Id: <20200226155714.43937-9-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200226155714.43937-1-broonie@kernel.org>
References: <20200226155714.43937-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Dave Martin <Dave.Martin@arm.com>

Hoist the IT state handling code earlier in traps.c, to avoid
accumulating forward declarations.

No functional change.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/kernel/traps.c | 103 ++++++++++++++++++--------------------
 1 file changed, 50 insertions(+), 53 deletions(-)

diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index bc9f4292bfc3..3c07a7074145 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -272,7 +272,55 @@ void arm64_notify_die(const char *str, struct pt_regs *regs,
 	}
 }
 
-static void advance_itstate(struct pt_regs *regs);
+#ifdef CONFIG_COMPAT
+#define PSTATE_IT_1_0_SHIFT	25
+#define PSTATE_IT_1_0_MASK	(0x3 << PSTATE_IT_1_0_SHIFT)
+#define PSTATE_IT_7_2_SHIFT	10
+#define PSTATE_IT_7_2_MASK	(0x3f << PSTATE_IT_7_2_SHIFT)
+
+static u32 compat_get_it_state(struct pt_regs *regs)
+{
+	u32 it, pstate = regs->pstate;
+
+	it  = (pstate & PSTATE_IT_1_0_MASK) >> PSTATE_IT_1_0_SHIFT;
+	it |= ((pstate & PSTATE_IT_7_2_MASK) >> PSTATE_IT_7_2_SHIFT) << 2;
+
+	return it;
+}
+
+static void compat_set_it_state(struct pt_regs *regs, u32 it)
+{
+	u32 pstate_it;
+
+	pstate_it  = (it << PSTATE_IT_1_0_SHIFT) & PSTATE_IT_1_0_MASK;
+	pstate_it |= ((it >> 2) << PSTATE_IT_7_2_SHIFT) & PSTATE_IT_7_2_MASK;
+
+	regs->pstate &= ~PSR_AA32_IT_MASK;
+	regs->pstate |= pstate_it;
+}
+
+static void advance_itstate(struct pt_regs *regs)
+{
+	u32 it;
+
+	/* ARM mode */
+	if (!(regs->pstate & PSR_AA32_T_BIT) ||
+	    !(regs->pstate & PSR_AA32_IT_MASK))
+		return;
+
+	it  = compat_get_it_state(regs);
+
+	/*
+	 * If this is the last instruction of the block, wipe the IT
+	 * state. Otherwise advance it.
+	 */
+	if (!(it & 7))
+		it = 0;
+	else
+		it = (it & 0xe0) | ((it << 1) & 0x1f);
+
+	compat_set_it_state(regs, it);
+}
 
 void arm64_skip_faulting_instruction(struct pt_regs *regs, unsigned long size)
 {
@@ -285,7 +333,7 @@ void arm64_skip_faulting_instruction(struct pt_regs *regs, unsigned long size)
 	if (user_mode(regs))
 		user_fastforward_single_step(current);
 
-	if (regs->pstate & PSR_MODE32_BIT)
+	if (compat_user_mode(regs))
 		advance_itstate(regs);
 }
 
@@ -578,34 +626,6 @@ static const struct sys64_hook sys64_hooks[] = {
 	{},
 };
 
-
-#ifdef CONFIG_COMPAT
-#define PSTATE_IT_1_0_SHIFT	25
-#define PSTATE_IT_1_0_MASK	(0x3 << PSTATE_IT_1_0_SHIFT)
-#define PSTATE_IT_7_2_SHIFT	10
-#define PSTATE_IT_7_2_MASK	(0x3f << PSTATE_IT_7_2_SHIFT)
-
-static u32 compat_get_it_state(struct pt_regs *regs)
-{
-	u32 it, pstate = regs->pstate;
-
-	it  = (pstate & PSTATE_IT_1_0_MASK) >> PSTATE_IT_1_0_SHIFT;
-	it |= ((pstate & PSTATE_IT_7_2_MASK) >> PSTATE_IT_7_2_SHIFT) << 2;
-
-	return it;
-}
-
-static void compat_set_it_state(struct pt_regs *regs, u32 it)
-{
-	u32 pstate_it;
-
-	pstate_it  = (it << PSTATE_IT_1_0_SHIFT) & PSTATE_IT_1_0_MASK;
-	pstate_it |= ((it >> 2) << PSTATE_IT_7_2_SHIFT) & PSTATE_IT_7_2_MASK;
-
-	regs->pstate &= ~PSR_AA32_IT_MASK;
-	regs->pstate |= pstate_it;
-}
-
 static bool cp15_cond_valid(unsigned int esr, struct pt_regs *regs)
 {
 	int cond;
@@ -626,29 +646,6 @@ static bool cp15_cond_valid(unsigned int esr, struct pt_regs *regs)
 	return aarch32_opcode_cond_checks[cond](regs->pstate);
 }
 
-static void advance_itstate(struct pt_regs *regs)
-{
-	u32 it;
-
-	/* ARM mode */
-	if (!(regs->pstate & PSR_AA32_T_BIT) ||
-	    !(regs->pstate & PSR_AA32_IT_MASK))
-		return;
-
-	it  = compat_get_it_state(regs);
-
-	/*
-	 * If this is the last instruction of the block, wipe the IT
-	 * state. Otherwise advance it.
-	 */
-	if (!(it & 7))
-		it = 0;
-	else
-		it = (it & 0xe0) | ((it << 1) & 0x1f);
-
-	compat_set_it_state(regs, it);
-}
-
 static void compat_cntfrq_read_handler(unsigned int esr, struct pt_regs *regs)
 {
 	int reg = (esr & ESR_ELx_CP15_32_ISS_RT_MASK) >> ESR_ELx_CP15_32_ISS_RT_SHIFT;
-- 
2.20.1

