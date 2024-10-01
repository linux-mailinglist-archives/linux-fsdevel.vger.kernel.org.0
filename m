Return-Path: <linux-fsdevel+bounces-30601-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C13798C915
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 01:09:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E5F01C2401E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 23:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 341751D07A4;
	Tue,  1 Oct 2024 23:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B5J7eMmH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC2B1CDFD9;
	Tue,  1 Oct 2024 23:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727823911; cv=none; b=bf12NfmZqP9pZ1+HswggeWBJ8mUKNIRgodjkKq9AEjYB8ogU8uCNjCjqZU4XfBdVMiyQmPqUXYr835w4Bif47T1FjRNEhFHvexwxlukYa+/zXTyq8ems+pg0mzCClmtV9nVGH3cYha4+JXRDieNsO0uEmSaTcGwCqrYybMrZsgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727823911; c=relaxed/simple;
	bh=atDZEtbemNIieqZC6RtXrtbJMuxF2tLKf2K/TSJvVes=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZYxvXC6vITjiBI2CWJsx0RMhqQzbn2yaOB/lYI5yPlE5BZ4NWdY/020vUo7MMlOwLUcLQCg0EejeLgGumCRkl2H8lIVAQfIKpN1T/je2xZ4AvGbRdhXhMyodUXl3gRyhmDhWBqJL7FCeLd9bOY/NmA21QwPENKNN7DL45V6GBhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B5J7eMmH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2430C4CEC6;
	Tue,  1 Oct 2024 23:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727823910;
	bh=atDZEtbemNIieqZC6RtXrtbJMuxF2tLKf2K/TSJvVes=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=B5J7eMmHKHd97SZEJxiVYhbNX/Ks8kJn5Nue5+50O9KQLxkG1E+ZShZeg7g74vkcV
	 A18Gq9rmhXe19Z4kUcF+pJs+Qtvsqr91+6+b7Kbsshk5rbEYcPSxMF6dM0k1CoOe1h
	 e7cF+4+kslmzvSIQSqXfflUfAQAyfMhFn+CLChMvKBH4y0HQkYfZBLgHsx4waUTth1
	 FFWq7cK+cnEGEWp6Vnhnn8l3ARtW5Mw5+nZSWMAvmkBEWfgsMfYi/qYMdxye19J2jn
	 B7Sl2jtRZqa10PTgSCq8QLQWkDF2ckA/wZ0Me+T/OCoSkGoPz9AVJA8AU9mCB+UO5i
	 YC+XhEF1TuzLw==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 01 Oct 2024 23:59:07 +0100
Subject: [PATCH v13 28/40] arm64: Add Kconfig for Guarded Control Stack
 (GCS)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241001-arm64-gcs-v13-28-222b78d87eee@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1477; i=broonie@kernel.org;
 h=from:subject:message-id; bh=atDZEtbemNIieqZC6RtXrtbJMuxF2tLKf2K/TSJvVes=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBm/H7Zc7rKkETgD5/LTaxxdr7BGJRS0qSsZjNw/txV
 r2Wuw/+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZvx+2QAKCRAk1otyXVSH0M+qB/
 91ODENwPWdKuLlElj/7OYeWGSCjN5ITwHJ4ppzWwF1BP5tpBhvEs9TuGenH2UXxcohCfUT6yjbeNU7
 BqHi1YY0+wQUtr4ulVRIVOnj1gq7q8h/tS/NBM0kzuoPNW/h3FxRY8l5bCnYAo5i4/0MKAznj5S5pL
 tj2aRrRznvG5Pj2t4m43nTUIxrTduG05Cdqisl6Txjh+LJSLhBOsiLtFeWGetiiTrHDcpNisfrWB/g
 INyNQ3jEJ06Kni4oXAI1kFQBiWcbUVqmeRHJg4jEpObnjwLN4GS3NWbsDfDtfdFgL9q0FM2zOz1vfP
 x+uZvUmrp6KnGE2kvCpjKmctHavSdF
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Provide a Kconfig option allowing the user to select if GCS support is
built into the kernel.

Reviewed-by: Thiago Jung Bauermann <thiago.bauermann@linaro.org>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/Kconfig | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 3e29b44d2d7b..dcb12f041c13 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -2178,6 +2178,27 @@ config ARCH_PKEY_BITS
 
 endmenu # "ARMv8.9 architectural features"
 
+menu "v9.4 architectural features"
+
+config ARM64_GCS
+	bool "Enable support for Guarded Control Stack (GCS)"
+	default y
+	select ARCH_HAS_USER_SHADOW_STACK
+	select ARCH_USES_HIGH_VMA_FLAGS
+	depends on !UPROBES
+	help
+	  Guarded Control Stack (GCS) provides support for a separate
+	  stack with restricted access which contains only return
+	  addresses.  This can be used to harden against some attacks
+	  by comparing return address used by the program with what is
+	  stored in the GCS, and may also be used to efficiently obtain
+	  the call stack for applications such as profiling.
+
+	  The feature is detected at runtime, and will remain disabled
+	  if the system does not implement the feature.
+
+endmenu # "v9.4 architectural features"
+
 config ARM64_SVE
 	bool "ARM Scalable Vector Extension support"
 	default y

-- 
2.39.2


