Return-Path: <linux-fsdevel+bounces-30591-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA60A98C8E0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 01:05:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2886A1F22840
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 23:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A48601D0178;
	Tue,  1 Oct 2024 23:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qN0KFUJ+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03CB01CF7C4;
	Tue,  1 Oct 2024 23:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727823795; cv=none; b=Rs+bGvAYKyGHA+Lo0fq0zKOtwwHigxcMK0C7i3KG32Szb1ITX0zHM1fdUveptjGcAut9m4tXaXkGDbjkKXsqdOAUgq9uzRIF3SRCuUzyRH7w/nlgMn/oXUHtKgh4TuJ8Y4r2z5wi82nQ3+Q64Na02xQU0stE62+r4KQxopUdubw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727823795; c=relaxed/simple;
	bh=2WIrz1ABczNTTuelqfWzt+ZpKm8ek9K3V5zq/uM97Fk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AtHHSKnNpl+hUq0gFQLpeUQl4/ymAwhpXIAGuETRWGcP15SCd6Z7pEgQgdRPS/IuqU7p18QXRvE6scrN+ZX1/QU1hDL6XAZ2X+nSOVFxHi3pNomySm5cVyqy7pr9F5lVNkMKAgozy9/f2NqniTzyy18MkOmGTwHdWhO3f328cGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qN0KFUJ+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4015C4CEC6;
	Tue,  1 Oct 2024 23:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727823794;
	bh=2WIrz1ABczNTTuelqfWzt+ZpKm8ek9K3V5zq/uM97Fk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qN0KFUJ+vti96yhBFnZJAl07br92mY0LG2AqB/XU+lMCE9arSoc22Aihn57FzTPpD
	 jKKAVLnRC9gZ+jxwJjsmG+liJwo8cYrrojAb2rw7ocfy49cIqq+/HQJ2k+wHQ3azmZ
	 u3St2TVXL1sZjxGG5DyK1BGF285LX4FW+9/vCWli5B9IDC/htY/ksU3oVbD5fNcrSZ
	 a1TY6yxP+8vK/arjhFPYY/r10Hn3joDG3THXNeO20pmSm37VOv9GnTCtQ0Fs10weUJ
	 L+JfGNKPR7XepAB1gZxNt/mU2ePMdt3EoQib1jcflSlJ0/7U8bue3Y1rO4mX5fjIIM
	 m+gHnS7WPEZoQ==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 01 Oct 2024 23:58:57 +0100
Subject: [PATCH v13 18/40] arm64/hwcap: Add hwcap for GCS
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241001-arm64-gcs-v13-18-222b78d87eee@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3474; i=broonie@kernel.org;
 h=from:subject:message-id; bh=2WIrz1ABczNTTuelqfWzt+ZpKm8ek9K3V5zq/uM97Fk=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBm/H7ScE1JawkHCykL372K9ucQN3HG0LoTpJcod4re
 tJ+zIjyJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZvx+0gAKCRAk1otyXVSH0JQvB/
 oDt7sqH+5NY4WIhDaXR/5vdnxL7JiatcdiiFuj+HShLpNnbvssP8ZvQSkwVv2/FomFWveqRBW43bJG
 P9/eHhKLyOKtyVQL4JAFUypJsyrK1luF9UU6gl9ztYvjWlBwjyVgH2te8uhEl4P5pP+WATtKiIC/Wo
 eul9cxeK7IgMXvQ3/hOCQpTVAHAi71PRnUczqs1r9slmr10NSrFKQiGJ9nq6AzMp/S+cIz4mJeVnEg
 OIUD1mRHZ8TPssXOn4jR4Y54I3iYwHRRUkvIOT/Tr7jH+Vs3/3yPmLGdBY7SEMaLgniP0PYxT8pSec
 FSLL7PSosg+g3RZfNrkb5A1gygvicw
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Provide a hwcap to enable userspace to detect support for GCS.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/arch/arm64/elf_hwcaps.rst | 4 ++++
 arch/arm64/include/asm/hwcap.h          | 1 +
 arch/arm64/include/uapi/asm/hwcap.h     | 3 ++-
 arch/arm64/kernel/cpufeature.c          | 3 +++
 arch/arm64/kernel/cpuinfo.c             | 1 +
 5 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/Documentation/arch/arm64/elf_hwcaps.rst b/Documentation/arch/arm64/elf_hwcaps.rst
