Return-Path: <linux-fsdevel+bounces-44975-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 054D4A6FCE2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 13:39:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F35B83B4299
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 12:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B65C325B670;
	Tue, 25 Mar 2025 12:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oz8iARGb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99A525A654;
	Tue, 25 Mar 2025 12:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742905249; cv=none; b=PXA5/9Qb0S+RV8JZtCUOA/lBhL14/s2dk44d2hCQerhzIw5o/KQjCgVPjBaqvwa1/CSMRnHG3o6fy7wfjsR8YEoJZQS5k1UGO+YPhOFoyjbPzzqkGszC2Bi7TBfL1ugeq4jSg5auQvPPD4LMXUzicrv8PwSmdPT0jq/ckFsrf1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742905249; c=relaxed/simple;
	bh=j18oLXPHFjnaGmgCwscTDaPTneiSyVqaoCKba61TqXg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ksvMfmY3i/W6NiLN+klluOkriT32EGq0noZ3BusNVu2GF1AiyMz1e9hsraXsCjKqLoktGK0HuqvGxV7Chie2WyAg0trLkEr7HRdWJXG0YdGkmxxNSw4WqETQnjLPn6jZ97gwQJPhPeJNGOogJavJ9OO67radIxFoZ1IA8nnwXfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oz8iARGb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 213B1C4CEE4;
	Tue, 25 Mar 2025 12:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742905248;
	bh=j18oLXPHFjnaGmgCwscTDaPTneiSyVqaoCKba61TqXg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Oz8iARGb8tr7htUnaAeUCJ6IYWmPD2sUy6Fahrj1eenZT1kKMM+eFWJiKMQdGqcqw
	 rqWz1qpr3jo3lVxFFYwrBasJ+tHw3PWT4Rv+apRvPWQa/i4K/2vaflC0hzKnPuX+P4
	 8bTM1EjGGpOTuQHdC8TBFwQkrFBcJI49u7thNpghWlOyMzJ3hMkq6mroidX2glUScJ
	 uyG/XkFYIxn9NAsEUQSTt4TYvFJgoGc/h+TFjpPprvl74n7fsNLu4FNEPQT7I99tBn
	 keJQj/Yhn5p3/N2C2J6YITPpmyRqNzvFWJV+jSwmuHsx+jq6dfD8Ek+CQ8ONbZxS8/
	 mQmFdBGqaAdYQ==
From: guoren@kernel.org
To: arnd@arndb.de,
	gregkh@linuxfoundation.org,
	torvalds@linux-foundation.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	anup@brainfault.org,
	atishp@atishpatra.org,
	oleg@redhat.com,
	kees@kernel.org,
	tglx@linutronix.de,
	will@kernel.org,
	mark.rutland@arm.com,
	brauner@kernel.org,
	akpm@linux-foundation.org,
	rostedt@goodmis.org,
	edumazet@google.com,
	unicorn_wang@outlook.com,
	inochiama@outlook.com,
	gaohan@iscas.ac.cn,
	shihua@iscas.ac.cn,
	jiawei@iscas.ac.cn,
	wuwei2016@iscas.ac.cn,
	drew@pdp7.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	ctsai390@andestech.com,
	wefu@redhat.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	josef@toxicpanda.com,
	dsterba@suse.com,
	mingo@redhat.com,
	peterz@infradead.org,
	boqun.feng@gmail.com,
	guoren@kernel.org,
	xiao.w.wang@intel.com,
	qingfang.deng@siflower.com.cn,
	leobras@redhat.com,
	jszhang@kernel.org,
	conor.dooley@microchip.com,
	samuel.holland@sifive.com,
	yongxuan.wang@sifive.com,
	luxu.kernel@bytedance.com,
	david@redhat.com,
	ruanjinjie@huawei.com,
	cuiyunhui@bytedance.com,
	wangkefeng.wang@huawei.com,
	qiaozhe@iscas.ac.cn
Cc: ardb@kernel.org,
	ast@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-mm@kvack.org,
	linux-crypto@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	maple-tree@lists.infradead.org,
	linux-trace-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-atm-general@lists.sourceforge.net,
	linux-btrfs@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	linux-nfs@vger.kernel.org,
	linux-sctp@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-media@vger.kernel.org
