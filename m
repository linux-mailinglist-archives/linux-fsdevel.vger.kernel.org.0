Return-Path: <linux-fsdevel+bounces-27682-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B8F89635CB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 01:35:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C01A01F22553
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 23:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 844081B5320;
	Wed, 28 Aug 2024 23:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uyWnGPMc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA68C1AE020;
	Wed, 28 Aug 2024 23:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724887852; cv=none; b=rDk7Jf0XQ7A+kz4fI2dhFkbawPeNNkCrD2mzKzdOK5E1W0ELCzRTp5uOjSUsG4IOCqO6BSqo04HxAkvALlT3nfjLqIGaHU27xsuqHWSMnUhBgmRCYOi5OQo8d2DsMYu83UNIPc5ZbTFmm+awuZFaIPcuvd011kUlBBztygoSBk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724887852; c=relaxed/simple;
	bh=cSumirTUCRKtD61yeizpYh0xonxdiRS3lfiiFjRSehM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RSrYTqR7pPx746clKtQSMy+D4Djkr5qsmj41peNtYpy7jiGCGS3yd6vEs+oYoLSo1cDcrYpkYuK7I6PR2mkChKGceWhiFZbnxLizcQblurFJxRTr5o51qUi31e63dJKBMClAwRvoSp80U3Z7r4q01bGr+OVsSf7TxcJc4/kp4os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uyWnGPMc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A19DC4CEC7;
	Wed, 28 Aug 2024 23:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724887851;
	bh=cSumirTUCRKtD61yeizpYh0xonxdiRS3lfiiFjRSehM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=uyWnGPMc5mbboXTpbrmBI2+pKq2ERDPePO/pWj+dJ8UdkJsjFTMv1GibdnvNPRrqK
	 LhIVbe51O7O9wuGxaJdBRYoAZI5ZPpa3xd/lCfZvxjN9uIt9LbdeGWaDVp78H58pBL
	 3/PhMftTH4DGf/WeV/kzJCIsWTq5JnMMxFZUfHhzI4KU/Og46scJoRfm4THyKV8JR2
	 N8AmTBjtJDc3tcsYCpbYR4fDxTF/s9CDk7VKR5Ug/XIGhvrWuoSUbmbbTbg+XzuWb+
	 b9iEafKjbkrj3n/IvDe/yqXKdhLC1Ai+FshkX2Nm1z8iqIkwjZKhQE6b81bFOf0LCH
	 ct/X5e1Ccf7sA==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 29 Aug 2024 00:27:35 +0100
Subject: [PATCH v12 19/39] arm64/mm: Handle GCS data aborts
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240829-arm64-gcs-v12-19-42fec947436a@kernel.org>
References: <20240829-arm64-gcs-v12-0-42fec947436a@kernel.org>
In-Reply-To: <20240829-arm64-gcs-v12-0-42fec947436a@kernel.org>
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
 Ross Burton <ross.burton@arm.com>, 
 Yury Khrustalev <yury.khrustalev@arm.com>, 
 Wilco Dijkstra <wilco.dijkstra@arm.com>, 
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
 kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-mm@kvack.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=openpgp-sha256; l=3656; i=broonie@kernel.org;
 h=from:subject:message-id; bh=cSumirTUCRKtD61yeizpYh0xonxdiRS3lfiiFjRSehM=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBmz7KH/LSvLtk/OSdB9E9vHbRin2oi8cGJ9yFB0MM4
 9vjv3rSJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZs+yhwAKCRAk1otyXVSH0FJUB/
 sG7fdRQl091vTLIo0rKV/SrbgEQGvseRyunCN4IYeMAJFfrGVdDik+4m+kIlVDdb0gP3NxYzDhefV1
 qvaLLyVRPPM1c7xtG2zenPFb+DHwjbsl1DezAlW8Wao6tNn/Pc81sxORQqNkj6E9ioBN6Syp1/qlmF
 GV5TT468xhXKCFo/L6KpkpjR04b/YWSYSR0L9iLt14j+PZycnJ9nY+VJ6qErjUqwib1yeHgNmpyYLS
 BWfP413MvtH7XYLF49lq2ySWdz2lQPdxMFxoERkIxk6jff3Af9kKYIViqlUEYf26mBILtkqxQ77AhT
 pH3hZQedHoun/Da8CGckiactQxvubk
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

Reviewed-by: Thiago Jung Bauermann <thiago.bauermann@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/mm/fault.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 451ba7cbd5ad..387f991e6e36 100644
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
@@ -500,6 +508,23 @@ static bool is_write_abort(unsigned long esr)
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
+	} else if (unlikely(vma->vm_flags & VM_SHADOW_STACK)) {
+		/* Only GCS operations can write to a GCS page */
+		return esr_is_data_abort(esr) && is_write_abort(esr);
+	}
+
+	return false;
+}
+
 static int __kprobes do_page_fault(unsigned long far, unsigned long esr,
 				   struct pt_regs *regs)
 {
@@ -535,6 +560,14 @@ static int __kprobes do_page_fault(unsigned long far, unsigned long esr,
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
@@ -568,6 +601,13 @@ static int __kprobes do_page_fault(unsigned long far, unsigned long esr,
 	if (!vma)
 		goto lock_mmap;
 
+	if (is_invalid_gcs_access(vma, esr)) {
+		vma_end_read(vma);
+		fault = 0;
+		si_code = SEGV_ACCERR;
+		goto bad_area;
+	}
+
 	if (!(vma->vm_flags & vm_flags)) {
 		vma_end_read(vma);
 		fault = 0;

-- 
2.39.2


