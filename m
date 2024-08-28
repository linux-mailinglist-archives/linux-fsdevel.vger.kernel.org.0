Return-Path: <linux-fsdevel+bounces-27670-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D903696358C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 01:31:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 955CF286382
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 23:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E012B1B14FD;
	Wed, 28 Aug 2024 23:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kNcQU5ny"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344A61AE875;
	Wed, 28 Aug 2024 23:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724887763; cv=none; b=bd16z0lQPuU7OzbGwtKohOKko6n8NH2/4bk7mbaba9qLWqkGMixCxtiKIb72p5xla6AAYDNwsCJrigWcBvMagfrA37b7irzHZ692WGJSMC35yQME6upK/S+SyEHrqqjKRotu5/lmG1R3hdRw1ifDcHR+biEgC2c5ruhtmRy/9uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724887763; c=relaxed/simple;
	bh=4p/cwsbgBUzYKsL2fclAIfpUU9Y3uPXu2QlRekLj7SY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TyXmdx8kSXHgRZ5jW7/4BKuP7HTlGUefO2JaZQv/+bH/YJ2IrHKoqpN1ZbmTS/GSGFsmTB6wqlZUlerrH4IVMSQ3bObjNDNWkE7sJ+HzZ9tdMn4i0rQfOZJiImS7yqmO9eiQ2BpkvSR0wzqHuHyNygmTM2CrdpxeQaf2kWwSWQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kNcQU5ny; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB798C4CEC9;
	Wed, 28 Aug 2024 23:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724887762;
	bh=4p/cwsbgBUzYKsL2fclAIfpUU9Y3uPXu2QlRekLj7SY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=kNcQU5nyrsMetOTGFm6ud7UHZ/GnC48WWUDtMXTgWHntNfYUFLWWUbL9x2wYmUDTy
	 x7lAq0JvS+9YS0FzCoPtxTbjpqy3dltQDe4nreFRosly12F+4B+Wb+N0OvQBsE8bQD
	 UcMJcKi5VwuSPfz3VnTbOn6GfEtR23FPaLmt68TzAf1gDpvvAlmr0hc4FoH6g6T8LM
	 dmi7fEHFLFgHQ/wd35qLqQxoyt33lXfh+qz2JE53etAKJK1fN/NYH0a+3sQkBQIbTb
	 jVUc8RtgEhHBH+qzQiPpSMaOsGUxLEcwHNhLcC9cIUgM3x1hBKYNObyRW8qXnPl/7y
	 jk9bBXyYZiSHQ==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 29 Aug 2024 00:27:23 +0100
Subject: [PATCH v12 07/39] arm64/sysreg: Add definitions for architected
 GCS caps
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240829-arm64-gcs-v12-7-42fec947436a@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1474; i=broonie@kernel.org;
 h=from:subject:message-id; bh=4p/cwsbgBUzYKsL2fclAIfpUU9Y3uPXu2QlRekLj7SY=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBmz7J98aWl1pxIvDvuP+c4z7xD1MmZ369TKWVm31vC
 ZPKg71mJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZs+yfQAKCRAk1otyXVSH0DWhB/
 9LgFKRD1xzzF2u2DcCqEwfQNnsJraBn1ikyZXthyso+/206Wxdaj6j6nc8nWNfdRhZgLV2t+fzG0jo
 Iqy1hG93N0nh6yqsPqlIgSAUqDnBq8+GpuhxlQy/nbpu2V6m5KslRv2aoooWQCcm3+VF9uw8elyiEk
 8K1yoV30FcvolqwyqiZIvm+S23v39l+nKYnW8QpvGSiHjSeltbT/rzxCHDZjG389l0YAM7lKEm3bWT
 BCFwq57PaZOdi/pK9ntm+WT8D25rZXmUhRtmILh9YNxOVifkuPFXQXHfD8Vu0zOZTTR/3kOWXQmrKC
 aSV0N0IHiwIlq88HTD622I9HTZSO2a
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

The architecture defines a format for guarded control stack caps, used
to mark the top of an unused GCS in order to limit the potential for
exploitation via stack switching. Add definitions associated with these.

Reviewed-by: Thiago Jung Bauermann <thiago.bauermann@linaro.org>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/sysreg.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 4a9ea103817e..b8d8718a7b8b 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -1077,6 +1077,26 @@
 #define POE_RXW		UL(0x7)
 #define POE_MASK	UL(0xf)
 
+/*
+ * Definitions for Guarded Control Stack
+ */
+
+#define GCS_CAP_ADDR_MASK		GENMASK(63, 12)
+#define GCS_CAP_ADDR_SHIFT		12
+#define GCS_CAP_ADDR_WIDTH		52
+#define GCS_CAP_ADDR(x)			FIELD_GET(GCS_CAP_ADDR_MASK, x)
+
+#define GCS_CAP_TOKEN_MASK		GENMASK(11, 0)
+#define GCS_CAP_TOKEN_SHIFT		0
+#define GCS_CAP_TOKEN_WIDTH		12
+#define GCS_CAP_TOKEN(x)		FIELD_GET(GCS_CAP_TOKEN_MASK, x)
+
+#define GCS_CAP_VALID_TOKEN		0x1
+#define GCS_CAP_IN_PROGRESS_TOKEN	0x5
+
+#define GCS_CAP(x)	((((unsigned long)x) & GCS_CAP_ADDR_MASK) | \
+					       GCS_CAP_VALID_TOKEN)
+
 #define ARM64_FEATURE_FIELD_BITS	4
 
 /* Defined for compatibility only, do not add new users. */

-- 
2.39.2


