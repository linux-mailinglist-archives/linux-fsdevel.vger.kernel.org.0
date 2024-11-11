Return-Path: <linux-fsdevel+bounces-34306-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87DA79C4838
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 22:39:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B4B3B32688
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 20:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55D731C9EC2;
	Mon, 11 Nov 2024 20:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="iooGap/5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557861C9DE5
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2024 20:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731358460; cv=none; b=SQguWYtofpQ0FNivUbX2Soy8EWVYV4HDce20y384541JrmzWEt2OrTy70AVeH7BfNfXb5CgzIeLbt63SI6GvEXcLvE2p4ZzZKtn6OcZZC0leaoGcZGtJX659y5rOrHCK6wevLwptM46HrLox6y5fBZv/S5JKpR97nrQXM688HNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731358460; c=relaxed/simple;
	bh=4L9Pc+WLf8NU9UEf50b4WKNQdDQT4lrkAVzX//n1GjI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dEh1F7VqSfOhmPxoC87Bmd3KXLmopFQFcSsFknL/LTWiCBnPdNcNJYg0pYN2QhQ6O7FeewGsWDVlxiM+jdAqM7ptHgefQNjzytn6NWBABpyW8BBMmD2ReXu0xuFR8KJSEcX+H+nnCpvD8MS9Fv7lQmepwNXAA3jHjWtyPITUGJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=iooGap/5; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7f45ab88e7fso1007529a12.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2024 12:54:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1731358459; x=1731963259; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I6L9CXOfGC8FGkDgNo32YOnEr2hJuvgG2CDkhLFheFM=;
        b=iooGap/5o1LE+dTTqUCwyZoA6+9S0DS9kKz5o0gqUCXPHbvF0Scgu/e1fhGKOhWTgR
         lrpFCQM2oKDi1s/nVmGYrRB0FDmy+hFj/3VO5F0nCZP/MnfI83/JVgyyWjk8k4JX7HKQ
         MuZL8QFr4JW9F7rmWH+qiZuxDyYIM0/rd5HAo+PzRlsdXlqASzhq3W9FxKdmtv9p8EMH
         F+YlsadP0D4VWWSYEAs6TRlxeNhq6tIrbUN4heYzDsjAiQS7mWKC11rc0sebr+2L2+hk
         XfPV0y3JkLI39k33l5irwBOxuunC82iqTnNTpe7y3XXdyWvQEZse4bE8R/AVBUTD8Tf6
         E/Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731358459; x=1731963259;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I6L9CXOfGC8FGkDgNo32YOnEr2hJuvgG2CDkhLFheFM=;
        b=cCWTtieZtQ4iaIUrxJ9mepnTevkzRm//3Uiwvc09EqlCCjT4mL9zTt6brEcVlxsBmL
         7prwc09PfSEotU0qb7yDKgwY8gNswyjcD7x6TmwWklO2XDqss7xaMWoPb47KWdPdihEy
         4iogyalJivyrPWXm/oTaf10J79G/Jyc53NnXkF3O3xYq9NsgIcVOLFFrxaru0L96bLFD
         0ExLYSZ4PpUH/gkhEq9usWC6idEsB6/cvFbVF5H0iH4zzX41N3pP2MW2p9/e+e88hWVp
         ulTo8skfjdykpDBcecGFFWf6BgDvEdL6YFb4JLPmtcxRgYpM+/wxmjoTFFXVd8rKEMI+
         Pzcg==
X-Forwarded-Encrypted: i=1; AJvYcCUn5j2ezcdxxeMF0x80BScFwaGn2MvWdd9uAResDDEwv/f7d7E28R/ZS9+PUpuGbw4nwCnbcXzuiGXGjv9I@vger.kernel.org
X-Gm-Message-State: AOJu0Yx59ahrbzbWk4O7O524GNcYjHDymHvysNiWYfQJeKSNHBqFfwLT
	/5tJySmCyG7KRwvuTZT4fioXK96VvN1iQPxH7geh1UJj4AUM+nFuLvloejoW+io=
X-Google-Smtp-Source: AGHT+IEjvMy0kDgdhVCgK7uRX+xkeiQXZuQFJUruwKRcfTXpudULSRLKQcZE75uv6i6SPaD/tVV5LA==
X-Received: by 2002:a17:90b:52c3:b0:2e2:e5d0:dabc with SMTP id 98e67ed59e1d1-2e9b171635bmr19132907a91.11.1731358458754;
        Mon, 11 Nov 2024 12:54:18 -0800 (PST)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e9a5fd1534sm9059974a91.42.2024.11.11.12.54.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 12:54:18 -0800 (PST)
From: Deepak Gupta <debug@rivosinc.com>
Date: Mon, 11 Nov 2024 12:53:54 -0800
Subject: [PATCH v8 09/29] riscv mmu: teach pte_mkwrite to manufacture
 shadow stack PTEs
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241111-v5_user_cfi_series-v8-9-dce14aa30207@rivosinc.com>
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

pte_mkwrite creates PTEs with WRITE encodings for underlying arch.
Underlying arch can have two types of writeable mappings. One that can be
written using regular store instructions. Another one that can only be
written using specialized store instructions (like shadow stack stores).
pte_mkwrite can select write PTE encoding based on VMA range (i.e.
VM_SHADOW_STACK)

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/include/asm/pgtable.h |  7 +++++++
 arch/riscv/mm/pgtable.c          | 17 +++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 2c6edc8d04a3..7963ab11d924 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -416,6 +416,10 @@ static inline pte_t pte_wrprotect(pte_t pte)
 
 /* static inline pte_t pte_mkread(pte_t pte) */
 
+struct vm_area_struct;
+pte_t pte_mkwrite(pte_t pte, struct vm_area_struct *vma);
+#define pte_mkwrite pte_mkwrite
+
 static inline pte_t pte_mkwrite_novma(pte_t pte)
 {
 	return __pte(pte_val(pte) | _PAGE_WRITE);
@@ -738,6 +742,9 @@ static inline pmd_t pmd_mkyoung(pmd_t pmd)
 	return pte_pmd(pte_mkyoung(pmd_pte(pmd)));
 }
 
+pmd_t pmd_mkwrite(pmd_t pmd, struct vm_area_struct *vma);
+#define pmd_mkwrite pmd_mkwrite
+
 static inline pmd_t pmd_mkwrite_novma(pmd_t pmd)
 {
 	return pte_pmd(pte_mkwrite_novma(pmd_pte(pmd)));
diff --git a/arch/riscv/mm/pgtable.c b/arch/riscv/mm/pgtable.c
index 4ae67324f992..be5d38546bb3 100644
--- a/arch/riscv/mm/pgtable.c
+++ b/arch/riscv/mm/pgtable.c
@@ -155,3 +155,20 @@ pmd_t pmdp_collapse_flush(struct vm_area_struct *vma,
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
+

-- 
2.45.0


