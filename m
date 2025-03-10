Return-Path: <linux-fsdevel+bounces-43630-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26FFBA598BC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 15:59:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E85AA16DC90
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 14:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BDBA23A99F;
	Mon, 10 Mar 2025 14:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Ct+JB6P8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70DAE238D35
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Mar 2025 14:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741618404; cv=none; b=cWbjMYSNGNU+pZc1h8Vtq/amjQVPbLBJ1MLw4jK6BR25Ck9aHnRptJ0r6ImpWoeNsLHVirqNTbsEWGeIA500mZ+2rqcg9LyqdG4UxPbrvs13KhITUVV0+LUzKYsGe3v9VxB0Sh4uKc9fNc7Ck8iGT7E/AXp6M4udLRlvozsjC8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741618404; c=relaxed/simple;
	bh=lD6rgHPb/ib2WH9dder9ZLKtBlS2SotatDP0DK7YItE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BxmG7PBgKjuIUoGO+Cr1L5bIoZKi5lqMTG7HZLjTEbvOD97IwqamorpOc04QGYH0h/pBra/omjKFTD2QNcEYruZElye/DAk1o0drhWKYVwjQ4WyaEfzPBmrbDz84ln/p8Gbt1gOrbhaIuEruSArgMDci/xLmlOdg+k/tOsNzq5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=Ct+JB6P8; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-22349bb8605so78603835ad.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Mar 2025 07:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1741618402; x=1742223202; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a5uI84SXblQRDID2BHNWhhHsRc7xVUDdoiei4kS9c/0=;
        b=Ct+JB6P8gBFhU2GL68I9x56icjkLjP62AapuT2jcDeENjphhxaGGU3o+qC8dvKrJ0g
         2VfkE9773u7mT4/bPGU8BwIZlfR+Ynatelwu14iYwVM6exIiH6gjp+3B4XjVdJfL4EYs
         4qC50m+e0mG7AbBt3fM2AWvnhDyCBIpD8l2BTMQceznIti+vPI3gt2Y8jENfIaqA2a9t
         YRel1XQSF1IYenBIUAg/xE4OMXKixw6zVwXIxoQBEQQPIM3e5Gk7KDzclPmCj/1bCMaG
         In0BU9boVSJlZ7ykEefPbMdFA3Qx0QxQ6esFxVSSS91DR0SnEDmlQDd66ojWVQcUwJ2q
         gKZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741618402; x=1742223202;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a5uI84SXblQRDID2BHNWhhHsRc7xVUDdoiei4kS9c/0=;
        b=Tb8i5P8WJEb5bTrQyFrdY1JH2JsulO6Bn8JnWnf9/Xr4Hq9kHUrurzSBobIi+g9Iuu
         +czRrphRBw0R/X6au4cNknbTH9DFhOHzoDZrvt6AOiVRbNY85ilCaHbPnhoxWjG0cd0s
         Y5eWPlD77cE8F42LpTc2mHmBtOXDiEM1jTz9/Lfa40/7P+1Qj0iLgO+0OAivcPMi7TU2
         J4kFiBwHeBMtlwViOsBozXLS5A0xxzJSj360tocorFZKaYNUoIQKMtz2i76uJdlgo88x
         UMg/zvE++SMqLYvTE/Aa59GBZWJe57fQW9OUbqS/SylzzmRPns7ryC9GnPku5LJSc1DV
         hhWQ==
X-Forwarded-Encrypted: i=1; AJvYcCXf7xgEoSmwjHP39wi5RAr5KVK5UCG4EWSmrW4M6m7H5V66Efcg3o7Jttuz/7GTkwC/DmhcLNcosalUUx2B@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+2gte0dN1YzCw59cYAxUxxxcOjPB7otcQ0vGEP5OMy7TMY18U
	cE/D7zNM6KA0uvxgOP3DVKHb9huA6QvU0tTf52rt5mKTAj69ScULdT4thrkEKdI=
X-Gm-Gg: ASbGncvjEXZYT4K3vN/6JiZaEPmywQ5W6IPOdRMQkI9uC6UIU6fQvYRX+59Nhrvh/3/
	3FjEDsrqKON/vaCNV9+fHawej7lF6WOksg7dPqIQywKRbyihOYvIZpUXAgb/q/SIUtWN58DmD7K
	fqgyix+lVTBwCEsiBxOgzQnN3YK5Y/srtMymzvnRXQzZWO8jJbOPR7ZqFsEu4XSee/6R6OXyEGk
	7EEuFDTPZcS4EELxFkS0fWEmduwlgnRnvDwwJRyBBNCjgAhCfNQaWvew+CkFHNRHVsxIE2WjpxR
	xQ3R0K70P3xNWvIP9Y+9Y3kDmL7M82CaSU1h2w1+IVnXYEa9sPxzUnE=
X-Google-Smtp-Source: AGHT+IFjDwjQ9fbG75ByIkC5Z62BpsOlmfgaoy0NDr7CGAoT4eOeNPAoaYep0Q4HRAItC/SdOQSQyA==
X-Received: by 2002:a05:6a00:4b4a:b0:736:54c9:df2c with SMTP id d2e1a72fcca58-736aaab75e8mr18259867b3a.15.1741618401679;
        Mon, 10 Mar 2025 07:53:21 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-736d11d4600sm2890275b3a.116.2025.03.10.07.53.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 07:53:21 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Mon, 10 Mar 2025 07:52:42 -0700
Subject: [PATCH v11 20/27] riscv: Add Firmware Feature SBI extensions
 definitions
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250310-v5_user_cfi_series-v11-20-86b36cbfb910@rivosinc.com>
References: <20250310-v5_user_cfi_series-v11-0-86b36cbfb910@rivosinc.com>
In-Reply-To: <20250310-v5_user_cfi_series-v11-0-86b36cbfb910@rivosinc.com>
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
 Jann Horn <jannh@google.com>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-mm@kvack.org, linux-riscv@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 alistair.francis@wdc.com, richard.henderson@linaro.org, jim.shu@sifive.com, 
 andybnac@gmail.com, kito.cheng@sifive.com, charlie@rivosinc.com, 
 atishp@rivosinc.com, evan@rivosinc.com, cleger@rivosinc.com, 
 alexghiti@rivosinc.com, samitolvanen@google.com, broonie@kernel.org, 
 rick.p.edgecombe@intel.com
X-Mailer: b4 0.14.0

From: Clément Léger <cleger@rivosinc.com>

Add necessary SBI definitions to use the FWFT extension.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
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
2.34.1


