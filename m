Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10DB01C7F3A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 May 2020 02:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728949AbgEGAqU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 May 2020 20:46:20 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:38988 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728927AbgEGAqN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 May 2020 20:46:13 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0470df6v097703;
        Thu, 7 May 2020 00:45:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=rlQi5rxYCHxqA5qKb9P4QkKEJHfUxot3+XWhWAfqKME=;
 b=J02jXttgdJsysTmwPlOH9qcFyn2Xdj2uzmEI9wYoaoGNBVVioCcduz4kKweVJwWKtIqe
 iTX/Sv7u1tTl9c0B0Skgy6tSoIjBpwFhgcW/fklhutm6C4tTTfx1cMD9qGmZVwEuoLVW
 yzv8ogAuvdxbGp1sVDkNtIhXpRgxGPKCnP4yV5WLbr3/KiNXtEB7OFDENr7L8IFQI2YG
 EUgy94b5O3v3Io7vnBQCBDnde/DLFRhq3pWS6QwWr4VZfllWZWZCo0d13OG8o8B23tyn
 HWW4n9OmhmDHk07IeECWwO+yn8FIvdVlNmR/jdEHWhT0klhZzQNyHsNntBoEwzGiJhDR Cw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 30usgq4h3y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 May 2020 00:45:12 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0470alr9170682;
        Thu, 7 May 2020 00:43:11 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 30us7p2m8e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 May 2020 00:43:11 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0470h8ph024282;
        Thu, 7 May 2020 00:43:08 GMT
Received: from ayz-linux.localdomain (/68.7.158.207)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 06 May 2020 17:43:08 -0700
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
Subject: [RFC 15/43] PKRAM: provide a way to ban pages from use by PKRAM
Date:   Wed,  6 May 2020 17:41:41 -0700
Message-Id: <1588812129-8596-16-git-send-email-anthony.yznaga@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1588812129-8596-1-git-send-email-anthony.yznaga@oracle.com>
References: <1588812129-8596-1-git-send-email-anthony.yznaga@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9613 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 suspectscore=2
 mlxlogscore=999 malwarescore=0 phishscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005070001
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9613 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 clxscore=1015
 mlxlogscore=999 spamscore=0 adultscore=0 bulkscore=0 phishscore=0
 suspectscore=2 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005070001
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Not all memory ranges can be used for saving preserved over-kexec data.
For example, a kexec kernel may be loaded before pages are preserved.
The memory regions where the kexec segments will be copied to on kexec
must not contain preserved pages or else they will be clobbered.

Originally-by: Vladimir Davydov <vdavydov.dev@gmail.com>
Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 include/linux/pkram.h |   2 +
 mm/pkram.c            | 210 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 212 insertions(+)

diff --git a/include/linux/pkram.h b/include/linux/pkram.h
index 409022e1472f..1ba48442ef8e 100644
--- a/include/linux/pkram.h
+++ b/include/linux/pkram.h
@@ -69,10 +69,12 @@ phys_addr_t pkram_memblock_find_in_range(phys_addr_t start, phys_addr_t end,
 extern unsigned long pkram_reserved_pages;
 void pkram_reserve(void);
 void pkram_free_pgt(void);
+void pkram_ban_region(unsigned long start, unsigned long end);
 #else
 #define pkram_reserved_pages 0UL
 static inline void pkram_reserve(void) { }
 static inline void pkram_free_pgt(void) { }
+static inline void pkram_ban_region(unsigned long start, unsigned long end) { }
 #endif
 
 #endif /* _LINUX_PKRAM_H */
diff --git a/mm/pkram.c b/mm/pkram.c
index e49c9bcd3854..60863c8ecbab 100644
--- a/mm/pkram.c
+++ b/mm/pkram.c
@@ -119,6 +119,28 @@ unsigned long __initdata pkram_reserved_pages;
 static bool pkram_reservation_in_progress;
 
 /*
+ * For tracking a region of memory that PKRAM is not allowed to use.
+ */
+struct banned_region {
+	unsigned long start, end;		/* pfn, inclusive */
+};
+
+#define MAX_NR_BANNED		(32 + MAX_NUMNODES * 2)
+
+static unsigned int nr_banned;			/* number of banned regions */
+
+/* banned regions; arranged in ascending order, do not overlap */
+static struct banned_region banned[MAX_NR_BANNED];
+/*
+ * If a page allocated for PKRAM turns out to belong to a banned region,
+ * it is placed on the banned_pages list so subsequent allocation attempts
+ * do not encounter it again. The list is shrunk when system memory is low.
+ */
+static LIST_HEAD(banned_pages);			/* linked through page::lru */
+static DEFINE_SPINLOCK(banned_pages_lock);
+static unsigned long nr_banned_pages;
+
+/*
  * The PKRAM super block pfn, see above.
  */
 static int __init parse_pkram_sb_pfn(char *arg)
@@ -223,12 +245,120 @@ void __init pkram_reserve(void)
 	pr_info("PKRAM: %lu pages reserved\n", pkram_reserved_pages);
 }
 
