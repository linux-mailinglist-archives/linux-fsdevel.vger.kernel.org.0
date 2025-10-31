Return-Path: <linux-fsdevel+bounces-66616-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A1BC2677F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 18:48:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 885F14FAC3E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 17:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 526F527FB37;
	Fri, 31 Oct 2025 17:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XtNJBG+z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51EB9302770
	for <linux-fsdevel@vger.kernel.org>; Fri, 31 Oct 2025 17:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761932560; cv=none; b=l+lyXNUyySLtHx9vYFtSUPsbUwVTAwJyiWMTBBPMJ3fdvSUjr+jUebw2PmO77O3U/Vzi+CB7P/YTuOY7exO/AbIuYTF3gOt9odFZwDHCx7KsYaVcBwwrFcd1X+DnK15VfrDdLpY9bCqY9RArbwjMe5ph+ORlNhJcgXubJU5aTTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761932560; c=relaxed/simple;
	bh=eCYShfRX0rHI6sx8cr4A4kN5N77l6dX/sdpeOCW1NVU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OD9NFj7tOal1y8rLrFNHc6o7F0Ps9O7jtCe0U1+yB6/8uHLsRqBEKq9y9Zfu2U+P/cvGNbgu38MWJbB0dgF4W9/V+t50H+jqFsh6kgGmsDQvgkMEfBVQ1D8PS3Z/J7L2Bo3/c8C7bKux8ShFTsaEfCVvu4bqRqoO0Pt867QKlS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XtNJBG+z; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-47112a73785so18371205e9.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Oct 2025 10:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761932556; x=1762537356; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/JFfpBNltudBh1dcawvKJ9buR3KdRpsYCaA9EH+988I=;
        b=XtNJBG+zq/eb8mLDXbsh48azjhXUeHWDCxawc+rT/MWGnG7ZWPX+/Rwria25WJECTS
         DjMtXWk1KyyPxvONvxc7NP1eoG5QbN4BvqzJm6hQj5nq2UER3CyajMdZF1DqyRt91mY8
         YfWB/KacRhL8c0RYJmRYm+O40bL/anjDGaPwQZ8DYUSjzpj9BrB/1f7u24Jj0BNkolnv
         OshqoODm/SEpzBoRqYpcu8gkFJYt6IyVSpijdJ7IW1KFZZpG7jyNSCUBCW4LEQgOAcna
         FjVa8Vc4vRHSDqlqCo9IhuQ6Bp4DFj7PrClXeFsb3ZNB72elh7hReScbH+JQ2dbIV0CR
         iusg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761932556; x=1762537356;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/JFfpBNltudBh1dcawvKJ9buR3KdRpsYCaA9EH+988I=;
        b=jpfZdHsY9wOCk9k53KvIl7SuSr0jGuAzDeAVdECPM+g0us3zkDpA/aTT6+HaNEsaqL
         NlAg39HyG5Ad7KMNoYqLym7qV2GYUCWEswuO428pvj/39cfXPlZHkQX9rmBm1M3iWk02
         XOBsK8WCJ5bSzupQnNZbXtKsMpCWhKpuJkHCKMX8BtoPKOvjegnMZrddtBrjtM+3CIFc
         qR31a8AFeDPsuPm1Zd/AIlrL+cebhIcRhF69s2Hipod6pWA6t7wSkoHiwFabpqaNKilZ
         mopXgS4VpHn947DVoBkVh/Hznzg1UL/NRG9V0NQ21Y9niTC+UtI/9253VbdqXHgL6USJ
         euLQ==
X-Forwarded-Encrypted: i=1; AJvYcCXEHxjKTxdkjHCmbQaELmh1qmvfgnxYHKGyh+HqiEe3PTZB3zGVu2BcPKKRLttQRICuUUXM4FXIYnLlFaFZ@vger.kernel.org
X-Gm-Message-State: AOJu0YzznitlJAJrzTSetM17UojQ5kA9Ewn0WJohc6HIj0ZRMguwAmmq
	tN+RqXejxyLQ3Cpxrvy9SRzkFm62ZxOXhxt1z8XtaAGhcZEThkbCbNhK
