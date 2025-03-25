Return-Path: <linux-fsdevel+bounces-44999-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 308ABA6FF45
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 14:02:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48DE8188ADE0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 12:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB24128FFE5;
	Tue, 25 Mar 2025 12:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JUZLlaeI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A4326563D;
	Tue, 25 Mar 2025 12:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742905587; cv=none; b=ZFiX8Rp3M6E4w259m2oQVIE/QlDmXFz3etXVRrAQmcTd9PcjeK1lzRDk9ZwjFLnhxQ/FGU/yMye0RLRkXZtZJicpagx5W7Ujt2UNxP3v7jaILoTBd2g0ujIr7Ne9M14GCV0FPas2OUXgbsvthysf04Bz2wrPMu4yHIonvrRXix4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742905587; c=relaxed/simple;
	bh=CN5WMBcSq4ybkzYSZlZQi/bVyuOph6iTDFSpBV5o4N8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B0jE2DtG90AS7PTM07xmHlDDAGC4AGMKW/Sr1QzbjaFzN6vGPLmcggdd1Q7y+kjw69/9dt9S1OtRk2cKHnIh/DATGdkijOcMHASQxPHhqL+NSYIgOyf+FWtJ4Mwg3KVoL0QviyJE3QdBoQHn2jQhA40uRbiSqjVMoXEHu4MvNxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JUZLlaeI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B719EC4CEED;
	Tue, 25 Mar 2025 12:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742905586;
	bh=CN5WMBcSq4ybkzYSZlZQi/bVyuOph6iTDFSpBV5o4N8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JUZLlaeIY8Hwh6lRUruQPwQasNliWPwz7cJWB27ghj4+IZjN2b4GbBZ/fSSZ6XMji
	 us+Hkvcz4IetM23aVYMu/AYs8cVXwsZBW7NeOsZgDbCgt6g5xqJd48sWMPOg1jFmZO
	 dTGKmsr8CcSEXGjzQ6k8LM44Bk1+QDQseKg+PcX8rq6xmuSZhGjpiAtIF0iRessEj3
	 aRKlIJp+k0H+q7J7Nwhehdmf4wV0LPBD/VdM8zp20s4PoYdcxn128IXf7LF6zj8Ai+
	 3WimUJp5bM0Px6NuLSmw5Ey3muirnPyNTnJB+ycI51xStVOVnALDfDoGBxJW8uVnSm
	 PDPGAqzidOZVg==
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
Subject: [RFC PATCH V3 40/43] rv64ilp32_abi: tracepoint-defs: Using u64 for trace_print_flags.mask
Date: Tue, 25 Mar 2025 08:16:21 -0400
Message-Id: <20250325121624.523258-41-guoren@kernel.org>
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

The rv64ilp32 ABI relies on CONFIG_64BIT, and mmflags.h defines
VMA flags with BIT_ULL. Consequently, use "unsigned long long"
for trace_print_flags.mask to align with VMAflag's type size.

Signed-off-by: Guo Ren (Alibaba DAMO Academy) <guoren@kernel.org>
---
 include/linux/tracepoint-defs.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/tracepoint-defs.h b/include/linux/tracepoint-defs.h
index aebf0571c736..3b51ede18e32 100644
--- a/include/linux/tracepoint-defs.h
+++ b/include/linux/tracepoint-defs.h
@@ -14,7 +14,11 @@
 struct static_call_key;
 
 struct trace_print_flags {
+#ifdef CONFIG_64BIT
+	unsigned long long	mask;
+#else
 	unsigned long		mask;
+#endif
 	const char		*name;
 };
 
-- 
2.40.1


