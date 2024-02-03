Return-Path: <linux-fsdevel+bounces-10159-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5450D8485C3
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Feb 2024 13:36:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8738D1C21253
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Feb 2024 12:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DEED64AB0;
	Sat,  3 Feb 2024 12:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b8LtOloG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8283E5EE69;
	Sat,  3 Feb 2024 12:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706963476; cv=none; b=h82tDslhiacq+zHTKqbZY6vpIi6rYaQ6PgYDxB/T6HU5vJJWRiTOsvbURjtWH2W2Y/oy4ESzgxGTtbaBzs5L8YmSYK0sej/rlL8rZnFnE3Vv20G43dGCQ88YIZlTyTEM9eiOlirxLoexSYUYdH2xJsS8EqpcJe2gCd1wKKpJImA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706963476; c=relaxed/simple;
	bh=D3mrjjzhu1bmO322qeetoeUWjp5BglarJjfdNbXnw/Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LuvQDLChHRO7iBVur6I+j3yOfln3XyskDYgOlf0J8MsLVg33jL9HN35JifghpIdQbVEhuLsTyHOHvRZNB6NlfLo9aSQ4jVgwHIHCWjrAa8IiiDHXLonJPR8ysIhDbNPsyMg+t9fIfWM+tM0AcA5CJEn+6rP7Nn5nIBkcqGUk43I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b8LtOloG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C56F8C433C7;
	Sat,  3 Feb 2024 12:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706963476;
	bh=D3mrjjzhu1bmO322qeetoeUWjp5BglarJjfdNbXnw/Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=b8LtOloGXjSjg88htRVqjKTHNIpv0KYxDjzZZc71ZNTni2PxZT1VAYdJN/gNX8zgU
	 ybOCUuvaxAoBMVShab+E5dZjUyGnTueq0nXdn1xuED1XL3WEEikq8LRu5ULi1VwggL
	 ZgrVxgcgUxtO5uO27W/yK4PC7TpG9BTPJE5/nHaFo2NC8luOoerHgYAqVYROaqSJVa
	 yt4mYZic23yETrP7HcrYgZfC1ZqB2dVzF/Wa6U3eZHxsG4Rp18/77HbM42KQpgvmub
	 rq5RZXLNX70wZiIl1EhPquGNwPdGSPO1GriBmlDJ8EjDf22vLCcozMiMlXJYsxwZlW
	 p/dVV5Ax8HJwA==
From: Mark Brown <broonie@kernel.org>
Date: Sat, 03 Feb 2024 12:25:40 +0000
Subject: [PATCH v8 14/38] arm64/gcs: Allow GCS usage at EL0 and EL1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240203-arm64-gcs-v8-14-c9fec77673ef@kernel.org>
References: <20240203-arm64-gcs-v8-0-c9fec77673ef@kernel.org>
In-Reply-To: <20240203-arm64-gcs-v8-0-c9fec77673ef@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Andrew Morton <akpm@linux-foundation.org>, Marc Zyngier <maz@kernel.org>, 
 Oliver Upton <oliver.upton@linux.dev>, James Morse <james.morse@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Arnd Bergmann <arnd@arndb.de>, 
 Oleg Nesterov <oleg@redhat.com>, Eric Biederman <ebiederm@xmission.com>, 
 Kees Cook <keescook@chromium.org>, Shuah Khan <shuah@kernel.org>, 
 "Rick P. Edgecombe" <rick.p.edgecombe@intel.com>, 
 Deepak Gupta <debug@rivosinc.com>, Ard Biesheuvel <ardb@kernel.org>, 
 Szabolcs Nagy <Szabolcs.Nagy@arm.com>
Cc: "H.J. Lu" <hjl.tools@gmail.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Florian Weimer <fweimer@redhat.com>, Christian Brauner <brauner@kernel.org>, 
 Thiago Jung Bauermann <thiago.bauermann@linaro.org>, 
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
 kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-mm@kvack.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-a684c
