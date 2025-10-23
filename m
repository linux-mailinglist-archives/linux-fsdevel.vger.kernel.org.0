Return-Path: <linux-fsdevel+bounces-65321-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27EE6C016CB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 15:32:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26CBA188394A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 13:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 182073321DD;
	Thu, 23 Oct 2025 13:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="cmsoPmt3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F4432F76D
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Oct 2025 13:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761225959; cv=none; b=Osu8MNuW0Xo4TKzUqqsAqj+gh/lYm24ERZLHQXQjx+2gCrOPzMFmUpCxHeYQ/+kqxuVwlNz1mpUpb+vfS174tkWrqhQqmT9/4VJUIJV7FEgDfA6/CJzxKYCrVGydkOnLTLFlbZLcq+mDnEHTZfLs0DVNCAEG7F04+Xj7NHe29io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761225959; c=relaxed/simple;
	bh=zG1PvbsubgVB7UstpLjRtN915FxsRLFbcnYegAn0YwA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FilNbgBHpsasY5VDlerKsklkGEE9yvmywit8w4cLFkteu9QuT0seJJQ4TLt/X3uYFy65n2RxCmxKr5jiKkndxaQysH/lZyIPhLx1KcojZTvLatEF7oiej0Hc/4Pl/64WiH++ZBzC0swpwJLWPs4ZnirVFAjswumtWmdAL+pnGQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=cmsoPmt3; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-26e68904f0eso8322095ad.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Oct 2025 06:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1761225957; x=1761830757; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f9H2LPWU9+l2k2EeL07qQml9rdpRAXigNCc3vd68LC0=;
        b=cmsoPmt3WnpHb10/2FNrmKG78VZ9aoLv6vFMHV0rIFxucXIfEG6oFMMHfqXwe2lXlg
         +tCfZb0rKNfPbR+h7sHTJP7JMvbBHz9ECHvBdFWtixO6W6CbiTPbuRhEX5oIA8yydjOh
         5T1mAiz3mkdzeMqKvUFs5Oe8pMYAxGhQdwcwBYKiO8D/ja3uBoK9BV2zWKjOzNQfiaBA
         wX/rFOO4lEEXtDY75tMVINKyxDtMR2GREwtwj3ps/elZKOpfk3ugjY5x+Bby991naG08
         8B1e7XVIGygbl4yXW5Iulp/drEhHWW+0mSu/9WzsjRfoi1zG891nYmYVGNNCNO0Z+kB6
         vfzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761225957; x=1761830757;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f9H2LPWU9+l2k2EeL07qQml9rdpRAXigNCc3vd68LC0=;
        b=gWbgu+sD27MQ1VG4zmnzNSgOarehok9MS5Fs5hcYeBCvXtr8oakZ0zsMAv3nJKSD9J
         3gL3h/5Ij5ChDZfMrr7Q2FYLrtPhNeuho3xhZybHWmSEdYADXWzYamSvXzCNHAp3JGFj
         iSvoThockcOinKt264QHE0QCiJn2O1rrJOBMu8L4HoxVLtC1+mJLgAyy2GiqGO9Jz8sh
         oVBkfJd0G5pxbO2pagkKvmgQXWelO9fFWDdKM3BSp7/Ch3FTYkio1JaxcrToTVrfo5Mp
         xBS5ngiKQcOJku+5MmmTseiGmHhLun6H0ACUSqObeD37+gfxMbVCfCRWWRzhaYXmn5Rt
         vtiQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxUc6oGLTVrZErbN1pFD9VpHzl6309kO42wR95+zwcPhZ0Y+5znM+4U4oLzVCFL1Jsb/gBraQQswAZZW1Q@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9E83x7OCHsdE/dcgf9dctkBa7tB62PTKkaPj2SbHjzoYYTYIG
	IbT06px0vBSSml7aNepQDUhqkPITR7rLIbIlFi3T8hakzogVBTn1/3LlXsIO0bfBdv4=
X-Gm-Gg: ASbGncu2cnE5APoMSkfLO7E9tWFKrIK/6tVQHTBtYJdp58dp7lyZIY+wXnJyJn3MGnc
	HPbF8n8PvAxP08CjW6HYvP62/PmbGtFrQEHgoFDR2pR6q7coHi0uEVq7W8vaFULz2NKonO7tJMZ
	Oz4SKIiDQ9RqPhb9WEaltFYRh2FAZuvhqz9Vq7qirqFh242iLQ2fgEYFi0qPCZh8nUJtafBCKTL
	wkfcHInUH8l/RkGq6QadAhk3ezxMotScXyxpBjEhtNyFYRlwH0Lfp+CYSYnsqDXnrQTeg2GX1Uo
	AX1crF0z3+WS1hxMjbhTGlv/e8RFCsDUDYYMSwWy60P7bHOpJCE5psLZArQQPxzzkz82KePKR8r
	rpRfgGL3h4EyzDn+oOgLeUkSKtEIuWrDreHkFJ8WR6h2d9i3hegwCObLrQ0Di7xGgqTUUvK+/XO
	HA9odfHjFOiQ==
X-Google-Smtp-Source: AGHT+IHQNsgbR9ZhvUDO+8XIqhhB5S0bPoonwHjZoVYPjQlap3Ktgwx5TRlqv2xhIowva8Uttq5czA==
X-Received: by 2002:a17:903:22c1:b0:278:704:d6d0 with SMTP id d9443c01a7336-290c9cb2666mr309074665ad.19.1761225957249;
        Thu, 23 Oct 2025 06:25:57 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946e23e4b3sm23432035ad.103.2025.10.23.06.25.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 06:25:56 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Thu, 23 Oct 2025 06:25:38 -0700
Subject: [PATCH v22 09/28] riscv/mm: write protect and shadow stack
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251023-v5_user_cfi_series-v22-9-1d53ce35d8fd@rivosinc.com>
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
2.43.0


