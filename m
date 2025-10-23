Return-Path: <linux-fsdevel+bounces-65320-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82083C01659
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 15:30:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39D5D3AE991
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 13:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC34B3314D9;
	Thu, 23 Oct 2025 13:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="atGqRQlB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9AFB32B9A9
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Oct 2025 13:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761225957; cv=none; b=UJVquRsGMupbrCF3OCTrBEJMTkdkX2lH4hTBluBq4xbYls3CtX6RphdrBF4sT+sb83aSBTjtD6Uhx2HtuTbamtkSza0LOcNciCGhG0VdEtn8Q7p0nxm8KGD4CKTgPK+WnSY6m467cpRQ2gBQLYItmAg6m/lUuajfL0XO9U/5QW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761225957; c=relaxed/simple;
	bh=hYnrlxG2aSy5XgBcW07Fd+5qY0pd1xI872KUOKzj6JI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gpKNnkkNqe36+2WOwx/ZIrM0wTSJIPP9bn7UI8HAdsC8FMY0uHMJbNsBv9FSZcrzHEkdRKBVMwAPQqN5VRs75v1HVXBKDFBMzqutIyMkW9TG6ENc7KbqeZ7EWzov9981l+E2xbxyqeIt61wLJFl7t2hJcxuuOg+Fc9AqDx0Mig8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=atGqRQlB; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-33d463e79ddso1031211a91.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Oct 2025 06:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1761225955; x=1761830755; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aU5JHaPOPUGgukhD3bad891ElerIE5ocm+VeTPJz1C8=;
        b=atGqRQlBOnY+EU0f/LQqSjMslU7qM0CJpik1DrDAzG7DxzmXpzNnFaPUeXiVBEM7cn
         PQY2rDyH8BQ9zMojPB/FaoEVQww6zY5UdBre/459P6PHgv+PcnAqgiDMzzaT1Wa4t036
         u6xVZf2EJrgbolD4W1vD3+AigeeWek7x75hYaLwwblEM3JxBkkHG+Z0EWLfuSaPDL00F
         na9CO/Rf+wuqXKoHCg9cry2kI9EW1+uVVdaDoXeAYDKvBXBZLNviCXShJ58LWemhoyRG
         OWMkVrYx5kAe05yeduzw8XGMNTp2o4OjlPvQNE/jgKVth/hUmiEya5Mn4HH0cwFR/tQR
         H6gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761225955; x=1761830755;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aU5JHaPOPUGgukhD3bad891ElerIE5ocm+VeTPJz1C8=;
        b=O4yHZuVrJpNx20vHte4ctMF+5QAPThrH0jEzePZlBKKAhRVSRwxZLQsKhEwAu5cw+U
         NkR5Aq4+5CVc3zJqQU6K1g+gUb2GFIbCsEvPv2UoCv77lG/LRcffVg4yl7TRbQ9t4XX3
         pTIhfBKLrrU5oa+g1ItJMrWYbHlvsyRSETKbF3vlWeN8bMDBGCFvjBxP7YXT4gHL5Wvw
         HwfaSdS1+09r9AulUxcII/MkpC1IuC0yK9oEPQNIhCQupLSdxht5L3envKrhaC5q+o8Q
         QsebNZmseNq/SIsDlLJzm46/ESbDZ013bsD3rXuZnGYAVy3anEEHTg3i1DTEAa6nUElO
         p15g==
X-Forwarded-Encrypted: i=1; AJvYcCWHaizGeCas2lT5atU0rqX42yHLUD+crEi8HzlcME1MXRwNlZ/ItfJPUZEUUNd3vOyu0E/etOhcTtgj79uG@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk2Ka+sF165OFXqbCvG/YIUvApZIs1qqsRvHBEp/iLfIDHD5OD
	9oDEko4coUMJrgkkqEK8hcoergQw5WQ+/VGk3S7r5cRGEvvoLkpy7UvDWQwoU2OO4iw=
X-Gm-Gg: ASbGncvLhJJlIJNvcI58ygeGlhQlJDumEihqJ9r0ldd2fE4H9VAKMejYjEjCFki9en0
	GoQHaoY2SIJyy5j5twLTlVbqcox6d1MGZKKRoHcWIzeH3FxMFHVX/IhcT0eGAOSTT6+51HK0vY0
	j3j1rDM95ONsufg3YrtacRTKT2ys0mUMhP8enOGFvpR9AcmB6vSbn5T2Eqkf7Ue/pxiFzi1fM0M
	3/Xo66loCz49Qz9Ds5eAywTyuSbiwuSpo/XODLC7NJLyYsPGW6Kj/jJmMw1Yob97wXOZ9IKl7uh
	CdXcRV4VRz3CWls1j+O/JhxqKOgdFAUQzcLcwkqks9uVUg+vwB/JxAYQEXo4McU0hw3/dVp3xdX
	VvA3wEHyEicadyKNAT7bn2rkImRHdHZ5MsxHOQC72/utjyeTKLcQpxGP0XW3Uz+j8AWiW/SLJxC
	UTDNknXeMoHg==
X-Google-Smtp-Source: AGHT+IHdVVJz5j5gdwIs7i1ckupc3MWiBeucKHlxMmPwS/HD5Gcn1QAjsoFkXcbrRaTvtAeB6lGYFA==
X-Received: by 2002:a17:902:fc8e:b0:267:ed5e:c902 with SMTP id d9443c01a7336-290c9cbcc96mr331173865ad.20.1761225955000;
        Thu, 23 Oct 2025 06:25:55 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946e23e4b3sm23432035ad.103.2025.10.23.06.25.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 06:25:54 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Thu, 23 Oct 2025 06:25:37 -0700
Subject: [PATCH v22 08/28] riscv/mm: teach pte_mkwrite to manufacture
 shadow stack PTEs
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251023-v5_user_cfi_series-v22-8-1d53ce35d8fd@rivosinc.com>
References: <20251023-v5_user_cfi_series-v22-0-1d53ce35d8fd@rivosinc.com>
In-Reply-To: <20251023-v5_user_cfi_series-v22-0-1d53ce35d8fd@rivosinc.com>
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
2.43.0


