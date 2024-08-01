Return-Path: <linux-fsdevel+bounces-24767-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A02A0944C3D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 15:03:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B0611C25BFA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 13:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 076521B32A8;
	Thu,  1 Aug 2024 12:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hd+OXBiY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD501A3BD9;
	Thu,  1 Aug 2024 12:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722517163; cv=none; b=McCkZNGZsPyS21R4ZjMY+/2L9bfsQTrOxse6PDgpBYNbphtD9iZ58Sw+t2z+4G1Be4PZAGVBhZnVYW4XQJLr/5euXS++WZaRMD3jFcgXpJZ3Ng8LVmUhfUa1TOaQgdt5HJcCk6zdWkH74k2P2hnXs6mDqgnoSfQDdBb7cbe2+qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722517163; c=relaxed/simple;
	bh=mCYEqlOLyPN0qEO0joq8aJDaO3kSWJXCOekmmHiOO54=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R2duAU3hD44wzCMKkk4k92vt3jP4L3YCKmvZfnuBkmRxjjfLCz4UWkXrDJAxL4SQ7lfBY+SEqhlfrl2PTGqIR/mnb4x26eksu9uZ+pZyE06PgLwRbY4Xemk/6qhnPmGZRowy2oJzQRzmWFwqYEE4gIMtiEXeTZQajW5Nx0cMnQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hd+OXBiY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82677C4AF0A;
	Thu,  1 Aug 2024 12:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722517162;
	bh=mCYEqlOLyPN0qEO0joq8aJDaO3kSWJXCOekmmHiOO54=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hd+OXBiYmYQ7Y//fkA4aEYz+PfLaULR587Lip2lLru+MeE0zfjQPmmTmggZAOSb6W
	 Qr/IsWI1qHO3AyRzzFrYBNju3NZhRMbESgLPxjvupiritZVxcIdSBeZl1MoIipOJ41
	 qX5O9TlfdXxTXaPIlXxjFiZTknTnqaLW2wAhpigDusoe1aoMYhecrtjrCVxQ47zTtR
	 j930gjTJ2dbrJ0EeIjSPhq3YhBPyS1VyW4+YMIUeCMHzfzxuRcdu7Irekyq+UOT7Gk
	 o3qmQIQ4qW+FdbvIS/arc20i2UI1n+WQCyuBoo8kBohmY7nlHK41NtvjYN2Q1E0mnW
	 UJGRnJzPbvaKw==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 01 Aug 2024 13:06:45 +0100
Subject: [PATCH v10 18/40] arm64/mm: Handle GCS data aborts
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240801-arm64-gcs-v10-18-699e2bd2190b@kernel.org>
References: <20240801-arm64-gcs-v10-0-699e2bd2190b@kernel.org>
In-Reply-To: <20240801-arm64-gcs-v10-0-699e2bd2190b@kernel.org>
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
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=openpgp-sha256; l=3621; i=broonie@kernel.org;
 h=from:subject:message-id; bh=mCYEqlOLyPN0qEO0joq8aJDaO3kSWJXCOekmmHiOO54=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBmq4YTtyLs+vnIQBWnGfIVH8o2DnS3kjKCvjmb12p9
 SZmL+AaJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZquGEwAKCRAk1otyXVSH0AxZB/
 wPhepfGMuxiO9PuNnOv6YrfgeBlsRwJvM/VUvi67zpKMpsBaAkgbb/2VWw/grqfKYNmhgW1gumwF6C
 tyVVQsT+s/EfexLl6BA26CVY7uXXlIp/0kXkFbMUqtlL1VQTL36JJqAqyXzSdCYCkeXmLh+wGD0f9e
 Kg5RUk1MX0Ch9escuRKahaaq7kI6zY1uH5zMeldSwh1bmAGX7N+kYxbINBnbp5LAqIY+DwUtEEN7C2
 tsVyqoltrGCYqmb1W65kAyo5UKWnZ0QQ38AdwXRZiRNFImkRvBkwcUMZSX49aWKWsaAV98CGwC1Fwj
 3QmFhr+QSiT5JnnL9eK6KF8bGEqgni
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
 arch/arm64/mm/fault.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 451ba7cbd5ad..0973dd09f11a 100644
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
@@ -568,6 +603,13 @@ static int __kprobes do_page_fault(unsigned long far, unsigned long esr,
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


