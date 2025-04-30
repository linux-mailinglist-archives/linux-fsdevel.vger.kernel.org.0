Return-Path: <linux-fsdevel+bounces-47660-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86A52AA3EE7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 02:31:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 616F81886E5F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 00:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 576C4224883;
	Wed, 30 Apr 2025 00:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="u7oAT4v4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119EC21C9E4
	for <linux-fsdevel@vger.kernel.org>; Wed, 30 Apr 2025 00:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745972199; cv=none; b=vEE3jOyXlsbiZsy9rUfoAZlT+opbtCG39lHI/wNZ5CYkXH2eRC/XbQuo5WoI/1K6geeEqCVvpmkELrcfSUX1UiM6HzPTvrreM2NQU3C7ctlSQUa4KSBhRZ7/ENQPF0PBgH9vLYl/vSl3IND9LZ+BWqg1PhQ7tsOyUDdf7/XsCwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745972199; c=relaxed/simple;
	bh=05039bUJ0bhZsU9ePl+ot7OaszQahvBHRlGY7m/JZd0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=otShYRz29DgxjwFv4ZIfPotDLfpuHpnyDn7OuSpLczoDTUtaF27v6zTVw8OsNXZRBr7y9SdkAyp9HmLkOlKSfK9s8njEfKqMnzP/QudUki+5Hj+Pm8aWPRfbg5v5ayIXeaXp79q9nzcYrCsxQXMDcnosQM4Ipv6jMsXa3dPotWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=u7oAT4v4; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2243803b776so111465825ad.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Apr 2025 17:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1745972195; x=1746576995; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kv/IZrFWN34T6LwOeKmoAZHYNOr2b+SAEf5j5mwxEcc=;
        b=u7oAT4v4q9V310c5meUGbAnUOLmZ3h9nKKrNiMomIEIVPe9sXJoizXT4B7jWVwD5n/
         QemkJZsesQ3qHq/0hqaUgvzfTvb0O3Hptlnaa/VTiRKmk4ldHohtOi8wtSy97Z7SkM8M
         Mgk2bWmU2CeDsh3/F6l9CSXQHh/t+WIQ++X9S4z7DN4EleE2J42pGZa3LYKyKsZSiF51
         RFeBROUaJpE4KA3Vzac58F65wUFUQj6nTZWArrXYEmVwda44txVdyf3Q75a5HRoFVLGQ
         z3fwlEDHsfo/5SuxECijqNUC6x9q7cfLGXqRWcWxPdqoG9sr6sQWHvrQKgGcJsEoXUb1
         Q/Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745972195; x=1746576995;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kv/IZrFWN34T6LwOeKmoAZHYNOr2b+SAEf5j5mwxEcc=;
        b=f6zaQaEShng0hCT4HPNfh5MaTmn4uZmA3rGos69V0uooixNe3iTfslkUfxvM0MCVbi
         h77YFxcRKnh2tX0sbSF7pUf0Pqxe+sJUjZffnXk+KCHvwOY/eALMBAetFoKNvKQpH89u
         1ziEMGrWTG3s3ghg9yTA0wIc/QgRT3emtc9T361vTgDfa/rK6qN5jYtOFkWr0M67RHtL
         0P1XLey7FlyPPmCHQKMZJBg04ioqPOKxAOtq6a5ClPgOPMVc9X2w62KGcgkvbMRZF3hW
         H7oywdfFlLFsE3Jw/batSO7O8TtEE7+Go6Ql12hVn1Yo6oBJjUB/WTF8lNIB+empAlcU
         Mylg==
X-Forwarded-Encrypted: i=1; AJvYcCVHvCgSw5hMwQuZF46E2I5HW7hM0GU+TgA+Mcz+Yq7hF3Ef42T70nvlkm9IAh8KeZtQVvgwvyyw5bfg1sIr@vger.kernel.org
X-Gm-Message-State: AOJu0YzTSAGjotzwsGHBNOnQIDA2HW2p8TQFgu0rYAaBNhyyVAso2GIl
	PvojRi51tcDRUVVeNuyvG1gaF0e9j2bDSbHg7R6Fr7BMXFJuC703ruT0F23sWcQ=
