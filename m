Return-Path: <linux-fsdevel+bounces-70861-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB9ACA91C8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 05 Dec 2025 20:43:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C8F91302282A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Dec 2025 19:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A86234DCE2;
	Fri,  5 Dec 2025 18:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="IKpEBYZB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7840C34A3C4
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Dec 2025 18:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764959834; cv=none; b=MwfdD0sLV4oKjPGtPT/+gxLQNMh0PEOu/buzo/EOxVelF0wgcX73+XaQUkxehPlscR94IsCIgHix62HqYga6Tw1LwYvz1jTEY9zl+OjGrGJRmFhlEOqVwbOUShQx6hBTQYftHL/s/bN7uiy0F3ntQOK31u6ROaTHPaS+XXiLarA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764959834; c=relaxed/simple;
	bh=DJZ2aJIoeyTvFOiDWAJGj4EuG7hZunP7odYpwBb+3MA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J4lbCbA/y1VhYvZbU2nZejraxLR9EHIqVGfeEbdslrfoYdwNIIDmYzLaAZstJmo9AqpwA2XW1oOJspyFVutDX24DxN9/ESMKNv8yHNr/5kj+DZlX4CacTve0txF3LM/U0YX6+tYmJ2Kk485X+CJLSV+RSHFDb5qf7YVedvTYitE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=IKpEBYZB; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-bc17d39ccd2so1453973a12.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Dec 2025 10:37:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1764959828; x=1765564628; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BhzOXQIeKPGphLxrrOEUt0Oa58R/DXqd+aRrNPmfj+E=;
        b=IKpEBYZBznV82dqQtxV7qqWuXx3cSZ2/9nCcI6qxN3YTN3kj7YD2PRXNTCJrYShzzx
         I+3+uckWGT8zKYEPifLtHggg47p29X+y2c8+x9KsoUMARSDjbfAihxzFU2eqrX+++Zb2
         QTPYRZsFSdWzZKcVirpB/lrKfdqHRePpqPgBnMXdOVatoNwAByUdYKQrv7YJk5/3tvmR
         0dhACJC9aBAeE9ikUH8jmFPWVFnE26xYqwqiFB5GevuQMGxo1yHTNTuGDr2lgL+1TkcY
         OCCykuIbxC8QY4c1xkEWJ7BmFvBmMcKIrdp70RbBFrVR8r3zdb038CMJUSXtdaHi/sCZ
         dQlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764959828; x=1765564628;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BhzOXQIeKPGphLxrrOEUt0Oa58R/DXqd+aRrNPmfj+E=;
        b=kE8kPqHtA8d831teHwjGgkMNxTR4kEgg6EHZKSTNFnj4DlgkU7OTD79afplVRSCKj0
         oyIFyVUj+fcxl66cI0FHdeKTiLvDoLiI+oI2Nqai2JQVmTO5hmV98RVheCLSDdkvCXSs
         vXkQX540rMcp6U+0b2dcfoei4wztU2hC9bzclXecIMqkimsqTmx21CYv0hPjHw+xyMfG
         +2ebU4Px31fHjrsHsA5im0MsspUF5dV60eJDpM7J2TDZ/HKsjb2i4N3fGIv6JeO63BFZ
         dpQawbYcl4nwkZ2FXCIF7cxZLhB93UCJdkkP6LAeG4fzTT10RUDIitDLJF0IBL/r3osk
         rVRg==
X-Forwarded-Encrypted: i=1; AJvYcCWhmBy4kbtQAtucV2HZVXA9PAf5AkCtppAMDpapgSuY/23Hk952yMC10xFLyCGFEZ0BhZIzac1zdZgteVbo@vger.kernel.org
X-Gm-Message-State: AOJu0Yzm2IIgIqRQjgCJZbkzHzFc1AelVlRSMa+bAOF8HQD8Eh06W2Wj
	Y9dtairjfy6AH91JUqqnA6O4qJoCyj10ZbOnOxJc1hsFd62JCqfy0hz5c2j6OLYTPmc=
X-Gm-Gg: ASbGncuh/wVgQAgMXqtyHeQdeHRVlN6UevbUzvakhoqNwNwge/mY5b2A864uIPVdz/W
	SUEvZ2sAGpOPf7a1VtEBq5asdCHJ7JV5IC7gTocNuMjdVvDdCqhU9ku+jbum9Yv3xSfI2LDHUnG
	su4GyUu+PgkiqyJCSFOaAgAwlYJiY9TgMIam1SuPtOFrnm+xyIYrivykRtIRaCfOIQtpmaVkOs0
	WYoJIrYyu9X3LSGfCviygyjtSz6HOUy6fu5/q96gtO7x39t9IADJZuzTBlZbipb3GFHPubUEkXo
	0Sz9SNs16ukc6EV58UAo71ZC/+TPmp+RrfYk3FQchB1CYLXTum/tOWCkbiimayDGRmQMacIAx8D
	PkhWYMTx8JHHj7rqAHnbepyVBScbIFUsW2ROAaZ49fXOjnPKqf8r00K41A4uhVjznV8MkNTmiFt
	SJwdreYMtgXQuSNBlr43mZ
X-Google-Smtp-Source: AGHT+IFTiX7E4nhtg2oLIOiIJsymgB//WfrL2lfzuDUbhfqZQt/M5VDYOlkYmCvfxcqp8BpnyoWHBA==
X-Received: by 2002:a05:7301:1c83:b0:2a9:9688:6ee8 with SMTP id 5a478bee46e88-2abc7201595mr81379eec.22.1764959828290;
        Fri, 05 Dec 2025 10:37:08 -0800 (PST)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2aba8395d99sm23933342eec.1.2025.12.05.10.37.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Dec 2025 10:37:07 -0800 (PST)
From: Deepak Gupta <debug@rivosinc.com>
Date: Fri, 05 Dec 2025 10:36:55 -0800
Subject: [PATCH v25 09/28] riscv/mm: write protect and shadow stack
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251205-v5_user_cfi_series-v25-9-8a3570c3e145@rivosinc.com>
References: <20251205-v5_user_cfi_series-v25-0-8a3570c3e145@rivosinc.com>
In-Reply-To: <20251205-v5_user_cfi_series-v25-0-8a3570c3e145@rivosinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764959808; l=2600;
 i=debug@rivosinc.com; s=20251023; h=from:subject:message-id;
 bh=DJZ2aJIoeyTvFOiDWAJGj4EuG7hZunP7odYpwBb+3MA=;
 b=C8TEEy1gs5sN7rJ+eYCVF1t4T+o2d8VuOmzt9c52Aq81heygn0UsWcug/A1KC3oo9oTAcQtSt
 XNDDFyGKg7jBvPECrfnFz1PZnqJVtsC1fQcCVVCaZ/Cl0mGP2aeU++w
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


