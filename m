Return-Path: <linux-fsdevel+bounces-44977-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83C83A6FD05
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 13:40:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DE943BE0AA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 12:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DDF7269B0C;
	Tue, 25 Mar 2025 12:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CASldfZK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62432586C5;
	Tue, 25 Mar 2025 12:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742905278; cv=none; b=mEr8USxEYxOrCxyaPiza+sxjz3fT4aQEw5VekROrjf+YJF1RPSLmuKR+OH4/mBshZVnd7kJhRZklrPn+Sy0eDVPvKXI4iExQiyU8qd3xaVo9XKDxOtsosyIAMHjtcnX9x7XK8qKbGC92LrwDD+HL/Zn+9QV8vbpjR1B59V+iqcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742905278; c=relaxed/simple;
	bh=2UWsq5ym5VI7/vPr12wsi4xJfQOhojxJV/AkLgh/hzg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fhizAkYnN+iL3ekWGxKB8XbM0ZhdzYRkD34vg280Q/B1zQL6q4jnPX77CzziIE++LVW0cd5tw+1zlJqmXE/r6+D6qDoew730caks0FoJ/GHWW++A5cXVkdA3Tv6fkMZMum8rMnJHa/loZ+h8Et8S+q3662V2a7VlfyZdk1f+wAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CASldfZK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE0C8C4CEED;
	Tue, 25 Mar 2025 12:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742905277;
	bh=2UWsq5ym5VI7/vPr12wsi4xJfQOhojxJV/AkLgh/hzg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CASldfZKFy6JxMfog2czdRUW400bjKu3qkIqf2g0bO4mAfdCAZJOHjQKj39cz8aqg
	 XG1civv4o3gD3MK48Yhqik6WW027RRpl8DQvIB9Yob7C9kX6E9qV9uYudT8hhev5cL
	 QTVrUoI6O6nkCMoTVAOPFZqdY9GzjntjKQO6ayze5oXkt5L0UWJbyNb4+aKdlWWzz3
	 3BCk6+WJF49ZitzC7I5AW48N1eiiEebNx/f6MnTwAH2grSuKMLPrEypZXRY8Sm16qK
	 mLSvyciL4KYAbVkJERD8dZPZNRmSFb8RH3/1NqleyW9uvgrIwTuaYlC1t3hgHEcd/Z
	 SqwIoUbHe8uUw==
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
Subject: [RFC PATCH V3 19/43] rv64ilp32_abi: irqchip: irq-riscv-intc: Use xlen_t instead of ulong
Date: Tue, 25 Mar 2025 08:16:00 -0400
Message-Id: <20250325121624.523258-20-guoren@kernel.org>
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

The RV64ILP32 ABI is based on CONFIG_64BIT, so use xlen/xlen_t
instead of BITS_PER_LONG/ulong.

Signed-off-by: Guo Ren (Alibaba DAMO Academy) <guoren@kernel.org>
---
 drivers/irqchip/irq-riscv-intc.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-riscv-intc.c b/drivers/irqchip/irq-riscv-intc.c
index f653c13de62b..4fc7d5704acf 100644
--- a/drivers/irqchip/irq-riscv-intc.c
+++ b/drivers/irqchip/irq-riscv-intc.c
@@ -20,18 +20,19 @@
 #include <linux/soc/andes/irq.h>
 
 #include <asm/hwcap.h>
+#include <asm/ptrace.h>
 
 static struct irq_domain *intc_domain;
-static unsigned int riscv_intc_nr_irqs __ro_after_init = BITS_PER_LONG;
-static unsigned int riscv_intc_custom_base __ro_after_init = BITS_PER_LONG;
+static unsigned int riscv_intc_nr_irqs __ro_after_init = __riscv_xlen;
+static unsigned int riscv_intc_custom_base __ro_after_init = __riscv_xlen;
 static unsigned int riscv_intc_custom_nr_irqs __ro_after_init;
 
 static void riscv_intc_irq(struct pt_regs *regs)
 {
-	unsigned long cause = regs->cause & ~CAUSE_IRQ_FLAG;
+	xlen_t cause = regs->cause & ~CAUSE_IRQ_FLAG;
 
 	if (generic_handle_domain_irq(intc_domain, cause))
-		pr_warn_ratelimited("Failed to handle interrupt (cause: %ld)\n", cause);
+		pr_warn_ratelimited("Failed to handle interrupt (cause: " REG_FMT ")\n", cause);
 }
 
 static void riscv_intc_aia_irq(struct pt_regs *regs)
-- 
2.40.1


