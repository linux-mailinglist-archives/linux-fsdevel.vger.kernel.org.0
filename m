Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34D561650DF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2020 22:02:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728177AbgBSVB4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Feb 2020 16:01:56 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:35990 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727592AbgBSVBI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Feb 2020 16:01:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=ti/VQbcGx7iB5ZkDtMNebTtjtNZ81oeKJGpMdUNZLV0=; b=uH+Yj68Zq00b1el9IhXvtJg/ER
        JKcDD2sr89kzrbW/CetZp6Fyud1tXA80CjzlzuHIreMpTZdCzt66YpvfxzztwR+HxT6XAzvXxI/iu
        b4YFRc6hamcIFMjpT0TuqEPN+qLrwntKHxJK8PDELA+OzYON8fSCz/Y20rnFMWe49OrohOnwn9yHz
        CGOoG1Lq3O5ypaCkNP2WJtcS91SQhIpHvbhIWNgGw2uR8VbM/wEI+AO28/uJA3ZoEJKzV7jnvLSkG
        3NbrGg91hnS2b8QyqPxskApWNYq11NuSW2lm22pIud33IrSYx0BQAbPqykBUdwrgp/K0HLfPETgOS
        ORq69oYQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j4WSu-0008TS-SZ; Wed, 19 Feb 2020 21:01:04 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-erofs@lists.ozlabs.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        cluster-devel@redhat.com, ocfs2-devel@oss.oracle.com,
        linux-xfs@vger.kernel.org
Subject: [PATCH v7 04/24] mm: Move readahead nr_pages check into read_pages
Date:   Wed, 19 Feb 2020 13:00:43 -0800
Message-Id: <20200219210103.32400-5-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200219210103.32400-1-willy@infradead.org>
References: <20200219210103.32400-1-willy@infradead.org>
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
2.25.0

