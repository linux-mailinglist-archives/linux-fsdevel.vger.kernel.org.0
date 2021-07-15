Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E115B3C985A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jul 2021 07:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238924AbhGOF1d (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 01:27:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235312AbhGOF1d (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 01:27:33 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E719C06175F;
        Wed, 14 Jul 2021 22:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=FvnKvrUT2fNk7/OyTjb1Ax4qDl3oGlD3/8sIT3O/4a8=; b=izkbNEHl+SIVNYKgt/mAEKaORv
        dk2/V/5ap64GEm2xYJiEfKnOPQsspNnlH7PnSkAmoTclYx7DfWr+QTftRAD57aysxz3g4CIXPNwMD
        FlBHsG60DSGcqQgh7uZIto4htO0BXbz0hWHBvc3PDd95CLGWRUU+yFiOkQU+1MJZ/FQdB+XptFF2l
        I+kPEEbN7ILEdF9YY16un0Z4+I6/ne7rw94akq7knkqkhL8NZhkmQq2LR6jYCCbWga+Ad1XbTwbFK
        12idSWixEs1ivcfHNq1InSzZfhmmLM8dq93S87Q35QGLebRmLkoy08PLvnrnQUMJR1ZXe8K1gYspL
        k5LgalPQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m3tqK-00310g-Gq; Thu, 15 Jul 2021 05:23:38 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v14 132/138] mm/vmscan: Free non-shmem THPs without splitting them
Date:   Thu, 15 Jul 2021 04:36:58 +0100
Message-Id: <20210715033704.692967-133-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210715033704.692967-1-willy@infradead.org>
References: <20210715033704.692967-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We have to allocate memory in order to split a file-backed page,
so it's not a good idea to split them.  It also doesn't work for XFS
because pages have an extra reference count from page_has_private() and
split_huge_page() expects that reference to have already been removed.
Unfortunately, we still have to split shmem THPs because we can't handle
swapping out an entire THP yet.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/vmscan.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 7a2f25b904d9..8b17e46dbf32 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1470,8 +1470,8 @@ static unsigned int shrink_page_list(struct list_head *page_list,
 				/* Adding to swap updated mapping */
 				mapping = page_mapping(page);
 			}
-		} else if (unlikely(PageTransHuge(page))) {
-			/* Split file THP */
+		} else if (PageSwapBacked(page) && PageTransHuge(page)) {
+			/* Split shmem THP */
 			if (split_huge_page_to_list(page, page_list))
 				goto keep_locked;
 		}
-- 
2.30.2

