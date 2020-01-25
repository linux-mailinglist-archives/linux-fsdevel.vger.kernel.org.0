Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D01F91492B3
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Jan 2020 02:37:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387405AbgAYBf4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Jan 2020 20:35:56 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:36702 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729195AbgAYBfz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Jan 2020 20:35:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=LKEoyUCzBuRkKfb9R2uO7LHx4Md5GqeUkIse+rddq2w=; b=pMkH+xX7Mh/vUpdwz79LTeziBB
        3XC3tlxILQETgjOioy3xvNGrkOukMURtUFt1NoWkvIC92bZYlpLVClbHUGN1Y3bqZJJ6cYtHKYcLY
        OeLSkurSnm6BizUAhjsDEO/UXyxI4CJj/WIqJwXDxQKJNuYRE0k2TJyDX/2mYouDTaK27C3JSt5xS
        rHooHWymtZLR3/WK3JZwFwDl6a/Sb8Zw8Scqb9jiV9muNkea9UQMvL+x9dSi77OU9DNLJbMH7tHDi
        Od5KLLqPPcdzhoysQxx/QJmzD7oeIJaEwuEf2aqZLqEDz5AvtO+0swYWAwp+CmVgbyd6nIZ0hulRy
        mszhOpkQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ivAMd-0006VH-84; Sat, 25 Jan 2020 01:35:55 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 02/12] readahead: Ignore return value of ->readpages
Date:   Fri, 24 Jan 2020 17:35:43 -0800
Message-Id: <20200125013553.24899-3-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200125013553.24899-1-willy@infradead.org>
References: <20200125013553.24899-1-willy@infradead.org>
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
2.24.1

