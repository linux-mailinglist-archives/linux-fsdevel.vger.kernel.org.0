Return-Path: <linux-fsdevel+bounces-33178-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56AA99B5737
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2024 00:44:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF8D1B228C4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Oct 2024 23:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC4A720C465;
	Tue, 29 Oct 2024 23:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="VRWj5fLb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CABC920C01A
	for <linux-fsdevel@vger.kernel.org>; Tue, 29 Oct 2024 23:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730245462; cv=none; b=aNPR1u9s8w5PbcrZeaChhTgTK5IzKZYuMaHgTJi4W6+BYGca9ZCI4UrpICphREnbU5A/Fuxf4MWtHsUF7/jh5uQzGEyInwt9fOYQtbanV+oO0K+ouZNcQ1D8//JXzB9odw1Ik+qwL2AH+x8iYovqtW7q/Ik91bdvD005zA3Bj8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730245462; c=relaxed/simple;
	bh=UNTobpzl38g0R+dv982rAreZHXjVtOuK145iVNOJ3Bk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g+tE2usMByuxyQwzai3tdV9eOqjkH+xb+JrEVBR/UZKfVwDKLzaH6dw7NEAK+XWAx++we6rDcB3Ua86FEuOmES9nmzkgwfg9vrk4SSXYrs9tc6wIA8nw4vNSCwmdR1IWQQahm23+mAoE06gHaFdzSgbgPrb9ek3CQ/yUEn8mJKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=VRWj5fLb; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7eb0bc007edso3029756a12.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Oct 2024 16:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1730245458; x=1730850258; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A27TSZWEvDZAFIGCzgSTP5vgsRCljOGvihxqekfN1m4=;
        b=VRWj5fLbel/QJqNJRx2zNrIwk9RJYjDwV2wIUbgLLfXf8Jlc/wUVewWKRwnAFstStQ
         4cdLDXuhtzaDzd8SRWCVokyFi87lErMo1MAuSGXWjY3k53S+R19YqmovblyzxbisfLOM
         aKizL8EaPiSsBF6ubYtYm7qsx5fhYAZkXMTw32b2iI6JIhVt3G2Zyxpiu3qKbD+MS8uV
         oq/BFoE88yNmfkv39bpLjA4R7r5WH8Ehc4R3B+Y8umdWN4UZa3F4r7bAy9BwE+US6KjI
         3VfN7q1UCoRrVryyNG7R2yOAL6HFzvst87Sj5dV/JpGPTmh1PhEq0egKuctsvAtUlF/V
         x9wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730245458; x=1730850258;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A27TSZWEvDZAFIGCzgSTP5vgsRCljOGvihxqekfN1m4=;
        b=UNDVZx9YiSCDgGi47YQPh57zPX3iK4w5Ya5GjfCQlVC7c7sr6eR1WlnsHpjPuZbrJm
         VKt9jIjD2Nty5aw3DaMMqcz5UB2Hy0m510/Bp/bDHYBGYzDe1X1/dOQNE7OsDGnu+NFC
         I6E8Qm0LHmGspY2cW3Rb87T3ecgloQkybqU+ri7zCpgg1LiG2UyTbOid6izWpzCs1IvK
         Ps4ztMf2bzit32JOx/tGh0fI/tMbBEmcBzyYpIZRloYEKJ6+1zLUgl4Q2pzjtaW98MQE
         UZinGcgQeySEqqEIT1Zi0MUv57NS0t4UMVPrjXZ99ov9ynVw5z3BySpGtXw+9tQDkrjY
         DGUw==
X-Forwarded-Encrypted: i=1; AJvYcCWMMD7meOuFKQzD7I5a+2e82JVHUnXJ7uEt8ZJGD4PmFabHferc5mh8Cvs6d/yrg2pUuuhcFiK+z5lS8l/7@vger.kernel.org
X-Gm-Message-State: AOJu0YxoPuLsMx6zuz+X+eDjbzqV4x5qkZ7yyNyn8oWbZqN94DlZ/Luk
	rFsvhSTohIuaMbBazE61BsdMl4AyaxowU9UL9fQe6b5EwXywT11nLxD0BWuoBu0=
