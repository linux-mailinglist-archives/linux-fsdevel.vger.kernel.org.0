Return-Path: <linux-fsdevel+bounces-70714-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A3D2CA557D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 04 Dec 2025 21:33:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4A70A30C5310
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Dec 2025 20:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E1D34E744;
	Thu,  4 Dec 2025 20:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="M9M46Yg7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E279342CA9
	for <linux-fsdevel@vger.kernel.org>; Thu,  4 Dec 2025 20:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764878667; cv=none; b=ZySoNS4AXRgFai7JBRShA4xEZnaADwRdJsqjyMNv+N/bz6ixT/Ml+4dCTvcjziYZSkwSi4PvpQKctEOhZuXmK8NGL7Kw/DKb2bmXQu0UIPkTcchtlOLWzUhpS6ig7Zg1nIavTYi24Jv4wgAVweNqeWYReWEHubBb0/6VdiTgc4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764878667; c=relaxed/simple;
	bh=DJZ2aJIoeyTvFOiDWAJGj4EuG7hZunP7odYpwBb+3MA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CVpdFQs3+ttdCUrq6g/ba2zMnI7Qdgf5PBivYK3xasz3zG9a6Ed/xLyGHETIVTvFWAsuBww+imWI9wcMShaPc39J4hit8qefRfgApKXvp6YMoxomPBmgj3sn9yPnsGMLYzYq3cD9KDzYGUo6vxAF1jrZTCmuXEevpYnLUBKZOgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=M9M46Yg7; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7b9387df58cso2092875b3a.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 04 Dec 2025 12:04:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1764878657; x=1765483457; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BhzOXQIeKPGphLxrrOEUt0Oa58R/DXqd+aRrNPmfj+E=;
        b=M9M46Yg7dqCFRbT/CsSjyAedvInlMXiwV3ScungFVtySwoPDka5xuAgtAyhTtZIosi
         Zl6XUSigSQu1ATv0AcQUiO5PqlM/ZTSdI1HnLfF8PaLOTZSlKKu22kLv0kpLkuSZ4X0T
         d6YKAZr1/ObWxdF59Y2hvCG98mIzcVPwTIpSgOzXL83g8NXv8DdNk+zB6zsPYoXsItMg
         hUcsKSfGhOL660HHLRrDfD6RXmx68LQ+VPyUB4Sj8/Qm2qNZBJYKMpUg0Ysh8Xm4dWqO
         EYFXB1JTqHaYM5rVM1H5FzL3pm6YdFW9eCyAyTIUrQ/qYMU+tEGjps5QPlNF0aa6njIi
         K1lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764878657; x=1765483457;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BhzOXQIeKPGphLxrrOEUt0Oa58R/DXqd+aRrNPmfj+E=;
        b=Nyg5PU6uMivr5pZlG4kLQWZak2y8WO6VdLG/9jl0g3b1Da8xmwkTECrzkwhx8iM58B
         xeBMIsNQVnYDjhVKMbRdd4q9mYhIyNs/VkrioyGH/XwXPfyK1UC4t0TlL5dzGhqOpLhY
         14E4OwbHkgTDSqVsCO5+zqfhrrIfO4+dROaawSnlXr0zTdC1m/FepD9Xp4DNMBPtgqDC
         NBn4HFQj8Ma/eV/Zg0kRPPxFBbcte5OiQBZsB3YL0JbrwH4Y34C3/5ZDFK+XTM4dH66q
         ZC35HkG7bfgu+HyEju/UbguIGj9ziA6TwPiBRYowEk1dl5HjPdKM2SwTyjNXmAmc3XAG
         7lRA==
X-Forwarded-Encrypted: i=1; AJvYcCW7mby2jpddMS9uk4DQ0qssqiHRoZeTeZOuLBTMLBksuq8nIOGDCNc0Nfk6lOIoUBTWKThYJ02sboDBmMAP@vger.kernel.org
X-Gm-Message-State: AOJu0YxhejSopdQfFtSqVLjutUy6I5JDnDyhKps+Gm2lIe9prxl/V16/
	CBl7O4flE/pdldBOu8aB9a7JaXW9IRem9uETWWGpdj0VJyZn1VDcmSiqUq95en6FCmI=
