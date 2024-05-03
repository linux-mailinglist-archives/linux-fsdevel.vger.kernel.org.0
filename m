Return-Path: <linux-fsdevel+bounces-18635-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D2AD8BAD0E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 15:04:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59F49284A20
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 13:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 324F0153BEF;
	Fri,  3 May 2024 13:03:17 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FA23153833
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 May 2024 13:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714741396; cv=none; b=ljefAQNhRYmKdiyLjoxXkEHsibT+UBJHa+4gxQHWZi8GAC8qBAkC/w5itR51azgqubgZHBEZz857UOxbP+8iA7c8GaN4EcsXq6ial7H1OQ+eHLlmnnzYzdX1sGcSFy3VrzakSntJ8xlbgE1Zdrc9grKz5YOswzgvO+wXG/ztVGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714741396; c=relaxed/simple;
	bh=CCWxOZyHRp2rGGweEVv/1WzRaNTpiEw9qr8f65Wy/+U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Hmv+6dwIgEp6LZntXaT7L8oX7G7/9rYzM9go0AjlkbxMVR7kVgB1J/ns9op5ZYyI7+RgBhgOTHRWYMCUQOYprGruuSyt+J84e869/5YOVhJE0Vv1FSmoKJrMaXa9QySKTgemQ1FGD7CX1Sqp5GBWKYlgyre2q2+wRQBmUY+ji1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6752F1756;
	Fri,  3 May 2024 06:03:40 -0700 (PDT)
Received: from e124191.cambridge.arm.com (e124191.cambridge.arm.com [10.1.197.45])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0FFD63F73F;
	Fri,  3 May 2024 06:03:11 -0700 (PDT)
From: Joey Gouly <joey.gouly@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: akpm@linux-foundation.org,
	aneesh.kumar@kernel.org,
	aneesh.kumar@linux.ibm.com,
	bp@alien8.de,
	broonie@kernel.org,
	catalin.marinas@arm.com,
	christophe.leroy@csgroup.eu,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	joey.gouly@arm.com,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org,
	maz@kernel.org,
	mingo@redhat.com,
	mpe@ellerman.id.au,
	naveen.n.rao@linux.ibm.com,
	npiggin@gmail.com,
	oliver.upton@linux.dev,
	shuah@kernel.org,
	szabolcs.nagy@arm.com,
	tglx@linutronix.de,
	will@kernel.org,
	x86@kernel.org,
	kvmarm@lists.linux.dev
Subject: [PATCH v4 24/29] selftests: mm: move fpregs printing
Date: Fri,  3 May 2024 14:01:42 +0100
Message-Id: <20240503130147.1154804-25-joey.gouly@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240503130147.1154804-1-joey.gouly@arm.com>
References: <20240503130147.1154804-1-joey.gouly@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

arm64's fpregs are not at a constant offset from sigcontext. Since this is
not an important part of the test, don't print the fpregs pointer on arm64.

Signed-off-by: Joey Gouly <joey.gouly@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
---
 tools/testing/selftests/mm/pkey-powerpc.h    | 1 +
 tools/testing/selftests/mm/pkey-x86.h        | 2 ++
 tools/testing/selftests/mm/protection_keys.c | 6 ++++++
 3 files changed, 9 insertions(+)

diff --git a/tools/testing/selftests/mm/pkey-powerpc.h b/tools/testing/selftests/mm/pkey-powerpc.h
index ae5df26104e5..6275d0f474b3 100644
--- a/tools/testing/selftests/mm/pkey-powerpc.h
+++ b/tools/testing/selftests/mm/pkey-powerpc.h
@@ -9,6 +9,7 @@
 #endif
 #define REG_IP_IDX		PT_NIP
 #define REG_TRAPNO		PT_TRAP
+#define MCONTEXT_FPREGS
 #define gregs			gp_regs
 #define fpregs			fp_regs
 #define si_pkey_offset		0x20
diff --git a/tools/testing/selftests/mm/pkey-x86.h b/tools/testing/selftests/mm/pkey-x86.h
index 814758e109c0..b9170a26bfcb 100644
--- a/tools/testing/selftests/mm/pkey-x86.h
+++ b/tools/testing/selftests/mm/pkey-x86.h
@@ -15,6 +15,8 @@
 
 #endif
 
+#define MCONTEXT_FPREGS
+
 #ifndef PKEY_DISABLE_ACCESS
 # define PKEY_DISABLE_ACCESS	0x1
 #endif
diff --git a/tools/testing/selftests/mm/protection_keys.c b/tools/testing/selftests/mm/protection_keys.c
index 48dc151f8fca..b3dbd76ea27c 100644
--- a/tools/testing/selftests/mm/protection_keys.c
+++ b/tools/testing/selftests/mm/protection_keys.c
@@ -314,7 +314,9 @@ void signal_handler(int signum, siginfo_t *si, void *vucontext)
 	ucontext_t *uctxt = vucontext;
 	int trapno;
 	unsigned long ip;
+#ifdef MCONTEXT_FPREGS
 	char *fpregs;
+#endif
 #if defined(__i386__) || defined(__x86_64__) /* arch */
 	u32 *pkey_reg_ptr;
 	int pkey_reg_offset;
@@ -330,7 +332,9 @@ void signal_handler(int signum, siginfo_t *si, void *vucontext)
 
 	trapno = uctxt->uc_mcontext.gregs[REG_TRAPNO];
 	ip = uctxt->uc_mcontext.gregs[REG_IP_IDX];
+#ifdef MCONTEXT_FPREGS
 	fpregs = (char *) uctxt->uc_mcontext.fpregs;
+#endif
 
 	dprintf2("%s() trapno: %d ip: 0x%016lx info->si_code: %s/%d\n",
 			__func__, trapno, ip, si_code_str(si->si_code),
@@ -359,7 +363,9 @@ void signal_handler(int signum, siginfo_t *si, void *vucontext)
 #endif /* arch */
 
 	dprintf1("siginfo: %p\n", si);
+#ifdef MCONTEXT_FPREGS
 	dprintf1(" fpregs: %p\n", fpregs);
+#endif
 
 	if ((si->si_code == SEGV_MAPERR) ||
 	    (si->si_code == SEGV_ACCERR) ||
-- 
2.25.1


