Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86AB82A1FF3
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Nov 2020 18:06:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727239AbgKARFw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 1 Nov 2020 12:05:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:39714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727233AbgKARFt (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 1 Nov 2020 12:05:49 -0500
Received: from aquarius.haifa.ibm.com (nesher1.haifa.il.ibm.com [195.110.40.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0898422242;
        Sun,  1 Nov 2020 17:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604250348;
        bh=BP7DmwJKn81ZIeGVeKy2Y93BUEFg6s///fIAFdqxqhs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jaTEbszp1CuUiJ+yaWla9bTyg/px5q89SxSWFAassJH80NOGLuWEEseD4BDDrsmfa
         EDZ7FlUm2Zw4TDjzYuGnFF8/TcBZD2f+rKYXNrWWj+NWVZCio/El+dWlObCBXmvq0g
         zY/ay84z1xQ7e1YX0J51Ko/cyispsqNnXb/bdmq4=
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
Subject: [PATCH v2 07/13] ia64: make SPARSEMEM default and disable DISCONTIGMEM
Date:   Sun,  1 Nov 2020 19:04:48 +0200
Message-Id: <20201101170454.9567-8-rppt@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201101170454.9567-1-rppt@kernel.org>
References: <20201101170454.9567-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

SPARSEMEM memory model suitable for systems with large holes in their
phyiscal memory layout. With SPARSEMEM_VMEMMAP enabled it provides
pfn_to_page() and page_to_pfn() as fast as FLATMEM.

Make it the default memory model for IA-64 and disable DISCONTIGMEM which
is considered obsolete for quite some time.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/ia64/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
index 83de0273d474..6e67d6110249 100644
--- a/arch/ia64/Kconfig
+++ b/arch/ia64/Kconfig
@@ -288,6 +288,7 @@ config ARCH_SELECT_MEMORY_MODEL
 
 config ARCH_DISCONTIGMEM_ENABLE
 	def_bool y
+	depends on BROKEN
 	help
 	  Say Y to support efficient handling of discontiguous physical memory,
 	  for architectures which are either NUMA (Non-Uniform Memory Access)
@@ -299,12 +300,11 @@ config ARCH_FLATMEM_ENABLE
 
 config ARCH_SPARSEMEM_ENABLE
 	def_bool y
-	depends on ARCH_DISCONTIGMEM_ENABLE
 	select SPARSEMEM_VMEMMAP_ENABLE
 
-config ARCH_DISCONTIGMEM_DEFAULT
+config ARCH_SPARSEMEM_DEFAULT
 	def_bool y
-	depends on ARCH_DISCONTIGMEM_ENABLE
+	depends on ARCH_SPARSEMEM_ENABLE
 
 config NUMA
 	bool "NUMA support"
-- 
2.28.0

