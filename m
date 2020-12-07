Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9A002D0F55
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Dec 2020 12:37:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727612AbgLGLfz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Dec 2020 06:35:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727566AbgLGLfy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Dec 2020 06:35:54 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E04AC0613D1;
        Mon,  7 Dec 2020 03:35:39 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id t8so9610762pfg.8;
        Mon, 07 Dec 2020 03:35:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZbMU89dV/uL3+8OuWgp1O7gQ5pASlyw5FoQtpms6guk=;
        b=hJ834cKhEjJVNZZ3t967QVJ2E8W9K6mc6jhd3ZkKT1XWsW3Git/iP8YVfRmQyt8sIr
         CjbTX37cTnlCLLuno8hPGkGDUmoZ1BtiEYJXX1b6z90vTqSR1KA8+8rId4N/7TnizniZ
         enCmfy4akOOpsgOGcbpB931EuqRfgpj+h5gaDLkFjyYbBZ9e/Dda80jgLj0M5Cqc6r1u
         hwxdv353KdyhkQxcMeQ8uHs9JbJAVgoln+7QovXo3A8RUP62nOLFJKHy2/oiSVfloI6E
         22pFGJvSpZrxXWrD0eCtE1IJmN+S1qu2/O18aqpz1ZdL8sqSQQUdbZk/09SaW4dU8ASj
         9dEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZbMU89dV/uL3+8OuWgp1O7gQ5pASlyw5FoQtpms6guk=;
        b=TuQKFpf29+zpYdMBBWHrMu3N8QBrwJjB42Hc1f6hP+EcGHRS5ZMmvda/c/wW4Fs6Kh
         fx+gRJmtD63gFrOFpaDzx7uB3S80/qkdPH5Fl4CZOKFfQEW+a7fMrWqyXdp3cKHNX2x2
         acjpQwOVa3ZpU81iiMlCMBKGE2/Lf4SCAmIsaoVd4X4f7Vey+5SvvZcUQMh9IITFSuGc
         i1Acew3F0hHpltS8yCVe5tKl8YlzZbLidunmDjn807Sc3gxihmHRZp6Dsg1cqbmoWjhg
         ZZVTKaoo/1ekRGFn1SDSP+TjXn6RPlyGVKRzqhILhox3qQgFurVKYtrSnr6/LP61EOVX
         WZjw==
X-Gm-Message-State: AOAM530QiFsVAvww30mbEOke0nagdq8yoKsRlJAKsJsb7GeNe+Gt7tp6
        QWypeEja9Zr+5wyX6qoTq/drpNPkUvU=
X-Google-Smtp-Source: ABdhPJytxl0Aj3b5REF0I4awOHOqfBomUWPVwgLlHgKjMQw2BuQ5IeQCZdBfDO1sTV2IIFA1EZ86zQ==
X-Received: by 2002:a63:4905:: with SMTP id w5mr17945642pga.124.1607340938617;
        Mon, 07 Dec 2020 03:35:38 -0800 (PST)
Received: from localhost.localdomain ([203.205.141.39])
        by smtp.gmail.com with ESMTPSA id d4sm14219822pfo.127.2020.12.07.03.35.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Dec 2020 03:35:38 -0800 (PST)
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
        Chen Zhuo <sagazchen@tencent.com>
Subject: [RFC V2 35/37] mm, dmem: introduce dregion->memmap for dmem
Date:   Mon,  7 Dec 2020 19:31:28 +0800
Message-Id: <db966b831955200a63643dcbbb71ffc5ae65a642.1607332046.git.yuleixzhang@tencent.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1607332046.git.yuleixzhang@tencent.com>
References: <cover.1607332046.git.yuleixzhang@tencent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Yulei Zhang <yuleixzhang@tencent.com>

Append 'memmap' into struct dmem_region, mapping each page of dmem with
struct dmempage.

Currently there is just one member '_refcount' in struct dmempage to
reflect the number of all modules which occupied the dmem page.

Modules which allocates the dmem page from dmempool will make first
reference and set _refcount to 1.

Modules which try to free the dmem page to dmempool will decrease 1
at _refcount and free it if _refcount is tested as zero after decrease.

At each time module A passes dmem page to module B, module B should call
get_dmem_pfn() to increase _refcount for dmem page before making use of it
to avoid referencing a dmem page which is occasionally freeed by any other
module in parallel. Vice versa after finishing usage of that dmem page
need call put_dmem_pfn() to decrease the _refcount.

Signed-off-by: Chen Zhuo <sagazchen@tencent.com>
Signed-off-by: Yulei Zhang <yuleixzhang@tencent.com>
---
 include/linux/dmem.h |   5 ++
 mm/dmem.c            | 147 ++++++++++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 139 insertions(+), 13 deletions(-)

diff --git a/include/linux/dmem.h b/include/linux/dmem.h
index fe0b270..8aaa80b 100644
--- a/include/linux/dmem.h
+++ b/include/linux/dmem.h
@@ -22,6 +22,9 @@
 bool is_dmem_pfn(unsigned long pfn);
 #define dmem_free_page(addr)	dmem_free_pages(addr, 1)
 
