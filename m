Return-Path: <linux-fsdevel+bounces-10171-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6FC58485FF
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Feb 2024 13:40:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 562771F2879F
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Feb 2024 12:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06AEA7763B;
	Sat,  3 Feb 2024 12:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rr0NlCUf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5680C7762E;
	Sat,  3 Feb 2024 12:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706963557; cv=none; b=AcSoHrn0wlCXoR9yjsSQGLfO1T9qMwkwiXzg+TPYNlq6IfJt+m1IGm4oXCSWUiqjUhbntdM80Vo9hfs1PvURbtWdNlFyCUYFdA9SZ0j/6wUXp4f4a6DDJaQ9xVKzIdGrTozCQN8Khsv8rptfeMxG5YKSVhsEsmx30x3qhSKVdeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706963557; c=relaxed/simple;
	bh=RGzSIrmEW7Jf6evuT6565KZp1tpVwBC25PeiKV/XCIM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AclgKjta+zioEIyu8IYfUJ6Wn3CSDh6NJGRZ6LqG7FFfqIOL4Sjlp1GkfEYrphudNBXzXy4r/U6JaLZBuz2yJXsfVnnq7V/ESX5PLJTCaK0ndso9JO4PLwv+xynMM8uFJeuz4obEXd4j1y+HERLr4qbzAOpybJ0dOR7KLKnbY+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rr0NlCUf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76DADC433F1;
	Sat,  3 Feb 2024 12:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706963556;
	bh=RGzSIrmEW7Jf6evuT6565KZp1tpVwBC25PeiKV/XCIM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Rr0NlCUfUX2j3myBULSLJPalVM826rFJl0vTY3fYPNIAoGjsaWyYKxtBifaNm6sDv
	 R3k3Z+e3/jgWq5+5PInC1Osi52ku2mCr6D9o1aURAOeLt+R2Zkk5U6R2wCML7xz6zk
	 PG81g8AMxl2rVOrJUNnz2N35u5ho9Xg89aJIJj9OoWN9wFUIZ/qvSjm3ZM8I4h9hFC
	 AbMSyA++bvK+sdEPPG3qzzEnAj62MLnGKSS32CcHHeeK/jUMKkKjE6RdyAZ+tvsviN
	 dDdf/wFFm15nQghsG5q3BA7MRI+OHsHHN8xmcmlC7HDsvlRem/d2ChYl+uIz2gqkTZ
	 rhMiIq5b7EusQ==
From: Mark Brown <broonie@kernel.org>
Date: Sat, 03 Feb 2024 12:25:52 +0000
Subject: [PATCH v8 26/38] arm64: Add Kconfig for Guarded Control Stack
 (GCS)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240203-arm64-gcs-v8-26-c9fec77673ef@kernel.org>
References: <20240203-arm64-gcs-v8-0-c9fec77673ef@kernel.org>
In-Reply-To: <20240203-arm64-gcs-v8-0-c9fec77673ef@kernel.org>
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
X-Mailer: b4 0.13-dev-a684c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1372; i=broonie@kernel.org;
 h=from:subject:message-id; bh=RGzSIrmEW7Jf6evuT6565KZp1tpVwBC25PeiKV/XCIM=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlvjDlwn8OBL1okRa937HDPu7LnBF8+tPg3W5TVRmQ
 TyRiYLiJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZb4w5QAKCRAk1otyXVSH0GddB/
 94PnXcnxhx9d3Igx3+8wyrY4sdF5KYIjmDuj3squkXqrrZ2tiirA6Q62mQp8vp+ezqY1jRXa4sYuJ6
 S4br3364VBFwZURGrMoqdURAvnmTRIVSNGGYe6TRIoFURRVmXmsSb1Zx9GeUJE+887P2YThSn1hX4u
 UYhHuNxxIuI+/hGpYdkS35l+885fx4nMPUte+GNr+FvdEa6vqVjtRScIfSuKLmDgZ/N4wSajZL/k1q
 rBPuJY2ifU59ibgG/D9dxZieNsgex3LyQf29V2Ibhl6yWuOIeyY9K15eIuhbvVWh0jnwxw8K8dMwt4
 yP307QaPCE4iW0R2nFKNxCYMzLGxW/
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Provide a Kconfig option allowing the user to select if GCS support is
built into the kernel.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/Kconfig | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index aa7c1d435139..e0048e4660cf 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -2098,6 +2098,26 @@ config ARM64_EPAN
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
2.30.2


