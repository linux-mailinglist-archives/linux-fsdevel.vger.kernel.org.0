Return-Path: <linux-fsdevel+bounces-31382-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 46126995A7E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2024 00:43:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89395B2498A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 22:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C481217913;
	Tue,  8 Oct 2024 22:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="K1BtnKfe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC6921D2B1
	for <linux-fsdevel@vger.kernel.org>; Tue,  8 Oct 2024 22:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728427105; cv=none; b=jPBI8gHJX/TM3kg4T2mLUcjPUhoe9lREcem9S1BKa0TuHrLeqi51dBhvAwwiFr8l7nkdGK9gYODbMEDL8lzsh2cVIC25fxIa4LWID35IijQn49lY3uxJGJMW9Zwj/C4QfenDf+ia6A4yqrG9jGmXZ/4sndd4evP7EMZKmWYWE+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728427105; c=relaxed/simple;
	bh=4L9Pc+WLf8NU9UEf50b4WKNQdDQT4lrkAVzX//n1GjI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e7wbUls/pTIwNFTt4eVd46sDoPAgjDRfQ2+UUJZr3P00BlZ7z6MKtHeG/xx2YZAww12SuCywa6r/G3MiTUUPpzxg5I1LLH2BTcShv0Ul65FOCd7YWhMo8OesJdXPV3tSKI1bkNG304gSLCvgaMk9SnWMusPqlgQL4czRqmfiucY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=K1BtnKfe; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7163489149eso5379077a12.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 08 Oct 2024 15:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1728427104; x=1729031904; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I6L9CXOfGC8FGkDgNo32YOnEr2hJuvgG2CDkhLFheFM=;
        b=K1BtnKfeWz81MGyv0C5IK1Jik1R2M63On5WDFlBzOlZtStvtMv+NR6vThfO2Y4GTaL
         YU5Nxr63/32c31CEXWwdFueY4NeIh//6xXgAt9HIdZVRI4ll/jbomU9elMVFAT1HHNl6
         1wDst5IlXqIjglj2aPYQ91kE1nLupLIAxs5hDGEufmlBSqggpnpdw80yBeLdmDnPyV87
         I/BLS50OwBMCD+TERj+e3q6s5Lpdr4HIrMFQlUz4xk86txLSgVKXG3tEaWdJkYRXyz/n
         Rk/MW0Gx1qJpADz5DNvf53UqkuNl+Y7gLhGSvQxGenKL17yBgtrFJuE7qaqUu3ygzcTz
         8NtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728427104; x=1729031904;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I6L9CXOfGC8FGkDgNo32YOnEr2hJuvgG2CDkhLFheFM=;
        b=jF1VWa/ZqjWWaHuwYIfHfCYNVMbqLe0Kg9DT40X/DeFZw2hP5Pj6g4n2i/U0JkeOOI
         Lytzl3GsQcpzrVd1EqEgrhIju3nEb8mkf0x3Ibn/Em2D/0cVHpdbeYmvxXhBwx8/kXCY
         iFsLtDjGAjrYPi/ghoAEgKb+j62VcjyJbj3pV7ZWfwReH3jH+V5PURAY6mkBdY8wWFii
         b3/Q1JkmfbnSVMfjgHo0rFSY70mrAkDV/OVncz2URgheywGcD+LjmT5qOW36kM/1SPjN
         Mr9oQ5zbHUcIAWu4fWlsjaU/ME3lddTPabUzAeh7fruCjqRDB9BZxVvJY7zp/fZ30YSV
         gKaA==
X-Forwarded-Encrypted: i=1; AJvYcCWzcRFtqwV4ZsE0GmKUh2ZkSEngtxRPDANJWpwU4fTnV3KbAv5PcButu/su5GUbwlhaetbIKajK8L5xkaD3@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy75kOGAP0oCw5tH2ObUSe8iCuYuvoQWAXeVqdjZqLu6Ytyxe5
	47kGPHOCWp1hMbSOTCxsT4gWpEK8n57mojlcVp8cJCFhTFCrMUkNh213FqUU9Yg=
X-Google-Smtp-Source: AGHT+IH2MMc22LEfeLpFr/+vzLpFm6wThOwZwpheAqw6wq1Vnq109QUbVNEO0CejcV+v5vQMgM/88g==
X-Received: by 2002:a05:6a21:1192:b0:1d8:a3ab:720d with SMTP id adf61e73a8af0-1d8a3b5cafamr1049827637.0.1728427103894;
        Tue, 08 Oct 2024 15:38:23 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0ccc4b2sm6591270b3a.45.2024.10.08.15.38.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 15:38:23 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Tue, 08 Oct 2024 15:36:55 -0700
Subject: [PATCH v6 13/33] riscv mmu: teach pte_mkwrite to manufacture
 shadow stack PTEs
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241008-v5_user_cfi_series-v6-13-60d9fe073f37@rivosinc.com>
References: <20241008-v5_user_cfi_series-v6-0-60d9fe073f37@rivosinc.com>
In-Reply-To: <20241008-v5_user_cfi_series-v6-0-60d9fe073f37@rivosinc.com>
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


