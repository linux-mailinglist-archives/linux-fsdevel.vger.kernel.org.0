Return-Path: <linux-fsdevel+bounces-44960-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F505A6FB0D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 13:21:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACBA9189926E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 12:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB525259CB2;
	Tue, 25 Mar 2025 12:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M7zSCa31"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000E9257421;
	Tue, 25 Mar 2025 12:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742905039; cv=none; b=Li23NvSFqYTUeBP5kpr+eztDRZQCED2QXCd5C8021aa1MYxvkrx3fI/UI7169EQ6aTJ0X/3iyCkLHSRcPdbWE8C98foe12QYLEdC8ukRyW1pf8MvNyX2XYHhs6jmyef25c8ncpaMyglZ+SsRtreRrXM0iG3UyAoSB1TLOtVuSeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742905039; c=relaxed/simple;
	bh=LCI/yc1ahl/Zp9x+QUBbqr6DoNgqTtvLT0+YbqUE8Kc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V/zvo+XkGniZ0eBsL6LVRWfifRC3wHgLCI52gyJyyOtV34rbwoxdfwaesLr+gijd377FL5t+AHzDyvKkWTEC9flb0xb4yIT44gL4Oh82iM61yh6pWlPuuYNKhD2Hlb1Clb0PUVg8M/P5w5XpR0JsHRmh4lpAwaV+5LdE5GD/+NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M7zSCa31; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89036C4CEEF;
	Tue, 25 Mar 2025 12:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742905038;
	bh=LCI/yc1ahl/Zp9x+QUBbqr6DoNgqTtvLT0+YbqUE8Kc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M7zSCa31T5EIDOyp2pisnsb36omDKGCK3CtmKd0jmWms5JTGy4cL6gqroHU+U6Do3
	 GF5N76/FLWX7xtVasdLhKMcInuvkPjYr3/XnVSZ0Pobo+jSDrMTbHwC4OV0hO+sPFI
	 ioSKnCYcXTCDbUuV2wyGraJbUwJ9AzzjW2UTGrk2nCywWovoornRX4ZXKz0LVTxi7r
	 qUcDCGXPxGB7Nv/XpwP22Vm+8YPGohVwdZX0Qz0dza/5WXPU3SnFd3lRUYrc4XYmk2
	 cIekIVLnOX0Kw3qDsIdU2cHos9atrofsQ8fmXPfl7xnlXnTI5oe/zK85/xe5ly8pgc
	 65J8Dyq0AYcUQ==
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
Subject: [RFC PATCH V3 02/43] rv64ilp32_abi: riscv: Adapt Makefile and Kconfig
Date: Tue, 25 Mar 2025 08:15:43 -0400
Message-Id: <20250325121624.523258-3-guoren@kernel.org>
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

Extend the ARCH_RV64I base with ABI_RV64ILP32 to compile the Linux
kernel self into ILP32 on CONFIG_64BIT=y, minimizing the kernel's
memory footprint and cache occupation.

The 'cmd_cpp_lds_S' in scripts/Makefile.build uses cpp_flags for
ld.s generation, so add "-mabi=xxx" to KBUILD_CPPFLAGS, just like
what we've done in KBUILD_CLFAGS and KBUILD_AFLAGS.

cmd_cpp_lds_S = $(CPP) $(cpp_flags) -P -U$(ARCH)

The rv64ilp32 ABI reuses an rv64 toolchain whose default "-mabi="
is lp64, so add "-mabi=ilp32" to correct it.

Add config entry with rv64ilp32.config fragment in Makefile:
 - rv64ilp32_defconfig

Signed-off-by: Guo Ren (Alibaba DAMO Academy) <guoren@kernel.org>
---
 arch/riscv/Kconfig                  | 12 ++++++++++--
 arch/riscv/Makefile                 | 17 +++++++++++++++++
 arch/riscv/configs/rv64ilp32.config |  1 +
 3 files changed, 28 insertions(+), 2 deletions(-)
 create mode 100644 arch/riscv/configs/rv64ilp32.config

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 7612c52e9b1e..da2111b0111c 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -213,7 +213,7 @@ config RISCV
 	select TRACE_IRQFLAGS_SUPPORT
 	select UACCESS_MEMCPY if !MMU
 	select USER_STACKTRACE_SUPPORT
