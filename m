Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D2631CC889
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 May 2020 09:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728763AbgEJH5f (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 10 May 2020 03:57:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729315AbgEJH4t (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 10 May 2020 03:56:49 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77316C061A0C;
        Sun, 10 May 2020 00:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=b/AKrpkhJpxezrTGvPZBC9SW3CgmeEDvWHVUmiGEvwM=; b=RiZBp/Ak2ZLcg9uwo2jE3Nh2ez
        V97n/DOnfkc8+Ie1NWYqFH64cE4WCyxAejFjCzsEp/hsFQVYiUy8FcCUirfKh5m9RQhN3PSVL9w4Z
        jxQC0gT6u8dgTp8+bgJerpz7jkl4ped2t6gOgy4CASpQkp5q719RAmhWjVsxRRMnB8jpssNeY6qTr
        rIeeyoFoWk/Vm1JvORmyjbnWcgloAM7yu3lD2mhz+baGeCa0nBxIvKBv67U3j6Uy6Y+porPNPtwFJ
        aNF8/XVfnliVo9bJkR6WLffKlS8HKH04+H8eI9QojENttmOrKt0i1ZOv1Mn6RsNASRs57ZBiw+Yhg
        Uk4ttaPw==;
Received: from [2001:4bb8:180:9d3f:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jXgp6-00018O-FJ; Sun, 10 May 2020 07:56:32 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Roman Zippel <zippel@linux-m68k.org>
Cc:     Jessica Yu <jeyu@kernel.org>, Michal Simek <monstr@monstr.eu>,
        x86@kernel.org, linux-alpha@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-c6x-dev@linux-c6x.org, linux-hexagon@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, openrisc@lists.librecores.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 25/31] arm: rename flush_cache_user_range to flush_icache_user_range
Date:   Sun, 10 May 2020 09:55:04 +0200
Message-Id: <20200510075510.987823-26-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200510075510.987823-1-hch@lst.de>
References: <20200510075510.987823-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

flush_icache_user_range will be the name for a generic primitive.
Move the arm name so that arm already has an implementation.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/arm/include/asm/cacheflush.h | 4 ++--
 arch/arm/kernel/traps.c           | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/include/asm/cacheflush.h b/arch/arm/include/asm/cacheflush.h
index c78e14fcfb5df..2e24e765e6d3a 100644
--- a/arch/arm/include/asm/cacheflush.h
+++ b/arch/arm/include/asm/cacheflush.h
@@ -258,11 +258,11 @@ extern void flush_cache_page(struct vm_area_struct *vma, unsigned long user_addr
 #define flush_cache_dup_mm(mm) flush_cache_mm(mm)
 
 /*
- * flush_cache_user_range is used when we want to ensure that the
+ * flush_icache_user_range is used when we want to ensure that the
  * Harvard caches are synchronised for the user space address range.
  * This is used for the ARM private sys_cacheflush system call.
  */
-#define flush_cache_user_range(s,e)	__cpuc_coherent_user_range(s,e)
+#define flush_icache_user_range(s,e)	__cpuc_coherent_user_range(s,e)
 
 /*
  * Perform necessary cache operations to ensure that data previously
diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
index 1e70e7227f0ff..316a7687f8133 100644
--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -566,7 +566,7 @@ __do_cache_op(unsigned long start, unsigned long end)
 		if (fatal_signal_pending(current))
 			return 0;
 
-		ret = flush_cache_user_range(start, start + chunk);
+		ret = flush_icache_user_range(start, start + chunk);
 		if (ret)
 			return ret;
 
-- 
2.26.2

