Return-Path: <linux-fsdevel+bounces-10183-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F91284863B
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Feb 2024 13:44:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C01A5281C09
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Feb 2024 12:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9437D7F7F2;
	Sat,  3 Feb 2024 12:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F78PhGGK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9AEC7F7C4;
	Sat,  3 Feb 2024 12:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706963642; cv=none; b=KCDltrnfJjDSuKJKxUME2mqNEaFYvtvQ5YDoluWBOUmF4AWeHtpZg7GgJXN17nTgQSDBEhbeEWPyTxkVaftCpcm34CkBSrj6e27Fj2jpsGqfxQ/VQ3pm9cw3VJecrsEFuAzp7Dl9C/11aI2p5fgdveDSiTX/z6KSzMJLUqn5pHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706963642; c=relaxed/simple;
	bh=WXqbYsgYYOXFEeMs+roJ3AXRYBhuL60ozPF+o7O4bAk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J0x4Q2/WSGuE4Gggb/RW1lKOpYVeFpOhQk2Pnpk/rt7+MXSnnUuRNbd5TtnexsVURHUPatuj4INhCIVWkXDTFk++qA/j55HOY4505t/GNtqwKMCbSfoIa46L/DZYc0cwsZQbFX4jkO7jTHNwo6UkcqN/02EJYmIlUuNIQaeoGIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F78PhGGK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35D85C43394;
	Sat,  3 Feb 2024 12:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706963641;
	bh=WXqbYsgYYOXFEeMs+roJ3AXRYBhuL60ozPF+o7O4bAk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=F78PhGGK2tKTlc1p2op6t75h6sAseztGvobKzgGSABUqePNhCLv6h7b0MXYZozVvf
	 TMoM8VKK0ZO5F2e6/66jeGgtskS0UMHEiCAZUXqg+6vxYh1xgH6tpBdIJiNPgo7YpK
	 EnaGYjMB/A//4+Sjcv0gbyN2txDslqcYGoLlVah+34dTkNIBFZPTZDpK5wR3pQL70I
	 Dzxx0jU1Bjxx/D0JoI4d/HNBk5LzI9/lGYtAoE48s/fM91juriLFdFQwpik4auJ+g4
	 1D/HN4P1oVK7bX97yoTav7bFx3jIr53qvhASYz8zdLRC/yDEo0s7d2QHFhc9ilv97S
	 gLO6O0zcUVi6Q==
From: Mark Brown <broonie@kernel.org>
Date: Sat, 03 Feb 2024 12:26:04 +0000
Subject: [PATCH v8 38/38] kselftest: Provide shadow stack enable helpers
 for arm64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240203-arm64-gcs-v8-38-c9fec77673ef@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2372; i=broonie@kernel.org;
 h=from:subject:message-id; bh=WXqbYsgYYOXFEeMs+roJ3AXRYBhuL60ozPF+o7O4bAk=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlvjDvM7ObtGoCDxxiAl89DYa6RzxdLnWQy+FkForz
 aUSU5kiJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZb4w7wAKCRAk1otyXVSH0NEICA
 CCvybEtXLigY0Lceu5RSwEZ8U+9W6svq5+knPV3mZQY4TSxy9Yy4lyeVk8Pv21v/12qFvp6uqzLp0g
 k6+WV9GRZ/Pqfacx9BQ00Oc/rfhKVczK0MsQz3mDGVuLKbJ4qSNpb8/dqtFqZr2ObsOcGe2ZV7T/CG
 ALJt/tNjptHMxvEWIyQI3z/Smo1ZEdn4C7yaVXufiGkwDmFEB8wquT7O7Dh3npGDpxL78q4rAtfJy+
 8dPSdobFohDZMcnrMhjgw8Klf2bbVp8Sut5M7DVJ/t3nRkqxRoYhyVFTjjG6NdjDWhhL+IKQdltpt4
 8U4+ItNFhfAZrHX27/JjU9V30WRy/h
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Allow test programs to use the shadow stack helpers on arm64.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/ksft_shstk.h | 37 ++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/tools/testing/selftests/ksft_shstk.h b/tools/testing/selftests/ksft_shstk.h
index 85d0747c1802..223e24b4eb80 100644
--- a/tools/testing/selftests/ksft_shstk.h
+++ b/tools/testing/selftests/ksft_shstk.h
@@ -50,6 +50,43 @@ static inline __attribute__((always_inline)) void enable_shadow_stack(void)
 
 #endif
 
+#ifdef __aarch64__
+#define PR_SET_SHADOW_STACK_STATUS      72
+# define PR_SHADOW_STACK_ENABLE         (1UL << 0)
+
+#define my_syscall2(num, arg1, arg2)                                          \
+({                                                                            \
+	register long _num  __asm__ ("x8") = (num);                           \
+	register long _arg1 __asm__ ("x0") = (long)(arg1);                    \
+	register long _arg2 __asm__ ("x1") = (long)(arg2);                    \
+	register long _arg3 __asm__ ("x2") = 0;                               \
+	register long _arg4 __asm__ ("x3") = 0;                               \
+	register long _arg5 __asm__ ("x4") = 0;                               \
+	                                                                      \
+	__asm__  volatile (                                                   \
+		"svc #0\n"                                                    \
+		: "=r"(_arg1)                                                 \
+		: "r"(_arg1), "r"(_arg2),                                     \
+		  "r"(_arg3), "r"(_arg4),                                     \
+		  "r"(_arg5), "r"(_num)					      \
+		: "memory", "cc"                                              \
+	);                                                                    \
+	_arg1;                                                                \
+})
+
+#define ENABLE_SHADOW_STACK
+static inline __attribute__((always_inline))  void enable_shadow_stack(void)
+{
+	int ret;
+
+	ret = my_syscall2(__NR_prctl, PR_SET_SHADOW_STACK_STATUS,
+			  PR_SHADOW_STACK_ENABLE);
+	if (ret == 0)
+		shadow_stack_enabled = true;
+}
+
+#endif
+
 #ifndef __NR_map_shadow_stack
 #define __NR_map_shadow_stack 453
 #endif

-- 
2.30.2


