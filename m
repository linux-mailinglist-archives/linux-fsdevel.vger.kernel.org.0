Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BD582D1DDE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Dec 2020 23:58:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728019AbgLGW6E (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Dec 2020 17:58:04 -0500
Received: from mga01.intel.com ([192.55.52.88]:19717 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726429AbgLGW6D (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Dec 2020 17:58:03 -0500
IronPort-SDR: oQUFDqdq0QbFVzhGDqKGbVXPj+BoW98TfUK7yJ3JC7p79r4o/fhXfe2Wxt8wsv45JvpwBimnHV
 +YKTSia6V1dg==
X-IronPort-AV: E=McAfee;i="6000,8403,9828"; a="192073007"
X-IronPort-AV: E=Sophos;i="5.78,401,1599548400"; 
   d="scan'208";a="192073007"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2020 14:57:12 -0800
IronPort-SDR: NOqL4zg9ogd7jvi01IAQTQVH7CCeO8EghE3wfhw68NCMfWkqqMZFUI99jukgb2VYXgXcqKNioD
 Kh5j2bMD0t7g==
X-IronPort-AV: E=Sophos;i="5.78,401,1599548400"; 
   d="scan'208";a="363354728"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2020 14:57:08 -0800
From:   ira.weiny@intel.com
To:     Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        Eric Biggers <ebiggers@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH V2 1/2] mm/highmem: Remove deprecated kmap_atomic
Date:   Mon,  7 Dec 2020 14:57:02 -0800
Message-Id: <20201207225703.2033611-2-ira.weiny@intel.com>
X-Mailer: git-send-email 2.28.0.rc0.12.gb6a658bd00c9
In-Reply-To: <20201207225703.2033611-1-ira.weiny@intel.com>
References: <20201207225703.2033611-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

kmap_atomic() is being deprecated in favor of kmap_local_page().

Replace the uses of kmap_atomic() within the highmem code.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 include/linux/highmem.h | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/include/linux/highmem.h b/include/linux/highmem.h
index f597830f26b4..3bfe6a12d14d 100644
--- a/include/linux/highmem.h
+++ b/include/linux/highmem.h
@@ -146,9 +146,9 @@ static inline void invalidate_kernel_vmap_range(void *vaddr, int size)
 #ifndef clear_user_highpage
 static inline void clear_user_highpage(struct page *page, unsigned long vaddr)
 {
-	void *addr = kmap_atomic(page);
+	void *addr = kmap_local_page(page);
 	clear_user_page(addr, vaddr, page);
-	kunmap_atomic(addr);
+	kunmap_local(addr);
 }
 #endif
 
@@ -199,16 +199,16 @@ alloc_zeroed_user_highpage_movable(struct vm_area_struct *vma,
 
 static inline void clear_highpage(struct page *page)
 {
-	void *kaddr = kmap_atomic(page);
+	void *kaddr = kmap_local_page(page);
 	clear_page(kaddr);
-	kunmap_atomic(kaddr);
+	kunmap_local(kaddr);
 }
 
 static inline void zero_user_segments(struct page *page,
 	unsigned start1, unsigned end1,
 	unsigned start2, unsigned end2)
 {
-	void *kaddr = kmap_atomic(page);
+	void *kaddr = kmap_local_page(page);
 
 	BUG_ON(end1 > PAGE_SIZE || end2 > PAGE_SIZE);
 
@@ -218,7 +218,7 @@ static inline void zero_user_segments(struct page *page,
 	if (end2 > start2)
 		memset(kaddr + start2, 0, end2 - start2);
 
-	kunmap_atomic(kaddr);
+	kunmap_local(kaddr);
 	flush_dcache_page(page);
 }
 
@@ -241,11 +241,11 @@ static inline void copy_user_highpage(struct page *to, struct page *from,
 {
 	char *vfrom, *vto;
 
-	vfrom = kmap_atomic(from);
-	vto = kmap_atomic(to);
+	vfrom = kmap_local_page(from);
+	vto = kmap_local_page(to);
 	copy_user_page(vto, vfrom, vaddr, to);
-	kunmap_atomic(vto);
-	kunmap_atomic(vfrom);
+	kunmap_local(vto);
+	kunmap_local(vfrom);
 }
 
 #endif
@@ -256,11 +256,11 @@ static inline void copy_highpage(struct page *to, struct page *from)
 {
 	char *vfrom, *vto;
 
-	vfrom = kmap_atomic(from);
-	vto = kmap_atomic(to);
+	vfrom = kmap_local_page(from);
+	vto = kmap_local_page(to);
 	copy_page(vto, vfrom);
-	kunmap_atomic(vto);
-	kunmap_atomic(vfrom);
+	kunmap_local(vto);
+	kunmap_local(vfrom);
 }
 
 #endif
-- 
2.28.0.rc0.12.gb6a658bd00c9

