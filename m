Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80EFC28703C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Oct 2020 09:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729151AbgJHH4C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Oct 2020 03:56:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729150AbgJHH4B (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Oct 2020 03:56:01 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6103DC0613D5;
        Thu,  8 Oct 2020 00:56:01 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id u24so3611565pgi.1;
        Thu, 08 Oct 2020 00:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=wyHDR8+dAOff2WNierEioGfQpDDNjWjuRwXu10QUWLc=;
        b=pTfNjEfzS3Q307/ptExM2s6iDRruR5t8Ppiks1cBPWbNNNJ+wLhGJhIHtyBSoLbZyc
         nnEpxQuCBkK4/o7AxLI8yK+O4CVJa2uSf1H5QEyimWnyHcKOVsg4WyINDJMcGruyWuyI
         1JumNEJoWBljLOBAca3mmBfh3E8NCnqGE6jzHfvvuB0e9E7rLVRW0AMRNjRmLIgrtrMt
         o8kIXd14KlOXgHpPkOtiJurT73i1+QwYVa4SI8u/CVqxYyeAeqUzXQEzlJmxs23P8ktg
         aP8I/MWsbb5gBEd2OOLnANzGk50mRv8CLQgSyNyKOH1FUETYZZU3WpsLlDrSmW4UOGuY
         bbEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=wyHDR8+dAOff2WNierEioGfQpDDNjWjuRwXu10QUWLc=;
        b=ZjmoSNNJmyjNeA8fAQBLP7HXYxQrosRy7mamG587eGpzedN7ZbRFBrBHc22a2SIHzG
         RnHsIBU88EQzZKuGtDKGLzsNxcXRWmqP5rse2EyPmRTOn7pv7Fma46HBWRnmkzm7M8XJ
         F4x0pNmz8RPG27KDuXgYM3CjmswUYLyTgVCF02lFIVO7znF7mc/FVUlRDEXbLPly4KpR
         5UuDsntjMQTUyGwW/CFL7tbNfRzf7ZdR3mHy9OAOx2090ENkAYTb8U03Ca2/iQdK3m5i
         TCeui0I3Mid8/XvMSo16Xq2pZj/T85Z5Q76n2Q47XknHi4E1EM8thUnN9xzaIHgEHw2+
         5kIw==
X-Gm-Message-State: AOAM533hoRvGa1OVP0j0DBnNJtiKhcHGziENMpzTiP78Omp5+ZywEjGm
        LYOqiHc5t0G0htUrhWoMWuw=
X-Google-Smtp-Source: ABdhPJyB9HushHJdLOcJQrYX8ceiZBF8Sc+4Il+mcDTyBSIrDeG0ruPy5odkRh7QQaPgij1A/BGp8w==
X-Received: by 2002:a63:4f5e:: with SMTP id p30mr6175167pgl.6.1602143760930;
        Thu, 08 Oct 2020 00:56:00 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.61])
        by smtp.gmail.com with ESMTPSA id k206sm6777106pfd.126.2020.10.08.00.55.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2020 00:56:00 -0700 (PDT)
From:   yulei.kernel@gmail.com
X-Google-Original-From: yuleixzhang@tencent.com
To:     akpm@linux-foundation.org, naoya.horiguchi@nec.com,
        viro@zeniv.linux.org.uk, pbonzini@redhat.com
Cc:     linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, xiaoguangrong.eric@gmail.com,
        kernellwp@gmail.com, lihaiwei.kernel@gmail.com,
        Yulei Zhang <yuleixzhang@tencent.com>,
        Haiwei Li <lihaiwei@tencent.com>
Subject: [PATCH 31/35] dmem: introduce mce handler
Date:   Thu,  8 Oct 2020 15:54:21 +0800
Message-Id: <6ac6ec10681d935664d6d065b8464b1a7755b674.1602093760.git.yuleixzhang@tencent.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1602093760.git.yuleixzhang@tencent.com>
References: <cover.1602093760.git.yuleixzhang@tencent.com>
In-Reply-To: <cover.1602093760.git.yuleixzhang@tencent.com>
References: <cover.1602093760.git.yuleixzhang@tencent.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Yulei Zhang <yuleixzhang@tencent.com>

dmem handle the mce if the pfn belongs to dmem when mce occurs.
1. check whether the pfn is handled by dmem. return if true.
2. mark the pfn in a new error bitmap defined in page.
3. a series of mechanism to ensure that the mce pfn is not allocated.

