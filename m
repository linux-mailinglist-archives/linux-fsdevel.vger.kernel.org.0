Return-Path: <linux-fsdevel+bounces-64026-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DEB9BD6704
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 23:57:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8AA764F6716
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 21:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A894F309F13;
	Mon, 13 Oct 2025 21:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="M7S3UxZe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5552FDC4C
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Oct 2025 21:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760392569; cv=none; b=ggOd8HTeVBPdcYNIPIzrczQQ6bF3aa0Q4EVFlZmZ9CpmrTuupPKFhid6UQ0uzKA0Ktc5SabNxl1+wZcMU1bLSiyBvJGiwRBiE0Dn8xm+w0yJxVMdpYxcYui7FQveOOy6O94KSMdf+zJnN+M2c/i1pP2QzBBNxNLMScx62V3c4cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760392569; c=relaxed/simple;
	bh=kcKAh3qiYa6u+vavoC8VVP4XbgP0FdaLB3/LKiPnoo8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ds9Di0o5f/VWGbxxAnqMrSMFAyKgWHvD784dgxWaA8ZOUuxGeVMxe3CGwymAOZ30kUgwCvV9fvaZ6FaRC6D8j2GUl8bT0oESkGf8JMaShKkv5gYOxeHaK3hcTJDE+/jlic+sfWWMKwqBdhivxBUf+M2yyKYzvWpk2wKhmHVZXto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=M7S3UxZe; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-32eb76b9039so5992223a91.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Oct 2025 14:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1760392567; x=1760997367; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VM5DlrQCbRYqN6WQC0IO67CheqmNFMHVu1qXR64a+aw=;
        b=M7S3UxZe7hFGWfgNneqeQQbb09etUMsP1GAKYhIvdzV//Rof733krKGwOVdZsmTtd2
         g47wnUVzp4sPaERd4Gy6Y/ysVsWK0fJnVPlNoJn+c7zZ01LaM+EzF//1x7ZwS+cvwu6q
         OSKOg0oNEtqeVzrpTtb9n+v55GNxnadvdD6SJbJmrez2jfIGDuIrx44KliexoFulHIcP
         ycVfDnoARZqtY2lCpxmx/HB5+1SXtPsfXX5DCghuZXTTtT+ZvIhTtXhl0VpSp5Sbd7Ct
         38TTPTalT614s08JMJC6AVYdYfBPHrBJe+tKG93X3BwLkbHXZJG+2QOQE5QP/hvme/Y2
         dmPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760392567; x=1760997367;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VM5DlrQCbRYqN6WQC0IO67CheqmNFMHVu1qXR64a+aw=;
        b=RcILn+e0X21zgpmiCiDJVgME6rVBCXwIq/snBX1oyLMFQMosYEYCEOLmpsadhRIb8m
         UoIwvTpKiecV0iBvRYV0bBsVAEd6/z/llrlX4hcOXOjbITo9HbrIWaOL4cHQcVH+/4Ih
         CXmXy4+S6r5d0CHy6SXV6BzUrOPtbqxN0HyM1weObobSroiwwrA/cAuxTxwvfc4HQ/pl
         9JQlpBAbntKDzLUBuuw8YbLIGI22IS3RtJfEr7A3aI/Ojaz30sltJtBbrvQ8UaftmuHp
         9nD5iowRpuWrtnhJ7+ZdaFhjazgp739jR4A/Xh2edPFfraaWiKWCI7X6lqaIk7NfhxBO
         OG2w==
X-Forwarded-Encrypted: i=1; AJvYcCV+mPyrIiUUctMwCtLn/qW4XTDcdubCb5hkh5Fu6RfdYnVdvDGKQX4DLToAINhWxUgEu8VugZeMgoW4lq1C@vger.kernel.org
X-Gm-Message-State: AOJu0YweufSK8UsOKao+8tBPQg7Vjqd5KnqRG1EW+N4RdKsV32HDH7Hi
	cZsaX3D7VAigJ5GnAsIW6rI7inusM0Rviux1KqdQaShixSVC5jTJiBov/YPSMlm8dJo=
X-Gm-Gg: ASbGncthbyAFTwbuCsRc63GD0HVnrNe/ZkQmcOajo2s8AauurgQg+3i3pbpO1oNTKBO
	yA3U7judLpb8I3YQ+gY9uDIB7nPOEmUK+wYQPZ2KjjtRqntrt4Q8oFQbJ/MApBYmUUYYE4jmJ+C
	hOzss9CdGOwbkgcC55QTiuYzHQuuHGNv5qIc6alHFIa8vqCj57G0L4fCzeGQF8T4gC4z40+2PvX
	O7P0YJ2AzW/aLEagyN46UZmcPRYP3mkzZ0681hRn3dJKUtHlaR5ENiILZX1E59GzMHpHB9OLI+J
	bFndI0gRlbervee4uWeajiCULePsaGHk/ekj7S4LqqMEavSnyJx+VJ4ZKekUrVbyT0/fzLLVMj7
	l8NN47aWEzD5UKanYShdPgT2ybPLC5UyGOpLv9lOwsXjRBEEgk7E=
X-Google-Smtp-Source: AGHT+IEk8C0wXtpiaSerIOmMVJ34V19j3qCgt/dP0k/QOvSZF8SGdHByWOIwcunMLrrPAiMMdWB6bA==
X-Received: by 2002:a17:90b:1d85:b0:32b:623d:ee91 with SMTP id 98e67ed59e1d1-33b5138623dmr30507133a91.27.1760392566692;
        Mon, 13 Oct 2025 14:56:06 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b626bb49esm13143212a91.12.2025.10.13.14.56.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 14:56:06 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Mon, 13 Oct 2025 14:55:56 -0700
Subject: [PATCH v20 04/28] riscv: zicfiss / zicfilp extension csr and bit
 definitions
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251013-v5_user_cfi_series-v20-4-b9de4be9912e@rivosinc.com>
References: <20251013-v5_user_cfi_series-v20-0-b9de4be9912e@rivosinc.com>
In-Reply-To: <20251013-v5_user_cfi_series-v20-0-b9de4be9912e@rivosinc.com>
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
index 4a37a98398ad..78f573ab4c53 100644
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


