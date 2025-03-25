Return-Path: <linux-fsdevel+bounces-44988-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56BAAA6FE24
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 13:51:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99FB83BCAA8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 12:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D7A427C154;
	Tue, 25 Mar 2025 12:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L4cw2mln"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43AEB258CE2;
	Tue, 25 Mar 2025 12:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742905436; cv=none; b=J9GFi4k5a/Uw9H7KbtURpPN1G52XnbA60hFJI8t+wvhlaos6pzOuEJeqXC7tiPI5o65Yr1xFSSYprNC8wO4I8JywwGjpdEucfIYkZG6KpleCU3drqX0kiQ1+MCp37UccPgAeqabjQsL5O8Vk7+z8jDyzOvzwpgfJ3CHDMRnelOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742905436; c=relaxed/simple;
	bh=1gg5o3afeYXr2oDy1XVLnTyki+lz38CMW137QmWraJ4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t8RfNzrciYnWgQcc7xnNq4Am+KUv5uru5OWqAfXj6XsxFKJnfCMQOzPjnQ+NcUsVlVJvBbgx9r7hU7jThFVX3tvzTxiinObHLLA99BxZ60neEHzslFCfbRw3+Wcsi6C68lbbBCznvjRbcBZlaVbyY42waVCGwyZ3iTjfSPU8JxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L4cw2mln; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF58FC4CEE4;
	Tue, 25 Mar 2025 12:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742905435;
	bh=1gg5o3afeYXr2oDy1XVLnTyki+lz38CMW137QmWraJ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L4cw2mlnpKO9zzlBV0K7R2SnFVRKniFFdGTiR1XJiWloP049xrRfsGdsekAZNO6iT
	 0IyPu7HYxWtcNr/GVwIsyoiG0WQGDVHF9znzdKgcSLP4/Mx+qe6abUvE609AinUueV
	 0KJNmISd/m0sVDU0CIIc8bPKS7tsLxYBWl6C9Q4zukQ4gJ5jyGZZAxFc2SGU/Bu4a5
	 45akXD+WZ2MUCfkqONcTDqGPuoH+ifGT/z4RaEjXSFoHsvMQYWwCSPkJnIvizKw1Rw
	 hDbQZdSoaf8SOQJv2hZJOxEN9nVfFJY2tF55Gmc3rr6AyEV5ls4O48mzUFO7UNigWe
	 wLQU7WgDVZaDw==
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
Subject: [RFC PATCH V3 30/43] rv64ilp32_abi: kernel/smp: Disable CSD_LOCK_WAIT_DEBUG
Date: Tue, 25 Mar 2025 08:16:11 -0400
Message-Id: <20250325121624.523258-31-guoren@kernel.org>
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

The rv64ilp32 abi is based on CONFIG_64BIT, but uses ILP32 for a
smaller cache & memory footprint. So, disable CSD_LOCK_WAIT_DEBUG
to get smaller csd struct.

Signed-off-by: Guo Ren (Alibaba DAMO Academy) <guoren@kernel.org>
---
 include/linux/smp_types.h | 2 +-
 lib/Kconfig.debug         | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/smp_types.h b/include/linux/smp_types.h
index 2e8461af8df6..5912b694059f 100644
--- a/include/linux/smp_types.h
+++ b/include/linux/smp_types.h
@@ -61,7 +61,7 @@ struct __call_single_node {
 		unsigned int	u_flags;
 		atomic_t	a_flags;
 	};
-#ifdef CONFIG_64BIT
+#if BITS_PER_LONG == 64
 	u16 src, dst;
 #endif
 };
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 1af972a92d06..f55f0ded826c 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1613,6 +1613,7 @@ config CSD_LOCK_WAIT_DEBUG
 	depends on DEBUG_KERNEL
 	depends on SMP
 	depends on 64BIT
+	depends on !ABI_RV64ILP32
 	default n
 	help
 	  This option enables debug prints when CPUs are slow to respond
-- 
2.40.1


