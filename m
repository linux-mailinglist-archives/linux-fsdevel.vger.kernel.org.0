Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B395773267
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Aug 2023 00:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231337AbjHGWFO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Aug 2023 18:05:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbjHGWEb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Aug 2023 18:04:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2691E2723;
        Mon,  7 Aug 2023 15:03:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A9839622AF;
        Mon,  7 Aug 2023 22:03:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C7DCC433CA;
        Mon,  7 Aug 2023 22:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691445799;
        bh=Qk1oAglcSxLTK1OL1yhAbWpcUwaL4dga6Y2wJZdhO9Q=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=q+CeRmt5eL4xOsVp8DYzEjCQrkXw/FRSsEX9IqeCGwgoiPRyvijX8JYktrSyCByCn
         v0GIZk0MFIOkWmyVIz+zz9j8wjcgXE+jvhuNxKJhfqoJJ29DUqNrQEfAIYjOfncO+0
         1aPONlvSRFOF8m0JRwRrRo9j1bIbG+7cC7XO2g1sF7YkOXdKGVdvrOMfsSB6avpi8w
         /KDAXEhb6gyBm0rElUOe6CamNH6nu5oJKXjuYZIcZP86sNZOoLwWXLvRKDJ5n5k8NO
         UymMTSHfVU0v5ZtB1wUsAKrddDObxWWzb+pKYCB3dbQnysbLoU4ZU8Mme5p2msWO2F
         kzkJCIBxgWWpQ==
From:   Mark Brown <broonie@kernel.org>
Date:   Mon, 07 Aug 2023 23:00:22 +0100
Subject: [PATCH v4 17/36] arm64/mm: Handle GCS data aborts
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230807-arm64-gcs-v4-17-68cfa37f9069@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5613; i=broonie@kernel.org;
 h=from:subject:message-id; bh=Qk1oAglcSxLTK1OL1yhAbWpcUwaL4dga6Y2wJZdhO9Q=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBk0WmltRJFfUgILH1PT6OkleoCIbvpqrmljfh9p3gp
 3M4urASJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZNFppQAKCRAk1otyXVSH0N0YB/
 4oJGO83iuU3UKPBuOCvYuymDohFnbZxvKYTYQAtAbZ1aMpN3CEhsNeZWsoA38hszxT6LEjReBE6ALE
 fFnJ+TJ33CGsrhK6hvYp+DwxeZWBg7trVaihxN/iCI3VnqB+ANcuqMenK2rum+Yx1KTZ58fXds8+8+
 Kg60aa+H6tZW99rFzAtR2R031hmdcG2/O1jyIubnBVvBb6XAn5RrEnpVbNBsCaMfh1ZevQ82/77MMO
 ys3/QgA/6D8ghPS0SSDhlC67klX9IhwA4ScPIqNRv1ss62ycbaqnaUXKR+ffaeujZBrNz/hYUMD3pa
 su8gqWStW+ekIoquARGSe8T31nR4hO
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
 arch/arm64/mm/fault.c | 78 +++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 70 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 3fe516b32577..ec392207a475 100644
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
 
@@ -518,13 +555,18 @@ static bool is_el0_instruction_abort(unsigned long esr)
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
+	if (likely(!(vma->vm_flags & VM_SHADOW_STACK))) {
+		if (is_gcs_fault(esr))
+			return true;
+		return false;
+	}
+	if (is_gcs_fault(esr))
+		return false;
+	return is_write_abort(esr);
 }
 
 static int __kprobes do_page_fault(unsigned long far, unsigned long esr,
@@ -573,6 +615,13 @@ static int __kprobes do_page_fault(unsigned long far, unsigned long esr,
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
@@ -595,6 +644,19 @@ static int __kprobes do_page_fault(unsigned long far, unsigned long esr,
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
@@ -624,7 +686,7 @@ static int __kprobes do_page_fault(unsigned long far, unsigned long esr,
 		goto done;
 	}
 
-	fault = __do_page_fault(mm, vma, addr, mm_flags, vm_flags, regs);
+	fault = __do_page_fault(mm, vma, addr, mm_flags, vm_flags, esr, regs);
 
 	/* Quick path to respond to signals */
 	if (fault_signal_pending(fault, regs)) {

-- 
2.30.2

