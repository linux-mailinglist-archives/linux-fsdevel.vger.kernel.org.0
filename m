Return-Path: <linux-fsdevel+bounces-27668-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36060963581
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 01:30:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69DDD1C22748
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 23:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DADC1B140E;
	Wed, 28 Aug 2024 23:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZtDMwdQp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B118A1AE05F;
	Wed, 28 Aug 2024 23:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724887748; cv=none; b=Yhnl3mwt1aPftiE2zoHDNnlaXK629mJQ4oTugO3SIuxTYn/h9J8PrdH8cQHqPagA7Xj0Wz7kQGAqIX11zCRRZmmwz9ElZY0Khr1EKkaZYGabsoETdC9JzGOM5H44yAIwSWiHekNJ/YIPBReqNLxhnAI9qYkQYaa1KgPSOKDY3KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724887748; c=relaxed/simple;
	bh=rOh4m4fj2wClbocRq0H+LpbzuLewpkO3M5BRFF5QA9g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XvVfioMAVDquS30tBOV3MmWEip+zm1b9XIRW0KDeV4XM+QWLeLJhAoGj7B451rsxJSRvhbfTPC3ihENfO6mSUED4WPkdF7uYZdO8VtH0DtYRV+Pje4/0P3FVPROXm7bQk8G7UlPhhrF4KYPuXYvG95iLDkE5Hnzx5AzHFfv9cBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZtDMwdQp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76D85C4CEC9;
	Wed, 28 Aug 2024 23:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724887748;
	bh=rOh4m4fj2wClbocRq0H+LpbzuLewpkO3M5BRFF5QA9g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ZtDMwdQpJIDs2Rkwg0UYeDSZGl9Kgy35c06eDIK4/xNomEaD++8/p8t2QXdJEAztH
	 wSDe8Jup97ATXtYoBygYSHUOvxgA0EtDFbcoVHiHXkZU64s+4e7QdTpYwjHwYUNNA4
	 fmXhbKdf9yiRBra8gOySoZ5GyegNK29pluB9SC4oXQpTUsASjznj/+gelnrStbMUCQ
	 mzoDrv+bTHH8lLa0Z0jhD+yocQgZqM15phOtwWzVvG0Hlip8JN4BaxASDLVEXK4jb0
	 ciKTdIgx29iXFhoHHZ6RBmDIqv5QKOIIhKW1Dsd8YOdLxp4HP/wwySaJA5xzlpY4PO
	 wYLCOROxVvtxw==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 29 Aug 2024 00:27:21 +0100
Subject: [PATCH v12 05/39] arm64: Document boot requirements for Guarded
 Control Stacks
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240829-arm64-gcs-v12-5-42fec947436a@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2380; i=broonie@kernel.org;
 h=from:subject:message-id; bh=rOh4m4fj2wClbocRq0H+LpbzuLewpkO3M5BRFF5QA9g=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBmz7J8Z5KYwVa17Tubvy4OA5GT6N3rKn+DrkFI1TFj
 ZrKgfK2JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZs+yfAAKCRAk1otyXVSH0MAcB/
 9SchQoHpvxwB9OxCqShz/dLftqcvRCIWxO9ZgoadV/U4Z50nuJqBdPypaRBS3bZjxOdOISP6XQ/CbU
 3V5v+g4JXxiGcKDkpOi/GfmZ6t1GA/fgPZdFp7Ckdq8Pt0Zt/kwqhC/xwj48+HPd3g5yzqtjHeJ9VG
 yMVnneUwHH2TzyyvgGOyEVPO6GLr8arjGFoQ31TxvfiC+NskBEnNqcixA8MMAzSn+sZ8Xfxuyxmvgi
 MILIA4dpUWrY3uWd/x5J6+znHC9MOgmcxRhX2X16jFT1Zd5K/rFTcP6Wz1FXTwZMdn/T7eo3Yjz4iO
 RIWXdgHpzMXKw6EeHaoiWr7gUCLOry
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
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
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


