Return-Path: <linux-fsdevel+bounces-29259-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53814977571
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 01:27:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FB3F280E91
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 23:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D273D1D47DC;
	Thu, 12 Sep 2024 23:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="XU9+kRuy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3541D4168
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Sep 2024 23:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726183146; cv=none; b=J9JJvKzAqwzRSOJG4KdK2suognmGps3B159sQM12x44x74i7Nw5Xz7UlfT/rTLgzpSxIOGbDtflp2XLISxjtopm71gmLhVjByPr1ktSFMbEOjPpQ1iecUE3Jckl+4cWMgORKqq4TIm44uZOBUz6cXn+BXLBRSlqhahC6A/0rq1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726183146; c=relaxed/simple;
	bh=pQ36bqJQc3crTMuG6nwBSgk8a0zlUdw1gw6SE4Q4lIU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hhrmtfj3pkI3JVJfGEdisJuxb6bmmMKQDvJWYcnbqEaGF95drbzJu3ntmnPxFSsQxeUrAdHKi6odTnP1sT/oACyIb3IWBq1Kz0VhHdEEtbOftJNg/1qV68x5aij38Jq+iit3+pZCbSHthREsXeyIWIy+RYiA9wuoz6QmBHke5eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=XU9+kRuy; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7d50532d335so813885a12.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Sep 2024 16:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1726183144; x=1726787944; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CbpKVNKRMfAtkqYXzA8w+8eVro8K48y9vmHyffj7Qao=;
        b=XU9+kRuy2rqqni/gJQi22KGOBl9Hg5D0UefCSy20BfL49aTLTqse19LUDg4KPFreKa
         2SNm1ZTnlDSOjjByklMxOUarGs+9r5fk/ebApVGuGDObxkW2h/IHcV1Xud6JF2yFrPnc
         7mufPWpztwNnBpoytc/hXBEj7hVLkDLMerTdSt1x57UweRzThrIxpK1o3ixUojx4dzEA
         fZYxhG1laVNPwodBc2mLyDAcEtvu0HQM+j0/6Jh1c3hEISEwdWFdKJPxVoCCBEsfvdFt
         KaombzvOd4w66392mS4XXATMJdDDqMvM/96XpuEKEDUZpg+/KlU5tt70k6lovuVMpP5y
         +/YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726183144; x=1726787944;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CbpKVNKRMfAtkqYXzA8w+8eVro8K48y9vmHyffj7Qao=;
        b=ZOx9AZxp6NbKyZezDCT7kHIlc0fjpoPX3XS7Fp8L3td3/0Xlng019CLYylDA/eTYmF
         pXwXmho1uuDv/je3xnST0PJDkdczMrQaJ0cMtXNJ4d+qGGVw5qAqUvKkZaQPLTci5v0h
         xrF89SiISEkOu1+dVkalZjrlt/tNTUcePF6rwzeJsqq+mgYm7VsIgqaUjTsUgWD8doKq
         bx4aucBzBD1NGQyI0HaV4O4z3rEJv0Ob1Itu2OMIWlX+aBgv6ZT3mB1eJ47FtDUbj9rU
         1uZ62y2z08fJNJPH1zfI3pzdvrcWSvvYRcYn3eDPyAd/8WCtcnFQM6gpFSzlWOW2obqb
         BRbA==
X-Forwarded-Encrypted: i=1; AJvYcCUw4gYsuE4Zytrgz+GlKqA9Fw6yqHj4YKOFtFWIP4+hnTFc/iGnP2iHx2v6GTJNcHHLslON9VX6NT+mLAA/@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3+kRXGZbB8fQwc5TXOy163E8uas0UE6UtVZ46DOQYTg7LbJHu
	JhY26MMw8Sojyuxhq4TPAzuF/pMsTUAzQVtlEDaYT4Sk0uRbWHTMc4VI6VbaMfg=
X-Google-Smtp-Source: AGHT+IERJQSRxOQYUrcoeWqKKFDuWvirFZC93eScxDPtDLfWGyU08Qp8o+SGLVlkTYVlfOG74jZpnw==
X-Received: by 2002:a17:90b:1043:b0:2d3:da6d:8330 with SMTP id 98e67ed59e1d1-2db9ff79ba2mr4907026a91.4.1726183144244;
        Thu, 12 Sep 2024 16:19:04 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2db6c1ac69asm3157591a91.0.2024.09.12.16.19.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 16:19:03 -0700 (PDT)
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
Subject: [PATCH v4 27/30] riscv: create a config for shadow stack and landing pad instr support
Date: Thu, 12 Sep 2024 16:16:46 -0700
Message-ID: <20240912231650.3740732-28-debug@rivosinc.com>
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

This patch creates a config for shadow stack support and landing pad instr
support. Shadow stack support and landing instr support can be enabled by
selecting `CONFIG_RISCV_USER_CFI`. Selecting `CONFIG_RISCV_USER_CFI` wires
up path to enumerate CPU support and if cpu support exists, kernel will
support cpu assisted user mode cfi.

If CONFIG_RISCV_USER_CFI is selected, select `ARCH_USES_HIGH_VMA_FLAGS`
and `ARCH_HAS_USER_SHADOW_STACK` for riscv.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 arch/riscv/Kconfig | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index d1d629a3eb91..24bf08c905d2 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -231,6 +231,25 @@ config ARCH_HAS_BROKEN_DWARF5
 	# https://github.com/llvm/llvm-project/commit/7ffabb61a5569444b5ac9322e22e5471cc5e4a77
 	depends on LD_IS_LLD && LLD_VERSION < 180000
 
+config RISCV_USER_CFI
+	def_bool y
+	bool "riscv userspace control flow integrity"
+	depends on 64BIT && $(cc-option,-mabi=lp64 -march=rv64ima_zicfiss)
+	depends on RISCV_ALTERNATIVE
+	select ARCH_HAS_USER_SHADOW_STACK
+	select ARCH_USES_HIGH_VMA_FLAGS
+	help
+	  Provides CPU assisted control flow integrity to userspace tasks.
+	  Control flow integrity is provided by implementing shadow stack for
+	  backward edge and indirect branch tracking for forward edge in program.
+	  Shadow stack protection is a hardware feature that detects function
+	  return address corruption. This helps mitigate ROP attacks.
+	  Indirect branch tracking enforces that all indirect branches must land
+	  on a landing pad instruction else CPU will fault. This mitigates against
+	  JOP / COP attacks. Applications must be enabled to use it, and old user-
+	  space does not get protection "for free".
+	  default y
+
 config ARCH_MMAP_RND_BITS_MIN
 	default 18 if 64BIT
 	default 8
-- 
2.45.0


