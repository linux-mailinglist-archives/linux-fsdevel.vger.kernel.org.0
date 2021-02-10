Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F8B3315F58
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Feb 2021 07:23:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231665AbhBJGXZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Feb 2021 01:23:25 -0500
Received: from mga03.intel.com ([134.134.136.65]:39559 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231639AbhBJGXN (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Feb 2021 01:23:13 -0500
IronPort-SDR: MWkM0vANgVdknZl8mBjJBmcFjGTgNMfhFgBXZwZ3ieKwO/2EDTTFRH0IQeYzg5e+jPsLd+ZEmd
 absLdODSYoeA==
X-IronPort-AV: E=McAfee;i="6000,8403,9890"; a="182086720"
X-IronPort-AV: E=Sophos;i="5.81,167,1610438400"; 
   d="scan'208";a="182086720"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2021 22:22:31 -0800
IronPort-SDR: NzVJeVhqWL42h2CcHULA3qCkmCOFtBHm6fb+k2bxU3pd9rqCJXZB8pGiZT4wiFnsGf0DXG3CrL
 82lI/mNJ6Lbg==
X-IronPort-AV: E=Sophos;i="5.81,167,1610438400"; 
   d="scan'208";a="587246122"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2021 22:22:31 -0800
From:   ira.weiny@intel.com
To:     Andrew Morton <akpm@linux-foundation.org>,
        David Sterba <dsterba@suse.cz>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Boris Pismenny <borisp@mellanox.com>,
        Or Gerlitz <gerlitz.or@gmail.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Eric Biggers <ebiggers@kernel.org>, clm@fb.com,
        josef@toxicpanda.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH V2 1/8] mm/highmem: Lift memcpy_[to|from]_page to core
Date:   Tue,  9 Feb 2021 22:22:14 -0800
Message-Id: <20210210062221.3023586-2-ira.weiny@intel.com>
X-Mailer: git-send-email 2.28.0.rc0.12.gb6a658bd00c9
In-Reply-To: <20210210062221.3023586-1-ira.weiny@intel.com>
References: <20210210062221.3023586-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

Working through a conversion to a call kmap_local_page() instead of
kmap() revealed many places where the pattern kmap/memcpy/kunmap
occurred.

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

[1] https://lore.kernel.org/lkml/20201013200149.GI3576660@ZenIV.linux.org.uk/
    https://lore.kernel.org/lkml/20201013112544.GA5249@infradead.org/

[2] https://lore.kernel.org/lkml/20201208122316.GH7338@casper.infradead.org/

[3] https://lore.kernel.org/lkml/20201013200149.GI3576660@ZenIV.linux.org.uk/#t
    https://lore.kernel.org/lkml/20201208163814.GN1563847@iweiny-DESK2.sc.intel.com/

Cc: Boris Pismenny <borisp@mellanox.com>
Cc: Or Gerlitz <gerlitz.or@gmail.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Suggested-by: Matthew Wilcox <willy@infradead.org>
Suggested-by: Christoph Hellwig <hch@infradead.org>
Suggested-by: Dan Williams <dan.j.williams@intel.com>
Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Suggested-by: Eric Biggers <ebiggers@kernel.org>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes from v1 btrfs series:
	https://lore.kernel.org/lkml/20210205232304.1670522-2-ira.weiny@intel.com/
	Split out the BUG_ON()'s per Andrew
	Split out the change to kmap_local_page() per Andrew
	Split out the addition of memcpy_page, memmove_page, and memset_page
	While we are refactoring adjust the line length down per Chaitanya
		https://lore.kernel.org/lkml/BYAPR04MB49655E5BDB24A108FEFFE9C486B09@BYAPR04MB4965.namprd04.prod.outlook.com/

Chagnes for V4:
	Update commit message to say kmap_local_page() since
	kmap_thread() is no longer valid

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
 include/linux/highmem.h | 18 ++++++++++++++++++
 lib/iov_iter.c          | 14 --------------
 2 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/include/linux/highmem.h b/include/linux/highmem.h
index d2c70d3772a3..736b6a9f144d 100644
--- a/include/linux/highmem.h
+++ b/include/linux/highmem.h
@@ -276,4 +276,22 @@ static inline void copy_highpage(struct page *to, struct page *from)
 
 #endif
 
+static inline void memcpy_from_page(char *to, struct page *page,
+				    size_t offset, size_t len)
+{
+	char *from = kmap_atomic(page);
+
+	memcpy(to, from + offset, len);
+	kunmap_atomic(from);
+}
+
+static inline void memcpy_to_page(struct page *page, size_t offset,
+				  const char *from, size_t len)
+{
+	char *to = kmap_atomic(page);
+
+	memcpy(to + offset, from, len);
+	kunmap_atomic(to);
+}
+
 #endif /* _LINUX_HIGHMEM_H */
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index a21e6a5792c5..9889e9903cdf 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -466,20 +466,6 @@ void iov_iter_init(struct iov_iter *i, unsigned int direction,
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
 static void memzero_page(struct page *page, size_t offset, size_t len)
 {
 	char *addr = kmap_atomic(page);
-- 
2.28.0.rc0.12.gb6a658bd00c9

