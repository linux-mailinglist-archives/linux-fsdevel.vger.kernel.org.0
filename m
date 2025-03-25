Return-Path: <linux-fsdevel+bounces-44963-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B73DA6FB1B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 13:22:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B05BB7A4D0B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 12:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B212525C6E5;
	Tue, 25 Mar 2025 12:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mJnrUfpQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6DB125B69D;
	Tue, 25 Mar 2025 12:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742905082; cv=none; b=FmDS6pGYfOS5MTgEfg/0uzgmTgQTeZO3Kw40D1k+D8RHJi40Dqy6+w6KHVsBSHa86zL43NerZ0sFcMyR1C/fqpRhq35f41Po7l8YlBp8cokxAqO7Pp4R4M9dj1/t+QIxfcgPlfMvEoZwbYKllZlJr0szUFmB+TASY20n9xOTL6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742905082; c=relaxed/simple;
	bh=iWYi5/d3lIOrxHNI1EIVP5k9hUi9+eK2hLYPYcT89jg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hS7fLASXrlg/B6TGaWLkgRSzkCTpRQEafmnj2cUVU5wvkItXf62lH8/hyYbnMKfcxPaZEQLflo8WxR8sE8cf+bjVWi/zwvgn5pJV6Z2qxqQKH0A6MJbm7iVosfx2ctxuG1xDioAuMPq9XjDxT8Y3og3H0T9GD+eK2+eyv6Hwlzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mJnrUfpQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B2FDC4CEF0;
	Tue, 25 Mar 2025 12:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742905081;
	bh=iWYi5/d3lIOrxHNI1EIVP5k9hUi9+eK2hLYPYcT89jg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mJnrUfpQU3tRiz/k25gw4Uqd12Aw8TcM6cjFO/pD8K+3ShkeSS04mnHDe7BpyS9ke
	 O8z/kOa0aXdpl9GLvZpnTK+Xx+g5W6fJjabNS4JH2Wwvd5+2wgVNE54fuiymHoC1wG
	 50KxnfqoOdtuha4aPxrF6rszRIRlwHFNHlIfbWoUlSci7i3a1tzNjs60WJvLsFt2CL
	 k4uREm/BjGR8keu0URF80UT0E0VmN+e0XoVL0J9C2x4l4RFyOLnqNqNi9ALPjHGSGJ
	 JkfPLCYVJWSPzMY2y47OjruYC0XtjptJeJQjpc7rLp5TYbe0YDu+bublV7qn3GnUev
	 yahK8zT/PrMfQ==
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
Subject: [RFC PATCH V3 05/43] rv64ilp32_abi: riscv: crc32: Utilize 64-bit width to improve the performance
Date: Tue, 25 Mar 2025 08:15:46 -0400
Message-Id: <20250325121624.523258-6-guoren@kernel.org>
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
BITS_PER_LONG. Therefore, crc32 algorithm could utilize 64-bit width
to improve the performance.

Signed-off-by: Guo Ren (Alibaba DAMO Academy) <guoren@kernel.org>
---
 arch/riscv/lib/crc32-riscv.c | 35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/arch/riscv/lib/crc32-riscv.c b/arch/riscv/lib/crc32-riscv.c
index 53d56ab422c7..68dfb0565696 100644
--- a/arch/riscv/lib/crc32-riscv.c
+++ b/arch/riscv/lib/crc32-riscv.c
@@ -8,6 +8,7 @@
 #include <asm/hwcap.h>
 #include <asm/alternative-macros.h>
 #include <asm/byteorder.h>
+#include <asm/csr.h>
 
 #include <linux/types.h>
 #include <linux/minmax.h>
@@ -59,12 +60,12 @@
  */
 # define CRC32_POLY_QT_BE	0x04d101df481b4e5a
 
-static inline u64 crc32_le_prep(u32 crc, unsigned long const *ptr)
+static inline u64 crc32_le_prep(u32 crc, u64 const *ptr)
 {
 	return (u64)crc ^ (__force u64)__cpu_to_le64(*ptr);
 }
 
-static inline u32 crc32_le_zbc(unsigned long s, u32 poly, unsigned long poly_qt)
+static inline u32 crc32_le_zbc(u64 s, u32 poly, u64 poly_qt)
 {
 	u32 crc;
 
@@ -85,7 +86,7 @@ static inline u32 crc32_le_zbc(unsigned long s, u32 poly, unsigned long poly_qt)
 	return crc;
 }
 
