Return-Path: <linux-fsdevel+bounces-56468-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63411B179AA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Aug 2025 01:24:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B43311C80BF2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Jul 2025 23:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4042A2877E5;
	Thu, 31 Jul 2025 23:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="p+SNytsy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B0E2877E2
	for <linux-fsdevel@vger.kernel.org>; Thu, 31 Jul 2025 23:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754004000; cv=none; b=dVTrbPr+W4Inl/jpXzS7FZC8d30DelmNgW16QMFh7awIyUVAXH3l6UBHQ+uLK4z6DvRvSHd8VtvIjGZ2Iaw6SgXyqrvmQHOA4HxH9pzchuzifT0l8HYCbpr23YrmFDQ1etfjdqSQseWV6ZZARBF/BK3f0j3KndRESN6Un4hMcFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754004000; c=relaxed/simple;
	bh=ykSXz3wnLGRA/+3+A2mDa3RMmU6JkcBGLDfL5CZd3kk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JnRB0Z4vr4raPdvAQWQGIO7oPm9dJXxAZPjmwDiucx7TZwsUXzALxTUqTCB3Gar182YbWpMUQxq0adKeGcuuo5DLTI7XbKN5s+He38ewPuEhw0stZ6O7er+dYUrH+Nr/uQ+VDOOOL/Sf6eVN9V6G4VceCW/5jOG+wVA8oxuce5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=p+SNytsy; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-31ee880f7d2so1597411a91.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 31 Jul 2025 16:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1754003998; x=1754608798; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9Zc5n/fmBFqSLzd2InHh+oo1/6vhMJLkVEGctgWUI64=;
        b=p+SNytsy2jSsN7uVEgk5p/FP3wQNGSoZ5oI+XpNGRqMqyVDGE8uwIa899xOSyWmLK9
         q6WAa6Ym3fo7mABYJ2wvCoXIAvKSEYF1VHTS/OorJOGmyL7bORh+p1lC74jjg7Ss4iFX
         UL5sUPNftRqAGPX9+g495MJYtZag5mfgULG8gJhU+BkWtAPmduOVugAo/4gBl7QbwZRg
         mYBAlrpNG1KbJuzPaKBZvWE71SIXstwbOTrUV3fCFDAkcNbOOjq5m70dThX3wA014wYM
         YP66/803PRpNMHhCJ05+6SdcDYX5soSoMDizz9JCE5UBsra34spl4hb8V7O0w5ArHVxQ
         KpXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754003998; x=1754608798;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Zc5n/fmBFqSLzd2InHh+oo1/6vhMJLkVEGctgWUI64=;
        b=TxmggCh3UZMazvUgAUqohFF1NQEe+Os4pjAy7K0NSYRTlv8EARsWI6SLTX4IrzDLox
         8GWQd53OW9FLKm44FkKUn1hMtMLAVGWAVl3flRLVz0JweLUSSJWqsI7Z1VSVgky0Qxqn
         Xj/Fm5hyGgbkfxtj4WuzkmEwzfWzHBHU8S560/pcIYaMM1/E7f1VKL2bAB86U8MiCz9z
         pjs6vEAQ0cKEmPMKQS+R7KW4L+kjr2Zkp5N2mfayXf7aoAenYQ5BXxZy1iQ0c0w+oZwv
         NknuJXmFu0s9fdDKiOEMaCN67UTTHdw8Irfk4zm0bHzCF35anYtQf9x/GYcKzb2EBX7U
         HVZw==
X-Forwarded-Encrypted: i=1; AJvYcCVJlUz6RycLDJYfKVZdzkFKmoqoaU0Hzn2iJ8A1SZnVJg5a9mWnp3IRNwc+pgK+XoVLmEJb+YD2X/d7MkZ3@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+DrMyXchRwh7h2uWw4treQHj5m6VX5r+jXLfpS0mmdNIZ8uQh
	mu/gq90NJljkwRHQ2+OMfRe1sM6ixkvdHnpMbUK0mWb/E6aC9ObzfrxWj432OjBiHgY=
