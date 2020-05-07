Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E0411C7F14
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 May 2020 02:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728716AbgEGApj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 May 2020 20:45:39 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:39810 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728695AbgEGApi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 May 2020 20:45:38 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0470cY9j093219;
        Thu, 7 May 2020 00:44:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=VWqlosoXjG5R1RqBZE9eEylkgp/X8RtUPIDoZID/DCc=;
 b=z4jXuicy7aci4NvCa/KN1RcAMWuOtdDvS84SCGxFCkXjDUmdqqoAAetkRp9ypU3IKNXG
 beQ7/jLaSZpFpgtKD9BsG5beTlYHBthhaxk4ruV/y+DRxQV45ivD5lze5JWb+Z2lvzSL
 b2y5KiDoF075GZ7LW2TtpxWI+ujPwm+GPq77bGgdQrQkgfBBk/PdNcsFym6N0SAAlOMm
 a7zwsecz/Xmq2CoD19k1AbX+DaEbYTCRapdsWGuOQlJ++bw5S3yDeAxbOUxpsWMihbtT
 TsRWffWXM3MjG82INzJj35Q8il8LFhkfmv0OmwlnVJL7p3nQiLWT8+w/oxXnL6CtNtrv Ww== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 30s1gnd8qc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 May 2020 00:44:27 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0470bm0c131683;
        Thu, 7 May 2020 00:44:27 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 30t1r95cbf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 May 2020 00:44:27 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0470iOBH026117;
        Thu, 7 May 2020 00:44:24 GMT
Received: from ayz-linux.localdomain (/68.7.158.207)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 06 May 2020 17:44:23 -0700
From:   Anthony Yznaga <anthony.yznaga@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     willy@infradead.org, corbet@lwn.net, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        rppt@linux.ibm.com, akpm@linux-foundation.org, hughd@google.com,
        ebiederm@xmission.com, masahiroy@kernel.org, ardb@kernel.org,
        ndesaulniers@google.com, dima@golovin.in, daniel.kiper@oracle.com,
        nivedita@alum.mit.edu, rafael.j.wysocki@intel.com,
        dan.j.williams@intel.com, zhenzhong.duan@oracle.com,
        jroedel@suse.de, bhe@redhat.com, guro@fb.com,
        Thomas.Lendacky@amd.com, andriy.shevchenko@linux.intel.com,
        keescook@chromium.org, hannes@cmpxchg.org, minchan@kernel.org,
        mhocko@kernel.org, ying.huang@intel.com,
        yang.shi@linux.alibaba.com, gustavo@embeddedor.com,
        ziqian.lzq@antfin.com, vdavydov.dev@gmail.com,
        jason.zeng@intel.com, kevin.tian@intel.com, zhiyuan.lv@intel.com,
        lei.l.li@intel.com, paul.c.lai@intel.com, ashok.raj@intel.com,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        kexec@lists.infradead.org
Subject: [RFC 31/43] memblock, mm: defer initialization of preserved pages
Date:   Wed,  6 May 2020 17:41:57 -0700
Message-Id: <1588812129-8596-32-git-send-email-anthony.yznaga@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1588812129-8596-1-git-send-email-anthony.yznaga@oracle.com>
References: <1588812129-8596-1-git-send-email-anthony.yznaga@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9613 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 suspectscore=2
 spamscore=0 mlxlogscore=999 malwarescore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005070001
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9613 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=2 mlxscore=0
 spamscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 phishscore=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005070001
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Preserved pages are represented in the memblock reserved list, but page
structs for pages in the reserved list are initialized early while boot
is single threaded which means that a large number of preserved pages
can impact boot time. To mitigate, defer initialization of preserved
pages by skipping them when other reserved pages are initialized and
initializing them later with a separate kernel thread.

Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 arch/x86/mm/init_64.c |  1 -
 include/linux/mm.h    |  2 +-
 mm/memblock.c         | 10 ++++++++--
 mm/page_alloc.c       | 52 +++++++++++++++++++++++++++++++++++++++++++--------
 4 files changed, 53 insertions(+), 12 deletions(-)

diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index 72662615977b..ae569ef6bd7d 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -1245,7 +1245,6 @@ void __init mem_init(void)
 	after_bootmem = 1;
 	x86_init.hyper.init_after_bootmem();
 
-	pkram_free_pgt();
 	totalram_pages_add(pkram_reserved_pages);
 	/*
 	 * Must be done after boot memory is put on freelist, because here we
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 5a323422d783..69b9cd08c721 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2297,7 +2297,7 @@ extern void free_highmem_page(struct page *page);
 extern void adjust_managed_page_count(struct page *page, long count);
 extern void mem_init_print_info(const char *str);
 
-extern void reserve_bootmem_region(phys_addr_t start, phys_addr_t end);
+extern void reserve_bootmem_region(phys_addr_t start, phys_addr_t end, int nid);
 
 /* Free the reserved page into the buddy system, so it gets managed. */
 static inline void __free_reserved_page(struct page *page)
diff --git a/mm/memblock.c b/mm/memblock.c
index 33597f352dc0..5524edbaf691 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -2042,11 +2042,17 @@ static unsigned long __init free_low_memory_core_early(void)
 	unsigned long count = 0;
 	phys_addr_t start, end;
 	u64 i;
