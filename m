Return-Path: <linux-fsdevel+bounces-50641-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B541BACE303
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 19:18:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1757A173CBD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 17:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5445E21421C;
	Wed,  4 Jun 2025 17:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="AFkwo8kR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE54D2101A0
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Jun 2025 17:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749057397; cv=none; b=dc59agC00wj7/EtjoGSq4RDauKUrPsgrYzmxmgGsNE9Wk3tJtacRMdV5ImcxU27jDrBfJbHUR/qF3Mg3Y5rfA+/sG7rpYVGUBwIfvB8QDpCGwxkT7C0zc0O2s5GO0yvQIGh6XqJ8s3nwNu9yUgFDu6zugIHvyGvVsvQpAm53nDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749057397; c=relaxed/simple;
	bh=5l4eYXK/UGIl+TXQnZwANU66ClnBTNssKdiHYV/yMZ4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AiCzWriL1zXfKGzhOBkbuIhoVyP52dr9Q0f3cEZtJoJbw+owku8ZBh2wuzY7z6NCaxQliPgcOGTZhQZINEpCo63StdyrNLaHBxbsrSk6fCVHZkVfb7EQBCV0a6tHELHek50nXdz0GseBDg0+T54kNXNFyTIfsiw0dW1iwfbW3PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=AFkwo8kR; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b1fd59851baso26237a12.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Jun 2025 10:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1749057395; x=1749662195; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2tvKQDIIBJb26wPDVIJoD2xzubcY8uay1NjKLxC4PFw=;
        b=AFkwo8kRJMjud/rwko8n6NMqRVUEg5eXTYwB2mg8Sz38y1yTr6IMjHYWq7SBPzafXw
         9L4Y16FkzdBoBjQBMj0hUBCii6H73b8EmumPhqYXqRmqumJNeHQbYRLGesVMoj/+/3pO
         nw29qRumIb4h265dL1GE7Br6Seh1mfp80kLWtYdSXCGtp55Z3wmkmwzuos3JIk1UKxmf
         9T4LubxFNgMUyPBdmEL5zxLpYCCPOfVbirRBFV8uo4BweAsfYynFa8GF2xu32NZw5jIh
         zl1hitW5Z7vyEoGZOpfdcw3z2dw6fMbUdBGJldbL9Hg263zyU7iLQWUqh2D4Nu+d6bWZ
         LfwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749057395; x=1749662195;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2tvKQDIIBJb26wPDVIJoD2xzubcY8uay1NjKLxC4PFw=;
        b=fcPYh+QCXG3P/DjtWL48lTHmubkPN/j3y3QoxkEct2/ocCY89VCJXaAxFTU62jqoEu
         WuvjLDKjoyh9egkHJ3L4xoPZdHNbmjChxgdCMmpFoTkFYhYDSM24Dpy6OEeLJWTggIGg
         kKLDjjt673dHadg/aIEf/wSAtxN/khEjqnDPRWCwhbOG3eVv6X6HYocubF/i8v9WBDMT
         v0I6XFRlxfjoig95JLg1w519KT0w1BFhkbzBho/WWPk0NI8TUcS44l43nFc5DzifACrn
         SBxfEYxO8CEU6caC2EoKs84/c97NrhKtJ9e7iklvzhDMV+tZYLTiXrfviTkNy+vvhu4r
         aDjA==
X-Forwarded-Encrypted: i=1; AJvYcCXmZwVqL1fZgqiHpnR4nV8rR4d18eohF8x9I2jarXVJcIQDep5GU2fEH3HXq/xOEbCN+K+QeO4Fyq8F/D1z@vger.kernel.org
X-Gm-Message-State: AOJu0YwFHhdS62UYMBsEI4zsLMnz2YVUb2B8fp0brqIh99RHE2QG0Yer
	FxWhHDJ8ZgPZ02FfeavKwnwrvItPgquLHIh3B3rlrju1PMYOYamdXYoB7ShcZ0z+2z0=
X-Gm-Gg: ASbGnctBcO9jCsLd/XNGjkqmEUpBqgfpeXM/9OZjmqHTjIdRAQp4Tf2p7OzPCpGl5gD
	CUmcO8H2tEgvxJESWgSBjPOSDGuHe1od1mIZpt8YKAPheCRmoKZGTLtglOLnYj6+sre+XOk1dPi
	Lj6qiKfJUBIa0o/A+s8IrF29oSS8xoy8VLTIO8Ug1nHuYTItZpph/O9i0Ye9XnXkPocRHBqQ1Zn
	gWWA+MgUevs0mbK4OKKx1Hq9/xTDVM1H4F+RyAfY0A6lQuylSgZJGbdfiXTw5sKn4JVOlO3q1li
	gxpnE22LRHZAL4uVZrQx/BLIlzMqLEqLQ0KwIdViQf8BxBuJJHeNnBs2yUzpQA62SRcaH+74
X-Google-Smtp-Source: AGHT+IG+Qv2DNy5GUYLSr8qaMd4z1JKIMYQvC0rcwVPQ/+dBpmSSBbz8jQQs3wb6D/V0cK/kK11nfA==
X-Received: by 2002:a17:90b:54cf:b0:311:c5d9:2c79 with SMTP id 98e67ed59e1d1-3130cd31ea9mr4868567a91.21.1749057395003;
        Wed, 04 Jun 2025 10:16:35 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3124e2e9c9fsm9178972a91.30.2025.06.04.10.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 10:16:34 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Wed, 04 Jun 2025 10:15:31 -0700
Subject: [PATCH v17 07/27] riscv/mm: manufacture shadow stack pte
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250604-v5_user_cfi_series-v17-7-4565c2cf869f@rivosinc.com>
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

This patch implements creating shadow stack pte (on riscv). Creating
shadow stack PTE on riscv means that clearing RWX and then setting W=1.

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Reviewed-by: Zong Li <zong.li@sifive.com>
Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 arch/riscv/include/asm/pgtable.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index dba257cc4e2d..f21c888f59eb 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -433,6 +433,11 @@ static inline pte_t pte_mkwrite_novma(pte_t pte)
 	return __pte(pte_val(pte) | _PAGE_WRITE);
 }
 
+static inline pte_t pte_mkwrite_shstk(pte_t pte)
+{
+	return __pte((pte_val(pte) & ~(_PAGE_LEAF)) | _PAGE_WRITE);
+}
+
 /* static inline pte_t pte_mkexec(pte_t pte) */
 
 static inline pte_t pte_mkdirty(pte_t pte)
@@ -778,6 +783,11 @@ static inline pmd_t pmd_mkwrite_novma(pmd_t pmd)
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


