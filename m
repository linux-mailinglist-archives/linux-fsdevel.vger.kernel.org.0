Return-Path: <linux-fsdevel+bounces-49713-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87953AC1BF5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 May 2025 07:32:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E3C31B6228B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 May 2025 05:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9926254B1F;
	Fri, 23 May 2025 05:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="qgJ/BGuz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587462472AF
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 May 2025 05:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747978285; cv=none; b=hlv45Ql9aqwc1FBuTDK3Gahz6xxqRh1+2A3XLV6/9KLCQZGh/RbvlLOaXh4KY97UjrRj1AE6tZLUMZUUGtmHzbTO9ujvrRgUzI8VcXG+ekLx2hrFWsytUhKAiVFUYuJGS8QiktCIm9KwN4w/z4681FZONwujLzRcBh+B4N1XGuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747978285; c=relaxed/simple;
	bh=9PDO8z/tbOe1lGT80gKwSIkcb5+Kq37kj7Zs5n5s9wE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aSgPwVueblcSbUrjFEJtmzMJf5c/FLOsRBQ+jthahPwp7QhYYsdm+RQJ35hgIdseQs2OpYi2G6l0S2E9WF9lrZ7IQcDZa4gjT0OBL7nEpX1xi6Gf1BJuS8IHxrfZ/5rEPF7yY2tS7WFEUrdFs6So4sYs2YGfNG6eTG6/eFzg+q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=qgJ/BGuz; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-742c7a52e97so4902965b3a.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 May 2025 22:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1747978283; x=1748583083; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2ZZoGehI751WEnlyiA7Yu8/Xg1oNedSIkF4OaPbny4E=;
        b=qgJ/BGuzf8FPC9bB7uw5q7VTgcg7PkdtJsbN9V1StNNz8JvKh1THmxQ8kGRQQmP13W
         soj4AfElIhwMQVXFT9LtibsErWnFBAcziiMnmvCeNYDKde0D7Kjr5HvX1KQPtxK4FngG
         jMqPWZMyoeqxY8v3k8/amgLDYbVMi3/5gOsxfpP/bFde3sdFQ1XlIKK0KjkJTa/oOTUz
         8JVLEt7q/GW0+xNJTbZZXk0R8IY+qS6/uR7a6EEdKUGovbn5IKceMmZMo46/Jf8+ucvI
         k79zqe3w6EweHptIwa8rOAU4Aj2wVHgZ9v9tfqDZVp3n4IZPeH57JSBqYIognUcJQRE+
         N0tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747978283; x=1748583083;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2ZZoGehI751WEnlyiA7Yu8/Xg1oNedSIkF4OaPbny4E=;
        b=rybdpbCBwWU2sjXnWmHuwqxe7WNIs2hTNRv8CD2CikVftcSmAw9MJ7j3z4g3aN1UVy
         1dBZC4QBge257paMAfdILNsDPxgK7UV2ThXnpiN3FVk6mvtX0rRpodaUcvT+MAcKsvIX
         EtqbHinbVTW9NdYSfFRFQXG2FP3tipZ/sVNktVOyyrcrsD2ncRoX7pQqf3zBgG1F7Tjk
         e88aQjyXGR9DqYqPsdDmxw5l+91l+Ol3R6AC8w1zsnNGn3al4K7Lyf2yWFdU1I0HjkBN
         NYZ0DNpGFPzJkCcQtlSY9+GGSKF6h/GAQkWMyJ6gX3OcPO5xb6n6b0oee/Vwu2rr3xjk
         8rYw==
X-Forwarded-Encrypted: i=1; AJvYcCUjqkTqTiL92k4z3xJ4alR76qj5ZCcYFFuBVGVmnOkN3Bb2W6gvdcBn1lA1gx2/EGmIbgeIBksP5U8g3QJc@vger.kernel.org
X-Gm-Message-State: AOJu0YzYrH+fEWtpeKoHw/N94wvf1jpc/NyHXNgL3hajoQHuuxMinKIA
	fcOBcYHCfg7/675lHnDav3U+IWE0PYgKd6BZOm42v4Zx19YzF+Uk5R02VQchJNzGEDw=
