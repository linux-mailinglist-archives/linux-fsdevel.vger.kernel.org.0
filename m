Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6DAB1C7EB8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 May 2020 02:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728324AbgEGAoD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 May 2020 20:44:03 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:47530 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728301AbgEGAoA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 May 2020 20:44:00 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0470befE064522;
        Thu, 7 May 2020 00:43:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=FB0OnNXJ4i/M/+h8LQO56pQ0/rOm3gP03sALm2dSqQ0=;
 b=paQStL8PTEqfO6fbwWpdX7ph/jPw52JforzGHSJy6xCRA7TlKE9rgam/ENPCfzk9euum
 Sjd0h3Kq+5hyYIizY1UV95kGxFr+kUjwBRtlGE4dS7wKcTc0MDxI6AzPRy4S9H0BboZy
 5iyq/+JtZKfXzfHVOfgd+OWjF9iP3dp2S51nbUcp2Lap+ah4HcaANnmMG5tIByCXDrDg
 jSvr9T9OLTgKIAumWEar+p656nFRq3XoHKoFhZheviqy0x9jOx9nPubeqQtSS20gUILr
 sjlSGRAXqdqABm8PE4bcPxPY0UbZwgKgKtirZ85i6jjBkT88h9WOuaYwwNoAmBmKdN3G Tg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 30s09rdf7e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 May 2020 00:43:03 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0470bTMj098599;
        Thu, 7 May 2020 00:43:02 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 30sjnma1ty-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 May 2020 00:43:02 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0470h1VZ019957;
        Thu, 7 May 2020 00:43:01 GMT
Received: from ayz-linux.localdomain (/68.7.158.207)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 06 May 2020 17:43:01 -0700
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
Subject: [RFC 13/43] mm: PKRAM: free preserved pages pagetable
Date:   Wed,  6 May 2020 17:41:39 -0700
Message-Id: <1588812129-8596-14-git-send-email-anthony.yznaga@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1588812129-8596-1-git-send-email-anthony.yznaga@oracle.com>
References: <1588812129-8596-1-git-send-email-anthony.yznaga@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9613 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=2
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005070001
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9613 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 clxscore=1015 suspectscore=2
 priorityscore=1501 malwarescore=0 mlxlogscore=999 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005070001
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

After the page ranges in the pagetable have been reserved the pagetable
is no longer needed.  Rather than free it during early boot by unreserving
page-sized blocks which can be inefficient when dealing with a large number
of blocks, wait until the page structs have been initialized and free them
as pages.

Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 arch/x86/mm/init_64.c |  1 +
 include/linux/pkram.h |  3 ++
 mm/pkram.c            | 11 +++++++
 mm/pkram_pagetable.c  | 82 +++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 97 insertions(+)

diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index ae569ef6bd7d..72662615977b 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -1245,6 +1245,7 @@ void __init mem_init(void)
 	after_bootmem = 1;
 	x86_init.hyper.init_after_bootmem();
 
+	pkram_free_pgt();
 	totalram_pages_add(pkram_reserved_pages);
 	/*
 	 * Must be done after boot memory is put on freelist, because here we
diff --git a/include/linux/pkram.h b/include/linux/pkram.h
index 1b475f6e1598..edc5d8bef9d3 100644
--- a/include/linux/pkram.h
+++ b/include/linux/pkram.h
@@ -39,6 +39,7 @@ struct pkram_pg_state {
 };
 
 void pkram_walk_pgt_rev(struct pkram_pg_state *st, pgd_t *pgd);
+void pkram_free_pgt_walk_pgd(pgd_t *pgd);
 
 int pkram_prepare_save(struct pkram_stream *ps, const char *name,
 		       gfp_t gfp_mask);
@@ -64,9 +65,11 @@ size_t pkram_read(struct pkram_stream *ps, void *buf, size_t count);
 #ifdef CONFIG_PKRAM
 extern unsigned long pkram_reserved_pages;
 void pkram_reserve(void);
+void pkram_free_pgt(void);
 #else
 #define pkram_reserved_pages 0UL
 static inline void pkram_reserve(void) { }
+static inline void pkram_free_pgt(void) { }
 #endif
 
 #endif /* _LINUX_PKRAM_H */
