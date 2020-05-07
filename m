Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EDCD1C7F1B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 May 2020 02:47:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728748AbgEGApm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 May 2020 20:45:42 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:38542 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728711AbgEGApk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 May 2020 20:45:40 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0470dEUI097500;
        Thu, 7 May 2020 00:44:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=ERMI4X4SzsQD4gAyYFAitYboRjs4H+C7qGOMU4P5U5w=;
 b=nR0OSEw/DvPNl9VYaj/Ak5biC59GnYGNIl5WQf5hnttYGpCE+hCzH04GgFFOJHLe9304
 l2dCwTZ2mUP8uX8uE6MIkQ5nz1AtnTIop8y59PSxkfzRYXKpyzttiW96qTCEEqXI5pPg
 nHnl4Ayfbaxsf8xyp2mvb0z544E6ealj8rS+aBok46UoclSSA7PuVpeeic97ivg2PFpZ
 5+3rdAEyLoyYz/tMD1ikokxl+2tXKO9md3r3n/Jp8WjctISXJqa3VJGNot17BlcADz4W
 ZUI1CXRETSuC63ayWY7FC9nD+BrycaicYQ2Lp8Nuo4lrwYimTkkods9kTa2WACEx7uIt LQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 30usgq4h2b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 May 2020 00:44:47 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0470at2I136306;
        Thu, 7 May 2020 00:44:47 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 30sjdwrt4e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 May 2020 00:44:47 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0470ih14026275;
        Thu, 7 May 2020 00:44:43 GMT
Received: from ayz-linux.localdomain (/68.7.158.207)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 06 May 2020 17:44:43 -0700
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
Subject: [RFC 36/43] PKRAM: add support for loading pages in bulk
Date:   Wed,  6 May 2020 17:42:02 -0700
Message-Id: <1588812129-8596-37-git-send-email-anthony.yznaga@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1588812129-8596-1-git-send-email-anthony.yznaga@oracle.com>
References: <1588812129-8596-1-git-send-email-anthony.yznaga@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9613 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=2 mlxscore=0
 bulkscore=0 adultscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
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

This patch adds three functions:

pkram_prepare_load_pages()
  Called after calling pkram_prepare_load_obj()

pkram_load_pages()
  Loads some number of pages that are contiguous by their original
  file index values.  The index of the first page, an array of the
  page pointers, and the number of pages in the array are provided
  to the caller.

pkram_finish_load_pages()
  Called when no more pages will be loaded from the pkram_obj.

Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 include/linux/pkram.h |   6 +++
 mm/pkram.c            | 106 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 112 insertions(+)