X-Gm-Gg: ASbGncvjwBqj2i+8GgFAUQMhlyS7zOTxfvwNmj9czmTrdtbbnAgb1LWGSlRN8yDBvB2
	2hLyLVkJ5jL1D1fhKSnkOwuY69MwIZEbcgvcezvfkvAsqH/owTg1vAxf0gt17nDyTjq7MAyscA8
	zbnfID+Drj11GCwIFLKFXoRRWHKCn6rZ09wllwtPHP95xQEstK1/2a64aKEYpUyhWkmvkD5wDZr
	kst2wdJ+Cs/wmnQzxroNX2FOgntLw4HxVLNCai3+HZNm2elhm7qm3+LE8nqFE6xxxco07j7WvWC
	WUPW6+MutyR8QocA2TON6VCpDwv6M1whMrE3f7g2NXGa6rroqRz0oFWAJ9C91kh0POfopgC9
X-Google-Smtp-Source: AGHT+IGd2D2FcDb/KwfbMJPCpLhAMjanV40kfX/RpFqLkWrkOR6PoOiVbMKoftU4GjTcvHCjealQ7A==
X-Received: by 2002:a05:6a00:399e:b0:736:50d1:fc84 with SMTP id d2e1a72fcca58-742acd726demr38699475b3a.21.1747978282621;
        Thu, 22 May 2025 22:31:22 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a982a0a4sm12474336b3a.101.2025.05.22.22.31.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 22:31:22 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Thu, 22 May 2025 22:31:06 -0700
Subject: [PATCH v16 03/27] riscv: zicfiss / zicfilp enumeration
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250522-v5_user_cfi_series-v16-3-64f61a35eee7@rivosinc.com>
References: <20250522-v5_user_cfi_series-v16-0-64f61a35eee7@rivosinc.com>
In-Reply-To: <20250522-v5_user_cfi_series-v16-0-64f61a35eee7@rivosinc.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Vlastimil Babka <vbabka@suse.cz>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Christian Brauner <brauner@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Oleg Nesterov <oleg@redhat.com>, 
 Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, 
 Jann Horn <jannh@google.com>, Conor Dooley <conor+dt@kernel.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-mm@kvack.org, linux-riscv@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 alistair.francis@wdc.com, richard.henderson@linaro.org, jim.shu@sifive.com, 
 andybnac@gmail.com, kito.cheng@sifive.com, charlie@rivosinc.com, 
 atishp@rivosinc.com, evan@rivosinc.com, cleger@rivosinc.com, 
 alexghiti@rivosinc.com, samitolvanen@google.com, broonie@kernel.org, 
 rick.p.edgecombe@intel.com, rust-for-linux@vger.kernel.org, 
 Zong Li <zong.li@sifive.com>, Deepak Gupta <debug@rivosinc.com>
X-Mailer: b4 0.13.0

This patch adds support for detecting zicfiss and zicfilp. zicfiss and
zicfilp stands for unprivleged integer spec extension for shadow stack
and branch tracking on indirect branches, respectively.

This patch looks for zicfiss and zicfilp in device tree and accordinlgy
lights up bit in cpu feature bitmap. Furthermore this patch adds detection
utility functions to return whether shadow stack or landing pads are
supported by cpu.

Reviewed-by: Zong Li <zong.li@sifive.com>
Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 arch/riscv/include/asm/cpufeature.h | 12 ++++++++++++
 arch/riscv/include/asm/hwcap.h      |  2 ++
 arch/riscv/include/asm/processor.h  |  1 +
 arch/riscv/kernel/cpufeature.c      | 22 ++++++++++++++++++++++
 4 files changed, 37 insertions(+)

diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm/cpufeature.h
index 3a87f612035c..100f4b53ba5d 100644
--- a/arch/riscv/include/asm/cpufeature.h
+++ b/arch/riscv/include/asm/cpufeature.h
@@ -146,4 +146,16 @@ static __always_inline bool riscv_cpu_has_extension_unlikely(int cpu, const unsi
 	return __riscv_isa_extension_available(hart_isa[cpu].isa, ext);
 }
 
