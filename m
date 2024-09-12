Return-Path: <linux-fsdevel+bounces-29241-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6778E977509
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 01:21:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26929285ECA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 23:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5BFD1CA6A0;
	Thu, 12 Sep 2024 23:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="nYZ2yvdL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED2B1C9ECC
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Sep 2024 23:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726183073; cv=none; b=F2WH/m4hSoeF4tzKsjak1URZMxfRnbm/YCfENvzR7+YOHqfaaTHSk1UablpDDu/g3ezn8au7A3cua1kfB75xGt+sqEoAzwlukzHZ1Mr8Q569bBSmqW1X9KlPLY8BDlC8f7tviagMbbs1e3uHLxM5FgLiW5gXud5/zG7tjsAQskc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726183073; c=relaxed/simple;
	bh=WlmunyazaeByF44JRKxRY5RmwH1P3gIDBsVZ/ZvxA4g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RO6tIytIbGKykwyJNrOoaP9jJ4EjOK/t/qCGoxdKX+dKY8TO0qPHcRstwFTEx3aMf/kXl3Wav23jTobo/m7m84MC814hbt03blGeWaE6QtW6xrxhEpZeKpkTk4ScoJLaD0cWEDCeEN9JyC8czpcX9ZORGUdXKpijtGFebvVmun8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=nYZ2yvdL; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2d88690837eso1257345a91.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Sep 2024 16:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1726183070; x=1726787870; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IdMH+b8hMWx7M6md7N6CXtcv0PrleWKto++QHl76wt4=;
        b=nYZ2yvdLcSYbJ6uKqniLix1z2a6TB3tVpmFmF131auCZojQEuSJj614sStteanF7UA
         z8e4F/jCKKaBHgERC9jUlv6nGw11AGCGZiNhdYDO+iXtwYin40hb9xtZeCf5b2sJa/k7
         fhnnD9N/ii95sLxAIe3nKlOe3v1fzlwJ7IKlbnu9dB2xUMGrWyMDncIFWGji8F5YzRN0
         5L9DNoJ2ag/LHBVj31n8XM78mU6VZqMogexA2w8aTHxgZdgwy+tgxvdQoMST4lzwtybz
         vsCjoxMB98jI7Yi+Z/ZBc0Z8tlJtu/03gTLesiH1Qp6jV++3jbQ+GjbBjhNSwG9xWSzL
         Sp5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726183070; x=1726787870;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IdMH+b8hMWx7M6md7N6CXtcv0PrleWKto++QHl76wt4=;
        b=o4I3Q5gl03reXy7sCJQIrMxgNJPF6lb7uYQQLyWEipOYZLODDG2mKNtK/5IuFK9Im7
         AUk9gvBj6mJkcfhkMXhCaIwvnEX4IYjnJ6Hkuac2OdtziiWKVo6Oq2fZp2NpWpr7S6ML
         zOQLBh6S6HYCKflr5HFv/wam950c91Gd6HnJRXuIDOmFhS7eAVNqUBaL2e2rIdO1fCz7
         m2qtcibD+mKAhtOadI/4642hD/Wlci2wCr97VtbHZ9trIl6hiTgVRtcji99bHqxcWXOp
         gcq7P7vH3pqovbfubXweLt2sVB4xdhWvj0Xmxlu0+oMxnXW26PU6A9ARpHuB+BwDO+hb
         CE+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUvdFYZV6oXuMcbu5YPYjRvWc8XicFw8pzp5+3PHygxeaYlej2ff6E/kf3DomsO6LFC9uRgOrgJy7zKn5gj@vger.kernel.org
X-Gm-Message-State: AOJu0YwAVLU6zVd3pFwbdUarqKEuWDPtbLYUSVinnvz7AETGQyAGYE4Y
	VeAu/85duR7E0qzMSbp5OF+UNpGjpP6m2RX7w8mZvuWBtft9DBCfUT3OKvNarkQ=
