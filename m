Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B384145DA6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jan 2020 22:22:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729418AbgAVVWZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Jan 2020 16:22:25 -0500
Received: from foss.arm.com ([217.140.110.172]:32828 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729299AbgAVVWY (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Jan 2020 16:22:24 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DC23D1424;
        Wed, 22 Jan 2020 13:22:23 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0F1183F52E;
        Wed, 22 Jan 2020 13:22:23 -0800 (PST)
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
Subject: [PATCH v5 11/12] KVM: arm64: BTI: Reset BTYPE when skipping emulated instructions
Date:   Wed, 22 Jan 2020 21:21:43 +0000
Message-Id: <20200122212144.6409-12-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200122212144.6409-1-broonie@kernel.org>
References: <20200122212144.6409-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Dave Martin <Dave.Martin@arm.com>

Since normal execution of any non-branch instruction resets the
PSTATE BTYPE field to 0, so do the same thing when emulating a
trapped instruction.

Branches don't trap directly, so we should never need to assign a
non-zero value to BTYPE here.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/kvm_emulate.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_emulate.h b/arch/arm64/include/asm/kvm_emulate.h
index 5efe5ca8fecf..05fb1b4e0fa2 100644
--- a/arch/arm64/include/asm/kvm_emulate.h
+++ b/arch/arm64/include/asm/kvm_emulate.h
@@ -470,10 +470,12 @@ static inline unsigned long vcpu_data_host_to_guest(struct kvm_vcpu *vcpu,
 
 static inline void kvm_skip_instr(struct kvm_vcpu *vcpu, bool is_wide_instr)
 {
-	if (vcpu_mode_is_32bit(vcpu))
+	if (vcpu_mode_is_32bit(vcpu)) {
 		kvm_skip_instr32(vcpu, is_wide_instr);
-	else
+	} else {
 		*vcpu_pc(vcpu) += 4;
+		*vcpu_cpsr(vcpu) &= ~PSR_BTYPE_MASK;
+	}
 
 	/* advance the singlestep state machine */
 	*vcpu_cpsr(vcpu) &= ~DBG_SPSR_SS;
-- 
2.20.1

