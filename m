Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9804B6F3464
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 May 2023 18:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233094AbjEAQ7o (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 May 2023 12:59:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232523AbjEAQ6j (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 May 2023 12:58:39 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 611932D78
        for <linux-fsdevel@vger.kernel.org>; Mon,  1 May 2023 09:56:09 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-559d35837bbso53104707b3.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 May 2023 09:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682960154; x=1685552154;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Mri2z+LvwzIobpEl78ZbT4L3ds7H/B8V3mrszruJwqU=;
        b=t3klBo0fosZzY+6Mn34UkeRIZ8VlBk56iQvcqMHnlZoMdspE+7NdZvE4k2vyn3ecSC
         wFY0JV6O1SpEH2hrWnI2ZwvcFG9UuRrWrZ6FC4svxPT3iRFpboq1m9ULo8cCPr6ZaPHa
         Y3x/6J6egKUSo5bKdDK02WHSlKy43vJBZZpKM6scw7eAqstx/nyrECEQlmlwNzLP6+c1
         x6typBX0rqpw1oi/w9vTNxPJlYF7ooBhaib/snmI2nYMcyeE2e2JEAGsaa+GQO7ffHeg
         n1W4cCFYszTARUhVglWM9nb/Nb2Udwpan9HFpZ/k9Jx52FO/vN20r/r10gSwNfC0onxH
         nPNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682960154; x=1685552154;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mri2z+LvwzIobpEl78ZbT4L3ds7H/B8V3mrszruJwqU=;
        b=kh2d0v6QTPK4jWKM5V4rOXlhI6tc0Cw7P6H43pK+DL9q0gJor0HzD7UIUjLjXxp5Z9
         hsMIAgDyNNE1qMiNrmqzru1s1lykZIT52zBP8v227aZUM7xpdfcQqpQTNFVpF63OUoAl
         HYZl1sgA8eSyGyCi3Fsw1BjFC7V6clmzLH3kYI+b1AW+T8wYFeyb/OX2p7zRfHHKpuOJ
         obaynanGGCfQoILC6ax4lpavi5QB//l2EahLZnTdijHs1LPVRWhBQOB5Ra2AFNmeRTGj
         OFlFjFf/JFOJLh8U+YGgeFes7NXuU170cFtaZjsJIRyExvWsjDU9+VMYMQMMEJN4YjX0
         evTA==
X-Gm-Message-State: AC+VfDyvkm5eeAwDKq85i5fcLLDey2as2htA9/cBcljcCCebKyBmMeKm
        sbpFEy81jW6x1hQe+62KYeO9wR0rXfU=
X-Google-Smtp-Source: ACHHUZ5Am/AbJJDHaPOyxBcK1szyPNP1NGMyyYGzfCHWCVUgDFAOjYjnaEfI2KDePZpQQp6gXZXY+DFEDT8=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:6d24:3efd:facc:7ac4])
 (user=surenb job=sendgmr) by 2002:a81:9f09:0:b0:559:e830:60f1 with SMTP id
 s9-20020a819f09000000b00559e83060f1mr4600345ywn.8.1682960153830; Mon, 01 May
 2023 09:55:53 -0700 (PDT)
Date:   Mon,  1 May 2023 09:54:30 -0700
In-Reply-To: <20230501165450.15352-1-surenb@google.com>
Mime-Version: 1.0
References: <20230501165450.15352-1-surenb@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Message-ID: <20230501165450.15352-21-surenb@google.com>
Subject: [PATCH 20/40] mm: enable page allocation tagging
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     kent.overstreet@linux.dev, mhocko@suse.com, vbabka@suse.cz,
        hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de,
        dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com,
        corbet@lwn.net, void@manifault.com, peterz@infradead.org,
        juri.lelli@redhat.com, ldufour@linux.ibm.com,
        catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        x86@kernel.org, peterx@redhat.com, david@redhat.com,
        axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org,
        nathan@kernel.org, dennis@kernel.org, tj@kernel.org,
        muchun.song@linux.dev, rppt@kernel.org, paulmck@kernel.org,
        pasha.tatashin@soleen.com, yosryahmed@google.com,
        yuzhao@google.com, dhowells@redhat.com, hughd@google.com,
        andreyknvl@gmail.com, keescook@chromium.org,
        ndesaulniers@google.com, gregkh@linuxfoundation.org,
        ebiggers@google.com, ytcoode@gmail.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        bristot@redhat.com, vschneid@redhat.com, cl@linux.com,
        penberg@kernel.org, iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com,
        glider@google.com, elver@google.com, dvyukov@google.com,
        shakeelb@google.com, songmuchun@bytedance.com, jbaron@akamai.com,
        rientjes@google.com, minchan@google.com, kaleshsingh@google.com,
        surenb@google.com, kernel-team@android.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, linux-arch@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-modules@vger.kernel.org, kasan-dev@googlegroups.com,
        cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Redefine page allocators to record allocation tags upon their invocation.
Instrument post_alloc_hook and free_pages_prepare to modify current
allocation tag.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/alloc_tag.h   |  11 ++++
 include/linux/gfp.h         | 123 +++++++++++++++++++++++++-----------
 include/linux/page_ext.h    |   1 -
 include/linux/pagemap.h     |   9 ++-
 include/linux/pgalloc_tag.h |  38 +++++++++--
 mm/compaction.c             |   9 ++-
 mm/filemap.c                |   6 +-
 mm/mempolicy.c              |  30 ++++-----
 mm/mm_init.c                |   1 +
 mm/page_alloc.c             |  73 ++++++++++++---------
 10 files changed, 208 insertions(+), 93 deletions(-)

