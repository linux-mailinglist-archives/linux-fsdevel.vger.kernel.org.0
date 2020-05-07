Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E96B71C7F5C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 May 2020 02:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728546AbgEGArs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 May 2020 20:47:48 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:40174 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728301AbgEGArr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 May 2020 20:47:47 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0470dorh097717;
        Thu, 7 May 2020 00:46:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=arcq8/HROQoIUiARdJysmZeubuzb+nFutvXELT9aDds=;
 b=dPlMIKVtPrIjyIeR1b5KRXUxKZhC1X1XWLgImAWpPKmV8IpsamzyGSJ0TKX2RV0704gq
 CTahxA4HfhdRGEAhkqYGa4Dkj25GdkzZcwii0mXdm5sNq2jYqLOsXcFkYCt4RFACBoov
 O7P9uIY02ZTKBv48yX3ToBUW8nvJzf1VAdYxx+goAyMFnoLU+rSCL3PfIvieghDUr6yn
 X7LGaV6szLjIDh4YyXKsDdRakFOjC8SB8RSMbJwe/y/x0wH9hJ46S5qJdeUpMKPzm7p8
 LbdnzdD6dVGHtIgd2lh83oLwfkmZ2KTumssABEf4D3rt0iSfGpPB4aUY8kRR8rFxlkMr ow== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 30usgq4h6x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 May 2020 00:46:54 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0470at2K136306;
        Thu, 7 May 2020 00:44:53 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 30sjdwrt78-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 May 2020 00:44:53 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0470ioUE024931;
        Thu, 7 May 2020 00:44:50 GMT
Received: from ayz-linux.localdomain (/68.7.158.207)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 06 May 2020 17:44:49 -0700
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
Subject: [RFC 38/43] mm: implement splicing a list of pages to the LRU
Date:   Wed,  6 May 2020 17:42:04 -0700
Message-Id: <1588812129-8596-39-git-send-email-anthony.yznaga@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1588812129-8596-1-git-send-email-anthony.yznaga@oracle.com>
References: <1588812129-8596-1-git-send-email-anthony.yznaga@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9613 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 mlxscore=0
 bulkscore=0 adultscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005070001
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9613 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 clxscore=1015
 mlxlogscore=999 spamscore=0 adultscore=0 bulkscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005070001
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Considerable contention on the LRU lock happens when multiple threads
are used to insert pages into a shmem file in parallel. To alleviate this
provide a way for pages to be added to the same LRU to be staged so that
they can be added by splicing lists and updating stats once with the lock
held. For now only unevictable pages are supported.

Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 include/linux/swap.h |  11 ++++++
 mm/swap.c            | 101 +++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 112 insertions(+)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index e1bbf7a16b27..462045f536a8 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -346,6 +346,17 @@ extern void swap_setup(void);
 
 extern void lru_cache_add_active_or_unevictable(struct page *page,
 						struct vm_area_struct *vma);
+struct lru_splice {
+	struct list_head	splice;
+	struct list_head	*lru_head;
+	struct pglist_data	*pgdat;
+	struct lruvec		*lruvec;
+	enum lru_list		lru;
+	unsigned long		nr_pages[MAX_NR_ZONES];
+	unsigned long		pgculled;
+};
+extern void lru_splice_add_anon(struct page *page, struct lru_splice *splice);
+extern void add_splice_to_lru_list(struct lru_splice *splice);
 
 /* linux/mm/vmscan.c */
 extern unsigned long zone_reclaimable_pages(struct zone *zone);
diff --git a/mm/swap.c b/mm/swap.c
index bf9a79fed62d..848f8b516471 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -187,6 +187,107 @@ int get_kernel_page(unsigned long start, int write, struct page **pages)
 }
 EXPORT_SYMBOL_GPL(get_kernel_page);
 
+/*
+ * Update stats and move accumulated pages from an lru_splice to the lru.
+ */
+void add_splice_to_lru_list(struct lru_splice *splice)
+{
+	struct pglist_data *pgdat = splice->pgdat;
+	struct lruvec *lruvec = splice->lruvec;
+	enum lru_list lru = splice->lru;
+	unsigned long flags = 0;
+	int zid;
+
+	spin_lock_irqsave(&pgdat->lru_lock, flags);
+	for (zid = 0; zid < MAX_NR_ZONES; zid++) {
+		if (splice->nr_pages[zid])
+			update_lru_size(lruvec, lru, zid, splice->nr_pages[zid]);
+	}
+	count_vm_events(UNEVICTABLE_PGCULLED, splice->pgculled);
+	list_splice(&splice->splice, splice->lru_head);
+	spin_unlock_irqrestore(&pgdat->lru_lock, flags);
+
+	splice->lru_head = NULL;
+	splice->pgculled = 0;
+}
+
+static void add_page_to_lru_splice(struct page *page,
+				   struct lru_splice *splice,
+				   struct lruvec *lruvec, enum lru_list lru)
+{
+	int zid;
+
+	if (splice->lru_head == &lruvec->lists[lru]) {
+		list_add(&page->lru, &splice->splice);
+		splice->nr_pages[page_zonenum(page)] += hpage_nr_pages(page);
+		return;
+	}
+
+	INIT_LIST_HEAD(&splice->splice);
+	splice->lruvec = lruvec;
+	splice->lru_head = &lruvec->lists[lru];
+	splice->lru = lru;
+	list_add(&page->lru, &splice->splice);
+	for (zid = 0; zid < MAX_NR_ZONES; zid++)
+		splice->nr_pages[zid] = 0;
+	splice->nr_pages[page_zonenum(page)] = hpage_nr_pages(page);
+
+}
+
+/*
+ * Similar in functionality to __pagevec_lru_add_fn() but here the page is
+ * being added to an lru_splice and the LRU lock is not held.
+ */
+static void page_lru_splice_add(struct page *page, struct lruvec *lruvec, struct lru_splice *splice)
+{
+	enum lru_list lru;
+	int was_unevictable = TestClearPageUnevictable(page);
+
+	VM_BUG_ON_PAGE(PageLRU(page), page);
+	/* XXX only supports unevictable pages at the moment */
+	VM_BUG_ON_PAGE(was_unevictable, page);
+
+	SetPageLRU(page);
+	smp_mb();
+
+	lru = LRU_UNEVICTABLE;
+	ClearPageActive(page);
+	SetPageUnevictable(page);
+	if (!was_unevictable)
+		splice->pgculled++;
+
+	add_page_to_lru_splice(page, splice, lruvec, lru);
+	trace_mm_lru_insertion(page, lru);
+}
+
+static void lru_splice_add(struct page *page, struct lru_splice *splice)
+{
+	struct pglist_data *pagepgdat, *pgdat = splice->pgdat;
+	struct lruvec *lruvec;
+
+	pagepgdat = page_pgdat(page);
+
+	if (pagepgdat != pgdat) {
+		if (pgdat)
+			add_splice_to_lru_list(splice);
+		splice->pgdat = pagepgdat;
+	}
+
+	lruvec = mem_cgroup_page_lruvec(page, pagepgdat);
+	page_lru_splice_add(page, lruvec, splice);
+}
+
+void lru_splice_add_anon(struct page *page, struct lru_splice *splice)
+{
+	if (PageActive(page))
+		ClearPageActive(page);
+	get_page(page);
+
+	lru_splice_add(page, splice);
+
+	put_page(page);
+}
+
 static void pagevec_lru_move_fn(struct pagevec *pvec,
 	void (*move_fn)(struct page *page, struct lruvec *lruvec, void *arg),
 	void *arg)
-- 
2.13.3

