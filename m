Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6519C1D4EEB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 May 2020 15:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbgEONSQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 May 2020 09:18:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726292AbgEONRD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 May 2020 09:17:03 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EE0CC05BD0D;
        Fri, 15 May 2020 06:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=9r9vORbOytoazW3UXAiDTCw79E+Sm2pnv9qrsCelaEs=; b=ET9GLrmZusiuGd8+w8wbCKtksq
        dHQouvGiIMBcgTOT5pbeue0pK+qjSdB4XU53P5KZf+KkVyWWMLGd/5A7XSv+hk8gMvOSOzRbA/CBS
        zpROQ0FzI6PUN9sdNnMI64kAIza+LuDxMTcwDacw5xYVpT1GmY6vfRWQIljHVlR726StSb3Bq3E1E
        ABUqKezeRQBX1+lpFso9xn4dngqpoIJNBOS4xFWiojxiVRA/ui30BwtXQBry49aSljgMHIU7sNmqE
        5DWE0n/jlkooNQ9JbFG5QRNiXeQFyKJM+YNLO84ZMqhdtACVIY/aaGrFsm8CstM34BdFES1qrnpt5
        p/9GiqWg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jZaD0-0005kH-8J; Fri, 15 May 2020 13:17:02 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 26/36] mm: Avoid splitting large pages
Date:   Fri, 15 May 2020 06:16:46 -0700
Message-Id: <20200515131656.12890-27-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200515131656.12890-1-willy@infradead.org>
References: <20200515131656.12890-1-willy@infradead.org>
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

