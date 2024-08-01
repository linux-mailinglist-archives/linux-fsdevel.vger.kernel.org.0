Return-Path: <linux-fsdevel+bounces-24758-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10CC4944C06
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 15:00:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB10D289412
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 13:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B2DF1A4F11;
	Thu,  1 Aug 2024 12:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pTC4lgO7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E261A0726;
	Thu,  1 Aug 2024 12:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722517101; cv=none; b=cKl8I/c5HDujTWUtalsGw8kySMWlTPm+igW67sTqubtip7+HDMl9IPe5sCSYk1MDDpzvKrhydHm7efZU36Xg9rGXBx9OCiZHtPv68/H8SrIF20z2ZWGdb1pADZilWqDLDBv6FpiyClAKIXyF+Tm0kOzhbCgcv2nWt0phg57s4dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722517101; c=relaxed/simple;
	bh=n96ljJnJVMpYM9CVsfMUORPIasrMIuo5nt8SCuY5I/I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C/SomfTVA9vvDCIjGlPzqnsuj4jg4RXUxclBuiQu7Bcz58UcTheYs7x09Vl3cFgaGal0cRAV0ipPoYnTGET4ujyWjg7I9FMrU+MuF5iMmZ4PpJTBkNj4ZVCawwPUfJhnKkA63oGYivXCfC7NoLT5D6QG4oj+ZLDeE3U2s+ov7HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pTC4lgO7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DD58C4AF09;
	Thu,  1 Aug 2024 12:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722517101;
	bh=n96ljJnJVMpYM9CVsfMUORPIasrMIuo5nt8SCuY5I/I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=pTC4lgO7SQKGHaiX2nkMESdUjPENIlCeXI7cbdMEO1veZv+NnE7Q0HtzHnypIRSwX
	 EFFbCP9R/odkVfMcUNhw2BYaIXYd3+HHHyjwGShekpbDTq/8639R57lZi260FRwS9W
	 BXwQfAdQaytr8C0yGa+c68hCauRvpcE5dlS4czXMOBk4eaOepEeEMdHSJS4YgQtuZk
	 I467IPjnvVLTzCPUkz/2CCGzWf602uS+MbKUA33Seoqav/yPBIg4Pmjhg1gOrHSJdQ
	 mzerRki9mRWRzWC7SiWU82YMhlX5m5cdrQzDukG/jpa0w3ctN8oQ6BmSr2GFLvtm/r
	 68Ybg8kKNBgRg==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 01 Aug 2024 13:06:36 +0100
Subject: [PATCH v10 09/40] arm64/gcs: Provide basic EL2 setup to allow GCS
 usage at EL0 and EL1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240801-arm64-gcs-v10-9-699e2bd2190b@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2228; i=broonie@kernel.org;
 h=from:subject:message-id; bh=n96ljJnJVMpYM9CVsfMUORPIasrMIuo5nt8SCuY5I/I=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBmq4YMcSNTIJcJ2iVFyb/E14kVTlvrio58Ua+gwj4/
 lAQflIiJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZquGDAAKCRAk1otyXVSH0DvuB/
 oDx/VdoNOsQl5QDmrDks6jRvVft2wlWPJjs7YotfALeKJpT6PRTjX/fHk0yQ3nT1TbsgavUVMh5ugk
 azWaDppWDeoeJyRUeR8AwqHPaLkF75qzW8tRm1tYmbjlUvU9Cs9kNG23dqrPxY48VY9JN/FknkR15Z
 vIT8K7Tidey9v247fvxyj4rfKz1arkjoyGZLJVMyWb6u9BHi66D9qeos14lTWlCqrtqjX8EJYBKS7r
 3I0t3sTBFUAUPotD1oVJPOQb4oPqtBVJy9PMQP1Yq1fWgtYabT5l5VrcJQzcK+M8dNstOCEIZLt/rL
 V6ygoYoUMW539BYpF1RQrxycLsV1z0
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

There is a control HCRX_EL2.GCSEn which must be set to allow GCS
features to take effect at lower ELs and also fine grained traps for GCS
usage at EL0 and EL1.  Configure all these to allow GCS usage by EL0 and
EL1.

We also initialise GCSCR_EL1 and GCSCRE0_EL1 to ensure that we can
execute function call instructions without faulting regardless of the
state when the kernel is started.

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


