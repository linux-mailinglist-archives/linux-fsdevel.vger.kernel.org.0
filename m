Return-Path: <linux-fsdevel+bounces-47670-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60A47AA3F24
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 02:35:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E31116F7EB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 00:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7398A2609F1;
	Wed, 30 Apr 2025 00:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="xOAnbh4L"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E651B2609CB
	for <linux-fsdevel@vger.kernel.org>; Wed, 30 Apr 2025 00:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745972229; cv=none; b=NrE6RZDyTd2LHGcQDrju/0PgOkjsyB5283o7uNNQU87/zpE8LqgZc8wAE/SlB+n1Xcc2jv21iP44qXAeXP6ewKCkU/CAFhRBcNok+a/stJi1nqCHtxxhMGvkYQtnMHR80NmoUSXiXw60Rtv04o7Z3uWzUoHYnS5jkewDBxmBpk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745972229; c=relaxed/simple;
	bh=4V/vc+IGuEXLJLSMGAlz1mzVikhLjzrFyJ0kt0SiHdA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pyKRwtctAVmcCtohRyzX3XqpblxZqvLnp2x5PN6jHgN6+RJxOvtI9VoAQoAbu6N/4+nx6Y+GR8xOwoveADvlQQmjblUcdc3i8np7iFpsHH/BYKSJyXz2SCgpd3eUzl9BzmlzXDoIyfVxPlpA/C/4HjW0HRUqbDJ54vy+aWs6iyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=xOAnbh4L; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-22c33ac23edso61521855ad.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Apr 2025 17:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1745972227; x=1746577027; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wqa+EnEmqD/WcxsFXdACBzGsJGhuUJWdKCVGNJwyc08=;
        b=xOAnbh4L4jFlBiCPu+/FlZJCwc0JLiVSzF3TxIHj2ISzRc8R/xaMq2jWRjWxyBSIvJ
         l+3Ru1kihn3EtzzDpTFHE4aDzaHxFzLOgdVaHm/f5CvpODglhPOBLOdPxFrItPKVg/9D
         6vzZN/Oh7OWzeaXGAgWjsWgxwEg2X05zCoFxhQnJMhMYWaHyR0jLiCo2iC4WzxHMK8YI
         BHs/FuYDA2WGIb3/65olA4YnZGyrHOdmMFntuOznGKalYEly2uVXd+M5vZpnuf9cTN08
         kMPXyvkcdb5TVQjZJFrlLJPtz26JIZ4H9kkKcvXBlqIFI3AV3yaZ7sqrEZJhrYWKl5tV
         3/5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745972227; x=1746577027;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wqa+EnEmqD/WcxsFXdACBzGsJGhuUJWdKCVGNJwyc08=;
        b=FEKQnbjCSIwy5oUKr0cTkMfDUR3c97oTrQUuOdA3MfC/tX8vqma+jIEfBRlNbH2raL
         Mgfk1SEovu2R/Wp0OpUcLjEFQJ0+4HWMKAxvPWY9xKg1J8Ex164WIMFERVvi5uKWd5NN
         sEJ54bq3lXZ6i1+sIBMu7sl3bSWJZQiRZam9yOpv7H4uErh/KJ3X2Fn70Id3C4EQPHzU
         b6dNVQjY3hrJQW+zzk14nzg2CJOQ/P7iNOMhpYRAlBJvH4cWVJSQaSKwB/2mgC3i2QtY
         zIyXlV1BfGJVq/viexospizdItNaGnxjrLemCGeI7BQjreJ8nyBbEPwjJs2D0wuQHXrS
         iJmQ==
X-Forwarded-Encrypted: i=1; AJvYcCXqyJXsnXFfy18OE96q1CXgtZdnYFBdaW1gqnU+tpk4OTfUy/2Dw+D6x13PZRPCl06H/Xw2pm1N1zRMfIAQ@vger.kernel.org
X-Gm-Message-State: AOJu0YxkW/W7qnNchnol6B8QkQ6GcbQptfPR4wGuOHh+WMwARJLZyOE1
	SlMNU7qhCQcBsUOFaAKX9+Gy+/GfozLCFGa32x19By1rzbxwuySQx04HW3dl/Cw=
