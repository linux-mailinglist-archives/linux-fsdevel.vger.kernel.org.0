Return-Path: <linux-fsdevel+bounces-26604-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C20895A983
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 03:17:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B19C1F2399A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 01:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3D19171D2;
	Thu, 22 Aug 2024 01:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ia0J7+D2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1991CA9F;
	Thu, 22 Aug 2024 01:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724289425; cv=none; b=nnOVHXPhIuLghuUT0dkvWtTo11DtyFHiqDlzt8sNSc3wLup9Hhe8/xHhsXkneY7bKB4giVxvd3CgsrTrkrPd2nwEFlOwymZLBdKtaDrZuBDDgrB8SZp8nc/NBDB1TaZliRafKvRn1XIRM9pe2Zq1h/HaL52dm5r+zRtTyLUoV+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724289425; c=relaxed/simple;
	bh=LciwolFLXXLWXDnsivqPJlAtVDmmbm43hS6WTnUcp7s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fh8YVWXILqQhrJVrC5OR5aTZu49D9PtX0myX4hoIWp2AeuM93yV4VFys9Ne9/Qri5Tan20FAYNxIN7b8GPNiLkhisObAgyTJ+kls9SWyMZARfwRjyyl4NeqZoqCgvWst8Bkfwt4w7x90zcDe92l33uyI7AqSU2zNZRmKGVugptY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ia0J7+D2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4565C32781;
	Thu, 22 Aug 2024 01:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724289425;
	bh=LciwolFLXXLWXDnsivqPJlAtVDmmbm43hS6WTnUcp7s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Ia0J7+D2NFXEmERA4MzAXLz1pGlb+558E6HkoadFLR+MbUfLle7EFSSmcioe5NUwP
	 FtkqMMdEx9UsBRQ/qORfUHBOsxA7OKwseQ/vNExKFBliIoDiDApWvzNXNmGrKWwGNu
	 r0yFtmaQOxeXmR0XePqzegx7CFhuusQYArnikYtytNSDU0bYR22HjH60ectbkksUdN
	 YDqKjUMZw/qGiw9MnNFna+T+E4gv806SFVvkWiF9bjxcEQB+e3TjyPh2eZGcuKbbxp
	 0fHNfQGupmKdAN3PouWeIIcmHIAKnGxvPb95W+cCIORajfoJhvSds4S0y8PIQnzVJG
	 48L5kKMqPA3eQ==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 22 Aug 2024 02:15:08 +0100
Subject: [PATCH v11 05/39] arm64: Document boot requirements for Guarded
 Control Stacks
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240822-arm64-gcs-v11-5-41b81947ecb5@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2324; i=broonie@kernel.org;
 h=from:subject:message-id; bh=LciwolFLXXLWXDnsivqPJlAtVDmmbm43hS6WTnUcp7s=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBmxpEngL7Lww4m52gXKTq1tKoqIVBC5xOmnd+rCOx3
 nXv9/fOJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZsaRJwAKCRAk1otyXVSH0OYEB/
 4xlpXpmgzrKErY1qHRUkcTUWg3EYHQ/Qr01sVqb0Ye+5PMjMVG+CInmO2KRkZ0gkgHMlZcu9ZrWqeu
 9rqYTkoaNj6IRo3kQmDFpOD7tSHwV3MHynW814M1FTg+A7qBtBCYE7cD7F9TvFm8+pKvzokXh3URRT
 hyu/gbZg3AW9s4kkAmNCa7t9G+ojCK6ye36D4jnQ7TT3NPoGgqOxHLnscslbvspCdMaE10YWE/OxOk
 bFnTh3K8ymWJnUMi0vhUvhnn1ulrNSdMfAW2DJcqS4JKKCk08fJmGK6OdYmuS1eQCWdxCbBbgifIBd
 0HuxoIfZvO7cjXv0Cl2nzl+EJ/keuT
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

FEAT_GCS introduces a number of new system registers, we require that
access to these registers is not trapped when we identify that the feature
is present.  There is also a HCRX_EL2 control to make GCS operations
functional.

Since if GCS is enabled any function call instruction will cause a fault
we also require that the feature be specifically disabled, existing
kernels implicitly have this requirement and especially given that the
MMU must be disabled it is difficult to see a situation where leaving
GCS enabled would be reasonable.

Reviewed-by: Thiago Jung Bauermann <thiago.bauermann@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/arch/arm64/booting.rst | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/Documentation/arch/arm64/booting.rst b/Documentation/arch/arm64/booting.rst
index b57776a68f15..aed6e9f47cf3 100644
--- a/Documentation/arch/arm64/booting.rst
+++ b/Documentation/arch/arm64/booting.rst
@@ -411,6 +411,38 @@ Before jumping into the kernel, the following conditions must be met:
 
     - HFGRWR_EL2.nPIRE0_EL1 (bit 57) must be initialised to 0b1.
 
+ - For CPUs with Guarded Control Stacks (FEAT_GCS):
+
+  - GCSCR_EL1 must be initialised to 0.
+
+  - GCSCRE0_EL1 must be initialised to 0.
+
+  - If EL3 is present:
+
+    - SCR_EL3.GCSEn (bit 39) must be initialised to 0b1.
+
+  - If EL2 is present:
+
+    - GCSCR_EL2 must be initialised to 0.
+
+ - If the kernel is entered at EL1 and EL2 is present:
+
+    - HCRX_EL2.GCSEn must be initialised to 0b1.
+
+    - HFGITR_EL2.nGCSEPP (bit 59) must be initialised to 0b1.
+
+    - HFGITR_EL2.nGCSSTR_EL1 (bit 58) must be initialised to 0b1.
+
+    - HFGITR_EL2.nGCSPUSHM_EL1 (bit 57) must be initialised to 0b1.
+
+    - HFGRTR_EL2.nGCS_EL1 (bit 53) must be initialised to 0b1.
+
+    - HFGRTR_EL2.nGCS_EL0 (bit 52) must be initialised to 0b1.
+
+    - HFGWTR_EL2.nGCS_EL1 (bit 53) must be initialised to 0b1.
+
+    - HFGWTR_EL2.nGCS_EL0 (bit 52) must be initialised to 0b1.
+
 The requirements described above for CPU mode, caches, MMUs, architected
 timers, coherency and system registers apply to all CPUs.  All CPUs must
 enter the kernel in the same exception level.  Where the values documented

-- 
2.39.2


