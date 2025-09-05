Return-Path: <linux-fsdevel+bounces-60344-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 403A4B4552A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Sep 2025 12:45:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 500C45C1360
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Sep 2025 10:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 394913054FF;
	Fri,  5 Sep 2025 10:44:11 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5084C2D73BF;
	Fri,  5 Sep 2025 10:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757069050; cv=none; b=YXVNmpp6GO0Sn1cXywvyAYF0FOAqkOO0KY1b3X7ttNiD2yfpD6IOMLNGSKbc72WZfLXg9/a+0bRSi1cVMHfLD1zYflBzS+ixr/i3aSTx9B++oCwmwO3poQWcmIr/3PqG4MRV/CTSZrCHdNWgOrUViE2iSiTJ9YI/QiaBxB1vyCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757069050; c=relaxed/simple;
	bh=YqbyBZQ0acxSzrFmEUVF6yD+M5/GAedLVQC48M2FccI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YZdtmTUa93cWy08IuNapAuoCjfUuto8KpgiDIvAvtUu6kzXqFWRNQTbchSYS+bjvjb/i3RkxI3QQPV1+Z0a36j35A4035cBDSv/Bl0BFEuXbQlIlNfwrJh1Rk+EKF0jXx7a8+O4jOhcJwDXCOaMsPSu+B14+Rfi9W1if6PPhQ1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from ubt.. (unknown [210.73.43.101])
	by APP-01 (Coremail) with SMTP id qwCowABnwaNMvbpoocLNAA--.50311S5;
	Fri, 05 Sep 2025 18:37:02 +0800 (CST)
From: Chunyan Zhang <zhangchunyan@iscas.ac.cn>
To: linux-riscv@lists.infradead.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Andrew Morton <akpm@linux-foundation.org>,
	Deepak Gupta <debug@rivosinc.com>,
	Ved Shanbhogue <ved@rivosinc.com>,
	Peter Xu <peterx@redhat.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Jan Kara <jack@suse.cz>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Wei Xu <weixugc@google.com>,
	David Hildenbrand <david@redhat.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>
Subject: [PATCH v9 3/5] riscv: Add RISC-V Svrsw60t59b extension support
Date: Fri,  5 Sep 2025 18:36:49 +0800
Message-Id: <20250905103651.489197-4-zhangchunyan@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250905103651.489197-1-zhangchunyan@iscas.ac.cn>
References: <20250905103651.489197-1-zhangchunyan@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowABnwaNMvbpoocLNAA--.50311S5
X-Coremail-Antispam: 1UD129KBjvJXoW7ur43JrWfJw1ktrWrXw4fKrg_yoW8tw4Upr
	s5CryrCrWrWwn3uw4ayr95u3y8Xws8Gws8Kw48u34rJrW7ZrWxZw1vy3W7Gw1DZanYqrnY
	gF1Fgr18uw48tF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPCb7Iv0xC_Cr1lb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
	8067AKxVWUWwA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF
	64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcV
	CY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv
	6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c
	02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVW8JVWxJwAm72CE
	4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7
	CjxVAaw2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l
	x2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14
	v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IY
	x2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z2
	80aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI
	43ZEXa7IUnw2-5UUUUU==
X-CM-SenderInfo: x2kd0wxfkx051dq6x2xfdvhtffof0/1tbiCRAQB2i6ooVpyQAAsb

The Svrsw60t59b extension allows to free the PTE reserved bits 60
and 59 for software to use.

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Signed-off-by: Chunyan Zhang <zhangchunyan@iscas.ac.cn>
---
 arch/riscv/Kconfig             | 14 ++++++++++++++
 arch/riscv/include/asm/hwcap.h |  1 +
 arch/riscv/kernel/cpufeature.c |  1 +
 3 files changed, 16 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index a4b233a0659e..d99df67cc7a4 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -862,6 +862,20 @@ config RISCV_ISA_ZICBOP
 
 	  If you don't know what to do here, say Y.
 
+config RISCV_ISA_SVRSW60T59B
+	bool "Svrsw60t59b extension support for using PTE bits 60 and 59"
+	depends on MMU && 64BIT
+	depends on RISCV_ALTERNATIVE
+	default y
+	help
+	  Adds support to dynamically detect the presence of the Svrsw60t59b
+	  extension and enable its usage.
+
+	  The Svrsw60t59b extension allows to free the PTE reserved bits 60
+	  and 59 for software to use.
+
+	  If you don't know what to do here, say Y.
+
 config TOOLCHAIN_NEEDS_EXPLICIT_ZICSR_ZIFENCEI
 	def_bool y
 	# https://sourceware.org/git/?p=binutils-gdb.git;a=commit;h=aed44286efa8ae8717a77d94b51ac3614e2ca6dc
diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
index affd63e11b0a..f98fcb5c17d5 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -106,6 +106,7 @@
 #define RISCV_ISA_EXT_ZAAMO		97
 #define RISCV_ISA_EXT_ZALRSC		98
 #define RISCV_ISA_EXT_ZICBOP		99
+#define RISCV_ISA_EXT_SVRSW60T59B	100
 
 #define RISCV_ISA_EXT_XLINUXENVCFG	127
 
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 743d53415572..de29562096ff 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -540,6 +540,7 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
 	__RISCV_ISA_EXT_DATA(svnapot, RISCV_ISA_EXT_SVNAPOT),
 	__RISCV_ISA_EXT_DATA(svpbmt, RISCV_ISA_EXT_SVPBMT),
 	__RISCV_ISA_EXT_DATA(svvptc, RISCV_ISA_EXT_SVVPTC),
+	__RISCV_ISA_EXT_DATA(svrsw60t59b, RISCV_ISA_EXT_SVRSW60T59B),
 };
 
 const size_t riscv_isa_ext_count = ARRAY_SIZE(riscv_isa_ext);
-- 
2.34.1


