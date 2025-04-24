Return-Path: <linux-fsdevel+bounces-47196-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD83A9A3C6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 09:29:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 880EA1B6104A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 07:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFB25227BA4;
	Thu, 24 Apr 2025 07:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="tRJeT4J3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84248226556
	for <linux-fsdevel@vger.kernel.org>; Thu, 24 Apr 2025 07:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745479297; cv=none; b=cMma4eoaLa0voXhBkMHSErKrC4yQ3D6i2j2Yyos7VWrlGWlRv0lefCWOp1eFB/8B2CljDlomzHkte/FBlPP0zPJrw+95/CiOEAPJeFPSYIqWU9ZMGTvK4ZGS+iuNk9SuPHXk/+5uP/BTfl/MGPD7ka1RFAHO4wcEdXAMObv+QQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745479297; c=relaxed/simple;
	bh=6HOI0xNMHwgDoMQzl6o5vZZloZ1zXIW22VEUT/hXJeM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WObzi0JpwriQBYl/d5ZwPubDPZtlJKmwt7d+1e/lAgJiS8pMamH0RVhIcT0A+L86fT0RtD/N2BkL4VDvDqfeUxDYImI1AAnJYRwvnscr7QzgT9hQCsqjN41egQ4/pMUrt81n60ed2luuUrDseeFc2g6qOt0U6qH6F+SatffA0J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=tRJeT4J3; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2254e0b4b79so10700065ad.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Apr 2025 00:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1745479295; x=1746084095; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=56/SgN8tPGcoGAXYBKRxyrEfzuX2/hNCTBzPLMLGwJ8=;
        b=tRJeT4J3I1YukuSAIml/5cC8ba0rsNy33myF2eZ+Y4BWQE+P2VwRSYdyTvtkoVhllC
         msGNIP0zsFAm1we3Ti9x3WOewdz5TWiY6ORl+oOd1o0HkLOm2/er/Szu/m6Un62rhVQv
         0VJW1GiPpFNd7mMeh9g2dH8V4/kGABGaOUJxlTwcIxj3xYHECqreiB1fKkSTj3XErggZ
         j1J1YUU1tkg2vzfwFEFy6+S6Vw1I9qQi8IZ3Bllv9EMBfuBcyKtXbx8KWxMIpPLRB9sd
         rHUbZci5Vh68e16g1Z5kCEQUqZ79sQUyeXpQJNXWP47OL3XePDgyf4CLCLW9ylMHhBcg
         JYMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745479295; x=1746084095;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=56/SgN8tPGcoGAXYBKRxyrEfzuX2/hNCTBzPLMLGwJ8=;
        b=I7VE9NnPa/u2cMwmTVVDrZDYKVPLbO/UCx+PcL7TczKsFVWKzP7N3B4S5PLmek+Rwu
         axxn/yYxVKlUe80YP4uNMZ1xhA1iF1gpdM/AFLmBGVgUpFyHas0aA3oMlmbS1vB4wu3l
         RC/14WnTC4xAnWMjICW7YdMD+dqx+LJTlKrp688zWdkZHMWphif9L4kmCMStrWX7UZGB
         AkVcrsS0PLVjn+TlF5VsGi4JcKeqCAGSVlubJ74AuvYl2lmxkrGBvPVPhYvHfD2fAuZo
         NX08gV32zZdLM+c3g7EHnnqgYzOR8Fh09Rca42CAmsPSAnmVu6pHmZi553DkDHhcpemK
         Hu2Q==
X-Forwarded-Encrypted: i=1; AJvYcCX3t06qvu2JhTHj8aD+R0GKk97ZkfoFkJU3pTWOzIdKRNSPaQA03pkjuWHsSV8VhmT6irv8RWyVbFNntNRt@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0WumwDYBbg4Hsk7y3jt1CfuJRQuhp1DE3Az0+1dTy0qg7dRJR
	p8/vFTWb73MSgechBU5iiGzn9V5WWDYwqrGD/sG5TvotrGXBmphFYMnq6FEKD9Y=