X-Gm-Gg: ASbGncuFU7jURe/Fmp76a7RPNOMfZFXM138BN1UMQ09so3bBKIIoQBhq0k8aDHb9ZpV
	h6FtB+H6Z/7LOUTYqjNTpriNtNT3R3TkElZZFazZZMiu86v8doKlz8dSnbdFwpYTz6Vlzc+RRRw
	SIhVnoaJHX2sremnafc3NUlBiTQUD7i62XndZ6qusS58DqjED6e7cLT1NwN1AK2vkzJR3zrtCUB
	qK6/JP36mk9osL3m0sTs+ggMwkNyPc3OGykITUSPAiF89jEgJ23EpN3UGZmX5brMwdW54TGuOfZ
	TDd/VxfP2eR7j7yku+56KKlzGJpb4RxC68ALGpk8z8X77CqJC/rytz1ioiJzMa+lZTkFHfxCUaO
	Qqte2VTmPhueIGhivwO/xNTGvxrezMCSCsQCoBwZFieM2KjP6Jq/IumwSFHi6FAtVlpGnGTaG3+
	Z0/Fzn/jC0jHLjMnpONi1j2oNZYsQ13jhsT5SRG2/DGUgq1SEFXr8640kKU5A=
X-Google-Smtp-Source: AGHT+IFbNYPa3KcCa7VpnDiT2uVnaGmXVOevywcNwvqIGQkDf6aVOLWVM/y4XkNRP6N+RMNcb2Nb7g==
X-Received: by 2002:a05:600d:6359:b0:475:de14:db1e with SMTP id 5b1f17b1804b1-477346ec27emr19014905e9.24.1761932556254;
        Fri, 31 Oct 2025 10:42:36 -0700 (PDT)
Received: from f.. (cst-prg-14-82.cust.vodafone.cz. [46.135.14.82])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4773c53eafbsm6728865e9.12.2025.10.31.10.42.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 10:42:35 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: torvalds@linux-foundation.org
Cc: brauner@kernel.org,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	tglx@linutronix.de,
	pfalcato@suse.de,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH 2/3] runtime-const: split headers between accessors and fixup; disable for modules
Date: Fri, 31 Oct 2025 18:42:19 +0100
Message-ID: <20251031174220.43458-3-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251031174220.43458-1-mjguzik@gmail.com>
References: <CAHk-=wjRA8G9eOPWa_Njz4NAk3gZNvdt0WAHZfn3iXfcVsmpcA@mail.gmail.com>
 <20251031174220.43458-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

risv and x86 covered as a POC
---
 .../include/asm/runtime-const-accessors.h     | 151 ++++++++++++++++++
 arch/riscv/include/asm/runtime-const.h        | 142 +---------------
 .../x86/include/asm/runtime-const-accessors.h |  45 ++++++
 arch/x86/include/asm/runtime-const.h          |  38 +----
 4 files changed, 200 insertions(+), 176 deletions(-)
 create mode 100644 arch/riscv/include/asm/runtime-const-accessors.h
 create mode 100644 arch/x86/include/asm/runtime-const-accessors.h

