Return-Path: <linux-fsdevel+bounces-27677-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A48539635B1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 01:33:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E7821C220EC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 23:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F9071AD401;
	Wed, 28 Aug 2024 23:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="csXIYlPb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB99161319;
	Wed, 28 Aug 2024 23:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724887815; cv=none; b=EW1GGha69p3cS/EfVwlnZqL+91BNmMWYGg0kjAtKbgv4+z0XJE2FU3xxh2PLIPI8gEs/DuE5POSP4t/ALrdS1it2HOh9HDWqehJiCO5W/8Z3sP3ktj6pc/kGLbVq3TYJ5ZRUiYpwjRLMfoIcq0sPzWEXNeqamJYiI1eHTd703Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724887815; c=relaxed/simple;
	bh=q8jtVg186GFJVIbjl1JCrkiZnz/oBLnR/HtHUgXvMfA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PU3wOJ2qJk6wI1DEGGkMQGk0KELRgrXXcKPC1rxNNm7O308zSN5TbrKXXqGAuN2frhnr3nUKDeCSmDbbstQIQZJ+Bg9DEQKEPv3TCBema3bEVzvxqzd06gSlH4HuMdPxfPMI0wbP2uJt1Bt/szlatZ3s9xRXsK7uyQfEHpcUvQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=csXIYlPb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E576DC4CEC5;
	Wed, 28 Aug 2024 23:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724887815;
	bh=q8jtVg186GFJVIbjl1JCrkiZnz/oBLnR/HtHUgXvMfA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=csXIYlPbjsq0/jESzviJXGLS5PVUMwFyPcl9Xf8tCAU3CGgzUzcSXEOOGrzJGOi4n
	 +LVpTfKWkimkyH2gkwgyYFLAqrNxMfByqvcuy0VRXO4vSBMDQDGRLkHTzLYPfpeOy2
	 AyEWc7lOsYqAfbBDM8Bc6mJym3P1TCGwFH6JYwLsXtYbilIWgJGJBuUIWwEF4ruBzk
	 Irzl16KGJZap13BwqZWYzbzXWP+4eyR9laKqpNp69phFVR0DOgEfIDlzw09zIlvjZg
	 aqd4HA+U9jzpvZJm3UVCJjQd5uoKjF5Q0gQa5Ttxa0UAOtqwlc/QdBtfEypp/Uxek/
	 Eb/XXqGaqeeCg==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 29 Aug 2024 00:27:30 +0100
Subject: [PATCH v12 14/39] arm64/mm: Map pages for guarded control stack
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240829-arm64-gcs-v12-14-42fec947436a@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1824; i=broonie@kernel.org;
 h=from:subject:message-id; bh=q8jtVg186GFJVIbjl1JCrkiZnz/oBLnR/HtHUgXvMfA=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBmz7KDz+A8JTqcELz4cAJ592v00no+g1aVltB8BmzS
 YLVlld6JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZs+ygwAKCRAk1otyXVSH0GfJB/
 49HQhF+L8EiPWM7v3hZ36OyfEAtuZYOAa7yxbdtNlpOsOKuJCieWaGUjCl4V7oMxDUXRoMqIYkJ2Y7
 0UjpPJ2A/OzEmFWXJzvSlVo9eCTfasoJ4KB8k9tuDNt/wmQ2GuY7C+9u0ds83AmngnuKcfDeqVE0VW
 8xDc5pxqMmvZE+kh51h7AXaa+kMQTlm7Dnb4gtNI554joq08SMIgk7fZKptpoJne0VPkT1C7gUBfTG
 r3ZYOx8kpQ6ZA2hstniXP3cfObhdDaqIBtvnccak5YaFOo4qP9sUvzJOoHVrguVBLRswG/5kNuET2U
 0gXB7BzsUfSt94B6y9IbRGc5knJOAA
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Map pages flagged as being part of a GCS as such rather than using the
full set of generic VM flags.

This is done using a conditional rather than extending the size of
protection_map since that would make for a very sparse array.

Reviewed-by: Thiago Jung Bauermann <thiago.bauermann@linaro.org>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/mman.h | 9 +++++++++
 arch/arm64/mm/mmap.c          | 9 ++++++++-
 2 files changed, 17 insertions(+), 1 deletion(-)

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
index 642bdf908b22..5943898f366b 100644
--- a/arch/arm64/mm/mmap.c
+++ b/arch/arm64/mm/mmap.c
@@ -83,8 +83,15 @@ arch_initcall(adjust_protection_map);
 
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
 
 	if (vm_flags & VM_ARM64_BTI)
 		prot |= PTE_GP;

-- 
2.39.2