X-Gm-Gg: ASbGncvMSYxC3KGhP2HgGe2s0k8omddLD9zpkZp8//BZopOV6QD8sv0grUTwUZIzgA5
	VdbQOMzOWBvmgEW3zPfRl0eAqRlv1iAIWqquI/dH+1gunYoqj2RXYlOfuq5fgKjRlvcZNRB12lU
	b+Cele/kqVru+p/JhttAt0TSv8R67IXi0W3K4djN5KPwEwu0Exw2pIWAD9QjbB3x2mnVu6gkilV
	J2eaMkVIJj8xD4R7PYRxYYisqDibgwiSb4BOneLNyv0zxppdd380onJXQ8RhtnRTGCFQ6p8FVWf
	UYFqIaaG1E9yiZDxyiNrBB8Z+IA8CuseyqkmgYczw17QobBWojE=
X-Google-Smtp-Source: AGHT+IHQiHW6ihtjUTT0DTqmkuWcAmVo/rllEq5v8YlabaxyEntdh+cJYjoV0mkSuSPow8vsrYIpLg==
X-Received: by 2002:a17:902:d4d1:b0:223:669f:ca2d with SMTP id d9443c01a7336-22df356d961mr20640625ad.35.1745972227361;
        Tue, 29 Apr 2025 17:17:07 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db4d770d6sm109386035ad.17.2025.04.29.17.17.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 17:17:07 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Tue, 29 Apr 2025 17:16:30 -0700
Subject: [PATCH v14 13/27] prctl: arch-agnostic prctl for indirect branch
 tracking
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250429-v5_user_cfi_series-v14-13-5239410d012a@rivosinc.com>
References: <20250429-v5_user_cfi_series-v14-0-5239410d012a@rivosinc.com>
In-Reply-To: <20250429-v5_user_cfi_series-v14-0-5239410d012a@rivosinc.com>
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

Three architectures (x86, aarch64, riscv) have support for indirect branch
tracking feature in a very similar fashion. On a very high level, indirect
branch tracking is a CPU feature where CPU tracks branches which uses
memory operand to perform control transfer in program. As part of this
tracking on indirect branches, CPU goes in a state where it expects a
landing pad instr on target and if not found then CPU raises some fault
(architecture dependent)

x86 landing pad instr - `ENDBRANCH`
arch64 landing pad instr - `BTI`
riscv landing instr - `lpad`

Given that three major arches have support for indirect branch tracking,
This patch makes `prctl` for indirect branch tracking arch agnostic.

To allow userspace to enable this feature for itself, following prtcls are
defined:
 - PR_GET_INDIR_BR_LP_STATUS: Gets current configured status for indirect
   branch tracking.
 - PR_SET_INDIR_BR_LP_STATUS: Sets a configuration for indirect branch
   tracking.
   Following status options are allowed
       - PR_INDIR_BR_LP_ENABLE: Enables indirect branch tracking on user
         thread.
       - PR_INDIR_BR_LP_DISABLE; Disables indirect branch tracking on user
         thread.
 - PR_LOCK_INDIR_BR_LP_STATUS: Locks configured status for indirect branch
   tracking for user thread.

Reviewed-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Zong Li <zong.li@sifive.com>
Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 include/linux/cpu.h        |  4 ++++
 include/uapi/linux/prctl.h | 27 +++++++++++++++++++++++++++
 kernel/sys.c               | 30 ++++++++++++++++++++++++++++++
 3 files changed, 61 insertions(+)

diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index e3049543008b..ea8b351b5bc5 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -204,4 +204,8 @@ static inline bool cpu_mitigations_auto_nosmt(void)
 }
 #endif
 
