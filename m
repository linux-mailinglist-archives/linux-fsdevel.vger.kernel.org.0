Return-Path: <linux-fsdevel+bounces-30593-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AB8398C8ED
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 01:06:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA92B1C21DE7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 23:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2A291D0421;
	Tue,  1 Oct 2024 23:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h5QOvsyH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5783D1CF2BE;
	Tue,  1 Oct 2024 23:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727823819; cv=none; b=qmGknbq2AHtxWEOthI287xsOmwv8JZ9Nv+Iybogkpoueiv1pE3SjBK9JkdnzMVCjdTrJPBSBh0LxXTiAKwrutXhK8GE68HHrYZAyh5gRWeSWI/cFtVDOcxZDD86s7xtbiT8O8dPXwgaQf9g25nYfrvwoY0tE8wG0+71ncFif/a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727823819; c=relaxed/simple;
	bh=JwTS5J5Kz+XCxYDRc3FG3N1klYZC99PAyz93oxxWHns=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Xl340ZXE1vUbe1pJ2Tz33fDDnLtrnYD1w5NHEcbFdIPr7l+sniamvlpxcw3p1Za6LTPdhEpy49nX1VQBqSRMUTl8jp01KiQsXjERf3kov3ahTLbjFXN8DSAU6zlnh67HpiEX83D3qNjzb5QRrNFIxwWMBLp6sst0flRErSpVfLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h5QOvsyH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B91A5C4CEC6;
	Tue,  1 Oct 2024 23:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727823818;
	bh=JwTS5J5Kz+XCxYDRc3FG3N1klYZC99PAyz93oxxWHns=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=h5QOvsyHwmwYJXTikpeXsVEp2A3UPoVjGZRUucHDnIEP8s20RwqCtfvtaEgYASJ3A
	 4VvT7Z9FkWpjGLRRUyAM0E57+nFfV/1smmkjKGkRZKQARGtcXv4Kr/B1Fg5EqqXPTT
	 w7iMpC+tcgCrK+qsiDR7XnELMA4PkJgDckI9vpw8SVgbifNvpYEuLSdt70HOnbcLrh
	 bILOGqSFtZOKo1haHLpTrtPKpk0NC0HS0Pd2sgi3K8cPhb+7HZxIGLJOcB3QJHfl0A
	 Gos56B/AegT6wsD2YwKq8Ie1aAdRX49w3baVX3709fSna41T6qIRdgrbFb2IW97c4V
	 0q6PzQ7x+JAPg==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 01 Oct 2024 23:58:59 +0100
Subject: [PATCH v13 20/40] arm64/mm: Handle GCS data aborts
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241001-arm64-gcs-v13-20-222b78d87eee@kernel.org>
References: <20241001-arm64-gcs-v13-0-222b78d87eee@kernel.org>
In-Reply-To: <20241001-arm64-gcs-v13-0-222b78d87eee@kernel.org>
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
 Ross Burton <ross.burton@arm.com>, David Spickett <david.spickett@arm.com>, 
 Yury Khrustalev <yury.khrustalev@arm.com>, 
 Wilco Dijkstra <wilco.dijkstra@arm.com>, 
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
 kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-mm@kvack.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=openpgp-sha256; l=3733; i=broonie@kernel.org;
 h=from:subject:message-id; bh=JwTS5J5Kz+XCxYDRc3FG3N1klYZC99PAyz93oxxWHns=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBm/H7TVZ3jDKeIyJFS2xkZycVzFdIgkZ/2MVMSxegg
 PracWFmJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZvx+0wAKCRAk1otyXVSH0PPFB/
 9jOVBZ0sZYLFYt8CYSgFwth5bQAMffCYR65UIbAKTDAZV8czeEm1xDTBVqLzh2y8cJ8L9rksWGRzsa
 KoNNdusUYbP0WwOzwiB8f26x4k5gKBP8dzKhvHobyjoVwM9dwHJ1P+31Rnk9S2VC0HlJ12ukGOll7A
 CZczYl0vb1teCaug4ldvi8DJRkAAMotUN8oeVWz1J0E9GwHb+eMDvTL9igdY9wrw4EyL8kkGp2K8aF
 B+pBMS0HXzUFSpXDbnSX5eVKfGA1myQSsEM0KQsGSA4aaHTZ8Guexvn78tQkU7ofyEMejYY/2DYTmb
 IZnC/hzjnKbZohafBaYTyRcPVaFiYq
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
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/mm/fault.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 8b281cf308b3..c2f89a678ac0 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -504,6 +504,14 @@ static bool fault_from_pkey(unsigned long esr, struct vm_area_struct *vma,
 			false);
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
@@ -518,6 +526,23 @@ static bool is_write_abort(unsigned long esr)
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
@@ -554,6 +579,14 @@ static int __kprobes do_page_fault(unsigned long far, unsigned long esr,
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
@@ -587,6 +620,13 @@ static int __kprobes do_page_fault(unsigned long far, unsigned long esr,
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


