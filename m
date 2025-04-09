Return-Path: <linux-fsdevel+bounces-46101-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38CECA828BC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 16:52:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B24A4E7442
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 14:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3825326A1CD;
	Wed,  9 Apr 2025 14:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Rv1Tpnnf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5F626A1BC
	for <linux-fsdevel@vger.kernel.org>; Wed,  9 Apr 2025 14:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744209829; cv=none; b=eaiH3jKfUTpTjzpooZmlfc1g6lTxqZNPGwRIjkpUVcNzPVaKFFM9pz5poAjH4PagAlNlPOyjkEF3LNu/vR9uqrm1dvkqS/LAbQESlLDwy8y8ZXaPbz9uanW0v+EoZ1kz9QHvcbtDD59ilV0r7njb12JlOGZaCa2zXcix4mS25qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744209829; c=relaxed/simple;
	bh=7Qyl/KGbNgAjKHzOstykL1b1PVeFC9C9SmfU8PxYhlc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WKQT7q2GgsbYH6x4Uxa5chyctt036S0pCzS6VGQJW8iGDcs1nh1OFnk2MQnTtmu8QnklQIFUPGdSsjOwUEgSMNw44BsLZHsQO+MAutEdg6eBKUt4mPJ4YsV/E4SwTMJfMh6QzJc4m74yfg5IgoavmKyDCXghCr/26z4uqzpEREE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=Rv1Tpnnf; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2243803b776so98160325ad.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Apr 2025 07:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1744209827; x=1744814627; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ow5mA7lTDwDJ/M6E3XEwhzsM01atmOj/MJRSg0pfs/U=;
        b=Rv1TpnnfCAYDUJmZsb8GSLvbfAR41yOxgzPfzDczY7jUA9EHzFeKfw8JMydztCGYmZ
         EjkDW3U9IbEbUtWHMuA7Ei3zh3fO1csXbPVFVIW4Lk95SfxgnBXXrgS+h1ORV6U+k9rK
         0q3vzGjvCCjgiP9ttTvVkciqE0XaJPSBdZR16s8pDn7OLYvGm5g+2E0VHGt2MX9y6x9h
         MUF7ZnNirkUdAMreh7a4kyTkdeG9ovH0ptoLzHh8IZi9NhzWmPlJFGGHjxCbG5LBLWF0
         6k8csHj2KmrgIgaOfbscu3VA6rKihvw7Im13SXTB/DAuk8xbv597NB3r5s2ufihZAbqu
         pHgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744209827; x=1744814627;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ow5mA7lTDwDJ/M6E3XEwhzsM01atmOj/MJRSg0pfs/U=;
        b=ADDzk/9UY0UVXaHzEUwk5XzJHDqRNJj+eLHbVzVpUhKq0YPsT3O9ezlMmjjFCA4UT9
         x5147K3MOsD9B9g3EWCppaRKOHC4xkiZXCR3Zo1QIPnveZV5k0IVB6Y3R6kSlS3k9aob
         hD7b39UYN//YtqtoXRbC1WCzxXa7G+XqL/m9/ib1qoB46hXr20jPBTY3VyPVzqgUGWz0
         Oo5QVm0dpLWMYxhME41jN0lVHCLF7MhOQmwJO6wHx63a8KbaZmdZNojoNOQQc60zyb4Z
         vaCJX8vEQCZsGHx0LLihKldFkJ/T/uve5aAdhJ6LTjQsSQhjKoEuFQn5yOjLrssh9/5N
         JWwA==
X-Forwarded-Encrypted: i=1; AJvYcCXGlWhcyNr8q2I2vaGiodViNfVi/YALwt4tCOSgtskhlygEmEWmkSzysrA7C8qBniWB+XbnpLH+qMwbPP+3@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0LKcwIeVlV87coFIPQlEsZFw9ok0/9MwblvlY3mtCVwyUtA8L
	hNXALedqRBH5S5ChYSUEn2sWuxvOLfu9ibNNVUErRHXcPVHwJnzB9wRfojWKZWE=