diff --git a/arch/riscv/include/asm/runtime-const-accessors.h b/arch/riscv/include/asm/runtime-const-accessors.h
new file mode 100644
index 000000000000..5b8e0349ee0d
--- /dev/null
+++ b/arch/riscv/include/asm/runtime-const-accessors.h
@@ -0,0 +1,151 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_RISCV_RUNTIME_CONST_ACCESSORS_H
+#define _ASM_RISCV_RUNTIME_CONST_ACCESSORS_H
+
+#ifdef MODULE
+#error "this functionality is not available for modules"
+#endif
+
+#ifdef CONFIG_32BIT
+#define runtime_const_ptr(sym)					\
+({								\
+	typeof(sym) __ret;					\
+	asm_inline(".option push\n\t"				\
+		".option norvc\n\t"				\
+		"1:\t"						\
+		"lui	%[__ret],0x89abd\n\t"			\
+		"addi	%[__ret],%[__ret],-0x211\n\t"		\
+		".option pop\n\t"				\
+		".pushsection runtime_ptr_" #sym ",\"a\"\n\t"	\
+		".long 1b - .\n\t"				\
+		".popsection"					\
+		: [__ret] "=r" (__ret));			\
+	__ret;							\
+})
+#else
+/*
+ * Loading 64-bit constants into a register from immediates is a non-trivial
+ * task on riscv64. To get it somewhat performant, load 32 bits into two
+ * different registers and then combine the results.
+ *
+ * If the processor supports the Zbkb extension, we can combine the final
+ * "slli,slli,srli,add" into the single "pack" instruction. If the processor
+ * doesn't support Zbkb but does support the Zbb extension, we can
+ * combine the final "slli,srli,add" into one instruction "add.uw".
+ */
+#define RISCV_RUNTIME_CONST_64_PREAMBLE				\
+	".option push\n\t"					\
+	".option norvc\n\t"					\
+	"1:\t"							\
+	"lui	%[__ret],0x89abd\n\t"				\
+	"lui	%[__tmp],0x1234\n\t"				\
+	"addiw	%[__ret],%[__ret],-0x211\n\t"			\
+	"addiw	%[__tmp],%[__tmp],0x567\n\t"			\
+
+#define RISCV_RUNTIME_CONST_64_BASE				\
+	"slli	%[__tmp],%[__tmp],32\n\t"			\
+	"slli	%[__ret],%[__ret],32\n\t"			\
+	"srli	%[__ret],%[__ret],32\n\t"			\
+	"add	%[__ret],%[__ret],%[__tmp]\n\t"			\
+
+#define RISCV_RUNTIME_CONST_64_ZBA				\
+	".option push\n\t"					\
+	".option arch,+zba\n\t"					\
+	".option norvc\n\t"					\
+	"slli	%[__tmp],%[__tmp],32\n\t"			\
+	"add.uw %[__ret],%[__ret],%[__tmp]\n\t"			\
+	"nop\n\t"						\
+	"nop\n\t"						\
+	".option pop\n\t"					\
+
+#define RISCV_RUNTIME_CONST_64_ZBKB				\
+	".option push\n\t"					\
+	".option arch,+zbkb\n\t"				\
+	".option norvc\n\t"					\
+	"pack	%[__ret],%[__ret],%[__tmp]\n\t"			\
+	"nop\n\t"						\
+	"nop\n\t"						\
+	"nop\n\t"						\
+	".option pop\n\t"					\
+
+#define RISCV_RUNTIME_CONST_64_POSTAMBLE(sym)			\
+	".option pop\n\t"					\
+	".pushsection runtime_ptr_" #sym ",\"a\"\n\t"		\
+	".long 1b - .\n\t"					\
+	".popsection"						\
+
+#if defined(CONFIG_RISCV_ISA_ZBA) && defined(CONFIG_TOOLCHAIN_HAS_ZBA)	\
+	&& defined(CONFIG_RISCV_ISA_ZBKB)
+#define runtime_const_ptr(sym)						\
+({									\
+	typeof(sym) __ret, __tmp;					\
+	asm_inline(RISCV_RUNTIME_CONST_64_PREAMBLE			\
+		ALTERNATIVE_2(						\
+			RISCV_RUNTIME_CONST_64_BASE,			\
+			RISCV_RUNTIME_CONST_64_ZBA,			\
+			0, RISCV_ISA_EXT_ZBA, 1,			\
+			RISCV_RUNTIME_CONST_64_ZBKB,			\
+			0, RISCV_ISA_EXT_ZBKB, 1			\
+		)							\
+		RISCV_RUNTIME_CONST_64_POSTAMBLE(sym)			\
+		: [__ret] "=r" (__ret), [__tmp] "=r" (__tmp));		\
+	__ret;								\
+})
+#elif defined(CONFIG_RISCV_ISA_ZBA) && defined(CONFIG_TOOLCHAIN_HAS_ZBA)
+#define runtime_const_ptr(sym)						\
+({									\
+	typeof(sym) __ret, __tmp;					\
+	asm_inline(RISCV_RUNTIME_CONST_64_PREAMBLE			\
+		ALTERNATIVE(						\
+			RISCV_RUNTIME_CONST_64_BASE,			\
+			RISCV_RUNTIME_CONST_64_ZBA,			\
+			0, RISCV_ISA_EXT_ZBA, 1				\
+		)							\
+		RISCV_RUNTIME_CONST_64_POSTAMBLE(sym)			\
+		: [__ret] "=r" (__ret), [__tmp] "=r" (__tmp));		\
+	__ret;								\
+})
+#elif defined(CONFIG_RISCV_ISA_ZBKB)
+#define runtime_const_ptr(sym)						\
+({									\
+	typeof(sym) __ret, __tmp;					\
+	asm_inline(RISCV_RUNTIME_CONST_64_PREAMBLE			\
+		ALTERNATIVE(						\
+			RISCV_RUNTIME_CONST_64_BASE,			\
+			RISCV_RUNTIME_CONST_64_ZBKB,			\
+			0, RISCV_ISA_EXT_ZBKB, 1			\
+		)							\
+		RISCV_RUNTIME_CONST_64_POSTAMBLE(sym)			\
+		: [__ret] "=r" (__ret), [__tmp] "=r" (__tmp));		\
+	__ret;								\
+})
+#else
+#define runtime_const_ptr(sym)						\
+({									\
+	typeof(sym) __ret, __tmp;					\
+	asm_inline(RISCV_RUNTIME_CONST_64_PREAMBLE			\
+		RISCV_RUNTIME_CONST_64_BASE				\
+		RISCV_RUNTIME_CONST_64_POSTAMBLE(sym)			\
+		: [__ret] "=r" (__ret), [__tmp] "=r" (__tmp));		\
+	__ret;								\
+})
+#endif
+#endif
+
+#define runtime_const_shift_right_32(val, sym)			\
+({								\
+	u32 __ret;						\
+	asm_inline(".option push\n\t"				\
+		".option norvc\n\t"				\
+		"1:\t"						\
+		SRLI " %[__ret],%[__val],12\n\t"		\
+		".option pop\n\t"				\
+		".pushsection runtime_shift_" #sym ",\"a\"\n\t"	\
+		".long 1b - .\n\t"				\
+		".popsection"					\
+		: [__ret] "=r" (__ret)				\
+		: [__val] "r" (val));				\
+	__ret;							\
+})
+
+#endif /* _ASM_RISCV_RUNTIME_CONST_ACCESSORS_H */
diff --git a/arch/riscv/include/asm/runtime-const.h b/arch/riscv/include/asm/runtime-const.h
index d766e2b9e6df..14994be81487 100644
--- a/arch/riscv/include/asm/runtime-const.h
+++ b/arch/riscv/include/asm/runtime-const.h
@@ -11,147 +11,7 @@
 
 #include <linux/uaccess.h>
 
