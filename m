Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 304FD1F5C98
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jun 2020 22:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbgFJUOk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Jun 2020 16:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730606AbgFJUNy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Jun 2020 16:13:54 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76226C03E96F;
        Wed, 10 Jun 2020 13:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=DV4ftIEdQNHLrdsOYQ9aZc9MP7MJ7x8fQ7A37yrCky8=; b=dE4XknevV4TlrEoLcQIxjzKRp+
        BibugNzNqwmBXjnp0W2fFr9fGISsZu07NDmp0kSLEqS83i+m2dUsKWpQw/pFlTb1pxMyCr4uVuIZJ
        GCk49SOlcF2PJhRvYT6T+KR9MifKirfYnoFeDLeSfElIwmWAxGwzNiqBo9c2O1+oSllVoaVE7wnRs
        0uYwfG/lPWO+08wl3MxXZLN0FVYDZUoHAiSw8qY2f/gx9f6r1qTbzXncCQ2Txxjugr8/e3cNjRoRx
        EKJBRl6912H2mNkP5vOjk6SYY4VqoVShGASvdRKYvS7NJEOu6V885vJx11f5spixepoqqPfv3Frp3
        03+2HSxg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jj76Z-0003T0-At; Wed, 10 Jun 2020 20:13:47 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 03/51] mm: Print hashed address of struct page
Date:   Wed, 10 Jun 2020 13:12:57 -0700
Message-Id: <20200610201345.13273-4-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200610201345.13273-1-willy@infradead.org>
References: <20200610201345.13273-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

The actual address of the struct page isn't particularly helpful,
while the hashed address helps match with other messages elsewhere.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/debug.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/mm/debug.c b/mm/debug.c
index e30e35b41d0e..b17909c16a77 100644
--- a/mm/debug.c
+++ b/mm/debug.c
@@ -86,23 +86,23 @@ void __dump_page(struct page *page, const char *reason)
 
 	if (compound)
 		if (hpage_pincount_available(page)) {
-			pr_warn("page:%px refcount:%d mapcount:%d mapping:%p "
-				"index:%#lx head:%px order:%u "
+			pr_warn("page:%p refcount:%d mapcount:%d mapping:%p "
+				"index:%#lx head:%p order:%u "
 				"compound_mapcount:%d compound_pincount:%d\n",
 				page, page_ref_count(head), mapcount,
 				mapping, page_to_pgoff(page), head,
 				compound_order(head), compound_mapcount(page),
 				compound_pincount(page));
 		} else {
-			pr_warn("page:%px refcount:%d mapcount:%d mapping:%p "
-				"index:%#lx head:%px order:%u "
+			pr_warn("page:%p refcount:%d mapcount:%d mapping:%p "
+				"index:%#lx head:%p order:%u "
 				"compound_mapcount:%d\n",
 				page, page_ref_count(head), mapcount,
 				mapping, page_to_pgoff(page), head,
 				compound_order(head), compound_mapcount(page));
 		}
 	else
-		pr_warn("page:%px refcount:%d mapcount:%d mapping:%p index:%#lx\n",
+		pr_warn("page:%p refcount:%d mapcount:%d mapping:%p index:%#lx\n",
 			page, page_ref_count(page), mapcount,
 			mapping, page_to_pgoff(page));
 	if (PageKsm(page))
-- 
2.26.2

