Return-Path: <linux-fsdevel+bounces-70730-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B60CA558C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 04 Dec 2025 21:33:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AE2B53161D11
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Dec 2025 20:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AE7034C991;
	Thu,  4 Dec 2025 20:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="bA1sYoAG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148AE34C99D
	for <linux-fsdevel@vger.kernel.org>; Thu,  4 Dec 2025 20:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764878693; cv=none; b=gF6Abc0yGqP5velSXBLWFfpNmozpe2psZvRBZocQU53eBtYTmfKbwJ9h75hvLTjMwCOR6Z4C8r3/SHXfkS3mE7OS9ch7nAuanOwLimpL2DdQA4KV3uCBkAsrUIMRgPdErzx8Sl06quytXZojRANa5Df7/iyQ2ofmzdsno8HUa7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764878693; c=relaxed/simple;
	bh=+ngELFAfNSDVPG1dfl4U/GNwgJgSLmHNPMTUuZ2hwrY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Pr8tnWMyvxS699Se0S6h3wLFz2q/GssDZ+3hqhqAEq/cNDceJipbq8DJh2k1hh78G48y94sE+xrEAdr4kEEQMLOgIYjYdUEDkUM2JWFSLlFMvrYFgjStQoOjRsgYAnmj++Wj9Th6kGqF8f2+3DGDpjdch7p9x/mH2/Eihk6BU/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=bA1sYoAG; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7d26a7e5639so1678725b3a.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 04 Dec 2025 12:04:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1764878689; x=1765483489; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uR2ANK1p/GtJMLoYkqluiVL+IiMuKNKdjgHs5HSKwC4=;
        b=bA1sYoAGNYrhIUtW0/k2h9N41N8tw+2Q0fwZJq5QR+6/K0p8JocSR2Cffm5XIia8A8
         Ts4HSQ3pUG5YyoYo4lXzWeBPud44DtrYHHOAiO89AOZvxjAnyKbtBaFf+1SzrFbpxC4Y
         AZw+rtzQY6Ti33fx1xZo3MJ1Jj7yxE+qiIfNvOC+jkjF60myYMRjMAkUVp0kbjbwYYnO
         2cUUYZwjiOMTbRb8RK3u535/lbs59fMJ6cbzfBc78qwi3utIC4bBhnsFYZMt9r7/OrbU
         zgnk5QINjpVFA8zbybxjabLE1mR9QWMgUnAa0T6igOkmfynOtyKgNpP1WvNEHFSXt0aw
         2D6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764878689; x=1765483489;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uR2ANK1p/GtJMLoYkqluiVL+IiMuKNKdjgHs5HSKwC4=;
        b=EOIWwXhDz98iac4gx0z02FexcTHCnWSsGTbgofeGYyaemZFy3bFPq1oFddkDZuxIkw
         rFGq1TwkpI/Ea60p4/bb3zsQPZIQNcgb+QBfvey/IOBQArEj282gFS6+OzK/6pHf7cC/
         8o76WLP2pF1huEMiEEIHiUeQLNOQADtcvJU8Ib72k9yd5VjZXDqb0YAyEqzN9UheUh1e
         OL7pDcpbp+rdg2dQPGkY0opnfbu1a78YyCFoEv3frYgrpA+DRa4ypVplaCkPBk2V9U4j
         LZrcqK+lm1MwJM3t8/Sp8/preQzIJiDJgDLhmATpUboxmapbNzSHEQrtTU1rXRnWyQ3w
         +6fA==
X-Forwarded-Encrypted: i=1; AJvYcCUk+oY0+fU8QX8qg2PwqJ7o13N6hLj/EZohlE+xPUwy5d9lzgdz+d0QIFhikov2PsrQt+2hYcAxJOokwD4u@vger.kernel.org
X-Gm-Message-State: AOJu0YwsC7zuz6CowqJM1W8pUs40nd1ZqDTT8yyDxhZX009TLl71C+qA
	BWL3fn5daN46GqKLN9Yto3k7WytePTzNaGDA4T6XY82+n12bJThcbvDQak/lxazSOo0=
