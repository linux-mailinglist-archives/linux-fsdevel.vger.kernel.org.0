Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDDBE29F558
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Oct 2020 20:34:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726458AbgJ2TeP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Oct 2020 15:34:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726237AbgJ2TeM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Oct 2020 15:34:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B32D7C0613CF
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2020 12:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=lGF4HW3xTcYw5c4m1uJQR09qdQYmGLF0sDqvoEBnKwc=; b=Iw/i9Ycuo/RjVb7jovRKBRt3Eu
        g5R4Efdp+GOX3ielnOCclp45qFbW3YsCuCrbikcdZBo3L6W9xy2O7WMI2m6xI1yrLNj3WXyUTXt1v
        hfz6I58c39cVYrMCL9WNP3yvrbX4IwNUMlU2y5XltGV8eOr/9msH86oD/qNhhDh29Tt5mNLnKYccE
        tFViHnnDwYtNpmrJalI3BpozUl1m7VgOp29aNTh575wdE9KC2TCaP5rdiMZEsPFpC+iId6uw2YQp4
        fQOiqw35i7gmozKL7dSg3jwil7aQKBY1HzIloSTksrEjwQWlIQ+a9FJFt21eiyaIMpiyXVOXl5ih/
        gGNDLNWw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kYDgY-0007c6-3K; Thu, 29 Oct 2020 19:34:10 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 10/19] mm/vmscan: Optimise shrink_page_list for smaller THPs
Date:   Thu, 29 Oct 2020 19:33:56 +0000
Message-Id: <20201029193405.29125-11-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201029193405.29125-1-willy@infradead.org>
References: <20201029193405.29125-1-willy@infradead.org>
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
index 1c2e6ca92a45..9e140d19611a 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1300,7 +1300,8 @@ static unsigned int shrink_page_list(struct list_head *page_list,
 			enum ttu_flags flags = ttu_flags | TTU_BATCH_FLUSH;
 			bool was_swapbacked = PageSwapBacked(page);
 
-			if (unlikely(PageTransHuge(page)))
+			if (PageTransHuge(page) &&
+					thp_order(page) >= HPAGE_PMD_ORDER)
 				flags |= TTU_SPLIT_HUGE_PMD;
 
 			if (!try_to_unmap(page, flags)) {
-- 
2.28.0

