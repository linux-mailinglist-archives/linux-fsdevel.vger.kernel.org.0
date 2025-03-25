Return-Path: <linux-fsdevel+bounces-44995-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6927BA6FECF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 13:57:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63D803A8FC8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 12:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C26C28150E;
	Tue, 25 Mar 2025 12:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MseyejDn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7103A25743E;
	Tue, 25 Mar 2025 12:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742905525; cv=none; b=tvtvcy8TQnRqKGSvWfiOSpQjkdSdS7KVGV/bzyplZJkwuqX/wBAD4at1i9+iRMqrVwa5CQtW6CUE/MHxqc43dZSxwVSn/JhlrFaYsUn0zFH2iQ9wcK4QEwL75qUE6g0A6jGd4EtgyhLu8Cc/xtuz4sqCOxdke+D7GE1scSdI0/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742905525; c=relaxed/simple;
	bh=YhFQ2ibshi4VdwpUCryIeDZCxGJd5L8LcBHKHU0qt6Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RDRBZkdXy+GY89rkFcFB0SyuYeWX82s2/n/xXW3RDHIRWcSZEL3xc9EDY7LE8R1WGjpbdUswyJOzK7yMi0A8eCREHbkYMcKTNOghD3tKUmUqPrIedrehz2lCz0cNN946K1dkngGS1VpLdMJkTyLABw72bsPSiyr7P7BN7vZFRo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MseyejDn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7793AC4CEEE;
	Tue, 25 Mar 2025 12:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742905525;
	bh=YhFQ2ibshi4VdwpUCryIeDZCxGJd5L8LcBHKHU0qt6Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MseyejDnF7mwqmEqN7tEG0RqwtwCeVyNtPH/896j91wVIegZa2jtI2EZ83uU/0V2E
	 9lABAyLdbPYzFsVhyfmGnTTu37x50QYjuV8s+jH6Amg7TKgjIpjJN8Z1yU4VwkbWUT
	 x5BXsnAu3qJ+98zrmXtBO952PUMQ22v+Yt9pce53Mph3EDro8EXgBHN3FBLaE3Dems
	 iwO2PikBqjaPdls2M1/9azOD9y8bGLfzPBTVJus/mPdsTHro2WluEYbis3rUZIYFMZ
	 ayOSUhoxogSQEsa2y3V0uhRHOG/GCXPjaG6XijbjVMJSyE4jTNrm5nZ34MPsJ6W1+h
	 mVg9mRnoG2F4A==
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
Subject: [RFC PATCH V3 36/43] rv64ilp32_abi: printf: Use BITS_PER_LONG instead of CONFIG_64BIT
Date: Tue, 25 Mar 2025 08:16:17 -0400
Message-Id: <20250325121624.523258-37-guoren@kernel.org>
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

RV64ILP32 ABI systems have BITS_PER_LONG set to 32. Use
BITS_PER_LONG instead of CONFIG_64BIT.

Signed-off-by: Guo Ren (Alibaba DAMO Academy) <guoren@kernel.org>
---
 lib/vsprintf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 56fe96319292..2d719be86945 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -771,7 +771,7 @@ static inline int __ptr_to_hashval(const void *ptr, unsigned long *hashval_out)
 	/* Pairs with smp_wmb() after writing ptr_key. */
 	smp_rmb();
 
-#ifdef CONFIG_64BIT
+#if BITS_PER_LONG == 64
 	hashval = (unsigned long)siphash_1u64((u64)ptr, &ptr_key);
 	/*
 	 * Mask off the first 32 bits, this makes explicit that we have
-- 
2.40.1


