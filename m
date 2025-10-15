Return-Path: <linux-fsdevel+bounces-64268-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2393BE00FC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 20:17:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FCF83ABD40
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 18:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7E1C341669;
	Wed, 15 Oct 2025 18:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="Exwb/QXP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0CCA340DB9
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Oct 2025 18:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760552042; cv=none; b=IYS7Ji+pLOeiruJOxI6uzAU52GXCtxh/kyjtvw5Q3ko+iyia6yOJp3czxixluydrpOJGkt6sdvOmNV/qvAp8ewwtuzYKU344MQ+jApXIpZXJIrTx+ZwzU0Loxr6UJPB77kBN/Z/n0q2oCzzQNecqfjsRbAbLqtPiRzS9Fgz+g84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760552042; c=relaxed/simple;
	bh=9AtWvDKQ9q5op9YLRgkrDiWaHEAhrRbEgloHu05lQww=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lTA23LDAKtVhkZ+6qdgX29k1HSEDbGjO+VydUW5naJXWtohx5BfYMBEMyBUienm+6RL39ZgcMgQ3uZkhSMmm9lxZwObyjgPGT2KucOT6DuiCr/e+EKK1YQOhNIE1oFQ6CeNJVx29stoC+Sy3W5XyMlvl5LKPq2JIN63kowk2iV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=Exwb/QXP; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-29091d29fc8so3017205ad.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Oct 2025 11:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1760552039; x=1761156839; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oeDKcuIcO6+2FhxyceVVS2WWiuktyVdq1WpyUni2wlA=;
        b=Exwb/QXPbXfTOGKP7tu8Nf+GnckXTCgO3BYpd7Cp6ZZmF4JBSu7v65V7OQg5628JQh
         mrfP5+WbGWFkv8usSO0tOTQksriHHmb5tatsmPN/qWRpuZ0rZBv2ZNzgaURgJ9O8asIX
         oQqa59/xel+mVz/UP9DgoS3liRs8q3sI8sr8vud2xzFq2GZ9oWJnBa1+Jmj2LCarrFrw
         +H+ZAu3u2G7oy0u/rAi7yXtNm/xumj99wekv3M6e1Fc7YewqajUcJClxNcSqenB0HZU2
         pWYCRNiKDBePIm4hyRYQMOTlANSE8cU3pE8w8EKAQ13buypysM+OTiB333atTIkCOS2O
         Smgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760552039; x=1761156839;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oeDKcuIcO6+2FhxyceVVS2WWiuktyVdq1WpyUni2wlA=;
        b=R4s2N5TH3gKTcMBIYQZeAv8K2Mz21uQYz9XhISTyX6AWqCCongoaAD+1SoGChtYGiq
         Cxnu8fsAOHK4VlphfExhbV/H7up5Oo6CvW4R7Dh9cxgXc2w2dBP3HeEZ147T0Et768UR
         kDacR7xiZJB2I43Im8VWztOl2KZu0pXK7SSC2Ryh26D/y+qRpsAYgkDLGIkTdaTYf/TM
         cAybb90CGnUSEeLJJLSqfi1BUqwq7wmMy339SYJINkE50HQdwt9OeaJdnRJR7B71Jpik
         Rlx/Man3rryqYQZvY5szhQTzVcMJni1m4nUwSF6HWVzjojbZPPTbVktbfWncGrHW4b+8
         ulJA==
X-Forwarded-Encrypted: i=1; AJvYcCUpyM+gg3o7o0uX85vQEgif3T01a77GVdHF85y/cksbYiS9b8+NMnYVRZMrjps8qjezUa2+L+Y0yRyN6CZs@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu2xNBqwTED2EIyh4xJFVvRNtwyPHnjvi9UhUxRfH1d2ZOM/4Y
	xoucEc7T/mmn5qVrXcmgU72wbqvsEK19knNLVqTx2uIzlTBPy8lM+eSsYhvy/11LqGU=
X-Gm-Gg: ASbGncvfxzSo2UNfVZgr0w9NpVN5IsBuN/EADIfDcO6h0kylw1UpQZEZv96+/sR4n2J
	LAt0Fi8CelArefX17re3nUwCU/4LhkOaRv4MJKoqMAE4frw3waO1FgvwhUo53rbSxRl11lh/J40
	pVI4CQi9pUEXU2bSF/5lYKG5eBwzVcXChoSdk/COlyI8sXqziXVo+LUK58jQJV93vF0ccJnszO9
	Ao1MwHsN/EmWlBfNDL/PPAFm0bYi8mGm+WTY2hH8kYkfDvl8+Zszoms01r0c5/PR54f0wC7zJXR
	56Ql21wcG8M7Krcyk+YwMlXnUqwDrK4Ta6KB2J4qY/fglkn3VYDqK8fd5J+4XFJyMF0Ai9QGuYw
	/7WqgKffnqqF4hTlLFgrAxyjLNuiiaAIxdzxFhY+01S6Of0eaup0=
X-Google-Smtp-Source: AGHT+IF7+0siZoxu9qB67nOXjy9vTyzrCE83G46axDJgPfnYJq92ADj9EdTAyl+KZI2DWODagqgyog==
X-Received: by 2002:a17:902:e786:b0:26e:7468:8a99 with SMTP id d9443c01a7336-290272c18e1mr357750345ad.36.1760552038791;
        Wed, 15 Oct 2025 11:13:58 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2909930a72esm3126625ad.21.2025.10.15.11.13.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 11:13:58 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Wed, 15 Oct 2025 11:13:39 -0700
Subject: [PATCH v21 07/28] riscv/mm: manufacture shadow stack pte
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251015-v5_user_cfi_series-v21-7-6a07856e90e7@rivosinc.com>
References: <20251015-v5_user_cfi_series-v21-0-6a07856e90e7@rivosinc.com>
In-Reply-To: <20251015-v5_user_cfi_series-v21-0-6a07856e90e7@rivosinc.com>
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

This patch implements creating shadow stack pte (on riscv). Creating
shadow stack PTE on riscv means that clearing RWX and then setting W=1.

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Reviewed-by: Zong Li <zong.li@sifive.com>
Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 arch/riscv/include/asm/pgtable.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 4c4057a2550e..e4eb4657e1b6 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -425,6 +425,11 @@ static inline pte_t pte_mkwrite_novma(pte_t pte)
 	return __pte(pte_val(pte) | _PAGE_WRITE);
 }
 
+static inline pte_t pte_mkwrite_shstk(pte_t pte)
+{
+	return __pte((pte_val(pte) & ~(_PAGE_LEAF)) | _PAGE_WRITE);
+}
+
 /* static inline pte_t pte_mkexec(pte_t pte) */
 
 static inline pte_t pte_mkdirty(pte_t pte)
@@ -765,6 +770,11 @@ static inline pmd_t pmd_mkwrite_novma(pmd_t pmd)
 	return pte_pmd(pte_mkwrite_novma(pmd_pte(pmd)));
 }
 
+static inline pmd_t pmd_mkwrite_shstk(pmd_t pte)
+{
+	return __pmd((pmd_val(pte) & ~(_PAGE_LEAF)) | _PAGE_WRITE);
+}
+
 static inline pmd_t pmd_wrprotect(pmd_t pmd)
 {
 	return pte_pmd(pte_wrprotect(pmd_pte(pmd)));

-- 
2.43.0


