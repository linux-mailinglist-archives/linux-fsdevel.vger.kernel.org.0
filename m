Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 955971C7F30
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 May 2020 02:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728895AbgEGAqI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 May 2020 20:46:08 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:40214 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728823AbgEGAqF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 May 2020 20:46:05 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0470bnlu093003;
        Thu, 7 May 2020 00:45:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=bv6mPYRvBlGJaPvIxvryncCtChgbVQh2Nj0efsq/tRk=;
 b=hXArlhMRvINvgicHIomniImjUPo2Eu6gImaZKxuEYHSWrFoMG1wfx97Nd8iTg7orSrdu
 osl8hSK64dZ9q6DGBX1pgOBi6X5m8HBhXKKl5TWIRcYrNW6ZrCL+1bGyXW8Jd6eHurYN
 LXTnNRbvPCLrJ8LV/hzXqYx+8/Rro0x2uJ6A2ukUqnsC2/miYThQsfeOMoASgV9UgwDM
 e7Bqa/9S6oKRVepJHscLpdgqGp3j+iVKPL560csj+4iZLhmzt+rfnUAeqAORWbXCSG+E
 UZkBKkjjFNT62+rIc2aoeAVwNdtR9BL0lP72l/ScXGzlTPedIp52pMywAVaicl3aO0Nv aA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 30s1gnd8s1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 May 2020 00:45:00 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0470akjj170679;
        Thu, 7 May 2020 00:43:00 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 30us7p2m1e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 May 2020 00:43:00 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0470gvDB025596;
        Thu, 7 May 2020 00:42:57 GMT
Received: from ayz-linux.localdomain (/68.7.158.207)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 06 May 2020 17:42:57 -0700
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
Subject: [RFC 12/43] mm: PKRAM: reserve preserved memory at boot
Date:   Wed,  6 May 2020 17:41:38 -0700
Message-Id: <1588812129-8596-13-git-send-email-anthony.yznaga@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1588812129-8596-1-git-send-email-anthony.yznaga@oracle.com>
References: <1588812129-8596-1-git-send-email-anthony.yznaga@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9613 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 suspectscore=2
 mlxlogscore=999 malwarescore=0 phishscore=0 mlxscore=0 spamscore=0
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

Keep preserved pages from being recycled during boot by adding them
to the memblock reserved list during early boot. If memory reservation
fails (e.g. a region has already been reserved), all preserved pages
are dropped.

For efficiency the preserved pages pagetable is used to identify and
reserve by the contiguous ranges present rather than a page at a time.

Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 arch/x86/kernel/setup.c |   3 +
 arch/x86/mm/init_64.c   |   2 +
 include/linux/pkram.h   |   8 +++
 mm/pkram.c              | 179 +++++++++++++++++++++++++++++++++++++++++++++++-
 4 files changed, 189 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 4b3fa6cd3106..851515753ad9 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -14,6 +14,7 @@
 #include <linux/iscsi_ibft.h>
 #include <linux/memblock.h>
 #include <linux/pci.h>
+#include <linux/pkram.h>
 #include <linux/root_dev.h>
 #include <linux/sfi.h>
 #include <linux/hugetlb.h>
@@ -1158,6 +1159,8 @@ void __init setup_arch(char **cmdline_p)
 	initmem_init();
 	dma_contiguous_reserve(max_pfn_mapped << PAGE_SHIFT);
 
+	pkram_reserve();
+
 	if (boot_cpu_has(X86_FEATURE_GBPAGES))
 		hugetlb_cma_reserve(PUD_SHIFT - PAGE_SHIFT);
 
diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index 3b289c2f75cd..ae569ef6bd7d 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -33,6 +33,7 @@
 #include <linux/nmi.h>
 #include <linux/gfp.h>
 #include <linux/kcore.h>
+#include <linux/pkram.h>
 
 #include <asm/processor.h>
 #include <asm/bios_ebda.h>
@@ -1244,6 +1245,7 @@ void __init mem_init(void)
 	after_bootmem = 1;
 	x86_init.hyper.init_after_bootmem();
 
+	totalram_pages_add(pkram_reserved_pages);
 	/*
 	 * Must be done after boot memory is put on freelist, because here we
 	 * might set fields in deferred struct pages that have not yet been
diff --git a/include/linux/pkram.h b/include/linux/pkram.h
index b6fa973d37cc..1b475f6e1598 100644
--- a/include/linux/pkram.h
+++ b/include/linux/pkram.h
@@ -61,4 +61,12 @@ struct page *pkram_load_page(struct pkram_stream *ps, unsigned long *index,
 ssize_t pkram_write(struct pkram_stream *ps, const void *buf, size_t count);
 size_t pkram_read(struct pkram_stream *ps, void *buf, size_t count);
 
+#ifdef CONFIG_PKRAM
+extern unsigned long pkram_reserved_pages;
+void pkram_reserve(void);
+#else
+#define pkram_reserved_pages 0UL
+static inline void pkram_reserve(void) { }
+#endif
+
 #endif /* _LINUX_PKRAM_H */
