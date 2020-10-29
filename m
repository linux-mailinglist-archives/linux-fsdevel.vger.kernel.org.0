Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA5229F564
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Oct 2020 20:34:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbgJ2Te0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Oct 2020 15:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726184AbgJ2TeN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Oct 2020 15:34:13 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70B91C0613D3
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2020 12:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=JtnSk9FEEgyaxqeuAWYlzwggtFwYiu6sjhMbVnBCTYw=; b=XBvRw9orNd8h9rQjHnBMKhkep1
        /jl88pKbWM5jCvFqJfh85I401AZooE3a/C4ejwpp4qhiotrF8dlXGRxLt50GKm1fDAafH/N692M7U
        58kez5ZDeU2JvNv7Q5BwvMb26oOJX+UaSRBc+beO+4AG1wEuACpXZlprPy8PS1X8iUi5WbqqqCsY9
        m5OmbxHlIeKL7a04gXeGOsiI2S4GGrMdWUZnUX3nxD9BvREQtyJXB3xqjTJqRsKbvQnmQ7xOaIRI2
        UlCkxoWNEzimRE6FXMrbj/lkxAZqf4uQfizyDRzR0KAlzU0JooGofizcENtYR8EiKqqVkDb44/c/a
        bmmlq3Tw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kYDgZ-0007cq-Ok; Thu, 29 Oct 2020 19:34:11 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Cc:     William Kucharski <william.kucharski@oracle.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH 16/19] mm/readahead: Align THP mappings for non-DAX
Date:   Thu, 29 Oct 2020 19:34:02 +0000
Message-Id: <20201029193405.29125-17-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201029193405.29125-1-willy@infradead.org>
References: <20201029193405.29125-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: William Kucharski <william.kucharski@oracle.com>

When we have the opportunity to use transparent huge pages to map a
file, we want to follow the same rules as DAX.

Signed-off-by: William Kucharski <william.kucharski@oracle.com>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/huge_memory.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 580afce93d4a..660fe8c29cd9 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -556,13 +556,10 @@ unsigned long thp_get_unmapped_area(struct file *filp, unsigned long addr,
 	unsigned long ret;
 	loff_t off = (loff_t)pgoff << PAGE_SHIFT;
 
-	if (!IS_DAX(filp->f_mapping->host) || !IS_ENABLED(CONFIG_FS_DAX_PMD))
-		goto out;
-
 	ret = __thp_get_unmapped_area(filp, addr, len, off, flags, PMD_SIZE);
 	if (ret)
 		return ret;
-out:
+
 	return current->mm->get_unmapped_area(filp, addr, len, pgoff, flags);
 }
 EXPORT_SYMBOL_GPL(thp_get_unmapped_area);
-- 
2.28.0

