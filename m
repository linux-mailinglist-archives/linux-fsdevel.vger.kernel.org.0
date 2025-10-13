Return-Path: <linux-fsdevel+bounces-64041-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A6D6BD6886
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 00:05:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A5F554F5B53
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 22:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDA2230F955;
	Mon, 13 Oct 2025 21:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="gTHTABbn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E939030F7F1
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Oct 2025 21:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760392604; cv=none; b=nPSMmYiYDmq+WPnRLJEsjFsDkcDLNGHpyiAW2LwLMVMSFXW29KMfSYGMQUsxojAlTqiAklXnYdoA9zZyD4pnCNDk2a0ejrgfiw6OMBXdbksg0PofbXUX6mqymGUmn5tw1h1I9UYPCmian+lLsmdsMJk9VZLrsWp3A6ajaAJdJSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760392604; c=relaxed/simple;
	bh=Lgv2+2JEKJz8I+eOPU23ZhagSpES8G7xWPFmmF1jXYI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WWl0KH9GPaO0kHnMnOT1Dtg/flVfIBOCjVU1SGM8aWY5U0xOdiy1KzBMJIZOHdb+D/JN8AdyBH6SzOgQZFs9YXBtWhDTKBMd5MByXiWPMNA9Qkwa1M+sbnT77Ar7+CnrAY2jSFUvhLGN1xLh+vNukth0SwWyASGmAoxhJgiN2ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=gTHTABbn; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3324523dfb2so4536860a91.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Oct 2025 14:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1760392601; x=1760997401; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=orzOOXGj405YiK6przhe0GQbSZ5JqsOFQ3WhV+5/r+M=;
        b=gTHTABbnjx8lpRtUDdTM73wh72fLrpXpeUaDPvh0h3ZN/CMM8Pe66Jqw1zOfBuM8W6
         4kqKzgTjMET/zhmdd2CkF8VMQajOBsKzhC7wAq2qqKYf4+7Z+DDQnAQ50Clm4dkXZm/t
         rDzfGN12+E8DJ3dyd7D1jcv5IvyENR/b6YJzSS/+c42xqVQ9J1YtAb7BAbVctU/AMvtb
         R3Rrru9lpxCmJVQRzJhNsq3iTgnJ+Nw/w2qD5Z1u0IkqZm3CoMlhU15n+uLbryuvinrQ
         xNExyrKTTrOn+gnT42Q0rDIyI3Z2pWrL0pqoi7ehIm4FEmMDRrhy0Ei38i3AUeGqU+cd
         2VSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760392601; x=1760997401;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=orzOOXGj405YiK6przhe0GQbSZ5JqsOFQ3WhV+5/r+M=;
        b=oTtyHSMJfO5evS/gMZbJzH8axB3WYsyfLEF4JTUe95T8twxQjTXmrcwbRL0DZ8b8Sa
         7Noms0W1uO9uIS12ntvb+IWM/5JbuolniflYYsyRjrl6TM3G2cWNOLrSVfmbRqIvd4wJ
         rphaWGohpeHldtb5nCw+0oUfWceXPWoTUJLqOYB+m31zY4DkpxcIN+BxoFejntiLKkFC
         Yuqyi94hAUvoS97arUv6QO9tW3qJGTAG8kBLOvyipuFAsG4Te4586DGrrBzsZfZbp3vB
         YmHJdjA3upeLuNg9KG31lKhlk8z9tnSVW7oodR2AoisYzv0j2YwIwTCjMRm5YqhCU0yJ
         D3BQ==
X-Forwarded-Encrypted: i=1; AJvYcCXOhAukuyNt2mPbO2RlY2nPMYll+I9HP3FqV38VrT2gSXAmK6uDdzwndGM0CqePIaTsN5hrJY0qEKyL1rjw@vger.kernel.org
X-Gm-Message-State: AOJu0YyLHRewUxfJg5tTvvtDtewHqOIk/Nn+r9eTrMqLN5a2YPEwj9YV
	QAy7SZikdF959r00r5Z6/F+WMyYLsqHry87Eqr5O8tcE/iFPXMYx45aq1MS/5iH9xek=
