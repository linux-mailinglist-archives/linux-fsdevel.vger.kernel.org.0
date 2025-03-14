Return-Path: <linux-fsdevel+bounces-44077-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64121A61F12
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Mar 2025 22:46:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E96C1886E0B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Mar 2025 21:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0F0F215186;
	Fri, 14 Mar 2025 21:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="LRSF9WBM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7114215046
	for <linux-fsdevel@vger.kernel.org>; Fri, 14 Mar 2025 21:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741988431; cv=none; b=OgCob0McU/+t6NmxZL5ckRI8FKDyEq1cu9Qh3ig6T2gxZaa/PW71CMeQER70cGnxL0za3Vn9QyTkYwOWdsicXumuBDyi738vOxMrj1tAIp+O6x1kIis1B1OljJOWdo7oK5DN2rdL3NV12/QbJm8NDCotDJE4KTGiGZf8SGEc5Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741988431; c=relaxed/simple;
	bh=CfqIlvRNnAaYS1Ud2Sq2SPLM7zgt5Ek9vu9v1oO8Dhg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TJfE6BVyjAMLeHOtryisKs+MHqFGH61F0uWAFLGcPpbs7tNChlgnfAT30AJnL1AcrFnPkFmW6W8zajcN2ugF2qOPCTOGSdnEjc4TMBHIk9b911XXWrfjK46KxZH6GgRS/tv4/GRl56/0KeEJB1Vx7hVALqXa310fqMqM+aLpeXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=LRSF9WBM; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2240b4de12bso69481315ad.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Mar 2025 14:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1741988428; x=1742593228; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a7L6jEjphmSCVBHcxl5XAt3Us7qrk/UvaMSfIdPEx6k=;
        b=LRSF9WBMlGQ1h1slE18S16rLUjEPjzot78w8SPGc2rX2NicbPSizXo66/GSyO6grNX
         0dJ1Tarn+6Gw5/P75CAdXbiVWKIhPfcKVZHC1uPiCdJ3g8XV5/5yIrUJEv8uc9Pj08Pc
         yrXVDjje5T/DWl24XYrZLwXPZ/hiQCktZQDwsA0x6b1JBEF9d6XG4TsgTA6PmObEOKgV
         nJPr7uagFFPPT1JECbupV/GuictUJGyDvX5W1yhNXxJMgCZ2Y6uGK/KuKaBqY5M2AXnO
         t7IQJIWB5NHs4tJkxFtQYdvWmU1F56T/cjmygHIuZo/4JNFlugL8QfnDtvXeJjZ1t0P8
         luyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741988428; x=1742593228;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a7L6jEjphmSCVBHcxl5XAt3Us7qrk/UvaMSfIdPEx6k=;
        b=Y96Immk9GL3Nip9tK4zLegBeMcyogaOiH9CIypBoXBaQ4ivA7PYPLVU3v19w98+sN5
         hSsP/93zcO6UODlk0tnjewIt1U33Vg8dDDziMHoZZLXwiLnMk0LyosCzAXD4Z+RVQJ+Q
         9peAT8l6ObvOBkqYz0lQdBcQ2xpPhgwmF+nqUQjPveSAf2t01Bt2Iiq9RhmyNk+e1Bdn
         H4mR8Vc3R7f9tGcOCi7+u/owJCO4LYtEB8RHKzDml+zpBUMBwCTu67dtVg4J+aIIl2Vb
         3JVnoDb/rVXwVdK1J8hYpQoJ/gjob4kCKHAD4ktYzJBIZHaqIa6J8dxvaAFFozV6NSRb
         ayTQ==
X-Forwarded-Encrypted: i=1; AJvYcCVytVSm1HcSAtZazHA0+QwUDWCNNVhMg6a948cHyoBjU388HIFEdJvTSDgc3u4ByB7ukE5IjtVlL9dWFKFG@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ1kna8KQvdzdTBQ6v2G8NvZxKuKA8Xltmb5AGR/l6fJEUbpd4
	HwISGFtLWe40/iKBlG4hh5u3M7js6aSpPnWmXlAHhJreEP5el1PexFvHj5fFFGU=
