Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F1AB1C7EB0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 May 2020 02:44:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728199AbgEGAny (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 May 2020 20:43:54 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:38070 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728010AbgEGAnv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 May 2020 20:43:51 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0470cDPd093126;
        Thu, 7 May 2020 00:42:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=zbg9yJyCJmJxhHSmdBbD25d4JQwY7L3Qzo2gYkXKc+M=;
 b=NYghlWuaON7yX8JJzdmXURt2zP24mBwfNQAwXmmaGa2VItI56EnRCd8ip9nnfT+v9qBS
 bAQFDt1JBrpfkTL+nlnKsXdCT3dK8TOM2pW5F+IgGxw36XLBjWj54jMm/n3Wc0yoJNiL
 27g7H9L5tjT2ZbEWfHLiCQzKsNymuEKVw+tPVI1xwdAXrkl7FSBj3x0na85W1of6unKg
 Zi7XoRxMHGDdORF1iacWwnOfTsrShL+dgwK5+clmmm2mPtX3Dbn/6ctRLRxTJnX0r48r
 TtQNNZcEPEOOzGp0wJr6GMMrB65ym30KuUEh5RH952jmMMH3uOc5xnw4xv/88sd84gzh ZQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 30s1gnd8hn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 May 2020 00:42:41 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0470alqm170682;
        Thu, 7 May 2020 00:42:41 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 30us7p2kqb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 May 2020 00:42:41 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0470gcTP024000;
        Thu, 7 May 2020 00:42:38 GMT
Received: from ayz-linux.localdomain (/68.7.158.207)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 06 May 2020 17:42:38 -0700
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
Subject: [RFC 06/43] mm: PKRAM: implement byte stream operations
Date:   Wed,  6 May 2020 17:41:32 -0700
Message-Id: <1588812129-8596-7-git-send-email-anthony.yznaga@oracle.com>
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

This patch adds the ability to save arbitrary byte streams up to a
total length of one page to a PKRAM object using pkram_write() to be
restored later using pkram_read().

Originally-by: Vladimir Davydov <vdavydov.dev@gmail.com>
Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 include/linux/pkram.h |  4 +++
 mm/pkram.c            | 84 +++++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 86 insertions(+), 2 deletions(-)

diff --git a/include/linux/pkram.h b/include/linux/pkram.h
index 584cadb662b4..a58dd2ea835a 100644
--- a/include/linux/pkram.h
+++ b/include/linux/pkram.h
@@ -17,6 +17,10 @@ struct pkram_stream {
 	unsigned int entry_idx;		/* next entry in link */
 
 	unsigned long next_index;
+
+	/* byte data */
+	struct page *data_page;
+	unsigned int data_offset;
 };
 
 #define PKRAM_NAME_MAX		256	/* including nul */
diff --git a/mm/pkram.c b/mm/pkram.c
index 9164060e36f5..06b471eea0b0 100644
--- a/mm/pkram.c
+++ b/mm/pkram.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/err.h>
 #include <linux/gfp.h>
+#include <linux/highmem.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/list.h>
@@ -42,6 +43,8 @@ struct pkram_link {
 	((PAGE_SIZE-sizeof(struct pkram_link))/sizeof(pkram_entry_t))
 
 struct pkram_obj {
+	__u64	data_pfn;	/* points to the byte data */
+	__u64	data_len;	/* byte data size */
 	__u64	link_pfn;	/* points to the first link of the object */
 	__u64	obj_pfn;	/* points to the next object in the list */
 };
@@ -407,6 +410,9 @@ void pkram_finish_load_obj(struct pkram_stream *ps)
 		}
 	}
 
+	if (ps->data_page)
+		pkram_free_page(page_address(ps->data_page));
+
 	pkram_truncate_obj(obj);
 	pkram_free_page(obj);
 }
@@ -422,6 +428,9 @@ void pkram_finish_load(struct pkram_stream *ps)
 
 	BUG_ON((node->flags & PKRAM_ACCMODE_MASK) != PKRAM_LOAD);
 
+	if (ps->data_page)
+		put_page(ps->data_page);
+
 	pkram_truncate_node(node);
 	pkram_free_page(node);
 }
@@ -581,10 +590,41 @@ struct page *pkram_load_page(struct pkram_stream *ps, unsigned long *index, shor
  *
  * On success, returns the number of bytes written, which is always equal to
  * @count. On failure, -errno is returned.
+ *
+ * Error values:
+ *    %ENOMEM: insufficient amount of memory available
  */
 ssize_t pkram_write(struct pkram_stream *ps, const void *buf, size_t count)
 {
-	return -ENOSYS;
+	struct pkram_node *node = ps->node;
+	struct pkram_obj *obj = ps->obj;
+	void *addr;
+
+	BUG_ON((node->flags & PKRAM_ACCMODE_MASK) != PKRAM_SAVE);
+
+	if (!ps->data_page) {
+		struct page *page;
+
+		page = pkram_alloc_page((ps->gfp_mask & GFP_RECLAIM_MASK) |
+				       __GFP_HIGHMEM | __GFP_ZERO);
+		if (!page)
+			return -ENOMEM;
+
+		ps->data_page = page;
+		ps->data_offset = 0;
+		obj->data_pfn = page_to_pfn(page);
+	}
+
+	BUG_ON(count > PAGE_SIZE - ps->data_offset);
+
+	addr = kmap_atomic(ps->data_page);
+	memcpy(addr + ps->data_offset, buf, count);
+	kunmap_atomic(addr);
+
+	obj->data_len += count;
+	ps->data_offset += count;
+
+	return count;
 }
 
 /**
@@ -597,5 +637,45 @@ ssize_t pkram_write(struct pkram_stream *ps, const void *buf, size_t count)
  */
 size_t pkram_read(struct pkram_stream *ps, void *buf, size_t count)
 {
-	return 0;
+	struct pkram_node *node = ps->node;
+	struct pkram_obj *obj = ps->obj;
+	size_t copy_count;
+	char *addr;
+
+	BUG_ON((node->flags & PKRAM_ACCMODE_MASK) != PKRAM_LOAD);
+
+	if (!count || !obj->data_len)
+		return 0;
+
+	if (!ps->data_page) {
+		struct page *page;
+
+		page = pfn_to_page(obj->data_pfn);
+		if (!page)
+			return 0;
+
+		ps->data_page = page;
+		ps->data_offset = 0;
+		obj->data_pfn = 0;
+	}
+
+	BUG_ON(count > PAGE_SIZE - ps->data_offset);
+
+	copy_count = min_t(size_t, count, PAGE_SIZE - ps->data_offset);
+	if (copy_count > obj->data_len)
+		copy_count = obj->data_len;
+
+	addr = kmap_atomic(ps->data_page);
+	memcpy(buf, addr + ps->data_offset, copy_count);
+	kunmap_atomic(addr);
+
+	obj->data_len -= copy_count;
+	ps->data_offset += copy_count;
+
+	if (!obj->data_len) {
+		pkram_free_page(page_address(ps->data_page));
+		ps->data_page = NULL;
+	}
+
+	return copy_count;
 }
-- 
2.13.3

