Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC5EF2D6354
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Dec 2020 18:20:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391080AbgLJRTk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Dec 2020 12:19:40 -0500
Received: from mga05.intel.com ([192.55.52.43]:27884 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389430AbgLJRTW (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Dec 2020 12:19:22 -0500
IronPort-SDR: 8rhlvhZFKE63fRdrzOnEGBENFPUPEE53+PnqvN2yO7cuGkJSco/stDJCaH4DR72rrPqjEstwHe
 2F8GHLo/3Hsw==
X-IronPort-AV: E=McAfee;i="6000,8403,9831"; a="259009697"
X-IronPort-AV: E=Sophos;i="5.78,408,1599548400"; 
   d="scan'208";a="259009697"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2020 09:18:42 -0800
IronPort-SDR: 5xr4apECjOj39Ur1mJWLL6wLeKeZj78MhV0ePWykHq4d7br65MV0RYZk6g4pvOO+c0OvvbBQ9K
 dwxPpmYpMY4g==
X-IronPort-AV: E=Sophos;i="5.78,408,1599548400"; 
   d="scan'208";a="553390235"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2020 09:18:41 -0800
From:   ira.weiny@intel.com
To:     Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Eric Biggers <ebiggers@kernel.org>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH V3 2/2] mm/highmem: Lift memcpy_[to|from]_page to core
Date:   Thu, 10 Dec 2020 09:18:34 -0800
Message-Id: <20201210171834.2472353-3-ira.weiny@intel.com>
X-Mailer: git-send-email 2.28.0.rc0.12.gb6a658bd00c9
In-Reply-To: <20201210171834.2472353-1-ira.weiny@intel.com>
References: <20201210171834.2472353-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

Working through a conversion to a call such as kmap_thread() revealed
many places where the pattern kmap/memcpy/kunmap occurred.

Eric Biggers, Matthew Wilcox, Christoph Hellwig, Dan Williams, and Al
Viro all suggested putting this code into helper functions.  Al Viro
further pointed out that these functions already existed in the iov_iter
code.[1]

Various locations for the lifted functions were considered.

Headers like mm.h or string.h seem ok but don't really portray the
functionality well.  pagemap.h made some sense but is for page cache
functionality.[2]

Another alternative would be to create a new header for the promoted
memcpy functions, but it masks the fact that these are designed to copy
to/from pages using the kernel direct mappings and complicates matters
with a new header.

Placing these functions in 'highmem.h' is suboptimal especially with the
changes being proposed in the functionality of kmap.  From a caller
perspective including/using 'highmem.h' implies that the functions
defined in that header are only required when highmem is in use which is
increasingly not the case with modern processors.  However, highmem.h is
where all the current functions like this reside (zero_user(),
clear_highpage(), clear_user_highpage(), copy_user_highpage(), and
copy_highpage()).  So it makes the most sense even though it is
distasteful for some.[3]

Lift memcpy_to_page() and memcpy_from_page() to pagemap.h.

Remove memzero_page() in favor of zero_user() to zero a page.

Add a memcpy_page(), memmove_page, and memset_page() to cover more
kmap/mem*/kunmap. patterns.

Add BUG_ON bounds checks to ensure the newly lifted page memory
operations do not result in corrupted data in neighbor pages and to make
them consistent with zero_user().[4]

Finally use kmap_local_page() in all the new calls.

[1] https://lore.kernel.org/lkml/20201013200149.GI3576660@ZenIV.linux.org.uk/
    https://lore.kernel.org/lkml/20201013112544.GA5249@infradead.org/

[2] https://lore.kernel.org/lkml/20201208122316.GH7338@casper.infradead.org/

[3] https://lore.kernel.org/lkml/20201013200149.GI3576660@ZenIV.linux.org.uk/#t
    https://lore.kernel.org/lkml/20201208163814.GN1563847@iweiny-DESK2.sc.intel.com/

[4] https://lore.kernel.org/lkml/20201210053502.GS1563847@iweiny-DESK2.sc.intel.com/

Cc: Dave Hansen <dave.hansen@intel.com>
Suggested-by: Matthew Wilcox <willy@infradead.org>
Suggested-by: Christoph Hellwig <hch@infradead.org>
Suggested-by: Dan Williams <dan.j.williams@intel.com>
Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Suggested-by: Eric Biggers <ebiggers@kernel.org>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes for V3:
	From Matthew Wilcox
		Move calls to highmem.h
		Add BUG_ON()

Changes for V2:
	From Thomas Gleixner
		Change kmap_atomic() to kmap_local_page() after basing
		on tip/core/mm
	From Joonas Lahtinen
		Reverse offset/val in memset_page()
---
 include/linux/highmem.h | 53 +++++++++++++++++++++++++++++++++++++++++
 lib/iov_iter.c          | 26 +++-----------------
 2 files changed, 56 insertions(+), 23 deletions(-)

diff --git a/include/linux/highmem.h b/include/linux/highmem.h
index 3bfe6a12d14d..75b2ca0b050b 100644
--- a/include/linux/highmem.h
+++ b/include/linux/highmem.h
@@ -265,4 +265,57 @@ static inline void copy_highpage(struct page *to, struct page *from)
 
 #endif
 
+static inline void memcpy_page(struct page *dst_page, size_t dst_off,
+			       struct page *src_page, size_t src_off,
+			       size_t len)
+{
+	char *dst = kmap_local_page(dst_page);
+	char *src = kmap_local_page(src_page);
+
+	BUG_ON(dst_off + len > PAGE_SIZE || src_off + len > PAGE_SIZE);
+	memcpy(dst + dst_off, src + src_off, len);
+	kunmap_local(src);
+	kunmap_local(dst);
+}
+
+static inline void memmove_page(struct page *dst_page, size_t dst_off,
+			       struct page *src_page, size_t src_off,
+			       size_t len)
+{
+	char *dst = kmap_local_page(dst_page);
+	char *src = kmap_local_page(src_page);
+
+	BUG_ON(dst_off + len > PAGE_SIZE || src_off + len > PAGE_SIZE);
+	memmove(dst + dst_off, src + src_off, len);
+	kunmap_local(src);
+	kunmap_local(dst);
+}
+
+static inline void memcpy_from_page(char *to, struct page *page, size_t offset, size_t len)
+{
+	char *from = kmap_local_page(page);
+
+	BUG_ON(offset + len > PAGE_SIZE);
+	memcpy(to, from + offset, len);
+	kunmap_local(from);
+}
+
+static inline void memcpy_to_page(struct page *page, size_t offset, const char *from, size_t len)
+{
+	char *to = kmap_local_page(page);
+
+	BUG_ON(offset + len > PAGE_SIZE);
+	memcpy(to + offset, from, len);
+	kunmap_local(to);
+}
+
+static inline void memset_page(struct page *page, size_t offset, int val, size_t len)
+{
+	char *addr = kmap_local_page(page);
+
+	BUG_ON(offset + len > PAGE_SIZE);
+	memset(addr + offset, val, len);
+	kunmap_local(addr);
+}
+
 #endif /* _LINUX_HIGHMEM_H */
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 1635111c5bd2..8ed1f846fcc3 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -5,6 +5,7 @@
 #include <linux/fault-inject-usercopy.h>
 #include <linux/uio.h>
 #include <linux/pagemap.h>
+#include <linux/highmem.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 #include <linux/splice.h>
@@ -466,27 +467,6 @@ void iov_iter_init(struct iov_iter *i, unsigned int direction,
 }
 EXPORT_SYMBOL(iov_iter_init);
 
-static void memcpy_from_page(char *to, struct page *page, size_t offset, size_t len)
-{
-	char *from = kmap_atomic(page);
-	memcpy(to, from + offset, len);
-	kunmap_atomic(from);
-}
-
-static void memcpy_to_page(struct page *page, size_t offset, const char *from, size_t len)
-{
-	char *to = kmap_atomic(page);
-	memcpy(to + offset, from, len);
-	kunmap_atomic(to);
-}
-
-static void memzero_page(struct page *page, size_t offset, size_t len)
-{
-	char *addr = kmap_atomic(page);
-	memset(addr + offset, 0, len);
-	kunmap_atomic(addr);
-}
-
 static inline bool allocated(struct pipe_buffer *buf)
 {
 	return buf->ops == &default_pipe_buf_ops;
@@ -964,7 +944,7 @@ static size_t pipe_zero(size_t bytes, struct iov_iter *i)
 
 	do {
 		size_t chunk = min_t(size_t, n, PAGE_SIZE - off);
-		memzero_page(pipe->bufs[i_head & p_mask].page, off, chunk);
+		zero_user(pipe->bufs[i_head & p_mask].page, off, chunk);
 		i->head = i_head;
 		i->iov_offset = off + chunk;
 		n -= chunk;
@@ -981,7 +961,7 @@ size_t iov_iter_zero(size_t bytes, struct iov_iter *i)
 		return pipe_zero(bytes, i);
 	iterate_and_advance(i, bytes, v,
 		clear_user(v.iov_base, v.iov_len),
-		memzero_page(v.bv_page, v.bv_offset, v.bv_len),
+		zero_user(v.bv_page, v.bv_offset, v.bv_len),
 		memset(v.iov_base, 0, v.iov_len)
 	)
 
-- 
2.28.0.rc0.12.gb6a658bd00c9