Signed-off-by: Haiwei Li <lihaiwei@tencent.com>
Signed-off-by: Yulei Zhang <yuleixzhang@tencent.com>
---
 include/linux/dmem.h        |   6 +++
 include/trace/events/dmem.h |  17 ++++++
 mm/dmem.c                   | 103 +++++++++++++++++++++++++-----------
 mm/memory-failure.c         |   6 +++
 4 files changed, 102 insertions(+), 30 deletions(-)

diff --git a/include/linux/dmem.h b/include/linux/dmem.h
index 59d3ef14fe42..cd17a91a7264 100644
--- a/include/linux/dmem.h
+++ b/include/linux/dmem.h
@@ -21,6 +21,8 @@ dmem_alloc_pages_vma(struct vm_area_struct *vma, unsigned long addr,
 void dmem_free_pages(phys_addr_t addr, unsigned int dpages_nr);
 bool is_dmem_pfn(unsigned long pfn);
 #define dmem_free_page(addr)	dmem_free_pages(addr, 1)
+
+bool dmem_memory_failure(unsigned long pfn, int flags);
 #else
 static inline int dmem_reserve_init(void)
 {
@@ -32,5 +34,9 @@ static inline bool is_dmem_pfn(unsigned long pfn)
 	return 0;
 }
 
+static inline bool dmem_memory_failure(unsigned long pfn, int flags)
+{
+	return false;
+}
 #endif
 #endif	/* _LINUX_DMEM_H */
diff --git a/include/trace/events/dmem.h b/include/trace/events/dmem.h
index 10d1b90a7783..f8eeb3c63b14 100644
--- a/include/trace/events/dmem.h
+++ b/include/trace/events/dmem.h
@@ -62,6 +62,23 @@ TRACE_EVENT(dmem_free_pages,
 	TP_printk("addr %#lx dpages_nr %d", (unsigned long)__entry->addr,
 		  __entry->dpages_nr)
 );
+
+TRACE_EVENT(dmem_memory_failure,
+	TP_PROTO(unsigned long pfn, bool used),
+	TP_ARGS(pfn, used),
+
+	TP_STRUCT__entry(
+		__field(unsigned long, pfn)
+		__field(bool, used)
+	),
+
+	TP_fast_assign(
+		__entry->pfn = pfn;
+		__entry->used = used;
+	),
+
+	TP_printk("pfn=%#lx used=%d", __entry->pfn, __entry->used)
+);
 #endif
 
 /* This part must be outside protection */
diff --git a/mm/dmem.c b/mm/dmem.c
index 50cdff98675b..16438dbed3f5 100644
--- a/mm/dmem.c
+++ b/mm/dmem.c
@@ -431,6 +431,41 @@ static void __init dmem_uinit(void)
 	dmem_pool.registered_pages = 0;
 }
 
