Return-Path: <linux-fsdevel+bounces-26609-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B11F795A99C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 03:19:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 387A91C22E62
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 01:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80E5818EAB;
	Thu, 22 Aug 2024 01:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rL6L4UeP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D410B125B9;
	Thu, 22 Aug 2024 01:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724289484; cv=none; b=YcUp0Fhh8jNjoZy4lrphdILHNhJnhf3f0wQWcWyYd7+DcehWG98XlNzOa1ZVLLoTy8iVTEL4ba3a2wRmkc+z/vbxRDbBwtmIAOcYoVCaQh64pTsomlcsmEmaQuc7zOfKinpm8pXlPAOVuSjwACmVcXSkDZGGuBckYBDCldcjSsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724289484; c=relaxed/simple;
	bh=3PCkZcUSj968cQtTDjlzona7eSoMlRvIMvYTHUlF5zg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N1pnWhRMTQAbxA6Jnd/gc8G4WTuSYoibifp5LDIu5x2T7K58mc0mJkHIW1RjYY/FL0XpzoX2QpC0ULOZr/gs0+WALA1+gc+rL0z08T3OIbWoOm8GyqNCSgVDsWwpoN/fUfPqI012V4PWEINbKPAz5NWXPcbcVVsrVEv8lTg4LE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rL6L4UeP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18BC0C4AF49;
	Thu, 22 Aug 2024 01:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724289483;
	bh=3PCkZcUSj968cQtTDjlzona7eSoMlRvIMvYTHUlF5zg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=rL6L4UePYIBcPMAMegpXM3RvHxb2UJ0cC/+C8fpXlliJfzZQf/OJfebJgVNd2sbHN
	 ia9NMcdfyb019v9u3XO349wiVGcmLu3cBda9ak5bgbl4HoaunhzW4Y/1i/veMC5Fqm
	 Ontch1UKVDToIiEWiaf4nd5jCXlEvEF7yWbC6YgWko9n7mXIoIb/vqWUgq/Z7kWDZB
	 GjdqRfmJ1qXL+8VXajm9bFVeX0PqyGMeq5y5WlRrCDssBsNsq47adh5LzFZKjdWo4l
	 LomOhSvvoMAaJq1PSi5UiMHAuNFRfHDidBYedvObewFLGS43WFlxOHS2uVci20uhQx
	 OQXDj4ckwymLQ==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 22 Aug 2024 02:15:13 +0100
Subject: [PATCH v11 10/39] arm64/gcs: Provide basic EL2 setup to allow GCS
 usage at EL0 and EL1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240822-arm64-gcs-v11-10-41b81947ecb5@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2350; i=broonie@kernel.org;
 h=from:subject:message-id; bh=3PCkZcUSj968cQtTDjlzona7eSoMlRvIMvYTHUlF5zg=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBmxpErUArASSVoXSqG8ijxz/nsmfDylSJ+4ae2T1K1
 K4ZJwp6JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZsaRKwAKCRAk1otyXVSH0DYDB/
 4iz3InFtNmnnhuBjqryzodiJBbmRksPiASjzcSakrQObaTee7+KpN6Jhe4FZiD+g2nLj2VzVRW2VT3
 JxmjDexLp1d/fqGKyZ7mg8isuw/HaVt7JXSMTtFmDw5x8Il+EZ3cYPwYFv7dyJXyKYSmOwW7EzSmIo
 CYxc7QplBTd3GMcSyDAZgPHnzRjWXv8X4CN5FFfsUDyEai5heqd6TfYxiBaC1S7LL48LRW/PtOCrN9
 NeF/IblrFoj2msY3FUj4taGpbS2kH9XpV42oXfTt4KdNlop5PUiJWMkxLK9v9in88jz0Lazw+zKhDK
 tQQPXRyCTwlniXzYqqTlLkHx6HI6ye
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

There is a control HCRX_EL2.GCSEn which must be set to allow GCS
features to take effect at lower ELs and also fine grained traps for GCS
usage at EL0 and EL1.  Configure all these to allow GCS usage by EL0 and
EL1.

We also initialise GCSCR_EL1 and GCSCRE0_EL1 to ensure that we can
execute function call instructions without faulting regardless of the
state when the kernel is started.

Reviewed-by: Thiago Jung Bauermann <thiago.bauermann@linaro.org>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/el2_setup.h | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm64/include/asm/el2_setup.h b/arch/arm64/include/asm/el2_setup.h
index fd87c4b8f984..09211aebcf03 100644
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
@@ -191,6 +199,15 @@
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
@@ -204,6 +221,17 @@
 .Lskip_fgt_\@:
 .endm
 
+.macro __init_el2_gcs
+	mrs_s	x1, SYS_ID_AA64PFR1_EL1
+	ubfx	x1, x1, #ID_AA64PFR1_EL1_GCS_SHIFT, #4
+	cbz	x1, .Lskip_gcs_\@
+
+	/* Ensure GCS is not enabled when we start trying to do BLs */
+	msr_s	SYS_GCSCR_EL1, xzr
+	msr_s	SYS_GCSCRE0_EL1, xzr
+.Lskip_gcs_\@:
+.endm
+
 .macro __init_el2_nvhe_prepare_eret
 	mov	x0, #INIT_PSTATE_EL1
 	msr	spsr_el2, x0
@@ -229,6 +257,7 @@
 	__init_el2_nvhe_idregs
 	__init_el2_cptr
 	__init_el2_fgt
+        __init_el2_gcs
 .endm
 
 #ifndef __KVM_NVHE_HYPERVISOR__

-- 
2.39.2