index 694f67fa07d1..25b41ff74fa0 100644
--- a/Documentation/arch/arm64/elf_hwcaps.rst
+++ b/Documentation/arch/arm64/elf_hwcaps.rst
@@ -170,6 +170,10 @@ HWCAP_PACG
     ID_AA64ISAR1_EL1.GPI == 0b0001, as described by
     Documentation/arch/arm64/pointer-authentication.rst.
 
+HWCAP_GCS
+    Functionality implied by ID_AA64PFR1_EL1.GCS == 0b1, as
+    described by Documentation/arch/arm64/gcs.rst.
+
 HWCAP2_DCPODP
     Functionality implied by ID_AA64ISAR1_EL1.DPB == 0b0010.
 
diff --git a/arch/arm64/include/asm/hwcap.h b/arch/arm64/include/asm/hwcap.h
index a775adddecf2..7bcf1347ca0b 100644
--- a/arch/arm64/include/asm/hwcap.h
+++ b/arch/arm64/include/asm/hwcap.h
@@ -92,6 +92,7 @@
 #define KERNEL_HWCAP_SB			__khwcap_feature(SB)
 #define KERNEL_HWCAP_PACA		__khwcap_feature(PACA)
 #define KERNEL_HWCAP_PACG		__khwcap_feature(PACG)
+#define KERNEL_HWCAP_GCS		__khwcap_feature(GCS)
 
 #define __khwcap2_feature(x)		(const_ilog2(HWCAP2_ ## x) + 64)
 #define KERNEL_HWCAP_DCPODP		__khwcap2_feature(DCPODP)
diff --git a/arch/arm64/include/uapi/asm/hwcap.h b/arch/arm64/include/uapi/asm/hwcap.h
index 055381b2c615..675642ec4d91 100644
--- a/arch/arm64/include/uapi/asm/hwcap.h
+++ b/arch/arm64/include/uapi/asm/hwcap.h
@@ -21,7 +21,7 @@
  * HWCAP flags - for AT_HWCAP
  *
  * Bits 62 and 63 are reserved for use by libc.
- * Bits 32-61 are unallocated for potential use by libc.
+ * Bits 33-61 are unallocated for potential use by libc.
  */
 #define HWCAP_FP		(1 << 0)
 #define HWCAP_ASIMD		(1 << 1)
@@ -55,6 +55,7 @@
 #define HWCAP_SB		(1 << 29)
 #define HWCAP_PACA		(1 << 30)
 #define HWCAP_PACG		(1UL << 31)
+#define HWCAP_GCS		(1UL << 32)
 
 /*
  * HWCAP2 flags - for AT_HWCAP2
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index d1e758e99e0a..b8655d55f318 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -3025,6 +3025,9 @@ static const struct arm64_cpu_capabilities arm64_elf_hwcaps[] = {
 	HWCAP_CAP(ID_AA64ZFR0_EL1, I8MM, IMP, CAP_HWCAP, KERNEL_HWCAP_SVEI8MM),
 	HWCAP_CAP(ID_AA64ZFR0_EL1, F32MM, IMP, CAP_HWCAP, KERNEL_HWCAP_SVEF32MM),
 	HWCAP_CAP(ID_AA64ZFR0_EL1, F64MM, IMP, CAP_HWCAP, KERNEL_HWCAP_SVEF64MM),
+#endif
+#ifdef CONFIG_ARM64_GCS
+	HWCAP_CAP(ID_AA64PFR1_EL1, GCS, IMP, CAP_HWCAP, KERNEL_HWCAP_GCS),
 #endif
 	HWCAP_CAP(ID_AA64PFR1_EL1, SSBS, SSBS2, CAP_HWCAP, KERNEL_HWCAP_SSBS),
 #ifdef CONFIG_ARM64_BTI
diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
index 44718d0482b3..f2f92c6b1c85 100644
--- a/arch/arm64/kernel/cpuinfo.c
+++ b/arch/arm64/kernel/cpuinfo.c
@@ -80,6 +80,7 @@ static const char *const hwcap_str[] = {
 	[KERNEL_HWCAP_SB]		= "sb",
 	[KERNEL_HWCAP_PACA]		= "paca",
 	[KERNEL_HWCAP_PACG]		= "pacg",
+	[KERNEL_HWCAP_GCS]		= "gcs",
 	[KERNEL_HWCAP_DCPODP]		= "dcpodp",
 	[KERNEL_HWCAP_SVE2]		= "sve2",
 	[KERNEL_HWCAP_SVEAES]		= "sveaes",

-- 
2.39.2


