Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 668BF2D1DDC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Dec 2020 23:58:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727908AbgLGW6B (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Dec 2020 17:58:01 -0500
Received: from mga05.intel.com ([192.55.52.43]:30904 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726429AbgLGW6B (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Dec 2020 17:58:01 -0500
IronPort-SDR: cmjfE5o6yErC0svfiwh2WX7jE/WSC7jkFXC2mTas5j5KNGNaxKZY42Melw5mtvIOMSQGojextK
 TolMkGiub59g==
X-IronPort-AV: E=McAfee;i="6000,8403,9828"; a="258503446"
X-IronPort-AV: E=Sophos;i="5.78,401,1599548400"; 
   d="scan'208";a="258503446"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2020 14:57:20 -0800
IronPort-SDR: e9d6KgSN55dDPcjiPioCnlFbID2IDa8Hm1l+x2GSqdCoALUss9l/+rB7tpSry9HRuk+hJghrwP
 l+868QZHa2pA==
X-IronPort-AV: E=Sophos;i="5.78,401,1599548400"; 
   d="scan'208";a="317433222"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2020 14:57:20 -0800
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
Subject: [PATCH V2 2/2] mm/highmem: Lift memcpy_[to|from]_page to core
Date:   Mon,  7 Dec 2020 14:57:03 -0800
Message-Id: <20201207225703.2033611-3-ira.weiny@intel.com>
X-Mailer: git-send-email 2.28.0.rc0.12.gb6a658bd00c9
In-Reply-To: <20201207225703.2033611-1-ira.weiny@intel.com>
References: <20201207225703.2033611-1-ira.weiny@intel.com>
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

Placing these functions in 'highmem.h' is suboptimal especially with the
changes being proposed in the functionality of kmap.  From a caller
perspective including/using 'highmem.h' implies that the functions
defined in that header are only required when highmem is in use which is
increasingly not the case with modern processors.  Some headers like
mm.h or string.h seem ok but don't really portray the functionality
well.  'pagemap.h', on the other hand, makes sense and is already
included in many of the places we want to convert.

Another alternative would be to create a new header for the promoted
memcpy functions, but it masks the fact that these are designed to copy
to/from pages using the kernel direct mappings and complicates matters
with a new header.

Lift memcpy_to_page() and memcpy_from_page() to pagemap.h.

Remove memzero_page() in favor of zero_user() to zero a page.

Add a memcpy_page(), memmove_page, and memset_page() to cover more
kmap/mem*/kunmap. patterns.

Finally use kmap_local_page() in all the new calls.

[1] https://lore.kernel.org/lkml/20201013200149.GI3576660@ZenIV.linux.org.uk/
    https://lore.kernel.org/lkml/20201013112544.GA5249@infradead.org/

Cc: Dave Hansen <dave.hansen@intel.com>
Suggested-by: Matthew Wilcox <willy@infradead.org>
Suggested-by: Christoph Hellwig <hch@infradead.org>
Suggested-by: Dan Williams <dan.j.williams@intel.com>
Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Suggested-by: Eric Biggers <ebiggers@kernel.org>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes for V2:
	From Thomas Gleixner
		Change kmap_atomic() to kmap_local_page() after basing
		on tip/core/mm
	From Joonas Lahtinen
		Reverse offset/val in memset_page()
---
 include/linux/pagemap.h | 44 +++++++++++++++++++++++++++++++++++++++++
 lib/iov_iter.c          | 26 +++---------------------
 2 files changed, 47 insertions(+), 23 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index c77b7c31b2e4..9141e5b7b9df 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -1028,4 +1028,48 @@ unsigned int i_blocks_per_page(struct inode *inode, struct page *page)
 {
 	return thp_size(page) >> inode->i_blkbits;
 }
+
+static inline void memcpy_page(struct page *dst_page, size_t dst_off,
+			       struct page *src_page, size_t src_off,
+			       size_t len)
+{
+	char *dst = kmap_local_page(dst_page);
+	char *src = kmap_local_page(src_page);
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
+	memmove(dst + dst_off, src + src_off, len);
+	kunmap_local(src);
+	kunmap_local(dst);
+}
+
+static inline void memcpy_from_page(char *to, struct page *page, size_t offset, size_t len)
+{
+	char *from = kmap_local_page(page);
+	memcpy(to, from + offset, len);
+	kunmap_local(from);
+}
+
+static inline void memcpy_to_page(struct page *page, size_t offset, const char *from, size_t len)
+{
+	char *to = kmap_local_page(page);
+	memcpy(to + offset, from, len);
+	kunmap_local(to);
+}
+
+static inline void memset_page(struct page *page, size_t offset, int val, size_t len)
+{
+	char *addr = kmap_local_page(page);
+	memset(addr + offset, val, len);
+	kunmap_local(addr);
+}
+
 #endif /* _LINUX_PAGEMAP_H */
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

