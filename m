Return-Path: <linux-fsdevel+bounces-64765-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 55C42BF38E7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 22:57:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7A46B4FD79B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 20:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14335337BA8;
	Mon, 20 Oct 2025 20:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="DHaNxyOU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9DA33372B
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Oct 2025 20:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760993637; cv=none; b=uFXSQlha57WF/Uxai8XCFUau9hH9ZhFJLm1eCv4NvPMEhuu8bilT2o5cnYFMEymHRUTrQQgyInQFXSCEEK1LhY80CsaoeLhpLmQUjZ5QG4ynayrNB9oDqitTawTy4TCAwAQpBnzNptLcRorpTAuRGucrcbgiftUFmdFDP+D0edQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760993637; c=relaxed/simple;
	bh=hYnrlxG2aSy5XgBcW07Fd+5qY0pd1xI872KUOKzj6JI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OsUcWuLvrdlSXpkdOk0URxcvj77UmeF7Fe7S6OHSsOC8E+TlOqpoOq0IvMeqz1/tNIRK4kL8VQU3GnlnTysqapxD4XSe6HY+iQ/b/Gq85xYoFe71Iwm/EOfHBqnSUMrlqsl9a854t9yXsQ1BBdmSKoLKVT9iwYgo5pp9HWomWHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=DHaNxyOU; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-780fc3b181aso2702905b3a.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Oct 2025 13:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1760993632; x=1761598432; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aU5JHaPOPUGgukhD3bad891ElerIE5ocm+VeTPJz1C8=;
        b=DHaNxyOU0Jg1OZuPhTOrCzCGaeA6xt9SyD5jr7gGlMBbLeHCuiEsFJWVV4OxlkcNvh
         wXZE9SWh3LSAcr8jYbM36TsnT4D99yvaiHNJlLt3PV8O6oYSnyKTwYv35rMch+h28Xnh
         GGinLY06WfBDGWs51L+Qc3jWgSm34TknjfnvXkEapZAKMwb/7LqJPo/ArCc91a6ym551
         ZBJVDuY6C1Af8X+VONFos/7I3x8pLhpNvOZSSfh4WE9emHRM/FER6IB7LMLgjku+oMfs
         zfyNWrFHjxmFSOtkta5yniF2Hdq/48fEqsEH2QYQZ6EiltYimA612Q0pFtzDFeChl/4P
         o/BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760993632; x=1761598432;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aU5JHaPOPUGgukhD3bad891ElerIE5ocm+VeTPJz1C8=;
        b=a44wLRPS6ztpAmQCoRTCH+ZaFxbT2MqAen2vcJ/QEM2zO5IwQ3MecK4rtEE+Q4ianu
         8vlsMI/MTdAe140KIFuKpphrHomtIz8OQOjUBNcVaojTrFS4k2mpnq8RMnoegg05ShEF
         98dUpxqPfZiY8gZ6iOlQUqlkhZutrrBalwcWwKTG3zHGFVspSDv8WbE2BNOzmbnWJcFw
         59asBCXB00rvaWQvZWOKyMgVSp1sft4Lv++Y6i8p2rAhacI1bKybIAlf3X1Gtc8KUlWp
         dl9xqsbZMXe0nBHWpJfKWrLMNMSM/MUmuFsPbmzntY6v2GKLTkDBi7IgSGgcQVkoaFFz
         jLwA==
X-Forwarded-Encrypted: i=1; AJvYcCVoZhoFOTeJqXFOOrK7IyPG64AFElAIGVdPIXrYjKWB+lX+UexOJkT/4cvgF+bg1ZHJiwtQpx5UQBFFglFY@vger.kernel.org
X-Gm-Message-State: AOJu0YxxxcUrZrwv42GNGBxc62dgwsSVSzLV/aRUZANcInkN1hn3MZEB
	welo1NTs4UGkx6YDtXEWiAObJ/nZ/DnRCq88++1KOQugOtDukY9ZazZWyXpZgTRtZj8=
X-Gm-Gg: ASbGncsvfRhOzBKYS243tfEMCQjRHluy8O8dMuPxDyPcvXE4ic+RkHotmW3lgQkd0sP
	2rIz+kqumZyLOV8u/QMwy4TDaz/PxTNFvf7Eab4j1Mzgl79neJWkIjWFVl5QnqIfEU1h4sOcTZR
	EHCC6CVD8pqcEtcmqCsIXeH6eFGpS6665hBQTMZcLT8bMgledB/M6AH4ZyCNUmWN0pvTvvKwJs9
	KGtRiqRDtw1oqIgLrOIdXfDlXBPiULfYuboNaC5PnGA5IkX0aFhifu6M+OtYx1i1VkDt2ksEt/j
	BlDv84vikdPHtaJXNk+Y3hYgtd9AQ9TxPDFWp3QFj6o3mrIlD79qwBvNtHrhkjMnJnjhTLOxOl5
	JCKVMIaMDnxCxeJfJujkKXGi6e54KdxSnBn29eD0iG3Z62RaKHsFkZ12kdMPh4wyZ2DCH8kLAAP
	ixM4sSCd6ppDEclzXuNK2suF4oGalZWCM=
X-Google-Smtp-Source: AGHT+IEnU9JmJAW6XUEpBFCvWbUt/eXN7ETKyltouGiw8zgeBwTW8/YUcqQ1OslTqOfhR53w2pN6Cg==
X-Received: by 2002:a05:6a20:7353:b0:2ca:1b5:9d45 with SMTP id adf61e73a8af0-334a8607501mr19932803637.32.1760993632128;
        Mon, 20 Oct 2025 13:53:52 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a22ff1591dsm9453867b3a.7.2025.10.20.13.53.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 13:53:51 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Mon, 20 Oct 2025 13:53:37 -0700
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
Message-Id: <20251020-v5_user_cfi_series-v22-8-9ae5510d1c6f@rivosinc.com>
References: <20251020-v5_user_cfi_series-v22-0-9ae5510d1c6f@rivosinc.com>
In-Reply-To: <20251020-v5_user_cfi_series-v22-0-9ae5510d1c6f@rivosinc.com>
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