diff --git a/mm/pkram.c b/mm/pkram.c
index 54b2779d0813..2c323154df76 100644
--- a/mm/pkram.c
+++ b/mm/pkram.c
@@ -7,6 +7,7 @@
 #include <linux/kernel.h>
 #include <linux/kobject.h>
 #include <linux/list.h>
+#include <linux/memblock.h>
 #include <linux/mm.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
@@ -105,6 +106,7 @@ static DEFINE_SPINLOCK(pkram_pgd_lock);
 
 static int pkram_add_identity_map(struct page *page);
 static void pkram_remove_identity_map(struct page *page);
+static int pkram_reserve_page_ranges(pgd_t *pgd);
 
 /*
  * For convenience sake PKRAM nodes are kept in an auxiliary doubly-linked list
@@ -113,6 +115,9 @@ static void pkram_remove_identity_map(struct page *page);
 static LIST_HEAD(pkram_nodes);			/* linked through page::lru */
 static DEFINE_MUTEX(pkram_mutex);		/* serializes open/close */
 
+unsigned long __initdata pkram_reserved_pages;
+static bool pkram_reservation_in_progress;
+
 /*
  * The PKRAM super block pfn, see above.
  */
@@ -122,6 +127,102 @@ static int __init parse_pkram_sb_pfn(char *arg)
 }
 early_param("pkram", parse_pkram_sb_pfn);
 
+static void * __init pkram_map_meta(unsigned long pfn)
+{
+	if (pfn >= max_low_pfn)
+		return ERR_PTR(-EINVAL);
+	return pfn_to_kaddr(pfn);
+}
+
+static int __init pkram_reserve_page(unsigned long pfn)
+{
+	phys_addr_t base, size;
+	int err = 0;
+
+	if (pfn >= max_pfn)
+		return -EINVAL;
+
+	base = PFN_PHYS(pfn);
+	size = PAGE_SIZE;
+
+	if (memblock_is_region_reserved(base, size) ||
+	    memblock_reserve(base, size) < 0)
+		err = -EBUSY;
+
+	if (!err)
+		pkram_reserved_pages++;
+
+	return err;
+}
+
+static void __init pkram_unreserve_page(unsigned long pfn)
+{
+	memblock_free(PFN_PHYS(pfn), PAGE_SIZE);
+	pkram_reserved_pages--;
+}
+
+/*
+ * Reserved pages that belong to preserved memory.
+ *
+ * This function should be called at boot time as early as possible to prevent
+ * preserved memory from being recycled.
+ */
+void __init pkram_reserve(void)
+{
+	int err = 0;
+
+	if (!pkram_sb_pfn)
+		return;
+
+	pr_info("PKRAM: Examining preserved memory...\n");
+	pkram_reservation_in_progress = true;
+
+	err = pkram_reserve_page(pkram_sb_pfn);
+	if (err)
+		goto out;
+	pkram_sb = pkram_map_meta(pkram_sb_pfn);
+	if (IS_ERR(pkram_sb)) {
+		pkram_unreserve_page(pkram_sb_pfn);
+		err = PTR_ERR(pkram_sb);
+		goto out;
+	}
+
+	/* An empty pkram_sb is not an error */
+	if (!pkram_sb->node_pfn) {
+		pkram_unreserve_page(pkram_sb_pfn);
+		pkram_sb = NULL;
+		goto done;
+	}
+
+	err = pkram_reserve_page(pkram_sb->pgd_pfn);
+	if (err) {
+		pr_warn("PKRAM: pgd_pfn=0x%llx already reserved\n",
+			pkram_sb->pgd_pfn);
+		pkram_unreserve_page(pkram_sb_pfn);
+		goto out;
+	}
+	pkram_pgd = pfn_to_kaddr(pkram_sb->pgd_pfn);
+	err = pkram_reserve_page_ranges(pkram_pgd);
+	if (err) {
+		pkram_unreserve_page(pkram_sb->pgd_pfn);
+		pkram_unreserve_page(pkram_sb_pfn);
+		pkram_pgd = NULL;
+	}
+
+out:
+	pkram_reservation_in_progress = false;
+
+	if (err) {
+		pr_err("PKRAM: Reservation failed: %d\n", err);
+		WARN_ON(pkram_reserved_pages > 0);
+		pkram_sb = NULL;
+		return;
+	}
+
+done:
+	pr_info("PKRAM: %lu pages reserved\n", pkram_reserved_pages);
+}
+
 static inline struct page *__pkram_alloc_page(gfp_t gfp_mask, bool add_to_map)
 {
 	struct page *page;
@@ -146,6 +247,11 @@ static inline struct page *pkram_alloc_page(gfp_t gfp_mask)
 
 static inline void pkram_free_page(void *addr)
 {
+	/*
+	 * The page may have the reserved bit set since preserved pages
+	 * are reserved early in boot.
+	 */
+	ClearPageReserved(virt_to_page(addr));
 	pkram_remove_identity_map(virt_to_page(addr));
 	free_page((unsigned long)addr);
 }
@@ -184,6 +290,11 @@ static void pkram_truncate_link(struct pkram_link *link)
 		if (!p)
 			continue;
 		page = pfn_to_page(PHYS_PFN(p));
+		/*
+		 * The page may have the reserved bit set since preserved pages
+		 * are reserved early in boot.
+		 */
+		ClearPageReserved(page);
 		pkram_remove_identity_map(page);
 		put_page(page);
 	}
