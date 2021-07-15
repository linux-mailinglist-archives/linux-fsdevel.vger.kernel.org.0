Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E2773C9866
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jul 2021 07:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239202AbhGOFa5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 01:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238186AbhGOFa4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 01:30:56 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97BF3C06175F;
        Wed, 14 Jul 2021 22:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=5ILLJtmg4y7//Nl5cqO6Dt5oKOASFCS0mS2xCX9QyaA=; b=rssLRkif3t/tSVMHXk5c7aqrPF
        tmQzfdg5A7AVrJdCKgh6hqc3VrLK5+CXT/LRghngVX1rUsJvmB3sCMEXBrczqRSQ3UVQ/oboWCUlW
        O+v3hWasBVRHwszi7py/QLZ2F642acp6xDEL/WOiZvf/MrYaB26iPSdfSx1jkbGmez1q/v+reqoW1
        +n00MTXt0Wfeodco8WSHQ+ijBd94fFdDGSX7O/gxAcauUcyJS6SZrILn+4i1HsDQAzJsQKkz6JhXe
        LmvIMAK8Mmb5sluf4xgp/VdtsNZ0/v4pGyYqPw9Vp0k8XmfB7srRXdrDdf2exrmol83pWZ2j87k/y
        YQ0Il39g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m3ttl-0031BC-3m; Thu, 15 Jul 2021 05:27:10 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v14 136/138] mm/vmscan: Optimise shrink_page_list for smaller THPs
Date:   Thu, 15 Jul 2021 04:37:02 +0100
Message-Id: <20210715033704.692967-137-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210715033704.692967-1-willy@infradead.org>
References: <20210715033704.692967-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

A THP which is smaller than a PMD does not need to do the extra work
in try_to_unmap() of trying to split a PMD entry.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/vmscan.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 8b17e46dbf32..433956675107 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1496,7 +1496,8 @@ static unsigned int shrink_page_list(struct list_head *page_list,
 			enum ttu_flags flags = TTU_BATCH_FLUSH;
 			bool was_swapbacked = PageSwapBacked(page);
 
-			if (unlikely(PageTransHuge(page)))
+			if (PageTransHuge(page) &&
+					thp_order(page) >= HPAGE_PMD_ORDER)
 				flags |= TTU_SPLIT_HUGE_PMD;
 
 			try_to_unmap(page, flags);
-- 
2.30.2

