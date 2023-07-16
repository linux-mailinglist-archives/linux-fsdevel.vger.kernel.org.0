Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E76A7557CB
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Jul 2023 23:56:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231292AbjGPV4c (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 16 Jul 2023 17:56:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231206AbjGPVzy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 16 Jul 2023 17:55:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFE572119;
        Sun, 16 Jul 2023 14:54:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7B4D160ED6;
        Sun, 16 Jul 2023 21:54:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27304C433CD;
        Sun, 16 Jul 2023 21:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689544483;
        bh=Ic5184HtLjp7BRJp2h4YHI8S+wCBGgxplC9dANJy2o0=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=RelYncrnGny+EAIlfhvuL2ShmSOMTtQz9t2jp4p0osbukgPqBuUZYVANDMaD8K74z
         bYSe6oyv9RfNlLF9wz9y7pqkyTDLJP9kscdXHnI5m5Xrn64tgu8wukMhliN8npSrjV
         BWXz1aweiGD4JBLEouYmkqMQJff4w9YknUECZ6bHn/AoQ0TZOW2n2N6+12vwWB/1D/
         OfXu6akRY27HEUpErilhIpLqIUIaX+gJ4PwoS433nwRFGIg+SwdzyjKOs/IQIVJXh/
         ALASiXAB7eJzX8QGDEET2oFy2GpWZJpLTN+DDDQE9w7MKMU++Nhk3l3xKBCgYHJt6v
         bS+aWM3JZxT6w==
From:   Mark Brown <broonie@kernel.org>
Date:   Sun, 16 Jul 2023 22:51:14 +0100
Subject: [PATCH 18/35] arm64/mm: Handle GCS data aborts
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230716-arm64-gcs-v1-18-bf567f93bba6@kernel.org>
References: <20230716-arm64-gcs-v1-0-bf567f93bba6@kernel.org>
In-Reply-To: <20230716-arm64-gcs-v1-0-bf567f93bba6@kernel.org>
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
X-Mailer: b4 0.13-dev-099c9
X-Developer-Signature: v=1; a=openpgp-sha256; l=5561; i=broonie@kernel.org;
 h=from:subject:message-id; bh=Ic5184HtLjp7BRJp2h4YHI8S+wCBGgxplC9dANJy2o0=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBktGadjCcwsj3WTxSZ76WapUXTwRGVNGO3X5o1MiEr
 UcRBdd6JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZLRmnQAKCRAk1otyXVSH0EUsB/
 0Y2q2IvD26b2AqosjuYfhXApUyZKIxrJGf5qPB9eQjeURpZjoVTQowhU4IE6kQbT4thl/xF8yO0K2c
 aC2sWmWA+cTNsD38B1GCLo4NG6DPxbzsMcMyrTgV7sxHT2V0LxyJXff2xzdJ+JMCan/00Fuw+YB1A0
 gHLIqHbzExbVwdBpDJ/47KeR32ti3bHPFPL9zO4+3qmnVBEzKbHcOnmpkNuuoVfMO3hVGiAHarBjcV
 Dbd5Mg8tYgg4VuE7ih68Tu+7ebUKIHriLwZljkBYHMHhUNlcoz0rx/Lbp4anYXnv1culJCySnMUY+D
 V5l28lm3yjxrMkwHTtiMzOuVPj9dIz
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

All GCS operations at EL0 must happen on a page which is marked as
having UnprivGCS access, including read operations.  If a GCS operation
attempts to access a page without this then it will generate a data
abort with the GCS bit set in ESR_EL1.ISS2.

EL0 may validly generate such faults, for example due to copy on write
which will cause the GCS data to be stored in a read only page with no
GCS permissions until the actual copy happens.  Since UnprivGCS allows
both reads and writes to the GCS (though only through GCS operations) we
need to ensure that the memory management subsystem handles GCS accesses
as writes at all times.  Do this by adding FAULT_FLAG_WRITE to any GCS
page faults, adding handling to ensure that invalid cases are identfied
as such early so the memory management core does not think they will
succeed.  The core cannot distinguish between VMAs which are generally
writeable and VMAs which are only writeable through GCS operations.

EL1 may validly write to EL0 GCS for management purposes (eg, while
initialising with cap tokens).

We also report any GCS faults in VMAs not marked as part of a GCS as
access violations, causing a fault to be delivered to userspace if it
attempts to do GCS operations outside a GCS.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/mm/fault.c | 75 +++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 67 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 3fe516b32577..facade819abb 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -494,13 +494,30 @@ static void do_bad_area(unsigned long far, unsigned long esr,
 	}
 }
 
