Return-Path: <linux-fsdevel+bounces-54723-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF68B0254C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 21:54:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCAAE5C5B59
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 19:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D698B2FEE27;
	Fri, 11 Jul 2025 19:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="ssygYxx+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F68B2F3C2E
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Jul 2025 19:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752263250; cv=none; b=M7di8jk0RZEeS8DMH3IfiKza/ZLQEOez0BjdY3vIPbjLnx3pFBfv/zYGiC8ZGXhWLCebbo+84DBuC66hZhE4c70jpxlnDSTzK2Z+nmmU3s+/B++GHeLbk4oAdj6xlkBpicO8ydadkTANlwqOSBgxbuIRPwcNKvztEukwi9dJW34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752263250; c=relaxed/simple;
	bh=2rH9NpqQOqhL1EJmZlhPfrwuNQdySdzYHbE8RFyVKvs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N3nJho9T6RPAKQ+9Y8S/r0vCw9b94D57Qf+ID9NnnxTLK0yr0VdSVNgZbZb9ddkxc/DfyXnpySFHOjC5J4S9r0BdwbUk4y/g25GGEPpKceDjGEnFnfRSZlS8HEGqMzDbu/EbrKcpM5KAkkhgHpOB/1ju6qoFXBKBaN+oVbPld+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=ssygYxx+; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7425bd5a83aso2190803b3a.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Jul 2025 12:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1752263247; x=1752868047; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zGYKU8oEStLMY+WKb4utGxIDZo++9HKS8iEvkqWqbZk=;
        b=ssygYxx+uoUHFcHd94dXl3KIVkW+p383rhfeyoU5xqs+wc9lWd4Hy2P2QKqton7k/m
         zB5qKRM6e8W2f4dyv+poisO43vVxh2ENf6QLu8atHhR81Ng22Omx6VvB1rmt0gli8iCY
         LlJlOkifmBz43bjXkwf+I+dTeiBJcfRXaFKNXbdU/N0nL26NTJmvFwMQd/qTynLzC1eq
         kkI6fIjcZ8ukT35aJXDZ7unkRsRuWYNw6YUB/NUiBVWSLnfZzsWvwULcFmJVaiAp7IN8
         Ahx0USUN8LMMYDuaQaQfcxgLRks/xQ633tF+UA1SgPxP+k6MihGEXiNWz/ryeZT8VX3p
         bqjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752263247; x=1752868047;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zGYKU8oEStLMY+WKb4utGxIDZo++9HKS8iEvkqWqbZk=;
        b=ku/ilHhiZmG3oDnLhD29e61ceCsfxAFR9ImlJH/7rdKS6EYPl5cm+6O/nC2owizWHw
         /Q6xYHVZ3r7mU2VBU4uvMhGHD8Rd3MvXGnQ6IZ43bIYYku4a1Zjs5ZuIhv8H6tgN67G1
         7csyuqBqYjap8BWyV8nqZVIic2lLZApCyd1yW4j/vv+Npp1SmIAlssiLe09SL/gIWRN1
         qNmHPZDIr/N7Wd9iL3UsKtNhZne7JfNu0MPRr2vjg388+XG8ALUDnspSIrgGWOySMlGw
         6VxAu+d7S7fKFU8OPCz88sUqYsgYo7kYU8z6jp1/NkopYQ7zXeXS/TM6IiISxtdVyGz8
         Nzag==
X-Forwarded-Encrypted: i=1; AJvYcCUfYQnfibc8Pl/zFdTVDZZDyKvZGAB3fIVCvDE1eEZtluycVxSjQ/6AddTR0O8sbX+szRAs/UzTYA49rXfe@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4zKV3gucqzFQSMQUepLiO3/SRefMcz6IAH/XwUwSO/F8lmcgI
	7WLOAcjXfSl12fH7p7OQDX0i1HIEtno4G4AY/V2qxZakot9EAy6VXq/9xQuKKsnm42s=
