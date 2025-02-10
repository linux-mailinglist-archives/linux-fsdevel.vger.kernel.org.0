Return-Path: <linux-fsdevel+bounces-41465-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB384A2FA58
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 21:32:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FE7C1883FE7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 20:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A40D024CEEA;
	Mon, 10 Feb 2025 20:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="cgfihual"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16BCD25E476
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Feb 2025 20:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739219240; cv=none; b=rYQZBCvB/4zp4gsMLcEpN9nNmgNUrfeFckMULkIwqM0MHk3V5GlotlXUdxVehMFew8cUBs32cKJsF068gnwSG6/++egT98Xs+cEim9OU5y8+bSmMOwmJjwfTLh8jgGo6+FYgkvVdIcoBtJrm9mpz8vSHzWFEvYXYBrUTZ7zHr+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739219240; c=relaxed/simple;
	bh=mWDyYETp4wr+sZ2udIiiXn9veUStZJ0b+YrPzAFDVJE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JbP4SiGTgrfRsU/aICptEHmTaw+W45ZLnAjHD+HAG2zyvNp0BC5kvdsJhJhf25h11zaGqpCoMjcPkQk8p/9JB+EPtif1NXU51HtLwfrdukcfiL3VNCaem0vwkhLgy1122sx4h+H4coX4UGOIba4AZpkkVC1Wj+k/EnztUZwCeIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=cgfihual; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-219f8263ae0so86740035ad.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Feb 2025 12:27:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1739219237; x=1739824037; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M49HWf8gzr6wWBf1Qtr4VOivQAEEQjfyuWgORGOVTSw=;
        b=cgfihual7vogIbUidSJciWrun5iWod8EpWE3A2Dal7ycflBNgWcunuDTA+cWrOJEsP
         DlKPiwbFzQc+VWaQV0CG6pfkGvGN/uD+lzc+GRI/gh2YJsyyxSmWNbFrZxSS1pAq3tDq
         6HbQ5YFGaUK3dj3gDznuTQ0ZYu2HPNaMgzH5jp7rjUnUCxQrrvhtSsYCijzxzVBnM9MQ
         cbQTzLZKTFkTDqDzavjXsJoPKafRlDhPSJGSsgMVNAIBt04dc490Qb8vJTWlkqVGvgTA
         LqxlqZIQDnTuAVnZd7i6zUiiFZZ8wCoMSc3l0AAPiSM9SWAB+Omu+m6jaZByBdF3U0EQ
         xrYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739219237; x=1739824037;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M49HWf8gzr6wWBf1Qtr4VOivQAEEQjfyuWgORGOVTSw=;
        b=WjLih2iPQdBe/w3hZcO0niwM4oNE6yqQmF6Ayj35OpeBUfv43hx+YvRhPUk21tWxYH
         ag2LyUvVHCG567YioB6sAmrksB7tEpuemlzASmHGxrjWVJ+bDJa9WQk6m9+bvhPys0gd
         sMtwO4iPhxvI69AZw51Fy9BqIfLo9k2hDCloosV1RxElDwYi03EvTl+ZMYE1snlLEQgg
         ppnn1ONo3NXqQZoF7V8RKFWntx53MvDuPiIBqnNXOiymjgcO9TZTKD2/PTm37Bt9nQxf
         fTtKyK5L0KzDpD+jouHJ7IGXQ7I5OZsDz9BP9Md2OJNN4j+Jz9CO6nmK+ylgOfmhqmtQ
         GbCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUO3i+p25U8UyLuMmaguVsUVsP4WQAknqDlGCiZTsdq2vVeGjIeC/xOKi5hC+xbZHDt87nFjA+tXzJ2t3Zg@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/mZZZUroD3HniY/75DRN3TGSmbUW1PaQTElwbIEv13PiTQ3uc
	YuqYHEpGlQSwlPEAsLeweZSPr1R9jicy1E1mBNz/h87i+N9PFk61EOEI9pXT8YU/dok4URIjExw
	m
X-Gm-Gg: ASbGncvQa0pyuXeodGxUHVtQ8ukggDd7APz4h58ZzqkdmxJPqBDHdtggd1O/lfgbHG+
	g7dYWTSIOGDDbS+88LVJuTpDnnV9UFzHfGsujbGoWOTGhTBPbbjTLAPjZSNigZtkYNbOzVh/C8G
	gC2dYFDrPFeiDcOqvX9y2PBgMEz1xkIBWqHV9Y3dCdUe94BUU4/Av9IXvsPSVCHbz3HXjOgvJSI
	Bmg5H6iJlWyItagwHa7GAyQHxqN/M7GWXxY1t5kHiXp4uaiPfHQTY42A3rNQOLigOvMcxUT3OwA
	KNSW2aaJXLRoPv/m0YiRh20oew==
X-Google-Smtp-Source: AGHT+IHdHEBMhep7yU/mVgZUfZFs7fvP4+JZwXsHPWxQJF2WCxVaTQUYKv93Rn4bqO7ShpSAaGLGsg==
X-Received: by 2002:a17:903:46c6:b0:216:393b:23d4 with SMTP id d9443c01a7336-21f4e1cb92fmr222614515ad.11.1739219237018;
        Mon, 10 Feb 2025 12:27:17 -0800 (PST)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3687c187sm83711555ad.168.2025.02.10.12.27.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 12:27:16 -0800 (PST)
From: Deepak Gupta <debug@rivosinc.com>
Date: Mon, 10 Feb 2025 12:26:47 -0800
Subject: [PATCH v10 14/27] riscv/traps: Introduce software check exception
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250210-v5_user_cfi_series-v10-14-163dcfa31c60@rivosinc.com>
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

