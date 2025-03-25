Return-Path: <linux-fsdevel+bounces-44972-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E89AA6FC8B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 13:36:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13364840482
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 12:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CCFC26771B;
	Tue, 25 Mar 2025 12:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SLdkNpDM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD51E25A33E;
	Tue, 25 Mar 2025 12:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742905206; cv=none; b=FO0PeYUj9mjI3XtLL6EhdgFMKI4Bl2lYHYrOVB7XgWKXg2ISuc0flfpA4uNxiPsSzm3lnmhREEyUyKisfXnTvFobCbs6V56DX8Vt4QUzenfLlHiGa/4sRUVVrgXLQyEl4VnAs92V4Ngxn7kg9TLooPA0I4/utOuZQhPm8l+x1ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742905206; c=relaxed/simple;
	bh=S5onwW8Rhyiou8sUliJC71k2++Mi5WmKeWwnQHNXJR4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nXNg+hccrfbi5znxnNMx3O7P6GmaBFUO4T1wLGqNL8gGhXq9MLH8L9op6nJ7RGrFeiSuBcLNcYxFDfc9wrz8qoG/DYZWkCJIuwPdxFCVlti8z8qu3qCq2ksjzcjHc+NCXyEnDMhZYUvcTYDwfas0ISkLLqsmhWokv4v027dcDMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SLdkNpDM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4631C4CEED;
	Tue, 25 Mar 2025 12:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742905206;
	bh=S5onwW8Rhyiou8sUliJC71k2++Mi5WmKeWwnQHNXJR4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SLdkNpDMElfs6JtH93HL2qjB8ooc8njsv/pKcwCApdLyBmrRvX5jPuX625CrCL3KO
	 LLg2i7GO2jiDdmvOrZJHbXmmZ//hxLsMMV2R487NeFcTSsmqjUedkLmuzv7hLlERU6
	 kiuccu5qk3IkbjYpbkj/s/pT/RPFgjJK5adv7y6A6BEEgO8BBTscDUHE/YjxJcfAd0
	 ppo9vCiFRV5Tz05przlyIDyBiWv9hSmTIygPLI/aoXi+ZELjeBp9iCTv0eEu9tP+Tz
	 vHMjNE6CxPdHgma3URda2HPkGEEkWTjPcCLQMXFENwL53LrB+OGroHLD8Txjexf9jd
	 7/iF+KyP6XFLQ==
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
Subject: [RFC PATCH V3 14/43] rv64ilp32_abi: riscv: Adapt kernel module code
Date: Tue, 25 Mar 2025 08:15:55 -0400
Message-Id: <20250325121624.523258-15-guoren@kernel.org>
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

Because riscv_insn_valid_32bit_offset is always true for ILP32,
use BITS_PER_LONG instead of CONFIG_64BIT.

Signed-off-by: Guo Ren (Alibaba DAMO Academy) <guoren@kernel.org>
---
 arch/riscv/kernel/module.c   | 2 +-
 include/asm-generic/module.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/kernel/module.c b/arch/riscv/kernel/module.c
index 47d0ebeec93c..d7360878e618 100644
--- a/arch/riscv/kernel/module.c
+++ b/arch/riscv/kernel/module.c
@@ -45,7 +45,7 @@ struct relocation_handlers {
  */
 static bool riscv_insn_valid_32bit_offset(ptrdiff_t val)
 {
-#ifdef CONFIG_32BIT
+#if BITS_PER_LONG == 32
 	return true;
 #else
 	return (-(1L << 31) - (1L << 11)) <= val && val < ((1L << 31) - (1L << 11));
diff --git a/include/asm-generic/module.h b/include/asm-generic/module.h
index 98e1541b72b7..f870171b14a8 100644
--- a/include/asm-generic/module.h
+++ b/include/asm-generic/module.h
@@ -12,7 +12,7 @@ struct mod_arch_specific
 };
 #endif
 
-#ifdef CONFIG_64BIT
+#if BITS_PER_LONG == 64
 #define Elf_Shdr	Elf64_Shdr
 #define Elf_Phdr	Elf64_Phdr
 #define Elf_Sym		Elf64_Sym
-- 
2.40.1


