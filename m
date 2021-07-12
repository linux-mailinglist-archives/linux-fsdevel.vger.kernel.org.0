Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E6B33C42D6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jul 2021 06:20:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231801AbhGLEWr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jul 2021 00:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233073AbhGLEWo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jul 2021 00:22:44 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA280C0613E8;
        Sun, 11 Jul 2021 21:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=5ILLJtmg4y7//Nl5cqO6Dt5oKOASFCS0mS2xCX9QyaA=; b=H0jet65lIWAMnR1NyCS5Y4GXIv
        fBvcRNCCZlWWs5+Tn+2iTULAhGIRs9kLk3CkjltQTRHtVNgXqnuGHYoBl1zrA0AQo+Obzzw8SRh/u
        uz2vMsN+oZ/+plX61E0O2J6Y09Z3On6c5gIJQR+TkPvsyGKmJyOcdRH3ygr2FiUmjs8eLhUyfNZX1
        ros/9A+6i90U8egZKoSkRQl55mIpdID64duhWLrkm5V/ugJ8IBXlHX6F1f588p7x1YxBFwnqy6gwZ
        57T4o5kSAG8cgz1tZZI2gXpWURNRNaU0YpE57oBeZRt5xAIm4iWzGM5rG08GKK7BfI2Ud0o45uE+M
        2u3ToKcQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m2nOV-00GroF-Jn; Mon, 12 Jul 2021 04:18:19 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v13 135/137] mm/vmscan: Optimise shrink_page_list for smaller THPs
Date:   Mon, 12 Jul 2021 04:06:59 +0100
Message-Id: <20210712030701.4000097-136-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210712030701.4000097-1-willy@infradead.org>
References: <20210712030701.4000097-1-willy@infradead.org>
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

