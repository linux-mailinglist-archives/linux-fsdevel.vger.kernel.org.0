Return-Path: <linux-fsdevel+bounces-44965-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D527AA6FB62
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 13:26:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E78816D161
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 12:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B62F625F79D;
	Tue, 25 Mar 2025 12:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WAArLR1c"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE1B2571BF;
	Tue, 25 Mar 2025 12:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742905110; cv=none; b=Q4BR1RjAqyqf8wfccMCNcsRgwbzKIEjU7E8OamM7Mm45qB+8cwYkyj9mGXvKGRoKfDX1ZThNVFxtR1zT4PnSfiPtKqtuL1wC+0MejuH1ZwmseMTX1re01tlLEW+O7DOkwRIdRj5tTnUVxoK89bN0Frw7BwUZIMh8XPEtZQ+Gzow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742905110; c=relaxed/simple;
	bh=BZhFrxC5LqWkJB24//QTxmrLgLREqoX75xqFkQDG2c4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pIK058E41+geMZ3KB0ui3+TP5zTuPsuibuHNVOxLzzBCq1PvfUI6q/qz5PrmSyhMvDkf3QIqN7zQ9ZhbUxpi03oLTUkKgKuV1NYrelztzrLNN0iL6uDOvXJ8fNEM5CtTRRRfyvVwIA0fW7SmWG20s9H2d2Mqb+mHLPce/m1FVHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WAArLR1c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC5F5C4CEE9;
	Tue, 25 Mar 2025 12:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742905109;
	bh=BZhFrxC5LqWkJB24//QTxmrLgLREqoX75xqFkQDG2c4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WAArLR1cIlUkjcVTXX0Tls/hyrhxZQce1pwWCWmmrhVqZo6CHID40/UUJJxlUdSIH
	 pvJzyeJsFsbR3Qj6oZQI0sosmdA0f0axmt/j3x0JtA4NVFN4oEroDbhzfKMj77LjcG
	 VpeybYwfnePV+fqBKEfi+c8b/VpfgQniRgpy+YGfPxfyz64Z96hgATbQA+bOjettSE
	 TFQQdcxc3W5FBVyXIBMFFRRS9NmLp2l79WVGP9idTb0YBrpmWMraoXJreb1OnK+1kW
	 R4WBNVgCauqIfaxd2Ttz8fBWM1S2wpc+NpxrTt7N9OYAE6+nKKUlTbfrvFhzZhVeQ9
	 0U3othdem+g7g==
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
Subject: [RFC PATCH V3 07/43] rv64ilp32_abi: riscv: arch_hweight: Adapt cpopw & cpop of zbb extension
Date: Tue, 25 Mar 2025 08:15:48 -0400
Message-Id: <20250325121624.523258-8-guoren@kernel.org>
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
Use cpopw for u32_weight and cpop for u64_weight.

Signed-off-by: Guo Ren (Alibaba DAMO Academy) <guoren@kernel.org>
---
 arch/riscv/include/asm/arch_hweight.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/include/asm/arch_hweight.h b/arch/riscv/include/asm/arch_hweight.h
index 613769b9cdc9..42577965f5bb 100644
--- a/arch/riscv/include/asm/arch_hweight.h
+++ b/arch/riscv/include/asm/arch_hweight.h
@@ -12,7 +12,11 @@
 #if (BITS_PER_LONG == 64)
 #define CPOPW	"cpopw "
 #elif (BITS_PER_LONG == 32)
+#ifdef CONFIG_64BIT
+#define CPOPW	"cpopw "
+#else
 #define CPOPW	"cpop "
+#endif
 #else
 #error "Unexpected BITS_PER_LONG"
 #endif
@@ -47,7 +51,7 @@ static inline unsigned int __arch_hweight8(unsigned int w)
 	return __arch_hweight32(w & 0xff);
 }
 
-#if BITS_PER_LONG == 64
+#ifdef CONFIG_64BIT
 static __always_inline unsigned long __arch_hweight64(__u64 w)
 {
 # ifdef CONFIG_RISCV_ISA_ZBB
@@ -61,7 +65,7 @@ static __always_inline unsigned long __arch_hweight64(__u64 w)
 	     ".option pop\n"
 	     : "=r" (w) : "r" (w) :);
 
-	return w;
+	return (unsigned long)w;
 
 legacy:
 # endif
-- 
2.40.1