-static inline u64 crc32_be_prep(u32 crc, unsigned long const *ptr)
+static inline u64 crc32_be_prep(u32 crc, u64 const *ptr)
 {
 	return ((u64)crc << 32) ^ (__force u64)__cpu_to_be64(*ptr);
 }
@@ -131,7 +132,7 @@ static inline u32 crc32_be_prep(u32 crc, unsigned long const *ptr)
 # error "Unexpected __riscv_xlen"
 #endif
 
-static inline u32 crc32_be_zbc(unsigned long s)
+static inline u32 crc32_be_zbc(xlen_t s)
 {
 	u32 crc;
 
@@ -156,16 +157,16 @@ typedef u32 (*fallback)(u32 crc, unsigned char const *p, size_t len);
 
 static inline u32 crc32_le_unaligned(u32 crc, unsigned char const *p,
 				     size_t len, u32 poly,
-				     unsigned long poly_qt)
+				     xlen_t poly_qt)
 {
 	size_t bits = len * 8;
-	unsigned long s = 0;
+	xlen_t s = 0;
 	u32 crc_low = 0;
 
 	for (int i = 0; i < len; i++)
-		s = ((unsigned long)*p++ << (__riscv_xlen - 8)) | (s >> 8);
+		s = ((xlen_t)*p++ << (__riscv_xlen - 8)) | (s >> 8);
 
-	s ^= (unsigned long)crc << (__riscv_xlen - bits);
+	s ^= (xlen_t)crc << (__riscv_xlen - bits);
 	if (__riscv_xlen == 32 || len < sizeof(u32))
 		crc_low = crc >> bits;
 
@@ -177,12 +178,12 @@ static inline u32 crc32_le_unaligned(u32 crc, unsigned char const *p,
 
 static inline u32 __pure crc32_le_generic(u32 crc, unsigned char const *p,
 					  size_t len, u32 poly,
-					  unsigned long poly_qt,
+					  xlen_t poly_qt,
 					  fallback crc_fb)
 {
 	size_t offset, head_len, tail_len;
-	unsigned long const *p_ul;
-	unsigned long s;
+	xlen_t const *p_ul;
+	xlen_t s;
 
 	asm goto(ALTERNATIVE("j %l[legacy]", "nop", 0,
 			     RISCV_ISA_EXT_ZBC, 1)
@@ -199,7 +200,7 @@ static inline u32 __pure crc32_le_generic(u32 crc, unsigned char const *p,
 
 	tail_len = len & OFFSET_MASK;
 	len = len >> STEP_ORDER;
-	p_ul = (unsigned long const *)p;
+	p_ul = (xlen_t const *)p;
 
 	for (int i = 0; i < len; i++) {
 		s = crc32_le_prep(crc, p_ul);
@@ -236,7 +237,7 @@ static inline u32 crc32_be_unaligned(u32 crc, unsigned char const *p,
 				     size_t len)
 {
 	size_t bits = len * 8;
-	unsigned long s = 0;
+	xlen_t s = 0;
 	u32 crc_low = 0;
 
 	s = 0;
@@ -247,7 +248,7 @@ static inline u32 crc32_be_unaligned(u32 crc, unsigned char const *p,
 		s ^= crc >> (32 - bits);
 		crc_low = crc << bits;
 	} else {
-		s ^= (unsigned long)crc << (bits - 32);
+		s ^= (xlen_t)crc << (bits - 32);
 	}
 
 	crc = crc32_be_zbc(s);
@@ -259,8 +260,8 @@ static inline u32 crc32_be_unaligned(u32 crc, unsigned char const *p,
 u32 __pure crc32_be_arch(u32 crc, const u8 *p, size_t len)
 {
 	size_t offset, head_len, tail_len;
-	unsigned long const *p_ul;
-	unsigned long s;
+	xlen_t const *p_ul;
+	xlen_t s;
 
 	asm goto(ALTERNATIVE("j %l[legacy]", "nop", 0,
 			     RISCV_ISA_EXT_ZBC, 1)
@@ -277,7 +278,7 @@ u32 __pure crc32_be_arch(u32 crc, const u8 *p, size_t len)
 
 	tail_len = len & OFFSET_MASK;
 	len = len >> STEP_ORDER;
-	p_ul = (unsigned long const *)p;
+	p_ul = (xlen_t const *)p;
 
 	for (int i = 0; i < len; i++) {
 		s = crc32_be_prep(crc, p_ul);
-- 
2.40.1


