Return-Path: <linux-fsdevel+bounces-50642-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B695ACE309
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 19:19:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC3221897D8A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 17:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42BE622B8A9;
	Wed,  4 Jun 2025 17:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Tg/7NlgR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62572101A0
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Jun 2025 17:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749057400; cv=none; b=LrA94AA1etu9rOk2oGHu6hid685PfAZvWnKIAK0cjrZVXXSiFKz4Y/8zYLYx9GPrP0tkwN0Q9mUepSma/t6VxJlYuEL2QcfPspT4FTW9LvHSnOV0g9bhd3RwKcaCZ5kDSK5PR5YD+S2Yw8Bxp5F3MDSJI7eFG5WZe02tjT7CnAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749057400; c=relaxed/simple;
	bh=sfs/voBRgEO0N2IxC4EipgroXAUwYP7ftsvLbUORtCw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F/74ZHOz4SDVr1dWVTeM7YYRMR1n/a86UApsCXBOQkTu5jE4f/ZD0jQOz6A6qoQXuCW03/C+RhcaP9EhyM4usDZWEjEYd0PsKhbwk8E4A5oMT9egdMGN1XFKgXXY/sVdsHojss7AkoaB/Djrk/rX52rV0/OmEl5sI+h9L1zFV4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=Tg/7NlgR; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-23526264386so608555ad.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Jun 2025 10:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1749057398; x=1749662198; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RWhABZTC7HgMOVZUdFo2P0cmdg9cGlaFRd3WQ+8L7gE=;
        b=Tg/7NlgROD1tWblZMmMRK0vAHPpTgvb0aSzjnTE80f7xZObh0ut1lgIIMa4jLMj/hq
         X3Bv82f7ydU30tSttR9NUxsYQssAvX6MP+00sf8px+aVEN5QhalnkCZRhHevs19TrWOa
         /RUu6CFBds3CznmXTUc2hc07/MMYqJHlfNDzipfLMp6BcFh3NQiPytfMm+DcruXVVCr1
         9zeptFYKAIe+hx6Wyc+zdDBgvtuhZtfhydQuJJudafkar+IEVR3IeB+u+BEWD0N0f24u
         RxzQ0d8evm2MB/yIuibSf9S8Yv5MeuFBHeVjvN+xKsgQgrSJybw6Qk2Qo6n8Nn+Es+48
         S4yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749057398; x=1749662198;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RWhABZTC7HgMOVZUdFo2P0cmdg9cGlaFRd3WQ+8L7gE=;
        b=va2Fni1+yYZGcsr6Co0Gv1cBrYZe0GuRB3sIqP4N/vCU8u8kh19t7ydZC+kB39p9SA
         gBM47tlSNeLFdCWEfqpoXMb5sCuYKHEHRvfxvpdEeQmJOZ54ZIv91Aus3IOj33eAlbqf
         Uj5T1shOLzzSfs6gK1PIcRuqzjnIo00zk5BCBehjCzWZETtDsRv3xTCZbsKKJJWAuiT9
         eVPOe22rw+RD06XoUCGmGPaomwRX932zSIhP/aI32I4eAiWNJ2GcqMltkYa0mbfBL9XE
         JSEaqR/fp0jvVZqjQH8TaOLo2G5K4KHuXeiVIXklHtFqTkkiIZF1OZVBkNBu8lu4FlvC
         623g==
X-Forwarded-Encrypted: i=1; AJvYcCXqVwT2IIluDFvr3YgGKFlj0wi1IKiVNtD2XfzIKjwyYZqq34kk+AGq7pXghDDwTwTzwLHD/Uy7ZlysAG1I@vger.kernel.org
X-Gm-Message-State: AOJu0YzTY6Fc5W5tQsJv4S5s1Oz6t3bFykl+Vcrpxuyd/t3HkVunHWT+
	tQ/ZJgtQoPzScV8yqL2QpRWZND9u3nsJmGgiKF47Cco2KFod0vMZNCjeBsJF/jbze/A=