+int arch_get_indir_br_lp_status(struct task_struct *t, unsigned long __user *status);
+int arch_set_indir_br_lp_status(struct task_struct *t, unsigned long status);
+int arch_lock_indir_br_lp_status(struct task_struct *t, unsigned long status);
+
 #endif /* _LINUX_CPU_H_ */
diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
index 15c18ef4eb11..2e09b19317a3 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -364,4 +364,31 @@ struct prctl_mm_map {
 # define PR_TIMER_CREATE_RESTORE_IDS_ON		1
 # define PR_TIMER_CREATE_RESTORE_IDS_GET	2
 
+/*
+ * Get the current indirect branch tracking configuration for the current
+ * thread, this will be the value configured via PR_SET_INDIR_BR_LP_STATUS.
+ */
+#define PR_GET_INDIR_BR_LP_STATUS      78
+
+/*
+ * Set the indirect branch tracking configuration. PR_INDIR_BR_LP_ENABLE will
+ * enable cpu feature for user thread, to track all indirect branches and ensure
+ * they land on arch defined landing pad instruction.
+ * x86 - If enabled, an indirect branch must land on `ENDBRANCH` instruction.
+ * arch64 - If enabled, an indirect branch must land on `BTI` instruction.
+ * riscv - If enabled, an indirect branch must land on `lpad` instruction.
+ * PR_INDIR_BR_LP_DISABLE will disable feature for user thread and indirect
+ * branches will no more be tracked by cpu to land on arch defined landing pad
+ * instruction.
+ */
+#define PR_SET_INDIR_BR_LP_STATUS      79
+# define PR_INDIR_BR_LP_ENABLE		   (1UL << 0)
+
+/*
+ * Prevent further changes to the specified indirect branch tracking
+ * configuration.  All bits may be locked via this call, including
+ * undefined bits.
+ */
+#define PR_LOCK_INDIR_BR_LP_STATUS      80
+
 #endif /* _LINUX_PRCTL_H */
diff --git a/kernel/sys.c b/kernel/sys.c
index c434968e9f5d..91a1dc093c2a 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -2340,6 +2340,21 @@ int __weak arch_lock_shadow_stack_status(struct task_struct *t, unsigned long st
 	return -EINVAL;
 }
 
+int __weak arch_get_indir_br_lp_status(struct task_struct *t, unsigned long __user *status)
+{
+	return -EINVAL;
+}
+
+int __weak arch_set_indir_br_lp_status(struct task_struct *t, unsigned long status)
+{
+	return -EINVAL;
+}
+
+int __weak arch_lock_indir_br_lp_status(struct task_struct *t, unsigned long status)
+{
+	return -EINVAL;
+}
+
 #define PR_IO_FLUSHER (PF_MEMALLOC_NOIO | PF_LOCAL_THROTTLE)
 
 #ifdef CONFIG_ANON_VMA_NAME
@@ -2820,6 +2835,21 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
 			return -EINVAL;
 		error = posixtimer_create_prctl(arg2);
 		break;
+	case PR_GET_INDIR_BR_LP_STATUS:
+		if (arg3 || arg4 || arg5)
+			return -EINVAL;
+		error = arch_get_indir_br_lp_status(me, (unsigned long __user *)arg2);
+		break;
+	case PR_SET_INDIR_BR_LP_STATUS:
+		if (arg3 || arg4 || arg5)
+			return -EINVAL;
+		error = arch_set_indir_br_lp_status(me, arg2);
+		break;
+	case PR_LOCK_INDIR_BR_LP_STATUS:
+		if (arg3 || arg4 || arg5)
+			return -EINVAL;
+		error = arch_lock_indir_br_lp_status(me, arg2);
+		break;
 	default:
 		trace_task_prctl_unknown(option, arg2, arg3, arg4, arg5);
 		error = -EINVAL;

-- 
2.43.0


