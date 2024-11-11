Return-Path: <linux-fsdevel+bounces-34311-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 569D89C476D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 22:01:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 160C6284117
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 21:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C7501CCB58;
	Mon, 11 Nov 2024 20:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="bU3Dszpm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068951CC16E
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2024 20:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731358475; cv=none; b=DklILgc9B6ByHs4eDqakVX3upNsScneS1vjWxVS6BuqaflzeOKW9Kfq5nDHFL6iHlxuJ1dWIJGWujFP81wTlgJinkKwjkBOW7YTQ3biFaSkZ54pcBP+M1N8sas1XEtNV9at4c642bDQtGagBQCApM9Kd7H64ZVZ1veT0BsfPpeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731358475; c=relaxed/simple;
	bh=8ieZNrrEN/UnXHxT5XTWXtI/q5FYLE81gQuhQu8xHpA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DotqZtv8Fu4hKnnH16az6jjb4itO5u928RRbixiVLt5CP1V3JPk+2mJ3ZrIV6XgXLF6B/0CVfqs8bMx7Pa5r7eP6uydl4lie0fBowmIqcC5H8yocE8q3PhdmY9lh56m2GcRzSOsaox6HB8odAp8ZQc4iZw9wX6h2iD/GRXmFidw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=bU3Dszpm; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7ed9c16f687so3346730a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2024 12:54:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1731358472; x=1731963272; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tXX3HktdfdUDYxlxepoMs9/t12X7ubBzoX+ktyscBn0=;
        b=bU3DszpmErapDO+xAOOCHpr5kIBJLc4RUBS05PNxNEXFasgiz8AVklzKmwvCDytsIR
         GsWl0WMILGYJ/m9vgomHSrGkmGJHO0DkhI1sp1SvpvrSrC3VGbnodBlbhc46Nwmeua3j
         IhhU5g1I81czdoWV0SDIqB6K9SWUtZ8gJHaXhIJSNBI0NYjBn6jSj81FOsjk+m06KctF
         LlWyqkM0f+0lmFwLM7Ye4rDAL3fcy+Th4OD2FRoHtLHUNDfwTEZquz4QWskXkOHRwhJi
         MBNoFUKQi59ZDsxq2iajnRGGTIIjRcMRr2eoWZkxOy5SbpBAWK0qvSFhNfEbUvy8kBlz
         pfYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731358472; x=1731963272;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tXX3HktdfdUDYxlxepoMs9/t12X7ubBzoX+ktyscBn0=;
        b=t1R8dCXvZ1aXz5euN9VPN87MnKNVJQ/P+bmcfXC9u0pn5c6zTgPiM+CdCFbb1F/0GT
         lh/vH6QUVBlCViuoTOM8vatbNkxkIk6PcXPajaHoG7xJsaq35G5yYDL2B3CqMc4DFCd5
         VYlRWz78RD3zpWFxd/xLBCiiln8GpEG4+S+wb/4Ginmg/GxEx8Dbd3bZGWBhwU71EYbn
         rcpkVx1PgDJa2ca4zdZOWuji05mjUZDewNBmtGO4noDVfttmoeRNJ4jWbNID61e7zFAe
         WF/mcfPtopUegglAgEHKwJd5TfZtW14wc6RbfGyZQKCDVSBbPMRgBB3j4aoagr+OOgtq
         AxiQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVR90xqzWEs1eRAbushGIojp7UJLAhYLSGexef4PMTn9ofcSAZBbhhGW4A0cmvhBozGoh4DZd8/qFoTjSC@vger.kernel.org
X-Gm-Message-State: AOJu0YxOqu13JUF4xeXcRYtZowmdIG/mSv7Ifl0+sOth9O9ekB37GXMR
	Vut1uY2Rk7ch9W3go3YvNg99QWkE8KQ93m56mnPfhYbf/upFadDA7zb6cGB8jmc=