X-Google-Smtp-Source: AGHT+IFFLSdBWtF2TFEc0MNeO8MBZSGLro8EZzW5E3fSn2Pc5KYqBR0cHiRpYxrN8cHcKSAWR1r/XQ==
X-Received: by 2002:a17:90a:9a86:b0:2d8:8818:4d53 with SMTP id 98e67ed59e1d1-2dba0090ccbmr4436318a91.41.1726183069691;
        Thu, 12 Sep 2024 16:17:49 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2db6c1ac69asm3157591a91.0.2024.09.12.16.17.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 16:17:49 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: paul.walmsley@sifive.com,
	palmer@sifive.com,
	conor@kernel.org,
	linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-arch@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: corbet@lwn.net,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	robh@kernel.org,
	krzk+dt@kernel.org,
	oleg@redhat.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	peterz@infradead.org,
	akpm@linux-foundation.org,
	arnd@arndb.de,
	ebiederm@xmission.com,
	kees@kernel.org,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	lorenzo.stoakes@oracle.com,
	shuah@kernel.org,
	brauner@kernel.org,
	samuel.holland@sifive.com,
	debug@rivosinc.com,
	andy.chiu@sifive.com,
	jerry.shih@sifive.com,
	greentime.hu@sifive.com,
	charlie@rivosinc.com,
	evan@rivosinc.com,
	cleger@rivosinc.com,
	xiao.w.wang@intel.com,
	ajones@ventanamicro.com,
	anup@brainfault.org,
	mchitale@ventanamicro.com,
	atishp@rivosinc.com,
	sameo@rivosinc.com,
	bjorn@rivosinc.com,
	alexghiti@rivosinc.com,
	david@redhat.com,
	libang.li@antgroup.com,
	jszhang@kernel.org,
	leobras@redhat.com,
	guoren@kernel.org,
	samitolvanen@google.com,
	songshuaishuai@tinylab.org,
	costa.shul@redhat.com,
	bhe@redhat.com,
	zong.li@sifive.com,
	puranjay@kernel.org,
	namcaov@gmail.com,
	antonb@tenstorrent.com,
	sorear@fastmail.com,
	quic_bjorande@quicinc.com,
	ancientmodern4@gmail.com,
	ben.dooks@codethink.co.uk,
	quic_zhonhan@quicinc.com,
	cuiyunhui@bytedance.com,
	yang.lee@linux.alibaba.com,
	ke.zhao@shingroup.cn,
	sunilvl@ventanamicro.com,
	tanzhasanwork@gmail.com,
	schwab@suse.de,
	dawei.li@shingroup.cn,
	rppt@kernel.org,
	willy@infradead.org,
	usama.anjum@collabora.com,
	osalvador@suse.de,
	ryan.roberts@arm.com,
	andrii@kernel.org,
	alx@kernel.org,
	catalin.marinas@arm.com,
	broonie@kernel.org,
	revest@chromium.org,
	bgray@linux.ibm.com,
	deller@gmx.de,
	zev@bewilderbeest.net
Subject: [PATCH v4 10/30] riscv: usercfi state for task and save/restore of CSR_SSP on trap entry/exit
Date: Thu, 12 Sep 2024 16:16:29 -0700
Message-ID: <20240912231650.3740732-11-debug@rivosinc.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240912231650.3740732-1-debug@rivosinc.com>
References: <20240912231650.3740732-1-debug@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Carves out space in arch specific thread struct for cfi status and shadow
stack in usermode on riscv.

This patch does following
- defines a new structure cfi_status with status bit for cfi feature
- defines shadow stack pointer, base and size in cfi_status structure
- defines offsets to new member fields in thread in asm-offsets.c
- Saves and restore shadow stack pointer on trap entry (U --> S) and exit
  (S --> U)

Shadow stack save/restore is gated on feature availiblity and implemented
using alternative. CSR can be context switched in `switch_to` as well but
soon as kernel shadow stack support gets rolled in, shadow stack pointer
will need to be switched at trap entry/exit point (much like `sp`). It can
be argued that kernel using shadow stack deployment scenario may not be as
prevalant as user mode using this feature. But even if there is some
minimal deployment of kernel shadow stack, that means that it needs to be
supported. And thus save/restore of shadow stack pointer in entry.S instead
of in `switch_to.h`.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>
---
 arch/riscv/include/asm/processor.h   |  1 +
 arch/riscv/include/asm/thread_info.h |  3 +++
 arch/riscv/include/asm/usercfi.h     | 24 ++++++++++++++++++++++++
 arch/riscv/kernel/asm-offsets.c      |  4 ++++
 arch/riscv/kernel/entry.S            | 26 ++++++++++++++++++++++++++
 5 files changed, 58 insertions(+)
 create mode 100644 arch/riscv/include/asm/usercfi.h

diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
index d61587964bd7..83d6ca4e0bba 100644
--- a/arch/riscv/include/asm/processor.h
+++ b/arch/riscv/include/asm/processor.h
@@ -14,6 +14,7 @@
 
 #include <asm/ptrace.h>
 #include <asm/hwcap.h>
+#include <asm/usercfi.h>
 
 /*
  * addr is a hint to the maximum userspace address that mmap should provide, so
diff --git a/arch/riscv/include/asm/thread_info.h b/arch/riscv/include/asm/thread_info.h
index c74536194626..cb694aef337d 100644
--- a/arch/riscv/include/asm/thread_info.h
+++ b/arch/riscv/include/asm/thread_info.h
@@ -58,6 +58,9 @@ struct thread_info {
 	int			cpu;
 	unsigned long		syscall_work;	/* SYSCALL_WORK_ flags */
 	unsigned long envcfg;
