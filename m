Return-Path: <linux-fsdevel+bounces-70713-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EFD83CA55AD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 04 Dec 2025 21:37:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 90EE430F7016
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Dec 2025 20:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B30E34D92A;
	Thu,  4 Dec 2025 20:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="VJPX2zxa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9AD334D397
	for <linux-fsdevel@vger.kernel.org>; Thu,  4 Dec 2025 20:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764878661; cv=none; b=DVEAZsDcW2/u0rTj1tA0Fy9IjoxmKKTSCbn2ztwdG0JhPiOl4X+3zAejmswuXmpncSmbgaN5nnYT91Yhe0iaqv0+Yz1bUyyBhOVwGE+YhwNr7wXNNVtKGiSf8cRC/lrhE8Y73hQMOrdcF+FZaC/Iv6PVerLbjM6/w/nmxugFPEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764878661; c=relaxed/simple;
	bh=c+59GLf/oXo60d4AM3tT5Dly1CdoHCtus6ztRRar0mY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K9nTJpu1L8sEDCGO4QI8lQaDzD0g+aF4UFr811z0Z7j+iPbOIyyzJih5/JejY4/bziSsq3yMUB9pMLkIPuD6M7ANW0jCfWwjwI0yXbkz9s54Z8lsCstG4AKrZlkqV6yKQooLqMX/F3M3UBo0CDS3barpy3W9jkJalMUtYRbALVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=VJPX2zxa; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-bc09b3d3b06so775866a12.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 04 Dec 2025 12:04:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1764878655; x=1765483455; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qazkzNjoTGNZQrm2wNpnFtC3xWbAXmOxYceHXxLC8bk=;
        b=VJPX2zxal/4iKr8/cGTDh7w/Xab5oHv5ZB2OaZ3sVAS/iQTpAW5UApXsDkjElKHeKx
         J1f7p97vgEQcVU96W5tmyjqMv8C3hX5gDqV973H6fNVKIDOZF3VJ8xh0YtinZwGQVuGM
         t9cGw7SK6d6ZxZvp+Vy6+GEa6t5I5wlxVZRIeg/PxuwlkG4kFu/UlY+GqUfyyKU0XhBA
         dtEC1fbnt54gWO2wlZA6SBa5ac3x4iH2L/TOqHmpUZpSg0UJHcxTdsWg0QRj21BbHZ3B
         HdkFofaQndfOFsjCpCDstftGxoPGb5eKRHJ3hWzNJrRSMdj2De2EAJvROjz+bGbSqesV
         czkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764878655; x=1765483455;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qazkzNjoTGNZQrm2wNpnFtC3xWbAXmOxYceHXxLC8bk=;
        b=v78rPIN34OKYUCMfKtD+f9ClYnBTpfxRybIo1CgTIguYyqutyxV/Y5mx0KJPUHATwF
         tTb5wsRQQVIPGXio/Po0T4hV6ZVGQaTBkumdbmE6882XvCo5UoxAJzFV5u+x1oRgXqaI
         2Fv6lmhnrwon0AKJcFFWYAEasHtBt6/2yE4tUnk9wXZ2gpHRb7bPzp+nPIxVDRXzsRMh
         GXSZzbvYaA6SqYPY/UBthpajKSredE6R3Dm8C8M8A2SXqBCnlwXdfHW+ClYJhbaPdKz4
         Bq70dvAsk61IVvrwPHmzTuLaSp7ftZKor2qFSA2acC3bHdkv8jaWaF1zWCd/nM4XcGjX
         mSsw==
X-Forwarded-Encrypted: i=1; AJvYcCUu5otKy4eN4DVGc+l5F7YahwOviqhtXvRZc2AxgFmHUN/qIhwUnIsfmcVpgYGbv46ZRPl6dqvz7Qoshq5T@vger.kernel.org
X-Gm-Message-State: AOJu0Yxblw+5ipNeQkG7ejrK6eqU9k9JkIQP2wQyurn27aZvbW40IVnZ
	X8GtnEo7Rv7Y0TaYKvcwJ+GMrMTZ6uGIELK+0oERxftzXUw+ux9AQFrqBWHlXZjX7fs=
X-Gm-Gg: ASbGnct71SH+Mk5H+BRfFRdc4rl1BM2bP035boInWoVZGqn25dIEQWx+pn6I8yhLCy0
	T/qRKrU+SJeYPeNrhIRgpqULdj+gZw0PUosMU+n2vn2yrT6kEQ+WXyXZuCI7aNw9m+/nMNXiUsF
	EGZTh30L8y0ogdbqdhTNEeCH9CYv/1UM5O0U1q2Dp8XRPUcg98SCKIhIiCSWb6tkU7Ukl/GBGCP
	U5CeAlkA0GkkFUCe/Hiyz8iTj7+UGc0sAb9JJDLW9aIbi2WwR0sooY47AGQsBvMgeJMh2/CcII0
	NFJp3SLv8k6WT6Yc3pM9QNOr98Tnhdv5Ew9V1V/rA7/l2vIdYy3fV8QnEqAqjCigGt+XmEwRx0d
	XR+pRnHuD8M7YkT4FSbLN0SsmCVlSTYCW8NdoFU4bwGTEaYVV/gCT+DvmCYoch/u7QTWv8Bla2a
	OiVVKPlCIyojPFJhsBetbV