X-Gm-Gg: ASbGnct1g63HBjFeoCMMFJZCPGatDuaQEF8tQ/jMRIF1XEdBIddByRNWmqgoFmJoZNg
	F1m2wc608I6ZVnf7Sw8DyrQHEvdv5N8TjQ+aNJNx58SefLZqXVTk/+4tICV+gQPV7ZNHCxXQk6h
	zkJ4z9aOnBcGFKplWlA9Nbc3lSeKqKyjyK0xHO+zI1SJ2Cai1elDlVzhXc3GIM1deLwadgcYoqk
	i46W3Egoa6yG505i+tzqXcrQGcZIwPjfovvnZ5BWFC2xYu1Agnsh951DqYJsgazN+rrFrAovEUO
	T3/jM4ykRVGz/2OV86/1BqYbl6UeKDZ+zWonLJT5c8uXXerNYvA=
X-Google-Smtp-Source: AGHT+IEgaCnvV5qiE5FYgc0Ujjm72QHq4NY5rpvgBrpJwRVGqGD1OFM7I6sIlnm2n2XAV9/GUpCxyg==
X-Received: by 2002:a17:903:32cb:b0:220:c164:6ee1 with SMTP id d9443c01a7336-22ac2a1df5cmr51260355ad.32.1744209826897;
        Wed, 09 Apr 2025 07:43:46 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7cb538csm12708815ad.176.2025.04.09.07.43.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 07:43:46 -0700 (PDT)
Date: Wed, 9 Apr 2025 07:43:42 -0700
From: Deepak Gupta <debug@rivosinc.com>
To: Alexandre Ghiti <alex@ghiti.fr>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Christian Brauner <brauner@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	Jann Horn <jannh@google.com>, Conor Dooley <conor+dt@kernel.org>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
	alistair.francis@wdc.com, richard.henderson@linaro.org,
	jim.shu@sifive.com, andybnac@gmail.com, kito.cheng@sifive.com,
	charlie@rivosinc.com, atishp@rivosinc.com, evan@rivosinc.com,
	cleger@rivosinc.com, alexghiti@rivosinc.com,
	samitolvanen@google.com, broonie@kernel.org,
	rick.p.edgecombe@intel.com, Zong Li <zong.li@sifive.com>
Subject: Re: [PATCH v12 03/28] riscv: zicfiss / zicfilp enumeration
Message-ID: <Z_aHnj2-8OlcRuHd@debug.ba.rivosinc.com>
References: <20250314-v5_user_cfi_series-v12-0-e51202b53138@rivosinc.com>
 <20250314-v5_user_cfi_series-v12-3-e51202b53138@rivosinc.com>
 <cc314da6-8755-4037-846b-01a20b3c68e1@ghiti.fr>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <cc314da6-8755-4037-846b-01a20b3c68e1@ghiti.fr>