X-Google-Smtp-Source: AGHT+IEl2QOb2QqMdMEvJJy28IFG3kLdP55DbuAo5+86qcvJIXvWMGt1Fwpgzfx+V0+HBr7ZrtesUw==
X-Received: by 2002:a05:6a20:d521:b0:1d9:181f:e6d8 with SMTP id adf61e73a8af0-1d9a84dd394mr17393682637.31.1730245457862;
        Tue, 29 Oct 2024 16:44:17 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72057921863sm8157643b3a.33.2024.10.29.16.44.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 16:44:17 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Tue, 29 Oct 2024 16:44:01 -0700
Subject: [PATCH v7 01/32] mm: Introduce ARCH_HAS_USER_SHADOW_STACK
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241029-v5_user_cfi_series-v7-1-2727ce9936cb@rivosinc.com>
References: <20241029-v5_user_cfi_series-v7-0-2727ce9936cb@rivosinc.com>
In-Reply-To: <20241029-v5_user_cfi_series-v7-0-2727ce9936cb@rivosinc.com>
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
 rick.p.edgecombe@intel.com, David Hildenbrand <david@redhat.com>, 
 Deepak Gupta <debug@rivosinc.com>, 
 Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
X-Mailer: b4 0.14.0

From: Mark Brown <broonie@kernel.org>

Since multiple architectures have support for shadow stacks and we need to
select support for this feature in several places in the generic code
provide a generic config option that the architectures can select.

Suggested-by: David Hildenbrand <david@redhat.com>
Acked-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Reviewed-by: Deepak Gupta <debug@rivosinc.com>
Reviewed-by: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
---
 arch/x86/Kconfig   | 1 +
 fs/proc/task_mmu.c | 2 +-
 include/linux/mm.h | 2 +-
 mm/Kconfig         | 6 ++++++
 4 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 2852fcd82cbd..8ccae77d40f7 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1954,6 +1954,7 @@ config X86_USER_SHADOW_STACK
 	depends on AS_WRUSS
 	depends on X86_64
 	select ARCH_USES_HIGH_VMA_FLAGS
+	select ARCH_HAS_USER_SHADOW_STACK
 	select X86_CET
 	help
 	  Shadow stack protection is a hardware feature that detects function
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 72f14fd59c2d..23f875e78eae 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -971,7 +971,7 @@ static void show_smap_vma_flags(struct seq_file *m, struct vm_area_struct *vma)
 #ifdef CONFIG_HAVE_ARCH_USERFAULTFD_MINOR
 		[ilog2(VM_UFFD_MINOR)]	= "ui",
 #endif /* CONFIG_HAVE_ARCH_USERFAULTFD_MINOR */
-#ifdef CONFIG_X86_USER_SHADOW_STACK
+#ifdef CONFIG_ARCH_HAS_USER_SHADOW_STACK
 		[ilog2(VM_SHADOW_STACK)] = "ss",
 #endif
 #if defined(CONFIG_64BIT) || defined(CONFIG_PPC32)
diff --git a/include/linux/mm.h b/include/linux/mm.h
index ecf63d2b0582..57533b9cae95 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -354,7 +354,7 @@ extern unsigned int kobjsize(const void *objp);
 #endif
 #endif /* CONFIG_ARCH_HAS_PKEYS */
 
-#ifdef CONFIG_X86_USER_SHADOW_STACK
+#ifdef CONFIG_ARCH_HAS_USER_SHADOW_STACK
 /*
  * VM_SHADOW_STACK should not be set with VM_SHARED because of lack of
  * support core mm.
diff --git a/mm/Kconfig b/mm/Kconfig
index 4c9f5ea13271..4b2a1ef9a161 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -1296,6 +1296,12 @@ config NUMA_EMU
 	  into virtual nodes when booted with "numa=fake=N", where N is the
 	  number of nodes. This is only useful for debugging.
 
+config ARCH_HAS_USER_SHADOW_STACK
+	bool
+	help
+	  The architecture has hardware support for userspace shadow call
+          stacks (eg, x86 CET, arm64 GCS or RISC-V Zicfiss).
+
 source "mm/damon/Kconfig"
 
 endmenu

-- 
2.34.1