zicfiss / zicfilp introduces a new exception to priv isa `software check
exception` with cause code = 18. This patch implements software check
exception.

Additionally it implements a cfi violation handler which checks for code
in xtval. If xtval=2, it means that sw check exception happened because of
an indirect branch not landing on 4 byte aligned PC or not landing on
`lpad` instruction or label value embedded in `lpad` not matching label
value setup in `x7`. If xtval=3, it means that sw check exception happened
because of mismatch between link register (x1 or x5) and top of shadow
stack (on execution of `sspopchk`).

In case of cfi violation, SIGSEGV is raised with code=SEGV_CPERR.
SEGV_CPERR was introduced by x86 shadow stack patches.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 arch/riscv/include/asm/asm-prototypes.h |  1 +
 arch/riscv/include/asm/entry-common.h   |  2 ++
 arch/riscv/kernel/entry.S               |  3 +++
 arch/riscv/kernel/traps.c               | 43 +++++++++++++++++++++++++++++++++
 4 files changed, 49 insertions(+)

diff --git a/arch/riscv/include/asm/asm-prototypes.h b/arch/riscv/include/asm/asm-prototypes.h
index cd627ec289f1..5a27cefd7805 100644
--- a/arch/riscv/include/asm/asm-prototypes.h
+++ b/arch/riscv/include/asm/asm-prototypes.h
@@ -51,6 +51,7 @@ DECLARE_DO_ERROR_INFO(do_trap_ecall_u);
 DECLARE_DO_ERROR_INFO(do_trap_ecall_s);
 DECLARE_DO_ERROR_INFO(do_trap_ecall_m);
 DECLARE_DO_ERROR_INFO(do_trap_break);
+DECLARE_DO_ERROR_INFO(do_trap_software_check);
 
 asmlinkage void handle_bad_stack(struct pt_regs *regs);
 asmlinkage void do_page_fault(struct pt_regs *regs);
diff --git a/arch/riscv/include/asm/entry-common.h b/arch/riscv/include/asm/entry-common.h
index b28ccc6cdeea..34ed149af5d1 100644
--- a/arch/riscv/include/asm/entry-common.h
+++ b/arch/riscv/include/asm/entry-common.h
@@ -40,4 +40,6 @@ static inline int handle_misaligned_store(struct pt_regs *regs)
 }
 #endif
 
+bool handle_user_cfi_violation(struct pt_regs *regs);
+
 #endif /* _ASM_RISCV_ENTRY_COMMON_H */
diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
index 00494b54ff4a..9c00cac3f6f2 100644
--- a/arch/riscv/kernel/entry.S
+++ b/arch/riscv/kernel/entry.S
@@ -472,6 +472,9 @@ SYM_DATA_START_LOCAL(excp_vect_table)
 	RISCV_PTR do_page_fault   /* load page fault */
 	RISCV_PTR do_trap_unknown
 	RISCV_PTR do_page_fault   /* store page fault */
+	RISCV_PTR do_trap_unknown /* cause=16 */
+	RISCV_PTR do_trap_unknown /* cause=17 */
+	RISCV_PTR do_trap_software_check /* cause=18 is sw check exception */
 SYM_DATA_END_LABEL(excp_vect_table, SYM_L_LOCAL, excp_vect_table_end)
 
 #ifndef CONFIG_MMU
diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index 8ff8e8b36524..3f7709f4595a 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -354,6 +354,49 @@ void do_trap_ecall_u(struct pt_regs *regs)
 
 }
 
+#define CFI_TVAL_FCFI_CODE	2
+#define CFI_TVAL_BCFI_CODE	3
+/* handle cfi violations */
+bool handle_user_cfi_violation(struct pt_regs *regs)
+{
+	bool ret = false;
+	unsigned long tval = csr_read(CSR_TVAL);
+
+	if ((tval == CFI_TVAL_FCFI_CODE && cpu_supports_indirect_br_lp_instr()) ||
+	    (tval == CFI_TVAL_BCFI_CODE && cpu_supports_shadow_stack())) {
+		do_trap_error(regs, SIGSEGV, SEGV_CPERR, regs->epc,
+			      "Oops - control flow violation");
+		ret = true;
+	}
+
+	return ret;
+}
+
+/*
+ * software check exception is defined with risc-v cfi spec. Software check
+ * exception is raised when:-
+ * a) An indirect branch doesn't land on 4 byte aligned PC or `lpad`
+ *    instruction or `label` value programmed in `lpad` instr doesn't
+ *    match with value setup in `x7`. reported code in `xtval` is 2.
+ * b) `sspopchk` instruction finds a mismatch between top of shadow stack (ssp)
+ *    and x1/x5. reported code in `xtval` is 3.
+ */
+asmlinkage __visible __trap_section void do_trap_software_check(struct pt_regs *regs)
+{
+	if (user_mode(regs)) {
+		irqentry_enter_from_user_mode(regs);
+
+		/* not a cfi violation, then merge into flow of unknown trap handler */
+		if (!handle_user_cfi_violation(regs))
+			do_trap_unknown(regs);
+
+		irqentry_exit_to_user_mode(regs);
+	} else {
+		/* sw check exception coming from kernel is a bug in kernel */
+		die(regs, "Kernel BUG");
+	}
+}
+
 #ifdef CONFIG_MMU
 asmlinkage __visible noinstr void do_page_fault(struct pt_regs *regs)
 {

-- 
2.34.1


