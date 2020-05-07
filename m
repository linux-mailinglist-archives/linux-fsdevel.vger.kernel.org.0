Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F41C61C7F28
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 May 2020 02:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728105AbgEGAp7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 May 2020 20:45:59 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:38788 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728823AbgEGAp6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 May 2020 20:45:58 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0470dDks097472;
        Thu, 7 May 2020 00:45:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=7K77j/6mtxQ9j5vDJ+M7D2bl3GjRuKy3se3PRu5nsHg=;
 b=fknRxePLvSCA2rgFxv17tFilEvUcB8Sm1qixpcq8htEL5+jMu9HgoK4AmSWmU5S+ZkSA
 nDAhgsc9si0wjbVnFvNv/8X2KeIYxyingZ+wv8jvbeRn+nVmTFly4CU0yNcKBvY2+jVu
 c2D85RuZlAHnVFY0HdVTQEdHGa7aiJPbG99wIg4XJyPEW+jT33EouxaTBIY1nMaIv0lV
 CbQYJXCcHIp4hPBwSJR28UisseHnsGqGQwpfd6W5LjvXz7KtxddPjhifE9TJ6cNYG2Ae
 zzaUH0VA/so04hfFmVi7z0tTREp0xKaYemyw2Yl7K60g3PKDQvkRdYChSgUY6vCl9+rG 4Q== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 30usgq4h3c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 May 2020 00:45:00 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0470alm0170700;
        Thu, 7 May 2020 00:44:59 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 30us7p2prs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 May 2020 00:44:59 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0470iv2E020654;
        Thu, 7 May 2020 00:44:57 GMT
Received: from ayz-linux.localdomain (/68.7.158.207)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 06 May 2020 17:44:57 -0700
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
Subject: [RFC 40/43] shmem: initial support for adding multiple pages to pagecache
Date:   Wed,  6 May 2020 17:42:06 -0700
Message-Id: <1588812129-8596-41-git-send-email-anthony.yznaga@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1588812129-8596-1-git-send-email-anthony.yznaga@oracle.com>
References: <1588812129-8596-1-git-send-email-anthony.yznaga@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9613 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 mlxscore=0 spamscore=0
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

shmem_insert_pages() currently loops over the array of pages passed
to it and calls shmem_add_to_page_cache() for each one. Prepare
for adding pages to the pagecache in bulk by adding and using a
shmem_add_pages_to_cache() call.  For now it just iterates over
an array and adds pages individually, but improvements in performance
when multiple threads are adding to the same pagecache are achieved
by calling a new shmem_add_to_page_cache_fast() function that does
not check for conflicts and drops the xarray lock before updating stats.

Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 mm/shmem.c | 95 ++++++++++++++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 84 insertions(+), 11 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 678a396ba8d3..f621d863e362 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -660,6 +660,57 @@ static int shmem_add_to_page_cache(struct page *page,
 	return 0;
 }
 
+static int shmem_add_to_page_cache_fast(struct page *page,
+				   struct address_space *mapping,
+				   pgoff_t index, gfp_t gfp)
+{
+	XA_STATE_ORDER(xas, &mapping->i_pages, index, compound_order(page));
+	unsigned long nr = compound_nr(page);
+	unsigned long i = 0;
+
+	VM_BUG_ON_PAGE(PageTail(page), page);
+	VM_BUG_ON_PAGE(index != round_down(index, nr), page);
+	VM_BUG_ON_PAGE(!PageLocked(page), page);
+	VM_BUG_ON_PAGE(!PageSwapBacked(page), page);
+
+	page_ref_add(page, nr);
+	page->mapping = mapping;
+	page->index = index;
+
+	do {
+		xas_lock_irq(&xas);
+		xas_create_range(&xas);
+		if (xas_error(&xas))
+			goto unlock;
+next:
+		xas_store(&xas, page);
+		if (++i < nr) {
+			xas_next(&xas);
+			goto next;
+		}
+		mapping->nrpages += nr;
+		xas_unlock(&xas);
+		if (PageTransHuge(page)) {
+			count_vm_event(THP_FILE_ALLOC);
+			__inc_node_page_state(page, NR_SHMEM_THPS);
+		}
+		__mod_node_page_state(page_pgdat(page), NR_FILE_PAGES, nr);
+		__mod_node_page_state(page_pgdat(page), NR_SHMEM, nr);
+		local_irq_enable();
+		break;
+unlock:
+		xas_unlock_irq(&xas);
+	} while (xas_nomem(&xas, gfp));
+
+	if (xas_error(&xas)) {
+		page->mapping = NULL;
+		page_ref_sub(page, nr);
+		return xas_error(&xas);
+	}
+
+	return 0;
+}
+
 /*
  * Like delete_from_page_cache, but substitutes swap for page.
  */
@@ -681,6 +732,35 @@ static void shmem_delete_from_page_cache(struct page *page, void *radswap)
 	BUG_ON(error);
 }
 
+static int shmem_add_pages_to_cache(struct page *pages[], int npages,
+				struct address_space *mapping,
+				pgoff_t start, gfp_t gfp)
+{
+	pgoff_t index = start;
+	int err = 0;
+	int i;
+
+	i = 0;
+	while (i < npages) {
+		if (PageTransHuge(pages[i])) {
+			err = shmem_add_to_page_cache_fast(pages[i], mapping, index, gfp);
+			if (err)
+				break;
+			index += HPAGE_PMD_NR;
+			i++;
+			continue;
+		}
+
+		err = shmem_add_to_page_cache_fast(pages[i], mapping, index, gfp);
+		if (err)
+			break;
+		index++;
+		i++;
+	}
+
+	return err;
+}
+
 int shmem_insert_page(struct mm_struct *mm, struct inode *inode, pgoff_t index,
 		      struct page *page)
 {
@@ -844,17 +924,10 @@ int shmem_insert_pages(struct mm_struct *mm, struct inode *inode, pgoff_t index,
 
 	}
 
-	for (i = 0; i < npages; i++) {
-		err = shmem_add_to_page_cache(pages[i], mapping, index,
-					NULL, gfp & GFP_RECLAIM_MASK);
-		if (err)
-			goto out_truncate;
-
-		if (PageTransHuge(pages[i]))
-			index += HPAGE_PMD_NR;
-		else
-			index++;
-	}
+	err = shmem_add_pages_to_cache(pages, npages, mapping, index,
+					gfp & GFP_RECLAIM_MASK);
+	if (err)
+		goto out_truncate;
 
 	spin_lock(&info->lock);
 	info->alloced += nr;
-- 
2.13.3

