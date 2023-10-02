Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19B6C7B514D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Oct 2023 13:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236742AbjJBL30 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Oct 2023 07:29:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236700AbjJBL3W (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Oct 2023 07:29:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E428DD;
        Mon,  2 Oct 2023 04:29:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D57E1C433C9;
        Mon,  2 Oct 2023 11:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696246156;
        bh=Rr8B+dxWn4Fc2in3F0SkUC70LhBVUMz18UV7OrElsJI=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
        b=IGXvrk12vUZSw19V62sYBIn8A4S3w/NcCqB89ZJb8B4eawxwd+PO727HC01vWxouU
         nLNgxiJ0Ygbebj9bftt7uwWvKdt7cc57/f9pnG6VqOTHCQu3c3hZvCJgZ+wDSCo7uO
         wqGPykikVyEcjm4eQ+kz3ZcsuisLjquHkSpYJKdvlbm+78r9+tvZqAGC+JlNgqvdT5
         Q2xw8LvYYEmOVx7DPIacQ/X/qC9cO3RPpQZgJn9xXBwhrhWuDhDzjmuCA7vLy0avfv
         7I2vPrmnLvokewtVAa0HD4dN/u0SyQqIExZfgHFBpbYDQWmPP/5WVH5t0dSIjWr3gR
         Qud+zhxz9dPZg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id B7369E784AF;
        Mon,  2 Oct 2023 11:29:16 +0000 (UTC)
From:   Joel Granados via B4 Relay 
        <devnull+j.granados.samsung.com@kernel.org>
Date:   Mon, 02 Oct 2023 13:30:37 +0200
Subject: [PATCH v3 2/7] arm: Remove now superfluous sentinel elem from
 ctl_table arrays
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231002-jag-sysctl_remove_empty_elem_arch-v3-2-606da2840a7a@samsung.com>
References: <20231002-jag-sysctl_remove_empty_elem_arch-v3-0-606da2840a7a@samsung.com>
In-Reply-To: <20231002-jag-sysctl_remove_empty_elem_arch-v3-0-606da2840a7a@samsung.com>
To:     Luis Chamberlain <mcgrof@kernel.org>, willy@infradead.org,
        josh@joshtriplett.org, Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Guo Ren <guoren@kernel.org>, Alexey Gladkov <legion@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
        linux-ia64@vger.kernel.org, linux-csky@vger.kernel.org,
        Joel Granados <j.granados@samsung.com>
X-Mailer: b4 0.13-dev-86aa5
X-Developer-Signature: v=1; a=openpgp-sha256; l=4081;
 i=j.granados@samsung.com; h=from:subject:message-id;
 bh=noJ2f5toULSK3D+m+WiinBKzEVnC7kJRWHJwSjStNEU=;
 b=owEB7QES/pANAwAKAbqXzVK3lkFPAcsmYgBlGqoT2tQ00qLwlU0pF99AimxPT3NSvuEoU5o3r
 ErsN0KqCAaJAbMEAAEKAB0WIQSuRwlXJeYxJc7LJ5C6l81St5ZBTwUCZRqqEwAKCRC6l81St5ZB
 TwztC/9795Kms0ahyuiZifUnGcF0XI4xsRGqRrXa27VtzuDrwO0ukaBXvlYD7ODDx/fRUTYHGAA
 3GTPbzTyN+niCpjPUwczSr5F6gJ1OW7UknG7REfzapRZidaaIjjAM1vSsgQlPuDWqfmVlhSSXA+
 0OMIA7+QnwwfjsdpMY+fqo7Z7HYkVolipDKJAI0AYULOB08BiUB7bjgSV24/oMHotxxfMiBkTB0
 IsuUT2JiLXfi/9dq3A2vUaiOTqMs6vB1AnDjPhrvLTEwvpvBJhzK3dvF/wrrYVcN4kRjiGd835w
 +MwVvDhWSmMqxAP/JJt88xKwjLhev0BgndjIoJvmKvSzVvu2x+nvDoitf0QHM/atrtrR+YPw30n
 ozpOdedQmam04sMQpTKEghZma3Ty/ILWzOVrZCzcBQCdzh5x6t28tJ2KdsUuCYZRWqi4rEv5B+U
 MbfO9gyd7CqJEzWl8wTveCs3D+8J3YmMBkqXiEiS+86ETGhrYYufmVDCWO16fsyU9TPcQ=
X-Developer-Key: i=j.granados@samsung.com; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for j.granados@samsung.com/default with auth_id=70
X-Original-From: Joel Granados <j.granados@samsung.com>
Reply-To: <j.granados@samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Joel Granados <j.granados@samsung.com>

This commit comes at the tail end of a greater effort to remove the
empty elements at the end of the ctl_table arrays (sentinels) which
will reduce the overall build time size of the kernel and run time
memory bloat by ~64 bytes per sentinel (further information Link :
https://lore.kernel.org/all/ZO5Yx5JFogGi%2FcBo@bombadil.infradead.org/)

Removed the sentinel as well as the explicit size from ctl_isa_vars. The
size is redundant as the initialization sets it. Changed
insn_emulation->sysctl from a 2 element array of struct ctl_table to a
simple struct. This has no consequence for the sysctl registration as it
is forwarded as a pointer. Removed sentinel from sve_defatul_vl_table,
sme_default_vl_table, tagged_addr_sysctl_table and
armv8_pmu_sysctl_table.

This removal is safe because register_sysctl_sz and register_sysctl use
the array size in addition to checking for the sentinel.

Signed-off-by: Joel Granados <j.granados@samsung.com>
---
 arch/arm/kernel/isa.c                | 4 ++--
 arch/arm64/kernel/armv8_deprecated.c | 8 +++-----
 arch/arm64/kernel/fpsimd.c           | 2 --
 arch/arm64/kernel/process.c          | 1 -
 drivers/perf/arm_pmuv3.c             | 1 -
 5 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/arch/arm/kernel/isa.c b/arch/arm/kernel/isa.c
index 20218876bef2..905b1b191546 100644
--- a/arch/arm/kernel/isa.c
+++ b/arch/arm/kernel/isa.c
@@ -16,7 +16,7 @@
 
 static unsigned int isa_membase, isa_portbase, isa_portshift;
 
-static struct ctl_table ctl_isa_vars[4] = {
+static struct ctl_table ctl_isa_vars[] = {
 	{
 		.procname	= "membase",
 		.data		= &isa_membase, 
@@ -35,7 +35,7 @@ static struct ctl_table ctl_isa_vars[4] = {
 		.maxlen		= sizeof(isa_portshift),
 		.mode		= 0444,
 		.proc_handler	= proc_dointvec,
-	}, {}
+	},
 };
 
 static struct ctl_table_header *isa_sysctl_header;
diff --git a/arch/arm64/kernel/armv8_deprecated.c b/arch/arm64/kernel/armv8_deprecated.c
index e459cfd33711..dd6ce86d4332 100644
--- a/arch/arm64/kernel/armv8_deprecated.c
+++ b/arch/arm64/kernel/armv8_deprecated.c
@@ -52,10 +52,8 @@ struct insn_emulation {
 	int min;
 	int max;
 
-	/*
-	 * sysctl for this emulation + a sentinal entry.
-	 */
-	struct ctl_table sysctl[2];
+	/* sysctl for this emulation */
+	struct ctl_table sysctl;
 };
 
 #define ARM_OPCODE_CONDTEST_FAIL   0
@@ -558,7 +556,7 @@ static void __init register_insn_emulation(struct insn_emulation *insn)
 	update_insn_emulation_mode(insn, INSN_UNDEF);
 
 	if (insn->status != INSN_UNAVAILABLE) {
-		sysctl = &insn->sysctl[0];
+		sysctl = &insn->sysctl;
 
 		sysctl->mode = 0644;
 		sysctl->maxlen = sizeof(int);
diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 91e44ac7150f..9afd0eb0cf88 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -589,7 +589,6 @@ static struct ctl_table sve_default_vl_table[] = {
 		.proc_handler	= vec_proc_do_default_vl,
 		.extra1		= &vl_info[ARM64_VEC_SVE],
 	},
-	{ }
 };
 
 static int __init sve_sysctl_init(void)
@@ -613,7 +612,6 @@ static struct ctl_table sme_default_vl_table[] = {
 		.proc_handler	= vec_proc_do_default_vl,
 		.extra1		= &vl_info[ARM64_VEC_SME],
 	},
-	{ }
 };
 
 static int __init sme_sysctl_init(void)
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 0fcc4eb1a7ab..610e13c3d41b 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -724,7 +724,6 @@ static struct ctl_table tagged_addr_sysctl_table[] = {
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_ONE,
 	},
-	{ }
 };
 
 static int __init tagged_addr_init(void)
diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
index 8fcaa26f0f8a..c0307b9181c3 100644
--- a/drivers/perf/arm_pmuv3.c
+++ b/drivers/perf/arm_pmuv3.c
@@ -1175,7 +1175,6 @@ static struct ctl_table armv8_pmu_sysctl_table[] = {
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_ONE,
 	},
-	{ }
 };
 
 static void armv8_pmu_register_sysctl_table(void)

-- 
2.30.2

