Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 108251C7F26
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 May 2020 02:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728833AbgEGAp6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 May 2020 20:45:58 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:38772 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728011AbgEGAp5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 May 2020 20:45:57 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0470eGfM098246;
        Thu, 7 May 2020 00:42:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=rwgijllW6M4XeYhmgrj3fFunHwUOc+7hS8CUFmbdL+Y=;
 b=R133pfJPycmJwf2nkOwOYFHZc44QZzHbHBW+GOTn/ard0CwPxFr1B5n0o2GLQy9oM38i
 HZE8RpmIPtKkvpdd5MKkyYJhpzkhaF3dJcsXnWRKGChHTCZNIUWkvV+5PjaK4cUQun9t
 Y56I+jDYIJcdEE8u1OnTCbSuRbZnSYOhcJQA3d/t0x1aiUlpWnvz2Ek1PEQyTT50cFnR
 QIrrys3PpUBpnz6QcXuClvEAQ/0styrGCrveOGqL2sc2a7+VJ3zrrnYu7Z80jADYzIb7
 tyUfLzsFfZA88gGJjIe6f7HTeRRJO909+XwIkCu1/FQlDhfbzDB7Vj/RIM/XxLdmflX6 Ug== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 30usgq4gw0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 May 2020 00:42:39 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0470bmCE131715;
        Thu, 7 May 2020 00:42:38 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 30t1r957v3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 May 2020 00:42:38 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0470gZvx025355;
        Thu, 7 May 2020 00:42:35 GMT
Received: from ayz-linux.localdomain (/68.7.158.207)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 06 May 2020 17:42:35 -0700
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
Subject: [RFC 05/43] mm: PKRAM: support preserving transparent hugepages
Date:   Wed,  6 May 2020 17:41:31 -0700
Message-Id: <1588812129-8596-6-git-send-email-anthony.yznaga@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1588812129-8596-1-git-send-email-anthony.yznaga@oracle.com>
References: <1588812129-8596-1-git-send-email-anthony.yznaga@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9613 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 suspectscore=2
 spamscore=0 mlxlogscore=999 malwarescore=0 phishscore=0 mlxscore=0
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

Support preserving a transparent hugepage by recording the page order and
a flag indicating it is a THP.  Use these values when the page is
restored to reconstruct the THP.

Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 include/linux/pkram.h |  2 ++
 mm/pkram.c            | 20 ++++++++++++++++----
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/include/linux/pkram.h b/include/linux/pkram.h
index f338d1c2aeb6..584cadb662b4 100644
--- a/include/linux/pkram.h
+++ b/include/linux/pkram.h
@@ -33,6 +33,8 @@ int pkram_prepare_load_obj(struct pkram_stream *ps);
 void pkram_finish_load(struct pkram_stream *ps);
 void pkram_finish_load_obj(struct pkram_stream *ps);
 
+#define PKRAM_PAGE_TRANS_HUGE	0x1	/* page is a transparent hugepage */
+
 int pkram_save_page(struct pkram_stream *ps, struct page *page, short flags);
 struct page *pkram_load_page(struct pkram_stream *ps, unsigned long *index,
 			     short *flags);
diff --git a/mm/pkram.c b/mm/pkram.c
index ab3053ca3539..9164060e36f5 100644
--- a/mm/pkram.c
+++ b/mm/pkram.c
@@ -21,6 +21,7 @@ typedef __u64 pkram_entry_t;
 
 #define PKRAM_ENTRY_FLAGS_SHIFT	0x5
 #define PKRAM_ENTRY_FLAGS_MASK	0x7f
+#define PKRAM_ENTRY_ORDER_MASK	0x1f
 
 /*
  * Keeps references to data pages saved to PKRAM.
@@ -434,6 +435,7 @@ static int __pkram_save_page(struct pkram_stream *ps,
 	struct pkram_link *link = ps->link;
 	struct pkram_obj *obj = ps->obj;
 	pkram_entry_t p;
+	int order;
 
 	if (!link || ps->entry_idx >= PKRAM_LINK_ENTRIES_MAX ||
 	    index != ps->next_index) {
@@ -452,10 +454,15 @@ static int __pkram_save_page(struct pkram_stream *ps,
 		ps->next_index = link->index = index;
 	}
 
-	ps->next_index++;
+	if (PageTransHuge(page))
+		flags |= PKRAM_PAGE_TRANS_HUGE;
+
+	order = compound_order(page);
+	ps->next_index += (1 << order);
 
 	get_page(page);
 	p = page_to_phys(page);
+	p |= order;
 	p |= ((flags & PKRAM_ENTRY_FLAGS_MASK) << PKRAM_ENTRY_FLAGS_SHIFT);
 	link->entry[ps->entry_idx] = p;
 	ps->entry_idx++;
@@ -485,8 +492,6 @@ int pkram_save_page(struct pkram_stream *ps, struct page *page, short flags)
 
 	BUG_ON((node->flags & PKRAM_ACCMODE_MASK) != PKRAM_SAVE);
 
-	BUG_ON(PageCompound(page));
-
 	return __pkram_save_page(ps, page, flags, page->index);
 }
 
@@ -499,6 +504,7 @@ static struct page *__pkram_load_page(struct pkram_stream *ps, unsigned long *in
 	struct pkram_link *link = ps->link;
 	struct page *page;
 	pkram_entry_t p;
+	int order;
 	short flgs;
 
 	if (!link) {
@@ -517,14 +523,20 @@ static struct page *__pkram_load_page(struct pkram_stream *ps, unsigned long *in
 	BUG_ON(!p);
 
 	flgs = (p >> PKRAM_ENTRY_FLAGS_SHIFT) & PKRAM_ENTRY_FLAGS_MASK;
+	order = p & PKRAM_ENTRY_ORDER_MASK;
 	page = pfn_to_page(PHYS_PFN(p));
 
+	if (flgs & PKRAM_PAGE_TRANS_HUGE) {
+		prep_compound_page(page, order);
+		prep_transhuge_page(page);
+	}
+
 	if (flags)
 		*flags = flgs;
 	if (index)
 		*index = ps->next_index;
 
-	ps->next_index++;
+	ps->next_index += (1 << order);
 
 	/* clear to avoid double free (see pkram_truncate_link()) */
 	link->entry[ps->entry_idx] = 0;
-- 
2.13.3

