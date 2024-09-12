Return-Path: <linux-fsdevel+bounces-29239-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00E4A9774FC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 01:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 256061C2420E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 23:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE2001C9865;
	Thu, 12 Sep 2024 23:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="oqQHyCri"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE411C4611
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Sep 2024 23:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726183063; cv=none; b=GDV9HiEoPVOKXWHf+Ka1+D61QyoMa5r/LkccCzx9ydw6cvXgzQJCEp4Hw5cztQJ5W6ZiJav+IgbKIxJER8xJrZ7ZeXIYzN09vccUNVU6XnfERm/bjYovpIrjJzCzuwTw4oLuX0zBv5n+EH+0fPpSQlUuui7TsuRHCb74hIRLFy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726183063; c=relaxed/simple;
	bh=iUNSgGvRIw7EI+iAFOg3HSTtEJXyWqlnUzOX6Qzr+3A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k6Qh0yB9YE6nPh/WN2Yte5LZW+RZQvsSqF/uGpqcp7yudpuhZeWW8ffb2I1ZbkqyaHPiCSODOWOBKHGlqJ0tATkds3P8toiDTVcega/dL/2WM4qB1Tk27dCQU3v7DFdi233LU1pv7q7nNe+i/qxq3D3iTznG9o82vpQj1p/mDow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=oqQHyCri; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-206f9b872b2so16199065ad.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Sep 2024 16:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1726183061; x=1726787861; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TC8HJTmLFTCxnzwVbVDHY5HOw5On7Gme9EHJxcVvh2Y=;
        b=oqQHyCrii57bj2fyOE8Ldui8HtMhpArl+RLmHUCl335uqA4WMJsxiU4L+LE5fkp3LJ
         /k7aluPjIyd62bNev95i+6RQMK63BKnLEUk1pfEf8Q47S1IFRufiJ0Xg3guvZ6OhO8ef
         M9mCYUJEENOfznYqMKazoMGetniy+D8Y9R/xJqW+3OgR0IXVS/nGqqxVPZUo+9kIHgxS
         esHieBO7aJKPTtRkcP/SVmi48blECLLp9HJI05agxu8sAgoKTHU1ysAIclVC7N/mJ51k
         gfiC/coNuZ3g+Aeq2ZO+dQSDZmvaJ4OPDvAKNq5hAwDfOF/7+dEyU1b9TZL07Lc6h/ZN
         57pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726183061; x=1726787861;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TC8HJTmLFTCxnzwVbVDHY5HOw5On7Gme9EHJxcVvh2Y=;
        b=WPay754p4vyNX0NpWd9qj1F/nrZaUj2Hb5ySGn8LNkuTH0wtqB7leiV5xQghTJJfuS
         G11aAvqqOAzP4i+tAuyj4UBOxHssz0CAhcLmSGistyfD/RSAUUyVBQRFHkbe+ImM5QF+
         NSDOskJ5+wDbT9Nj7COyx/teKkp3jOpbINBEKQX4ZPNNj9BHVNFIpJSST81TzTACwlAt
         yPDtWO/e8XSTUHN6QVkrxrUkQQ+FFzFMYSNO782dNxEhviyWbCpE89gxHJIHW+rJqu2V
         Tqvjz4PdXscXNnNpI/OAHwXbJ9jnAu5bzCquwvobeBDBZ75a6fLW6+Zl9W+M+aD2eTSJ
         1pYw==
X-Forwarded-Encrypted: i=1; AJvYcCWDU7G+wsrySOKUG10j2IeDB0flaoGvw33NMZvdeR+iaXQ/4mFnHmZIqUS0fLWE7pDHa419am9Nlg/FfutH@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/VT5WaGKXdlWDxwNuzUdOe27Bga37oXL44K7P0DcCN4l9I3Hc
	xh75YsEqT0UD339vLN8oK12dHZt/+bV7OZ84/U1O1PgI4DyjLfvHvoeKBxaDunmu3BibxNKjQdE
	m
X-Google-Smtp-Source: AGHT+IEpTcNeHZnDkxzsBefZDBG9gwlZQAPff/y8vG/iX+SRyJGFk81Qx5PcE3129Vm1O5X6NKyS+w==
X-Received: by 2002:a17:90b:4c41:b0:2c9:3370:56e3 with SMTP id 98e67ed59e1d1-2dba008304amr4873291a91.34.1726183060973;
        Thu, 12 Sep 2024 16:17:40 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2db6c1ac69asm3157591a91.0.2024.09.12.16.17.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 16:17:40 -0700 (PDT)
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
Subject: [PATCH v4 08/30] riscv: zicfiss / zicfilp enumeration
Date: Thu, 12 Sep 2024 16:16:27 -0700
Message-ID: <20240912231650.3740732-9-debug@rivosinc.com>
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