X-Gm-Gg: ASbGncuniBukXdQVcOz8tqp3HcybTS2FXhif0uOkJQkvlRIiL4+DWvgpvPdPuNmDBul
	RyfcobOM9fED+7eVNGoggetcHl2Xxpw6T+Q8JYeH3UoQ3Ip9vyPgfdpYAkrrf/+kLdAVngp7gX/
	aKyASTO4mQ4wtXNn8F1zANiXQavGQ5n+cuYOwCkX52WRjyfKZyO/MzUI0qiyL5Nm2IlIrU9eu2d
	INVpgZMZluHdYB2RUFA5rCXkjX4ntDuALFzNpuDP6eKWIv+VMVaUVClDPnI3HsIj/Ldbb57j6Tt
	7hxMqBaDhOKNnSrSCZcjaplUl7voD+NJXvKj4uC8mXYT9YnQ9KUdn6S22ER4DbqFXaA7tgLJaVB
	RVBihMycXYeYxfQ9nw/HWtyll9NfKwGjRiOeLcVZKCHk5MKaMeCIicU2QKgKKJQ==
X-Google-Smtp-Source: AGHT+IFXIjCgVe+iPpZHDAimXPS0S6OzXaRZdMT1KbxRB2iNFRf26pwMaw595QqzXQcdzmq5wyfjiA==
X-Received: by 2002:a17:90b:1c81:b0:330:7a11:f111 with SMTP id 98e67ed59e1d1-33b513be2c9mr30305717a91.35.1760392601215;
        Mon, 13 Oct 2025 14:56:41 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b626bb49esm13143212a91.12.2025.10.13.14.56.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 14:56:40 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Mon, 13 Oct 2025 14:56:11 -0700
Subject: [PATCH v20 19/28] riscv/ptrace: riscv cfi status and state via
 ptrace and in core files
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251013-v5_user_cfi_series-v20-19-b9de4be9912e@rivosinc.com>
References: <20251013-v5_user_cfi_series-v20-0-b9de4be9912e@rivosinc.com>
In-Reply-To: <20251013-v5_user_cfi_series-v20-0-b9de4be9912e@rivosinc.com>
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
 Deepak Gupta <debug@rivosinc.com>
X-Mailer: b4 0.13.0

Expose a new register type NT_RISCV_USER_CFI for risc-v cfi status and
state. Intentionally both landing pad and shadow stack status and state
are rolled into cfi state. Creating two different NT_RISCV_USER_XXX would
not be useful and wastage of a note type. Enabling, disabling and locking
of feature is not allowed via ptrace set interface. However setting `elp`
state or setting shadow stack pointer are allowed via ptrace set interface
. It is expected `gdb` might have use to fixup `elp` state or `shadow
stack` pointer.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 arch/riscv/include/uapi/asm/ptrace.h | 30 ++++++++++++
 arch/riscv/kernel/ptrace.c           | 95 ++++++++++++++++++++++++++++++++++++
 include/uapi/linux/elf.h             |  2 +
 3 files changed, 127 insertions(+)

diff --git a/arch/riscv/include/uapi/asm/ptrace.h b/arch/riscv/include/uapi/asm/ptrace.h
index 261bfe70f60a..b2a18dfeb2fb 100644
--- a/arch/riscv/include/uapi/asm/ptrace.h
+++ b/arch/riscv/include/uapi/asm/ptrace.h
@@ -131,6 +131,36 @@ struct __sc_riscv_cfi_state {
 	unsigned long ss_ptr;   /* shadow stack pointer */
 };
 
