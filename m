Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3166F315F5E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Feb 2021 07:24:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231691AbhBJGXh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Feb 2021 01:23:37 -0500
Received: from mga03.intel.com ([134.134.136.65]:39564 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231651AbhBJGXQ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Feb 2021 01:23:16 -0500
IronPort-SDR: hJV5El22nShlzWwOcIcKor6ZnRuvrffWv1bsj+y4W8RpMZJpORiCEsnNvsYw/JObitRNP/Bu93
 LFayAnU8fbEg==
X-IronPort-AV: E=McAfee;i="6000,8403,9890"; a="182086723"
X-IronPort-AV: E=Sophos;i="5.81,167,1610438400"; 
   d="scan'208";a="182086723"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2021 22:22:34 -0800
IronPort-SDR: RYvxZq6b+f56s8vwubDbwJMmRqyjN8YP3X6q+1kd894MtYMxxhntB1Pl1zC6Du6WRZqkp0fItH
 zYAhXQWN8X3g==
X-IronPort-AV: E=Sophos;i="5.81,167,1610438400"; 
   d="scan'208";a="587246143"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2021 22:22:33 -0800
From:   ira.weiny@intel.com
To:     Andrew Morton <akpm@linux-foundation.org>,
        David Sterba <dsterba@suse.cz>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Christoph Hellwig <hch@infradead.org>, clm@fb.com,
        josef@toxicpanda.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH V2 3/8] mm/highmem: Introduce memcpy_page(), memmove_page(), and memset_page()
Date:   Tue,  9 Feb 2021 22:22:16 -0800
Message-Id: <20210210062221.3023586-4-ira.weiny@intel.com>
X-Mailer: git-send-email 2.28.0.rc0.12.gb6a658bd00c9
In-Reply-To: <20210210062221.3023586-1-ira.weiny@intel.com>
References: <20210210062221.3023586-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

3 more common kmap patterns are kmap/memcpy/kunmap, kmap/memmove/kunmap.
and kmap/memset/kunmap.

Add helper functions for those patterns which use kmap_local_page().

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
New for V2
---
 include/linux/highmem.h | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/include/linux/highmem.h b/include/linux/highmem.h
index c17a175fe5fe..0b5d89621cb9 100644
--- a/include/linux/highmem.h
+++ b/include/linux/highmem.h
@@ -276,6 +276,39 @@ static inline void copy_highpage(struct page *to, struct page *from)
 
 #endif
 
+static inline void memcpy_page(struct page *dst_page, size_t dst_off,
+			       struct page *src_page, size_t src_off,
+			       size_t len)
+{
+	char *dst = kmap_local_page(dst_page);
+	char *src = kmap_local_page(src_page);
+
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
+	memmove(dst + dst_off, src + src_off, len);
+	kunmap_local(src);
+	kunmap_local(dst);
+}
+
+static inline void memset_page(struct page *page, size_t offset, int val,
+			       size_t len)
+{
+	char *addr = kmap_local_page(page);
+
+	memset(addr + offset, val, len);
+	kunmap_local(addr);
+}
+
 static inline void memcpy_from_page(char *to, struct page *page,
 				    size_t offset, size_t len)
 {
-- 
2.28.0.rc0.12.gb6a658bd00c9

