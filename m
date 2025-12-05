Return-Path: <linux-fsdevel+bounces-70856-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A5DF9CA8DAB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 05 Dec 2025 19:45:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1E70D30EC75A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Dec 2025 18:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A04734B682;
	Fri,  5 Dec 2025 18:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="OdGPP9gv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB97734A3DF
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Dec 2025 18:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764959823; cv=none; b=TAdGj/svrjBA6aYx4IC+iqbu/gZun+GWEOrRnk++KJz5k1h2/u8NKTCku/GYM0Mbfm1oi/0VcHdy01Z3LfZRhujKZQSQIXziIzAo3mkqd7dlpQoVCB/UjQIMpnYseDeoI5sLGEndR1AWSqNABsCTsmOIE8j7n+lzxDpm0fg0B7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764959823; c=relaxed/simple;
	bh=n7bR1NnVFI/AqRJ5DRrpGqIuuKL5t/EAGbECncFah4k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cnX+nSoILQcNOCwNys4/loMY4K9TclKBEQ0t8RQKpsfcv+7uz4cwB2y6gQ1d6zSTjwnWSYmMvVRjDK8hXaiaEF88gvhOwiexkIXi8aN0UWVgrIeof0qgInmcy2l/FqVPAFIlHd1dAjJA2tyjTDbVYY1bBqj96vG/9T7lZUjxpTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=OdGPP9gv; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-bddba676613so1617620a12.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Dec 2025 10:36:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1764959819; x=1765564619; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cETj36wQ9Li8D++iY1PBxUMbJIR6wBVZ7mUW8zqZ2ak=;
        b=OdGPP9gvMqICkHUNxjestrW16p8dgTnCgBtRmRY5Q1AZCcE0lvQgCKlmbRzkXJzCjt
         XE08kZYI+ycosead7s8QVubf289JEBL3DvCmcs+8T4i3AAgS0zRxdFQqeHQWMYIl65Tq
         c38Ac8mYiCcmhsYqnMn5z0EVJdgtKHenDqxXGMoAU+AyECVzDWYD/5N3JILx1MdSaHHy
         R11+C2yiaFh7tMYQd8KwaumQcsTjulOVHmYa30bIFQDZZ2gL8aqUWTAh/JBMLLnEyfia
         Ufv4ua2jME1UsuSmRUeXfehkWnAWEfQvFx82ccbO9GuSro+Uwd3958JS2z+ZKSFflM7N
         Dk6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764959819; x=1765564619;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cETj36wQ9Li8D++iY1PBxUMbJIR6wBVZ7mUW8zqZ2ak=;
        b=iShvIif3sCDpIqcjIDvyq9ahtVgF5Kcc1BAigHx6cj/oWn6f54OK/69MJCCnxsTYIs
         Dct4fX3Aof6MJKavqOdGlzTBR0gRVw8zZe6UhgDybZ2/HM9+UhMwtzD43Nmp0fDQVlJw
         Jcnd6scHKrOc90JIIFPXQU3g4BMqN2kssTPbqXGBlonjWOdpNgHTqz41j6qc7IABYXC3
         12I2GPJuUNzk2K5Y2uHhjMQAY8zB5iCo7DHHvz+E+JulGVl0ExmSUpeSCz2dnX1XZd+6
         aRlNmlqZmfqL7SjI+eLKqyMwODJYafeeyqQvJDQvN+DB8twvzkR0VEDeSfXxfzoNqgN4
         skSQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9PulKIAT0s1uVRktbgV2UL91uxFq9ynfmGmln2o1m92eMGXwv/h8XcCWN0Q7JoUEkdNVAGt8usDne97mA@vger.kernel.org
X-Gm-Message-State: AOJu0YwfNfCxsUkWYXE+ohDu7zK5pUvM5GIPkBJEQma1u8m4zX9ytTJd
	2sI6sCQbku+Jm8p5D0bpPQnK0A3JGUSq+HZ6390I9rZafRrYP9gkW3iePalGw3LFXc4=
X-Gm-Gg: ASbGncsthxs9Zm4Ats+V2h8j5tSWrR+i3Blx2+G+jb7FQ1nvGdZ2i3G/5HtOwaki39N
	V5dVJIRejfS1bhQu5cV8JejHGMMeLx33TekMrznx/jk8BXAMWjlRFcdg7dGkDOoFZjjBKqwFtH7
	/CYss0wEpmeHJ2Twu4l1gMCu8MvfdGlVAXEGAvDWhWilJcSypwOcIV5Jp5oOf563gPZT4ukoFUn
	ncvR8uqK9A4/PhJc9ZE3FMSJIn2x72LdgQaHi+2NQF5knGfvnl0wTpijp4HTmEDDSXcAuo2taKI
	QiQDNrGWWbvIze3/EzU15z1KuBdwJhCp38CILtjkKtkIWp3svu0f8fVFZDkZW73WLtT+dQz8s+A
	USNlC0BMPtHqS9LEW7qvQr1yHE9SRLbq2t4pwfh6Cwvdioo94s3G4wrUnUDSVZzLTY2FzCYPXe9
	gwKB0SeKBz36LhZm6S4fs1
X-Google-Smtp-Source: AGHT+IEkzbnT/WgOlempvP3hpilfiz+Q71aHJSWUM26fnmV95b/U/OPvqEShn/bm1V+eS1bH7ZJBNQ==
X-Received: by 2002:a05:7301:7389:b0:2a4:6488:7a91 with SMTP id 5a478bee46e88-2abc721e3aemr63588eec.37.1764959818484;
        Fri, 05 Dec 2025 10:36:58 -0800 (PST)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2aba8395d99sm23933342eec.1.2025.12.05.10.36.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Dec 2025 10:36:57 -0800 (PST)
From: Deepak Gupta <debug@rivosinc.com>
Date: Fri, 05 Dec 2025 10:36:50 -0800
Subject: [PATCH v25 04/28] riscv: zicfiss / zicfilp extension csr and bit
 definitions
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251205-v5_user_cfi_series-v25-4-8a3570c3e145@rivosinc.com>
References: <20251205-v5_user_cfi_series-v25-0-8a3570c3e145@rivosinc.com>
In-Reply-To: <20251205-v5_user_cfi_series-v25-0-8a3570c3e145@rivosinc.com>
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
 Andreas Korb <andreas.korb@aisec.fraunhofer.de>, 
 Valentin Haudiquet <valentin.haudiquet@canonical.com>, 
 Deepak Gupta <debug@rivosinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764959808; l=2422;
 i=debug@rivosinc.com; s=20251023; h=from:subject:message-id;
 bh=n7bR1NnVFI/AqRJ5DRrpGqIuuKL5t/EAGbECncFah4k=;
 b=31A6j7PC6Y5du6FtyG1Tip5TQTReoqkkZmO7mrZz/KN+VapztQ/ClG5jXhF8oJEHAJfpgvSh7
 Wdgdq2HWZ/wBlxT7xVvM72WWT8CT9lmclkSWtwU4fMwFZ3NA1iNoLlQ
X-Developer-Key: i=debug@rivosinc.com; a=ed25519;
 pk=O37GQv1thBhZToXyQKdecPDhtWVbEDRQ0RIndijvpjk=

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

Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>
Tested-by: Andreas Korb <andreas.korb@aisec.fraunhofer.de>
Tested-by: Valentin Haudiquet <valentin.haudiquet@canonical.com>
Signed-off-by: Deepak Gupta <debug@rivosinc.com>
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
2.45.0