X-Google-Smtp-Source: AGHT+IHq5Z7Xi/84uV65vfYB2LFlDXOy+r9mzEGPAb0M8IJd9siANoKs1hUvfB42yyVVA4FysR6vOw==
X-Received: by 2002:a17:90b:250f:b0:2e2:c421:894b with SMTP id 98e67ed59e1d1-2e9b1682496mr17398074a91.14.1731358472327;
        Mon, 11 Nov 2024 12:54:32 -0800 (PST)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e9a5fd1534sm9059974a91.42.2024.11.11.12.54.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 12:54:32 -0800 (PST)
From: Deepak Gupta <debug@rivosinc.com>
Date: Mon, 11 Nov 2024 12:53:59 -0800
Subject: [PATCH v8 14/29] prctl: arch-agnostic prctl for indirect branch
 tracking
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241111-v5_user_cfi_series-v8-14-dce14aa30207@rivosinc.com>
References: <20241111-v5_user_cfi_series-v8-0-dce14aa30207@rivosinc.com>
In-Reply-To: <20241111-v5_user_cfi_series-v8-0-dce14aa30207@rivosinc.com>
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
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
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

Three architectures (x86, aarch64, riscv) have support for indirect branch
tracking feature in a very similar fashion. On a very high level, indirect
branch tracking is a CPU feature where CPU tracks branches which uses
memory operand to perform control transfer in program. As part of this
tracking on indirect branches, CPU goes in a state where it expects a
landing pad instr on target and if not found then CPU raises some fault
(architecture dependent)

x86 landing pad instr - `ENDBRANCH`
aarch64 landing pad instr - `BTI`
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

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
Reviewed-by: Mark Brown <broonie@kernel.org>
---
 include/linux/cpu.h        |  4 ++++
 include/uapi/linux/prctl.h | 27 +++++++++++++++++++++++++++
 kernel/sys.c               | 30 ++++++++++++++++++++++++++++++
 3 files changed, 61 insertions(+)

diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index bdcec1732445..eff56aae05d7 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -203,4 +203,8 @@ static inline bool cpu_mitigations_auto_nosmt(void)
 }
 #endif
 
+int arch_get_indir_br_lp_status(struct task_struct *t, unsigned long __user *status);
+int arch_set_indir_br_lp_status(struct task_struct *t, unsigned long status);
+int arch_lock_indir_br_lp_status(struct task_struct *t, unsigned long status);
+
 #endif /* _LINUX_CPU_H_ */
diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
index c42ed44e86bc..8afd5cb70237 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -352,4 +352,31 @@ struct prctl_mm_map {
  */
 #define PR_LOCK_SHADOW_STACK_STATUS      76
 
+/*
+ * Get the current indirect branch tracking configuration for the current
+ * thread, this will be the value configured via PR_SET_INDIR_BR_LP_STATUS.
+ */
+#define PR_GET_INDIR_BR_LP_STATUS      77
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
+#define PR_SET_INDIR_BR_LP_STATUS      78
+# define PR_INDIR_BR_LP_ENABLE		   (1UL << 0)
+
+/*
+ * Prevent further changes to the specified indirect branch tracking
+ * configuration.  All bits may be locked via this call, including
+ * undefined bits.
+ */
+#define PR_LOCK_INDIR_BR_LP_STATUS      79
+
 #endif /* _LINUX_PRCTL_H */
diff --git a/kernel/sys.c b/kernel/sys.c
index 3d38a9c7c5c9..dafa31485584 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -2339,6 +2339,21 @@ int __weak arch_lock_shadow_stack_status(struct task_struct *t, unsigned long st
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
@@ -2814,6 +2829,21 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
 			return -EINVAL;
 		error = arch_lock_shadow_stack_status(me, arg2);
 		break;
+	case PR_GET_INDIR_BR_LP_STATUS:
+		if (arg3 || arg4 || arg5)
+			return -EINVAL;
+		error = arch_get_indir_br_lp_status(me, (unsigned long __user *) arg2);
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
 		error = -EINVAL;
 		break;

-- 
2.45.0


