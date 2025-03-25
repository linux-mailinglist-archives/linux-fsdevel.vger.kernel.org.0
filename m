Return-Path: <linux-fsdevel+bounces-44964-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A00FFA6FB4F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 13:24:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 185A71892142
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 12:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80BA725DAE1;
	Tue, 25 Mar 2025 12:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="teUw2FHO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB0E2571BF;
	Tue, 25 Mar 2025 12:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742905098; cv=none; b=j67yYqqg0y6WqNl8J4rYQIUAmFo6pfTvgmvxQdEwRgD/qujWd/k/xAyvnTg/f6i3nWXg4kZ6FFASvXb1TtS4CqOCLs6hZpOCXCXM0dthnD8++QMzFpCJ1beq65ck2rqrpuPSvrEIXsJTEoEz6ZsioHRekQp/WIXY9EOzeTiYleI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742905098; c=relaxed/simple;
	bh=UABL4vMSXTJ7ioKDShPOJnvQ/v/SXYqnkdRYWjffYuI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SyJwV++7HcvMup5wz1WMiXdvGniqVOA9szkS+ycAZDN+s5VtFzB9Uvn38uRQ1d0ohCODLFbI3SNXT4UqPR6aoef5bmqj15daAE621Ns9c1uSvahOqPaXXkiqIrRNtYmVvTEadaCWhs1tBMaCkxLsVpY4QfEc0m4jLv6TOO2kBSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=teUw2FHO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3232CC4CEE4;
	Tue, 25 Mar 2025 12:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742905095;
	bh=UABL4vMSXTJ7ioKDShPOJnvQ/v/SXYqnkdRYWjffYuI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=teUw2FHOlBQ1lrIKT7Hs+qUfkkWnEEpTWG7+L12tSB2mbphU+tEwWLTIzWHI0iiRJ
	 DbQvjYXhNoIHuNkVkJjJR9grTurlc5egb+jrZsRmnn/7yCBhuoST5sWNFrEg4whn8S
	 R8w4LPsMxn2q34XM1d2a9BJgQLJkEbNoee3acd75JHM7OSqPc/dbF55YqAnxMmxb3B
	 GonCtkmj1hPTAVD6eZOTRDAsO7Au8f+9qjRty68GqzTjCoMQ60GAujyzoXiVezS8hQ
	 Cw9dI4jq4Uyzfsd0C+8lhRsjuPYR84Qgic3GJeVkTgp4byQiRpTz3vrpRfdwMGr/ce
	 BEShK8B1mJ11Q==
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
Subject: [RFC PATCH V3 06/43] rv64ilp32_abi: riscv: csum: Utilize 64-bit width to improve the performance
Date: Tue, 25 Mar 2025 08:15:47 -0400
Message-Id: <20250325121624.523258-7-guoren@kernel.org>
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

The RV64ILP32 ABI, derived from a 64-bit ISA, uses 32-bit
BITS_PER_LONG. Therefore, checksum algorithm could utilize 64-bit
width to improve the performance.

Signed-off-by: Guo Ren (Alibaba DAMO Academy) <guoren@kernel.org>
---
 arch/riscv/lib/csum.c | 48 +++++++++++++++++++++----------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/arch/riscv/lib/csum.c b/arch/riscv/lib/csum.c
