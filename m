Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F40F18FF1F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Mar 2020 21:25:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727606AbgCWUYE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Mar 2020 16:24:04 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37046 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727364AbgCWUXK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Mar 2020 16:23:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=kZSWYbADCDtb2xc4p+R2B9mS5JBLfDUqpyTeSWepChg=; b=QyArVQNnAYA4CrP+it2v+xSMhc
        pe5MDSzjIGjT1P9OojwQPxZfJcZw3B82Y4DeEq2Bd5qqFb7Wpkp+Hrmol/if6vSmpcDa2WMbTzYal
        /E0lQpkjgKvAnS/qLTm+aPiuF7rAF0cwrSDTfsV9gXC5cc09Km9epDgFO96JVR2XfkvO88VwbgkYh
        mP+yKgky0ETpSuG4mUY9I3XAvhUPmGGPsSP9/xUcercB9beUFB5dpu5xjt7/4CxigB/ylf+5PKDUY
        QTdSpjm5DTNw+MStErILyNkTo6S8Oj+0raSuj1TwLctQZL1XWU5hmdYr4FK8oA+C7mgjQiJAoZnNr
        iBT6aGsQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jGTbB-0003Ud-FL; Mon, 23 Mar 2020 20:23:01 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        ocfs2-devel@oss.oracle.com, linux-xfs@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Dave Chinner <dchinner@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        William Kucharski <william.kucharski@oracle.com>
Subject: [PATCH v10 03/25] mm: Ignore return value of ->readpages
Date:   Mon, 23 Mar 2020 13:22:37 -0700
Message-Id: <20200323202259.13363-4-willy@infradead.org>
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

We used to assign the return value to a variable, which we then ignored.
Remove the pretence of caring.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Dave Chinner <dchinner@redhat.com>
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: William Kucharski <william.kucharski@oracle.com>
---
 mm/readahead.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/mm/readahead.c b/mm/readahead.c
index 41a592886da7..61b15b6b9e72 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -113,17 +113,16 @@ int read_cache_pages(struct address_space *mapping, struct list_head *pages,
 
 EXPORT_SYMBOL(read_cache_pages);
 
-static int read_pages(struct address_space *mapping, struct file *filp,
+static void read_pages(struct address_space *mapping, struct file *filp,
 		struct list_head *pages, unsigned int nr_pages, gfp_t gfp)
 {
 	struct blk_plug plug;
 	unsigned page_idx;
-	int ret;
 
 	blk_start_plug(&plug);
 
 	if (mapping->a_ops->readpages) {
-		ret = mapping->a_ops->readpages(filp, mapping, pages, nr_pages);
+		mapping->a_ops->readpages(filp, mapping, pages, nr_pages);
 		/* Clean up the remaining pages */
 		put_pages_list(pages);
 		goto out;
@@ -136,12 +135,9 @@ static int read_pages(struct address_space *mapping, struct file *filp,
 			mapping->a_ops->readpage(filp, page);
 		put_page(page);
 	}
-	ret = 0;
 
 out:
 	blk_finish_plug(&plug);
-
-	return ret;
 }
 
 /*
-- 
2.25.1

