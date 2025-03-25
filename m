Return-Path: <linux-fsdevel+bounces-44997-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C892EA6FF36
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 14:01:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC5A719A1069
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 12:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84A5D284B5C;
	Tue, 25 Mar 2025 12:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TKIbxeDg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4282265618;
	Tue, 25 Mar 2025 12:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742905554; cv=none; b=EC3zoYCKR267p7G5SvpwrW/WQVe56fH13yfmabwrnZg2ZpDnIAjZxb9WwnblRTh+zARcaBxJ16o497F9Xi1WIIH81mluDLQEaZzSnYi09R3dsn1D8O9CWvUKfYaWJcUOaLwuHejTLdD+F2IocLRVPHRnbsminSrwiJd7o8keJXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742905554; c=relaxed/simple;
	bh=eb9pFbZS3Y9m5tP2e5oU2ev4kJ8aZOyHuzMgMflfDxM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RqjGZuG33/QYFt4LqjKmx9V9ufMU9l8R40cvUjzRmgrbN/peTjv1LimR61OfpeoOrxNmIakXhmEeytubObWW/hGTY5jR4Jhn1ZEIUhgo54UprZ2MbqzFNeFTEV1J3P1EawlzX6GRWAkFlJOvsZJafIaGufB6/LjvSYw5D3HaOPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TKIbxeDg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98700C4CEE4;
	Tue, 25 Mar 2025 12:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742905554;
	bh=eb9pFbZS3Y9m5tP2e5oU2ev4kJ8aZOyHuzMgMflfDxM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TKIbxeDg/4MGDoxGYhtsr77x8nD9+TpCG8oy/mBv1GHzr8ZWepo0+9u/qgnTYwhM7
	 9FoabPbbN9S6IfOf26oxS3m5p0frx/eThfy2pNkvlIe2k1adYFkjCwm3E3QYrPnnXY
	 qg1+2WeIhc8bsbGmrVaN8x2QJEpf+pJnOK1bpb9Cm3LPqRTJwuy9bTAStpIJuNhcng
	 U6oe1mYNc6XNsLp33CR0gMzzC0NbL9mf8zaoGaRdRBmnSf8sdgpDmPkIT5iWLXo5Lq
	 f6F/efG1+AqbmifuFranEddUppFwWnYxtFJSXivX7reLfW7B+/YSGNRM9ytoYkkqRu
	 QY3BUYNUiqCrw==
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
Subject: [RFC PATCH V3 38/43] rv64ilp32_abi: syscall: Use CONFIG_64BIT instead of BITS_PER_LONG
Date: Tue, 25 Mar 2025 08:16:19 -0400
Message-Id: <20250325121624.523258-39-guoren@kernel.org>
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

The RV64ILP32 ABI adopts the syscall rules from CONFIG_64BIT and
directly uses 64BIT, replacing BITS_PER_LONG representation.

Signed-off-by: Guo Ren (Alibaba DAMO Academy) <guoren@kernel.org>
---
 arch/riscv/include/asm/syscall_table.h | 2 +-
 arch/riscv/include/asm/unistd.h        | 4 ++--
 scripts/checksyscalls.sh               | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/include/asm/syscall_table.h b/arch/riscv/include/asm/syscall_table.h
index 0c2d61782813..aab2bc0ddf4e 100644
--- a/arch/riscv/include/asm/syscall_table.h
+++ b/arch/riscv/include/asm/syscall_table.h
@@ -1,6 +1,6 @@
 #include <asm/bitsperlong.h>
 
-#if __BITS_PER_LONG == 64
+#ifdef CONFIG_64BIT
 #include <asm/syscall_table_64.h>
 #else
 #include <asm/syscall_table_32.h>
diff --git a/arch/riscv/include/asm/unistd.h b/arch/riscv/include/asm/unistd.h
index e6d904fa67c5..86b9c1712f24 100644
--- a/arch/riscv/include/asm/unistd.h
+++ b/arch/riscv/include/asm/unistd.h
@@ -16,10 +16,10 @@
 #define __ARCH_WANT_COMPAT_FADVISE64_64
 #endif
 
-#if defined(__LP64__) && !defined(__SYSCALL_COMPAT)
+#if defined(CONFIG_64BIT) && !defined(__SYSCALL_COMPAT)
 #define __ARCH_WANT_NEW_STAT
 #define __ARCH_WANT_SET_GET_RLIMIT
-#endif /* __LP64__ */
+#endif /* CONFIG_64BIT */
 
 #define __ARCH_WANT_MEMFD_SECRET
 
diff --git a/scripts/checksyscalls.sh b/scripts/checksyscalls.sh
index 1e5d2eeb726d..9cc4f9086dfe 100755
--- a/scripts/checksyscalls.sh
+++ b/scripts/checksyscalls.sh
@@ -76,7 +76,7 @@ cat << EOF
 #endif
 
 /* System calls for 32-bit kernels only */
-#if BITS_PER_LONG == 64
+#ifdef CONFIG_64BIT
 #define __IGNORE_sendfile64
 #define __IGNORE_ftruncate64
 #define __IGNORE_truncate64
-- 
2.40.1


