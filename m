Return-Path: <linux-fsdevel+bounces-47178-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C97DAA9A34A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 09:22:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68C993AD98A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 07:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEC9F1FCFF3;
	Thu, 24 Apr 2025 07:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="e0l06LJG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6351F75A9
	for <linux-fsdevel@vger.kernel.org>; Thu, 24 Apr 2025 07:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745479237; cv=none; b=BT5xaKZ3N+aI46xTt+hOZq+YpNxg0ZA8IpJAvbxdSvtkcAh5Foj40GrRWZ/v9uQtSQgaMCpHwQTP0JxboYI6JF7FANAwcrjjHczC1ptmmKrn69f/6yBHF5Z8tAgm3zgUuAbiGC5wRtlpvtIqK8qGY6RLN8sXW4jMD/hdDtw0QHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745479237; c=relaxed/simple;
	bh=ynTUDLBp2gEKhFeiYfxgOCPe6wht1rOzpyg0Vu3jGXs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XseDFr0Z2wZGt2YETW+lERwePyBa1HwGExQyUNbWhUE/LQBMAnG+Ln90Zw3T5KldH+y0xioAHgu1Oe5WieZLLcBO3lLvIGduruvVd9HLnHrIBGEB/tF5S/NuyzRtBQqKK/6KqDaRAnZuy43Vj8ashKjpOsVMlj22AEav+hint4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=e0l06LJG; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2240b4de12bso9624555ad.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Apr 2025 00:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1745479234; x=1746084034; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ome3u7rmCNb01KyjL0hHySpySbFvJDab/QcqkVOgxo4=;
        b=e0l06LJGjGYgqEs8930R24/vCj4c/+xFDgD6D9fm7Mc2uV9RevhZYL0wyKeYBUouzH
         HwVbSSx6geGhRL6RHOy9y6SWSIEtt8iEoM2LGtKQriBvCtf3+2QakHbadP6yfOhueI1h
         t1fT5WqXdcJ3591B+OOHmq8Mu+YO3t96JLkx3eDsRdmo9eUEv8xZzsuKSQMBZyUpM5VI
         VPs9IlOmYH8QIHqBVgprH3OC0bmwsK+Hl2hwON8Njbk2j+lu6YHn5kwVbyitIVIzKIOl
         A/6Sk6hPIbW5UPsLf2MyVpiyPqiywQUnpdqktr1fuBYCj7MyI5Z+wlj5sTL1nrfWp9ds
         VFwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745479234; x=1746084034;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ome3u7rmCNb01KyjL0hHySpySbFvJDab/QcqkVOgxo4=;
        b=eEfOLiMvHUjDiJpcK359w0z9AgLyVeCKoqFt81UheNRPjaT7aSFwK9qXFJrr8mk3Jh
         Q1K29rDfoS+MUgR8a3ntyTEGzbVlafl81JPXvVJq0cqujvShxS24ncp5UDfeY1AD9/JR
         m7R3KKW8fChO2qGl0gDhiwW8kMWdNDU7lfNEgdur0xJF4DgKYgxZJwqTryJWeUUMtSOA
         dV2/RKbeSkyRo5URGsmoR265l81582hjAEnYEP09v5k97L2hdqouL/BP28GLV52PqNLj
         PyrWxJTEvwJmaOWNXLUqOz180hCrcJia/Hn5ec1If0WCAARutHTLYyu5+94v0YF8Vvcr
         XRrg==
X-Forwarded-Encrypted: i=1; AJvYcCWj/ZrgtV3lXECyFcBnj9SYSS19osU82ssjs1a8uHmqA/3JisLjq1J0m0BATA/5YNxjL1HOPbPKvKEm1YYe@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3g9YzYSQUqWHfcX0C8hOskhM0ZBtSv0+Z27Ib2MMN3BPGY/Yq
	2nqCahrULn7DHA9IUyf9VjX64wfVUA9EmhYWwLO/8/q0CrW0f12jwUzmY3IyrsY=
