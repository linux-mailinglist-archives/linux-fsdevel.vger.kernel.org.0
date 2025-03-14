Return-Path: <linux-fsdevel+bounces-44073-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AEA6BA61F00
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Mar 2025 22:45:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C9573AF2A6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Mar 2025 21:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC9BC21420F;
	Fri, 14 Mar 2025 21:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="JWthE3RO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5AAF2139BC
	for <linux-fsdevel@vger.kernel.org>; Fri, 14 Mar 2025 21:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741988419; cv=none; b=HCDEpTX2b37AGnQ6oLuG/7oV8NWd72jyA7y1kCFpJnrJPoBtN0h7aHaq7LwD9D7BnMcU1GhZ4gMWzVKwdhaybkr7FJXy6iBfCLHeP2xi2/VzdaOSy+zYATDQIBgUGblTF1/4GtKZn2X/DPPB+vhKXjQkJ7yOKqkHR8kjeWPM1TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741988419; c=relaxed/simple;
	bh=no//4s1hCd1n+ijW2BrzZfXeDu40oLpUpqqQfLr6u/M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H1d/rUvVmxZaDAXO1pqUcU9aLJU3sZYrJt3bbNyCzvsKLRhVz2Wq7FTx2hV6YDYLtrTECYDsJDxkEavlQ05P3JOZ8v39P5LGzU6zy0U7GHAXsFtrbahXr4RTcnWysuhDf7e0joOkOeHdcVCV1diCan0Gs8Ac6/66D7TTWV2JQ7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=JWthE3RO; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-224191d92e4so52589815ad.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Mar 2025 14:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1741988417; x=1742593217; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qihiC//CQppmEvCBgeNt37whYo0mSsmsLXBW9eHBYhI=;
        b=JWthE3ROQ555xytGCuqJakvgFZwMEH6nzJ5xiJSy3YwkHNMy0U6B7EOZkGsW45CndF
         98zp10YUzdAInV92yW6sk08vHQwSsXtoSTcBRBz+086I1S0ddwttCvaE4vfpCohI7fGY
         4OGiaKMV63RZ38+B5rsJQXDMZnBhanzWjnMx1H2hx7t67u1hC4pyJLFUBDrKc9euxuT6
         ufDgHsVqixFIS2jY6G0q/V4v3kwGDQK/pQcMU0jb5Vwm/fEJnBKd3Kv9o5c8ezwtAO9i
         m+0RIuvvwMBo2KWo9/YCtApYzHs8CNT2CuhR2Q5H9BwPhMYfuWYN+uhkE/gmxFXrhDKf
         Mf9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741988417; x=1742593217;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qihiC//CQppmEvCBgeNt37whYo0mSsmsLXBW9eHBYhI=;
        b=eRo3BjNPKJAy1iLPcZ/4BA4VVAI8PesRIs25IOwSbtZO42K7pmOo+cW4yvzaHLUXTI
         USnkaP90lxwjIGMZw4coExa03/a2kimF4UEXiib7UXYNHUfrI2AcaX/F4tPOzo+CZNU4
         ErJFVfWqgVJyQq6rj93bzCVpTyEU0h1/C9X3snP1qa9EWZ8MCWDvCdYRJSgNFUldYZc3
         Huy+pQNgJUu1EGmlsuspTSfyDeTJ2tdlMYOChmar12jOGqmI3CT+6PUzEhrF/jISxOFL
         SL2wIJRgniLGACP4sQSCif3SRvwDNwWOMrbp3rAH+YQem/h5RCSjDsjdnakiEilTeI/6
         eOXg==
X-Forwarded-Encrypted: i=1; AJvYcCVauho5PIkHdbMghBA3no02Xao/uKyRtPQfk67DkFdS5e+BhaiKmXRT4ZK9IOYMvzT8DokuWslP/dbjjyrE@vger.kernel.org
X-Gm-Message-State: AOJu0YxxL2oN5AwPOTNAI6+mSrJn4eUiS+YveDVLGpS86nyTSMwG7Ezg
	Q6Hn3XpVkB2OWqHHeiB19AycfJfmzFSLpGwvdr6/XszQ+23XdBlckfLfoy3rfh4=
X-Gm-Gg: ASbGncs46J4PuGGZyLX4Dx8Y9iKRbw4F2OO/OIT45Ya+oRc/0HP3ZiAMQXkepOK35mn
	3wfVoXGZk3IkiRHgYYlZsoyVxzSpgP1Yg607TJAI2LgxlZeRKVYvG+G3kCY+gM1cjK2aNXayfkA
	xk7p+KmzowZMnup9lZKRNtZ4G9sMD7ZzZ7dAGIJTxOiWdEIlMVm1IR2bcJJYVeQoB1mkxPYAySI
	dV7HqGOBTEV4rgicASmuthjUEx0KkDTfk7qKG+QuBKSC3GSuOeyKeo1cp4yNeQPgXkfAvUCWKLC
	yw0FhGwR5RGDgu08ywqz3amnP2CFzMnskyTRm1kXhjcxstC3gxuG0vM=