Subject: [RFC PATCH V3 17/43] rv64ilp32_abi: riscv: Adapt kasan memory layout
Date: Tue, 25 Mar 2025 08:15:58 -0400
Message-Id: <20250325121624.523258-18-guoren@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20250325121624.523258-1-guoren@kernel.org>
References: <20250325121624.523258-1-guoren@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Guo Ren (Alibaba DAMO Academy)" <guoren@kernel.org>

For generic KASAN, the size of each memory granule is 8, which
needs 1/8 address space. The kernel space is 2GiB in rv64ilp32,
so we need 256MiB range (0x80000000 ~ 0x90000000), and the offset
is 0x7000000 for the whole 4GiB address space.

 Virtual kernel memory layout:
       fixmap : 0x90a00000 - 0x90ffffff   (6144 kB)
       pci io : 0x91000000 - 0x91ffffff   (  16 MB)
      vmemmap : 0x92000000 - 0x93ffffff   (  32 MB)
      vmalloc : 0x94000000 - 0xb3ffffff   ( 512 MB)
      modules : 0xb4000000 - 0xb7ffffff   (  64 MB)
       lowmem : 0xc0000000 - 0xc7ffffff   ( 128 MB)
        kasan : 0x80000000 - 0x8fffffff   ( 256 MB) <=
       kernel : 0xb8000000 - 0xbfffffff   ( 128 MB)

Signed-off-by: Guo Ren (Alibaba DAMO Academy) <guoren@kernel.org>
---
 arch/riscv/include/asm/kasan.h | 6 +++++-
 arch/riscv/mm/kasan_init.c     | 2 +-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/include/asm/kasan.h b/arch/riscv/include/asm/kasan.h
index e6a0071bdb56..dd3a211bc5d0 100644
--- a/arch/riscv/include/asm/kasan.h
+++ b/arch/riscv/include/asm/kasan.h
@@ -21,7 +21,7 @@
  * [KASAN_SHADOW_OFFSET, KASAN_SHADOW_END) cover all 64-bits of virtual
  * addresses. So KASAN_SHADOW_OFFSET should satisfy the following equation:
  *      KASAN_SHADOW_OFFSET = KASAN_SHADOW_END -
- *                              (1ULL << (64 - KASAN_SHADOW_SCALE_SHIFT))
+ *                              (1ULL << (BITS_PER_LONG - KASAN_SHADOW_SCALE_SHIFT))
  */
 #define KASAN_SHADOW_SCALE_SHIFT	3
 
@@ -31,7 +31,11 @@
  * aligned on PGDIR_SIZE, so force its alignment to ease its population.
  */
 #define KASAN_SHADOW_START	((KASAN_SHADOW_END - KASAN_SHADOW_SIZE) & PGDIR_MASK)
+#if defined(CONFIG_64BIT) && (BITS_PER_LONG == 32)
+#define KASAN_SHADOW_END	0x90000000UL
+#else
 #define KASAN_SHADOW_END	MODULES_LOWEST_VADDR
+#endif
 
 #ifdef CONFIG_KASAN
 #define KASAN_SHADOW_OFFSET	_AC(CONFIG_KASAN_SHADOW_OFFSET, UL)
diff --git a/arch/riscv/mm/kasan_init.c b/arch/riscv/mm/kasan_init.c
index 41c635d6aca4..1e864598779a 100644
--- a/arch/riscv/mm/kasan_init.c
+++ b/arch/riscv/mm/kasan_init.c
@@ -324,7 +324,7 @@ asmlinkage void __init kasan_early_init(void)
 	uintptr_t i;
 
 	BUILD_BUG_ON(KASAN_SHADOW_OFFSET !=
-		KASAN_SHADOW_END - (1UL << (64 - KASAN_SHADOW_SCALE_SHIFT)));
+		KASAN_SHADOW_END - (1UL << (BITS_PER_LONG - KASAN_SHADOW_SCALE_SHIFT)));
 
 	for (i = 0; i < PTRS_PER_PTE; ++i)
 		set_pte(kasan_early_shadow_pte + i,
-- 
2.40.1


