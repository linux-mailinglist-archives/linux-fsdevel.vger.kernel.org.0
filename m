Return-Path: <linux-fsdevel+bounces-34320-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C4EA09C481F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 22:33:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03FFCB21C23
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 21:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC6D61E0B96;
	Mon, 11 Nov 2024 20:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="NGPyZW9p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5CB81D63F2
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2024 20:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731358499; cv=none; b=EUt49KOKpnAGu8Yc14yKcoj+rcpwpn/SmUPet30kmzQQQNzd/uWbWBTUr1TL+yRIzG7VJNtspBWyiyRlTlB786iHC8go29pb7yyG19+Z6kwuOCoBp7O3ee2m7OCBL8YK/Mm6ZoWr+yYLUe0RyJ24J0VBdpd8hmwppY8Hdfc7nvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731358499; c=relaxed/simple;
	bh=wYCEI7wvSMLui8WMRpDFv0a+NDWckEqPGqXUbhFxHHQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LwOwdCf4W3As5QvsxXGGI8DmwaMWd7eDljlVf8D9W3pb3cV4WmjE1unl/IC0C292E1mYogDl8cGSE10JKXKWSBKQ049zlUru4IW57pBt0aC/F8R8RAfdwUZtFzwifAF4tiK2noYTiSgT2LUV5BMR47g+cYFZyqAtTorU6x0urds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=NGPyZW9p; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2e2e23f2931so3969660a91.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2024 12:54:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1731358497; x=1731963297; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hq3DaQ4YpzTwJN9yZW6Sl3gPyL1m035+b/05XFtk9T8=;
        b=NGPyZW9pLPhC9nXjvoY7+iCDi7hEEe7Aq4Q1nnrUeilw8TGv/tUAoXjNfpMjejLsFU
         rXwibYB2aPGCSbhjOFtGcyIzSPw8KpaZp7MaIFpIsnG83mCS7FgWWKnXDvKvISuwy+xF
         MSAreHKMqyBbzXP6NLnjNwf8VMMkHbgFyUvtOc2ZuNX8wrMDx90l3114cIV2S1iyb8bR
         pO99P4WTmS/rhknkCCg/CtDnD1uKMpn6ddlASHZyI1IpA3olgS8hbbcPbBjpWo1sMG8/
         bgrvwH6+8zfRnXewf0+PEHPJHbOIdpFohrZdBcGjgWvCWvkhVc8YSyurqllWi2SDD+Ee
         BbvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731358497; x=1731963297;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hq3DaQ4YpzTwJN9yZW6Sl3gPyL1m035+b/05XFtk9T8=;
        b=xB95M4YvtmonqOBAfA3zPElwUw661JUWxdwfY+p8GXW0oczlO63mQkvy1OTqah+1dz
         gwce9g6GMeiWJRqXSDZ3PuuVVcastI/g92kM5Mra2+8f8Ovb04K/01J3eWSsq92XyKQe
         +YQ1lpBoZfqhXycnGTwn7HWPW7GSKX6vsgq+jmHTLo6+vvt0xC3rYh08QA0pfUVKSxU1
         SQcAZnO2HC2pXXms3Co5R1SK+6ioV+aTd09KPvYzQL9vfuxaqyieEv+4tP5ZqyI8e7eX
         XxzpqUVwbGBoGGnL5rVZDVcCqPhvAbbfWR3YpWEmkXGb+RolFPgRqTU6knydpQOhBi0Z
         ozFw==
X-Forwarded-Encrypted: i=1; AJvYcCWaqpNrmllmdUGvWfHwUvN1Tdzbp2/98ZElS/TdlZlr4KBTYfLt+EMPhwnI3JVzYKdjDgvmfwb2LQcaZlAE@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8C4QCjpqok2zuLJeiSQcCLEIT1pO7SE6fmFuryzboTW7J4sfd
	8+SEDYE7tCqi8jl+bMtuphrDmaz3i5QAc4Mjo/o+BOT4fgz+crhusjOnnR0mU84=
X-Google-Smtp-Source: AGHT+IEEKaEBcK4MgBqd/tJtgjOiUzsMic6zpl+RlG/WSuE/W94Zyl8KoJt+g6fHJT4sQqdqWl8Dag==
X-Received: by 2002:a17:90a:d88d:b0:2cb:5aaf:c12e with SMTP id 98e67ed59e1d1-2e9b1788b6amr17044135a91.37.1731358497234;
        Mon, 11 Nov 2024 12:54:57 -0800 (PST)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e9a5fd1534sm9059974a91.42.2024.11.11.12.54.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 12:54:56 -0800 (PST)
From: Deepak Gupta <debug@rivosinc.com>
Date: Mon, 11 Nov 2024 12:54:08 -0800
Subject: [PATCH v8 23/29] riscv: Add Firmware Feature SBI extensions
 definitions
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241111-v5_user_cfi_series-v8-23-dce14aa30207@rivosinc.com>
References: <20241111-v5_user_cfi_series-v8-0-dce14aa30207@rivosinc.com>
In-Reply-To: <20241111-v5_user_cfi_series-v8-0-dce14aa30207@rivosinc.com>
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
 rick.p.edgecombe@intel.com
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


