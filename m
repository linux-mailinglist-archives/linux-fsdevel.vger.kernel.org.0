Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8813929AADC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Oct 2020 12:31:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410409AbgJ0Lb1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Oct 2020 07:31:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:46582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1737274AbgJ0LbV (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Oct 2020 07:31:21 -0400
Received: from aquarius.haifa.ibm.com (nesher1.haifa.il.ibm.com [195.110.40.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB89C222EA;
        Tue, 27 Oct 2020 11:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603798281;
        bh=vmfZroUJkM1m/TwoHTzOGMJv9COTYCqEs/vywYSaGqw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b99+t/zxGqKiY0mVd3nJ3Tgx7pRC8vULcERZWWim4VU/p2KOdYSgzDcp37EYbEZ5P
         yhNXHW5NtywekjpZmFjC59aCK4DAfJMCVRblemDs9VsDADb3t796dHIC0QTog4K72o
         7yMQbMVOPOhuXQSLboUbgAIZVy6+GCPxbtTOy5YU=
From:   Mike Rapoport <rppt@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Matt Turner <mattst88@gmail.com>, Meelis Roos <mroos@linux.ee>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Russell King <linux@armlinux.org.uk>,
        Tony Luck <tony.luck@intel.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Will Deacon <will@kernel.org>, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mm@kvack.org, linux-snps-arc@lists.infradead.org
Subject: [PATCH 11/13] m68k/mm: make node data and node setup depend on CONFIG_DISCONTIGMEM
Date:   Tue, 27 Oct 2020 13:29:53 +0200
Message-Id: <20201027112955.14157-12-rppt@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201027112955.14157-1-rppt@kernel.org>
References: <20201027112955.14157-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

The pg_data_t node structures and their initialization currently depends on
!CONFIG_SINGLE_MEMORY_CHUNK. Since they are required only for DISCONTIGMEM
make this dependency explicit and replace usage of
CONFIG_SINGLE_MEMORY_CHUNK with CONFIG_DISCONTIGMEM where appropriate.

The CONFIG_SINGLE_MEMORY_CHUNK was implicitly disabled on the ColdFire MMU
variant, although it always presumed a single memory bank. As there is no
actual need for DISCONTIGMEM in this case, make sure that ColdFire MMU
systems set CONFIG_SINGLE_MEMORY_CHUNK to 'y'.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/m68k/Kconfig.cpu           | 6 +++---
 arch/m68k/include/asm/page_mm.h | 2 +-
 arch/m68k/mm/init.c             | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/m68k/Kconfig.cpu b/arch/m68k/Kconfig.cpu
index 694c4fca9f5d..3af0fca03803 100644
--- a/arch/m68k/Kconfig.cpu
+++ b/arch/m68k/Kconfig.cpu
@@ -20,6 +20,7 @@ choice
 
 config M68KCLASSIC
 	bool "Classic M68K CPU family support"
+	select NEED_MULTIPLE_NODES if DISCONTIGMEM
 
 config COLDFIRE
 	bool "Coldfire CPU family support"
@@ -373,8 +374,7 @@ config RMW_INSNS
 config SINGLE_MEMORY_CHUNK
 	bool "Use one physical chunk of memory only" if ADVANCED && !SUN3
 	depends on MMU
-	default y if SUN3
-	select NEED_MULTIPLE_NODES
+	default y if SUN3 || MMU_COLDFIRE
 	help
 	  Ignore all but the first contiguous chunk of physical memory for VM
 	  purposes.  This will save a few bytes kernel size and may speed up
@@ -406,7 +406,7 @@ config M68K_L2_CACHE
 config NODES_SHIFT
 	int
 	default "3"
-	depends on !SINGLE_MEMORY_CHUNK
+	depends on DISCONTIGMEM
 
 config CPU_HAS_NO_BITFIELDS
 	bool
diff --git a/arch/m68k/include/asm/page_mm.h b/arch/m68k/include/asm/page_mm.h
index e6b75992192b..0e794051d3bb 100644
--- a/arch/m68k/include/asm/page_mm.h
+++ b/arch/m68k/include/asm/page_mm.h
@@ -126,7 +126,7 @@ static inline void *__va(unsigned long x)
 
 extern int m68k_virt_to_node_shift;
 
-#ifdef CONFIG_SINGLE_MEMORY_CHUNK
+#ifndef CONFIG_DISCONTIGMEM
 #define __virt_to_node(addr)	(&pg_data_map[0])
 #else
 extern struct pglist_data *pg_data_table[];
diff --git a/arch/m68k/mm/init.c b/arch/m68k/mm/init.c
index 53040857a9ed..4b46ceace3d3 100644
--- a/arch/m68k/mm/init.c
+++ b/arch/m68k/mm/init.c
@@ -47,14 +47,14 @@ EXPORT_SYMBOL(pg_data_map);
 
 int m68k_virt_to_node_shift;
 
-#ifndef CONFIG_SINGLE_MEMORY_CHUNK
+#ifdef CONFIG_DISCONTIGMEM
 pg_data_t *pg_data_table[65];
 EXPORT_SYMBOL(pg_data_table);
 #endif
 
 void __init m68k_setup_node(int node)
 {
-#ifndef CONFIG_SINGLE_MEMORY_CHUNK
+#ifdef CONFIG_DISCONTIGMEM
 	struct m68k_mem_info *info = m68k_memory + node;
 	int i, end;
 
-- 
2.28.0

