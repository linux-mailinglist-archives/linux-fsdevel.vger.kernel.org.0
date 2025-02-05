Return-Path: <linux-fsdevel+bounces-40886-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39687A28124
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 02:28:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCA9918839B2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 01:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F18D022F15D;
	Wed,  5 Feb 2025 01:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="ekf0P+CH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D730A22F158
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Feb 2025 01:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738718555; cv=none; b=TUDMzpBY2s29vvILgwAZg0kf2T+dAV+7Yp1UtZvbydl+oUQuEyZkuAghOyg6xg7aIz+GVWKLFV37wIm5EJP0OCyfS5kp5b8+UfF2JsuOzfdh6peC9fIaBBrJcStiFRxJTuyFHxtWXBkld0BHPNgbRFQfjBcywAKgkRuOs78OrIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738718555; c=relaxed/simple;
	bh=lD6rgHPb/ib2WH9dder9ZLKtBlS2SotatDP0DK7YItE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CRuSVxT+lAlv3FCXc8+Ha1iDTbRWgFf6gp692mqJ/0QIo8FvM6Vj63u06ingMxNNZvhbikxXZcBO0Yrn7AdLniNR5SLTaKmiAiaHPD+r22w0LD0/4fERBFWNR1TCuZgOmkcYLSuIt5V/52iiT0+JnikaVMMea2JH86vpAyt4aUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=ekf0P+CH; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-21ddab8800bso88860265ad.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Feb 2025 17:22:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1738718552; x=1739323352; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a5uI84SXblQRDID2BHNWhhHsRc7xVUDdoiei4kS9c/0=;
        b=ekf0P+CHlRFc2j4jMgY/9lZwxhTPQVrMUSz/Cb8Fps/2R2HH3I8h/IyuZTp+T5c7Kv
         zf1O7K239Y/JmWfEDY59kCSCeIKjRZviKnX9vFyw2KCQWzqoLJFbA5eKzKnIi416WcZ0
         N5CYD3jEkxvnjW0zpGeBxYKotkK54bkqcdhsbBxKr1OnN8A2ddkkQjLmfLEAUGqore7S
         eNr9z9zsWoExP4bS6UmlJlzIkFoQQ+Nywo0IOfUD/qhukv+CiTo8TIBEnoUN0xtessXy
         AEdec9TSsfUcNo8yf+/X+KDQIlUAJHbbjLvt84FNCL0c/IxZxRZxnhzs2nrTgq9WwZCz
         7YXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738718552; x=1739323352;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a5uI84SXblQRDID2BHNWhhHsRc7xVUDdoiei4kS9c/0=;
        b=g0/NP9G7dxkbJ+fAgh0uI88nhNF09BoF97WP7VgmK3PTXhfUwrRg2guCUraawXNZjK
         J3BYTcbelML2RG9hyyNLJfzReQUqhe5TNctbor7+1p4DNhGK4D1SH9S9JXv76Fflb3I8
         zmc/vmynusNieQi7vdwz16zFJvLej23RsvdLWlugYgfn5OVdyKyrIBhEwOOd9OPbjtJi
         DmV2XeTFXj4oJ8WYPgia5blUevZ0BQjbPC+uXqnhLIexGydY13hZco152F/6ka9zSVB/
         m3JDXb65S1H/ct/uXaSt403rVy8Znn2vTpWO4qJHs4m7B9ini65Dt13biB0PdWnOV5HT
         YI8g==
X-Forwarded-Encrypted: i=1; AJvYcCWU742yc8855Hr/Cj86eY02rVNMmhDIjO1dfdPYnMXh87LXhn63IB5YYjJKm6vvOA/vE8Ux0zV21aDTHY6h@vger.kernel.org
X-Gm-Message-State: AOJu0YyfYdBD+6ln5aRKCbQeozUyMO1xZq/ZnJl4b+Gvd/elJIVM/Sma
	8FTlVo/VGAG9FQuMOPzd022BNONLE3GP+8EY+nQHcDJ4Tl2pql2/9Ck7ZV5d22g=
X-Gm-Gg: ASbGncuh4BB9TBtifTBQwEBvzL8uhTT6AghgGS+lxK2C25ne9XmM7icgWuxZA6cO5bF
	QgCu1BtQGqQQYdCdKWyBODrhGaJ/3xfwTxomgoPxJqf/2sKVCE2kh1Kkir394Gh+IrxPDNsmA2O
	fIxmBUzYWGxpUAKtkejR1mVouLibdD2uBR1dvcY6jFFBOCOgAF93/PbJeSSvK7klHDS3JK3TPNt
	fnLs/gaxr+R1rZXFCjWHdV/e40F297RTMXAUYNPKQyKmLkGs9n2yWfEoAl67iQ2ctZrFFwyCU+o
	5DtKXRjX9aRUxb8ewDZBMUWK6Q==
X-Google-Smtp-Source: AGHT+IFCF6Qyo3q2G3dGEoXnovMcbEOll06APDlJ/baKR1lUf1tJ5kFaxAt+4U15uatvwIepGIzY3g==
X-Received: by 2002:a05:6a21:6da4:b0:1d9:2705:699e with SMTP id adf61e73a8af0-1ede88106d4mr1669830637.7.1738718552107;
        Tue, 04 Feb 2025 17:22:32 -0800 (PST)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72fe69cec0fsm11457202b3a.137.2025.02.04.17.22.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 17:22:31 -0800 (PST)
From: Deepak Gupta <debug@rivosinc.com>
Date: Tue, 04 Feb 2025 17:22:07 -0800
Subject: [PATCH v9 20/26] riscv: Add Firmware Feature SBI extensions
 definitions
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250204-v5_user_cfi_series-v9-20-b37a49c5205c@rivosinc.com>
References: <20250204-v5_user_cfi_series-v9-0-b37a49c5205c@rivosinc.com>
In-Reply-To: <20250204-v5_user_cfi_series-v9-0-b37a49c5205c@rivosinc.com>
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


