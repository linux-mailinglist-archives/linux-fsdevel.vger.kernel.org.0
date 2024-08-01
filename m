Return-Path: <linux-fsdevel+bounces-24750-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88CA5944BDA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 14:57:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00ED11F22AC4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 12:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 416D01A256A;
	Thu,  1 Aug 2024 12:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BZbXzFPN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889B31A00F7;
	Thu,  1 Aug 2024 12:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722517046; cv=none; b=kHtjWRMtJk3wn968yxnK/5yjT1P5nmDjB/G9/NvzPBQS3N2KOt253d/3WY1APk+AkAmHg4ZOqCWVqqW4WtvBCCp2uqb816oi5RBgXmcZTtd/QsdCGofUMLME87GhM6HRP+I8PU8NMcWJon/Q7+bGlsi9qs8gHKpahZJY3/xquqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722517046; c=relaxed/simple;
	bh=bsiMqAlOgEwP0cbRhsqWxUT30GAWtj7CcR/m2yEY+EM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JKgxLGC0yGe7CY4e68uvNqBiiigr+3OktrEuCVtooVeGJ1kAzoR6LuolYNxCW5svPNEMWiG3pI/ihjq3xnWChG0lhCTYpx2NMZi9zWjaZxyl3//fNBNcs7bIA2y4nEl8ZvSmzc+3NaALei5y2T1fCrlTaEAlxI/D7+xXxEK9JXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BZbXzFPN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB0C0C4AF09;
	Thu,  1 Aug 2024 12:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722517046;
	bh=bsiMqAlOgEwP0cbRhsqWxUT30GAWtj7CcR/m2yEY+EM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=BZbXzFPNzPvbVSEL1HQGb9vwgWBSp98cTAPSVjgtfvJw92HXoTlzukkF3KirLERxc
	 bqNPNcakZeZ/4Csghs6sC/XpdJCwoczXybGu7jfJiioe7ljfYE4qxdv6Q0hGT5BMXt
	 eIqPOfLqmTZwbfvoVmaVqmAFunVsB0EF3q98WvvHeu9kip39NlikjgyNpwevVVHoeq
	 H5Ci97Hqtb2MoP/46USTpEYDzAs4bjD5CG6Opz6g2V+D7Ss3x4ldV4Do03mZti3btS
	 r8pN2FEjEAryz6qhJyFeD7V9FRQ7eboOa9BOTKFurPui97bxufWmSq7NQ2pj0rkkLZ
	 vS/O9RPKAAgmg==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 01 Aug 2024 13:06:28 +0100
Subject: [PATCH v10 01/40] arm64/mm: Restructure arch_validate_flags() for
 extensibility
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240801-arm64-gcs-v10-1-699e2bd2190b@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1369; i=broonie@kernel.org;
 h=from:subject:message-id; bh=bsiMqAlOgEwP0cbRhsqWxUT30GAWtj7CcR/m2yEY+EM=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBmq4YGqNne7baHl23QOwDNZcKGE/jpNiGj7M5xDaR7
 lIob1RyJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZquGBgAKCRAk1otyXVSH0P6kB/
 wIOf1cMolmdce2aUsq0S+hmD8dGJDuLlSKxaFli9jY4UBL8wsQJFyiNa/OYFI8nDKrC5byoMT1dO0M
 TqsVdiKMI+P8FfRaguIINosdMj2HarIZXN1a5vv2E26G44gzwk+9wjKUMgc26wRPvP+R9Oa9FgWaKM
 jR+dEdnMkFQja9XnvYvrIpSN7VCp0GZ9n3Hf5G+tMTC/pVQibgBVYGV6j38kDUitFDpMiYJvHjFRpw
 vWH8ACdZCETPX9eigVl2ElUysqkSWWtpY+fLh856UWEVGsXYY0P/Aqm5NoC5EBRo9DP9EU2Qxcpjo5
 j0naxVNyc9NsDOrN3vlTlgohZmbE/F
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Currently arch_validate_flags() is written in a very non-extensible
fashion, returning immediately if MTE is not supported and writing the MTE
check as a direct return. Since we will want to add more checks for GCS
refactor the existing code to be more extensible, no functional change
intended.

Reviewed-by: Thiago Jung Bauermann <thiago.bauermann@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/mman.h | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/mman.h b/arch/arm64/include/asm/mman.h
index 5966ee4a6154..c21849ffdd88 100644
--- a/arch/arm64/include/asm/mman.h
+++ b/arch/arm64/include/asm/mman.h
@@ -52,11 +52,17 @@ static inline bool arch_validate_prot(unsigned long prot,
 
 static inline bool arch_validate_flags(unsigned long vm_flags)
 {
-	if (!system_supports_mte())
-		return true;
+	if (system_supports_mte()) {
+		/*
+		 * only allow VM_MTE if VM_MTE_ALLOWED has been set
+		 * previously
+		 */
+		if ((vm_flags & VM_MTE) && !(vm_flags & VM_MTE_ALLOWED))
+			return false;
+	}
+
+	return true;
 
-	/* only allow VM_MTE if VM_MTE_ALLOWED has been set previously */
-	return !(vm_flags & VM_MTE) || (vm_flags & VM_MTE_ALLOWED);
 }
 #define arch_validate_flags(vm_flags) arch_validate_flags(vm_flags)
 

-- 
2.39.2