-	select ZONE_DMA32 if 64BIT
+	select ZONE_DMA32 if 64BIT && !ABI_RV64ILP32
 
 config RUSTC_SUPPORTS_RISCV
 	def_bool y
@@ -298,6 +298,7 @@ config PAGE_OFFSET
 config KASAN_SHADOW_OFFSET
 	hex
 	depends on KASAN_GENERIC
+	default 0x70000000 if ABI_RV64ILP32
 	default 0xdfffffff00000000 if 64BIT
 	default 0xffffffff if 32BIT
 
@@ -341,7 +342,7 @@ config FIX_EARLYCON_MEM
 
 config ILLEGAL_POINTER_VALUE
 	hex
-	default 0 if 32BIT
+	default 0 if 32BIT || ABI_RV64ILP32
 	default 0xdead000000000000 if 64BIT
 
 config PGTABLE_LEVELS
@@ -418,6 +419,13 @@ config ARCH_RV64I
 
 endchoice
 
+config ABI_RV64ILP32
+	bool "ABI RV64ILP32"
+	depends on 64BIT
+	help
+	  Compile linux kernel self into RV64ILP32 ABI of RISC-V psabi
+	  specification.
+
 # We must be able to map all physical memory into the kernel, but the compiler
 # is still a bit more efficient when generating code if it's setup in a manner
 # such that it can only map 2GiB of memory.
diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
index 13fbc0f94238..76db01020a22 100644
--- a/arch/riscv/Makefile
+++ b/arch/riscv/Makefile
@@ -30,10 +30,21 @@ ifeq ($(CONFIG_ARCH_RV64I),y)
 	BITS := 64
 	UTS_MACHINE := riscv64
 
+ifeq ($(CONFIG_ABI_RV64ILP32),y)
+	KBUILD_CPPFLAGS += -mabi=ilp32
+
+	KBUILD_CFLAGS += -mabi=ilp32
+	KBUILD_AFLAGS += -mabi=ilp32
+
+	KBUILD_LDFLAGS += -melf32lriscv
+else
+	KBUILD_CPPFLAGS += -mabi=lp64
+
 	KBUILD_CFLAGS += -mabi=lp64
 	KBUILD_AFLAGS += -mabi=lp64
 
 	KBUILD_LDFLAGS += -melf64lriscv
+endif
 
 	KBUILD_RUSTFLAGS += -Ctarget-cpu=generic-rv64 --target=riscv64imac-unknown-none-elf \
 			    -Cno-redzone
@@ -41,6 +52,8 @@ else
 	BITS := 32
 	UTS_MACHINE := riscv32
 
+	KBUILD_CPPFLAGS += -mabi=ilp32
+
 	KBUILD_CFLAGS += -mabi=ilp32
 	KBUILD_AFLAGS += -mabi=ilp32
 	KBUILD_LDFLAGS += -melf32lriscv
@@ -224,6 +237,10 @@ PHONY += rv32_nommu_virt_defconfig
 rv32_nommu_virt_defconfig:
 	$(Q)$(MAKE) -f $(srctree)/Makefile nommu_virt_defconfig 32-bit.config
 
+PHONY += rv64ilp32_defconfig
+rv64ilp32_defconfig:
+	$(Q)$(MAKE) -f $(srctree)/Makefile defconfig rv64ilp32.config
+
 define archhelp
   echo  '  Image		- Uncompressed kernel image (arch/riscv/boot/Image)'
   echo  '  Image.gz	- Compressed kernel image (arch/riscv/boot/Image.gz)'
diff --git a/arch/riscv/configs/rv64ilp32.config b/arch/riscv/configs/rv64ilp32.config
new file mode 100644
index 000000000000..07536586e169
--- /dev/null
+++ b/arch/riscv/configs/rv64ilp32.config
@@ -0,0 +1 @@
+CONFIG_ABI_RV64ILP32=y
-- 
2.40.1


