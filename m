Return-Path: <linux-fsdevel+bounces-3376-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B232E7F4230
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 10:44:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D541D1C20A45
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 09:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 854105644B;
	Wed, 22 Nov 2023 09:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SyPO5tjn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC09B16407;
	Wed, 22 Nov 2023 09:44:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70B4AC433C7;
	Wed, 22 Nov 2023 09:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700646285;
	bh=eAZyVctWUIW822C6a4XspzvFhF8YmdJ2KmfW+KTTZkg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=SyPO5tjneJ1lWQ6vMvro8FogjGi2iuc2b+pcmTXuO8VKhRqYlvw00yJlvvbHsdh84
	 TjGzB+y7+/Y3Q920f0JAUO7oIDuDC/YZstqwF38A6ixh909kP+lzJHULCdJGX+fIzu
	 q2JxSOEaKpH+uJ3EXxGW9/9dWeXbeAXUDeWofNO1W6RlsAf2V1MwnpzjgSB/ogU4X+
	 iQxSL+7QlIiwyGcC1yZ1M5CuYrxppxx40R+51v4wstppfqJqFFJl8enKcPtvvp49Ck
	 5eg7e8+cZV57vDaFzG3Pv8smXqbDeUH6q2VouWbCf5uw9sS0ZDl4rykCqfkbJEE4hX
	 ADwfS0/JxHqSg==
From: Mark Brown <broonie@kernel.org>
Date: Wed, 22 Nov 2023 09:42:25 +0000
Subject: [PATCH v7 15/39] arm64/gcs: Allow GCS usage at EL0 and EL1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231122-arm64-gcs-v7-15-201c483bd775@kernel.org>
References: <20231122-arm64-gcs-v7-0-201c483bd775@kernel.org>
In-Reply-To: <20231122-arm64-gcs-v7-0-201c483bd775@kernel.org>
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
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=2246; i=broonie@kernel.org;
 h=from:subject:message-id; bh=eAZyVctWUIW822C6a4XspzvFhF8YmdJ2KmfW+KTTZkg=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlXc0CgBXsZyH7UmX+GJUnolHom10FZwrrBFtz2
 fm0irI1LESJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZV3NAgAKCRAk1otyXVSH
 0DSKB/0YQg4ct+cd7LzPnbzosVtkcpo9NOAazn/sUsJ2DtI354warKGrRY6PxciWlxzrMDgiIus
 HiJme7H4zGCw0IDbOmwwTfwCBkzLrvskL6mtcVElBOwwj0p22FxA2z06bnEyl+hOGCVOvm6HJGr
 S2L6/PMBzs/qmDYtEl04cqXyrEjy7B073aCQ39bj4OWb8e9pd1x45oG1v1BG9nEsklqU/iYgKZl
 +W/7rPeizJfM/yQ1ZEYuaJ73f8isMI/FMN+vA1i0JVuceYiVSaL7GypOFOYgDGwoP/Xmt6S2aUk
 PoVEJ298MhJe8H7+mrvEZOIqa4+3U3qcVTURWXFcrBZzuVbh
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
index b85f46a73e21..e4b6a29879b7 100644
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
 #define TCR_EL2_RES1		((1U << 31) | (1 << 23))

-- 
2.39.2