X-Gm-Gg: ASbGnculjQcd+m0+Fn1U+Jz5D/OgJB85O15dNrQIVfWDjBfpWAmBItFMBPwT02Sgiuc
	SEbK/FFbkm/5ePnDSbmxZMggUpmjuVtvPv2gyHEA7w/BoqcQKx1oZkxlCVMT75CJPe9l41zQiKX
	C2LIz8zRh0DYoDPDqwvkPTAUaKO665jQgYDeKg7L1X/AbUMtFEOOkSpXZABHoaiBbjprPu0NJd9
	4FnEyeOF+M2unHqN5ezopDbX2wnvaS/eNS+nLWoiQynb+OnX89mCo5THk7zfMqE+ujW8vXz06PZ
	xaeU+RdYI9yz7LT96XoFqueb8SAIel4KpmUgbUuLHWmWH10CMg1JQSOaavB5bkbaommLakLDnig
	P+SjLldN5B45Ixak9RDCxuKAQ8feh4XFk
X-Google-Smtp-Source: AGHT+IEsEqGjrDeW2X9G2yHiapVhyLhkS/QI4B1UlMQoQiVgeLmn2Nt1VUXQjuYKd+UB5h+FQa/Zuw==
X-Received: by 2002:a05:6a00:1994:b0:748:68dd:eb8c with SMTP id d2e1a72fcca58-74ee2d510ecmr5840604b3a.23.1752263247480;
        Fri, 11 Jul 2025 12:47:27 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9e06995sm5840977b3a.38.2025.07.11.12.47.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 12:47:27 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Fri, 11 Jul 2025 12:46:29 -0700
Subject: [PATCH v18 24/27] riscv: create a config for shadow stack and
 landing pad instr support
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250711-v5_user_cfi_series-v18-24-a8ee62f9f38e@rivosinc.com>
References: <20250711-v5_user_cfi_series-v18-0-a8ee62f9f38e@rivosinc.com>
In-Reply-To: <20250711-v5_user_cfi_series-v18-0-a8ee62f9f38e@rivosinc.com>
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
 Zong Li <zong.li@sifive.com>, Deepak Gupta <debug@rivosinc.com>
X-Mailer: b4 0.13.0

This patch creates a config for shadow stack support and landing pad instr
support. Shadow stack support and landing instr support can be enabled by
selecting `CONFIG_RISCV_USER_CFI`. Selecting `CONFIG_RISCV_USER_CFI` wires
up path to enumerate CPU support and if cpu support exists, kernel will
support cpu assisted user mode cfi.

If CONFIG_RISCV_USER_CFI is selected, select `ARCH_USES_HIGH_VMA_FLAGS`,
`ARCH_HAS_USER_SHADOW_STACK` and DYNAMIC_SIGFRAME for riscv.

Reviewed-by: Zong Li <zong.li@sifive.com>
Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 arch/riscv/Kconfig                  | 21 +++++++++++++++++++++
 arch/riscv/configs/hardening.config |  4 ++++
 2 files changed, 25 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 36061f4732b7..385c3d93e378 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -1161,6 +1161,27 @@ config RANDOMIZE_BASE
 
           If unsure, say N.
 
+config RISCV_USER_CFI
+	def_bool n
+	bool "riscv userspace control flow integrity"
+	depends on 64BIT && $(cc-option,-mabi=lp64 -march=rv64ima_zicfiss)
+	depends on RISCV_ALTERNATIVE
+	select RISCV_SBI
+	select ARCH_HAS_USER_SHADOW_STACK
+	select ARCH_USES_HIGH_VMA_FLAGS
+	select DYNAMIC_SIGFRAME
+	help
+	  Provides CPU assisted control flow integrity to userspace tasks.
+	  Control flow integrity is provided by implementing shadow stack for
+	  backward edge and indirect branch tracking for forward edge in program.
+	  Shadow stack protection is a hardware feature that detects function
+	  return address corruption. This helps mitigate ROP attacks.
+	  Indirect branch tracking enforces that all indirect branches must land
+	  on a landing pad instruction else CPU will fault. This mitigates against
+	  JOP / COP attacks. Applications must be enabled to use it, and old user-
+	  space does not get protection "for free".
+	  default n.
+
 endmenu # "Kernel features"
 
 menu "Boot options"
diff --git a/arch/riscv/configs/hardening.config b/arch/riscv/configs/hardening.config
new file mode 100644
index 000000000000..089f4cee82f4
--- /dev/null
+++ b/arch/riscv/configs/hardening.config
@@ -0,0 +1,4 @@
+# RISCV specific kernel hardening options
+
+# Enable control flow integrity support for usermode.
+CONFIG_RISCV_USER_CFI=y

-- 
2.43.0