+#define PTRACE_CFI_LP_EN_BIT	0
+#define PTRACE_CFI_LP_LOCK_BIT	1
+#define PTRACE_CFI_ELP_BIT	2
+#define PTRACE_CFI_SS_EN_BIT	3
+#define PTRACE_CFI_SS_LOCK_BIT	4
+#define PTRACE_CFI_SS_PTR_BIT	5
+
+#define PTRACE_CFI_LP_EN_STATE		(1 << PTRACE_CFI_LP_EN_BIT)
+#define PTRACE_CFI_LP_LOCK_STATE	(1 << PTRACE_CFI_LP_LOCK_BIT)
+#define PTRACE_CFI_ELP_STATE		(1 << PTRACE_CFI_ELP_BIT)
+#define PTRACE_CFI_SS_EN_STATE		(1 << PTRACE_CFI_SS_EN_BIT)
+#define PTRACE_CFI_SS_LOCK_STATE	(1 << PTRACE_CFI_SS_LOCK_BIT)
+#define PTRACE_CFI_SS_PTR_STATE	(1 << PTRACE_CFI_SS_PTR_BIT)
+
+#define PRACE_CFI_STATE_INVALID_MASK	~(PTRACE_CFI_LP_EN_STATE | \
+					  PTRACE_CFI_LP_LOCK_STATE | \
+					  PTRACE_CFI_ELP_STATE | \
+					  PTRACE_CFI_SS_EN_STATE | \
+					  PTRACE_CFI_SS_LOCK_STATE | \
+					  PTRACE_CFI_SS_PTR_STATE)
+
+struct __cfi_status {
+	__u64 cfi_state;
+};
+
+struct user_cfi_state {
+	struct __cfi_status	cfi_status;
+	__u64 shstk_ptr;
+};
+
 #endif /* __ASSEMBLER__ */
 
 #endif /* _UAPI_ASM_RISCV_PTRACE_H */
diff --git a/arch/riscv/kernel/ptrace.c b/arch/riscv/kernel/ptrace.c
index 8e86305831ea..56b9e3871862 100644
--- a/arch/riscv/kernel/ptrace.c
+++ b/arch/riscv/kernel/ptrace.c
@@ -19,6 +19,7 @@
 #include <linux/regset.h>
 #include <linux/sched.h>
 #include <linux/sched/task_stack.h>