-#ifdef CONFIG_32BIT
-#define runtime_const_ptr(sym)					\
-({								\
-	typeof(sym) __ret;					\
-	asm_inline(".option push\n\t"				\
-		".option norvc\n\t"				\
-		"1:\t"						\
-		"lui	%[__ret],0x89abd\n\t"			\
-		"addi	%[__ret],%[__ret],-0x211\n\t"		\
-		".option pop\n\t"				\
-		".pushsection runtime_ptr_" #sym ",\"a\"\n\t"	\
-		".long 1b - .\n\t"				\
-		".popsection"					\
-		: [__ret] "=r" (__ret));			\
-	__ret;							\
-})
-#else
-/*
- * Loading 64-bit constants into a register from immediates is a non-trivial
- * task on riscv64. To get it somewhat performant, load 32 bits into two
- * different registers and then combine the results.
- *
- * If the processor supports the Zbkb extension, we can combine the final
- * "slli,slli,srli,add" into the single "pack" instruction. If the processor
- * doesn't support Zbkb but does support the Zbb extension, we can
- * combine the final "slli,srli,add" into one instruction "add.uw".
- */
-#define RISCV_RUNTIME_CONST_64_PREAMBLE				\
-	".option push\n\t"					\
-	".option norvc\n\t"					\
-	"1:\t"							\
-	"lui	%[__ret],0x89abd\n\t"				\
-	"lui	%[__tmp],0x1234\n\t"				\
-	"addiw	%[__ret],%[__ret],-0x211\n\t"			\
-	"addiw	%[__tmp],%[__tmp],0x567\n\t"			\
-
-#define RISCV_RUNTIME_CONST_64_BASE				\
-	"slli	%[__tmp],%[__tmp],32\n\t"			\
-	"slli	%[__ret],%[__ret],32\n\t"			\
-	"srli	%[__ret],%[__ret],32\n\t"			\
-	"add	%[__ret],%[__ret],%[__tmp]\n\t"			\
-
-#define RISCV_RUNTIME_CONST_64_ZBA				\
-	".option push\n\t"					\
-	".option arch,+zba\n\t"					\
-	".option norvc\n\t"					\
-	"slli	%[__tmp],%[__tmp],32\n\t"			\
-	"add.uw %[__ret],%[__ret],%[__tmp]\n\t"			\
-	"nop\n\t"						\
-	"nop\n\t"						\
-	".option pop\n\t"					\
-
-#define RISCV_RUNTIME_CONST_64_ZBKB				\
-	".option push\n\t"					\
-	".option arch,+zbkb\n\t"				\
-	".option norvc\n\t"					\
-	"pack	%[__ret],%[__ret],%[__tmp]\n\t"			\
-	"nop\n\t"						\
-	"nop\n\t"						\
-	"nop\n\t"						\
-	".option pop\n\t"					\
-
-#define RISCV_RUNTIME_CONST_64_POSTAMBLE(sym)			\
-	".option pop\n\t"					\
-	".pushsection runtime_ptr_" #sym ",\"a\"\n\t"		\
-	".long 1b - .\n\t"					\
-	".popsection"						\
-
-#if defined(CONFIG_RISCV_ISA_ZBA) && defined(CONFIG_TOOLCHAIN_HAS_ZBA)	\
-	&& defined(CONFIG_RISCV_ISA_ZBKB)
-#define runtime_const_ptr(sym)						\
-({									\
-	typeof(sym) __ret, __tmp;					\
-	asm_inline(RISCV_RUNTIME_CONST_64_PREAMBLE			\
-		ALTERNATIVE_2(						\
-			RISCV_RUNTIME_CONST_64_BASE,			\
-			RISCV_RUNTIME_CONST_64_ZBA,			\
-			0, RISCV_ISA_EXT_ZBA, 1,			\
-			RISCV_RUNTIME_CONST_64_ZBKB,			\
-			0, RISCV_ISA_EXT_ZBKB, 1			\
-		)							\
-		RISCV_RUNTIME_CONST_64_POSTAMBLE(sym)			\
-		: [__ret] "=r" (__ret), [__tmp] "=r" (__tmp));		\
-	__ret;								\
-})
-#elif defined(CONFIG_RISCV_ISA_ZBA) && defined(CONFIG_TOOLCHAIN_HAS_ZBA)
-#define runtime_const_ptr(sym)						\
-({									\
-	typeof(sym) __ret, __tmp;					\
-	asm_inline(RISCV_RUNTIME_CONST_64_PREAMBLE			\
-		ALTERNATIVE(						\
-			RISCV_RUNTIME_CONST_64_BASE,			\
-			RISCV_RUNTIME_CONST_64_ZBA,			\
-			0, RISCV_ISA_EXT_ZBA, 1				\
-		)							\
-		RISCV_RUNTIME_CONST_64_POSTAMBLE(sym)			\
-		: [__ret] "=r" (__ret), [__tmp] "=r" (__tmp));		\
-	__ret;								\
-})
-#elif defined(CONFIG_RISCV_ISA_ZBKB)
-#define runtime_const_ptr(sym)						\
-({									\
-	typeof(sym) __ret, __tmp;					\
-	asm_inline(RISCV_RUNTIME_CONST_64_PREAMBLE			\
-		ALTERNATIVE(						\
-			RISCV_RUNTIME_CONST_64_BASE,			\
-			RISCV_RUNTIME_CONST_64_ZBKB,			\
-			0, RISCV_ISA_EXT_ZBKB, 1			\
-		)							\
-		RISCV_RUNTIME_CONST_64_POSTAMBLE(sym)			\
-		: [__ret] "=r" (__ret), [__tmp] "=r" (__tmp));		\
-	__ret;								\
-})
-#else
-#define runtime_const_ptr(sym)						\
-({									\
-	typeof(sym) __ret, __tmp;					\
-	asm_inline(RISCV_RUNTIME_CONST_64_PREAMBLE			\
-		RISCV_RUNTIME_CONST_64_BASE				\
-		RISCV_RUNTIME_CONST_64_POSTAMBLE(sym)			\
-		: [__ret] "=r" (__ret), [__tmp] "=r" (__tmp));		\
-	__ret;								\
-})
-#endif
-#endif
-
-#define runtime_const_shift_right_32(val, sym)			\
-({								\
-	u32 __ret;						\
-	asm_inline(".option push\n\t"				\
-		".option norvc\n\t"				\
-		"1:\t"						\
-		SRLI " %[__ret],%[__val],12\n\t"		\
-		".option pop\n\t"				\
-		".pushsection runtime_shift_" #sym ",\"a\"\n\t"	\
-		".long 1b - .\n\t"				\
-		".popsection"					\
-		: [__ret] "=r" (__ret)				\
-		: [__val] "r" (val));				\
-	__ret;							\
-})
+#include <asm/runtime-const-accessors.h>
 
 #define runtime_const_init(type, sym) do {			\
 	extern s32 __start_runtime_##type##_##sym[];		\
