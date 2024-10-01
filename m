Return-Path: <linux-fsdevel+bounces-30584-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4786198C8BD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 01:03:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95C74B241AB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 23:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 343411D042E;
	Tue,  1 Oct 2024 23:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cn0MHg3e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2DE1BDA9B;
	Tue,  1 Oct 2024 23:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727823718; cv=none; b=gH6zI1rOdZjpDiYXeGQ1Qk4zdmVE2E22Bxa2f5w59YPBgsM2JF4w03q+PprC/rsCBE339wNj+nodurWNLbJD8nGrZIceDh38bATryqfQotyUa7Rn9aMyon3L2B2/tpE7YTsU24xIrqNikEwSypAUXher5KoGqpL4y9ZLlxKk1dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727823718; c=relaxed/simple;
	bh=Ks8MFARHCgoYvKlZU6GLbHhVfaqXF8TPA2joPbZMDJ0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HNOq3aW6aynYM6hGSwDGFtN+dNMyzUiGTKw9CoNgvFKPL9DHhlX5pN98Rlc8ID3xKJS1KibFsfTTAtILuSkcBv8Nl0JtRI/JwrlyKhCkgs4A1elysKHIcecwjWvu8CLcitY/gvYx4ag2+yx8r5udq5XDmx9aWrAdEYzJtrUgojk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cn0MHg3e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D4AFC4CECF;
	Tue,  1 Oct 2024 23:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727823718;
	bh=Ks8MFARHCgoYvKlZU6GLbHhVfaqXF8TPA2joPbZMDJ0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=cn0MHg3eO0Yo4Or//lQRmgonz5ejCUv+6594M8VlW6g8B5NIWlg860BJ6D8qI2YgV
	 GV+I3lNe9kuZP1vrCgqbzVS6hK9e+nc0txyMnJ9T8BT9Uh+OEmcDYrfNNz7bzBOn6S
	 oRFXhyJvXgEpzBJ5KVKYMioEvdK+KG96dF0Km5qHym4e1l9SU/X5va2Xey3Dk154O4
	 hMljQY4YA3oBYMuXQLOUoRZaCvlmileovyiCzDXvVRsJaA8NHELWgzYESuf5NthmQY
	 Z+sByWmrf/S56XQALexiOpbAyIVq6QTCeeCuG3iOdod/wVu9gWyN5eQUa+dfllnXpK
	 SUfOmuhLGsQ+w==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 01 Oct 2024 23:58:50 +0100
Subject: [PATCH v13 11/40] arm64/gcs: Provide basic EL2 setup to allow GCS
 usage at EL0 and EL1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241001-arm64-gcs-v13-11-222b78d87eee@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2363; i=broonie@kernel.org;
 h=from:subject:message-id; bh=Ks8MFARHCgoYvKlZU6GLbHhVfaqXF8TPA2joPbZMDJ0=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBm/H7Mo7StH9NeEdFx4e51cOj/G4fz2GUpoEOK3dVF
 ihqzuxKJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZvx+zAAKCRAk1otyXVSH0E4VB/
 44Y/DcxPyyJpegtnqk2Xgu4LfuVN9YN36+8Wa/TWW/x1dk/OsduoSR0EhzeC2naITe38OnI2yNsg2r
 HN/GaAXzc9BwXtFDMkIxufE38zZBxSH6tb7DRcyR4t+sY0wc8QE2X3AAAG9PSGMiA56nu5zdYlC7XP
 PLgYHgUmzw+YfzPsfZBVE2jh1vAbXfixjIO03HSI1Rbp1UsVnoZspSK5JVdwcA5R6nZcMCt8dA9tEp
 bAEQuk72ftCeVy1fIrWWJlYMyaTZ2W23ceUAsMF+g+Ef8tFQJxR/QpzGSrU3J/a3W2zLuuMjMuopKW
 7ReB4Wzd9fUI3XBDKdquXjtl43L8R+
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
 arch/arm64/include/asm/el2_setup.h | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm64/include/asm/el2_setup.h b/arch/arm64/include/asm/el2_setup.h
index e0ffdf13a18b..27086a81eae3 100644
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
@@ -200,6 +208,16 @@
 	orr	x0, x0, #HFGxTR_EL2_nPOR_EL0
 
 .Lskip_poe_fgt_\@:
+	/* GCS depends on PIE so we don't check it if PIE is absent */
+	mrs_s	x1, SYS_ID_AA64PFR1_EL1
+	ubfx	x1, x1, #ID_AA64PFR1_EL1_GCS_SHIFT, #4
+	cbz	x1, .Lset_fgt_\@
+
+	/* Disable traps of access to GCS registers at EL0 and EL1 */
+	orr	x0, x0, #HFGxTR_EL2_nGCS_EL1_MASK
+	orr	x0, x0, #HFGxTR_EL2_nGCS_EL0_MASK
+
+.Lset_fgt_\@:
 	msr_s	SYS_HFGRTR_EL2, x0
 	msr_s	SYS_HFGWTR_EL2, x0
 	msr_s	SYS_HFGITR_EL2, xzr
@@ -215,6 +233,17 @@
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
@@ -240,6 +269,7 @@
 	__init_el2_nvhe_idregs
 	__init_el2_cptr
 	__init_el2_fgt
+        __init_el2_gcs
 .endm
 
 #ifndef __KVM_NVHE_HYPERVISOR__

-- 
2.39.2


