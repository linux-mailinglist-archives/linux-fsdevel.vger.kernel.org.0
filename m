Return-Path: <linux-fsdevel+bounces-27673-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C86D796359D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 01:32:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D69AB25646
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 23:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AC7F1AED54;
	Wed, 28 Aug 2024 23:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UTt5Z5R9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43181AE034;
	Wed, 28 Aug 2024 23:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724887784; cv=none; b=U6cdl4eXx/tefVyNOGUTtSUUHlF56Nv7FlqfY8WU+1NE78N0x8fwgKrYTV7seGtjGxQ2/VUjvKV/XHHQD2OUMr5+YQVz2e87hZvH+8rw1p1V9sKqYBnaxQ1wWBnvdnJr7FcJR2ImaOul2cWGcSBqO0/kTabizJDwkVN9OMJRzlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724887784; c=relaxed/simple;
	bh=3PCkZcUSj968cQtTDjlzona7eSoMlRvIMvYTHUlF5zg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rkXrtgWC8s4442KybPnUcEJoVCriC4dU8irUfA42j9fzeb/xzXgGysLmR4nrL05cmeICxfDQ+P8VECeygw6Me3Pyw/Sh8bXCuDJHHvxsVE1tPGFy5g5yJEPZWjb8EmD/jr2TUxrIj3oTSrED2aVy7Eq1+c4M5WV8mrzsTxDuREo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UTt5Z5R9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79C41C4CEC4;
	Wed, 28 Aug 2024 23:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724887784;
	bh=3PCkZcUSj968cQtTDjlzona7eSoMlRvIMvYTHUlF5zg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=UTt5Z5R9O9L3+/5QwmzXLa0NZOyyFfOJvNEjdjsou5sYGYQDRTvuWaDX1alKAOM3r
	 PlKZvIQsEyXMPw14zormLU4udP4t90TY41lquo/Zt2XZzvTiEF5gjVphHd8EJLzRLC
	 P+j2++1e9WN6x2mQmznqNIwtsbdv55cIDxKpuSBIPiQBJhaGwvKJk7vFWk9VoLtfO1
	 iQ4uNzq0QjpqxWA0pLbpi4l9Uzg6snFZfoNbr/XjnMQEheyhlfOY5Q5pebN4ELHSCN
	 a3gyN8SMoG2g2U7qkibyWiBE5onpK6paLCCsZiYsY3GokgRP7lgu4Zvfv2ZXwMOvog
	 eMFKSeRr8WCuQ==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 29 Aug 2024 00:27:26 +0100
Subject: [PATCH v12 10/39] arm64/gcs: Provide basic EL2 setup to allow GCS
 usage at EL0 and EL1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240829-arm64-gcs-v12-10-42fec947436a@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2350; i=broonie@kernel.org;
 h=from:subject:message-id; bh=3PCkZcUSj968cQtTDjlzona7eSoMlRvIMvYTHUlF5zg=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBmz7KANWZG2hh16VubTD5fO6Rw8TQa6E+JpUOJeRjf
 o/z2jmaJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZs+ygAAKCRAk1otyXVSH0BStB/
 9JzYqvtihAZIiZE0UehfqFnvL+Y7P5f/SIYrMDhXoNsieqAPH5A7T5d8Y1bIohg98VNwdg5w4oSCiW
 IvqTzCS7J122yXyYslDcQpnpWDID1OF4fKKO3ctjEkmGQAKDimom7bPTI8CmN9SRcJjQ6MrUDDI1/2
 NlkwdJFRKuqy9Ktus3cxRtOwnCM3oAys0EXB2tKsO02QinWHdzMze5hnM/eR7rdP6knSPR+iV92uSf
 FbbV4o2RswyXeZwGtddcBmDTDmG7C3KCNsn/C41uHvNHavqMOspSJMyqZy6kQUJqezSFaqovv4yZb4
 EWd0RMJuEI1s5UNCl6/d+NUL5sxNZq
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


