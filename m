Return-Path: <linux-fsdevel+bounces-45003-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7EA3A6FF6E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 14:04:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 914C9177B15
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 12:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52AFE298CDD;
	Tue, 25 Mar 2025 12:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BOK/wPKS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A5D26656F;
	Tue, 25 Mar 2025 12:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742905630; cv=none; b=lSA3gxwGMP/D51a9ShRV/Oui4UEy61exe2Mv+BKBak0UgB7m4jJIHGjj0+7TLuFR2KNhEFA/mczgbvnRp03mEMupxoD1KJHWdo+Eujo1UCBc+T2KCqPNJp3JJWS/nBdfOfzxjPuPTxGe3gYu5R7Ep3kT/Q4o1XEk6hLYrPSeR0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742905630; c=relaxed/simple;
	bh=AWjl4tBrnhRkcRiex/88q6k6fRAmxNwISnnYEf7182Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m7H9qapBaAXxp+Tk/PZCNHDJ6C4mD/pSePwrd1a/6/Tpx1ArkIgEI3BWkrsbOuqwD6m/wzfajLNCAzXD44K6TbUyVOB/5XfCwq9++a2oUEsNuZanagW71We/UNy58cXcTT44MAPbwL1lWHgx6/qYWxj98cbkeF7XQEDU70gebQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BOK/wPKS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EF18C4CEE4;
	Tue, 25 Mar 2025 12:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742905629;
	bh=AWjl4tBrnhRkcRiex/88q6k6fRAmxNwISnnYEf7182Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BOK/wPKSymoONoK8d8zXPGGMy5MG+aYpHf3TkadCLwDPTOQJGUAW9et07ZG7zCZWv
	 ef4pdsDxtkJTHjY+SAKtAcW26il80oDtB38MozaTEhXlGd4IkrTlN3tIWkXmAwnoLn
	 BzHu8ImCylu3Yb81WL68Buni1g0ODfLOGd7OBrnKV/M2af0y77JoFV43LSNATjnN4G
	 9CzIE3AozXUaiD7HuaDWAl0wAkWF1HUbFGm1CJxGQ45QPczxfx9HKr6TYKmSS9kPAD
	 gZpFZHUBEZFz8k7KsyAguseekaOJzmeEib25mONLZRMhFlnpUorLwGTrqPnI6I56MM
	 2bv1z0/9P4X3A==
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
Subject: [RFC PATCH V3 43/43] riscv: Fixup address space overlay of print_mlk
Date: Tue, 25 Mar 2025 08:16:24 -0400
Message-Id: <20250325121624.523258-44-guoren@kernel.org>
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

If phyical memory is 1GiB for ilp32 linux, then print_mlk would be:
lowmem : 0xc0000000 - 0x00000000   ( 1024 MB)

After fixup:
lowmem : 0xc0000000 - 0xffffffff   ( 1024 MB)

Signed-off-by: Guo Ren (Alibaba DAMO Academy) <guoren@kernel.org>
---
 arch/riscv/mm/init.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 3cdbb033860e..e09286d4916a 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -105,26 +105,26 @@ static void __init zone_sizes_init(void)
 
 static inline void print_mlk(char *name, unsigned long b, unsigned long t)
 {
-	pr_notice("%12s : 0x%08lx - 0x%08lx   (%4ld kB)\n", name, b, t,
+	pr_notice("%12s : 0x%08lx - 0x%08lx   (%4ld kB)\n", name, b, t - 1,
 		  (((t) - (b)) >> LOG2_SZ_1K));
 }
 
 static inline void print_mlm(char *name, unsigned long b, unsigned long t)
 {
-	pr_notice("%12s : 0x%08lx - 0x%08lx   (%4ld MB)\n", name, b, t,
+	pr_notice("%12s : 0x%08lx - 0x%08lx   (%4ld MB)\n", name, b, t - 1,
 		  (((t) - (b)) >> LOG2_SZ_1M));
 }
 
 static inline void print_mlg(char *name, unsigned long b, unsigned long t)
 {
-	pr_notice("%12s : 0x%08lx - 0x%08lx   (%4ld GB)\n", name, b, t,
+	pr_notice("%12s : 0x%08lx - 0x%08lx   (%4ld GB)\n", name, b, t - 1,
 		   (((t) - (b)) >> LOG2_SZ_1G));
 }
 
 #if BITS_PER_LONG == 64
 static inline void print_mlt(char *name, unsigned long b, unsigned long t)
 {
-	pr_notice("%12s : 0x%08lx - 0x%08lx   (%4ld TB)\n", name, b, t,
+	pr_notice("%12s : 0x%08lx - 0x%08lx   (%4ld TB)\n", name, b, t - 1,
 		   (((t) - (b)) >> LOG2_SZ_1T));
 }
 #else
-- 
2.40.1