+/*
+ * Note: not valid for EL1 DC IVAC, but we never use that such that it
+ * should fault. EL0 cannot issue DC IVAC (undef).
+ */
+static bool is_write_abort(unsigned long esr)
+{
+	return (esr & ESR_ELx_WNR) && !(esr & ESR_ELx_CM);
+}
+
+static bool is_gcs_fault(unsigned long esr)
+{
+	if (!esr_is_data_abort(esr))
+		return false;
+
+	return ESR_ELx_ISS2(esr) & ESR_ELx_GCS;
+}
+
 #define VM_FAULT_BADMAP		((__force vm_fault_t)0x010000)
 #define VM_FAULT_BADACCESS	((__force vm_fault_t)0x020000)
 
 static vm_fault_t __do_page_fault(struct mm_struct *mm,
 				  struct vm_area_struct *vma, unsigned long addr,
 				  unsigned int mm_flags, unsigned long vm_flags,
-				  struct pt_regs *regs)
+				  unsigned long esr, struct pt_regs *regs)
 {
 	/*
 	 * Ok, we have a good vm_area for this memory access, so we can handle
@@ -510,6 +527,26 @@ static vm_fault_t __do_page_fault(struct mm_struct *mm,
 	 */
 	if (!(vma->vm_flags & vm_flags))
 		return VM_FAULT_BADACCESS;
+
+	if (vma->vm_flags & VM_SHADOW_STACK) {
+		/*
+		 * Writes to a GCS must either be generated by a GCS
+		 * operation or be from EL1.
+		 */
+		if (is_write_abort(esr) &&
+		    !(is_gcs_fault(esr) || is_el1_data_abort(esr)))
+			return VM_FAULT_BADACCESS;
+	} else {
+		/*
+		 * GCS faults should never happen for pages that are
+		 * not part of a GCS and the operation being attempted
+		 * can never succeed.
+		 */
+		if (is_gcs_fault(esr))
+			return VM_FAULT_BADACCESS;
+	}
+
+
 	return handle_mm_fault(vma, addr, mm_flags, regs);
 }
 
@@ -518,13 +555,15 @@ static bool is_el0_instruction_abort(unsigned long esr)
 	return ESR_ELx_EC(esr) == ESR_ELx_EC_IABT_LOW;
 }
 
-/*
- * Note: not valid for EL1 DC IVAC, but we never use that such that it
- * should fault. EL0 cannot issue DC IVAC (undef).
- */
-static bool is_write_abort(unsigned long esr)
+static bool is_invalid_el0_gcs_access(struct vm_area_struct *vma, u64 esr)
 {
-	return (esr & ESR_ELx_WNR) && !(esr & ESR_ELx_CM);
+	if (!system_supports_gcs())
+		return false;
+	if (likely(!(vma->vm_flags & VM_SHADOW_STACK)))
+		return false;
+	if (is_gcs_fault(esr))
+		return false;
+	return is_write_abort(esr);
 }
 
 static int __kprobes do_page_fault(unsigned long far, unsigned long esr,
@@ -573,6 +612,13 @@ static int __kprobes do_page_fault(unsigned long far, unsigned long esr,
 		/* If EPAN is absent then exec implies read */
 		if (!cpus_have_const_cap(ARM64_HAS_EPAN))
 			vm_flags |= VM_EXEC;
+		/*
+		 * Upgrade read faults to write faults, GCS reads must
+		 * occur on a page marked as GCS so we need to trigger
+		 * copy on write always.
+		 */
+		if (is_gcs_fault(esr))
+			mm_flags |= FAULT_FLAG_WRITE;
 	}
 
 	if (is_ttbr0_addr(addr) && is_el1_permission_fault(addr, esr, regs)) {
@@ -595,6 +641,19 @@ static int __kprobes do_page_fault(unsigned long far, unsigned long esr,
 	if (!vma)
 		goto lock_mmap;
 
+	/*
+	 * We get legitimate write faults for GCS pages from GCS
+	 * operations and from EL1 writes to EL0 pages but just plain
+	 * EL0 writes are invalid.  Specifically check for this since
+	 * as a result of upgrading read faults to write faults for
+	 * CoW the mm core isn't able to distinguish these invalid
+	 * writes.
+	 */
+	if (is_invalid_el0_gcs_access(vma, esr)) {
+		vma_end_read(vma);
+		goto lock_mmap;
+	}
+
 	if (!(vma->vm_flags & vm_flags)) {
 		vma_end_read(vma);
 		goto lock_mmap;
@@ -624,7 +683,7 @@ static int __kprobes do_page_fault(unsigned long far, unsigned long esr,
 		goto done;
 	}
 
-	fault = __do_page_fault(mm, vma, addr, mm_flags, vm_flags, regs);
+	fault = __do_page_fault(mm, vma, addr, mm_flags, vm_flags, esr, regs);
 
 	/* Quick path to respond to signals */
 	if (fault_signal_pending(fault, regs)) {

-- 
2.30.2