+static inline bool cpu_supports_shadow_stack(void)
+{
+	return (IS_ENABLED(CONFIG_RISCV_USER_CFI) &&
+		riscv_has_extension_unlikely(RISCV_ISA_EXT_ZICFISS));
+}
+
+static inline bool cpu_supports_indirect_br_lp_instr(void)
+{
+	return (IS_ENABLED(CONFIG_RISCV_USER_CFI) &&
+		riscv_has_extension_unlikely(RISCV_ISA_EXT_ZICFILP));
+}
+
 #endif
diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
index e3cbf203cdde..abc33ca1302e 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -105,6 +105,8 @@
 #define RISCV_ISA_EXT_ZVFBFWMA		96
 #define RISCV_ISA_EXT_ZAAMO		97
 #define RISCV_ISA_EXT_ZALRSC		98
+#define RISCV_ISA_EXT_ZICFILP		99
+#define RISCV_ISA_EXT_ZICFISS		100
 
 #define RISCV_ISA_EXT_XLINUXENVCFG	127
 
diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
index 5f56eb9d114a..e3aba3336e63 100644
--- a/arch/riscv/include/asm/processor.h
+++ b/arch/riscv/include/asm/processor.h
@@ -13,6 +13,7 @@
 #include <vdso/processor.h>
 
 #include <asm/ptrace.h>
+#include <asm/hwcap.h>
 
 #define arch_get_mmap_end(addr, len, flags)			\
 ({								\
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 2054f6c4b0ae..c54de1bbe206 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -258,6 +258,24 @@ static int riscv_ext_svadu_validate(const struct riscv_isa_ext_data *data,
 	return 0;
 }
 
+static int riscv_cfilp_validate(const struct riscv_isa_ext_data *data,
+			      const unsigned long *isa_bitmap)
+{
+	if (!IS_ENABLED(CONFIG_RISCV_USER_CFI))
+		return -EINVAL;
+
+	return 0;
+}
+
+static int riscv_cfiss_validate(const struct riscv_isa_ext_data *data,
+			      const unsigned long *isa_bitmap)
+{
+	if (!IS_ENABLED(CONFIG_RISCV_USER_CFI))
+		return -EINVAL;
+
+	return 0;
+}
+
 static const unsigned int riscv_a_exts[] = {
 	RISCV_ISA_EXT_ZAAMO,
 	RISCV_ISA_EXT_ZALRSC,
@@ -444,6 +462,10 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
 	__RISCV_ISA_EXT_SUPERSET_VALIDATE(zicbom, RISCV_ISA_EXT_ZICBOM, riscv_xlinuxenvcfg_exts, riscv_ext_zicbom_validate),
 	__RISCV_ISA_EXT_SUPERSET_VALIDATE(zicboz, RISCV_ISA_EXT_ZICBOZ, riscv_xlinuxenvcfg_exts, riscv_ext_zicboz_validate),
 	__RISCV_ISA_EXT_DATA(ziccrse, RISCV_ISA_EXT_ZICCRSE),
+	__RISCV_ISA_EXT_SUPERSET_VALIDATE(zicfilp, RISCV_ISA_EXT_ZICFILP, riscv_xlinuxenvcfg_exts,
+					  riscv_cfilp_validate),
+	__RISCV_ISA_EXT_SUPERSET_VALIDATE(zicfiss, RISCV_ISA_EXT_ZICFISS, riscv_xlinuxenvcfg_exts,
+					  riscv_cfiss_validate),
 	__RISCV_ISA_EXT_DATA(zicntr, RISCV_ISA_EXT_ZICNTR),
 	__RISCV_ISA_EXT_DATA(zicond, RISCV_ISA_EXT_ZICOND),
 	__RISCV_ISA_EXT_DATA(zicsr, RISCV_ISA_EXT_ZICSR),

-- 
2.43.0


