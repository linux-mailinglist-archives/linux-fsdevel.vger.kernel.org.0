Return-Path: <linux-fsdevel+bounces-47975-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A6ACAA7D34
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 May 2025 01:38:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F8EA9A03A0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 May 2025 23:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3854026D4C9;
	Fri,  2 May 2025 23:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="uVOMRKwZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C37426B978
	for <linux-fsdevel@vger.kernel.org>; Fri,  2 May 2025 23:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746228700; cv=none; b=mGxE+hekDfga4fQuZyGjCwvh9hMFc9zwf8HCvwhWppCGSPvuvEk0sr16XhQsund8DRyKpPoVugowAJIv+CTv9JpysT9HnOvogLTtB/TG65tpVYjzt/8A0LriNCRvgKSNMnimQmWGlRA6ivIM+wZVpFElGvSvdkxNqwrHHRwgru4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746228700; c=relaxed/simple;
	bh=DD8AZK8ySfZe7gMGHOO9A42rFShjR5wdUyvOAGK6saQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V7IjG8Y2oh/iWJN1R9ENBiHGWkXZEbBZ4QJWFemUyQIybfqNT6LnV6nEItxZy7w2WjOcfvmXqYxG4ngMRjc2qk+aDMdDoG7zonTcMpBfEBGrwBVwpkv5F50F1icnU8xTIUp94PY1FJX1UQqTFTULXaJ/sGcHVBJYoi+BmGWM+js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=uVOMRKwZ; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-223f4c06e9fso24880845ad.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 02 May 2025 16:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1746228698; x=1746833498; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ju4eTa3aeO/W78J21C+hNLwsAKoKH1MKseai5GOrm10=;
        b=uVOMRKwZ/X/orDBHu3T3UIvXa26PpT1xEdgPNFm+NZZBUUrlLqI/5xx0Anj5RobIZM
         mB0Kba2e7tvCrhv4b7RiCTixBDpQiBSwI+McRM3Emgqfm8tFuFpKNnZyxrtdMMw8oond
         OsrM982J2hxQR7UF3wxydhcuYgSWZwvTvP0IC5HbxfhCSN4jrOgrKR10h5YDBdWFYOf+
         Lnq2Mjut//YfssMp7nmPYk217OQ/v2Xf0DEboh/71LOxAMqm8YRXqFDeIZ4YhHNc6p6k
         gp8AenZ7O5RnMRVovJ9I+NoypXNOTBBupBIiRX7ycxlYdwSjEU850afakAs7xreD5Njr
         p+mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746228698; x=1746833498;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ju4eTa3aeO/W78J21C+hNLwsAKoKH1MKseai5GOrm10=;
        b=B0Cdv43k604dQfjcTHF8wGNIYPsZTCRUb+M56e7Z6f2N5YG7T+zWCbnYQ+Uhv1hPbx
         1NIVH3tI+OaSdQlbeM0Pzk5rrgou0zpSeB2EQM+f6+W55KND+Z23440GwbHhmutn+goE
         TeQwuuKhsXCn1d5zTSFUfUxyzVwCVaLekc25RsEAH7Fuy074OoaTxT9ux4rQ8wGNWn7m
         O8C6+CnJiSxeduObr43mws9ITfKCMtca2WeIEEnqy+0TrFT8vbdYk9OEzSROv+BNbxK3
         mHEaQd2I2yO42ir7sjBnpYBc42vlff8UufaQoU59TyVafZ8RykNISV+YguAy/sg99dmA
         6Baw==
X-Forwarded-Encrypted: i=1; AJvYcCXUapNNhAGBCotKToBw86mcBA0SglnhwECgmAq7uK5E3/nhDY1SaXmDCTO2ti7bX7ArjAQtJBldgbvFX+t9@vger.kernel.org
X-Gm-Message-State: AOJu0YwpSSUxzTSFyL3MaFKhy+JJXBEho3m0fu//cJN/N53ujS1SiBtR
	fKs0GNX/EJwlNCjyCIyXzzt2bTJyGCYwIOBSioKlArHn+aHtOMEoF8rx5NKv6gU=
X-Gm-Gg: ASbGncs+4Hpr6x7bndWbFMEtrh0NTgi8jCfUbqunq/1dn2+gnEJs17JnWm0Y94SoLBn
	StQelSyD/ZUV/Zf5s8kj+UfUcvEYdtOx9sjsi/jDa31nAfHmx8t9AJtCktxeLKfUfv9mZ150uJX
	ZTGBl9/mztUvvVd/juZr1cIgnSKYO1fCNbalvI4RaIKodatk7Kvoe9MqZDtwspfMS9UUIBuRI/j
	529QxTTZiBCCYzvO4kf1wdooX57v+iztAVwm5Wa+91FLWOB3I4s6sKZDgm4s+29eStGB6SSePZv
	byGucij9hT33h3z6cYvA/b+QLlF1LLNXTifURC3Pjx3AO4L+gEQ=
X-Google-Smtp-Source: AGHT+IH40Jmn6oEiZT0umVLkqo8dVsl41YyQO4DPBkxlhpe7o3KvJQ1BRD6SebSW+AuEVdZx++vrtA==
X-Received: by 2002:a17:903:3c47:b0:215:58be:3349 with SMTP id d9443c01a7336-22e1007d2bamr83923895ad.14.1746228697999;
        Fri, 02 May 2025 16:31:37 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e15228ff2sm13367055ad.180.2025.05.02.16.31.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 16:31:37 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Fri, 02 May 2025 16:30:50 -0700
Subject: [PATCH v15 19/27] riscv/ptrace: riscv cfi status and state via
 ptrace and in core files
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250502-v5_user_cfi_series-v15-19-914966471885@rivosinc.com>
References: <20250502-v5_user_cfi_series-v15-0-914966471885@rivosinc.com>
In-Reply-To: <20250502-v5_user_cfi_series-v15-0-914966471885@rivosinc.com>
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
index 659ea3af5680..42c3fc8bd513 100644
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
+#define PTRACE_CFI_SS_PTR_STATE		(1 << PTRACE_CFI_SS_PTR_BIT)
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
 #endif /* __ASSEMBLY__ */
 
 #endif /* _UAPI_ASM_RISCV_PTRACE_H */
diff --git a/arch/riscv/kernel/ptrace.c b/arch/riscv/kernel/ptrace.c
index ea67e9fb7a58..933a3d26d33c 100644
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
 		.core_note_type = NT_PRSTATUS,
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


