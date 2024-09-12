Return-Path: <linux-fsdevel+bounces-29242-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E3F97750E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 01:21:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16FAF1F254F1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 23:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE1E71CA6A9;
	Thu, 12 Sep 2024 23:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="dP07W/AC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFBC01CA6A6
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Sep 2024 23:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726183076; cv=none; b=MCX97FI/nq3G1fFjC/KRGYAw2aWQ6li1DpIz4my8YA4fZ2UtDKCIbydL02E1qf8eU0VLvBmpUA0bNA4UB4dA2seT2bekQAndPc0KrGYeDWQyXLQv4Ii5+2kclDoKQJuRyGRcluXz/ZvTpbPo77L44mn7yytDx3qHE5PvBRlOvn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726183076; c=relaxed/simple;
	bh=EHU+93eBzQNZszHkkLULrtx7hZG3HFcTa50zagBvcq8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o2YvCePKpf0y6f8CNDSb2at4HFsotbV5TE83lFK3yX0SpTy47ORsln+ScnPKOR0iMzdqCYFLImhkKPMZRiyFX3x+ibSEwPVhoNmGYqLJWD/znja9B73rQHssVStrtD2mwzxhVa4aW9xRx7IrIegy7wiQDxDxll+uqihlM6fkx/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=dP07W/AC; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2d8815ef6d2so1276820a91.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Sep 2024 16:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1726183074; x=1726787874; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eiprnGA2BOGVGzJqIZ9S6uz8auKceb/MWPdqRC4IaOM=;
        b=dP07W/ACmZ4LEK74Bxj79Z2SEdjo218R0pFGbGgipsippIWYUfT3/PO8W5LxzsSjXp
         C+OkE9WOCml4mTLmWNuvH92nUdgstppfAV6ocjd4hDgnlAyq9Ac053qeRwTOegSYNM1N
         EX3B5pe4eNjOL9qb94Iz37+LxGtjj0QsMUsoHRSchk9GMrZHjp0idZCjrQojWNbIPBzT
         cJf+BFJ79uOrTVzwfRwAMMuJZTR4TXT0OgXrmCMu/JfaNjAgBfuEfL+a98EdBoRbLmV7
         bq74DZ4jW6Okxg5j4OPD1XU6+6EZjjsm8aipmXPjzQIfuSTPjqvG0VJm50b2FXoWHYsu
         gTgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726183074; x=1726787874;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eiprnGA2BOGVGzJqIZ9S6uz8auKceb/MWPdqRC4IaOM=;
        b=FIGRFtaTmBsUUR190PnqS80/c+JjuZkVXOVwvj/OYhfiLi9gTx9lu6yaVf7vc2rgNT
         DSjXS6mshm+V4xe4dUOsHPotB0WQWz8W3rn3eMJC3J1BaxXdL/dT3X8uw2j/DxR9aI8D
         06FlHIToHkS6AJFh6CjJGQeNE3aRnf+K3EvB5vWFlB3ftqLOhomrsyOrt7ZoxOt3npqX
         XacmGtUryhg8/PHJtwtQJ3sCMELvfCe9ZYovbT5Eyjd6LClF/Gfo2ErEU4YfnK+MqGEY
         l7cV4z8Mjhpv08mgvbsT/QnyAP2NOV36uo50xH+9tQfUtRaepkPaxCvIBE33/1FRi8TP
         Mwxg==
X-Forwarded-Encrypted: i=1; AJvYcCVuZ4ofYtC1XvfE+shJp7IW4oHHZSzpCLUiTyvyWkaP+s/QAsuEgouBfDON6OUpClU3XoB9tWrqg68aF7wl@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+j1Eo+H/WXuisYI3J+UAawMdjVQkAuHWyBo5z/T6/4sCuixsK
	9FO2T8QY7UB3BoO7PF+/V2dd4XZLS78cEESlq2lffkzBBRZI4s4qe0qvFWcdJIo=
X-Google-Smtp-Source: AGHT+IEnJrdTR1Y5qPMoOCKu4YCibaPdfaIv67ki6aFPE+yQ7lsYshwSwmMRsNa90sGyf+0sNSEfcA==
X-Received: by 2002:a17:90a:8a13:b0:2da:bd08:edc2 with SMTP id 98e67ed59e1d1-2db9ffcaaaamr5258868a91.9.1726183074122;
        Thu, 12 Sep 2024 16:17:54 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2db6c1ac69asm3157591a91.0.2024.09.12.16.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 16:17:53 -0700 (PDT)
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
Subject: [PATCH v4 11/30] riscv/mm : ensure PROT_WRITE leads to VM_READ | VM_WRITE
Date: Thu, 12 Sep 2024 16:16:30 -0700
Message-ID: <20240912231650.3740732-12-debug@rivosinc.com>
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

`arch_calc_vm_prot_bits` is implemented on risc-v to return VM_READ |
VM_WRITE if PROT_WRITE is specified. Similarly `riscv_sys_mmap` is
updated to convert all incoming PROT_WRITE to (PROT_WRITE | PROT_READ).
This is to make sure that any existing apps using PROT_WRITE still work.

