Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF161C7F0D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 May 2020 02:47:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728658AbgEGApc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 May 2020 20:45:32 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:39682 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727109AbgEGApb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 May 2020 20:45:31 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0470cFcS093150;
        Thu, 7 May 2020 00:44:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=DoQrZzU/UMsJZ2IxoUJb14SQbVfDKKaxGdtOnUPWmyk=;
 b=C4+OVNvvwb1kwbmns15EmlXY9rzfDHIB9UetOGbMnxHIDD72iydl9DK8TyWHsrV7hoON
 NlGymJDXMCb7mQYs5tvh0xbxx0IXo4j2n+4Qmtnparvw1yWqiDvgBC87b9arOKz2nX8z
 +N0U/G7DJFx0rfYkFpXKeyDP8lAXVViydT8IbMhZf/8QECxh91r0DRWrkb+oO+N5S4gI
 Te2L4bVGCgMM+hYZTvmkRd43auwozy6qVNCxC4L8nmQrOnPXoEh0+PfFPiCSQCpfeZFZ
 8/h7m8B9MtugkDRYI9OOxt/s0X5ccXnLzXwGbYy1cbl0Lg0MkIH9L7LJDe2+nrsl662C GQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 30s1gnd8q2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 May 2020 00:44:21 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0470bonI131815;
        Thu, 7 May 2020 00:44:21 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 30t1r95c43-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 May 2020 00:44:21 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0470iJvK020415;
        Thu, 7 May 2020 00:44:19 GMT
Received: from ayz-linux.localdomain (/68.7.158.207)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 06 May 2020 17:44:19 -0700
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
Subject: [RFC 30/43] memblock: add for_each_reserved_mem_range()
Date:   Wed,  6 May 2020 17:41:56 -0700
Message-Id: <1588812129-8596-31-git-send-email-anthony.yznaga@oracle.com>
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

To support deferred initialization of page structs for preserved
pages, add an iterator of the memblock reserved list that can select or
exclude ranges based on memblock flags.

Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 include/linux/memblock.h | 10 ++++++++++
 mm/memblock.c            | 51 +++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 60 insertions(+), 1 deletion(-)

diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index 27ab2b30ae1d..f348ebb750c9 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -145,6 +145,11 @@ void __next_mem_range_rev(u64 *idx, int nid, enum memblock_flags flags,
 void __next_reserved_mem_region(u64 *idx, phys_addr_t *out_start,
 				phys_addr_t *out_end);
 
+void __next_reserved_mem_range(u64 *idx, enum memblock_flags flags,
+			       enum memblock_flags exclflags,
+			       phys_addr_t *out_start, phys_addr_t *out_end,
+			       int *out_nid);
+
 void __memblock_free_late(phys_addr_t base, phys_addr_t size);
 
 /**
@@ -202,6 +207,11 @@ void __memblock_free_late(phys_addr_t base, phys_addr_t size);
 	     i != (u64)ULLONG_MAX;					\
 	     __next_reserved_mem_region(&i, p_start, p_end))
 
+#define for_each_reserved_mem_range(i, flags, exclflags, p_start, p_end, p_nid)\
+	for (i = 0UL, __next_reserved_mem_range(&i, flags, exclflags, p_start, p_end, p_nid);	\
+	     i != (u64)ULLONG_MAX;					\
+	     __next_reserved_mem_range(&i, flags, exclflags, p_start, p_end, p_nid))
+
 static inline bool memblock_is_hotpluggable(struct memblock_region *m)
 {
 	return m->flags & MEMBLOCK_HOTPLUG;
diff --git a/mm/memblock.c b/mm/memblock.c
index 1a9a2055ed11..33597f352dc0 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -987,6 +987,55 @@ void __init_memblock __next_reserved_mem_region(u64 *idx,
 	*idx = ULLONG_MAX;
 }
 
+/**
+ * __next_reserved_mem_range - next function for for_each_reserved_range()
+ * @idx: pointer to u64 loop variable
+ * @flags: pick blocks based on memory attributes
+ * @exclflags: exclude blocks based on memory attributes
+ * @out_start: ptr to phys_addr_t for start address of the range, can be %NULL
+ * @out_end: ptr to phys_addr_t for end address of the range, can be %NULL
+ * @out_nid: ptr to int for nid of the range, can be %NULL
+ *
+ * Iterate over all reserved memory ranges.
+ */
+void __init_memblock __next_reserved_mem_range(u64 *idx,
+					   enum memblock_flags flags,
+					   enum memblock_flags exclflags,
+					   phys_addr_t *out_start,
+					   phys_addr_t *out_end, int *out_nid)
+{
+	struct memblock_type *type = &memblock.reserved;
+	int _idx = *idx;
+
+	for (; _idx < type->cnt; _idx++) {
+		struct memblock_region *r = &type->regions[_idx];
+		phys_addr_t base = r->base;
+		phys_addr_t size = r->size;
+
+		/* skip preserved pages */
+		if ((exclflags & MEMBLOCK_PRESERVED) && memblock_is_preserved(r))
+			continue;
+
+		/* skip non-preserved pages */
+		if ((flags & MEMBLOCK_PRESERVED) && !memblock_is_preserved(r))
+			continue;
+
+		if (out_start)
+			*out_start = base;
+		if (out_end)
+			*out_end = base + size - 1;
+		if (out_nid)
+			*out_nid = r->nid;
+
+		_idx++;
+		*idx = (u64)_idx;
+		return;
+	}
+
+	/* signal end of iteration */
+	*idx = ULLONG_MAX;
+}
+
 static bool should_skip_region(struct memblock_region *m, int nid, int flags)
 {
 	int m_nid = memblock_get_region_node(m);
@@ -1011,7 +1060,7 @@ static bool should_skip_region(struct memblock_region *m, int nid, int flags)
 }
 
 /**
- * __next_mem_range - next function for for_each_free_mem_range() etc.
+ * __next__mem_range - next function for for_each_free_mem_range() etc.
  * @idx: pointer to u64 loop variable
  * @nid: node selector, %NUMA_NO_NODE for all nodes
  * @flags: pick from blocks based on memory attributes
-- 
2.13.3