+#include <asm/usercfi.h>
 
 enum riscv_regset {
 	REGSET_X,
@@ -31,6 +32,9 @@ enum riscv_regset {
 #ifdef CONFIG_RISCV_ISA_SUPM
 	REGSET_TAGGED_ADDR_CTRL,
 #endif
+#ifdef CONFIG_RISCV_USER_CFI
+	REGSET_CFI,
+#endif
 };
 
 static int riscv_gpr_get(struct task_struct *target,
@@ -184,6 +188,87 @@ static int tagged_addr_ctrl_set(struct task_struct *target,
 }
 #endif
 
+#ifdef CONFIG_RISCV_USER_CFI
+static int riscv_cfi_get(struct task_struct *target,
+			 const struct user_regset *regset,
+			 struct membuf to)
+{
+	struct user_cfi_state user_cfi;
+	struct pt_regs *regs;
+
+	memset(&user_cfi, 0, sizeof(user_cfi));
+	regs = task_pt_regs(target);
+
+	if (is_indir_lp_enabled(target)) {
+		user_cfi.cfi_status.cfi_state |= PTRACE_CFI_LP_EN_STATE;
+		user_cfi.cfi_status.cfi_state |= is_indir_lp_locked(target) ?
+						 PTRACE_CFI_LP_LOCK_STATE : 0;
+		user_cfi.cfi_status.cfi_state |= (regs->status & SR_ELP) ?
+						PTRACE_CFI_ELP_STATE : 0;
+	}
+
+	if (is_shstk_enabled(target)) {
+		user_cfi.cfi_status.cfi_state |= (PTRACE_CFI_SS_EN_STATE |
+						  PTRACE_CFI_SS_PTR_STATE);
+		user_cfi.cfi_status.cfi_state |= is_shstk_locked(target) ?
+						 PTRACE_CFI_SS_LOCK_STATE : 0;
+		user_cfi.shstk_ptr = get_active_shstk(target);
+	}
+
+	return membuf_write(&to, &user_cfi, sizeof(user_cfi));
+}
+
+/*
+ * Does it make sense to allowing enable / disable of cfi via ptrace?
+ * Not allowing enable / disable / locking control via ptrace for now.
+ * Setting shadow stack pointer is allowed. GDB might use it to unwind or
+ * some other fixup. Similarly gdb might want to suppress elp and may want
+ * to reset elp state.
+ */
+static int riscv_cfi_set(struct task_struct *target,
+			 const struct user_regset *regset,
+			 unsigned int pos, unsigned int count,
+			 const void *kbuf, const void __user *ubuf)
+{
+	int ret;
+	struct user_cfi_state user_cfi;
+	struct pt_regs *regs;
+
+	regs = task_pt_regs(target);
+
+	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf, &user_cfi, 0, -1);
+	if (ret)
+		return ret;
+
+	/*
+	 * Not allowing enabling or locking shadow stack or landing pad
+	 * There is no disabling of shadow stack or landing pad via ptrace
+	 * rsvd field should be set to zero so that if those fields are needed in future
+	 */
+	if ((user_cfi.cfi_status.cfi_state &
+	     (PTRACE_CFI_LP_EN_STATE | PTRACE_CFI_LP_LOCK_STATE |
+	      PTRACE_CFI_SS_EN_STATE | PTRACE_CFI_SS_LOCK_STATE)) ||
+	     (user_cfi.cfi_status.cfi_state & PRACE_CFI_STATE_INVALID_MASK))
+		return -EINVAL;
+
+	/* If lpad is enabled on target and ptrace requests to set / clear elp, do that */
+	if (is_indir_lp_enabled(target)) {
+		if (user_cfi.cfi_status.cfi_state &
+		    PTRACE_CFI_ELP_STATE) /* set elp state */
+			regs->status |= SR_ELP;
+		else
+			regs->status &= ~SR_ELP; /* clear elp state */
+	}
+
+	/* If shadow stack enabled on target, set new shadow stack pointer */
+	if (is_shstk_enabled(target) &&
+	    (user_cfi.cfi_status.cfi_state & PTRACE_CFI_SS_PTR_STATE))
+		set_active_shstk(target, user_cfi.shstk_ptr);
+
+	return 0;
+}
+#endif
+
 static const struct user_regset riscv_user_regset[] = {
 	[REGSET_X] = {
 		USER_REGSET_NOTE_TYPE(PRSTATUS),
@@ -224,6 +309,16 @@ static const struct user_regset riscv_user_regset[] = {
 		.set = tagged_addr_ctrl_set,
 	},
 #endif
+#ifdef CONFIG_RISCV_USER_CFI
+	[REGSET_CFI] = {
+		.core_note_type = NT_RISCV_USER_CFI,
+		.align = sizeof(__u64),
+		.n = sizeof(struct user_cfi_state) / sizeof(__u64),
+		.size = sizeof(__u64),
+		.regset_get = riscv_cfi_get,
+		.set = riscv_cfi_set,
+	},
+#endif
 };
 
 static const struct user_regset_view riscv_user_native_view = {
diff --git a/include/uapi/linux/elf.h b/include/uapi/linux/elf.h
index 819ded2d39de..ee30dcd80901 100644
--- a/include/uapi/linux/elf.h
+++ b/include/uapi/linux/elf.h
@@ -545,6 +545,8 @@ typedef struct elf64_shdr {
 #define NT_RISCV_VECTOR	0x901		/* RISC-V vector registers */
 #define NN_RISCV_TAGGED_ADDR_CTRL "LINUX"
 #define NT_RISCV_TAGGED_ADDR_CTRL 0x902	/* RISC-V tagged address control (prctl()) */
+#define NN_RISCV_USER_CFI	"LINUX"
+#define NT_RISCV_USER_CFI	0x903		/* RISC-V shadow stack state */
 #define NN_LOONGARCH_CPUCFG	"LINUX"
 #define NT_LOONGARCH_CPUCFG	0xa00	/* LoongArch CPU config registers */
 #define NN_LOONGARCH_CSR	"LINUX"

-- 
2.43.0