Earlier `protection_map[VM_WRITE]` used to pick read-write PTE encodings.
Now `protection_map[VM_WRITE]` will always pick PAGE_SHADOWSTACK PTE
encodings for shadow stack. Above changes ensure that existing apps
continue to work because underneath kernel will be picking
`protection_map[VM_WRITE|VM_READ]` PTE encodings.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 arch/riscv/include/asm/mman.h    | 24 ++++++++++++++++++++++++
 arch/riscv/include/asm/pgtable.h |  1 +
 arch/riscv/kernel/sys_riscv.c    | 10 ++++++++++
 arch/riscv/mm/init.c             |  2 +-
 mm/mmap.c                        |  1 +
 5 files changed, 37 insertions(+), 1 deletion(-)
 create mode 100644 arch/riscv/include/asm/mman.h

diff --git a/arch/riscv/include/asm/mman.h b/arch/riscv/include/asm/mman.h
new file mode 100644
index 000000000000..ef9fedf32546
--- /dev/null
+++ b/arch/riscv/include/asm/mman.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_MMAN_H__
+#define __ASM_MMAN_H__
+
+#include <linux/compiler.h>
+#include <linux/types.h>
+#include <uapi/asm/mman.h>
+
+static inline unsigned long arch_calc_vm_prot_bits(unsigned long prot,
+	unsigned long pkey __always_unused)
+{
+	unsigned long ret = 0;
+
+	/*
+	 * If PROT_WRITE was specified, force it to VM_READ | VM_WRITE.
+	 * Only VM_WRITE means shadow stack.
+	 */
+	if (prot & PROT_WRITE)
+		ret = (VM_READ | VM_WRITE);
+	return ret;
+}
+#define arch_calc_vm_prot_bits(prot, pkey) arch_calc_vm_prot_bits(prot, pkey)
+
+#endif /* ! __ASM_MMAN_H__ */
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 089f3c9f56a3..af4337774fe5 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -181,6 +181,7 @@ extern struct pt_alloc_ops pt_ops __meminitdata;
 #define PAGE_READ_EXEC		__pgprot(_PAGE_BASE | _PAGE_READ | _PAGE_EXEC)
 #define PAGE_WRITE_EXEC		__pgprot(_PAGE_BASE | _PAGE_READ |	\
 					 _PAGE_EXEC | _PAGE_WRITE)
+#define PAGE_SHADOWSTACK       __pgprot(_PAGE_BASE | _PAGE_WRITE)
 
 #define PAGE_COPY		PAGE_READ
 #define PAGE_COPY_EXEC		PAGE_READ_EXEC
diff --git a/arch/riscv/kernel/sys_riscv.c b/arch/riscv/kernel/sys_riscv.c
index d77afe05578f..43a448bf254b 100644
--- a/arch/riscv/kernel/sys_riscv.c
+++ b/arch/riscv/kernel/sys_riscv.c
@@ -7,6 +7,7 @@
 
 #include <linux/syscalls.h>
 #include <asm/cacheflush.h>
+#include <asm-generic/mman-common.h>
 
 static long riscv_sys_mmap(unsigned long addr, unsigned long len,
 			   unsigned long prot, unsigned long flags,
@@ -16,6 +17,15 @@ static long riscv_sys_mmap(unsigned long addr, unsigned long len,
 	if (unlikely(offset & (~PAGE_MASK >> page_shift_offset)))
 		return -EINVAL;
 
+	/*
+	 * If PROT_WRITE is specified then extend that to PROT_READ
+	 * protection_map[VM_WRITE] is now going to select shadow stack encodings.
+	 * So specifying PROT_WRITE actually should select protection_map [VM_WRITE | VM_READ]
+	 * If user wants to create shadow stack then they should use `map_shadow_stack` syscall.
+	 */
+	if (unlikely((prot & PROT_WRITE) && !(prot & PROT_READ)))
+		prot |= PROT_READ;
+
 	return ksys_mmap_pgoff(addr, len, prot, flags, fd,
 			       offset >> (PAGE_SHIFT - page_shift_offset));
 }
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index eb0649a61b4c..000b51c26943 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -324,7 +324,7 @@ pgd_t early_pg_dir[PTRS_PER_PGD] __initdata __aligned(PAGE_SIZE);
 static const pgprot_t protection_map[16] = {
 	[VM_NONE]					= PAGE_NONE,
 	[VM_READ]					= PAGE_READ,
-	[VM_WRITE]					= PAGE_COPY,
+	[VM_WRITE]					= PAGE_SHADOWSTACK,
 	[VM_WRITE | VM_READ]				= PAGE_COPY,
 	[VM_EXEC]					= PAGE_EXEC,
 	[VM_EXEC | VM_READ]				= PAGE_READ_EXEC,
diff --git a/mm/mmap.c b/mm/mmap.c
index d0dfc85b209b..04023a464fac 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -47,6 +47,7 @@
 #include <linux/oom.h>
 #include <linux/sched/mm.h>
 #include <linux/ksm.h>
+#include <linux/processor.h>
 
 #include <linux/uaccess.h>
 #include <asm/cacheflush.h>
-- 
2.45.0