X-Google-Smtp-Source: AGHT+IEHTIgzeGQs95nPlCKytt5z5yea/NHClPHPp1BUNubi4Uv9wCiZoYw+B2CYuOVgi1HkJrteRg==
X-Received: by 2002:a17:902:da90:b0:224:10a2:cae7 with SMTP id d9443c01a7336-225e0af9d92mr50201135ad.40.1741988417057;
        Fri, 14 Mar 2025 14:40:17 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c68a6e09sm33368855ad.55.2025.03.14.14.40.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 14:40:16 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Fri, 14 Mar 2025 14:39:38 -0700
Subject: [PATCH v12 19/28] riscv/ptrace: riscv cfi status and state via
 ptrace and in core files
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250314-v5_user_cfi_series-v12-19-e51202b53138@rivosinc.com>
References: <20250314-v5_user_cfi_series-v12-0-e51202b53138@rivosinc.com>
In-Reply-To: <20250314-v5_user_cfi_series-v12-0-e51202b53138@rivosinc.com>
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

Expose a new register type NT_RISCV_USER_CFI for risc-v cfi status and
state. Intentionally both landing pad and shadow stack status and state
are rolled into cfi state. Creating two different NT_RISCV_USER_XXX would
not be useful and wastage of a note type. Enabling or disabling of feature
is not allowed via ptrace set interface. However setting `elp` state or
setting shadow stack pointer are allowed via ptrace set interface. It is
expected `gdb` might have use to fixup `elp` state or `shadow stack`
pointer.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 arch/riscv/include/uapi/asm/ptrace.h | 18 ++++++++
 arch/riscv/kernel/ptrace.c           | 83 ++++++++++++++++++++++++++++++++++++
 include/uapi/linux/elf.h             |  1 +
 3 files changed, 102 insertions(+)

diff --git a/arch/riscv/include/uapi/asm/ptrace.h b/arch/riscv/include/uapi/asm/ptrace.h
index 659ea3af5680..e6571fba8a8a 100644
--- a/arch/riscv/include/uapi/asm/ptrace.h
+++ b/arch/riscv/include/uapi/asm/ptrace.h
@@ -131,6 +131,24 @@ struct __sc_riscv_cfi_state {
 	unsigned long ss_ptr;   /* shadow stack pointer */
 };
 
+struct __cfi_status {
+	/* indirect branch tracking state */
+	__u64 lp_en : 1;
+	__u64 lp_lock : 1;
+	__u64 elp_state : 1;
+
+	/* shadow stack status */
+	__u64 shstk_en : 1;
+	__u64 shstk_lock : 1;
+
+	__u64 rsvd : sizeof(__u64) - 5;
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
index ea67e9fb7a58..df8b7c6ab671 100644
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
@@ -184,6 +188,75 @@ static int tagged_addr_ctrl_set(struct task_struct *target,
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
+	regs = task_pt_regs(target);
+
+	user_cfi.cfi_status.lp_en = is_indir_lp_enabled(target);
+	user_cfi.cfi_status.lp_lock = is_indir_lp_locked(target);
+	user_cfi.cfi_status.elp_state = (regs->status & SR_ELP);
+
+	user_cfi.cfi_status.shstk_en = is_shstk_enabled(target);
+	user_cfi.cfi_status.shstk_lock = is_shstk_locked(target);
+	user_cfi.shstk_ptr = get_active_shstk(target);
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
+	if (user_cfi.cfi_status.lp_en || user_cfi.cfi_status.lp_lock ||
+	    user_cfi.cfi_status.shstk_en || user_cfi.cfi_status.shstk_lock ||
+	    !user_cfi.cfi_status.rsvd)
+		return -EINVAL;
+
+	/* If lpad is enabled on target and ptrace requests to set / clear elp, do that */
+	if (is_indir_lp_enabled(target)) {
+		if (user_cfi.cfi_status.elp_state) /* set elp state */
+			regs->status |= SR_ELP;
+		else
+			regs->status &= ~SR_ELP; /* clear elp state */
+	}
+
+	/* If shadow stack enabled on target, set new shadow stack pointer */
+	if (is_shstk_enabled(target))
+		set_active_shstk(target, user_cfi.shstk_ptr);
+
+	return 0;
+}
+#endif
+
 static const struct user_regset riscv_user_regset[] = {
 	[REGSET_X] = {
 		.core_note_type = NT_PRSTATUS,
@@ -224,6 +297,16 @@ static const struct user_regset riscv_user_regset[] = {
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
index b44069d29cec..b9daed4ab780 100644
--- a/include/uapi/linux/elf.h
+++ b/include/uapi/linux/elf.h
@@ -452,6 +452,7 @@ typedef struct elf64_shdr {
 #define NT_RISCV_CSR	0x900		/* RISC-V Control and Status Registers */
 #define NT_RISCV_VECTOR	0x901		/* RISC-V vector registers */
 #define NT_RISCV_TAGGED_ADDR_CTRL 0x902	/* RISC-V tagged address control (prctl()) */
+#define NT_RISCV_USER_CFI	0x903		/* RISC-V shadow stack state */
 #define NT_LOONGARCH_CPUCFG	0xa00	/* LoongArch CPU config registers */
 #define NT_LOONGARCH_CSR	0xa01	/* LoongArch control and status registers */
 #define NT_LOONGARCH_LSX	0xa02	/* LoongArch Loongson SIMD Extension registers */

-- 
2.34.1


