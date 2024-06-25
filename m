Return-Path: <linux-fsdevel+bounces-22384-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10B6E916BE0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 17:07:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BB32B23DBD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 15:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF1F1157461;
	Tue, 25 Jun 2024 15:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="STatpgD2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A3F16FF52;
	Tue, 25 Jun 2024 15:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719327740; cv=none; b=jXdYOwHswPtgQ910RBrYQ2NTEzJXktHAMBlSCxwvzOpOqXNIopeGWWGGSy67n0RlS9FXKvSJQ2Gt2AtP0StGDYsPki0zI0wd+4uWknpcOrQWhxPBvRTDkkfl4ezmH/fRaikAWSIbMdTHXFnizPs4CUKwCYkkt50tNWjAooC5Z4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719327740; c=relaxed/simple;
	bh=TfNpxv0/YFgIFj+ehQEMyQU6+Dwt53rcvRO+chZ3qhs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UDxamwtPJgrKC32r3f3e4FE1W/qF3M/02P6d9vwDoPW0brIJu80jwAxZM1X0EOeYRhD0EuMlI8pLPT0guZzi31iuj6902w+Z2b10v7bASES/AbJKY9MSG8uGyJzMuQLosDGLYNTc95BPtYmwfV1KCZDojC88/OrGzFOk86Fsjg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=STatpgD2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E37DC32786;
	Tue, 25 Jun 2024 15:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719327739;
	bh=TfNpxv0/YFgIFj+ehQEMyQU6+Dwt53rcvRO+chZ3qhs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=STatpgD2i8PfRN0VLtvr3/xO4Z576aE4SkCdSBU+uuppRnLcsEIl09YBQW4P3cJV/
	 5nPYryHHx8XOBERPro9tvUe7WHZE9e5zrrsmu7uDiDGlt1rb2tHMZJyRsZFXpQEZbv
	 Lfh5wJSR/w+YIO2f5HKJz3uW0rCPkXav7nCEaYXnujgz7Vxlwu6k8bfME/aWKN5ZK4
	 +2Vo7VpnCsfDzZhfVcVlex8iIkQZT7mslYD9IJbK3Wc8cUNQI++3PPJT5fRkID/Tew
	 +NOBLkJNPrtlIgMIPIPBPIpmMOxPyPr2D7FfuK1tqs8YknrdtCYI4ZF7jIhEJFDKm/
	 WGGoVGXke1AWw==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 25 Jun 2024 15:57:42 +0100
Subject: [PATCH v9 14/39] arm64/gcs: Allow GCS usage at EL0 and EL1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240625-arm64-gcs-v9-14-0f634469b8f0@kernel.org>
References: <20240625-arm64-gcs-v9-0-0f634469b8f0@kernel.org>
In-Reply-To: <20240625-arm64-gcs-v9-0-0f634469b8f0@kernel.org>
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
X-Mailer: b4 0.14-dev-d4707
X-Developer-Signature: v=1; a=openpgp-sha256; l=1532; i=broonie@kernel.org;
 h=from:subject:message-id; bh=TfNpxv0/YFgIFj+ehQEMyQU6+Dwt53rcvRO+chZ3qhs=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBmett9AN60q5kvIlR1ZcHcKPpCsET41XbuQScM991y
 JwD1yJmJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZnrbfQAKCRAk1otyXVSH0PcTB/
 9cpj20UTw99E9XrZQ4iq0JEfF+LAfyUcO1sE6bwkbyJu9xmMka/NS5vgBpaOVjWQHlLEA6PK8spBiM
 JKjkW5k7zeUW013lpa/iWiADA05kVin3SSzAVcRf9B/NoQ54ZJZjL/mHEhbeli16FDg4o3tJB5JOdv
 rddkE38qEE2zTtwySZ4pPFsqhi0Q44wMfZMrK0kuM+OPrCiPeoNUhtmczNkkW8l7SJ39SMwuNex5IP
 hWJE6EQjChRcge1YsVTmS/BdZdzg7R9HuIcMkXpq9JMQ2N6RpiOLZTx5hO97OoApANlVjDrX2w+rdp
 lXc8DUnhi7lkYJ83O1dvM78CD4A9ri
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

There is a control HCRX_EL2.GCSEn which must be set to allow GCS
features to take effect at lower ELs and also fine grained traps for GCS
usage at EL0 and EL1.  Configure all these to allow GCS usage by EL0 and
EL1.

Reviewed-by: Thiago Jung Bauermann <thiago.bauermann@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/el2_setup.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm64/include/asm/el2_setup.h b/arch/arm64/include/asm/el2_setup.h
index fd87c4b8f984..36aa40c19e85 100644
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

-- 
2.39.2


