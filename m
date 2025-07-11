Return-Path: <linux-fsdevel+bounces-54702-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5B00B024DF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 21:47:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 531E654404E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 19:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E4292F3C2F;
	Fri, 11 Jul 2025 19:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="GWQB2iw6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B822F3C03
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Jul 2025 19:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752263185; cv=none; b=Mbd+pqVzcwHsdUIXEf4rnFlBETLe7R7JxdjDypo+uSYdEMswafC3LEg6l9IBQBEEUvWQ7oMEjkcFR6qnznApoPk+/9JaOTR7AgkOOQ/ulrFfPqGGUaHt1kJ/Qz2Ilc3+7FwOvTQrXrsywX3tnIyn2y4B0u0OsHo/asbzTKolBeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752263185; c=relaxed/simple;
	bh=7li879NG60DMvoItDtTrx3PfjzLR4bOnwC03MvXTnvw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jwAQaugbf7ahVvszxqwv5NJiFaZG5lAN1Jc463vEQNtRSUMGeqq3DoEBMUjc/Y8BRhY3q8133CkSA1HC9RlajwSDSUAjlrK5QxcI18ahgXQwctD8yHYNrtgKlnaU86/TTFchfyumuLOD3k84tqX0RuSh/vww6Q/EfBVeKb+vVmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=GWQB2iw6; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-74b54cead6cso1812814b3a.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Jul 2025 12:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1752263183; x=1752867983; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R/zH7pR/lYDXTCsVz0jr8PjmlJlgvFu5fq+fqB2fhJ8=;
        b=GWQB2iw6nCcmMhAmQ2vnSMu9CbUe7FxW3GoiPk7AKvtI/rG2VZTx6GoJ2I3vNCNoth
         OFW/mm/Ql1kWUvaAJg4suk+6sIOtLXPm1UK09SD1+1hutPUxtjV4b3xnmHgt8UJ+Jcwm
         L9BH0F+ZFjLq9uY2gMqxEh0zw+QkxL3LmZ9OKcvPuNkDOBPk10u+pz4nSZnpq3hE27vI
         kScyAt6JbgnRnBSlxXYrJfthHABoWWv77DWLR1msE+yRcGQAV64u/cd4pSAGQflCDsj5
         spWAvu+yFyvZcylSgOizwukOfbW3GKv4YiBTAddA4e0GvBF3jfzN5pFBVwSAr1iXcJa0
         Ieog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752263183; x=1752867983;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R/zH7pR/lYDXTCsVz0jr8PjmlJlgvFu5fq+fqB2fhJ8=;
        b=A0TmNmVgxfVGGUDh2Pl7iSwoFpwSFBmMD7acgR66sCLoUTDve2srVZtPMqExhPj9x4
         rNJ6PGXbi3cvklJDABjxX1Ots+1LfnFVTn7rn1tUM9SqZ4hZiuGv+SlTrg9xt7NZFFH2
         crYSu7ZIl/qIkENkXqieGsUWUL17ra2zJyDxpz6IGthji7TvaRclJbyrOfTftp/vyzO0
         NeXFS/F48NcWOq5xOiDkbUzzqAg1kZjyz4hlF9Y3TM+O6Whk7jIUfx0jeqVNAcQ7PeKR
         7l5UO6tiHjaTbRZFuQOqaNuzbOc+y/kuJ80S/oL8qBfDdjHpoHpqkvU0yTeNzlRfm4py
         /Tyg==
X-Forwarded-Encrypted: i=1; AJvYcCXvHTpPOOcoUmRRdgJCu1tK/ZhClNVV/cCX0YzdEr/A9XiZIcd1PeMyoMxIX7a6n6ztvtn8Lf9mOYPz9Dfb@vger.kernel.org
X-Gm-Message-State: AOJu0YyFdUQFS97iXIx5mMiIWcl0R745yRxavxvo/1BxB6H9/lNjPQWr
	Pe7x9+lWV2nj3lVOE/XM4wAJEXl+Pdq3f030ZWF5GsVbK3mmnbyXrewQyi3G2WGvOOo=
X-Gm-Gg: ASbGnctu9pYmvRK7Ply10zlzzvlC8jwigx/mqOshj62N6XPYXtTCiZhAYxagLvw9UMD
	R3j9XDH8HVUbJy3fuiMrDAecz2vgI7Pi28MJp6Y8yEWSruMPwzntcuhBktkQ+DgH+lHWUshlPUC
	00ePuA3eFOJuI+j5CfqDHBQsKAIhvOevPj2hVtV7jJDjp20z+GxsvbJk2ShQeQN76PPH2vHp3l3
	4kUgoQwSOwRfbr3It+kCTHc/NSR+ES1fs9MnZxEy6gZhFmR7dCOd7jtsRwMFP93JDgZlzMdgZ4T
	0tp4vFBIfwUbFQ15YT5G7nIQJwhHo874b0ghG8brGb9iIv33Utq/0McnYjIk1MnYRN5J7FNTPER
	uoSbUt4HMMTdN3Cpt3R7CYPK3GC4pJXlu
X-Google-Smtp-Source: AGHT+IFyimWgTP5VaqUhTlIlPAVe2LYBX0T5vTTsCW0gESMJyXnfxn+vG6S6gJBxf49Htp5zG0wCCw==
X-Received: by 2002:a05:6a20:9f4d:b0:220:9e54:d5cc with SMTP id adf61e73a8af0-23120a0397bmr8606330637.31.1752263183164;
        Fri, 11 Jul 2025 12:46:23 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9e06995sm5840977b3a.38.2025.07.11.12.46.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 12:46:22 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Fri, 11 Jul 2025 12:46:08 -0700
Subject: [PATCH v18 03/27] riscv: zicfiss / zicfilp enumeration
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250711-v5_user_cfi_series-v18-3-a8ee62f9f38e@rivosinc.com>
References: <20250711-v5_user_cfi_series-v18-0-a8ee62f9f38e@rivosinc.com>
In-Reply-To: <20250711-v5_user_cfi_series-v18-0-a8ee62f9f38e@rivosinc.com>
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
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Benno Lossin <lossin@kernel.org>
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
 arch/riscv/kernel/cpufeature.c      | 22 ++++++++++++++++++++++
 3 files changed, 36 insertions(+)

diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm/cpufeature.h
index 9430dc198caa..c5c01efba3e7 100644
--- a/arch/riscv/include/asm/cpufeature.h
+++ b/arch/riscv/include/asm/cpufeature.h
@@ -156,4 +156,16 @@ static __always_inline bool riscv_cpu_has_extension_unlikely(int cpu, const unsi
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
index affd63e11b0a..7c4619a6d70d 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -106,6 +106,8 @@
 #define RISCV_ISA_EXT_ZAAMO		97
 #define RISCV_ISA_EXT_ZALRSC		98
 #define RISCV_ISA_EXT_ZICBOP		99
+#define RISCV_ISA_EXT_ZICFILP		100
+#define RISCV_ISA_EXT_ZICFISS		101
 
 #define RISCV_ISA_EXT_XLINUXENVCFG	127
 
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 743d53415572..d38136672650 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -274,6 +274,24 @@ static int riscv_ext_svadu_validate(const struct riscv_isa_ext_data *data,
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
@@ -461,6 +479,10 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
 	__RISCV_ISA_EXT_DATA_VALIDATE(zicbop, RISCV_ISA_EXT_ZICBOP, riscv_ext_zicbop_validate),
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