@@ -593,7 +704,7 @@ static struct page *__pkram_load_page(struct pkram_stream *ps, unsigned long *in
 	struct pkram_link *link = ps->link;
 	struct page *page;
 	pkram_entry_t p;
-	int order;
+	int i, order;
 	short flgs;
 
 	if (!link) {
@@ -615,6 +726,12 @@ static struct page *__pkram_load_page(struct pkram_stream *ps, unsigned long *in
 	order = p & PKRAM_ENTRY_ORDER_MASK;
 	page = pfn_to_page(PHYS_PFN(p));
 
+	for (i = 0; i < (1 << order); i++) {
+		struct page *pg = page + i;
+
+		ClearPageReserved(pg);
+	}
+
 	if (flgs & PKRAM_PAGE_TRANS_HUGE) {
 		prep_compound_page(page, order);
 		prep_transhuge_page(page);
@@ -735,6 +852,7 @@ size_t pkram_read(struct pkram_stream *ps, void *buf, size_t count)
 		page = pfn_to_page(obj->data_pfn);
 		if (!page)
 			return 0;
+		ClearPageReserved(page);
 
 		ps->data_page = page;
 		ps->data_offset = 0;
@@ -782,8 +900,15 @@ static void __pkram_reboot(void)
 		}
 		pgd_pfn = page_to_pfn(virt_to_page(pkram_pgd));
 	}
-	pkram_sb->node_pfn = node_pfn;
-	pkram_sb->pgd_pfn = pgd_pfn;
+	/*
+	 * Zero out pkram_sb completely since it may have been passed from
+	 * the previous boot.
+	 */
+	memset(pkram_sb, 0, PAGE_SIZE);
+	if (node_pfn) {
+		pkram_sb->node_pfn = node_pfn;
+		pkram_sb->pgd_pfn = pgd_pfn;
+	}
 }
 
 static int pkram_reboot(struct notifier_block *notifier,
@@ -867,6 +992,7 @@ static unsigned long *pkram_alloc_pte_bitmap(void)
 
 static void pkram_free_pte_bitmap(void *bitmap)
 {
+	ClearPageReserved(virt_to_page(bitmap));
 	pkram_remove_identity_map(virt_to_page(bitmap));
 	free_page((unsigned long)bitmap);
 }
@@ -1054,3 +1180,50 @@ static void pkram_remove_identity_map(struct page *page)
 		spin_unlock(&pkram_pgd_lock);
 	}
 }
+
+static int __init pkram_reserve_range_cb(struct pkram_pg_state *st, unsigned long base, unsigned long size)
+{
+	if (memblock_is_region_reserved(base, size) ||
+	    memblock_reserve(base, size) < 0) {
+		pr_warn("PKRAM: reservations exist in [0x%lx,0x%lx]\n", base, base + size - 1);
+		/*
+		 * Set a lower bound so another walk can undo the earlier,
+		 * successful reservations.
+		 */
+		st->min_addr = base + size;
+		st->retval = -EBUSY;
+		return 1;
+	}
+
+	pkram_reserved_pages += (size >> PAGE_SHIFT);
+	return 0;
+}
+
+static int __init pkram_unreserve_range_cb(struct pkram_pg_state *st, unsigned long base, unsigned long size)
+{
+	memblock_free(base, size);
+	pkram_reserved_pages -= (size >> PAGE_SHIFT);
+	return 0;
+}
+
+/*
+ * Walk the preserved pages pagetable and reserve each present address range.
+ */
+static int __init pkram_reserve_page_ranges(pgd_t *pgd)
+{
+	struct pkram_pg_state st = {
+		.range_cb = pkram_reserve_range_cb,
+		.max_addr = PHYS_ADDR_MAX,
+	};
+	int err = 0;
+
+	pkram_walk_pgt_rev(&st, pgd);
+	if ((int)st.retval < 0) {
+		err = st.retval;
+		st.retval = 0;
+		st.range_cb = pkram_unreserve_range_cb;
+		pkram_walk_pgt_rev(&st, pgd);
+	}
+
+	return err;
+}
-- 
2.13.3

