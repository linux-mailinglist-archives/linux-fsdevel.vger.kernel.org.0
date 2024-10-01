Return-Path: <linux-fsdevel+bounces-30579-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E88B298C8A4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 01:02:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5740FB249DB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 23:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 600D91CF7BE;
	Tue,  1 Oct 2024 23:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EwJEg0or"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89911CF29C;
	Tue,  1 Oct 2024 23:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727823666; cv=none; b=rG7FfgUm8mxGRHCNA1buDSDni4O7dVNLlZ8EJa0nU227gGcXQUChGPiKByrH3vbboa5HmjvJ6KUlS6ml9rJ/w4VSl3nBvKpIDzUBvjq/7CETVN07kM2TGFSoq+0FpCM02LUOPKyliEhYrbnXe8hl4Vr90M6fu15v7HMW4pkQSBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727823666; c=relaxed/simple;
	bh=rOh4m4fj2wClbocRq0H+LpbzuLewpkO3M5BRFF5QA9g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=noB13vs/gf5v3zV5rPNNzxDkGW+GoBaO42zFL1EthHlNf3E/H6VIQy7MvWBhSe49pSDZd1CKTfalK9nvUi28EdCYhSjRebgW1/ScOpG9Kk7nSIcvDbAtjJkK++gExlwG2KE7MgPQ8edRoiq6wUV2ka9FM3fPOxISpDGXwX6CmWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EwJEg0or; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 676C2C4CEC6;
	Tue,  1 Oct 2024 23:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727823666;
	bh=rOh4m4fj2wClbocRq0H+LpbzuLewpkO3M5BRFF5QA9g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=EwJEg0ori93CigiLXfM5nzkzTLmGWgRtXKjPULKcnBgukqJz6P6ymcuAN6ht2YaRy
	 wgamKhoUMormn2N+/htgu2VlgVf0uTQ1ITD9QDL6rB+P/kcQjVFPWhXZWaet1ichPB
	 jwEKXZw4fQuWgLCXpPH+LjAXYH3cWDylFR4MTG95fkh3MPrYsKP06PotNeH2zId6oP
	 uMEww4ujLpbVwMP3AsRdLcu4O2epXPKu6DVSY/UoUX6Y8yOIrjQvEpw0NYbMNA7sA2
	 PJO1XQACz4QGYf0EaHCYle2qPWNV7t7Ih98KnqImQyQFZMqQEiY9KEOZW9LZtwjalp
	 KYIHKmBb8YxKg==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 01 Oct 2024 23:58:45 +0100
Subject: [PATCH v13 06/40] arm64: Document boot requirements for Guarded
 Control Stacks
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241001-arm64-gcs-v13-6-222b78d87eee@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2380; i=broonie@kernel.org;
 h=from:subject:message-id; bh=rOh4m4fj2wClbocRq0H+LpbzuLewpkO3M5BRFF5QA9g=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBm/H7I9yk8ghsLdqny2ZV4YER/rGKDoJ0hQxESLaXj
 e/jW+b6JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZvx+yAAKCRAk1otyXVSH0PQcB/
 9/5WoMr0iRfMQ6yNpxH+5BewveQcTTMADtDGZU0k/TPNq9rE3ncWHNxGcjO5lTOdD/EjuYj9w5bEib
 ie+7XUaGRkJxY29dQJM2fqh9IiDAAoMvM+M9HZzbBonZb0bOU+7VmrkMeOrSR4lCJC6G4P5Ihl5IHb
 Mad5JNsK7tZaGyxdxnDfBJ1yX3zPURMe+mQYJosdDYot7KoZtGajfg37krRbknWsjD1onnxwYUObrb
 f5er9ZMlomZ3/7/BsXHsZBpV6lW/DjF7b64sbPvl06kGHxPhZ+slMQUCDMqXOnrfaJaYXc8c5z/cru
 3oB24kM87Df0vSL96ajkVILRkQxWGg
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