X-Gm-Gg: ASbGncu7rffnJnT2S/8Gnm/XUdgHb/5qfLJ+ULPkaSRGG+4ktmfmz9RvPath1GjCLXx
	nqPruPaAXeFdY6YvVlVFpQUAWGPO6WjQOEBTBZmifsSNAvCZ/KKJG8czm6LwpGCjInepbxOXQEH
	BQZbpKBWkPifWgIK6N39BrdeeEq2Jpw47BP/I5JYAH6yeoUblSjvLXRpjE2xo9yg7YByQp2EgTE
	RY0/otIIby4dYRsgXpxIUoUZzF/uwKV2N/GSdVOoOP9o3wAC9EweTY8Te6aGOex3o0VS4nBs8t+
	b3uPPstemXNMVwG0ERJ3ged6O9aFC+k8mMRSCAuW0/1/3ycycPAScQedGoULd4pWu5oPKds+MNZ
	I8R96ufq9fcK4LOAfJnmuAF2LTnWKajX8X2/wBf2uBXG//k8k8bfM6bTLbwcL5/lY06NA9bLU4+
	G1g4OcCJmMNX0zpfcYI2vy
X-Google-Smtp-Source: AGHT+IHr9eCZ7OoyJRMHMKZM3eAa0ZLkjuqDEJhukBTDFAFWWCXqX+gcmL/RFs0P9XhWOx4pRyl01w==
X-Received: by 2002:a05:7022:fe09:b0:119:e569:fb9b with SMTP id a92af1059eb24-11df0bd1799mr5495837c88.10.1764878689024;
        Thu, 04 Dec 2025 12:04:49 -0800 (PST)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11df76e2eefsm10417454c88.6.2025.12.04.12.04.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 12:04:48 -0800 (PST)
From: Deepak Gupta <debug@rivosinc.com>
Date: Thu, 04 Dec 2025 12:04:14 -0800
Subject: [PATCH v24 25/28] riscv: create a config for shadow stack and
 landing pad instr support
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251204-v5_user_cfi_series-v24-25-ada7a3ba14dc@rivosinc.com>
References: <20251204-v5_user_cfi_series-v24-0-ada7a3ba14dc@rivosinc.com>
In-Reply-To: <20251204-v5_user_cfi_series-v24-0-ada7a3ba14dc@rivosinc.com>
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
 Zong Li <zong.li@sifive.com>, 
 Andreas Korb <andreas.korb@aisec.fraunhofer.de>, 
 Valentin Haudiquet <valentin.haudiquet@canonical.com>, 
 Deepak Gupta <debug@rivosinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764878636; l=2507;
 i=debug@rivosinc.com; s=20251023; h=from:subject:message-id;
 bh=+ngELFAfNSDVPG1dfl4U/GNwgJgSLmHNPMTUuZ2hwrY=;
 b=iBrp1RtTRh5oJZVzaOaeFhva2V5Z1q1JFj7rzOxyzprKnymzoWjN45RvOVAV8T5/wMd+G1JGu
 G1MvETpgLboC+3bOxlsHE8Ns8RB1GZmzEixY2AHWIc1eUxbU9mIcSne
X-Developer-Key: i=debug@rivosinc.com; a=ed25519;
 pk=O37GQv1thBhZToXyQKdecPDhtWVbEDRQ0RIndijvpjk=

This patch creates a config for shadow stack support and landing pad instr
support. Shadow stack support and landing instr support can be enabled by
selecting `CONFIG_RISCV_USER_CFI`. Selecting `CONFIG_RISCV_USER_CFI` wires
up path to enumerate CPU support and if cpu support exists, kernel will
support cpu assisted user mode cfi.

If CONFIG_RISCV_USER_CFI is selected, select `ARCH_USES_HIGH_VMA_FLAGS`,
`ARCH_HAS_USER_SHADOW_STACK` and DYNAMIC_SIGFRAME for riscv.

Reviewed-by: Zong Li <zong.li@sifive.com>
Tested-by: Andreas Korb <andreas.korb@aisec.fraunhofer.de>
Tested-by: Valentin Haudiquet <valentin.haudiquet@canonical.com>
Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 arch/riscv/Kconfig                  | 22 ++++++++++++++++++++++
 arch/riscv/configs/hardening.config |  4 ++++
 2 files changed, 26 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 0c6038dc5dfd..f5574c6f66d8 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -1146,6 +1146,28 @@ config RANDOMIZE_BASE
 
           If unsure, say N.
 
+config RISCV_USER_CFI
+	def_bool y
+	bool "riscv userspace control flow integrity"
+	depends on 64BIT && \
+		$(cc-option,-mabi=lp64 -march=rv64ima_zicfiss_zicfilp -fcf-protection=full)
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
+	  default y.
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
2.45.0


