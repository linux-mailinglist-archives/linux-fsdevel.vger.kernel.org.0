Return-Path: <linux-fsdevel+bounces-22399-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9CDD916C3D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 17:12:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 848A9280F4C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 15:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D46217967C;
	Tue, 25 Jun 2024 15:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L/22fLgn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2CB2178390;
	Tue, 25 Jun 2024 15:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719327842; cv=none; b=gegJcmHyV/oqPCT2LxOgUPX4ECU0M060mJnreFUEVmlLBlZJQH5bbfGorZovAhMCI43HvGXYsvT5cKyJCv/+fFVuikdh5E6Uqs6baRn4T3Bl1AwhX/Ywss9XTiomjm6HXqgBiYer8NfnF6lifZ9dRFQ0uxiOJ9nwUOXPkxlLcXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719327842; c=relaxed/simple;
	bh=18sWPiMz/2PRxXCIvtfcK7spgh5pr5ZrfaiB3z+47E4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=czpcJxUjr8gogMoc5fIFktDUHfc254OQon4fcbt+nL4yLpknhuh3uJcRZHfa3zevq5UUM0iWfzRu84Q2Kxn4yYeoJs6L9aOFPZk97d2XxlxGygJbu5gunnHB/JRJs/BLIYGfcWPKShSWwQsiMlIuNnN0EKucUiXDpn+hWFz8WRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L/22fLgn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 952C8C32786;
	Tue, 25 Jun 2024 15:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719327841;
	bh=18sWPiMz/2PRxXCIvtfcK7spgh5pr5ZrfaiB3z+47E4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=L/22fLgnVrCDuOa9AvI6QdbD1mU2fPLWMyOny0LJICnsPQ+OE/mai2HAC7OkLXWrJ
	 pcjmdvOHUArp132IpQ/J7Z21Sv/jOjoC6HDAqdUKWzSDHPvfBs0pcnv8FRQWxrb3Sr
	 FraOwe39xbpr7uXa7BJ61D/F5eof33J8kY9ZTgInPA47/sgIlBPg/f8C2pZayWI2YR
	 nrWC+5A2Hs6TAQQZSCany+TRS3b/filwuFp/OmO63FLC5Pow0ctynPP+i3tlzxgMWn
	 ycNQHDCO02rxEI6Wbb971VZMdfryYPFOk1DSQOosLTixKz+ahicdLElvrOaKYhN9HJ
	 TYvGOxzLrD3vA==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 25 Jun 2024 15:57:56 +0100
Subject: [PATCH v9 28/39] kselftest: Provide shadow stack enable helpers
 for arm64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240625-arm64-gcs-v9-28-0f634469b8f0@kernel.org>
References: <20240625-arm64-gcs-v9-0-0f634469b8f0@kernel.org>
In-Reply-To: <20240625-arm64-gcs-v9-0-0f634469b8f0@kernel.org>
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
X-Mailer: b4 0.14-dev-d4707
X-Developer-Signature: v=1; a=openpgp-sha256; l=2438; i=broonie@kernel.org;
 h=from:subject:message-id; bh=18sWPiMz/2PRxXCIvtfcK7spgh5pr5ZrfaiB3z+47E4=;
 b=owGbwMvMwMWocq27KDak/QLjabUkhrSq2x0KqV3vs2a/V1Pb7Be8+t4u7WmabwqCORe9/xTgHr+8
 zNa2k9GYhYGRi0FWTJFl7bOMVenhElvnP5r/CmYQKxPIFAYuTgGYiHcj+292TZ+CQLdbi9mYW8zEN2
 X1LjihftFL8fvMrGl2EZzskwXMdeZ+eBMrWuqa2borvMb24hZlk386KTFbd8ltvyeVsXVOUuDr1asv
 5ZQFu/QfNL7cmbnl1obSPh5WI7muxXX+i5PSXV4x/kwPf7jnbGuQWhhDb1TwV5+nwho3/2t21fw80T
 +/J3pniDibQTHbr237989ZsoBNX6Ly+1zl60weQQfadrmbdbHmndF47pjSx75Xe2qA22mzq809x4pu
 SvLH7TaZ1mPz6YWxRt70D7HrehQD3Njlrr2cmpYzdT2bxNJMr5m6ejY8x25oC3rm7/86pfBzBmdA0f
 namwlBHDZhJpa9tqHSxU6cK8oB
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


