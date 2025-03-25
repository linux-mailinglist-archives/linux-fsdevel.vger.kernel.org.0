Return-Path: <linux-fsdevel+bounces-44979-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84573A6FD15
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 13:41:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 597F21887C7D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 12:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35FF026AABF;
	Tue, 25 Mar 2025 12:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yclr6uQ+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C0625C6EA;
	Tue, 25 Mar 2025 12:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742905307; cv=none; b=MABosUlkCPqRlUQsblXKz01FcQNIQG69EdgsnthhJudVm7SYLHnzwjYQovKuoe1j2WcMCZDJP0/BZhYsO+27E8zLB6u8IruBiZpGn5hxMmy3rcdS7yYz5ivwQuwX4BtzLW3xC7x9VXsCxZCPJ/B9qDehioJRISHODH22gAVvoa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742905307; c=relaxed/simple;
	bh=CZdS/GvkA90YU/kEAB36wBveXCqjeNawAvE607HO4+w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=scYlMC+YY0HEBJMCbFygnmXvnD1YYhxzoyYz0ZLifnqfq0PPA0JxyLfp7kTrCSA0d3gfwQfJrSrq70Sq9NQIZtWSiazi2CB1Xv/YajWf5zkaAoQwD296iCPJ+lzhHK9ypE4xjEJZqYT7EOO/woj7F/8UJr1D8SMN7qqDgvu9z74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yclr6uQ+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBB6BC4CEEE;
	Tue, 25 Mar 2025 12:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742905306;
	bh=CZdS/GvkA90YU/kEAB36wBveXCqjeNawAvE607HO4+w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Yclr6uQ+H+fwk4FeZuO/o1L+d44Ijt8+G1fy933XmRQHqYsRSsd0sTScvUWf8jhFn
	 posU+nxR0I0CJubB8JpreHpWy/aH5nvKFU2hJMpWF6yA979un6JU7n1rYErPHMB+OE
	 1HtLAfDLBJWL5lUcfbf0A+xaNH26BIwc5uqCly6rbYZnlIoX+horQoW9v4j5Sryd9B
	 XXw3PX/jNNQJEowJrGs9ycLTX55S8tjuI6nqYWKt5HT846Iutyoxz4uQ/nads2ZfRN
	 d2AZWWzbzkjb2I7at8nkI5Hq2azsuTC7jh77lOOfoH2dxmDMXNH64ns6YpTd/KRsOD
	 WXp0YdnLwIufw==
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
Subject: [RFC PATCH V3 21/43] rv64ilp32_abi: asm-generic: Add custom BITS_PER_LONG definition
Date: Tue, 25 Mar 2025 08:16:02 -0400
Message-Id: <20250325121624.523258-22-guoren@kernel.org>
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

The RV64ILP32 ABI linux kernel is based on CONFIG_64BIT, but
BITS_PER_LONG is 32. So, give a custom architectural definition
of BITS_PER_LONG to match the correct macro definition.

Signed-off-by: Guo Ren (Alibaba DAMO Academy) <guoren@kernel.org>
---
 arch/riscv/include/uapi/asm/bitsperlong.h | 6 ++++++
 include/asm-generic/bitsperlong.h         | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/arch/riscv/include/uapi/asm/bitsperlong.h b/arch/riscv/include/uapi/asm/bitsperlong.h
index 7d0b32e3b701..fec2ad91597c 100644
--- a/arch/riscv/include/uapi/asm/bitsperlong.h
+++ b/arch/riscv/include/uapi/asm/bitsperlong.h
@@ -9,6 +9,12 @@
 
 #define __BITS_PER_LONG (__SIZEOF_POINTER__ * 8)
 
+#if __BITS_PER_LONG == 64
+#define BITS_PER_LONG 64
+#else
+#define BITS_PER_LONG 32
+#endif
+
 #include <asm-generic/bitsperlong.h>
 
 #endif /* _UAPI_ASM_RISCV_BITSPERLONG_H */
diff --git a/include/asm-generic/bitsperlong.h b/include/asm-generic/bitsperlong.h
index 1023e2a4bd37..7ccbb7ce6610 100644
--- a/include/asm-generic/bitsperlong.h
+++ b/include/asm-generic/bitsperlong.h
@@ -6,7 +6,9 @@
 
 
 #ifdef CONFIG_64BIT
+#ifndef BITS_PER_LONG
 #define BITS_PER_LONG 64
+#endif
 #else
 #define BITS_PER_LONG 32
 #endif /* CONFIG_64BIT */
-- 
2.40.1