+/* set or clear corresponding bit on allocation bitmap based on error bitmap */
+static unsigned long dregion_alloc_bitmap_set_clear(struct dmem_region *dregion,
+						    bool set)
+{
+	unsigned long pos_pfn, pos_offset;
+	unsigned long valid_pages, mce_dpages = 0;
+	phys_addr_t dpage, reserved_start_pfn;
+
+	reserved_start_pfn = __phys_to_pfn(dregion->reserved_start_addr);
+
+	valid_pages = dpage_to_pfn(dregion->dpage_end_pfn) - reserved_start_pfn;
+	pos_offset = dpage_to_pfn(dregion->dpage_start_pfn)
+		- reserved_start_pfn;
+try_set:
+	pos_pfn = find_next_bit(dregion->error_bitmap, valid_pages, pos_offset);
+
+	if (pos_pfn >= valid_pages)
+		return mce_dpages;
+	mce_dpages++;
+	dpage = pfn_to_dpage(pos_pfn + reserved_start_pfn);
+	if (set)
+		WARN_ON(__test_and_set_bit(dpage - dregion->dpage_start_pfn,
+					   dregion->bitmap));
+	else
+		WARN_ON(!__test_and_clear_bit(dpage - dregion->dpage_start_pfn,
+					      dregion->bitmap));
+	pos_offset = dpage_to_pfn(dpage + 1) - reserved_start_pfn;
+	goto try_set;
+}
+
+static unsigned long dmem_region_mark_mce_dpages(struct dmem_region *dregion)
+{
+	return dregion_alloc_bitmap_set_clear(dregion, true);
+}
+
 static int __init dmem_region_init(struct dmem_region *dregion)
 {
 	unsigned long *bitmap, nr_pages;
@@ -514,6 +549,8 @@ static int dmem_alloc_region_init(struct dmem_region *dregion,
 	dregion->dpage_start_pfn = start;
 	dregion->dpage_end_pfn = end;
 
+	*dpages -= dmem_region_mark_mce_dpages(dregion);
+
 	dmem_pool.unaligned_pages += __phys_to_pfn((dpage_to_phys(start)
 		- dregion->reserved_start_addr));
 	dmem_pool.unaligned_pages += __phys_to_pfn(dregion->reserved_end_addr
@@ -558,36 +595,6 @@ dmem_alloc_bitmap_clear(struct dmem_region *dregion, phys_addr_t dpage,
 	return err_num;
 }
 
-/* set or clear corresponding bit on allocation bitmap based on error bitmap */
-static unsigned long dregion_alloc_bitmap_set_clear(struct dmem_region *dregion,
-						    bool set)
-{
-	unsigned long pos_pfn, pos_offset;
-	unsigned long valid_pages, mce_dpages = 0;
-	phys_addr_t dpage, reserved_start_pfn;
-
-	reserved_start_pfn = __phys_to_pfn(dregion->reserved_start_addr);
-
-	valid_pages = dpage_to_pfn(dregion->dpage_end_pfn) - reserved_start_pfn;
-	pos_offset = dpage_to_pfn(dregion->dpage_start_pfn)
-		- reserved_start_pfn;
-try_set:
-	pos_pfn = find_next_bit(dregion->error_bitmap, valid_pages, pos_offset);
-
-	if (pos_pfn >= valid_pages)
-		return mce_dpages;
-	mce_dpages++;
-	dpage = pfn_to_dpage(pos_pfn + reserved_start_pfn);
-	if (set)
-		WARN_ON(__test_and_set_bit(dpage - dregion->dpage_start_pfn,
-					   dregion->bitmap));
-	else
-		WARN_ON(!__test_and_clear_bit(dpage - dregion->dpage_start_pfn,
-					      dregion->bitmap));
-	pos_offset = dpage_to_pfn(dpage + 1) - reserved_start_pfn;
-	goto try_set;
-}
-
 static void dmem_uinit_check_alloc_bitmap(struct dmem_region *dregion)
 {
 	unsigned long dpages, size;
@@ -989,6 +996,42 @@ void dmem_free_pages(phys_addr_t addr, unsigned int dpages_nr)
 }
 EXPORT_SYMBOL(dmem_free_pages);
 
+bool dmem_memory_failure(unsigned long pfn, int flags)
+{
+	struct dmem_region *dregion;
+	struct dmem_node *pdnode = NULL;
+	u64 pos;
+	phys_addr_t addr = __pfn_to_phys(pfn);
+	bool used = false;
+
+	dregion = find_dmem_region(addr, &pdnode);
+	if (!dregion)
+		return false;
+
+	WARN_ON(!pdnode || !dregion->error_bitmap);
+
+	mutex_lock(&dmem_pool.lock);
+	pos = pfn - __phys_to_pfn(dregion->reserved_start_addr);
+	if (__test_and_set_bit(pos, dregion->error_bitmap))
+		goto out;
+
+	if (!dregion->bitmap || pfn < dpage_to_pfn(dregion->dpage_start_pfn) ||
+	    pfn >= dpage_to_pfn(dregion->dpage_end_pfn))
+		goto out;
+
+	pos = phys_to_dpage(addr) - dregion->dpage_start_pfn;
+	if (__test_and_set_bit(pos, dregion->bitmap)) {
+		used = true;
+	} else {
+		pr_info("MCE: free dpage, mark %#lx disabled in dmem\n", pfn);
+		dnode_count_free_dpages(pdnode, -1);
+	}
+out:
+	trace_dmem_memory_failure(pfn, used);
+	mutex_unlock(&dmem_pool.lock);
+	return true;
+}
+
 bool is_dmem_pfn(unsigned long pfn)
 {
 	struct dmem_node *dnode;
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index f1aa6433f404..c613e1ec5995 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -35,6 +35,7 @@
  */
 #include <linux/kernel.h>
 #include <linux/mm.h>
+#include <linux/dmem.h>
 #include <linux/page-flags.h>
 #include <linux/kernel-page-flags.h>
 #include <linux/sched/signal.h>
@@ -1280,6 +1281,11 @@ int memory_failure(unsigned long pfn, int flags)
 	if (!sysctl_memory_failure_recovery)
 		panic("Memory failure on page %lx", pfn);
 
+	if (dmem_memory_failure(pfn, flags)) {
+		pr_info("MCE %#lx: handled by dmem\n", pfn);
+		return 0;
+	}
+
 	p = pfn_to_online_page(pfn);
 	if (!p) {
 		if (pfn_valid(pfn)) {
-- 
2.28.0

