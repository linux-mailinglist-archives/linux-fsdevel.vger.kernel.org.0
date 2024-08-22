Return-Path: <linux-fsdevel+bounces-26601-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E8C95A972
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 03:16:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBDC71F23815
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 01:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C84811711;
	Thu, 22 Aug 2024 01:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ueVLaK2M"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0DDB67E;
	Thu, 22 Aug 2024 01:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724289386; cv=none; b=krSR9Prz+I+wXSvrTIl/ONNjkzGQe2F0tunzwkayy1T0kJ2bPfb+1mCR/979AKDv0JSGaUX8TiGo2GZUlVqx5F9NwP2GTJRQuKZD2qPqmdX/qqkAID78ldECUOpg32VwbAudawctIKizwZUsahOAmIINGSocn+bHbdXvTACdbUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724289386; c=relaxed/simple;
	bh=pHfZEKDzLLM4lr4zoXfluscujJ3LYl3h2pXq/J8hLlM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=daztfASYGNz/XSyGm/z6jZ7IY0nGA32SR5XD/ipBjS+mVEQCWstx/OiHYq+mwWmrmpQ67Hb2RKWa7qk5a0KSbdFoMM59UK8F+6syc0LRPxO0gIsK6d5GtMKJsnMkQR8K/5fm5CzT8dPV+UTFyplC+AwopP8Hl8ajzFLLCNt5hWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ueVLaK2M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 666C9C4AF1A;
	Thu, 22 Aug 2024 01:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724289386;
	bh=pHfZEKDzLLM4lr4zoXfluscujJ3LYl3h2pXq/J8hLlM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ueVLaK2MsY/szyYEntQjZLCLmSRxuLrl1Gi44VBoYEOUxf+EFs125s4/3ol3QDM9z
	 X0uq0oLUomlTmF4IeqLnycgtWjo8hG4RUpi38YDJ2yN9GCnAIzczWfCfqV8UqCLsa4
	 LgV/BxdLzAWfYKAQhJnFfDy6vMkl3H4e1XZvscIMergMM2DXlg7qUST8B7BSL15Dy/
	 ACGCdswfAW7EXeh1gwRuId8MWV/S0yfaUQY40OVIY2GeKOKZzgB7uRR9DruoAnxB70
	 9FP0XaInJ4IhHow7mgbNG98DzxHE7VWqcv76qbyxlEY8qorNgt8+kQF6tVXk1MJMl+
	 8/GTtxPOV2fUA==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 22 Aug 2024 02:15:05 +0100
Subject: [PATCH v11 02/39] arm64/mm: Restructure arch_validate_flags() for
 extensibility
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240822-arm64-gcs-v11-2-41b81947ecb5@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1425; i=broonie@kernel.org;
 h=from:subject:message-id; bh=pHfZEKDzLLM4lr4zoXfluscujJ3LYl3h2pXq/J8hLlM=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBmxpEl9voS9PP73u8VNnhsmW4oYvOczA8/d2TEsErN
 Njv4/K2JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZsaRJQAKCRAk1otyXVSH0A4CB/
 9MXo13GBv5ic9iHD9QnaDlTvnWnODh6Vu3DTv6ZsajAlY/vDbpNjNksJ7N1/t8aGXvs4uy5ICkLVG8
 ixe/6vrw8GsFJ/VPkcB0maOlg61u65806KML6g1ycIYyHfVIcoLsGmQl2I3qPvDMqQqQgYi3OEaPJg
 r00Rl8ZYS8awDvmVP8whjypeAEPDSHoumixJLsW80rL1XqMP5IupEhOudxgROA7nkEslitEzwyBzxQ
 iiZ4Ha+a1V0f9GGhGDZH+hu/Rmn4kPGXRm3HE6dZxLZpxa9ZAgggCvVPjYL6cKjTqwdjSUt/VRNZF8
 wquclYiWd2K+Ek6E4LF24vGnbVv5DR
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Currently arch_validate_flags() is written in a very non-extensible
fashion, returning immediately if MTE is not supported and writing the MTE
check as a direct return. Since we will want to add more checks for GCS
refactor the existing code to be more extensible, no functional change
intended.

Reviewed-by: Thiago Jung Bauermann <thiago.bauermann@linaro.org>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
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