X-Gm-Gg: ASbGncu0dA4qOpQM7shoQq7G9etyNiXCyo0bmMDl5jOhuQX4dBV4ZWodDCZVozbbGGG
	mWqgJng/NegItxc5K4fYmvCwvzk5WTTlRvJ1Di4PfQY3JcF2bWnjTtIQRcwxpJhvCt4q30My2Oz
	ELoLVLgmRvbrVAUUvGCsImIy22MIMLdMuxk6Fo4gW/h9m2JQ+lBtWYf5x8b72aD574ui0pzv85u
	KYM11rA5qen5u8z/Yjg/oP9dfhgAIQ2T12kx4oXOtLF3LqgyjAJO32iPVGpfSJ3omBPvZ8ssBVg
	IRrCOycAiVS2Uls+CkAWQAcOk+bIYbvJQAp+gkdyg4dwvam2Js2pAOs7pPxGRg==
X-Google-Smtp-Source: AGHT+IESzgVoI6jsn8EBaGsznchFbfhdmr9dOihFSf5lgEfKGzXoOOTnsQHJIuLLab2X/wZNB3LJLg==
X-Received: by 2002:a17:903:3d0b:b0:234:a033:b6f6 with SMTP id d9443c01a7336-235e11cb901mr49065825ad.31.1749057398132;
        Wed, 04 Jun 2025 10:16:38 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3124e2e9c9fsm9178972a91.30.2025.06.04.10.16.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 10:16:37 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Wed, 04 Jun 2025 10:15:32 -0700
Subject: [PATCH v17 08/27] riscv/mm: teach pte_mkwrite to manufacture
 shadow stack PTEs
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250604-v5_user_cfi_series-v17-8-4565c2cf869f@rivosinc.com>
References: <20250604-v5_user_cfi_series-v17-0-4565c2cf869f@rivosinc.com>
In-Reply-To: <20250604-v5_user_cfi_series-v17-0-4565c2cf869f@rivosinc.com>
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
 Benno Lossin <benno.lossin@proton.me>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>
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

pte_mkwrite creates PTEs with WRITE encodings for underlying arch.
Underlying arch can have two types of writeable mappings. One that can be
written using regular store instructions. Another one that can only be
written using specialized store instructions (like shadow stack stores).
pte_mkwrite can select write PTE encoding based on VMA range (i.e.
VM_SHADOW_STACK)

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Reviewed-by: Zong Li <zong.li@sifive.com>
Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 arch/riscv/include/asm/pgtable.h |  7 +++++++
 arch/riscv/mm/pgtable.c          | 16 ++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index f21c888f59eb..60d4821627d2 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -428,6 +428,10 @@ static inline pte_t pte_wrprotect(pte_t pte)
 
 /* static inline pte_t pte_mkread(pte_t pte) */
 
+struct vm_area_struct;
+pte_t pte_mkwrite(pte_t pte, struct vm_area_struct *vma);
+#define pte_mkwrite pte_mkwrite
+
 static inline pte_t pte_mkwrite_novma(pte_t pte)
 {
 	return __pte(pte_val(pte) | _PAGE_WRITE);
@@ -778,6 +782,9 @@ static inline pmd_t pmd_mkyoung(pmd_t pmd)
 	return pte_pmd(pte_mkyoung(pmd_pte(pmd)));
 }
 
+pmd_t pmd_mkwrite(pmd_t pmd, struct vm_area_struct *vma);
+#define pmd_mkwrite pmd_mkwrite
+
 static inline pmd_t pmd_mkwrite_novma(pmd_t pmd)
 {
 	return pte_pmd(pte_mkwrite_novma(pmd_pte(pmd)));
diff --git a/arch/riscv/mm/pgtable.c b/arch/riscv/mm/pgtable.c
index 4ae67324f992..0bedf6523108 100644
--- a/arch/riscv/mm/pgtable.c
+++ b/arch/riscv/mm/pgtable.c
@@ -155,3 +155,19 @@ pmd_t pmdp_collapse_flush(struct vm_area_struct *vma,
 	return pmd;
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
2.43.0