+	enum memblock_flags exclude;
 
 	memblock_clear_hotplug(0, -1);
 
-	for_each_reserved_mem_region(i, &start, &end)
-		reserve_bootmem_region(start, end);
+	if (IS_ENABLED(CONFIG_DEFERRED_STRUCT_PAGE_INIT))
+		exclude = MEMBLOCK_PRESERVED;
+	else
+		exclude = MEMBLOCK_NONE;
+
+	for_each_reserved_mem_range(i, 0, exclude, &start, &end, NULL)
+		reserve_bootmem_region(start, end, -1);
 
 	/*
 	 * We need to use NUMA_NO_NODE instead of NODE_DATA(0)->node_id
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 69827d4fa052..afd97b31725e 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -68,6 +68,7 @@
 #include <linux/lockdep.h>
 #include <linux/nmi.h>
 #include <linux/psi.h>
+#include <linux/pkram.h>
 
 #include <asm/sections.h>
 #include <asm/tlbflush.h>
@@ -1408,15 +1409,18 @@ static void __meminit __init_single_page(struct page *page, unsigned long pfn,
 }
 
 #ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
-static void __meminit init_reserved_page(unsigned long pfn)
+static void __meminit init_reserved_page(unsigned long pfn, int nid)
 {
 	pg_data_t *pgdat;
-	int nid, zid;
+	int zid;
 
-	if (!early_page_uninitialised(pfn))
-		return;
+	if (nid == -1) {
+		if (!early_page_uninitialised(pfn))
+			return;
+
+		nid = early_pfn_to_nid(pfn);
+	}
 
-	nid = early_pfn_to_nid(pfn);
 	pgdat = NODE_DATA(nid);
 
 	for (zid = 0; zid < MAX_NR_ZONES; zid++) {
@@ -1428,7 +1432,7 @@ static void __meminit init_reserved_page(unsigned long pfn)
 	__init_single_page(pfn_to_page(pfn), pfn, zid, nid);
 }
 #else
-static inline void init_reserved_page(unsigned long pfn)
+static inline void init_reserved_page(unsigned long pfn, int nid)
 {
 }
 #endif /* CONFIG_DEFERRED_STRUCT_PAGE_INIT */
@@ -1439,7 +1443,7 @@ static inline void init_reserved_page(unsigned long pfn)
  * marks the pages PageReserved. The remaining valid pages are later
  * sent to the buddy page allocator.
  */
-void __meminit reserve_bootmem_region(phys_addr_t start, phys_addr_t end)
+void __meminit reserve_bootmem_region(phys_addr_t start, phys_addr_t end, int nid)
 {
 	unsigned long start_pfn = PFN_DOWN(start);
 	unsigned long end_pfn = PFN_UP(end);
@@ -1448,7 +1452,7 @@ void __meminit reserve_bootmem_region(phys_addr_t start, phys_addr_t end)
 		if (pfn_valid(start_pfn)) {
 			struct page *page = pfn_to_page(start_pfn);
 
-			init_reserved_page(start_pfn);
+			init_reserved_page(start_pfn, nid);
 
 			/* Avoid false-positive PageTail() */
 			INIT_LIST_HEAD(&page->lru);
@@ -1876,6 +1880,34 @@ static int __init deferred_init_memmap(void *data)
 	return 0;
 }
 
+#ifdef CONFIG_PKRAM
+static int __init deferred_init_preserved(void *dummy)
+{
+	unsigned long start = jiffies;
+	unsigned long nr_pages = 0;
+	phys_addr_t spa, epa;
+	int nid;
+	u64 i;
+
+	for_each_reserved_mem_range(i, MEMBLOCK_PRESERVED, 0, &spa, &epa, &nid) {
+		reserve_bootmem_region(spa, epa, nid);
+		nr_pages += ((epa - spa) >> PAGE_SHIFT);
+	}
+
+	pr_info("initialised %lu preserved pages in %ums\n", nr_pages,
+					jiffies_to_msecs(jiffies - start));
+
+	/*
+	 * Free the preserved pages pagetable now that page structs are
+	 * initialized.
+	 */
+	pkram_free_pgt();
+
+	pgdat_init_report_one_done();
+	return 0;
+}
+#endif /* CONFIG_PKRAM */
+
 /*
  * If this zone has deferred pages, try to grow it by initializing enough
  * deferred pages to satisfy the allocation specified by order, rounded up to
@@ -1985,6 +2017,10 @@ void __init page_alloc_init_late(void)
 
 	/* There will be num_node_state(N_MEMORY) threads */
 	atomic_set(&pgdat_init_n_undone, num_node_state(N_MEMORY));
+#ifdef CONFIG_PKRAM
+	atomic_inc(&pgdat_init_n_undone);
+	kthread_run(deferred_init_preserved, NULL, "pgdatainit_preserved");
+#endif
 	for_each_node_state(nid, N_MEMORY) {
 		kthread_run(deferred_init_memmap, NODE_DATA(nid), "pgdatinit%d", nid);
 	}
-- 
2.13.3

