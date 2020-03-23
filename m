Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6510818FF2A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Mar 2020 21:25:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727680AbgCWUYY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Mar 2020 16:24:24 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36976 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727328AbgCWUXI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Mar 2020 16:23:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Lc2x7VErpz8frUilxWdYkzAv1z74llWH8NCvh1AsjI4=; b=OCqwAs8gWk8moYj+LDYAgnWNAH
        t5/NKYmt3+SR3/wx+zFgX2g93PKItZMY4t+ZlktHqiRKCUaT+0BQ+OD5m8+q0b21PtJVr6eRIcase
        coap6FvntuTtV2v2TUrj+ZzK3VLwWTieamolenBguach8qjCeGe6JJ4ZN4k/4eyxCK+yq35DsQ8+X
        /opsa7hT3ETSTKyeTfaQpFE7wMZae+k8lJ4Z2f2Mf0z0UZCytJdmMCg2+CbA+d2OlWVRTbY7R5/mC
        FxdkpQDVVPxzy5prWby2DTFxQqCNKCJ/sQno0fKowRcPoPK6OluFusTBONzTctJ+ovOw2AUyMN4kz
        YQpvLD9A==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jGTbB-0003VP-SE; Mon, 23 Mar 2020 20:23:01 +0000
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
Subject: [PATCH v10 15/25] mm: Use memalloc_nofs_save in readahead path
Date:   Mon, 23 Mar 2020 13:22:49 -0700
Message-Id: <20200323202259.13363-16-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200323202259.13363-1-willy@infradead.org>
References: <20200323202259.13363-1-willy@infradead.org>
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

