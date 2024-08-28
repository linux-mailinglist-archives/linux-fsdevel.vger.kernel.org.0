Return-Path: <linux-fsdevel+bounces-27665-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17EB2963574
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 01:29:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6D251F23656
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 23:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF1FC1AE039;
	Wed, 28 Aug 2024 23:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rq++GcKR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6C61AE036;
	Wed, 28 Aug 2024 23:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724887727; cv=none; b=HB3O9PKpgWGTNQJpmuipLM9TgFCQ7o6Vz0s67J+BkA94OezZfQBnTDU51CQFqf3phYI9YvHv5tR033dVweZx5/KyfiIQl+1l9/HWwcJX0DHcW/2w62Z9bdDTSGdn8n6I1/W7HguxB3wclHBqt80uWrClx7yJ25zAVNVjKwbc1Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724887727; c=relaxed/simple;
	bh=pHfZEKDzLLM4lr4zoXfluscujJ3LYl3h2pXq/J8hLlM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=maqFPPqgtvCMHTD9oMEolleijikUNqnKa2L8nMlDOD7o6tEvEs3B2ywArBlsdvl/n5FPxo7fUKIJuN8iDmMLBynuc92noGdnz0Bx6X1KjiM0c4WiN0Q8zJl+1qX7qR7TVDd+xGW3N1AwkXHOk+ykBmZ6syMm4Vselu1cpW/48+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rq++GcKR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCED0C4CEC0;
	Wed, 28 Aug 2024 23:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724887726;
	bh=pHfZEKDzLLM4lr4zoXfluscujJ3LYl3h2pXq/J8hLlM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=rq++GcKRSvjv+PpuihZSyX+jI22rkXN+ahaJ3t3y5r8tOhGSsG32bALwOyi6zYXN+
	 eVkgXBG41Uv68iVxp4/e7dy2O7x7R9RL6V+bdhoGuS7S8B+ghf22V7W/Ls/kWbdLBo
	 7Is1GwWxO6TaQP0Tj7x6lsCbVCGUfXijCHMn6tEsRacuyEEVSbx2WXVHBZ96pD53Hf
	 pmT3dpjzta4JENEwzaXB5sa+L7S1NKJnQCHIsWXQspmurerFzOEyKIifOvm+NSlcfW
	 TzFOCynF53a2oPN11SQE0FwHZZfiWDjTdsJtv/mxFkMVO9x8PjMxmTb8sZsdxPuGhG
	 +pVfHFtUnOF6w==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 29 Aug 2024 00:27:18 +0100
Subject: [PATCH v12 02/39] arm64/mm: Restructure arch_validate_flags() for
 extensibility
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240829-arm64-gcs-v12-2-42fec947436a@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1425; i=broonie@kernel.org;
 h=from:subject:message-id; bh=pHfZEKDzLLM4lr4zoXfluscujJ3LYl3h2pXq/J8hLlM=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBmz7J6RoofHrvZefS5vfHSrIx3ilH92it2YpD+C2sU
 TzTMMvuJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZs+yegAKCRAk1otyXVSH0OzJB/
 9Gab3WMv/piiW9sI/VMmkzs26eYy2nciOZlr+bDnZbXBO3RS2k7ZKTA3UXP8pw+WP6f3OTrK2JMpfg
 ycY7eHztFNrujRTDsA1Fbnp4LEYMTUqMdaDxVz54T1PND+NB3VCmbCLle67gDrxjBhI0d/2ZdiBMlQ
 WlCVUNCOU4/GRZkhQPjvJpMhnxtqZ868DYBfql4xwV4z+fedBMTIIwQLcAO/sLgPIoTYb+If2GbG+R
 SnPQARoQRW3QsGmVzONtxPqheal1fPNH30HxTnD56qvbXOnHngyg3z0/KOYD9Zh06RHyr1ixJg8tZT
 ++7YZqvjMHAD6oGk6OoVaK0+39aOZh
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


