Return-Path: <linux-fsdevel+bounces-24753-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F83B944BEB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 14:58:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF4C0289BB8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 12:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 202021A3BAF;
	Thu,  1 Aug 2024 12:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nM/gS+qr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667661A0AFA;
	Thu,  1 Aug 2024 12:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722517067; cv=none; b=Ad6otzj307YGANJnCcJDg1LOFFXlMm6yNBjWhBvVKPS9K3tE0Ktx3hhV4BEoVXlbSYpvPZVsaqPayGAwAOeoUBFBDXwSo0mQ0NGayKMC+w6o/Fd6//EgOW3/PSXkBEXmZkAPO6CzssLOyXDrf9FR6iGlwOmOytQ6JG8BwZH6uL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722517067; c=relaxed/simple;
	bh=3RZmbStJwVSGoP/qDNBFqPg5B/6FQNSgda/JKhBv7x0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SlqdX/b4VPC6kpcqBA11YDpxtYOQRxFFzfWv+75n9NxDJ+GI/cNFEGwBzp+p6xucTbZn84CGGjt7GnRi8BPsSDiqBIG2PwXhnUflu69fRA2lWANy4ONlneeyVZxAx7b1nPRYxPeYkVzuEpbZEzAMFZIfowH5n6HgebyRt/di8Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nM/gS+qr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB533C4AF09;
	Thu,  1 Aug 2024 12:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722517067;
	bh=3RZmbStJwVSGoP/qDNBFqPg5B/6FQNSgda/JKhBv7x0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=nM/gS+qrFmEXsCA6RF2Xqdp3hb1CAKq9WGlHmbcwRTXnqJw63mJKa4Kb0O2iVyBX2
	 g+uUNVNRjO5ozwRIafO9FQN/TC2c9YJ54Kgb20htooXIcwdQdv0/WQvAb0B6YZiqwN
	 V6Efuiql/CuGLVlN6wj5nbtZXYGIkaf7IyVu8aI2utkfhPBKvajQTPqGg1P5vk0rze
	 7MtTS4W1GnMoYc32N3Xl9mhD+/J57V+Rw0T3h5K0wrwT6eDPfmMWS/Bp6EviouyVku
	 iYaaz+B9BVSeAENv0L1FLziwTmgtD7qWVp75kIlknntKSABmRyBsTOhcAkjitVxC2d
	 oX1/sMdKfEtZQ==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 01 Aug 2024 13:06:31 +0100
Subject: [PATCH v10 04/40] arm64: Document boot requirements for Guarded
 Control Stacks
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240801-arm64-gcs-v10-4-699e2bd2190b@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1946; i=broonie@kernel.org;
 h=from:subject:message-id; bh=3RZmbStJwVSGoP/qDNBFqPg5B/6FQNSgda/JKhBv7x0=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBmq4YJBO3yLLrkfe904+TZtJB1T9HeB08OFT8n6HhY
 M3NNmXKJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZquGCQAKCRAk1otyXVSH0B+qB/
 43pou9Y4TC/1pa0XTbag+sHQNoVFkuUIA8FSfx1e87YJGvqHTeNRK4JKwnIPZS8ZFD//FeU6sWUSfW
 yxOSuNd5EuCHGVVWwisTo696Z3sw6XMWW7d8fhRPIuFFtqtA6kpgUUm5VnWhlwsUMJLlyEvhPCLH9M
 W1uyrDqwl2iSR5m0UsF7EGNk5xhw5KPc8sOnTXdUsLVKW+omEqyEmUym6r/iwkWJKgT/pfEyZjPiOb
 09Gkvy+2Bqy0iqZTzyLHdRiLMdV98L/zhHvVf6T0+hXGkl8wPotyUaXqIQUnOZ/tgnOUYdr26cwP2w
 XhAdMoByrIqOboCZuztVTcCPMQnZS1
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

FEAT_GCS introduces a number of new system registers, we require that
access to these registers is not trapped when we identify that the feature
is detected.  Since if GCS is enabled any function call instruction will
be checked we also require that the feature be specifically disabled.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/arch/arm64/booting.rst | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/Documentation/arch/arm64/booting.rst b/Documentation/arch/arm64/booting.rst
index b57776a68f15..f5b8e4bb9653 100644
--- a/Documentation/arch/arm64/booting.rst
+++ b/Documentation/arch/arm64/booting.rst
@@ -411,6 +411,36 @@ Before jumping into the kernel, the following conditions must be met:
 
     - HFGRWR_EL2.nPIRE0_EL1 (bit 57) must be initialised to 0b1.
 
+ - For CPUs with Guarded Control Stacks (FEAT_GCS):
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
+    - GCSCR_EL1 must be initialised to 0.
+
+    - GCSCRE0_EL1 must be initialised to 0.
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


