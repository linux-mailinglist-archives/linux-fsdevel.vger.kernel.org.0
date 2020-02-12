Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75A4015B109
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2020 20:29:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729201AbgBLT3h (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Feb 2020 14:29:37 -0500
Received: from foss.arm.com ([217.140.110.172]:37194 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729169AbgBLT3g (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Feb 2020 14:29:36 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 338BD106F;
        Wed, 12 Feb 2020 11:29:36 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 899633F68E;
        Wed, 12 Feb 2020 11:29:35 -0800 (PST)
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
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v6 11/11] arm64: mm: Display guarded pages in ptdump
Date:   Wed, 12 Feb 2020 19:29:06 +0000
Message-Id: <20200212192906.53366-12-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200212192906.53366-1-broonie@kernel.org>
References: <20200212192906.53366-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

v8.5-BTI introduces the GP field in stage 1 translation tables which
indicates that blocks and pages with it set are guarded pages for which
branch target identification checks should be performed. Decode this
when dumping the page tables to aid debugging.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/mm/dump.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/mm/dump.c b/arch/arm64/mm/dump.c
index 860c00ec8bd3..78163b7a7dde 100644
--- a/arch/arm64/mm/dump.c
+++ b/arch/arm64/mm/dump.c
@@ -145,6 +145,11 @@ static const struct prot_bits pte_bits[] = {
 		.val	= PTE_UXN,
 		.set	= "UXN",
 		.clear	= "   ",
+	}, {
+		.mask	= PTE_GP,
+		.val	= PTE_GP,
+		.set	= "GP",
+		.clear	= "  ",
 	}, {
 		.mask	= PTE_ATTRINDX_MASK,
 		.val	= PTE_ATTRINDX(MT_DEVICE_nGnRnE),
-- 
2.20.1

