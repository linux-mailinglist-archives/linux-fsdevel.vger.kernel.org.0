Return-Path: <linux-fsdevel+bounces-34323-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 608A39C47A0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 22:06:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FC282822E7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 21:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70A551E6325;
	Mon, 11 Nov 2024 20:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="XbL4crMS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF6F1E3DC9
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2024 20:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731358507; cv=none; b=QrwXgaVBOTVT8qmjWlCxa2ddhd6Sgk1+Hco2M1EqbgRZ51u/m1bvOHhj3FVX5ZoT5erJmLbIXIpGFvwKoSCmpPrVd4wm9Pf8V6vnltuAaLAn0GkfWgWojr0rJA9fMM3YjvR286HK2ud2PHF5bgxoOlTlma+5agHqYZecZFS+DrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731358507; c=relaxed/simple;
	bh=5EJK+m/wGPqdefZn2t55PTF5xGbYrN1JuaX+BqVJWMA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eaD+kqhDmXs8ZmLshV5plFVWmZBZbEotKKRpUq5Gl7QBl2PMcE7uMqgJEDfErPr2V7sZsnIbHlkwSZeaxJxD4qBVvxg6s+oEutz+X1SyTZGgDFM3mLkWELDVk1jAyBZaRNfersZHfxy+eLU2Ym/w2+frFNMgnmxAmO3z/81eZtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=XbL4crMS; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2e56750bb0dso3585491a91.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2024 12:55:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1731358506; x=1731963306; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sEpSBMtfQIdn0VsL6AOSyBd/7ZO5cM9GZrrfF6sqPzw=;
        b=XbL4crMSL83W9I+2KJbi4OTTdjbdsPRzyBv9KNprJ8sH2qYvoX0SUx7U3SPnXtTMXz
         07cFwrQJmSaT7aG5yyGCZyu0q/1ZLQw1BsXEvjygIvup/461gjSTQDXVFcdiA7KHhl37
         uobcSKa42kR5HT36ysm0/Rhd2DlSiBPv4lQwoRlzNB8NZjx7IFqeneqntM5dWpPZXbDS
         fERyjzcGdbr6CF//SMsImu+1N+mCRY0HVXXUAgycDSwSYFZKkRufGF1bKzzhmUdQOlva
         6N55Zx5dfoXV/x/m1J360AViQMN4P4DbcQBvKHV3LLjdhntb4WmMmQav9qbUR4V7Krjp
         gGkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731358506; x=1731963306;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sEpSBMtfQIdn0VsL6AOSyBd/7ZO5cM9GZrrfF6sqPzw=;
        b=T2UUmBy24mmfPcqrwmKByByQtDs7E5Pj6IMrFQNp4PGwArddd8s2sWDa7bzMnAQyXm
         7dckGRU2hBhNozDHbTvDw10ASceaUm4fPqKupcdgq0ZKaPHn5RCTJc628eGJD98XHePc
         wd7Gn8fvf0S3zLDFsAhiK7J7KQX5P/pWlW1Bx7hQQKKq4wVdP7Hqx/NTBb7jD008yZmS
         X9KoghRQeSsTbQdo4XRi7yWVHSu4RS4kA9s9P5EBCyU8GS7avmDj4ACx53Qz7hItImrQ
         e8rVZtR2Iatd78wC3gmv12a2B3nw8cW9ebv1eki960vpraHavOm4nuGArUAcOlG9/tbU
         VuFw==
X-Forwarded-Encrypted: i=1; AJvYcCXApfcw0MnXAka/uc61j+WCmZYtLsK8r8nRxY1TyyZSIiOoYXXpe/5bd7e+/lxxyy+sXU7N6E8IZgUbu9TT@vger.kernel.org
X-Gm-Message-State: AOJu0YxCezssuR6IiFNdlmHhl8eRRhPi8YiDFsUmQ8prx9IF/PSCVKfB
	+GAMEs+pXdDwPNen9fC4em/uGNhD+CsN4HsSFkN8b5BSiGLHofgG/fvj+3IOHFg=
X-Google-Smtp-Source: AGHT+IFzBuraYyYmpM+mIAMFI16Yg/jetlEaju2rqc5UFMlTYdZs+XaMbAKQKjfpaEa7usCG1NdnaQ==
X-Received: by 2002:a17:90b:4d11:b0:2e2:b922:48a with SMTP id 98e67ed59e1d1-2e9b173aff9mr21100247a91.18.1731358505869;
        Mon, 11 Nov 2024 12:55:05 -0800 (PST)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e9a5fd1534sm9059974a91.42.2024.11.11.12.55.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 12:55:05 -0800 (PST)
From: Deepak Gupta <debug@rivosinc.com>
Date: Mon, 11 Nov 2024 12:54:11 -0800
Subject: [PATCH v8 26/29] riscv: create a config for shadow stack and
 landing pad instr support
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241111-v5_user_cfi_series-v8-26-dce14aa30207@rivosinc.com>
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
 rick.p.edgecombe@intel.com, Deepak Gupta <debug@rivosinc.com>
X-Mailer: b4 0.14.0

This patch creates a config for shadow stack support and landing pad instr
support. Shadow stack support and landing instr support can be enabled by
selecting `CONFIG_RISCV_USER_CFI`. Selecting `CONFIG_RISCV_USER_CFI` wires
up path to enumerate CPU support and if cpu support exists, kernel will
support cpu assisted user mode cfi.

If CONFIG_RISCV_USER_CFI is selected, select `ARCH_USES_HIGH_VMA_FLAGS`,
`ARCH_HAS_USER_SHADOW_STACK` and DYNAMIC_SIGFRAME for riscv.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 arch/riscv/Kconfig | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 5bdda86ada37..0887a9ae0c20 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -246,6 +246,26 @@ config ARCH_HAS_BROKEN_DWARF5
 	# https://github.com/llvm/llvm-project/commit/7ffabb61a5569444b5ac9322e22e5471cc5e4a77
 	depends on LD_IS_LLD && LLD_VERSION < 180000
 
+config RISCV_USER_CFI
+	def_bool y
+	bool "riscv userspace control flow integrity"
+	depends on 64BIT && $(cc-option,-mabi=lp64 -march=rv64ima_zicfiss)
+	depends on RISCV_ALTERNATIVE
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
+	  default y
+
 config ARCH_MMAP_RND_BITS_MIN
 	default 18 if 64BIT
 	default 8

-- 
2.45.0


