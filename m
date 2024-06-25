Return-Path: <linux-fsdevel+bounces-22389-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C54A7916BF5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 17:08:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E77BB1C23F2B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 15:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3F8317F4EE;
	Tue, 25 Jun 2024 15:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NqmuhU/F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FCD717625C;
	Tue, 25 Jun 2024 15:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719327768; cv=none; b=t6mubQ7AhgDp7Oc8WbLADunkoqYJuXXp1INVw+YL5jQrBSFOiWTo6wRsyYo2Nt+VWSDn5E45SXIZJQdLUt29Y73CRsqL12UR0IjBZjVaCt9r9uMNNO/wHhSBoDBPy5BdgLd/LYALXCvzOC+rq6q3lJ6HEo9ynDbWOVNcC9OasM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719327768; c=relaxed/simple;
	bh=Kh+IETSPL7qtolQq3lnlhkzFZ1gTXcIg84ZJjg4GwDo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hyfULp2NRP7LsssfHNQbteSsja4BwjiH1Qc/kxsNvpY7q2ORZJ4nq2M2nR3cUKzThmlfqPnVxlE0TlnAhSSFdTe/jSyCf1p17v3FevDitLPwZZkEAYf9DaXBHNnt4Z9Iw98urMKqgncHtY3BzbvMW9Ob8MZt3nUe7w3On5lVF5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NqmuhU/F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DDB4C32782;
	Tue, 25 Jun 2024 15:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719327767;
	bh=Kh+IETSPL7qtolQq3lnlhkzFZ1gTXcIg84ZJjg4GwDo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NqmuhU/Ff0h3LtISDpIR4LELNEW47+ErWU3dX0Kgb2WwBpg/UNPMZk/3pQ0PYB1VI
	 r/Sk2xkGmNKtOI/q8U2CgxZfhnnEM7SbHdW6fD9QDbpvh8GryRUlCOEwblVuQislXS
	 UMhR4JP8WmDWmFbOAPfVkDy3agDNMQ1EjqGGBc6b767cwqVtcNWutiFFFJhGEz3fU0
	 CKb3bK8zw9PtvzVDEpX94l+RGWbaYZkGsx+H35ODgE8LNeBd7SZN9OxBfAMa72WOoc
	 14vmisyaBHOWWM1XshDHqpHBiAEi+387qIU1euy1VJrilb7MSQekyQzo0Ak+tu/xDi
	 TWFJndJ8VyW4w==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 25 Jun 2024 15:57:46 +0100
Subject: [PATCH v9 18/39] arm64/mm: Handle GCS data aborts
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240625-arm64-gcs-v9-18-0f634469b8f0@kernel.org>
References: <20240625-arm64-gcs-v9-0-0f634469b8f0@kernel.org>
In-Reply-To: <20240625-arm64-gcs-v9-0-0f634469b8f0@kernel.org>
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
 Ross Burton <ross.burton@arm.com>, linux-arm-kernel@lists.infradead.org, 
 linux-doc@vger.kernel.org, kvmarm@lists.linux.dev, 
 linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.14-dev-d4707
X-Developer-Signature: v=1; a=openpgp-sha256; l=3651; i=broonie@kernel.org;
 h=from:subject:message-id; bh=Kh+IETSPL7qtolQq3lnlhkzFZ1gTXcIg84ZJjg4GwDo=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBmetuAlhPwwg74pRVVM89hL0m4VNM6ITOzanR6CdNZ
 sXVkSpCJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZnrbgAAKCRAk1otyXVSH0EpYB/
 9DrxYdrSx1M6UsWZ8hhevoQ6LhgfMS1f0ctPjflnEYxAuXwqOT+eZL/xrSaLvCcaVqiQz7y+sS5b5K
 3aQXMrDN2LkRkJbOxwsA89H6WTBhFvNPu0hfZiAAO2P6wEeEtdIs/efj9Jif5lxTx+4F75eu3qHJ7v
 9I7XDppZFUhJS9qA/xcfwrgR9YydpToq5a/cS2H7r3aGSYe6+NkWAIsyObTDjgxANhadUN06ef2rjx
 A8f/hqcVj+Wlm3QLrLdhjfHiy3woa+yVkGfxH1peBijH7Nu1oW6NYBqXizTNPkLbv7F3077Y/SUzPJ
 yCsShRq/pkkfBsZeVJieKkZPSga30a
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

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
 arch/arm64/mm/fault.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 451ba7cbd5ad..bdc28588163d 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -486,6 +486,14 @@ static void do_bad_area(unsigned long far, unsigned long esr,
 	}
 }
 
+static bool is_gcs_fault(unsigned long esr)
+{
+	if (!esr_is_data_abort(esr))
+		return false;
+
+	return ESR_ELx_ISS2(esr) & ESR_ELx_GCS;
+}
+
 static bool is_el0_instruction_abort(unsigned long esr)
 {
 	return ESR_ELx_EC(esr) == ESR_ELx_EC_IABT_LOW;
@@ -500,6 +508,25 @@ static bool is_write_abort(unsigned long esr)
 	return (esr & ESR_ELx_WNR) && !(esr & ESR_ELx_CM);
 }
 
+static bool is_invalid_gcs_access(struct vm_area_struct *vma, u64 esr)
+{
+	if (!system_supports_gcs())
+		return false;
+
+	if (unlikely(is_gcs_fault(esr))) {
+		/* GCS accesses must be performed on a GCS page */
+		if (!(vma->vm_flags & VM_SHADOW_STACK))
+			return true;
+		if (!(vma->vm_flags & VM_WRITE))
+			return true;
+	} else if (unlikely(vma->vm_flags & VM_SHADOW_STACK)) {
+		/* Only GCS operations can write to a GCS page */
+		return is_write_abort(esr);
+	}
+
+	return false;
+}
+
 static int __kprobes do_page_fault(unsigned long far, unsigned long esr,
 				   struct pt_regs *regs)
 {
@@ -535,6 +562,14 @@ static int __kprobes do_page_fault(unsigned long far, unsigned long esr,
 		/* It was exec fault */
 		vm_flags = VM_EXEC;
 		mm_flags |= FAULT_FLAG_INSTRUCTION;
+	} else if (is_gcs_fault(esr)) {
+		/*
+		 * The GCS permission on a page implies both read and
+		 * write so always handle any GCS fault as a write fault,
+		 * we need to trigger CoW even for GCS reads.
+		 */
+		vm_flags = VM_WRITE;
+		mm_flags |= FAULT_FLAG_WRITE;
 	} else if (is_write_abort(esr)) {
 		/* It was write fault */
 		vm_flags = VM_WRITE;
@@ -568,6 +603,14 @@ static int __kprobes do_page_fault(unsigned long far, unsigned long esr,
 	if (!vma)
 		goto lock_mmap;
 
+	if (is_invalid_gcs_access(vma, esr)) {
+		pr_crit("INVALID GCS\n");
+		vma_end_read(vma);
+		fault = 0;
+		si_code = SEGV_CPERR;
+		goto bad_area;
+	}
+
 	if (!(vma->vm_flags & vm_flags)) {
 		vma_end_read(vma);
 		fault = 0;

-- 
2.39.2