+#ifdef CONFIG_RISCV_USER_CFI
+	struct cfi_status       user_cfi_state;
+#endif
 #ifdef CONFIG_SHADOW_CALL_STACK
 	void			*scs_base;
 	void			*scs_sp;
diff --git a/arch/riscv/include/asm/usercfi.h b/arch/riscv/include/asm/usercfi.h
new file mode 100644
index 000000000000..4fa201b4fc4e
--- /dev/null
+++ b/arch/riscv/include/asm/usercfi.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0
+ * Copyright (C) 2024 Rivos, Inc.
+ * Deepak Gupta <debug@rivosinc.com>
+ */
+#ifndef _ASM_RISCV_USERCFI_H
+#define _ASM_RISCV_USERCFI_H
+
+#ifndef __ASSEMBLY__
+#include <linux/types.h>
+
+#ifdef CONFIG_RISCV_USER_CFI
+struct cfi_status {
+	unsigned long ubcfi_en : 1; /* Enable for backward cfi. */
+	unsigned long rsvd : ((sizeof(unsigned long)*8) - 1);
+	unsigned long user_shdw_stk; /* Current user shadow stack pointer */
+	unsigned long shdw_stk_base; /* Base address of shadow stack */
+	unsigned long shdw_stk_size; /* size of shadow stack */
+};
+
+#endif /* CONFIG_RISCV_USER_CFI */
+
+#endif /* __ASSEMBLY__ */
+
+#endif /* _ASM_RISCV_USERCFI_H */
diff --git a/arch/riscv/kernel/asm-offsets.c b/arch/riscv/kernel/asm-offsets.c
index b09ca5f944f7..5457f9070cff 100644
--- a/arch/riscv/kernel/asm-offsets.c
+++ b/arch/riscv/kernel/asm-offsets.c
@@ -45,6 +45,10 @@ void asm_offsets(void)
 #endif
 
 	OFFSET(TASK_TI_CPU_NUM, task_struct, thread_info.cpu);
+#ifdef CONFIG_RISCV_USER_CFI
+	OFFSET(TASK_TI_CFI_STATUS, task_struct, thread_info.user_cfi_state);
+	OFFSET(TASK_TI_USER_SSP, task_struct, thread_info.user_cfi_state.user_shdw_stk);
+#endif
 	OFFSET(TASK_THREAD_F0,  task_struct, thread.fstate.f[0]);
 	OFFSET(TASK_THREAD_F1,  task_struct, thread.fstate.f[1]);
 	OFFSET(TASK_THREAD_F2,  task_struct, thread.fstate.f[2]);
diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
index ac2e908d4418..ca9203e6d76d 100644
--- a/arch/riscv/kernel/entry.S
+++ b/arch/riscv/kernel/entry.S
@@ -60,6 +60,20 @@ SYM_CODE_START(handle_exception)
 
 	REG_L s0, TASK_TI_USER_SP(tp)
 	csrrc s1, CSR_STATUS, t0
+	/*
+	 * If previous mode was U, capture shadow stack pointer and save it away
+	 * Zero CSR_SSP at the same time for sanitization.
+	 */
+	ALTERNATIVE("nop; nop; nop; nop",
+				__stringify(			\
+				andi s2, s1, SR_SPP;	\
+				bnez s2, skip_ssp_save;	\
+				csrrw s2, CSR_SSP, x0;	\
+				REG_S s2, TASK_TI_USER_SSP(tp); \
+				skip_ssp_save:),
+				0,
+				RISCV_ISA_EXT_ZICFISS,
+				CONFIG_RISCV_USER_CFI)
 	csrr s2, CSR_EPC
 	csrr s3, CSR_TVAL
 	csrr s4, CSR_CAUSE
@@ -149,6 +163,18 @@ SYM_CODE_START_NOALIGN(ret_from_exception)
 	 * structures again.
 	 */
 	csrw CSR_SCRATCH, tp
+
+	/*
+	 * Going back to U mode, restore shadow stack pointer
+	 */
+	ALTERNATIVE("nop; nop",
+				__stringify(					\
+				REG_L s3, TASK_TI_USER_SSP(tp); \
+				csrw CSR_SSP, s3),
+				0,
+				RISCV_ISA_EXT_ZICFISS,
+				CONFIG_RISCV_USER_CFI)
+
 1:
 #ifdef CONFIG_RISCV_ISA_V_PREEMPTIVE
 	move a0, sp
-- 
2.45.0


