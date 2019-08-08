Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2FE6185ADF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2019 08:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731470AbfHHGd2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Aug 2019 02:33:28 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:51379 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725817AbfHHGd1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Aug 2019 02:33:27 -0400
X-Originating-IP: 79.86.19.127
Received: from alex.numericable.fr (127.19.86.79.rev.sfr.net [79.86.19.127])
        (Authenticated sender: alex@ghiti.fr)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 6957F1BF207;
        Thu,  8 Aug 2019 06:33:19 +0000 (UTC)
From:   Alexandre Ghiti <alex@ghiti.fr>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mips@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Alexandre Ghiti <alex@ghiti.fr>
Subject: [PATCH v6 14/14] riscv: Make mmap allocation top-down by default
Date:   Thu,  8 Aug 2019 02:17:56 -0400
Message-Id: <20190808061756.19712-15-alex@ghiti.fr>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190808061756.19712-1-alex@ghiti.fr>
References: <20190808061756.19712-1-alex@ghiti.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In order to avoid wasting user address space by using bottom-up mmap
allocation scheme, prefer top-down scheme when possible.

Before:
root@qemuriscv64:~# cat /proc/self/maps
00010000-00016000 r-xp 00000000 fe:00 6389       /bin/cat.coreutils
00016000-00017000 r--p 00005000 fe:00 6389       /bin/cat.coreutils
00017000-00018000 rw-p 00006000 fe:00 6389       /bin/cat.coreutils
00018000-00039000 rw-p 00000000 00:00 0          [heap]
1555556000-155556d000 r-xp 00000000 fe:00 7193   /lib/ld-2.28.so
155556d000-155556e000 r--p 00016000 fe:00 7193   /lib/ld-2.28.so
155556e000-155556f000 rw-p 00017000 fe:00 7193   /lib/ld-2.28.so
155556f000-1555570000 rw-p 00000000 00:00 0
1555570000-1555572000 r-xp 00000000 00:00 0      [vdso]
1555574000-1555576000 rw-p 00000000 00:00 0
1555576000-1555674000 r-xp 00000000 fe:00 7187   /lib/libc-2.28.so
1555674000-1555678000 r--p 000fd000 fe:00 7187   /lib/libc-2.28.so
1555678000-155567a000 rw-p 00101000 fe:00 7187   /lib/libc-2.28.so
155567a000-15556a0000 rw-p 00000000 00:00 0
3fffb90000-3fffbb1000 rw-p 00000000 00:00 0      [stack]

After:
root@qemuriscv64:~# cat /proc/self/maps
00010000-00016000 r-xp 00000000 fe:00 6389       /bin/cat.coreutils
00016000-00017000 r--p 00005000 fe:00 6389       /bin/cat.coreutils
00017000-00018000 rw-p 00006000 fe:00 6389       /bin/cat.coreutils
2de81000-2dea2000 rw-p 00000000 00:00 0          [heap]
3ff7eb6000-3ff7ed8000 rw-p 00000000 00:00 0
3ff7ed8000-3ff7fd6000 r-xp 00000000 fe:00 7187   /lib/libc-2.28.so
3ff7fd6000-3ff7fda000 r--p 000fd000 fe:00 7187   /lib/libc-2.28.so
3ff7fda000-3ff7fdc000 rw-p 00101000 fe:00 7187   /lib/libc-2.28.so
3ff7fdc000-3ff7fe2000 rw-p 00000000 00:00 0
3ff7fe4000-3ff7fe6000 r-xp 00000000 00:00 0      [vdso]
3ff7fe6000-3ff7ffd000 r-xp 00000000 fe:00 7193   /lib/ld-2.28.so
3ff7ffd000-3ff7ffe000 r--p 00016000 fe:00 7193   /lib/ld-2.28.so
3ff7ffe000-3ff7fff000 rw-p 00017000 fe:00 7193   /lib/ld-2.28.so
3ff7fff000-3ff8000000 rw-p 00000000 00:00 0
3fff888000-3fff8a9000 rw-p 00000000 00:00 0      [stack]

Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
Acked-by: Paul Walmsley <paul.walmsley@sifive.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
---
 arch/riscv/Kconfig | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 59a4727ecd6c..87dc5370becb 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -54,6 +54,18 @@ config RISCV
 	select EDAC_SUPPORT
 	select ARCH_HAS_GIGANTIC_PAGE
 	select ARCH_WANT_HUGE_PMD_SHARE if 64BIT
+	select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT if MMU
+	select HAVE_ARCH_MMAP_RND_BITS
+
+config ARCH_MMAP_RND_BITS_MIN
+	default 18 if 64BIT
+	default 8
+
+# max bits determined by the following formula:
+#  VA_BITS - PAGE_SHIFT - 3
+config ARCH_MMAP_RND_BITS_MAX
+	default 24 if 64BIT # SV39 based
+	default 17
 
 config MMU
 	def_bool y
-- 
2.20.1

