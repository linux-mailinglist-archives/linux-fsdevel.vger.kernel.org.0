Return-Path: <linux-fsdevel+bounces-30547-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAA1398C2F0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 18:16:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14DF8286CC1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 16:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAB811D0977;
	Tue,  1 Oct 2024 16:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="KcplkNX+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C191D07B6
	for <linux-fsdevel@vger.kernel.org>; Tue,  1 Oct 2024 16:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727798894; cv=none; b=NngbenzcKWGXa26PcFpLkgXmDhy/MR/09YAF0zuNwEkmR/cwJf9Fe1qH8L9th/Ce7L+uWo1fS0ohAvUdWwlUcEXfdyieIOz8aGVsaOts2w3EhMwvJy6OzzdHZjYtVXlID7RJ6NPJuswMEMAvSHA3w3QwSrirJbvWWujf8FSw5xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727798894; c=relaxed/simple;
	bh=wYCEI7wvSMLui8WMRpDFv0a+NDWckEqPGqXUbhFxHHQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ASlgw09948OWpn+T2b256shc5u+OK62A8kYxZpEovuheSjpCaWoki4M6zefUV44h/X7eLI6ze/o9+otBkks7AVGx2OXPRt7hU1Zgh808TTWaHWPyc5dENitZguLmVPI6SfFxkRMwpyfwrJnNUpBF1DZSyrfaHbBiDf/pxsBYrL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=KcplkNX+; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20b7259be6fso29606355ad.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 01 Oct 2024 09:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1727798892; x=1728403692; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hq3DaQ4YpzTwJN9yZW6Sl3gPyL1m035+b/05XFtk9T8=;
        b=KcplkNX+kxQXQI3wWhzz/NMJNzQ0B40n4vnLG9Vkr1h6cFYw2Hnr83Yeo+jAMU2qw2
         WQ7kz8oM37O+Vx1N4xZMn0UwarJBIhAnmAeNrLW+ra9QmpsSixuoz9XwJ1j9FvKbTEny
         m7aUkAXVgfd6p8xcfy3pfJSQU2DxTeUbsAYn9Je7clwiyaVOTWTVoMZoy1JCxyXtr9FG
         O2q3X6oNY9fXIDiR2tMHavEDBRC/KmwfiFFoEbdVVRKmtWhBGaZWMjmRThs3YZos5v+1
         MijRWcW6XS6O+8wVrkQEKCfILWPbVnDX7s8/M2uyCJsqmnfW49qLyJqBJTlK4ipPdfSU
         7ezQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727798892; x=1728403692;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hq3DaQ4YpzTwJN9yZW6Sl3gPyL1m035+b/05XFtk9T8=;
        b=TFhxO4mLt9RvShvYwnawhnnQNGpwSwILPsHrDyq2wN7YEv7EEM0NMLwoBTL4W/qc3q
         E2JI2KL6ZevLsAggP3EftShukJMebpFLfKLJvhQpABxdM54lpOH3o5/RPxp6oRaruxOR
         G6YOcQuEMCHiGsR9NdCpk7TaZVeWUe1pEG0ArhiXvtYqUdjkZNXOVb5SEad+Y3YjRDs3
         glLWBvq3wuHvNyV3faAfyx9+iaAlYwjhJT+yeLLOKiGo+6k266xr3HkB4rLJsywUqea8
         8oxt7yCoGD3nUzJvwqbLOr00tmLoxyKWgcatUk0A7AOkVVt8gNIpUUapaFrTlbVraCOV
         Braw==
X-Forwarded-Encrypted: i=1; AJvYcCUrnrqf7a8a1E9GHfQhBioAzTI3aYrEgnBfZTORS9gops0v8C+Tgj1iOomWcqBLOg2QFXuivTuEZUJ9EJRP@vger.kernel.org
X-Gm-Message-State: AOJu0YyQjoZSq1bQ73c8NTIMI5LiF1P4usbtTnfqLueDYkSCMGfrjY4J
	/aP8++UzjSMnsBFtONHh+hkY1fZb4YjLdtLwQ8/bEBLtQbwTiBd0HMqP2fXurv4=
X-Google-Smtp-Source: AGHT+IE1mC9nGVWp9Ep/VDB2JSrhkpX0Jq7sG4mPQqlp/n+0JH5ZZvXoSkfUlTtqgO8CiZuzgQPUOQ==
X-Received: by 2002:a17:90b:264e:b0:2d8:82da:2627 with SMTP id 98e67ed59e1d1-2e1848f671bmr199013a91.27.1727798892044;
        Tue, 01 Oct 2024 09:08:12 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e06e1d7d47sm13843973a91.28.2024.10.01.09.08.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 09:08:11 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Tue, 01 Oct 2024 09:06:32 -0700
Subject: [PATCH 27/33] riscv: Add Firmware Feature SBI extensions
 definitions
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241001-v5_user_cfi_series-v1-27-3ba65b6e550f@rivosinc.com>
References: <20241001-v5_user_cfi_series-v1-0-3ba65b6e550f@rivosinc.com>
In-Reply-To: <20241001-v5_user_cfi_series-v1-0-3ba65b6e550f@rivosinc.com>
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
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-mm@kvack.org, linux-riscv@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 alistair.francis@wdc.com, richard.henderson@linaro.org, jim.shu@sifive.com, 
 andybnac@gmail.com, kito.cheng@sifive.com, charlie@rivosinc.com, 
 atishp@rivosinc.com, evan@rivosinc.com, cleger@rivosinc.com, 
 alexghiti@rivosinc.com, samitolvanen@google.com, broonie@kernel.org, 
 rick.p.edgecombe@intel.com, Deepak Gupta <debug@rivosinc.com>
X-Mailer: b4 0.14.0

From: Clément Léger <cleger@rivosinc.com>

Add necessary SBI definitions to use the FWFT extension.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
---
 arch/riscv/include/asm/sbi.h | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index 98f631b051db..754e5cdabf46 100644
--- a/arch/riscv/include/asm/sbi.h
+++ b/arch/riscv/include/asm/sbi.h
@@ -34,6 +34,7 @@ enum sbi_ext_id {
 	SBI_EXT_PMU = 0x504D55,
 	SBI_EXT_DBCN = 0x4442434E,
 	SBI_EXT_STA = 0x535441,
+	SBI_EXT_FWFT = 0x46574654,
 
 	/* Experimentals extensions must lie within this range */
 	SBI_EXT_EXPERIMENTAL_START = 0x08000000,
@@ -281,6 +282,32 @@ struct sbi_sta_struct {
 
 #define SBI_SHMEM_DISABLE		-1
 
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
+
 /* SBI spec version fields */
 #define SBI_SPEC_VERSION_DEFAULT	0x1
 #define SBI_SPEC_VERSION_MAJOR_SHIFT	24

-- 
2.45.0