X-Google-Smtp-Source: AGHT+IFp98bHY82tmn1SWytYtV7IsOH4MNT5CrcOIzKcMZAK7rnYCRSLOXMz8X4skJhf2qDKjmrSCw==
X-Received: by 2002:a05:7022:249e:b0:119:e55a:9be6 with SMTP id a92af1059eb24-11df643c373mr2741142c88.2.1764878654709;
        Thu, 04 Dec 2025 12:04:14 -0800 (PST)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11df76e2eefsm10417454c88.6.2025.12.04.12.04.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 12:04:14 -0800 (PST)
From: Deepak Gupta <debug@rivosinc.com>
Date: Thu, 04 Dec 2025 12:03:57 -0800
Subject: [PATCH v24 08/28] riscv/mm: teach pte_mkwrite to manufacture
 shadow stack PTEs
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251204-v5_user_cfi_series-v24-8-ada7a3ba14dc@rivosinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764878635; l=2371;
 i=debug@rivosinc.com; s=20251023; h=from:subject:message-id;
 bh=c+59GLf/oXo60d4AM3tT5Dly1CdoHCtus6ztRRar0mY=;
 b=DBHza92aj+k0BS2czHCo1xp8g9Cp+zSzm46DfBTV4xMmhPpMOTYeBlej3lCSUVel0u+uvkiuX
 hMVROXA+6ouD+BJWbNswx6PxOLIYpQkgCDWYd1oT2RkSzTAuLozzwnl
X-Developer-Key: i=debug@rivosinc.com; a=ed25519;
 pk=O37GQv1thBhZToXyQKdecPDhtWVbEDRQ0RIndijvpjk=

pte_mkwrite creates PTEs with WRITE encodings for underlying arch.
Underlying arch can have two types of writeable mappings. One that can be
written using regular store instructions. Another one that can only be
written using specialized store instructions (like shadow stack stores).
pte_mkwrite can select write PTE encoding based on VMA range (i.e.
VM_SHADOW_STACK)

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Reviewed-by: Zong Li <zong.li@sifive.com>
Tested-by: Andreas Korb <andreas.korb@aisec.fraunhofer.de>
Tested-by: Valentin Haudiquet <valentin.haudiquet@canonical.com>
Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 arch/riscv/include/asm/pgtable.h |  7 +++++++
 arch/riscv/mm/pgtable.c          | 16 ++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index e4eb4657e1b6..b03e8f85221f 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -420,6 +420,10 @@ static inline pte_t pte_wrprotect(pte_t pte)
 
 /* static inline pte_t pte_mkread(pte_t pte) */
 
+struct vm_area_struct;
+pte_t pte_mkwrite(pte_t pte, struct vm_area_struct *vma);
+#define pte_mkwrite pte_mkwrite
+
 static inline pte_t pte_mkwrite_novma(pte_t pte)
 {
 	return __pte(pte_val(pte) | _PAGE_WRITE);
@@ -765,6 +769,9 @@ static inline pmd_t pmd_mkyoung(pmd_t pmd)
 	return pte_pmd(pte_mkyoung(pmd_pte(pmd)));
 }
 
+pmd_t pmd_mkwrite(pmd_t pmd, struct vm_area_struct *vma);
+#define pmd_mkwrite pmd_mkwrite
+
 static inline pmd_t pmd_mkwrite_novma(pmd_t pmd)
 {
 	return pte_pmd(pte_mkwrite_novma(pmd_pte(pmd)));
diff --git a/arch/riscv/mm/pgtable.c b/arch/riscv/mm/pgtable.c
index 8b6c0a112a8d..17a4bd05a02f 100644
--- a/arch/riscv/mm/pgtable.c
+++ b/arch/riscv/mm/pgtable.c
@@ -165,3 +165,19 @@ pud_t pudp_invalidate(struct vm_area_struct *vma, unsigned long address,
 	return old;
 }
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
+
+pte_t pte_mkwrite(pte_t pte, struct vm_area_struct *vma)
+{
+	if (vma->vm_flags & VM_SHADOW_STACK)
+		return pte_mkwrite_shstk(pte);
+
+	return pte_mkwrite_novma(pte);
+}
+
+pmd_t pmd_mkwrite(pmd_t pmd, struct vm_area_struct *vma)
+{
+	if (vma->vm_flags & VM_SHADOW_STACK)
+		return pmd_mkwrite_shstk(pmd);
+
+	return pmd_mkwrite_novma(pmd);
+}

-- 
2.45.0


