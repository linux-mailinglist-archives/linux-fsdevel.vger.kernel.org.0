Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0601315F62
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Feb 2021 07:24:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231706AbhBJGXw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Feb 2021 01:23:52 -0500
Received: from mga03.intel.com ([134.134.136.65]:39560 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231699AbhBJGXo (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Feb 2021 01:23:44 -0500
IronPort-SDR: MsNmq3R7GbEbsNnJ79vzWo5zCcLmB7C6tY74o9FJKZnaU9IeDOZp3aG7LnVUrdvIo0n+MzAhwB
 2d59bF4ljqWA==
X-IronPort-AV: E=McAfee;i="6000,8403,9890"; a="182086729"
X-IronPort-AV: E=Sophos;i="5.81,167,1610438400"; 
   d="scan'208";a="182086729"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2021 22:22:35 -0800
IronPort-SDR: 5eoJKcK/RWash0k66dbBApuI93VJoHtDSlnhJYdJnwZxz4jPR71UJlx7rzcAbbE4SooyefGlDS
 Y3K0W5ES2NwQ==
X-IronPort-AV: E=Sophos;i="5.81,167,1610438400"; 
   d="scan'208";a="587246161"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2021 22:22:35 -0800
From:   ira.weiny@intel.com
To:     Andrew Morton <akpm@linux-foundation.org>,
        David Sterba <dsterba@suse.cz>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Christoph Hellwig <hch@infradead.org>, clm@fb.com,
        josef@toxicpanda.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH V2 5/8] iov_iter: Remove memzero_page() in favor of zero_user()
Date:   Tue,  9 Feb 2021 22:22:18 -0800
Message-Id: <20210210062221.3023586-6-ira.weiny@intel.com>
X-Mailer: git-send-email 2.28.0.rc0.12.gb6a658bd00c9
In-Reply-To: <20210210062221.3023586-1-ira.weiny@intel.com>
References: <20210210062221.3023586-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

zero_user() is already defined with the same interface and contains the
same code pattern as memzero_page().  Remove memzero_page() and use the
already defined common function zero_user()

To: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
New for V2
---
 lib/iov_iter.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 9889e9903cdf..aa0d03b33a1e 100644
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
@@ -466,13 +467,6 @@ void iov_iter_init(struct iov_iter *i, unsigned int direction,
 }
 EXPORT_SYMBOL(iov_iter_init);
 
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
@@ -950,7 +944,7 @@ static size_t pipe_zero(size_t bytes, struct iov_iter *i)
 
 	do {
 		size_t chunk = min_t(size_t, n, PAGE_SIZE - off);
-		memzero_page(pipe->bufs[i_head & p_mask].page, off, chunk);
+		zero_user(pipe->bufs[i_head & p_mask].page, off, chunk);
 		i->head = i_head;
 		i->iov_offset = off + chunk;
 		n -= chunk;
@@ -967,7 +961,7 @@ size_t iov_iter_zero(size_t bytes, struct iov_iter *i)
 		return pipe_zero(bytes, i);
 	iterate_and_advance(i, bytes, v,
 		clear_user(v.iov_base, v.iov_len),
-		memzero_page(v.bv_page, v.bv_offset, v.bv_len),
+		zero_user(v.bv_page, v.bv_offset, v.bv_len),
 		memset(v.iov_base, 0, v.iov_len)
 	)
 
-- 
2.28.0.rc0.12.gb6a658bd00c9