+void get_dmem_pfn(unsigned long pfn);
+#define put_dmem_pfn(pfn)	dmem_free_page(PFN_PHYS(pfn))
+
 bool dmem_memory_failure(unsigned long pfn, int flags);
 
 struct dmem_mce_notifier_info {
@@ -45,5 +48,7 @@ static inline bool dmem_memory_failure(unsigned long pfn, int flags)
 {
 	return false;
 }
+void get_dmem_pfn(unsigned long pfn) {}
+void put_dmem_pfn(unsigned long pfn) {}
 #endif
 #endif	/* _LINUX_DMEM_H */
diff --git a/mm/dmem.c b/mm/dmem.c
index dd81b24..776dbf2 100644
--- a/mm/dmem.c
+++ b/mm/dmem.c
@@ -47,6 +47,7 @@ struct dmem_region {
 
 	unsigned long static_error_bitmap;
 	unsigned long *error_bitmap;
+	void *memmap;
 };
 
 /*
@@ -91,6 +92,10 @@ struct dmem_pool {
 	struct dmem_node nodes[MAX_NUMNODES];
 };
 
+struct dmempage {
+	atomic_t _refcount;
+};
+
 static struct dmem_pool dmem_pool = {
 	.lock = __MUTEX_INITIALIZER(dmem_pool.lock),
 	.mce_notifier_chain = RAW_NOTIFIER_INIT(dmem_pool.mce_notifier_chain),
@@ -123,6 +128,40 @@ struct dmem_pool {
 #define for_each_dmem_region(_dnode, _dregion)				\
 	list_for_each_entry(_dregion, &(_dnode)->regions, node)
 
+#define pfn_to_dmempage(_pfn, _dregion)					\
+	((struct dmempage *)(_dregion)->memmap +			\
+	pfn_to_dpage(_pfn) - (_dregion)->dpage_start_pfn)
+
+#define dmempage_to_dpage(_dmempage, _dregion)				\
+	((_dmempage) - (struct dmempage *)(_dregion)->memmap +		\
+	(_dregion)->dpage_start_pfn)
+
+static inline int dmempage_count(struct dmempage *dmempage)
+{
+	return atomic_read(&dmempage->_refcount);
+}
+
+static inline void set_dmempage_count(struct dmempage *dmempage, int v)
+{
+	atomic_set(&dmempage->_refcount, v);
+}
+
+static inline void dmempage_ref_inc(struct dmempage *dmempage)
+{
+	atomic_inc(&dmempage->_refcount);
+}
+
+static inline int dmempage_ref_dec_and_test(struct dmempage *dmempage)
+{
+	return atomic_dec_and_test(&dmempage->_refcount);
+}
+
+static inline int put_dmempage_testzero(struct dmempage *dmempage)
+{
+	VM_BUG_ON(dmempage_count(dmempage) == 0);
+	return dmempage_ref_dec_and_test(dmempage);
+}
+
 int dmem_register_mce_notifier(struct notifier_block *nb)
 {
 	int ret;
@@ -559,10 +598,25 @@ static int __init dmem_late_init(void)
 }
 late_initcall(dmem_late_init);
 
+static void *dmem_memmap_alloc(unsigned long dpages)
+{
+	unsigned long size;
+
+	size = dpages * sizeof(struct dmempage);
+	return vzalloc(size);
+}
+
+static void dmem_memmap_free(void *memmap)
+{
+	if (memmap)
+		vfree(memmap);
+}
+
 static int dmem_alloc_region_init(struct dmem_region *dregion,
 				  unsigned long *dpages)
 {
 	unsigned long start, end, *bitmap;
+	void *memmap;
 
 	start = DMEM_PAGE_UP(dregion->reserved_start_addr);
 	end = DMEM_PAGE_DOWN(dregion->reserved_end_addr);
@@ -575,7 +629,14 @@ static int dmem_alloc_region_init(struct dmem_region *dregion,
 	if (!bitmap)
 		return -ENOMEM;
 
+	memmap = dmem_memmap_alloc(*dpages);
+	if (!memmap) {
+		dmem_bitmap_free(*dpages, bitmap, &dregion->static_bitmap);
+		return -ENOMEM;
+	}
+
 	dregion->bitmap = bitmap;
+	dregion->memmap = memmap;
 	dregion->next_free_pos = 0;
 	dregion->dpage_start_pfn = start;
 	dregion->dpage_end_pfn = end;
@@ -650,7 +711,9 @@ static void dmem_alloc_region_uinit(struct dmem_region *dregion)
 	dmem_uinit_check_alloc_bitmap(dregion);
 
 	dmem_bitmap_free(dpages, bitmap, &dregion->static_bitmap);
+	dmem_memmap_free(dregion->memmap);
 	dregion->bitmap = NULL;
+	dregion->memmap = NULL;
 }
 
 static void __dmem_alloc_uinit(void)
@@ -793,6 +856,16 @@ int dmem_alloc_init(unsigned long dpage_shift)
 	return dpage_to_phys(dregion->dpage_start_pfn + pos);
 }
 
+static void prep_new_dmempage(unsigned long phys, unsigned int nr,
+			      struct dmem_region *dregion)
+{
+	struct dmempage *dmempage = pfn_to_dmempage(PHYS_PFN(phys), dregion);
+	unsigned int i;
+
+	for (i = 0; i < nr; i++, dmempage++)
+		set_dmempage_count(dmempage, 1);
+}
+
 /*
  * allocate dmem pages from the nodelist
  *
@@ -839,6 +912,7 @@ int dmem_alloc_init(unsigned long dpage_shift)
 			if (addr) {
 				dnode_count_free_dpages(dnode,
 							-(long)(*result_nr));
+				prep_new_dmempage(addr, *result_nr, dregion);
 				break;
 			}
 		}
@@ -993,6 +1067,41 @@ static struct dmem_region *find_dmem_region(phys_addr_t phys_addr,
 	return NULL;
 }
 
+static unsigned int free_dmempages_prepare(struct dmempage *dmempage,
+				   unsigned int dpages_nr)
+{
+	unsigned int i, ret = 0;
+
+	for (i = 0; i < dpages_nr; i++, dmempage++)
+		if (put_dmempage_testzero(dmempage))
+			ret++;
+
+	return ret;
+}
+
+void __dmem_free_pages(struct dmempage *dmempage,
+		       unsigned int dpages_nr,
+		       struct dmem_region *dregion,
+		       struct dmem_node *pdnode)
+{
+	phys_addr_t dpage = dmempage_to_dpage(dmempage, dregion);
+	u64 pos;
+	unsigned long err_dpages;
+
+	trace_dmem_free_pages(dpage_to_phys(dpage), dpages_nr);
+	WARN_ON(!dmem_pool.dpage_shift);
+
+	pos = dpage - dregion->dpage_start_pfn;
+	dregion->next_free_pos = min(dregion->next_free_pos, pos);
+
+	/* it is not possible to span multiple regions */
+	WARN_ON(dpage + dpages_nr - 1 >= dregion->dpage_end_pfn);
+
+	err_dpages = dmem_alloc_bitmap_clear(dregion, dpage, dpages_nr);
+
+	dnode_count_free_dpages(pdnode, dpages_nr - err_dpages);
+}
+
 /*
  * free dmem page to the dmem pool
  *   @addr: the physical addree will be freed
@@ -1002,27 +1111,26 @@ void dmem_free_pages(phys_addr_t addr, unsigned int dpages_nr)
 {
 	struct dmem_region *dregion;
 	struct dmem_node *pdnode = NULL;
-	phys_addr_t dpage = phys_to_dpage(addr);
-	u64 pos;
-	unsigned long err_dpages;
+	struct dmempage *dmempage;
+	unsigned int nr;
 
 	mutex_lock(&dmem_pool.lock);
 
-	trace_dmem_free_pages(addr, dpages_nr);
-	WARN_ON(!dmem_pool.dpage_shift);
-
 	dregion = find_dmem_region(addr, &pdnode);
 	WARN_ON(!dregion || !dregion->bitmap || !pdnode);
 
-	pos = dpage - dregion->dpage_start_pfn;
-	dregion->next_free_pos = min(dregion->next_free_pos, pos);
-
-	/* it is not possible to span multiple regions */
-	WARN_ON(dpage + dpages_nr - 1 >= dregion->dpage_end_pfn);
+	dmempage = pfn_to_dmempage(PHYS_PFN(addr), dregion);
 
