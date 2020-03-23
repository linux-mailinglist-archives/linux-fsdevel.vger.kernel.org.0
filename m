Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E57618FF3B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Mar 2020 21:25:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727351AbgCWUYo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Mar 2020 16:24:44 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36972 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727325AbgCWUXI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Mar 2020 16:23:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=tVTCrH8cQ/F5ivWRNhrAQ0ihqzkrHbjiqbn9CKzaols=; b=rIfwwr2ujm4sHIILzMYdQAjIcw
        zXDYj70t8jps/X53ROSqAtikL1S7ctNZa1wzvP0pNsyVCnIe9phSTbJFmQHhrQ0hzhLDxAONlzLKD
        z8lF0JNa0u3Lo7XosbztKUbmMGrobcaDzDKiSlTSdEbvLOQV3GmWQ7CaAzOjwbHlHNvak/CPLSTZC
        lZLFPceOpZ9quoPILXhxizPG7bPSDG0yLlTn0iyRM48HHjVe640I3OiyW9yhut+JotmvlIQk/wUNf
        LwHJ4/BExIV09zzbhXJ+F411WRU5klsKST/cPY6DlxUz+9Vdi4A6vCzcaC8FuXeW8GX05TSfuyLm1
        f/opqMkw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jGTbB-0003Uh-GN; Mon, 23 Mar 2020 20:23:01 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        ocfs2-devel@oss.oracle.com, linux-xfs@vger.kernel.org,
        Zi Yan <ziy@nvidia.com>, John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        William Kucharski <william.kucharski@oracle.com>
Subject: [PATCH v10 04/25] mm: Move readahead nr_pages check into read_pages
Date:   Mon, 23 Mar 2020 13:22:38 -0700
Message-Id: <20200323202259.13363-5-willy@infradead.org>
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

Simplify the callers by moving the check for nr_pages and the BUG_ON
into read_pages().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: William Kucharski <william.kucharski@oracle.com>
---
 mm/readahead.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/mm/readahead.c b/mm/readahead.c
index 61b15b6b9e72..9fcd4e32b62d 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -119,6 +119,9 @@ static void read_pages(struct address_space *mapping, struct file *filp,
 	struct blk_plug plug;
 	unsigned page_idx;
 
+	if (!nr_pages)
+		return;
+
 	blk_start_plug(&plug);
 
 	if (mapping->a_ops->readpages) {
@@ -138,6 +141,8 @@ static void read_pages(struct address_space *mapping, struct file *filp,
 
 out:
 	blk_finish_plug(&plug);
+
+	BUG_ON(!list_empty(pages));
 }
 
 /*
@@ -180,8 +185,7 @@ void __do_page_cache_readahead(struct address_space *mapping,
 			 * contiguous pages before continuing with the next
 			 * batch.
 			 */
-			if (nr_pages)
-				read_pages(mapping, filp, &page_pool, nr_pages,
+			read_pages(mapping, filp, &page_pool, nr_pages,
 						gfp_mask);
 			nr_pages = 0;
 			continue;
@@ -202,9 +206,7 @@ void __do_page_cache_readahead(struct address_space *mapping,
 	 * uptodate then the caller will launch readpage again, and
 	 * will then handle the error.
 	 */
-	if (nr_pages)
-		read_pages(mapping, filp, &page_pool, nr_pages, gfp_mask);
-	BUG_ON(!list_empty(&page_pool));
+	read_pages(mapping, filp, &page_pool, nr_pages, gfp_mask);
 }
 
 /*
-- 
2.25.1

