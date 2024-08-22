Return-Path: <linux-fsdevel+bounces-26613-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DE4695A9B2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 03:20:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1308EB2331D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 01:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B50EB1B947;
	Thu, 22 Aug 2024 01:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o8FiYm5l"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125B93A8CE;
	Thu, 22 Aug 2024 01:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724289537; cv=none; b=J3nmxcEu7SgDrHCQyIBVFYqv/KEJ9zUyYjJ3lq+NmjctzBAz4O5DRs1LF0lvjhgDkfa4kPf/9U9oalG8aJvzsEBdc3G9Ax94vhX7tO4R0LLOAGL6Br/4x+cNGpaDP2OjmJxoCv6Tv2SU6ulbggBWnVDYyT88fsSAorocfKT+Tkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724289537; c=relaxed/simple;
	bh=+TK11w/7oyUnbPsKo/oQrSN1KO+dOWD16qqEJpANLmY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cMPYSPNwfEa+NwSK46MvUPap1AKpO0SUnbcgK18coLF+RvyXrumYkY6eSMva4h90Awm2YOg+EMrDnSLQD7g3JrJ1Ljjs4kZfpqOvqwcYAAIk+4551YsOP4fpqr32Ckcnj+Qko/O6BNaID71OB7d60n+SK/sk/2spNlycwdrZiDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o8FiYm5l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 508C6C32782;
	Thu, 22 Aug 2024 01:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724289536;
	bh=+TK11w/7oyUnbPsKo/oQrSN1KO+dOWD16qqEJpANLmY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=o8FiYm5l+0/cHZX1HsRAyIUtvG4tyaQDkbJEdTcNPq4sjwiKMQiyR5Z1SUDwsKqxl
	 rWQ1ACNxfahd8IJWovns2gUvp5Hbr4rpC8H15lv5Z9BL57fNDKdbht2UExHQoHI6a3
	 9CRlrx/L1tNQZC/UIarWEMQs6z5mavlQWpfQLA0X2EMfOh4//aRghiIv7SStLjgBu9
	 9GTaf+xeDyHpxNH5TbtUUCRnCO8mPdslDzyxY5zqPf9Ag9Qi0VcEoxtiw6sbrbzaeQ
	 vCMKqWh+OPYeRle9F1M4oTLKEBThcX4T3dJeFKacKB9T0KpiPdcgUQ5SsZKTusqYul
	 KcZeyVHM5Wmzg==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 22 Aug 2024 02:15:17 +0100
Subject: [PATCH v11 14/39] arm64/mm: Map pages for guarded control stack
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240822-arm64-gcs-v11-14-41b81947ecb5@kernel.org>
References: <20240822-arm64-gcs-v11-0-41b81947ecb5@kernel.org>
In-Reply-To: <20240822-arm64-gcs-v11-0-41b81947ecb5@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1842; i=broonie@kernel.org;
 h=from:subject:message-id; bh=+TK11w/7oyUnbPsKo/oQrSN1KO+dOWD16qqEJpANLmY=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBmxpEuY7qje14egT0jcYvUuc18fgX2hyZO8U/JWAKU
 p3nRhCyJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZsaRLgAKCRAk1otyXVSH0GsEB/
 9qdaHW2b3XgfR3+Lcf74TxUigjDXbDl/OHGsds2ymyg2RqDu0qZzVpsuut7A7stH+sU0N1dDdUpcqD
 F9TmP51kmfH9e5EHHvRsMZx6vWevSrVLpQLVmb495BVgunxLqyP9Ybr7Ba466Y4a/BDEAmHV9iJj2d
 HADHwxouSbw11czxAdsIPZvqXV3RzZtu+CH0YlxipziDUYG3USAkc3ZHpyVwV+VsJjnUEbUvnrL5iX
 nu3TZdz7oOTX+LhfkfJxJcQ7dV7BXJa8+upiQtxc+q0kriB3FRmYJfQ/Ps+0aeQ/M7VvauhDbZ47NH
 P3N0oUsx2lrb30YIaP03PP0gXBZSob
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Map pages flagged as being part of a GCS as such rather than using the
full set of generic VM flags.

This is done using a conditional rather than extending the size of
protection_map since that would make for a very sparse array.

Reviewed-by: Thiago Jung Bauermann <thiago.bauermann@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/mman.h |  9 +++++++++
 arch/arm64/mm/mmap.c          | 10 +++++++++-
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/mman.h b/arch/arm64/include/asm/mman.h
index c21849ffdd88..37dfd2882f04 100644
--- a/arch/arm64/include/asm/mman.h
+++ b/arch/arm64/include/asm/mman.h
@@ -61,6 +61,15 @@ static inline bool arch_validate_flags(unsigned long vm_flags)
 			return false;
 	}
 
+	if (system_supports_gcs() && (vm_flags & VM_SHADOW_STACK)) {
+		/* An executable GCS isn't a good idea. */
+		if (vm_flags & VM_EXEC)
+			return false;
+
+		/* The memory management core should prevent this */
+		VM_WARN_ON(vm_flags & VM_SHARED);
+	}
+
 	return true;
 
 }
diff --git a/arch/arm64/mm/mmap.c b/arch/arm64/mm/mmap.c
index 642bdf908b22..3ed63fc8cd0a 100644
--- a/arch/arm64/mm/mmap.c
+++ b/arch/arm64/mm/mmap.c
@@ -83,9 +83,17 @@ arch_initcall(adjust_protection_map);
 
 pgprot_t vm_get_page_prot(unsigned long vm_flags)
 {
-	pteval_t prot = pgprot_val(protection_map[vm_flags &
+	pteval_t prot;
+
+	/* Short circuit GCS to avoid bloating the table. */
+	if (system_supports_gcs() && (vm_flags & VM_SHADOW_STACK)) {
+		prot = _PAGE_GCS_RO;
+	} else {
+		prot = pgprot_val(protection_map[vm_flags &
 				   (VM_READ|VM_WRITE|VM_EXEC|VM_SHARED)]);
+	}
 
+	/* VM_ARM64_BTI on a GCS is rejected in arch_validate_flags() */
 	if (vm_flags & VM_ARM64_BTI)
 		prot |= PTE_GP;
 

-- 
2.39.2