-	err_dpages = dmem_alloc_bitmap_clear(dregion, dpage, dpages_nr);
+	nr = free_dmempages_prepare(dmempage, dpages_nr);
+	if (nr == dpages_nr)
+		__dmem_free_pages(dmempage, dpages_nr, dregion, pdnode);
+	else if (nr)
+		while (dpages_nr--, dmempage++) {
+			if (dmempage_count(dmempage))
+				continue;
+			__dmem_free_pages(dmempage, 1, dregion, pdnode);
+		}
 
-	dnode_count_free_dpages(pdnode, dpages_nr - err_dpages);
 	mutex_unlock(&dmem_pool.lock);
 }
 EXPORT_SYMBOL(dmem_free_pages);
@@ -1073,3 +1181,16 @@ bool is_dmem_pfn(unsigned long pfn)
 	return !!find_dmem_region(__pfn_to_phys(pfn), &dnode);
 }
 EXPORT_SYMBOL(is_dmem_pfn);
+
+void get_dmem_pfn(unsigned long pfn)
+{
+	struct dmem_region *dregion = find_dmem_region(PFN_PHYS(pfn), NULL);
+	struct dmempage *dmempage;
+
+	VM_BUG_ON(!dregion || !dregion->memmap);
+
+	dmempage = pfn_to_dmempage(pfn, dregion);
+	VM_BUG_ON(dmempage_count(dmempage) + 127u <= 127u);
+	dmempage_ref_inc(dmempage);
+}
+EXPORT_SYMBOL(get_dmem_pfn);
-- 
1.8.3.1

