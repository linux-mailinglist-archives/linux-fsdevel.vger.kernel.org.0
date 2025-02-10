Return-Path: <linux-fsdevel+bounces-41459-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED9F0A2FA35
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 21:30:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29A961880395
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 20:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70FF2257AE5;
	Mon, 10 Feb 2025 20:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="bdZGmsNC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1437D256C6B
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Feb 2025 20:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739219224; cv=none; b=dufh/T7xCVKDRqj9njVnVW4Vxfb22R87OmFEuHE8iiC43NbxMmvgJ4iubc08+83U9k9/aaifoYLkU72CVojYq6zQMNz6JAapGDMuF7vIOIi3eiwErtaxS/X+bJ9jF4ElQgQu/CjC8U1QgkUoeA6QiZ86UO3RTHsKLL2iAzL+alk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739219224; c=relaxed/simple;
	bh=HOQqOSPO+MhBbccjb2UbKqhOT3MYkxspDNQyPTpGYhw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qjVVdVn+R3VyvHXQuy9A4xnZ1guxiAI3EbDiavsZ/GF8bbkzrw/G8QM/pz6ajq8/UCivV+neApnLaFNQXlNrb8uMq20sXRfgn8uPnIHAGHAAt4EEdyULSNMOWrUjDUfFyUVF1NfvpTg/g4RKRv/rIQa5CH+T43dLCWKnfPHR50E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=bdZGmsNC; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-21f44e7eae4so77810845ad.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Feb 2025 12:27:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1739219222; x=1739824022; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WPde6NcIQ47rHbegQG8dPMP+orPth983zEAPX8ktkAY=;
        b=bdZGmsNCbRfHq+wwkLL449aLVBt/zCKaWvM0i5+x49wRi+u+0XoYUc6IizqI+m8OXb
         qJ9HUlwDSG/EWWyR0t1VqieUZkQ/gByK0EKp60yXnQEbNFMW8MKQJf5lue2dodRIIfmL
         LQiYykIP+9XttRSVmw1kR6QoRoeqcLJY4Lav0UqYxAKGajf806AWum4rMXEmDjfEd1Mn
         V18D2od3yvANtzqh9k1QC5zGAJR2yfro/+tzcf8T/4zWOJcbKQVAF8AiMP7eQyBHquu8
         zg+J3nvVlfAhjqfDyqY73DPN8TZOr5lYeDjRgr53TG9WRAIsnWa+LwYXKzlSgAPElyor
         ls6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739219222; x=1739824022;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WPde6NcIQ47rHbegQG8dPMP+orPth983zEAPX8ktkAY=;
        b=ukr95omZI8iX3dgjSV6Q3z4TrVTXWVB2xozGoTr/sOuBUN/950ILqkARfGT6kjC4H8
         AbMTPc5z4WbFHCCbAk6cguEn6HHjfBLGyd4sm+6xYs/Hw2GHdc8BOo8dysOsbhJNQ18S
         2CWOZFyDILoBnO0EutujPgXfNlTqEpkve5C/uWkAn2vFItAeZWUAYuNhAP9pyBDcdb2r
         hZd5drRbicYALFkEsM7tMX5BJYMOCMoe4JsGJGaiZlgkqwgxC9SiLLj0glOTurXIdkMy
         /2XKY3xpBYJ4GU2R7Kjj0NL1jp79G9hNNF6tYjbx0r6FvHYRPo/QawW8kTpwLVDjzsYr
         5Ncw==
X-Forwarded-Encrypted: i=1; AJvYcCUjWcr4qX012rlROPomZwfursyIC+pYqZ1D+MyRerTXfmeJ90bjnsbjSIiRZJyZNOEAmi7RH4nCH0xEtFul@vger.kernel.org
X-Gm-Message-State: AOJu0YzvdI4QeArp6QUMB5x7hsrIWJRXpItAF992lU9phb31a3GdluZl
	jaV5LuXp36ylHzqjx2kskM8cwjynBu23MN5BLObhystmC49iFerRWaVpte9QLE3/5Em9FQtYD09
	f
X-Gm-Gg: ASbGncthoZ8a3rzWoOpU+Ztw8Lj3u5Z0L2QyJw2PdS2/S5TtfbAP7MTCFtYyOt5zhsd
	NtxSQSswCvRvUzE3nHxeE4YeVpANmr/Wv5gjJp0TFxiiycpXk+Fq1jrK1Iw5xKhvfeI4AKad8wP
	66vuaWz5vP0xnQAQZaBBMfCz+8DCEesNNRrnDY4bxSGnBVlFi9JLjelUkmMByKAgeUNFYY3uZbB
	h06leA/ZoM0hP2PSlc+l2473MJMmSyQ380Eu+KKZhrgqNGWoXIhtozl4UsOgMBBOwykvvlpL4wv
	IPj9kAZDDEsV1TYEoQApTM7rHw==
X-Google-Smtp-Source: AGHT+IGkck8QMdE2zF0rHgCttuOewb5gUafKkLZkDOmgM8iUcqpClnt2HEbL9+VvYLlypifzjE6CDA==
X-Received: by 2002:a17:902:f687:b0:21f:4479:a34d with SMTP id d9443c01a7336-21f4e6bf3f3mr236952035ad.12.1739219221922;
        Mon, 10 Feb 2025 12:27:01 -0800 (PST)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3687c187sm83711555ad.168.2025.02.10.12.26.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 12:27:01 -0800 (PST)
From: Deepak Gupta <debug@rivosinc.com>
Date: Mon, 10 Feb 2025 12:26:41 -0800
Subject: [PATCH v10 08/27] riscv mmu: teach pte_mkwrite to manufacture
 shadow stack PTEs
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250210-v5_user_cfi_series-v10-8-163dcfa31c60@rivosinc.com>
References: <20250210-v5_user_cfi_series-v10-0-163dcfa31c60@rivosinc.com>
In-Reply-To: <20250210-v5_user_cfi_series-v10-0-163dcfa31c60@rivosinc.com>
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


