Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5992172589
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Feb 2020 18:49:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730733AbgB0Roo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Feb 2020 12:44:44 -0500
Received: from foss.arm.com ([217.140.110.172]:55676 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730705AbgB0Ron (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Feb 2020 12:44:43 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E5A42106F;
        Thu, 27 Feb 2020 09:44:42 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5BC5A3F73B;
        Thu, 27 Feb 2020 09:44:42 -0800 (PST)
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
Subject: [PATCH v8 09/11] arm64: BTI: Reset BTYPE when skipping emulated instructions
Date:   Thu, 27 Feb 2020 17:44:15 +0000
Message-Id: <20200227174417.23722-10-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200227174417.23722-1-broonie@kernel.org>
References: <20200227174417.23722-1-broonie@kernel.org>
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
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/kernel/traps.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index 3c07a7074145..52ed261e7739 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -335,6 +335,8 @@ void arm64_skip_faulting_instruction(struct pt_regs *regs, unsigned long size)
 
 	if (compat_user_mode(regs))
 		advance_itstate(regs);
+	else
+		regs->pstate &= ~PSR_BTYPE_MASK;
 }
 
 static LIST_HEAD(undef_hook);
-- 
2.20.1

