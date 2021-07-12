Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A60C3C42CA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jul 2021 06:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbhGLEUz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jul 2021 00:20:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232755AbhGLEUv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jul 2021 00:20:51 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 420BCC0613E9;
        Sun, 11 Jul 2021 21:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=FvnKvrUT2fNk7/OyTjb1Ax4qDl3oGlD3/8sIT3O/4a8=; b=fqZKTW6TtdDvbDhqH27ow4lpWv
        ITL2ujZDrU6THFtBDkEa/65oFbDX+klfUR3YNABj94//fPUtK4/y8J76LdAe3RHEaAwVKNZKb1rYa
        GSre3ApdeyYv8XxW1k2uMs8Ir7vR1mKagHI6C6s+iLEqQcHR5eV+6ofmV13S1jSMK2JJVYo5x0fe/
        lMFLBpSIEH8iverjHjHiyDYH8Iyv/jl/RV9o8enYqkzvVtoHuy65nIj7KSB5/SJHQlsBZY8bRw1I1
        HFN7+2CR1LPQN/Gz68QN/CsQ7jxX66B5JM8o2YLKu/jVHjVAfKEMTE2Lg8tNNWzM8wPGb+AchC4dm
        WV4rimCA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m2nMu-00Greh-BD; Mon, 12 Jul 2021 04:16:40 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v13 131/137] mm/vmscan: Free non-shmem THPs without splitting them
Date:   Mon, 12 Jul 2021 04:06:55 +0100
Message-Id: <20210712030701.4000097-132-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210712030701.4000097-1-willy@infradead.org>
References: <20210712030701.4000097-1-willy@infradead.org>
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

