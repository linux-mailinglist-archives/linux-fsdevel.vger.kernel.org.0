Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC9E2D0F4D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Dec 2020 12:37:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727518AbgLGLfs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Dec 2020 06:35:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726820AbgLGLfq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Dec 2020 06:35:46 -0500
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1203C0613D3;
        Mon,  7 Dec 2020 03:35:25 -0800 (PST)
Received: by mail-pj1-x1041.google.com with SMTP id lb18so4650807pjb.5;
        Mon, 07 Dec 2020 03:35:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RqR44fauEeBZpjBAC1kdf97KbTscq65KeJ9aEDRCpGI=;
        b=Rw3amSd3rBlJpXc7dX1ne8f178KphM/6QUoRTeExFUzM83n8/SHLhQ1jf5VnNMZZoq
         WuAjjkZMPHqpQpdQvXvFrk1Lrq3tYST8SBgJNrKuHm5OX6smgd6BEFs4OIMr7YERjyHE
         +l8qRaSkfTcRGuTg4cWZJ7rhUL/vn+7/MfHju29iuvNwlvUzvEEXuWed5lRO12cXlsAx
         XrCYPpBkWM0g4QcxIQmTZCq99AtRHUV0xUPFWj3Jr2NdsV9RrOanCNVSLbsuvivzchZf
         +SeAeVSMNE20dUY9LBSn+wbwDwf7toSjY/933D0g8CyRml2C5K4r/casmfAA+xjS1HuQ
         ICHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RqR44fauEeBZpjBAC1kdf97KbTscq65KeJ9aEDRCpGI=;
        b=GYeU0aeGM94M3BKOhjFYyyKOPLOtl2g+p721sZhD7luQywZ8S3FyP8A9AAMIoxF1/V
         W/8b1zm+RuHsoRfpxEhp5ZVA+DY+M5WmGGnKT7bOhSZKqmlDFzdebNvFVUCckY5rufmW
         o4+VviV+0/HsyVxcyWyFbPZaXXR1S5X4iBPOtdE0n9YJ3bdBMOxepGcMH+OEPz0e/bpf
         +lcnXUW/Tw/idGPz7xN3+6cdFMPl/jkZgFu0YlVS0/u9Altm8ex3aQ270mRy6eyUs58E
         MxXffbvH0J6aXTejm5VcOsdC6EkaAY2tnPfqmWxfhTuMvcRZ9dwD964V+LCBKDvm6tzR
         t1gA==
X-Gm-Message-State: AOAM530moruTCe4XwzR4jVkKr5xbFsF2PoCbHnQS1NwWghXxjY12PP2J
        jMnDNcbbFXyDvdopwx669FbPyk+l0bc=
X-Google-Smtp-Source: ABdhPJyk3zQTpnyvz7bT7T3Uf0mnoGZKCzyksipWfZnA8cr+UkGx6yntGVpICOae5nxRYw96Y20SUg==
X-Received: by 2002:a17:90b:11d5:: with SMTP id gv21mr930902pjb.12.1607340925289;
        Mon, 07 Dec 2020 03:35:25 -0800 (PST)
Received: from localhost.localdomain ([203.205.141.39])
        by smtp.gmail.com with ESMTPSA id d4sm14219822pfo.127.2020.12.07.03.35.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Dec 2020 03:35:24 -0800 (PST)
From:   yulei.kernel@gmail.com
X-Google-Original-From: yuleixzhang@tencent.com
To:     linux-mm@kvack.org, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, naoya.horiguchi@nec.com,
        viro@zeniv.linux.org.uk, pbonzini@redhat.com
Cc:     joao.m.martins@oracle.com, rdunlap@infradead.org,
        sean.j.christopherson@intel.com, xiaoguangrong.eric@gmail.com,
        kernellwp@gmail.com, lihaiwei.kernel@gmail.com,
        Yulei Zhang <yuleixzhang@tencent.com>,
        Haiwei Li <lihaiwei@tencent.com>
Subject: [RFC V2 31/37] dmem: introduce mce handler
Date:   Mon,  7 Dec 2020 19:31:24 +0800
Message-Id: <6a5471107b81ee999f776547f2fccb045967701e.1607332046.git.yuleixzhang@tencent.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1607332046.git.yuleixzhang@tencent.com>
References: <cover.1607332046.git.yuleixzhang@tencent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
 include/trace/events/dmem.h |  17 ++++++++
 mm/dmem.c                   | 103 +++++++++++++++++++++++++++++++-------------
 mm/memory-failure.c         |   6 +++
 4 files changed, 102 insertions(+), 30 deletions(-)

diff --git a/include/linux/dmem.h b/include/linux/dmem.h
index 59d3ef14..cd17a91 100644
--- a/include/linux/dmem.h
+++ b/include/linux/dmem.h
@@ -21,6 +21,8 @@
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
index 10d1b90..f8eeb3c 100644
--- a/include/trace/events/dmem.h
+++ b/include/trace/events/dmem.h
@@ -62,6 +62,23 @@
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
index 50cdff9..16438db 100644
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
@@ -558,36 +595,6 @@ static bool dmem_dpage_is_error(struct dmem_region *dregion, phys_addr_t dpage)
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
index 5d880d4..dda45d2 100644
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
@@ -1323,6 +1324,11 @@ int memory_failure(unsigned long pfn, int flags)
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
1.8.3.1

