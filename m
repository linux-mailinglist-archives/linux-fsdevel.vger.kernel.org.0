Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B64401E7333
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 May 2020 05:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391766AbgE2DAp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 May 2020 23:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407289AbgE2C6i (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 May 2020 22:58:38 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBBC0C008600;
        Thu, 28 May 2020 19:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=9r9vORbOytoazW3UXAiDTCw79E+Sm2pnv9qrsCelaEs=; b=fN69t9ki3F7CoL9P+jkh/n6yaN
        MtA978kQdBvtN05wJgmMMV/ZrxTLf1HJGIkTvvK2G8cxfjMfIn+8EtYRvjIsuT72uI3G7LT9JxGnC
        Fnj2JhU+qSEKTPoBo6k4nXacBFB8eIwpf1KTi62ChfurQtwdRGqSYCl50mvLA4MDUPeqVcsKqI4fK
        KD8cSmjG7BjwD8i49MRSjwPsWRe4Fxj3uKDebTENm2faLh8CgwelRu4H5SR84PcqTNpHV9xVIAhlV
        +5Ia7lV5YdERJufYRpwGdzAy9sPKuoK1AR3GynsSFn27sQXcKgQP8YOYHr8XNa9EA8hExf7HNeWBK
        h49iJvow==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jeVE3-0008Sq-LC; Fri, 29 May 2020 02:58:27 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 28/39] mm: Avoid splitting large pages
Date:   Thu, 28 May 2020 19:58:13 -0700
Message-Id: <20200529025824.32296-29-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200529025824.32296-1-willy@infradead.org>
References: <20200529025824.32296-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

If the filesystem supports large pages, then do not split them before
removing them from the page cache; remove them as a unit.
---
 mm/vmscan.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index b06868fc4926..51e6c135575d 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1271,9 +1271,10 @@ static unsigned long shrink_page_list(struct list_head *page_list,
 				/* Adding to swap updated mapping */
 				mapping = page_mapping(page);
 			}
-		} else if (unlikely(PageTransHuge(page))) {
+		} else if (PageTransHuge(page)) {
 			/* Split file THP */
-			if (split_huge_page_to_list(page, page_list))
+			if (!mapping_large_pages(mapping) &&
+			    split_huge_page_to_list(page, page_list))
 				goto keep_locked;
 		}
 
-- 
2.26.2