X-Gm-Gg: ASbGncsj1uadKFT7MVIu6a3rd206Y86nBj6FyN3WGNDwzxFqwErppMgWhrRFV+H1M1T
	qvUWrqp0W3gj+UPIDgws17nO5/bO5vKtb2Axnqq5V6Lwagg1zWaAMSZS/En7Jb55eVVSwpzl0Mt
	KobFLuin2J5+koqGF8vnxG2tEHC9JRO/AqztaadBR2T7rPY3RwcueCHj10L09PIle6jx401trgQ
	77r1oflHeK2Oh+U2SVwfMtIsLLH1TxmxEeKlHreOkACrrXvbHnEXny/LiFmO6o/cTI3gCKKl3Rm
	9hQQkjMeo8m2Y2uyS8kWNu86s+kvBVrTFhu7ApOIk/krSKPgXl6rYlgNwEylMw==
X-Google-Smtp-Source: AGHT+IElTpm1m59BCiMYV66Qwl1bIP6MumvDjXe79sV2QfTXj47VxQa3ZP8qKREhDRx3opT6xCz9bg==
X-Received: by 2002:a17:903:1b0e:b0:223:6744:bfb9 with SMTP id d9443c01a7336-22df359c764mr20042105ad.41.1745972195360;
        Tue, 29 Apr 2025 17:16:35 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db4d770d6sm109386035ad.17.2025.04.29.17.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 17:16:35 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Tue, 29 Apr 2025 17:16:20 -0700
Subject: [PATCH v14 03/27] riscv: zicfiss / zicfilp enumeration
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250429-v5_user_cfi_series-v14-3-5239410d012a@rivosinc.com>
References: <20250429-v5_user_cfi_series-v14-0-5239410d012a@rivosinc.com>
In-Reply-To: <20250429-v5_user_cfi_series-v14-0-5239410d012a@rivosinc.com>
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
 arch/riscv/kernel/cpufeature.c      | 13 +++++++++++++
 4 files changed, 28 insertions(+)

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
index 2054f6c4b0ae..98e55467557b 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -258,6 +258,15 @@ static int riscv_ext_svadu_validate(const struct riscv_isa_ext_data *data,
 	return 0;
 }
 
+static int riscv_cfi_validate(const struct riscv_isa_ext_data *data,
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
@@ -444,6 +453,10 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
 	__RISCV_ISA_EXT_SUPERSET_VALIDATE(zicbom, RISCV_ISA_EXT_ZICBOM, riscv_xlinuxenvcfg_exts, riscv_ext_zicbom_validate),
 	__RISCV_ISA_EXT_SUPERSET_VALIDATE(zicboz, RISCV_ISA_EXT_ZICBOZ, riscv_xlinuxenvcfg_exts, riscv_ext_zicboz_validate),
 	__RISCV_ISA_EXT_DATA(ziccrse, RISCV_ISA_EXT_ZICCRSE),
+	__RISCV_ISA_EXT_SUPERSET_VALIDATE(zicfilp, RISCV_ISA_EXT_ZICFILP, riscv_xlinuxenvcfg_exts,
+					  riscv_cfi_validate),
+	__RISCV_ISA_EXT_SUPERSET_VALIDATE(zicfiss, RISCV_ISA_EXT_ZICFISS, riscv_xlinuxenvcfg_exts,
+					  riscv_cfi_validate),
 	__RISCV_ISA_EXT_DATA(zicntr, RISCV_ISA_EXT_ZICNTR),
 	__RISCV_ISA_EXT_DATA(zicond, RISCV_ISA_EXT_ZICOND),
 	__RISCV_ISA_EXT_DATA(zicsr, RISCV_ISA_EXT_ZICSR),

-- 
2.43.0


