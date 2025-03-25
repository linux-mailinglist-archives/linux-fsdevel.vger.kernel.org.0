Return-Path: <linux-fsdevel+bounces-44974-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ECF7A6FCB2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 13:37:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBADE1764FC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 12:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25050268689;
	Tue, 25 Mar 2025 12:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YGv7Ju8F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393C425A634;
	Tue, 25 Mar 2025 12:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742905235; cv=none; b=qRVQxWTE0q4WHX8CtpT3RT9pkVURq9wwNO4FDZK6VEoNLSPR8STliCoY72Y5e8tq/5+t5sHCLXhZPvqhr61zCs/hpFBcyUdMUOClw5KymIPZqx1kipC6DknwxgeFFnMaHKMZ4Ho76pUzpGJtA7D5YW0EDJEJuhClIdWBavuOFSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742905235; c=relaxed/simple;
	bh=IFZFjonaMzbpRZ4swpgyItEna4nE83LkZzb9BRzGITE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I758uCRIsZ/pTmdIvgYzt7IIftxvY9iSVz++22aEQ4JkCcOa91ax7MBgIpP6nx1PCJYo5LSsB5AhGg7MHMqWdh/eK3uVdWFAP+X0vHRoWSF1+70f5Vg4I2vBuh2q60M7Xz4CxVKkljpU9FsDaGM3YSgem7xQ0jaZnyXQoO7AbfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YGv7Ju8F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E3FBC4CEEE;
	Tue, 25 Mar 2025 12:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742905234;
	bh=IFZFjonaMzbpRZ4swpgyItEna4nE83LkZzb9BRzGITE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YGv7Ju8FJqwJKAhoK+0bpefpHJmqwSqitCJQ3KA8SHoFBO3xjgZJGCnN1+EpM9Ri8
	 G0F8vKvx8n6+OSgZoVo+DMyBKKoIIhJSCP3taMQ5FZeWGN/R31z9hqNogcz/s/Onyr
	 z7gFsqQn85faeI7gGJQLGHu93WAcoXryyyRSyQsANFNuhZaVIo6Dx8943m3kKw9yDg
	 27bjtFahCMk02wsXueW0/FZUhPIbW+fn3gQxchZIXU1nl5TX8/4hg5q3hXCN/9iqSh
	 /WA528nukATyoTdAqfWLTZshpwfuMiYbtl8zLXtJpFV+4Wd+cfr5szXSWpIHHAHUjx
	 4Ts1fcwAE9wQQ==
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
Subject: [RFC PATCH V3 16/43] rv64ilp32_abi: riscv: Support physical addresses >= 0x80000000
Date: Tue, 25 Mar 2025 08:15:57 -0400
Message-Id: <20250325121624.523258-17-guoren@kernel.org>
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

The RV64ILP32 ABI has two independent 2GiB address space:
 - 0 ~ 0x7fffffff
 - 0xffffffff80000000 ~ 0xffffffffffffffff

In the rv64ilp32 ABI, 0x80000000 is illegal; hence, use a
temporary trap handler to zero-extend the address for jalr,
load and store operations.

Signed-off-by: Guo Ren (Alibaba DAMO Academy) <guoren@kernel.org>
---
 arch/riscv/kernel/head.S | 112 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 112 insertions(+)

diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
index e55a92be12b1..bd2f30aa6d01 100644
--- a/arch/riscv/kernel/head.S
+++ b/arch/riscv/kernel/head.S
@@ -170,6 +170,118 @@ secondary_start_sbi:
 
 .align 2
 .Lsecondary_park:
+#ifdef CONFIG_ABI_RV64ILP32
+.option push
+.option norelax
+.option norvc
+	addiw sp, sp, -32
+
+	/* zext.w sp */
+	slli  sp, sp, 32
+	srli  sp, sp, 32
+
+	/* zext.w ra */
+	slli ra, ra, 32
+	srli ra, ra, 32
+
+	/* zext.w fp */
+	slli fp, fp, 32
+	srli fp, fp, 32
+
+	/* zext.w tp */
+	slli tp, tp, 32
+	srli tp, tp, 32
+
+	/* save tmp reg */
+	REG_S ra, 24(sp)
+	REG_S fp, 16(sp)
+	REG_S tp,  8(sp)
+	REG_S gp,  0(sp)
+
+	/* zext.w epc */
+	csrr ra, CSR_EPC
+	slli ra, ra, 32
+	srli ra, ra, 32
+	csrw CSR_SEPC, ra
+
+	csrr gp, CSR_CAUSE
+
+	/* EXC_INST_ACCESS */
+	addiw fp, gp, -1
+	beqz fp, 6f
+
+	/* EXC_LOAD_ACCESS */
+	addiw fp, gp, -5
+	beqz fp, 1f
+
+	/* EXC_STORE_ACCESS */
+	addiw fp, gp, -7
+	beqz fp, 1f
+
+	j 7f
+1:
+	/* get inst */
+	lw ra, 0(ra)
+	andi gp, ra, 0x3
+
+	/* c.(lw/sw/ld/sd)sp */
+	addiw fp, gp, -2
+	beqz fp, 6f
+
+	/* lw/sw/ld/sd */
+	addiw fp, gp, -3
+	beqz fp, 2f
+
+	/* c.(lw/sw/ld/sd) */
+	li fp, 0x7
+	slli fp, fp, 7
+	and ra, fp, ra
+	slli ra, ra, 8
+	j 3f
+
+2:
+	/* get rs1 */
+	li fp, 0x1f
+	slli fp, fp, 15
+	and ra, fp, ra
+
+3:
+	/* copy rs1 to rd */
+	mv fp, ra
+	srli fp, fp, 8
+	or ra, fp, ra
+
+	/* modify slli */
+	la fp, 4f
+	lw tp, 0(fp)
+	mv gp, tp
+	or tp, ra, tp
+	sw tp, 0(fp)
+	fence.i
+4:	slli x0, x0, 32
+	sw gp, 0(fp)
+
+	/* modify srli */
+	la fp, 5f
+	lw tp, 0(fp)
+	mv gp, tp
+	or tp, ra, tp
+	sw tp, 0(fp)
+	fence.i
+5:	srli x0, x0, 32
+	sw gp, 0(fp)
+
+6:
+	/* restore tmp reg */
+	REG_L ra, 24(sp)
+	REG_L fp, 16(sp)
+	REG_L tp,  8(sp)
+	REG_L gp,  0(sp)
+	addi sp, sp, 32
+	sret
+.option pop
+7:
+#endif
 	/*
 	 * Park this hart if we:
 	 *  - have too many harts on CONFIG_RISCV_BOOT_SPINWAIT
-- 
2.40.1