diff --git a/include/linux/pkram.h b/include/linux/pkram.h
index bf2e138b044e..3f059791f88c 100644
--- a/include/linux/pkram.h
+++ b/include/linux/pkram.h
@@ -18,6 +18,9 @@ struct pkram_stream {
 	struct pkram_link *link;		/* current link */
 	unsigned int entry_idx;		/* next entry in link */
 
+	struct page **pages;
+	unsigned int nr_pages;
+
 	unsigned long next_index;
 	struct address_space *mapping;
 	struct mm_struct *mm;
@@ -60,14 +63,17 @@ void pkram_discard_save(struct pkram_stream *ps);
 
 int pkram_prepare_load(struct pkram_stream *ps, const char *name);
 int pkram_prepare_load_obj(struct pkram_stream *ps);
+int pkram_prepare_load_pages(struct pkram_stream *ps);
 void pkram_finish_load(struct pkram_stream *ps);
 void pkram_finish_load_obj(struct pkram_stream *ps);
+void pkram_finish_load_pages(struct pkram_stream *ps);
 
 #define PKRAM_PAGE_TRANS_HUGE	0x1	/* page is a transparent hugepage */
 
 int pkram_save_page(struct pkram_stream *ps, struct page *page, short flags);
 struct page *pkram_load_page(struct pkram_stream *ps, unsigned long *index,
 			     short *flags);
+int pkram_load_pages(struct pkram_stream *ps, unsigned long *index);
 
 ssize_t pkram_write(struct pkram_stream *ps, const void *buf, size_t count);
 size_t pkram_read(struct pkram_stream *ps, void *buf, size_t count);
diff --git a/mm/pkram.c b/mm/pkram.c
index 042c14dedc25..ef092aa5ce7a 100644
--- a/mm/pkram.c
+++ b/mm/pkram.c
@@ -820,6 +820,37 @@ int pkram_prepare_load_obj(struct pkram_stream *ps)
 }
 
 /**
+ * Initialize stream @ps for loading preserved pages from it.
+ *
+ * Returns 0 on success, -errno on failure.
+ *
+ * Error values:
+ *	%ENOMEM: insufficient memory available
+ *
+ * After the load has finished, pkram_finish_load_pages() is to be called.
+ */
+int pkram_prepare_load_pages(struct pkram_stream *ps)
+{
+	BUG_ON((ps->node->flags & PKRAM_ACCMODE_MASK) != PKRAM_LOAD);
+
+	ps->pages = kzalloc(PAGE_SIZE, GFP_KERNEL);
+	if (!ps->pages)
+		return -ENOMEM;
+
+	return 0;
+}
+
+/**
+ * Finish the load of preserved pages started with pkram_prepare_load_pages()
+ */
+void pkram_finish_load_pages(struct pkram_stream *ps)
+{
+	BUG_ON((ps->node->flags & PKRAM_ACCMODE_MASK) != PKRAM_LOAD);
+
+	kfree(ps->pages);
+}
+
+/**
  * Finish the load of a preserved memory object started with
  * pkram_prepare_load_obj() freeing the object and any data that has not
  * been loaded from it.
@@ -1066,6 +1097,81 @@ struct page *pkram_load_page(struct pkram_stream *ps, unsigned long *index, shor
 }
 
 /**
+ * Load pages from the preserved memory object associated with stream
+ * @ps. The stream must have been initialized with pkram_prepare_load(),
+ * pkram_prepare_load_obj(), and pkram_prepare_load_pages().
+ * The page entries of a single pkram_link are processed, and the stream
+ * 'pages' buffer is populated with the page pointers.
+ *
+ * Returns 0 if one or more pages are loaded or -ENODATA if there are no
+ * pages to load.
+ *
+ * The pages loaded have an incremented refcount either because the page
+ * was initialized with a refcount of 1 at boot or because the page was
+ * subsequently preserved which increased the refcount.
+ */
+int pkram_load_pages(struct pkram_stream *ps, unsigned long *index)
+{
+	struct pkram_link *link = ps->link;
+	int nr_entries = 0;
+	int i;
+
+	if (!link) {
+		link = pkram_remove_link(ps->obj);
+		if (!link)
+			return -ENODATA;
+	}
+
+	*index = link->index;
+
+	for (i = 0; i < PKRAM_LINK_ENTRIES_MAX; i++) {
+		unsigned long p = link->entry[i];
+		struct page *page;
+		short flags;
+
+		if (!p)
+			break;
+
+		flags = (p >> PKRAM_ENTRY_FLAGS_SHIFT) & PKRAM_ENTRY_FLAGS_MASK;
+		nr_entries++;
+
+		page = pfn_to_page(PHYS_PFN(p));
+		ps->pages[i] = page;
+
+		if (flags & PKRAM_PAGE_TRANS_HUGE) {
+			int order = p & PKRAM_ENTRY_ORDER_MASK;
+			int nr_pages = 1 << order;
+			int j;
+
+			for (j = 0; j < nr_pages; j++) {
+				struct page *p = page + j;
+
+				ClearPageReserved(p);
+			}
+
+			prep_compound_page(page, order);
+			prep_transhuge_page(page);
+		} else {
+			ClearPageReserved(page);
+		}
+
+		pkram_remove_identity_map(page);
+	}
+
+	ps->nr_pages = nr_entries;
+
+	/* Advance to next pkram_link page and free this one */
+	if (link->link_pfn)
+		ps->link = pfn_to_kaddr(link->link_pfn);
+	else
+		ps->link = NULL;
+
+	pkram_free_page(link);
+
+	return 0;
+}
+
+/**
  * Copy @count bytes from @buf to the preserved memory node and object
  * associated with stream @ps. The stream must have been initialized with
  * pkram_prepare_save() and pkram_prepare_save_obj().
-- 
2.13.3

