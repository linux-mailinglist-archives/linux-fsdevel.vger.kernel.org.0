Return-Path: <linux-fsdevel+bounces-44079-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28EB1A61F22
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Mar 2025 22:47:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2D474610CD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Mar 2025 21:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEC67215793;
	Fri, 14 Mar 2025 21:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="aF0l5O9v"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78FB8215789
	for <linux-fsdevel@vger.kernel.org>; Fri, 14 Mar 2025 21:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741988436; cv=none; b=T0J88VTnacOWuLl1SZjPZcN9exMM/VVIudJciF0W69cqE7NCoJUBvuYmfY1kMQHMygRzT10BZ2B5epJMjNBU6V3+TB2JoUhh6agaZi5Dy5TzVH4X9N6X2PcLPI4uZSVuMO/NSPjg/Rbk3fnkABJR6D9lnM6v1jpvqwlU6aXit9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741988436; c=relaxed/simple;
	bh=jphbYhrRQJE3aza4B1cudTZ4/ZFMf8KSGATMhENGHNM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e9BNwHnI7Tfbu/BjOL3KJtzWDB5uFYrxRS0CyIxRqRKlbymUyillbqXYqyQRW3DLLwGylIP8Q5gFLAJRJuVVznycfzfWVqmqft0a4Rhe394Tm+vw26zKWFesKRiQmBgcYWlPsxulEsYDL7a0Kl/9o/m9vmbwvOsTXpS45E1QNm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=aF0l5O9v; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-224191d92e4so52592605ad.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Mar 2025 14:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1741988434; x=1742593234; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RHgO3WLw+YmwdWGhLYAhQ6tJSqW/uFwu3lLubQj4jZ0=;
        b=aF0l5O9vvGp4BPf6jfvlT9siIWjvREV/3Ch5DnGUxv5ZhgttiLR3d4zQuFIN7LyW2r
         TJX/yYRIJsvWtlnKJKwZ9oDoXVsJILZ7uqWY0xRl3S0bLdl9LYSzlk1FijkJyUASpcUw
         MZ07LmoP1+9lOkOFGblLNAtRFQ77d+oZbf7nzjoE6FLln5a4JmLg9GgxufaBPr5joe4f
         r1W8OTGjazyehFAzlYwxqGtZ/Q7VcFFyjXl074UsejuL/PMfpp3icSRo9iBWlyv9dzrE
         eFHEqnoklWCRnd4dm3KYjW+c6tUNRkjtu21wm+STHuDeSV7nhfN8otouaJngYQpFMvDH
         jWNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741988434; x=1742593234;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RHgO3WLw+YmwdWGhLYAhQ6tJSqW/uFwu3lLubQj4jZ0=;
        b=ULv+UGfVVCopYlluhA3jIxo8tbvFaTSC+KQHTpsIuKZS5YZOL2PL/Opx1KTqS5QXIr
         3aj8lwcu7Yosaz8XoXBCdVRGrl2LZe9fbBqbwHh1iGXt3Xm5ltu8XCt4bH9CBSbsx2NP
         Pa7yLQIHdNPDVd4BdOFBeDabgbnVVwGTPohZw48eBjVjSIzmjOC6Ya9Undjo4g+1QnLD
         CWKiGHNulh9ck3jTAcONlIceK5/BZ7kULYXVSVgn2iSlR60g07KLb3MTbgbf3q3mGv4L
         wA4D4yYNmiywbhZ5q/wxLWhwBVxOECOjk1Q3ubGmCFL4RHvuyGuSg/RvHOw30CFlWpIk
         5qqQ==
X-Forwarded-Encrypted: i=1; AJvYcCWgIBprKHpzlwJ9cHQ0OjBh5IjP899SwGCZb9IYrEQ8g8563JygZgFLc+1PkSWU3crAajOAZHFU4GHMV0WT@vger.kernel.org
X-Gm-Message-State: AOJu0YyxvJyPBrHwPu+chlITVtHtsUrnwu8J1jitvUY/pO9Ej4FS91Ic
	ly6Au6n0xDzgTsNJAQy7KOZPgcYKGnUIcG612rLBQhTgNEZP08FXOAvHLkAT1+s=
X-Gm-Gg: ASbGncvBJKvLs9Oy4Bx1PT7kOcYwLO7RfZA1vUgaZ7OU9chXFRUymkGCjJBPV2/4YiG
	F1nXqe74HdYgQTrh72xL4iREYB2ySqGGDV/REjjNt6BKYm9YRxFgExov3L2yYz6Az6Gmj+uz9Aa
	H9tzBfK0suNY4XubnTu3Q/ux/8flDg5UA6B+4+hPSvRDIPot+CfPva7EmtX7q0kTo7QGE3Oedvb
	nz9NROA1ZaHU0W4bnmr4YtEdNam79dF6UVNMTaf0u1JplmB4Ljg5JcSvGj02MveqQSOWzyNte7c
	Ef1mf8bXPSRkGOzQCUsYJzfLa/wxQvK2BlZJfF5KydyqPFWnUu6rf8E=
X-Google-Smtp-Source: AGHT+IGwO6FdmJUbA9RsVYM+YTvEHEJUu4luaiuDWiqjNtcj9WvZlSftHA3OvhahsPKrta0EdbsKUA==
X-Received: by 2002:a05:6a21:394c:b0:1f5:7d57:8309 with SMTP id adf61e73a8af0-1f5c119438dmr5984307637.21.1741988433739;
        Fri, 14 Mar 2025 14:40:33 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c68a6e09sm33368855ad.55.2025.03.14.14.40.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 14:40:33 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Fri, 14 Mar 2025 14:39:44 -0700
Subject: [PATCH v12 25/28] riscv: create a config for shadow stack and
 landing pad instr support
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250314-v5_user_cfi_series-v12-25-e51202b53138@rivosinc.com>
References: <20250314-v5_user_cfi_series-v12-0-e51202b53138@rivosinc.com>
In-Reply-To: <20250314-v5_user_cfi_series-v12-0-e51202b53138@rivosinc.com>
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
 rick.p.edgecombe@intel.com, Zong Li <zong.li@sifive.com>, 
 Deepak Gupta <debug@rivosinc.com>
X-Mailer: b4 0.14.0

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
 arch/riscv/Kconfig | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 7612c52e9b1e..0a2e50f056e8 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -250,6 +250,26 @@ config ARCH_HAS_BROKEN_DWARF5
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
2.34.1