diff --git a/include/linux/alloc_tag.h b/include/linux/alloc_tag.h
index d913f8d9a7d8..07922d81b641 100644
--- a/include/linux/alloc_tag.h
+++ b/include/linux/alloc_tag.h
@@ -102,4 +102,15 @@ static inline void alloc_tag_add(union codetag_ref *ref, struct alloc_tag *tag,
 
 #endif
 
+#define alloc_hooks(_do_alloc, _res_type, _err)			\
+({									\
+	_res_type _res;							\
+	DEFINE_ALLOC_TAG(_alloc_tag, _old);				\
+									\
+	_res = _do_alloc;						\
+	alloc_tag_restore(&_alloc_tag, _old);				\
+	_res;								\
+})
+
+
 #endif /* _LINUX_ALLOC_TAG_H */
diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index ed8cb537c6a7..0cb4a515109a 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -6,6 +6,8 @@
 
 #include <linux/mmzone.h>
 #include <linux/topology.h>
+#include <linux/alloc_tag.h>
+#include <linux/sched.h>
 
 struct vm_area_struct;
 
@@ -174,42 +176,57 @@ static inline void arch_free_page(struct page *page, int order) { }
 static inline void arch_alloc_page(struct page *page, int order) { }
 #endif
 
-struct page *__alloc_pages(gfp_t gfp, unsigned int order, int preferred_nid,
+struct page *_alloc_pages2(gfp_t gfp, unsigned int order, int preferred_nid,
 		nodemask_t *nodemask);
-struct folio *__folio_alloc(gfp_t gfp, unsigned int order, int preferred_nid,
+#define __alloc_pages(_gfp, _order, _preferred_nid, _nodemask) \
+		alloc_hooks(_alloc_pages2(_gfp, _order, _preferred_nid, \
+					    _nodemask), struct page *, NULL)
+
+struct folio *_folio_alloc2(gfp_t gfp, unsigned int order, int preferred_nid,
 		nodemask_t *nodemask);
+#define __folio_alloc(_gfp, _order, _preferred_nid, _nodemask) \
+		alloc_hooks(_folio_alloc2(_gfp, _order, _preferred_nid, \
+					    _nodemask), struct folio *, NULL)
 
-unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
+unsigned long _alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 				nodemask_t *nodemask, int nr_pages,
 				struct list_head *page_list,
 				struct page **page_array);
-
-unsigned long alloc_pages_bulk_array_mempolicy(gfp_t gfp,
+#define __alloc_pages_bulk(_gfp, _preferred_nid, _nodemask, _nr_pages, \
+			   _page_list, _page_array) \
+		alloc_hooks(_alloc_pages_bulk(_gfp, _preferred_nid, \
+						_nodemask, _nr_pages, \
+						_page_list, _page_array), \
+						unsigned long, 0)
+
+unsigned long _alloc_pages_bulk_array_mempolicy(gfp_t gfp,
 				unsigned long nr_pages,
 				struct page **page_array);
+#define  alloc_pages_bulk_array_mempolicy(_gfp, _nr_pages, _page_array) \
+		alloc_hooks(_alloc_pages_bulk_array_mempolicy(_gfp, \
+					_nr_pages, _page_array), \
+					unsigned long, 0)
 
 /* Bulk allocate order-0 pages */
-static inline unsigned long
-alloc_pages_bulk_list(gfp_t gfp, unsigned long nr_pages, struct list_head *list)
-{
-	return __alloc_pages_bulk(gfp, numa_mem_id(), NULL, nr_pages, list, NULL);
-}
+#define alloc_pages_bulk_list(_gfp, _nr_pages, _list)				\
+	__alloc_pages_bulk(_gfp, numa_mem_id(), NULL, _nr_pages, _list, NULL)
 
-static inline unsigned long
-alloc_pages_bulk_array(gfp_t gfp, unsigned long nr_pages, struct page **page_array)
-{
-	return __alloc_pages_bulk(gfp, numa_mem_id(), NULL, nr_pages, NULL, page_array);
-}
+#define alloc_pages_bulk_array(_gfp, _nr_pages, _page_array)			\
+	__alloc_pages_bulk(_gfp, numa_mem_id(), NULL, _nr_pages, NULL, _page_array)
 
 static inline unsigned long
-alloc_pages_bulk_array_node(gfp_t gfp, int nid, unsigned long nr_pages, struct page **page_array)
+_alloc_pages_bulk_array_node(gfp_t gfp, int nid, unsigned long nr_pages, struct page **page_array)
 {
 	if (nid == NUMA_NO_NODE)
 		nid = numa_mem_id();
 
-	return __alloc_pages_bulk(gfp, nid, NULL, nr_pages, NULL, page_array);
+	return _alloc_pages_bulk(gfp, nid, NULL, nr_pages, NULL, page_array);
 }
 
+#define alloc_pages_bulk_array_node(_gfp, _nid, _nr_pages, _page_array) \
+	alloc_hooks(_alloc_pages_bulk_array_node(_gfp, _nid, _nr_pages, _page_array), \
+		    unsigned long, 0)
+
 static inline void warn_if_node_offline(int this_node, gfp_t gfp_mask)
 {
 	gfp_t warn_gfp = gfp_mask & (__GFP_THISNODE|__GFP_NOWARN);
@@ -229,21 +246,25 @@ static inline void warn_if_node_offline(int this_node, gfp_t gfp_mask)
  * online. For more general interface, see alloc_pages_node().
  */
 static inline struct page *
-__alloc_pages_node(int nid, gfp_t gfp_mask, unsigned int order)
+_alloc_pages_node2(int nid, gfp_t gfp_mask, unsigned int order)
 {
 	VM_BUG_ON(nid < 0 || nid >= MAX_NUMNODES);
 	warn_if_node_offline(nid, gfp_mask);
 
-	return __alloc_pages(gfp_mask, order, nid, NULL);
+	return _alloc_pages2(gfp_mask, order, nid, NULL);
 }
 
+#define  __alloc_pages_node(_nid, _gfp_mask, _order) \
+		alloc_hooks(_alloc_pages_node2(_nid, _gfp_mask, _order), \
+					struct page *, NULL)
+
 static inline
 struct folio *__folio_alloc_node(gfp_t gfp, unsigned int order, int nid)
 {
 	VM_BUG_ON(nid < 0 || nid >= MAX_NUMNODES);
 	warn_if_node_offline(nid, gfp);
 
-	return __folio_alloc(gfp, order, nid, NULL);
+	return _folio_alloc2(gfp, order, nid, NULL);
 }
 
 /*
@@ -251,32 +272,45 @@ struct folio *__folio_alloc_node(gfp_t gfp, unsigned int order, int nid)
  * prefer the current CPU's closest node. Otherwise node must be valid and
  * online.
  */
-static inline struct page *alloc_pages_node(int nid, gfp_t gfp_mask,
+static inline struct page *_alloc_pages_node(int nid, gfp_t gfp_mask,
 						unsigned int order)
 {
 	if (nid == NUMA_NO_NODE)
 		nid = numa_mem_id();
 
-	return __alloc_pages_node(nid, gfp_mask, order);
+	return _alloc_pages_node2(nid, gfp_mask, order);
 }
 
+#define  alloc_pages_node(_nid, _gfp_mask, _order) \
+		alloc_hooks(_alloc_pages_node(_nid, _gfp_mask, _order), \
+					struct page *, NULL)
+
 #ifdef CONFIG_NUMA
-struct page *alloc_pages(gfp_t gfp, unsigned int order);
-struct folio *folio_alloc(gfp_t gfp, unsigned order);
-struct folio *vma_alloc_folio(gfp_t gfp, int order, struct vm_area_struct *vma,
+struct page *_alloc_pages(gfp_t gfp, unsigned int order);
+struct folio *_folio_alloc(gfp_t gfp, unsigned int order);
+struct folio *_vma_alloc_folio(gfp_t gfp, int order, struct vm_area_struct *vma,
 		unsigned long addr, bool hugepage);
 #else
-static inline struct page *alloc_pages(gfp_t gfp_mask, unsigned int order)
+static inline struct page *_alloc_pages(gfp_t gfp_mask, unsigned int order)
 {
-	return alloc_pages_node(numa_node_id(), gfp_mask, order);
+	return _alloc_pages_node(numa_node_id(), gfp_mask, order);
 }
-static inline struct folio *folio_alloc(gfp_t gfp, unsigned int order)
+static inline struct folio *_folio_alloc(gfp_t gfp, unsigned int order)
 {
 	return __folio_alloc_node(gfp, order, numa_node_id());
 }
-#define vma_alloc_folio(gfp, order, vma, addr, hugepage)		\
-	folio_alloc(gfp, order)
+#define _vma_alloc_folio(gfp, order, vma, addr, hugepage)		\
+	_folio_alloc(gfp, order)
 #endif
+
+#define alloc_pages(_gfp, _order) \
+		alloc_hooks(_alloc_pages(_gfp, _order), struct page *, NULL)
+#define folio_alloc(_gfp, _order) \
+		alloc_hooks(_folio_alloc(_gfp, _order), struct folio *, NULL)
+#define vma_alloc_folio(_gfp, _order, _vma, _addr, _hugepage)		\
+		alloc_hooks(_vma_alloc_folio(_gfp, _order, _vma, _addr, \
+				_hugepage), struct folio *, NULL)
+
 #define alloc_page(gfp_mask) alloc_pages(gfp_mask, 0)
 static inline struct page *alloc_page_vma(gfp_t gfp,
 		struct vm_area_struct *vma, unsigned long addr)
@@ -286,12 +320,21 @@ static inline struct page *alloc_page_vma(gfp_t gfp,
 	return &folio->page;
 }
 
-extern unsigned long __get_free_pages(gfp_t gfp_mask, unsigned int order);
-extern unsigned long get_zeroed_page(gfp_t gfp_mask);
+extern unsigned long _get_free_pages(gfp_t gfp_mask, unsigned int order);
+#define __get_free_pages(_gfp_mask, _order) \
+		alloc_hooks(_get_free_pages(_gfp_mask, _order), unsigned long, 0)
+extern unsigned long _get_zeroed_page(gfp_t gfp_mask);
+#define get_zeroed_page(_gfp_mask) \
+		alloc_hooks(_get_zeroed_page(_gfp_mask), unsigned long, 0)
 
-void *alloc_pages_exact(size_t size, gfp_t gfp_mask) __alloc_size(1);
+void *_alloc_pages_exact(size_t size, gfp_t gfp_mask) __alloc_size(1);
+#define alloc_pages_exact(_size, _gfp_mask) \
+		alloc_hooks(_alloc_pages_exact(_size, _gfp_mask), void *, NULL)
 void free_pages_exact(void *virt, size_t size);
-__meminit void *alloc_pages_exact_nid(int nid, size_t size, gfp_t gfp_mask) __alloc_size(2);
+
+__meminit void *_alloc_pages_exact_nid(int nid, size_t size, gfp_t gfp_mask) __alloc_size(2);
+#define alloc_pages_exact_nid(_nid, _size, _gfp_mask) \
+		alloc_hooks(_alloc_pages_exact_nid(_nid, _size, _gfp_mask), void *, NULL)
 
 #define __get_free_page(gfp_mask) \
 		__get_free_pages((gfp_mask), 0)
@@ -354,10 +397,16 @@ static inline bool pm_suspended_storage(void)
 
 #ifdef CONFIG_CONTIG_ALLOC
 /* The below functions must be run on a range from a single zone. */
-extern int alloc_contig_range(unsigned long start, unsigned long end,
+extern int _alloc_contig_range(unsigned long start, unsigned long end,
 			      unsigned migratetype, gfp_t gfp_mask);
-extern struct page *alloc_contig_pages(unsigned long nr_pages, gfp_t gfp_mask,
-				       int nid, nodemask_t *nodemask);
+#define alloc_contig_range(_start, _end, _migratetype, _gfp_mask) \
+		alloc_hooks(_alloc_contig_range(_start, _end, _migratetype, \
+						 _gfp_mask), int, -ENOMEM)
+extern struct page *_alloc_contig_pages(unsigned long nr_pages, gfp_t gfp_mask,
+					int nid, nodemask_t *nodemask);
+#define alloc_contig_pages(_nr_pages, _gfp_mask, _nid, _nodemask) \
+		alloc_hooks(_alloc_contig_pages(_nr_pages, _gfp_mask, _nid, \
+						  _nodemask), struct page *, NULL)
 #endif
 void free_contig_range(unsigned long pfn, unsigned long nr_pages);
 
diff --git a/include/linux/page_ext.h b/include/linux/page_ext.h
index 67314f648aeb..cff15ee5440e 100644
--- a/include/linux/page_ext.h
+++ b/include/linux/page_ext.h
@@ -4,7 +4,6 @@
 
 #include <linux/types.h>
 #include <linux/stacktrace.h>
-#include <linux/stackdepot.h>
 
 struct pglist_data;
 
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index a56308a9d1a4..b2efafa001f8 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -467,14 +467,17 @@ static inline void *detach_page_private(struct page *page)
 }
 
 #ifdef CONFIG_NUMA
-struct folio *filemap_alloc_folio(gfp_t gfp, unsigned int order);
+struct folio *_filemap_alloc_folio(gfp_t gfp, unsigned int order);
 #else
-static inline struct folio *filemap_alloc_folio(gfp_t gfp, unsigned int order)
+static inline struct folio *_filemap_alloc_folio(gfp_t gfp, unsigned int order)
 {
-	return folio_alloc(gfp, order);
+	return _folio_alloc(gfp, order);
 }
 #endif
 
+#define filemap_alloc_folio(_gfp, _order) \
+	alloc_hooks(_filemap_alloc_folio(_gfp, _order), struct folio *, NULL)
+
 static inline struct page *__page_cache_alloc(gfp_t gfp)
 {
 	return &filemap_alloc_folio(gfp, 0)->page;
diff --git a/include/linux/pgalloc_tag.h b/include/linux/pgalloc_tag.h
index f8c7b6ef9c75..567327c1c46f 100644
--- a/include/linux/pgalloc_tag.h
+++ b/include/linux/pgalloc_tag.h
@@ -6,28 +6,58 @@
 #define _LINUX_PGALLOC_TAG_H
 
 #include <linux/alloc_tag.h>
+
+#ifdef CONFIG_MEM_ALLOC_PROFILING
+
 #include <linux/page_ext.h>
 
 extern struct page_ext_operations page_alloc_tagging_ops;
-struct page_ext *lookup_page_ext(const struct page *page);
+extern struct page_ext *page_ext_get(struct page *page);
+extern void page_ext_put(struct page_ext *page_ext);
+
+static inline union codetag_ref *codetag_ref_from_page_ext(struct page_ext *page_ext)
+{
+	return (void *)page_ext + page_alloc_tagging_ops.offset;
+}
+
+static inline struct page_ext *page_ext_from_codetag_ref(union codetag_ref *ref)
+{
+	return (void *)ref - page_alloc_tagging_ops.offset;
+}
 
 static inline union codetag_ref *get_page_tag_ref(struct page *page)
 {
 	if (page && mem_alloc_profiling_enabled()) {
-		struct page_ext *page_ext = lookup_page_ext(page);
+		struct page_ext *page_ext = page_ext_get(page);
 
 		if (page_ext)
-			return (void *)page_ext + page_alloc_tagging_ops.offset;
+			return codetag_ref_from_page_ext(page_ext);
 	}
 	return NULL;
 }
 
+static inline void put_page_tag_ref(union codetag_ref *ref)
+{
+	if (ref)
+		page_ext_put(page_ext_from_codetag_ref(ref));
+}
+
 static inline void pgalloc_tag_dec(struct page *page, unsigned int order)
 {
 	union codetag_ref *ref = get_page_tag_ref(page);
 
-	if (ref)
+	if (ref) {
 		alloc_tag_sub(ref, PAGE_SIZE << order);
+		put_page_tag_ref(ref);
+	}
 }
 
+#else /* CONFIG_MEM_ALLOC_PROFILING */
+
+static inline union codetag_ref *get_page_tag_ref(struct page *page) { return NULL; }
+static inline void put_page_tag_ref(union codetag_ref *ref) {}
+#define pgalloc_tag_dec(__page, __size)		do {} while (0)
+
+#endif /* CONFIG_MEM_ALLOC_PROFILING */
+
 #endif /* _LINUX_PGALLOC_TAG_H */
diff --git a/mm/compaction.c b/mm/compaction.c
index c8bcdea15f5f..32707fb62495 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -1684,7 +1684,7 @@ static void isolate_freepages(struct compact_control *cc)
  * This is a migrate-callback that "allocates" freepages by taking pages
  * from the isolated freelists in the block we are migrating to.
  */
-static struct page *compaction_alloc(struct page *migratepage,
+static struct page *_compaction_alloc(struct page *migratepage,
 					unsigned long data)
 {
 	struct compact_control *cc = (struct compact_control *)data;
@@ -1704,6 +1704,13 @@ static struct page *compaction_alloc(struct page *migratepage,
 	return freepage;
 }
 
+static struct page *compaction_alloc(struct page *migratepage,
+				     unsigned long data)
+{
+	return alloc_hooks(_compaction_alloc(migratepage, data),
+			   struct page *, NULL);
+}
+
 /*
  * This is a migrate-callback that "frees" freepages back to the isolated
  * freelist.  All pages on the freelist are from the same zone, so there is no
diff --git a/mm/filemap.c b/mm/filemap.c
index a34abfe8c654..f0f8b782d172 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -958,7 +958,7 @@ int filemap_add_folio(struct address_space *mapping, struct folio *folio,
 EXPORT_SYMBOL_GPL(filemap_add_folio);
 
 #ifdef CONFIG_NUMA
-struct folio *filemap_alloc_folio(gfp_t gfp, unsigned int order)
+struct folio *_filemap_alloc_folio(gfp_t gfp, unsigned int order)
 {
 	int n;
 	struct folio *folio;
@@ -973,9 +973,9 @@ struct folio *filemap_alloc_folio(gfp_t gfp, unsigned int order)
 
 		return folio;
 	}
-	return folio_alloc(gfp, order);
+	return _folio_alloc(gfp, order);
 }
-EXPORT_SYMBOL(filemap_alloc_folio);
+EXPORT_SYMBOL(_filemap_alloc_folio);
 #endif
 
 /*
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 2068b594dc88..80cd33811641 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -2141,7 +2141,7 @@ static struct page *alloc_pages_preferred_many(gfp_t gfp, unsigned int order,
 }
 
 /**
- * vma_alloc_folio - Allocate a folio for a VMA.
+ * _vma_alloc_folio - Allocate a folio for a VMA.
  * @gfp: GFP flags.
  * @order: Order of the folio.
  * @vma: Pointer to VMA or NULL if not available.
@@ -2155,7 +2155,7 @@ static struct page *alloc_pages_preferred_many(gfp_t gfp, unsigned int order,
  *
  * Return: The folio on success or NULL if allocation fails.
  */
-struct folio *vma_alloc_folio(gfp_t gfp, int order, struct vm_area_struct *vma,
+struct folio *_vma_alloc_folio(gfp_t gfp, int order, struct vm_area_struct *vma,
 		unsigned long addr, bool hugepage)
 {
 	struct mempolicy *pol;
@@ -2240,10 +2240,10 @@ struct folio *vma_alloc_folio(gfp_t gfp, int order, struct vm_area_struct *vma,
 out:
 	return folio;
 }
-EXPORT_SYMBOL(vma_alloc_folio);
+EXPORT_SYMBOL(_vma_alloc_folio);
 
 /**
- * alloc_pages - Allocate pages.
+ * _alloc_pages - Allocate pages.
  * @gfp: GFP flags.
  * @order: Power of two of number of pages to allocate.
  *
@@ -2256,7 +2256,7 @@ EXPORT_SYMBOL(vma_alloc_folio);
  * flags are used.
  * Return: The page on success or NULL if allocation fails.
  */
-struct page *alloc_pages(gfp_t gfp, unsigned order)
+struct page *_alloc_pages(gfp_t gfp, unsigned int order)
 {
 	struct mempolicy *pol = &default_policy;
 	struct page *page;
@@ -2274,15 +2274,15 @@ struct page *alloc_pages(gfp_t gfp, unsigned order)
 		page = alloc_pages_preferred_many(gfp, order,
 				  policy_node(gfp, pol, numa_node_id()), pol);
 	else
-		page = __alloc_pages(gfp, order,
+		page = _alloc_pages2(gfp, order,
 				policy_node(gfp, pol, numa_node_id()),
 				policy_nodemask(gfp, pol));
 
 	return page;
 }
-EXPORT_SYMBOL(alloc_pages);
+EXPORT_SYMBOL(_alloc_pages);
 
-struct folio *folio_alloc(gfp_t gfp, unsigned order)
+struct folio *_folio_alloc(gfp_t gfp, unsigned int order)
 {
 	struct page *page = alloc_pages(gfp | __GFP_COMP, order);
 
@@ -2290,7 +2290,7 @@ struct folio *folio_alloc(gfp_t gfp, unsigned order)
 		prep_transhuge_page(page);
 	return (struct folio *)page;
 }
-EXPORT_SYMBOL(folio_alloc);
+EXPORT_SYMBOL(_folio_alloc);
 
 static unsigned long alloc_pages_bulk_array_interleave(gfp_t gfp,
 		struct mempolicy *pol, unsigned long nr_pages,
@@ -2309,13 +2309,13 @@ static unsigned long alloc_pages_bulk_array_interleave(gfp_t gfp,
 
 	for (i = 0; i < nodes; i++) {
 		if (delta) {
-			nr_allocated = __alloc_pages_bulk(gfp,
+			nr_allocated = _alloc_pages_bulk(gfp,
 					interleave_nodes(pol), NULL,
 					nr_pages_per_node + 1, NULL,
 					page_array);
 			delta--;
 		} else {
-			nr_allocated = __alloc_pages_bulk(gfp,
+			nr_allocated = _alloc_pages_bulk(gfp,
 					interleave_nodes(pol), NULL,
 					nr_pages_per_node, NULL, page_array);
 		}
@@ -2337,11 +2337,11 @@ static unsigned long alloc_pages_bulk_array_preferred_many(gfp_t gfp, int nid,
 	preferred_gfp = gfp | __GFP_NOWARN;
 	preferred_gfp &= ~(__GFP_DIRECT_RECLAIM | __GFP_NOFAIL);
 
-	nr_allocated  = __alloc_pages_bulk(preferred_gfp, nid, &pol->nodes,
+	nr_allocated  = _alloc_pages_bulk(preferred_gfp, nid, &pol->nodes,
 					   nr_pages, NULL, page_array);
 
 	if (nr_allocated < nr_pages)
-		nr_allocated += __alloc_pages_bulk(gfp, numa_node_id(), NULL,
+		nr_allocated += _alloc_pages_bulk(gfp, numa_node_id(), NULL,
 				nr_pages - nr_allocated, NULL,
 				page_array + nr_allocated);
 	return nr_allocated;
@@ -2353,7 +2353,7 @@ static unsigned long alloc_pages_bulk_array_preferred_many(gfp_t gfp, int nid,
  * It can accelerate memory allocation especially interleaving
  * allocate memory.
  */
-unsigned long alloc_pages_bulk_array_mempolicy(gfp_t gfp,
+unsigned long _alloc_pages_bulk_array_mempolicy(gfp_t gfp,
 		unsigned long nr_pages, struct page **page_array)
 {
 	struct mempolicy *pol = &default_policy;
@@ -2369,7 +2369,7 @@ unsigned long alloc_pages_bulk_array_mempolicy(gfp_t gfp,
 		return alloc_pages_bulk_array_preferred_many(gfp,
 				numa_node_id(), pol, nr_pages, page_array);
 
-	return __alloc_pages_bulk(gfp, policy_node(gfp, pol, numa_node_id()),
+	return _alloc_pages_bulk(gfp, policy_node(gfp, pol, numa_node_id()),
 				  policy_nodemask(gfp, pol), nr_pages, NULL,
 				  page_array);
 }
diff --git a/mm/mm_init.c b/mm/mm_init.c
index 7f7f9c677854..42135fad4d8a 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -24,6 +24,7 @@
 #include <linux/page_ext.h>
 #include <linux/pti.h>
 #include <linux/pgtable.h>
+#include <linux/stackdepot.h>
 #include <linux/swap.h>
 #include <linux/cma.h>
 #include "internal.h"
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 9de2a18519a1..edd35500f7f6 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -74,6 +74,7 @@
 #include <linux/psi.h>
 #include <linux/khugepaged.h>
 #include <linux/delayacct.h>
+#include <linux/pgalloc_tag.h>
 #include <asm/sections.h>
 #include <asm/tlbflush.h>
 #include <asm/div64.h>
@@ -657,6 +658,7 @@ static inline bool pcp_allowed_order(unsigned int order)
 
 static inline void free_the_page(struct page *page, unsigned int order)
 {
+
 	if (pcp_allowed_order(order))		/* Via pcp? */
 		free_unref_page(page, order);
 	else
@@ -1259,6 +1261,7 @@ static __always_inline bool free_pages_prepare(struct page *page,
 			__memcg_kmem_uncharge_page(page, order);
 		reset_page_owner(page, order);
 		page_table_check_free(page, order);
+		pgalloc_tag_dec(page, order);
 		return false;
 	}
 
@@ -1301,6 +1304,7 @@ static __always_inline bool free_pages_prepare(struct page *page,
 	page->flags &= ~PAGE_FLAGS_CHECK_AT_PREP;
 	reset_page_owner(page, order);
 	page_table_check_free(page, order);
+	pgalloc_tag_dec(page, order);
 
 	if (!PageHighMem(page)) {
 		debug_check_no_locks_freed(page_address(page),
@@ -1669,6 +1673,9 @@ inline void post_alloc_hook(struct page *page, unsigned int order,
 	bool init = !want_init_on_free() && want_init_on_alloc(gfp_flags) &&
 			!should_skip_init(gfp_flags);
 	bool zero_tags = init && (gfp_flags & __GFP_ZEROTAGS);
+#ifdef CONFIG_MEM_ALLOC_PROFILING
+	union codetag_ref *ref;
+#endif
 	int i;
 
 	set_page_private(page, 0);
@@ -1721,6 +1728,14 @@ inline void post_alloc_hook(struct page *page, unsigned int order,
 
 	set_page_owner(page, order, gfp_flags);
 	page_table_check_alloc(page, order);
+
+#ifdef CONFIG_MEM_ALLOC_PROFILING
+	ref = get_page_tag_ref(page);
+	if (ref) {
+		alloc_tag_add(ref, current->alloc_tag, PAGE_SIZE << order);
+		put_page_tag_ref(ref);
+	}
+#endif
 }
 
 static void prep_new_page(struct page *page, unsigned int order, gfp_t gfp_flags,
@@ -4568,7 +4583,7 @@ static inline bool prepare_alloc_pages(gfp_t gfp_mask, unsigned int order,
  *
  * Returns the number of pages on the list or array.
  */
-unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
+unsigned long _alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 			nodemask_t *nodemask, int nr_pages,
 			struct list_head *page_list,
 			struct page **page_array)
@@ -4704,7 +4719,7 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 	pcp_trylock_finish(UP_flags);
 
 failed:
-	page = __alloc_pages(gfp, 0, preferred_nid, nodemask);
+	page = _alloc_pages2(gfp, 0, preferred_nid, nodemask);
 	if (page) {
 		if (page_list)
 			list_add(&page->lru, page_list);
@@ -4715,12 +4730,12 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 
 	goto out;
 }
-EXPORT_SYMBOL_GPL(__alloc_pages_bulk);
+EXPORT_SYMBOL_GPL(_alloc_pages_bulk);
 
 /*
  * This is the 'heart' of the zoned buddy allocator.
  */
-struct page *__alloc_pages(gfp_t gfp, unsigned int order, int preferred_nid,
+struct page *_alloc_pages2(gfp_t gfp, unsigned int order, int preferred_nid,
 							nodemask_t *nodemask)
 {
 	struct page *page;
@@ -4783,41 +4798,41 @@ struct page *__alloc_pages(gfp_t gfp, unsigned int order, int preferred_nid,
 
 	return page;
 }
-EXPORT_SYMBOL(__alloc_pages);
+EXPORT_SYMBOL(_alloc_pages2);
 
-struct folio *__folio_alloc(gfp_t gfp, unsigned int order, int preferred_nid,
+struct folio *_folio_alloc2(gfp_t gfp, unsigned int order, int preferred_nid,
 		nodemask_t *nodemask)
 {
-	struct page *page = __alloc_pages(gfp | __GFP_COMP, order,
+	struct page *page = _alloc_pages2(gfp | __GFP_COMP, order,
 			preferred_nid, nodemask);
 
 	if (page && order > 1)
 		prep_transhuge_page(page);
 	return (struct folio *)page;
 }
-EXPORT_SYMBOL(__folio_alloc);
+EXPORT_SYMBOL(_folio_alloc2);
 
 /*
  * Common helper functions. Never use with __GFP_HIGHMEM because the returned
  * address cannot represent highmem pages. Use alloc_pages and then kmap if
  * you need to access high mem.
  */
-unsigned long __get_free_pages(gfp_t gfp_mask, unsigned int order)
+unsigned long _get_free_pages(gfp_t gfp_mask, unsigned int order)
 {
 	struct page *page;
 
-	page = alloc_pages(gfp_mask & ~__GFP_HIGHMEM, order);
+	page = _alloc_pages(gfp_mask & ~__GFP_HIGHMEM, order);
 	if (!page)
 		return 0;
 	return (unsigned long) page_address(page);
 }
-EXPORT_SYMBOL(__get_free_pages);
+EXPORT_SYMBOL(_get_free_pages);
 
-unsigned long get_zeroed_page(gfp_t gfp_mask)
+unsigned long _get_zeroed_page(gfp_t gfp_mask)
 {
-	return __get_free_page(gfp_mask | __GFP_ZERO);
+	return _get_free_pages(gfp_mask | __GFP_ZERO, 0);
 }
-EXPORT_SYMBOL(get_zeroed_page);
+EXPORT_SYMBOL(_get_zeroed_page);
 
 /**
  * __free_pages - Free pages allocated with alloc_pages().
@@ -5009,7 +5024,7 @@ static void *make_alloc_exact(unsigned long addr, unsigned int order,
 }
 
 /**
- * alloc_pages_exact - allocate an exact number physically-contiguous pages.
+ * _alloc_pages_exact - allocate an exact number physically-contiguous pages.
  * @size: the number of bytes to allocate
  * @gfp_mask: GFP flags for the allocation, must not contain __GFP_COMP
  *
@@ -5023,7 +5038,7 @@ static void *make_alloc_exact(unsigned long addr, unsigned int order,
  *
  * Return: pointer to the allocated area or %NULL in case of error.
  */
-void *alloc_pages_exact(size_t size, gfp_t gfp_mask)
+void *_alloc_pages_exact(size_t size, gfp_t gfp_mask)
 {
 	unsigned int order = get_order(size);
 	unsigned long addr;
@@ -5031,13 +5046,13 @@ void *alloc_pages_exact(size_t size, gfp_t gfp_mask)
 	if (WARN_ON_ONCE(gfp_mask & (__GFP_COMP | __GFP_HIGHMEM)))
 		gfp_mask &= ~(__GFP_COMP | __GFP_HIGHMEM);
 
-	addr = __get_free_pages(gfp_mask, order);
+	addr = _get_free_pages(gfp_mask, order);
 	return make_alloc_exact(addr, order, size);
 }
-EXPORT_SYMBOL(alloc_pages_exact);
+EXPORT_SYMBOL(_alloc_pages_exact);
 
 /**
- * alloc_pages_exact_nid - allocate an exact number of physically-contiguous
+ * _alloc_pages_exact_nid - allocate an exact number of physically-contiguous
  *			   pages on a node.
  * @nid: the preferred node ID where memory should be allocated
  * @size: the number of bytes to allocate
@@ -5048,7 +5063,7 @@ EXPORT_SYMBOL(alloc_pages_exact);
  *
  * Return: pointer to the allocated area or %NULL in case of error.
  */
-void * __meminit alloc_pages_exact_nid(int nid, size_t size, gfp_t gfp_mask)
+void * __meminit _alloc_pages_exact_nid(int nid, size_t size, gfp_t gfp_mask)
 {
 	unsigned int order = get_order(size);
 	struct page *p;
@@ -5056,7 +5071,7 @@ void * __meminit alloc_pages_exact_nid(int nid, size_t size, gfp_t gfp_mask)
 	if (WARN_ON_ONCE(gfp_mask & (__GFP_COMP | __GFP_HIGHMEM)))
 		gfp_mask &= ~(__GFP_COMP | __GFP_HIGHMEM);
 
-	p = alloc_pages_node(nid, gfp_mask, order);
+	p = _alloc_pages_node(nid, gfp_mask, order);
 	if (!p)
 		return NULL;
 	return make_alloc_exact((unsigned long)page_address(p), order, size);
@@ -6729,7 +6744,7 @@ int __alloc_contig_migrate_range(struct compact_control *cc,
 }
 
 /**
- * alloc_contig_range() -- tries to allocate given range of pages
+ * _alloc_contig_range() -- tries to allocate given range of pages
  * @start:	start PFN to allocate
  * @end:	one-past-the-last PFN to allocate
  * @migratetype:	migratetype of the underlying pageblocks (either
@@ -6749,7 +6764,7 @@ int __alloc_contig_migrate_range(struct compact_control *cc,
  * pages which PFN is in [start, end) are allocated for the caller and
  * need to be freed with free_contig_range().
  */
-int alloc_contig_range(unsigned long start, unsigned long end,
+int _alloc_contig_range(unsigned long start, unsigned long end,
 		       unsigned migratetype, gfp_t gfp_mask)
 {
 	unsigned long outer_start, outer_end;
@@ -6873,15 +6888,15 @@ int alloc_contig_range(unsigned long start, unsigned long end,
 	undo_isolate_page_range(start, end, migratetype);
 	return ret;
 }
-EXPORT_SYMBOL(alloc_contig_range);
+EXPORT_SYMBOL(_alloc_contig_range);
 
 static int __alloc_contig_pages(unsigned long start_pfn,
 				unsigned long nr_pages, gfp_t gfp_mask)
 {
 	unsigned long end_pfn = start_pfn + nr_pages;
 
-	return alloc_contig_range(start_pfn, end_pfn, MIGRATE_MOVABLE,
-				  gfp_mask);
+	return _alloc_contig_range(start_pfn, end_pfn, MIGRATE_MOVABLE,
+				   gfp_mask);
 }
 
 static bool pfn_range_valid_contig(struct zone *z, unsigned long start_pfn,
@@ -6916,7 +6931,7 @@ static bool zone_spans_last_pfn(const struct zone *zone,
 }
 
 /**
- * alloc_contig_pages() -- tries to find and allocate contiguous range of pages
+ * _alloc_contig_pages() -- tries to find and allocate contiguous range of pages
  * @nr_pages:	Number of contiguous pages to allocate
  * @gfp_mask:	GFP mask to limit search and used during compaction
  * @nid:	Target node
@@ -6936,8 +6951,8 @@ static bool zone_spans_last_pfn(const struct zone *zone,
  *
  * Return: pointer to contiguous pages on success, or NULL if not successful.
  */
-struct page *alloc_contig_pages(unsigned long nr_pages, gfp_t gfp_mask,
-				int nid, nodemask_t *nodemask)
+struct page *_alloc_contig_pages(unsigned long nr_pages, gfp_t gfp_mask,
+				 int nid, nodemask_t *nodemask)
 {
 	unsigned long ret, pfn, flags;
 	struct zonelist *zonelist;
-- 
2.40.1.495.gc816e09b53d-goog

