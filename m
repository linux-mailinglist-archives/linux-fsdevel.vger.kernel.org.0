Return-Path: <linux-fsdevel+bounces-26753-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD18D95B9A7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 17:13:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0DC2B2A95A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 15:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCF811CC880;
	Thu, 22 Aug 2024 15:11:39 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00E141C9EBB;
	Thu, 22 Aug 2024 15:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724339499; cv=none; b=Zk5aNarPCBZN+iJ/vz9eganFf3Wymwu/g67Tzv4qoImKgeYOcurKP60nqqYOEP1354SaDWjjhDv2KRnnGOQedHmExY2ytu2Qr5pSaKNH5uBGrUeO7B/Xp4JLxuiqsWx8xlm+O9wdGTuf3y+zor2fpfTqhUUIgqxFtRrIo/4OQfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724339499; c=relaxed/simple;
	bh=SYHG7e/ZfuUynIiAIglAqcGkd6gqqF4ktuzCFhTOZ5o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=M381UYMgkc5SrvI+YSM56ymbjnxEY/e1DopPMlOkgAs9xT/AgvFiCX/NSk5+rUS+Js0xe+6QRcU9pOJEt89N6qBz4+vps0JpBwVlTLsTwHfq3aqYNelNjX6EDiTTwjXy8YMgd2DEAb5L2gKSJFDRHITSQ9Zpwtb+CMmm5GZarnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6108A1595;
	Thu, 22 Aug 2024 08:12:03 -0700 (PDT)
Received: from e124191.cambridge.arm.com (e124191.cambridge.arm.com [10.1.197.45])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 336263F58B;
	Thu, 22 Aug 2024 08:11:33 -0700 (PDT)
From: Joey Gouly <joey.gouly@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: nd@arm.com,
	akpm@linux-foundation.org,
	aneesh.kumar@kernel.org,
	aneesh.kumar@linux.ibm.com,
	anshuman.khandual@arm.com,
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
	skhan@linuxfoundation.org,
	szabolcs.nagy@arm.com,
	tglx@linutronix.de,
	will@kernel.org,
	x86@kernel.org,
	kvmarm@lists.linux.dev,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v5 03/30] mm: use ARCH_PKEY_BITS to define VM_PKEY_BITN
Date: Thu, 22 Aug 2024 16:10:46 +0100
Message-Id: <20240822151113.1479789-4-joey.gouly@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240822151113.1479789-1-joey.gouly@arm.com>
References: <20240822151113.1479789-1-joey.gouly@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the new CONFIG_ARCH_PKEY_BITS to simplify setting these bits
for different architectures.

Signed-off-by: Joey Gouly <joey.gouly@arm.com>

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-mm@kvack.org
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 fs/proc/task_mmu.c |  2 ++
 include/linux/mm.h | 16 ++++++++++------
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git fs/proc/task_mmu.c fs/proc/task_mmu.c
index 5f171ad7b436..2c5f4814aef9 100644
--- fs/proc/task_mmu.c
+++ fs/proc/task_mmu.c
@@ -976,7 +976,9 @@ static void show_smap_vma_flags(struct seq_file *m, struct vm_area_struct *vma)
 		[ilog2(VM_PKEY_BIT0)]	= "",
 		[ilog2(VM_PKEY_BIT1)]	= "",
 		[ilog2(VM_PKEY_BIT2)]	= "",
+#if VM_PKEY_BIT3
 		[ilog2(VM_PKEY_BIT3)]	= "",
+#endif
 #if VM_PKEY_BIT4
 		[ilog2(VM_PKEY_BIT4)]	= "",
 #endif
diff --git include/linux/mm.h include/linux/mm.h
index 6549d0979b28..56dc2481cc0f 100644
--- include/linux/mm.h
+++ include/linux/mm.h
@@ -330,12 +330,16 @@ extern unsigned int kobjsize(const void *objp);
 #endif /* CONFIG_ARCH_USES_HIGH_VMA_FLAGS */
 
 #ifdef CONFIG_ARCH_HAS_PKEYS
-# define VM_PKEY_SHIFT	VM_HIGH_ARCH_BIT_0
-# define VM_PKEY_BIT0	VM_HIGH_ARCH_0	/* A protection key is a 4-bit value */
-# define VM_PKEY_BIT1	VM_HIGH_ARCH_1	/* on x86 and 5-bit value on ppc64   */
-# define VM_PKEY_BIT2	VM_HIGH_ARCH_2
-# define VM_PKEY_BIT3	VM_HIGH_ARCH_3
-#ifdef CONFIG_PPC
+# define VM_PKEY_SHIFT VM_HIGH_ARCH_BIT_0
+# define VM_PKEY_BIT0  VM_HIGH_ARCH_0
+# define VM_PKEY_BIT1  VM_HIGH_ARCH_1
+# define VM_PKEY_BIT2  VM_HIGH_ARCH_2
+#if CONFIG_ARCH_PKEY_BITS > 3
+# define VM_PKEY_BIT3  VM_HIGH_ARCH_3
+#else
+# define VM_PKEY_BIT3  0
+#endif
+#if CONFIG_ARCH_PKEY_BITS > 4
 # define VM_PKEY_BIT4  VM_HIGH_ARCH_4
 #else
 # define VM_PKEY_BIT4  0
-- 
2.25.1


