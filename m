Return-Path: <linux-fsdevel+bounces-64766-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F2B8BF38F5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 22:57:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA2311885A42
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 20:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5F31338592;
	Mon, 20 Oct 2025 20:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="FFvBtEYG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E73334C3C
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Oct 2025 20:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760993637; cv=none; b=k9gUUuTxTK/gmLpwAuoLIdJJZYAKC/11+W6YnY0OVWAZntpks8HGdnPjEKvQAGxLsCZDhpQDSc86vH5mt4x3WwdI3mHRtEjysmailZ1b6ISRRBef+xpyyXKrgpbIBM+oIXGaQoayDAQdCn0vU2/79MslPMaY66PJO70mmskeWb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760993637; c=relaxed/simple;
	bh=zG1PvbsubgVB7UstpLjRtN915FxsRLFbcnYegAn0YwA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c4y2/TquYWZhXDlNYWsf5Ig6+V7f1BK6gHEfnMtz/laE2P042EVJUCiXGtTJCla4hF03ZNLehBE3CIZqsUTzrjYiLbgZcAkn+NrHFy6vxSLBdNrF0nPDa5iaM7o29puToa4iJquDaJ5SgWs2KuD+48vofXzTJwoSRvo7su2xrvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=FFvBtEYG; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7a226a0798cso2836536b3a.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Oct 2025 13:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1760993634; x=1761598434; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f9H2LPWU9+l2k2EeL07qQml9rdpRAXigNCc3vd68LC0=;
        b=FFvBtEYGIgsi6pmutftGfXsANjWJPM2JL2cdoah5lrxtP/Pv2cVGr77Ru/hfszPI+C
         e6OGmvo1gWF4jsJ/UDvPs5lDN2Yx9zXMqJ3ipw1IH0n30jnsU4TCUBlyNa2Ut6xbCB6x
         dqrGVN3TSN9wJfV8Vpk75irDizMWMUjto4poUDEtBNiU5SU6qQT9Cpa6QcWWdTW134Sp
         F8OxaOhoWMAG0ikd2jh+Ugbi4NONg3iZxMkMbee0d4JwQKakD4XzoLhwEceE11ABIljS
         DK6tFYxF1ZmQEIt8GgVulrucH5fwrJi4p81UDrOGFmJiJ3ggMqvEhMCwjyZYHN9s5op5
         iCLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760993634; x=1761598434;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f9H2LPWU9+l2k2EeL07qQml9rdpRAXigNCc3vd68LC0=;
        b=HRPC19QTJLmk9AbRSCHTBbTqTA2bVbsNQr/Vy/QiNbuqektmEwZZRVRvcI84pulGjl
         Ow+KD9lInSnwMDvAFGV1vOwA5e+RcuHEcOZFUCcXMDdNjjj2TWSot3+Iw7O5WkulFMjH
         8DVeF43aXPhXNyKAynMUZ/SGY34R+EtKHxPANxSz3r6yn4yZlwtXjBTIyc08YVRAVcln
         xO6QrO+SZ4VOqn1H80lRsrD1SVpz+4C1mVlrxJbeh8YOaelYI6AXCg50suTNF88y2vGC
         qTw9XD9gQ14isrEJ9Blztz3WoS2we11lvAptxlyiUSPfLt9EKHoxUEBU8jxl/7hkPu5l
         8ORw==
X-Forwarded-Encrypted: i=1; AJvYcCVeVry1a7wa1sDntQa65CLp+MjQydbiWlpc6y1z7C5iTXRGIwvT3VLUzj+YYLOImZHNHzBG9sd2FgRZ6ioB@vger.kernel.org
X-Gm-Message-State: AOJu0Ywtq9T+sdd5z2FlPnb9OrPR2VKgKpZRKsQCuqgkuRXk0NDoX7Vu
	QauBSSTytvtZFI9NefnNpZiYmpdnEI8FYejvzivSxOH0i948ODon/ilH92Sg9hceM1k=
X-Gm-Gg: ASbGncsd4/bfKWDsTGlmw+c5SsS/6pPg7nL9TYK81TaJarRpG1d3svV7UnAlSjPFjmk
	AADom5yQw25gE5W7ndP34j3G71S9AsB0peJCbuqBNSbd43eB5B0DtTqW7WyQRk5gQFMn6aORHoE
	Fek5ffE6spnum2O07CFXT/kiOv87wtT7NM5LlEQ9IDrs1F6M38FJ+A9v5Q+I/YMM8/qn5HmKt+7
	O1nj9w6RzzX0/+dYyeNnfbfV2OxWSpkyA6F/Mdonit2B2vdeLNdYsM1QPzSNXAoIiWlgdhsnt3b
	aN3SlQDmrv+MJJxrN2hcCQliW2s7airW2irbmOgWlSjr+Im7V9LV48BTgh5T6Mcy6tEu6dU9sFK
	bEuq7apUBpljvB+kEPK1O2QzK6ufaBD5ZLiM3yIhPq9f+5mXlPUxxFdkXj5CofWUdt5O3nblYQP
	9HqeHXuzPoJrt9F+uySAI1
X-Google-Smtp-Source: AGHT+IGY4EyF47I5kfM9sLiEWB0A4XrZi6suavhQ3DELNJWCbB/8MtVPQAocTammVkTvv5k+HEaGCA==
X-Received: by 2002:a05:6a20:2443:b0:303:8207:eb51 with SMTP id adf61e73a8af0-334a864aaf2mr20366099637.55.1760993634353;
        Mon, 20 Oct 2025 13:53:54 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a22ff1591dsm9453867b3a.7.2025.10.20.13.53.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 13:53:53 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Mon, 20 Oct 2025 13:53:38 -0700
Subject: [PATCH v22 09/28] riscv/mm: write protect and shadow stack
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251020-v5_user_cfi_series-v22-9-9ae5510d1c6f@rivosinc.com>
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