On Mon, Apr 07, 2025 at 05:48:27PM +0200, Alexandre Ghiti wrote:
>
>On 14/03/2025 22:39, Deepak Gupta wrote:
>>This patch adds support for detecting zicfiss and zicfilp. zicfiss and
>>zicfilp stands for unprivleged integer spec extension for shadow stack
>>and branch tracking on indirect branches, respectively.
>>
>>This patch looks for zicfiss and zicfilp in device tree and accordinlgy
>>lights up bit in cpu feature bitmap. Furthermore this patch adds detection
>>utility functions to return whether shadow stack or landing pads are
>>supported by cpu.
>>
>>Reviewed-by: Zong Li <zong.li@sifive.com>
>>Signed-off-by: Deepak Gupta <debug@rivosinc.com>
>>---
>>  arch/riscv/include/asm/cpufeature.h | 13 +++++++++++++
>>  arch/riscv/include/asm/hwcap.h      |  2 ++
>>  arch/riscv/include/asm/processor.h  |  1 +
>>  arch/riscv/kernel/cpufeature.c      | 13 +++++++++++++
>>  4 files changed, 29 insertions(+)
>>
>>diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm/cpufeature.h
>>index 569140d6e639..69007b8100ca 100644
>>--- a/arch/riscv/include/asm/cpufeature.h
>>+++ b/arch/riscv/include/asm/cpufeature.h
>>@@ -12,6 +12,7 @@
>>  #include <linux/kconfig.h>
>>  #include <linux/percpu-defs.h>
>>  #include <linux/threads.h>
>>+#include <linux/smp.h>
>>  #include <asm/hwcap.h>
>>  #include <asm/cpufeature-macros.h>
>>@@ -137,4 +138,16 @@ static __always_inline bool riscv_cpu_has_extension_unlikely(int cpu, const unsi
>>  	return __riscv_isa_extension_available(hart_isa[cpu].isa, ext);
>>  }
>>+static inline bool cpu_supports_shadow_stack(void)
>>+{
>>+	return (IS_ENABLED(CONFIG_RISCV_USER_CFI) &&
>>+		riscv_cpu_has_extension_unlikely(smp_processor_id(), RISCV_ISA_EXT_ZICFISS));
>
>
>I would use riscv_has_extension_unlikely() instead of the cpu specific 
>variant, that would remove the need for #include <linux/smp.h>. Unless 
>you have a good reason to do that?


No I dont remember the reason. I'll fix it.
When I am fixing it, and happpen to remember the reason.
I'll post it.

>
>
>>+}
>>+
>>+static inline bool cpu_supports_indirect_br_lp_instr(void)
>>+{
>>+	return (IS_ENABLED(CONFIG_RISCV_USER_CFI) &&
>>+		riscv_cpu_has_extension_unlikely(smp_processor_id(), RISCV_ISA_EXT_ZICFILP));
>>+}
>>+
>>  #endif
>>diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
>>index 869da082252a..2dc4232bdb3e 100644
>>--- a/arch/riscv/include/asm/hwcap.h
>>+++ b/arch/riscv/include/asm/hwcap.h
>>@@ -100,6 +100,8 @@
>>  #define RISCV_ISA_EXT_ZICCRSE		91
>>  #define RISCV_ISA_EXT_SVADE		92
>>  #define RISCV_ISA_EXT_SVADU		93
>>+#define RISCV_ISA_EXT_ZICFILP		94
>>+#define RISCV_ISA_EXT_ZICFISS		95
>>  #define RISCV_ISA_EXT_XLINUXENVCFG	127
>>diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
>>index 5f56eb9d114a..e3aba3336e63 100644
>>--- a/arch/riscv/include/asm/processor.h
>>+++ b/arch/riscv/include/asm/processor.h
>>@@ -13,6 +13,7 @@
>>  #include <vdso/processor.h>
>>  #include <asm/ptrace.h>
>>+#include <asm/hwcap.h>
>>  #define arch_get_mmap_end(addr, len, flags)			\
>>  ({								\
>>diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
>>index c6ba750536c3..82065cc55822 100644
>>--- a/arch/riscv/kernel/cpufeature.c
>>+++ b/arch/riscv/kernel/cpufeature.c
>>@@ -150,6 +150,15 @@ static int riscv_ext_svadu_validate(const struct riscv_isa_ext_data *data,
>>  	return 0;
>>  }
>>+static int riscv_cfi_validate(const struct riscv_isa_ext_data *data,
>>+			      const unsigned long *isa_bitmap)
>>+{
>>+	if (!IS_ENABLED(CONFIG_RISCV_USER_CFI))
>>+		return -EINVAL;
>>+
>>+	return 0;
>>+}
>>+
>>  static const unsigned int riscv_zk_bundled_exts[] = {
>>  	RISCV_ISA_EXT_ZBKB,
>>  	RISCV_ISA_EXT_ZBKC,
>>@@ -333,6 +342,10 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
>>  	__RISCV_ISA_EXT_SUPERSET_VALIDATE(zicboz, RISCV_ISA_EXT_ZICBOZ, riscv_xlinuxenvcfg_exts,
>>  					  riscv_ext_zicboz_validate),
>>  	__RISCV_ISA_EXT_DATA(ziccrse, RISCV_ISA_EXT_ZICCRSE),
>>+	__RISCV_ISA_EXT_SUPERSET_VALIDATE(zicfilp, RISCV_ISA_EXT_ZICFILP, riscv_xlinuxenvcfg_exts,
>>+					  riscv_cfi_validate),
>>+	__RISCV_ISA_EXT_SUPERSET_VALIDATE(zicfiss, RISCV_ISA_EXT_ZICFISS, riscv_xlinuxenvcfg_exts,
>>+					  riscv_cfi_validate),
>>  	__RISCV_ISA_EXT_DATA(zicntr, RISCV_ISA_EXT_ZICNTR),
>>  	__RISCV_ISA_EXT_DATA(zicond, RISCV_ISA_EXT_ZICOND),
>>  	__RISCV_ISA_EXT_DATA(zicsr, RISCV_ISA_EXT_ZICSR),
>>
>
>With the above comment fixed, you can add:
>
>Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
>
>Thanks,
>
>Alex
>

