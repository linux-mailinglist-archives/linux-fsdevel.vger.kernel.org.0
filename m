Return-Path: <linux-fsdevel+bounces-3388-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA8857F426B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 10:46:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F356B1C209C5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 09:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D47156463;
	Wed, 22 Nov 2023 09:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZNt/mhOl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903BE55791;
	Wed, 22 Nov 2023 09:46:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 866E8C43395;
	Wed, 22 Nov 2023 09:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700646383;
	bh=0y6nS2SVdzl2qxV5TcDCnpKi8YQvhWLC/gR5WsuQggw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ZNt/mhOldQGyAGrFdcd7zCoYi9c4Cpbfl611N1nCbvre1FYvH7Zl1qxYMHlLUXK/R
	 oTr4pGgCl3ZqkdfLg9vxV823aJQE0eCLlAhRLaW1gT0pmdwjk38uP6NXqfphyDxggd
	 Nce0uiHdxAcfp2N1Y9laenaA7HV7sOUFODNyqrBMy7XcrOzKnRNQTKmHrYboi3WFf4
	 QOpE3cQlVvo2KE6NieOOuSEronhIGHfX5fucm1ZO0NVH0NxleNUmMK8+wdtaJLpRNh
	 bN4Wz6vhiC+V3XP1enBFhlP/PZm5aE6IiSJnXGkBC62BqC2W7W+tQNNElkgCPc4NEY
	 Pt1AESbQWlpmQ==
From: Mark Brown <broonie@kernel.org>
Date: Wed, 22 Nov 2023 09:42:37 +0000
Subject: [PATCH v7 27/39] arm64: Add Kconfig for Guarded Control Stack
 (GCS)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231122-arm64-gcs-v7-27-201c483bd775@kernel.org>
References: <20231122-arm64-gcs-v7-0-201c483bd775@kernel.org>
In-Reply-To: <20231122-arm64-gcs-v7-0-201c483bd775@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Andrew Morton <akpm@linux-foundation.org>, Marc Zyngier <maz@kernel.org>, 
 Oliver Upton <oliver.upton@linux.dev>, James Morse <james.morse@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Arnd Bergmann <arnd@arndb.de>, 
 Oleg Nesterov <oleg@redhat.com>, Eric Biederman <ebiederm@xmission.com>, 
 Kees Cook <keescook@chromium.org>, Shuah Khan <shuah@kernel.org>, 
 "Rick P. Edgecombe" <rick.p.edgecombe@intel.com>, 
 Deepak Gupta <debug@rivosinc.com>, Ard Biesheuvel <ardb@kernel.org>, 
 Szabolcs Nagy <Szabolcs.Nagy@arm.com>
Cc: "H.J. Lu" <hjl.tools@gmail.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Florian Weimer <fweimer@redhat.com>, Christian Brauner <brauner@kernel.org>, 
 Thiago Jung Bauermann <thiago.bauermann@linaro.org>, 
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
 kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-mm@kvack.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1372; i=broonie@kernel.org;
 h=from:subject:message-id; bh=0y6nS2SVdzl2qxV5TcDCnpKi8YQvhWLC/gR5WsuQggw=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlXc0LjTRQMrZZBOJgPLB48tbG4uiml7CZIDEV5
 uQD798eCNqJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZV3NCwAKCRAk1otyXVSH
 0Iq3B/9HlE8pfPFk2nuyqu1U5wC2TDnfo30tlZoqa72rjxWoZMeOZIt03d7ifiDGT60BAhV7DR/
 X2q4ijl0gxsqAdoQTECIT09I17i0jhkg4sOrFnUM9S88Dc3B+OIQORdu8k6AozeCurJMkcd/ICY
 snWt5N0Nh2ox8T7U6IwsCVSrOZfctm8ylWDVAVHxsy53/DBhuI0FtT+rlbYGseRcYj1zRLPXpf+
 BVttx7Ntz2AelFYWVTuV1+GEKIwFIHMxKR/QSrU8uS9CzItwTUAOZKN30cLz7YqjsJMsYAnSVKN
 Bd8Eqt+f6s9NrIoUWZmOF8FfRH4sNLQwPl0XXWRCxkdsmJNx
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Provide a Kconfig option allowing the user to select if GCS support is
built into the kernel.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/Kconfig | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 7b071a00425d..05cffc0f5786 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -2078,6 +2078,26 @@ config ARM64_EPAN
 	  if the cpu does not implement the feature.
 endmenu # "ARMv8.7 architectural features"
 
+menu "v9.4 architectural features"
+
+config ARM64_GCS
+	bool "Enable support for Guarded Control Stack (GCS)"
+	default y
+	select ARCH_HAS_USER_SHADOW_STACK
+	select ARCH_USES_HIGH_VMA_FLAGS
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