X-Gm-Gg: ASbGncvgl+L33r9t5aSc1Sqb47fEbkxy53hqk99LB+de1vLx9IvVPTA/shfrHllgnFw
	+Tu5ywnpZMEN36pHJY2EKRVrhIkDE0F86yZ4i54LZrhwnww2HY/JgJe/NCgWEEn7yalIO9htttA
	PNyueMO+mBryh24bO0pRqftW9eRZqwLW+yj+OkY800ZgPrhB+YbeJERdOhyyHuEIcmkjmngVlk8
	nJVJ/FpYHaJxj+3EBRLRn/ZUN1traOxYIUtQ1y3jPTw/KKZZ1sberJ0fHCrSroLIzp/ofYww1vM
	9Xjh54bBaKwm7SRq7LCIyaVNnSvaBs3fvN3tuj19VWDUjdUyv5HjFrrmouomZ7JlpbTyY1oUGL0
	ybjJOyIbF4P8XuN48z4oH3OCMBuxdeiZUtR//u0BsXFEFPCWDRznDGXwkyMDHM6MgWI8PuSm/1p
	o31apWlgFNkLEv9ALr2gYK
X-Google-Smtp-Source: AGHT+IGFh0sV8K3YM30SGR/TeRRCbuWQKSsLII8uaKG0pjWDWdO9phApXXsMABddoI0pDrEfs2joRg==
X-Received: by 2002:a05:7022:608e:b0:11b:c1ab:bdd4 with SMTP id a92af1059eb24-11df64af432mr3149166c88.38.1764878656793;
        Thu, 04 Dec 2025 12:04:16 -0800 (PST)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11df76e2eefsm10417454c88.6.2025.12.04.12.04.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 12:04:16 -0800 (PST)
From: Deepak Gupta <debug@rivosinc.com>
Date: Thu, 04 Dec 2025 12:03:58 -0800
Subject: [PATCH v24 09/28] riscv/mm: write protect and shadow stack
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251204-v5_user_cfi_series-v24-9-ada7a3ba14dc@rivosinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764878635; l=2600;
 i=debug@rivosinc.com; s=20251023; h=from:subject:message-id;
 bh=DJZ2aJIoeyTvFOiDWAJGj4EuG7hZunP7odYpwBb+3MA=;
 b=V44PsHIMigORyGMx65St1otJQpXcs/c8txcdP6sR8t3hFePxiBSJJTUudJDieXaQDuwFWIgx0
 Fsn4n/4NJ/rDp/0y8KXbf/bVJBdFeXiZH1dd2WqsJ6zjcjREaYj7YBZ
X-Developer-Key: i=debug@rivosinc.com; a=ed25519;
 pk=O37GQv1thBhZToXyQKdecPDhtWVbEDRQ0RIndijvpjk=

`fork` implements copy on write (COW) by making pages readonly in child
and parent both.

ptep_set_wrprotect and pte_wrprotect clears _PAGE_WRITE in PTE.
Assumption is that page is readable and on fault copy on write happens.

To implement COW on shadow stack pages, clearing up W bit makes them XWR =
000. This will result in wrong PTE setting which says no perms but V=1 and
PFN field pointing to final page. Instead desired behavior is to turn it
into a readable page, take an access (load/store) fault on sspush/sspop
(shadow stack) and then perform COW on such pages. This way regular reads
would still be allowed and not lead to COW maintaining current behavior
of COW on non-shadow stack but writeable memory.

On the other hand it doesn't interfere with existing COW for read-write
memory. Assumption is always that _PAGE_READ must have been set and thus
setting _PAGE_READ is harmless.

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Reviewed-by: Zong Li <zong.li@sifive.com>
Tested-by: Andreas Korb <andreas.korb@aisec.fraunhofer.de>
Tested-by: Valentin Haudiquet <valentin.haudiquet@canonical.com>
Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 arch/riscv/include/asm/pgtable.h | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index b03e8f85221f..df4a04b64944 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -415,7 +415,7 @@ static inline int pte_special(pte_t pte)
 
 static inline pte_t pte_wrprotect(pte_t pte)
 {
-	return __pte(pte_val(pte) & ~(_PAGE_WRITE));
+	return __pte((pte_val(pte) & ~(_PAGE_WRITE)) | (_PAGE_READ));
 }
 
 /* static inline pte_t pte_mkread(pte_t pte) */
@@ -611,7 +611,15 @@ static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
 static inline void ptep_set_wrprotect(struct mm_struct *mm,
 				      unsigned long address, pte_t *ptep)
 {
-	atomic_long_and(~(unsigned long)_PAGE_WRITE, (atomic_long_t *)ptep);
+	pte_t read_pte = READ_ONCE(*ptep);
+	/*
+	 * ptep_set_wrprotect can be called for shadow stack ranges too.
+	 * shadow stack memory is XWR = 010 and thus clearing _PAGE_WRITE will lead to
+	 * encoding 000b which is wrong encoding with V = 1. This should lead to page fault
+	 * but we dont want this wrong configuration to be set in page tables.
+	 */
+	atomic_long_set((atomic_long_t *)ptep,
+			((pte_val(read_pte) & ~(unsigned long)_PAGE_WRITE) | _PAGE_READ));
 }
 
 #define __HAVE_ARCH_PTEP_CLEAR_YOUNG_FLUSH

-- 
2.45.0