X-Developer-Signature: v=1; a=openpgp-sha256; l=2231; i=broonie@kernel.org;
 h=from:subject:message-id; bh=D3mrjjzhu1bmO322qeetoeUWjp5BglarJjfdNbXnw/Y=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlvjDc8EHGCknoOBKe6qZKHD+oiq1TQJV0CBg/qGUx
 v9IrslaJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZb4w3AAKCRAk1otyXVSH0D/LB/
 42988rQEDEd1c4AWNUz5rGufrrvcfn77vTQ2D1Q95lKvScKDoA3SCsg/NCBvD6bTwCQyimBPieLclf
 vphVOHi8RIWA46cysnMRfhnLSUzUUwJdRhNYL1KASDBbgrGh2nIdUMB1zMuuBP4yJowmA+LBTjroCK
 YPS9XoZUZIHlFfkTOi0V/a8Fu+HwPn14jxbpiehTXDctJz5EfvwcjTooeg2p6dmcuHzocpcSTVBX5V
 AZNNDcwvGgtXBrDMV8wVp3ZJk6Iq3ejaqd2L8Iz3zS/sAJBUp7sDi/fCOHvh+iWdCsG4mGqUuqM0F+
 LjLYBdtbAn0AUFobSt30jnpFzdqG+D
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

There is a control HCRX_EL2.GCSEn which must be set to allow GCS
features to take effect at lower ELs and also fine grained traps for GCS
usage at EL0 and EL1.  Configure all these to allow GCS usage by EL0 and
EL1.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/el2_setup.h | 17 +++++++++++++++++
 arch/arm64/include/asm/kvm_arm.h   |  4 ++--
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/el2_setup.h b/arch/arm64/include/asm/el2_setup.h
index b7afaa026842..17672563e333 100644
--- a/arch/arm64/include/asm/el2_setup.h
+++ b/arch/arm64/include/asm/el2_setup.h
@@ -27,6 +27,14 @@
 	ubfx	x0, x0, #ID_AA64MMFR1_EL1_HCX_SHIFT, #4
 	cbz	x0, .Lskip_hcrx_\@
 	mov_q	x0, HCRX_HOST_FLAGS
+
+        /* Enable GCS if supported */
+	mrs_s	x1, SYS_ID_AA64PFR1_EL1
+	ubfx	x1, x1, #ID_AA64PFR1_EL1_GCS_SHIFT, #4
+	cbz	x1, .Lset_hcrx_\@
+	orr	x0, x0, #HCRX_EL2_GCSEn
+
+.Lset_hcrx_\@:
 	msr_s	SYS_HCRX_EL2, x0
 .Lskip_hcrx_\@:
 .endm
@@ -190,6 +198,15 @@
 	orr	x0, x0, #HFGxTR_EL2_nPIR_EL1
 	orr	x0, x0, #HFGxTR_EL2_nPIRE0_EL1
 
+	/* GCS depends on PIE so we don't check it if PIE is absent */
+	mrs_s	x1, SYS_ID_AA64PFR1_EL1
+	ubfx	x1, x1, #ID_AA64PFR1_EL1_GCS_SHIFT, #4
+	cbz	x1, .Lset_fgt_\@
+
+	/* Disable traps of access to GCS registers at EL0 and EL1 */
+	orr	x0, x0, #HFGxTR_EL2_nGCS_EL1_MASK
+	orr	x0, x0, #HFGxTR_EL2_nGCS_EL0_MASK
+
 .Lset_fgt_\@:
 	msr_s	SYS_HFGRTR_EL2, x0
 	msr_s	SYS_HFGWTR_EL2, x0
diff --git a/arch/arm64/include/asm/kvm_arm.h b/arch/arm64/include/asm/kvm_arm.h
index 3c6f8ba1e479..a9354c237a97 100644
--- a/arch/arm64/include/asm/kvm_arm.h
+++ b/arch/arm64/include/asm/kvm_arm.h
@@ -103,9 +103,9 @@
 #define HCR_HOST_VHE_FLAGS (HCR_RW | HCR_TGE | HCR_E2H)
 
 #define HCRX_GUEST_FLAGS \
-	(HCRX_EL2_SMPME | HCRX_EL2_TCR2En | \
+	(HCRX_EL2_SMPME | HCRX_EL2_TCR2En | HCRX_EL2_GCSEn |\
 	 (cpus_have_final_cap(ARM64_HAS_MOPS) ? (HCRX_EL2_MSCEn | HCRX_EL2_MCE2) : 0))
-#define HCRX_HOST_FLAGS (HCRX_EL2_MSCEn | HCRX_EL2_TCR2En)
+#define HCRX_HOST_FLAGS (HCRX_EL2_MSCEn | HCRX_EL2_TCR2En | HCRX_EL2_GCSEn)
 
 /* TCR_EL2 Registers bits */
 #define TCR_EL2_DS		(1UL << 32)

-- 
2.30.2