index 7fb12c59e571..7139ab855349 100644
--- a/arch/riscv/lib/csum.c
+++ b/arch/riscv/lib/csum.c
@@ -22,17 +22,17 @@ __sum16 csum_ipv6_magic(const struct in6_addr *saddr,
 			__u32 len, __u8 proto, __wsum csum)
 {
 	unsigned int ulen, uproto;
-	unsigned long sum = (__force unsigned long)csum;
+	xlen_t sum = (__force xlen_t)csum;
 
-	sum += (__force unsigned long)saddr->s6_addr32[0];
-	sum += (__force unsigned long)saddr->s6_addr32[1];
-	sum += (__force unsigned long)saddr->s6_addr32[2];
-	sum += (__force unsigned long)saddr->s6_addr32[3];
+	sum += (__force xlen_t)saddr->s6_addr32[0];
+	sum += (__force xlen_t)saddr->s6_addr32[1];
+	sum += (__force xlen_t)saddr->s6_addr32[2];
+	sum += (__force xlen_t)saddr->s6_addr32[3];
 
-	sum += (__force unsigned long)daddr->s6_addr32[0];
-	sum += (__force unsigned long)daddr->s6_addr32[1];
-	sum += (__force unsigned long)daddr->s6_addr32[2];
-	sum += (__force unsigned long)daddr->s6_addr32[3];
+	sum += (__force xlen_t)daddr->s6_addr32[0];
+	sum += (__force xlen_t)daddr->s6_addr32[1];
+	sum += (__force xlen_t)daddr->s6_addr32[2];
+	sum += (__force xlen_t)daddr->s6_addr32[3];
 
 	ulen = (__force unsigned int)htonl((unsigned int)len);
 	sum += ulen;
@@ -46,7 +46,7 @@ __sum16 csum_ipv6_magic(const struct in6_addr *saddr,
 	 */
 	if (IS_ENABLED(CONFIG_RISCV_ISA_ZBB) &&
 	    IS_ENABLED(CONFIG_RISCV_ALTERNATIVE)) {
-		unsigned long fold_temp;
+		xlen_t fold_temp;
 
 		/*
 		 * Zbb is likely available when the kernel is compiled with Zbb
@@ -85,12 +85,12 @@ EXPORT_SYMBOL(csum_ipv6_magic);
 #define OFFSET_MASK 7
 #endif
 
-static inline __no_sanitize_address unsigned long
-do_csum_common(const unsigned long *ptr, const unsigned long *end,
-	       unsigned long data)
+static inline __no_sanitize_address xlen_t
+do_csum_common(const xlen_t *ptr, const xlen_t *end,
+	       xlen_t data)
 {
 	unsigned int shift;
-	unsigned long csum = 0, carry = 0;
+	xlen_t csum = 0, carry = 0;
 
 	/*
 	 * Do 32-bit reads on RV32 and 64-bit reads otherwise. This should be
@@ -130,8 +130,8 @@ static inline __no_sanitize_address unsigned int
 do_csum_with_alignment(const unsigned char *buff, int len)
 {
 	unsigned int offset, shift;
-	unsigned long csum, data;
-	const unsigned long *ptr, *end;
+	xlen_t csum, data;
+	const xlen_t *ptr, *end;
 
 	/*
 	 * Align address to closest word (double word on rv64) that comes before
@@ -140,7 +140,7 @@ do_csum_with_alignment(const unsigned char *buff, int len)
 	 */
 	offset = (unsigned long)buff & OFFSET_MASK;
 	kasan_check_read(buff, len);
-	ptr = (const unsigned long *)(buff - offset);
+	ptr = (const xlen_t *)(buff - offset);
 
 	/*
 	 * Clear the most significant bytes that were over-read if buff was not
@@ -153,7 +153,7 @@ do_csum_with_alignment(const unsigned char *buff, int len)
 #else
 	data = (data << shift) >> shift;
 #endif
-	end = (const unsigned long *)(buff + len);
+	end = (const xlen_t *)(buff + len);
 	csum = do_csum_common(ptr, end, data);
 
 #ifdef CC_HAS_ASM_GOTO_TIED_OUTPUT
@@ -163,7 +163,7 @@ do_csum_with_alignment(const unsigned char *buff, int len)
 	 */
 	if (IS_ENABLED(CONFIG_RISCV_ISA_ZBB) &&
 	    IS_ENABLED(CONFIG_RISCV_ALTERNATIVE)) {
-		unsigned long fold_temp;
+		xlen_t fold_temp;
 
 		/*
 		 * Zbb is likely available when the kernel is compiled with Zbb
@@ -233,15 +233,15 @@ do_csum_with_alignment(const unsigned char *buff, int len)
 static inline __no_sanitize_address unsigned int
 do_csum_no_alignment(const unsigned char *buff, int len)
 {
-	unsigned long csum, data;
-	const unsigned long *ptr, *end;
+	xlen_t csum, data;
+	const xlen_t *ptr, *end;
 
-	ptr = (const unsigned long *)(buff);
+	ptr = (const xlen_t *)(buff);
 	data = *(ptr++);
 
 	kasan_check_read(buff, len);
 
-	end = (const unsigned long *)(buff + len);
+	end = (const xlen_t *)(buff + len);
 	csum = do_csum_common(ptr, end, data);
 
 	/*
@@ -250,7 +250,7 @@ do_csum_no_alignment(const unsigned char *buff, int len)
 	 */
 	if (IS_ENABLED(CONFIG_RISCV_ISA_ZBB) &&
 	    IS_ENABLED(CONFIG_RISCV_ALTERNATIVE)) {
-		unsigned long fold_temp;
+		xlen_t fold_temp;
 
 		/*
 		 * Zbb is likely available when the kernel is compiled with Zbb
-- 
2.40.1