This patch adds support for detecting zicfiss and zicfilp. zicfiss and
zicfilp stands for unprivleged integer spec extension for shadow stack
and branch tracking on indirect branches, respectively.

This patch looks for zicfiss and zicfilp in device tree and accordinlgy
lights up bit in cpu feature bitmap. Furthermore this patch adds detection
utility functions to return whether shadow stack or landing pads are
supported by cpu.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 arch/riscv/include/asm/cpufeature.h | 13 +++++++++++++
 arch/riscv/include/asm/hwcap.h      |  2 ++
 arch/riscv/include/asm/processor.h  |  1 +
 arch/riscv/kernel/cpufeature.c      |  2 ++
 4 files changed, 18 insertions(+)

diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm/cpufeature.h
index ce9a995730c1..344b8e8cd3e8 100644
--- a/arch/riscv/include/asm/cpufeature.h
+++ b/arch/riscv/include/asm/cpufeature.h
@@ -8,6 +8,7 @@
 
 #include <linux/bitmap.h>
 #include <linux/jump_label.h>
+#include <linux/smp.h>
 #include <asm/hwcap.h>
 #include <asm/alternative-macros.h>
 #include <asm/errno.h>
@@ -180,4 +181,16 @@ static __always_inline bool riscv_cpu_has_extension_unlikely(int cpu, const unsi
 	return __riscv_isa_extension_available(hart_isa[cpu].isa, ext);
 }
 
+static inline bool cpu_supports_shadow_stack(void)
+{
+	return (IS_ENABLED(CONFIG_RISCV_USER_CFI) &&
+		    riscv_cpu_has_extension_unlikely(smp_processor_id(), RISCV_ISA_EXT_ZICFISS));
+}
+
+static inline bool cpu_supports_indirect_br_lp_instr(void)
+{
+	return (IS_ENABLED(CONFIG_RISCV_USER_CFI) &&
+		    riscv_cpu_has_extension_unlikely(smp_processor_id(), RISCV_ISA_EXT_ZICFILP));
+}
+
 #endif
diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
index 5a0bd27fd11a..04425476526a 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -92,6 +92,8 @@
 #define RISCV_ISA_EXT_ZCF		83
 #define RISCV_ISA_EXT_ZCMOP		84
 #define RISCV_ISA_EXT_ZAWRS		85
+#define RISCV_ISA_EXT_ZICFILP		86
+#define RISCV_ISA_EXT_ZICFISS		87
 
 #define RISCV_ISA_EXT_XLINUXENVCFG	127
 
diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
index 8702b8721a27..d61587964bd7 100644
--- a/arch/riscv/include/asm/processor.h
+++ b/arch/riscv/include/asm/processor.h
@@ -13,6 +13,7 @@
 #include <vdso/processor.h>
 
 #include <asm/ptrace.h>
+#include <asm/hwcap.h>
 
 /*
  * addr is a hint to the maximum userspace address that mmap should provide, so
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 41fd0be25bd8..ae6ea2f1d1db 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -317,6 +317,8 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
 					  riscv_ext_zicbom_validate),
 	__RISCV_ISA_EXT_SUPERSET_VALIDATE(zicboz, RISCV_ISA_EXT_ZICBOZ, riscv_xlinuxenvcfg_exts,
 					  riscv_ext_zicboz_validate),
+	__RISCV_ISA_EXT_SUPERSET(zicfilp, RISCV_ISA_EXT_ZICFILP, riscv_xlinuxenvcfg_exts),
+	__RISCV_ISA_EXT_SUPERSET(zicfiss, RISCV_ISA_EXT_ZICFISS, riscv_xlinuxenvcfg_exts),
 	__RISCV_ISA_EXT_DATA(zicntr, RISCV_ISA_EXT_ZICNTR),
 	__RISCV_ISA_EXT_DATA(zicond, RISCV_ISA_EXT_ZICOND),
 	__RISCV_ISA_EXT_DATA(zicsr, RISCV_ISA_EXT_ZICSR),
-- 
2.45.0