diff --git a/arch/x86/include/asm/runtime-const-accessors.h b/arch/x86/include/asm/runtime-const-accessors.h
new file mode 100644
index 000000000000..4c411bc3cb32
--- /dev/null
+++ b/arch/x86/include/asm/runtime-const-accessors.h
@@ -0,0 +1,45 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_RUNTIME_CONST_ACCESSORS_H
+#define _ASM_RUNTIME_CONST_ACCESSORS_H
+
+#ifdef MODULE
+#error "this functionality is not available for modules"
+#endif
+
+#ifdef __ASSEMBLY__
+
+.macro RUNTIME_CONST_PTR sym reg
+	movq	$0x0123456789abcdef, %\reg
+	1:
+	.pushsection runtime_ptr_\sym, "a"
+	.long	1b - 8 - .
+	.popsection
+.endm
+
+#else /* __ASSEMBLY__ */
+
+#define runtime_const_ptr(sym) ({				\
+	typeof(sym) __ret;					\
+	asm_inline("mov %1,%0\n1:\n"				\
+		".pushsection runtime_ptr_" #sym ",\"a\"\n\t"	\
+		".long 1b - %c2 - .\n"				\
+		".popsection"					\
+		:"=r" (__ret)					\
+		:"i" ((unsigned long)0x0123456789abcdefull),	\
+		 "i" (sizeof(long)));				\
+	__ret; })
+
+// The 'typeof' will create at _least_ a 32-bit type, but
+// will happily also take a bigger type and the 'shrl' will
+// clear the upper bits
+#define runtime_const_shift_right_32(val, sym) ({		\
+	typeof(0u+(val)) __ret = (val);				\
+	asm_inline("shrl $12,%k0\n1:\n"				\
+		".pushsection runtime_shift_" #sym ",\"a\"\n\t"	\
+		".long 1b - 1 - .\n"				\
+		".popsection"					\
+		:"+r" (__ret));					\
+	__ret; })
+
+#endif /* __ASSEMBLY__ */
+#endif
diff --git a/arch/x86/include/asm/runtime-const.h b/arch/x86/include/asm/runtime-const.h
index 8d983cfd06ea..15d67e2bfc96 100644
--- a/arch/x86/include/asm/runtime-const.h
+++ b/arch/x86/include/asm/runtime-const.h
@@ -2,41 +2,9 @@
 #ifndef _ASM_RUNTIME_CONST_H
 #define _ASM_RUNTIME_CONST_H
 
