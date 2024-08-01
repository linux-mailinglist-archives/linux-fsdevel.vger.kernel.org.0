Return-Path: <linux-fsdevel+bounces-24777-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7CB1944C74
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 15:07:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 057251C26556
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 13:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4D7A1A0AF2;
	Thu,  1 Aug 2024 13:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LLg1OHA3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BBC61A38D6;
	Thu,  1 Aug 2024 13:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722517237; cv=none; b=aCdy9mwlWr/aByHY0ujYJiAoWhzYwLLlbLX5uj3TJuGpjnPV5Kr+azwgGaWXskRMpv0AXoQAH8rNO2g1iEItDwdBQ4UnDhmbiUphiE3acTdpoxdGLqs0D2iDurmbc3xgVGv1SpWBPWxWIbtYaBBvle1zIPoeDZQ2EMcocppWuno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722517237; c=relaxed/simple;
	bh=18sWPiMz/2PRxXCIvtfcK7spgh5pr5ZrfaiB3z+47E4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pFHwUXUDD+aHS52+QDXvYDR5ES0LW2nSUPT6ku3i9AD1q5F/eIWVnMbck7NdQT55UqM5n7It6k2H/GKu3sQYlSQbVOOChTMGsvNFJuyOKfwacjePAs/6FPgwwnKT/4BXalIiIXy7lPxKUum2+VIAMnRQEkEN660e05Eb03kwKOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LLg1OHA3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56ABDC4AF09;
	Thu,  1 Aug 2024 13:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722517236;
	bh=18sWPiMz/2PRxXCIvtfcK7spgh5pr5ZrfaiB3z+47E4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=LLg1OHA31BGAOp+FcPmnJJOjzfR45mz7vsAtPMUFCrp3V7jiNukUbotugAHXE9tfV
	 aIcA8L9FYxshLmS4g00Xcx4OAeSAXMA7Cx6hpLIH3QZnSQCt8YXedBHO8JI/yttRb9
	 JpkHjxdKoSHdhI9vBqBIdnPygpaZJ95EUystul9JiKsQD6DkVqldmjSesjTbLv0sqm
	 NikT1hoabasrT4HukGBspGC81nPLvOcQeycfSnyUlng10ZobRMGQEKzhITf55ljibS
	 VtYKfgXcpzqVAaAmo+gfDKDoKfc1vsoY8HVPiXk+19EWEoJEiduwxjrgaCrru96J69
	 z1MECEs5pWqoQ==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 01 Aug 2024 13:06:55 +0100
Subject: [PATCH v10 28/40] kselftest: Provide shadow stack enable helpers
 for arm64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240801-arm64-gcs-v10-28-699e2bd2190b@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2438; i=broonie@kernel.org;
 h=from:subject:message-id; bh=18sWPiMz/2PRxXCIvtfcK7spgh5pr5ZrfaiB3z+47E4=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBmq4YbFMDh5Ckm74QVwECa6WtHKMFE+UgmODNhyXqy
 jR+iB0mJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZquGGwAKCRAk1otyXVSH0P71B/
 9V7hV3CQrkTFd7jDYY3vyp6DGdl60ANtDN9HiUq6OdnYyjo74919F2XR8dM7OFco4J0gWHLqcHOJMQ
 mCqdEM4vB9PQSvpXx2GH03cxvxIqdqfE55+qgXzqgNbizwwLZUpwdgD5RHVNHSFRB9W/bjx+JZXJqE
 PKyTwIymZZopYRk+Y7ejaWLDSbbzDu0NF6S8j6E5VbD9oU0rsQLaLyqdWH6OjAzZA3A/kzW6XVepic
 IbfLQ4Lre1T22ts5jLylYp9CPZR3M4w4IURa3eyhuBgX98WzddCT/kBy8n9tPazpRw0cDNsaEqUins
 yEg+6uGOgaqj7quxk0iWHDXsMAOH09
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Allow test programs to use the shadow stack helpers on arm64.

Reviewed-by: Thiago Jung Bauermann <thiago.bauermann@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/ksft_shstk.h | 37 ++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/tools/testing/selftests/ksft_shstk.h b/tools/testing/selftests/ksft_shstk.h
index 85d0747c1802..302957a0bbd5 100644
--- a/tools/testing/selftests/ksft_shstk.h
+++ b/tools/testing/selftests/ksft_shstk.h
@@ -50,6 +50,43 @@ static inline __attribute__((always_inline)) void enable_shadow_stack(void)
 
 #endif
 
+#ifdef __aarch64__
+#define PR_SET_SHADOW_STACK_STATUS      75
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
2.39.2


