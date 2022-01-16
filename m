Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EFA148FC99
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Jan 2022 13:19:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235080AbiAPMS3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 16 Jan 2022 07:18:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235062AbiAPMS2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 16 Jan 2022 07:18:28 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A860C06161C;
        Sun, 16 Jan 2022 04:18:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=nR4q6LlG4aGXJETtHyIwh712yfW3kU3d8of6ibolorw=; b=skxRut/WqIDWQi1x1bJxL7nfWV
        4K6mG+tEfRQsHFAfjGW3fuPyDROkCHtjOfjP4uuuWO4XM5+QfRhizrFk7InpT7Sq27J+/yyk/52JX
        rR4Mqoh+iZpSzGel6T8UsGvic5F3Sp++fCGdjNDNFzpRmFoMx1f2lj53jsemOtjwcd7uzu5Po7hzH
        XyvIQRYQ2Zwjv6nULypWTl1m76xP3NtfqvalshW/TgMo3/RNflTq9jpSSe4hbC6H/txt9eS7p1MIJ
        vBr+m2tJcEwrwAfp46jfM+1jhLjyTag5Qj3xFH5Et8Mt53MXAj1ZwMi11KEtbNtZOInD+UAfrWOF6
        6kkhnMkg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n94UM-007FUL-Hj; Sun, 16 Jan 2022 12:18:26 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 06/12] mm/vmscan: Optimise shrink_page_list for non-PMD-sized folios
Date:   Sun, 16 Jan 2022 12:18:16 +0000
Message-Id: <20220116121822.1727633-7-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220116121822.1727633-1-willy@infradead.org>
References: <20220116121822.1727633-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

A large folio which is smaller than a PMD does not need to do the extra
work in try_to_unmap() of trying to split a PMD entry.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/vmscan.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 45665874082d..3181bf2f8a37 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1754,7 +1754,8 @@ static unsigned int shrink_page_list(struct list_head *page_list,
 			enum ttu_flags flags = TTU_BATCH_FLUSH;
 			bool was_swapbacked = PageSwapBacked(page);
 
-			if (unlikely(PageTransHuge(page)))
+			if (PageTransHuge(page) &&
+					thp_order(page) >= HPAGE_PMD_ORDER)
 				flags |= TTU_SPLIT_HUGE_PMD;
 
 			try_to_unmap(page, flags);
-- 
2.34.1

