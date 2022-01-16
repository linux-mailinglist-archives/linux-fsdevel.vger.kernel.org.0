Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F39E48FCA7
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Jan 2022 13:19:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235188AbiAPMSm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 16 Jan 2022 07:18:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235112AbiAPMSe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 16 Jan 2022 07:18:34 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15F63C061574;
        Sun, 16 Jan 2022 04:18:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=DgDHeNwPS9XAK0JO3fVKJQ4TsoEJSTs7hmi2i7kzloU=; b=UsA9wMhthgEmyRAyyN0eOL4wHq
        BBnwv4WAChPolc/5fswDbTKaaDo66RdkzsTTI77OvtwhbWCU2bmvauPXmje3o0PKno99CGclqqmvw
        KrgLAxFpOgGk7Q7DncaNjS1uO5K5txNCvb+3rat+Ow9xSrtr9eKD/pSjxnVK9tYZe+siGUYINgB/I
        R6I1L1xj+LXUt+zzQsmJ3UaQp378toif1wubVCuxlr96YYkkbpHXNKOSGF6WiTT0bEB1OaAfIQaaY
        PGN3ikv1L1z9YjI6e6SGtsJcuWNy7IsQvfa43s8q9Z/3VQ+0y6YOmEDGip1WKpxhfIynTzLXqiVJ/
        5IIEHkHQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n94UM-007FUH-D6; Sun, 16 Jan 2022 12:18:26 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 04/12] mm/vmscan: Free non-shmem folios without splitting them
Date:   Sun, 16 Jan 2022 12:18:14 +0000
Message-Id: <20220116121822.1727633-5-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220116121822.1727633-1-willy@infradead.org>
References: <20220116121822.1727633-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We have to allocate memory in order to split a file-backed folio, so
it's not a good idea to split them in the memory freeing path.  It also
doesn't work for XFS because pages have an extra reference count from
page_has_private() and split_huge_page() expects that reference to have
already been removed.  Unfortunately, we still have to split shmem THPs
because we can't handle swapping out an entire THP yet.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/vmscan.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 700434db5735..45665874082d 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1728,8 +1728,8 @@ static unsigned int shrink_page_list(struct list_head *page_list,
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
2.34.1

