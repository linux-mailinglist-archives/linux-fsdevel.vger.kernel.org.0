Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CADA615878E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2020 02:05:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727901AbgBKBDz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Feb 2020 20:03:55 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:54736 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727695AbgBKBDy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Feb 2020 20:03:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=MOOCl0kElclaL12Bo2vdDIW4gCL68Y7X1xBVMIbuM80=; b=Isw5m/tToyqF5hw2BHaQc66txg
        PLpadc/3h5L6eAeruvyIBlnGL1PP7HBjXzQGHBrgDRT079Q3r/xXZRoyDxjg9eYDqeL9RoWbECgEm
        IViGYNLoYxC8uf/tZ96aGfepdrMqdPmTsRd0IMjX/2KZemd3naXkvF6oAY3AtJ8V4hqLrYX9oKGei
        WdFEds4K+gW630ResAlErqadDoitOedK0m1LuInhQW/SaVHIon6X3nGWBFlKNaEWcziZjkDcH9c4A
        MYXX/W4UN0+2jmsJlL97B3nSSMEXmyOgLqdqFqdm+QN3vnSEn0/Zyg8JczgtVc92uJp3BUxRQVhaa
        4qj969Yw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j1Jxu-0001nl-BQ; Tue, 11 Feb 2020 01:03:50 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-erofs@lists.ozlabs.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        cluster-devel@redhat.com, ocfs2-devel@oss.oracle.com,
        linux-xfs@vger.kernel.org
Subject: [PATCH v5 02/13] mm: Ignore return value of ->readpages
Date:   Mon, 10 Feb 2020 17:03:37 -0800
Message-Id: <20200211010348.6872-3-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200211010348.6872-1-willy@infradead.org>
References: <20200211010348.6872-1-willy@infradead.org>
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
---
 mm/readahead.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/mm/readahead.c b/mm/readahead.c
index 6bf73ef33b7e..fc77d13af556 100644
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
2.25.0

