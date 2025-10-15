Return-Path: <linux-fsdevel+bounces-64270-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D7E2CBE00E6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 20:16:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9483A504D26
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 18:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D894341AD4;
	Wed, 15 Oct 2025 18:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="KFgRBUpa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28DB7340D99
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Oct 2025 18:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760552045; cv=none; b=Ifgdh5C3RdXi6NLWYljVo9punlhFArjXv4VghcLh2WXQoKcH2vHBJSIas4jXUaGGTjL7NbSxhVsdRasTSvxc+232Fo9DFwN4NCDbUOvnPMvjfh8vDAdv/NNvTWtvPGZZSwSOUGpMyrd4ccXM9/oYvi4hAL3HRsYGYeh9sVs0jt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760552045; c=relaxed/simple;
	bh=zG1PvbsubgVB7UstpLjRtN915FxsRLFbcnYegAn0YwA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MMMVCN3RW2KtOie27mfQjtBmSOREQq1Cjg69grfZiVRiGSh/BiQV0jdW/GurIaiDmBNmBUSUEOQah6oMpX6uySXFVGDN4Zy1FLqg1laR4MwyLNjPB9ReiExOb3PNaNswSEmhMF4sQ+lot+2VAPUuVsVgD1bBb3huH5Hu9TTl47o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=KFgRBUpa; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-27eceb38eb1so80005735ad.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Oct 2025 11:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1760552043; x=1761156843; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f9H2LPWU9+l2k2EeL07qQml9rdpRAXigNCc3vd68LC0=;
        b=KFgRBUpa10WXaQAGQ9N63akR+RjBhvA8ZAIgOFY1SgVtluv7Fu6tmUr7fWUMGS/8lI
         FzstAvY8fnJJP1A0xSpWSXmf3jCrUO9/Afb18iKkSF5LVaZJIIcjQD7vGEQm6ITZ1Li5
         oPgG5gAPnCRBrSgNAszkH0AeNGdRde17sCjWgTMjdNiYCD3+FgC2NRT78zpaLP+8qUfD
         A2HOs4DAG4K3FjCKwpeFs1OQ7kv2WBqRSleKfhlpSezmLTCoi2exLxrFmRIwmdlqKRTS
         yTuD3eCOqVbInuOohIHxNtCvVO1eho95hwMeUR3kmjxLetAnfp6vvf/t9wlfeqfHIkT4
         kY9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760552043; x=1761156843;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f9H2LPWU9+l2k2EeL07qQml9rdpRAXigNCc3vd68LC0=;
        b=YhULoRhB9hWK0DtfCAC37lyq6DbUGF+37ItrQpDjMENh1/384lqsE2jAepJYq6bkjq
         +ie2g+0JXqZ057waqBTtdU60AJkSltZANO6S/lIoQTON5NKyV7gnrL05oUj65M4NmhQA
         Gxe+GFVAbM/3gWs0icjI0jjcmPkEeUldHZvXZ3s1kehOrue8kuEi6oPoUuYgctxqWEvL
         hIa+VMtKm8JQTIlbRFhkGy0RkBF5r4hZjQ2J7AY6U0sVwk9dzerIr7HRQfTh0EEvTsKo
         GavCbqeEdVVbcAhh5VaC/C02jxN6zDgc3hBwsCypffb2Jrh5K3SRy9KpsANeUlbQzrcm
         ALKA==
X-Forwarded-Encrypted: i=1; AJvYcCXQP+euqmNjINXX40RT3uWqtx1aYON59WfORywdk5BzUME5u+hOEc3/aoS5pyybVC3YooGY6IAzyVXSDvXZ@vger.kernel.org
X-Gm-Message-State: AOJu0YzPhlf+3GCl/I7HtDo/mVSAZ2H82dtYhKX/bP6tbXJH/fRD4FbD
	WpkMB31zYBZJmd3Ev5DbDtYHiRPiWKMS1xnzKhoAGXnHGxnkpGEb7TdJJVIGghnuWYY=
X-Gm-Gg: ASbGncuTLJqT3N/hujnX/updOYfVmtlxIAiXTuvtog+1P2pQSbTbEvyOYK5NU7KbslD
	ogN7cuzU7jwit267MngLfrWv0k7o0+53neSFocQQLyqW9ImEHMFrYbeqUT3lKEIFdQHHk9yDwl+
	Lrsgx/sxGKtEEa7KW2JuLBXepblmZBEtl4/hMAlszdkjLT0xkiOxEt2Ke6yY3XhHatLBZpDFsTP
	Rjnpdh7scaSibeajEMSyoHwyle6i49aa+u5/YXZuCqaDp09hzHQsQay/du/CcL3FJxZ8ukY740H
	FupYtvYcfdfmKYjyg+Gc/no9QJBpqpxu3lnjlO8uGmKcTcraVsexTLx3D6umhbfvNzQiSsI7dPN
	Cry7AxQob8xKcwXGb4Z+LiOO6uudb8pj+6FC+E8Omg7mqGoqALSl/789pohyZiA==
X-Google-Smtp-Source: AGHT+IHetZQQxpaUW6Ligrelt0t3SG9P3lR8csbC0fN5hsFXEFcboGQK7fC7f7E0BUqjK+kKMsFmwA==
X-Received: by 2002:a17:902:e806:b0:261:6d61:f28d with SMTP id d9443c01a7336-290273ffe94mr346464585ad.50.1760552043546;
        Wed, 15 Oct 2025 11:14:03 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2909930a72esm3126625ad.21.2025.10.15.11.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 11:14:03 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Wed, 15 Oct 2025 11:13:41 -0700
Subject: [PATCH v21 09/28] riscv/mm: write protect and shadow stack
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251015-v5_user_cfi_series-v21-9-6a07856e90e7@rivosinc.com>
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


