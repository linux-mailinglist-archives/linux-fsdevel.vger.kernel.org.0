Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2605279395C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Sep 2023 12:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238619AbjIFKEf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Sep 2023 06:04:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235639AbjIFKEN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Sep 2023 06:04:13 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43707E64;
        Wed,  6 Sep 2023 03:04:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C79FFC43395;
        Wed,  6 Sep 2023 10:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693994648;
        bh=6qyahIWMDqGumydP6jatTEqBGZFg9bKWNldP/JMCBf4=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
        b=WDKQgCGk1ewitC2ljOHvuoZfX0PunKpEPswAKjvOM4mw6dld7GWu4qkxJRJUBAZ+D
         CE7SALO/Y0Rs3HnRxEWzMYjiwHbneecI+B2QCfDT8Z9TE8cRvCn19CBHrYrrEF8ZE5
         AiAJmUIbGgc6VDlemn+Ou79kmuLsMIaZr3Ck8h9C09+TVMmgDHE6EWIIZ8hcltmePZ
         XPs7vdU1DPjNirlWDGYFSEOC5CPGZpKtYTccRddwUe0Z3zpJL5YpMoTrdcMhr1ZjgF
         FmsDrh4EbHHkGC+0sbrqRTmcV3KMSE9zKjJqHiCXONTChGKVfv7RWgJEy22GCNCagG
         Ipmt14Py4IoXA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id AD86DEB8FA5;
        Wed,  6 Sep 2023 10:04:08 +0000 (UTC)
From:   Joel Granados via B4 Relay 
        <devnull+j.granados.samsung.com@kernel.org>
Date:   Wed, 06 Sep 2023 12:03:23 +0200
Subject: [PATCH 2/8] arm: Remove sentinel elem from ctl_table arrays
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230906-jag-sysctl_remove_empty_elem_arch-v1-2-3935d4854248@samsung.com>
References: <20230906-jag-sysctl_remove_empty_elem_arch-v1-0-3935d4854248@samsung.com>
In-Reply-To: <20230906-jag-sysctl_remove_empty_elem_arch-v1-0-3935d4854248@samsung.com>
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
        Guo Ren <guoren@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
        linux-ia64@vger.kernel.org, linux-csky@vger.kernel.org,
        Joel Granados <j.granados@samsung.com>
X-Mailer: b4 0.13-dev-86aa5
X-Developer-Signature: v=1; a=openpgp-sha256; l=4110;
 i=j.granados@samsung.com; h=from:subject:message-id;
 bh=kRRgU9TB4640um/mWRntJEhdx6NG5ds+BwxX9jXrRXA=;
 b=owEB7QES/pANAwAKAbqXzVK3lkFPAcsmYgBk+E6Ur2J0kuQcNZObNxMe0aJ2hWc7iqqapxvuF
 OwJdlhaURSJAbMEAAEKAB0WIQSuRwlXJeYxJc7LJ5C6l81St5ZBTwUCZPhOlAAKCRC6l81St5ZB
 T1yUC/4yflkwsD8iS/7Czi88MHtKqSjX9ywAVic2vtw9U3RHdGW1Cpc9iSXsTYtOI/FHD7Wtnb3
 fSLNGEliGcqaGR9KNJbwTfnCFZg7LquUXjT2ecnK7FdliQNOvehRbMkkJUj5awgq/g14eC4cpPq
 27uxAt9wOVU35+G1zNJybSMVlhYlRBFX+Mt9XlFB6zLXeAyIR5TMidTAiw9EHNQ1UpP24K14cd+
 XBTab+hvuXZ8gu4koUQS+ASkCRBVn6VdA5ZWeh5w5YoiPemdG4r5vfIDDl4oz6RQ5Ysm9Iq5swx
 9sByh27nj7dLaFs+8N59sQoSiICG4FKxxj9V9N94wAmol2bpNdFqQSYq+RQnMvet1FsUWpHUrdY
 +Q4tMhoT1vzhKpOmX+5dZ23riHPK7gEC+nRb2wBafDrBrk+zirIqkyMaN0iULzIVKo8ffkoweDy
 6Tz91Srx2S1YeBzrf1azOZwHUho/4ZRuirvEAjww3hnI2HniWQj7Oud+TjCR8MwiCFOqg=
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
size is redundant as the initialization sets it.
Changed insn_emulation->sysctl from a 2 element array of struct
ctl_table to a simple struct. This has no consequence for the sysctl
registration as it is forwarded as a pointer.
Removed sentinel from sve_defatul_vl_table, sme_default_vl_table,
tagged_addr_sysctl_table and armv8_pmu_sysctl_table.

Signed-off-by: Joel Granados <j.granados@samsung.com>
---
 arch/arm/kernel/isa.c                | 4 ++--
 arch/arm64/kernel/armv8_deprecated.c | 8 +++-----
 arch/arm64/kernel/fpsimd.c           | 6 ++----
 arch/arm64/kernel/process.c          | 3 +--
 drivers/perf/arm_pmuv3.c             | 3 +--
 5 files changed, 9 insertions(+), 15 deletions(-)

diff --git a/arch/arm/kernel/isa.c b/arch/arm/kernel/isa.c
index 20218876bef2..0b9c28077092 100644
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
+	}
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
index 91e44ac7150f..db3ad1ba8272 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -588,8 +588,7 @@ static struct ctl_table sve_default_vl_table[] = {
 		.mode		= 0644,
 		.proc_handler	= vec_proc_do_default_vl,
 		.extra1		= &vl_info[ARM64_VEC_SVE],
-	},
-	{ }
+	}
 };
 
 static int __init sve_sysctl_init(void)
@@ -612,8 +611,7 @@ static struct ctl_table sme_default_vl_table[] = {
 		.mode		= 0644,
 		.proc_handler	= vec_proc_do_default_vl,
 		.extra1		= &vl_info[ARM64_VEC_SME],
-	},
-	{ }
+	}
 };
 
 static int __init sme_sysctl_init(void)
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 0fcc4eb1a7ab..48861cdc3aae 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -723,8 +723,7 @@ static struct ctl_table tagged_addr_sysctl_table[] = {
 		.proc_handler	= proc_dointvec_minmax,
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_ONE,
-	},
-	{ }
+	}
 };
 
 static int __init tagged_addr_init(void)
diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
index e5a2ac4155f6..c4aa6a8d1b05 100644
--- a/drivers/perf/arm_pmuv3.c
+++ b/drivers/perf/arm_pmuv3.c
@@ -1172,8 +1172,7 @@ static struct ctl_table armv8_pmu_sysctl_table[] = {
 		.proc_handler	= armv8pmu_proc_user_access_handler,
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_ONE,
-	},
-	{ }
+	}
 };
 
 static void armv8_pmu_register_sysctl_table(void)

-- 
2.30.2

