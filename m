Return-Path: <linux-fsdevel+bounces-18614-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F2948BACF7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 15:02:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3BAA1F2145A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 13:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1E01153596;
	Fri,  3 May 2024 13:02:08 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2F0B153595
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 May 2024 13:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714741328; cv=none; b=C1vgfeghudYYDj4rDYcJYH3jVg/BsrJy8MbaYtNBC6aps3EHfMcH+4FCQn2LjC6oB+LlnpqUWrQArc7fHpgifdScZYB5DAgLz03xD10bTXuuu/s0X/4Xeuc7B0ksl+b52Y3TzEJKOQY09lfiTX7dbhGREdcK9aiOPOWGMVSmiEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714741328; c=relaxed/simple;
	bh=Qb1fnku60Ews1vye2+85sEuaJZk7xSrVw9HFVgGz3Uc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kRvwVcqcH5Cgqx8gk0iIdR6Y+pb1Sd84hMW91eSug0ARncjU+7ZxmIhfb7kKRs2OdJsRgEpCcy9Rb7M5aGGgTkuSgQ/O1Q7g/1G0klbZs2LX4mRZZgL4yKKnBswDjPUVdD6sjqDb5wuHb/QCGjt8dMMGdajxDRx67KUfmfNjRpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B60E31477;
	Fri,  3 May 2024 06:02:30 -0700 (PDT)
Received: from e124191.cambridge.arm.com (e124191.cambridge.arm.com [10.1.197.45])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 650863F73F;
	Fri,  3 May 2024 06:02:02 -0700 (PDT)
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
Subject: [PATCH v4 03/29] mm: use ARCH_PKEY_BITS to define VM_PKEY_BITN
Date: Fri,  3 May 2024 14:01:21 +0100
Message-Id: <20240503130147.1154804-4-joey.gouly@arm.com>
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

Use the new CONFIG_ARCH_PKEY_BITS to simplify setting these bits
for different architectures.

Signed-off-by: Joey Gouly <joey.gouly@arm.com>

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-mm@kvack.org
---
 fs/proc/task_mmu.c |  2 ++
 include/linux/mm.h | 16 ++++++++++------
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 23fbab954c20..0d152f460dcc 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -692,7 +692,9 @@ static void show_smap_vma_flags(struct seq_file *m, struct vm_area_struct *vma)
 		[ilog2(VM_PKEY_BIT0)]	= "",
 		[ilog2(VM_PKEY_BIT1)]	= "",
 		[ilog2(VM_PKEY_BIT2)]	= "",
+#if VM_PKEY_BIT3
 		[ilog2(VM_PKEY_BIT3)]	= "",
+#endif
 #if VM_PKEY_BIT4
 		[ilog2(VM_PKEY_BIT4)]	= "",
 #endif
diff --git a/include/linux/mm.h b/include/linux/mm.h
index b6bdaa18b9e9..5605b938acce 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -329,12 +329,16 @@ extern unsigned int kobjsize(const void *objp);
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