X-Gm-Gg: ASbGncuN6RlCwX3AFoRpDHJKjcP0JQiB0BH3gkt5+ir+qiJb2Bff/5hRcScniK1dMRe
	DNpDWEKNLjOdb6okNGFm8h/5e21bkU1ZdTttehXp9UVed716XXtaC2w/slAtzGu/OQqAAIvPeZN
	IzH+nXR6HZQg3BwXY7bj6jLS1bcA3nJ2ho23gChTvRjnICWfbo62gWkC0E+WOhsI6ITT71G7rcW
	+9SdLZAvxCggHTlNvqqjkqfri6VeizSDfytsChfVnXXJqACByXm7zgGYJ5oGlqGrHQLlBE+Hdun
	+DRy+tnG1M1YJG9qxtG5NKkxdcn8J9HDipdawgi7QHwwHZS5VwDj/BI=
X-Google-Smtp-Source: AGHT+IHAGPYqUS71chjGuiJ8YNLnk78WQ4QXPzZzrnBV+tP+kBaD6/rfE4E8XKuF5NR7jHoZswbG+g==
X-Received: by 2002:a17:902:aa4a:b0:224:1dd5:4878 with SMTP id d9443c01a7336-225e0a62f2emr37059015ad.7.1741988428224;
        Fri, 14 Mar 2025 14:40:28 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c68a6e09sm33368855ad.55.2025.03.14.14.40.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 14:40:27 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Fri, 14 Mar 2025 14:39:42 -0700
Subject: [PATCH v12 23/28] riscv: kernel command line option to opt out of
 user cfi
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250314-v5_user_cfi_series-v12-23-e51202b53138@rivosinc.com>
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
 rick.p.edgecombe@intel.com, Deepak Gupta <debug@rivosinc.com>
X-Mailer: b4 0.14.0

This commit adds a kernel command line option using which user cfi can be
disabled.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 arch/riscv/kernel/usercfi.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/riscv/kernel/usercfi.c b/arch/riscv/kernel/usercfi.c
index d31d89618763..813162ce4f15 100644
--- a/arch/riscv/kernel/usercfi.c
+++ b/arch/riscv/kernel/usercfi.c
@@ -17,6 +17,8 @@
 #include <asm/csr.h>
 #include <asm/usercfi.h>
 
+bool disable_riscv_usercfi;
+
 #define SHSTK_ENTRY_SIZE sizeof(void *)
 
 bool is_shstk_enabled(struct task_struct *task)
@@ -396,6 +398,9 @@ int arch_set_shadow_stack_status(struct task_struct *t, unsigned long status)
 	unsigned long size = 0, addr = 0;
 	bool enable_shstk = false;
 
+	if (disable_riscv_usercfi)
+		return 0;
+
 	if (!cpu_supports_shadow_stack())
 		return -EINVAL;
 
@@ -475,6 +480,9 @@ int arch_set_indir_br_lp_status(struct task_struct *t, unsigned long status)
 {
 	bool enable_indir_lp = false;
 
+	if (disable_riscv_usercfi)
+		return 0;
+
 	if (!cpu_supports_indirect_br_lp_instr())
 		return -EINVAL;
 
@@ -507,3 +515,16 @@ int arch_lock_indir_br_lp_status(struct task_struct *task,
 
 	return 0;
 }
+
+static int __init setup_global_riscv_enable(char *str)
+{
+	if (strcmp(str, "true") == 0)
+		disable_riscv_usercfi = true;
+
+	pr_info("Setting riscv usercfi to be %s\n",
+		(disable_riscv_usercfi ? "disabled" : "enabled"));
+
+	return 1;
+}
+
+__setup("disable_riscv_usercfi=", setup_global_riscv_enable);

-- 
2.34.1


