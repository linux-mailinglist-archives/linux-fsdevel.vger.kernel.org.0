Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 609F11C7F3D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 May 2020 02:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728965AbgEGAqa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 May 2020 20:46:30 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:40278 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728886AbgEGAqJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 May 2020 20:46:09 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0470d0Ej105240;
        Thu, 7 May 2020 00:45:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=tO+BBoL6QA83N8AKybR2dW6y4zRDAJKByikm9WLIvJA=;
 b=e6tBMfZvQU1I7oBrLvbLNbk8ehB/ncx827a2VLGsvklCAyzd8qo2KC8U01bEFq8Xq+yC
 ezx4eY6eLsFamhw4qwLpItroIYvmiLNZ9TyGONKuxkX/mUMrWXX156AnYAG0PpSS/JpV
 clkpPQPh2XNuUiPA89c3tqYVFYgYm6zMZ88YPkBCDH1RGsWrLkHoinDtzVy/mNMC6ZoM
 Eip8SgOqH/NcYWiu7gMFjQfImEuPvQ1iD7Wi1tnf2s81oJbUBGo9TJV65x3YgNuWVZe6
 /Z0j4hQIVRZP3FbQbHfeRuL9D25iCA1SP6a7ALImGzCsdL6cCKd65RYuG3KEJHhIYTc9 TA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 30s1gnd8sb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 May 2020 00:45:07 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0470bT2v098614;
        Thu, 7 May 2020 00:45:06 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 30sjnma6ts-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 May 2020 00:45:06 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0470j5lH020685;
        Thu, 7 May 2020 00:45:05 GMT
Received: from ayz-linux.localdomain (/68.7.158.207)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 06 May 2020 17:45:04 -0700
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
Subject: [RFC 42/43] shmem: reduce time holding xa_lock when inserting pages
Date:   Wed,  6 May 2020 17:42:08 -0700
Message-Id: <1588812129-8596-43-git-send-email-anthony.yznaga@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1588812129-8596-1-git-send-email-anthony.yznaga@oracle.com>
References: <1588812129-8596-1-git-send-email-anthony.yznaga@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9613 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005070001
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9613 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 mlxscore=0
 spamscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 phishscore=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005070001
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Rather than adding one page at a time to the page cache and taking the
page cache xarray lock each time, where possible add pages in bulk by
first populating an xarray node outside of the page cache before taking
the lock to insert it.
When a group of pages to be inserted will fill an xarray node, add them
to a local xarray, export the xarray node, and then take the lock on the
page cache xarray and insert the node.

Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 mm/shmem.c | 145 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 138 insertions(+), 7 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index f621d863e362..9d3c4e1f2dc1 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -732,17 +732,130 @@ static void shmem_delete_from_page_cache(struct page *page, void *radswap)
 	BUG_ON(error);
 }
 
