Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D70A41A8100
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Apr 2020 17:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406473AbgDNPD1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Apr 2020 11:03:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405690AbgDNPCs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Apr 2020 11:02:48 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0634AC025480;
        Tue, 14 Apr 2020 08:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Lc2x7VErpz8frUilxWdYkzAv1z74llWH8NCvh1AsjI4=; b=teq48N4dMHtg9u2jF36VIIhQ+3
        yBvTTjFBO/xdSUuz7m2VObRylAzloyThn42zRtrzirqXsWr6gFYoNZa2VjqwuBtnNwgazTRga3oF4
        ej5rIpSz5nF+XV2q7ook9oD3rb2kDKJyGrFGM23W+aT+SI2NX+pyqTeJEPc6/NXLh2xf2p27zJHL4
        t0oUMKhQUM7wQOVY3A/RNWOr5xcz9n3EKSsCBnFbFetspHBVIazW14oyjZd+WiPj0CgOy1DaGBd4o
        Th71AI/meVr2KHc3hLKa4mgIccyPOjIBGeTiIU5xTfzrpAAJvft0iOG6daYhkpvYjxaE4MyENg8ZW
        egCdyU9g==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jON5A-0006P1-8A; Tue, 14 Apr 2020 15:02:36 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        ocfs2-devel@oss.oracle.com, linux-xfs@vger.kernel.org,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        William Kucharski <william.kucharski@oracle.com>
Subject: [PATCH v11 15/25] mm: Use memalloc_nofs_save in readahead path
Date:   Tue, 14 Apr 2020 08:02:23 -0700
Message-Id: <20200414150233.24495-16-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200414150233.24495-1-willy@infradead.org>
References: <20200414150233.24495-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Ensure that memory allocations in the readahead path do not attempt to
reclaim file-backed pages, which could lead to a deadlock.  It is
possible, though unlikely this is the root cause of a problem observed
by Cong Wang.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reported-by: Cong Wang <xiyou.wangcong@gmail.com>
Suggested-by: Michal Hocko <mhocko@suse.com>
Reviewed-by: William Kucharski <william.kucharski@oracle.com>
---
 mm/readahead.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/mm/readahead.c b/mm/readahead.c
index 73cb59ed5cff..3c9a8dd7c56c 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -22,6 +22,7 @@
 #include <linux/mm_inline.h>
 #include <linux/blk-cgroup.h>
 #include <linux/fadvise.h>
+#include <linux/sched/mm.h>
 
 #include "internal.h"
 
@@ -185,6 +186,18 @@ void page_cache_readahead_unbounded(struct address_space *mapping,
 	};
 	unsigned long i;
 
+	/*
+	 * Partway through the readahead operation, we will have added
+	 * locked pages to the page cache, but will not yet have submitted
+	 * them for I/O.  Adding another page may need to allocate memory,
+	 * which can trigger memory reclaim.  Telling the VM we're in
+	 * the middle of a filesystem operation will cause it to not
+	 * touch file-backed pages, preventing a deadlock.  Most (all?)
+	 * filesystems already specify __GFP_NOFS in their mapping's
+	 * gfp_mask, but let's be explicit here.
+	 */
+	unsigned int nofs = memalloc_nofs_save();
+
 	/*
 	 * Preallocate as many pages as we will need.
 	 */
@@ -229,6 +242,7 @@ void page_cache_readahead_unbounded(struct address_space *mapping,
 	 * will then handle the error.
 	 */
 	read_pages(&rac, &page_pool, false);
+	memalloc_nofs_restore(nofs);
 }
 EXPORT_SYMBOL_GPL(page_cache_readahead_unbounded);
 
-- 
2.25.1

