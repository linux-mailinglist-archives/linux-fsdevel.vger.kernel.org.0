Return-Path: <linux-fsdevel+bounces-30534-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A7A6E98C2A1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 18:12:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 248C41F22AB1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 16:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED0641CF289;
	Tue,  1 Oct 2024 16:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="ZlCgJVus"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900071CEEAA
	for <linux-fsdevel@vger.kernel.org>; Tue,  1 Oct 2024 16:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727798860; cv=none; b=BFz8phF8pS8oWtgA90vVDL5uUzF5g5uEXM/KmeLb5mFp9LdZQPzIhAHRv29Zhfbdsx8WpiPK+Uynd0zilcCN9T6gFGAVSRucVKr/5hCeWx02WocDyDZQXoRKZ9lTDfGS1iqsIBwFOrbjEJGcYnQf1DTs0jtv71MsiMzNE2a2fDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727798860; c=relaxed/simple;
	bh=vaFWjXy2DRrsSIuTbWduvBr7Hy/qYsbzVGbusd1hcYE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Eso7vY//0KoCN8KGknIFv9nZ9o5dYLsXcqZmqe6+MonmV45N8+dlnQP2q7fbVsX0ruCIvC8mOMZz35f3XF16tcRiVgh+k5MGMHJei2hXKFBSkzeQ9wNCNE4UPiXYO4ngkFFTu4g+loHm4qt5LVeyZ8b5ONw0XOSbdiMLUo87q/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=ZlCgJVus; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2e0a5088777so4602847a91.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 01 Oct 2024 09:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1727798858; x=1728403658; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AMPZIqdzSjfHq7xJb4YaIgEu2GPeUmiCYK4jkAGMc38=;
        b=ZlCgJVusBeshAcu5xCItvib08BedqGWUZO8LzVDyLTvhpO060xOlpE5o87ER4fj1EM
         4Ng1S/wI9+JXVnY3QDDTxBG4XGiq/R3wUGyM3KxhRWE1ImSMJwPcM8hlrGtJQMA8TsXx
         qXDQXaPET7MGaQDI5Ti0gRjoi/Kj5l3vFzPGPPhsz6ifyF0hweP2JF5Y0fQS0lkvOE2z
         +ZlJU/IZTDxKcqoVCjjXOgK0Ugdbgi6WDPvXkgfgGquvnXVKWK7d2qhrKRRFxm8TTH/p
         7aY5Dwqpz2v57KVXx0t07RvO1ITUgYigyCWyNZdgqCaPUozoHQL4X6uom+MB2zOGqSwH
         8hVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727798858; x=1728403658;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AMPZIqdzSjfHq7xJb4YaIgEu2GPeUmiCYK4jkAGMc38=;
        b=YAYq6cxAzn1C+2sLo3QS7T/so65NVj3vBFCdmsr5AE/qubwg+WYMEgyXZQZnqOjpp7
         1ayx6GpBq2O7wYdL3VS/uGBo4GCndOUhlf920xrH/b4TtYNpUHOmxzQ2rEYlLd1IDsgN
         8jLfOkNcHQwNLkLCfJv58BG9QMxzcAdlg3o1mFMQBhG/EilE8SSs7jKF35iLscfTXgpx
         2HuF5ij+qgsyzD2abAoRjs6MGuIYWq7amZvQG6Y9vFzKdtYDvgiEqzCuwreCVTKkrn8j
         Q+xGuKdnSqAEA021Cea7Sth4dSVMGLIuJeL0LQfI+JaHGI+0jE97D+efinnEM+NKvnLX
         Ti6g==
X-Forwarded-Encrypted: i=1; AJvYcCWYBJ9gSDR8D0QtJDNK/RY5B2Nw3HX7Lf9fxUhdUKg146Q521vJe7qbue7CpShvGfLPAtbDVYsbL+NVCNPn@vger.kernel.org
X-Gm-Message-State: AOJu0YyKi4ftjJetgXaxNPNwdkDtK4Z4bXl2hM0tSs243WyAnDBCbbTw
	GxJDFhBqewC5w1qEPsZcB1vaGUhfjeA7PaEfRQN7245+dBtCxvvybDxm4XRjHRs=
X-Google-Smtp-Source: AGHT+IFru0DhFvQoGs6LhOQ3kHAjWn92S78/sQgjmR4BKwvX6aS8UH3SB8TB1kja/SuVDdI6S6eWBw==
X-Received: by 2002:a17:90a:a886:b0:2e0:adbd:78ec with SMTP id 98e67ed59e1d1-2e1849d9954mr193359a91.39.1727798857996;
        Tue, 01 Oct 2024 09:07:37 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e06e1d7d47sm13843973a91.28.2024.10.01.09.07.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 09:07:37 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Tue, 01 Oct 2024 09:06:19 -0700
Subject: [PATCH 14/33] riscv mmu: write protect and shadow stack
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241001-v5_user_cfi_series-v1-14-3ba65b6e550f@rivosinc.com>
References: <20241001-v5_user_cfi_series-v1-0-3ba65b6e550f@rivosinc.com>
In-Reply-To: <20241001-v5_user_cfi_series-v1-0-3ba65b6e550f@rivosinc.com>
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

`fork` implements copy on write (COW) by making pages readonly in child
and parent both.

ptep_set_wrprotect and pte_wrprotect clears _PAGE_WRITE in PTE.
Assumption is that page is readable and on fault copy on write happens.

To implement COW on shadow stack pages, clearing up W bit makes them XWR =
000. This will result in wrong PTE setting which says no perms but V=1 and
PFN field pointing to final page. Instead desired behavior is to turn it
into a readable page, take an access (load/store) fault on sspush/sspop
(shadow stack) and then perform COW on such pages. This way regular reads
would still be allowed and not lead to COW maintaining current behavior
of COW on non-shadow stack but writeable memory.

On the other hand it doesn't interfere with existing COW for read-write
memory. Assumption is always that _PAGE_READ must have been set and thus
setting _PAGE_READ is harmless.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/include/asm/pgtable.h | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 7963ab11d924..fdab7d74437d 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -411,7 +411,7 @@ static inline int pte_devmap(pte_t pte)
 
 static inline pte_t pte_wrprotect(pte_t pte)
 {
-	return __pte(pte_val(pte) & ~(_PAGE_WRITE));
+	return __pte((pte_val(pte) & ~(_PAGE_WRITE)) | (_PAGE_READ));
 }
 
 /* static inline pte_t pte_mkread(pte_t pte) */
@@ -612,7 +612,15 @@ static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
 static inline void ptep_set_wrprotect(struct mm_struct *mm,
 				      unsigned long address, pte_t *ptep)
 {
-	atomic_long_and(~(unsigned long)_PAGE_WRITE, (atomic_long_t *)ptep);
+	pte_t read_pte = READ_ONCE(*ptep);
+	/*
+	 * ptep_set_wrprotect can be called for shadow stack ranges too.
+	 * shadow stack memory is XWR = 010 and thus clearing _PAGE_WRITE will lead to
+	 * encoding 000b which is wrong encoding with V = 1. This should lead to page fault
+	 * but we dont want this wrong configuration to be set in page tables.
+	 */
+	atomic_long_set((atomic_long_t *)ptep,
+			((pte_val(read_pte) & ~(unsigned long)_PAGE_WRITE) | _PAGE_READ));
 }
 
 #define __HAVE_ARCH_PTEP_CLEAR_YOUNG_FLUSH

-- 
2.45.0