X-Gm-Gg: ASbGncu1JG46sU419bsTOyJuL3bmky/Yvl0LcZI/7fgmfugt7TmpDnAKEgKg1L+WLg0
	e9SDOYLrfhK1RmcNO9fXB/fGVNai+RD9e95IYMdxGPhGms7ih4MivwgaQ6fgKZzZznevb2kvIeF
	0Zu8PGgMtQ0+V9hVa5VmVKVVaZAEv2B1IZlJw+WMtJI3g7dxiS3KvX6C5qB0AN6zNy/zC353IKw
	2oww2P8dvktfKimSa8R4kTiW9X7IDXZCkvS0QO5ffoQX8K2MKGUdRDjG2oY9nY7sCJTE8SztJUC
	U5hkIevJWUDoJ+3M4DOJdssd1OGnb3Lxa8d0B87lGJRhe9WWB7gFaavnvaNFipfMKxrbocYn3iO
	T3BW8NP35qhgKTOA7BdAA5DOtkNaglNLD
X-Google-Smtp-Source: AGHT+IGMci/ZUZvRGC0c5qs/SYI7GTnxNqXfFm57trPuw38BbDf+AgAuyfA9SnoqlH12HgSVHy/1mA==
X-Received: by 2002:a17:90b:1d88:b0:31f:3c3:947c with SMTP id 98e67ed59e1d1-31f5ddb5396mr12372587a91.10.1754003998042;
        Thu, 31 Jul 2025 16:19:58 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31f63da8fcfsm5773085a91.7.2025.07.31.16.19.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 16:19:57 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Thu, 31 Jul 2025 16:19:23 -0700
Subject: [PATCH v19 13/27] prctl: arch-agnostic prctl for indirect branch
 tracking
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250731-v5_user_cfi_series-v19-13-09b468d7beab@rivosinc.com>
References: <20250731-v5_user_cfi_series-v19-0-09b468d7beab@rivosinc.com>
In-Reply-To: <20250731-v5_user_cfi_series-v19-0-09b468d7beab@rivosinc.com>
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
index e6089abc28e2..e94cd69825e2 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -208,4 +208,8 @@ static inline bool cpu_mitigations_auto_nosmt(void)
 }
 #endif
 
+int arch_get_indir_br_lp_status(struct task_struct *t, unsigned long __user *status);
+int arch_set_indir_br_lp_status(struct task_struct *t, unsigned long status);
+int arch_lock_indir_br_lp_status(struct task_struct *t, unsigned long status);
+
 #endif /* _LINUX_CPU_H_ */
diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
index 43dec6eed559..9cbb37afccda 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -371,4 +371,31 @@ struct prctl_mm_map {
 # define PR_FUTEX_HASH_GET_SLOTS	2
 # define PR_FUTEX_HASH_GET_IMMUTABLE	3
 
+/*
+ * Get the current indirect branch tracking configuration for the current
+ * thread, this will be the value configured via PR_SET_INDIR_BR_LP_STATUS.
+ */
+#define PR_GET_INDIR_BR_LP_STATUS      79
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
+#define PR_SET_INDIR_BR_LP_STATUS      80
+# define PR_INDIR_BR_LP_ENABLE		   (1UL << 0)
+
+/*
+ * Prevent further changes to the specified indirect branch tracking
+ * configuration.  All bits may be locked via this call, including
+ * undefined bits.
+ */
+#define PR_LOCK_INDIR_BR_LP_STATUS      81
+
 #endif /* _LINUX_PRCTL_H */
diff --git a/kernel/sys.c b/kernel/sys.c
index adc0de0aa364..af6c28dc6b71 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -2341,6 +2341,21 @@ int __weak arch_lock_shadow_stack_status(struct task_struct *t, unsigned long st
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
@@ -2824,6 +2839,21 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
 	case PR_FUTEX_HASH:
 		error = futex_hash_prctl(arg2, arg3, arg4);
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


