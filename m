Return-Path: <linux-fsdevel+bounces-40874-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3649EA280DB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 02:24:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E86A2188175C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 01:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B557522ACD2;
	Wed,  5 Feb 2025 01:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="GYWuKvhE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217E022A7F7
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Feb 2025 01:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738718532; cv=none; b=M6OVZ5ei3bmZdIFGCxmaulrbQTKbpw0Y19fvpiv/Gef4wopIWvwXL74+/4K6mxQppY5yqIJyN5CcM68z0UO3uZehoO6UOzRXYBWFW39uhbFYIzbuyYJiYUAGpt7ZEkMMgO8Wz52r/Oy3C4EDtU38RkMtV6Mq75YL/BQTTBdqKL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738718532; c=relaxed/simple;
	bh=HOQqOSPO+MhBbccjb2UbKqhOT3MYkxspDNQyPTpGYhw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GatooCodTGTfd1A+HyqnT+JQAjhyN2teZbKPlIhkSHdp9gENw4Y9miDdU+puDiWKKnDS0fWTgejjyUB3E3BLMzVSmLTfUSRpYnSYu5T0IvRYbaiPuE/rRQEl896i2zLkCdsNcHjbpbxB49BYyICZ4Y8aLULMu++f1WDaxcNp5fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=GYWuKvhE; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2f9dbd7d80dso907745a91.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Feb 2025 17:22:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1738718529; x=1739323329; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WPde6NcIQ47rHbegQG8dPMP+orPth983zEAPX8ktkAY=;
        b=GYWuKvhE5q6kewHJL2AeIOOIlbys8wkXYWo16hj7BUaqIY03Eod2piqVd+ZsLyjuEG
         XTQuQDJNVQEvwS3RSPWMFVbeXUlX6w00Akc0c7wVcGs1nJGa9I+bb68IYVacK3klMqvn
         oVgAnQAn0gurFpjdq1MdlYYFsKO2XkzLxSZStYgbzgnHL3y4OsgjQf6EK2Atv86K/Agd
         30AICNnrIODMm1QtigZ0R29NyARO978AdDG72LXvUUWmEhhsZ1Y2OMQagb59O/jXGgVn
         dVGloyM0+1Gez+hSN62xGySydNKbomuA1jzk88uHevbjfgy38d2qsq4ftKq202byhT9d
         s4eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738718529; x=1739323329;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WPde6NcIQ47rHbegQG8dPMP+orPth983zEAPX8ktkAY=;
        b=j9roUp+ZHxY8Mo5HPxonlY6W+N6BuTFHXMiuISiy/KsOD3RWnkb7EKbAyil8Ihky1k
         rgslwkbalYOzLUC7Hu8Uewy/EhO+6pA6lrtowGwCjHxo1v1Umjd0b1Nif7pD87d+KLaX
         eJYl4UhJ8slPd14kAWYqFithHZUMTdeKY7QdtqCnq++PqZOp2kjoS2fdaFSZwMA2BVOi
         3w7tQRKMSfx6nxJ+B1HVTTShhhYUJ0Y9FAGscdVxzGX7xcgLxnLHesxqTuOaY/wAJFJ4
         BnvzMnzIx9hw6PmpNbO2cBbnC12L2gxx921DvT2bFCPnvR6r1Zhi/7gLQUXBeeGe5xT8
         Slaw==
X-Forwarded-Encrypted: i=1; AJvYcCU458eawpT6FlvMt6wGvn4A+Pov4AHvdWrDrmM1bP8SBZlT/jnnBUNPifnK7+JxFdsgiGHhPoVZqAKN2ydT@vger.kernel.org
X-Gm-Message-State: AOJu0YxIjtnk2H5PneQy7zIwLuw8dWn560S168kveWTETjuiMFemgXwd
	of6d8v87S0Cyt3+sZL49ndJA+wzceO+n0PO8J7eexZLvBabEtWW/lD+ih0OHYPg=
X-Gm-Gg: ASbGncv5vy2nl/TSaWEfam/TYgwbtnYTse5BsFi2PW5RIK8QdNkRTsNGsgQppqXYI3v
	+ceb8jW5iMRLChgBs9BV+QhhkcpRfdDaTKDlERinhoVAJilqzd6Gh4O5zynitDGiDOIJ/H/nRbV
	FexkMbEAvmFIXSXkJnY6vhBm5+Gg1EK9RGaL4DSmq9f6G7Mfm/AERfBRs9BX9AW0qB7V/dyHSll
	SJFfcxdrSuuxAJTlTkZBm0EuWAqESTxLuW288TQCkegNJoZNI1g5TEuuSvDQJTdg+eqdPvBmY3z
	9AWWACOzqKRhu70A8KA50mkauw==
X-Google-Smtp-Source: AGHT+IEPr/jAZdU1BeAv0MTLO4+mRSsOemI+fwwJ0UmsHYAhZKBwL5jRXw2/FSsvJQ9vrjQzGW+zkw==
X-Received: by 2002:a05:6a00:35cb:b0:72d:8fa2:9999 with SMTP id d2e1a72fcca58-73035140b35mr1685541b3a.11.1738718529305;
        Tue, 04 Feb 2025 17:22:09 -0800 (PST)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72fe69cec0fsm11457202b3a.137.2025.02.04.17.22.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 17:22:08 -0800 (PST)
From: Deepak Gupta <debug@rivosinc.com>
Date: Tue, 04 Feb 2025 17:21:55 -0800
Subject: [PATCH v9 08/26] riscv mmu: teach pte_mkwrite to manufacture
 shadow stack PTEs
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250204-v5_user_cfi_series-v9-8-b37a49c5205c@rivosinc.com>
References: <20250204-v5_user_cfi_series-v9-0-b37a49c5205c@rivosinc.com>
In-Reply-To: <20250204-v5_user_cfi_series-v9-0-b37a49c5205c@rivosinc.com>
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
index ede43185ffdf..ccd2fa34afb8 100644
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
@@ -749,6 +753,9 @@ static inline pmd_t pmd_mkyoung(pmd_t pmd)
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
2.34.1


