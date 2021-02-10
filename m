Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA431315F5D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Feb 2021 07:24:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231682AbhBJGXc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Feb 2021 01:23:32 -0500
Received: from mga03.intel.com ([134.134.136.65]:39560 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231649AbhBJGXO (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Feb 2021 01:23:14 -0500
IronPort-SDR: WNQ2EA1nDhPa68/gkolrNpiQ6wVFd8PFsK03XiLn13JBfyqlXXUfRAZA+V9oIEr/v3CXS+U50z
 l2eyw9SEM19A==
X-IronPort-AV: E=McAfee;i="6000,8403,9890"; a="182086721"
X-IronPort-AV: E=Sophos;i="5.81,167,1610438400"; 
   d="scan'208";a="182086721"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2021 22:22:32 -0800
IronPort-SDR: TNyf62LmvAf7sbaHgJW7LIsoqbTIp/+X8VsK16OhK/J0iZd9plVx3ZJef4kCFv7cKh46HgDVDb
 TS+P450yT4ag==
X-IronPort-AV: E=Sophos;i="5.81,167,1610438400"; 
   d="scan'208";a="587246132"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2021 22:22:32 -0800
From:   ira.weiny@intel.com
To:     Andrew Morton <akpm@linux-foundation.org>,
        David Sterba <dsterba@suse.cz>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Christoph Hellwig <hch@infradead.org>, clm@fb.com,
        josef@toxicpanda.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH V2 2/8] mm/highmem: Convert memcpy_[to|from]_page() to kmap_local_page()
Date:   Tue,  9 Feb 2021 22:22:15 -0800
Message-Id: <20210210062221.3023586-3-ira.weiny@intel.com>
X-Mailer: git-send-email 2.28.0.rc0.12.gb6a658bd00c9
In-Reply-To: <20210210062221.3023586-1-ira.weiny@intel.com>
References: <20210210062221.3023586-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

kmap_local_page() is more efficient and is well suited for these calls.
Convert the kmap() to kmap_local_page()

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
New for V2
---
 include/linux/highmem.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/highmem.h b/include/linux/highmem.h
index 736b6a9f144d..c17a175fe5fe 100644
--- a/include/linux/highmem.h
+++ b/include/linux/highmem.h
@@ -279,19 +279,19 @@ static inline void copy_highpage(struct page *to, struct page *from)
 static inline void memcpy_from_page(char *to, struct page *page,
 				    size_t offset, size_t len)
 {
-	char *from = kmap_atomic(page);
+	char *from = kmap_local_page(page);
 
 	memcpy(to, from + offset, len);
-	kunmap_atomic(from);
+	kunmap_local(from);
 }
 
 static inline void memcpy_to_page(struct page *page, size_t offset,
 				  const char *from, size_t len)
 {
-	char *to = kmap_atomic(page);
+	char *to = kmap_local_page(page);
 
 	memcpy(to + offset, from, len);
-	kunmap_atomic(to);
+	kunmap_local(to);
 }
 
 #endif /* _LINUX_HIGHMEM_H */
-- 
2.28.0.rc0.12.gb6a658bd00c9