+static int shmem_add_aligned_to_page_cache(struct page *pages[], int npages,
+					   struct address_space *mapping,
+					   pgoff_t index, gfp_t gfp, int order)
+{
+	int xa_shift = order + XA_CHUNK_SHIFT - (order % XA_CHUNK_SHIFT);
+	XA_STATE_ORDER(xas, &mapping->i_pages, index, xa_shift);
+	struct xa_state *xas_ptr = &xas;
+	struct xarray xa_tmp;
+	/*
+	 * Specify order so xas_create_range() only needs to be called once
+	 * to allocate the entire range.  This guarantees that xas_store()
+	 * will not fail due to lack of memory.
+	 * Specify index == 0 so the minimum necessary nodes are allocated.
+	 */
+	XA_STATE_ORDER(xas_tmp, &xa_tmp, 0, xa_shift);
+	unsigned long nr = 1UL << order;
+	struct xa_node *node;
+	int i;
+
+	if (npages * nr != 1 << xa_shift) {
+		WARN_ONCE(1, "npages (%d) not aligned to xa_shift\n", npages);
+		return -EINVAL;
+	}
+	if (!IS_ALIGNED(index, 1 << xa_shift)) {
+		WARN_ONCE(1, "index (%lu) not aligned to xa_shift\n", index);
+		return -EINVAL;
+	}
+
+	for (i = 0; i < npages; i++) {
+		VM_BUG_ON_PAGE(PageTail(pages[i]), pages[i]);
+		VM_BUG_ON_PAGE(!PageLocked(pages[i]), pages[i]);
+		VM_BUG_ON_PAGE(!PageSwapBacked(pages[i]), pages[i]);
+
+		page_ref_add(pages[i], nr);
+		pages[i]->mapping = mapping;
+		pages[i]->index = index + (i * nr);
+	}
+
+	xa_init(&xa_tmp);
+	do {
+		xas_lock(&xas_tmp);
+		xas_create_range(&xas_tmp);
+		if (xas_error(&xas_tmp))
+			goto unlock;
+		for (i = 0; i < npages; i++) {
+			int j = 0;
+next:
+			xas_store(&xas_tmp, pages[i]);
+			if (++j < nr) {
+				xas_next(&xas_tmp);
+				goto next;
+			}
+			if (i < npages - 1)
+				xas_next(&xas_tmp);
+		}
+		xas_set_order(&xas_tmp, 0, xa_shift);
+		node = xas_export_node(&xas_tmp);
+unlock:
+		xas_unlock(&xas_tmp);
+	} while (xas_nomem(&xas_tmp, gfp));
+
+	if (xas_error(&xas_tmp)) {
+		xas_ptr = &xas_tmp;
+		goto error;
+	}
+
+	do {
+		xas_lock_irq(&xas);
+		xas_import_node(&xas, node);
+		if (xas_error(&xas))
+			goto unlock1;
+		mapping->nrpages += nr * npages;
+		xas_unlock(&xas);
+		for (i = 0; i < npages; i++) {
+			__mod_node_page_state(page_pgdat(pages[i]), NR_FILE_PAGES, nr);
+			__mod_node_page_state(page_pgdat(pages[i]), NR_SHMEM, nr);
+			if (PageTransHuge(pages[i])) {
+				count_vm_event(THP_FILE_ALLOC);
+				__inc_node_page_state(pages[i], NR_SHMEM_THPS);
+			}
+		}
+		local_irq_enable();
+		break;
+unlock1:
+		xas_unlock_irq(&xas);
+	} while (xas_nomem(&xas, gfp));
+
+	if (!xas_error(&xas))
+		return 0;
+
+error:
+	for (i = 0; i < npages; i++) {
+		pages[i]->mapping = NULL;
+		page_ref_sub(pages[i], nr);
+	}
+	return xas_error(xas_ptr);
+}
+
 static int shmem_add_pages_to_cache(struct page *pages[], int npages,
 				struct address_space *mapping,
 				pgoff_t start, gfp_t gfp)
 {
 	pgoff_t index = start;
 	int err = 0;
-	int i;
+	int i, j;
 
 	i = 0;
 	while (i < npages) {
 		if (PageTransHuge(pages[i])) {
+			if (IS_ALIGNED(index, 4096) && i+8 <= npages) {
+				for (j = 1; j < 8; j++) {
+					if (!PageTransHuge(pages[i+j]))
+						break;
+				}
+				if (j == 8) {
+					err = shmem_add_aligned_to_page_cache(&pages[i], 8, mapping, index, gfp, HPAGE_PMD_ORDER);
+					if (err)
+						goto done;
+					index += HPAGE_PMD_NR * 8;
+					i += 8;
+					continue;
+				}
+			}
+
 			err = shmem_add_to_page_cache_fast(pages[i], mapping, index, gfp);
 			if (err)
 				break;
@@ -751,13 +864,31 @@ static int shmem_add_pages_to_cache(struct page *pages[], int npages,
 			continue;
 		}
 
-		err = shmem_add_to_page_cache_fast(pages[i], mapping, index, gfp);
-		if (err)
-			break;
-		index++;
-		i++;
-	}
+		for (j = 1; i + j < npages; j++) {
+			if (PageTransHuge(pages[i + j]))
+				break;
+		}
+
+		while (j > 0) {
+			if (IS_ALIGNED(index, 64) && j >= 64) {
+				err = shmem_add_aligned_to_page_cache(&pages[i], 64, mapping, index, gfp, 0);
+				if (err)
+					goto done;
+				index += 64;
+				i += 64;
+				j -= 64;
+				continue;
+			}
 
+			err = shmem_add_to_page_cache_fast(pages[i], mapping, index, gfp);
+			if (err)
+				goto done;
+			index++;
+			i++;
+			j--;
+		}
+	}
+done:
 	return err;
 }
 
-- 
2.13.3

