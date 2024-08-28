Return-Path: <linux-fsdevel+bounces-27690-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82FD49635F5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 01:38:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5EAC1C217B1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 23:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 669F01B2507;
	Wed, 28 Aug 2024 23:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cmxwoYiP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30771AE031;
	Wed, 28 Aug 2024 23:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724887911; cv=none; b=hCGe1b67rEKJJz4iu6vuXaD/idxBt57BNcsd9IgqlKbvNXi+0Ka57sids5yeMiC8c5VkGdFJ6vtifLMP5Vwybbn+KyEDUhixF0Z5TGrHS4+RvrV1GKUXRo9/Wj2Yzv5+01pT3eu8drpk4i+SIRpAu+QFz81GbUSge3Z4WNQ6jB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724887911; c=relaxed/simple;
	bh=beFDrtDyIwMIQ+9ZnRJrXKiqbsyL6F5ZUs+tNbRY4bo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AwqVPGDWXkK/YySTY4v89plwIy+qDXntz7irOpV/MWGDUTzoWeU8dQ1kdbJ773H1B8Opkx9JGK3p2UourbM4D0U2VGKcZIKjG4lEU2cBIGyB06eAkrejuSWcTVtCAtXi5Oetri7aY9Ulr6pWRTw8kyHGkD22Ok/opKTb13+sG/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cmxwoYiP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FA6CC4CEC2;
	Wed, 28 Aug 2024 23:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724887911;
	bh=beFDrtDyIwMIQ+9ZnRJrXKiqbsyL6F5ZUs+tNbRY4bo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=cmxwoYiPlqAu3PpbAe4bGKFan0D35T9aFz1uyLOo8UJeOq5mAHsWPTyVNiP5qq+QF
	 1bJmwFkWzxk1xeCmgEZjTmbPypjyB2wMPlh4/9IEsgqdGpkxmvUz3PCfJH9PueVAL6
	 MKQBMKGgFzhwPuS8beYHyGbOiwMhjcRUsKrtqTZHRGCrVw+kmWWj1h9HXwUb6w3RWV
	 FYKB2GvPgAUY/CCdj7QhVw+qDbhnzLjrekLZU+8Q32/0IagdbBbZuMFRTV3mEFcGaP
	 m66+DiHgGeY1Hu80y6yk2xG+bH397ive8mzSUVwJSrPZmFjr4FhDO1y9KjCrF9iyRT
	 i9cYNNLgL2fWw==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 29 Aug 2024 00:27:43 +0100
Subject: [PATCH v12 27/39] arm64: Add Kconfig for Guarded Control Stack
 (GCS)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240829-arm64-gcs-v12-27-42fec947436a@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1518; i=broonie@kernel.org;
 h=from:subject:message-id; bh=beFDrtDyIwMIQ+9ZnRJrXKiqbsyL6F5ZUs+tNbRY4bo=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBmz7KNVB+3I+jq6y04asLcwgZ/MwTq5s+oa0mg+YNh
 Yfgu4RqJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZs+yjQAKCRAk1otyXVSH0BPHB/
 90dYgJUIMJYlO9HaX+ruyrHyhuRC2pGtl9VBK2lNdeGXJ6Hvqi4owpgy/8/6e5omy6rq70EJZcWYul
 POQSUjKOHIw23YuSNSZgnq/G5o/jHmK1bUc5Vbn/iSGWK+Qdd/pAYigxHAfQZv40m5SgkAm+/vKLRP
 Cn4pGEJ7bm1AL0CKRoMgGxW7lo4EIWCdJDkr6hLUENHRWN15nlW1jpIfgtrYVfTm+AN7qx8NuUyjwp
 MoSbOf9pQqmotQKVb8unNR3EsDxcpUueJxVZgR9sSM8h2vGjIfeXq6D2SF/qtFM9p7KvJAd/F9OMXD
 x31o4oXplu9qcRnov3va3/52q6tZ/o
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Provide a Kconfig option allowing the user to select if GCS support is
built into the kernel.

Reviewed-by: Thiago Jung Bauermann <thiago.bauermann@linaro.org>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/Kconfig | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index a2f8ff354ca6..3fa682151c8f 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -2137,6 +2137,27 @@ config ARM64_EPAN
 	  if the cpu does not implement the feature.
 endmenu # "ARMv8.7 architectural features"
 
+menu "v9.4 architectural features"
+
+config ARM64_GCS
+	bool "Enable support for Guarded Control Stack (GCS)"
+	default y
+	select ARCH_HAS_USER_SHADOW_STACK
+	select ARCH_USES_HIGH_VMA_FLAGS
+	depends on !UPROBES
+	help
+	  Guarded Control Stack (GCS) provides support for a separate
+	  stack with restricted access which contains only return
+	  addresses.  This can be used to harden against some attacks
+	  by comparing return address used by the program with what is
+	  stored in the GCS, and may also be used to efficiently obtain
+	  the call stack for applications such as profiling.
+
+	  The feature is detected at runtime, and will remain disabled
+	  if the system does not implement the feature.
+
+endmenu # "v9.4 architectural features"
+
 config ARM64_SVE
 	bool "ARM Scalable Vector Extension support"
 	default y

-- 
2.39.2