diff --git a/mm/pkram.c b/mm/pkram.c
index 2c323154df76..dd3c89614010 100644
--- a/mm/pkram.c
+++ b/mm/pkram.c
@@ -1227,3 +1227,14 @@ static int __init pkram_reserve_page_ranges(pgd_t *pgd)
 
 	return err;
 }
+
+void pkram_free_pgt(void)
+{
+	if (!pkram_pgd)
+		return;
+
+	pkram_free_pgt_walk_pgd(pkram_pgd);
+
+	__free_pages_core(virt_to_page(pkram_pgd), 0);
+	pkram_pgd = NULL;
+}
diff --git a/mm/pkram_pagetable.c b/mm/pkram_pagetable.c
index d31aa36207ba..7033e9b1c47f 100644
--- a/mm/pkram_pagetable.c
+++ b/mm/pkram_pagetable.c
@@ -3,6 +3,8 @@
 #include <asm/pgtable.h>
 #include <linux/pkram.h>
 
+#include "internal.h"
+
 #define pgd_none(a)  (pgtable_l5_enabled() ? pgd_none(a) : p4d_none(__p4d(pgd_val(a))))
 
 static int note_page_rev(struct pkram_pg_state *st, unsigned long curr_size, bool present)
@@ -167,3 +169,83 @@ void pkram_walk_pgt_rev(struct pkram_pg_state *st, pgd_t *pgd)
 			break;
 	}
 }
+
+static void pkram_free_pgt_walk_pmd(pud_t addr)
+{
+	unsigned long bitmap_pa;
+	struct page *page;
+	pmd_t *start;
+	int i;
+
+	start = (pmd_t *)pud_page_vaddr(addr);
+	for (i = 0; i < PTRS_PER_PMD; i++, start++) {
+		if (!pmd_none(*start)) {
+			bitmap_pa = pte_val(pte_clrhuge(*(pte_t *)start));
+			if (pmd_large(*start) && !bitmap_pa)
+				continue;
+			page = virt_to_page(__va(bitmap_pa));
+			__free_pages_core(page, 0);
+		}
+	}
+}
+
+static void pkram_free_pgt_walk_pud(p4d_t addr)
+{
+	struct page *page;
+	pud_t *start;
+	int i;
+
+	start = (pud_t *)p4d_page_vaddr(addr);
+	for (i = 0; i < PTRS_PER_PUD; i++, start++) {
+		if (!pud_none(*start)) {
+			if (pud_large(*start)) {
+				WARN_ONCE(1, "PKRAM: unexpected pud hugepage\n");
+				continue;
+			}
+			pkram_free_pgt_walk_pmd(*start);
+			page = virt_to_page(__va(pud_val(*start)));
+			__free_pages_core(page, 0);
+		}
+	}
+}
+
+static void pkram_free_pgt_walk_p4d(pgd_t addr)
+{
+	struct page *page;
+	p4d_t *start;
+	int i;
+
+	if (PTRS_PER_P4D == 1)
+		return pkram_free_pgt_walk_pud(__p4d(pgd_val(addr)));
+
+	start = (p4d_t *)pgd_page_vaddr(addr);
+	for (i = 0; i < PTRS_PER_P4D; i++, start++) {
+		if (!p4d_none(*start)) {
+			if (p4d_large(*start)) {
+				WARN_ONCE(1, "PKRAM: unexpected p4d hugepage\n");
+				continue;
+			}
+			pkram_free_pgt_walk_pud(*start);
+			page = virt_to_page(__va(p4d_val(*start)));
+			__free_pages_core(page, 0);
+		}
+	}
+}
+
+/*
+ * Free the pagetable passed from the previous boot.
+ */
+void pkram_free_pgt_walk_pgd(pgd_t *pgd)
+{
+	pgd_t *start = pgd;
+	struct page *page;
+	int i;
+
+	for (i = 0; i < PTRS_PER_PGD; i++, start++) {
+		if (!pgd_none(*start)) {
+			pkram_free_pgt_walk_p4d(*start);
+			page = virt_to_page(__va(pgd_val(*start)));
+			__free_pages_core(page, 0);
+		}
+	}
+}
-- 
2.13.3

