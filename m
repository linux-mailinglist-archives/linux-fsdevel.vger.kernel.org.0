Return-Path: <linux-fsdevel+bounces-44966-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7902FA6FB5C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 13:25:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8246A7A1CE4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 12:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76C3C2627E3;
	Tue, 25 Mar 2025 12:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lucl4scH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A7D1531C5;
	Tue, 25 Mar 2025 12:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742905123; cv=none; b=KFaCZjXEfLRbq9Ba56FDJipm1n+VG/dmWTc9LIHcQlJlG4st9kxyaXMU8GrJiFySYQGgSb4kybH+spCMKDKD4Z5OvRRb0mXPosVfNePKCmTvY2T6/1hEtu1v0QglzDuNU4CoTcTOWpZ5Od/rCaF6ozYaCsqcuWtCMrlbYvuIP8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742905123; c=relaxed/simple;
	bh=IoEFeh+m75KDxz7bIm+5+JPKqFD60PyKrITdPvnkO1Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=awooEMC4V9YZTwcaVbas+w/ybRvdxEvo2K32qBX44L2Nl70IeYKqJrk7x5o5ooaNVwXTePl7PEKixFzr5+iOARLn33cgVbE78TP+nepMqEeEHZLtD2QBjXqtnOtwwUZPSpaKXjsIbYhgItbGIhkDshg6pQZUi0VyJigfTo4bgaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lucl4scH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2D25C4CEED;
	Tue, 25 Mar 2025 12:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742905123;
	bh=IoEFeh+m75KDxz7bIm+5+JPKqFD60PyKrITdPvnkO1Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lucl4scHiNV8o0GAc3IKkqwvULaoWzPmEp5Cf3HWn54r4yb4FO0Wcun579c2vfuZz
	 J8cjJa3GTTzkMWx5VdBC4BoSRe3Rj4eXqqI4hKBSbaoTMZ+l2q1jnuJGFbX5wp6j2P
	 m4aeZBNLUPltdt6Ih13MGR6Div/iKVhSIZIxo4dWkQp8ORKrVGeC8JOoffP8TQadpr
	 bZFHGx2/54BhY+aa5gsFpFKEFifG6AH1a8qy5WxVap/Iz20XwOxa0fOKpKS0lOBu99
	 ve/Glkh5gV2+3Jeg8PA+Vog5uAShqNQ+riLO4RMDzBggckY3glJExTgraHapieY6+k
	 4nOhr50cYNVQA==
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
Subject: [RFC PATCH V3 08/43] rv64ilp32_abi: riscv: bitops: Adapt ctzw & clzw of zbb extension
Date: Tue, 25 Mar 2025 08:15:49 -0400
Message-Id: <20250325121624.523258-9-guoren@kernel.org>
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

The RV64ILP32 ABI is based on 64-bit ISA, but BITS_PER_LONG is 32.
Use ctzw and clzw for int and long types instead of ctz and clz.

Signed-off-by: Guo Ren (Alibaba DAMO Academy) <guoren@kernel.org>
---
 arch/riscv/include/asm/bitops.h | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/include/asm/bitops.h b/arch/riscv/include/asm/bitops.h
index c6bd3d8354a9..d041b9e3ba84 100644
--- a/arch/riscv/include/asm/bitops.h
+++ b/arch/riscv/include/asm/bitops.h
@@ -35,14 +35,27 @@
 #include <asm/alternative-macros.h>
 #include <asm/hwcap.h>
 
-#if (BITS_PER_LONG == 64)
+#if (__riscv_xlen == 64)
 #define CTZW	"ctzw "
 #define CLZW	"clzw "
+
+#if (BITS_PER_LONG == 64)
+#define CTZ	"ctz "
+#define CLZ	"clz "
 #elif (BITS_PER_LONG == 32)
+#define CTZ	"ctzw "
+#define CLZ	"clzw "
+#else
+#error "Unexpected BITS_PER_LONG"
+#endif
+
+#elif (__riscv_xlen == 32)
 #define CTZW	"ctz "
 #define CLZW	"clz "
+#define CTZ	"ctz "
+#define CLZ	"clz "
 #else
-#error "Unexpected BITS_PER_LONG"
+#error "Unexpected __riscv_xlen"
 #endif
 
 static __always_inline unsigned long variable__ffs(unsigned long word)
@@ -53,7 +66,7 @@ static __always_inline unsigned long variable__ffs(unsigned long word)
 
 	asm volatile (".option push\n"
 		      ".option arch,+zbb\n"
-		      "ctz %0, %1\n"
+		      CTZ "%0, %1\n"
 		      ".option pop\n"
 		      : "=r" (word) : "r" (word) :);
 
@@ -82,7 +95,7 @@ static __always_inline unsigned long variable__fls(unsigned long word)
 
 	asm volatile (".option push\n"
 		      ".option arch,+zbb\n"
-		      "clz %0, %1\n"
+		      CLZ "%0, %1\n"
 		      ".option pop\n"
 		      : "=r" (word) : "r" (word) :);
 
-- 
2.40.1