+/*
+ * Ban pfn range [start..end] (inclusive) from use in PKRAM.
+ */
+void pkram_ban_region(unsigned long start, unsigned long end)
+{
+	int i, merged = -1;
+
+	if (pkram_reservation_in_progress)
+		return;
+
+	/* first try to merge the region with an existing one */
+	for (i = nr_banned - 1; i >= 0 && start <= banned[i].end + 1; i--) {
+		if (end + 1 >= banned[i].start) {
+			start = min(banned[i].start, start);
+			end = max(banned[i].end, end);
+			if (merged < 0)
+				merged = i;
+		} else
+			/*
+			 * Regions are arranged in ascending order and do not
+			 * intersect so the merged region cannot jump over its
+			 * predecessors.
+			 */
+			BUG_ON(merged >= 0);
+	}
+
+	i++;
+
+	if (merged >= 0) {
+		banned[i].start = start;
+		banned[i].end = end;
+		/* shift if merged with more than one region */
+		memmove(banned + i + 1, banned + merged + 1,
+			sizeof(*banned) * (nr_banned - merged - 1));
+		nr_banned -= merged - i;
+		return;
+	}
+
+	/*
+	 * The region does not intersect with an existing one;
+	 * try to create a new one.
+	 */
+	if (nr_banned == MAX_NR_BANNED) {
+		pr_err("PKRAM: Failed to ban %lu-%lu: "
+		       "Too many banned regions\n", start, end);
+		return;
+	}
+
+	memmove(banned + i + 1, banned + i,
+		sizeof(*banned) * (nr_banned - i));
+	banned[i].start = start;
+	banned[i].end = end;
+	nr_banned++;
+}
+
+static void pkram_show_banned(void)
+{
+	int i;
+	unsigned long n, total = 0;
+
+	pr_info("PKRAM: banned regions:\n");
+	for (i = 0; i < nr_banned; i++) {
+		n = banned[i].end - banned[i].start + 1;
+		pr_info("%4d: [%08lx - %08lx] %ld pages\n",
+			i, banned[i].start, banned[i].end, n);
+		total += n;
+	}
+	pr_info("Total banned: %ld pages in %d regions\n",
+		total, nr_banned);
+}
+
+/*
+ * Returns true if the page may not be used for storing preserved data.
+ */
+static bool pkram_page_banned(struct page *page)
+{
+	unsigned long epfn, pfn = page_to_pfn(page);
+	int l = 0, r = nr_banned - 1, m;
+
+	epfn = pfn + compound_nr(page) - 1;
+
+	/* do binary search */
+	while (l <= r) {
+		m = (l + r) / 2;
+		if (epfn < banned[m].start)
+			r = m - 1;
+		else if (pfn > banned[m].end)
+			l = m + 1;
+		else
+			return true;
+	}
+	return false;
+}
+
 static inline struct page *__pkram_alloc_page(gfp_t gfp_mask, bool add_to_map)
 {
 	struct page *page;
+	LIST_HEAD(list);
+	unsigned long len = 0;
 	int err;
 
 	page = alloc_page(gfp_mask);
+	while (page && pkram_page_banned(page)) {
+		len++;
+		list_add(&page->lru, &list);
+		page = alloc_page(gfp_mask);
+	}
+	if (len > 0) {
+		spin_lock(&banned_pages_lock);
+		nr_banned_pages += len;
+		list_splice(&list, &banned_pages);
+		spin_unlock(&banned_pages_lock);
+	}
+
 	if (page && add_to_map) {
 		err = pkram_add_identity_map(page);
 		if (err) {
@@ -256,6 +386,53 @@ static inline void pkram_free_page(void *addr)
 	free_page((unsigned long)addr);
 }
 
+static void __banned_pages_shrink(unsigned long nr_to_scan)
+{
+	struct page *page;
+
+	if (nr_to_scan <= 0)
+		return;
+
+	while (nr_banned_pages > 0) {
+		BUG_ON(list_empty(&banned_pages));
+		page = list_first_entry(&banned_pages, struct page, lru);
+		list_del(&page->lru);
+		__free_page(page);
+		nr_banned_pages--;
+		nr_to_scan--;
+		if (!nr_to_scan)
+			break;
+	}
+}
+
+static unsigned long
+banned_pages_count(struct shrinker *shrink, struct shrink_control *sc)
+{
+	return nr_banned_pages;
+}
+
+static unsigned long
+banned_pages_scan(struct shrinker *shrink, struct shrink_control *sc)
+{
+	int nr_left = nr_banned_pages;
+
+	if (!sc->nr_to_scan || !nr_left)
+		return nr_left;
+
+	spin_lock(&banned_pages_lock);
+	__banned_pages_shrink(sc->nr_to_scan);
+	nr_left = nr_banned_pages;
+	spin_unlock(&banned_pages_lock);
+
+	return nr_left;
+}
+
+static struct shrinker banned_pages_shrinker = {
+	.count_objects = banned_pages_count,
+	.scan_objects = banned_pages_scan,
+	.seeks = DEFAULT_SEEKS,
+};
+
 static inline void pkram_insert_node(struct pkram_node *node)
 {
 	list_add(&virt_to_page(node)->lru, &pkram_nodes);
@@ -665,6 +842,32 @@ static int __pkram_save_page(struct pkram_stream *ps,
 	return 0;
 }
 
+static int __pkram_save_page_copy(struct pkram_stream *ps, struct page *page,
+				short flags)
+{
+	int nr_pages = compound_nr(page);
+	pgoff_t index = page->index;
+	int i, err;
+
+	for (i = 0; i < nr_pages; i++, index++) {
+		struct page *p = page + i;
+		struct page *new;
+
+		new = pkram_alloc_page(ps->gfp_mask);
+		if (!new)
+			return -ENOMEM;
+
+		copy_highpage(new, p);
+		err = __pkram_save_page(ps, new, flags, index);
+		put_page(new);
+
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
 /**
  * Save page @page to the preserved memory node and object associated with
  * stream @ps. The stream must have been initialized with pkram_prepare_save()
@@ -688,6 +891,10 @@ int pkram_save_page(struct pkram_stream *ps, struct page *page, short flags)
 
 	BUG_ON((node->flags & PKRAM_ACCMODE_MASK) != PKRAM_SAVE);
 
+	/* if page is banned, relocate it */
+	if (pkram_page_banned(page))
+		return __pkram_save_page_copy(ps, page, flags);
+
 	err = __pkram_save_page(ps, page, flags, page->index);
 	if (!err)
 		err = pkram_add_identity_map(page);
@@ -891,6 +1098,7 @@ static void __pkram_reboot(void)
 	unsigned long pgd_pfn = 0;
 
 	if (pkram_pgd) {
+		pkram_show_banned();
 		list_for_each_entry_reverse(page, &pkram_nodes, lru) {
 			node = page_address(page);
 			if (WARN_ON(node->flags & PKRAM_ACCMODE_MASK))
@@ -957,6 +1165,7 @@ static int __init pkram_init_sb(void)
 		page = __pkram_alloc_page(GFP_KERNEL | __GFP_ZERO, false);
 		if (!page) {
 			pr_err("PKRAM: Failed to allocate super block\n");
+			__banned_pages_shrink(ULONG_MAX);
 			return 0;
 		}
 		pkram_sb = page_address(page);
@@ -979,6 +1188,7 @@ static int __init pkram_init(void)
 {
 	if (pkram_init_sb()) {
 		register_reboot_notifier(&pkram_reboot_notifier);
+		register_shrinker(&banned_pages_shrinker);
 		sysfs_update_group(kernel_kobj, &pkram_attr_group);
 	}
 	return 0;
-- 
2.13.3