-#ifdef __ASSEMBLY__
-
-.macro RUNTIME_CONST_PTR sym reg
-	movq	$0x0123456789abcdef, %\reg
-	1:
-	.pushsection runtime_ptr_\sym, "a"
-	.long	1b - 8 - .
-	.popsection
-.endm
-
-#else /* __ASSEMBLY__ */
-
-#define runtime_const_ptr(sym) ({				\
-	typeof(sym) __ret;					\
-	asm_inline("mov %1,%0\n1:\n"				\
-		".pushsection runtime_ptr_" #sym ",\"a\"\n\t"	\
-		".long 1b - %c2 - .\n"				\
-		".popsection"					\
-		:"=r" (__ret)					\
-		:"i" ((unsigned long)0x0123456789abcdefull),	\
-		 "i" (sizeof(long)));				\
-	__ret; })
-
-// The 'typeof' will create at _least_ a 32-bit type, but
-// will happily also take a bigger type and the 'shrl' will
-// clear the upper bits
-#define runtime_const_shift_right_32(val, sym) ({		\
-	typeof(0u+(val)) __ret = (val);				\
-	asm_inline("shrl $12,%k0\n1:\n"				\
-		".pushsection runtime_shift_" #sym ",\"a\"\n\t"	\
-		".long 1b - 1 - .\n"				\
-		".popsection"					\
-		:"+r" (__ret));					\
-	__ret; })
+#include <asm/runtime-const-accessors.h>
 
+#ifndef __ASSEMBLY__
 #define runtime_const_init(type, sym) do {		\
 	extern s32 __start_runtime_##type##_##sym[];	\
 	extern s32 __stop_runtime_##type##_##sym[];	\
@@ -70,5 +38,5 @@ static inline void runtime_const_fixup(void (*fn)(void *, unsigned long),
 	}
 }
 
-#endif /* __ASSEMBLY__ */
+#endif /* !__ASSEMBLY__ */
 #endif
-- 
2.34.1