X-Gm-Gg: ASbGnctWbQmvRELG3henZFBtQZbDRXbrhQu/R+yVkWS2JVy6+GVbjrm8kRJ8AD9V0ah
	ZFpGgW1py3Jspzo5/5K0eRcQf2SJh1aXJuvMYXEWJvlL8Qwf/NVDeJObd1W95rlMcT4dboSMR+X
	jKz0LLCFFeZdiEa1dwaVdUpVGhLodmHT9vuRwFBqQ0QGadxvkNtgTFQoTSut0345RyVQeK5N7ZU
	oFT+HGg5Hb6lnG7/baldD1CQPF3ZlR4I9k+SKP7p8l0ktR0WAB0XKux3tmLRDfLISFN9ZwOolU2
	rSumnpaoIDkFgm4hpk+uNGiG6vXfF8fT3/eWDfCQ/9E5vAFCg50=
X-Google-Smtp-Source: AGHT+IG7mvKQVsAWhJ67siR5HyXzPu+FGKMk0BZF9KiTPtDYxOR22o33eCLSKG+9Sr0e0wwJKYQf8g==
X-Received: by 2002:a17:903:2d0:b0:224:283f:a9ef with SMTP id d9443c01a7336-22db3ba02e2mr22559525ad.6.1745479234501;
        Thu, 24 Apr 2025 00:20:34 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db52163d6sm6240765ad.214.2025.04.24.00.20.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 00:20:34 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Thu, 24 Apr 2025 00:20:19 -0700
Subject: [PATCH v13 04/28] riscv: zicfiss / zicfilp extension csr and bit
 definitions
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250424-v5_user_cfi_series-v13-4-971437de586a@rivosinc.com>
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
 Deepak Gupta <debug@rivosinc.com>
X-Mailer: b4 0.13.0

zicfiss and zicfilp extension gets enabled via b3 and b2 in *envcfg CSR.
menvcfg controls enabling for S/HS mode. henvcfg control enabling for VS
while senvcfg controls enabling for U/VU mode.

zicfilp extension extends *status CSR to hold `expected landing pad` bit.
A trap or interrupt can occur between an indirect jmp/call and target
instr. `expected landing pad` bit from CPU is recorded into xstatus CSR so
that when supervisor performs xret, `expected landing pad` state of CPU can
be restored.

zicfiss adds one new CSR
- CSR_SSP: CSR_SSP contains current shadow stack pointer.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>
---
 arch/riscv/include/asm/csr.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
index 6fed42e37705..2f49b9663640 100644
--- a/arch/riscv/include/asm/csr.h
+++ b/arch/riscv/include/asm/csr.h
@@ -18,6 +18,15 @@
 #define SR_MPP		_AC(0x00001800, UL) /* Previously Machine */
 #define SR_SUM		_AC(0x00040000, UL) /* Supervisor User Memory Access */
 
+/* zicfilp landing pad status bit */
+#define SR_SPELP	_AC(0x00800000, UL)
+#define SR_MPELP	_AC(0x020000000000, UL)
+#ifdef CONFIG_RISCV_M_MODE
+#define SR_ELP		SR_MPELP
+#else
+#define SR_ELP		SR_SPELP
+#endif
+
 #define SR_FS		_AC(0x00006000, UL) /* Floating-point Status */
 #define SR_FS_OFF	_AC(0x00000000, UL)
 #define SR_FS_INITIAL	_AC(0x00002000, UL)
@@ -212,6 +221,8 @@
 #define ENVCFG_PMM_PMLEN_16		(_AC(0x3, ULL) << 32)
 #define ENVCFG_CBZE			(_AC(1, UL) << 7)
 #define ENVCFG_CBCFE			(_AC(1, UL) << 6)
+#define ENVCFG_LPE			(_AC(1, UL) << 2)
+#define ENVCFG_SSE			(_AC(1, UL) << 3)
 #define ENVCFG_CBIE_SHIFT		4
 #define ENVCFG_CBIE			(_AC(0x3, UL) << ENVCFG_CBIE_SHIFT)
 #define ENVCFG_CBIE_ILL			_AC(0x0, UL)
@@ -230,6 +241,11 @@
 #define SMSTATEEN0_HSENVCFG		(_ULL(1) << SMSTATEEN0_HSENVCFG_SHIFT)
 #define SMSTATEEN0_SSTATEEN0_SHIFT	63
 #define SMSTATEEN0_SSTATEEN0		(_ULL(1) << SMSTATEEN0_SSTATEEN0_SHIFT)
+/*
+ * zicfiss user mode csr
+ * CSR_SSP holds current shadow stack pointer.
+ */
+#define CSR_SSP                 0x011
 
 /* mseccfg bits */
 #define MSECCFG_PMM			ENVCFG_PMM

-- 
2.43.0


