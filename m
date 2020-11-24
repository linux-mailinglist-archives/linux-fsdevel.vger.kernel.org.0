Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C3AE2C1DD7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Nov 2020 07:10:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729354AbgKXGIH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Nov 2020 01:08:07 -0500
Received: from mga02.intel.com ([134.134.136.20]:57123 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729309AbgKXGIE (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Nov 2020 01:08:04 -0500
IronPort-SDR: Qc8OPO1J9gqyRaaBn6ljuKzsdRK432dWGNpCWnEuxWefYJeQ1IuQK4rMpSXmFfptYUY1VMat9Y
 aEqvtEPP3X+w==
X-IronPort-AV: E=McAfee;i="6000,8403,9814"; a="158937222"
X-IronPort-AV: E=Sophos;i="5.78,365,1599548400"; 
   d="scan'208";a="158937222"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2020 22:08:03 -0800
IronPort-SDR: Zw2VaazFW03fZFRdJj38HIMXIVqbN/85Fo9/0Ue7V9ZWM/Q05lCstaS0pglbOknKZNmn/v3oLQ
 fQIV9CK6ORAg==
X-IronPort-AV: E=Sophos;i="5.78,365,1599548400"; 
   d="scan'208";a="478391562"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2020 22:08:03 -0800
From:   ira.weiny@intel.com
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Eric Biggers <ebiggers@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Howells <dhowells@redhat.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Steve French <sfrench@samba.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        Nicolas Pitre <nico@fluxnic.net>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Brian King <brking@us.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Kirti Wankhede <kwankhede@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 01/17] mm/highmem: Lift memcpy_[to|from]_page and memset_page to core
Date:   Mon, 23 Nov 2020 22:07:39 -0800
Message-Id: <20201124060755.1405602-2-ira.weiny@intel.com>
X-Mailer: git-send-email 2.28.0.rc0.12.gb6a658bd00c9
In-Reply-To: <20201124060755.1405602-1-ira.weiny@intel.com>
References: <20201124060755.1405602-1-ira.weiny@intel.com>
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

Lift memcpy_to_page(), memcpy_from_page(), and memzero_page() to
pagemap.h.

Also, add a memcpy_page(), memmove_page, and memset_page() to cover more
kmap/mem*/kunmap. patterns.

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
 include/linux/pagemap.h | 49 +++++++++++++++++++++++++++++++++++++++++
 lib/iov_iter.c          | 21 ------------------
 2 files changed, 49 insertions(+), 21 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index c77b7c31b2e4..82a0af6bc843 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -1028,4 +1028,53 @@ unsigned int i_blocks_per_page(struct inode *inode, struct page *page)
 {
 	return thp_size(page) >> inode->i_blkbits;
 }
+
+static inline void memcpy_page(struct page *dst_page, size_t dst_off,
+			       struct page *src_page, size_t src_off,
+			       size_t len)
+{
+	char *dst = kmap_atomic(dst_page);
+	char *src = kmap_atomic(src_page);
+	memcpy(dst + dst_off, src + src_off, len);
+	kunmap_atomic(src);
+	kunmap_atomic(dst);
+}
+
+static inline void memmove_page(struct page *dst_page, size_t dst_off,
+			       struct page *src_page, size_t src_off,
+			       size_t len)
+{
+	char *dst = kmap_atomic(dst_page);
+	char *src = kmap_atomic(src_page);
+	memmove(dst + dst_off, src + src_off, len);
+	kunmap_atomic(src);
+	kunmap_atomic(dst);
+}
+
+static inline void memcpy_from_page(char *to, struct page *page, size_t offset, size_t len)
+{
+	char *from = kmap_atomic(page);
+	memcpy(to, from + offset, len);
+	kunmap_atomic(from);
+}
+
+static inline void memcpy_to_page(struct page *page, size_t offset, const char *from, size_t len)
+{
+	char *to = kmap_atomic(page);
+	memcpy(to + offset, from, len);
+	kunmap_atomic(to);
+}
+
+static inline void memset_page(struct page *page, int val, size_t offset, size_t len)
+{
+	char *addr = kmap_atomic(page);
+	memset(addr + offset, val, len);
+	kunmap_atomic(addr);
+}
+
+static inline void memzero_page(struct page *page, size_t offset, size_t len)
+{
+	memset_page(page, 0, offset, len);
+}
+
 #endif /* _LINUX_PAGEMAP_H */
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 1635111c5bd2..2439a8b4f0d2 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -466,27 +466,6 @@ void iov_iter_init(struct iov_iter *i, unsigned int direction,
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
-- 
2.28.0.rc0.12.gb6a658bd00c9

