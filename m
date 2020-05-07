Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B12861C7EC1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 May 2020 02:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728365AbgEGAoM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 May 2020 20:44:12 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:38392 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728301AbgEGAoM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 May 2020 20:44:12 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0470bn87092995;
        Thu, 7 May 2020 00:43:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=7FlNkRF1oblAeXIUyymeHAqshs+dkh2quuYtBUHergU=;
 b=kcHW/TPO1YMNUkHh0blDwat1m2OeaHhivZ//2tjB83CvkHLWVfxwAMzKQjxlyklkvESi
 xSqemzMlgECWBv4ppxad67bEfH1xwDDIoxsBgLWFpZ4RPaz7deQs6LQFMr4rGoQNM0HY
 iCRzbXY6UJCYRXPu8Ab20cpqQZv3UBKqrPv2MBDT6rohUz5+JcXi2NTYEgB2aILy3ykj
 OhkqeIxFrE/mglKShKR10Gp2Vdq15HYSME8zuWBCGdtB5uZ0YOuRPCNkK5mcgxXtzDLm
 Gr0aeDT2ATIBEPPK6peQvmiTmlhx09vYA8AMq0GMJ3eapI+0BRIbyrVzyGUHC8OAi/5m NA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 30s1gnd8kd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 May 2020 00:43:07 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0470bm3P131725;
        Thu, 7 May 2020 00:43:06 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 30t1r958s2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 May 2020 00:43:06 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0470h5NU019964;
        Thu, 7 May 2020 00:43:05 GMT
Received: from ayz-linux.localdomain (/68.7.158.207)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 06 May 2020 17:43:04 -0700
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
Subject: [RFC 14/43] mm: memblock: PKRAM: prevent memblock resize from clobbering preserved pages
Date:   Wed,  6 May 2020 17:41:40 -0700
Message-Id: <1588812129-8596-15-git-send-email-anthony.yznaga@oracle.com>
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

The size of the memblock reserved array may be increased while preserved
pages are being reserved. When this happens, preserved pages that have
not yet been reserved are at risk for being clobbered when space for a
larger array is allocated.
When called from memblock_double_array(), a wrapper around
memblock_find_in_range() walks the preserved pages pagetable to find
sufficiently sized ranges without preserved pages and passes them to
memblock_find_in_range().

Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 include/linux/pkram.h |  3 +++
 mm/memblock.c         | 15 +++++++++++++--
 mm/pkram.c            | 51 +++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 67 insertions(+), 2 deletions(-)

diff --git a/include/linux/pkram.h b/include/linux/pkram.h
index edc5d8bef9d3..409022e1472f 100644
--- a/include/linux/pkram.h
+++ b/include/linux/pkram.h
@@ -62,6 +62,9 @@ struct page *pkram_load_page(struct pkram_stream *ps, unsigned long *index,
 ssize_t pkram_write(struct pkram_stream *ps, const void *buf, size_t count);
 size_t pkram_read(struct pkram_stream *ps, void *buf, size_t count);
 
+phys_addr_t pkram_memblock_find_in_range(phys_addr_t start, phys_addr_t end,
+					 phys_addr_t size, phys_addr_t align);
+
 #ifdef CONFIG_PKRAM
 extern unsigned long pkram_reserved_pages;
 void pkram_reserve(void);
diff --git a/mm/memblock.c b/mm/memblock.c
index c79ba6f9920c..69ae883b8d21 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -16,6 +16,7 @@
 #include <linux/kmemleak.h>
 #include <linux/seq_file.h>
 #include <linux/memblock.h>
+#include <linux/pkram.h>
 
 #include <asm/sections.h>
 #include <linux/io.h>
@@ -349,6 +350,16 @@ phys_addr_t __init_memblock memblock_find_in_range(phys_addr_t start,
 	return ret;
 }
 
+phys_addr_t __init_memblock __memblock_find_in_range(phys_addr_t start,
+					phys_addr_t end, phys_addr_t size,
+					phys_addr_t align)
+{
+	if (IS_ENABLED(CONFIG_PKRAM))
+		return pkram_memblock_find_in_range(start, end, size, align);
+	else
+		return memblock_find_in_range(start, end, size, align);
+}
+
 static void __init_memblock memblock_remove_region(struct memblock_type *type, unsigned long r)
 {
 	type->total_size -= type->regions[r].size;
@@ -447,11 +458,11 @@ static int __init_memblock memblock_double_array(struct memblock_type *type,
 		if (type != &memblock.reserved)
 			new_area_start = new_area_size = 0;
 
-		addr = memblock_find_in_range(new_area_start + new_area_size,
+		addr = __memblock_find_in_range(new_area_start + new_area_size,
 						memblock.current_limit,
 						new_alloc_size, PAGE_SIZE);
 		if (!addr && new_area_size)
-			addr = memblock_find_in_range(0,
+			addr = __memblock_find_in_range(0,
 				min(new_area_start, memblock.current_limit),
 				new_alloc_size, PAGE_SIZE);
 
diff --git a/mm/pkram.c b/mm/pkram.c
index dd3c89614010..e49c9bcd3854 100644
--- a/mm/pkram.c
+++ b/mm/pkram.c
@@ -1238,3 +1238,54 @@ void pkram_free_pgt(void)
 	__free_pages_core(virt_to_page(pkram_pgd), 0);
 	pkram_pgd = NULL;
 }
+
+static int __init_memblock pkram_memblock_find_cb(struct pkram_pg_state *st, unsigned long base, unsigned long size)
+{
+	unsigned long end = base + size;
+	unsigned long addr;
+
+	if (size < st->min_size)
+		return 0;
+
+	addr =  memblock_find_in_range(base, end, st->min_size, PAGE_SIZE);
+	if (!addr)
+		return 0;
+
+	st->retval = addr;
+	return 1;
+}
+
+/*
+ * It may be necessary to allocate a larger reserved memblock array
+ * while populating it with ranges of preserved pages.  To avoid
+ * trampling preserved pages that have not yet been added to the
+ * memblock reserved list this function implements a wrapper around
+ * memblock_find_in_range() that restricts searches to subranges
+ * that do not contain preserved pages.
+ */
+phys_addr_t __init_memblock pkram_memblock_find_in_range(phys_addr_t start,
+					phys_addr_t end, phys_addr_t size,
+					phys_addr_t align)
+{
+	struct pkram_pg_state st = {
+		.range_cb = pkram_memblock_find_cb,
+		.min_addr = start,
+		.max_addr = end,
+		.min_size = PAGE_ALIGN(size),
+		.find_holes = true,
+	};
+
+	if (!pkram_reservation_in_progress)
+		return memblock_find_in_range(start, end, size, align);
+
+	if (!pkram_pgd) {
+		WARN_ONCE(1, "No preserved pages pagetable\n");
+		return memblock_find_in_range(start, end, size, align);
+	}
+
+	WARN_ONCE(memblock_bottom_up(), "PKRAM: bottom up memblock allocation not yet supported\n");
+
+	pkram_walk_pgt_rev(&st, pkram_pgd);
+
+	return st.retval;
+}
-- 
2.13.3