X-Gm-Gg: ASbGncvjJk7MD5jZR8A8/POFJ/7PFtH0fZvZyEGpsWOiCGLHKM+TwdrZrQlkIVmbDMg
	U5GnWIGCJg0e/vY7PgLtNIy5fZts9Kw6gTQwXPGqAPuT2Ce4yazZ5woOMvA+F1t/+hNHQxrP8GB
	ilSQ0/u+mGcc+v88ek0SXHH36BeQLh3OCqZ2fArC5I+DrC3tNOqTvjgSAWQ4eCLCx4Xi/8Z+8WK
	5nKf9fE1ODCMyOKmQb9wXchHZwe0SsDBD5umkpNKu0OIdmW9wjQNwYI8TeG1e0448XQV9uBAvW3
	dYOQOtP9IGklst23/509NTCO3w0rcS6CGcCfywdUZzkeCdglCLM=
X-Google-Smtp-Source: AGHT+IES6ugcFiGiBeYn0Bu9yj72YjguM/2DnNhh5dwYD/ciftAfP8S7Lu2JJFwp+N1aQgpYEtpBuA==
X-Received: by 2002:a17:903:24a:b0:223:668d:eba9 with SMTP id d9443c01a7336-22db3bb6f7dmr25356505ad.10.1745479294876;
        Thu, 24 Apr 2025 00:21:34 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db52163d6sm6240765ad.214.2025.04.24.00.21.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 00:21:34 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Thu, 24 Apr 2025 00:20:37 -0700
Subject: [PATCH v13 22/28] riscv: Add Firmware Feature SBI extensions
 definitions
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250424-v5_user_cfi_series-v13-22-971437de586a@rivosinc.com>
References: <20250424-v5_user_cfi_series-v13-0-971437de586a@rivosinc.com>
In-Reply-To: <20250424-v5_user_cfi_series-v13-0-971437de586a@rivosinc.com>
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
 Zong Li <zong.li@sifive.com>
X-Mailer: b4 0.13.0

From: Clément Léger <cleger@rivosinc.com>

Add necessary SBI definitions to use the FWFT extension.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
Reviewed-by: Zong Li <zong.li@sifive.com>
---
 arch/riscv/include/asm/sbi.h | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index 3d250824178b..23bfb254e3f4 100644
--- a/arch/riscv/include/asm/sbi.h
+++ b/arch/riscv/include/asm/sbi.h
@@ -35,6 +35,7 @@ enum sbi_ext_id {
 	SBI_EXT_DBCN = 0x4442434E,
 	SBI_EXT_STA = 0x535441,
 	SBI_EXT_NACL = 0x4E41434C,
+	SBI_EXT_FWFT = 0x46574654,
 
 	/* Experimentals extensions must lie within this range */
 	SBI_EXT_EXPERIMENTAL_START = 0x08000000,
@@ -401,6 +402,31 @@ enum sbi_ext_nacl_feature {
 
 #define SBI_NACL_SHMEM_SRET_X(__i)		((__riscv_xlen / 8) * (__i))
 #define SBI_NACL_SHMEM_SRET_X_LAST		31
+/* SBI function IDs for FW feature extension */
+#define SBI_EXT_FWFT_SET		0x0
+#define SBI_EXT_FWFT_GET		0x1
+
+enum sbi_fwft_feature_t {
+	SBI_FWFT_MISALIGNED_EXC_DELEG		= 0x0,
+	SBI_FWFT_LANDING_PAD			= 0x1,
+	SBI_FWFT_SHADOW_STACK			= 0x2,
+	SBI_FWFT_DOUBLE_TRAP			= 0x3,
+	SBI_FWFT_PTE_AD_HW_UPDATING		= 0x4,
+	SBI_FWFT_LOCAL_RESERVED_START		= 0x5,
+	SBI_FWFT_LOCAL_RESERVED_END		= 0x3fffffff,
+	SBI_FWFT_LOCAL_PLATFORM_START		= 0x40000000,
+	SBI_FWFT_LOCAL_PLATFORM_END		= 0x7fffffff,
+
+	SBI_FWFT_GLOBAL_RESERVED_START		= 0x80000000,
+	SBI_FWFT_GLOBAL_RESERVED_END		= 0xbfffffff,
+	SBI_FWFT_GLOBAL_PLATFORM_START		= 0xc0000000,
+	SBI_FWFT_GLOBAL_PLATFORM_END		= 0xffffffff,
+};
+
+#define SBI_FWFT_GLOBAL_FEATURE_BIT		(1 << 31)
+#define SBI_FWFT_PLATFORM_FEATURE_BIT		(1 << 30)
+
+#define SBI_FWFT_SET_FLAG_LOCK			(1 << 0)
 
 /* SBI spec version fields */
 #define SBI_SPEC_VERSION_DEFAULT	0x1

-- 
2.43.0


