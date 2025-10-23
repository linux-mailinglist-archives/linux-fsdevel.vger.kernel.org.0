Return-Path: <linux-fsdevel+bounces-65316-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF39C01647
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 15:29:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 486C719A0038
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 13:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AA8132B98E;
	Thu, 23 Oct 2025 13:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="VgfPjWwC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F22E3233F4
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Oct 2025 13:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761225949; cv=none; b=E92/UbeidIBf6GD6kk5aAN5IYqTAUoSKlF5d9JodllI9PQ93CWfAB312xNwlZV9+M+nvyq6N9E6YBIMigtTsjOJf0KX5GwSo39iBQX1RPRlbu1DExugY6lRc0LeKVg8bLHglAOXtB7rNJzw/qYLkbdEl6iALrtDZu0BeFOV17Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761225949; c=relaxed/simple;
	bh=kcKAh3qiYa6u+vavoC8VVP4XbgP0FdaLB3/LKiPnoo8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QlLH9QVZyIyrJhMu+plFA3zCB9JvZOqkGtUQbsJZ/KZmIBKYS21FoOp/M8psSg874TE95kKcXXoyhd8/GmFWhj+LQYRNKyteoxGZDs7yrIU1URqOpMtJnHDB7GTuho7jQKK6qSTuIbp1vX8g91AsGAqj4vXRLW1MTRmbsGFGJlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=VgfPjWwC; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-28a5b8b12a1so8351355ad.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Oct 2025 06:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1761225945; x=1761830745; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VM5DlrQCbRYqN6WQC0IO67CheqmNFMHVu1qXR64a+aw=;
        b=VgfPjWwCoWA5PqEl6Lqc+gy38UGSzEaV2xrm9WRqT2ck0Em9QQKq9E32nrwPCK0Uaw
         NC5L8s3ua0BbIcE42bl3sqqaEpiYmzOwJoJsQR8+oMimBm+4tiIiWlS0M8Wjh/WKzw/q
         cvinAHVyE9dpbduFzw8tvLYqZrp7d72z7nyefpgt8Or5kATkY7eJd9T1W5QMh/Pprkhi
         2pNS2//NpNbWWbdBzUhTjoRJVpO4az6yrzHxcg2hNEngy9HmSaOLW45GTQfddQtFwNpG
         EQkolhJ6ihrX9KkbBcP+e5yki32ASDpwYSltbYt7xsKuc6GEQKqNcPFmbOgK4tFxWE/L
         UnRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761225945; x=1761830745;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VM5DlrQCbRYqN6WQC0IO67CheqmNFMHVu1qXR64a+aw=;
        b=xFbQdZAGq5pVDKcQOFDXsR7HBLUdg8dpNPbW92gJpM/4OZbz9SFUcRTzGosU0pve+t
         cBSvFAgqsrrhdse52Csa/27rR2ZdzP/pWsEYINvHLPCfivLI+0sCk9vMdy1kzCIycmlY
         Opc0HCuSGavPb+RSI4EQNJBEo1srMnX6VqDzmnMLe+Tpvq0NMGVPNCh9v7CO5+4NL8O4
         5ZUZmz+BBf2Fgqo8l5bZM2+BP506U0R4ppIQ+y3WQlvW0Cp6Lk8GTQtmefMCDsIh6AcO
         KZbStA8Cy/5jNRhVD1c1Bbt17+sP0w/Q3DFlgY06nl4l/90dNuZeDpQcyeWOOHBGq1P7
         iCCg==
X-Forwarded-Encrypted: i=1; AJvYcCXultrGHdp2KDC+uEdE98Sy93e3mNZQ2NU6dtlmln1a03jOAhefKUZRUmd+W/E0/mJO1C3Xr2Q/ywv37r0L@vger.kernel.org
X-Gm-Message-State: AOJu0YyUeDcfEm2qRGP4O83KSLahbbJeAzUJQCPnTnFoE3BJuaeTjUyb
	KCRFJ1HtJhrEKHOHTp/l9VUjGiQoyRoPSg3ZxaJs7ts+bwg87IsHRcN+X+wX2HE+Ix8=
X-Gm-Gg: ASbGncuvKFu4605UZaXAzI3JuR/0oQe90nJHwa0zD+dKhyolevh4FBw3bNVcK0w6byk
	GiOV6K8mIawJMk6bIVl6pDu+OALhk/DRzRRN2xKUb1HVsoqwfQsUZwJfTuj40259m6/x6UDjrSQ
	7+/0Pp+2M8q7MzpiowyGH8iiBXHqsZk3QBnQJNCitegDQCaKYINfjNsg2in8WbdiidGZ957WeVL
	+OIF5dAkM2GIc0P0YkWKHiEKJ70Y6o/PgHGsjJxsMY5KVzhWwRtPIfoWAwJv/YPa9YrhdmJljW4
	k81j9vMZdhipWlRSrkK1ylGSH1y5MqXq+ohPJqrGUdRR/AKEK2qin3iOucvpBAyJoWmU2dsN4uG
	qK0K8dBdWz+7v+g6u0MG0eO03k+0o/Uv8XFbHfiMu+9dHZ+x79vKLphQNsnvUNWPhh2IVm0xkSW
	xxi4W/GH7eUQy7VAZzc61m
X-Google-Smtp-Source: AGHT+IEy3qLITcuChtDM79cXlP4i162rfKSR20rjSZYhE6w88AMJ5HcNN3dCkLwwo8KQPtiBjUNHgw==
X-Received: by 2002:a17:902:e88e:b0:27e:f018:d312 with SMTP id d9443c01a7336-290c9cf350amr320485415ad.1.1761225945527;
        Thu, 23 Oct 2025 06:25:45 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946e23e4b3sm23432035ad.103.2025.10.23.06.25.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 06:25:45 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Thu, 23 Oct 2025 06:25:33 -0700
Subject: [PATCH v22 04/28] riscv: zicfiss / zicfilp extension csr and bit
 definitions
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251023-v5_user_cfi_series-v22-4-1d53ce35d8fd@rivosinc.com>
References: <20251023-v5_user_cfi_series-v22-0-1d53ce35d8fd@rivosinc.com>
In-Reply-To: <20251023-v5_user_cfi_series-v22-0-1d53ce35d8fd@rivosinc.com>
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


